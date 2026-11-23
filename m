Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA32606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GNusMoGZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kl5BOb1h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V+Or3Y2y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AW8vtoedYbpTZn6mvqKzPtFo3cMhVbE02wFMqZUvaJM=; b=GNusMoGZ6IIfTO
	xfpOSl22wybDOkjTQyMwVRlu7v2ECqHbsQ+p5VoFIpnksLeJP6BVDf3j+3/V9B96B39txXBbifTT8
	dWJrcWg5l+jVJNoN78gTce4feoNfc+tGYaEU+NqZackNJaZHUDCZo+QIUI2zq32yVM6YZ0dnDOgtP
	+Dw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVRQm-000000004kN-0QeM;
	Mon, 23 Nov 2026 10:37:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVRQl-000000004kH-1phC for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 10:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02XOvjzbtlgXNvGc3BCVt/ZB1BKzN5Gs8804UgpWiHI=; b=kl5BOb1hTEIeyxKcXRnnl53dxP
 FRiuh0LlPSqRJkKW9xpFVnnNMZubovdE4RiaqHVNdwIvHCbnrI0YRvZl5Jbu5fuSJHVU1wyTbsW8H
 YMvft1EjqDFWlrI7KvWpKjMhVHM5xFc3otcgx0yDHJh2AJ0hyYbOPaZflCiAFbdqHAzU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02XOvjzbtlgXNvGc3BCVt/ZB1BKzN5Gs8804UgpWiHI=; b=V+Or3Y2y63r86xdFWm8r/hhrpD
 S5wkkHg3yvQazdx58lkY2IrCJN0hknE3xevMKc6VkBLKHi3H0rAf+0gwfvCdRMd+2X0sAIpReqdAF
 qTHxDrfmBqay3M3sQVJTEz8z+9h8+CDMye93icYbNYDbWnVdhUBtvNwEzApWBFR+QXhM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVRQj-000000004EX-2JWc for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 10:37:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANAbgCQ010604
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 11:37:42 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANAbgvJ010603
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 11:37:42 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 11:37:36 +0100
Message-ID: <20261123103742.10589-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
References: <gerrit.1795379218000.I74eca236465190ab55db289b98e432757c61a4a3@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVRQj-000000004EX-2JWc
Subject: [Openvpn-devel] [PATCH v1] ssl: drop duplicate remote address check
 in tls_pre_decrypt()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

The existing-session branch already rejects a packet whose source
doesn't match ks->remote_addr, and key_state_soft_reset() keeps that
address, so the later check never fails. new_link is always false in
that branch.

Change-Id: I74eca236465190ab55db289b98e432757c61a4a3
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2240
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2240
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d5ae13d..e4a39b2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4003,7 +4003,7 @@
         /*
          * Verify remote IP address
          */
-        if (!new_link && !link_socket_actual_match(&ks->remote_addr, from))
+        if (!link_socket_actual_match(&ks->remote_addr, from))
         {
             msg(D_TLS_ERRORS, "TLS Error: Received control packet from unexpected IP addr: %s",
                 print_link_socket_actual(from, &gc));
@@ -4105,13 +4105,6 @@
         ks->remote_addr = *from;
         ++multi->n_sessions;
     }
-    else if (!link_socket_actual_match(&ks->remote_addr, from))
-    {
-        msg(D_TLS_ERRORS,
-            "TLS Error: Existing session control channel packet from unknown IP address: %s",
-            print_link_socket_actual(from, &gc));
-        goto error;
-    }
 
     /*
      * Should we do a retransmit of all unacknowledged packets in


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
