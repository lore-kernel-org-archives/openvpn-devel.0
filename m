Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F7BC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aSJw9TMOh7Dn0BQb00DEcBs0+IkgaWkki6WAsslygP0=; b=L1yA3eHmpQqkez+VI0UbiRYfmk
	McnhqqwVu8lcPDeOY8lGKWAEqEkiGzpe0EEXY6OEauyjFDGZfRT9HEkHnpCit+w1YAIXbz5fSTuDd
	VaQM//AwhSFdm7U/xqm+yQWSNkupBuy+9VDMOqVCr5Ky5K2p8MjLuC2EZDBYsnTJ2VxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfGDg-0001Ev-6C;
	Thu, 02 Jul 2026 12:08:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfGDe-0001Ee-50
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:08:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=It3nM7RQDts7Fzm8YE29DFlM1VLD3o4MHNbg1aMqFVU=; b=f5wFl4OgkVuNVHyxPUvmuUDcyY
 EYEpUTBRBthW+IhccbG0kUGtjFH6K7gObQt3JsDyxYCYPsx0XKKu0uHBiJbKqQ3v2VfE05JYAO4l3
 NMzgHjudDjWVzY9SniOdlpYDsHQQ7rPiF1JSjThFbEvLR6aYsutYW/JTjWDhmOLuJc8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=It3nM7RQDts7Fzm8YE29DFlM1VLD3o4MHNbg1aMqFVU=; b=m
 V6hjXoQnmlLoaSXR36jxpADIs4icOrPbuiwFl8i07KsB3hZ4duVObumWB4IYXdEnzdZx8136ss/8O
 7RoHxI38JKkvC38h1fGKb2AIUHgzrcqSCD/UD/YWnEx7dWkWvSQrf2POvbjivnPPS7rY4eOa6oloO
 /O5Y0LSWvSLTEqNk=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfGDc-0005Ee-SX for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:08:38 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4grbJ76MbtzDs65;
 Thu,  2 Jul 2026 14:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1782994103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=It3nM7RQDts7Fzm8YE29DFlM1VLD3o4MHNbg1aMqFVU=;
 b=U/LM6NholXrkCkHngsV0gfQiRoAuxOksIywYXG8Owt4fausFtT/ObC3yiAVDedTmZ4G7KU
 msEmUUGWrNk5zBON7k1S4ChXDyxbqZhhleZ+lteUsqsjqUiH3cxZF1k6Dkt6+MD85/fKNA
 LgnDoj+GRFkjkAnSzJAFP3mQU+n0ifcwTC57ZGWvgeJyFdvG1+sQmZY4ILikIP+mQrN0n1
 pImbAWNB0KcX+LCY5BDmYCpb3MBZ/Q5vYKe2W/9F4kIwtuV3RRwfzRAmlUTZeT/y4YKAiI
 /VkGC1ts4wh3H/QbBPwgW8spDUEVj+T/1WfR4ofOLlvRX/K3ScxnalVKwKF5HQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 14:08:11 +0200
Message-ID: <19318904cf077d067cd4ec628a22bab03ed7dd29.1782993857.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4grbJ76MbtzDs65
X-Headers-End: 1wfGDc-0005Ee-SX
Subject: [Openvpn-devel] [PATCH ovpn net v2] ovpn: fix NULL dereference when
 killing missing key
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
Changes since v1 https://lore.kernel.org/openvpn-devel/9fc33e6f9fae10b9e372a3e06934d697edf5b024.1782829171.git.ralf@mandelbit.com/
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

base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
-- 
2.54.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
