Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Mon, 19 Jun 2017 17:35:13 +0200
Message-Id: <20170619153513.5420-1-logout@...260...>
Subject: [Openvpn-devel] [PATCH] OpenSSL: remove pre-1.1 function from the
 OpenSSL compat interface
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

From: Emmanuel Deloget <logout@...260...>

HMAC_CTX_init() has been removed from OpenSSL 1.1. Both this function
and function HMAC_CTX_cleanup() has been replaced by HMAC_CTX_reset().

Commit aba98e9050eb54d72d921e70bcd422cb892b9c6c introduced support for
HMAC_CTX_init() for OpenSSL 1.1+ while other functions were mimicking
the OpenSSL 1.1 interface for earlier version. This is clearly not a
good idea -- a better approach would be to provide the new interface for
pre-1.1 versions in order to have the dependant code use only one
interface version. To implement that, we remove HMAC_CTX_init() from our
compatibility layer and implement HMAC_CTX_reset() in terms of a cleanup
followed by an init (as the regular HMAC_CTX_reset() function does in
OpenSSL 1.1. This change has a consequence on HMAC_CTX_free() which now
need to cleanup() the HMAC context before freeing it.
---
 configure.ac                 |  1 -
 src/openvpn/crypto_openssl.c |  2 +-
 src/openvpn/openssl_compat.h | 39 ++++++++++++++-------------------------
 3 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/configure.ac b/configure.ac
index 56ce5f82..22f91cb6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -924,7 +924,6 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			HMAC_CTX_new \
 			HMAC_CTX_free \
 			HMAC_CTX_reset \
-			HMAC_CTX_init \
 			EVP_MD_CTX_new \
 			EVP_MD_CTX_free \
 			EVP_MD_CTX_reset \
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a55e65c1..9cf3355b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -930,7 +930,7 @@ hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,
 {
     ASSERT(NULL != kt && NULL != ctx);
 
-    HMAC_CTX_init(ctx);
+    HMAC_CTX_reset(ctx);
     HMAC_Init_ex(ctx, key, key_len, kt, NULL);
 
     /* make sure we used a big enough key */
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index c765f0bb..617410e0 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -120,6 +120,15 @@ EVP_CIPHER_CTX_new(void)
 /**
  * Reset a HMAC context
  *
+ * OpenSSL 1.1+ removes APIs HMAC_CTX_init() and HMAC_CTX_cleanup()
+ * and replace them with a single call that does a cleanup followed
+ * by an init. A proper _reset() for OpenSSL < 1.1 should perform
+ * a similar set of operations.
+ *
+ * It means that before we kill a HMAC context, we'll have to cleanup
+ * again, as we probably have allocated a few resources when we forced
+ * an init.
+ *
  * @param ctx                 The HMAC context
  * @return                    1 on success, 0 on error
  */
@@ -127,42 +136,22 @@ static inline int
 HMAC_CTX_reset(HMAC_CTX *ctx)
 {
     HMAC_CTX_cleanup(ctx);
+    HMAC_CTX_init(ctx);
     return 1;
 }
 #endif
 
-#if !defined(HAVE_HMAC_CTX_INIT)
-/**
- * Init a HMAC context
- *
- * @param ctx                 The HMAC context
- *
- * Contrary to many functions in this file, HMAC_CTX_init() is not
- * an OpenSSL 1.1 function: it comes from previous versions and was
- * removed in v1.1. As a consequence, there is no distincting in
- * v1.1 between a cleanup, and init and a reset. Yet, previous OpenSSL
- * version need this distinction.
- *
- * In order to respect previous OpenSSL versions, we implement init
- * as reset for OpenSSL 1.1+.
- */
-static inline void
-HMAC_CTX_init(HMAC_CTX *ctx)
-{
-    HMAC_CTX_reset(ctx);
-}
-#endif
-
 #if !defined(HAVE_HMAC_CTX_FREE)
 /**
- * Free an existing HMAC context
+ * Cleanup and free an existing HMAC context
  *
  * @param ctx                 The HMAC context
  */
 static inline void
-HMAC_CTX_free(HMAC_CTX *c)
+HMAC_CTX_free(HMAC_CTX *ctx)
 {
-	free(c);
+    HMAC_CTX_cleanup(ctx);
+    free(ctx);
 }
 #endif
 
-- 
2.11.0


