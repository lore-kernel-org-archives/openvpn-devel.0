Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE79C61DD7
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWPkrGgvVjN58GRu/eOguuiC+yrB49p3loCJxkTKbOk=; b=cH9vmQ6Boof3BamFWt12R820qJ
	n5p6NiRLSvlakAf1ayPJE3hSKXj0sDt2pfQ1mLh0x5Nl1xsoac+g6O3NK9XsghC5NTbcR8zBBeOpm
	srnF0xmNzWz44PJGI/RZoDIe6SqekZOk9MhHpv5g/soO2xIjq28Jsx5nDMcmrxjGYIk4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzwCl-0003Hr-22;
	Fri, 28 Aug 2026 13:01:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzwCP-0003H4-UN
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eA/0FjXZziVVh1UlSjwtBwDjZ/Se2eCwuRS93nmojG0=; b=HQIZWT1FGabrgmYMbzSdq8r4s0
 p5SGp9iFVROoQCB8P4Sp2FYZw7uKGJSLOdBK6tTzlfWo8EaoBuy+OWt/QRW/UvzVPXpPFJ/QkxRB2
 cChHKXI7P3G3Uq3LdgNO7Rp/sN+6nDE8eMI43xrcseQM+mtFqGae2SMABEP2ug5V1pj0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eA/0FjXZziVVh1UlSjwtBwDjZ/Se2eCwuRS93nmojG0=; b=fPjTW4Gpn6N4XxHIAGmAcrsLZ2
 Qgj0EvIJbs6C/QA8RywJQCHmQD3hm/J5bxq08ZUOD18/7LTY4jPZy15jXuOyXLePiwN/AIGo1Hzs+
 /EunsKNH7qjZLuKiLXfHLaNDSRffbiuTcPgiPhqaIPu5HuzpYa7KxjGZgnXXx8S6CMIQ=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzwCC-0005bO-KM for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:38 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hWdlw25pwz5wlm;
 Fri, 28 Aug 2026 15:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787922028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eA/0FjXZziVVh1UlSjwtBwDjZ/Se2eCwuRS93nmojG0=;
 b=PTfvCBDBqf+Pt0dA7AiFyP4GhQnrdKdDKejlsMrgZELzsfC0hNim95V5oFEDAF5itJQSc4
 nM0GmfoEuqPgEYWP3EA5MSBff1/Az7tihQThtde4flQyK9BhKS0F33FoRp+gfVymI97EYv
 Xob41TsD/gf+ws2MPb93+AGbrxDHa8aldviNekoirPCMJKhO4PK8iyrh5ri9wS1hjy/IQO
 y78fZYctBMQYSbbCjTSjQIdLpVhkyONkZjoSsLMqa/+a6yCsixt35Pg0Uue+4Pypo5hcpK
 cmco4LDnhkORlKmDqIKFSS5fvPpIxLQWuYtx97EHa7ULhJoYfvVpkZr69ldfsQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 15:00:08 +0200
Message-ID: <21af0a98270dc43e5720734834bdd836b8384b52.1787919082.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787919082.git.ralf@mandelbit.com>
References: <cover.1787919082.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wzwCC-0005bO-KM
Subject: [Openvpn-devel] [PATCH ovpn net v2 3/5] ovpn: reject multipeer
 peers without VPN addresses
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

This changes such configurations from being accepted to being rejected,
but they have never been usable because the peer cannot be selected
through the VPN address hash tables.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/17ced9a7caee691e602e3c02f5e399aa9a35067c.1785338921.git.ralf@mandelbit.com/
- Explicitly stated that the policy introduced by this commit is not
  breaking userspace. (Sabrina)
- Used htonl(INADDR_ANY) instead of directly comparing s_addr. (Sabrina)

 drivers/net/ovpn/netlink.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index a444930234b6..a0ed09278a6b 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -346,8 +346,10 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 
 int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct in_addr vpn_addr4 = { .s_addr = htonl(INADDR_ANY) };
+	struct in6_addr vpn_addr6 = IN6ADDR_ANY_INIT;
 	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_socket *ovpn_sock;
 	struct socket *sock = NULL;
 	struct ovpn_peer *peer;
@@ -371,11 +373,20 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
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
+		if (vpn_addr4.s_addr == htonl(INADDR_ANY) &&
+		    ipv6_addr_any(&vpn_addr6)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "at least one VPN IP must be configured in MP mode");
+			return -EINVAL;
+		}
 	}
 
 	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
@@ -525,6 +536,9 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&ovpn->lock);
 
+	vpn_addr4 = peer->vpn_addrs.ipv4;
+	vpn_addr6 = peer->vpn_addrs.ipv6;
+
 	/* reject peer with conflicting VPN address */
 	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
 		vpn_addr4.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
@@ -537,6 +551,16 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 			goto addr_conflict;
 	}
 
+	/* in MP mode VPN IPs are required for selecting the right peer */
+	if (ovpn->mode == OVPN_MODE_MP &&
+	    vpn_addr4.s_addr == htonl(INADDR_ANY) &&
+	    ipv6_addr_any(&vpn_addr6)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "at least one VPN IP must be configured in MP mode");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	ret = ovpn_nl_peer_modify(peer, info, attrs);
 	if (ret < 0)
 		goto unlock;
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
