Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2F9C5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tg6+rXh9aZFbfGmuE1EEzXo3iFguaUJC98mAD71SGlE=; b=XNuxnyGfqHnI8zr+K1rQExiiJd
	u4lIRnP221Wk8ei81VirZZcvUPKRZ6UM3p3+cIhbzsADnhpH3hxJmuFp3xsNLaL0SK3WEEupYrrG1
	E4pJLyYRG2DPgZL3lnJ2oiPKaMI8+zJC1dbEYa0sc1R241qJp4ZmwQAEIh+l0hbaWVMY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXJr-0005In-9z;
	Mon, 24 Aug 2026 16:14:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyXJp-0005Ig-Rx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:14:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcUpNFdxA05Fpvps0G9ZbfFKOXOI5tBQSDizlp5PVNw=; b=lqXbmfxp+MUYRfZxGg3fFCQqwB
 ZEqmeY5vCQ/DRrr36JXc5V3PP1voDZ2vLnPx6igPd6iwXMflZ1/Uc8gSywvH8PrZhcFz2Mm+hV6N/
 HEI7T+/pwlOFpY8nrNTXatHcRoalf/jP79nj6PpPGiOqgZJ24HM0Ptdj+cOzTerOrUrY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PcUpNFdxA05Fpvps0G9ZbfFKOXOI5tBQSDizlp5PVNw=; b=dlhPmMUz0KM7FonSjODK9XX6Di
 hsgYt9UomQ3PeJC2BWoZSD2ZWXd8oaRZxPg7HgtY6VSvsWk60+bq2tzT6eW6QqH03iwrmfjEUGuft
 yjiPLuVND40d2jtp75Bvv45kYOj7A3oM8Pd9CnB2KU9xS9foKtC9gl0M7YAKvFep5AVg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyXJm-0007L7-Co for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:14:39 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OGEV10001656
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 18:14:31 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OGEVsK001655
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 18:14:31 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 18:14:25 +0200
Message-ID: <20260824161431.1639-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
References: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyXJm-0007L7-Co
Subject: [Openvpn-devel] [PATCH v1] route: Remove unused function
 print_routes
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

This function has never been used in the git history.
Probably an OpenVPN 1.x remnant.

Identified by cppcheck.

Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1865
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1865
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8ea745d..6dbe3ec 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -185,19 +185,6 @@
     dest->gc = a;
 }
 
-static const char *
-route_string(const struct route_ipv4 *r, struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(256, gc);
-    buf_printf(&out, "ROUTE network %s netmask %s gateway %s", print_in_addr_t(r->network, 0, gc),
-               print_in_addr_t(r->netmask, 0, gc), print_in_addr_t(r->gateway, 0, gc));
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        buf_printf(&out, " metric %d", r->metric);
-    }
-    return BSTR(&out);
-}
-
 static bool
 is_route_parm_defined(const char *parm)
 {
@@ -1325,27 +1312,6 @@
 #endif /* ifndef ENABLE_SMALL */
 
 static void
-print_route(const struct route_ipv4 *r, msglvl_t msglevel)
-{
-    struct gc_arena gc = gc_new();
-    if (r->flags & RT_DEFINED)
-    {
-        msg(msglevel, "%s", route_string(r, &gc));
-    }
-    gc_free(&gc);
-}
-
-void
-print_routes(const struct route_list *rl, msglvl_t msglevel)
-{
-    struct route_ipv4 *r;
-    for (r = rl->routes; r; r = r->next)
-    {
-        print_route(r, msglevel);
-    }
-}
-
-static void
 setenv_route(struct env_set *es, const struct route_ipv4 *r, int i)
 {
     struct gc_arena gc = gc_new();
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 473df87..0d33d36 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -377,8 +377,6 @@
 
 #endif
 
-void print_routes(const struct route_list *rl, msglvl_t msglevel);
-
 #ifdef _WIN32
 
 void show_routes(msglvl_t msglevel);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
