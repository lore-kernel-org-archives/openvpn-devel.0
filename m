Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A58BC61DDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yvMTJ++0LDskAUkMKnffCKtqHDawJMKC1+FPfB30cUk=; b=Vg0aEMednGFIUPhFaNOfiRVP97
	mBF8bRjEQ5TfQI1mn/XGqsG27XgQhPNr5bGTAh9ixDPuUh+bW9XZTyqGz9R/7mZM7fn615mIJQ4Q4
	qqhFv+3EzCe+qn6H43gio4jXMlQwFiSgG5rcLa99arnSq9SMyMFOfyafLl7jAiXDq9ro=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzwCj-0001bD-He;
	Fri, 28 Aug 2026 13:01:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzwCM-0001aG-JE
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KtdulZmEFhCpglK28MwKNKSoL519haptelaHqlRGy7M=; b=HGYU3rs8OhusgMINLQ2uTkZuxF
 3OPaICQ8Hz7sR2GOOKU8uPgkPCfXaYmu/gemRBCD80QRL6ACCXwyikwOglQ4HnUlU2YC9VYhrXaSD
 p5I1akLJg6Jgs5ulsJbVLAayXlZfRPBChvLYxPRV8yvRSzT1V+4NMPtuXzyguRhjF8F4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KtdulZmEFhCpglK28MwKNKSoL519haptelaHqlRGy7M=; b=mxjlTvj5dYU92mxo8NXffo5+DY
 GQF/xej3zd9RFR50Ypl+SQc5MH2Cm2b0gSUDVQ5vd4EP5PEXTTvfWMV4G/ogps91WQj3cC2170ze2
 SFdNzfiY+lE+RBSFjuxM4feXV97K/BJdvvfhycse+RKcjARuYjW5l1Xn+fAk3x4nQIGM=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzwCB-0005bL-Ge for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:00:37 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4hWdlv0YtyzHj;
 Fri, 28 Aug 2026 15:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787922027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KtdulZmEFhCpglK28MwKNKSoL519haptelaHqlRGy7M=;
 b=HSz0i8XLNuFCq+zt0BXSfyjLANxfcLsOZUmlco5F8EPUGx/cvXDNha+LNX3HalivW2mMym
 ec5JhDh45inv42rcd4WHPoFnq9YxUqJETq9cPoBFeI+gEm5ch4VF9+MdNeWmZhh8XJMvDE
 Na37oH9Oaydbpj+9idSjq0/+St/k6EkaybQVAuniM7Um/gf9rfPnzO/hlXkfW83DsG8+Jq
 fmXqDuUHft12i26Pc6mNK07yW619j3fatSUgG2/SeIqUNiGai8JNTcrhtsGLGir3soBM4X
 P1KeIqqOHNdklf5Hxa4KwojwYRUZZgB6llxjCgI3wiVmkE1zsrcKbMYw77W/PQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 15:00:07 +0200
Message-ID: <3da9a7b4d938b88f7c5cad9127bdffa5c79fcfbb.1787919082.git.ralf@mandelbit.com>
In-Reply-To: <cover.1787919082.git.ralf@mandelbit.com>
References: <cover.1787919082.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hWdlv0YtyzHj
X-Headers-End: 1wzwCB-0005bL-Ge
Subject: [Openvpn-devel] [PATCH ovpn net v2 2/5] ovpn: reject duplicate peer
 VPN addresses
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

In MP mode, ovpn uses the peer VPN addresses as lookup keys for
selecting the peer that should receive an outgoing tunnel packet.
However, the netlink peer configuration path does not currently reject
duplicate VPN addresses.

If two peers are configured with the same VPN address, both can be
inserted in the VPN address hash table and lookups return whichever peer
is found first. This makes peer selection ambiguous and dependent on
hash insertion order.

Reject peer creation or update when the resulting VPN address is already
assigned to another peer. Ignore unspecified addresses because those are
not inserted in the VPN address hash tables.

This changes such configurations from being accepted to being rejected,
but they have never worked reliably because peer selection is ambiguous.

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/872f401e31dae10388fe65b45463c5c55b96ac86.1785338921.git.ralf@mandelbit.com/
- Explicitly stated that the policy introduced by this commit is not
  breaking userspace. (Sabrina)
- Split ovpn_peer_vpn_addr_conflict into two helpers, one for v4 and one
  for v6. (Sabrina)

 drivers/net/ovpn/netlink.c | 37 ++++++++++++++++-----
 drivers/net/ovpn/peer.c    | 67 +++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.h    |  6 ++++
 3 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4dad85294198..a444930234b6 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -474,8 +474,10 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct in6_addr vpn_addr6;
+	struct in_addr vpn_addr4;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
 	u32 peer_id;
@@ -522,28 +524,47 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_unlock();
 
 	spin_lock_bh(&ovpn->lock);
-	ret = ovpn_nl_peer_modify(peer, info, attrs);
-	if (ret < 0) {
-		spin_unlock_bh(&ovpn->lock);
-		ovpn_peer_put(peer);
-		return ret;
+
+	/* reject peer with conflicting VPN address */
+	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
+		vpn_addr4.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+		if (ovpn_peer_vpn_addr_conflict4(ovpn, peer, &vpn_addr4))
+			goto addr_conflict;
 	}
+	if (attrs[OVPN_A_PEER_VPN_IPV6]) {
+		vpn_addr6 = nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+		if (ovpn_peer_vpn_addr_conflict6(ovpn, peer, &vpn_addr6))
+			goto addr_conflict;
+	}
+
+	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	if (ret < 0)
+		goto unlock;
 
 	/* ret == 1 means that VPN IPv4/6 has been modified and rehashing
 	 * is required
 	 */
-	if (ret > 0)
+	if (ret > 0) {
 		ovpn_peer_hash_vpn_ip(peer);
+		ret = 0;
+	}
 	/* if the remote endpoint was updated, the by_transp_addr hash bucket
 	 * also needs to be refreshed, otherwise incoming packets from the new
 	 * remote address would fail the lockless lookup
 	 */
 	if (attrs[OVPN_A_PEER_REMOTE_IPV4] || attrs[OVPN_A_PEER_REMOTE_IPV6])
 		ovpn_peer_hash_transp_addr(peer);
+
+unlock:
 	spin_unlock_bh(&ovpn->lock);
 	ovpn_peer_put(peer);
 
-	return 0;
+	return ret;
+addr_conflict:
+	NL_SET_ERR_MSG_FMT_MOD(info->extack,
+			       "VPN IP is already assigned to another peer");
+	ret = -EADDRINUSE;
+	goto unlock;
 }
 
 static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 68a2b05689ef..da456981bc67 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -484,7 +484,7 @@ static struct ovpn_peer *ovpn_peer_get_by_vpn_addr4(struct ovpn_priv *ovpn,
  * Return: the peer if found or NULL otherwise
  */
 static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_priv *ovpn,
-						    struct in6_addr *addr)
+						    const struct in6_addr *addr)
 {
 	struct hlist_nulls_head *nhead;
 	struct hlist_nulls_node *ntmp;
@@ -509,6 +509,64 @@ static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_priv *ovpn,
 	return NULL;
 }
 
+/**
+ * ovpn_peer_vpn_addr_conflict4 - check if the VPN v4 address is already in use
+ * @ovpn: the openvpn instance to search
+ * @peer: peer being added or updated, or NULL
+ * @addr: VPN IPv4 address to check
+ *
+ * Check whether @addr is already assigned to another peer. @peer is ignored
+ * when found, allowing peer updates that keep an existing address.
+ * Unspecified addresses are ignored.
+ *
+ * Note: the caller must hold @ovpn->lock.
+ *
+ * Return: true on conflict, false otherwise.
+ */
+bool ovpn_peer_vpn_addr_conflict4(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in_addr *addr)
+{
+	struct ovpn_peer *tmp = NULL;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	/* we don't hash INADDR_ANY, no conflict in that case */
+	if (addr->s_addr != htonl(INADDR_ANY))
+		tmp = ovpn_peer_get_by_vpn_addr4(ovpn, addr->s_addr);
+
+	return tmp && tmp != peer;
+}
+
+/**
+ * ovpn_peer_vpn_addr_conflict6 - check if the VPN v6 address is already in use
+ * @ovpn: the openvpn instance to search
+ * @peer: peer being added or updated, or NULL
+ * @addr: VPN IPv6 address to check
+ *
+ * Check whether @addr is already assigned to another peer. @peer is ignored
+ * when found, allowing peer updates that keep an existing address.
+ * Unspecified addresses are ignored.
+ *
+ * Note: the caller must hold @ovpn->lock.
+ *
+ * Return: true on conflict, false otherwise.
+ */
+bool ovpn_peer_vpn_addr_conflict6(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in6_addr *addr)
+{
+	struct ovpn_peer *tmp = NULL;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	/* we don't hash ::, no conflict in that case */
+	if (!ipv6_addr_any(addr))
+		tmp = ovpn_peer_get_by_vpn_addr6(ovpn, addr);
+
+	return tmp && tmp != peer;
+}
+
 /**
  * ovpn_peer_transp_match - check if sockaddr and peer binding match
  * @peer: the peer to get the binding from
@@ -1036,6 +1094,13 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 		goto out;
 	}
 
+	/* reject peer with conflicting VPN address */
+	if (ovpn_peer_vpn_addr_conflict4(ovpn, NULL, &peer->vpn_addrs.ipv4) ||
+	    ovpn_peer_vpn_addr_conflict6(ovpn, NULL, &peer->vpn_addrs.ipv6)) {
+		ret = -EADDRINUSE;
+		goto out;
+	}
+
 	bind = rcu_dereference_protected(peer->bind, true);
 	/* peers connected via TCP have bind == NULL */
 	if (bind) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02..a1cbd4013349 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -149,6 +149,12 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
+bool ovpn_peer_vpn_addr_conflict4(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in_addr *addr);
+bool ovpn_peer_vpn_addr_conflict6(struct ovpn_priv *ovpn,
+				  const struct ovpn_peer *peer,
+				  const struct in6_addr *addr);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 void ovpn_peer_hash_transp_addr(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
