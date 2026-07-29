Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB55C53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jj/mWuysYByh5XYW82uBnbUvdDoErBPDd7MDWKVZRTk=; b=DZO+CFfiHemSOV90yMDnXtTrpt
	YL4Du+pTIdsZClc8f/+BZOuwVq/JNxAmUrupX8l2X+yHB4l/SgrAML83ICCmkpEmYZJ8+baMpVfAJ
	naVsFFzEwfxTzm4cnk3kiczP/8tBLGIxF7JekHUXYKzbLZYSxgP6zz7/yDwdnAprAG2M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6QV-0002WU-7m;
	Wed, 29 Jul 2026 15:42:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp6QG-0002Vr-1C
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gkiR86nWJ5KqIffl2XADuoX6NqgPodYASX0slnIbrSs=; b=IsfABJ168zCTwXzdtc+LpxCiIm
 3icEO2btCPsFd9Qt4Oiyq3sD5gS5CCaSiMkFwTOuLS44/DrbkKmcb9bPteVaLCMsCGh5hnkDhG8lv
 qOW/Yoq1yQ7XaCd7OwBaNubgYO8uGK63GiHiMFlo5tGw6esxPQICPxfMpLDNYAeSTYq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gkiR86nWJ5KqIffl2XADuoX6NqgPodYASX0slnIbrSs=; b=YWYrjhtoeZe4EdbcCZh46AHWFv
 qXDfi6tkZEQwnEc/DP8DyrPhQ4wVLs/fmDEK01vfftJa27jRrIToaEnew1OoNV9WcOQv6aHDn7Q48
 bnjoJluAZcpR8A22FcpGdJwOpiH96tphrIuKd7e070XksqQxl0H12j8bPK5HiNLvNRTA=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6QF-0002u5-7O for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:19 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4h9GmM368sz3y60;
 Wed, 29 Jul 2026 17:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkiR86nWJ5KqIffl2XADuoX6NqgPodYASX0slnIbrSs=;
 b=SIV4qATOqdw7Y+vc4QdGXW+eBDn9M9eZ/GXjkvbawug50GzLIIl9Q+xnxAIZK14RsuC1WK
 BlOrI50lr6hTGDs26yab88VQEQt65O94d1nFnWVFqCXXNBQFvt2JhPdpiiqyXRtY82f0XD
 0dJOB7iOMNIs7HmLRU/ipLBU+4fe1ZSQZndyRcPThJAdkjZnIniT4xLukzbvNnYEX+I3cu
 wUNblq9dyIi6C2xDdOZifEwxTtFcBHDFqlDuLh+TwLEK96fkRwAimGMXXHZgIM8/FOgUQ0
 V2lgW6lnPGlb/ZXUYbQL8STlHvf5JScLGg/f9udww2LeGbJfaT5BCyzxzjedPg==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:37:42 +0200
Message-ID: <934f840c132e350415369712806b3d9d77957ca5.1785338921.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785338921.git.ralf@mandelbit.com>
References: <cover.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp6QF-0002u5-7O
Subject: [Openvpn-devel] [PATCH ovpn net 4/5] ovpn: reject invalid peer VPN
 addresses
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

In MP mode, ovpn uses peer VPN addresses as lookup keys for selecting
the peer that should receive outgoing tunnel packets. The netlink
configuration path currently accepts address values that cannot sensibly
identify a VPN peer, such as multicast, broadcast or loopback addresses.

Reject invalid peer VPN addresses when creating or updating an MP peer.
Keep accepting the unspecified address as the internal unset value,
provided that at least one VPN address family remains configured.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 50 ++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 43e6c7a29a6f..333e9237e594 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -179,6 +179,39 @@ static sa_family_t ovpn_nl_family_get(struct nlattr *addr4,
 	return AF_UNSPEC;
 }
 
+static int ovpn_nl_peer_check_vpn_addrs(const struct in_addr *addr4,
+					const struct in6_addr *addr6,
+					struct genl_info *info)
+{
+	int addr6_type;
+
+	if (addr4->s_addr == htonl(INADDR_ANY) && ipv6_addr_any(addr6)) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "at least one VPN IP must be configured");
+		return -EINVAL;
+	}
+
+	if (ipv4_is_multicast(addr4->s_addr) || ipv4_is_lbcast(addr4->s_addr) ||
+	    ipv4_is_loopback(addr4->s_addr)) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "VPN IPv4 address must be valid unicast or any");
+		return -EADDRNOTAVAIL;
+	}
+
+	if (!ipv6_addr_any(addr6)) {
+		addr6_type = ipv6_addr_type(addr6);
+
+		if (!(addr6_type & IPV6_ADDR_UNICAST) ||
+		    (addr6_type & (IPV6_ADDR_LOOPBACK | IPV6_ADDR_COMPATv4))) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "VPN IPv6 address must be valid unicast or any");
+			return -EADDRNOTAVAIL;
+		}
+	}
+
+	return 0;
+}
+
 static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
 				 struct genl_info *info,
 				 struct nlattr **attrs)
@@ -381,11 +414,10 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 			vpn_addr6 =
 				nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
 
-		if (!vpn_addr4.s_addr && ipv6_addr_any(&vpn_addr6)) {
-			NL_SET_ERR_MSG_FMT_MOD(info->extack,
-					       "VPN IP must be provided in MP mode");
-			return -EINVAL;
-		}
+		ret = ovpn_nl_peer_check_vpn_addrs(&vpn_addr4, &vpn_addr6,
+						   info);
+		if (ret < 0)
+			return ret;
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
@@ -547,12 +579,10 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	/* in MP mode VPN IPs are required for selecting the right peer */
 	if (ovpn->mode == OVPN_MODE_MP &&
 	    (attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_IPV6])) {
-		if (!vpn_addr4.s_addr && ipv6_addr_any(&vpn_addr6)) {
-			NL_SET_ERR_MSG_FMT_MOD(info->extack,
-					       "MP peer must have at least one valid VPN IP");
-			ret = -EINVAL;
+		ret = ovpn_nl_peer_check_vpn_addrs(&vpn_addr4, &vpn_addr6,
+						   info);
+		if (ret < 0)
 			goto unlock;
-		}
 
 		/* reject peer with conflicting VPN address */
 		if (ovpn_peer_vpn_addr_conflict(ovpn, peer, &vpn_addr4,
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
