Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC1606A8B3
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E9c4Gc4y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BCDW5bqU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DwxH0Hap
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h608QdzSuJnYYJz0vsM5LPfQCLpbkqPQF6F34ub2Gss=; b=E9c4Gc4yOrqblG
	i0sYFzqtWt4pgNYQ8S4MG7Acb//nPnEeAhHmWW9SRbfC//xAzqRYaBhAxBVAVHqz+5+Yl0UcQsWz5
	1VFqHnUX6TJ7wxo8uSy1RF5jVlJgjnfabrA73MJg5Q0DYG9414nbQg+QAQ24ZMzz8cIOSnlhprMw8
	Lfg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYmP-000000005rj-1StT;
	Thu, 12 Nov 2026 17:40:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRYmK-000000005ra-2s1j for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AcaqvwDinz3WEUJkQfbsMVU3tF+gw3nGL1FS0HHDmLc=; b=BCDW5bqUin+38V2EKgOiLCwt9d
 WIxG0r5vAtsz6B5jOfQhb4SzjMXfR4uPHChRzNE0lXD4xxQ4tB9048lenhtm3892jiq6bpux9tcPE
 HLvF5gNy/eSv7rDwzgQIIt7FhOjT5BMcu+BSEiZtH3Ejp2QjF43rQE2oqLt8mC5mtKfw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AcaqvwDinz3WEUJkQfbsMVU3tF+gw3nGL1FS0HHDmLc=; b=DwxH0HapDaBFBxfPFATFa+wRlS
 YtnTSg1rTpkJYQGcqPODGyzLSxtHGy/ZKhoGGNMwReXHlzC212mdY4FiNbgVku6ZHsEjyb2yB6n9x
 XOUv0QlTtz0moamkghes8ct10tjetGzY0o4VMZ8tUGCDep0crlGMN6OfeGEmLxqD958o=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRYmI-000000003jG-3Ld8 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:40:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ACHdtJ2023655
 for <openvpn-devel@lists.sourceforge.net>; Thu, 12 Nov 2026 18:39:55 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACHdtJt023654
 for openvpn-devel@lists.sourceforge.net; Thu, 12 Nov 2026 18:39:55 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 12 Nov 2026 18:39:50 +0100
Message-ID: <20261112173955.23638-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRYmI-000000003jG-3Ld8
Subject: [Openvpn-devel] [PATCH v2] networking_sitnl: Reduce boilerplate
 code for parameter checks
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Also removes some inconsistencies and some
sign conversion warnings.

Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2177
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2177
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 501c635..ee6229b 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -673,25 +673,37 @@
 
 #ifdef ENABLE_SITNL
 
+static int
+get_ifindex(const char *func, const char *iface, uint32_t *ifindex)
+{
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interface", func);
+        return -EINVAL;
+    }
+
+    *ifindex = if_nametoindex(iface);
+    if (*ifindex == 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", func, iface);
+        return -ENOENT;
+    }
+    return 0;
+}
+
+
 int
 net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;
-    int ifindex;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    if (!iface)
+    const int ret = get_ifindex(__func__, iface, &ifindex);
+    if (ret < 0)
     {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifindex = if_nametoindex(iface);
-    if (ifindex == 0)
-    {
-        msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface, strerror(errno));
-        return -ENOENT;
+        return ret;
     }
 
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
@@ -699,7 +711,7 @@
     req.n.nlmsg_type = RTM_SETLINK;
 
     req.i.ifi_family = AF_PACKET;
-    req.i.ifi_index = ifindex;
+    req.i.ifi_index = (int)ifindex;
     req.i.ifi_change |= IFF_UP;
     if (up)
     {
@@ -707,7 +719,7 @@
     }
     else
     {
-        req.i.ifi_flags &= ~IFF_UP;
+        req.i.ifi_flags &= ~(unsigned int)IFF_UP;
     }
 
     msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");
@@ -719,14 +731,13 @@
 net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifindex, ret = -1;
+    int ret = -1;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifindex = if_nametoindex(iface);
-    if (ifindex == 0)
+    if (get_ifindex(__func__, iface, &ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -1;
     }
 
@@ -735,7 +746,7 @@
     req.n.nlmsg_type = RTM_SETLINK;
 
     req.i.ifi_family = AF_PACKET;
-    req.i.ifi_index = ifindex;
+    req.i.ifi_index = (int)ifindex;
 
     SITNL_ADDATTR(&req.n, sizeof(req), IFLA_MTU, &mtu, 4);
 
@@ -750,14 +761,13 @@
 net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct sitnl_link_req req;
-    int ifindex, ret = -1;
+    int ret = -1;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifindex = if_nametoindex(iface);
-    if (ifindex == 0)
+    if (get_ifindex(__func__, iface, &ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -1;
     }
 
@@ -766,7 +776,7 @@
     req.n.nlmsg_type = RTM_SETLINK;
 
     req.i.ifi_family = AF_PACKET;
-    req.i.ifi_index = ifindex;
+    req.i.ifi_index = (int)ifindex;
 
     SITNL_ADDATTR(&req.n, sizeof(req), IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);
 
@@ -778,22 +788,19 @@
 }
 
 static int
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_family,
                const inet_address_t *local, const inet_address_t *remote, int prefixlen)
 {
     struct sitnl_addr_req req;
-    uint32_t size;
-    int ret = -EINVAL;
+    size_t size;
+    uint32_t ifindex;
 
-    CLEAR(req);
-
-    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
-    req.n.nlmsg_type = cmd;
-    req.n.nlmsg_flags = NLM_F_REQUEST | flags;
-
-    req.i.ifa_index = ifindex;
-    ASSERT(af_family <= UINT8_MAX);
-    req.i.ifa_family = (uint8_t)af_family;
+    int ret = get_ifindex(__func__, iface, &ifindex);
+    if (ret < 0)
+    {
+        return ret;
+    }
+    ret = -EINVAL; /* for SITNL_ADDATTR */
 
     switch (af_family)
     {
@@ -810,10 +817,20 @@
             return -EINVAL;
     }
 
+    CLEAR(req);
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_type = cmd;
+    req.n.nlmsg_flags = NLM_F_REQUEST | flags;
+
+    req.i.ifa_index = ifindex;
+    ASSERT(af_family <= UINT8_MAX);
+    req.i.ifa_family = (uint8_t)af_family;
+
     /* if no prefixlen has been specified, assume host address */
     if (prefixlen == 0)
     {
-        prefixlen = size * 8;
+        prefixlen = (int)size * 8;
     }
     ASSERT(prefixlen <= UINT8_MAX);
     req.i.ifa_prefixlen = (uint8_t)prefixlen;
@@ -848,76 +865,37 @@
 sitnl_addr_ptp_add(sa_family_t af_family, const char *iface, const inet_address_t *local,
                    const inet_address_t *remote)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-            break;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifindex = if_nametoindex(iface);
-    if (ifindex == 0)
-    {
-        msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(iface), strerror(errno));
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, local,
                           remote, 0);
 }
 
 static int
 sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, const inet_address_t *local)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-            break;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifindex = if_nametoindex(iface);
-    if (ifindex == 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, local, NULL, 0);
 }
 
 static int
-sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *dst,
+sitnl_route_set(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_family, const void *dst,
                 int prefixlen, const void *gw, enum rt_class_t table, int metric,
                 enum rt_scope_t scope, unsigned char protocol, unsigned char type)
 {
     struct sitnl_route_req req;
-    int ret = -1, size;
+    int ret = -1;
+    size_t size;
+    uint32_t ifindex = 0;
 
     CLEAR(req);
 
+    if (iface)
+    {
+        const int ret = get_ifindex(__func__, iface, &ifindex);
+        if (ret < 0)
+        {
+            return ret;
+        }
+    }
+
     switch (af_family)
     {
         case AF_INET:
@@ -982,64 +960,14 @@
 static int
 sitnl_addr_add(sa_family_t af_family, const char *iface, const inet_address_t *addr, int prefixlen)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-            break;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifindex = if_nametoindex(iface);
-    if (ifindex == 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, addr, NULL,
                           prefixlen);
 }
 
 static int
 sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_address_t *addr, int prefixlen)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_INET:
-        case AF_INET6:
-            break;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
-
-    ifindex = if_nametoindex(iface);
-    if (ifindex == 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, addr, NULL, prefixlen);
 }
 
 int
@@ -1174,17 +1102,6 @@
                 const void *gw, uint32_t table, int metric)
 {
     enum rt_scope_t scope = RT_SCOPE_UNIVERSE;
-    int ifindex = 0;
-
-    if (iface)
-    {
-        ifindex = if_nametoindex(iface);
-        if (ifindex == 0)
-        {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __func__, iface);
-            return -ENOENT;
-        }
-    }
 
     if (table == 0)
     {
@@ -1196,7 +1113,7 @@
         scope = RT_SCOPE_LINK;
     }
 
-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,
+    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,
                            table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
@@ -1258,24 +1175,12 @@
 sitnl_route_del(const char *iface, sa_family_t af_family, const inet_address_t *dst, int prefixlen,
                 const inet_address_t *gw, uint32_t table, int metric)
 {
-    int ifindex = 0;
-
-    if (iface)
-    {
-        ifindex = if_nametoindex(iface);
-        if (ifindex == 0)
-        {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __func__, iface);
-            return -ENOENT;
-        }
-    }
-
     if (table == 0)
     {
         table = RT_TABLE_MAIN;
     }
 
-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,
+    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, metric,
                            RT_SCOPE_NOWHERE, 0, 0);
 }
 
@@ -1439,7 +1344,7 @@
 net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_link_req req = {};
-    int ifindex = if_nametoindex(iface);
+    int ifindex = (int)if_nametoindex(iface);
 
     if (!ifindex)
     {
@@ -1471,7 +1376,7 @@
 net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
     struct sitnl_link_req req = {};
-    int ifindex = if_nametoindex(iface);
+    int ifindex = (int)if_nametoindex(iface);
 
     if (!ifindex)
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
