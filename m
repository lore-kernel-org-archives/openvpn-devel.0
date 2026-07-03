Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B14AC43602
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vl7WpkuzhiAlguUN4z42FflQm8zssfcXTYXPvG8LKJI=; b=fYlx4YaJ0ITMbKrJX5YBUE2BOw
	Ovg6vAanh/7E/Wxc4VOj8wU8K+fUW/MpEiesM4HcSWL3+FBBl8AQqBvuaQLKUDwi6+ZcGodo5teHV
	SvKAPAZus9mMX4iqZhwPU12h6+Dhkxez1+kTPcW6Aq99Xp0DB8JqVBhxHfqTsAmZMGDk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfZrb-0000ll-22;
	Fri, 03 Jul 2026 09:07:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfZrY-0000lc-26
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 09:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8wVVWjRto61+Opgk9ZT+IXb/xnVsQIN2zZU+I0gZtGU=; b=B2k6aoxzqeWpYXfCZw0jgEw5Ej
 vwv+mup+HGrX01RUOrRncAcV7jhRM1oYboKLvN+JaIicTnR+mboDj57xf+Q/4P8h81ouL2tNeKXaT
 aMEzzsFFPTyFbDGOKVZ4Epb1Q5mN6pFMzyxsVF3XA8oNWLchVXEx0IE9mnWlQv9nWp4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8wVVWjRto61+Opgk9ZT+IXb/xnVsQIN2zZU+I0gZtGU=; b=N
 osg/fv2Dz0eJD70E9t818y0gRhzAtvJ76O5SDFK0VRDo4Muu9OHzxynVA6C5gGcLyYyV/JC3WxcRJ
 kiZwdAqLNRokAPYFNqrWQRd3GVEo2Vbl/cXaQbUNu1Z4IfSHhia+Yn44GtA6QAfZ06hN9oTsOOQ43
 rwdNEnJmrZm/aFOc=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfZrW-0007dx-OL for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 09:07:08 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gs7DG689HzDsYs;
 Fri,  3 Jul 2026 11:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783069614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8wVVWjRto61+Opgk9ZT+IXb/xnVsQIN2zZU+I0gZtGU=;
 b=A1du04q5KP7386lIcVRFr0LAtoaQzw6rCzv5cO7vnZX/khCZzPUFZor6nUkLCJ4DBoraQV
 W0hlRihgrGTDBMIiL6WTP7/66jQVhcAmZyFyUo7md/sEQeK/G/tnNwMNW1lDH2otbJzBu4
 fMs9vx8mlR1kI4fcLmW5Yzv8G9in5KwEKBthEDyBN7536wjsPb3hYK0Xssyn03Wf9UxwqB
 KDu8svy2pD8n/mtB1Rm3ir85RHGRX85HPXklte28s+mcSuYBFBliTZsAHBiyS/77uEizU9
 spqeS75flJOBSj1D4p4mGZP0mfoY21LsaTUPhL7l3vDso6BEVaCHoh+qLuCnxg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  3 Jul 2026 11:06:39 +0200
Message-ID: <567de7a9371ce72b0632158799dd11bb543cae08.1783068961.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gs7DG689HzDsYs
X-Headers-End: 1wfZrW-0007dx-OL
Subject: [Openvpn-devel] [PATCH ovpn net v2 1/2] ovpn: release key slot
 before peer in crypto callbacks
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

Crypto completion callbacks release both key slot and peer references.
The peer reference pins the netdev. Once ovpn_peer_put drops the last
reference, netdev unregistration and module removal can complete on
another CPU while the callback is still running.

The subsequent ovpn_crypto_key_slot_put can then schedule an RCU
callback backed by module text after ovpn_cleanup rcu_barrier has
already run. The callback can later execute in freed module memory.

Release the key slot first, while the peer reference still blocks
teardown, and drop the peer reference as the last action.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New patch added in v2.

 drivers/net/ovpn/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a6b777a9c2d9..9671ee6bea9b 100644
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
@@ -302,10 +302,10 @@ void ovpn_encrypt_post(void *data, int ret)
 err:
 	if (unlikely(skb))
 		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-	if (likely(peer))
-		ovpn_peer_put(peer);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
+	if (likely(peer))
+		ovpn_peer_put(peer);
 	kfree_skb(skb);
 }
 
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
