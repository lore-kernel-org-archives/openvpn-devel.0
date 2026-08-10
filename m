Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E2EC5AD55
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y19Hgl9oWwpyELcKt9BKuq/2OGUir5jONeT8829LKko=; b=E5JDnyKXoMHlxKuQC4kKvCquNq
	PRkbQAf1cDe3G2YbGvetfN0LdL2+U/NINZboDfZI/8ynG25B7HCdvyc5qv7oQO1izrg25sAylLeZN
	0MTpNlYDGheX/atQ6TCIy3e19KsA/FcOMIitUcmMX2dD7+/Dad4lBGTT17tXmIww7ye8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtOOe-0005tL-3x;
	Mon, 10 Aug 2026 11:42:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wtOOc-0005tE-E2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 11:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=blWzq3PWOPO8qCbxYTJ792lEDYJPJjxIF9uVzyvsF7E=; b=JfIVN+CIw1As18OZPU7uA1vYKn
 jVmzVuTgY6bDHCINIzo9KN0l4emEas/jx3jrYTAngooaOfIFQ1OEVdOLc8VgFsb/En+aKVC/08wWd
 hHSde4mF0Z41IOSVqqdZvc9t2Bqdra/4LPjDiO7E6fBXNeP4E6vUJxn7K0jdEqsOQ6SU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=blWzq3PWOPO8qCbxYTJ792lEDYJPJjxIF9uVzyvsF7E=; b=SLSCSfGPkjllRrY5TSDFxw/f09
 XXRtTWw2YJhCePHO/+ZDOFmeZ22gaCRelKKrzqiijCbKpH7vgnY9rS9OkSqCe8rmbVnWneGHySOkX
 0XknDyPcchiU1HLYOi1b7zNw/TDM3ziIQq9X5/iPczYRsu5h4X3xcMKmD5WHnlBcAZ3g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtOOd-0000eJ-Q0 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 11:42:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67ABgDkt028403
 for <openvpn-devel@lists.sourceforge.net>; Mon, 10 Aug 2026 13:42:13 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67ABgDSg028402
 for openvpn-devel@lists.sourceforge.net; Mon, 10 Aug 2026 13:42:13 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 10 Aug 2026 13:42:06 +0200
Message-ID: <20260810114212.28379-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wtOOd-0000eJ-Q0
Subject: [Openvpn-devel] [PATCH v4] Reenable xmit_hold when using p2p
 tcp-server and tls-server
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

Commit 619c3e9 changed the logic to enable xmit_hold only
when c->mode is CM_CHILD_TCP. This works for --mode server and
was probably done to allow to properly work when the server
is listening on multiple sockets and options->ce.proto cannot be used
to determine if this socket is tcp or udp.

Restore the logic for p2p to avoid both sides starting sending
resets at the same time.

Closes: openvpn/openvpn#1089
Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: MaxF <max@max-fillinger.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1837
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1837
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@max-fillinger.net>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 69d226d..08278fc2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3332,7 +3332,7 @@
 
     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && c->mode == CM_CHILD_TCP)
+    if (to.server && (c->mode == CM_CHILD_TCP || (c->mode == CM_P2P && options->ce.proto == PROTO_TCP_SERVER)))
     {
         to.xmit_hold = true;
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
