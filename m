Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC176070521
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YiTsBZEP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AkT1UMST;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PjvEgo7B;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=mq+gZ9c3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SM3zZ/HcNeHhOq9l7RWe6EfLUbDRRiLGHO4wm2H7BwQ=; b=YiTsBZEPuw/OyT
	lVtnAcXZ292EYV9UNiml+9nYW9d/GdfJXe0Fwk9WQTeM+nkZDXRjdwgyKkamtHpA+1YmON1YtUdUR
	Qm60UdGLfu0r18CqiCDAMYflaRRtoRu5IsNrSbqLd0MXyBvcMAwogpSIJ3o7yZLSMis65Q/feQfwO
	HCU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJu6-0000000021I-18WH;
	Tue, 17 Nov 2026 14:11:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTJu4-00000000212-3JDn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9OBo0xgyqYJrCBn0r8bdho/zHv3WCWK75dct43w9B6Y=; b=AkT1UMSTg68f/Pb78f05r5pr1O
 CARD8cPMzjI+VGvoi6Qoy07UwhTsn5U1rb755ZjZRzQkfw4dXpxuo0MsaeOys3Xft3avJ9kr3Yj57
 0LZyMfsJtWWrdqr8txGKYkpwyJAH3NjMVv1wqCWm/kJAewuNT0unpBm6mHO0khclaxiI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9OBo0xgyqYJrCBn0r8bdho/zHv3WCWK75dct43w9B6Y=; b=PjvEgo7BsEYN4T2sI6Nlbrbcl+
 +qhCAFm6xzKScEw9UIC4FWe8x5a8BkGx+rCzeGRprSMw+NZwoh8PKt4VllTbxNn3Z3Z+DLDB54Fzl
 yUhrx4JypTOvoLxdZiAsl9g8VRgDECQ6cvaTaFoyitRaK+2uLox34f54x9jj0ftVbMsg=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTJu1-000000003Ny-3i2E for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:20 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA512) (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jTRV55hPXzLm0V
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 15:11:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794924669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OBo0xgyqYJrCBn0r8bdho/zHv3WCWK75dct43w9B6Y=;
 b=mq+gZ9c35TWPPvPyHgJqRnuHQYLNjjDviVaNe2M+RtBPWILh484rNV4HZEQ/daMQ6CdJp4
 nU1BHIt65AmAZBN9xIThB7yTvi+njqIGWAS/8FRVQ258ukb0avqoEDaQbFxcrJkFMWr6m4
 e05BYjQGH+ygDprbG3RDCt88J1Ykrz/7hBGlihzdG4VE5Kzd0nfR2o7+dMK2NDHK1HwGVH
 kJMGzFNybSwfHZVWucv4M9dMOuMH7wQNHYu7+ezyUR6gmEiehU61UhvaF8ckkfs/TBMV3R
 7P3BNgOmruL3Sf2aqzLSrUyQ/HlsjHh9nKFSZspdLTX7zq8IUml9D4i7s+adVQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 15:10:58 +0100
Message-ID: <f5ff46607b1dd9592bf45c6c325cf7fdcbf8eacc.1794922487.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794922487.git.ralf@mandelbit.com>
References: <cover.1794922487.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTRV55hPXzLm0V
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTJu1-000000003Ny-3i2E
Subject: [Openvpn-devel] [PATCH ovpn net-next 1/4] net: allow selecting TX
 queues from the packet hash
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An skb may retain a socket for write accounting even when encapsulation
has changed the flow represented by the packet. In that case the
socket's cached TX queue and XPS placement describe the inner flow
rather than the completed outer packet. This matters when one outer
flow multiplexes several inner flows and must stay in order, for example
because a replay window protects its sequence.

Add an skb policy bit which makes netdev_pick_tx select within the
packet's traffic-class queue range using skb_get_hash. The policy
bypasses the owning socket's cached queue, XPS and a recorded RX queue,
and is copied with the skb so that it remains effective through stacked
devices. The bit takes previously unused space next to tc_depth, so
sk_buff does not grow.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 include/linux/skbuff.h | 18 ++++++++++++++++++
 net/core/dev.c         |  8 ++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1d6832878930..aaa33d44b01c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -833,6 +833,8 @@ enum skb_tstamp_type {
  *	@_nfct: Associated connection, if any (with nfctinfo bits)
  *	@skb_iif: ifindex of device we arrived on
  *	@tc_depth: counter for packet duplication
+ *	@tx_queue_from_hash: select the TX queue from the packet hash rather
+ *		than the owning socket or producer CPU
  *	@tc_index: Traffic control index
  *	@hash: the packet hash
  *	@queue_mapping: Queue mapping for multiqueue devices
@@ -1043,6 +1045,7 @@ struct sk_buff {
 #endif
 	__u8			unreadable:1;
 	__u8			tc_depth:2;
+	__u8			tx_queue_from_hash:1;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -5268,6 +5271,21 @@ static inline void skb_copy_queue_mapping(struct sk_buff *to, const struct sk_bu
 	to->queue_mapping = from->queue_mapping;
 }
 
+static inline void skb_set_tx_queue_from_hash(struct sk_buff *skb)
+{
+	skb->tx_queue_from_hash = 1;
+}
+
+static inline void skb_clear_tx_queue_from_hash(struct sk_buff *skb)
+{
+	skb->tx_queue_from_hash = 0;
+}
+
+static inline bool skb_tx_queue_from_hash(const struct sk_buff *skb)
+{
+	return skb->tx_queue_from_hash;
+}
+
 static inline void skb_record_rx_queue(struct sk_buff *skb, u16 rx_queue)
 {
 	skb->queue_mapping = rx_queue + 1;
diff --git a/net/core/dev.c b/net/core/dev.c
index a230ecce9327..e150d5e92712 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3625,7 +3625,7 @@ static u16 skb_tx_hash(const struct net_device *dev,
 		}
 	}
 
-	if (skb_rx_queue_recorded(skb)) {
+	if (!skb_tx_queue_from_hash(skb) && skb_rx_queue_recorded(skb)) {
 		DEBUG_NET_WARN_ON_ONCE(qcount == 0);
 		hash = skb_get_rx_queue(skb);
 		if (hash >= qoffset)
@@ -4925,9 +4925,13 @@ u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev)
 {
 	struct sock *sk = skb->sk;
-	int queue_index = sk_tx_queue_get(sk);
+	int queue_index;
 
 	sb_dev = sb_dev ? : dev;
+	if (skb_tx_queue_from_hash(skb))
+		return skb_tx_hash(dev, sb_dev, skb);
+
+	queue_index = sk_tx_queue_get(sk);
 
 	if (queue_index < 0 || skb->ooo_okay ||
 	    queue_index >= dev->real_num_tx_queues) {
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
