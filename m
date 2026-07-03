Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9E8C43602
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+EpXGst+eiiBCBF0DGoNSpprx059MorTw3BbE1lLsY=; b=NlE5U507Yi5Qfrr1LuRQgLQipv
	Q63MLxK8MXgtSO6pkKzPVFxCbnuWnTIKCLipwVu8mTnhJG9F7eA1NEBPpK71Qt2aZ0+uY+fAGRw9w
	wykKxA516quAKWMSuD5m/efRPkrtPcwBj3wzdZWB9TDlNphJNqui86lnC+X2vBGUTNxk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfcor-0008Gj-89;
	Fri, 03 Jul 2026 12:16:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfcol-0008GZ-WF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 12:16:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MtmDcZMLv9OA7oZjiFSfXAbilkohKAeTvfIagh0wmK0=; b=EziAzrLvuEP+0otHYWQ/9e7RdO
 dXNVpjqSoqiGev/VSilcWlZ+oza9/murFWHXnRiW6pk7vpNjw4V0S94zE1RYL5gR1ssijTfoVf7Nn
 Uv3ongHaW6huXJlO5C+K6yW7APywP49Ge52ZdHFxlSh5bxuij9o63bIPwNZouF2KZlw0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MtmDcZMLv9OA7oZjiFSfXAbilkohKAeTvfIagh0wmK0=; b=PUTkZYrhmy3hsqw8XbTR1ZCKYr
 7VPGrsI8zRFQ+7YlmTzFYhSAmctdocis97YZGlfz7mEJM5BvQBmGVn/4V0TZerYHz6LZ8IAzqMZM9
 G479+Df+dfw7cwvfXgR3cwDvM7roS9uHZObOhvD1kcWBKcRzYHkfMKaOLCR5xOZ74V9o=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfcoj-0006yf-RJ for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 12:16:27 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gsCQj2VY6zDsGD;
 Fri,  3 Jul 2026 14:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783080973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtmDcZMLv9OA7oZjiFSfXAbilkohKAeTvfIagh0wmK0=;
 b=d1sDHAm9BXhEIK0WjeL0pDUmTLYdOD51A1XbLm89cUJrhq/uV+GTO2vWP5NEUNMbKulOrb
 RBuCJZCXDDWFR9Yl6xe0TUtUTAWltnd5794FblOm+1JHyoO2mFnmnoPLyUolRPV7IvS+fl
 kMMwgsyQ9YB8iUItqIz4RweufTFQvO1HuILOex1UhrjeArWwvucyydEgNmyCi/VDbCO9dD
 Mz29eA4XhJKvEjh47vtPk5qWsz7ibtZyUlsaqIMwRm/UbWG2aAK2ts2W1gK741ODDCfMzU
 8tbTRNFu/kQYSi5Bu6LT6WuV4EaKGEJ/8wn0rqiYbG1jOBsDyzAlOsuGQ/jQGw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  3 Jul 2026 14:15:56 +0200
Message-ID: <49f38f89340e18ed30543d3990a7a7e20595b6af.1783080055.git.ralf@mandelbit.com>
In-Reply-To: <f367b736f2597edb1677794173997d5a0f9f599c.1783080055.git.ralf@mandelbit.com>
References: <f367b736f2597edb1677794173997d5a0f9f599c.1783080055.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wfcoj-0006yf-RJ
Subject: [Openvpn-devel] [PATCH ovpn net v3 2/3] ovpn: defer peer netdev
 reference release to RCU
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

ovpn_peer_release can run from ovpn module execution context. For
example, ovpn_peer_keepalive_send passes its peer reference to
ovpn_xmit_special, which may drop the final peer reference before the
worker returns.

The peer reference owns a netdev reference. Releasing that netdev
reference synchronously in ovpn_peer_release can unblock netdev
unregistration and module removal while the caller is still executing
ovpn text.

Keep the netdev reference until the peer RCU release callback. That
callback already performs the final peer cleanup after active users have
left their RCU read-side sections, and dropping the netdev reference
there prevents module teardown from passing the netdev-ref boundary
while the final peer-put caller is still running.

Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New patch added in v3.

 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..d274e901cba1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -347,6 +347,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 	 * perform it in the RCU callback, when all contexts are done
 	 */
 	dst_cache_destroy(&peer->dst_cache);
+	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
 	kfree(peer);
 }
 
@@ -361,7 +362,6 @@ static void ovpn_peer_release(struct ovpn_peer *peer)
 	ovpn_bind_reset(peer, NULL);
 	spin_unlock_bh(&peer->lock);
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
-	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
 }
 
 /**
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
