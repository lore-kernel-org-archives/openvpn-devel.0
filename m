Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A306C54F55
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WV1gq7Pzen/8u1HLK2NQnE+/KJUg4zbN32LEfgyU/kg=; b=UWyvMnOrcNBT3VJGYXbJlx0f31
	mghjcXCiAljME36JlpEHhU7sdf8+TNVUsltkeRzyOdVHidDw2bSS8KhISwPa+VoCdoS/+1pONTpGJ
	grRxeZDZc2V+L27pZZzaUJPR19FX/ycXai6DRuzdBDcsMS5jMz30jcGVbA0/O+NU2iaU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woyb5-0000Bu-C6;
	Wed, 29 Jul 2026 07:20:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1woyb4-0000Bn-57
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ipEaZg7tfzbAlF4Sgl6jeb1UbMREFHEpCQfumpuH4O4=; b=hXgLovVdz5tsbGMxhK4+WqBl0e
 GvKkmghEr4m6P+5MNdJPqx9n1fyiU9kuV7S1tTkYkOeP9+V2dMhGaY1iaQnerw/MnuH5Or4BG7V7X
 lq97NdQcIxblbjj+wJhV1GHFULDxGbS8EPBxNG5WtPnxe54CXN0mUgA/wBHt5N46b3tM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ipEaZg7tfzbAlF4Sgl6jeb1UbMREFHEpCQfumpuH4O4=; b=QoIkjPMM69NnvFrlmAB2dyHuYi
 5X46jrvrdJG6y/cQy928WIkZKkdzfe88NmbgucppvRYEH3ZHgWyweA7DzDeborqJAAMQVCjYBgDKo
 RJ3XkByUKIAo1X6URoBHz+yaddHhXP7yd9cDU/taqBP9e1CSbMsALH19cjRtGABepvDM=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woyb5-0004eQ-0i for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:58 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4h93dq4d1zz9tLy;
 Wed, 29 Jul 2026 09:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785309647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipEaZg7tfzbAlF4Sgl6jeb1UbMREFHEpCQfumpuH4O4=;
 b=Ebf5OQ+wegkxNvLyjqXi4hEULx3ZoqkHeQTIdS5qzkIBDa1uckZd6GXf9Xe7j1DP1prOwP
 Wd3Qu/98Vf4ooVvwHtehWOOY6CjQRvijMUyWn+wSDpgYQzjWjZb2UA5Ojm5n0TidS0Rzbt
 tBaDBVWDZ8wiSCeIow1W01VeRRsynJl3tGGd9GuIE/AZpPClmi976g/QUlKM0JT5msS0ut
 aAVk0e31pxQfRMhBjKF3v18fta2IVHUGMBTQMHEHlf1uHq5qbKwwq5qWIFfgbrBWpKmK0J
 afk0kp+yi1eEcs258+xszbjAEjjHHzklf0P5d4icnGkriTSy/WVBbuUXDIItjw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 09:20:32 +0200
Message-ID: <87f7c1a6eea0005a067889e9b6f73fc6bd4f40e1.1785308184.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785308184.git.ralf@mandelbit.com>
References: <cover.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h93dq4d1zz9tLy
X-Headers-End: 1woyb5-0004eQ-0i
Subject: [Openvpn-devel] [PATCH ovpn net v2 1/5] ovpn: preserve IPv6 scope
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
No changes since v1 https://lore.kernel.org/openvpn-devel/87f7c1a6eea0005a067889e9b6f73fc6bd4f40e1.1785253480.git.ralf@mandelbit.com/

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
