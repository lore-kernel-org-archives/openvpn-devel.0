Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0021CD6E51
	for <openvpn-devel@archiver.kernel.org>; Fri, 29 May 2026 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oV7AGbrkVsgQQF21vBNbKraPSkNcmaN+tAog4eQr2mE=; b=fiQ+TeXSXRrR+qlu4cvIYog9Ko
	UJUZOYjhAH7rToYKwxqIZdjvt36Y35tePJwlc/fvGS+SaDFmppGFs7Jp8RrqNwVMhvnFDye29LYHw
	7j/9OIvEfxZvDSRmSb95PRB8XlLZmkkNV0x2F20unB7+CsbSZ7YRIZg9vmM4NW3AmoSM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSx3h-0002Xe-TN;
	Fri, 29 May 2026 13:15:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wSx3f-0002XV-C2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 29 May 2026 13:15:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tfxrEhu7Uhl4w4cpLt7FenRztHhVhApYxy7KxNna/1U=; b=VhniQK/uFaiE9y44VdUV1luJLJ
 GMHIo7iZJ0H4ZUPfiTk5YEtK+IIihPbTJjWrZcT3jOszETaj4v+xZngPGENt5qz5dwJodQ43cpiSi
 q0k0Lwe/hNStbWKCSbE18Vi0CrBXPSS+8Pm8Xuz2pWkgHkEI82x0QcJyBIB4LrdgRceg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tfxrEhu7Uhl4w4cpLt7FenRztHhVhApYxy7KxNna/1U=; b=Q
 /O/7/CtElQoW8qNc8CyQNn431z+n/VGSOY48fR2j3ICifewUGmfQO07NrccqBO8P95RKyMggd6UUe
 9OWpJH/xdhyUd1nJDe9tGgFJGAJxEQb1lRmnBnZITlvS9X7QeW2R9NzgMBiDw6611n/1pa6re3Qcx
 ZzCDQ4v1jfOB4bC4=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSx3Z-0007ID-Ap for openvpn-devel@lists.sourceforge.net;
 Fri, 29 May 2026 13:15:24 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gRkNr4cYxzDs15;
 Fri, 29 May 2026 15:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780060508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfxrEhu7Uhl4w4cpLt7FenRztHhVhApYxy7KxNna/1U=;
 b=M9Iqb6TwdFe0cFAp2ALl+5EKTFY+wNMoH36T+8CutIoMTDlcHT77EPhRwpvO1z0K7Ir3Y4
 ns0Xb1ccFSSboedSvtfYZ52pRzHs+OhEF3OoJknRCTscSIhJkJxVRac4aNNt/DZPTs29C0
 6XVBfb/f/uyDoEPcPN3r+xEz7ZgePKy4JoBoqC847bcPDLzwCy5oYDP6BBpHxXcmpRqMpG
 mGbmbHizlDlbVvEbmxogZnE2+nOCy4Ajwdc+OQn1Ktg142kV8dK+d0bOymt7Y92r98CS6r
 VC/6rxMtJ3FgYLLCrBagcKWn3sqBwc0R2N5E+ovolcRTqf4eutPlzLln+m1MWA==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 29 May 2026 15:15:01 +0200
Message-ID: <20260529131501.3923068-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wSx3Z-0007ID-Ap
Subject: [Openvpn-devel] [RFC ovpn net] ovpn: use monotonic clock for peer
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
