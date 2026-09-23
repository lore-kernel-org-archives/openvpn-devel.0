Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B76C982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jFdqI5BYyi+EYt06chEL+jswkbepcsgq2D6opFsGHy0=; b=lDlbI3ehFbgFa7eCOAE/soWcDe
	2J0KpXtYI8TvnypnylnDOjd4YeE9oS4qVNLMbQklVbfZwnpKxikdjpEpxcIGyvdTzZMV9rR7egrL8
	u4unvlZEfHb2sVZ+aJOPUCGOb4iG/br1eYzykBGhGhB8fr1eFeceslbEBapPlv6t8klY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Mho-0005SF-2Z;
	Wed, 23 Sep 2026 13:08:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x9Mhm-0005S9-LS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y6vGv1JsRzliRjXknLiQ1n7pztRUfRbXt/IekOiqVZo=; b=S2CHm+TxVsG8n2T2/nprSyV6Bf
 weOsCSGlLxYpi3pd3AbCw0NqKPn79lnD4t0qJzLBMhhf+X8TYU8KanJcSElMvZLuyNFIbFMtdGpw8
 kIC/1UUhwMSETCavgDIqJodbb9sA5nuff+nKT99w7399c3ZhwPGBm4mLqr6LW64uUXFE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y6vGv1JsRzliRjXknLiQ1n7pztRUfRbXt/IekOiqVZo=; b=S1zT0OK/2CsfB/eyaVkreMxR1r
 46ct+0PRKRLSGf8rUL/6TBplxKWbAz7nuauXvDTCBB6yJjeRFVq2AMegKZuXmm4G3jIbWJbI8pc+4
 G1aVHCr80DHx2NSNvznD+hGWCZyQRkrG2Va7CLFLHl3i582myxzHyEsP62NmY2nzf2ek=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9Mhl-0000DW-GY for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 13:08:10 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68ND82Zu016814
 for <openvpn-devel@lists.sourceforge.net>; Wed, 23 Sep 2026 15:08:02 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68ND82DY016813
 for openvpn-devel@lists.sourceforge.net; Wed, 23 Sep 2026 15:08:02 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 23 Sep 2026 15:07:56 +0200
Message-ID: <20260923130801.16802-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
References: <gerrit.1790167275000.If276bd4c5d07fcd26f6749f514f0257eab73249f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x9Mhl-0000DW-GY
Subject: [Openvpn-devel] [PATCH v1] proxy: Work-around spurious warning on
 mingw builds
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

mingw in Ubuntu 26.04 has issues with checking snprintf
format strings against original MS implementation even
though it uses the GCC implementation.

Apply work-around that is good enough for code that is
already gone in master.

Change-Id: If276bd4c5d07fcd26f6749f514f0257eab73249f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1945
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.7.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1945
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 7101d9f..857bf03 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -767,7 +767,9 @@
 
                 char get[80];
                 CLEAR(buf2);
-                snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
+                /* mingw checks calls to the builtin snprintf() with the
+                 * ms_printf archetype, which does not know the 'z' modifier */
+                snprintf(get, sizeof(get), "%%*s NTLM %%%us", (unsigned int)(sizeof(buf2) - 1));
                 nparms = sscanf(buf, get, buf2);
 
                 /* check for "Proxy-Authenticate: NTLM TlRM..." */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
