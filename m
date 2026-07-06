Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B4CC43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vr6rl+LmZ+soSQCg7Unh/yNByW2H+B4ZoO85aiLS1EU=; b=IrnTUcvHMBIqRXXnN1GDct3o8W
	5F+6I0bsdpytLW8QlJBIahYQpvvLRxnXcREiTtYFGu3CKN914lDNDTRivih50SDAhiALjuxIrk0Dl
	m96boo1ZmFmGzDcpl0X1kGloN4TPJt73mNPe1qoK1AStjE76CSgXa+IJqugqGng2MdHs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wghaz-0001LJ-Jb;
	Mon, 06 Jul 2026 11:34:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wghay-0001L1-3p
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ucNxD8Y6eCJDQRSMs8zMnGBa91Gx19CryChV9K9cIFg=; b=S8BdWFomEdHrg7T4XUhnvQ/hwt
 gb6OlxsiLlqiX9KpdVgu12viDAVmEEGS2KFF8HStfG2qnj+XHM+41xplUAPrUYmCzoLMcArMIRUWs
 RFnj2rYFvgccVy9HuQFCIYWHAO23Q6Kd0f47nYKzTylMQFnaFb1oETx8aCVF4ZpgWzmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ucNxD8Y6eCJDQRSMs8zMnGBa91Gx19CryChV9K9cIFg=; b=JVRv8SmrgJeDoUBxRpY1VZNQqV
 l26RHXnU3cY/YrRv90ShIAXerjc5NqbEQkGG5l6Dppo+Hg83eM452I4p/0p6p5k4CwmF84f3gB7a1
 eEXspD6xYv6JEkf+krUzSk2cbu8UONJoqB4tlp47aQ+JaVYiTCNsE1gAa/0DosWUMKOU=;
Received: from mout-b-206.mailbox.org ([195.10.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wghax-0006no-KP for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:40 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gv2M64zVDz9yFq;
 Mon,  6 Jul 2026 13:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783337666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucNxD8Y6eCJDQRSMs8zMnGBa91Gx19CryChV9K9cIFg=;
 b=bHI+6Ikdx8pxNxH3BghhyHGCBn9JOv9i3I0hWOtcQ/AlOzcT7+6GxZXqEXdGt9Xjh9xxh9
 rGMjMc0NyKu3pcEqKYPxtbGhCgy6uQiuluv6z50WOrggm9rJFH/El+O/HpPVY2wpI+gGE+
 aJiauAOidvo9HJKeyqczQJ+sm/z1RhsWmEcDFDyq8S2L6VP29w6neGgVFypOJPzWioe/py
 Z31zt0X2iB/bUQ9WphKmd9ToBpLkAgXC2O+fWa7Ah3Qp7RVUDoKPtHw+oJYNj23cqCX6mp
 rZnRTwlfg7yxwrgeoUTD8ro/9L14HEMYkPAlMNu2ydJfHX73FYL6HHPJCwxuLg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  6 Jul 2026 13:34:04 +0200
Message-ID: <5e4de5963ea48d7e7431e55192f0d6a5784c2a47.1783336121.git.ralf@mandelbit.com>
In-Reply-To: <cover.1783336121.git.ralf@mandelbit.com>
References: <cover.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gv2M64zVDz9yFq
X-Headers-End: 1wghax-0006no-KP
Subject: [Openvpn-devel] [PATCH ovpn net v5 6/6] ovpn: defer key slot crypto
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
No changes since v4 https://lore.kernel.org/openvpn-devel/b53ae1a9714bae7081c71bdab7b30623ce3cb77b.1783099626.git.ralf@mandelbit.com/

Changes since v3 https://lore.kernel.org/openvpn-devel/ac2842c8e759849c51447126343376dcc793c7ae.1783080055.git.ralf@mandelbit.com/
- Reuse the module-owned ovpn workqueue instead of allocating a
  crypto-specific workqueue for key-slot teardown.

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
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
