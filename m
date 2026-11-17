Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021BD6070537
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GV56P1yi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fdRqNzFc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Jw6FUvUX;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=haS6E8DN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wSJZmJABj8U8vLX0EucNvy31970Hbk+bkxTAelMmOm4=; b=GV56P1yi7KPDoq
	KzrCzIJCwebY0iIZs6jZwPLZgil3kIUWQRmt6u8OS721QC3ejr060aUST7JjSULPCGT3IJzezk5OZ
	jCwPoC5Et7HJbmWJEQm+s3v0YeuncyGTssAAagb71JbBZuvbCSFK5ZE5Xoffhxfx6O2Utj76lynFF
	MxI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJu6-000000001sk-2wFQ;
	Tue, 17 Nov 2026 14:11:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTJu3-000000001sS-1xP6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LqhQKh7AjK1KVACPTGfTM15jWonWafxcm0cgxzgCmpU=; b=fdRqNzFcHIobt09Alf8QVzvLXP
 QpcWIyQ3pJvuPMorgG8Wq0jSzCchQlHdwTkUkbKZaG0Vy2m44wFEp0hTYbSCdKmkJaamLk2vehWxx
 rLy0nw+llU4YvDUymLN5AXvvMoSaJA42I+IHwcQ0bJ/Id+Fo1M9Of81F42Dc7CGvM2Xo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LqhQKh7AjK1KVACPTGfTM15jWonWafxcm0cgxzgCmpU=; b=Jw6FUvUXxhj/RCQN87FjkotMvc
 8qyPacYiOo0eEc5J70NBrEERRsqbyV1O7D0aeqfKEIOOnMqq45L2N4y4xsdpCz2F6CBPzyWrHLWAH
 U4DXpxt3rNHfsidZAkoCVQZefCpLRp28o4kQaRpNWAr3vYxF6nd6vSFFyhnVRj5SP2HQ=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTJu2-000000007sw-00ea for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:11:19 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jTRV61Vmcz9sP9
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 15:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794924670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqhQKh7AjK1KVACPTGfTM15jWonWafxcm0cgxzgCmpU=;
 b=haS6E8DNSQGmM8tstFsHaZMn9YgtuMd1UDyKKV0f2IZNnJsUVTMm1qWmgfhEg6e1qSMKdM
 eU16w5M31KHdKop4KOnwV+FqyIQAUAr8seNs8pxAtYgSCBz/Efqw7G7IbEG4nKSL+vMKXi
 htxOFz1sGWSgp6O0YyLt52Kv1hG55NyuTFk9mqBCXT/dNpvqonfUIu+DgwtEOk+DHmyDW9
 m15pmnQA7syK7Lw6Zf6ozrg3XMpTW5VW2vTTduynYb6u8N0/wYxDgsXcmjOcGILWqlfK+t
 IWyN3o8RWrnHa0ExNVF2/UsnvTTzWkUXBqV/x8x45vUJlhYXlqeZK5KqAuWTGw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 15:10:59 +0100
Message-ID: <7659be667398b1979db7b57d2a1e3ac240a35a81.1794922487.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794922487.git.ralf@mandelbit.com>
References: <cover.1794922487.git.ralf@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTRV61Vmcz9sP9
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTJu2-000000007sw-00ea
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/4] ovpn: select physical TX
 queues from the outer flow
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

ovpn retains the inner socket on encrypted UDP skbs so that write
accounting and TCP Small Queues remain correct. netdev_pick_tx, however,
interprets that socket as the transmitted flow and spreads one outer
OpenVPN channel across hardware queues according to the inner socket's
cached queue, XPS and the producing CPU. Packets of one packet-ID
sequence then race through different queues, and the resulting
reordering can exceed the receiver's replay window.

Clear the inner-flow hash and request hash-based queue selection in the
UDP output path, so that the lower device hashes the completed outer
tuple while skb->sk and its destructor keep describing the inner owner.
Clear the policy again after decapsulation.

With one peer between two directly connected mlx5 ports and four or
eight inner TCP flows sent from different CPUs, the outer flow used five
to nine TX queues and the receiver rejected 2000 to 4800 packets per
20-second run whose packet IDs had fallen behind the replay window. With
this change, all of them used a single TX queue and no packet was
rejected.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/io.c  | 1 +
 drivers/net/ovpn/udp.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index f14eb4e6c46a..e09a27969fce 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -76,6 +76,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 
 	/* skb hash for transport packet no longer valid after decapsulation */
 	skb_clear_hash(skb);
+	skb_clear_tx_queue_from_hash(skb);
 
 	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
 	 * interface, based on __skb_tunnel_rx() in dst.h
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 055cdb1bee13..892b33edaf8c 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -467,6 +467,11 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 
 	skb->dev = peer->ovpn->dev;
 	skb->mark = key.mark;
+	/* select the physical queue from the completed outer flow while
+	 * skb->sk remains the inner socket for write accounting and TSQ
+	 */
+	skb_clear_hash(skb);
+	skb_set_tx_queue_from_hash(skb);
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
-- 
2.56.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
