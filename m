From: Gert Doering <gert@...1296...>
Date: Thu, 13 Feb 2025 20:39:41 +0100
Message-ID: <20250213193942.26423-1-gert@...1296...>
In-Reply-To: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
References: <gerrit.1737027245000.I15c7cfdddb06d4530d669b222a3c65db5169b29a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Extend the unit test for data channel
 packets with aead limit tests
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

Change-Id: I15c7cfdddb06d4530d669b222a3c65db5169b29a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/868
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 486e298..9340953 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -363,14 +363,107 @@
         /* compare */
         assert_int_equal(buf.len, src.len);
         assert_memory_equal(BPTR(&src), BPTR(&buf), i);
-
     }
     gc_free(&gc);
 }
 
+static void
+encrypt_one_packet(struct crypto_options *co, int len)
+{
+    struct frame frame;
+    init_frame_parameters(&frame);
+
+    struct gc_arena gc = gc_new();
+    struct buffer encrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer decrypt_workspace = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer work = alloc_buf_gc(BUF_SIZE(&frame), &gc);
+    struct buffer buf = clear_buf();
+    struct buffer src = alloc_buf_gc(frame.buf.payload_size, &gc);
+    void *buf_p;
+
+    ASSERT(buf_init(&work, frame.buf.headroom));
+
+    /*
+     * Load src with random data.
+     */
+    ASSERT(buf_init(&src, 0));
+    ASSERT(len <= src.capacity);
+    src.len = len;
+    ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+
+    /* copy source to input buf */
+    buf = work;
+    buf_p = buf_write_alloc(&buf, BLEN(&src));
+    ASSERT(buf_p);
+    memcpy(buf_p, BPTR(&src), BLEN(&src));
+
+    ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
+    openvpn_encrypt(&buf, encrypt_workspace, co);
+
+    /* decrypt */
+    openvpn_decrypt(&buf, decrypt_workspace, co, &frame, BPTR(&buf));
+
+    /* compare */
+    assert_int_equal(buf.len, src.len);
+    assert_memory_equal(BPTR(&src), BPTR(&buf), len);
+
+    gc_free(&gc);
+}
 
 
-struct crypto_options
+static void
+check_aead_limits(struct crypto_options *co, bool chachapoly)
+{
+
+    /* Check that we correctly react when we have a nearing AEAD limits */
+
+    /* manually increase the send counter to be past
+     * the GCM usage limit */
+    co->key_ctx_bi.encrypt.plaintext_blocks = 0x1ull << 40;
+
+
+    bool epoch = (co->flags & CO_EPOCH_DATA_KEY_FORMAT);
+
+    int expected_epoch = epoch ? 4 : 0;
+
+    /* Ensure that we are still on the initial key (our init_crypto_options
+     * unit test method iterates the initial key to 4) or that it is 0 when
+     * epoch is not in * use */
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, expected_epoch);
+
+    encrypt_one_packet(co, 1000);
+
+    /* either epoch key has been updated or warning is enabled */
+    if (epoch && !chachapoly)
+    {
+        expected_epoch++;
+    }
+
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, expected_epoch);
+
+    if (!epoch)
+    {
+        /* Check always against the GCM usage limit here to see if that
+         * check works */
+        assert_true(aead_usage_limit_reached((1ull << 36),
+                                             &co->key_ctx_bi.encrypt,
+                                             co->packet_id.send.id));
+        return;
+    }
+
+    /* Move to the end of the epoch data key send PID range, ChachaPoly
+     * should now also move to a new epoch data key */
+    co->packet_id.send.id = PACKET_ID_EPOCH_MAX;
+
+    encrypt_one_packet(co, 1000);
+    encrypt_one_packet(co, 1000);
+
+    expected_epoch++;
+    assert_int_equal(co->key_ctx_bi.encrypt.epoch, expected_epoch);
+}
+
+
+static struct crypto_options
 init_crypto_options(const char *cipher, const char *auth, bool epoch,
                     struct key2 *statickey)
 {
@@ -428,16 +521,21 @@
 static void
 run_data_channel_with_cipher_epoch(const char *cipher)
 {
+    bool ischacha = !strcmp(cipher, "ChaCha20-Poly1305");
+
     struct crypto_options co = init_crypto_options(cipher, "none", true, NULL);
     do_data_channel_round_trip(&co);
+    check_aead_limits(&co, ischacha);
     uninit_crypto_options(&co);
 }
 
 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
+    bool ischacha = !strcmp(cipher, "ChaCha20-Poly1305");
     struct crypto_options co = init_crypto_options(cipher, auth, false, NULL);
     do_data_channel_round_trip(&co);
+    check_aead_limits(&co, ischacha);
     uninit_crypto_options(&co);
 }
 

