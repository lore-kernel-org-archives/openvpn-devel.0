Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E64CD4F54
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eom1hpkLcM0gs5lFiBayYxKRkGp2CgGPnEaNeSw3JJ8=; b=CZjO4+cGJ9bWRtOBgI+5UTWeB/
	o0AL8uQu/Jziucn71RaKimzZTYeIT72kKEh1gjR3IRvb4qwuy6dD9mavno/sNafW91iIWxwCpvvxb
	dFbqDMdeJfR6crVVTcUfOtzq/KzGd/ueipB2szd56+/W1KT4KdvoJxUTx8BE2HAdUvbs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS8y5-0002MX-Um;
	Wed, 27 May 2026 07:46:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wS8xX-0002Lh-WC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 07:45:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rwkEQz0eEZMljTLN5PEkMJ+3f0eWk8161F09Tm5GDsU=; b=HphWi3CaQ7rP5apDbPSP2jS6nX
 Ui9znb1gF3vYNz/lzWhseUZcTXXsPM64+wZALTYbvgamp7glExY5J6EeFFQobclynLvvqtfh81nEN
 VNZ+0pE4gMSEHonnnLW/2Dl4s+Vy+i47Av13aR23B5VYNQJjai3KDlHR2o+iy401m+D8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rwkEQz0eEZMljTLN5PEkMJ+3f0eWk8161F09Tm5GDsU=; b=K
 wmOCEja+V+3Bd6eBaJLEqWqfn3YClP0TF2I1w5DO1pk7FWjRO1Tm8CmT2B5dbSdOc/lp+2OiP7pvh
 DWDr6j4D9HGfEL24LsACTUA+QaiBZGyNFkODEa7qDKd9oHNYhRay0zjr+YLRnAa4DMBHjCXZRZYN8
 YMZ5ZCXlxCcBisoM=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS8xS-0003MK-JV for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 07:45:45 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gQM9P3W1hz9y6b;
 Wed, 27 May 2026 09:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779867929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rwkEQz0eEZMljTLN5PEkMJ+3f0eWk8161F09Tm5GDsU=;
 b=YVilGYzLbDoYRILIrq3EwG2dCmE7tQOMVnq23zZOVlqqzjb2Tgbn/hvwjT13fNUdBapy7X
 /81MtmEUlXKZ3aKFwdftznwZ75rxZnbZdxElKW52xXgHoKtYjAPUUEkba+RSwPPVzZkz9Z
 +Nu284nwF1w2NMYILbPkV23ZAuUddsgk1wpw+kYWswuTGMPbm22BmfT235eA5/9zxtgEsW
 I1rDlcujY+7c68loup5C2E9Li6OELP4obmNFIkGgm0UXJaeY0uK9fmLQrrFnKSuL3L/T+2
 FEk+Q5oRms7qcQ5+2fPs3SnWNjSB7vwEWZEPgPtwU4bPb81oGzkOqi20Ww9r5w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 09:45:23 +0200
Message-ID: <20260527074523.2299644-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gQM9P3W1hz9y6b
X-Headers-End: 1wS8xS-0003MK-JV
Subject: [Openvpn-devel] [RFC ovpn net-next] ovpn: allow keepalive timeout
 and interval to be set individually
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

Currently the netlink API rejects PEER_SET/PEER_NEW messages that carry
only one of the two keepalive attributes (interval or timeout) and
requires both to be provided at the same time.

Relax this restriction so that userspace can configure either value
independently.

Refactor ovpn_peer_keepalive_set() to handle the two parameters
separately.

Update the periodic worker so that it correctly handles peers that have
only a timeout or only an interval configured, instead of skipping them
entirely.

Closes: https://github.com/OpenVPN/openvpn/issues/911

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 20 ++------
 drivers/net/ovpn/peer.c    | 98 +++++++++++++++++++++++++-------------
 drivers/net/ovpn/peer.h    |  4 +-
 3 files changed, 72 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..306c7b3200a7 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -254,15 +254,6 @@ static int ovpn_nl_peer_precheck(struct ovpn_priv *ovpn,
 		return -EINVAL;
 	}
 
-	if ((attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
-	     !attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) ||
-	    (!attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
-	     attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT])) {
-		NL_SET_ERR_MSG_FMT_MOD(info->extack,
-				       "keepalive interval and timeout are required together");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -281,7 +272,6 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 {
 	struct sockaddr_storage ss = {};
 	void *local_ip = NULL;
-	u32 interv, timeout;
 	bool rehash = false;
 	int ret;
 
@@ -323,13 +313,9 @@ static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
 			nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
 	}
 
-	/* when setting the keepalive, both parameters have to be configured */
-	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
-	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
-		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
-		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
-		ovpn_peer_keepalive_set(peer, interv, timeout);
-	}
+	ovpn_peer_keepalive_set(peer,
+				attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL],
+				attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
 
 	netdev_dbg(peer->ovpn->dev,
 		   "modify peer id=%u tx_id=%u endpoint=%pIScp VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..b06dbd8feb0b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -37,26 +37,60 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 }
 
 /**
- * ovpn_peer_keepalive_set - configure keepalive values for peer
+ * ovpn_peer_keepalive_interval_set - configure keepalive interval for peer
  * @peer: the peer to configure
  * @interval: outgoing keepalive interval
- * @timeout: incoming keepalive timeout
+ * @now: current time
  */
-void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
+static void ovpn_peer_keepalive_interval_set(struct ovpn_peer *peer, u32 interval, time64_t now)
 {
-	time64_t now = ktime_get_real_seconds();
-
 	netdev_dbg(peer->ovpn->dev,
-		   "scheduling keepalive for peer %u: interval=%u timeout=%u\n",
-		   peer->id, interval, timeout);
+		   "scheduling keepalive interval for peer %u: %u\n",
+		   peer->id, interval);
 
 	peer->keepalive_interval = interval;
 	WRITE_ONCE(peer->last_sent, now);
 	peer->keepalive_xmit_exp = now + interval;
+}
+
+/**
+ * ovpn_peer_keepalive_timeout_set - configure keepalive timeout for peer
+ * @peer: the peer to configure
+ * @timeout: incoming keepalive timeout
+ * @now: current time
+ */
+static void ovpn_peer_keepalive_timeout_set(struct ovpn_peer *peer, u32 timeout, time64_t now)
+{
+	netdev_dbg(peer->ovpn->dev,
+		   "scheduling keepalive timeout for peer %u: %u\n",
+		   peer->id, timeout);
 
 	peer->keepalive_timeout = timeout;
 	WRITE_ONCE(peer->last_recv, now);
 	peer->keepalive_recv_exp = now + timeout;
+}
+
+/**
+ * ovpn_peer_keepalive_set - configure keepalive values for peer
+ * @peer: the peer to configure
+ * @nla_interval: pointer to the KEEPALIVE_INTERVAL netlink attribute
+ * @nla_timeout: pointer to the KEEPALIVE_TIMEOUT netlink attribute
+ */
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer,
+			     const struct nlattr *nla_interval,
+			     const struct nlattr *nla_timeout)
+{
+	time64_t now;
+
+	if (!nla_interval && !nla_timeout)
+		return;
+
+	now = ktime_get_real_seconds();
+
+	if (nla_interval)
+		ovpn_peer_keepalive_interval_set(peer, nla_get_u32(nla_interval), now);
+	if (nla_timeout)
+		ovpn_peer_keepalive_timeout_set(peer, nla_get_u32(nla_timeout), now);
 
 	/* now that interval and timeout have been changed, kick
 	 * off the worker so that the next delay can be recomputed
@@ -1214,15 +1248,13 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 						time64_t now,
 						struct llist_head *release_list)
 {
-	time64_t last_recv, last_sent, next_run1, next_run2;
+	time64_t last_recv, last_sent, next_run1 = 0, next_run2;
 	unsigned long timeout, interval;
 	bool expired;
 
 	spin_lock_bh(&peer->lock);
-	/* we expect both timers to be configured at the same time,
-	 * therefore bail out if either is not set
-	 */
-	if (!peer->keepalive_timeout || !peer->keepalive_interval) {
+
+	if (!peer->keepalive_timeout && !peer->keepalive_interval) {
 		spin_unlock_bh(&peer->lock);
 		return 0;
 	}
@@ -1230,31 +1262,33 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 	/* check for peer timeout */
 	expired = false;
 	timeout = peer->keepalive_timeout;
-	last_recv = READ_ONCE(peer->last_recv);
-	if (now < last_recv + timeout) {
-		peer->keepalive_recv_exp = last_recv + timeout;
-		next_run1 = peer->keepalive_recv_exp;
-	} else if (peer->keepalive_recv_exp > now) {
-		next_run1 = peer->keepalive_recv_exp;
-	} else {
-		expired = true;
-	}
+	if (timeout) {
+		last_recv = READ_ONCE(peer->last_recv);
+		if (now < last_recv + timeout) {
+			peer->keepalive_recv_exp = last_recv + timeout;
+			next_run1 = peer->keepalive_recv_exp;
+		} else if (peer->keepalive_recv_exp > now) {
+			next_run1 = peer->keepalive_recv_exp;
+		} else {
+			expired = true;
+		}
 
-	if (expired) {
-		/* peer is dead -> kill it and move on */
-		spin_unlock_bh(&peer->lock);
-		netdev_dbg(peer->ovpn->dev, "peer %u expired\n",
-			   peer->id);
-		ovpn_peer_remove(peer, OVPN_DEL_PEER_REASON_EXPIRED,
-				 release_list);
-		return 0;
+		if (expired) {
+			/* peer is dead -> kill it and move on */
+			spin_unlock_bh(&peer->lock);
+			netdev_dbg(peer->ovpn->dev, "peer %u expired\n", peer->id);
+			ovpn_peer_remove(peer, OVPN_DEL_PEER_REASON_EXPIRED, release_list);
+			return 0;
+		}
 	}
 
 	/* check for peer keepalive */
-	expired = false;
 	interval = peer->keepalive_interval;
 	last_sent = READ_ONCE(peer->last_sent);
-	if (now < last_sent + interval) {
+	if (!interval) {
+		spin_unlock_bh(&peer->lock);
+		return next_run1;
+	} else if (now < last_sent + interval) {
 		peer->keepalive_xmit_exp = last_sent + interval;
 		next_run2 = peer->keepalive_xmit_exp;
 	} else if (peer->keepalive_xmit_exp > now) {
@@ -1274,7 +1308,7 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 			ovpn_peer_hold(peer);
 	}
 
-	if (next_run1 < next_run2)
+	if (next_run1 && next_run1 < next_run2)
 		return next_run1;
 
 	return next_run2;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..af184a3aca80 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -154,7 +154,9 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
-void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
+void ovpn_peer_keepalive_set(struct ovpn_peer *peer,
+			     const struct nlattr *nla_interval,
+			     const struct nlattr *nla_timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
