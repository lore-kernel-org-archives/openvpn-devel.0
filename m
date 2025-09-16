From: Gert Doering <gert@...1296...>
Date: Tue, 16 Sep 2025 17:52:50 +0200
Message-ID: <20250916155258.6864-1-gert@...1296...>
In-Reply-To: <gerrit.1757931374000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
References: <gerrit.1757931374000.I6752dcd5aff3e5cea2b439366479e86751a1c403@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Check message id/acked ids too when
 doing sessionid cookie checks
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

This fixes that control packets on a floating client can trigger
creating a new session in special circumstances:

To trigger this circumstance a connection needs to

- starts on IP A
- successfully floats to IP B by data packet
- then has a control packet from IP A before any
  data packet can trigger the float back to IP A

and all of this needs to happen in the 60s time
that hmac cookie is valid in the default
configuration.

In this scenario we would trigger a new connection as the HMAC
session id would be valid.

This patch adds checking also of the message-id and acked ids to
discern packet from the initial three-way handshake where these
ids are 0 or 1 from any later packet.

This will now trigger (at verb 4 or higher) a messaged like:

   Packet (P_ACK_V1) with invalid or missing SID

instead.

Also remove a few duplicated free_tls_pre_decrypt_state in test_ssl.

Reported-By: Walter Doekes <walter.openvpn@...2889...>
Tested-By: Walter Doekes <walter.openvpn@...2889...>

Change-Id: I6752dcd5aff3e5cea2b439366479e86751a1c403
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20250819212214.16218-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32626.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1184
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index cdde0b5..0492311 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -153,7 +153,8 @@
          * need to contain the peer id */
         struct gc_arena gc = gc_new();
 
-        bool ret = check_session_id_hmac(state, from, hmac, handwindow);
+        bool pkt_is_ack = (verdict == VERDICT_VALID_ACK_V1);
+        bool ret = check_session_hmac_and_pkt_id(state, from, hmac, handwindow, pkt_is_ack);
 
         const char *peer = print_link_socket_actual(&m->top.c2.from, &gc);
         uint8_t pkt_firstbyte = *BPTR( &m->top.c2.buf);
@@ -161,7 +162,8 @@
 
         if (!ret)
         {
-            msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or missing SID from %s",
+            msg(D_MULTI_MEDIUM, "Packet (%s) with invalid or missing SID from"
+                " %s or wrong packet id",
                 packet_opcode_name(op), peer);
         }
         else
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 41299f4..432bb8b 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -527,10 +527,11 @@
 }
 
 bool
-check_session_id_hmac(struct tls_pre_decrypt_state *state,
-                      const struct openvpn_sockaddr *from,
-                      hmac_ctx_t *hmac,
-                      int handwindow)
+check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
+                              const struct openvpn_sockaddr *from,
+                              hmac_ctx_t *hmac,
+                              int handwindow,
+                              bool pkt_is_ack)
 {
     if (!from)
     {
@@ -545,6 +546,36 @@
         return false;
     }
 
+    /* Check if the packet ID of the packet or ACKED packet  is <= 1 */
+    for (int i = 0; i < ack.len; i++)
+    {
+        /* This packet ACKs a packet that has a higher packet id than the
+         * ones expected in the three-way handshake, consider it as invalid
+         * for the session */
+        if (ack.packet_id[i] > 1)
+        {
+            return false;
+        }
+    }
+
+    if (!pkt_is_ack)
+    {
+        packet_id_type message_id;
+        /* Extract the packet ID from the packet */
+        if (!reliable_ack_read_packet_id(&buf, &message_id))
+        {
+            return false;
+        }
+
+        /* similar check. Anything larger than 1 is not considered part of the
+         * three-way handshake */
+        if (message_id > 1)
+        {
+            return false;
+        }
+    }
+
+
     /* check adjacent timestamps too */
     for (int offset = -2; offset <= 1; offset++)
     {
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 2033da6..1df691c 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -182,17 +182,20 @@
 /**
  * Checks if a control packet has a correct HMAC server session id
  *
- * @param client_sid    session id of the client
+ * This will also consider packets that have a packet id higher
+ * than 1 or ack packets higher than 1 to be invalid as they are
+ * not part of the initial three way handshake of OpenVPN and should
+ * not create a new connection.
+ *
+ * @param state         session information
  * @param from          link_socket from the client
  * @param hmac          the hmac context to use for the calculation
  * @param handwindow    the quantisation of the current time
+ * @param pkt_is_ack    the packet being checked is a P_ACK_V1
  * @return              the expected server session id
  */
-bool
-check_session_id_hmac(struct tls_pre_decrypt_state *state,
-                      const struct openvpn_sockaddr *from,
-                      hmac_ctx_t *hmac,
-                      int handwindow);
+bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *from,
+                                   hmac_ctx_t *hmac, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a control channel authentication record.
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 74d7311..27f52cf 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -174,6 +174,27 @@
     0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
 };
 
+/* no tls-auth, P_ACK_V1, acks 0,1, and 2 */
+const uint8_t client_ack_123_none_random_id[] = {
+    0x28,
+    0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,
+    0x03,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x01,
+    0x00, 0x00, 0x00, 0x02,
+    0xdd, 0x85, 0xdb, 0x53, 0x56, 0x23, 0xb0, 0x2e
+};
+
+/* no tls-auth, P_CONTROL_V1, acks 0, msg-id 2 */
+const uint8_t client_control_none_random_id[] = {
+    0x20,
+    0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8,
+    0x01,
+    0x00, 0x00, 0x00, 0x00,
+    0x02
+};
+
+
 struct tls_auth_standalone
 init_tas_auth(int key_direction)
 {
@@ -294,12 +315,10 @@
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);
 
-    free_tls_pre_decrypt_state(&state);
     /* The pre decrypt function should not modify the buffer, so calling it
      * again should have the same result */
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
-    free_tls_pre_decrypt_state(&state);
 
     /* and buf memory should be equal */
     assert_memory_equal(BPTR(&buf), client_reset_v2_tls_auth, sizeof(client_reset_v2_tls_auth));
@@ -317,7 +336,6 @@
     assert_int_equal(verdict, VERDICT_INVALID);
     free_tls_pre_decrypt_state(&state);
 
-    free_tls_pre_decrypt_state(&state);
     /* Wrong key direction gives a wrong hmac key and should not validate */
     free_key_ctx_bi(&tas.tls_wrap.opt.key_ctx_bi);
     free_tas(&tas);
@@ -357,15 +375,12 @@
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);
 
-    free_tls_pre_decrypt_state(&state);
     buf_reset_len(&buf);
     buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_none));
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
     free_tls_pre_decrypt_state(&state);
 
-    free_tls_pre_decrypt_state(&state);
-
     /* This is not a reset packet and should trigger the other response */
     buf_reset_len(&buf);
     buf_write(&buf, client_ack_tls_auth_randomid, sizeof(client_ack_tls_auth_randomid));
@@ -443,7 +458,7 @@
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
 
     /* This is a valid packet but containing a random id instead of an HMAC id*/
-    bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, false);
     assert_false(valid);
 
     free_tls_pre_decrypt_state(&state);
@@ -474,7 +489,7 @@
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
-    bool valid = check_session_id_hmac(&state, &from.dest, hmac, 30);
+    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
     assert_true(valid);
 
     free_tls_pre_decrypt_state(&state);
@@ -483,6 +498,51 @@
     hmac_ctx_free(hmac);
 }
 
+static void
+test_verify_hmac_none_out_of_range_ack(void **ut_state)
+{
+    hmac_ctx_t *hmac = session_id_hmac_init();
+
+    struct link_socket_actual from = { 0 };
+    from.dest.addr.sa.sa_family = AF_INET;
+
+    struct tls_auth_standalone tas = { 0 };
+    struct tls_pre_decrypt_state state = { 0 };
+
+    struct buffer buf = alloc_buf(1024);
+    enum first_packet_verdict verdict;
+
+    tas.tls_wrap.mode = TLS_WRAP_NONE;
+
+    buf_reset_len(&buf);
+    buf_write(&buf, client_ack_123_none_random_id, sizeof(client_ack_123_none_random_id));
+
+
+    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
+
+    /* should fail because it acks 2 */
+    bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+    assert_false(valid);
+    free_tls_pre_decrypt_state(&state);
+
+    /* Try test with the control with a too high message id now */
+    buf_reset_len(&buf);
+    buf_write(&buf, client_control_none_random_id, sizeof(client_control_none_random_id));
+
+    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
+
+    /* should fail because it has message id 2 */
+    valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+    assert_false(valid);
+
+    free_tls_pre_decrypt_state(&state);
+    free_buf(&buf);
+    hmac_ctx_cleanup(hmac);
+    hmac_ctx_free(hmac);
+}
+
 static hmac_ctx_t *
 init_static_hmac(void)
 {
@@ -670,6 +730,7 @@
         cmocka_unit_test(test_calc_session_id_hmac_static),
         cmocka_unit_test(test_verify_hmac_none),
         cmocka_unit_test(test_verify_hmac_tls_auth),
+        cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(test_extract_control_message)

