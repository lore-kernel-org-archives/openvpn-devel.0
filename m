Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A4606A334
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Cy8RPad6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=me1UdYuo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SICEduDC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GfvK+wEzKNizQY2x7eEki0u7X3eZf47IepnqtvTibLo=; b=Cy8RPad6NEHoGn
	iCsfJSzEdKek1HzSv7GDZ556WnWTCrrHIIiBuQOf1h0bx5CNOEkW7Ykh8neJv9Sa7pclylBTApYuC
	4IVCYylyphB9PJIaccMX7M38egY06Bc7pZjqjHf+c8ORPypOFtOENqlmNLUr05B65/r9ZH3FE/rh4
	qL4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRA8d-000000003Sv-1oXh;
	Wed, 11 Nov 2026 15:21:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRA8X-000000003Sm-3H4t for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 15:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjNp4OE80Pr74KYbBR/M6IPtIiccWApI8W+0w7e3QzE=; b=me1UdYuoY+lArIgD6dylAZ8ra8
 3kGovcMN7SUW1HC2jYf3wQqwegKNSJO3ZyyDSlUYlwZO3u11H/1gd3DagKTerBrXHcHamvkvUjaYY
 c68VsKzPNkSxLEvxI4PoWEjnr2aLy65JX4h2dA4DbD73FXa37jVgmLrJSlJUkLPgLsqw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjNp4OE80Pr74KYbBR/M6IPtIiccWApI8W+0w7e3QzE=; b=SICEduDCrjsf60U5i+cVl/f2ve
 VUWYL/HHPRlLBVl6jD209E7QQD04ZpskUQuVmbatw9AndDc7XfskftP3HKLqAth4Z1103YM03Mqb7
 MPZ6gHdZ4iPXd9dDTnFcT0MP23tsVv74v2IGgs5uobTHrA2gL+ZiVOtiflzYy9GZ5XrA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRA8W-000000000kF-1iBa for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 15:21:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ABFLDRd031493
 for <openvpn-devel@lists.sourceforge.net>; Wed, 11 Nov 2026 16:21:13 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ABFLDMO031492
 for openvpn-devel@lists.sourceforge.net; Wed, 11 Nov 2026 16:21:13 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 16:21:07 +0100
Message-ID: <20261111152112.31478-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRA8W-000000000kF-1iBa
Subject: [Openvpn-devel] [PATCH v2] Silence remaining cppcheck warnings on
 macOS and FreeBSD
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

From: Arne Schwabe <arne@rfc2549.org>

Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2108
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2108
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d0d26c6..449b4f1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3331,7 +3331,6 @@
     int rtm_addrs;
     struct sockaddr so_dst, so_mask;
     char *cp = m_rtmsg.m_space;
-    struct sockaddr *gate = NULL, *ifp = NULL, *sa;
     struct rt_msghdr *rtm_aux;
 
 #define rtm m_rtmsg.m_rtm
@@ -3396,6 +3395,8 @@
     sockfd = -1;
 
     /* extract return data from routing socket */
+    const struct sockaddr_in *gate = NULL;
+    const struct sockaddr_dl *adl = NULL;
     rtm_aux = &rtm;
     cp = (char *)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
@@ -3404,14 +3405,14 @@
         {
             if (i & rtm_aux->rtm_addrs)
             {
-                sa = (struct sockaddr *)cp;
+                const struct sockaddr *sa = (const struct sockaddr *)cp;
                 if (i == RTA_GATEWAY)
                 {
-                    gate = sa;
+                    gate = (const struct sockaddr_in *)sa;
                 }
                 else if (i == RTA_IFP)
                 {
-                    ifp = sa;
+                    adl = (const struct sockaddr_dl *)sa;
                 }
                 ADVANCE(cp, sa);
             }
@@ -3423,19 +3424,18 @@
     }
 
     /* get gateway addr and interface name */
-    if (gate != NULL)
+    if (gate)
     {
         /* get default gateway addr */
-        rgi->gateway.addr = ntohl(((struct sockaddr_in *)gate)->sin_addr.s_addr);
+        rgi->gateway.addr = ntohl((gate)->sin_addr.s_addr);
         if (rgi->gateway.addr)
         {
             rgi->flags |= RGI_ADDR_DEFINED;
         }
 
-        if (ifp)
+        if (adl)
         {
             /* get interface name */
-            const struct sockaddr_dl *adl = (struct sockaddr_dl *)ifp;
             if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi->iface))
             {
                 memcpy(rgi->iface, adl->sdl_data, adl->sdl_nlen);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index bcea331..a1f9886 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1040,7 +1040,7 @@
  * @param ctx       the networking API opaque context
  */
 static void
-do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,
+do_ifconfig_ipv6(const struct tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,
                  openvpn_net_ctx_t *ctx)
 {
 #if !defined(TARGET_LINUX)
@@ -1231,7 +1231,7 @@
  * @param ctx       the networking API opaque context
  */
 static void
-do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,
+do_ifconfig_ipv4(const struct tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,
                  openvpn_net_ctx_t *ctx)
 {
 #if !defined(_WIN32) && !defined(TARGET_ANDROID)
@@ -1587,7 +1587,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, const openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits = netmask_to_netbits2(tt->remote_netmask);
@@ -1622,7 +1622,7 @@
 }
 
 static void
-undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv6(const struct tuntap *tt, const openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6, tt->netbits_ipv6) < 0)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
