Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5FCCD6E40
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yujdzMrHsAamWun/U8ibD9FTkgP2Y3vOb7oDVwnM5as=; b=FBzYbsI8CCFh1dYBKsgn3rRBBp
	mrdmPmkAdo1+QeBXSNJ/KC7tTCM62mq0Fy+kmttxicL+dzv3SM5GXccrhdfYckidzljyOS7loWbKd
	Rk4B00Ed1QSRwoaCCfpUzJdTTNaRU9SONZGh2d+ZW37yWGKzeNXJ8vFJhdJYhrt11HRI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS13X-0004YL-BQ;
	Tue, 26 May 2026 23:19:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wS13E-0004Xv-3o
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nJ3FVAex1jEUuDanGPnZt3vq0dfGyANc7vyZ4edRT+M=; b=Tr2JUApsTHh3fjCFc5F6iI0CjY
 UmVXRwFJZzg5bav1bdfwrQQWtAZJhP5p+lwPRNGAC6YciUWKymWLQfgBcl5V2Ia34Xkpsq/I+0SZ8
 zxf2jNbMN/zOSt6cRnmhpSPOGH8QJNFWxsEfUOiYFtJQoUC0+xp2Y2w5yqFIzfy0sLDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nJ3FVAex1jEUuDanGPnZt3vq0dfGyANc7vyZ4edRT+M=; b=A0SS5uWlag2W0/pP55Rcf5vrtb
 k2KSE+WHUmhNr4lUqBpXXQYyrtEvOewKfWGLMwC9H3SCDPBLt4MQqlWZJuuR888r1Fgo2LpLXlZR8
 NSJNmJUEFb6pDrCwaY+Mjth1kKvYUmdA8KSrFHNVNwbrByVyFUHMlXL5IlBaQ8R/Nr0U=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS13A-0000QW-SK for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gQ7wx4v9yz9tqk;
 Wed, 27 May 2026 01:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779837537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJ3FVAex1jEUuDanGPnZt3vq0dfGyANc7vyZ4edRT+M=;
 b=uuI8CbGLXpuM1N3VFAO/dAXhxah+OK12Es7/6p1gMya7HY0GiPiOvw7sYFTLIogGcZAGVv
 n7ES7OV5fL2YGKdGAd5YlSvq73g1maB5WQht4NuQQvNf3kD4XkMuGVsDj3tmCSKN/9s0XI
 UZxZKEEV7mpzaud9o8AKAkacB0knznc8oQwpQZDL+LDW0dGZd22MjOA3bnYtoWhsqYAeJS
 2KGBGU3rbjwSIcUPXmKfFqq9DvmKaomoo2Fd6D6bywikrBianKVCuZbrehr8yf2O1kmi7A
 r+mcynQeUeO4a2kpZhnluv/GCmPiBdsGxwtuSYuFMPFw9qqyHxtMqQQYh5pcAQ==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 01:18:44 +0200
Message-ID: <20260526231850.2511369-3-a@unstable.cc>
In-Reply-To: <20260526231850.2511369-1-a@unstable.cc>
References: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wS13A-0000QW-SK
Subject: [Openvpn-devel] [PATCH ovpn net 3/9] ovpn: fix data race reading
 cached local endpoint on TX path
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

The cached local source address bind->local is updated in place on a
live, RCU-published ovpn_bind while holding peer->lock: the UDP output
error paths reset it (ovpn_udp4_output()/ovpn_udp6_output()) and the RX
float path learns it (ovpn_peer_endpoints_update()). The UDP TX fast
path and the netlink dump, however, read bind->local holding only
rcu_read_lock(), never peer->lock.

For bind->local.ipv6 this is a torn read: struct in6_addr is 128 bit and
is copied as multiple words, so a concurrent in-place update can make a
reader observe a mix of the old and new address. The mangled source
address then feeds ip6_dst_lookup_flow() and udp_tunnel6_xmit_skb(). For
bind->local.ipv4 (a single aligned word) it is a data race without
tearing.

A spinlock on the per-packet TX path is not acceptable, and
READ_ONCE()/WRITE_ONCE() cannot atomically access the 128-bit IPv6
address (the >8-byte access is rejected at build time and per-word
accesses still can't yield a consistent snapshot).

Serialize the IPv6 field with a per-peer seqcount_spinlock_t tied to the
existing peer->lock: the in-place writers (already under peer->lock) bump
it, and readers take a lock-free read_seqcount_begin()/retry() snapshot
via the new ovpn_peer_local_ipv6() helper. The single-word IPv4 field is
handled with plain READ_ONCE()/WRITE_ONCE(). bind->remote is untouched:
it is immutable for a given bind object (only swapped via whole-bind RCU
replacement), so reading it locklessly remains safe.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 13 +++++++++++--
 drivers/net/ovpn/peer.c    | 26 +++++++++++++++++++++++++-
 drivers/net/ovpn/peer.h    |  6 ++++++
 drivers/net/ovpn/udp.c     | 17 +++++++++++++----
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad85294198..8e21fa3e7822 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -610,14 +610,23 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 	bind = rcu_dereference(peer->bind);
 	if (bind) {
 		if (bind->remote.in4.sin_family == AF_INET) {
+			/* bind->local is updated in place under peer->lock;
+			 * READ_ONCE() pairs with the WRITE_ONCE() updaters
+			 */
 			if (nla_put_in_addr(skb, OVPN_A_PEER_REMOTE_IPV4,
 					    bind->remote.in4.sin_addr.s_addr) ||
 			    nla_put_net16(skb, OVPN_A_PEER_REMOTE_PORT,
 					  bind->remote.in4.sin_port) ||
 			    nla_put_in_addr(skb, OVPN_A_PEER_LOCAL_IPV4,
-					    bind->local.ipv4.s_addr))
+					    READ_ONCE(bind->local.ipv4.s_addr)))
 				goto err_unlock;
 		} else if (bind->remote.in4.sin_family == AF_INET6) {
+			struct in6_addr local_ipv6;
+
+			/* read the 128-bit local address under the peer
+			 * seqcount to avoid a torn read
+			 */
+			ovpn_peer_local_ipv6(peer, bind, &local_ipv6);
 			if (nla_put_in6_addr(skb, OVPN_A_PEER_REMOTE_IPV6,
 					     &bind->remote.in6.sin6_addr) ||
 			    nla_put_u32(skb, OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
@@ -625,7 +634,7 @@ static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
 			    nla_put_net16(skb, OVPN_A_PEER_REMOTE_PORT,
 					  bind->remote.in6.sin6_port) ||
 			    nla_put_in6_addr(skb, OVPN_A_PEER_LOCAL_IPV6,
-					     &bind->local.ipv6))
+					     &local_ipv6))
 				goto err_unlock;
 		}
 	}
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 8aa07560bb30..bbb1946fa5b4 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -112,6 +112,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	RCU_INIT_POINTER(peer->bind, NULL);
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
+	seqcount_spinlock_init(&peer->bind_local_seq, &peer->lock);
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
@@ -175,6 +176,27 @@ int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
 	return 0;
 }
 
+/**
+ * ovpn_peer_local_ipv6 - read the cached local IPv6 endpoint of a peer
+ * @peer: the peer owning the binding
+ * @bind: the binding to read the local address from
+ * @dst: where the local IPv6 address is copied to
+ *
+ * bind->local is updated in place under peer->lock (TX error path and RX
+ * float path). Read the 128-bit address under the peer seqcount so that
+ * lockless readers never observe a torn value.
+ */
+void ovpn_peer_local_ipv6(const struct ovpn_peer *peer,
+			  const struct ovpn_bind *bind, struct in6_addr *dst)
+{
+	unsigned int seq;
+
+	do {
+		seq = read_seqcount_begin(&peer->bind_local_seq);
+		*dst = bind->local.ipv6;
+	} while (read_seqcount_retry(&peer->bind_local_seq, seq));
+}
+
 /* variable name __tbl2 needs to be different from __tbl1
  * in the macro below to avoid confusing clang
  */
@@ -237,7 +259,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv4.s_addr,
 					    &ip_hdr(skb)->daddr);
-			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+			WRITE_ONCE(bind->local.ipv4.s_addr, ip_hdr(skb)->daddr);
 			reset_cache = true;
 		}
 		break;
@@ -268,7 +290,9 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv6,
 					    &ipv6_hdr(skb)->daddr);
+			write_seqcount_begin(&peer->bind_local_seq);
 			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+			write_seqcount_end(&peer->bind_local_seq);
 			reset_cache = true;
 		}
 		break;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02..c0994c606554 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
+#include <linux/seqlock.h>
 #include <net/dst_cache.h>
 #include <net/strparser.h>
 
@@ -56,6 +57,8 @@
  * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind) and keepalive* fields
+ * @bind_local_seq: seqcount serializing in-place updates of bind->local
+ *		    (done under @lock) against lockless readers on the TX path
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
@@ -110,6 +113,7 @@ struct ovpn_peer {
 	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind  and keepalive* */
+	seqcount_spinlock_t bind_local_seq; /* protects bind->local */
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
@@ -151,6 +155,8 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer);
+void ovpn_peer_local_ipv6(const struct ovpn_peer *peer,
+			  const struct ovpn_bind *bind, struct in6_addr *dst);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
 
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 8811aa9eedeb..60d32dc5af4a 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -147,7 +147,10 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
-		.saddr = bind->local.ipv4.s_addr,
+		/* bind->local is updated in place under peer->lock; a single
+		 * aligned word is read/written atomically via {READ,WRITE}_ONCE
+		 */
+		.saddr = READ_ONCE(bind->local.ipv4.s_addr),
 		.daddr = bind->remote.in4.sin_addr.s_addr,
 		.fl4_sport = inet_sk(sk)->inet_sport,
 		.fl4_dport = bind->remote.in4.sin_port,
@@ -169,7 +172,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		 */
 		fl.saddr = 0;
 		spin_lock_bh(&peer->lock);
-		bind->local.ipv4.s_addr = 0;
+		WRITE_ONCE(bind->local.ipv4.s_addr, 0);
 		spin_unlock_bh(&peer->lock);
 		dst_cache_reset(cache);
 	}
@@ -178,7 +181,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	if (IS_ERR(rt) && PTR_ERR(rt) == -EINVAL) {
 		fl.saddr = 0;
 		spin_lock_bh(&peer->lock);
-		bind->local.ipv4.s_addr = 0;
+		WRITE_ONCE(bind->local.ipv4.s_addr, 0);
 		spin_unlock_bh(&peer->lock);
 		dst_cache_reset(cache);
 
@@ -224,7 +227,6 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	struct flowi6 fl = {
-		.saddr = bind->local.ipv6,
 		.daddr = bind->remote.in6.sin6_addr,
 		.fl6_sport = inet_sk(sk)->inet_sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
@@ -233,6 +235,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		.flowi6_oif = bind->remote.in6.sin6_scope_id,
 	};
 
+	/* bind->local is updated in place under peer->lock; read the 128-bit
+	 * address under the peer seqcount to avoid a torn read
+	 */
+	ovpn_peer_local_ipv6(peer, bind, &fl.saddr);
+
 	local_bh_disable();
 	dst = dst_cache_get_ip6(cache, &fl.saddr);
 	if (dst)
@@ -245,7 +252,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		 */
 		fl.saddr = in6addr_any;
 		spin_lock_bh(&peer->lock);
+		write_seqcount_begin(&peer->bind_local_seq);
 		bind->local.ipv6 = in6addr_any;
+		write_seqcount_end(&peer->bind_local_seq);
 		spin_unlock_bh(&peer->lock);
 		dst_cache_reset(cache);
 	}
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
