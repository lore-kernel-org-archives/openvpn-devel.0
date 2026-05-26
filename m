Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEA8CD5BC8
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4K0w0zTqzk/ty6aVyF+wEIIB5v/jF5YMKxr9pPrwI3M=; b=FFSA2k17NnLhaUuCc2sDMdQ3ok
	8f7fhYb7DdYX5fTK95JA68edCYlf19NeuTAqd1Owx982hRNUmYIyhkvkv9/Y3Jdd1Zu4EGflGx0zd
	qaEBc7WKbMgTJd6Kh1hK87aN7shVyqj2QTw+tblBZgKQ6hG3+tv9YDyGe9Qmd/36IF3M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRrAn-0001Om-Bp;
	Tue, 26 May 2026 12:46:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wRrAe-0001OY-Fp
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSctAYy/f+Ckd6Varr6NH262ju2Rwf5Ibuly/1iNqwY=; b=gw1lJeTJSX3FajYVsIAkRbMVzE
 /knQEKR6+lagZ8+ak59AXuwN6DVZ5bVgGVDKAaiMR81keoIp9b774zsyd1msqRnSjAt6Bv5VNaJk2
 rJuXnm/LnBYavwpGiFzd4sRcGSxZtbYgiHYkeoicgjUiVErkhIXZPP+gONIpUba3frTY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qSctAYy/f+Ckd6Varr6NH262ju2Rwf5Ibuly/1iNqwY=; b=f
 zxRHkMxRTrQcU7yeq1slvSIGFxLiC954WwaAI5wLXPOnrS+nuABM9CuCQ1TZ+4bDte79GcLkBirFF
 c7LMHg+pgFjw0PfE5iHZ5OLPbgYKj8UH9kpS+a8A5B8e6+2Rf4mCKjJ635xQDo84NKn6xRVBACl/F
 DZJJp3643g73E8Lc=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRrAc-0007ZA-Ac for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:08 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gPstV0hYJzDs03;
 Tue, 26 May 2026 14:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779799554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qSctAYy/f+Ckd6Varr6NH262ju2Rwf5Ibuly/1iNqwY=;
 b=V44YO5V4nT5c28u0flgMVzcH0GAhAoMOm4kr6fCDYks9iJ2+i+OXJ2Tv2nxG5pUA0pV829
 ICb5gPK8Jm8sQWa3cDxGpr/pmaMbFyEC25XoNH+zCxq90fVY/rbDLmCJpRwz5NhH/29g91
 wP+sllrrP0qMmHQn5NQ2ED7vEgMMetIpDX6oARnsWgHp1RoFEOgWDnOyduMjyI/44PWGTn
 qQKFJgoo8zPgE5tFQzwqswd7zRp0QqH8/g9Q2i0CgTSLesr297ioVb2PONdizpCvDp5A1X
 dZ1MSLNPH/EP4eaaazUEaHv+E4YFJa0W/MoUinAlrtqHLFD6CIn0sNMCRo4JGA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 26 May 2026 14:45:38 +0200
Message-ID: <20260526124544.425791-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gPstV0hYJzDs03
X-Headers-End: 1wRrAc-0007ZA-Ac
Subject: [Openvpn-devel] [PATCH ovpn net 1/4] ovpn: avoid sending UDP
 packets with source port 0
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

ovpn operates on a userspace-owned UDP socket, which may be manipulated
in various ways by userspace. If the socket is never bound, connected,
or used for communication, it may not have a source port assigned.
Similarly, if the socket was connect()'ed to AF_INET or AF_INET6, it can
be disconnected by connect() with AF_UNSPEC, which resets the source
port unless the socket was explicitly bound.

Since we must not transmit packets with source port 0, gate UDP TX on
the presence of a valid source port and drop packets otherwise. To avoid
ambiguity, sample the current source port once before route lookup and
header build and enforce the check on that value.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/udp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 493a5a0744af..2610f3e23bf0 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -149,13 +149,17 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	struct flowi4 fl = {
 		.saddr = bind->local.ipv4.s_addr,
 		.daddr = bind->remote.in4.sin_addr.s_addr,
-		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_sport = READ_ONCE(inet_sk(sk)->inet_sport),
 		.fl4_dport = bind->remote.in4.sin_port,
 		.flowi4_proto = sk->sk_protocol,
 		.flowi4_mark = sk->sk_mark,
 	};
 	int ret;
 
+	/* an uninitialized socket or connect(AF_UNSPEC) can cause this */
+	if (unlikely(!fl.fl4_sport))
+		return -EADDRNOTAVAIL;
+
 	local_bh_disable();
 	rt = dst_cache_get_ip4(cache, &fl.saddr);
 	if (rt)
@@ -226,13 +230,17 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	struct flowi6 fl = {
 		.saddr = bind->local.ipv6,
 		.daddr = bind->remote.in6.sin6_addr,
-		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_sport = READ_ONCE(inet_sk(sk)->inet_sport),
 		.fl6_dport = bind->remote.in6.sin6_port,
 		.flowi6_proto = sk->sk_protocol,
 		.flowi6_mark = sk->sk_mark,
 		.flowi6_oif = bind->remote.in6.sin6_scope_id,
 	};
 
+	/* an uninitialized socket or connect(AF_UNSPEC) can cause this */
+	if (unlikely(!fl.fl6_sport))
+		return -EADDRNOTAVAIL;
+
 	local_bh_disable();
 	dst = dst_cache_get_ip6(cache, &fl.saddr);
 	if (dst)
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
