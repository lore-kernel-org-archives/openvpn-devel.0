Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818E606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hoeSxCc4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W+OZguz5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TBADoS1x;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=NDgZMXNW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=br2RjapdmEXmxhQCw3VkiZ+zkBDmULz9fphJkXCReug=; b=hoeSxCc4iixcK8
	5PxK6QEZ1mVwLow7nnCDX0OCs/LXI114hzAN288aLW8mbEviMxdvh9ZcSeS3AU5Gi/+d+3aa4hrEH
	Pu9m90kb2ZShWfTLfqLXJuGaHrCjHgbmvr1vnfHNqZHOwAp/9omb43SAPmFulEk1+DYMnOMAaWSZX
	SnE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWajC-000000004tW-1d3C;
	Thu, 26 Nov 2026 14:45:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWajA-000000004tE-09Ez
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0GiUkp4sKBvffAbm8LzEKrsFioHGHb8CGIcLMPYDKc0=; b=W+OZguz56R1gyTIUF7XkNjv5i3
 YvCHjo0FK/fMl1Od6gntyYFlb1X+jrLy2rvxAzOvuyEoJb7WoNqg5CxIAZeGxZZdhiiboxOWThExh
 Ke5YlSQb8gDj69QVS9W6PLNIiFyQLTHzAvLY3Ob9cDnu0NMELufdI9nl8/iimZDa6OfI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0GiUkp4sKBvffAbm8LzEKrsFioHGHb8CGIcLMPYDKc0=; b=TBADoS1xLR0zHr1Z2FtORUge2o
 FALjbAJB0JLjAJPZe+nlfqgh18meOBu4/KyRDGeFj2wzATayaIrED9JUe72iQcmPb+dTWroERnPMH
 u/5A9YLOZEg9gglibTAVsyJUn5j1/tD13xmgmvAbOcV2c7CCYRDUiTT786vXIgc83hvE=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWaj8-000000001wm-1TAX for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:35 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jZzqR0FRmz9sKM
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 15:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795704323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GiUkp4sKBvffAbm8LzEKrsFioHGHb8CGIcLMPYDKc0=;
 b=NDgZMXNWeG8/lnysR0JzR1Dgn/T3pQPKCdm92GHI8i9bTIDKN4M+8Ss8snnxz2q+sKcBTI
 xbMq0QchH6IjKh36pa7Zr8knN6SldEfOJGoHYHJRO5JHoJy+xvPIJLXLUnE/fTdxv4nwL4
 ZYG4PhgHZ7hP0KE2w8uWDRFtMnoEoV+53+KapctXsooUZ/N/eWLJQymmDizDPI5I8kX3b1
 KXlSwE8XSICtr/0NR3tgI3qNbQf0DjC08W4i/g596noeYfteAtKvEdQx9G7ELh2MNOeRUw
 WI4R4kHUS+HbPZ32LKP8U0pCbh94A8DrffZfwQ1OsPX7uEnsk4p+Jy2vnfmAjw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 15:45:09 +0100
Message-ID: <d537b82354d90522b462dc0ba40e61d0684965bf.1795703343.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795703343.git.ralf@mandelbit.com>
References: <cover.1795703343.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZzqR0FRmz9sKM
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWaj8-000000001wm-1TAX
Subject: [Openvpn-devel] [PATCH ovpn net 1/3] ovpn: reset dst cache before
 publishing a new bind
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

When the peer endpoint changes, the new bind is published with RCU
before the dst cache is reset. TX does not take peer->lock before the
cache lookup, so a concurrent transmitter can pick up the new bind and
still get a hit on the entry cached for the old one.

The packet then goes out over the old route and cached source address
but towards the new remote. On a cross-family float, dst_cache_get_ip4
or dst_cache_get_ip6 would also return a dst of the wrong family, which
is then passed to the other family's xmit helper.

Reset the cache before publishing the new bind, both when the endpoint
is updated from RX and when it is changed via netlink. Both run under
peer->lock, which a TX must hold to store a new dst, and the store
requires the bind to still be the current one. Therefore, once the new
bind is visible no stale entry can be repopulated. A failed bind update
at worst costs one extra cache miss.

Fixes: aea934a221ec ("ovpn: replace bind when learning local endpoint")
Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921102215.3599702-1-antonio%40openvpn.net?part=5
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c |  7 ++++++-
 drivers/net/ovpn/peer.c    | 10 +++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 5432bc2eb8e8..6231d87304e1 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -333,6 +333,12 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 		 */
 		local_ip = ovpn_nl_attr_local_ip(attrs);
 
+		/* reset the cache before publishing the new bind, so that
+		 * concurrent TX cannot pair it with a route cached for the
+		 * old one
+		 */
+		dst_cache_reset(&peer->dst_cache);
+
 		/* set peer sockaddr */
 		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
 		if (ret < 0) {
@@ -341,7 +347,6 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 					       ret);
 			goto err_unlock;
 		}
-		dst_cache_reset(&peer->dst_cache);
 	}
 
 	/* In a multipeer-to-multipeer setup we may have asymmetric peer IDs,
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2067825bb5b6..07f3fd9cbed6 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -294,16 +294,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 		goto unlock;
 	}
 
+	/* reset the cache before publishing the new bind, so that concurrent TX
+	 * cannot pair it with a route cached for the old one
+	 */
+	dst_cache_reset(&peer->dst_cache);
+
 	if (unlikely(ovpn_peer_reset_sockaddr(peer,
 					      (struct sockaddr_storage *)&ss,
 					      local_ip) < 0))
 		goto unlock;
 
-	/* reset the cache only after a successful bind update to avoid useless
-	 * cache misses on concurrent TX
-	 */
-	dst_cache_reset(&peer->dst_cache);
-
 	/* if only the local address changed, bail out now */
 	if (!floated)
 		goto unlock;
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
