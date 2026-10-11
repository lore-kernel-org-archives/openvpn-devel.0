Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FC9CA9ECC
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8syNbqzg9SxucqR+SH7kTgxzHervFFm4tPPquFd6VvA=; b=Kja08u8s3czSAJ0PZfw3Wr0ZbZ
	FND5Oprq9RI7dpMuKBwk/G+TePuFKdVjBFYzWGmVefgrjBmmNku8TOSQsyHIEVmVYLoBhriF4t6e7
	M51+Em/GOe8mJS7/g6OcLlOWvS22gRj4EFuZoxy8Qm6rvEjFgKPB5f1tfwIhj7u1Jk3E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xG06Z-0004WY-9t;
	Sun, 11 Oct 2026 20:25:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xG06D-0004VL-2N
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vAdVUeFO0HmXvc++Y1RoBlkxkoPF9xvRQuCSKeL211o=; b=JORHsGsWBbfdSKzue/4uSFq+eJ
 oyl9+LQ0b/qBrWMggdm4Fu/3a8ImjiO03ygLstaUl22e5a9vVf5uAgKhenGHOzslBh8J7rQGkyoCe
 yKw9+U9REaPqkUajKsc//pbxwkSwKs2oGSsOYUx346GkHJnIHCvJ7su1gU5M/to4iA7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vAdVUeFO0HmXvc++Y1RoBlkxkoPF9xvRQuCSKeL211o=; b=K8wB9AY0rYqpwVvYmmID5cD8R3
 UdueeyVJPOpsI8EMyh5X0mH4eZ5PSjUDQif5PSV79pl44HMrOsiid6fJPOcYpVEy53ucnVZc3eYMc
 w1unU11G3NAuTvvaAwBq7InDh+Omdivrm+jKrydTqXKTXngPT9rz3rSXBSZHHyE6T0mA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xG06B-0003XQ-Ej for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 20:24:48 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69BKOeMh015173
 for <openvpn-devel@lists.sourceforge.net>; Sun, 11 Oct 2026 22:24:40 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69BKOeHD015172
 for openvpn-devel@lists.sourceforge.net; Sun, 11 Oct 2026 22:24:40 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 11 Oct 2026 22:24:34 +0200
Message-ID: <20261011202439.15128-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
References: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xG06B-0003XQ-Ej
Subject: [Openvpn-devel] [PATCH v1] sitnl: use RTM_SETLINK for updating
 existing interfaces
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

RTM_NEWLINK is primarily intended for link creation and initialization,
while RTM_SETLINK is the canonical interface for modifying attributes of
an already existing link.

Even though the kernel may accept RTM_NEWLINK for updates, using
RTM_SETLINK better reflects the intended netlink semantics and follows
the dedicated update path in the kernel.

This makes the behavior more explicit and consistent with how link
configuration changes are expected to be performed.

Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1628
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1628
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b3f8e2b..3aea076 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -671,7 +671,7 @@
 
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
-    req.n.nlmsg_type = RTM_NEWLINK;
+    req.n.nlmsg_type = RTM_SETLINK;
 
     req.i.ifi_family = AF_PACKET;
     req.i.ifi_index = ifindex;
@@ -707,7 +707,7 @@
 
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
-    req.n.nlmsg_type = RTM_NEWLINK;
+    req.n.nlmsg_type = RTM_SETLINK;
 
     req.i.ifi_family = AF_PACKET;
     req.i.ifi_index = ifindex;
@@ -738,7 +738,7 @@
 
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
-    req.n.nlmsg_type = RTM_NEWLINK;
+    req.n.nlmsg_type = RTM_SETLINK;
 
     req.i.ifi_family = AF_PACKET;
     req.i.ifi_index = ifindex;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
