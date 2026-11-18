Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EE606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CPoF/E78;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FJHvK5hB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mY2sCwkv;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=pN7wDLqe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=8clUQSg44KDaFQaJVlTZ8iOYP7MVaOY9XT6kIlO+zyM=; b=CPoF/E78L94LJ4cRZc8C8rX5MJ
	VpJcEiLumDvPZTCAb02HfR1RF6WOUThw8BjDzoAbB5SMB392KknApjkAUQ72ceFkGpm0MxuITa6e5
	vt43qqO4h/WTOSgnlRmAx+MktJFxByi9zvOirXWTyJGH1W+NKVTAsA3uBrln59F1+UlA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjUs-000000008JU-2n4z;
	Wed, 18 Nov 2026 17:31:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTjUq-000000008JE-1HMP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:31:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZuRQj2rWA8S1uP/+eJUqX0cLvA0GHyR6Y2SXilkbGnU=; b=FJHvK5hBxpeXHSvcORcQOdoyk0
 RSJzpHGJocE2XeeXPYxDux/TvaiFvF4FUejhk3upNm1adfIeVM72OWVDGHawa5j7CHe1KI2xKYdrg
 12a8ZzmcbZwqCiQfvSmbw5kEwIboqY0xxyU1e45EicUOLsuX39CMBVk/AsMtScMgLs0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
 Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZuRQj2rWA8S1uP/+eJUqX0cLvA0GHyR6Y2SXilkbGnU=; b=mY2sCwkv7CEA6AVtFPysUpPHbd
 iKyUQJh+u54+qONlj4PC+dw9Uyc07Ht6GGi9EDKDxrks+NRgOgk2LbWUQttWQ4W5/khMS6YGOr+MP
 8UbkplW5cIrZCSlZaFOQUjiwmo2XzGmAUw05eEI7KYqzy1CPcSZx2g5Ni2V0mCFHHQzs=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTjUl-000000007PK-490Y for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:31:00 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jV7sy3fT1z5xCw
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 18:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795023046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZuRQj2rWA8S1uP/+eJUqX0cLvA0GHyR6Y2SXilkbGnU=;
 b=pN7wDLqeRBv7qWDvsIW8NsqxpdvwWQox8qXoik4rj22ce/K6ycKYClZ3GG+zR/Wc+bYYqs
 4AhsKwyC5PHxHOQZMM4rEJMrORoNJEL8Q5r56vBvXiWc1ddUHsu30zhWcTaHZSO3Lmf0uX
 5i3wjNbEd14yML4OsuURin0oqS+02uEDMVurhoHx4VQTGWMkJxbPFxPF9FYqHJGIed0NSr
 nY1p7HamZ0Yqa04KU7hfyxEN06khuT0Y4NKxYQTJDNkjxbduLCILJW5jXeYfTFEOUGPHh/
 63egaj488pwwedZ6zGCt6CipgPJOyXb4T8gNT/iONHF68a6s8P7E850w6Mceow==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 18:30:35 +0100
Message-ID: <dd65f48b91c7acc2ddf84f1dfdb55d84923a0ad2.1795022183.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jV7sy3fT1z5xCw
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTjUl-000000007PK-490Y
Subject: [Openvpn-devel] [PATCH ovpn net-next] ovpn: avoid endpoint lock
 when the bind matches
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ovpn_peer_endpoints_update runs for every authenticated UDP data packet
and takes peer->lock just to compare the packet addresses with the
peer's bind, although they almost always match.

Bind objects are immutable and replaced under RCU, so check for a match
under RCU first and take the lock only when the remote or local endpoint
has changed. The locked path rereads the current bind, so concurrent
updates are still handled there.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/peer.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2067825bb5b6..972ee4ba0aec 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -193,10 +193,29 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
 					 const struct ovpn_bind *bind);
 
+static bool ovpn_peer_endpoints_match(const struct ovpn_bind *bind,
+				      const struct sk_buff *skb)
+{
+	if (!bind || !ovpn_bind_skb_src_match(bind, skb))
+		return false;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return bind->local.ipv4.s_addr == ip_hdr(skb)->daddr;
+	case htons(ETH_P_IPV6):
+		return ipv6_addr_equal(&bind->local.ipv6,
+				       &ipv6_hdr(skb)->daddr);
+	default:
+		return true;
+	}
+}
+
 /**
  * ovpn_peer_endpoints_update - update remote or local endpoint for peer
  * @peer: peer to update the remote endpoint for
  * @skb: incoming packet to retrieve the source/destination address from
+ *
+ * Context: called with rcu_read_lock held.
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
@@ -207,6 +226,13 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_bind *bind;
 	bool floated = false;
 
+	/* bind objects are immutable and replaced under RCU and the locked
+	 * path rechecks the current object before changing an endpoint
+	 */
+	bind = rcu_dereference(peer->bind);
+	if (likely(ovpn_peer_endpoints_match(bind, skb)))
+		return;
+
 	spin_lock_bh(&peer->lock);
 	bind = rcu_dereference_protected(peer->bind,
 					 lockdep_is_held(&peer->lock));

base-commit: 7ccc5e05043b1bb84326b19a2b05938d8f7a2ae6
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
