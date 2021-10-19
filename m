From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:08 +0200
Message-Id: <20211019182332.613155-4-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 02/16] [OSSL 3.0] Disable engine support
 for OpenSSL 3.0
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac                 |  2 ++
 src/openvpn/crypto_openssl.c | 13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index a37dc762f..0f9e203a4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -813,7 +813,9 @@ if test "${with_crypto_library}" = "openssl"; then
 	if test "${have_openssl_engine}" = "no"; then
 		AC_CHECK_DECL( [ENGINE_cleanup], [have_openssl_engine="yes"],,
 			[[
+			    #if OPENSSL_VERSION_NUMBER < 0x30000000L
 				#include <openssl/engine.h>
+				#endif
 			]]
 		)
 	fi
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1c800df7f..3a344f266 100644
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
@@ -1165,7 +1166,7 @@ memcmp_constant_time(const void *a, const void *b, size_t size)
     return CRYPTO_memcmp(a, b, size);
 }
 
-#if HAVE_OPENSSL_ENGINE
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
 static int
 ui_reader(UI *ui, UI_STRING *uis)
 {
@@ -1189,7 +1190,7 @@ ui_reader(UI *ui, UI_STRING *uis)
 EVP_PKEY *
 engine_load_key(const char *file, SSL_CTX *ctx)
 {
-#if HAVE_OPENSSL_ENGINE
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER < 0x30000000L
     UI_METHOD *ui;
     EVP_PKEY *pkey;
 
-- 
2.33.0


