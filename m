Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3055CD8C92
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mL4bJ+LSxd0VnrN4IeDEMjQG0xGPmibO1kB+/h5XxZQ=; b=Zu3LaDb9hcLA3/CcfqApI6QhIp
	Xmn4JDOBzuIAPQpu8cWNurb712s9uZFKu1JFCI9Why9+XyqmxfG1uzZRYTSfweUItyk4UajvbEj4u
	LJeOvycczSldiy8J+mqoQkvhRkYb32b+5BarWr/J1KXgeCVqAkIvYs7tbN3K1LQM99WQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa6G-0001Cf-Ty;
	Mon, 08 Jun 2026 13:33:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWa6E-0001CW-Bv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3SO51xGxkJt8zJ1G/O5z8R+QSQzRGqAq8QHjtl6WKcA=; b=Tef9WFJJzXmDbbIvj26bqi9uCW
 M2Z7adQpNy4P/lBnbzM/7xvE2e39b+nfxpBPRGUCu6cV0f7w+FsYVxQdZt5YbyeMG266FDLIQvTol
 CESObqjRbHLvCRXTJywA/nFrBO21SmFsvwfsHPIGZFF4GSLEtJCFnxtAy+RHwRwnVZ2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3SO51xGxkJt8zJ1G/O5z8R+QSQzRGqAq8QHjtl6WKcA=; b=Aggwh8ySeEnOSyoOcOi9kUAfH7
 cRu/nlIWVCR6MEn3kTNDNpXSYkkMSwOuZcmkfC3ZwtRktEVj/oPwi9FOvzqtD6gM8+m2RBtIaibzs
 JHTUG0UjjEPvK+CmlW5j3a2lm4UwapwABkiDHq2a2p9fpmoRQgQiyJ5SVM/UhX5RMZNw=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWa6D-0004wN-2V for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gYtJn5K5yz9vJ5;
 Mon,  8 Jun 2026 15:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780925577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SO51xGxkJt8zJ1G/O5z8R+QSQzRGqAq8QHjtl6WKcA=;
 b=rZkv6LnHmCoMihylRUSIequejeDam/iUb9WFnpdd9jFt5E2JoD5DLArBy9oD1f28jYa+Ev
 DV80DvFqBOvwFNgptBKThjZ46YYLT4cFu2GLLzpy4NeZKVTnp/J+blfPhDXSVW53Yu6e+J
 tLqvXMZJK8l8Ea9HRkuKSa0PcC6W5jyogofhHSR6KEedRi9PqaApzKBXZ6Nd07dXQgcOS5
 eU5HBh/bB2J6B27mOHKaBjofAr537xIv2RXs/NzfoINXeECPpDokMWsGlqiezrbftybxtg
 JL7D7x3YFjbrToWIh/lxjU22okFpEic+exPSbhJmgv7KwVTFFIpbSQc1BHK55A==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 15:32:47 +0200
Message-ID: <20260608133251.3128542-5-a@unstable.cc>
In-Reply-To: <20260608133251.3128542-1-a@unstable.cc>
References: <20260608133251.3128542-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wWa6D-0004wN-2V
Subject: [Openvpn-devel] [PATCH ovpn net v2 5/9] ovpn: tcp - fix peer
 reference leak on deferred deletion
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>

The TCP error paths in ovpn_tcp_rcv() and ovpn_tcp_send_sock() take a
peer reference and then schedule the deferred-delete work:

	ovpn_peer_hold(peer);
	schedule_work(&peer->tcp.defer_del_work);

ovpn_tcp_peer_del_work() drops exactly one reference per run, but
schedule_work() returns false and does not re-queue when the work is
already pending. The reference, however, was taken unconditionally, so
every hold+schedule that lands on an already-pending work leaks one peer
reference.

ovpn_tcp_rcv() is the strparser receive callback and has no guard against
this: a TCP segment packed with packets whose length header is valid for
the stream parser but whose payload is smaller than the opcode size
passes ovpn_tcp_parse() and hits the error path. strparser delivers all
complete messages in a loop, so many error invocations run before the
scheduled work executes, leaking one reference each. A remote peer can
exploit this to pin the peer (and the netdev reference it holds) forever,
preventing interface teardown - a denial of service.

Take the reference only when schedule_work() actually queues the work.
schedule_work() flips the work pending bit atomically, so exactly one
caller - even across the concurrent RX and TX paths - observes the
idle->pending transition and acquires the single reference that the lone
ovpn_peer_put() in the worker balances. ovpn_peer_del() is idempotent
(ovpn_peer_remove() bails on an already-unhashed peer), so a work item
re-queued while running stays refcount-balanced.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/tcp.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 433bd07a4f1b..6cf684699ada 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -148,10 +148,14 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	ovpn_recv(peer, skb);
 	return;
 err:
-	/* take reference for deferred peer deletion. should never fail */
-	if (WARN_ON(!ovpn_peer_hold(peer)))
-		goto err_nopeer;
-	schedule_work(&peer->tcp.defer_del_work);
+	/* schedule deferred peer deletion and take a reference only if the
+	 * work was actually queued: the matching ovpn_peer_put() in
+	 * ovpn_tcp_peer_del_work() runs once per queued work, so re-arming an
+	 * already-pending work must not take another reference (it would be
+	 * leaked, e.g. on a flood of invalid packets)
+	 */
+	if (schedule_work(&peer->tcp.defer_del_work))
+		ovpn_peer_hold(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -280,15 +284,20 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 					     peer->id, ret);
 
 			/* in case of TCP error we can't recover the VPN
-			 * stream therefore we abort the connection
+			 * stream therefore we abort the connection.
+			 *
+			 * Take a reference only if the work was actually
+			 * queued: ovpn_tcp_peer_del_work() drops exactly one
+			 * reference per run, so re-arming an already-pending
+			 * work (e.g. already scheduled from the RX path) must
+			 * not take another reference (it would be leaked).
 			 */
-			ovpn_peer_hold(peer);
-			schedule_work(&peer->tcp.defer_del_work);
+			if (schedule_work(&peer->tcp.defer_del_work))
+				ovpn_peer_hold(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
-			 * to true. This way we prevent more TX attempts
-			 * which would lead to more invocations of
-			 * schedule_work()
+			 * to true, so that no further TX is attempted on the
+			 * aborted stream
 			 */
 			return;
 		}
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
