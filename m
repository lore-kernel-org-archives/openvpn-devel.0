From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 10 Oct 2018 09:55:07 +0200
Message-ID: <1539158110-9503-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6 4/7] tls-crypt-v2: add unwrap_client_key
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

Add helper functions to unwrap tls-crypt-v2 client keys.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v3: Include length in WKc
v4: Rebase on v4 patch set
v5: Rebase on v5 patch set
v6: Change WKc length to ciphertext length (was plaintext)

 src/openvpn/buffer.h                      |   7 +
 src/openvpn/tls_crypt.c                   | 121 ++++++++++++++
 tests/unit_tests/openvpn/test_tls_crypt.c | 254 +++++++++++++++++++++++++++---
 3 files changed, 362 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index cb9e9df..e17ce07 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -837,6 +837,13 @@ buf_read_u32(struct buffer *buf, bool *good)
     }
 }
 
+/** Return true if buffer contents are equal */
+static inline bool
+buf_equal(const struct buffer *a, const struct buffer *b)
+{
+    return BLEN(a) == BLEN(b) && 0 == memcmp(BPTR(a), BPTR(b), BLEN(a));
+}
+
 /**
  * Compare src buffer contents with match.
  * *NOT* constant time. Do not use when comparing HMACs.
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 25212a1..b61c4ce 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -434,6 +434,115 @@ tls_crypt_v2_wrap_client_key(struct buffer *wkc,
     return buf_copy(wkc, &work);
 }
 
+static bool
+tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *metadata,
+                               struct buffer wrapped_client_key,
+                               struct key_ctx *server_key)
+{
+    const char *error_prefix = __func__;
+    bool ret = false;
+    struct gc_arena gc = gc_new();
+    /* The crypto API requires one extra cipher block of buffer head room when
+     * decrypting, which nicely matches the tag size of WKc.  So
+     * TLS_CRYPT_V2_MAX_WKC_LEN is always large enough for the plaintext. */
+    uint8_t plaintext_buf_data[TLS_CRYPT_V2_MAX_WKC_LEN] = { 0 };
+    struct buffer plaintext = { 0 };
+
+    dmsg(D_TLS_DEBUG_MED, "%s: unwrapping client key (len=%d): %s", __func__,
+         BLEN(&wrapped_client_key), format_hex(BPTR(&wrapped_client_key),
+                                               BLEN(&wrapped_client_key),
+                                               0, &gc));
+
+    if (TLS_CRYPT_V2_MAX_WKC_LEN < BLEN(&wrapped_client_key))
+    {
+        CRYPT_ERROR("wrapped client key too big");
+    }
+
+    /* Decrypt client key and metadata */
+    uint16_t net_len = 0;
+    const uint8_t *tag = BPTR(&wrapped_client_key);
+
+    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    {
+        CRYPT_ERROR("failed to read length");
+    }
+    memcpy(&net_len, BEND(&wrapped_client_key) - sizeof(net_len),
+           sizeof(net_len));
+
+    if (ntohs(net_len) != BLEN(&wrapped_client_key))
+    {
+        dmsg(D_TLS_DEBUG_LOW, "%s: net_len=%u, BLEN=%i", __func__,
+             ntohs(net_len), BLEN(&wrapped_client_key));
+        CRYPT_ERROR("invalid length");
+    }
+
+    buf_inc_len(&wrapped_client_key, -(int)sizeof(net_len));
+
+    if (!buf_advance(&wrapped_client_key, TLS_CRYPT_TAG_SIZE))
+    {
+        CRYPT_ERROR("failed to read tag");
+    }
+
+    if (!cipher_ctx_reset(server_key->cipher, tag))
+    {
+        CRYPT_ERROR("failed to initialize IV");
+    }
+    buf_set_write(&plaintext, plaintext_buf_data, sizeof(plaintext_buf_data));
+    int outlen = 0;
+    if (!cipher_ctx_update(server_key->cipher, BPTR(&plaintext), &outlen,
+                           BPTR(&wrapped_client_key),
+                           BLEN(&wrapped_client_key)))
+    {
+        CRYPT_ERROR("could not decrypt client key");
+    }
+    ASSERT(buf_inc_len(&plaintext, outlen));
+
+    if (!cipher_ctx_final(server_key->cipher, BEND(&plaintext), &outlen))
+    {
+        CRYPT_ERROR("cipher final failed");
+    }
+    ASSERT(buf_inc_len(&plaintext, outlen));
+
+    /* Check authentication */
+    uint8_t tag_check[TLS_CRYPT_TAG_SIZE] = { 0 };
+    hmac_ctx_reset(server_key->hmac);
+    hmac_ctx_update(server_key->hmac, (void *)&net_len, sizeof(net_len));
+    hmac_ctx_update(server_key->hmac, BPTR(&plaintext),
+                    BLEN(&plaintext));
+    hmac_ctx_final(server_key->hmac, tag_check);
+
+    if (memcmp_constant_time(tag, tag_check, sizeof(tag_check)))
+    {
+        dmsg(D_CRYPTO_DEBUG, "tag      : %s",
+             format_hex(tag, sizeof(tag_check), 0, &gc));
+        dmsg(D_CRYPTO_DEBUG, "tag_check: %s",
+             format_hex(tag_check, sizeof(tag_check), 0, &gc));
+        CRYPT_ERROR("client key authentication error");
+    }
+
+    if (buf_len(&plaintext) < sizeof(client_key->keys))
+    {
+        CRYPT_ERROR("failed to read client key");
+    }
+    memcpy(&client_key->keys, BPTR(&plaintext), sizeof(client_key->keys));
+    ASSERT(buf_advance(&plaintext, sizeof(client_key->keys)));
+
+    if(!buf_copy(metadata, &plaintext))
+    {
+        CRYPT_ERROR("metadata too large for supplied buffer");
+    }
+
+    ret = true;
+error_exit:
+    if (!ret)
+    {
+        secure_memzero(client_key, sizeof(*client_key));
+    }
+    buf_clear(&plaintext);
+    gc_free(&gc);
+    return ret;
+}
+
 void
 tls_crypt_v2_write_server_key_file(const char *filename)
 {
@@ -544,6 +653,18 @@ tls_crypt_v2_write_client_key_file(const char *filename,
     tls_crypt_v2_init_client_key(&test_client_key, &test_wrapped_client_key,
                                  filename, NULL);
     free_key_ctx_bi(&test_client_key);
+
+    /* Sanity check: unwrap and load client key (as "server") */
+    struct buffer test_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN,
+                                               &gc);
+    struct key2 test_client_key2 = { 0 };
+    free_key_ctx(&server_key);
+    tls_crypt_v2_init_server_key(&server_key, false, server_key_file,
+                                 server_key_inline);
+    msg(D_GENKEY, "Testing server-side key loading...");
+    ASSERT(tls_crypt_v2_unwrap_client_key(&test_client_key2, &test_metadata,
+                                          test_wrapped_client_key, &server_key));
+    secure_memzero(&test_client_key2, sizeof(test_client_key2));
     free_buf(&test_wrapped_client_key);
 
 cleanup:
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index f3228ad..d499c4e 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -45,7 +45,7 @@
 
 const char plaintext_short[1];
 
-struct test_context {
+struct test_tls_crypt_context {
     struct crypto_options co;
     struct key_type kt;
     struct buffer source;
@@ -54,8 +54,8 @@ struct test_context {
 };
 
 static int
-setup(void **state) {
-    struct test_context *ctx = calloc(1, sizeof(*ctx));
+test_tls_crypt_setup(void **state) {
+    struct test_tls_crypt_context *ctx = calloc(1, sizeof(*ctx));
     *state = ctx;
 
     struct key key = { 0 };
@@ -84,8 +84,9 @@ setup(void **state) {
 }
 
 static int
-teardown(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+test_tls_crypt_teardown(void **state) {
+    struct test_tls_crypt_context *ctx =
+            (struct test_tls_crypt_context *)*state;
 
     free_buf(&ctx->source);
     free_buf(&ctx->ciphertext);
@@ -98,7 +99,7 @@ teardown(void **state) {
     return 0;
 }
 
-static void skip_if_tls_crypt_not_supported(struct test_context *ctx)
+static void skip_if_tls_crypt_not_supported(struct test_tls_crypt_context *ctx)
 {
     if (!ctx->kt.cipher || !ctx->kt.digest)
     {
@@ -111,7 +112,7 @@ static void skip_if_tls_crypt_not_supported(struct test_context *ctx)
  */
 static void
 tls_crypt_loopback(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+    struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
 
@@ -128,7 +129,7 @@ tls_crypt_loopback(void **state) {
  */
 static void
 tls_crypt_loopback_zero_len(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+    struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
 
@@ -147,7 +148,7 @@ tls_crypt_loopback_zero_len(void **state) {
  */
 static void
 tls_crypt_loopback_max_len(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+    struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
 
@@ -168,7 +169,7 @@ tls_crypt_loopback_max_len(void **state) {
  */
 static void
 tls_crypt_fail_msg_too_long(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+    struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
 
@@ -184,7 +185,7 @@ tls_crypt_fail_msg_too_long(void **state) {
  */
 static void
 tls_crypt_fail_invalid_key(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+    struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
 
@@ -203,7 +204,7 @@ tls_crypt_fail_invalid_key(void **state) {
  */
 static void
 tls_crypt_fail_replay(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+    struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
 
@@ -222,7 +223,7 @@ tls_crypt_fail_replay(void **state) {
  */
 static void
 tls_crypt_ignore_replay(void **state) {
-    struct test_context *ctx = (struct test_context *) *state;
+    struct test_tls_crypt_context *ctx = (struct test_tls_crypt_context *) *state;
 
     skip_if_tls_crypt_not_supported(ctx);
 
@@ -236,22 +237,235 @@ tls_crypt_ignore_replay(void **state) {
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
 }
 
+struct test_tls_crypt_v2_context {
+    struct gc_arena gc;
+    struct key2 server_key2;
+    struct key_ctx_bi server_keys;
+    struct key2 client_key2;
+    struct key_ctx_bi client_key;
+    struct buffer metadata;
+    struct buffer unwrapped_metadata;
+    struct buffer wkc;
+};
+
+static int
+test_tls_crypt_v2_setup(void **state) {
+    struct test_tls_crypt_v2_context *ctx = calloc(1, sizeof(*ctx));
+    *state = ctx;
+
+    ctx->gc = gc_new();
+
+    /* Sligthly longer buffers to be able to test too-long data */
+    ctx->metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN+16, &ctx->gc);
+    ctx->unwrapped_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN+16,
+                                           &ctx->gc);
+    ctx->wkc = alloc_buf_gc(TLS_CRYPT_V2_MAX_WKC_LEN+16, &ctx->gc);
+
+    /* Generate server key */
+    rand_bytes((void *)ctx->server_key2.keys, sizeof(ctx->server_key2.keys));
+    ctx->server_key2.n = 2;
+    struct key_type kt = tls_crypt_kt();
+    init_key_ctx_bi(&ctx->server_keys, &ctx->server_key2,
+                    KEY_DIRECTION_BIDIRECTIONAL, &kt,
+                    "tls-crypt-v2 server key");
+
+    /* Generate client key */
+    rand_bytes((void *)ctx->client_key2.keys, sizeof(ctx->client_key2.keys));
+    ctx->client_key2.n = 2;
+
+    return 0;
+}
+
+static int
+test_tls_crypt_v2_teardown(void **state) {
+    struct test_tls_crypt_v2_context *ctx =
+            (struct test_tls_crypt_v2_context *) *state;
+
+    free_key_ctx_bi(&ctx->server_keys);
+    free_key_ctx_bi(&ctx->client_key);
+
+    gc_free(&ctx->gc);
+
+    free(ctx);
+
+    return 0;
+}
+
+/**
+ * Check wrapping and unwrapping a tls-crypt-v2 client key without metadata.
+ */
+static void
+tls_crypt_v2_wrap_unwrap_no_metadata(void **state) {
+    struct test_tls_crypt_v2_context *ctx =
+            (struct test_tls_crypt_v2_context *) *state;
+
+    struct buffer wrapped_client_key = alloc_buf_gc(TLS_CRYPT_V2_MAX_WKC_LEN,
+                                                    &ctx->gc);
+    assert_true(tls_crypt_v2_wrap_client_key(&wrapped_client_key,
+                                             &ctx->client_key2,
+                                             &ctx->metadata,
+                                             &ctx->server_keys.encrypt,
+                                             &ctx->gc));
+
+    struct buffer unwrap_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN,
+                                                 &ctx->gc);
+    struct key2 unwrapped_client_key2 = { 0 };
+    assert_true(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2,
+                                               &unwrap_metadata,
+                                               wrapped_client_key,
+                                               &ctx->server_keys.decrypt));
+
+    assert_true(0 == memcmp(ctx->client_key2.keys, unwrapped_client_key2.keys,
+                            sizeof(ctx->client_key2.keys)));
+}
+
+/**
+ * Check wrapping and unwrapping a tls-crypt-v2 client key with maximum length
+ * metadata.
+ */
+static void
+tls_crypt_v2_wrap_unwrap_max_metadata(void **state) {
+    struct test_tls_crypt_v2_context *ctx =
+            (struct test_tls_crypt_v2_context *) *state;
+
+    uint8_t* metadata =
+            buf_write_alloc(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN);
+    assert_true(rand_bytes(metadata, TLS_CRYPT_V2_MAX_METADATA_LEN));
+    assert_true(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
+                                             &ctx->metadata,
+                                             &ctx->server_keys.encrypt,
+                                             &ctx->gc));
+
+    struct buffer unwrap_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN,
+                                                 &ctx->gc);
+    struct key2 unwrapped_client_key2 = { 0 };
+    assert_true(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2,
+                                               &unwrap_metadata, ctx->wkc,
+                                               &ctx->server_keys.decrypt));
+
+    assert_true(0 == memcmp(ctx->client_key2.keys, unwrapped_client_key2.keys,
+                            sizeof(ctx->client_key2.keys)));
+    assert_true(buf_equal(&ctx->metadata, &unwrap_metadata));
+}
+
+/**
+ * Check that wrapping a tls-crypt-v2 client key with too long metadata fails
+ * as expected.
+ */
+static void
+tls_crypt_v2_wrap_too_long_metadata(void **state) {
+    struct test_tls_crypt_v2_context *ctx =
+            (struct test_tls_crypt_v2_context *) *state;
+
+    assert_true(buf_inc_len(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN+1));
+    assert_false(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
+                                              &ctx->metadata,
+                                              &ctx->server_keys.encrypt,
+                                              &ctx->gc));
+}
+
+/**
+ * Check that unwrapping a tls-crypt-v2 client key with the wrong server key
+ * fails as expected.
+ */
+static void
+tls_crypt_v2_wrap_unwrap_wrong_key(void **state) {
+    struct test_tls_crypt_v2_context *ctx =
+            (struct test_tls_crypt_v2_context *) *state;
+
+    assert_true(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
+                                             &ctx->metadata,
+                                             &ctx->server_keys.encrypt,
+                                             &ctx->gc));
+
+    /* Change server key */
+    struct key_type kt = tls_crypt_kt();
+    free_key_ctx_bi(&ctx->server_keys);
+    memset(&ctx->server_key2.keys, 0, sizeof(ctx->server_key2.keys));
+    init_key_ctx_bi(&ctx->server_keys, &ctx->server_key2,
+                    KEY_DIRECTION_BIDIRECTIONAL, &kt,
+                    "wrong tls-crypt-v2 server key");
+
+
+    struct key2 unwrapped_client_key2 = { 0 };
+    assert_false(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2,
+                                                &ctx->unwrapped_metadata,
+                                                ctx->wkc,
+                                                &ctx->server_keys.decrypt));
+
+    const struct key2 zero = { 0 };
+    assert_true(0 == memcmp(&unwrapped_client_key2, &zero, sizeof(zero)));
+    assert_true(0 == BLEN(&ctx->unwrapped_metadata));
+}
+
+/**
+ * Check that unwrapping a tls-crypt-v2 client key to a too small metadata
+ * buffer fails as expected.
+ */
+static void
+tls_crypt_v2_wrap_unwrap_dst_too_small(void **state) {
+    struct test_tls_crypt_v2_context *ctx =
+            (struct test_tls_crypt_v2_context *) *state;
+
+    uint8_t* metadata =
+            buf_write_alloc(&ctx->metadata, TLS_CRYPT_V2_MAX_METADATA_LEN);
+    assert_true(rand_bytes(metadata, TLS_CRYPT_V2_MAX_METADATA_LEN));
+    assert_true(tls_crypt_v2_wrap_client_key(&ctx->wkc, &ctx->client_key2,
+                                             &ctx->metadata,
+                                             &ctx->server_keys.encrypt,
+                                             &ctx->gc));
+
+    struct key2 unwrapped_client_key2 = { 0 };
+    struct buffer unwrapped_metadata =
+            alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN-1, &ctx->gc);
+    assert_false(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2,
+                                                &unwrapped_metadata, ctx->wkc,
+                                                &ctx->server_keys.decrypt));
+
+    const struct key2 zero = { 0 };
+    assert_true(0 == memcmp(&unwrapped_client_key2, &zero, sizeof(zero)));
+    assert_true(0 == BLEN(&ctx->unwrapped_metadata));
+}
+
 int
 main(void) {
     const struct CMUnitTest tests[] = {
-        cmocka_unit_test_setup_teardown(tls_crypt_loopback, setup, teardown),
+        cmocka_unit_test_setup_teardown(tls_crypt_loopback,
+                                        test_tls_crypt_setup,
+                                        test_tls_crypt_teardown),
         cmocka_unit_test_setup_teardown(tls_crypt_loopback_zero_len,
-                                        setup, teardown),
+                                        test_tls_crypt_setup,
+                                        test_tls_crypt_teardown),
         cmocka_unit_test_setup_teardown(tls_crypt_loopback_max_len,
-                                        setup, teardown),
+                                        test_tls_crypt_setup,
+                                        test_tls_crypt_teardown),
         cmocka_unit_test_setup_teardown(tls_crypt_fail_msg_too_long,
-                                        setup, teardown),
+                                        test_tls_crypt_setup,
+                                        test_tls_crypt_teardown),
         cmocka_unit_test_setup_teardown(tls_crypt_fail_invalid_key,
-                                        setup, teardown),
+                                        test_tls_crypt_setup,
+                                        test_tls_crypt_teardown),
         cmocka_unit_test_setup_teardown(tls_crypt_fail_replay,
-                                        setup, teardown),
+                                        test_tls_crypt_setup,
+                                        test_tls_crypt_teardown),
         cmocka_unit_test_setup_teardown(tls_crypt_ignore_replay,
-                                        setup, teardown),
+                                        test_tls_crypt_setup,
+                                        test_tls_crypt_teardown),
+        cmocka_unit_test_setup_teardown(tls_crypt_v2_wrap_unwrap_no_metadata,
+                                        test_tls_crypt_v2_setup,
+                                        test_tls_crypt_v2_teardown),
+        cmocka_unit_test_setup_teardown(tls_crypt_v2_wrap_unwrap_max_metadata,
+                                        test_tls_crypt_v2_setup,
+                                        test_tls_crypt_v2_teardown),
+        cmocka_unit_test_setup_teardown(tls_crypt_v2_wrap_too_long_metadata,
+                                        test_tls_crypt_v2_setup,
+                                        test_tls_crypt_v2_teardown),
+        cmocka_unit_test_setup_teardown(tls_crypt_v2_wrap_unwrap_wrong_key,
+                                        test_tls_crypt_v2_setup,
+                                        test_tls_crypt_v2_teardown),
+        cmocka_unit_test_setup_teardown(tls_crypt_v2_wrap_unwrap_dst_too_small,
+                                        test_tls_crypt_v2_setup,
+                                        test_tls_crypt_v2_teardown),
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.7.4


