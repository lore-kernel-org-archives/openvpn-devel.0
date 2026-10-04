Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E376CA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEX7gnWJSIsxrrCT6ieIfJexrm79UVuMoRSkGRRSaTo=; b=Uq2hyzou8F+v+LkHF/PtUK9X40
	46pqSA7xJXGsh/y3DSA8DyWFZR++ipdKRaIeteU0IIY812YrVGU6nKyxkUZfs1Mlf73k4GbfBYB6E
	xZZkDOWvCHlNn0shLYhzO//zsvyfuAEZxPGDo7dm8y+qRsvPwm9Ny7UaD7Sh/0NMiHo4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDJ1Z-0003pw-Pl;
	Sun, 04 Oct 2026 10:00:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xDJ1Y-0003pT-F3
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:00:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d3Xp1/6CSdcnh/GgE6kgZi2JBFPr2FgRXkogtuXO6Q4=; b=UEZV5nN7atXx2sEbJ4zLVOMkKr
 KUh0XtsVSyttxbSt+GuaK170NJL5b1R+SQwljjMKT15V86U3T34gUlznfhVuq0FquOTSC0LqhgM44
 Pp6yhWG/hxaNBkQDPbOtPw+N1w5URNmctB+rvUrG8WqDM9uJc4KLgItRq0f0sZH1X3q8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d3Xp1/6CSdcnh/GgE6kgZi2JBFPr2FgRXkogtuXO6Q4=; b=DwE2DrWfEiAKh5oioMdopcqiGp
 HR/qj+I9vmgNzPPU91JX2FubO3bUATi/C4og/CyAY6gHoTwuPobwtU/mJZSdmD5MmVGhmjzR0se8B
 HKGbQdtlw8mgFIXeUTjCU2S5ZAT+zrtGpP1EDa6Naue/sFe8VbTsH/n3gL/4LiNDe4js=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDJ1O-0003ea-NK for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:00:47 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 694A0ZCC000885
 for <openvpn-devel@lists.sourceforge.net>; Sun, 4 Oct 2026 12:00:35 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 694A0ZJb000884
 for openvpn-devel@lists.sourceforge.net; Sun, 4 Oct 2026 12:00:35 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun,  4 Oct 2026 12:00:29 +0200
Message-ID: <20261004100035.860-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xDJ1O-0003ea-NK
Subject: [Openvpn-devel] [PATCH v3] Always use a 0.0.0.0/0 default on
 Android instead of def1
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

Certain handset manufacturers (like Samsung iirc)  are handling
0.0.0.0/0 different from the split /1 routes, so push the 0.0.0.0/0
route to the OS.

Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/890
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/890
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e3cd527..cbada6f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5615,7 +5615,14 @@
             }
             else if (streq(p[j], "def1"))
             {
+#ifndef TARGET_ANDROID
+                /* The hack that def1 uses to split 0.0.0.0 into 0.0.0.0/1 and
+                 * 128.0.0.0/1 is not needed on Android and will even
+                 * make some Android implementations (e.g. Samsung)
+                 * misbehave, so silently ignore the flag and always use
+                 * 0.0.0.0/0 instead */
                 options->routes->flags |= RG_DEF1;
+#endif
             }
             else if (streq(p[j], "bypass-dhcp"))
             {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
