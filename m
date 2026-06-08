Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A34ECD8C92
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oV7AGbrkVsgQQF21vBNbKraPSkNcmaN+tAog4eQr2mE=; b=kqxMZIs8XPp5OtuieusDc9mnUA
	KA6Todw/T1/LGMw0BL/x/m0cfGdiplfCjsZhJqyvnqf0FGxHzu4hxkZ2Mg87cplDbucRA+4IXbDVz
	1l9E+mbzzI9W9oqWmMKxtlMzwUgxI9lPUKY0DnjlZxzQJq9oHMHDrjSTVKP7uQQatFEA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWad0-0001xH-5D;
	Mon, 08 Jun 2026 14:06:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wWacz-0001x8-8S
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:06:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tfxrEhu7Uhl4w4cpLt7FenRztHhVhApYxy7KxNna/1U=; b=hjvSpqCPmdXyP/EhQT5D73QPoT
 qf8vSnVjlchCpAVdzn6ZnFti97zxaHsAKmI7CTbJas6PxEl1/yRYJW9hjqAejBlfAH4E1Hu38dT/l
 2jFH0NeF3QUWkI8udCQnBcxFf7z9c9gmLzkRVbFSg4Q//oQmYeuVzVQ6Z0Ig9j8Hv27k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tfxrEhu7Uhl4w4cpLt7FenRztHhVhApYxy7KxNna/1U=; b=D
 KldtXUa+lgMWGtAf9ZZOJD5PT6PKWLNMo//caGoT9Psrn3Fov3piC1lQkVOxjq6oFrTtvAvkGFGAA
 LZ6utPw8VLETOBVsInAfx/F6qpPvNj7RNq6ohDrfJCM7q1WTJWvm42opqarS84grL3hnxLly3q7Q1
 +zg1XQbJbwsu4GdU=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWacx-0000IN-Pd for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 14:06:57 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gYv3r2y8NzDs2S;
 Mon,  8 Jun 2026 16:06:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780927608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfxrEhu7Uhl4w4cpLt7FenRztHhVhApYxy7KxNna/1U=;
 b=DJXjcVadmPeSkWcOgyfrvlS5mRdOLFjMFTYDCcY7M6D42gaG/E6LgSxaAd6xUe9m+XMtOv
 OYm32D3qKMykpu66XhTpCaw0yDGOpYAQq133GwN9DrNMSFEMIWks22VPSHayIcewsyNyiw
 iDZ7L4muzzcRE8839spCQt3kmfjPQ53xVMvKfuvZjAckcHeTTKPsEbOvu6J4Lu9LPrMe3b
 hmkIoU5g9Dp9ezCJXehL8FnSrv0eSGSlun0EKjbj33swl5mpk6D+WSpq1ZHJFUmv//ZKYw
 AAZn6BLMHHm+0lx8tALPoFITEsSR4Tz8PdHkkfOd3Ge0nXe34LtINs1rq0dKiQ==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 16:06:42 +0200
Message-ID: <20260608140642.546546-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wWacx-0000IN-Pd
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: use monotonic clock for peer
 keepalive timeouts
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

Replace ktime_get_real_seconds() with the monotonic ktime_get_boottime_seconds()
to ensure the keepalive mechanism is robust against system clock modifications.

Right now, the driver uses ktime_get_real_seconds() to track peer timeouts,
relying on the system wall-clock.

An administrative time adjustment or an NTP sync that steps the clock forward
can cause `now' to instantly exceed `last_recv + timeout'.

When this occurs, the driver artificially expires healthy peers. Depending on
the OpenVPN user-space configuration, this triggers a premature tunnel restart
(if --keepalive or --ping-restart is used) or a complete disconnection of the
client (if --ping-exit is used).

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/io.c   | 4 ++--
 drivers/net/ovpn/peer.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 22c555dd962e..802d39ef38e5 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -142,7 +142,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 
 	/* keep track of last received authenticated packet for keepalive */
-	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_recv, ktime_get_boottime_seconds());
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -294,7 +294,7 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* keep track of last sent packet for keepalive */
-	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_sent, ktime_get_boottime_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..ef1da9e03b5a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -44,7 +44,7 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
  */
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
 {
-	time64_t now = ktime_get_real_seconds();
+	time64_t now = ktime_get_boottime_seconds();
 
 	netdev_dbg(peer->ovpn->dev,
 		   "scheduling keepalive for peer %u: interval=%u timeout=%u\n",
@@ -1342,7 +1342,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 {
 	struct ovpn_priv *ovpn = container_of(work, struct ovpn_priv,
 					      keepalive_work.work);
-	time64_t next_run = 0, now = ktime_get_real_seconds();
+	time64_t next_run = 0, now = ktime_get_boottime_seconds();
 	LLIST_HEAD(release_list);
 
 	spin_lock_bh(&ovpn->lock);
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
