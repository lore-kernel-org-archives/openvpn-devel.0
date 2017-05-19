Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 19 May 2017 12:38:16 +0200
Message-Id: <20170519103816.19851-7-logout@...260...>
In-Reply-To: <20170519103816.19851-1-logout@...260...>
References: <CAKh=nwFot6GZiv1cs2-X8kL0UNS6r8BGsNQ2RtC+0eyiJRMZtA@...278...>
	<20170519103816.19851-1-logout@...260...>
Subject: [Openvpn-devel] [PATCH 7/7] OpenSSL: don't use direct access to the
	internal of HMAC_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including HMAC_CTX. We have to use the defined
functions to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  4 +++
 src/openvpn/crypto.c         |  4 +--
 src/openvpn/crypto_backend.h | 14 ++++++++++
 src/openvpn/crypto_mbedtls.c | 15 ++++++++++
 src/openvpn/crypto_openssl.c | 17 ++++++++++--
 src/openvpn/ntlm.c           | 12 ++++----
 src/openvpn/openssl_compat.h | 65 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl.c            | 38 ++++++++++++++------------
 8 files changed, 140 insertions(+), 29 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8a9a3ff3..7875c4fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -922,6 +922,10 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 		[ \
 			EVP_CIPHER_CTX_new \
 			EVP_CIPHER_CTX_free \
+			HMAC_CTX_new \
+			HMAC_CTX_free \
+			HMAC_CTX_reset \
+			HMAC_CTX_init \
 			EVP_MD_CTX_new \
 			EVP_MD_CTX_free \
 			EVP_MD_CTX_reset \
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 893879cf..a80c3f7f 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -854,7 +854,7 @@ init_key_ctx(struct key_ctx *ctx, struct key *key,
     }
     if (kt->digest && kt->hmac_length > 0)
     {
-        ALLOC_OBJ(ctx->hmac, hmac_ctx_t);
+        ctx->hmac = hmac_ctx_new();
         hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest);
 
         msg(D_HANDSHAKE,
@@ -885,7 +885,7 @@ free_key_ctx(struct key_ctx *ctx)
     if (ctx->hmac)
     {
         hmac_ctx_cleanup(ctx->hmac);
-        free(ctx->hmac);
+        hmac_ctx_free(ctx->hmac);
         ctx->hmac = NULL;
     }
     ctx->implicit_iv_len = 0;
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 3a911a47..3dc75ab9 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -584,6 +584,20 @@ void md_ctx_final(md_ctx_t *ctx, uint8_t *dst);
  */
 
 /*
+ * Create a new HMAC context
+ *
+ * @return              A new HMAC context
+ */
+hmac_ctx_t *hmac_ctx_new(void);
+
+/*
+ * Free an existing HMAC context
+ *
+ * @param  ctx           HMAC context to free
+ */
+void hmac_ctx_free(hmac_ctx_t *ctx);
+
+/*
  * Initialises the given HMAC context, using the given digest
  * and key.
  *
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 4d38aadc..f0698f61 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -841,6 +841,21 @@ md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
 /*
  * TODO: re-enable dmsg for crypto debug
  */
+
+mbedtls_md_context_t *
+hmac_ctx_new(void)
+{
+    mbedtls_md_context_t *ctx;
+    ALLOC_OBJ(ctx, mbedtls_md_context_t);
+    return ctx;
+}
+
+void
+hmac_ctx_free(mbedtls_md_context_t *ctx)
+{
+    free(ctx);
+}
+
 void
 hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, int key_len,
               const mbedtls_md_info_t *kt)
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0644f1c3..b64f7f04 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -911,6 +911,19 @@ md_ctx_final(EVP_MD_CTX *ctx, uint8_t *dst)
  *
  */
 
+HMAC_CTX *
+hmac_ctx_new(void)
+{
+    HMAC_CTX *ctx = HMAC_CTX_new();
+    check_malloc_return(ctx);
+    return ctx;
+}
+
+void
+hmac_ctx_free(HMAC_CTX *ctx)
+{
+    HMAC_CTX_free(ctx);
+}
 
 void
 hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
@@ -918,8 +931,6 @@ hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
 {
     ASSERT(NULL != kt && NULL != ctx);
 
-    CLEAR(*ctx);
-
     HMAC_CTX_init(ctx);
     HMAC_Init_ex(ctx, key, key_len, kt, NULL);
 
@@ -930,7 +941,7 @@ hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
 void
 hmac_ctx_cleanup(HMAC_CTX *ctx)
 {
-    HMAC_CTX_cleanup(ctx);
+    HMAC_CTX_reset(ctx);
 }
 
 int
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 0c436812..4a4e8b9b 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -86,13 +86,13 @@ static void
 gen_hmac_md5(const char *data, int data_len, const char *key, int key_len,char *result)
 {
     const md_kt_t *md5_kt = md_kt_get("MD5");
-    hmac_ctx_t hmac_ctx;
-    CLEAR(hmac_ctx);
+    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
 
-    hmac_ctx_init(&hmac_ctx, key, key_len, md5_kt);
-    hmac_ctx_update(&hmac_ctx, (const unsigned char *)data, data_len);
-    hmac_ctx_final(&hmac_ctx, (unsigned char *)result);
-    hmac_ctx_cleanup(&hmac_ctx);
+    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt);
+    hmac_ctx_update(hmac_ctx, (const unsigned char *)data, data_len);
+    hmac_ctx_final(hmac_ctx, (unsigned char *)result);
+    hmac_ctx_cleanup(hmac_ctx);
+    hmac_ctx_free(hmac_ctx);
 }
 
 static void
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index d1be9d78..3c93bfaa 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -124,6 +124,71 @@ EVP_CIPHER_CTX_new(void)
 }
 #endif
 
+#if !defined(HAVE_HMAC_CTX_RESET)
+/**
+ * Reset a HMAC context
+ *
+ * @param ctx                 The HMAC context
+ * @return                    1 on success, 0 on error
+ */
+static inline int
+HMAC_CTX_reset(HMAC_CTX *ctx)
+{
+    HMAC_CTX_cleanup(ctx);
+    return 1;
+}
+#endif
+
+#if !defined(HAVE_HMAC_CTX_INIT)
+/**
+ * Init a HMAC context
+ *
+ * @param ctx                 The HMAC context
+ *
+ * Contrary to many functions in this file, HMAC_CTX_init() is not
+ * an OpenSSL 1.1 function: it comes from previous versions and was
+ * removed in v1.1. As a consequence, there is no distincting in
+ * v1.1 between a cleanup, and init and a reset. Yet, previous OpenSSL
+ * version need this distinction.
+ *
+ * In order to respect previous OpenSSL versions, we implement init
+ * as reset for OpenSSL 1.1+.
+ */
+static inline void
+HMAC_CTX_init(HMAC_CTX *ctx)
+{
+    HMAC_CTX_reset(ctx);
+}
+#endif
+
+#if !defined(HAVE_HMAC_CTX_FREE)
+/**
+ * Free an existing HMAC context
+ *
+ * @param ctx                 The HMAC context
+ */
+static inline void
+HMAC_CTX_free(HMAC_CTX *c)
+{
+	free(c);
+}
+#endif
+
+#if !defined(HAVE_HMAC_CTX_NEW)
+/**
+ * Allocate a new HMAC context object
+ *
+ * @return                    A zero'ed HMAC context object
+ */
+static inline HMAC_CTX *
+HMAC_CTX_new(void)
+{
+    HMAC_CTX *ctx = NULL;
+    ALLOC_OBJ_CLEAR(ctx, HMAC_CTX);
+    return ctx;
+}
+#endif
+
 #if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
 /**
  * Fetch the default password callback user data from the SSL context
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3d5e8241..55cc457d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1607,8 +1607,8 @@ tls1_P_hash(const md_kt_t *md_kt,
 {
     struct gc_arena gc = gc_new();
     int chunk;
-    hmac_ctx_t ctx;
-    hmac_ctx_t ctx_tmp;
+    hmac_ctx_t *ctx;
+    hmac_ctx_t *ctx_tmp;
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
     unsigned int A1_len;
 
@@ -1617,8 +1617,8 @@ tls1_P_hash(const md_kt_t *md_kt,
     const uint8_t *out_orig = out;
 #endif
 
-    CLEAR(ctx);
-    CLEAR(ctx_tmp);
+    ctx = hmac_ctx_new();
+    ctx_tmp = hmac_ctx_new();
 
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
@@ -1626,36 +1626,38 @@ tls1_P_hash(const md_kt_t *md_kt,
     chunk = md_kt_size(md_kt);
     A1_len = md_kt_size(md_kt);
 
-    hmac_ctx_init(&ctx, sec, sec_len, md_kt);
-    hmac_ctx_init(&ctx_tmp, sec, sec_len, md_kt);
+    hmac_ctx_init(ctx, sec, sec_len, md_kt);
+    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);
 
-    hmac_ctx_update(&ctx,seed,seed_len);
-    hmac_ctx_final(&ctx, A1);
+    hmac_ctx_update(ctx,seed,seed_len);
+    hmac_ctx_final(ctx, A1);
 
     for (;; )
     {
-        hmac_ctx_reset(&ctx);
-        hmac_ctx_reset(&ctx_tmp);
-        hmac_ctx_update(&ctx,A1,A1_len);
-        hmac_ctx_update(&ctx_tmp,A1,A1_len);
-        hmac_ctx_update(&ctx,seed,seed_len);
+        hmac_ctx_reset(ctx);
+        hmac_ctx_reset(ctx_tmp);
+        hmac_ctx_update(ctx,A1,A1_len);
+        hmac_ctx_update(ctx_tmp,A1,A1_len);
+        hmac_ctx_update(ctx,seed,seed_len);
 
         if (olen > chunk)
         {
-            hmac_ctx_final(&ctx, out);
+            hmac_ctx_final(ctx, out);
             out += chunk;
             olen -= chunk;
-            hmac_ctx_final(&ctx_tmp, A1); /* calc the next A1 value */
+            hmac_ctx_final(ctx_tmp, A1); /* calc the next A1 value */
         }
         else    /* last one */
         {
-            hmac_ctx_final(&ctx, A1);
+            hmac_ctx_final(ctx, A1);
             memcpy(out,A1,olen);
             break;
         }
     }
-    hmac_ctx_cleanup(&ctx);
-    hmac_ctx_cleanup(&ctx_tmp);
+    hmac_ctx_cleanup(ctx);
+    hmac_ctx_free(ctx);
+    hmac_ctx_cleanup(ctx_tmp);
+    hmac_ctx_free(ctx_tmp);
     secure_memzero(A1, sizeof(A1));
 
     dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig, olen_orig, 0, &gc));
-- 
2.11.0


