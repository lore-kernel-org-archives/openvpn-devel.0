From: selva.nair@...277...
Date: Thu, 25 Jan 2018 14:45:13 -0500
Message-Id: <1516909513-31683-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1516301696-11308-1-git-send-email-selva.nair@...277...>
References: <1516301696-11308-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v3 2/3] Allow external EC key through
 --management-external-key
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

- This automatically supports EC certificates through
  --management-external-cert
- EC signature request from management is prompted by
  >PK_SIGN if the client supports it (or >RSA_SIGN)
  Response should be of the form 'pk-sig' (or rsa-sig
  by older clients) followed by DER encoded signature
  as base64 terminated by 'END' on a new line.

v3: This is v2 adapted to the client_version capability
Requires pacthes 1 and 2 of the series 147:
https://patchwork.openvpn.net/project/openvpn2/list/?series=147

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/management-notes.txt  |   9 +-
 src/openvpn/ssl_openssl.c | 210 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 176 insertions(+), 43 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 070c2d6..96470d0 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -779,14 +779,14 @@ COMMAND -- rsa-sig (OpenVPN 2.3 or higher, management version <= 1)
 Provides support for external storage of the private key. Requires the
 --management-external-key option. This option can be used instead of "key"
 in client mode, and allows the client to run without the need to load the
-actual private key. When the SSL protocol needs to perform an RSA sign
+actual private key. When the SSL protocol needs to perform a sign
 operation, the data to be signed will be sent to the management interface
 via a notification as follows:
 
 >PK_SIGN:[BASE64_DATA] (if client announces support for management version > 1)
 >RSA_SIGN:[BASE64_DATA] (only older clients will be prompted like this)
 
-The management interface client should then create a PKCS#1 v1.5 signature of
+The management interface client should then create an appropriate signature of
 the (decoded) BASE64_DATA using the private key and return the SSL signature as
 follows:
 
@@ -797,8 +797,9 @@ pk-sig   (or rsa-sig)
 .
 END
 
-Base64 encoded output of RSA_private_encrypt() (OpenSSL) or mbedtls_pk_sign()
-(mbed TLS) will provide a correct signature.
+Base64 encoded output of RSA_private_encrypt for RSA or ECDSA_sign() for EC
+using OpenSSL or mbedtls_pk_sign() using mbed TLS will provide a correct
+signature.
 
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 242b464..74ce596 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1043,58 +1043,51 @@ openvpn_extkey_rsa_finish(RSA *rsa)
     return 1;
 }
 
-/* sign arbitrary data */
+/* Pass the input hash in 'dgst' to management and get the signature back.
+ * On input siglen contains the capacity of the buffer 'sig'.
+ * On return signature is in sig.
+ * Return value is signature length or -1 on error.
+ */
 static int
-rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
+                 unsigned char *sig, unsigned int siglen)
 {
-    /* optional app data in rsa->meth->app_data; */
     char *in_b64 = NULL;
     char *out_b64 = NULL;
-    int ret = -1;
-    int len;
+    int len = -1;
 
-    if (padding != RSA_PKCS1_PADDING)
-    {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
-        goto done;
-    }
-
-    /* convert 'from' to base64 */
-    if (openvpn_base64_encode(from, flen, &in_b64) <= 0)
-    {
-        goto done;
-    }
-
-    /* call MI for signature */
-    if (management)
+    /* convert 'dgst' to base64 */
+    if (management
+        && openvpn_base64_encode(dgst, dgstlen, &in_b64) > 0)
     {
         out_b64 = management_query_pk_sig(management, in_b64);
     }
-    if (!out_b64)
+    if (out_b64)
     {
-        goto done;
+        len = openvpn_base64_decode(out_b64, sig, siglen);
     }
 
-    /* decode base64 signature to binary */
-    len = RSA_size(rsa);
-    ret = openvpn_base64_decode(out_b64, to, len);
+    free(in_b64);
+    free(out_b64);
+    return len;
+}
 
-    /* verify length */
-    if (ret != len)
-    {
-        ret = -1;
-    }
+/* sign arbitrary data */
+static int
+rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+    unsigned int len = RSA_size(rsa);
+    int ret = -1;
 
-done:
-    if (in_b64)
-    {
-        free(in_b64);
-    }
-    if (out_b64)
+    if (padding != RSA_PKCS1_PADDING)
     {
-        free(out_b64);
+        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
+        return -1;
     }
-    return ret;
+
+    ret = get_sig_from_man(from, flen, to, len);
+
+    return (ret == len)? ret : -1;
 }
 
 static int
@@ -1166,6 +1159,130 @@ err:
     return 0;
 }
 
+#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)
+
+/* called when EC_KEY is destroyed */
+static void
+openvpn_extkey_ec_finish(EC_KEY *ec)
+{
+    /* release the method structure */
+    const EC_KEY_METHOD *ec_meth = EC_KEY_get_method(ec);
+    EC_KEY_METHOD_free((EC_KEY_METHOD *) ec_meth);
+}
+
+/* EC_KEY_METHOD callback: sign().
+ * Sign the hash using EC key and return DER encoded signature in sig,
+ * its length in siglen. Return value is 1 on success, 0 on error.
+ */
+static int
+ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
+           unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
+{
+    int capacity = ECDSA_size(ec);
+    int len = get_sig_from_man(dgst, dgstlen, sig, capacity);
+
+    if (len > 0)
+    {
+        *siglen = len;
+        return 1;
+    }
+    return 0;
+}
+
+/* EC_KEY_METHOD callback: sign_setup(). We do no precomputations */
+static int
+ecdsa_sign_setup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
+{
+    return 1;
+}
+
+/* EC_KEY_METHOD callback: sign_sig().
+ * Sign the hash and return the result as a newly allocated ECDS_SIG
+ * struct or NULL on error.
+ */
+static ECDSA_SIG *
+ecdsa_sign_sig(const unsigned char *dgst, int dgstlen, const BIGNUM *in_kinv,
+               const BIGNUM *in_r, EC_KEY *ec)
+{
+    ECDSA_SIG *ecsig = NULL;
+    unsigned int len = ECDSA_size(ec);
+    struct gc_arena gc = gc_new();
+
+    unsigned char *buf = gc_malloc(len, false, &gc);
+    if (ecdsa_sign(0, dgst, dgstlen, buf, &len, NULL, NULL, ec) != 1)
+    {
+        goto out;
+    }
+    /* const char ** should be avoided: not up to us, so we cast our way through */
+    ecsig = d2i_ECDSA_SIG(NULL, (const unsigned char **)&buf, len);
+
+out:
+    gc_free(&gc);
+    return ecsig;
+}
+
+static int
+tls_ctx_use_external_ec_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
+{
+    EC_KEY *ec = NULL;
+    EVP_PKEY *privkey = NULL;
+    EC_KEY_METHOD *ec_method;
+
+    ASSERT(ctx);
+
+    ec_method = EC_KEY_METHOD_new(EC_KEY_OpenSSL());
+    if (!ec_method)
+    {
+        goto err;
+    }
+
+    /* Among init methods, we only need the finish method */
+    EC_KEY_METHOD_set_init(ec_method, NULL, openvpn_extkey_ec_finish, NULL, NULL, NULL, NULL);
+    EC_KEY_METHOD_set_sign(ec_method, ecdsa_sign, ecdsa_sign_setup, ecdsa_sign_sig);
+
+    ec = EC_KEY_dup(EVP_PKEY_get0_EC_KEY(pkey));
+    if (!ec)
+    {
+        EC_KEY_METHOD_free(ec_method);
+        goto err;
+    }
+    if (!EC_KEY_set_method(ec, ec_method))
+    {
+        EC_KEY_METHOD_free(ec_method);
+        goto err;
+    }
+    /* from this point ec_method will get freed when ec is freed */
+
+    privkey = EVP_PKEY_new();
+    if (!EVP_PKEY_assign_EC_KEY(privkey, ec))
+    {
+        goto err;
+    }
+    /* from this point ec will get freed when privkey is freed */
+
+    if (!SSL_CTX_use_PrivateKey(ctx->ctx, privkey))
+    {
+        ec = NULL; /* avoid double freeing it below */
+        goto err;
+    }
+
+    EVP_PKEY_free(privkey); /* this will down ref privkey and ec */
+    return 1;
+
+err:
+    /* Reach here only when ec and privkey can be independenly freed */
+    if (privkey)
+    {
+        EVP_PKEY_free(privkey);
+    }
+    if(ec)
+    {
+        EC_KEY_free(ec);
+    }
+    return 0;
+}
+#endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev */
+
 int
 tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
                                  const char *cert_file, const char *cert_file_inline)
@@ -1183,18 +1300,33 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
     X509_free(cert);
 
-    if (EVP_PKEY_get0_RSA(pkey))
+    if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
     {
         if (!tls_ctx_use_external_rsa_key(ctx, pkey))
         {
             goto err;
         }
     }
+#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)
+    else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
+    {
+        if (!tls_ctx_use_external_ec_key(ctx, pkey))
+        {
+            goto err;
+        }
+    }
+    else
+    {
+        crypto_msg(M_WARN, "management-external-key requires an RSA or EC certificate");
+        goto err;
+    }
+#else
     else
     {
-        crypto_msg(M_WARN, "management-external-key requires a RSA certificate");
+        crypto_msg(M_WARN, "management-external-key requires an RSA certificate");
         goto err;
     }
+#endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev */
     return 1;
 
 err:
-- 
2.1.4


