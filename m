Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCDCCD5BB1
	for <openvpn-devel@archiver.kernel.org>; Mon, 25 May 2026 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YY8qdS0xyfdYOH+ZYd9HzFqgCWz0e5RbBdw2BAZljw=; b=mNrB/15KL7UAXGPD8ASdkSsvFE
	qXlC8qWRFiP89WzS2/JKTMusEFLS4fL1PC1kAzzFIiPL+2ViJumavH5j3OF63eWOcPlKJEbHyjMIB
	JQ8taMOyZneZdpbGJS1hvORlfdF2b9HMPKYgxwk0EfFZRqlC25WeBoV1fg94d0Va11C4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRWPx-0006PE-Rt;
	Mon, 25 May 2026 14:36:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wRWPw-0006JH-B8
 for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tHRadf2QJQEdsGXYAW31WSywdtNO+52smVfJINAQskw=; b=iO4DJCgBgE2HHkKd4lWcgzyLJa
 x8YVVnrJsDdCgLMQKvDipeN15tLMy0+Z/AdtFlLRG3XEPpB0kISWfHYypWB63m2OkCYp0dvaOxMlm
 JKOyYgxY1NFP4EvOUtVeuCe15KSoHD5Qe1xT0GNe/dtOBqq6FeImuALslNwlk4VYm8Eg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tHRadf2QJQEdsGXYAW31WSywdtNO+52smVfJINAQskw=; b=bz7TkJYn9OmUkQvO5Wvda1t6hB
 e6LNH7vzQapKwYahQN1XF5LtVDb9mA5ZrujZPWX0IyRCBqPBVNOcFMSrsrZhq7AuCgR84bqDKcPLq
 RNw/yLdKmDc0tLTOPqC9HmW2zfvHvb6PbvffGxX/LnfDqagd8dUFI2/UXp+l/u2kGj1s=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRWPl-0003pN-OY for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:23 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gPJN92KxCz9sX2;
 Mon, 25 May 2026 16:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779719769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHRadf2QJQEdsGXYAW31WSywdtNO+52smVfJINAQskw=;
 b=lc5dvxMy+AL7fAj/3Tb3u0thOHJgjWI3X/vbmM7dAinpx7Vw/OaeklNKV2avX6SMTEAgWL
 4kopmWt7VYMQPw6KxaliNDJXOPQKZaS8l3MFew4cgGKDkq4r58hWk8E6XFrwdKoU9VOd1l
 eGBoCRl533amMgzBP+GPGfyq14a/yCX22cTZTURA22yodSU+fh/4LQo9v05o+Gi/N04/aC
 yWQ7g8pPNytqwt3oaDVvjqxTWQTKNeWrovc/64aODThcvH4bHLjsVULoDKDUNJy4t4s9aI
 +WBQOCFMqZPWPYJLPGjGv9WHL/owmGMhlRTDk4jSsW7m9ZugHlWbRDjhtQ8MZQ==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 25 May 2026 16:36:04 +0200
Message-ID: <20260525143606.1532168-2-a@unstable.cc>
In-Reply-To: <20260525143606.1532168-1-a@unstable.cc>
References: <20260525143606.1532168-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wRWPl-0003pN-OY
Subject: [Openvpn-devel] [PATCH 2/4] ovpn: cap number of peers per
 multi-peer interface
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

Memcg accounting bounds user-driven peer creation only when the
calling cgroup has memory.max set; on unconstrained hosts it isn't
a hard limit.

Track the live peer count in ovpn_peer_collection::n_peers under the
existing ovpn->lock and reject OVPN_CMD_PEER_NEW with -ENOSPC once
OVPN_MAX_PEERS (65535) is reached. 65535 matches what userspace
OpenVPN servers configure via --max-clients. P2P mode is unaffected.

The same cap also bounds the unaccounted RX-float bind allocations,
since binds are owned by peers.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/ovpnpriv.h | 3 +++
 drivers/net/ovpn/peer.c     | 9 +++++++++
 drivers/net/ovpn/peer.h     | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 5898f6adada7..113f5f493575 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -24,12 +24,15 @@
  *		  rehashed on the fly due to peer IP change)
  * @by_transp_addr: table of peers indexed by transport address (items can be
  *		    rehashed on the fly due to peer IP change)
+ * @n_peers: number of peers currently in the collection, protected by
+ *	     ovpn_priv->lock
  */
 struct ovpn_peer_collection {
 	DECLARE_HASHTABLE(by_id, 12);
 	struct hlist_nulls_head by_vpn_addr4[1 << 12];
 	struct hlist_nulls_head by_vpn_addr6[1 << 12];
 	struct hlist_nulls_head by_transp_addr[1 << 12];
+	u32 n_peers;
 };
 
 /**
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 511a7ce9b32b..1d564888479a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -286,6 +286,8 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* RX float path runs in softirq context: __GFP_ACCOUNT would charge
 	 * whatever cgroup is on-CPU when the packet arrives, not the userns
 	 * owner, so pass plain GFP_ATOMIC and skip accounting on this path.
+	 * The number of bind objects that can accumulate via float events is
+	 * bounded by the per-MP peer cap, since binds are owned by peers.
 	 */
 	if (unlikely(ovpn_peer_reset_sockaddr(peer,
 					      (struct sockaddr_storage *)&ss,
@@ -703,6 +705,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
 		hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
 		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		peer->ovpn->peers->n_peers--;
 		break;
 	case OVPN_MODE_P2P:
 		/* prevent double remove */
@@ -959,6 +962,11 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 		goto out;
 	}
 
+	if (ovpn->peers->n_peers >= OVPN_MAX_PEERS) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
 	bind = rcu_dereference_protected(peer->bind, true);
 	/* peers connected via TCP have bind == NULL */
 	if (bind) {
@@ -994,6 +1002,7 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 					      sizeof(peer->id)));
 
 	ovpn_peer_hash_vpn_ip(peer);
+	ovpn->peers->n_peers++;
 out:
 	spin_unlock_bh(&ovpn->lock);
 	return ret;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1bfc66821739..2efc782130f3 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -17,6 +17,14 @@
 #include "socket.h"
 #include "stats.h"
 
+/* Hard cap on number of peers per MP-mode interface. Caps the worst-case
+ * kernel memory an unprivileged userns owner driving OVPN_CMD_PEER_NEW can
+ * pin even when memcg accounting is unconstrained. 65535 matches what
+ * mainstream userspace OpenVPN servers configure via --max-clients, so
+ * legitimate deployments never hit this.
+ */
+#define OVPN_MAX_PEERS 65535
+
 /**
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
