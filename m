From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Jun 2021 17:30:11 +0200
Message-Id: <20210610153011.1730670-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Avoid resending reset reply more than once
 per client packet
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

For the second reply of a OpenVPN we have no completed the three
way handshake yet and the client IP address is still untrusted.
When retransmitting the reset packet multiple times when timing
out for an ACK response to it, we send the packet multiple
times to an untrusted IP which is nowadys considered bad in a
protocol.

This patch fixes the problem by keeping normal original retry
logic intact but adds a flags to initial packets that they are
are held back to be retrasmitted until we have another packet
from the client.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/reliable.c | 52 +++++++++++++++++++++++++++++++-----------
 src/openvpn/reliable.h | 36 +++++++++++++++++++++++------
 src/openvpn/ssl.c      | 16 +++++++++++--
 3 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 15b90fbe4..da660023c 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -549,6 +549,13 @@ reliable_get_buf_sequenced(struct reliable *rel)
     return NULL;
 }
 
+static inline bool
+entry_ready_for_resend(const struct reliable_entry *e)
+{
+    return ((now >= e->next_try || e->n_acks >= N_ACK_RETRANSMIT)
+        && (!(e->flags & REL_FLAG_RESEND_INITIAL) || (e->flags & REL_FLAG_RESEND_ALLOW)));
+}
+
 /* return true if reliable_send would return a non-NULL result */
 bool
 reliable_can_send(const struct reliable *rel)
@@ -562,7 +569,7 @@ reliable_can_send(const struct reliable *rel)
         if (e->active)
         {
             ++n_active;
-            if (now >= e->next_try || e->n_acks >= N_ACK_RETRANSMIT)
+            if (entry_ready_for_resend(e))
             {
                 ++n_current;
             }
@@ -583,7 +590,6 @@ reliable_send(struct reliable *rel, int *opcode)
 {
     int i;
     struct reliable_entry *best = NULL;
-    const time_t local_now = now;
 
     for (i = 0; i < rel->size; ++i)
     {
@@ -592,8 +598,7 @@ reliable_send(struct reliable *rel, int *opcode)
         /* If N_ACK_RETRANSMIT later packets have received ACKs, we assume
          * that the packet was lost and resend it even if the timeout has
          * not expired yet. */
-        if (e->active
-            && (e->n_acks >= N_ACK_RETRANSMIT || local_now >= e->next_try))
+        if (e->active && entry_ready_for_resend(e))
         {
             if (!best || reliable_pid_min(e->packet_id, best->packet_id))
             {
@@ -605,17 +610,18 @@ reliable_send(struct reliable *rel, int *opcode)
     {
 #ifdef EXPONENTIAL_BACKOFF
         /* exponential backoff */
-        best->next_try = local_now + best->timeout;
+        best->next_try = now + best->timeout;
         best->timeout *= 2;
 #else
         /* constant timeout, no backoff */
-        best->next_try = local_now + best->timeout;
+        best->next_try = now + best->timeout;
 #endif
         best->n_acks = 0;
+        best->flags &= ~REL_FLAG_RESEND_ALLOW;
         *opcode = best->opcode;
         dmsg(D_REL_DEBUG, "ACK reliable_send ID " packet_id_format " (size=%d to=%d)",
              (packet_id_print_type)best->packet_id, best->buf.len,
-             (int)(best->next_try - local_now));
+             (int)(best->next_try - now));
         return &best->buf;
     }
     return NULL;
@@ -639,6 +645,22 @@ reliable_schedule_now(struct reliable *rel)
     }
 }
 
+
+void
+reliable_allow_reschedule_initial(struct reliable *rel)
+{
+    dmsg(D_REL_DEBUG, "ACK %s", __func__);
+    for (int i = 0; i < rel->size; ++i)
+    {
+        struct reliable_entry *e = &rel->array[i];
+        if (e->flags & REL_FLAG_RESEND_INITIAL)
+        {
+            e->flags |= REL_FLAG_RESEND_ALLOW;
+        }
+    }
+}
+
+
 /* in how many seconds should we wake up to check for timeout */
 /* if we return BIG_TIMEOUT, nothing to wait for */
 interval_t
@@ -647,21 +669,20 @@ reliable_send_timeout(const struct reliable *rel)
     struct gc_arena gc = gc_new();
     interval_t ret = BIG_TIMEOUT;
     int i;
-    const time_t local_now = now;
 
     for (i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)
         {
-            if (e->next_try <= local_now)
+            if (e->next_try <= now)
             {
                 ret = 0;
                 break;
             }
             else
             {
-                ret = min_int(ret, e->next_try - local_now);
+                ret = min_int(ret, e->next_try - now);
             }
         }
     }
@@ -712,10 +733,10 @@ reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf,
  */
 
 void
-reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf, int opcode)
+reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf,
+                              int opcode, bool initial_response)
 {
-    int i;
-    for (i = 0; i < rel->size; ++i)
+    for (int i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         if (buf == &e->buf)
@@ -731,6 +752,11 @@ reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf, int opco
             e->next_try = 0;
             e->timeout = rel->initial_timeout;
             dmsg(D_REL_DEBUG, "ACK mark active outgoing ID " packet_id_format, (packet_id_print_type)e->packet_id);
+
+            if (initial_response)
+            {
+                e->flags |= REL_FLAG_RESEND_INITIAL | REL_FLAG_RESEND_ALLOW;
+            }
             return;
         }
     }
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 97e6dce7e..902483685 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -66,19 +66,29 @@ struct reliable_ack
     packet_id_type packet_id[RELIABLE_ACK_SIZE];
 };
 
+
+/** Use logic for initial packet to resend. I.e. only allow to resend the
+ * packet if also the \c REL_FLAG_RESEND_ALLOW is set */
+#define REL_FLAG_RESEND_INITIAL     (1<<0)
+/** The peer has sent a packet, this allows resending of our reply */
+#define REL_FLAG_RESEND_ALLOW       (1<<1)
+
 /**
- * The structure in which the reliability layer stores a single incoming
- * or outgoing packet.
- */
+* The structure in which the reliability layer stores a single incoming
+* or outgoing packet.
+*/
 struct reliable_entry
 {
     bool active;
     interval_t timeout;
     time_t next_try;
     packet_id_type packet_id;
-    size_t n_acks;  /* Number of acks received for packets with higher PID.
-                     * Used for fast retransmission when there were at least
-                     * N_ACK_RETRANSMIT. */
+    size_t n_acks;  /**< Number of acks received for packets with higher PID.
+                     *  Used for fast retransmission when there were at least
+                     *  N_ACK_RETRANSMIT. */
+    unsigned int flags; /**< flags to control resending to avoid
+                          * sending more responses than client's initial
+                          * packets to avoid amplification */
     int opcode;
     struct buffer buf;
 };
@@ -378,8 +388,12 @@ struct buffer *reliable_get_buf_output_sequenced(struct reliable *rel);
  *     reliable_get_buf_output_sequenced() into which the packet has been
  *     copied.
  * @param opcode The packet's opcode.
+ * @param initial_response consider this packet an initial response to
+ *                         on a connection and apply non amplification
+ *                         retry rules
  */
-void reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf, int opcode);
+void reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf,
+                                   int opcode, bool initial_response);
 
 /** @} name Functions for inserting outgoing packets */
 
@@ -462,6 +476,14 @@ interval_t reliable_send_timeout(const struct reliable *rel);
  */
 void reliable_schedule_now(struct reliable *rel);
 
+/**
+ * Marks all packets that are currently held back to avoid amplification
+ * as ready to be resend with the normal resend/timers.
+ * @param rel The reliable structure of which the entries should be
+ *     modified.
+ */
+void reliable_allow_reschedule_initial(struct reliable *rel);
+
 void reliable_debug_print(const struct reliable *rel, char *desc);
 
 /* set sending timeout (after this time we send again until ACK) */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 70b36779a..8a53817db 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2735,8 +2735,15 @@ tls_process(struct tls_multi *multi,
                 ks->must_negotiate = now + session->opt->handshake_window;
                 ks->auth_deferred_expire = now + auth_deferred_expire_window(session->opt);
 
+                /* session id defined serves here as a proxy for this is a
+                 * response to a reset from the other side or our initial
+                 * packet */
+                bool initial_reply = ks->initial_opcode != P_CONTROL_SOFT_RESET_V1
+                    && session_id_defined(&ks->session_id_remote);
+
                 /* null buffer */
-                reliable_mark_active_outgoing(ks->send_reliable, buf, ks->initial_opcode);
+                reliable_mark_active_outgoing(ks->send_reliable, buf,
+                                              ks->initial_opcode, initial_reply);
                 INCR_GENERATED;
 
                 ks->state = S_PRE_START;
@@ -2972,7 +2979,7 @@ tls_process(struct tls_multi *multi,
                 }
                 if (status == 1)
                 {
-                    reliable_mark_active_outgoing(ks->send_reliable, buf, P_CONTROL_V1);
+                    reliable_mark_active_outgoing(ks->send_reliable, buf, P_CONTROL_V1, false);
                     INCR_GENERATED;
                     state_change = true;
                     dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
@@ -3652,6 +3659,11 @@ tls_pre_decrypt(struct tls_multi *multi,
     /* Let our caller know we processed a control channel packet */
     ret = true;
 
+    /* we we have a packet from the peer, allow another initial response
+     * to the packet, on the first packet the queue is empty so nothing
+     * happens */
+    reliable_allow_reschedule_initial(ks->send_reliable);
+
     /*
      * Set our remote address and remote session_id
      */
-- 
2.32.0


