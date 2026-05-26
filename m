Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F76DCD6E48
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 23:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=guU1ZAwMNqS6m0tYrMyJgYIExjRVa0Vc8UjnOX0tCAw=; b=cP4SOjE3anTzHixkBqC4PYF9K+
	Fe0/xxI/xYRwqlNVNv2Wx0mrvdZPJp6W25jJ1w8Bdm8BooS5VwG1VsMv5YduV5Oc0KL5JzFXjY1Vc
	RTsq8fMA+8oElzpD5THd27PP5w6J4V+YZTXLA3Y7oGyxWvjfOhwctJGxxNz9bJZsEn3s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS13X-0007KB-Ev;
	Tue, 26 May 2026 23:19:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wS13E-0007Jk-RO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uzV/iSWxOWFbwHNn28LZgHA+TgsJ5nTKq8WYlRFnFyA=; b=ce/58vtzFFgUBvPeCRFf7Qkkmi
 I8h/O4ImBZTcfz6rNzTnTaDWTgRmlT+bV+kKHFsZMuU/cmhtCPdzPqlB1P0WQ9X87Uptf14fnEK86
 mkhnRGWkQsE6fAFELttxhAj3B/wK0Pvuq1EbCrm5SC0QNn7+lJwWR5hQxWWMHzkd+7cI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uzV/iSWxOWFbwHNn28LZgHA+TgsJ5nTKq8WYlRFnFyA=; b=i
 Cg5MsPcQULFizKh+letS8PTRqACpDAI7y1KANPftpTyvgzgvFC7tbsKTe9FE+skxVjyA+eAbVCTTN
 AfkofmRm/6Y6CKscmAoY3+0QYpmqGd+YhGEZm3TjcJPJ6j13bN0p+nimRaULtw0zBB+He6ckn0BIp
 dYbYM3nQ8BxvAmBY=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS13A-0000Q2-6h for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:07 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gQ7ww4Wdxz9tL7;
 Wed, 27 May 2026 01:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779837536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uzV/iSWxOWFbwHNn28LZgHA+TgsJ5nTKq8WYlRFnFyA=;
 b=Aq339GGERrnOGes8ZZX5pa1ELStZJKC+qA4vv4MROjEtLeh9eZB7BE/bot8tGPhCIZ5anW
 gciEDVvpr1XsM4chvKKAd/NYPVpa0Q8MWwIF0wOlbEQCaq+0NK0gSt0AOVDyRMRuePIjqA
 QqUodKKiHoPes3xbKLEBAjDcS8TAvB8ti2MtELnX9euULlBRw/xk2J0GTvFikOPcsxUgze
 Mtc+YAgBImqJamODeQAewWZOUVp1W7fPTB5fro8oXW+OwjPbF/dLNndaYQ7gVHVzfg07yc
 VYjopLPO87YSFWhM2DRGQP+FTB8C4SYNwXhxXyr2bAwFYYjQPrc+aYRSu35Dlg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 01:18:42 +0200
Message-ID: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gQ7ww4Wdxz9tL7
X-Headers-End: 1wS13A-0000Q2-6h
Subject: [Openvpn-devel] [PATCH ovpn net 1/9] ovpn: skip rehash for peers
 already removed from by_id
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

ovpn_nl_peer_set_doit() resolves the target peer via
ovpn_peer_get_by_id() before taking ovpn->lock. In the window between
the lookup (which only takes a refcount) and the subsequent
spin_lock_bh(&ovpn->lock), a concurrent OVPN_CMD_PEER_DEL, keepalive
expiry, or socket teardown can take ovpn->lock first, run
ovpn_peer_remove() to unhash the peer from all four tables (by_id,
by_vpn_addr4/6, by_transp_addr) and release the lock. set_doit then
acquires ovpn->lock and calls ovpn_peer_hash_vpn_ip(), which
re-inserts the now-removed peer back into the rehashing tables.

The same race affects the float path: ovpn_peer_endpoints_update()
holds only a refcount and acquires ovpn->lock very late (after async
AEAD decrypt and a netlink notification), then rehashes the peer
in the by_transp_addr table.

The resurrected peer becomes reachable again from the RX lookup
(ovpn_peer_get_by_transp_addr) and the TX VPN-IP lookup, even though
userspace believes it is gone. Once the data-path refcount drops the
peer is freed via call_rcu while the hash entries embedded in it
remain linked, opening a UAF window.

Bail out of the rehash when hash_entry_id is unhashed, mirroring
the sentinel already used by ovpn_peer_remove() to detect the
already-removed state. The check is safe under ovpn->lock, which
serializes every mutation of hash_entry_id, and is a no-op for the
add path because ovpn_peer_add_mp() inserts hash_entry_id before
calling ovpn_peer_hash_vpn_ip().

Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a09d61296425..a472ffe3016b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -307,6 +307,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			return;
 		}
 
+		/* peer may have been concurrently removed between the caller's
+		 * initial lookup and our acquisition of ovpn->lock; skip the
+		 * rehash so we don't re-insert a removed peer
+		 */
+		if (unlikely(hlist_unhashed(&peer->hash_entry_id))) {
+			spin_unlock_bh(&peer->lock);
+			spin_unlock_bh(&peer->ovpn->lock);
+			return;
+		}
+
 		/* This function may be invoked concurrently, therefore another
 		 * float may have happened in parallel: perform rehashing
 		 * using the peer->bind->remote directly as key
@@ -905,6 +915,13 @@ void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
 	if (peer->ovpn->mode != OVPN_MODE_MP)
 		return;
 
+	/* peer may have been concurrently removed between the caller's
+	 * initial lookup and our acquisition of ovpn->lock; skip the
+	 * rehash so we don't re-insert a removed peer
+	 */
+	if (hlist_unhashed(&peer->hash_entry_id))
+		return;
+
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
 		/* remove potential old hashing */
 		hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
