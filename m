Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2083C54FDF
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0CIzUvtLzpBY0ADK34s1HiTczXhEdGD7rGTQIdW7fw=; b=Z7fqNAfytaDoNb9uWgwO8peOt2
	gmpoQz7ljnSSxAIVZFW9sem0zt8hfqd/WrW5EhDzmRn+JYTrU6y9UMZGOQOCV5A3GxpeuRQMudKKW
	1OLNEodycS759k6r4t9/EIBsxZ6tiCox+Z1sOnqCdxhkfTuHKVhPQQaL0aSAjdZSo5pQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp1Qc-0004At-Dw;
	Wed, 29 Jul 2026 10:22:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp1QQ-0004AW-SS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cTf/bhGf8rX5ITyQ0t3ft3oRbgdO+t9mKY6Liyetwdg=; b=GlLqb0JlT4gzFlU7q32e4UFQPI
 pp89zEStnYDPfDew4V0v5WowTtqz4ltEz6T3Gn18nvt83HUMRz1US+w/KVchmSvHgkvF+yFCMlJZ/
 smSKQRdIG9a0PGI2vItA3wFM+zl/Vrj/uwJHEAt+2VG22/28+7PMv5MSq/u0gySUTSk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cTf/bhGf8rX5ITyQ0t3ft3oRbgdO+t9mKY6Liyetwdg=; b=mKYPPhFgVw2F4HViQWCCUWnpq1
 GHvuTmgZooCNs/uCtjfhKNJYiIBIn0n7NFvuf1zNSYpjABsTZHlMvOp4RykE+oS8PS1aMX6oUPA26
 aVQc9tSp7v8CwgVKsMtNOiq7yAR34+2Qr5CYyaf0EH+57juCKMm0Q0UL0NxgP71pdEdc=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp1QQ-0002fD-7o for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:10 +0000
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4h97ft2xp1zNlG7;
 Wed, 29 Jul 2026 12:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785320518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTf/bhGf8rX5ITyQ0t3ft3oRbgdO+t9mKY6Liyetwdg=;
 b=0wAAJex0KgpIGbU3eVDkSAbWlcHZBhcPUs332d0hw3NYPTkuNlHhrT/cfBEMUYbcr8fSjk
 QV070kJLueYcYyfnorOjMIGTXoVLvRaOULE62S+fAbBfK1UKPyXe6HPXncj9Oj84Llisiv
 +JErXa05Qu7YsxIhBlGqiD6fEgZhQB7sXSr8xLOzCubuMhmUuw13rR8xUCb5rk07OeDxNX
 b0YDAU9Va5iDc39Sx8athhTFlPc3NsgE7GMTdFprmKPLWv984ADy072USTquEicuigqX3j
 gzhCxVoZNF8+139khBXHuZkXT7d/xqIANmNJsiXblsUFoDXWRT2F/kWdYkKIsg==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 12:21:44 +0200
Message-ID: <9f5ae15a10087fe7bb258594ebd745818401da4a.1785318038.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785318038.git.ralf@mandelbit.com>
References: <cover.1785318038.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp1QQ-0002fD-7o
Subject: [Openvpn-devel] [PATCH ovpn net v6 4/6] ovpn: finish crypto
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
No changes since v5 https://lore.kernel.org/openvpn-devel/7336c4c945f4d8f816b57da2525c8f7b037cfa46.1783336121.git.ralf@mandelbit.com/

No changes since v4 https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/

No changes since v3 https://lore.kernel.org/openvpn-devel/f367b736f2597edb1677794173997d5a0f9f599c.1783080055.git.ralf@mandelbit.com/

Changes since v2 https://lore.kernel.org/openvpn-devel/567de7a9371ce72b0632158799dd11bb543cae08.1783068961.git.ralf@mandelbit.com/
- Also free the remaining TX skb before dropping the peer reference, so
  crypto callbacks do not continue cleanup after peer release.

 drivers/net/ovpn/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9a66d693039a..9526f8096da6 100644
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
