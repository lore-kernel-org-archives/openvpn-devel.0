Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD50C79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uDM/qUKshMat6P2RcYqyfiGPDvMvpMlsVZeyiZcr7C0=; b=iCFFTnosBh/MLh2kADt9Fh7vd9
	K5dHA89T5WNF1b8xHRwkidbdpdsIy6r8mzrqrNs54dthDQHBeuAgIs4L4gKoKRlAJyuzLByEwHnBL
	pj2K27dh+DsQnAYIvc+Re6edVu8i6FwHi0HuAH8m207BU6QVq9tbcS7n2zuk8HN0dx2M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3X4K-0000kO-7t;
	Mon, 07 Sep 2026 10:59:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1x3X4I-0000kG-G4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1LF/SyvYYxlmMyYIg42TXzIgqdw4CptSyjvzk7Uhnlw=; b=ZzaZhTTSdPrLPbuT+VVLsbKyQD
 AscWTH21c5o/64WseqmNLmk7WlNCC66vbSrpDzhJl4QBfahh7butTlJMJDHIEEeK9SpoC6lnxa4Yh
 BffjjSYaTv1Q2uvRzdUegt6uEzLQj+5YA22qcGjZVk7SDBd0moaVyCjtWN8v2bVarAiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1LF/SyvYYxlmMyYIg42TXzIgqdw4CptSyjvzk7Uhnlw=; b=e
 oyBj2ARkbJNL4NdJ/XH2Rt6dNu6Ahwyx+pxJtyDpZoR1ngubC58hKsv2CdW0d5wvfFnVjAgZ2hLVC
 5glRFhuMAfsRh3FGeAyDZS8TxeY0BZui3Rtvyocw3CUsuGjKa87A3l65iPbeVugrb3jKauMIt/54D
 Dvg1ExSJPC37t/hc=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3X4E-00021x-Nd for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:59:15 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4hdkbG70fzzNJ;
 Mon, 07 Sep 2026 12:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1788778747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1LF/SyvYYxlmMyYIg42TXzIgqdw4CptSyjvzk7Uhnlw=;
 b=11x2LUqHH5JCboLifB7ZDs/DLN0d8hxRQyD0lxNBYIYdsiJ/l1MnDOeQTOI0E2Eh/45fi5
 cewV3WgYGSX+W838v5K8GUKS0SLYMzcQhldQgFOZPSKljQHdxcN9Jz3+KsFT+wbcf/zdoE
 p+R1A6G9p4Xm70xjtyUc0U1Ua477LLokic1M40tnGtA83e1uvD6BFvOqEsJKinA7WJoWrf
 yWvVet8935WfE2ptHOmaiQYGvb3ZYi3OXFqBx8GUseHQMXDhe/F3Ne+f+93eqcfD0y+2Qj
 +j31uEIjYq3BijjlfsoPvPmyWCASjJEa/TF7WHOfDrXFF5HB05gV1u+axJhSTQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  7 Sep 2026 12:59:02 +0200
Message-ID: <20260907105902.3270608-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hdkbG70fzzNJ
X-Headers-End: 1x3X4E-00021x-Nd
Subject: [Openvpn-devel] [PATCH ovpn net-next] ovpn: remove redundant peer
 NULL checks in crypto post functions
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

The AEAD helpers set the peer pointer in the skb control buffer before
any error return or crypto request submission. Both crypto paths hold
a peer reference until post-processing finishes.

Remove the redundant NULL checks before ovpn_peer_put() in
ovpn_encrypt_post() and ovpn_decrypt_post().

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da60..f14eb4e6c46ad 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -206,8 +206,7 @@ void ovpn_decrypt_post(void *data, int ret)
 drop_nocount:
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	ovpn_peer_put(peer);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -305,8 +304,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	kfree_skb(skb);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	ovpn_peer_put(peer);
 }
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
