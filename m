From: Arne Schwabe <arne@...1227...>
Date: Sun, 19 Sep 2021 18:29:50 +0200
Message-Id: <20210919162956.695496-2-arne@...1227...>
In-Reply-To: <20210919162956.695496-1-arne@...1227...>
References: <20210919162956.695496-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/8] [OSSL 3.0] Disable engine support for
 OpenSSL 3.0
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

Engine support is deprecated in OpenSSL 3.0. No longer use the deprecated API
when running with OpenSSL 3.0
---
 src/openvpn/crypto_openssl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index f1b2d8b4a..34a564e46 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -67,7 +67,7 @@
 #warning Some OpenSSL HMAC message digests now support key lengths greater than MAX_HMAC_KEY_LENGTH -- consider increasing MAX_HMAC_KEY_LENGTH
 #endif
 
-#if HAVE_OPENSSL_ENGINE
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
 #include <openssl/ui.h>
 #include <openssl/engine.h>
 
@@ -132,7 +132,7 @@ setup_engine(const char *engine)
 void
 crypto_init_lib_engine(const char *engine_name)
 {
-#if HAVE_OPENSSL_ENGINE
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
     if (!engine_initialized)
     {
         ASSERT(engine_name);
@@ -182,7 +182,7 @@ crypto_uninit_lib(void)
     fclose(fp);
 #endif
 
-#if HAVE_OPENSSL_ENGINE
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
     if (engine_initialized)
     {
         ENGINE_cleanup();
@@ -368,7 +368,8 @@ show_available_digests(void)
 void
 show_available_engines(void)
 {
-#if HAVE_OPENSSL_ENGINE /* Only defined for OpenSSL */
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
+    /* Only defined for OpenSSL */
     ENGINE *e;
 
     printf("OpenSSL Crypto Engines\n\n");
@@ -1151,7 +1152,7 @@ memcmp_constant_time(const void *a, const void *b, size_t size)
     return CRYPTO_memcmp(a, b, size);
 }
 
-#if HAVE_OPENSSL_ENGINE
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
 static int
 ui_reader(UI *ui, UI_STRING *uis)
 {
@@ -1175,7 +1176,7 @@ ui_reader(UI *ui, UI_STRING *uis)
 EVP_PKEY *
 engine_load_key(const char *file, SSL_CTX *ctx)
 {
-#if HAVE_OPENSSL_ENGINE
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
     UI_METHOD *ui;
     EVP_PKEY *pkey;
 
-- 
2.33.0


