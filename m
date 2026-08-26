Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA1AC5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4FRElYLe4F6qts5Yv7597XoMbBgDFMGNgbrXz64stII=; b=dj0BT6aytuWVxrCRKM9s6XMjUl
	ng9ZI5bMiIXY0nMcCiLRHh4LqL6KfdFXb8umbWr1O3Q16W+YkExes0nphlEOLetJsR6O1QfftYyFu
	qCycfNrq0/Bi6JstAeUcf88Lm3cbW8jb+CzGkxI2Az9KFKcRyws0CbhJ+wNIuRlWRxdc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzKRT-00075D-0m;
	Wed, 26 Aug 2026 20:41:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wzKRR-00074x-0d
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 20:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dC87h3UdOhMZSDqVPbeakQoo+/MZAG4mwO7mxUY1nVQ=; b=GxhqadctzW/iWzmRmyMc/Ot/tA
 RtIokDqxFLLetnj3bSO1TjEBOu0U92+Bp0LGzoKSrkLxp3If7PM+xcncA0iqvhypW7mMqGD5BQo+u
 APddbF3remTBfk2PFb7LwM0JZf/V5TOnXwdi3z/nsINuhS5DiMi8xAyJrxWRUpQrKmas=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dC87h3UdOhMZSDqVPbeakQoo+/MZAG4mwO7mxUY1nVQ=; b=Pjo1mKhkMuJfah3rPJqonTwBnJ
 ks7zCLiCCmEb9MNuxHWCfiuikiP0sEUOmh5EG38gAYdwHE1DKJ/5SYkgSqs+vPUAL4STSXRqOPkPh
 zjImTopIjTBqE5CHrhmPSQ5WuaHiHL1okqvAGpmcqLFp0U+hq7W8ytPsIueRxJQOiu/0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzKRP-000160-Da for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 20:41:49 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67QKfemk029133
 for <openvpn-devel@lists.sourceforge.net>; Wed, 26 Aug 2026 22:41:40 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67QKfear029132
 for openvpn-devel@lists.sourceforge.net; Wed, 26 Aug 2026 22:41:40 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 26 Aug 2026 22:40:47 +0200
Message-ID: <20260826204139.28986-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
References: <gerrit.1787570563000.I7217d87a0f133e0bbee7896984e668cd28db73bd@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wzKRP-000160-Da
Subject: [Openvpn-devel] [PATCH v2] route: Remove unused function
 route_list_vpn_gateway_needed
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

From: Frank Lichtenheld <frank@lichtenheld.com>

This function has not been used since commit
840799182c0769c8ac9d014d09a497563516fc0d from 2011.
So it is probably safe to assume it is not useful.

Identified by cppcheck.

Change-Id: I7217d87a0f133e0bbee7896984e668cd28db73bd
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1864
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1864
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index bae8659..0d33d36 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -407,19 +407,6 @@
     return mask;
 }
 
-static inline bool
-route_list_vpn_gateway_needed(const struct route_list *rl)
-{
-    if (!rl)
-    {
-        return false;
-    }
-    else
-    {
-        return !(rl->spec.flags & RTSA_REMOTE_ENDPOINT);
-    }
-}
-
 static inline int
 route_did_redirect_default_gateway(const struct route_list *rl)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
