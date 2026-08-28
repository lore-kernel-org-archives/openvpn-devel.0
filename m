Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48018C61DDA
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1l+znuyS9Iq2X8+ZUk55dxxrAhapFh0acSpaa5HkgLw=; b=A8ZERpLeuxx4j3jXSCnUHzQbVj
	CFyCVj6UjVLSc2s7vVvnXmqI/83WwtLMUL9dfNRWeDujEaRB892dcYdnbkB5vS84LjKk5DX6m2Tsx
	vq6H7hA1W6PbSLpE+grwuOUs+8PwOrI/TR8ghTpljzz3/AjpMfsnFAdpa8giFUSAAnkU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzwCj-0001b4-7H;
	Fri, 28 Aug 2026 13:01:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzwCM-0001aM-JL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l3kKVzpsCJJNFGYtCfLWekadyfB69gwfvzgBALJzdSw=; b=Zwb1iDyMXgw6n0g4VcrPDEGztn
 lM3WSjscl/9bpEPq6zhtPTdSdJ0NxtYU9Uo8JioVN+LTC39SsCRX8/eHzBohHZHpwI6NpcnOLHZ9a
 aJwfQgrIkfEp+Rpoe/AniJwcs8MxrsQqn5kdp5dj6TBmk8szxmC8OsnhYepMNyUt9sDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l3kKVzpsCJJNFGYtCfLWekadyfB69gwfvzgBALJzdSw=; b=WQtq3vEiUUYP0HunglGQBnnYBD
 42gmcMnMoSrcYvt3wpkzcJ3JxTcVLKj42EF6wW2tlZExIC5ivB0876chvTLTVGpNdaYsW3tEcP7cD
 9rUxTjsI1vVuy+twFz3e1+eTJ/FgHaJ3bS4hy1FfK2Fcf3nrNMBL8MoMjB/OUa3DIRPM=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzwCH-0003Ww-7C for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:45 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hWdlx2S8Pz5wPq;
 Fri, 28 Aug 2026 15:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787922029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3kKVzpsCJJNFGYtCfLWekadyfB69gwfvzgBALJzdSw=;
 b=Swe3vX+2qqRES9i5QHz1w9BqUrRwOXIYf9fhPByes6If/YazAoUf3wyVpdCsE+aH5GNyGP
 skjx6x3lXo3KxoCFfL75aNovUEcS0FgkhgLtqxOnekxDTe806um638UrS4XzYvWRyXrwaB
 t+O599tP9nsCQsfLJ25hPZG1ZwNuZnf14pPn7dHHdnHcEK5gdbKPNNIJ/v60mfR0nO8tFy
 19/OH3DNFSDpEw9abLKnubM4JyTPUA+lQCAMqiIKrKqUzTQaa+XKSn40aVXmh8CSX7TvzT
 s7XEUnCWeKpXqzyZLknpkcP0ekrJFZN/oZ23fvO1LSYg1+M+No7jdVoRoatvbA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 15:00:09 +0200
Message-ID: <1bddf9d3f19e8d74d831526e9ce80182bcfcab73.1787919082.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787919082.git.ralf@mandelbit.com>
References: <cover.1787919082.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wzwCH-0003Ww-7C
Subject: [Openvpn-devel] [PATCH ovpn net v2 4/5] ovpn: reject invalid peer
 VPN addresses
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
Changes since v1 https://lore.kernel.org/openvpn-devel/934f840c132e350415369712806b3d9d77957ca5.1785338921.git.ralf@mandelbit.com/
- Adapted to changes in 2/5 and 3/5; no behavioral changes.

 drivers/net/ovpn/netlink.c | 55 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index a0ed09278a6b..e9fef784dfc1 100644
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
+				   "at least one VPN IP must be configured in MP mode");
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
@@ -381,12 +414,10 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 			vpn_addr6 =
 				nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
 
-		if (vpn_addr4.s_addr == htonl(INADDR_ANY) &&
-		    ipv6_addr_any(&vpn_addr6)) {
-			NL_SET_ERR_MSG_FMT_MOD(info->extack,
-					       "at least one VPN IP must be configured in MP mode");
-			return -EINVAL;
-		}
+		ret = ovpn_nl_peer_check_vpn_addrs(&vpn_addr4, &vpn_addr6,
+						   info);
+		if (ret < 0)
+			return ret;
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
@@ -552,13 +583,11 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* in MP mode VPN IPs are required for selecting the right peer */
-	if (ovpn->mode == OVPN_MODE_MP &&
-	    vpn_addr4.s_addr == htonl(INADDR_ANY) &&
-	    ipv6_addr_any(&vpn_addr6)) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "at least one VPN IP must be configured in MP mode");
-		ret = -EINVAL;
-		goto unlock;
+	if (ovpn->mode == OVPN_MODE_MP) {
+		ret = ovpn_nl_peer_check_vpn_addrs(&vpn_addr4, &vpn_addr6,
+						   info);
+		if (ret < 0)
+			goto unlock;
 	}
 
 	ret = ovpn_nl_peer_modify(peer, info, attrs);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
