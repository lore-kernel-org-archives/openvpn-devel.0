Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55375CD37B6
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c/Rd//P4XKirhJ0vmlwKHoSkR68bdiUM2qjJb/RN0/8=; b=UU4EDIViqhmQKH2ED9mpGTC4AA
	KQ0uQmvP6C1mGaWCDMSCZsHUC3tbOqz+MgN8WXkPqbbMEL2rSxgS5of6x2Tv2ovPVrCe/z0LelgkX
	7Y5NGUU09kLD/HMmw98JXosX6MBOreboOQTdHPa1xCVf6ONDc+uF846FSJz5+4AW13As=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN5ZB-0007rw-3c;
	Wed, 13 May 2026 09:07:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wN5Yr-0007r9-MD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ia9PZH+qV/Xqk7xjBUDF1zydfLjRZfH8uAeFN9Od6hE=; b=DmZgiToDsu6k6d/EEEJn//oc4J
 cdQBEwk3wX+9CU0Ulkve1mYWYJZp1TCGr+O4JEmUv5PtUv4D4weV/0V/Mp4qMEI1W7lKBgV4U59xH
 xs9OW7fp/tvXIFw0LWy9TFofAvTkDPAp5Snmv/8/wgk7wfGY09zGugn7yFw0HDzKRbXY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ia9PZH+qV/Xqk7xjBUDF1zydfLjRZfH8uAeFN9Od6hE=; b=Z
 qpekDmF6B6NGTrZqoqVNWj8gP4p1aaTnjzwYyDitDPXOz2gVgbj1BsG99SjDGqzlbDajVZfFFddO8
 KpniAzSQt8qfjO8Zw0Pe9uzAJ7Wb/J+I64mDLJTniIB5nuHLaZOOWWDMqgHQBZCc3zOpaat0S4BR9
 k1lOrJ9U8RFStQLc=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN5Yl-0003LH-Uf for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 09:07:23 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gFnf32wLNz9vFd;
 Wed, 13 May 2026 11:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778663227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ia9PZH+qV/Xqk7xjBUDF1zydfLjRZfH8uAeFN9Od6hE=;
 b=ONCmdbAclc0glsntiq5cOj9DkKfxEb3EKrIWAzPUOP64GjOqL/MEY6DOu/7Q/t0aAMR5Ip
 zRLnDO8hqOhVtwWyX0QUMW++pDsuqDOSDjmK+A1lYjNFWy9xKd9JIGjarLPGTy2yG2ROF6
 FnfXw1nc8EyNwKvtpxgfIwlP9qyFkdYX1j9KxgIK41Kyflgz+9gyLNkulGs61KQSVh+wBv
 zOM2kdw0NTeFOCRtSckmceNXC14/m6UG96lyfwB6WRrX051Hu36n3V9HU4OHOlr7Awd62/
 WhjVYNvbOs4i/Yh5y+jEkqx8xa6YfbMBJt7ZP1A9ESI+WZZAwxrE0r54YRYpDg==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 13 May 2026 11:07:03 +0200
Message-ID: <20260513090703.700837-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wN5Yl-0003LH-Uf
Subject: [Openvpn-devel] [PATCH ovpn net-next] ovpn: drop useless NULL
 checks in ovpn_decrypt/encrypt_post()
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
Cc: Antonio Quartulli <antonio@openvpn.net>, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>

`peer` and `ks` are assumed to be non-NULL throughtout the whole
ovpn_decrypt/encrypt_post(), therefore it doesn't make sense
to perform a NULL check before dropping their reference.

Remove the checks and simplify the code.

Caught by Smatch-CI.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 3e6c06b9a5ae..762a8f31acfa 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -198,10 +198,8 @@ void ovpn_decrypt_post(void *data, int ret)
 		dev_dstats_rx_dropped(peer->ovpn->dev);
 	kfree_skb(skb);
 drop_nocount:
-	if (likely(peer))
-		ovpn_peer_put(peer);
-	if (likely(ks))
-		ovpn_crypto_key_slot_put(ks);
+	ovpn_peer_put(peer);
+	ovpn_crypto_key_slot_put(ks);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -296,10 +294,8 @@ void ovpn_encrypt_post(void *data, int ret)
 err:
 	if (unlikely(skb))
 		dev_dstats_tx_dropped(peer->ovpn->dev);
-	if (likely(peer))
-		ovpn_peer_put(peer);
-	if (likely(ks))
-		ovpn_crypto_key_slot_put(ks);
+	ovpn_peer_put(peer);
+	ovpn_crypto_key_slot_put(ks);
 	kfree_skb(skb);
 }
 
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
