Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB12EC43602
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JM0C4cbOx1NZNdRpih+i+8Vi/1qF61ziEHmu0ARQW1I=; b=B5sN+2CzMwAQM1gFn11k4hq13f
	/A+ud22w1lobOaqYfPWFUY8+CMdeu8JFHtNX1VqQ/d4Ts/ri2Xlww6hFakTIDgl1dZzSwBH37ba60
	hgxgGbKy3mlbndLU8B1tuYThq4yK/j6M63tqmYOBc70p7g0QAHZ73pMJLpKKMfJHuD9M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfhnb-0003rQ-FA;
	Fri, 03 Jul 2026 17:35:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfhnU-0003qb-Hd
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 17:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v41xdGIv7vutWRJ1QpWGGIOWO4aqmbLe4+0FDd/YstQ=; b=b3jz+1qdsdoNFI/Su8WA5v9WqA
 hqMeuLv5z+Q1dqWUHfL5NEnPNnNM0xARa3vFsfxS215DjPRho4I5GI2bBarp+DKadB3jM3SnHNVeU
 6r4JHFfZizb6FCvaOlcG4KPQoP9wDd6wUY4I3T94RkJF8/l+FGV3daobjmIM1CNJxVKQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v41xdGIv7vutWRJ1QpWGGIOWO4aqmbLe4+0FDd/YstQ=; b=U
 V9DDTWWcW/F9ZWi8ofq4GbX053St3KzXFpGdq91HAYXVywNcB9i5PaFyJVhVfFDLFc37dQWTpF9pN
 yfXF+THRp3XvTUiPcGEhfrMpWXJ7vPIKUowCdN+rLNIZKvVr0eZs2khMf2BuRdnCUC4iZO6cHG7qC
 E3Dh02nSU/zJ3eLY=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfhnS-00071m-Ek for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 17:35:29 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gsLVm4tjCzDx6P;
 Fri,  3 Jul 2026 19:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783100112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v41xdGIv7vutWRJ1QpWGGIOWO4aqmbLe4+0FDd/YstQ=;
 b=iRMYTRvTUVaEfKKnGQNuZ9rsACcV4KR74XiIivAOF5/5/0XqU91QZjAAipOp5O24wIFBTe
 IAyXeKVE7lignDYCY1iwVgAO+4hVo+VvxpAWh6OJ7iQFKExL99sh42UDa4HiIq7f3/wBHi
 oKZ4c/683DMvFnmluzSfLwHT/plRofkYHmstJRMHl4JSV4592F476JAvYi3IwQ0Ro6d3dY
 CkR8QTwJk4oDEJcxI8HMRkqjhmQhxtFbEFXDptUlpvOmuJ86wElVadjnfKMsqMV/Ja1CC9
 QJChZ7sZzRJMR3kdijUygQVaAlXb8vPyKPfmzYTy36AXZdC1d8WgB0KeP2/5MQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  3 Jul 2026 19:34:59 +0200
Message-ID: <981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gsLVm4tjCzDx6P
X-Headers-End: 1wfhnS-00071m-Ek
Subject: [Openvpn-devel] [PATCH ovpn net v4 1/3] ovpn: finish crypto
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
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
