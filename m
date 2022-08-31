From: Arne Schwabe <arne@...1227...>
Date: Wed, 31 Aug 2022 15:41:39 +0200
Message-Id: <20220831134140.913337-1-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 28/28] Always include ACKs for the last
 seen control packets
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

This adds an MRU cache for the last seen packets from the peer to send acks
to all recently recently  packets. This allows packets to be acknowledged
even if a single P_ACK_V1 gets lost, avoiding retransmissions. The downside
is that we add up to 28 byte to an P_ACK_V1 (7* packet_id) and up to 24
bytes to other control channel packets (4* packet_id + peer session id).
However these small increases in packet size are a small price to pay for
increased reliability.

Currently OpenVPN will only send the absolute minimum of ACK messages. A single
lost ACK message will trigger a resend from the peer and another ACK message.

Patch v2: fix multiple typos/grammar. Change lru to mru (this is really an
          MRU cache), add more unit test cases

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/reliable.c                    | 69 +++++++++++++++++++++--
 src/openvpn/reliable.h                    | 17 ++++++
 src/openvpn/ssl.c                         |  5 +-
 src/openvpn/ssl_common.h                  |  1 +
 src/openvpn/ssl_pkt.c                     |  3 +-
 tests/unit_tests/openvpn/test_packet_id.c | 68 +++++++++++++++++++++-
 6 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 3ccb73976..209ca6ede 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -206,10 +206,56 @@ reliable_ack_parse(struct buffer *buf, struct reliable_ack *ack,
     return true;
 }
 
+/**
+ * Copies the first n acks from \c ack to \c ack_mru
+ */
+void
+copy_acks_to_mru(struct reliable_ack *ack, struct reliable_ack *ack_mru, int n)
+{
+    ASSERT(ack->len >= n);
+    /* This loop is backward to ensure the same order as in ack */
+    for (int i = n-1; i >= 0; i--)
+    {
+        packet_id_type id = ack->packet_id[i];
+
+        /* Handle special case of ack_mru empty */
+        if (ack_mru->len == 0)
+        {
+            ack_mru->len = 1;
+            ack_mru->packet_id[0] = id;
+        }
+
+        bool idfound = false;
+
+        /* Move all existing entries one to the right */
+        packet_id_type move = id;
+
+        for (int j = 0; j < ack_mru->len; j++)
+        {
+            packet_id_type tmp = ack_mru->packet_id[j];
+            ack_mru->packet_id[j] = move;
+            move = tmp;
+
+            if (move == id)
+            {
+                idfound = true;
+                break;
+            }
+        }
+
+        if (!idfound && ack_mru->len < RELIABLE_ACK_SIZE)
+        {
+            ack_mru->packet_id[ack_mru->len] = move;
+            ack_mru->len++;
+        }
+    }
+}
+
 /* write a packet ID acknowledgement record to buf, */
 /* removing all acknowledged entries from ack */
 bool
 reliable_ack_write(struct reliable_ack *ack,
+                   struct reliable_ack *ack_mru,
                    struct buffer *buf,
                    const struct session_id *sid, int max, bool prepend)
 {
@@ -222,23 +268,36 @@ reliable_ack_write(struct reliable_ack *ack,
     {
         n = max;
     }
-    sub = buf_sub(buf, ACK_SIZE(n), prepend);
+
+    copy_acks_to_mru(ack, ack_mru, n);
+
+    /* Number of acks we can resend that still fit into the packet */
+    uint8_t total_acks = min_int(max, ack_mru->len);
+
+    sub = buf_sub(buf, ACK_SIZE(total_acks), prepend);
     if (!BDEF(&sub))
     {
         goto error;
     }
-    ASSERT(buf_write(&sub, &n, sizeof(n)));
-    for (i = 0; i < n; ++i)
+    ASSERT(buf_write_u8(&sub, total_acks));
+
+    /* Write the actual acks to the packets. Since we copied the acks that
+     * are going out now already to the front of ack_mru we can fetch all
+     * acks from ack_mru */
+    for (i = 0; i < total_acks; ++i)
     {
-        packet_id_type pid = ack->packet_id[i];
+        packet_id_type pid = ack_mru->packet_id[i];
         packet_id_type net_pid = htonpid(pid);
         ASSERT(buf_write(&sub, &net_pid, sizeof(net_pid)));
         dmsg(D_REL_DEBUG, "ACK write ID " packet_id_format " (ack->len=%d, n=%d)", (packet_id_print_type)pid, ack->len, n);
     }
-    if (n)
+    if (total_acks)
     {
         ASSERT(session_id_defined(sid));
         ASSERT(session_id_write(sid, &sub));
+    }
+    if (n)
+    {
         for (i = 0, j = n; j < ack->len; )
         {
             ack->packet_id[i++] = ack->packet_id[j++];
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 7fffe397d..01ce72876 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -197,6 +197,9 @@ reliable_ack_outstanding(struct reliable_ack *ack)
  *
  * @param ack The acknowledgment structure containing packet IDs to be
  *     acknowledged.
+ * @param ack_mru List of packets we have acknowledged before. Packets from
+ *                \c ack will be moved here and if there is space in our
+ *                ack structure we will fill it with packets from this
  * @param buf The buffer into which the acknowledgment record will be
  *     written.
  * @param sid The session ID of the VPN tunnel associated with the
@@ -211,6 +214,7 @@ reliable_ack_outstanding(struct reliable_ack *ack)
  * @li False, if an error occurs during processing.
  */
 bool reliable_ack_write(struct reliable_ack *ack,
+                        struct reliable_ack *ack_mru,
                         struct buffer *buf,
                         const struct session_id *sid, int max, bool prepend);
 
@@ -370,6 +374,19 @@ bool reliable_ack_acknowledge_packet_id(struct reliable_ack *ack, packet_id_type
  */
 struct reliable_entry *reliable_get_entry_sequenced(struct reliable *rel);
 
+
+
+/**
+ * Copies the first n acks from \c ack to \c ack_mru
+ *
+ * @param ack The reliable structure to copy the acks from
+ * @param ack_mru The reliable structure to insert the acks into
+ * @param n The number of ACKS to copy
+ */
+void
+copy_acks_to_mru(struct reliable_ack *ack, struct reliable_ack *ack_mru, int n);
+
+
 /**
  * Remove an entry from a reliable structure.
  *
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ebce048c2..ec5639993 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -356,7 +356,8 @@ calc_control_channel_frame_overhead(const struct tls_session *session)
     overhead += SID_SIZE;
 
     /* ACK array and remote SESSION ID (part of the ACK array) */
-    overhead += ACK_SIZE(min_int(reliable_ack_outstanding(ks->rec_ack), CONTROL_SEND_ACK_MAX));
+    int ackstosend = reliable_ack_outstanding(ks->rec_ack) + ks->lru_acks->len;
+    overhead += ACK_SIZE(min_int(ackstosend, CONTROL_SEND_ACK_MAX));
 
     /* Message packet id */
     overhead += sizeof(packet_id_type);
@@ -977,6 +978,7 @@ key_state_init(struct tls_session *session, struct key_state *ks)
     ALLOC_OBJ_CLEAR(ks->send_reliable, struct reliable);
     ALLOC_OBJ_CLEAR(ks->rec_reliable, struct reliable);
     ALLOC_OBJ_CLEAR(ks->rec_ack, struct reliable_ack);
+    ALLOC_OBJ_CLEAR(ks->lru_acks, struct reliable_ack);
 
     /* allocate buffers */
     ks->plaintext_read_buf = alloc_buf(TLS_CHANNEL_BUF_SIZE);
@@ -1047,6 +1049,7 @@ key_state_free(struct key_state *ks, bool clear)
     reliable_free(ks->rec_reliable);
 
     free(ks->rec_ack);
+    free(ks->lru_acks);
     free(ks->key_src);
 
     packet_id_free(&ks->crypto_options.packet_id);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f1cade2ef..9dcd447cb 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -233,6 +233,7 @@ struct key_state
     struct reliable *send_reliable; /* holds a copy of outgoing packets until ACK received */
     struct reliable *rec_reliable; /* order incoming ciphertext packets before we pass to TLS */
     struct reliable_ack *rec_ack; /* buffers all packet IDs we want to ACK back to sender */
+    struct reliable_ack *lru_acks; /* keeps the most recently acked packages*/
 
     /** Holds outgoing message for the control channel until ks->state reaches
      * S_ACTIVE */
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 0083fc470..e86fbc1b8 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -179,7 +179,8 @@ write_control_auth(struct tls_session *session,
 
     ASSERT(link_socket_actual_defined(&ks->remote_addr));
     ASSERT(reliable_ack_write
-               (ks->rec_ack, buf, &ks->session_id_remote, max_ack, prepend_ack));
+               (ks->rec_ack, ks->lru_acks, buf, &ks->session_id_remote,
+               max_ack, prepend_ack));
 
     msg(D_TLS_DEBUG, "%s(): %s", __func__, packet_opcode_name(opcode));
 
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 96d3e870d..03fc13ccf 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -210,6 +210,70 @@ test_get_num_output_sequenced_available(void **state)
     reliable_free(rel);
 }
 
+
+static void
+test_copy_acks_to_lru(void **state)
+{
+    struct reliable_ack ack = { .len = 4, .packet_id = {2, 1, 3, 2} };
+
+    struct reliable_ack mru_ack = {0 };
+
+    /* Test copying to empty ack structure */
+    copy_acks_to_mru(&ack, &mru_ack, 4);
+    assert_int_equal(mru_ack.len, 3);
+    assert_int_equal(mru_ack.packet_id[0], 2);
+    assert_int_equal(mru_ack.packet_id[1], 1);
+    assert_int_equal(mru_ack.packet_id[2], 3);
+
+    /* Copying again should not change the result */
+    copy_acks_to_mru(&ack, &mru_ack, 4);
+    assert_int_equal(mru_ack.len, 3);
+    assert_int_equal(mru_ack.packet_id[0], 2);
+    assert_int_equal(mru_ack.packet_id[1], 1);
+    assert_int_equal(mru_ack.packet_id[2], 3);
+
+    /* Copying just the first two element should not change the order
+     * as they are still the most recent*/
+    struct reliable_ack mru_ack2 = mru_ack;
+    copy_acks_to_mru(&ack, &mru_ack2, 2);
+    assert_int_equal(mru_ack2.packet_id[0], 2);
+    assert_int_equal(mru_ack2.packet_id[1], 1);
+    assert_int_equal(mru_ack2.packet_id[2], 3);
+
+    /* Adding just two packets shoudl ignore the 42 in array and
+     * reorder the order in the MRU */
+    struct reliable_ack ack2 = { .len = 3, .packet_id = {3, 2, 42} };
+    copy_acks_to_mru(&ack2, &mru_ack2, 2);
+    assert_int_equal(mru_ack2.packet_id[0], 3);
+    assert_int_equal(mru_ack2.packet_id[1], 2);
+    assert_int_equal(mru_ack2.packet_id[2], 1);
+
+    /* Copying a zero array into it should also change nothing */
+    struct reliable_ack empty_ack = { .len = 0 };
+    copy_acks_to_mru(&empty_ack, &mru_ack, 0);
+    assert_int_equal(mru_ack.len, 3);
+    assert_int_equal(mru_ack.packet_id[0], 2);
+    assert_int_equal(mru_ack.packet_id[1], 1);
+    assert_int_equal(mru_ack.packet_id[2], 3);
+
+    /* Or should just 0 elements of the ack */
+    copy_acks_to_mru(&ack, &mru_ack, 0);
+    assert_int_equal(mru_ack.len, 3);
+    assert_int_equal(mru_ack.packet_id[0], 2);
+    assert_int_equal(mru_ack.packet_id[1], 1);
+    assert_int_equal(mru_ack.packet_id[2], 3);
+
+    struct reliable_ack ack3 = { .len = 7, .packet_id = {5, 6, 7, 8, 9, 10, 11}};
+
+    /* Adding multiple acks tests if the a full array is handled correctly */
+    copy_acks_to_mru(&ack3, &mru_ack, 7);
+
+    struct reliable_ack expected_ack = { .len = 8, .packet_id = {5, 6, 7, 8, 9, 10, 11, 2}};
+    assert_int_equal(mru_ack.len, expected_ack.len);
+
+    assert_memory_equal(mru_ack.packet_id, expected_ack.packet_id, sizeof(expected_ack.packet_id));
+}
+
 int
 main(void)
 {
@@ -232,7 +296,9 @@ main(void)
         cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
                                         test_packet_id_write_setup,
                                         test_packet_id_write_teardown),
-        cmocka_unit_test(test_get_num_output_sequenced_available)
+        cmocka_unit_test(test_get_num_output_sequenced_available),
+        cmocka_unit_test(test_copy_acks_to_lru)
+
     };
 
     return cmocka_run_group_tests_name("packet_id tests", tests, NULL, NULL);
-- 
2.32.1 (Apple Git-133)


