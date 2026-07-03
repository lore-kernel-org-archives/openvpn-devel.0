Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D74C43458
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LKwHAwHtmvsCye6DR/czDK1wKfzOpyqDyTZqMZV8ORQ=; b=ASm5o38cqMOL4dcdBW1yKS39E6
	rx5abeDZ0oBN8f6eOo5LCgaG2cXChRq4eb/ZsQgRgmaSC2QbTG/pKs+cUJiC2m414bh39VdC6l4sX
	AmDu7jdHesMtYjjEaH8v6nqbDPnjRGvvFUBOLLyxsIqwI881elcCJGRpyxmOOsHhTUEM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfhnd-0001yw-Nz;
	Fri, 03 Jul 2026 17:35:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfhnb-0001yl-PH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 17:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SXbWfecXPFHVGMvXgqIb/ZHORrJiGaLCkiYspXYormc=; b=Y1zXr0DAjhBOLl/cz0weENh2/F
 Ncmfl96B1Y9qXQBIBYgHjdsrEp3IqoAxiHlz176sP90MBitSBaCSD5B1p5KioZ3NeUL1CQGskV7+w
 M8VdvppSSAnaPFblrWFPHiuqQ1e0GdnUev+i5tiwMX8dCtO+DO1RMC5JUcvJyak9VJ70=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SXbWfecXPFHVGMvXgqIb/ZHORrJiGaLCkiYspXYormc=; b=hukpvvMfA1bKp4ruXJGJsZrByo
 Fa4TQVOtvhJE3bYpmph+PQTOTFrDf0i4VNiQVOG9qgICr89J1/3cTU02/2cNkiF0W5I28Vnhjbzlm
 RUblX9FxaSa2BGEvt7ObdtpKtqAw5bxxkGUDplA7yc9IEKdIk8KyQb51+3q7wjI5davc=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfhnW-00072g-HF for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 17:35:31 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gsLVq70BXzDx6b;
 Fri,  3 Jul 2026 19:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783100116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SXbWfecXPFHVGMvXgqIb/ZHORrJiGaLCkiYspXYormc=;
 b=IAoPUpEpTN9m85qs2CXRNgW4EWaMrqTA1xZUc9z9vcba9MucZsqvNGRjXmQV6mgnKy6wJv
 9q6uGCL148G8mPg/if08lMJYpUAUP/J0vLahhcZx+bhPuvXbafp3sp2JnmbD6ZC9d7bIoZ
 D+iqImdIJm9EJ6EBcJEZ5RcXrvVeJQtHnHq8ssiQB+X+FEng9iZyUq0qHS2Z+Tfzq7RZBh
 aGr/Yu7D3xnGtdIDzpT1Mu4tKp8phUE0Gr+ct2t/CfMmv99UZEWkb6TGRmUS+Boybkq80o
 W4RHLEfZIGJnK6b4XjOseFXhx8DmK5dUQnRFTMO6iAGZHWAC7sUEQLPMzym6Cg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  3 Jul 2026 19:35:01 +0200
Message-ID: <b53ae1a9714bae7081c71bdab7b30623ce3cb77b.1783099626.git.ralf@mandelbit.com>
In-Reply-To: <981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com>
References: <981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gsLVq70BXzDx6b
X-Headers-End: 1wfhnW-00072g-HF
Subject: [Openvpn-devel] [PATCH ovpn net v4 3/3] ovpn: defer key slot crypto
 freeing to workqueue
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

Key slots are released through a kref and the existing release path frees
the AEAD transforms from an RCU callback. That is not safe for all crypto
implementations: crypto_free_aead can sleep, for example when an async or
hardware implementation has teardown work to complete.

The AEAD transforms are only used while a key-slot reference is held, so
the final kref put is enough to prove that no transform user remains.
Queue the final crypto teardown on the ovpn workqueue, where sleeping is
allowed, and keep the slot memory itself RCU-freed after the transforms
have been released.

ovpn_crypto_config_get was the remaining lockless reader of transform
state through ovpn_aead_crypto_alg. Make it take a key-slot reference
before reading that state, so the transform lifetime is consistently tied
to key-slot references. The previous patch drains ovpn_wq during module
exit, so queued key-slot teardown work cannot outlive module text.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v3 https://lore.kernel.org/openvpn-devel/ac2842c8e759849c51447126343376dcc793c7ae.1783080055.git.ralf@mandelbit.com/
- Reuse the module-owned ovpn workqueue introduced by patch 2 instead
  of allocating a crypto-specific workqueue for key-slot teardown.

Changes since v2 https://lore.kernel.org/openvpn-devel/b5dfebec718f230783ff47aa354c3b3fa1aa2ed7.1783068961.git.ralf@mandelbit.com/
- Reword the message to note the dependency on patch 1.

Changes since v1 https://lore.kernel.org/openvpn-devel/350f6b48c363dde5a8d0bdf7a1b9fd2abb8b1034.1783057762.git.ralf@mandelbit.com/
- Fix a potential AEAD transform UAF in ovpn_crypto_config_get by
  holding a slot kref while reading the cipher algorithm.

 drivers/net/ovpn/crypto.c      | 15 ++++-----------
 drivers/net/ovpn/crypto.h      |  3 +++
 drivers/net/ovpn/crypto_aead.c | 20 ++++++++++++++------
 drivers/net/ovpn/crypto_aead.h |  1 -
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 8cb7078a1d93..63efbca64eab 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -18,20 +18,12 @@
 #include "crypto_aead.h"
 #include "crypto.h"
 
-static void ovpn_ks_destroy_rcu(struct rcu_head *head)
-{
-	struct ovpn_crypto_key_slot *ks;
-
-	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
-	ovpn_aead_crypto_key_slot_destroy(ks);
-}
-
 void ovpn_crypto_key_slot_release(struct kref *kref)
 {
 	struct ovpn_crypto_key_slot *ks;
 
 	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
-	call_rcu(&ks->rcu, ovpn_ks_destroy_rcu);
+	queue_work(ovpn_wq, &ks->free_work);
 }
 
 /* can only be invoked when all peer references have been dropped (i.e. RCU
@@ -201,14 +193,15 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 
 	rcu_read_lock();
 	ks = rcu_dereference(cs->slots[idx]);
-	if (!ks) {
+	if (!ks || !ovpn_crypto_key_slot_hold(ks)) {
 		rcu_read_unlock();
 		return -ENOENT;
 	}
+	rcu_read_unlock();
 
 	keyconf->cipher_alg = ovpn_aead_crypto_alg(ks);
 	keyconf->key_id = ks->key_id;
-	rcu_read_unlock();
+	ovpn_crypto_key_slot_put(ks);
 
 	return 0;
 }
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 0e284fec3a75..85834bbd3ec9 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/workqueue_types.h>
+
 #include "pktid.h"
 #include "proto.h"
 
@@ -45,6 +47,7 @@ struct ovpn_crypto_key_slot {
 
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
+	struct work_struct free_work;
 	struct kref refcount;
 	struct rcu_head rcu;
 };
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 8f07c418622b..332975527734 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -9,6 +9,7 @@
 
 #include <crypto/aead.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
@@ -380,14 +381,19 @@ static struct crypto_aead *ovpn_aead_init(const char *title,
 	return ERR_PTR(ret);
 }
 
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
+static void ovpn_aead_crypto_key_slot_free(struct ovpn_crypto_key_slot *ks)
 {
-	if (!ks)
-		return;
-
 	crypto_free_aead(ks->encrypt);
 	crypto_free_aead(ks->decrypt);
-	kfree(ks);
+}
+
+static void ovpn_aead_crypto_key_slot_free_work(struct work_struct *work)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(work, struct ovpn_crypto_key_slot, free_work);
+	ovpn_aead_crypto_key_slot_free(ks);
+	kfree_rcu(ks, rcu);
 }
 
 struct ovpn_crypto_key_slot *
@@ -420,6 +426,7 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 
 	ks->encrypt = NULL;
 	ks->decrypt = NULL;
+	INIT_WORK(&ks->free_work, ovpn_aead_crypto_key_slot_free_work);
 	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
 
@@ -453,7 +460,8 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	return ks;
 
 destroy_ks:
-	ovpn_aead_crypto_key_slot_destroy(ks);
+	ovpn_aead_crypto_key_slot_free(ks);
+	kfree(ks);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 65a2ff307898..fae3b585a43b 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -22,7 +22,6 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 struct ovpn_crypto_key_slot *
 ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
 enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
 
-- 
2.54.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
