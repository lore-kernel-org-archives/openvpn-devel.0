From: selva.nair@...277...
Date: Sat, 11 Mar 2023 00:24:03 -0500
Message-Id: <20230311052403.1154030-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Bugfix: Convert ECDSA signature form
 pkcs11-helper to DER encoded form
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

- With OpenSSL 3.0 and xkey-provider, we use pkcs11h_certificate_signAny_ex()
  which returns EC signature as raw r|s concatenated. But OpenSSL expects
  a DER encoded ASN.1 structure.

  Do this conversion as done in cryptoapi.c. For code re-use, ecdsa_bin2sig()
  is consolidated with sig to DER conversion as ecdsa_bin2der() and
  moved to xkey_helper.c

  In the past when we used OpenSSL hooks installed by pkcs11-helper,
  such a conversion was not required as it was internally handled by
  the library.

Reported by: Tom <openvpn@...2719...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c      | 61 +++++-------------------------------
 src/openvpn/pkcs11_openssl.c | 23 ++++++++++++--
 src/openvpn/xkey_common.h    | 15 +++++++++
 src/openvpn/xkey_helper.c    | 45 ++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 56 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 136c6ffc..022f53d4 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -146,40 +146,6 @@ CAPI_DATA_free(CAPI_DATA *cd)
     free(cd);
 }
 
-/**
- * Helper to convert ECDSA signature returned by NCryptSignHash
- * to an ECDSA_SIG structure.
- * On entry 'buf[]' of length len contains r and s concatenated.
- * Returns a newly allocated ECDSA_SIG or NULL (on error).
- */
-static ECDSA_SIG *
-ecdsa_bin2sig(unsigned char *buf, int len)
-{
-    ECDSA_SIG *ecsig = NULL;
-    DWORD rlen = len/2;
-    BIGNUM *r = BN_bin2bn(buf, rlen, NULL);
-    BIGNUM *s = BN_bin2bn(buf+rlen, rlen, NULL);
-    if (!r || !s)
-    {
-        goto err;
-    }
-    ecsig = ECDSA_SIG_new(); /* in openssl 1.1 this does not allocate r, s */
-    if (!ecsig)
-    {
-        goto err;
-    }
-    if (!ECDSA_SIG_set0(ecsig, r, s)) /* ecsig takes ownership of r and s */
-    {
-        ECDSA_SIG_free(ecsig);
-        goto err;
-    }
-    return ecsig;
-err:
-    BN_free(r); /* it is ok to free NULL BN */
-    BN_free(s);
-    return NULL;
-}
-
 /**
  * Parse a hex string with optional embedded spaces into
  * a byte array.
@@ -287,12 +253,11 @@ static int
 xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
                  size_t tbslen)
 {
-    BYTE buf[1024]; /* large enough for EC keys upto 1024 bits */
-    DWORD len = _countof(buf);
+    DWORD len = *siglen;
 
     msg(D_LOW, "Signing using NCryptSignHash with EC key");
 
-    DWORD status = NCryptSignHash(cd->crypt_prov, NULL, (BYTE *)tbs, tbslen, buf, len, &len, 0);
+    DWORD status = NCryptSignHash(cd->crypt_prov, NULL, (BYTE *)tbs, tbslen, sig, len, &len, 0);
 
     if (status != ERROR_SUCCESS)
     {
@@ -301,26 +266,14 @@ xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsign
         return 0;
     }
 
-    /* NCryptSignHash returns r|s -- convert to OpenSSL's ECDSA_SIG */
-    ECDSA_SIG *ecsig = ecdsa_bin2sig(buf, len);
-    if (!ecsig)
+    /* NCryptSignHash returns r|s -- convert to DER encoded buffer expected by OpenSSL */
+    int derlen = ecdsa_bin2der(sig, (int) len, *siglen);
+    if (derlen <= 0)
     {
-        msg(M_NONFATAL, "Error in cryptopicert: Failed to convert ECDSA signature");
         return 0;
     }
-
-    /* convert internal signature structure 's' to DER encoded byte array in sig */
-    if (i2d_ECDSA_SIG(ecsig, NULL) > EVP_PKEY_size(cd->pubkey))
-    {
-        ECDSA_SIG_free(ecsig);
-        msg(M_NONFATAL, "Error in cryptoapicert: DER encoded ECDSA signature is too long");
-        return 0;
-    }
-
-    *siglen = i2d_ECDSA_SIG(ecsig, &sig);
-    ECDSA_SIG_free(ecsig);
-
-    return (*siglen > 0);
+    *siglen = derlen;
+    return 1;
 }
 
 /** Sign hash in tbs using RSA key in cd and NCryptSignHash */
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 5c1de44e..eee86e17 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -168,6 +168,7 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
 
     unsigned char buf[EVP_MAX_MD_SIZE];
     size_t buflen;
+    size_t siglen_max = *siglen;
 
     unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for DigestInfo header */
     size_t enc_len = sizeof(enc);
@@ -234,8 +235,26 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
         ASSERT(0);  /* coding error -- we couldnt have created any such key */
     }
 
-    return CKR_OK == pkcs11h_certificate_signAny_ex(cert, &mech,
-                                                    tbs, tbslen, sig, siglen);
+    if (CKR_OK != pkcs11h_certificate_signAny_ex(cert, &mech,
+                                                 tbs, tbslen, sig, siglen))
+    {
+        return 0;
+    }
+    if (strcmp(sigalg.keytype, "EC"))
+    {
+        return 1;
+    }
+
+    /* For EC keys, pkcs11 returns signature as r|s: convert to der encoded */
+    int derlen = ecdsa_bin2der(sig, (int) *siglen, siglen_max);
+
+    if (derlen <= 0)
+    {
+        return 0;
+    }
+    *siglen = derlen;
+
+    return 1;
 }
 
 /* wrapper for handle free */
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 07b70c08..51cdb5b7 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -33,6 +33,7 @@
 #define HAVE_XKEY_PROVIDER 1
 #include <openssl/provider.h>
 #include <openssl/core_dispatch.h>
+#include <openssl/ecdsa.h>
 
 /**
  * Initialization function for OpenVPN external key provider for OpenSSL
@@ -170,6 +171,20 @@ xkey_max_saltlen(int modBits, int hLen)
 
     return emLen - hLen - 2;
 }
+
+/**
+ * @brief Convert raw ECDSA signature to DER encoded
+ * This function converts ECDSA signature provided as a buffer
+ * containing r|s to DER encoded ASN.1 expected by OpenSSL
+ * @param buf       signature containing r|s.
+ * @param len       size of signature in bytes
+ * @param capacity  max space in the buffer buf in bytes
+ * @returns the size of the converted signature or <= 0 on error.
+ * On success, buf is overwritten by its DER encoding
+ */
+int
+ecdsa_bin2der(unsigned char *buf, int len, size_t capacity);
+
 #endif /* HAVE_XKEY_PROVIDER */
 
 #endif /* ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 052c60c4..ee9677ab 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -401,4 +401,49 @@ done:
     return ret;
 }
 
+/**
+ * Helper to convert ECDSA signature with r and s concatenated
+ * to a DER encoded format used by OpenSSL.
+ * Returns the size of the converted signature or <= 0 on error.
+ * On success, buf is overwritten by the DER encoded signature.
+ */
+int
+ecdsa_bin2der(unsigned char *buf, int len, size_t capacity)
+{
+    ECDSA_SIG *ecsig = NULL;
+    int rlen = len/2;
+    BIGNUM *r = BN_bin2bn(buf, rlen, NULL);
+    BIGNUM *s = BN_bin2bn(buf+rlen, rlen, NULL);
+    if (!r || !s)
+    {
+        goto err;
+    }
+    ecsig = ECDSA_SIG_new(); /* this does not allocate r, s */
+    if (!ecsig)
+    {
+        goto err;
+    }
+    if (!ECDSA_SIG_set0(ecsig, r, s)) /* ecsig takes ownership of r and s */
+    {
+        ECDSA_SIG_free(ecsig);
+        goto err;
+    }
+
+    int derlen = i2d_ECDSA_SIG(ecsig, NULL);
+    if (derlen > (int) capacity)
+    {
+        ECDSA_SIG_free(ecsig);
+        msg(M_NONFATAL, "Error: DER encoded ECDSA signature is too long (%d)\n", derlen);
+        return 0;
+    }
+    derlen = i2d_ECDSA_SIG(ecsig, &buf);
+    ECDSA_SIG_free(ecsig);
+    return derlen;
+
+err:
+    BN_free(r); /* it is ok to free NULL BN */
+    BN_free(s);
+    return 0;
+}
+
 #endif /* HAVE_XKEY_PROVIDER */
-- 
2.34.1


