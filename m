Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BE606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Kdm5c6ZD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EjiIO9JT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Yf5cETbI;
	dkim=neutral header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IIsvTVCq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:Message-ID:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Z/2FQF38f9LuvBcQ+W6peVBNM94XKRE7nYYGT8a8VVI=; b=Kdm5c6ZDIexR0OxWzmKFLhg6pS
	9u51QPb85hn7bBGQTcCU4Zt4n3jIwhjDgvPz5/xYfY45giFmmQ6yvrC3mmTwrpMX5f2+k9c/W3Kxz
	M57dmZ9lWAU7NAtI9QqNGAg6vQ29QxkOecGPZXtXutHBqchcNRhRWdBNlenf4TF6CI0w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTZfH-000000006L6-31Mt;
	Wed, 18 Nov 2026 07:01:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <979504756@qq.com>) id 1xTZfG-000000006KV-0Xp6
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 07:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject
 :Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rlsdF6Ptjg0z/qlYu6hrmjq4WNFlUg9sAyH13gwD+TU=; b=EjiIO9JTq4hK9lHLR3VHn1IsBW
 XFNfdPWHtMpUjsiEFArAxbfxsFBEGcwftamNnKA3dX9nziubFaAq7YLO2fotBxc1S9FSdYOqSbaz5
 9nhrEBrVtmRDxgC/UPYctBeLCgw+9FgmJO20leJ2o4/7jvBB9VgAqON+rJoUl87U/lzk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Message-ID
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rlsdF6Ptjg0z/qlYu6hrmjq4WNFlUg9sAyH13gwD+TU=; b=Yf5cETbIg898+yVS8/VTPokySq
 cO5NzZTforRmy/sB12+3nRWJNEddvfwkv0LP4UINbrl3xTaO+NnAoSdTAuyHEbg+/+s9UwQYCjKFf
 wYedwUEEVsgawhmonEylNYxh0fuIPXN4g8xti3hW7XzcGfgAtbTd76TFqMySOy1pXW1k=;
Received: from xmbghk7.mail.qq.com ([43.163.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTZew-000000004ho-0eWB for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 07:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794985239; bh=rlsdF6Ptjg0z/qlYu6hrmjq4WNFlUg9sAyH13gwD+TU=;
 h=From:To:Cc:Subject:Date;
 b=IIsvTVCqxjTHSbJmbzML/1tDxeaqjV11NwWuZg+UtNlpQhx4cVOFW8Z4T3GwAbIxS
 PaU3t/4xS+XUUMcHxmZdYqqc7JlNoSSz1/t3MO8kDVpGdrIy41rY//9BkKpcs+KJvO
 0xvF1Yp6IShsgXht1LE/5j8iRwAwzvfv5WCbk/EQ=
Received: from VM-0-17-ubuntu.. ([124.223.3.35])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 250B0CE; Wed, 18 Nov 2026 15:00:37 +0800
X-QQ-mid: xmsmtpt1794985237t3vrhmp5b
Message-ID: <tencent_4CA59D4D873F946422CA8AAEB20AF7C4CF05@qq.com>
X-QQ-XMAILINFO: MTEKjEyAppcsdQUTnbW9rFjB8r8B8CnLAwuPwZQ923MYTctGEOXDiMoEHO1Xnr
 Kn0lmjBlOeOJb/J0Jg2CbP7l6CgKVwDzla6E7xEGRDa1w2FI2XEggh1CCB7HERq478KyMZngE51T
 ySKR913EooRoc8LcJNTSYdhy9LttVW1xO/uVeqRjBc+CY75h3PNQqmd/RsoqR7jXnb+Zgj1jkkz4
 ucAFhi+dkxD5g1XBjhGVqLGocHIcej6fjSbPKyAxYTdOUAXRQpLP3rqdDbsTz57top/bUPJCl6xU
 ewVkBkj6q/CNTcMccg2x4TdmkG/RrRhUHLAsz1wK6WXQT8TSzimZdxS3c7D+UUhuVX30myfowF99
 odDqIpMMUTxNb3p4E2WUs4BGemN3FHwps+771NUi+ztMYE1z8ZPCYAU8VT6pw00lONXGwnSA21p6
 VrmJzoC8rW2K1YkvsL0bjUbu1M+/GtSDw317SsidCjxvJEVvalU8+LFZr7YiZ8Uhu5/di6pX9yda
 SEBFONQ8rpYnkjWJHVApnP9dsbBmyZblZ/rfpPtE/3VDuXU/fPXFpETyeHUNqcFjdcXuyL8K5VXT
 SJ5UfORLermMEdiBLeeNkzlDZ3j3jfLRYJ9r9nA1RCMqD5axLANQjIMXG8Jm5h66CZf751SuMCVp
 S896LllrMMnwfnClSTeQALc5rFo8HoxizgvqMB8mUaQkDkYP1//vmxsg6cY16q2MD/AanMSdrqyF
 3Vs2cRk33p4w0VWXhH0A8k93e4OpviRW+udJUmV1AjxuceCIyhe+ZfEJro4YyoXXLuLfbqq2eZg4
 FGPSoZu46PyAaZcnChR30KB7kt0bIIRdOK7wcBilSVs+6fyBytUMW6sy8tQx73/oEjV6h/9PmRKa
 wEd4M5cL/4D+iPIY64KqIqGZpESOqpzvRrc7TFWUuHnaRLr4RBfF6+l4tjM6hs6LnP8vhglXA8EC
 eVznD0Cst5Ra1qdvYh50YghXOeDTSV9Vaalp7de9nz8CYy5NI9pVC9dhwDr3Uk2c5zNR5ovfPchN
 WzKdahr0as3BbaNDuOs6vDWidbOB38z5MRc0eNrHUtLS1tylMqpcz51+r7Opw88O6m+q5hvuq4Pa
 97AFMS
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 15:00:37 +0800
X-OQ-MSGID: <20261118070037.3265825-1-979504756@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTZew-000000004ho-0eWB
Subject: [Openvpn-devel] [PATCH] ovpn-dco: hold peer ref in
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
Signed-off-by: liuchong <979504756@qq.com>
---
 drivers/net/ovpn-dco/tcp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn-dco/tcp.c b/drivers/net/ovpn-dco/tcp.c
index fe095f9..d8f9afd 100644
--- a/drivers/net/ovpn-dco/tcp.c
+++ b/drivers/net/ovpn-dco/tcp.c
@@ -35,15 +35,26 @@ static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
 
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
 
+	/* Take a reference while still under RCU: ovpn_peer_del() may drop the
+	 * last hash-table reference before socket callbacks are restored in
+	 * ovpn_peer_release(). Without this hold, a concurrent delete leaves
+	 * peer->refcount at 0 while this callback still runs, causing
+	 * ovpn_peer_hold() for ovpn_recv() to fail and a later put to underflow.
+	 */
 	peer = sock->peer;
+	if (unlikely(!ovpn_peer_hold(peer))) {
+		rcu_read_unlock();
+		/* Peer is already being destroyed; stop consuming the stream. */
+		return 0;
+	}
+	rcu_read_unlock();
 
 	while (in_len > 0) {
 		/* no skb allocated means that we have to read (or finish reading) the 2 bytes
@@ -103,11 +114,10 @@ static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
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
@@ -140,10 +150,12 @@ next_read:
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
