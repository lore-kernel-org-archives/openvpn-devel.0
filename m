From: Steffan Karger <steffan.karger@...1435...>
Date: Sat, 12 Aug 2017 11:53:52 +0200
Message-ID: <1502531632-16833-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
References: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] tls-crypt: introduce tls_crypt_kt()
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

Reduces code duplication (and prepares for tls-crypt-v2, which needs the
same functionality at more places).

Because tls_crypt_kt() is a static function we now need to include
tls_crypt.c from the tests, rather than tls_crypt.h.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: improve error handling

 src/openvpn/tls_crypt.c                   | 40 ++++++++++++++++++++-----------
 tests/unit_tests/openvpn/Makefile.am      |  3 +--
 tests/unit_tests/openvpn/test_tls_crypt.c | 20 ++++------------
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e13bb4e..403060d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -35,35 +35,47 @@
 
 #include "tls_crypt.h"
 
-int
-tls_crypt_buf_overhead(void)
-{
-    return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
-}
-
-void
-tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                   const char *key_inline, bool tls_server)
+static struct key_type
+tls_crypt_kt(void)
 {
-    const int key_direction = tls_server ?
-                              KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
-
     struct key_type kt;
     kt.cipher = cipher_kt_get("AES-256-CTR");
     kt.digest = md_kt_get("SHA256");
 
     if (!kt.cipher)
     {
-        msg(M_FATAL, "ERROR: --tls-crypt requires AES-256-CTR support.");
+        msg(M_WARN, "ERROR: --tls-crypt requires AES-256-CTR support.");
+        return (struct key_type) { 0 };
     }
     if (!kt.digest)
     {
-        msg(M_FATAL, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
+        msg(M_WARN, "ERROR: --tls-crypt requires HMAC-SHA-256 support.");
+        return (struct key_type) { 0 };
     }
 
     kt.cipher_length = cipher_kt_key_size(kt.cipher);
     kt.hmac_length = md_kt_size(kt.digest);
 
+    return kt;
+}
+
+int
+tls_crypt_buf_overhead(void)
+{
+    return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
+}
+
+void
+tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
+                   const char *key_inline, bool tls_server)
+{
+    const int key_direction = tls_server ?
+                              KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
+    struct key_type kt = tls_crypt_kt();
+    if (!kt.cipher || !kt.digest)
+    {
+        msg (M_FATAL, "ERROR: --tls-crypt not supported");
+    }
     crypto_read_openvpn_key(&kt, key, key_file, key_inline, key_direction,
                             "Control Channel Encryption", "tls-crypt");
 }
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 3bd382c..7b44f42 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -54,5 +54,4 @@ tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
 	$(openvpn_srcdir)/crypto_openssl.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c \
-	$(openvpn_srcdir)/tls_crypt.c
+	$(openvpn_srcdir)/platform.c
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 9b82035..0a6a08f 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -39,7 +39,7 @@
 #include <setjmp.h>
 #include <cmocka.h>
 
-#include "tls_crypt.h"
+#include "tls_crypt.c"
 
 #include "mock_msg.h"
 
@@ -60,23 +60,13 @@ setup(void **state) {
     struct test_context *ctx = calloc(1, sizeof(*ctx));
     *state = ctx;
 
-    ctx->kt.cipher = cipher_kt_get("AES-256-CTR");
-    ctx->kt.digest = md_kt_get("SHA256");
-    if (!ctx->kt.cipher)
-    {
-        printf("No AES-256-CTR support, skipping test.\n");
-        return 0;
-    }
-    if (!ctx->kt.digest)
+    struct key key = { 0 };
+
+    ctx->kt = tls_crypt_kt();
+    if (!ctx->kt.cipher || !ctx->kt.digest)
     {
-        printf("No HMAC-SHA256 support, skipping test.\n");
         return 0;
     }
-    ctx->kt.cipher_length = cipher_kt_key_size(ctx->kt.cipher);
-    ctx->kt.hmac_length = md_kt_size(ctx->kt.digest);
-
-    struct key key = { 0 };
-
     init_key_ctx(&ctx->co.key_ctx_bi.encrypt, &key, &ctx->kt, true, "TEST");
     init_key_ctx(&ctx->co.key_ctx_bi.decrypt, &key, &ctx->kt, false, "TEST");
 
-- 
2.7.4


