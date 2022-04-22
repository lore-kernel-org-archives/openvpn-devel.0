From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:42 +0200
Message-Id: <20220422142953.3805364-8-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 17/28] Implement constructing a control
 channel reset client as standalone fucntion
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

This implement creating a reset packet without needing to setup a full control
session.
---
 src/openvpn/packet_id.h             | 15 ++++++
 src/openvpn/ssl.h                   |  6 ---
 src/openvpn/ssl_pkt.c               | 34 +++++++++++-
 src/openvpn/ssl_pkt.h               | 19 +++++++
 tests/unit_tests/openvpn/test_pkt.c | 84 ++++++++++++++++++++++++++++-
 5 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 410071e26..e5ffd485c 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -289,6 +289,21 @@ packet_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id *
     }
 }
 
+/**
+ * Reset the current send packet id to its initial state.
+ * Use very carefully only as (e.g. in the standalone reset packet context)
+ * to avoid sending more than one packet with the same packet id (that is not
+ * also a resend like the reset packet)
+ *
+ * @param p the packet structure to modify
+ */
+static inline void
+reset_packet_id_send(struct packet_id_send *p)
+{
+    p->time = 0;
+    p->id = 0;
+}
+
 const char *packet_id_net_print(const struct packet_id_net *pin, bool print_timestamp, struct gc_arena *gc);
 
 static inline int
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index d718aa27b..3a65bad6a 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -53,12 +53,6 @@
  */
 #define CONTROL_SEND_ACK_MAX 4
 
-/*
- * Define number of buffers for send and receive in the reliability layer.
- */
-#define TLS_RELIABLE_N_SEND_BUFFERS  4 /* also window size for reliability layer */
-#define TLS_RELIABLE_N_REC_BUFFERS   8
-
 /*
  * Various timeouts
  */
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 86c1f0e29..927ee35aa 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -397,4 +397,36 @@ error:
     tls_clear_error();
     gc_free(&gc);
     return VERDICT_INVALID;
-}
\ No newline at end of file
+}
+
+struct buffer
+tls_reset_standalone(struct tls_auth_standalone *tas,
+                     struct session_id *own_sid,
+                     struct session_id *remote_sid,
+                     uint8_t header)
+{
+    struct buffer buf = alloc_buf(tas->frame.buf.payload_size);
+    ASSERT(buf_init(&buf, tas->frame.buf.headroom));
+
+    /* Reliable ACK structure */
+    /* Length of the ACK structure - 1 ACK */
+    buf_write_u8(&buf, 1);
+
+    /* ACKed packet - first packet's id is always 0 */
+    buf_write_u32(&buf, 0);
+
+    /* Remote session id */
+    buf_write(&buf, remote_sid->id, SID_SIZE);
+
+    /* Packet ID of our own packet: Our reset packet is always using
+     * packet id 0 since it is the first packet */
+    packet_id_type net_pid = htonpid(0);
+
+    ASSERT(buf_write(&buf, &net_pid, sizeof(net_pid)));
+    
+    /* Add tls-auth/tls-crypt wrapping, this might replace buf */
+    tls_wrap_control(&tas->tls_wrap, header, &buf, own_sid);
+
+    return buf;
+}
+
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index b7a8d9c35..1a327eba6 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -60,6 +60,12 @@
 #define P_FIRST_OPCODE                 3
 #define P_LAST_OPCODE                  10
 
+/*
+ * Define number of buffers for send and receive in the reliability layer.
+ */
+#define TLS_RELIABLE_N_SEND_BUFFERS  4 /* also window size for reliability layer */
+#define TLS_RELIABLE_N_REC_BUFFERS   8
+
 /*
  * Used in --mode server mode to check tls-auth signature on initial
  * packets received from new clients.
@@ -157,6 +163,19 @@ read_control_auth(struct buffer *buf,
                   const struct link_socket_actual *from,
                   const struct tls_options *opt);
 
+
+/**
+ * This function creates a reset packet using the information
+ * from the tls pre decrypt state.
+ *
+ * The returned buf need to be free with \c free_buf
+ */
+struct buffer
+tls_reset_standalone(struct tls_auth_standalone *tas,
+                     struct session_id *own_sid,
+                     struct session_id *remote_sid,
+                         uint8_t header);
+
 static inline const char *
 packet_opcode_name(int op)
 {
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 022e15d3e..95ff13b5a 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -156,7 +156,7 @@ struct tls_auth_standalone init_tas_auth(int key_direction)
 
     tas.tls_wrap.mode = TLS_WRAP_AUTH;
     /* we ignore packet ids on for the first packet check */
-    tas.tls_wrap.opt.flags |= CO_IGNORE_PACKET_ID;
+    tas.tls_wrap.opt.flags |= (CO_IGNORE_PACKET_ID|CO_PACKET_ID_LONG_FORM);
 
     struct key_type tls_crypt_kt;
     init_key_type(&tls_crypt_kt, "none", "SHA1", true, false);
@@ -171,7 +171,7 @@ struct tls_auth_standalone init_tas_crypt(bool server)
 {
     struct tls_auth_standalone tas = { 0 };
     tas.tls_wrap.mode = TLS_WRAP_CRYPT;
-    tas.tls_wrap.opt.flags |= CO_IGNORE_PACKET_ID;
+    tas.tls_wrap.opt.flags |= (CO_IGNORE_PACKET_ID|CO_PACKET_ID_LONG_FORM);
 
     tls_crypt_init_key(&tas.tls_wrap.opt.key_ctx_bi, static_key, true, server);
 
@@ -324,6 +324,84 @@ test_tls_decrypt_lite_none(void **ut_state)
     free_buf(&buf);
 }
 
+static void
+test_generate_reset_packet_plain(void **ut_state)
+{
+    struct link_socket_actual from = { 0 };
+    struct tls_auth_standalone tas = { 0 };
+    struct tls_pre_decrypt_state state = { 0 };
+
+    struct session_id client_id = {{0, 1, 2, 3, 4, 5, 6, 7}};
+    struct session_id server_id = {{8, 9, 0, 9, 8, 7, 6, 2}};
+
+    enum first_packet_verdict verdict;
+
+    tas.tls_wrap.mode = TLS_WRAP_NONE;
+    struct frame frame = { {.headroom = 200, .payload_size = 1400}, 0};
+    tas.frame = frame;
+
+    uint8_t header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT);
+
+    struct buffer buf = tls_reset_standalone(&tas, &client_id, &server_id, header);
+
+
+    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_RESET);
+
+    /* Assure repeated generation of reset is deterministic/stateless*/
+    assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
+    struct buffer buf2 = tls_reset_standalone(&tas, &client_id, &server_id, header);
+    assert_int_equal(BLEN(&buf), BLEN(&buf2));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    free_buf(&buf2);
+
+    free_tls_pre_decrypt_state(&state);
+    free_buf(&buf);
+}
+
+static void
+test_generate_reset_packet_tls_auth(void **ut_state)
+{
+    struct link_socket_actual from = { 0 };
+    struct tls_pre_decrypt_state state = { 0 };
+
+    struct tls_auth_standalone tas_server = init_tas_auth(KEY_DIRECTION_NORMAL);
+    struct tls_auth_standalone tas_client = init_tas_auth(KEY_DIRECTION_INVERSE);
+
+    packet_id_init(&tas_client.tls_wrap.opt.packet_id, 5, 5, "UNITTEST", 0);
+
+    struct session_id client_id = {{0xab, 1, 2, 3, 4, 5, 6, 0xcd}};
+    struct session_id server_id = {{8, 9, 0xa, 0xc, 8, 7, 6, 2}};
+
+    uint8_t header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT);
+
+    now = 0x22446688;
+    reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
+    struct buffer buf = tls_reset_standalone(&tas_client, &client_id, &server_id, header);
+
+    enum first_packet_verdict verdict = tls_pre_decrypt_lite(&tas_server, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_RESET);
+
+    assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
+
+    /* Assure repeated generation of reset is deterministic/stateless*/
+    reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
+    struct buffer buf2 = tls_reset_standalone(&tas_client, &client_id, &server_id, header);
+    assert_int_equal(BLEN(&buf), BLEN(&buf2));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    free_buf(&buf2);
+
+
+    free_tls_pre_decrypt_state(&state);
+
+    packet_id_free(&tas_client.tls_wrap.opt.packet_id);
+
+    free_buf(&buf);
+    free_key_ctx_bi(&tas_server.tls_wrap.opt.key_ctx_bi);
+    free_key_ctx_bi(&tas_client.tls_wrap.opt.key_ctx_bi);
+
+}
+
 int
 main(void)
 {
@@ -331,6 +409,8 @@ main(void)
         cmocka_unit_test(test_tls_decrypt_lite_none),
         cmocka_unit_test(test_tls_decrypt_lite_auth),
         cmocka_unit_test(test_tls_decrypt_lite_crypt),
+        cmocka_unit_test(test_generate_reset_packet_plain),
+        cmocka_unit_test(test_generate_reset_packet_tls_auth),
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)
-- 
2.32.0 (Apple Git-132)


