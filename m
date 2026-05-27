Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC362CD5BD0
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gok+oA+NMzAK3aM/pulY+MlLS1bUwh5L/3jZuY79vgg=; b=CYZXY8qY4ul8+lSaBhUmxK4hC+
	4Yl6EzS2At/5+cS8r79wsy/AlDejjVfZ4+CZGClBkpmPG1vfBjTczrGP6Ak3J0rBe0K7OMhi8yvKp
	JPzQykLE98n3QiJakKjl0JPZ5ASo3UU0OK7UGAHeYXEHcHnZSJElVbbCdAmXoAfbvTXU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSCcR-0004Gt-Pu;
	Wed, 27 May 2026 11:40:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wSCcO-0004Gj-Jf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 11:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ruG0BPTrSKimGHNNRIVKdyugdiqp2DX7N6BFYBjtp74=; b=UgY1vmAT66crxV7v1n9CVomv0m
 dx7YJinNl8rSpTt7ETSTtC6VpI+LTbtZD7P+e0RQ90/ZoprWx2WKqgq/iQwe7KVHLWhLZ2xkmsmw8
 oQw6zBfkldbCacOyrYpery9B6GgkezG+aD+bzFPGllWXQSl5WKQUI8gVA4+U790PCOpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ruG0BPTrSKimGHNNRIVKdyugdiqp2DX7N6BFYBjtp74=; b=G
 dljbjUOfB0AQVfQIa8kqYkQwxrH3SylVWlY7D+EiYomDG8+Hn+vL78+YqLlvZdJbpkjGxe7JwBgW7
 omewBO25pu4CLkGm4qwYIcL9rzdYzuLPE36rEPtlqqIBKtOf48mjoOHXfV7yGLom9XIZVIo1LESpz
 dG7+HAIoWYzYbKhY=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSCcM-0004Xe-Vq for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 11:40:13 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gQSMz0VygzDvQX;
 Wed, 27 May 2026 13:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779881999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ruG0BPTrSKimGHNNRIVKdyugdiqp2DX7N6BFYBjtp74=;
 b=JZRvCdYXazdyEClQiFM08Ke+KDoduPCBxYgRN3pj6QD+8pfqxaQq13b+tU5fHqNPNfFAup
 Bprq2PXU95mlL1Ruxj+ZowlqQ8R7DyWyumqjNuSab9yCFFBnhg1UU/YIm8yvbA0p7yPtVR
 7RcWzU3LPzAp80Jc7YdGdXAiWBJiBGjk83Js/wAtIKeqE0l2PuJOzG9lpjiyZTYcvQvcEo
 1rM1c8pTkJ/Nrr0qc8Q9Yx7L/rwXiMFE4H4Im/2kU9lox0ImSCf5kCvDlrwlyKe4Oo7P3X
 b/OChDFRneVcCKuru+Mbh749rnDc2XM/eK9BRXP5rLqKKAUB9HEpEzfw7fhjgg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 13:39:54 +0200
Message-ID: <20260527113954.3592539-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gQSMz0VygzDvQX
X-Headers-End: 1wSCcM-0004Xe-Vq
Subject: [Openvpn-devel] [RFC ovpn net] ovpn: fix use after free in
 unlock_ovpn()
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

unlock_ovpn() iterates over the release_list using llist_for_each_entry()
and drops the peer reference inside the loop body via ovpn_peer_put().

If this drops the last reference, the peer is eventually freed. However,
llist_for_each_entry() reads peer->release_entry.next in the loop advance
expression, which runs after the body. By that time the peer may have
already been freed, resulting in a use after free when advancing to the
next list entry.

Fix this by using llist_for_each_entry_safe(), which caches the next
pointer before executing the loop body.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/peer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..ff7c6ce9fcad 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -26,11 +26,11 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
 			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
-	struct ovpn_peer *peer;
+	struct ovpn_peer *peer, *next;
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry(peer, release_list->first, release_entry) {
+	llist_for_each_entry_safe(peer, next, release_list->first, release_entry) {
 		ovpn_socket_release(peer);
 		ovpn_peer_put(peer);
 	}
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
