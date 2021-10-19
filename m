From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:11 +0200
Message-Id: <20211019183127.614175-6-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 05/21] [OSSL 3.0] Use EVP_PKEY based API
 for loading DH keys
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

OpenSSL 3.0 replaces the DH API with a generic EVP_KEY based API to
load DH parameters.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 9a7cb9c64..a44d4f85c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -649,7 +649,6 @@ void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
                        bool dh_file_inline)
 {
-    DH *dh;
     BIO *bio;
 
     ASSERT(NULL != ctx);
@@ -670,7 +669,26 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
         }
     }
 
-    dh = PEM_read_bio_DHparams(bio, NULL, NULL, NULL);
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    EVP_PKEY *dh = PEM_read_bio_Parameters(bio, NULL);
+    BIO_free(bio);
+
+    if (!dh)
+    {
+        crypto_msg(M_FATAL, "Cannot load DH parameters from %s",
+                   print_key_filename(dh_file, dh_file_inline));
+    }
+    if (!SSL_CTX_set0_tmp_dh_pkey(ctx->ctx, dh))
+    {
+        crypto_msg(M_FATAL, "SSL_CTX_set_tmp_dh");
+    }
+
+    msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
+        8 * EVP_PKEY_get_size(dh));
+
+    EVP_PKEY_free(dh);
+#else
+    DH *dh = PEM_read_bio_DHparams(bio, NULL, NULL, NULL);
     BIO_free(bio);
 
     if (!dh)
@@ -687,6 +705,7 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
         8 * DH_size(dh));
 
     DH_free(dh);
+#endif
 }
 
 void
-- 
2.33.0


