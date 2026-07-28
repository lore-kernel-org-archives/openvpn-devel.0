Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F294C54F54
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VzBUHeVkeT7BjJODdYr3iLIx+16OAfSSM60E7zIbo8s=; b=e9r+jDAEHN8cGmhA5XdGei9aRM
	rtIHtkLmK1Va2l5ePmtEhrw91iQikkyuAP700RM0SPanmJAseZ2FsuMkm2AUPRE9HkK8GgJVLWUZK
	7ORRiBrYuVA+x0w6pNb3Rf0N2kBgUG7gLCQN7St+WkJuRFQJGTHvwVa8zhEKjkjnStB0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wok4n-000316-Ju;
	Tue, 28 Jul 2026 15:50:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wok4k-00030w-Vl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ugkvjvevx4m9D1KSWtMsQVP4RsNSZmE4wESHbgcDJg0=; b=ktitMwWXQJl2gcOrXEOGw6f3V/
 tmtu60uglYFFeuLYM4oAfI7aGp9YL6ebVWMXeWbPYXB4BNhvGCkbE7cTf8IfNSADx/6sOCEkHzWxK
 8w4IjkI6/PkSBkL3Jiuo/WlguOqBQ8ZjOfyGRogZI7pZc4V1KrspsTBBn2MUNWhqIeZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ugkvjvevx4m9D1KSWtMsQVP4RsNSZmE4wESHbgcDJg0=; b=f7PZNXJCalgJVK2apw04GC8Ont
 aArULoA3WI7soq4peXb2hCBXasqKkrgHidmqwpnUbgmtQY9wMLwPlxORD6kWQ8njZtSGNDYUt+D8a
 3URrbLYMn3GTIw58Wq0hZHb6AEY/H609Ba1iskxgyxZBki9Gbat67Mo5XIRxvpPP6Uek=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wok4k-00027M-By for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:50:39 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4h8g0Q4G2BzNlfb;
 Tue, 28 Jul 2026 17:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785253830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ugkvjvevx4m9D1KSWtMsQVP4RsNSZmE4wESHbgcDJg0=;
 b=kDiJusjYd0Jm4ggFTmwRf3z6c6sc0BxkVrKinmKWYuhmk7iafzKm5BgnWzb4dPBc+rVZNc
 7GriZ8ftFXzKVhAVYaXQf8ZRusuB1AeLqu5KK/uubDaX8ZYUFhR+N267/q5yYitCnXODku
 NSS5/TymExPR3jTQt6JSoUuEauYOeBN1o25v1WtlKq4EBiJALDFhBr8ogUb3G8cPytoXbQ
 pwkfrZ+E6dyeDI6WgQpncohPeV6JrOyA6dgfmp/dx7zHJv22V32uNHwtRNTeM62ns+kZYc
 3YvISMTp8q/MytzxYcCVwK4op+QxWg/S4aoqLHV2p/VQ/kxh8f0o1KtK1LtDfw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 17:50:11 +0200
Message-ID: <87f7c1a6eea0005a067889e9b6f73fc6bd4f40e1.1785253480.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785253480.git.ralf@mandelbit.com>
References: <cover.1785253480.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h8g0Q4G2BzNlfb
X-Headers-End: 1wok4k-00027M-By
Subject: [Openvpn-devel] [PATCH ovpn net 1/5] ovpn: preserve IPv6 scope id
 for netlink peer endpoints
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

ovpn accepts OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID and reports
bind->remote.in6.sin6_scope_id in peer dumps, but the netlink endpoint
parser never copied the attribute into the sockaddr_in6 used to create or
update the peer bind.

As a result, an IPv6 link-local remote endpoint configured through
netlink loses its interface scope, unlike on the peer float path where
ipv6_iface_scope_id populates the field. The UDPv6 output path then
builds a flow with flowi6_oif set to zero and route lookup can fail or
select the wrong interface.

Copy the scope id when parsing non-v4-mapped IPv6 remote endpoints. The
existing precheck already rejects the scope-id attribute for IPv4 and
v4-mapped IPv6 remotes.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..883a28d69d8e 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -100,6 +100,8 @@ static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
 	struct sockaddr_in6 *sin6;
 	struct sockaddr_in *sin;
 	struct in6_addr *in6;
+	struct nlattr *scope;
+	u32 scope_id = 0;
 	__be16 port = 0;
 	__be32 *in;
 
@@ -114,6 +116,9 @@ static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
 	} else if (attrs[OVPN_A_PEER_REMOTE_IPV6]) {
 		ss->ss_family = AF_INET6;
 		in6 = nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]);
+		scope = attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID];
+		if (scope)
+			scope_id = nla_get_u32(scope);
 	} else {
 		return false;
 	}
@@ -126,6 +131,7 @@ static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
 		if (!ipv6_addr_v4mapped(in6)) {
 			sin6 = (struct sockaddr_in6 *)ss;
 			sin6->sin6_port = port;
+			sin6->sin6_scope_id = scope_id;
 			memcpy(&sin6->sin6_addr, in6, sizeof(*in6));
 			break;
 		}
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
