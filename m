Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEE6C79FB9
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDCd3kaH24C7K4Ksl29Vk+McQp1Af4NTZGODCzHdvJ8=; b=MyF3xXeO5q5Yzr9Hu5m61ySglq
	oI4v659VPZOPORLM+Od83prbPQU0j9Oqy6HANyjMEDMxY7OE/XLrYirboPyZ7L98nCIxy2miKsV7A
	9gt0IKhyzZGNzsQj42H1wWHr2xX/AGF+fxJZNq0MA7NlyflpcsnMWd3p3f2CnpqRdioE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4aV8-0006Le-VP;
	Thu, 10 Sep 2026 08:51:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x4aV0-0006I2-T4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5pDMa48HA5aNcJImGkOGrmny8237uv17+BTG9SP3cbw=; b=C53rBBkeid3O5NPosetIrlao1F
 J8Fgtb3pKxk67g8lxXKXIsqXcrbBJO2quFn/8+dqMhzKMeqwHCGIgs9LN6eAsTuJMGnDKANXGzWNg
 c/JqQLhOlfWV9koHfI1/+2FKdkIWIwch5wejQf7w2qjRQMsPC/Y31CGV0zxTePgzV78c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5pDMa48HA5aNcJImGkOGrmny8237uv17+BTG9SP3cbw=; b=Ed+MXBn1Lfl7evBGjbXjf/STyE
 UJlg9MQglneu0vbK4zOcyM5h3p+T71UNvLWzfvXwevyyh2Z1ed3ol21oAmusAnVFumoU0yL3/I3i3
 RY/HCNq9D2zrBC7twkguHWyE6PyuJVvnlLfnombkVw0NZi7o1LiVVJWhRuLMHbPHhb28=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4aUg-0001xB-Co for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 08:50:56 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68A8olZa030851
 for <openvpn-devel@lists.sourceforge.net>; Thu, 10 Sep 2026 10:50:47 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68A8olF4030850
 for openvpn-devel@lists.sourceforge.net; Thu, 10 Sep 2026 10:50:47 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 10 Sep 2026 10:50:41 +0200
Message-ID: <20260910085046.30817-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
References: <gerrit.1788885307000.I944478767b52a1b9bf6a65373ce0544c69cb1012@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x4aUg-0001xB-Co
Subject: [Openvpn-devel] [PATCH v4] Ignore acks for packets that cannot be
 outstanding
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

From: Arne Schwabe <arne@rfc2549.org>

This ignores acks for pids outside the send window, i.e. for packets
that have either not been sent out yet or already left the window.
Nothing outside that window can be outstanding, so such acks can only
be used to manipulate the state of the send buffer.

Comparing the pid of an outstanding packet against the acked pid needs
to be wraparound aware as well. Otherwise a peer can ack a pid from the
lower half of the id space, which passes the window check above, and
still increment n_acks on every outstanding packet, forcing an early
retransmit after N_ACK_RETRANSMIT such acks.

Github: OpenVPN/openvpn-private-issues#161
Reported-By: Mark Bregman (Fox-IT) <mark.bregman@fox-it.com>
CVE: 2026-84732
Change-Id: I944478767b52a1b9bf6a65373ce0544c69cb1012
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1909
Acked-by: MaxF <max@max-fillinger.net>
(cherry picked from commit d988ef4508e63b28c8e3efcb9f62eb8c836907fe)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1909
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index babe4c8..d0ae3cc 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -404,15 +404,36 @@
     return true;
 }
 
+int
+validate_packet_id_window(struct reliable *rel, packet_id_type pid)
+{
+    return reliable_pid_min(pid, rel->packet_id)
+           && reliable_pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+}
+
 /* del acknowledged items from send buf */
 void
 reliable_send_purge(struct reliable *rel, const struct reliable_ack *ack)
 {
-    int i, j;
-    for (i = 0; i < ack->len; ++i)
+    unsigned int out_of_window = 0;
+    packet_id_type first_out_of_window = 0;
+
+    for (int i = 0; i < ack->len; ++i)
     {
         packet_id_type pid = ack->packet_id[i];
-        for (j = 0; j < rel->size; ++j)
+
+
+        if (!validate_packet_id_window(rel, pid))
+        {
+            if (out_of_window == 0)
+            {
+                first_out_of_window = pid;
+            }
+            out_of_window++;
+            continue;
+        }
+
+        for (int j = 0; j < rel->size; ++j)
         {
             struct reliable_entry *e = &rel->array[j];
             if (e->active && e->packet_id == pid)
@@ -432,16 +453,27 @@
 #endif
                 e->active = false;
             }
-            else if (e->active && e->packet_id < pid)
+
+            if (e->active && reliable_pid_min(e->packet_id, pid))
             {
                 /* We have received an ACK for a packet with a higher PID. Either
                  * we have received ACKs out of or order or the packet has been
                  * lost. We count the number of ACKs to determine if we should
-                 * resend it early. */
+                 * resend it early. The comparison needs to be wraparound aware,
+                 * otherwise a peer can inflate n_acks with an ACK for a pid from
+                 * the lower half of the id space and force a retransmit. */
                 e->n_acks++;
             }
         }
     }
+
+    if (out_of_window > 0)
+    {
+        (void)first_out_of_window; /* dmsg might not generate code */
+        dmsg(D_REL_LOW, "ACK contained %u ids outside the send window, "
+             "first was " packet_id_format,
+             out_of_window, (packet_id_print_type)first_out_of_window);
+    }
 }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 5877f20..cdd33c8 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -106,9 +106,9 @@
 {
     int size;
     interval_t initial_timeout;
-    packet_id_type packet_id;
-    int offset; /**< Offset of the bufs in the reliable_entry array */
-    bool hold; /* don't xmit until reliable_schedule_now is called */
+    packet_id_type packet_id; /**< Packet ID for the next packet to be sent out. */
+    int offset;               /**< Offset of the bufs in the reliable_entry array */
+    bool hold;                /* don't xmit until reliable_schedule_now is called */
     struct reliable_entry array[RELIABLE_CAPACITY];
 };
 
@@ -193,6 +193,17 @@
 }
 
 /**
+ * check that pid is inside the window of possible outstanding packets
+ * of size RELIABLE_CAPACITY, ie inside the range
+ * [rel->packet_id - RELIABLE_CAPACITY, rel->packet_id).
+ *
+ * rel->packet is the *next* packet id to be sent out, so it is not
+ * included in the valid range.
+ */
+int
+validate_packet_id_window(struct reliable *rel, packet_id_type pid);
+
+/**
  * Returns the number of packets that need to be acked.
  *
  * @param ack The acknowledgment structure to check.
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index ff3f788..a27bd6d 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -271,6 +271,53 @@
     assert_memory_equal(mru_ack.packet_id, expected_ack.packet_id, sizeof(expected_ack.packet_id));
 }
 
+static void
+test_packet_id_window(void **state)
+{
+    struct reliable rel = { 0 };
+    rel.packet_id = 1;
+
+    assert_true(validate_packet_id_window(&rel, 0));
+
+    /* packet id 1 is outside the window as it is the *next* packet id */
+    assert_false(validate_packet_id_window(&rel, 1));
+
+    /* wrapped around packet id, "-2" */
+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFFD));
+
+    /* wrapped around packet id, "-10" */
+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF6));
+
+    /* wrapped around packet id, "-11" */
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFF5));
+    assert_false(validate_packet_id_window(&rel, 0x80000000));
+
+    rel.packet_id = 0x80000000;
+
+    /* near the signed/usigned integer area */
+    assert_false(validate_packet_id_window(&rel, 0x80000001));
+    assert_true(validate_packet_id_window(&rel, 0x7fffffff));
+    assert_true(validate_packet_id_window(&rel, 0x7ffffff5));
+    assert_false(validate_packet_id_window(&rel, 0x7ffffff4));
+
+    rel.packet_id = 0xFFFFFFFD;
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFD));
+    assert_false(validate_packet_id_window(&rel, 0));
+    assert_false(validate_packet_id_window(&rel, 1));
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFE));
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFF));
+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF3));
+    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF2));
+    assert_false(validate_packet_id_window(&rel, 0xFFFFFFF1));
+
+    rel.packet_id = 500;
+    assert_false(validate_packet_id_window(&rel, 501));
+    assert_true(validate_packet_id_window(&rel, 497));
+    assert_true(validate_packet_id_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
+    assert_false(validate_packet_id_window(&rel, 500 - RELIABLE_CAPACITY));
+}
+
+
 int
 main(void)
 {
@@ -295,7 +342,8 @@
                                         test_packet_id_write_setup,
                                         test_packet_id_write_teardown),
         cmocka_unit_test(test_get_num_output_sequenced_available),
-        cmocka_unit_test(test_copy_acks_to_lru)
+        cmocka_unit_test(test_copy_acks_to_lru),
+        cmocka_unit_test(test_packet_id_window)
 
     };
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
