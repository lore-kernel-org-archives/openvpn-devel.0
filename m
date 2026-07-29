Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E533C54FD4
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=61ipKnQQAYvhUMxo2PFCwGxoR6f2W5CnPQsPuEvkTuM=; b=ed3rLNMqa1DSct9BZ+i7G6GAck
	PeqGm2fMZwypoYvQpFupo1rmU4tBknKVl/1TjeKXRXW0nHJe4GEcxpz0G7lFwvt3mO5W94zfqH1N0
	fSxgq4MRZwuEz3iH4k7bZqoRd4p0Ofg1AHy1WcN4xRrWQajbPfJw8kuSkGsAKUgo5nfA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp1Qc-0004Aj-2W;
	Wed, 29 Jul 2026 10:22:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp1QM-0004AM-3b
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9epp/RTDoFQYD1vdJo85EGEdQLGumxZFFX94OPVbfCw=; b=J5BTP+XP/dYoCTgOEChpGecm8Z
 0m7Oue5cKABthdpFPzIvlmIOi/6yKi4ChGrYqskSfAE/f+yCktW931BUFO5mAJavm3j+SAsYvBInm
 dBa7u6tWqpjLLH0QhLzMM6fzeMWk11wmTqgM52hxrf9pFujkx/UZxWYmvJfXj3zGH6v4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9epp/RTDoFQYD1vdJo85EGEdQLGumxZFFX94OPVbfCw=; b=lD+2Aauwg6Klr13cIGewfpIvfK
 dRrMac3cV8KmOliO3wGP9CgxWz9psOe2NZnBWj3pOAr+g1TUCgJms3OJZ/O8zBn8WPMY/DuJrCcyM
 ObcatqaHE/4p5xyzTm5saa/aWsQsiNOLmBT4UrIJ68enfQr8bzkTS80z9u+HJ9aGGaq4=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp1QK-0003UW-EI for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:06 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4h97fr07bdzNljs;
 Wed, 29 Jul 2026 12:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785320516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9epp/RTDoFQYD1vdJo85EGEdQLGumxZFFX94OPVbfCw=;
 b=wrIirvsrmPzJDe/0NfmjDj5LegbhkmUXeoPqwmwPMPuB/YFFYlvhqBttsyKoba7ZcLBlxt
 jGzHaLqPVgS78oh7d9l689aJ0hxJMq7TGuC3Jf7Ic6mXlQIdxCXDZ7VSuSqw9u3l7TXtf2
 P3F8OJn4w1VzK9nTka8XmGXs0VYuClOvBa4S4SLk5reWKBCI0txJATZgv3/+ztUmHq6O00
 3ZIIqzWytaXC4NpYxCiAGZDyUjZrSd/T1uieFzMuFFEA4eudlKFWyGj8n8AByvn7pwodHq
 oX+VmYvMDrETJiGVPRiHyksjTdNfXKwmDo4ACK7WedyGS9nOT4OASRp92drvZQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 12:21:41 +0200
Message-ID: <da59b0f39ad7eb59174bd1ffdc2b5ab5e2499e08.1785318038.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785318038.git.ralf@mandelbit.com>
References: <cover.1785318038.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h97fr07bdzNljs
X-Headers-End: 1wp1QK-0003UW-EI
Subject: [Openvpn-devel] [PATCH ovpn net v6 1/6] ovpn: fix NULL dereference
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
Changes since v5 https://lore.kernel.org/openvpn-devel/b2f5120a3efa20c62a83397d96e949eac6a983df.1783336121.git.ralf@mandelbit.com/
- Rework using the slot-based shape (Sabrina).

Changes since v4 of this series https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/
- Add this previously posted standalone fix to the series so the whole
  set can be picked in order.
- No changes since v2 of the original single patch
  https://lore.kernel.org/openvpn-devel/19318904cf077d067cd4ec628a22bab03ed7dd29.1782993857.git.ralf@mandelbit.com/

Changes since v1 of the original single patch https://lore.kernel.org/openvpn-devel/9fc33e6f9fae10b9e372a3e06934d697edf5b024.1782829171.git.ralf@mandelbit.com/
- Remove unnecessary braces around single-statement if/else branches.

 drivers/net/ovpn/crypto.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 90580e32052f..2e95f29514fc 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -58,15 +58,19 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
 {
 	struct ovpn_crypto_key_slot *ks = NULL;
+	struct ovpn_crypto_key_slot *tmp;
+	int slot = 0;
 
 	spin_lock_bh(&cs->lock);
-	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
-		ks = rcu_replace_pointer(cs->slots[0], NULL,
-					 lockdep_is_held(&cs->lock));
-	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
-		ks = rcu_replace_pointer(cs->slots[1], NULL,
-					 lockdep_is_held(&cs->lock));
+	tmp = rcu_access_pointer(cs->slots[slot]);
+	if (!tmp || tmp->key_id != key_id) {
+		slot = 1;
+		tmp = rcu_access_pointer(cs->slots[slot]);
 	}
+
+	if (tmp && tmp->key_id == key_id)
+		ks = rcu_replace_pointer(cs->slots[slot], NULL,
+					 lockdep_is_held(&cs->lock));
 	spin_unlock_bh(&cs->lock);
 
 	if (ks)
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
