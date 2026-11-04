Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24515606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iHbgAhIi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=D3VpJbwn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LK6z8f5q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BejAO3A1mRl6KQhjJ3MbKzp1dFAnP8va/CBpFRbVFTE=; b=iHbgAhIiyzkzAk
	k/R9p8wuksD5uPuOVKff+9R5/yA05RlOBPNfaVLuUOnpLL0X3ByQwC9cYgiGanNNxBPRIQRfGC4dD
	izLrLMSXPoSmooOe1QO6UmYMkKpVte4pzDJXoo4ko1Zhq2+8BiA5RFAP04ZNtAKH+kpa9PikhgiFb
	yyk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYdc-000000005fx-3Yh2;
	Wed, 04 Nov 2026 10:54:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOYdb-000000005fk-2HsK for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2OS6ZPEImavl5Jj+bHdxgCAm6Sl4f1wkJjLestMfdeg=; b=D3VpJbwnSA8q9sFpq6V9s8LjDC
 640BAhJinBq0/vF5sAt8wLA6BJcNPV8JHuDRkAFIIxvIdBSSYn3q1F0ZhDtrEFn350LRk/zJrqzt6
 ZH2XRrK+eUo7nYENqlwM7HlFp7eRq60VNybMJAaAg53ETAdz41enopuXDz/LFmIlBtDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2OS6ZPEImavl5Jj+bHdxgCAm6Sl4f1wkJjLestMfdeg=; b=LK6z8f5qcvarRJKnqhSm8RGACr
 5x3KFTLBSzcksIMoqRLrq1IGzGzgzvZeWy8D3MUJtXFQNAagLXB+VTuSifcsTiZC0MDivrFwhmmmC
 HKpS82kLvwc2NSInri1vZVscQM/uPy5tH0Su2X04a9m61dW35D1ra18CN1m/XBbBiXBk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOYda-000000008MX-1SVQ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:54:39 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4AsV9q007024
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 11:54:31 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4AsV2A007023
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 11:54:31 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 11:54:25 +0100
Message-ID: <20261104105431.7011-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
References: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOYda-000000008MX-1SVQ
Subject: [Openvpn-devel] [PATCH v1] route: remove unused max() and gc from
 BSD get_default_gateway()
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

Both lost their last users when 76d11614 ("get_default_gateway()
HWADDR overhaul") replaced the SIOCGIFCONF loop with getifaddrs().

Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2123
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2123
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 53550c4..27012f7 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3322,12 +3322,9 @@
 #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
 #endif
 
-#define max(a, b) ((a) > (b) ? (a) : (b))
-
 void
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc = gc_new();
     struct rtmsg m_rtmsg;
     int sockfd = -1;
     int rtm_addrs;
@@ -3529,7 +3526,6 @@
     {
         close(sockfd);
     }
-    gc_free(&gc);
 }
 
 /* BSD implementation using routing socket (as does IPv4)
@@ -3698,8 +3694,6 @@
     }
 }
 
-#undef max
-
 #elif defined(TARGET_HAIKU)
 
 void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
