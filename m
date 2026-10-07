Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0117CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MjynGvGfUcP4EzC7+sAznR3o+GgsoXhEhsWTXwHmyYM=; b=ToZmH8brb9cU+N8+IMImO1ui5Z
	hysmJIonkCodt9DF76kvEpDkcBDafJBCbKVEijuBdrDeiGthNtdIFCpS0bK8qvcOQqgdggZ4/c+FY
	Fw4IQdcgOC6/5tdMLLJMSmFNKK6fdiHtAlJZdiNMV5Aty522qRJyHgK2CPopVofAvZhI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEVJU-0001nU-DW;
	Wed, 07 Oct 2026 17:20:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xEVJS-0001nO-I6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e98htL+0F7KDGrF1PHjNXDh2hJvQZi5CP3jS43m5D8A=; b=CtW28ILebcB6i55YUJSa5s36W0
 vr6cSmQL/cSX6JYjmYAa6s56ifH5oz5N6yO0NIIYZ2lUTGIbMxeT759bzFiipfkGxmecCn7R4xE9p
 hVO8B6hVSqTBl/fF5k07FpXYcmPmk4vDCe6xR50Ggc5iN8q50Eyx4llnsIw6tlMId28k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e98htL+0F7KDGrF1PHjNXDh2hJvQZi5CP3jS43m5D8A=; b=DCiNLoi0zzaRYYbWgMhqFZtV6c
 YwlRtwAj4Bez3AkREA4z6orQTw4xqMOtfRUSOpo9gncvjQ7rffJNSylUMJ1CSpY64/2ZSzueaTYKV
 pif0WxSZAiz7V05D+SCZ3GfNFTrMXnnqI6zS1jH67OQCPaRnPY4PsRgMrhfLyZ5GTGs4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEVJO-0004hE-4C for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:20:16 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 697HK7Y9023418
 for <openvpn-devel@lists.sourceforge.net>; Wed, 7 Oct 2026 19:20:07 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 697HK7WH023417
 for openvpn-devel@lists.sourceforge.net; Wed, 7 Oct 2026 19:20:07 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  7 Oct 2026 19:20:01 +0200
Message-ID: <20261007172007.23382-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xEVJO-0004hE-4C
Subject: [Openvpn-devel] [PATCH v2] reliable: characterize the packet id
 comparisons before rewriting them
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

The comparisons are about to lose their 2^31 horizon helpers. Pin the
accepted id set at each site first, by sweeping anchors and offsets across
the 0/2^32 wrap and the 0x80000000 midpoint against reference
implementations of the current behaviour.

reliable_not_replay(), reliable_wont_break_sequentiality(), the three scans
for the oldest unacknowledged entry and the ASSERT in
reliable_mark_active_incoming() had no coverage at all.

The receive path is characterized as the verdict ssl.c produces
(drop / ack-only / store) rather than as two predicates, because a replay is
still acknowledged while a sequentiality break is not. Its sweep splits at
2^31: reliable_wont_break_sequentiality() compares in absolute terms, so
above that base its accepted set shifts.

Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1899
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1899
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index dc77553..aabb555 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -516,6 +516,344 @@
     reliable_free(rel);
 }
 
+/*
+ * Reference implementations of the packet id comparisons as they behave today.
+ * The sweeps below assert reliable.c agrees with them at the anchors swept, so
+ * a change to an accepted id set there fails a test. Keep them standalone:
+ * expressing them in terms of reliable.c would make the sweeps tautologies.
+ */
+
+/* "p1 < p2" with the 2^31 horizon, i.e. ((int32_t)(p1 - p2) < 0) */
+static bool
+ref_pid_min(packet_id_type p1, packet_id_type p2)
+{
+    return (packet_id_type)(p1 - p2) >= 0x80000000u;
+}
+
+/* one short of RELIABLE_CAPACITY, which is what the code accepts today */
+#define CHARACTERIZED_SEND_WINDOW 11
+
+/* TLS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt.h, which this
+ * test binary does not pull in */
+#define CHAR_N_SEND_BUFFERS    6
+#define CHAR_OPCODE_CONTROL_V1 4
+
+static bool
+ref_pid_in_send_window(const struct reliable *rel, packet_id_type pid)
+{
+    const packet_id_type dist = (packet_id_type)(rel->packet_id - pid);
+
+    return dist >= 1 && dist <= CHARACTERIZED_SEND_WINDOW;
+}
+
+static bool
+ref_wont_break_sequentiality(const struct reliable *rel, packet_id_type id)
+{
+    const packet_id_type base = rel->packet_id;
+    const packet_id_type extent = (packet_id_type)rel->size;
+
+    /* char_anchors and char_anchors_high stay clear of the overflow, where
+     * reliable_pid_in_range2() used a 0x80000000 bias instead */
+    assert_true(base + extent >= base);
+
+    return id < base + extent;
+}
+
+static bool
+ref_not_replay(const struct reliable *rel, packet_id_type id)
+{
+    if (ref_pid_min(id, rel->packet_id))
+    {
+        return false;
+    }
+
+    for (int i = 0; i < rel->size; ++i)
+    {
+        if (rel->array[i].active && rel->array[i].packet_id == id)
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/* The receive path verdict as ssl.c produces it: stored only if both checks
+ * pass, a replay still ACKed, a sequentiality break dropped without an ACK. */
+enum recv_verdict
+{
+    RECV_DROP,
+    RECV_ACK_ONLY,
+    RECV_STORE
+};
+
+static enum recv_verdict
+recv_filter(const struct reliable *rel, packet_id_type id)
+{
+    if (!reliable_wont_break_sequentiality(rel, id))
+    {
+        return RECV_DROP;
+    }
+
+    return reliable_not_replay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+
+static enum recv_verdict
+ref_recv_filter(const struct reliable *rel, packet_id_type id)
+{
+    if (!ref_wont_break_sequentiality(rel, id))
+    {
+        return RECV_DROP;
+    }
+
+    return ref_not_replay(rel, id) ? RECV_STORE : RECV_ACK_ONLY;
+}
+
+/* Anchors for rel->packet_id. reliable_wont_break_sequentiality() compares id
+ * against rel->packet_id + rel->size in absolute terms, so its accepted set
+ * depends on where rel->packet_id sits: up to 2^31 that leaves the composite
+ * verdict unchanged, above it it does not, hence the split. Bases past
+ * 0xFFFFFFF3 are excluded, rel->packet_id + rel->size overflowing there. */
+static const packet_id_type char_anchors[] = {
+    0x00000000,
+    0x00000001,
+    0x00000005,
+    0x0000000B,
+    0x0000000C,
+    0x0000000D,
+    0x000001F4,
+    0x7FFFFFF4,
+    0x7FFFFFFF,
+    0x80000000,
+};
+
+static const packet_id_type char_anchors_high[] = {
+    0x80000001,
+    0x8000000C,
+    0xFFFFFFF0,
+    0xFFFFFFF3,
+};
+
+/* offsets applied below and above each anchor */
+static const packet_id_type char_offsets[] = {
+    0,
+    1,
+    2,
+    10,
+    11,
+    12,
+    13,
+    14,
+    100,
+    0x3FFFFFFF,
+    0x40000000,
+    0x7FFFFFFE,
+    0x7FFFFFFF,
+    0x80000000,
+    0x80000001,
+    0x80000002,
+    0xFFFFFFF4,
+    0xFFFFFFFE,
+    0xFFFFFFFF,
+};
+
+static void
+sweep_recv_filter(const packet_id_type *anchors, size_t n_anchors,
+                  enum recv_verdict (*oracle)(const struct reliable *, packet_id_type))
+{
+    for (size_t a = 0; a < n_anchors; a++)
+    {
+        for (size_t o = 0; o < SIZE(char_offsets); o++)
+        {
+            /* probe both below and above the anchor */
+            const packet_id_type ids[] = {
+                (packet_id_type)(anchors[a] - char_offsets[o]),
+                (packet_id_type)(anchors[a] + char_offsets[o]),
+            };
+
+            for (size_t i = 0; i < SIZE(ids); i++)
+            {
+                struct reliable rel = { 0 };
+                rel.size = RELIABLE_CAPACITY;
+                rel.packet_id = anchors[a];
+
+                assert_int_equal(oracle(&rel, ids[i]), recv_filter(&rel, ids[i]));
+
+                /* with the id already in a receive slot it can only be
+                 * acknowledged or dropped, never stored again */
+                rel.array[3].active = true;
+                rel.array[3].packet_id = ids[i];
+
+                assert_int_equal(oracle(&rel, ids[i]), recv_filter(&rel, ids[i]));
+                assert_int_not_equal(RECV_STORE, recv_filter(&rel, ids[i]));
+            }
+        }
+    }
+}
+
+/* bases at or below 2^31, where old and new agree; never to change */
+static void
+test_recv_filter_characterization(void **state)
+{
+    sweep_recv_filter(char_anchors, SIZE(char_anchors), ref_recv_filter);
+}
+
+/* bases above 2^31, where they diverge, kept apart so a change confined
+ * there touches one test */
+static void
+test_recv_filter_high_base(void **state)
+{
+    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high), ref_recv_filter);
+}
+
+static void
+sweep_send_window(const packet_id_type *anchors, size_t n_anchors)
+{
+    for (size_t a = 0; a < n_anchors; a++)
+    {
+        for (size_t o = 0; o < SIZE(char_offsets); o++)
+        {
+            const packet_id_type ids[] = {
+                (packet_id_type)(anchors[a] - char_offsets[o]),
+                (packet_id_type)(anchors[a] + char_offsets[o]),
+            };
+
+            for (size_t i = 0; i < SIZE(ids); i++)
+            {
+                struct reliable rel = { 0 };
+                rel.size = CHAR_N_SEND_BUFFERS;
+                rel.packet_id = anchors[a];
+
+                assert_int_equal(ref_pid_in_send_window(&rel, ids[i]),
+                                 validate_packet_id_window(&rel, ids[i]) != 0);
+            }
+        }
+    }
+}
+
+/* a pure distance test, so identical at every base */
+static void
+test_send_window_characterization(void **state)
+{
+    sweep_send_window(char_anchors, SIZE(char_anchors));
+    sweep_send_window(char_anchors_high, SIZE(char_anchors_high));
+}
+
+/* reliable_send() picks the oldest eligible entry, across the wrap and the
+ * signed midpoint */
+static void
+test_reliable_send_picks_oldest(void **state)
+{
+    now = 1000;
+
+    struct reliable rel = { 0 };
+    rel.size = CHAR_N_SEND_BUFFERS;
+    rel.initial_timeout = 2;
+    rel.packet_id = 3;
+
+    /* 6, 2 and 1 below rel->packet_id; the first sits exactly on the window
+     * edge, where rel->size still admits it */
+    const packet_id_type wrapped[] = { 0xFFFFFFFD, 1, 2 };
+
+    for (size_t i = 0; i < SIZE(wrapped); i++)
+    {
+        rel.array[i].active = true;
+        rel.array[i].packet_id = wrapped[i];
+        rel.array[i].timeout = 2;
+        rel.array[i].next_try = 0;
+    }
+
+    int opcode = 0;
+    assert_ptr_equal(&rel.array[0].buf, reliable_send(&rel, &opcode));
+
+    /* same across the signed midpoint */
+    struct reliable rel2 = { 0 };
+    rel2.size = CHAR_N_SEND_BUFFERS;
+    rel2.initial_timeout = 2;
+    rel2.packet_id = 0x80000002;
+
+    const packet_id_type midpoint[] = { 0x7FFFFFFF, 0x80000000, 0x80000001 };
+
+    for (size_t i = 0; i < SIZE(midpoint); i++)
+    {
+        rel2.array[i].active = true;
+        rel2.array[i].packet_id = midpoint[i];
+        rel2.array[i].timeout = 2;
+        rel2.array[i].next_try = 0;
+    }
+
+    assert_ptr_equal(&rel2.array[0].buf, reliable_send(&rel2, &opcode));
+}
+
+/* reliable_get_buf_output_sequenced() stops issuing ids once rel->packet_id is
+ * a full window ahead of the oldest unacknowledged one */
+static void
+test_get_buf_output_sequenced_boundary(void **state)
+{
+    struct reliable *rel = test_reliable_new();
+
+    rel->array[0].active = true;
+    rel->array[0].packet_id = 100;
+
+    /* distance 7 < size 8: still allowed */
+    rel->packet_id = 107;
+    assert_non_null(reliable_get_buf_output_sequenced(rel));
+
+    /* distance 8 == size 8: refused */
+    rel->packet_id = 108;
+    assert_null(reliable_get_buf_output_sequenced(rel));
+
+    /* same boundary across the wrap */
+    rel->array[0].packet_id = 0xFFFFFFFC;
+    rel->packet_id = 3;
+    assert_non_null(reliable_get_buf_output_sequenced(rel));
+
+    rel->packet_id = 4;
+    assert_null(reliable_get_buf_output_sequenced(rel));
+
+    reliable_free(rel);
+}
+
+/* Ids at or just ahead of rel->packet_id are accepted */
+static void
+test_mark_active_incoming_accepts_window(void **state)
+{
+    struct reliable rel = { 0 };
+    rel.size = RELIABLE_CAPACITY;
+    rel.packet_id = 10;
+
+    reliable_mark_active_incoming(&rel, &rel.array[0].buf, 10, CHAR_OPCODE_CONTROL_V1);
+    assert_true(rel.array[0].active);
+    assert_int_equal(10, rel.array[0].packet_id);
+
+    reliable_mark_active_incoming(&rel, &rel.array[1].buf, 10 + RELIABLE_CAPACITY - 1,
+                                  CHAR_OPCODE_CONTROL_V1);
+    assert_true(rel.array[1].active);
+}
+
+/* Ids below rel->packet_id abort. The far-ahead case is left unpinned: callers
+ * cannot produce it, and the bound may legitimately tighten.
+ *
+ * NOTE: expect_assert_failure() does not work with MSVC. It catches the ASSERT
+ * by longjmp()ing out of assert_failed(), and MSVC's longjmp() unwinds the
+ * intervening frames through RtlUnwindEx() instead of just restoring the
+ * registers, which faults. */
+#ifndef _MSC_VER
+static void
+test_mark_active_incoming_rejects_past_ids(void **state)
+{
+    struct reliable rel = { 0 };
+    rel.size = RELIABLE_CAPACITY;
+    rel.packet_id = 10;
+
+    expect_assert_failure(
+        reliable_mark_active_incoming(&rel, &rel.array[0].buf, 5, CHAR_OPCODE_CONTROL_V1));
+    expect_assert_failure(
+        reliable_mark_active_incoming(&rel, &rel.array[1].buf, 0xFFFFFFFF, CHAR_OPCODE_CONTROL_V1));
+}
+#endif /* ifndef _MSC_VER */
+
+
 int
 main(void)
 {
@@ -541,8 +879,16 @@
         cmocka_unit_test(test_packet_id_window),
         cmocka_unit_test(test_reliable_backoff_is_bounded),
         cmocka_unit_test(test_reliable_purge_ignores_forged_acks),
-        cmocka_unit_test(test_reliable_purge_legitimate_ack)
-
+        cmocka_unit_test(test_reliable_purge_legitimate_ack),
+        cmocka_unit_test(test_recv_filter_characterization),
+        cmocka_unit_test(test_recv_filter_high_base),
+        cmocka_unit_test(test_send_window_characterization),
+        cmocka_unit_test(test_reliable_send_picks_oldest),
+        cmocka_unit_test(test_get_buf_output_sequenced_boundary),
+        cmocka_unit_test(test_mark_active_incoming_accepts_window),
+#ifndef _MSC_VER
+        cmocka_unit_test(test_mark_active_incoming_rejects_past_ids),
+#endif
     };
 
     return cmocka_run_group_tests_name("packet_id tests", tests, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
