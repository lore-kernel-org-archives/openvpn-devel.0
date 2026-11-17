Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282860711AF
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KxJxAT9d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZBTTNEcb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PedlbSbP;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Q7rPNm+q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=w7JkQ29F/32j9OTHXUaNDYXFg/wmOWy4WA8qJK1cenI=; b=KxJxAT9dYFxV1/
	FkB0x1ya0TdOdKM/OYz6Qdq6ACfHl5xD5VPcHbmj0Sq/0np7a4YAemwwIGFNYoPa3NBmcBYIIBf64
	y5a9Z6Ngdm6P8Z1fnOFlPBDQYuSRwqrZZbX0Cw1yUWXmo43aBY66QCzMMM9WThuZQV5P822ny46sj
	iY8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJu8-000000006qu-0Ato;
	Tue, 17 Nov 2026 14:11:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTJu3-000000006qj-31JN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DQj1ziqMEKpHWDaqoM4Ka48aAbfdgTEL750t4tRlk/U=; b=ZBTTNEcbkHKV3e45H2Td7qtjYb
 AxrvIwdC+2+rEi9LAB/3Xz+SC9+fgQEn070DWgBqZVKx6gdSH4uDGwOxqcsx+K4CYbQHunOFTUTUZ
 RqDXQsQInB3V7BiY6Yevg9qAL2cbpQdBNrpgtlrzDfjrMNL3jhZbqG4UfbrGZyIP68mk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DQj1ziqMEKpHWDaqoM4Ka48aAbfdgTEL750t4tRlk/U=; b=PedlbSbPZnMT17BqDV75F1n3xt
 6Le0vmpmEuciZ7Gvcz3Iumg28g8jVNSeGwqAYZLE+td2W8GM5eQsr0Z5aZGvHqC52SB11Cktl3bWL
 OGZRa31GuMkX+/PvmreXEguS6gfdW/LKjlyHhj5g1r5NH53it5O1jRtn/fRWWyfDoVuE=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTJu2-000000003Nz-0rQx for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:19 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jTRV66PqYzLlp6
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 15:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794924670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQj1ziqMEKpHWDaqoM4Ka48aAbfdgTEL750t4tRlk/U=;
 b=Q7rPNm+qpa/rZPdKrV4u/DwkAqL45ESZ8Sad6kb4xPPErgo3iZu8kJQvy2ZOURfj4508AF
 D4flT7TjYmTYVFEqpS1FWSv7o46uFcCW48EsQaqHxUbL3l/cIBY/QbYVW4NqV0xX0d7LV5
 93Qs98ixJFTkc/IXbDWhbN/wxo3u1YL9f+vm3azEGixJxEXztOiiGCFKeVQ4db7r69KZs9
 dlLXjNvuSypnlkDV/AU2oAZXlStsY//67aSC6LFuPo1qByUCcg36uAyN/xzUMQxmHlPWjv
 f8nSvWLK9dUF7HpOQ4s1pIHVeVd88n+JSKsDzp+ukwZd1cMghm+aU/OuDUtgrA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 15:11:01 +0100
Message-ID: <148b9524e5fcbbe18a18368ba6a2abe3904b4d24.1794922487.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794922487.git.ralf@mandelbit.com>
References: <cover.1794922487.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTRV66PqYzLlp6
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTJu2-000000003Nz-0rQx
Subject: [Openvpn-devel] [PATCH ovpn net-next 4/4] ovpn: hash the outer flow
 from its flowi
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

Selecting the physical TX queue from the packet hash makes
netdev_pick_tx dissect every outer packet, although ovpn already holds
the outer flow in the flowi it routes with. On IPv6, the stack derives
the hash from that flowi only when it generates an automatic flow
label.

Set the hash from the outer flowi in both output paths, so that queue
selection depends neither on dissecting the packet nor on automatic
flow labels.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/udp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 892b33edaf8c..f9741fd86c20 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -288,6 +288,8 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	spin_unlock_bh(&peer->lock);
 
 transmit:
+	/* hash the outer flow for queue selection without dissecting it */
+	skb_get_hash_flowi4(skb, &fl);
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
@@ -388,6 +390,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 * udp_tunnel_xmit_skb()
 	 */
 	skb->ignore_df = 1;
+	/* hash the outer flow for queue selection without dissecting it */
+	skb_get_hash_flowi6(skb, &fl);
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
