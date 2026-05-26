Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12DFCD6E47
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UTkIbI1E04lskLsBXunMbL3Xv0LPBTy6lJP7j1DZymg=; b=YLL+n1xuN7ZyJJ+qepA7+Ph00Z
	JArGJ8IWcXnhjZhotq6yWM41ap8297lUKyg6rIU17xlsQRMSwiCa5dIFvO6k0fRILJr0PEnu9Hu16
	OL5+e9kXIZz+JmaD12qEydS2FThgC4PkzBF6KoZ6dk+Nkno0ii5cjqDmFQfmZEI6yw3g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS13g-0003Zk-L9;
	Tue, 26 May 2026 23:19:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wS13a-0003Yx-3V
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RZO0MsyPEb4YuJFfZGfEawSIvMhZNfVfpHKfPA+WUMg=; b=g6tC+7amSw3H/Tx56GBtnEagJZ
 eEeDhSzX/dMLJU79NUbl9y824677TutdjYwaG1wdfcyzZP2YbXRa5wOCZ//MMLzNdwkjXmTrV4e/t
 wEQd4T2WhL760x9lWzs6FMW8f0YzegPhv1WU3/07rzglCf9Ycu1E4R5CTFQX/qkUQjgI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RZO0MsyPEb4YuJFfZGfEawSIvMhZNfVfpHKfPA+WUMg=; b=DsTcroppUj2A6d3JdizYfiaSMi
 4+twEUrLoHBgICMn+nVhKfaocSM9kAcfXYkmRqbpbfZBx0iXvn5SPmlUQEuy+gM90yeXVfQ7oaIdP
 z4s52Y5R2CHO88uyILJ/1+r1arId2wu3LxqWJsXk9t43R4wYYGxSbGBJayyV6P3KEUhU=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS13I-0000Tz-8i for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:13 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gQ7wz6Ld3z9tW1;
 Wed, 27 May 2026 01:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779837539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZO0MsyPEb4YuJFfZGfEawSIvMhZNfVfpHKfPA+WUMg=;
 b=XtaRS8vKN/4CRSQKi09/Goy6/Ps1XES5e1Ak1OC7D6EGWX47BEO1fBmhiKfUaYD5nH5o56
 mrMjw1Ltr4uhHNa4Q34fkaANCXxZxMG9sAwKXVLAv0LjGfGYuFjMBZ2VD0wZ02HHubQD1e
 x4N9y6Hmew5LAcMK7LVUqyQvEYpfnSdnl7l4TJPWHC7xT6ThBu4UsbA3UUQnBcETxYg3VN
 rbW3vphPI3aOcjkvhJ0Pj5fdjhVPg/oe6i2PI2x4+xaRCwznYNbtqb9qkw1POPXAemc2xb
 sMgqGNz9WJ3vTEhO3Rvp2TAlL6f6GwfJzefstvr85oUDD0KooAzXbRKYQxpi5g==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 01:18:48 +0200
Message-ID: <20260526231850.2511369-7-a@unstable.cc>
In-Reply-To: <20260526231850.2511369-1-a@unstable.cc>
References: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wS13I-0000Tz-8i
Subject: [Openvpn-devel] [PATCH ovpn net 7/9] ovpn: hash floated peer by
 transport identity only
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

The by_transp_addr table is keyed on the peer's remote transport
address, but the float rehash hashed bind->remote directly, while the
two other sites that touch the table build a clean key first:
ovpn_peer_add_mp() and the lookup in ovpn_peer_get_by_transp_addr()
both hash a sockaddr holding only family/address/port.

For a link-local IPv6 peer, bind->remote carries sin6_scope_id (set
from ipv6_iface_scope_id() when the endpoint is learned), and that
field is folded into the jhash() over sizeof(struct sockaddr_in6).
The lookup never sets sin6_scope_id, so after such a peer floats it is
rehashed into a scope_id-dependent bucket that lookups (scope_id 0)
never visit, making the peer unreachable through the by_transp_addr
fallback. ovpn_peer_transp_match() only compares address and port, so
the hash was keying on a field the match ignores.

sin6_scope_id must stay in bind->remote because the TX path uses it as
flowi6_oif, so it cannot just be cleared there. Instead build the hash
key from family/address/port only, exactly like ovpn_peer_add_mp() and
the lookup, so all three sites agree on the bucket.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1d878c3e1514..fdf6262704c1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -907,7 +907,10 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
 					 const struct ovpn_bind *bind)
 {
+	struct sockaddr_storage sa = {};
 	struct hlist_nulls_head *nhead;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
 	size_t salen;
 
 	lockdep_assert_held(&peer->ovpn->lock);
@@ -923,12 +926,26 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
 	if (unlikely(hlist_unhashed(&peer->hash_entry_id)))
 		return;
 
+	/* Build the hash key from the transport identity only
+	 * (family/address/port), matching ovpn_peer_add_mp() and the lookup
+	 * in ovpn_peer_get_by_transp_addr(). Hashing bind->remote directly
+	 * would fold in sin6_scope_id (set on the float path but never by the
+	 * lookup), scattering the peer into a bucket lookups cannot reach.
+	 */
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
-		salen = sizeof(struct sockaddr_in);
+		sa4 = (struct sockaddr_in *)&sa;
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
+		sa4->sin_port = bind->remote.in4.sin_port;
+		salen = sizeof(*sa4);
 		break;
 	case AF_INET6:
-		salen = sizeof(struct sockaddr_in6);
+		sa6 = (struct sockaddr_in6 *)&sa;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = bind->remote.in6.sin6_addr;
+		sa6->sin6_port = bind->remote.in6.sin6_port;
+		salen = sizeof(*sa6);
 		break;
 	default:
 		return;
@@ -937,8 +954,8 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
 	/* remove old hashing (no-op if entry is not currently linked) */
 	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
 	/* re-add with current transport address */
-	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
-				   &bind->remote, salen);
+	nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr, &sa,
+				   salen);
 	hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
 }
 
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
