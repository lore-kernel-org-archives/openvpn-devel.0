Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D558C5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3FWcG4Aio1FDuDCPqS5risDEdOIS9f5kzLr1RKx+LeY=; b=XcTldIsWfug7dN7nRL/Jt/p/Cu
	ELc0etBOVh2ILOyJdlhyMQG8sKNDA2OBwLezxoo8CUWBmZThBbHad482hgCwSnakPQclXszHZ4rzj
	RdiVaYVoTuKlOGUDe2qCkzF6ZnwzFAchi6fYJHEMkl4V6vBgpJfwelfxhCqpxtYfZnXc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXMK-0005Rz-JG;
	Mon, 24 Aug 2026 16:17:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyXMJ-0005RJ-W5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OCA3WTPsmBTf9mpQPWlf6BH2+1kOKY3+2oLHyQ5o0wg=; b=VtxfC6hG2SMj1GTii/VafIkzVK
 I/ttD2WwZec1uYwhS3wc4+rA94Lv9OrG42W6nPPzWtiVecAxqjBExCDDetNLZ94Yox8k2QauK0TQW
 iGCMTACdfnqqwIVFTktjWaEQgOkdKbX1I62prAR9ixjI1gunqwlxZbPxZ+wtNIvbLe1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OCA3WTPsmBTf9mpQPWlf6BH2+1kOKY3+2oLHyQ5o0wg=; b=CxFsHIoyTGxpwK6GLTY1DPph0X
 90qq7QtEZD0DPiqFnCGXtskYlC/PnaR1LsVjyxEKJTCIgy2GwotWm8WHEYjz5C1ClS680JLYu+LjV
 pGfhoIIenVRoNztSlSzt5AKiv67xvkiIXHMXEBzWvCpRnj7UH1aYd9lFL4CHcDU9bu/4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyXLr-0007R6-FX for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:16:48 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OGGfNf002007
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 18:16:41 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OGGe1I002006
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 18:16:40 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 18:16:34 +0200
Message-ID: <20260824161640.1971-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
References: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyXLr-0007R6-FX
Subject: [Openvpn-devel] [PATCH v1] interval: Remove unused usec_timer
 functions
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

These have never been used in the git history.
Probably OpenVPN 1.x remnants.

Identified by cppcheck.

Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1862
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1862
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index f6d3503..59051bd 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -255,47 +255,4 @@
  */
 bool event_timeout_trigger(struct event_timeout *et, struct timeval *tv, int et_const_retry);
 
-/*
- * Measure time intervals in microseconds
- */
-
-#define USEC_TIMER_MAX 60 /* maximum interval size in seconds */
-
-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000)
-
-struct usec_timer
-{
-    struct timeval start;
-    struct timeval end;
-};
-
-#ifdef HAVE_GETTIMEOFDAY
-
-static inline void
-usec_timer_start(struct usec_timer *obj)
-{
-    CLEAR(*obj);
-    openvpn_gettimeofday(&obj->start, NULL);
-}
-
-static inline void
-usec_timer_end(struct usec_timer *obj)
-{
-    openvpn_gettimeofday(&obj->end, NULL);
-}
-
-#endif /* HAVE_GETTIMEOFDAY */
-
-static inline bool
-usec_timer_interval_defined(struct usec_timer *obj)
-{
-    return obj->start.tv_sec && obj->end.tv_sec;
-}
-
-static inline int
-usec_timer_interval(struct usec_timer *obj)
-{
-    return tv_subtract(&obj->end, &obj->start, USEC_TIMER_MAX);
-}
-
 #endif /* INTERVAL_H */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
