Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6736C53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ljfiyeO3VDJQ4sgKYBTKTmTdsjkIKSSTTuadrFUADc=; b=Yu57yea8j49WBk+xeeJwusjR8Z
	WClswy0YM1zFpy7F3wtdfyoLYpsnHMp+whyYwkJj9WBEZMV2MyBwnkAK3KzZNdH/06k40/kB64WrF
	aYZgNd9OeeDPeLxUH8JttZV5gh5hLdG3j/7sx5D30+c/Xej9tMpPoT9G8mvsWh3CE1Yo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woyb4-0003zq-GX;
	Wed, 29 Jul 2026 07:20:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1woyb2-0003zi-Dw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oGXHWlz0X58ND2Q1t9QiDKv7FLuqLrjAxFhwirx7mLI=; b=SqGzpPntyvDktUQZGk5m+r2hD3
 l5I9tpeLV3xUI9dX4GRwgHmMXRwBp0U+ycGz6Moj56CScH4FWkGMvSqiCv0KhYOrsYRflu8qHmn8O
 6EewKOaVSGkSx+DvDOnIyaDQYR9LQKKX/nvRdKv68GhUG3+xeSnirgmN71n1dfZfnep8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oGXHWlz0X58ND2Q1t9QiDKv7FLuqLrjAxFhwirx7mLI=; b=Jd5RayPHRUJIqmVe9t9R8Q/Ge9
 NKoHDZnTBa4flv2OXsNdshuDMLXKJ+G755gNRoAaWzex0gAHGzqGBfq1uvRuW255mw1QtEQqmM4pV
 yzpwVBzVxzEg1cAHk2E/bjKXbAmtfZCkn8rqPC35cmtzNp4JOMbSE1UnFh7tbmoiqi0U=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woyb2-0005D8-CB for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 07:20:57 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4h93dr3h28zLlsF;
 Wed, 29 Jul 2026 09:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785309648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGXHWlz0X58ND2Q1t9QiDKv7FLuqLrjAxFhwirx7mLI=;
 b=Ycju+t9l8IPHzChtQsL5T3gYL7fzINRcTpJvfDj+jYs6XwknDa2tBPxdjGAkDAy9UHv+7Z
 A7PvgkWoOnDXqHkdwsQAbtTGVQPMBEAkVw9lbi5/jkk7TpxxleKa5vXsPeHZ8W5Fe4llTP
 eS7JfZZrZMwZk7f/m+6J1d3jdVVIjH9YRaOlF7d0O49kI1wy2RDfQyi4fZpD8zkCQ9zq94
 1HnoFc4wIl8vqCFPGmnOlGJo+qlEShz0dMU0bgBFVaO3aoyFdEgXQYpKHRGuz0LQzrh4Ye
 lfUrE3bvtn3sYrDKDXv2X6G68DrfezUzVZwnRAhtzrRaRrggJA8Jlz6embJIuw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 09:20:33 +0200
Message-ID: <cb51001bfdaeba899b6ca9b22186ea2ebb49c23c.1785308184.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785308184.git.ralf@mandelbit.com>
References: <cover.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h93dr3h28zLlsF
X-Headers-End: 1woyb2-0005D8-CB
Subject: [Openvpn-devel] [PATCH ovpn net v2 2/5] ovpn: skip UDP source
 validation for unspecified addresses
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

ovpn validates the cached local UDP source address before reusing or
refreshing a peer dst cache. This is only meaningful when a concrete
source address is selected.

For IPv6, calling ipv6_chk_addr with :: checks whether the unspecified
address itself is configured on the host. A peer may legitimately have
bind->local.ipv6 set to :: when no local endpoint was configured or
after a stale learned address was cleared. In that case the source
should be left unspecified and selected by ip6_dst_lookup_flow().

For IPv4, inet_confirm_addr(..., local = 0, ...) asks for local address
autoselection rather than validating a chosen source. Skip the precheck
there as well and let ip_route_output_flow select or reject the source.

Only validate non-zero/non-any source addresses.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v1 https://lore.kernel.org/openvpn-devel/cb51001bfdaeba899b6ca9b22186ea2ebb49c23c.1785253480.git.ralf@mandelbit.com/

 drivers/net/ovpn/udp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 493a5a0744af..eb342c7eef29 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -161,8 +161,8 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	if (rt)
 		goto transmit;
 
-	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
-					RT_SCOPE_HOST))) {
+	if (fl.saddr && unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0,
+						    fl.saddr, RT_SCOPE_HOST))) {
 		/* we may end up here when the cached address is not usable
 		 * anymore. In this case we reset address/cache and perform a
 		 * new look up
@@ -238,7 +238,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	if (dst)
 		goto transmit;
 
-	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
+	if (!ipv6_addr_any(&fl.saddr) &&
+	    unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
 		/* we may end up here when the cached address is not usable
 		 * anymore. In this case we reset address/cache and perform a
 		 * new look up
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
