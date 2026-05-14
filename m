Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B735CD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LlFEyKMvzE4AqAOYV3pyQmRBxPGa2j1WR5ZgK9Z9IA=; b=HoqWwNa1LmMn3zBDmef2MnDvoa
	GOd4e+Chu2pRa5p+VBm7mJ269lxz6s+Z4aCncehDlAx/pZ0xJ8Dg07LZEJev+A1t7OXntn0mkkC+a
	Z6OriGEB0EOSZxSLGBwmh6KKbCy08zXkDHdS3Q+aTbtzJGRSBWjgdmjg9xysvMAC14Q4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNbie-0005xU-Te;
	Thu, 14 May 2026 19:27:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wNbic-0005xL-V8
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:27:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gHSl4ExTWcAo/O0B1+5mwc45i9K42nMjvHtIsync6A4=; b=YyjAYvZi9EJgtrx/qG3hzwF5OM
 WTeLU9jFy2X8j63shXZ35eE1dMy/GnQBEYjs9B/HfVxxdzWkjbcZV9WJpSOjWAgoF7dOTE44HITS5
 DvqXDhsUwbFYnQAJ5LijG5pdTA1ttREc6z/PJIIZoW+i1X9rV9J90pzu81E95+nc+Nws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gHSl4ExTWcAo/O0B1+5mwc45i9K42nMjvHtIsync6A4=; b=jDHFxqaxZbxj/bv9qtCKPGLLUb
 TEHWZ/IahCTwTMHr4X5zQDyZH0PTc7kgIId/AcEtDXCnPmuXkX1+GkzZfOrMpoDMMgHyBTk+IxTn3
 MZMy2ebGKuCoeENeAss6LjaHt67r+k1DgLppSKxS+ZT7EUju7nePNaV/BPlTf9eieCYg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNbiY-0006CA-2L for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:27:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64EJRRHQ032188
 for <openvpn-devel@lists.sourceforge.net>; Thu, 14 May 2026 21:27:27 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 64EJRRPB032187
 for openvpn-devel@lists.sourceforge.net; Thu, 14 May 2026 21:27:27 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 21:27:21 +0200
Message-ID: <20260514192727.31903-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
References: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wNbiY-0006CA-2L
Subject: [Openvpn-devel] [PATCH v8] options: Move <= 0 check for keepalive
 settings earlier
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

Use the atoi_constrained function.

Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1155
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1155
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 9e7ad93..4c540a6 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -552,14 +552,10 @@
         /*
          * Sanity checks.
          */
-        if (o->keepalive_ping <= 0 || o->keepalive_timeout <= 0)
-        {
-            msg(M_USAGE, "--keepalive parameters must be > 0");
-        }
         if (o->keepalive_ping * 2 > o->keepalive_timeout)
         {
             msg(M_USAGE,
-                "the second parameter to --keepalive (restart timeout=%d) must be at least twice the value of the first parameter (ping interval=%d).  A ratio of 1:5 or 1:6 would be even better.  Recommended setting is --keepalive 10 60.",
+                "The second parameter to --keepalive (restart timeout=%d) must be at least twice the value of the first parameter (ping interval=%d).  A ratio of 1:5 or 1:6 would be even better.  Recommended setting is --keepalive 10 60.",
                 o->keepalive_timeout, o->keepalive_ping);
         }
         if (o->ping_send_timeout || o->ping_rec_timeout)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e75b452..51d0418 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6755,8 +6755,8 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->keepalive_ping = atoi_warn(p[1], msglevel);
-        options->keepalive_timeout = atoi_warn(p[2], msglevel);
+        atoi_constrained(p[1], &options->keepalive_ping, "keepalive ping", 1, INT_MAX, msglevel);
+        atoi_constrained(p[2], &options->keepalive_timeout, "keepalive timeout", 1, INT_MAX, msglevel);
     }
     else if (streq(p[0], "ping") && p[1] && !p[2])
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
