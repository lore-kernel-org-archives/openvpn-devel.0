Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762F606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eASls4pK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hHw4ntY1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FP3zf0ws;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=zOmZeaQW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=pikTnzXgTcsBzpG+yr+usBSlr+QEvldPIP3DsRuxESU=; b=eASls4pKz32c/e5ftlMFTc2yQX
	gq1p6J2MfVuUCm2+f8fNRMHRQ5r7Nog4e1rnwZhN9idUukwgT/rkUtQCA59Wl0l9LZAAmmYwH/ZOp
	ufr7p90OrgHuPHXPbH8PuVXR9+gluOZOXhLoyTEa6NB5VCmQMllqMKYRfsQzcJoVx4os=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBlJ-000000002Zc-2RaS;
	Wed, 28 Oct 2026 22:04:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xMBlI-000000002ZU-1R24
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bbh7ro44JUZscSvhfLF662noRd/zDD1qgxDlfqHkslM=; b=hHw4ntY1lK9tcdFMtMn0iwEke3
 DzH3/SWmqc2lWr9lD8ZIDjdEn9cLf0+zkQgcqEv6p5Ak6zPFkWlvdx75grYN2FhoDfwWbhiLciJvx
 +1Bq5eiS/7h8PlTyQewwVfOadslGLwxNKPeKRaUai5q4Dot1Mdqz+HQ1rki037/v9bbs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bbh7ro44JUZscSvhfLF662noRd/zDD1qgxDlfqHkslM=; b=FP3zf0wsmTePsfcdKJ97p0cx3B
 rb8NL30bxfoVMu6GkgCLTQIQEExVypTrdXgI7img1P8OzZfoqbc0FcDdhS8HQ9mt6nWWGJLN1GspY
 QoQvnLHIdEDvfGiWdrLIoE1Kvc+kAi8XOQZdtZ6UxUmwv7O3oCgv2dAxuG7edUjF/Fe8=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMBlF-000000004KX-2hO2 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 22:04:48 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jFLxd1KBLzKnB8;
 Wed, 28 Oct 2026 23:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1793225077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bbh7ro44JUZscSvhfLF662noRd/zDD1qgxDlfqHkslM=;
 b=zOmZeaQWQhAa00nQ5Gp3+f+x+qbwM/jaSdzwYM3FiuwYDzDI0Pb6ceqqgEJFjji+p/Irdx
 lqxqHNJuDEEbEz4bA3VYCE7xf4oCQS7UUKCz01Hw3hD6vC5TNVWmGaBG/zWkVIXB11pruB
 3c1yv6IbuNtodiDYxNF98M/gOs/HBg/ekf7VUKcQI2caywtqqRPrU0c+B00J0Z5/RDN9hy
 aGPFDoNBj7rxdP0FVx6xLMh7Yh2wAeJjdXL1MyKyBoHKWHeAP7vR1+631ZQF93dCqeZCeW
 YtK7AejclTpUVgP4OKt1MrLuc5WIwhrYtmRsbW2txVUJrVYhpjQVE8sCnQ4Mvw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 28 Oct 2026 23:04:30 +0100
Message-ID: <20261028220430.968756-1-a@unstable.cc>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jFLxd1KBLzKnB8
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMBlF-000000004KX-2hO2
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: drop packets looping back
 into their own TCP transport socket
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Antonio Quartulli <antonio@openvpn.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antonio Quartulli <antonio@openvpn.net>

If the outer packets of a TCP peer are routed into the ovpn interface,
ovpn_net_xmit() selects that same peer and ovpn_tcp_send_skb() tries to
take sk->sk_lock.slock, which the TCP transmit path already holds.
The CPU deadlocks.

Drop such packets in ovpn_net_xmit().

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Reported-by: Bernhard Schmidt <berni@birkenwald.de>
Closes: https://lore.kernel.org/openvpn-devel/auJj5Ld6uMjPb2eS@fliwatuet.svr02.mucip.net/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f14eb4e6c46a..57cdea45dce7 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -349,6 +349,31 @@ static void ovpn_send(struct ovpn_priv *ovpn, struct sk_buff *skb,
 	ovpn_peer_put(peer);
 }
 
+/**
+ * ovpn_skb_is_looping - check if skb comes from the peer's own socket
+ * @peer: the peer the skb is about to be sent to
+ * @skb: the packet to check
+ *
+ * Return: true if @skb was generated by the transport socket of @peer,
+ * false otherwise
+ */
+static bool ovpn_skb_is_looping(struct ovpn_peer *peer,
+				const struct sk_buff *skb)
+{
+	struct ovpn_socket *sock;
+	bool ret;
+
+	if (!skb->sk)
+		return false;
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	ret = sock && sock->sk == skb->sk;
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -386,6 +411,13 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		goto drop_no_peer;
 	}
+
+	if (unlikely(ovpn_skb_is_looping(peer, skb))) {
+		net_warn_ratelimited("%s: recursive routing detected, dropping TCP packet to peer %u\n",
+				     netdev_name(ovpn->dev), peer->id);
+		goto drop;
+	}
+
 	/* dst was needed for peer selection - it can now be dropped */
 	skb_dst_drop(skb);
 
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
