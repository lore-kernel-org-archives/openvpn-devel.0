Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E95CA600C
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0S1ppQF8heX99tlJszf+xiyywRLFS9uO16Jlt9IPI0=; b=WNPdQOCWBXgLeiJaS5sjxFfkq4
	l01Cx4DbvVMCIVb/AcvIHfr42FL9qURi5bTl7Vw+BoDR0SAmt5ubtaSxG2opP/25K6KhkI9DUmnn1
	tgB8iRENFsTMNUT+iYvYmmDBhzmP28CZsYNn2Y6P/tS1H5RucAtpW3bgwFEGkPhYgq5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEv4p-0005HG-DV;
	Thu, 08 Oct 2026 20:50:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xEv4o-0005H9-Bp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 20:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E88mtcL7H7aC6jJVZONqyq4BbkH1fUbOHJk0/lm4W7s=; b=mQxr2FbXGDfIH5PiJaPiZXR5S8
 UIcRREJhBcHz0DrNCx7a3/d0F5bKgR7ZIyZ6INYZFOJAKnRoWGZV/b/6opEJW6G2GRCQReP7jV2ZT
 q0xftFHYsj9cv6bOrD5YnjU0KB+zoS7pW+VP38AojGFofweLPzCW6gPtDy/2RORq1D68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E88mtcL7H7aC6jJVZONqyq4BbkH1fUbOHJk0/lm4W7s=; b=RXS5/VvKckPE9/H4h+VClYZAYX
 TtRCM4WjNX6q0gKLzf3vZ+5nvaDm+rwoEwXQTLsMZSxO+10tnTWeTmQgN79/jTV6B/yQ2L/ZFQ4he
 kyL6SxMJBrfBa+M4DVMT3Gp/x+nDF/2KhZeTR7hXgXuhF/HrHhdqqF/uJt7HEY+bf+IQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEv4m-0002iO-PS for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 20:50:54 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 698KojKv028250
 for <openvpn-devel@lists.sourceforge.net>; Thu, 8 Oct 2026 22:50:45 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 698Koj6c028248
 for openvpn-devel@lists.sourceforge.net; Thu, 8 Oct 2026 22:50:45 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  8 Oct 2026 22:50:39 +0200
Message-ID: <20261008205045.28233-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
References: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xEv4m-0002iO-PS
Subject: [Openvpn-devel] [PATCH v3] reliable: fix the send window width
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

The check accepted the 11 ids below rel->packet_id where its documentation
said RELIABLE_CAPACITY. Twelve is right: reliable_get_buf_output_sequenced()
issues an id while it is less than rel->size beyond the oldest unacknowledged
one, so an entry can sit a full rel->size below rel->packet_id, and rel->size
may be RELIABLE_CAPACITY.

No effect today, TLS_RELIABLE_N_SEND_BUFFERS being 6. Raising the send buffer
count to RELIABLE_CAPACITY, which reliable_init() permits, would have
discarded the ACK for the oldest outstanding packet.

The width is now the extent passed to reliable_pid_in_range() rather than a
comparison operator.

Also renames validate_packet_id_window() to reliable_pid_in_send_window(),
returning bool and taking a const struct reliable * like its neighbours, and
the same const on reliable_get_num_output_sequenced_available().

Three doc comments described what the code does not do: the window bounds,
reliable_wont_break_sequentiality()'s reference id, subtract_pid()'s argument
order. reliable_mark_active_incoming() now states the precondition it asserts.

Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1901
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1901
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 645fbfd..c268cce 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -38,8 +38,9 @@
 
 #include "memdbg.h"
 
-/* calculates test - base while allowing for base or test wraparound. test is
- * assumed to be higher than base */
+/* calculates test - base while allowing for base or test wraparound. The
+ * result is only meaningful compared against a bound: on its own it does not
+ * say which id came first. */
 static inline packet_id_type
 subtract_pid(const packet_id_type test, const packet_id_type base)
 {
@@ -356,12 +357,11 @@
     return true;
 }
 
-int
-validate_packet_id_window(struct reliable *rel, packet_id_type pid)
+bool
+reliable_pid_in_send_window(const struct reliable *rel, packet_id_type pid)
 {
-    const packet_id_type dist = subtract_pid(rel->packet_id, pid);
-
-    return dist > 0 && dist < RELIABLE_CAPACITY;
+    return reliable_pid_in_range(pid, subtract_pid(rel->packet_id, RELIABLE_CAPACITY),
+                                 RELIABLE_CAPACITY);
 }
 
 /* del acknowledged items from send buf */
@@ -376,7 +376,7 @@
         packet_id_type pid = ack->packet_id[i];
 
 
-        if (!validate_packet_id_window(rel, pid))
+        if (!reliable_pid_in_send_window(rel, pid))
         {
             if (out_of_window == 0)
             {
@@ -566,7 +566,7 @@
 }
 
 int
-reliable_get_num_output_sequenced_available(struct reliable *rel)
+reliable_get_num_output_sequenced_available(const struct reliable *rel)
 {
     return rel->size - (int)reliable_oldest_active_distance(rel);
 }
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 04f3372..534feb3 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -190,15 +190,20 @@
 }
 
 /**
- * check that pid is inside the window of possible outstanding packets
- * of size RELIABLE_CAPACITY, ie inside the range
- * [rel->packet_id - RELIABLE_CAPACITY, rel->packet_id).
+ * Check whether pid is one of the RELIABLE_CAPACITY ids below rel->packet_id,
+ * and so could still be outstanding. rel->packet_id is the *next* id to be
+ * sent, so it is not itself in the window.
  *
- * rel->packet is the *next* packet id to be sent out, so it is not
- * included in the valid range.
+ * pid comes off the wire; all 2^32 values are handled.
+ *
+ * @param rel The reliable structure holding this tunnel's sent packets.
+ * @param pid A packet ID from a received acknowledgment.
+ *
+ * @return
+ * @li True, if pid is inside the window.
+ * @li False, otherwise.
  */
-int
-validate_packet_id_window(struct reliable *rel, packet_id_type pid);
+bool reliable_pid_in_send_window(const struct reliable *rel, packet_id_type pid);
 
 /**
  * Returns the number of packets that need to be acked.
@@ -305,14 +310,15 @@
  * Check that a received packet's ID can safely be stored in
  *     the reliable structure's processing window.
  *
- * This function checks the difference between the received packet's ID
- * and the lowest non-acknowledged packet ID in the given reliable
- * structure.  If that difference is larger than the total number of
- * packets which can be stored, then this packet cannot be stored safely,
- * because the reliable structure could possibly fill up without leaving
- * room for all intervening packets.  In that case, this received packet
- * could break the reliable structure's sequentiality, and must therefore
- * be discarded.
+ * Checks the received packet's ID against rel->packet_id, the next ID the
+ * reliability layer expects to hand upwards. One too far ahead could fill the
+ * structure without leaving room for the intervening packets, so it is
+ * discarded.
+ *
+ * IDs numerically below rel->packet_id are accepted here, an absolute
+ * comparison that an ID from before a wraparound does not pass.
+ * reliable_not_replay() rejects them, and they are still acknowledged so a
+ * peer whose ACK was lost stops retransmitting.
  *
  * @param rel The reliable structure for handling this VPN tunnel's
  *     received packets.
@@ -354,6 +360,10 @@
  * Mark the %reliable entry associated with the given buffer as active
  * incoming.
  *
+ * pid must be less than rel->size ahead of rel->packet_id. This is asserted,
+ * so run reliable_wont_break_sequentiality() and reliable_not_replay()
+ * first.
+ *
  * @param rel The reliable structure associated with this packet.
  * @param buf The buffer into which the packet has been copied.
  * @param pid The packet's packet ID.
@@ -446,7 +456,7 @@
  *  @return the number of buffer that are available for sending without
  *             breaking ack sequence
  * */
-int reliable_get_num_output_sequenced_available(struct reliable *rel);
+int reliable_get_num_output_sequenced_available(const struct reliable *rel);
 
 /**
  * Mark the reliable entry associated with the given buffer as
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index ac6c710..245c357 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -331,44 +331,50 @@
     struct reliable rel = { 0 };
     rel.packet_id = 1;
 
-    assert_true(validate_packet_id_window(&rel, 0));
+    assert_true(reliable_pid_in_send_window(&rel, 0));
 
     /* packet id 1 is outside the window as it is the *next* packet id */
-    assert_false(validate_packet_id_window(&rel, 1));
+    assert_false(reliable_pid_in_send_window(&rel, 1));
 
     /* wrapped around packet id, "-2" */
-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFFD));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFFD));
 
     /* wrapped around packet id, "-10" */
-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF6));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF6));
 
-    /* wrapped around packet id, "-11" */
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFF5));
-    assert_false(validate_packet_id_window(&rel, 0x80000000));
+    /* wrapped around packet id, "-11": the oldest id still in the window */
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF5));
+
+    /* one further back is outside it */
+    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFF4));
+    assert_false(reliable_pid_in_send_window(&rel, 0x80000000));
 
     rel.packet_id = 0x80000000;
 
     /* near the signed/usigned integer area */
-    assert_false(validate_packet_id_window(&rel, 0x80000001));
-    assert_true(validate_packet_id_window(&rel, 0x7fffffff));
-    assert_true(validate_packet_id_window(&rel, 0x7ffffff5));
-    assert_false(validate_packet_id_window(&rel, 0x7ffffff4));
+    assert_false(reliable_pid_in_send_window(&rel, 0x80000001));
+    assert_true(reliable_pid_in_send_window(&rel, 0x7fffffff));
+    assert_true(reliable_pid_in_send_window(&rel, 0x7ffffff5));
+    assert_true(reliable_pid_in_send_window(&rel, 0x7ffffff4));
+    assert_false(reliable_pid_in_send_window(&rel, 0x7ffffff3));
 
     rel.packet_id = 0xFFFFFFFD;
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFD));
-    assert_false(validate_packet_id_window(&rel, 0));
-    assert_false(validate_packet_id_window(&rel, 1));
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFE));
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFF));
-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF3));
-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF2));
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFF1));
+    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFFD));
+    assert_false(reliable_pid_in_send_window(&rel, 0));
+    assert_false(reliable_pid_in_send_window(&rel, 1));
+    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFFE));
+    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFFF));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF3));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF2));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF1));
+    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFF0));
 
     rel.packet_id = 500;
-    assert_false(validate_packet_id_window(&rel, 501));
-    assert_true(validate_packet_id_window(&rel, 497));
-    assert_true(validate_packet_id_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
-    assert_false(validate_packet_id_window(&rel, 500 - RELIABLE_CAPACITY));
+    assert_false(reliable_pid_in_send_window(&rel, 501));
+    assert_true(reliable_pid_in_send_window(&rel, 497));
+    assert_true(reliable_pid_in_send_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
+    assert_true(reliable_pid_in_send_window(&rel, 500 - RELIABLE_CAPACITY));
+    assert_false(reliable_pid_in_send_window(&rel, 500 - (RELIABLE_CAPACITY + 1)));
 }
 
 
@@ -533,21 +539,19 @@
     return (packet_id_type)(p1 - p2) >= 0x80000000u;
 }
 
-/* one short of RELIABLE_CAPACITY, which is what the code accepts today */
-#define CHARACTERIZED_SEND_WINDOW 11
-
 /* TLS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt.h, which this
  * test binary does not pull in */
 #define CHAR_N_SEND_BUFFERS    6
 #define CHAR_OPCODE_CONTROL_V1 4
 
-/* preserved: the ids validate_packet_id_window() accepts */
+/* introduced: the RELIABLE_CAPACITY ids below rel->packet_id.
+ * validate_packet_id_window() stopped one short of that. */
 static bool
 ref_pid_in_send_window(const struct reliable *rel, packet_id_type pid)
 {
     const packet_id_type dist = (packet_id_type)(rel->packet_id - pid);
 
-    return dist >= 1 && dist <= CHARACTERIZED_SEND_WINDOW;
+    return dist >= 1 && dist <= RELIABLE_CAPACITY;
 }
 
 /* preserved: reliable_pid_in_range2() */
@@ -798,7 +802,7 @@
                 rel.packet_id = anchors[a];
 
                 assert_int_equal(ref_pid_in_send_window(&rel, ids[i]),
-                                 validate_packet_id_window(&rel, ids[i]) != 0);
+                                 reliable_pid_in_send_window(&rel, ids[i]));
             }
         }
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
