Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E86C5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=omuSs9nNLpIqy7+RG5VBNmoLNzKKlu37mC+bgCmtDXs=; b=lYDF0ldFTBMwI8EmNWPQbXrjlW
	eyq8GN8Wj7vGEJPtTSTPoO8Uf37Bib8dxGSCCXfD28+9NoyJYiTa0HmJ6c6k3qrvLEiFtKtmLv0wY
	Zy3Oo1bCcSQr9S+eMB655Z/x7/0Q2MsFOVgRTypws5lcOTixWhtditShTjzlQEVWTXII=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXLE-00034f-4g;
	Mon, 24 Aug 2026 16:16:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyXLD-00034Y-1V
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SVjf+h7XPW3lyMl3kfVFWMzzvI48t6BHV65A3I99XwM=; b=PKI9BEpPKS0kfhQJysNusap0hO
 dVE04cPMAugjXn3pwxcrc9qNOV0zpwO3R/g77pDbKs2tRExyGMf54NyeT0wq12euMK4MaH8YANF5s
 Y5v/qgepEsR30cnd7JXzrTt90ikJ7wVhGLp8X/XFhFz/a5MLMDegx4jUn1BvG1cDOv3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SVjf+h7XPW3lyMl3kfVFWMzzvI48t6BHV65A3I99XwM=; b=cb97GHwHhQx7Hire8dEjz0xNFP
 woAtv9WPww6Wuv1dAPNj2b4mZD4GuJpEsIaJTODbXURoskXsEY4u5BZ0OFDNJJhrsz21xT3GJU/6E
 4/r/2SEyLHrvPuLgroUAsUEiWNn+L67l+HgDXzupeiY1HlW6IhI5rqLKHNR6e1j2nX/g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyXLB-0007PK-Co for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:16:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OGFwj4001892
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 18:15:58 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OGFwoW001891
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 18:15:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 18:15:52 +0200
Message-ID: <20260824161558.1869-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
References: <gerrit.1787570563000.I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyXLB-0007PK-Co
Subject: [Openvpn-devel] [PATCH v1] event: Remove unused function
 event_set_return_init
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

This has never been used in the git history.
It is also equivalent to just using CLEAR().

Identified by cppcheck.

Change-Id: I2cf5da2aa6fbb68116c7b6ef587a6494acae0b54
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1867
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1867
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 40ed161..b784dfe 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -190,13 +190,6 @@
     return ret;
 }
 
-static inline void
-event_set_return_init(struct event_set_return *esr)
-{
-    esr->rwflags = 0;
-    esr->arg = NULL;
-}
-
 #ifdef _WIN32
 
 static inline void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
