From: Gert Doering <gert@...1296...>
Date: Mon, 17 Nov 2025 18:28:59 +0100
Message-ID: <20251117173843.10091-3-gert@...1296...>
In-Reply-To: <20251117173843.10091-1-gert@...1296...>
References: <20251117173843.10091-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Fix memcmp check for the hmac
 verification in the 3way handshake being inverted
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

This is a stupid mistake but causes all hmac cookies to be accepted,
thus breaking source IP address validation.   As a consequence, TLS
sessions can be openend and state can be consumed in the server from
IP addresses that did not initiate an initial connection.

While at it, fix check to only allow [t-2;t] timeslots, disallowing
HMACs coming in from a future timeslot.

Github: OpenVPN/openvpn-private-issues#56

CVE: 2025-13086

Reported-By: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Reported-By: stefan@...2953...

Change-Id: I9cbe2bf535575b47ddd7f34e985c5c1c6953a6fc
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Max Fillinger <max@...2606...>
---
 src/openvpn/ssl_pkt.c               |  7 ++--
 tests/unit_tests/openvpn/test_pkt.c | 58 ++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index f216e88b..85a55b15 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -548,13 +548,14 @@ check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
     }
 
 
-    /* check adjacent timestamps too */
-    for (int offset = -2; offset <= 1; offset++)
+    /* check adjacent timestamps too, the handwindow is split in 2 for the
+     * offset, so we check the current timeslot and the two before that */
+    for (int offset = -2; offset <= 0; offset++)
     {
         struct session_id expected_id =
             calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, offset);
 
-        if (memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE))
+        if (memcmp_constant_time(&expected_id, &state->server_session_id, SID_SIZE) == 0)
         {
             return true;
         }
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 1423d469..c2aff8c6 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -406,6 +406,8 @@ test_verify_hmac_tls_auth(void **ut_state)
     hmac_ctx_t *hmac = session_id_hmac_init();
 
     struct link_socket_actual from = { 0 };
+    from.dest.addr.sa.sa_family = AF_INET;
+    from.dest.addr.in4.sin_addr.s_addr = ntohl(0x01020304);
     struct tls_auth_standalone tas = { 0 };
     struct tls_pre_decrypt_state state = { 0 };
 
@@ -433,10 +435,12 @@ test_verify_hmac_tls_auth(void **ut_state)
 static void
 test_verify_hmac_none(void **ut_state)
 {
+    now = 1000;
     hmac_ctx_t *hmac = session_id_hmac_init();
 
     struct link_socket_actual from = { 0 };
     from.dest.addr.sa.sa_family = AF_INET;
+    from.dest.addr.in4.sin_addr.s_addr = ntohl(0x01020304);
 
     struct tls_auth_standalone tas = { 0 };
     struct tls_pre_decrypt_state state = { 0 };
@@ -451,9 +455,61 @@ test_verify_hmac_none(void **ut_state)
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
+    /* This packet has a random hmac, so it should fail to validate */
     bool valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+    assert_false(valid);
+
+    struct session_id client_id = { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } };
+    assert_memory_equal(&client_id, &state.peer_session_id, sizeof(struct session_id));
+
+    struct session_id expected_id = calculate_session_id_hmac(client_id, &from.dest, hmac, 30, 0);
+
+    free_tls_pre_decrypt_state(&state);
+    buf_reset_len(&buf);
+
+    /* Write the packet again into the buffer but this time, replacing the peer packet
+     * id with the expected one */
+    buf_write(&buf, client_ack_none_random_id, sizeof(client_ack_none_random_id) - 8);
+    buf_write(&buf, expected_id.id, 8);
+
+    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
+    valid = check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true);
+
     assert_true(valid);
 
+    /* Our handwindow is 30 so the slices are half of that, so they are
+     * (975,990), (990, 1005), (1005, 1020), (1020, 1035), (1035, 1050)
+     * So setting time to the two future ones should work
+     */
+    now = 980;
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    now = 1040;
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    now = 1002;
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    now = 1022;
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+    now = 1010;
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+
+    /* Changing the IP address should make this invalid */
+    from.dest.addr.in4.sin_addr.s_addr = ntohl(0x01020305);
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+
+    /* Change to the correct one again */
+    from.dest.addr.in4.sin_addr.s_addr = ntohl(0x01020304);
+    assert_true(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+
+    /* Modify the peer id, should now fail hmac verification */
+    buf_inc_len(&buf, -4);
+    buf_write_u32(&buf, 0x12345678);
+
+    free_tls_pre_decrypt_state(&state);
+    verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
+    assert_false(check_session_hmac_and_pkt_id(&state, &from.dest, hmac, 30, true));
+
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
     hmac_ctx_cleanup(hmac);
@@ -696,12 +752,12 @@ main(void)
     openvpn_unit_test_setup();
 
     const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_verify_hmac_none),
         cmocka_unit_test(test_tls_decrypt_lite_none),
         cmocka_unit_test(test_tls_decrypt_lite_auth),
         cmocka_unit_test(test_tls_decrypt_lite_crypt),
         cmocka_unit_test(test_parse_ack),
         cmocka_unit_test(test_calc_session_id_hmac_static),
-        cmocka_unit_test(test_verify_hmac_none),
         cmocka_unit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
-- 
2.51.2


