From: selva.nair@...277...
Date: Sun, 14 Jan 2018 14:44:31 -0500
Message-Id: <1515959073-10376-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1515959073-10376-1-git-send-email-selva.nair@...277...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/3] Refactor ssl_openssl.c in prep for
 external EC key support
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

- Move setting of key method callbacks into a function

No change in functionality.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl_openssl.c | 65 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d6d9acf..c29dbcf 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1063,20 +1063,17 @@ done:
     return ret;
 }
 
-int
-tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
-                                 const char *cert_file, const char *cert_file_inline)
+static int
+tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 {
     RSA *rsa = NULL;
     RSA *pub_rsa;
     RSA_METHOD *rsa_meth;
-    X509 *cert = NULL;
 
     ASSERT(NULL != ctx);
 
-    tls_ctx_load_cert_file_and_copy(ctx, cert_file, cert_file_inline, &cert);
-
-    ASSERT(NULL != cert);
+    pub_rsa = EVP_PKEY_get0_RSA(pkey);
+    ASSERT(NULL != pub_rsa);
 
     /* allocate custom RSA method object */
     rsa_meth = RSA_meth_new("OpenVPN external private key RSA Method",
@@ -1098,18 +1095,6 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
         goto err;
     }
 
-    /* get the public key */
-    EVP_PKEY *pkey = X509_get0_pubkey(cert);
-    ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
-    pub_rsa = EVP_PKEY_get0_RSA(pkey);
-
-    /* Certificate might not be RSA but DSA or EC */
-    if (!pub_rsa)
-    {
-        crypto_msg(M_WARN, "management-external-key requires a RSA certificate");
-        goto err;
-    }
-
     /* initialize RSA object */
     const BIGNUM *n = NULL;
     const BIGNUM *e = NULL;
@@ -1118,8 +1103,10 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
     RSA_set_flags(rsa, RSA_flags(rsa) | RSA_FLAG_EXT_PKEY);
     if (!RSA_set_method(rsa, rsa_meth))
     {
+        RSA_meth_free(rsa_meth);
         goto err;
     }
+    /* from this point rsa_meth will get freed with rsa */
 
     /* bind our custom RSA object to ssl_ctx */
     if (!SSL_CTX_use_RSAPrivateKey(ctx->ctx, rsa))
@@ -1127,15 +1114,10 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
         goto err;
     }
 
-    X509_free(cert);
     RSA_free(rsa); /* doesn't necessarily free, just decrements refcount */
     return 1;
 
 err:
-    if (cert)
-    {
-        X509_free(cert);
-    }
     if (rsa)
     {
         RSA_free(rsa);
@@ -1147,6 +1129,41 @@ err:
             RSA_meth_free(rsa_meth);
         }
     }
+    return 0;
+}
+
+int
+tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
+                                 const char *cert_file, const char *cert_file_inline)
+{
+    X509 *cert = NULL;
+
+    ASSERT(NULL != ctx);
+
+    tls_ctx_load_cert_file_and_copy(ctx, cert_file, cert_file_inline, &cert);
+
+    ASSERT(NULL != cert);
+
+    /* get the public key */
+    EVP_PKEY *pkey = X509_get0_pubkey(cert);
+    ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
+    X509_free(cert);
+
+    if (EVP_PKEY_get0_RSA(pkey))
+    {
+        if (!tls_ctx_use_external_rsa_key(ctx, pkey))
+        {
+            goto err;
+        }
+    }
+    else
+    {
+        crypto_msg(M_WARN, "management-external-key requires a RSA certificate");
+        goto err;
+    }
+    return 1;
+
+err:
     crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
     return 0;
 }
-- 
2.1.4


