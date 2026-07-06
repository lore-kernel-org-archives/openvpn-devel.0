Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7A8C44501
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFzOe1HUqGwvYdoGKqVjJMY2/ZoZFRiv+Xl8WWtvN8E=; b=TsT704VzxQ5e2KXh6ZgVqlTmzY
	twgzv5NGLeezBvUtuQ1RCTij2S9QT5jF08TXDsDMss5/PfG57c133jCQv6WNy0T82tVOsanXYVxAW
	6ZkVqmf4OndIiGoplXgmDkgkJdgh4vZX4ks11yzhzzigcCjpUpiU25vkrFDDKkz610TQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wghaw-0000QH-Ql;
	Mon, 06 Jul 2026 11:34:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wghau-0000Q2-Dt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=znaVAEp1GjJ5F9cr/8ySktkMRUAeu1VFMZA29PBiBEY=; b=Z4IrFuWKYRdApDwlihu61U+G4H
 0YZOcfX1pdNprLg7lr3AsVPoZgkjaTdSDJeiLhZ2+E89abXNrSEXCyLtriU3VrKVRc0oDKSdaKL5Y
 N/ZNsYKFxmp7sxmaBJmbLsngzFdRKojlEFeYbYQVyRcggPoJshWQIOAGO/osEdbopdmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=znaVAEp1GjJ5F9cr/8ySktkMRUAeu1VFMZA29PBiBEY=; b=Ca9lzq2304mMscNFPfXHT1PK9E
 E6ScXUS1OvgCdzkivHgRMQPXrl36a5doaauSnJ+TX3FgELG9mcHL5tg6EQN18Zcj5AztVY9xv8Q1M
 y7yCd20tPwIGQ7r56iGR9TW13JYVMoqkuzFHE9XitfrFTzbhg+zeWamxfw6pU47/mDKY=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wghao-0006l0-Ob for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:33 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4gv2M32jHTz9y7m;
 Mon,  6 Jul 2026 13:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783337663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znaVAEp1GjJ5F9cr/8ySktkMRUAeu1VFMZA29PBiBEY=;
 b=TGtVDTkKiHhW0vpqGQE9FyJuqqDLDUX1YPE/vEPzPHYPRB+tisnIqVjKY7sWiOt5+1qj7/
 DvJE2/Lo6Mt3V3CS/vV+7QYYhFTUDNCPjvHG+jfNnCvif9gHPK0HEuydBblfz+VaZK6QeT
 lnbDa46NKdPM+zdS3FMNT4bd3LqFoRoUkM7+FaY6wZ6+sOjVUWPCg0lAwjtmhcv9V2tpMi
 7/OLzORjsOtAJjZU63XIjrMdyHHjsg8Vi0d4BVp5G2HVpo0lzSvcWl9N6t2HimyYwqewQO
 1tIsg1ArWb8JqEVQV5eZtZsftfW3ihfBnEKh6BzDmjBeOUDw3Zo5+/SSSD4MFA==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  6 Jul 2026 13:34:02 +0200
Message-ID: <7336c4c945f4d8f816b57da2525c8f7b037cfa46.1783336121.git.ralf@mandelbit.com>
In-Reply-To: <cover.1783336121.git.ralf@mandelbit.com>
References: <cover.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wghao-0006l0-Ob
Subject: [Openvpn-devel] [PATCH ovpn net v5 4/6] ovpn: finish crypto
 callback cleanup before peer release
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

Crypto completion callbacks hold both key-slot and peer references. The
peer reference pins the netdev, and dropping the last peer reference can
let netdev unregistration and module removal make progress.

Do not release that peer reference before the callback has finished its
own cleanup. If ovpn_crypto_key_slot_put runs after ovpn_peer_put, it can
schedule an RCU callback backed by module text after ovpn_cleanup
rcu_barrier has already run. The TX error path also freed the remaining
skb after ovpn_peer_put, leaving callback cleanup outside the peer/netdev
lifetime window.

Release the key slot and free any remaining skb first, then drop the peer
reference as the last callback action.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
No changes since v4 https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/

No changes since v3 https://lore.kernel.org/openvpn-devel/f367b736f2597edb1677794173997d5a0f9f599c.1783080055.git.ralf@mandelbit.com/

Changes since v2 https://lore.kernel.org/openvpn-devel/567de7a9371ce72b0632158799dd11bb543cae08.1783068961.git.ralf@mandelbit.com/
- Also free the remaining TX skb before dropping the peer reference, so
  crypto callbacks do not continue cleanup after peer release.

 drivers/net/ovpn/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a6b777a9c2d9..e5f2775392d7 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -204,10 +204,10 @@ void ovpn_decrypt_post(void *data, int ret)
 		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 	kfree_skb(skb);
 drop_nocount:
-	if (likely(peer))
-		ovpn_peer_put(peer);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
+	if (likely(peer))
+		ovpn_peer_put(peer);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -302,11 +302,11 @@ void ovpn_encrypt_post(void *data, int ret)
 err:
 	if (unlikely(skb))
 		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	kfree_skb(skb);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	kfree_skb(skb);
+	if (likely(peer))
+		ovpn_peer_put(peer);
 }
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
-- 
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
