Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1E3C624DE
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0r6GIAvhN27AhsxoCpP3LNM10mSx8vnzF0C+mR+gmEM=; b=OOV0CYCdRQxGYJPZRgcTp8Xzfn
	h1OgU/2fF5eJtTzFzrngKOim/ECu6ZBbYPmsF/pK7dyN9w2/BsgjlhU/qa6kGxSKG56i9rCg/kAwG
	cGLRpCjEdINeoyASe0oMSR+y5TeMXxUrKe5E8GctJOtCRgg0UDJI2loBCmmgu16u7E9E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2WTN-0007W6-2z;
	Fri, 04 Sep 2026 16:09:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x2WTL-0007Vp-4G
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 16:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y4cZCPZSYl0GQD/6xBHkICnYgWi9fDvMDwfmedhLm3w=; b=KxF7bF3GKhy5dqomEzmZkDuSdo
 5+DyMIfILyYtFF/gxL9jyL58jurWEKVwUVW93QyxrCWe+NL08m+MDbIIwSvg2AE3y17DkY0XpZPAD
 lZ98vWch+dqSTAqQrko+fg9s0/cfczO+JJYmFir39LsFfPCldYqTRN4CEmc1vw90bZeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y4cZCPZSYl0GQD/6xBHkICnYgWi9fDvMDwfmedhLm3w=; b=CydhgZJrsUyD2nGQeM90i2Q+cu
 tIZnfufOz7oN+iwgyGtOnBiwzX+nJ3toEQf/Gz+rVvYz1blYa6bIqqFlWF5y2fqcv6xr+Z+9WnAdo
 3zdl/iwugzygHaJnIdZQH7xlsakeDQqbSLNuAxBUcORFgSDGU9y7NAV6SsHscuY6gFaE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2WTI-0003JS-GB for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 16:08:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 684G8nlr005567
 for <openvpn-devel@lists.sourceforge.net>; Fri, 4 Sep 2026 18:08:49 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 684G8nIo005566
 for openvpn-devel@lists.sourceforge.net; Fri, 4 Sep 2026 18:08:49 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  4 Sep 2026 18:08:42 +0200
Message-ID: <20260904160848.5553-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x2WTI-0003JS-GB
Subject: [Openvpn-devel] [PATCH v3] reliable: add unit tests for ACK and
 backoff DoS hardening
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

From: Lev Stipakov <lev@openvpn.net>

Add regression coverage for the reliability-layer denial-of-service fix
to test_packet_id, which already links reliable.c:

 - the retransmission timeout must stay positive and bounded no matter how
   often the fast-retransmit path is forced, so it can no longer overflow;
 - reliable_send_purge() must ignore ACKs for packet IDs that could never
   have been in flight (out of the send window, or wrapped-around), so a
   peer cannot inflate n_acks and force early retransmits;
 - a legitimate ACK for a real higher packet ID still removes that entry
   and counts towards fast retransmit (positive control).

These tests fail on the unfixed code and pass with the fix.

Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1894
Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1894
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index a5d50de..dc77553 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -372,6 +372,150 @@
 }
 
 
+/* The fix keeps the timeout well below this; the broken code grows past it.
+ * A plain number, so the test builds with or without the fix. */
+#define SANE_TIMEOUT_BOUND (10 * 1000 * 1000)
+
+static struct reliable *
+test_reliable_new(void)
+{
+    struct reliable *rel = malloc(sizeof(struct reliable));
+    assert_non_null(rel);
+    /* reliable_init() zeroes everything, so each test only sets the
+     * fields it actually needs. */
+    reliable_init(rel, 100, 50, 8, false);
+    rel->initial_timeout = 2;
+    return rel;
+}
+
+/*
+ * Each retransmit doubles the timeout. If a peer keeps forcing retransmits,
+ * the broken code doubles it forever: after about 30 rounds it overflows and
+ * turns zero or negative, and then the packet is resent nonstop (the flood).
+ * The fix caps the doubling. This test forces many retransmits and checks the
+ * timeout never overflows or grows without limit.
+ */
+static void
+test_reliable_backoff_is_bounded(void **state)
+{
+    (void)state;
+    now = 1000;
+
+    struct reliable *rel = test_reliable_new();
+
+    struct reliable_entry *e = &rel->array[0];
+    e->active = true;
+    e->packet_id = 1;
+    e->timeout = rel->initial_timeout;
+    rel->packet_id = 2;
+
+    for (int i = 0; i < 40; ++i)
+    {
+        /* make the packet due for a fast retransmit */
+        e->n_acks = N_ACK_RETRANSMIT;
+
+        int opcode;
+        struct buffer *buf = reliable_send(rel, &opcode);
+        /* our one active packet is the one picked to send */
+        assert_ptr_equal(buf, &e->buf);
+
+        /* a zero or negative timeout would resend with no delay (the flood) */
+        assert_true(e->timeout > 0);
+        /* the timeout must stop growing, not double forever */
+        assert_true(e->timeout <= SANE_TIMEOUT_BOUND);
+    }
+
+    reliable_free(rel);
+}
+
+/*
+ * An ACK should only count if it is for a packet we actually sent. If the
+ * broken code accepts ACKs for packets that were never sent, a peer can force
+ * early retransmits at will (which then feeds the timeout overflow above).
+ * These two cases send such bogus ACKs and check they are ignored.
+ */
+static void
+test_reliable_purge_ignores_forged_acks(void **state)
+{
+    (void)state;
+
+    /* Case (a): an ACK for pid 0x40000000, which we never sent (we only sent
+     * 0 and 1). The old "e->packet_id < pid" check treats it as newer and
+     * counts it. It should be ignored. */
+    {
+        struct reliable *rel = test_reliable_new();
+        struct reliable_entry *e = &rel->array[0];
+        e->active = true;
+        e->packet_id = 1;
+        rel->packet_id = 2; /* only pids 0 and 1 were ever sent */
+
+        struct reliable_ack ack = { .len = 1, .packet_id = { 0x40000000 } };
+        reliable_send_purge(rel, &ack);
+
+        /* the bogus ACK must not be counted */
+        assert_int_equal(e->n_acks, 0);
+        /* and must not drop our real packet */
+        assert_true(e->active);
+        reliable_free(rel);
+    }
+
+    /* Case (b): an ACK for pid 0xFFFFFFFF. It is inside the send window, so
+     * it passes the window check, but ids wrap around and 0xFFFFFFFF is really
+     * older than our pid 1. A plain "<" thinks it is newer and counts it; the
+     * wraparound-aware comparison must not. */
+    {
+        struct reliable *rel = test_reliable_new();
+        struct reliable_entry *e = &rel->array[0];
+        e->active = true;
+        e->packet_id = 1;
+        rel->packet_id = 2;
+
+        struct reliable_ack ack = { .len = 1, .packet_id = { 0xFFFFFFFF } };
+        reliable_send_purge(rel, &ack);
+
+        /* the bogus ACK must not be counted */
+        assert_int_equal(e->n_acks, 0);
+        /* and must not drop our real packet */
+        assert_true(e->active);
+        reliable_free(rel);
+    }
+}
+
+/*
+ * Sanity check: a real ACK must still work. Acknowledging a higher packet
+ * should drop that packet and count once towards resending the older one.
+ * The fix must not break this.
+ */
+static void
+test_reliable_purge_legitimate_ack(void **state)
+{
+    (void)state;
+
+    struct reliable *rel = test_reliable_new();
+
+    struct reliable_entry *e0 = &rel->array[0];
+    e0->active = true;
+    e0->packet_id = 1;
+
+    struct reliable_entry *e1 = &rel->array[1];
+    e1->active = true;
+    e1->packet_id = 2;
+
+    rel->packet_id = 3; /* pids 0,1,2 sent; 1 and 2 still waiting */
+
+    struct reliable_ack ack = { .len = 1, .packet_id = { 2 } };
+    reliable_send_purge(rel, &ack);
+
+    /* packet 2 was acked, so it is dropped */
+    assert_false(e1->active);
+    /* packet 1 is older, so it gets one ACK towards an early resend */
+    assert_int_equal(e0->n_acks, 1);
+    /* packet 1 was not acked, so it stays */
+    assert_true(e0->active);
+
+    reliable_free(rel);
+}
+
 int
 main(void)
 {
@@ -394,7 +538,10 @@
 
         cmocka_unit_test(test_get_num_output_sequenced_available),
         cmocka_unit_test(test_copy_acks_to_lru),
-        cmocka_unit_test(test_packet_id_window)
+        cmocka_unit_test(test_packet_id_window),
+        cmocka_unit_test(test_reliable_backoff_is_bounded),
+        cmocka_unit_test(test_reliable_purge_ignores_forged_acks),
+        cmocka_unit_test(test_reliable_purge_legitimate_ack)
 
     };
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
