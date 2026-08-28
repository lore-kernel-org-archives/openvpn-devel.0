Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8912EC61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAAcVpxSwxMD+4/hmKw2PJp7VFrEyA/6Q54mH2jqwjw=; b=SZwKEbvAZJBmvyQojujbH4j4vb
	ljKWiXG5BPE1tZJyhY22eL1uvYVj2+c0/yVyjLHMKM9pE8LL0aK10QBh3AJY5w5Hz2zFksACaJAa0
	aL2Y+EemYwkXnwGzCtjwcSdsTylgKTRUdxq/hlRJ0ZycKwdVk87tkjna5z3BTlt5dZxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzwCm-00017a-9t;
	Fri, 28 Aug 2026 13:01:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzwCN-00016r-AU
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PKHz1IxdpECY3W1lGOkcRp7xmXjrQnWLzGIFgQJBM5k=; b=PeNtzGIC5kHLSzhwkeqWzYiSdk
 bJ+eBC3J1En/thMamOS8Vn58RnMMpGgDhuMnA4Eoks7+oWjf3RbneJW0jz6Dogt9kOOVxjktF0H4n
 ZrVHU9713Vv1A4sHJcCTUg9eE0n4rOBbMjGuzLA+mlloQDWLg2vJQL+gyntkZucGJ5A8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PKHz1IxdpECY3W1lGOkcRp7xmXjrQnWLzGIFgQJBM5k=; b=Ryg92vpHsWN8fGhJZnx2sAIxvv
 bjdP6lmMCwn82R2rfmF/rXbrsJK5F2MbYkdQ941PP+iMgeVLBv2oNxJjjfG3TyUSGbWyEff/Vitc5
 NnkdHhEABGne5NGM5yF7UzSdJrM/Xb7V4WKcVd4Ymd4xLL8PVrjFnjsmn3fjnCQvmBSM=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzwCA-0005bC-79 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:38 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4hWdls3pwJzLlqM;
 Fri, 28 Aug 2026 15:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787922025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKHz1IxdpECY3W1lGOkcRp7xmXjrQnWLzGIFgQJBM5k=;
 b=uJIDZg2HlM/YPVF3+cCDPiI0Ig5r5+0T0TNyIchkHNVH3MmqOTNeElTFZIjxx7PFuBYjQI
 +mbh81ajsLdBmIpobAog8D46/5wU1VOmTsGuxplP9Qy/o1micTCN4ogTmXNjeO1ZFNdNS7
 AcZ2ulwq5YtKAw/zHpNLpdI372WW2573x/IBzsUV+vBsJqIvn8Rf1tb3vmw97x2Gy2zg/Q
 2ooiMFYxw+HP24pVeWtPWMFG7QSmBtqXFXKVopW4WQh9lX5XpbxylI/Xmb5s/sHNVjx40R
 7yxW8wIBCo0IqJXLpaJGa9d+r69p2SVb1dEJkk2QhFhdRaOflIG+bzHf8rCuUg==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 15:00:06 +0200
Message-ID: <8eca0229a26d5e6db8e095b2f1693b6fc03fcfb1.1787919082.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787919082.git.ralf@mandelbit.com>
References: <cover.1787919082.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wzwCA-0005bC-79
Subject: [Openvpn-devel] [PATCH ovpn net v2 1/5] ovpn: always unhash old VPN
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
No changes since v1 https://lore.kernel.org/openvpn-devel/e15d597b1c6d0e98727f482113b51f86a8510c50.1785338921.git.ralf@mandelbit.com/

 drivers/net/ovpn/peer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c95656ca7c35..68a2b05689ef 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -990,10 +990,11 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	if (hlist_unhashed(&peer->hash_entry_id))
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
@@ -1001,9 +1002,6 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
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
