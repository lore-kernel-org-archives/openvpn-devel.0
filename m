Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA20C43602
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4kSnmDCLOQt/zZqzatHcgV5fBoi13OyZVJO/0W1JyE=; b=lQ2M1LSwuDMc7GW0Jp9hyQeOur
	Mj9rfOJx42sK/2JBpUxkM24gHtf3w6rRv2Y6dHX4oxaoQ4PoKXbsft3bunEALvmiEf9Qbk/ZNYKMI
	MExuNXdHwFu3vuNjBdY0AW2bLTzx9Hd3gqQeGTZvxlHYY8BvpEIFy4SosL+QRyMEykvE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wghat-0001KK-9K;
	Mon, 06 Jul 2026 11:34:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wghar-0001KB-Ak
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYkAXVlwWnFwk4Pg9jQnNOpzSSm0BPWUf0P489QL93U=; b=DYtuZoYqS1HAxxForlKlpQZqiM
 r8hWgxhQiY1BgP4XZocNdQRslBuVDH0tx9N9Yn+oAzpa5+T43ojkhxIFsp2D6hoIGujrZ5ZEd2uAr
 YI3YgsjP5YHB21uLpKFry9VGbNolIe/o7AOSovqWWVmgmeEclEgHOfU7CEd3OStJozwc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vYkAXVlwWnFwk4Pg9jQnNOpzSSm0BPWUf0P489QL93U=; b=Zxg+ygn0GSjxQMkBzL0hNA/ixV
 h8CbTFpZ396fXogw2sPfpvBL0n+gXXBiOLKQGIFZnSBbl9Wen5Yh1mfIgPC7XiP8s1Hiu/TIFTQ7o
 koiYsXR/M3ENoSrM9SpP/j6+mZCtD9x+Im5LEFA8rR97AeubtLpCeBd2OmzgYygd6VOw=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wghap-0006lM-UI for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:34 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gv2Ly6gJ0zB1Ct;
 Mon,  6 Jul 2026 13:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783337658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYkAXVlwWnFwk4Pg9jQnNOpzSSm0BPWUf0P489QL93U=;
 b=LqewURx9g7iTWrNBQxeI4cZSRrZ84ShgpQzuRZ6XcCg49pcNq1TY/jfvid9/n98pZgalQx
 3WE7hHWOyTFYRLomgJTSziQIStp2rrUIV0bonli7ikyH+ov84Uuisn7p0chJnxPBowW9zW
 apmRQy6egqumMqnekGReLOCNPS8xUukqDjazDpjFRrDw43GTSKvWvbt199Qg2GcSbuW58r
 VP0OxXlq0N7MbIzGjq4ELIiBPWb8NzuMBn8xqWBhJFiAOIboZ5iU6Na/nN5Q4fekBewixD
 iH33SeJ4YGOvatG12lqNJ9js1/0HubEKJflP9NKQCbERevXOiYCrCc8FBwql5A==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  6 Jul 2026 13:33:59 +0200
Message-ID: <b2f5120a3efa20c62a83397d96e949eac6a983df.1783336121.git.ralf@mandelbit.com>
In-Reply-To: <cover.1783336121.git.ralf@mandelbit.com>
References: <cover.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wghap-0006lM-UI
Subject: [Openvpn-devel] [PATCH ovpn net v5 1/6] ovpn: fix NULL dereference
 when killing missing key
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

ovpn_crypto_kill_key assumes both crypto slots are populated and
dereferences each slot before checking it. That is not guaranteed: a
peer can have only one installed key, and the kill path may be asked to
remove a key that is not present.

Read each slot once while holding the crypto state lock, check for NULL
before looking at key_id, and only replace the slot that actually
matches.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v4 of this series https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/
- Add this previously posted standalone fix to the series so the whole
  set can be picked in order.
- No changes since v2 of the original single patch
  https://lore.kernel.org/openvpn-devel/19318904cf077d067cd4ec628a22bab03ed7dd29.1782993857.git.ralf@mandelbit.com/

Changes since v1 of the original single patch https://lore.kernel.org/openvpn-devel/9fc33e6f9fae10b9e372a3e06934d697edf5b024.1782829171.git.ralf@mandelbit.com/
- Remove unnecessary braces around single-statement if/else branches.

 drivers/net/ovpn/crypto.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 90580e32052f..8cb7078a1d93 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -58,15 +58,19 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
 {
 	struct ovpn_crypto_key_slot *ks = NULL;
+	struct ovpn_crypto_key_slot *tmp;
 
 	spin_lock_bh(&cs->lock);
-	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
+	tmp = rcu_access_pointer(cs->slots[0]);
+	if (tmp && tmp->key_id == key_id)
 		ks = rcu_replace_pointer(cs->slots[0], NULL,
 					 lockdep_is_held(&cs->lock));
-	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
+	else
+		tmp = rcu_access_pointer(cs->slots[1]);
+
+	if (!ks && tmp && tmp->key_id == key_id)
 		ks = rcu_replace_pointer(cs->slots[1], NULL,
 					 lockdep_is_held(&cs->lock));
-	}
 	spin_unlock_bh(&cs->lock);
 
 	if (ks)
-- 
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
