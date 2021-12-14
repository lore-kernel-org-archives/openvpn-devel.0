From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:24 -0500
Message-Id: <20211214165928.30676-15-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 14/18] pkcs11: Interface the xkey
 provider with pkcs11-helper
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

- Load the 'private key' handle through the provider and set it in
  SSL_CTX
- Add a sign op function to interface provider with pkcs11-helper.
  Previously we used its "OpenSSL Session" which internally sets up
  callbacks in RSA and EC key methods. Not useful for the provider
  interface, so, we directly call the PKCS#11 sign operation
  as done with mbedTLS.
- tls_libctx is made global for accessing from pkcs11_openssl.c

  Supports ECDSA and RSA_PKCS1_PADDING signatures. PSS support
  will be added when pkcs11-helper with our PR for specifying
  CK_MECHANISM variable in sign operations is released.
  (i.e., next release of pkcs11-helper).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/pkcs11_openssl.c | 151 +++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    |   2 +-
 src/openvpn/xkey_common.h    |   2 +
 3 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index b29504b6..9cf46b2c 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -39,12 +39,163 @@
 #include "errlevel.h"
 #include "pkcs11_backend.h"
 #include "ssl_verify.h"
+#include "xkey_common.h"
 #include <pkcs11-helper-1.0/pkcs11h-openssl.h>
 
+#ifdef HAVE_XKEY_PROVIDER
+static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
+
+/**
+ * Sign op called from xkey provider
+ *
+ * We support ECDSA, RSA_NO_PADDING, RSA_PKCS1_PADDING
+ */
+static int
+xkey_pkcs11h_sign(void *handle, unsigned char *sig,
+            size_t *siglen, const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg)
+{
+    pkcs11h_certificate_t cert = handle;
+    CK_MECHANISM mech = {CKM_RSA_PKCS, NULL, 0}; /* default value */
+
+    unsigned char buf[EVP_MAX_MD_SIZE];
+    size_t buflen;
+
+    if (!strcmp(sigalg.op, "DigestSign"))
+    {
+        dmsg(D_LOW, "xkey_pkcs11h_sign: computing digest");
+        if (xkey_digest(tbs, tbslen, buf, &buflen, sigalg.mdname))
+        {
+            tbs = buf;
+            tbslen = (size_t) buflen;
+            sigalg.op = "Sign";
+        }
+        else
+        {
+            return 0;
+        }
+    }
+
+    if (!strcmp(sigalg.keytype, "EC"))
+    {
+        mech.mechanism = CKM_ECDSA;
+    }
+    else if (!strcmp(sigalg.keytype, "RSA"))
+    {
+        if (!strcmp(sigalg.padmode,"none"))
+        {
+            mech.mechanism = CKM_RSA_X_509;
+        }
+        else if (!strcmp(sigalg.padmode, "pss"))
+        {
+            msg(M_NONFATAL, "PKCS#11: Error: PSS padding is not yet supported.");
+            return 0;
+        }
+        else if (!strcmp(sigalg.padmode, "pkcs1"))
+        {
+            /* CMA_RSA_PKCS needs pkcs1 encoded digest */
+
+            unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for DigestInfo header */
+            size_t enc_len = sizeof(enc);
+
+            if (!encode_pkcs1(enc, &enc_len, sigalg.mdname, tbs, tbslen))
+            {
+                return 0;
+            }
+            tbs = enc;
+            tbslen = enc_len;
+        }
+        else /* should not happen */
+        {
+            msg(M_WARN, "PKCS#11: Unknown padmode <%s>", sigalg.padmode);
+        }
+    }
+    else
+    {
+         ASSERT(0); /* coding error -- we couldnt have created any such key */
+    }
+
+    return CKR_OK == pkcs11h_certificate_signAny(cert, mech.mechanism,
+                                                 tbs, tbslen, sig, siglen);
+}
+
+/* wrapper for handle free */
+static void
+xkey_handle_free(void *handle)
+{
+    pkcs11h_certificate_freeCertificate(handle);
+}
+
+
+/**
+ * Load certificate and public key from pkcs11h to SSL_CTX
+ * through xkey provider.
+ *
+ * @param certificate          pkcs11h certificate object
+ * @param ctx                  OpenVPN root tls context
+ *
+ * @returns                    1 on success, 0 on error to match
+ *                             other xkey_load_.. routines
+ */
+static int
+xkey_load_from_pkcs11h(pkcs11h_certificate_t certificate,
+                        struct tls_root_ctx *const ctx)
+{
+    int ret = 0;
+
+    X509 *x509 = pkcs11h_openssl_getX509(certificate);
+    if (!x509)
+    {
+        msg(M_WARN, "PKCS#11: Unable get x509 certificate object");
+        return 0;
+    }
+
+    EVP_PKEY *pubkey = X509_get0_pubkey(x509);
+
+    XKEY_PRIVKEY_FREE_fn *free_op = xkey_handle_free; /* it calls pkcs11h_..._freeCertificate() */
+    XKEY_EXTERNAL_SIGN_fn *sign_op = xkey_pkcs11h_sign;
+
+    EVP_PKEY *pkey = xkey_load_generic_key(tls_libctx, certificate, pubkey, sign_op, free_op);
+    if (!pkey)
+    {
+        msg(M_WARN, "PKCS#11: Failed to load private key into xkey provider");
+        goto cleanup;
+    }
+    /* provider took ownership of the pkcs11h certificate object -- do not free below */
+    certificate = NULL;
+
+    if (!SSL_CTX_use_cert_and_key(ctx->ctx, x509, pkey, NULL, 0))
+    {
+        msg(M_WARN, "PKCS#11: Failed to set cert and private key for OpenSSL");
+        goto cleanup;
+    }
+    ret = 1;
+
+cleanup:
+    if (x509)
+    {
+        X509_free(x509);
+    }
+    if (pkey)
+    {
+        EVP_PKEY_free(pkey);
+    }
+    if (certificate)
+    {
+        pkcs11h_certificate_freeCertificate(certificate);
+    }
+    return ret;
+}
+#endif /* HAVE_XKEY_PROVIDER */
+
 int
 pkcs11_init_tls_session(pkcs11h_certificate_t certificate,
                         struct tls_root_ctx *const ssl_ctx)
 {
+
+#ifdef HAVE_XKEY_PROVIDER
+    return (xkey_load_from_pkcs11h(certificate, ssl_ctx) == 0); /* inverts the return value */
+#endif
+
     int ret = 1;
 
     X509 *x509 = NULL;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8f0281b1..b48845eb 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -70,7 +70,7 @@
 #include <openssl/applink.c>
 #endif
 
-static OSSL_LIB_CTX *tls_libctx;
+OSSL_LIB_CTX *tls_libctx; /* Global */
 
 static void unload_xkey_provider(void);
 
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index e2ddc178..8eac4c7c 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -151,6 +151,8 @@ EVP_PKEY *
 xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
                       XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op);
 
+extern OSSL_LIB_CTX *tls_libctx; /* Global */
+
 #endif /* HAVE_XKEY_PROVIDER */
 
 #endif /* XKEY_COMMON_H_ */
-- 
2.30.2


