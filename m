Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08E1CA600E
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Xkc2HPBG+WJCKASLY79oKPtM1YEXk7rtUxl0rQtXzM=; b=Ssv2A/W9ff4i5awGDuk7+H3zk4
	v0J9EI+80C4xIdfc/mS2Hw4DwNjv/Os3bfVz8hGi2uC633h8X4w+qH6Zb5Ml2vQdY17CgB2b9QUZD
	baXr8cVpEItrzHpVmOeXYwOpAY8SX0/0hq+R6IaqSj0l5ZrFPsoAfpDmz2inZ8ZrJKbs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEv5n-0001NR-C9;
	Thu, 08 Oct 2026 20:51:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xEv5l-0001NI-UU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 20:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i684JQYfoYY8tdg3FunAFb/Gf4AwvTp955YNYXZ1x3M=; b=A7tclUNFK/i5vnoEoHRumrZsWj
 l56KbcQVVw3BZbbdu8sv8cBwb7DHSDaI9YOgO8G+52O3vtZnRK5vjfwO8QfllLXB/vg933tUa4+zR
 rk0YdOvAtD56JcvgI46p1qeOwGXetHuCLdz9300vG3EbGrIpcTb4d74T+ws1fluZhZLo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i684JQYfoYY8tdg3FunAFb/Gf4AwvTp955YNYXZ1x3M=; b=YhQifxWlhdSdmzBRM0NUrHbJqY
 grvBnCTccxvbIU9W8eCfhL5shnEfVWsnrW54oTKq9RSSh0evEJ9h8rgE0Xk28gXOim/Imh17DomQ3
 UIV5FdFufZAjxZiNM894CA27/SGUzy8qPugVybEZdyhWvzTu4AKUAhNdzU/8W8u7YVhg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEv5h-0005PE-Qk for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 20:51:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 698Kph7h028467
 for <openvpn-devel@lists.sourceforge.net>; Thu, 8 Oct 2026 22:51:43 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 698KphN8028466
 for openvpn-devel@lists.sourceforge.net; Thu, 8 Oct 2026 22:51:43 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  8 Oct 2026 22:51:37 +0200
Message-ID: <20261008205143.28452-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xEv5h-0005PE-Qk
Subject: [Openvpn-devel] [PATCH v3] reliable: drop the half-space packet id
 comparisons
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Razvan Cojocaru <razvanc@mailbox.org>

Every comparison becomes a modular distance against a stated bound.
subtract_pid() stays and reliable_pid_in_range1() loses its suffix;
reliable_pid_min() and reliable_pid_in_range2() go, and with them the last
0x80000000 in the file.

The three scans for the oldest unacknowledged entry now track the largest
distance below rel->packet_id, bounded by rel->size, in
reliable_oldest_active_distance(). reliable_wont_break_sequentiality() bounds
the distance ahead and accepts past ids outright, as the old comparison did
without the 0x80000000 bias.

reliable_can_send() counts the same entries without the window bound and its
caller asserts on the result, so reliable_send() falls back to any eligible
entry when the bound leaves nothing.

Equivalent for every reachable input. Four deliberate differences:

- Once rel->packet_id + rel->size overflows, the absolute clause makes
  reliable_wont_break_sequentiality() permissive: ids the old bias branch
  rejected are acknowledged. Nothing more is stored, reliable_not_replay()
  still bounding that to the receive window, which wraps with rel->packet_id.
  Needs ~2^32 control channel packets in one key state.
- Above 2^31, an id absolutely below rel->packet_id + rel->size but more than
  rel->size ahead is acknowledged and no longer stored: it can never equal
  rel->packet_id, so its slot was held for the rest of the key state. Needs
  ~2^31 such packets; test_recv_filter_high_base's oracle switches to the new
  rule there, pinning behaviour rather than equivalence.
- The ASSERT in reliable_mark_active_incoming() is the receive window rather
  than a half space, and runs before the entry is touched. Unobservable: it
  repeats the check reliable_not_replay() makes immediately before it.
- A send entry more than rel->size below rel->packet_id is ignored by the
  scans instead of taken for a very old one, so
  reliable_get_num_output_sequenced_available() can no longer go negative.
  reliable_get_buf_output_sequenced() keeps every distance within rel->size,
  so it never could.

Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1900
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1900
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index b5315ff..645fbfd 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -50,46 +50,12 @@
  * verify that test - base < extent while allowing for base or test wraparound
  */
 static inline bool
-reliable_pid_in_range1(const packet_id_type test, const packet_id_type base,
-                       const unsigned int extent)
+reliable_pid_in_range(const packet_id_type test, const packet_id_type base,
+                      const unsigned int extent)
 {
     return subtract_pid(test, base) < extent;
 }
 
-/*
- * verify that test < base + extent while allowing for base or test wraparound
- */
-static inline bool
-reliable_pid_in_range2(const packet_id_type test, const packet_id_type base,
-                       const unsigned int extent)
-{
-    if (base + extent >= base)
-    {
-        if (test < base + extent)
-        {
-            return true;
-        }
-    }
-    else
-    {
-        if ((test + 0x80000000u) < (base + 0x80000000u) + extent)
-        {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-/*
- * verify that p1 < p2  while allowing for p1 or p2 wraparound
- */
-static inline bool
-reliable_pid_min(const packet_id_type p1, const packet_id_type p2)
-{
-    return !reliable_pid_in_range1(p1, p2, 0x80000000u);
-}
-
 /* check if a particular packet_id is present in ack */
 static inline bool
 reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
@@ -393,8 +359,9 @@
 int
 validate_packet_id_window(struct reliable *rel, packet_id_type pid)
 {
-    return reliable_pid_min(pid, rel->packet_id)
-           && reliable_pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+    const packet_id_type dist = subtract_pid(rel->packet_id, pid);
+
+    return dist > 0 && dist < RELIABLE_CAPACITY;
 }
 
 /* del acknowledged items from send buf */
@@ -440,14 +407,17 @@
                 e->active = false;
             }
 
-            if (e->active && reliable_pid_min(e->packet_id, pid))
+            /* Order the two by their distance below rel->packet_id, as
+             * comparing the ids directly misorders them across the wrap.
+             * Entries further back than rel->size are outside the send window
+             * and left alone. An ACK for a higher pid means this packet
+             * arrived out of order or was lost, and enough of them trigger
+             * the early resend. */
+            const packet_id_type e_dist = subtract_pid(rel->packet_id, e->packet_id);
+
+            if (e->active && e_dist <= (packet_id_type)rel->size
+                && e_dist > subtract_pid(rel->packet_id, pid))
             {
-                /* We have received an ACK for a packet with a higher PID. Either
-                 * we have received ACKs out of or order or the packet has been
-                 * lost. We count the number of ACKs to determine if we should
-                 * resend it early. The comparison needs to be wraparound aware,
-                 * otherwise a peer can inflate n_acks with an ACK for a pid from
-                 * the lower half of the id space and force a retransmit. */
                 e->n_acks++;
             }
         }
@@ -505,7 +475,9 @@
 reliable_not_replay(const struct reliable *rel, packet_id_type id)
 {
     struct gc_arena gc = gc_new();
-    if (reliable_pid_min(id, rel->packet_id))
+
+    /* outside the receive window: already consumed, or too far ahead to store */
+    if (!reliable_pid_in_range(id, rel->packet_id, rel->size))
     {
         goto bad;
     }
@@ -531,7 +503,12 @@
 bool
 reliable_wont_break_sequentiality(const struct reliable *rel, packet_id_type id)
 {
-    const int ret = reliable_pid_in_range2(id, rel->packet_id, rel->size);
+    /* The first clause is the receive window. The second is an absolute
+     * comparison, kept so that already consumed ids still reach
+     * reliable_ack_acknowledge_packet_id() and a peer whose ACK was lost stops
+     * retransmitting; reliable_not_replay() rejects them. */
+    const bool ret = (subtract_pid(id, rel->packet_id) < (packet_id_type)rel->size
+                      || id < rel->packet_id);
 
     if (!ret)
     {
@@ -562,57 +539,46 @@
     return NULL;
 }
 
-int
-reliable_get_num_output_sequenced_available(struct reliable *rel)
+/* Distance below rel->packet_id of the oldest unacknowledged entry, 0 if there
+ * is none. Entries more than rel->size away are outside the sequencing window
+ * and ignored, rather than taken for very old ones. */
+static packet_id_type
+reliable_oldest_active_distance(const struct reliable *rel)
 {
-    packet_id_type min_id = 0;
-    bool min_id_defined = false;
+    packet_id_type max_dist = 0;
 
-    /* find minimum active packet_id */
     for (int i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
-        if (e->active)
+        if (!e->active)
         {
-            if (!min_id_defined || reliable_pid_min(e->packet_id, min_id))
-            {
-                min_id_defined = true;
-                min_id = e->packet_id;
-            }
+            continue;
+        }
+
+        const packet_id_type dist = subtract_pid(rel->packet_id, e->packet_id);
+        if (dist <= (packet_id_type)rel->size && dist > max_dist)
+        {
+            max_dist = dist;
         }
     }
 
-    int ret = rel->size;
-    if (min_id_defined)
-    {
-        ret -= subtract_pid(rel->packet_id, min_id);
-    }
-    return ret;
+    return max_dist;
+}
+
+int
+reliable_get_num_output_sequenced_available(struct reliable *rel)
+{
+    return rel->size - (int)reliable_oldest_active_distance(rel);
 }
 
 /* grab a free buffer, fail if buffer clogged by unacknowledged low packet IDs */
 struct buffer *
 reliable_get_buf_output_sequenced(struct reliable *rel)
 {
-    packet_id_type min_id = 0;
-    bool min_id_defined = false;
     struct buffer *ret = NULL;
 
-    /* find minimum active packet_id */
-    for (int i = 0; i < rel->size; ++i)
-    {
-        const struct reliable_entry *e = &rel->array[i];
-        if (e->active)
-        {
-            if (!min_id_defined || reliable_pid_min(e->packet_id, min_id))
-            {
-                min_id_defined = true;
-                min_id = e->packet_id;
-            }
-        }
-    }
-
-    if (!min_id_defined || reliable_pid_in_range1(rel->packet_id, min_id, rel->size))
+    /* keep the next id within rel->size of the oldest unacknowledged one */
+    if (reliable_oldest_active_distance(rel) < (packet_id_type)rel->size)
     {
         ret = reliable_get_buf(rel);
     }
@@ -671,6 +637,8 @@
 reliable_send(struct reliable *rel, int *opcode)
 {
     struct reliable_entry *best = NULL;
+    struct reliable_entry *eligible = NULL;
+    packet_id_type best_dist = 0;
     const time_t local_now = now;
 
     for (int i = 0; i < rel->size; ++i)
@@ -682,13 +650,29 @@
          * not expired yet. */
         if (e->active && (e->n_acks >= N_ACK_RETRANSMIT || local_now >= e->next_try))
         {
-            if (!best || reliable_pid_min(e->packet_id, best->packet_id))
+            /* oldest = furthest below rel->packet_id, within the window */
+            const packet_id_type dist = subtract_pid(rel->packet_id, e->packet_id);
+            if (dist <= (packet_id_type)rel->size && dist > best_dist)
             {
                 best = e;
+                best_dist = dist;
+            }
+
+            if (!eligible)
+            {
+                eligible = e;
             }
         }
     }
 
+    /* reliable_can_send() promises a non-NULL result for these same entries
+     * without applying the window bound, and its caller asserts on that, so
+     * never come back empty while one of them is eligible. */
+    if (!best)
+    {
+        best = eligible;
+    }
+
     if (best)
     {
         /* The initial timeout is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so
@@ -776,14 +760,14 @@
         struct reliable_entry *e = &rel->array[i];
         if (buf == &e->buf)
         {
+            /* storable and not yet consumed, checked before touching the entry */
+            ASSERT(reliable_pid_in_range(pid, rel->packet_id, rel->size));
+
             e->active = true;
 
             /* packets may not arrive in sequential order */
             e->packet_id = pid;
 
-            /* check for replay */
-            ASSERT(!reliable_pid_min(pid, rel->packet_id));
-
             e->opcode = opcode;
             e->next_try = 0;
             e->timeout = 0;
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index a85f2e9..04f3372 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -288,15 +288,16 @@
 bool reliable_can_get(const struct reliable *rel);
 
 /**
- * Check that a received packet's ID is not a replay.
+ * Check that a received packet's ID is not a replay and is inside the receive
+ * window.
  *
  * @param rel The reliable structure for handling this VPN tunnel's
  *     received packets.
  * @param id The packet ID of the received packet.
  *
  * @return
- * @li True, if the packet ID is not a replay.
- * @li False, if the packet ID is a replay.
+ * @li True, if the packet ID is new and inside the receive window.
+ * @li False, if it is a replay, or too far ahead to be stored.
  */
 bool reliable_not_replay(const struct reliable *rel, packet_id_type id);
 
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index aabb555..ac6c710 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -517,13 +517,16 @@
 }
 
 /*
- * Reference implementations of the packet id comparisons as they behave today.
- * The sweeps below assert reliable.c agrees with them at the anchors swept, so
- * a change to an accepted id set there fails a test. Keep them standalone:
- * expressing them in terms of reliable.c would make the sweeps tautologies.
+ * Independent models of the id sets the packet id comparisons accept. The
+ * sweeps below assert reliable.c agrees with them at the anchors swept, so a
+ * change to an accepted id set there fails a test. Each model is tagged
+ * "preserved" or "introduced" against the comparisons that came before. Keep
+ * them standalone: expressing them in terms of reliable.c would make the
+ * sweeps tautologies.
  */
 
-/* "p1 < p2" with the 2^31 horizon, i.e. ((int32_t)(p1 - p2) < 0) */
+/* the dropped reliable_pid_min(): "p1 < p2" with the 2^31 horizon,
+ * i.e. ((int32_t)(p1 - p2) < 0) */
 static bool
 ref_pid_min(packet_id_type p1, packet_id_type p2)
 {
@@ -538,6 +541,7 @@
 #define CHAR_N_SEND_BUFFERS    6
 #define CHAR_OPCODE_CONTROL_V1 4
 
+/* preserved: the ids validate_packet_id_window() accepts */
 static bool
 ref_pid_in_send_window(const struct reliable *rel, packet_id_type pid)
 {
@@ -546,6 +550,7 @@
     return dist >= 1 && dist <= CHARACTERIZED_SEND_WINDOW;
 }
 
+/* preserved: reliable_pid_in_range2() */
 static bool
 ref_wont_break_sequentiality(const struct reliable *rel, packet_id_type id)
 {
@@ -559,6 +564,7 @@
     return id < base + extent;
 }
 
+/* preserved: the horizon check, then the slot scan */
 static bool
 ref_not_replay(const struct reliable *rel, packet_id_type id)
 {
@@ -691,6 +697,54 @@
     }
 }
 
+/* Once rel->packet_id + rel->size overflows, the absolute clause makes
+ * reliable_wont_break_sequentiality() permissive; what may be stored is still
+ * the receive window, which wraps with it. */
+static void
+test_recv_window_bounded_at_wrap(void **state)
+{
+    struct reliable rel = { 0 };
+    rel.size = RELIABLE_CAPACITY;
+    rel.packet_id = 0xFFFFFFF8;
+
+    assert_int_equal(RECV_STORE, recv_filter(&rel, 0xFFFFFFF8));
+    assert_int_equal(RECV_STORE, recv_filter(&rel, 0xFFFFFFFF));
+    assert_int_equal(RECV_STORE, recv_filter(&rel, 3));
+
+    /* one past the window, and one behind it: acknowledged, never stored */
+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&rel, 4));
+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&rel, 0xFFFFFFF7));
+}
+
+/* The id the receiver is next waiting for has to be storable at every base,
+ * the packet id wrap included. */
+static void
+test_wont_break_sequentiality_accepts_next_id(void **state)
+{
+    const packet_id_type bases[] = {
+        0,
+        1,
+        500,
+        0x7FFFFFFF,
+        0x80000000,
+        0xFFFFFFF3,
+        0xFFFFFFF4,
+        0xFFFFFFF8,
+        0xFFFFFFFE,
+        0xFFFFFFFF,
+    };
+
+    for (size_t i = 0; i < SIZE(bases); i++)
+    {
+        struct reliable rel = { 0 };
+        rel.size = RELIABLE_CAPACITY;
+        rel.packet_id = bases[i];
+
+        assert_true(reliable_wont_break_sequentiality(&rel, rel.packet_id));
+        assert_true(reliable_not_replay(&rel, rel.packet_id));
+    }
+}
+
 /* bases at or below 2^31, where old and new agree; never to change */
 static void
 test_recv_filter_characterization(void **state)
@@ -698,12 +752,31 @@
     sweep_recv_filter(char_anchors, SIZE(char_anchors), ref_recv_filter);
 }
 
+/* Introduced, for the bases above 2^31 only: storing also requires the id to
+ * be inside the receive window. The ids between one further ahead and
+ * rel->packet_id cannot all fit alongside it, so rel->packet_id never reaches
+ * it and the slot is held for the rest of the key state. Still ACKed, like a
+ * replay. */
+static enum recv_verdict
+ref_recv_filter_bounded(const struct reliable *rel, packet_id_type id)
+{
+    const enum recv_verdict verdict = ref_recv_filter(rel, id);
+
+    if (verdict == RECV_STORE
+        && (packet_id_type)(id - rel->packet_id) >= (packet_id_type)rel->size)
+    {
+        return RECV_ACK_ONLY;
+    }
+
+    return verdict;
+}
+
 /* bases above 2^31, where they diverge, kept apart so a change confined
  * there touches one test */
 static void
 test_recv_filter_high_base(void **state)
 {
-    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high), ref_recv_filter);
+    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high), ref_recv_filter_bounded);
 }
 
 static void
@@ -739,6 +812,60 @@
     sweep_send_window(char_anchors_high, SIZE(char_anchors_high));
 }
 
+/* The window bound in the selection is what stops an entry sitting ahead of
+ * rel->packet_id from being taken for the oldest one: its distance below
+ * rel->packet_id is then nearly the whole id space. array[0] cannot arise
+ * through the API; array[1] is an ordinary outstanding packet. */
+static void
+test_reliable_send_ignores_entry_ahead(void **state)
+{
+    now = 1000;
+
+    struct reliable rel = { 0 };
+    rel.size = CHAR_N_SEND_BUFFERS;
+    rel.initial_timeout = 2;
+    rel.packet_id = 3;
+
+    /* scanned first, and outside the window */
+    rel.array[0].active = true;
+    rel.array[0].packet_id = 0x40000000;
+    rel.array[0].timeout = 2;
+    rel.array[0].next_try = 0;
+
+    /* a genuine outstanding packet, two below rel->packet_id */
+    rel.array[1].active = true;
+    rel.array[1].packet_id = 1;
+    rel.array[1].timeout = 2;
+    rel.array[1].next_try = 0;
+
+    int opcode = 0;
+    assert_ptr_equal(&rel.array[1].buf, reliable_send(&rel, &opcode));
+}
+
+/* reliable_can_send() promises reliable_send() will hand back a buffer, and
+ * its caller asserts on that. The state below cannot arise through the API --
+ * the entry sits outside the send window -- but the two must not be able to
+ * disagree. */
+static void
+test_reliable_send_matches_can_send(void **state)
+{
+    now = 1000;
+
+    struct reliable rel = { 0 };
+    rel.size = CHAR_N_SEND_BUFFERS;
+    rel.initial_timeout = 2;
+    rel.packet_id = 3;
+
+    rel.array[0].active = true;
+    rel.array[0].packet_id = 0x40000000;
+    rel.array[0].timeout = 2;
+    rel.array[0].next_try = 0;
+
+    int opcode = 0;
+    assert_true(reliable_can_send(&rel));
+    assert_non_null(reliable_send(&rel, &opcode));
+}
+
 /* reliable_send() picks the oldest eligible entry, across the wrap and the
  * signed midpoint */
 static void
@@ -880,10 +1007,14 @@
         cmocka_unit_test(test_reliable_backoff_is_bounded),
         cmocka_unit_test(test_reliable_purge_ignores_forged_acks),
         cmocka_unit_test(test_reliable_purge_legitimate_ack),
+        cmocka_unit_test(test_wont_break_sequentiality_accepts_next_id),
+        cmocka_unit_test(test_recv_window_bounded_at_wrap),
         cmocka_unit_test(test_recv_filter_characterization),
         cmocka_unit_test(test_recv_filter_high_base),
         cmocka_unit_test(test_send_window_characterization),
         cmocka_unit_test(test_reliable_send_picks_oldest),
+        cmocka_unit_test(test_reliable_send_ignores_entry_ahead),
+        cmocka_unit_test(test_reliable_send_matches_can_send),
         cmocka_unit_test(test_get_buf_output_sequenced_boundary),
         cmocka_unit_test(test_mark_active_incoming_accepts_window),
 #ifndef _MSC_VER


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
