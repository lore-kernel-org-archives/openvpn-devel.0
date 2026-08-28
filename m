Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4EBC61DDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dkr9P7bf0MFoeVTMvsZYuVFQHk4ioDZgiY46AACerqg=; b=RA2NCHVt9lX2CY27MNnlZtVgHl
	88dkMSme37k7SoNDlEQ7aImSRC+48dcpZP5rnKqP1eA3jIni1tdMqGPRSMI28nP5iTH3QiJyNyoj5
	fzJtSNZmes4z+3pgI53DAytUOPTWQ2c44BTvlID6Wv4W1VugPZHo4y01TB/0Eso5Tigs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxuw-00046P-QB;
	Fri, 28 Aug 2026 14:50:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzxuv-00046A-4Z
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c5sz0/xLsrD5HMxlj6w/xp0zpsYJ0lexaVHSBaKgrLM=; b=W26QTmE7eb55/GCdI1UWmU/VLe
 8UQqqVd8wy97Z/ygfKtXmEfLw7DfezAfq19tNlA0MWLZoMos3Sqfric5SLDsytjBGPgT0XEg+3DgN
 N8RtW92td91/LfvlojJjVN8O7HJunoorAombwphj4hEocMAu8WGeQLKQx8gOV4cbRxAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c5sz0/xLsrD5HMxlj6w/xp0zpsYJ0lexaVHSBaKgrLM=; b=be7vfujf1NCnGRrr2sGLnydWA7
 p3wffkMX27rR65yxMrclEqEgO6PIQsN37D07rh7RlsdcXMyhWL5KkAi0mIQeA247vA2TyLW8xZPZ8
 Fxe+/IjdWMNlxWnag1hoXHoz8SpN7dbHsE0DnHI2S55eP8O8fwnWfnetU3uNRIsUlHcA=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxut-0005qZ-Fz for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:50:53 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hWhC71R3GzFpwZ
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 16:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787928643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5sz0/xLsrD5HMxlj6w/xp0zpsYJ0lexaVHSBaKgrLM=;
 b=dG3ys2jPFttsgfvfJpXgWcOM5U02+sl+MvOXSMMoMRwdJIIBCC2agAJH4OR58Ap6/Vhgc+
 n7/jHIZc7GMlefTYE462jj+wm1dx7GvpqVw3ydBBycBbZlgWM5xYpELecil3wWMmah25p3
 KaBM5UAXlzpTPVCXjO4+BbkeqMVc5NjewHggicFbfdl09jGEFtoUK0fDJoyyADMZjqK5a0
 CvmfYoscDxpBPHwMCdDcp9nSoL0Ws2FKkevBNgmzsqqFl0c+maKv22ABFyBwocEp/oXBDy
 8CbYBR0MsCLQOLHuBnsQdcIuW7WhuM0+KKPzPO8n/Cmu3AgYjKF7LbcpsSx9dQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 16:50:26 +0200
Message-ID: <f1011c5f725f2caf81a39a2c7766bd5c0f95b660.1787925761.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787925761.git.ralf@mandelbit.com>
References: <cover.1787925761.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hWhC71R3GzFpwZ
X-Headers-End: 1wzxut-0005qZ-Fz
Subject: [Openvpn-devel] [PATCH ovpn net v3 5/6] ovpn: replace bind when
 learning local endpoint
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

struct ovpn_bind is published through peer->bind with RCU, but local
endpoint learning updates bind->local in place under peer->lock. UDP TX
reads the field without that lock. In particular, a concurrent IPv6
update can therefore result in a torn address read.

Use ovpn_peer_reset_sockaddr to publish a replacement bind when learning
a new local endpoint, just as a remote endpoint change does. Preserve
the current remote address and reset the dst cache only after the new
bind has been published successfully.

Track remote endpoint changes separately so that float notification and
transport-address rehashing remain limited to actual peer floats.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785308184.git.ralf@mandelbit.com/
- Split former 4/5 into this plus the previous and the next patch.
  (Sabrina)
- Tracked float with the specific floated boolean rather than indirectly
  through salen.
- Refactored the code into a cleaner shape. (Sabrina)

 drivers/net/ovpn/peer.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index b400783c2efa..430c6cd48db8 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -200,13 +200,12 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
+	const void *local_ip = NULL;
 	struct sockaddr_storage ss;
 	struct sockaddr_in6 *sa6;
-	bool reset_cache = false;
 	struct sockaddr_in *sa;
 	struct ovpn_bind *bind;
-	const void *local_ip;
-	size_t salen = 0;
+	bool floated = false;
 
 	spin_lock_bh(&peer->lock);
 	bind = rcu_dereference_protected(peer->bind,
@@ -233,8 +232,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 				.sin_addr.s_addr = ip_hdr(skb)->saddr,
 				.sin_port = udp_hdr(skb)->source,
 			};
-			salen = sizeof(*sa);
-			reset_cache = true;
+			floated = true;
 			break;
 		}
 
@@ -246,10 +244,12 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv4.s_addr,
 					    &ip_hdr(skb)->daddr);
-			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
-			reset_cache = true;
+			local_ip = &ip_hdr(skb)->daddr;
+			memcpy(&ss, &bind->remote, sizeof(struct sockaddr_in));
+			break;
 		}
-		break;
+		/* nothing changed */
+		goto unlock;
 	case htons(ETH_P_IPV6):
 		/* float check */
 		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
@@ -271,8 +271,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
 							    skb->skb_iif),
 			};
-			salen = sizeof(*sa6);
-			reset_cache = true;
+			floated = true;
 			break;
 		}
 
@@ -285,26 +284,30 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv6,
 					    &ipv6_hdr(skb)->daddr);
-			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
-			reset_cache = true;
+			local_ip = &ipv6_hdr(skb)->daddr;
+			memcpy(&ss, &bind->remote, sizeof(struct sockaddr_in6));
+			break;
 		}
-		break;
+		/* nothing changed */
+		goto unlock;
 	default:
 		goto unlock;
 	}
 
-	if (unlikely(reset_cache))
-		dst_cache_reset(&peer->dst_cache);
-
-	/* if the peer did not float, we can bail out now */
-	if (likely(!salen))
-		goto unlock;
-
 	if (unlikely(ovpn_peer_reset_sockaddr(peer,
 					      (struct sockaddr_storage *)&ss,
 					      local_ip) < 0))
 		goto unlock;
 
+	/* reset the cache only after a successful bind update to avoid useless
+	 * cache misses on concurrent TX
+	 */
+	dst_cache_reset(&peer->dst_cache);
+
+	/* if only the local address changed, bail out now */
+	if (!floated)
+		goto unlock;
+
 	net_dbg_ratelimited("%s: peer %d floated to %pIScp",
 			    netdev_name(peer->ovpn->dev), peer->id, &ss);
 
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
