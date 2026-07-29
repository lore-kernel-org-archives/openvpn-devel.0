Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0DCC54FD2
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8cGRYLl9DNQAa1p+DdGbUHxB2O8lL7fkPJrSV01Cyzc=; b=k1Ni4IjLo3Ha4z+mfK2nUOkG5G
	EdIWUF7fO7sAoprwty0sHU2T+GS7J11wCpnkuSH6lhFq6okrXmaVKGzH1bYSBiQeMv5wBLlGYYfWH
	n+utaUF4zmCQ7fxSnTRrKeFtTfhEwivyWegGTk33nuqixXJSFOPQ8Q+aFG9ZAuLtxegg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6QU-0002WH-Tp;
	Wed, 29 Jul 2026 15:42:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp6QE-0002Vh-Nn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2vjgLsDKJbs5n1mVWaNjla9Xm1S5OTNt2up56irwDqk=; b=YhMRyRIjji5J4Z1nsPdKmpYgYR
 a2aEo7bz9TFotPm0IxNwlLeBClx0MQmPd/bG/URgSI/ub2Ihm8pvH/8TdNkgqhRwwrxi+PJyzRy2O
 tXNg3giXRbOoMKospp259bv90AQIaEH7M9Mm62J904ttFcRUnbucjKII8/ltQqWnZm5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2vjgLsDKJbs5n1mVWaNjla9Xm1S5OTNt2up56irwDqk=; b=NKVRWm9AcRUq/x6d6ZHlb93toV
 yemxanD++ZrfPnWHskXFigNL5PzZHFGdRBVRjOBHMW28ZxRZW0AjxZKUVNJyNdJkx5CEp3Ey7JjwQ
 JpM9Ju5TbIUZ52hIaa7dJ7YA0kX4e6EisuGMcjDd14iUQMfD9S0u9uw/ZBBrfxyZD7gw=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6QD-0002tz-9O for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:18 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4h9GmK3b83zNlmH;
 Wed, 29 Jul 2026 17:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vjgLsDKJbs5n1mVWaNjla9Xm1S5OTNt2up56irwDqk=;
 b=hHKkNcIjxRopzPbYfiYVcBqXYrAssZ/Sejv0hAt6qhZVlX2KKBJB4moyPTPPv07dIkVEPB
 BifP4R1/CI4P3s+/i6tUQSezQUmsODyVig0yyd99sZcWXLdfQxAW93fSo4dznbpd9vK+ef
 yUQXnnEY9i1uEq3JCGH6sRIRgqx1+clmqjDMo3ZSI+Vzr/a1IP005Advw/Kv9xjOheSUDV
 5dj0qBmCf6gFMRtNB+k5JV5o5ek6yeQj6gCoPEv+qlJ0XpU9UDBqhRIkSckoS1tF8cwNct
 KE1NUSlvuVvJl2XxSFmEy2VRICtXGcHpu2AbPfL37XWDcldcirk2TLmD6QH2zA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:37:39 +0200
Message-ID: <e15d597b1c6d0e98727f482113b51f86a8510c50.1785338921.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785338921.git.ralf@mandelbit.com>
References: <cover.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9GmK3b83zNlmH
X-Headers-End: 1wp6QD-0002tz-9O
Subject: [Openvpn-devel] [PATCH ovpn net 1/5] ovpn: always unhash old VPN
 addresses before rehashing
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

ovpn_peer_hash_vpn_ip updates the per-peer VPN address hash entries
after userspace changes a peer VPN address. The current code removes an
old hash entry only when the new address for that family is not the
unspecified address.

When an address is cleared to 0.0.0.0 or ::, its hash node therefore
remains linked in the bucket selected by the old address. The address
comparison performed during lookup prevents the old address from
matching, but the table retains a stale entry until the peer is removed
or another address is configured for that family.

Always remove both old VPN address hash entries before conditionally
adding the currently configured addresses back. This ensures that a
cleared address leaves its hash node unhashed.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/peer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a21d02ac715e..6b1f176433d9 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -906,10 +906,11 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	if (peer->ovpn->mode != OVPN_MODE_MP)
 		return;
 
-	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
-		/* remove potential old hashing */
-		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+	/* remove potential old hashing */
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
+	hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
 
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
 		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr4,
 					   &peer->vpn_addrs.ipv4,
 					   sizeof(peer->vpn_addrs.ipv4));
@@ -917,9 +918,6 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	}
 
 	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
-		/* remove potential old hashing */
-		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
-
 		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr6,
 					   &peer->vpn_addrs.ipv6,
 					   sizeof(peer->vpn_addrs.ipv6));
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
