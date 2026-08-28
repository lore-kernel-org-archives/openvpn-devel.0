Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DFCC61DDA
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BpStNCLB/icquu9vAztURt9kx1UAANcphcF4V2xD0b4=; b=OaTJ5bGSAdypXqfPhKlkffB+iU
	6150ZleDt+2CxsdGjQmT6/fP+eA1XLXg7Ec/moq32zcRcuTE8Ls92ljPOBeb9T8xotXUhzkvDBxY7
	5g8SMN+qwGi3hjB0aVNeSTQWOYWBWNyY5wHLN6KKonUNpxu2rVnMsKC9sGMDAS6v+J5M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxuw-0003lB-Fn;
	Fri, 28 Aug 2026 14:50:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzxuu-0003l4-N4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qm2WApMEB3Msc9WYkr9RkT7HPiUkRIZqD8uAotX4ZkY=; b=Q52bIxvxLRn+GlPGmbV84zQtDx
 87oky0AJiH+Qs9WpN/xobQJBuGhA/ZKBxkXzaUJDQucDATW7Ec3TYq5PhvoF6RUeUHeZPbP7ID6OF
 Uk8koQF8IFrIYzrO0+L4yVe7Cy95YRztk065SnkxTUuNJVpAeBOZwBQD+ACmu9bH9pYk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qm2WApMEB3Msc9WYkr9RkT7HPiUkRIZqD8uAotX4ZkY=; b=DfSdMQEhIj7riUTG+nJdzoTQca
 KxqDBUd6EUd4SS5qgE3GH2TDVHqQX3tQasXHGWU/EivAF0FijPqBaAj/O0GU3/HmRchFUGeQGNgf+
 zREORtzq7HX52HzthkmNy/qBslBZORjozyK1uLPaUuGDT+7WH9eMboIo+IwIkITH/8qk=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxuq-0005qV-AU for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:52 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hWhC35fcxzNlf3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 16:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787928639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qm2WApMEB3Msc9WYkr9RkT7HPiUkRIZqD8uAotX4ZkY=;
 b=d/hrcb7f9wFxV8g0RxyefADHIRw4TfGzb+fsHAEy3w6CkdzI3TCLexeTdYj08cwsRQF7xh
 8Fgz5JULPRBUlrE9DjTRx1ikngn4BHRr9uvSTJdqr78hbgkYDuFK3JrhWVoCE/CjlmxpTu
 JSvRX0ESOCpGsdrs1c68sdWuMqDj505SrQeySLCOz1jUXfMJfMtCq38lBfhH5Jjid5dHEf
 z7l58ixzDQPfCee6XwfoYB3LzjSx3PRWaKB9yjoRS7UpfnKXiVrZ8amD7rCGXz3DK8i6Hp
 OnNqhyFDfQoxHLC17nWsiBAPFd2hJSd57vo4yB9gyE1V92WiM6knHUI/aWrclA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 16:50:22 +0200
Message-ID: <87624efbd20845abc23ebde353e82d5a90e0325c.1787925761.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787925761.git.ralf@mandelbit.com>
References: <cover.1787925761.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wzxuq-0005qV-AU
Subject: [Openvpn-devel] [PATCH ovpn net v3 1/6] ovpn: preserve IPv6 scope
 id for netlink peer endpoints
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
No changes since v2 https://lore.kernel.org/openvpn-devel/87f7c1a6eea0005a067889e9b6f73fc6bd4f40e1.1785308184.git.ralf@mandelbit.com/

No changes since v1 https://lore.kernel.org/openvpn-devel/87f7c1a6eea0005a067889e9b6f73fc6bd4f40e1.1785253480.git.ralf@mandelbit.com/

 drivers/net/ovpn/netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad85294198..2ba762082acc 100644
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
