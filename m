From: Gert Doering <gert@...1296...>
Date: Wed, 25 Dec 2024 15:21:31 +0100
Message-ID: <20241225142131.12543-1-gert@...1296...>
In-Reply-To: <gerrit.1731290343000.If470af2eb456b2b10f9f2806933e026842188c42@...2715...>
References: <gerrit.1731290343000.If470af2eb456b2b10f9f2806933e026842188c42@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] Change internal id of packet id to uint64
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

This allows to get rid of multiple casts and also prepares for the
larger packet id used by epoch data format.

Change-Id: If470af2eb456b2b10f9f2806933e026842188c42
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/802
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index fb962e4..117c95f 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -36,6 +36,8 @@
 
 #include "syshead.h"
 
+#include <stddef.h>
+
 #include "packet_id.h"
 #include "misc.h"
 #include "integer.h"
@@ -56,7 +58,7 @@
                                   const struct packet_id_rec *p,
                                   const struct packet_id_net *pin,
                                   const char *message,
-                                  int value);
+                                  packet_id_print_type value);
 
 #endif /* ENABLE_DEBUG */
 
@@ -65,7 +67,7 @@
                 const struct packet_id_rec *p,
                 const struct packet_id_net *pin,
                 const char *message,
-                int value)
+                uint64_t value)
 {
 #ifdef ENABLE_DEBUG
     if (unlikely(check_debug_level(msglevel)))
@@ -115,22 +117,21 @@
     const time_t local_now = now;
     if (p->seq_list)
     {
-        packet_id_type diff;
+        int64_t diff;
 
         /*
-         * If time value increases, start a new
-         * sequence number sequence.
+         * If time value increases, start a new sequence number sequence.
          */
         if (!CIRC_LIST_SIZE(p->seq_list)
             || pin->time > p->time
-            || (pin->id >= (packet_id_type)p->seq_backtrack
-                && pin->id - (packet_id_type)p->seq_backtrack > p->id))
+            || (pin->id >= p->seq_backtrack
+                && pin->id - p->seq_backtrack > p->id))
         {
             p->time = pin->time;
             p->id = 0;
-            if (pin->id > (packet_id_type)p->seq_backtrack)
+            if (pin->id > p->seq_backtrack)
             {
-                p->id = pin->id - (packet_id_type)p->seq_backtrack;
+                p->id = pin->id - p->seq_backtrack;
             }
             CIRC_LIST_RESET(p->seq_list);
         }
@@ -146,7 +147,7 @@
         }
 
         diff = p->id - pin->id;
-        if (diff < (packet_id_type) CIRC_LIST_SIZE(p->seq_list)
+        if (diff < CIRC_LIST_SIZE(p->seq_list)
             && local_now > SEQ_EXPIRED)
         {
             CIRC_LIST_ITEM(p->seq_list, diff) = local_now;
@@ -170,9 +171,8 @@
     const time_t local_now = now;
     if (p->time_backtrack)
     {
-        int i;
         bool expire = false;
-        for (i = 0; i < CIRC_LIST_SIZE(p->seq_list); ++i)
+        for (int i = 0; i < CIRC_LIST_SIZE(p->seq_list); ++i)
         {
             const time_t t = CIRC_LIST_ITEM(p->seq_list, i);
             if (t == SEQ_EXPIRED)
@@ -200,7 +200,7 @@
 packet_id_test(struct packet_id_rec *p,
                const struct packet_id_net *pin)
 {
-    packet_id_type diff;
+    uint64_t diff;
 
     packet_id_debug(D_PID_DEBUG, p, pin, "PID_TEST", 0);
 
@@ -231,9 +231,9 @@
             diff = p->id - pin->id;
 
             /* keep track of maximum backtrack seen for debugging purposes */
-            if ((int)diff > p->max_backtrack_stat)
+            if (diff > p->max_backtrack_stat)
             {
-                p->max_backtrack_stat = (int)diff;
+                p->max_backtrack_stat = diff;
                 packet_id_debug(D_PID_DEBUG_LOW, p, pin, "PID_ERR replay-window backtrack occurred", p->max_backtrack_stat);
             }
 
@@ -557,7 +557,7 @@
                       const struct packet_id_rec *p,
                       const struct packet_id_net *pin,
                       const char *message,
-                      int value)
+                      packet_id_print_type value)
 {
     struct gc_arena gc = gc_new();
     struct buffer out = alloc_buf_gc(256, &gc);
@@ -569,7 +569,7 @@
     CLEAR(tv);
     gettimeofday(&tv, NULL);
 
-    buf_printf(&out, "%s [%d]", message, value);
+    buf_printf(&out, "%s [" packet_id_format "]", message, value);
     buf_printf(&out, " [%s-%d] [", p->name, p->unit);
     for (i = 0; sl != NULL && i < sl->x_size; ++i)
     {
@@ -604,17 +604,17 @@
         }
         buf_printf(&out, "%c", c);
     }
-    buf_printf(&out, "] %" PRIi64 ":" packet_id_format, (int64_t)p->time, (packet_id_print_type)p->id);
+    buf_printf(&out, "] %" PRIi64 ":" packet_id_format, (int64_t)p->time, p->id);
     if (pin)
     {
-        buf_printf(&out, " %" PRIi64 ":" packet_id_format, (int64_t)pin->time, (packet_id_print_type)pin->id);
+        buf_printf(&out, " %" PRIi64 ":" packet_id_format, (int64_t)pin->time, pin->id);
     }
 
     buf_printf(&out, " t=%" PRIi64 "[%d]",
                (int64_t)prev_now,
                (int)(prev_now - tv.tv_sec));
 
-    buf_printf(&out, " r=[%d,%d,%d,%d,%d]",
+    buf_printf(&out, " r=[%d,%" PRIu64 ",%d,%" PRIu64 ",%d]",
                (int)(p->last_reap - tv.tv_sec),
                p->seq_backtrack,
                p->time_backtrack,
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 3778d19..d8a3e1a 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -35,11 +35,13 @@
 #include "error.h"
 #include "otime.h"
 
-#if 1
 /*
- * These are the types that members of
- * a struct packet_id_net are converted
- * to for network transmission.
+ * These are the types that members of a struct packet_id_net are converted
+ * to for network transmission and for saving to a persistent file.
+ *
+ * Note: data epoch data uses a 64 bit packet ID
+ * compromised of 16 bit epoch and 48 bit per-epoch packet counter.
+ * These are ephemeral and are never saved to a file.
  */
 typedef uint32_t packet_id_type;
 #define PACKET_ID_MAX UINT32_MAX
@@ -64,31 +66,12 @@
 /* convert a net_time_t in network order to a time_t in host order */
 #define ntohtime(x) ((time_t)ntohl(x))
 
-#else  /* if 1 */
-
-/*
- * DEBUGGING ONLY.
- * Make packet_id_type and net_time_t small
- * to test wraparound logic and corner cases.
- */
-
-typedef uint8_t packet_id_type;
-typedef uint16_t net_time_t;
-
-#define PACKET_ID_WRAP_TRIGGER 0x80
-
-#define htonpid(x) (x)
-#define ntohpid(x) (x)
-#define htontime(x) htons((net_time_t)x)
-#define ntohtime(x) ((time_t)ntohs(x))
-
-#endif /* if 1 */
 
 /*
  * Printf formats for special types
  */
-#define packet_id_format "%u"
-typedef unsigned int packet_id_print_type;
+#define packet_id_format "%" PRIu64
+typedef uint64_t packet_id_print_type;
 
 /*
  * Maximum allowed backtrack in
@@ -128,10 +111,10 @@
 {
     time_t last_reap;         /* last call of packet_id_reap */
     time_t time;              /* highest time stamp received */
-    packet_id_type id;        /* highest sequence number received */
-    int seq_backtrack;        /* set from --replay-window */
+    uint64_t id;              /* highest sequence number received */
+    uint64_t seq_backtrack;   /* set from --replay-window */
     int time_backtrack;       /* set from --replay-window */
-    int max_backtrack_stat;   /* maximum backtrack seen so far */
+    uint64_t max_backtrack_stat;   /* maximum backtrack seen so far */
     bool initialized;         /* true if packet_id_init was called */
     struct seq_list *seq_list; /* packet-id "memory" */
     const char *name;
@@ -164,7 +147,7 @@
  */
 struct packet_id_send
 {
-    packet_id_type id;
+    uint64_t id;
     time_t time;
 };
 
@@ -174,8 +157,12 @@
  * sequence number.  A long packet-id
  * includes a timestamp as well.
  *
+ * An epoch packet-id is a 16 bit epoch
+ * counter plus a 48 per-epoch packet-id
+ *
  * Long packet-ids are used as IVs for
- * CFB/OFB ciphers.
+ * CFB/OFB ciphers and for control channel
+ * messages.
  *
  * This data structure is always sent
  * over the net in network byte order,
@@ -191,9 +178,16 @@
  * 64 bit platforms use a
  * 64 bit time_t.
  */
+
+/**
+ * Data structure for describing the packet id that is received/send to the
+ * network. This struct does not match the on wire format.
+ */
 struct packet_id_net
 {
-    packet_id_type id;
+    /* converted to packet_id_type on non-epoch data ids, does not contain
+     * the epoch but is a flat id */
+    uint64_t id;
     time_t time; /* converted to net_time_t before transmission */
 };
 
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index a3567bc..d918985 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -90,8 +90,8 @@
 
     now = 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
-    assert(data->pis.id == 1);
-    assert(data->pis.time == now);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->pis.time, now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
     assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
@@ -117,8 +117,8 @@
     data->test_buf.offset = sizeof(data->test_buf_data);
     now = 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, true));
-    assert(data->pis.id == 1);
-    assert(data->pis.time == now);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->pis.time, now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
     assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }
@@ -128,7 +128,8 @@
 {
     struct test_packet_id_write_data *data = *state;
 
-    data->pis.id = ~0;
+    /* maximum 32-bit packet id */
+    data->pis.id = (packet_id_type)(~0);
     assert_false(packet_id_write(&data->pis, &data->test_buf, false, false));
 }
 
@@ -137,7 +138,8 @@
 {
     struct test_packet_id_write_data *data = *state;
 
-    data->pis.id = ~0;
+    /* maximum 32-bit packet id */
+    data->pis.id = (packet_id_type)(~0);
     data->pis.time = 5006;
 
     /* Write fails if time did not change */
@@ -148,8 +150,8 @@
     now = 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
 
-    assert(data->pis.id == 1);
-    assert(data->pis.time == now);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->pis.time, now);
     assert_true(data->test_buf_data.buf_id == htonl(1));
     assert_true(data->test_buf_data.buf_time == htonl((uint32_t)now));
 }

