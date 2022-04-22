From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:48 +0200
Message-Id: <20220422142953.3805364-14-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 23/28] Optimise three-way handshake
 condition for S_PRE_START to S_START
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

We move to the S_START when we have finished the three-way handshake. After
the three way handshake is done, the client will send the TLS Client Hello
packet.

Currently we consider the three way handshake only complete if all
outgoing packet have been acked (which in this case is the one
HARD_RESET_CLIENT or HARD_RESET_SERVER) and also all akcs for incoming
packets are send out.

The outgoing packet ack is important as it signal that the other side is
really responding. The need to send out all ACKs before moving to the next
state also breaks piggybacking the ACKs onto the next control packet.

With this change both server and client will only send a P_CONTROL_V1 with
the TLS Client Hello and the TLS Server Hello with piggybacked ack instead
sending an P_ACK_V1 + P_CONTROL_V1, recuding the number of packets in a
handshake by 2.

This also allows the server to avoid resending P_CONTROL_HARD_RESET_V2
to complete the three-way handshake with HMAC. Only packets with
an ACK contain the remote session id that we need for HMAC session id
verification. The ACK_V1 packet that complets this three-way handshake
can get lost. But the P_CONTROL_V1 with the piggybacked ACK will get
retransmitted. This allows to put the burden of retransmission fully on
the client.

The S_GOT_KEY/S_SENT_KEY -> S_ACTIVE is similar. We do not need to wait
for the ack packet to be sent to move the state forward. This has however
no effect on actual packets since there are normally no outstanding ACKs
here.
---
 src/openvpn/ssl.c                   | 15 +++++----------
 tests/unit_tests/openvpn/test_pkt.c |  8 ++++----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5e1a23ccd..e3101c7fa 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1796,13 +1796,6 @@ flush_payload_buffer(struct key_state *ks)
     }
 }
 
-/* true if no in/out acknowledgements pending */
-static bool
-no_pending_reliable_packets(struct key_state *ks)
-{
-    return (reliable_empty(ks->send_reliable) && reliable_ack_empty(ks->rec_ack));
-}
-
 /*
  * Move the active key to the lame duck key and reinitialize the
  * active key.
@@ -2646,8 +2639,10 @@ tls_process_state(struct tls_multi *multi,
         goto error;
     }
 
-    /* Wait for Initial Handshake ACK */
-    if (ks->state == S_PRE_START && no_pending_reliable_packets(ks))
+    /* Check if the initial three-way Handshake is complete.
+     * This handshake can be considered to be complete when our own
+     * initial packet can been successfully acked. */
+    if (ks->state == S_PRE_START && reliable_empty(ks->send_reliable))
     {
         ks->state = S_START;
         state_change = true;
@@ -2660,7 +2655,7 @@ tls_process_state(struct tls_multi *multi,
     /* Wait for ACK */
     if (((ks->state == S_GOT_KEY && !session->opt->server)
          || (ks->state == S_SENT_KEY && session->opt->server))
-        && no_pending_reliable_packets(ks))
+        && reliable_empty(ks->send_reliable))
     {
         session_move_active(multi, session, to_link_socket_info, ks);
         state_change = true;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 184b88383..d525def3c 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -531,7 +531,7 @@ test_generate_reset_packet_plain(void **ut_state)
 
     uint8_t header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT);
 
-    struct buffer buf = tls_reset_standalone(&tas, &client_id, &server_id, header, 0, 0);
+    struct buffer buf = tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, header, false);
 
 
     verdict = tls_pre_decrypt_lite(&tas, &state, &from, &buf);
@@ -539,7 +539,7 @@ test_generate_reset_packet_plain(void **ut_state)
 
     /* Assure repeated generation of reset is deterministic/stateless*/
     assert_memory_equal(state.peer_session_id.id, client_id.id, SID_SIZE);
-    struct buffer buf2 = tls_reset_standalone(&tas, &client_id, &server_id, header, 0, 0);
+    struct buffer buf2 = tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
     assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
     free_buf(&buf2);
@@ -566,7 +566,7 @@ test_generate_reset_packet_tls_auth(void **ut_state)
 
     now = 0x22446688;
     reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
-    struct buffer buf = tls_reset_standalone(&tas_client, &client_id, &server_id, header, 0, 0);
+    struct buffer buf = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header, false);
 
     enum first_packet_verdict verdict = tls_pre_decrypt_lite(&tas_server, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_RESET_V2);
@@ -575,7 +575,7 @@ test_generate_reset_packet_tls_auth(void **ut_state)
 
     /* Assure repeated generation of reset is deterministic/stateless*/
     reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
-    struct buffer buf2 = tls_reset_standalone(&tas_client, &client_id, &server_id, header, 0, 0);
+    struct buffer buf2 = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header,false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
     assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
     free_buf(&buf2);
-- 
2.32.0 (Apple Git-132)


