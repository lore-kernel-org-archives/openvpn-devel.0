From: Gert Doering <gert@...1296...>
Date: Thu,  9 Jan 2025 18:55:28 +0100
Message-ID: <20250109175528.22033-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
References: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v12] Add methods to read/write packet ids
 for epoch data
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

Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/803
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 117c95f..0806e99 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -120,7 +120,8 @@
         int64_t diff;
 
         /*
-         * If time value increases, start a new sequence number sequence.
+         * If time value increases, start a new sequence list of number
+         * sequence for the new time point.
          */
         if (!CIRC_LIST_SIZE(p->seq_list)
             || pin->time > p->time
@@ -343,6 +344,21 @@
     return true;
 }
 
+static bool
+packet_id_send_update_epoch(struct packet_id_send *p)
+{
+    if (!p->time)
+    {
+        p->time = now;
+    }
+    if (p->id == PACKET_ID_EPOCH_MAX)
+    {
+        return false;
+    }
+    p->id++;
+    return true;
+}
+
 bool
 packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_form,
                 bool prepend)
@@ -634,4 +650,44 @@
     gc_free(&gc);
 }
 
+uint16_t
+packet_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)
+{
+    uint64_t packet_id;
+
+
+    if (!buf_read(buf, &packet_id, sizeof(packet_id)))
+    {
+        return 0;
+    }
+
+    uint64_t id = ntohll(packet_id);
+    /* top most 16 bits */
+    uint16_t epoch = id >> 48;
+
+    pin->id = id & PACKET_ID_MASK;
+    return epoch;
+}
+
+bool
+packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buffer *buf)
+{
+    if (!packet_id_send_update_epoch(p))
+    {
+        return false;
+    }
+
+    /* Highest 16 bits of packet id is the epoch.
+     *
+     * The lower 48 bits are the per-epoch packet id counter. */
+    uint64_t net_id = ((uint64_t) epoch) << 48 | p->id;
+
+    /* convert to network order. This ensures that the highest bytes
+     * also become the first ones on the wire*/
+    net_id = htonll(net_id);
+
+    return buf_write(buf, &net_id, sizeof(net_id));
+}
+
+
 #endif /* ifdef ENABLE_DEBUG */
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index d8a3e1a..c05ac9a 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -44,7 +44,11 @@
  * These are ephemeral and are never saved to a file.
  */
 typedef uint32_t packet_id_type;
-#define PACKET_ID_MAX UINT32_MAX
+#define PACKET_ID_MAX        UINT32_MAX
+#define PACKET_ID_EPOCH_MAX  0x0000ffffffffffffull
+/** Mask of the bits that contain the 48-bit of the per-epoch packet
+ * counter in the packet id*/
+#define PACKET_ID_MASK       0x0000ffffffffffffull
 typedef uint32_t net_time_t;
 
 /*
@@ -158,7 +162,8 @@
  * includes a timestamp as well.
  *
  * An epoch packet-id is a 16 bit epoch
- * counter plus a 48 per-epoch packet-id
+ * counter plus a 48 per-epoch packet-id.
+ *
  *
  * Long packet-ids are used as IVs for
  * CFB/OFB ciphers and for control channel
@@ -321,4 +326,25 @@
     }
 }
 
+/**
+ * Writes the packet ID containing both the epoch and the packet id to the
+ * buffer specified by buf.
+ * @param p         packet id send structure to use for the packet id
+ * @param epoch     epoch to write to the packet
+ * @param buf       buffer to write the packet id/epoch to
+ * @return          false if the packet id space is exhausted and cannot be written
+ */
+bool
+packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buffer *buf);
+
+/**
+ * Reads the packet ID containing both the epoch and the per-epoch counter
+ * from the buf.  Will return 0 as epoch id if there is any error.
+ * @param p       packet_id struct to populate with the on-wire counter
+ * @param buf     buffer to read the packet id from.
+ * @return        0 for an error/invalid id, epoch otherwise
+ */
+uint16_t
+packet_id_read_epoch(struct packet_id_net *p, struct buffer *buf);
+
 #endif /* PACKET_ID_H */
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index d918985..312a6b3d 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -44,6 +44,7 @@
     } test_buf_data;
     struct buffer test_buf;
     struct packet_id_send pis;
+    struct gc_arena gc;
 };
 
 static int
@@ -59,6 +60,7 @@
 
     data->test_buf.data = (void *) &data->test_buf_data;
     data->test_buf.capacity = sizeof(data->test_buf_data);
+    data->gc = gc_new();
 
     *state = data;
     return 0;
@@ -67,6 +69,8 @@
 static int
 test_packet_id_write_teardown(void **state)
 {
+    struct test_packet_id_write_data *data = *state;
+    gc_free(&data->gc);
     free(*state);
     return 0;
 }
@@ -209,6 +213,54 @@
     reliable_free(rel);
 }
 
+static void
+test_packet_id_write_epoch(void **state)
+{
+    struct test_packet_id_write_data *data = *state;
+
+    struct buffer buf = alloc_buf_gc(128, &data->gc);
+
+    /* test normal writing of packet id to the buffer */
+    assert_true(packet_id_write_epoch(&data->pis, 0x23, &buf));
+
+    assert_int_equal(buf.len, 8);
+    uint8_t expected_header[8] = { 0x00, 0x23, 0, 0, 0, 0, 0, 1};
+    assert_memory_equal(BPTR(&buf), expected_header, 8);
+
+    /* too small buffer should error out */
+    struct buffer buf_short = alloc_buf_gc(5, &data->gc);
+    assert_false(packet_id_write_epoch(&data->pis, 0xabde, &buf_short));
+
+    /* test a true 48 bit packet id */
+    data->pis.id = 0xfa079ab9d2e8;
+    struct buffer buf_48 = alloc_buf_gc(128, &data->gc);
+    assert_true(packet_id_write_epoch(&data->pis, 0xfffe, &buf_48));
+    uint8_t expected_header_48[8] = { 0xff, 0xfe, 0xfa, 0x07, 0x9a, 0xb9, 0xd2, 0xe9};
+    assert_memory_equal(BPTR(&buf_48), expected_header_48, 8);
+
+    /* test writing/checking the 48 bit per epoch packet counter
+     * overflow */
+    data->pis.id = 0xfffffffffffe;
+    struct buffer buf_of = alloc_buf_gc(128, &data->gc);
+    assert_true(packet_id_write_epoch(&data->pis, 0xf00f, &buf_of));
+    uint8_t expected_header_of[8] = { 0xf0, 0x0f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+    assert_memory_equal(BPTR(&buf_of), expected_header_of, 8);
+
+    /* This is go over 2^48 - 1 and should error out. */
+    assert_false(packet_id_write_epoch(&data->pis, 0xf00f, &buf_of));
+
+    /* Now read back the packet ids and check if they are the same as what we
+     * have written */
+    struct packet_id_net pin;
+    assert_int_equal(packet_id_read_epoch(&pin, &buf), 0x23);
+    assert_int_equal(pin.id, 1);
+
+    assert_int_equal(packet_id_read_epoch(&pin, &buf_48), 0xfffe);
+    assert_int_equal(pin.id, 0xfa079ab9d2e9);
+
+    assert_int_equal(packet_id_read_epoch(&pin, &buf_of), 0xf00f);
+    assert_int_equal(pin.id, 0xffffffffffff);
+}
 
 static void
 test_copy_acks_to_lru(void **state)
@@ -296,6 +348,10 @@
         cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
                                         test_packet_id_write_setup,
                                         test_packet_id_write_teardown),
+        cmocka_unit_test_setup_teardown(test_packet_id_write_epoch,
+                                        test_packet_id_write_setup,
+                                        test_packet_id_write_teardown),
+
         cmocka_unit_test(test_get_num_output_sequenced_available),
         cmocka_unit_test(test_copy_acks_to_lru)
 

