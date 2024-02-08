From: Gert Doering <gert@...1296...>
Date: Thu,  8 Feb 2024 09:57:49 +0100
Message-ID: <20240208085749.869-1-gert@...1296...>
In-Reply-To: <gerrit.1705939439000.Ifa5ae96165d17b3cae4afc53e844bb34d1610e58@...2715...>
References: <gerrit.1705939439000.Ifa5ae96165d17b3cae4afc53e844bb34d1610e58@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add unit test for encrypting/decrypting
 data channel
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

From: Arne Schwabe <arne@...1227...>

This test is reusing code from --test-crypto but is modified to not rely
on the static key functionality and also only tests the most common
algorithm. So it does not yet completely replace --test-crypto

Change-Id: Ifa5ae96165d17b3cae4afc53e844bb34d1610e58
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/505
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 18b9ec8..8c1fb5b 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -44,6 +44,9 @@
 #include "ssl_verify_backend.h"
 #include "win32.h"
 #include "test_common.h"
+#include "ssl.h"
+#include "buffer.h"
+#include "packet_id.h"
 
 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
@@ -120,20 +123,238 @@
     gc_free(&gc);
 }
 
+static void
+init_implicit_iv(struct crypto_options *co)
+{
+    cipher_ctx_t *cipher = co->key_ctx_bi.encrypt.cipher;
+
+    if (cipher_ctx_mode_aead(cipher))
+    {
+        size_t impl_iv_len = cipher_ctx_iv_length(cipher) - sizeof(packet_id_type);
+        ASSERT(cipher_ctx_iv_length(cipher) <= OPENVPN_MAX_IV_LENGTH);
+        ASSERT(cipher_ctx_iv_length(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
+
+        /* Generate dummy implicit IV */
+        ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
+                          OPENVPN_MAX_IV_LENGTH));
+        co->key_ctx_bi.encrypt.implicit_iv_len = impl_iv_len;
+
+        memcpy(co->key_ctx_bi.decrypt.implicit_iv,
+               co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
+        co->key_ctx_bi.decrypt.implicit_iv_len = impl_iv_len;
+    }
+}
+
+static void
+init_frame_parameters(struct frame *frame)
+{
+    int overhead = 0;
+
+    /* tls-auth and tls-crypt */
+    overhead += 128;
+
+    /* TCP length field and opcode */
+    overhead += 3;
+
+    /* ACK array and remote SESSION ID (part of the ACK array) */
+    overhead += ACK_SIZE(RELIABLE_ACK_SIZE);
+
+    /* Previous OpenVPN version calculated the maximum size and buffer of a
+     * control frame depending on the overhead of the data channel frame
+     * overhead and limited its maximum size to 1250. Since control frames
+     * also need to fit into data channel buffer we have the same
+     * default of 1500 + 100 as data channel buffers have. Increasing
+     * control channel mtu beyond this limit also increases the data channel
+     * buffers */
+    int tls_mtu = 1500;
+    frame->buf.payload_size = tls_mtu + 100;
+
+    frame->buf.headroom = overhead;
+    frame->buf.tailroom = overhead;
+
+    frame->tun_mtu = tls_mtu;
+
+}
+
+static void
+do_data_channel_round_trip(struct crypto_options *co)
+{
+    struct gc_arena gc = gc_new();
+
+    /* initialise frame for the test */
+    struct frame frame;
+    init_frame_parameters(&frame);
+
+    struct buffer src = alloc_buf_gc(frame.buf.payload_size, &gc);
+    struct buffer work = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer buf = clear_buf();
+    void *buf_p;
+
+    /* init work */
+    ASSERT(buf_init(&work, frame.buf.headroom));
+
+    init_implicit_iv(co);
+    update_time();
+
+    /* Test encryption, decryption for all packet sizes */
+    for (int i = 1; i <= frame.buf.payload_size; ++i)
+    {
+
+        /* msg(M_INFO, "TESTING ENCRYPT/DECRYPT of packet length=%d", i); */
+
+        /*
+         * Load src with random data.
+         */
+        ASSERT(buf_init(&src, 0));
+        ASSERT(i <= src.capacity);
+        src.len = i;
+        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+
+        /* copy source to input buf */
+        buf = work;
+        buf_p = buf_write_alloc(&buf, BLEN(&src));
+        ASSERT(buf_p);
+        memcpy(buf_p, BPTR(&src), BLEN(&src));
+
+        /* initialize work buffer with buf.headroom bytes of prepend capacity */
+        ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
+
+        /* encrypt */
+        openvpn_encrypt(&buf, encrypt_workspace, co);
+
+        /* decrypt */
+        openvpn_decrypt(&buf, decrypt_workspace, co, &frame, BPTR(&buf));
+
+        /* compare */
+        assert_int_equal(buf.len, src.len);
+        assert_memory_equal(BPTR(&src), BPTR(&buf), i);
+
+    }
+    gc_free(&gc);
+}
+
+
+
+struct crypto_options
+init_crypto_options(const char *cipher, const char *auth)
+{
+    struct key2 key2 = { .n = 2};
+
+    ASSERT(rand_bytes(key2.keys[0].cipher, sizeof(key2.keys[0].cipher)));
+    ASSERT(rand_bytes(key2.keys[0].hmac, sizeof(key2.keys[0].hmac)));
+    ASSERT(rand_bytes(key2.keys[1].cipher, sizeof(key2.keys[1].cipher)));
+    ASSERT(rand_bytes(key2.keys[1].hmac, sizeof(key2.keys)[1].hmac));
+
+    struct crypto_options co = { 0 };
+
+    struct key_type kt = create_kt(cipher, auth, "ssl-test");
+
+    init_key_ctx_bi(&co.key_ctx_bi, &key2, 0, &kt, "unit-test-ssl");
+    packet_id_init(&co.packet_id,  5, 5, "UNITTEST", 0);
+
+    return co;
+}
+
+static void
+uninit_crypto_options(struct crypto_options *co)
+{
+    packet_id_free(&co->packet_id);
+    free_key_ctx_bi(&co->key_ctx_bi);
+
+}
+
+
+static void
+run_data_channel_with_cipher(const char *cipher, const char *auth)
+{
+    struct crypto_options co = init_crypto_options(cipher, auth);
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
+static void
+test_data_channel_roundtrip_aes_128_gcm(void **state)
+{
+    run_data_channel_with_cipher("AES-128-GCM", "none");
+}
+
+static void
+test_data_channel_roundtrip_aes_192_gcm(void **state)
+{
+    run_data_channel_with_cipher("AES-192-GCM", "none");
+}
+
+static void
+test_data_channel_roundtrip_aes_256_gcm(void **state)
+{
+    run_data_channel_with_cipher("AES-256-GCM", "none");
+}
+
+static void
+test_data_channel_roundtrip_aes_128_cbc(void **state)
+{
+    run_data_channel_with_cipher("AES-128-CBC", "SHA256");
+}
+
+static void
+test_data_channel_roundtrip_aes_192_cbc(void **state)
+{
+    run_data_channel_with_cipher("AES-192-CBC", "SHA256");
+}
+
+static void
+test_data_channel_roundtrip_aes_256_cbc(void **state)
+{
+    run_data_channel_with_cipher("AES-256-CBC", "SHA256");
+}
+
+static void
+test_data_channel_roundtrip_chacha20_poly1305(void **state)
+{
+    if (!cipher_valid("ChaCha20-Poly1305"))
+    {
+        skip();
+        return;
+    }
+    run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
+}
+
+static void
+test_data_channel_roundtrip_bf_cbc(void **state)
+{
+    if (!cipher_valid("BF-CBC"))
+    {
+        skip();
+        return;
+    }
+    run_data_channel_with_cipher("BF-CBC", "SHA1");
+}
+
+
 int
 main(void)
 {
     openvpn_unit_test_setup();
 
     const struct CMUnitTest tests[] = {
-        cmocka_unit_test(crypto_pem_encode_certificate)
+        cmocka_unit_test(crypto_pem_encode_certificate),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),
+        cmocka_unit_test(test_data_channel_roundtrip_chacha20_poly1305),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_128_cbc),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_192_cbc),
+        cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
+        cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
     tls_init_lib();
 #endif
 
-    int ret = cmocka_run_group_tests_name("crypto tests", tests, NULL, NULL);
+    int ret = cmocka_run_group_tests_name("ssl tests", tests, NULL, NULL);
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
     tls_free_lib();

