Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2503ECD8C90
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kv2FEWIEs6QSUmIMnUE9uOv9KQZfWQYvw1QD4VyntcU=; b=Xf2yjws1y+wYZpUWL3gBvE6SI9
	9ylQxmwygNZD1q02FyJuPcNmONmAQwjQeiQpSn3rQ5ukrqHL1SdNqCTV8XA3KKAtIMJBk0JZx0DLq
	l3h0F8MFyk0zuu1Qnm9BPXfgSFgnR6H8AqMdkWeNIVMPyYj37qDDyaxyVxtcJYhyy1q4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXNbq-0006JJ-Ix;
	Wed, 10 Jun 2026 18:25:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wXNbn-0006IO-0I
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 18:25:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MGTfc82KkY0OD9iwinsUGMqMwdzZNHEREa0wiMfyfeE=; b=M9WrQ7Ya6YTcuD1jXSo2S4ypnt
 ts2ObOvUyNO8nZBzw1tWt9V6kIa7BBmhBYZWYYiUnCtlhxMtxwFfnlSAohgGfbU8gT0qISeJBJaNr
 S1ReLZSTUknGO2LYmaZkdKUrBWe0yT956gv2+3hnwoVwXVGJk4RdiFZIuylfBosvsoDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MGTfc82KkY0OD9iwinsUGMqMwdzZNHEREa0wiMfyfeE=; b=H
 lm/rVGpVstiNlbgwSKu0ZN0Pp814D24NfCNvL1/ELXTvjdlC5GqWu+hHheW4FHyNKMnopwmP8re26
 wnW+k75NKjG4IENLzpFm70gj94ccRD32q0RqauBuc7woTOiaG6oZDUbDiYq+awPezUaDZha2f7oNr
 dKP9D+m+Ib52xACk=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXNbl-0000xK-TU for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 18:24:59 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gbDhY3gq1zDsN5;
 Wed, 10 Jun 2026 20:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1781115885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MGTfc82KkY0OD9iwinsUGMqMwdzZNHEREa0wiMfyfeE=;
 b=gynis9dRafGQwJR692UlMLxPDwTbI1PBJJCCnTegHyV+i8AgLPwtv0TRNwszT+I6iYdnTE
 iY5JOo//sbhhTKBcrvjFZ63SS08fQ/Gigz1Xk+xeLJKmQRhSclLFZUW4kwSQ19eEoUC63+
 g8PU84zHbzApeI/Vh8FH0WbMgdEXu41bylZYnstW70EyXeF3E7TYSgGIW1Z1xhHFODa0JN
 EK033T+d1//IX/Kw2lXwAnDVj07X9bVpomT2hle5KxlE4wFsZhGdM9mOMynl7SmRjnF4ZP
 rlUTUzJDwJgf6pJyS1QN37StIr6YCknjYRiToPxVponG7+eF9l697QrFDKY+Mw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 10 Jun 2026 20:24:39 +0200
Message-ID: <20260610182439.63305-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gbDhY3gq1zDsN5
X-Headers-End: 1wXNbl-0000xK-TU
Subject: [Openvpn-devel] [PATCH ovpn net v2] ovpn: use monotonic clock for
 peer keepalive timers
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

Replace ktime_get_real_seconds() with ktime_get_seconds() so that
peer keepalive timeouts are calculated against a monotonic clock
instead of wall-clock time.

Because the driver currently uses CLOCK_REALTIME, an administrative
settimeofday() or an NTP step adjustment that moves the clock forward
can cause now to exceed last_recv + timeout instantly. This artificially
expires healthy peers and, depending on userspace configuration, can
trigger a premature tunnel restart (--keepalive / --ping-restart) or
client disconnection (--ping-exit). At the same time a backward step
can delay the detection of dead peers.

Switching to ktime_get_seconds() avoid both issues.

Fixes: 411f445fe91d ("ovpn: implement keepalive mechanism")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
Changes in v2:
Use ktime_get_seconds() instead of ktime_get_boottime_seconds()

 drivers/net/ovpn/io.c   | 4 ++--
 drivers/net/ovpn/peer.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a6b777a9c2d9..d0b8f7b95995 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -142,7 +142,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 
 	/* keep track of last received authenticated packet for keepalive */
-	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_recv, ktime_get_seconds());
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -294,7 +294,7 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* keep track of last sent packet for keepalive */
-	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_sent, ktime_get_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..caee56cd399a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -44,7 +44,7 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
  */
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
 {
-	time64_t now = ktime_get_real_seconds();
+	time64_t now = ktime_get_seconds();
 
 	netdev_dbg(peer->ovpn->dev,
 		   "scheduling keepalive for peer %u: interval=%u timeout=%u\n",
@@ -1357,7 +1357,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 {
 	struct ovpn_priv *ovpn = container_of(work, struct ovpn_priv,
 					      keepalive_work.work);
-	time64_t next_run = 0, now = ktime_get_real_seconds();
+	time64_t next_run = 0, now = ktime_get_seconds();
 	LLIST_HEAD(release_list);
 
 	spin_lock_bh(&ovpn->lock);
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
