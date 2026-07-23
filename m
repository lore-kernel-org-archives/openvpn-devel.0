Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F302EC531CB
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ArBZBlweqdkuayLmQC4YMT1/xBFcvlX/Ws8tVSvSvjs=; b=AoRRbyDyeLQOrsUU8BvPy9VbKV
	5KHrsBAiWafEaTaisYCFcokL0QTw9YfJ7fJy7AYnNK5TP1iM16F3VvZR13qpfydOzLjbyKsPvpiKx
	VO7ApMqfmFH96KYbzJ26tzj5SN0Ec+H25BItsakDoyFgzwJQDpkiJ1ihssv/HgBXwKC4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmrLJ-0004hY-DX;
	Thu, 23 Jul 2026 11:11:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <haiku-os@quietcode.org>) id 1wmrLH-0004hO-My
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 11:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CWVmdya4qFf803mfF87kx/GJDQ0iQ+BEHkhefBt7D4s=; b=ReG7Jm46aImbAOng3zDhin0nPg
 IxhSXtNeIk07lxkrILJCqJU4EqYzY5K7Igy0rdifk6gbDamVdDf+V8K9TywRciMb5Xh5TRgqxTS6Z
 6MpvzIBhdz88kwdz5vqgFOeNx5e/I1j0Bn7Qf9tQZIYnlRwRqb8l6hJFvTihghibkOgI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CWVmdya4qFf803mfF87kx/GJDQ0iQ+BEHkhefBt7D4s=; b=l
 u4VcBpM1jJp7tfdRntP9uhGLYfVavt6hhwm6uJfgTJrC+PkTz1rfWl5fnXf2LYY6O+gI/7SPhWlgm
 uCXgf2QbBLW3ta/AoiBrxUtXaXz4zgCV/MeHcKHmkho5l96Muu8+JUqNvC9Yzi4bDRAaQXNJHUXFk
 1bGJQ6TGLGv6syLo=;
Received: from dd37824.kasserver.com ([85.13.157.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmrLK-0001Mb-3M for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 11:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quietcode.org;
 s=kas202603051731; t=1784804010;
 bh=CWVmdya4qFf803mfF87kx/GJDQ0iQ+BEHkhefBt7D4s=;
 h=From:To:Cc:Subject:Date:From;
 b=SvgK3AWZdCZ9L0g/6i03v2PYdgNGuO0zcIMU5/cmpbhCYOXcJVhEjWwZHZcGCM0jQ
 o5Fp9HechA1z8dqxUG3RLOwl4Mu4KrKhBqtS7DxaFur4KrWEZrMESLsG9HiWLL+Ofr
 UQSce212qA0MBPnfGXtX6PMPYKpxlG1MN6BdN1zLsTH7DADsSEJJswKBg29h3xbxf+
 f7uDcQTZMFBHblq/jnGWsSsc+KNh2uWS77sQ4s/9WucsAPbRtoZnpFbZiwCFC0OOZR
 /g1ItOWWhnaPBPjqm4xD84mHA6y2YRErrNbcTJ26ap5BPDt05zBsUoLiawmXCof3zM
 P8juBxHJWE7jA==
Received: from voelundr.fritz.box (unknown [155.133.212.114])
 by dd37824.kasserver.com (Postfix) with ESMTPSA id 5DAAD1980F1D;
 Thu, 23 Jul 2026 12:53:30 +0200 (CEST)
From: Andreas Just <haiku-os@quietcode.org>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 23 Jul 2026 12:55:18 +0200
Message-ID: <20260723105518.2363-1-haiku-os@quietcode.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Bar: --
X-Headers-End: 1wmrLK-0001Mb-3M
Subject: [Openvpn-devel] [PATCH] Haiku: Route VPN networks through tunnel
 interface
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

The Haiku IPv4 route implementation always passes rgi->iface to route(8).
That interface describes the pre-VPN default gateway, so ordinary VPN
routes are attached to the physical interface even when their gateway is
the tunnel peer.

Use the recorded physical interface only when the route gateway matches
the recorded pre-VPN default gateway. Use the actual tunnel interface for
other IPv4 VPN routes.

Apply the same interface selection to route addition and deletion.

Signed-off-by: Andreas Just <haiku-os@quietcode.org>
---
 src/openvpn/route.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 81ce867..e1d00f4 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1477,6 +1477,23 @@ is_on_link(const int is_local_route, const unsigned int flags, const struct rout
 }
 #endif
 
+#if defined(TARGET_HAIKU)
+static const char *
+haiku_route_interface(const struct route_ipv4 *r, const struct tuntap *tt,
+                      const struct route_gateway_info *rgi)
+{
+    const unsigned int required_flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+
+    if (rgi != NULL && (rgi->flags & required_flags) == required_flags
+        && r->gateway == rgi->gateway.addr)
+    {
+        return rgi->iface;
+    }
+
+    return tt->actual_name;
+}
+#endif
+
 bool
 add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
           const struct route_gateway_info *rgi, /* may be NULL */
@@ -1733,8 +1750,8 @@ add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
 #elif defined(TARGET_HAIKU)
 
     /* ex: route add /dev/net/ipro1000/0 0.0.0.0 gw 192.168.1.1 netmask 128.0.0.0 */
-    argv_printf(&argv, "%s add %s inet %s gw %s netmask %s", ROUTE_PATH, rgi->iface, network,
-                gateway, netmask);
+    argv_printf(&argv, "%s add %s inet %s gw %s netmask %s", ROUTE_PATH,
+                haiku_route_interface(r, tt, rgi), network, gateway, netmask);
     argv_msg(D_ROUTE, &argv);
     bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route add command failed");
     status = ret ? RTA_SUCCESS : RTA_ERROR;
@@ -2176,8 +2193,8 @@ delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
 #elif defined(TARGET_HAIKU)
 
     /* ex: route delete /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0 */
-    argv_printf(&argv, "%s delete %s inet %s gw %s netmask %s", ROUTE_PATH, rgi->iface, network,
-                gateway, netmask);
+    argv_printf(&argv, "%s delete %s inet %s gw %s netmask %s", ROUTE_PATH,
+                haiku_route_interface(r, tt, rgi), network, gateway, netmask);
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route delete command failed");
 
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
