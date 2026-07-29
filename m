Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4031EC54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QKPqnSHnJdtzHUpsCU99Vs8LNJO+RUkPOBQjeweWZaY=; b=anjyja7chFpbVLqMX8jEFdnXrj
	Fhnsn9CMyEw/J9CLjs+3VhC+zn4mtCq3R1lTT8Z30SJ9PVjCqcnuKChMBOE8DMplRXIqb1U0LCiSS
	3fpayMz+0ABPL+jyxYbld2E1WyoM6cKOMyRCTpgsS6mKGcglye9aNmULRtDcFBKE0fsU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp6QS-000261-CW;
	Wed, 29 Jul 2026 15:42:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp6QE-00025c-EW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yioZm92fLiFn6C4gYvyKN6K6/h5OYEmJfXJdl0DvpPs=; b=ZK6M+TeRTyMgOdFfpPyFO6J5qq
 soMvgSX776l5SAnrF7DSKxMPw53/w9UiZ7qy+VlMTOrQ5jEUj2cpLM9qicFfRcdFdhx6ztUsTUGPc
 w70NUCtropONZnF4S5zmHUUr+CajZLBSqCNmTmy0HM2VZGKblruTK+1YlKhO5x2RuC0M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yioZm92fLiFn6C4gYvyKN6K6/h5OYEmJfXJdl0DvpPs=; b=cg61Zs+ZywELElUofSzlBrNrml
 KDj7SOaha4Hco/5Dd7YuSs9YV76icJI9cmoKCxim5te1Fh/KvQahVSrYoJ01tJzkU11u5TdQpZent
 EvH0Jnr214tDefmhD77/vksDVuVWiimQvGZ+VussY6KNHjkOsQ/PYyzMgzUbziIXm8cc=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp6QH-0001TC-2y for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 15:42:19 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h9GmL1685zFr0N;
 Wed, 29 Jul 2026 17:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785339730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yioZm92fLiFn6C4gYvyKN6K6/h5OYEmJfXJdl0DvpPs=;
 b=IyrehkFGcD5+45kq5PdXdeA+VehyuTTuXY7OsASx4/oCtwGoZjWo3L3z6EenFUvuyfWUFS
 fF5t6MVI73nGsi7F5A6mPWC6ly01BSOVh2axIH3SxnoCSDr0bZ1Rj0AF6t14I+umsODGIq
 W6n1NFk40ZXk1XBkgkPeW0Si6ugR6ZBdpV0KyIsf/lEJ57jR8RnKS/Yz0f4Z55V7M6mGNR
 Fd2fQCgtNR2G/H9FnAzwnOIcuIiNIDtI2S1rNnmJ1ZwGx3KXnFJ/2a8SoKzns8hr7Im86/
 nvmLQaaquRQC/VtBZdhYAOCC+y3VUHW216sUF6Y/WDq1cR9eEAW5HmNA5ob0LQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 17:37:40 +0200
Message-ID: <872f401e31dae10388fe65b45463c5c55b96ac86.1785338921.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785338921.git.ralf@mandelbit.com>
References: <cover.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp6QH-0001TC-2y
Subject: [Openvpn-devel] [PATCH ovpn net 2/5] ovpn: reject duplicate peer
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

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/netlink.c | 37 ++++++++++++++++++++++-------
 drivers/net/ovpn/peer.c    | 48 +++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.h    |  4 ++++
 3 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..79775af26fda 100644
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
@@ -522,22 +524,41 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_unlock();
 
 	spin_lock_bh(&ovpn->lock);
-	ret = ovpn_nl_peer_modify(peer, info, attrs);
-	if (ret < 0) {
-		spin_unlock_bh(&ovpn->lock);
-		ovpn_peer_put(peer);
-		return ret;
+
+	vpn_addr4 = peer->vpn_addrs.ipv4;
+	vpn_addr6 = peer->vpn_addrs.ipv6;
+
+	if (attrs[OVPN_A_PEER_VPN_IPV4])
+		vpn_addr4.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+
+	if (attrs[OVPN_A_PEER_VPN_IPV6])
+		vpn_addr6 = nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+
+	/* reject peer with conflicting VPN address */
+	if ((attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_IPV6]) &&
+	    ovpn_peer_vpn_addr_conflict(ovpn, peer, &vpn_addr4, &vpn_addr6)) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "VPN IP is already assigned to another peer");
+		ret = -EADDRINUSE;
+		goto unlock;
 	}
 
+	ret = ovpn_nl_peer_modify(peer, info, attrs);
+	if (ret < 0)
+		goto unlock;
+
 	/* ret == 1 means that VPN IPv4/6 has been modified and rehashing
 	 * is required
 	 */
-	if (ret > 0)
+	if (ret > 0) {
 		ovpn_peer_hash_vpn_ip(peer);
+		ret = 0;
+	}
+unlock:
 	spin_unlock_bh(&ovpn->lock);
 	ovpn_peer_put(peer);
 
-	return 0;
+	return ret;
 }
 
 static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 6b1f176433d9..e68699e58a1b 100644
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
@@ -509,6 +509,45 @@ static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_priv *ovpn,
 	return NULL;
 }
 
+/**
+ * ovpn_peer_vpn_addr_conflict - check if VPN addresses are already in use
+ * @ovpn: the openvpn instance to search
+ * @peer: peer being added or updated, or NULL
+ * @addr4: VPN IPv4 address to check
+ * @addr6: VPN IPv6 address to check
+ *
+ * Check whether @addr4 or @addr6 is already assigned to another peer. @peer is
+ * ignored when found, allowing peer updates that keep an existing address.
+ * Unspecified addresses are ignored.
+ *
+ * Note: the caller must hold @ovpn->lock.
+ *
+ * Return: true on conflict, false otherwise.
+ */
+bool ovpn_peer_vpn_addr_conflict(struct ovpn_priv *ovpn,
+				 const struct ovpn_peer *peer,
+				 const struct in_addr *addr4,
+				 const struct in6_addr *addr6)
+{
+	struct ovpn_peer *tmp;
+
+	lockdep_assert_held(&ovpn->lock);
+
+	if (addr4->s_addr != htonl(INADDR_ANY)) {
+		tmp = ovpn_peer_get_by_vpn_addr4(ovpn, addr4->s_addr);
+		if (tmp && tmp != peer)
+			return true;
+	}
+
+	if (!ipv6_addr_any(addr6)) {
+		tmp = ovpn_peer_get_by_vpn_addr6(ovpn, addr6);
+		if (tmp && tmp != peer)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * ovpn_peer_transp_match - check if sockaddr and peer binding match
  * @peer: the peer to get the binding from
@@ -952,6 +991,13 @@ static int ovpn_peer_add_mp(struct ovpn_priv *ovpn, struct ovpn_peer *peer)
 		goto out;
 	}
 
+	/* reject peer with conflicting VPN address */
+	if (ovpn_peer_vpn_addr_conflict(ovpn, NULL, &peer->vpn_addrs.ipv4,
+					&peer->vpn_addrs.ipv6)) {
+		ret = -EADDRINUSE;
+		goto out;
+	}
+
 	bind = rcu_dereference_protected(peer->bind, true);
 	/* peers connected via TCP have bind == NULL */
 	if (bind) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 86c8cffada6d..6f7df9ae8fe4 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -149,6 +149,10 @@ struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id);
 struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb);
+bool ovpn_peer_vpn_addr_conflict(struct ovpn_priv *ovpn,
+				 const struct ovpn_peer *peer,
+				 const struct in_addr *addr4,
+				 const struct in6_addr *addr6);
 void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer);
 bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer);
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
