From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 15 May 2017 16:44:43 +0200
Message-ID: <1494859483-16466-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Skip tls-crypt unit tests if required
	crypto mode not supported
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

Instead of failing the test with an unclear error, print that the a
required crypto primitive is not supported and skip the test.

This is for example the case when using the system-supplied openssl on
SLES11, which does not support AES-256-CTR.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 tests/unit_tests/openvpn/test_tls_crypt.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 7b014e0..262b198 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -58,11 +58,22 @@ struct test_context {
 
 static int
 setup(void **state) {
-    struct test_context *ctx  = calloc(1, sizeof(*ctx));
+    struct test_context *ctx = calloc(1, sizeof(*ctx));
+    *state = ctx;
 
     ctx->kt.cipher = cipher_kt_get("AES-256-CTR");
-    ctx->kt.cipher_length = cipher_kt_key_size(ctx->kt.cipher);
     ctx->kt.digest = md_kt_get("SHA256");
+    if (!ctx->kt.cipher)
+    {
+        printf("No AES-256-CTR support, skipping test.\n");
+        return 0;
+    }
+    if (!ctx->kt.digest)
+    {
+        printf("No HMAC-SHA256 support, skipping test.\n");
+        return 0;
+    }
+    ctx->kt.cipher_length = cipher_kt_key_size(ctx->kt.cipher);
     ctx->kt.hmac_length = md_kt_size(ctx->kt.digest);
 
     struct key key = { 0 };
@@ -82,8 +93,6 @@ setup(void **state) {
     /* Write dummy opcode and session id */
     buf_write(&ctx->ciphertext, "012345678", 1 + 8);
 
-    *state = ctx;
-
     return 0;
 }
 
@@ -102,6 +111,14 @@ teardown(void **state) {
     return 0;
 }
 
+static void skip_if_tls_crypt_not_supported(struct test_context *ctx)
+{
+    if (!ctx->kt.cipher || !ctx->kt.digest)
+    {
+        skip();
+    }
+}
+
 /**
  * Check that short messages are successfully wrapped-and-unwrapped.
  */
@@ -109,6 +126,8 @@ static void
 tls_crypt_loopback(void **state) {
     struct test_context *ctx = (struct test_context *) *state;
 
+    skip_if_tls_crypt_not_supported(ctx);
+
     assert_true(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
@@ -124,6 +143,8 @@ static void
 tls_crypt_loopback_zero_len(void **state) {
     struct test_context *ctx = (struct test_context *) *state;
 
+    skip_if_tls_crypt_not_supported(ctx);
+
     buf_clear(&ctx->source);
 
     assert_true(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
@@ -141,6 +162,8 @@ static void
 tls_crypt_loopback_max_len(void **state) {
     struct test_context *ctx = (struct test_context *) *state;
 
+    skip_if_tls_crypt_not_supported(ctx);
+
     buf_clear(&ctx->source);
     assert_non_null(buf_write_alloc(&ctx->source,
                                     TESTBUF_SIZE - BLEN(&ctx->ciphertext) - tls_crypt_buf_overhead()));
@@ -160,6 +183,8 @@ static void
 tls_crypt_fail_msg_too_long(void **state) {
     struct test_context *ctx = (struct test_context *) *state;
 
+    skip_if_tls_crypt_not_supported(ctx);
+
     buf_clear(&ctx->source);
     assert_non_null(buf_write_alloc(&ctx->source,
                                     TESTBUF_SIZE - BLEN(&ctx->ciphertext) - tls_crypt_buf_overhead() + 1));
@@ -174,6 +199,8 @@ static void
 tls_crypt_fail_invalid_key(void **state) {
     struct test_context *ctx = (struct test_context *) *state;
 
+    skip_if_tls_crypt_not_supported(ctx);
+
     /* Change decrypt key */
     struct key key = { { 1 } };
     free_key_ctx(&ctx->co.key_ctx_bi.decrypt);
@@ -191,6 +218,8 @@ static void
 tls_crypt_fail_replay(void **state) {
     struct test_context *ctx = (struct test_context *) *state;
 
+    skip_if_tls_crypt_not_supported(ctx);
+
     assert_true(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     struct buffer tmp = ctx->ciphertext;
@@ -208,6 +237,8 @@ static void
 tls_crypt_ignore_replay(void **state) {
     struct test_context *ctx = (struct test_context *) *state;
 
+    skip_if_tls_crypt_not_supported(ctx);
+
     ctx->co.flags |= CO_IGNORE_PACKET_ID;
 
     assert_true(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
-- 
2.7.4


