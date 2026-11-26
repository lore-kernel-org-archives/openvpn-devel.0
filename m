Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9F606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UdF5E83i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bWmjijsx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=USNLwC85;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=gPj2zirj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U3gR5npFNvRHmVijsr7xCpIBkrlHKL8EuVynLIN5Ksg=; b=UdF5E83il02uv0
	hpnzj4nJXVktv935DWAPQhlYXrth3aQI5GexEXGSIf0J9w/y/f5jW4FYIfHRhCt/41yEkh+vge/xK
	UbM+CchVw2RwvO85I7q120Q96Wp1PB2n3dd8NqE7duh4BbZfxEaBy7huBvjiSIjp07q5q+ReI/K/s
	43U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWajA-000000002pr-28nV;
	Thu, 26 Nov 2026 14:45:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xWaj8-000000002pi-0d0x
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=el9Xe9Gn/y/JbaJ5pFwGrcCjlACs3B2V3KgD26ymDTo=; b=bWmjijsxVNN5y37zeW/2jvb4IH
 RSjlG7swjQRtxdT+24+l2Zo8X+CbQSWOYcx+5KipN+lpwlYqtYMReb5UQaeTK1CEnjHCD+CwFiOM4
 CtbmFxxba63vPKuyodydzwEB/n0YE+WYUNazCzA4rXpB0vl7+2/6aDixvrBBlydLx9Ok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=el9Xe9Gn/y/JbaJ5pFwGrcCjlACs3B2V3KgD26ymDTo=; b=USNLwC85KcKvdZdu8c49AEGd98
 KoCWnRBZwt3UL6o7uysGFVsVe+xwmGVabhtiiP/+ofSmUUfJyomGQZczvktSdYDXb6Y3qISYa3Jsp
 HsXQxHuS3tKDg/e7v0mF/T3sTCzxgpnBexQy0lLH6X+7cWa/gzotoWkROejhxSLyKwHI=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWaj6-000000005rz-0gAE for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 14:45:34 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jZzqR4d6Mz5wSY
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 15:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795704323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=el9Xe9Gn/y/JbaJ5pFwGrcCjlACs3B2V3KgD26ymDTo=;
 b=gPj2zirjihXKX8wy+1rhePUJm8o/MnP81Y5qXXr7JY6yicM2upd97PPvGtET0tyoTv0ft+
 D4LP9HCBSupYL0R+W+CYGY4VbF2/vrX9vfy9OBeiWzj+wuF39ZxFRDsTnshXFuyhZv9wbt
 lcDvsNoN+ujBge1NW1+3+yXkk4npzxv8cp/llM4X7f8B8KFL0uqhq6Euvo462xt7PaAU+g
 frueIybgkVGebpQ/kBDyulwLmBbnIELNfFzPTSNZjSyh21ryEmrGpkHPs+LIJrcfM5cywE
 28EAwutB5PyIPE2gD67kSUFLTqsgCsa64GrKnlotSpWqntp5bDnwrz82JBQ31w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 15:45:10 +0100
Message-ID: <79158eb33d6442ca84b03593596407cee8aaec0c.1795703343.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795703343.git.ralf@mandelbit.com>
References: <cover.1795703343.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jZzqR4d6Mz5wSY
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWaj6-000000005rz-0gAE
Subject: [Openvpn-devel] [PATCH ovpn net 2/3] ovpn: release netdev reference
 from the peer RCU callback
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

ovpn_peer_release queues ovpn_peer_release_rcu, which frees the peer, and
only then calls netdev_put, which still dereferences peer->ovpn and
peer->dev_tracker.

When the last reference is dropped from preemptible process context,
for instance in a netlink handler, the task may be preempted right after
call_rcu. If a grace period elapses before it runs again, netdev_put
operates on freed memory, and with CONFIG_NET_DEV_REFCNT_TRACKER
ref_tracker_free also writes through the stale tracker pointer.

Drop the netdev reference from the RCU callback instead, right before
freeing the peer, so that the peer is not accessed once it has been
queued for freeing. This also keeps the netdev, and therefore the
module, pinned until the callback has run, as ovpn_cleanup expects when
it waits for it with rcu_barrier. Simply calling netdev_put before
call_rcu would let unregistration and module exit complete before the
callback is even queued.

Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809212142.2249027-1-antonio%40openvpn.net?part=2
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/peer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 07f3fd9cbed6..7c3c33a6068b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -352,6 +352,10 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
 	 * perform it in the RCU callback, when all contexts are done
 	 */
 	dst_cache_destroy(&peer->dst_cache);
+	/* drop the netdev reference only now, so that unregistration cannot
+	 * complete before this callback has run
+	 */
+	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
 	kfree(peer);
 }
 
@@ -366,7 +370,6 @@ static void ovpn_peer_release(struct ovpn_peer *peer)
 	ovpn_bind_reset(peer, NULL);
 	spin_unlock_bh(&peer->lock);
 	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
-	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
 }
 
 /**
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
