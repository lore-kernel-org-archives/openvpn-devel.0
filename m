Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF40CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9M4mfYw6hSLTGQOwHsUU+FcLsyrN33JAknMb6HirM8=; b=O5KdVwt50eIpnmGNAwl/uhQaH1
	OF23WP++sE90NENeg1uW6+Doms7GHvbyyOfpiYu5eIX1l0s2CtFWM8LmCs5upBqUVWbt411C0lpuc
	DM3eYYzGnqd7cURM4r/GQHZpWdunI7/8+e0770RR0FpnLuNqJVRvq5ZDcMR9VVKzUTvk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDiKn-0003cx-Fl;
	Mon, 05 Oct 2026 13:02:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xDiKl-0003ck-VY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lh3jQqjt25zGYgZkarUfnBWdjNmY904fXLmSDA+qD4c=; b=SLc9v9sMZS5YHwxhDcmBql/9F7
 sRoN4B5MeRrK4GTyPcE8oY8GVareYaXm6cmLFgE9hB5D/wFSBFE67RQwq9NWkh1J/oSZhwenm1Pug
 0uB+kHQNa2DlYDDByWw0a8OoR8FCppX9UmesP/74PZl9oZDeTmvKN7B5NEao8T6uWzso=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lh3jQqjt25zGYgZkarUfnBWdjNmY904fXLmSDA+qD4c=; b=USwsUjpA1AAt22I8kD1Gw6kFPk
 28R+7nOFd9taHLF/aR64UBHWjQBexFkbLGF3IaWqITTWfed4aokRJm8PdMA0zsAqFvumnvWsJPJnv
 /pc77bYlqNC6NNv2GVuKlzL/cCmv+5Z8WtvvyZ8o24z0Qmw82decutZPUvpYZlcmFrmw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDiKl-0007lY-D1 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:02:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 695D2G6g025854
 for <openvpn-devel@lists.sourceforge.net>; Mon, 5 Oct 2026 15:02:16 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 695D2GH2025852
 for openvpn-devel@lists.sourceforge.net; Mon, 5 Oct 2026 15:02:16 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  5 Oct 2026 15:02:08 +0200
Message-ID: <20261005130215.25812-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
References: <gerrit.1790611935000.I9579ab9a3f588a3841bb90c9a4b930b7690e0b71@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xDiKl-0007lY-D1
Subject: [Openvpn-devel] [PATCH v2] mbuf: don't count dereferenced items in
 the queue length
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

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

Items of a closed instance are cleared in place, because head + len is
the ring's insertion point.  mbuf_extract_item() reclaims such holes as
it walks past them, but nothing does once no live item is left behind
them, so ms->len keeps counting slots that can never be sent.

mbuf_defined() and mbuf_peek() then disagree about whether the queue
holds anything, and a ring made of nothing but holes still looks full
to mbuf_add_item(), which tries to make room by dropping the oldest
packet and finds nothing it can drop.

A UDP socket hides this, as the IOW_MBUF write event reclaims the holes
on its way out; a TCP-only server has nothing that does.

Reclaim the holes once they reach the head, so a ring that holds no live
item at all cannot keep looking full.  Holes sitting behind a live item
are still counted, but an extract walking past them takes them along,
and mbuf_add_item() always has the live head left to evict.

Change-Id: I9579ab9a3f588a3841bb90c9a4b930b7690e0b71
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1961
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1961
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 7b790ed..5bb397f 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -85,6 +85,21 @@
     }
 }
 
+/*
+ * Dereferenced items cannot be removed from the middle of the ring, so
+ * reclaim them once they reach the head: a ring left without any live
+ * item must not keep looking full.
+ */
+static void
+mbuf_reclaim_head(struct mbuf_set *ms)
+{
+    while (ms->len && !ms->array[ms->head].instance)
+    {
+        ms->head = MBUF_INDEX(ms->head, 1, ms->capacity);
+        --ms->len;
+    }
+}
+
 void
 mbuf_add_item(struct mbuf_set *ms, const struct mbuf_item *item)
 {
@@ -125,6 +140,7 @@
                 break;
             }
         }
+        mbuf_reclaim_head(ms);
     }
     return ret;
 }
@@ -164,5 +180,6 @@
                 msg(D_MBUF, "MBUF: dereferenced queued packet");
             }
         }
+        mbuf_reclaim_head(ms);
     }
 }
diff --git a/tests/unit_tests/openvpn/test_mbuf.c b/tests/unit_tests/openvpn/test_mbuf.c
index cba4da7..61d438b 100644
--- a/tests/unit_tests/openvpn/test_mbuf.c
+++ b/tests/unit_tests/openvpn/test_mbuf.c
@@ -136,9 +136,9 @@
     mbuf_dereference_instance(ms, &mi2);
     assert_int_equal(mbuf_buf->refcount, 2);
     assert_int_equal(mbuf_buf2->refcount, 1);
-    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mbuf_len(ms), 1);
     assert_int_equal(mbuf_maximum_queued(ms), 4);
-    assert_int_equal(ms->head, 3);
+    assert_int_equal(ms->head, 1);
     assert_ptr_equal(mbuf_peek(ms), &mi);
 
     mbuf_free(ms);
@@ -148,12 +148,151 @@
     mbuf_free_buf(mbuf_buf2);
 }
 
+/* a queue holding nothing but dereferenced items is an empty queue */
+static void
+test_mbuf_dereference_reclaims_queue(void **state)
+{
+    struct mbuf_set *ms = mbuf_init(4);
+    struct multi_instance mi = { 0 };
+    struct buffer buf = alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf = mbuf_alloc_buf(&buf);
+    struct mbuf_item item = { .buffer = mbuf_buf, .instance = &mi };
+    free_buf(&buf);
+
+    for (int i = 0; i < 4; ++i)
+    {
+        mbuf_add_item(ms, &item);
+    }
+    assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_buf->refcount, 5);
+
+    mbuf_dereference_instance(ms, &mi);
+
+    assert_int_equal(mbuf_len(ms), 0);
+    assert_false(mbuf_defined(ms));
+    assert_null(mbuf_peek(ms));
+    assert_int_equal(mbuf_buf->refcount, 1);
+
+    /* the queue is empty, so this must be queued and not dropped */
+    mbuf_add_item(ms, &item);
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* extracting the last live item must not leave a trailing hole behind */
+static void
+test_mbuf_extract_reclaims_tail(void **state)
+{
+    struct mbuf_set *ms = mbuf_init(4);
+    struct multi_instance mi = { 0 };
+    struct multi_instance mi2 = { 0 };
+    struct buffer buf = alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf = mbuf_alloc_buf(&buf);
+    struct mbuf_item item = { .buffer = mbuf_buf, .instance = &mi };
+    struct mbuf_item item2 = { .buffer = mbuf_buf, .instance = &mi2 };
+    free_buf(&buf);
+
+    mbuf_add_item(ms, &item);
+    mbuf_add_item(ms, &item2);
+    mbuf_dereference_instance(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 2); /* head is still live, nothing to reclaim */
+
+    struct mbuf_item out;
+    assert_true(mbuf_extract_item(ms, &out));
+    assert_ptr_equal(out.instance, &mi);
+    mbuf_free_buf(out.buffer);
+
+    assert_int_equal(mbuf_len(ms), 0);
+    assert_false(mbuf_defined(ms));
+    assert_null(mbuf_peek(ms));
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* reclaiming stops at the first live item, it does not walk the whole ring */
+static void
+test_mbuf_extract_reclaims_up_to_live(void **state)
+{
+    struct mbuf_set *ms = mbuf_init(4);
+    struct multi_instance mi = { 0 };
+    struct multi_instance mi2 = { 0 };
+    struct buffer buf = alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf = mbuf_alloc_buf(&buf);
+    struct mbuf_item item = { .buffer = mbuf_buf, .instance = &mi };
+    struct mbuf_item item2 = { .buffer = mbuf_buf, .instance = &mi2 };
+    free_buf(&buf);
+
+    /* [mi][mi2][mi] -> dereferencing mi2 leaves [mi][hole][mi] */
+    mbuf_add_item(ms, &item);
+    mbuf_add_item(ms, &item2);
+    mbuf_add_item(ms, &item);
+    mbuf_dereference_instance(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 3); /* head is live, nothing to reclaim yet */
+
+    /* extracting the head leaves the hole in front: it must be reclaimed, and
+     * the walk must stop at the live item behind it */
+    struct mbuf_item out;
+    assert_true(mbuf_extract_item(ms, &out));
+    assert_ptr_equal(out.instance, &mi);
+    mbuf_free_buf(out.buffer);
+
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_true(mbuf_defined(ms));
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
+/* Holes behind a live item are not reclaimed, so a full ring can still hold
+ * them. mbuf_add_item() must cope: it evicts the live head, which drags the
+ * holes with it, rather than finding nothing to drop. */
+static void
+test_mbuf_add_on_full_queue_with_holes(void **state)
+{
+    struct mbuf_set *ms = mbuf_init(4);
+    struct multi_instance mi = { 0 };
+    struct multi_instance mi2 = { 0 };
+    struct multi_instance mi3 = { 0 };
+    struct buffer buf = alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf = mbuf_alloc_buf(&buf);
+    struct mbuf_item item = { .buffer = mbuf_buf, .instance = &mi };
+    struct mbuf_item item2 = { .buffer = mbuf_buf, .instance = &mi2 };
+    struct mbuf_item item3 = { .buffer = mbuf_buf, .instance = &mi3 };
+    free_buf(&buf);
+
+    /* [mi][mi2][mi2][mi2] -> dereferencing mi2 leaves [mi][hole][hole][hole],
+     * which mbuf_reclaim_head() cannot touch: the head is still live */
+    mbuf_add_item(ms, &item);
+    mbuf_add_item(ms, &item2);
+    mbuf_add_item(ms, &item2);
+    mbuf_add_item(ms, &item2);
+    mbuf_dereference_instance(ms, &mi2);
+    assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_len(ms), ms->capacity); /* still counts as full */
+
+    mbuf_add_item(ms, &item3);
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_ptr_equal(mbuf_peek(ms), &mi3);
+
+    mbuf_free(ms);
+    mbuf_free_buf(mbuf_buf);
+}
+
 int
 main(void)
 {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_mbuf_init),
         cmocka_unit_test(test_mbuf_add_remove),
+        cmocka_unit_test(test_mbuf_dereference_reclaims_queue),
+        cmocka_unit_test(test_mbuf_extract_reclaims_tail),
+        cmocka_unit_test(test_mbuf_extract_reclaims_up_to_live),
+        cmocka_unit_test(test_mbuf_add_on_full_queue_with_holes),
     };
 
     return cmocka_run_group_tests_name("mbuf", tests, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
