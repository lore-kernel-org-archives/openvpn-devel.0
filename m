From: Gert Doering <gert@...1296...>
Date: Tue, 15 Jul 2025 16:37:44 +0200
Message-ID: <20250715143750.9719-1-gert@...1296...>
In-Reply-To: <gerrit.1752140383000.I8cefa9a406fe90bb3cbe481304782c639691a3a0@...2715...>
References: <gerrit.1752140383000.I8cefa9a406fe90bb3cbe481304782c639691a3a0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] reliable: Review and fix gc_arena usage
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

From: Frank Lichtenheld <frank@...2641...>

Check for unused objects (in
reliable_get_num_output_sequenced_available)
and missing free (in reliable_can_get).

While looking through the code, modernize
the loop variable usage.

Change-Id: I8cefa9a406fe90bb3cbe481304782c639691a3a0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1083
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 424d194..5505f56 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -98,8 +98,7 @@
 static inline bool
 reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
 {
-    int i;
-    for (i = 0; i < ack->len; ++i)
+    for (int i = 0; i < ack->len; ++i)
     {
         if (ack->packet_id[i] == pid)
         {
@@ -312,10 +311,7 @@
 const char *
 reliable_ack_print(struct buffer *buf, bool verbose, struct gc_arena *gc)
 {
-    int i;
     uint8_t n_ack;
-    struct session_id sid_ack;
-    packet_id_type pid;
     struct buffer out = alloc_buf_gc(256, gc);
 
     buf_printf(&out, "[");
@@ -323,8 +319,9 @@
     {
         goto done;
     }
-    for (i = 0; i < n_ack; ++i)
+    for (int i = 0; i < n_ack; ++i)
     {
+        packet_id_type pid;
         if (!buf_read(buf, &pid, sizeof(pid)))
         {
             goto done;
@@ -334,6 +331,7 @@
     }
     if (n_ack)
     {
+        struct session_id sid_ack;
         if (!session_id_read(&sid_ack, buf))
         {
             goto done;
@@ -356,14 +354,12 @@
 void
 reliable_init(struct reliable *rel, int buf_size, int offset, int array_size, bool hold)
 {
-    int i;
-
     CLEAR(*rel);
     ASSERT(array_size > 0 && array_size <= RELIABLE_CAPACITY);
     rel->hold = hold;
     rel->size = array_size;
     rel->offset = offset;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         e->buf = alloc_buf(buf_size);
@@ -378,8 +374,7 @@
     {
         return;
     }
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         free_buf(&e->buf);
@@ -391,8 +386,7 @@
 bool
 reliable_empty(const struct reliable *rel)
 {
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)
@@ -407,11 +401,10 @@
 void
 reliable_send_purge(struct reliable *rel, const struct reliable_ack *ack)
 {
-    int i, j;
-    for (i = 0; i < ack->len; ++i)
+    for (int i = 0; i < ack->len; ++i)
     {
         packet_id_type pid = ack->packet_id[i];
-        for (j = 0; j < rel->size; ++j)
+        for (int j = 0; j < rel->size; ++j)
         {
             struct reliable_entry *e = &rel->array[j];
             if (e->active && e->packet_id == pid)
@@ -449,10 +442,9 @@
 reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(256, gc);
-    int i;
 
     buf_printf(&out, "[" packet_id_format "]", (packet_id_print_type)rel->packet_id);
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)
@@ -468,9 +460,7 @@
 bool
 reliable_can_get(const struct reliable *rel)
 {
-    struct gc_arena gc = gc_new();
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (!e->active)
@@ -478,6 +468,7 @@
             return true;
         }
     }
+    struct gc_arena gc = gc_new();
     dmsg(D_REL_LOW, "ACK no free receive buffer available: %s", reliable_print_ids(rel, &gc));
     gc_free(&gc);
     return false;
@@ -488,12 +479,11 @@
 reliable_not_replay(const struct reliable *rel, packet_id_type id)
 {
     struct gc_arena gc = gc_new();
-    int i;
     if (reliable_pid_min(id, rel->packet_id))
     {
         goto bad;
     }
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active && e->packet_id == id)
@@ -514,19 +504,17 @@
 bool
 reliable_wont_break_sequentiality(const struct reliable *rel, packet_id_type id)
 {
-    struct gc_arena gc = gc_new();
-
     const int ret = reliable_pid_in_range2(id, rel->packet_id, rel->size);
 
     if (!ret)
     {
+        struct gc_arena gc = gc_new();
         dmsg(D_REL_LOW, "ACK " packet_id_format " breaks sequentiality: %s",
              (packet_id_print_type)id, reliable_print_ids(rel, &gc));
+        gc_free(&gc);
     }
 
     dmsg(D_REL_DEBUG, "ACK RWBS rel->size=%d rel->packet_id=%08x id=%08x ret=%d", rel->size, rel->packet_id, id, ret);
-
-    gc_free(&gc);
     return ret;
 }
 
@@ -534,8 +522,7 @@
 struct buffer *
 reliable_get_buf(struct reliable *rel)
 {
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         if (!e->active)
@@ -550,7 +537,6 @@
 int
 reliable_get_num_output_sequenced_available(struct reliable *rel)
 {
-    struct gc_arena gc = gc_new();
     packet_id_type min_id = 0;
     bool min_id_defined = false;
 
@@ -573,7 +559,6 @@
     {
         ret -= subtract_pid(rel->packet_id, min_id);
     }
-    gc_free(&gc);
     return ret;
 }
 
@@ -581,14 +566,12 @@
 struct buffer *
 reliable_get_buf_output_sequenced(struct reliable *rel)
 {
-    struct gc_arena gc = gc_new();
-    int i;
     packet_id_type min_id = 0;
     bool min_id_defined = false;
     struct buffer *ret = NULL;
 
     /* find minimum active packet_id */
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)
@@ -607,9 +590,10 @@
     }
     else
     {
+        struct gc_arena gc = gc_new();
         dmsg(D_REL_LOW, "ACK output sequence broken: %s", reliable_print_ids(rel, &gc));
+        gc_free(&gc);
     }
-    gc_free(&gc);
     return ret;
 }
 
@@ -617,8 +601,7 @@
 struct reliable_entry *
 reliable_get_entry_sequenced(struct reliable *rel)
 {
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         if (e->active && e->packet_id == rel->packet_id)
@@ -634,9 +617,8 @@
 reliable_can_send(const struct reliable *rel)
 {
     struct gc_arena gc = gc_new();
-    int i;
     int n_active = 0, n_current = 0;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)
@@ -662,11 +644,10 @@
 struct buffer *
 reliable_send(struct reliable *rel, int *opcode)
 {
-    int i;
     struct reliable_entry *best = NULL;
     const time_t local_now = now;
 
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
 
@@ -701,10 +682,9 @@
 void
 reliable_schedule_now(struct reliable *rel)
 {
-    int i;
     dmsg(D_REL_DEBUG, "ACK reliable_schedule_now");
     rel->hold = false;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         if (e->active)
@@ -722,10 +702,9 @@
 {
     struct gc_arena gc = gc_new();
     interval_t ret = BIG_TIMEOUT;
-    int i;
     const time_t local_now = now;
 
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)
@@ -758,8 +737,7 @@
 reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf,
                               packet_id_type pid, int opcode)
 {
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         if (buf == &e->buf)
@@ -790,8 +768,7 @@
 void
 reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf, int opcode)
 {
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         if (buf == &e->buf)
@@ -817,8 +794,7 @@
 void
 reliable_mark_deleted(struct reliable *rel, struct buffer *buf)
 {
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         if (buf == &e->buf)
@@ -836,10 +812,8 @@
 void
 reliable_ack_debug_print(const struct reliable_ack *ack, char *desc)
 {
-    int i;
-
     printf("********* struct reliable_ack %s\n", desc);
-    for (i = 0; i < ack->len; ++i)
+    for (int i = 0; i < ack->len; ++i)
     {
         printf("  %d: " packet_id_format "\n", i, (packet_id_print_type) ack->packet_id[i]);
     }
@@ -848,14 +822,13 @@
 void
 reliable_debug_print(const struct reliable *rel, char *desc)
 {
-    int i;
     update_time();
 
     printf("********* struct reliable %s\n", desc);
     printf("  initial_timeout=%d\n", (int)rel->initial_timeout);
     printf("  packet_id=" packet_id_format "\n", rel->packet_id);
     printf("  now=%" PRIi64 "\n", (int64_t)now);
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)

