Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C51C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txNzFFfVBQkWDYR3vfhax3izHp5zZDYU5EDvjpSsYW0=; b=LTQBMGJuheETKX9uXUXyC70PV7
	OirFpuEgwfom/fAIwLQLv/JGdurSJ0dh9fRilJc1UO4eIgg+IF+KixtVJFNMzVD71NVWAhbs4aMu9
	M6KZlfB5nm1eK9mIv+uURSWFn9wV43j16eF4ir2P4/pZs9kuTFbiMPWYzLwaq59wtCug=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6QV-0000HI-Ki;
	Wed, 29 Jul 2026 15:42:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp6QH-0000Gm-7W
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WapK7H1NDi6EtOG50cprXW6e9N5mJDrFi0U+8naQrBk=; b=FvnUf76biez6V5iKS+MV2dDnDh
 bVZujNj03eHYzDagNdEvFe3j2WJIGrx+St4CYPTmGhDPXxRe8TsfTtoyjARAORJwtjQWOg2mgXo+C
 Z3nv+Y9vNKupwg4UJV5IgVM+jjgUQ4BdoaaD/dYLPdlqDMVBrUc2pGAoO210x9NH+9/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WapK7H1NDi6EtOG50cprXW6e9N5mJDrFi0U+8naQrBk=; b=YJFwLuVrRk03YIJEnKs1EHROH1
 Rus1N+k4OVmHZbjW7i+vJ2p7hY5kdBi6HuBYaXy8Yx1EQdfGEjWl0EzASxgvFx53v3V27rQQyFhuI
 j4/f6gX3ywR9Z68McJ0uxSdQjnrc55cNI9a1sy8nTfwy1JgMQFA6occViI9zvKf/b/XQ=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6QH-0001TD-JU for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:18 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4h9GmL5713zXb;
 Wed, 29 Jul 2026 17:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WapK7H1NDi6EtOG50cprXW6e9N5mJDrFi0U+8naQrBk=;
 b=yd+q9AMwqB+ArkwOkdvwEOo2Y158MgikpViOtHIuZjMYIpBFpia3dj0nBXYjrQgoCkktCR
 xr9JqRbZl44FnmnrMos9bZdYf+UM1bPdGn2tQ/lPELK/TKovjItwO3NM9m7/IcnumaxjI2
 b91L0OsVqccG+QAKwxNPQHe8IQJxXLKOfx6vQf1SiuQsd0gisuUMMBteMe0Ckqmm+Yujo0
 6OzMs9ILhiA/KStVyMq9BbyfktvkVL6Nw8Y97MaIhTohP0MGSVFouBRgz5vpHofAdNMiDv
 Gk1vXLtoeiwRUFYPtSfsVUmTzDPXvFm+/JuUf8pcO5vRH2cb3Z5tkHrUFQ5RGg==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:37:41 +0200
Message-ID: <17ced9a7caee691e602e3c02f5e399aa9a35067c.1785338921.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785338921.git.ralf@mandelbit.com>
References: <cover.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp6QH-0001TD-JU
Subject: [Openvpn-devel] [PATCH ovpn net 3/5] ovpn: reject multipeer peers
 without VPN addresses
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

In MP mode, ovpn uses the peer VPN addresses to select the peer for
outgoing tunnel packets. Peer creation currently requires a VPN IPv4 or
IPv6 attribute, but it only checks for the presence of the attribute and
not for a usable address value.

This allows userspace to create an MP peer with only unspecified VPN
addresses, or to update an existing peer so that both VPN address
families become unspecified. Such a peer cannot be selected through the
VPN address hash tables.

Reject MP peer creation or update when the resulting peer would not have
at least one VPN address configured.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 47 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 79775af26fda..43e6c7a29a6f 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -346,8 +346,10 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct in_addr vpn_addr4 = { .s_addr = INADDR_ANY };
+	struct in6_addr vpn_addr6 = IN6ADDR_ANY_INIT;
 	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_socket *ovpn_sock;
 	struct socket *sock = NULL;
 	struct ovpn_peer *peer;
@@ -371,11 +373,19 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* in MP mode VPN IPs are required for selecting the right peer */
-	if (ovpn->mode == OVPN_MODE_MP && !attrs[OVPN_A_PEER_VPN_IPV4] &&
-	    !attrs[OVPN_A_PEER_VPN_IPV6]) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "VPN IP must be provided in MP mode");
-		return -EINVAL;
+	if (ovpn->mode == OVPN_MODE_MP) {
+		if (attrs[OVPN_A_PEER_VPN_IPV4])
+			vpn_addr4.s_addr =
+				nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+		if (attrs[OVPN_A_PEER_VPN_IPV6])
+			vpn_addr6 =
+				nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+
+		if (!vpn_addr4.s_addr && ipv6_addr_any(&vpn_addr6)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "VPN IP must be provided in MP mode");
+			return -EINVAL;
+		}
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
@@ -534,13 +544,24 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (attrs[OVPN_A_PEER_VPN_IPV6])
 		vpn_addr6 = nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
 
-	/* reject peer with conflicting VPN address */
-	if ((attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_IPV6]) &&
-	    ovpn_peer_vpn_addr_conflict(ovpn, peer, &vpn_addr4, &vpn_addr6)) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "VPN IP is already assigned to another peer");
-		ret = -EADDRINUSE;
-		goto unlock;
+	/* in MP mode VPN IPs are required for selecting the right peer */
+	if (ovpn->mode == OVPN_MODE_MP &&
+	    (attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_IPV6])) {
+		if (!vpn_addr4.s_addr && ipv6_addr_any(&vpn_addr6)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "MP peer must have at least one valid VPN IP");
+			ret = -EINVAL;
+			goto unlock;
+		}
+
+		/* reject peer with conflicting VPN address */
+		if (ovpn_peer_vpn_addr_conflict(ovpn, peer, &vpn_addr4,
+						&vpn_addr6)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "VPN IP is already assigned to another peer");
+			ret = -EADDRINUSE;
+			goto unlock;
+		}
 	}
 
 	ret = ovpn_nl_peer_modify(peer, info, attrs);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
