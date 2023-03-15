From: selva.nair@...277...
Date: Tue, 14 Mar 2023 21:35:15 -0400
Message-Id: <20230315013516.1256700-4-selva.nair@...277...>
In-Reply-To: <20230315013516.1256700-1-selva.nair@...277...>
References: <20230315013516.1256700-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Refactor
 SSL_CTX_use_CryptoAPI_certificate()
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

- Loading the certificate and key into the provider is split out of
  setting up the SSL context. This allows testing of signing by
  cryptoapi-provider interface without dependence on SSL context
  or link-time wrapping.

Change-Id: I269b94589636425e1ba9bf953047d238fa830376
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 63 +++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 022f53d4..20b7d985 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -401,11 +401,17 @@ get_cert_name(const CERT_CONTEXT *cc, struct gc_arena *gc)
     return name;
 }
 
-int
-SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
+/**
+ * Load certificate matching 'cert_prop' from Windows cert store
+ * into xkey provider and return pointers to X509 cert and private key.
+ * Returns 1 on success, 0 on error.
+ * Caller must free 'cert' and 'privkey' after use.
+ */
+static int
+Load_CryptoAPI_certificate(const char *cert_prop, X509 **cert, EVP_PKEY **privkey)
 {
+
     HCERTSTORE cs;
-    X509 *cert = NULL;
     CAPI_DATA *cd = calloc(1, sizeof(*cd));
     struct gc_arena gc = gc_new();
 
@@ -450,9 +456,9 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
 
     /* cert_context->pbCertEncoded is the cert X509 DER encoded. */
-    cert = d2i_X509(NULL, (const unsigned char **) &cd->cert_context->pbCertEncoded,
-                    cd->cert_context->cbCertEncoded);
-    if (cert == NULL)
+    *cert = d2i_X509(NULL, (const unsigned char **) &cd->cert_context->pbCertEncoded,
+                     cd->cert_context->cbCertEncoded);
+    if (*cert == NULL)
     {
         msg(M_NONFATAL, "Error in cryptoapicert: X509 certificate decode failed");
         goto err;
@@ -468,28 +474,16 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
         /* private key may be in a token not available, or incompatible with CNG */
         msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to acquire key. Key not present or "
             "is in a legacy token not supported by Windows CNG API");
-        goto err;
-    }
-
-    /* Public key in cert is NULL until we call SSL_CTX_use_certificate(),
-     * so we do it here then...  */
-    if (!SSL_CTX_use_certificate(ssl_ctx, cert))
-    {
+        X509_free(*cert);
         goto err;
     }
 
     /* the public key */
-    EVP_PKEY *pkey = X509_get_pubkey(cert);
+    EVP_PKEY *pkey = X509_get_pubkey(*cert);
     cd->pubkey = pkey; /* will be freed with cd */
 
-    /* SSL_CTX_use_certificate() increased the reference count in 'cert', so
-     * we decrease it here with X509_free(), or it will never be cleaned up. */
-    X509_free(cert);
-    cert = NULL;
-
-    EVP_PKEY *privkey = xkey_load_generic_key(tls_libctx, cd, pkey,
-                                              xkey_cng_sign, (XKEY_PRIVKEY_FREE_fn *) CAPI_DATA_free);
-    SSL_CTX_use_PrivateKey(ssl_ctx, privkey);
+    *privkey = xkey_load_generic_key(tls_libctx, cd, pkey,
+                                     xkey_cng_sign, (XKEY_PRIVKEY_FREE_fn *) CAPI_DATA_free);
     gc_free(&gc);
     return 1; /* do not free cd -- its kept by xkey provider */
 
@@ -498,5 +492,30 @@ err:
     gc_free(&gc);
     return 0;
 }
+
+int
+SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
+{
+    X509 *cert = NULL;
+    EVP_PKEY *privkey = NULL;
+    int ret = 0;
+
+    if (!Load_CryptoAPI_certificate(cert_prop, &cert, &privkey))
+    {
+        return ret;
+    }
+    if (SSL_CTX_use_certificate(ssl_ctx, cert)
+        && SSL_CTX_use_PrivateKey(ssl_ctx, privkey))
+    {
+        ret = 1;
+    }
+
+    /* Always free cert and privkey even if retained by ssl_ctx as
+     * they are reference counted */
+    X509_free(cert);
+    EVP_PKEY_free(privkey);
+    return ret;
+}
+
 #endif  /* HAVE_XKEY_PROVIDER */
 #endif                          /* _WIN32 */
-- 
2.34.1


