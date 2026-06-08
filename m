Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3003CD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gok+oA+NMzAK3aM/pulY+MlLS1bUwh5L/3jZuY79vgg=; b=QFfzR3q1ph1GWDVShOqiuPIt21
	LVbdC9PpOqpB0cnHp+snsW6adGlkslx0xV+ph/u4QdrHKNY8/AAVslw5vFuLS4QV2jxDEvnku+3Rl
	PW2CPDBB7zTgrC3rqq3gFaIKt3FHT9sDYgVR2u8rk5NdvMHzU9tsHJlYbhbSWO4Fggck=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWabF-0005gm-Jj;
	Mon, 08 Jun 2026 14:05:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wWabB-0005gd-Qn
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ruG0BPTrSKimGHNNRIVKdyugdiqp2DX7N6BFYBjtp74=; b=KfpbXe/QQtAtrKnBrJgThReaf3
 D7nlhS9a5pATfbWl0DJnksmvHucPHit3vAim2q2Yt4MKB5Fa3zrAILTHBL7lG7BJtP42Bztj1xMt1
 3xh91Esm+GS+7jFRB0AKDMIkJ2xfOnLyprKmaaKF6oYADxyQo9y+LAF0pqAlZ6T2Qgk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ruG0BPTrSKimGHNNRIVKdyugdiqp2DX7N6BFYBjtp74=; b=d
 dYQ9m5TyMQely2P8309H8ThyPoEY/ObUQl2wvKuUMsO0mdTCeWfuk2RN2WV2C1LPZ4NGuNy0sMUoH
 lER38Vzqz2F0j4JWJztDDVHG4DSM7sQhDB8yOxNGvXkJ+BHow/TPIsJUoJwdqkfWop57o3OOlOrSF
 Nh0gLcNpP85uk4M4=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWab6-0008UL-Ao for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:05:03 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gYv1d1xy0zDrr2;
 Mon,  8 Jun 2026 16:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780927493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ruG0BPTrSKimGHNNRIVKdyugdiqp2DX7N6BFYBjtp74=;
 b=kH6s6V9Ff4KBjrzyiVA6ZvzSC5NQww6NdVdShcuOK1T1ddJyWsoBd0kLws5LqLkPF080BX
 Ag+9hVWbEkt/vt3o90JyTZkEH+7dVUa5XPLg7KhroCr6Mc6IA2z3J7rPwLJsqEmeZwhRum
 /E4/5Xlt0uC4oBA6Yl2DroUx7MtDwXrf8cdI8DYV8ODMHa9CdtRfwa23bTUv/k6uwGgFw7
 85q8gNhKZxllswhPXDKDhhHg8wUMNBLc0B8Xsa636cf+Vw9bVS89BEPzHM0TDKpr9D68ZS
 HZdXWrmd2ba2XfNlhJsRqv+zMxCesGHJk1JM9DRm/s2HUzup7hSv5ASuQC+9aw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 16:04:46 +0200
Message-ID: <20260608140446.546040-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gYv1d1xy0zDrr2
X-Headers-End: 1wWab6-0008UL-Ao
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: fix use after free in
 unlock_ovpn()
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

unlock_ovpn() iterates over the release_list using llist_for_each_entry()
and drops the peer reference inside the loop body via ovpn_peer_put().

If this drops the last reference, the peer is eventually freed. However,
llist_for_each_entry() reads peer->release_entry.next in the loop advance
expression, which runs after the body. By that time the peer may have
already been freed, resulting in a use after free when advancing to the
next list entry.

Fix this by using llist_for_each_entry_safe(), which caches the next
pointer before executing the loop body.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/peer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..ff7c6ce9fcad 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -26,11 +26,11 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
-	struct ovpn_peer *peer;
+	struct ovpn_peer *peer, *next;
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry(peer, release_list->first, release_entry) {
+	llist_for_each_entry_safe(peer, next, release_list->first, release_entry) {
 		ovpn_socket_release(peer);
 		ovpn_peer_put(peer);
 	}
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
