Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7641606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c7iFEMmQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XnfD8HOi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VLBuY9me;
	dkim=neutral header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xLkX7nWD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:Date:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=606eb1WaooORSlSVLKKtlR+v9JOGCazTOOazsk5c2F4=; b=c7iFEMmQg2Purd
	gD6C3jkgLpAjIieTDkaGgUUP9XZ+FqHJPtq/0shn9ECTVTnVFowPynM8ZYzWp4/zxCOudLLdgf/VW
	Mz6cCZ1+UdQkhJOMOol+WoJzqXahwxC7Y1/AlSVzz8uHhetnmrOwuTzygaYzJ3nTG3KgKSt1Foebg
	HOA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTayl-0000000082a-0obl;
	Wed, 18 Nov 2026 08:25:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <979504756@qq.com>) id 1xTayj-0000000082S-1xCT
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:25:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Mtd5NScO6HSs8iE0LVsK3YbdwmnE997rBVW63b/TpM=; b=XnfD8HOiilQ0Vxc4FF8W8iyqZi
 uYIAjZ7HkL5HyueYKGQkpBMRhLa/fsAsuU1rdi4W1vk/jQdck1I0iZqYuTYo6Qsg2mIE9DMVZ7RfV
 MyV282G3aMwGaoE8g4Qu69VbUnaUNlj/6cVEdfjjtdqeVWk012sKI4iWpQwW5ZNTjhlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Mtd5NScO6HSs8iE0LVsK3YbdwmnE997rBVW63b/TpM=; b=VLBuY9meLuxC+npQVT14tEq/kW
 cGDnVSgcqM8sYIv5tNrKEpSS9WA+N8Nhrlhl+lV5vSbhVfkRZO5XURBwUl0A1wo8cbOCJZNwxDqyz
 l17ozZs4tgWVYgr75ayXZVrFhypXrIYMYQ7sr0AxhHtxoobo4AZUKLJhBhkFAUBJleII=;
Received: from out203-205-221-236.mail.qq.com ([203.205.221.236])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTayi-0000000016V-2brC for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:25:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794990309; bh=4Mtd5NScO6HSs8iE0LVsK3YbdwmnE997rBVW63b/TpM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xLkX7nWD3WAte9VpgKshkHQTU3OaOSzBvMV/ETlDpX6PyyUE72TJ0scxc8heNdU/c
 XCVaAsvwGNKobs/SL6JQvfA7wvyGyFyTGPi7RcQn8RSbzc2wRRnz3gP9bp6zuv/Uok
 oA9TRPhwBIYhGrJ+l87pYh/AHIS+8G7IIGim7O6A=
Received: from VM-0-17-ubuntu.. ([124.223.3.35])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 647102A8; Wed, 18 Nov 2026 16:25:07 +0800
X-QQ-mid: xmsmtpt1794990307tm9wmbysi
Message-ID: <tencent_61D46342CA8AA4D20297CC2FB21D4A272C05@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NOMdA56vM55O7Zl17wmMRRa1T3OsPfSX6Sdruyad5sbdpcET4Nc
 hPWdjMoXnVR2F+gYjqRmZugK9Ixf02IVy7oeqUR5KEKSIs7BnZYVg++Nha+Sh/+SWLw0A67lrbfx
 EKAq/EN3tp3XYmCAjIyZWfWXWuG/t7f+tJKwLaiMmrdDGu/K8pP2fU0OsaAtuVwFyfYMM4IoAhln
 w9/NrbOAqu0STFoc4U7stN5wZ+GgjfRaBV4i3Ig77X+x6MV5NH29843hpmopUWqRO9vJsVoUaxfq
 j7Va5rvlslta+vesc3rmZlzzuodwu24ZA2c5+h6Va6Pg9CsPPlELKhtgYdCRjIb8s0Ax6egMPXHw
 V56MDuOVyhwPOG+EWhvYbveRwS5lJ91xePgS+HP7mm86IAtYAhOwGIkugbd1j/H63aWSxuCzEuBd
 5W5AIAR1NC8pUZ1/WM8O38k7o1Fi8BqoJRTAQoJ1sUca+4AmwAzb9cbPGFFLqlSvoCg7oJrW122E
 pKyB3fc/nKLzfEuHLRZxKRQOONZzapm1hujJFxmo0RsaDB1DN89HD0Gf2WGvUBa9upoMkE1WCyxj
 6QvTUkFxxy/XoMG0Nc4nVzQtLN+oZsYMaIx8+613zls5enN7AWVCeTZlVwwE/F12q0LkmoftkObM
 jtbX6gxljONQvOABiWpfy5Y+G8r1kKj7lkpFCzMYCzhALYoJaZMvrBUMGyFNM5VcRvn+lRunyjar
 Tjg1HqxU2CYbR3HJ7sccGKhIiACAGYctSL5uFpuiDbvtyy61o1jk7cHvZDMCJ5wtc705quE2js8+
 BtTjghvaHk5KxfBoLcY0L916/o4vtMQeYQKy8XgrTqA91t2+ZUQkB5bHTsRdS14bCJfxbQXyy+rV
 fPNY471phllibi4rHKXoeD7PD8v4nuPkxeE9LM99dKcMvg1mFARSmcx3puPtiju7MhcLwTt9Vl4S
 jlM8eTnzPv9ZVub1yMbITHquyVCv/NjuU5/gpdp9+65uW6KjwShyMsaMAIyoE+XIUbJijcfWkM+X
 p5x56p3XNVVxvuz6qwhlHwLRxHaT8=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 16:25:07 +0800
X-OQ-MSGID: <20261118082507.3286702-1-979504756@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118070037.3265825-1-979504756@qq.com>
References: <20261118070037.3265825-1-979504756@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTayi-0000000016V-2brC
Subject: [Openvpn-devel] [PATCH v2] ovpn-dco: hold peer ref in
 ovpn_tcp_read_sock under RCU
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: liuchong via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: liuchong <979504756@qq.com>
Cc: antonio@openvpn.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Liu Chong <979504756@qq.com>

ovpn_tcp_read_sock() uses sock->peer without taking a reference.
ovpn_peer_del() can drop the last hash-table reference while the
TCP data_ready callback is still attached, so peer->refcount may
already be zero when ovpn_peer_hold() is later called for
ovpn_recv(). That leads to a WARN_ON and a refcount underflow when
the async path puts the peer.

Take the peer reference under rcu_read_lock() before leaving the
RCU critical section, and drop it on all exit paths. If the peer
is already being destroyed, stop consuming the stream quietly.

Fixes: 209247cf6d47 ("ovpn-dco: implement TCP transport support")
Signed-off-by: Liu Chong <979504756@qq.com>
Reviewed-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1:
- Use real name in Signed-off-by for DCO compliance
- Shorten the RCU hold comment as suggested by Ralf

 drivers/net/ovpn-dco/tcp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn-dco/tcp.c b/drivers/net/ovpn-dco/tcp.c
index fe095f9..d167be6 100644
--- a/drivers/net/ovpn-dco/tcp.c
+++ b/drivers/net/ovpn-dco/tcp.c
@@ -35,15 +35,21 @@ static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
 
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
-	rcu_read_unlock();
-
 	if (unlikely(!sock || !sock->peer)) {
+		rcu_read_unlock();
 		pr_err("ovpn: read_sock triggered for socket with no metadata\n");
 		desc->error = -EINVAL;
 		return 0;
 	}
 
+	/* hold the peer while still under RCU, it may be getting deleted */
 	peer = sock->peer;
+	if (unlikely(!ovpn_peer_hold(peer))) {
+		rcu_read_unlock();
+		/* Peer is already being destroyed; stop consuming the stream. */
+		return 0;
+	}
+	rcu_read_unlock();
 
 	while (in_len > 0) {
 		/* no skb allocated means that we have to read (or finish reading) the 2 bytes
@@ -103,11 +109,10 @@ static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
 			 * Queue skb for sending to userspace via recvmsg on the socket
 			 */
 			if (likely(ovpn_opcode_from_skb(peer->tcp.skb, 0) == OVPN_DATA_V2)) {
-				/* hold reference to peer as required by ovpn_recv().
+				/* Extra reference required by ovpn_recv() / decrypt_work.
 				 *
-				 * NOTE: in this context we should already be holding a
-				 * reference to this peer, therefore ovpn_peer_hold() is
-				 * not expected to fail
+				 * NOTE: this cannot fail as this function already holds a
+				 * reference to the peer.
 				 */
 				WARN_ON(!ovpn_peer_hold(peer));
 				status = ovpn_recv(peer->ovpn, peer, peer->tcp.skb);
@@ -140,10 +145,12 @@ next_read:
 		copied += chunk;
 	}
 
+	ovpn_peer_put(peer);
 	return copied;
 err:
 	netdev_err(peer->ovpn->dev, "cannot process incoming TCP data: %d\n", desc->error);
 	ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
+	ovpn_peer_put(peer);
 	return 0;
 }
 
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
