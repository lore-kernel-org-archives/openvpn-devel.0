Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE3DCA600D
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dzenoAMTfVLmfU7uGFnDXZOb6YEwJpX55r0vum/VPgo=; b=PFB+so8RHHWUFdkKjo5N3IyMPf
	lzQfSL7PyYBgFX+sN0psK02fK49YUPnS6SNK70lNaZm1snjwbPuOJsoGCBrL3JxdOKWjjfvDQt0XZ
	g8N0Gj4AZ+c7jw7GARK6O43/uC4BTJ/FScFgN/f+gOK+oMvPF0Y4e0+XKUi3CCiD3ptU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEosh-0007A9-U3;
	Thu, 08 Oct 2026 14:14:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1xEosg-00079s-4t
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:13:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Su5pKGYdTEh9/N0zpQh3v1tL+dLKiYuRypVHj9nmYyg=; b=XkXJ8R5MfnG4POfb/6eVP9jc8A
 vd/YRtAHduQgrHUlDJ0ugfPxgZytoFnCt8p6Bi+xLYrrEr1s/T6rLMeJplCZ/37efe5+q5VITftIh
 HSK229qUatqg9TV1zjizh1KoGeWbsXwZdBhnyKUmiDUjXwZ/f7nl86n5KOyA6wp3EYr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Su5pKGYdTEh9/N0zpQh3v1tL+dLKiYuRypVHj9nmYyg=; b=Ngg3cK2WmLUe24BPBDNVqsEFA7
 w0wEo65LlaKgM3K/+IUUJauacCLMbO+AU2yXHf7KB0bDo0PZw9zcN3/AfrEeoTaO8FISBmN3lW0+I
 zi0DjpYb3Ro5daayzSwnqqS5WDz65bvhvXOV63jridNlnUqIgTVuWDw7IC1mMRyZkdn8=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEosf-0003eI-8s for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:13:58 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4j0sRd3Dy7zNlZg;
 Thu, 08 Oct 2026 16:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1791468829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Su5pKGYdTEh9/N0zpQh3v1tL+dLKiYuRypVHj9nmYyg=;
 b=r4ScCgrw+fV0p2PqDerJrKvijihk2mUxlYnDFgaJOHXQD8RG1iPHQ+AlgMXiPsr5uhOySG
 nZURNpAhsF315vxpNAQZJombPetSpq5n5nBj7V+vrAqO8xI1VPi/PjRYxszC4/BskKBxzH
 plN8r8xOWM7EZ/Qi6s2B0hGxW583CKRiicW89Gg92mZjbStjEUMbR3ZcX8pcxmivvX09Hs
 U5l+WXKfaFgKoz0uvDZFNiVAGbxw7gm3498xle0Y+WhbgIWNCm7qQx5Kkj26qwa6KOrbiX
 xoRVBQm9nmiX9slnSP6lVx8JgkgEcbd35N8z3T5Bo7Jf/5yMyE0fBqzH4IH+Ig==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  8 Oct 2026 16:13:42 +0200
Message-ID: <20261008141343.553249-3-marco@mandelbit.com>
In-Reply-To: <20261008141343.553249-1-marco@mandelbit.com>
References: <20261008141343.553249-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j0sRd3Dy7zNlZg
X-Headers-End: 1xEosf-0003eI-8s
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/3] ovpn: use percpu
 references for key slots
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

From: Ralf Lici <ralf@mandelbit.com>

Packet processing holds a key slot until asynchronous crypto completion.
Parallel traffic using one key consequently updates the same kref cache
line for every packet, even though key slots are normally long-lived.

Replace the key-slot kref with percpu_ref. Kill the initial reference
after atomically unpublishing a slot, while ordinary packet completions
only put their live references.

Key destruction needs process context to release the crypto transforms
and an RCU grace period for lockless configuration readers which do not
hold a key reference. With percpu_ref, the release callback may run from
the internal RCU callback which switches the reference to atomic mode.
Queueing rcu_work from there would create a nested callback which the
module cleanup rcu_barrier is not guaranteed to wait for.

Record the RCU state after unpublishing the slot and queue ordinary work
from the release callback instead. The worker conditionally waits for
the recorded grace period before freeing the key. This provides explicit
RCU synchronization without depending on percpu_ref implementation
details or unconditionally starting another grace period.

Peer teardown kills its keys before dropping the final netdevice
reference, so rtnl_link_unregister cannot return before the key
percpu-ref callbacks have been registered. The existing rcu_barrier
drains those callbacks and destroy_workqueue subsequently drains the
ordinary key cleanup work.

Initialize the reference only after the rest of the key slot is ready,
allowing the existing destruction path to handle allocation failure.

The conversion adds an 8-byte counter per possible CPU and a 56-byte
control allocation for each installed key slot; with at most two
long-lived slots per peer, this is a bounded memory tradeoff for
removing the shared reference cacheline from the packet path.

After the peer conversion, perf c2c still identified the key-slot kref
cacheline, with 15 sampled HITM loads attributed to its locked reference
update. This change removed that line from the shared-cacheline profile
as well. In a set of interleaved 32-flow iperf3 runs, the combined peer
and key conversion moved throughput to 8.812 Gbit/s, against 7.734
Gbit/s for the baseline, a +13.95% improvement. Single-stream control
found no reproducible regression.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.c      | 16 ++++++++--------
 drivers/net/ovpn/crypto.h      | 27 ++++++++++++++++++++++-----
 drivers/net/ovpn/crypto_aead.c | 17 +++++++++++++----
 3 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 7e545428900a9..25c3a2b6da481 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -18,12 +18,12 @@
 #include "crypto_aead.h"
 #include "crypto.h"
 
-void ovpn_crypto_key_slot_release(struct kref *kref)
+void ovpn_crypto_key_slot_release(struct percpu_ref *ref)
 {
 	struct ovpn_crypto_key_slot *ks;
 
-	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
-	queue_rcu_work(ovpn_wq, &ks->free_work);
+	ks = container_of(ref, struct ovpn_crypto_key_slot, refcount);
+	queue_work(ovpn_wq, &ks->free_work);
 }
 
 /* can only be invoked when all peer references have been dropped (i.e. RCU
@@ -36,13 +36,13 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 	ks = rcu_access_pointer(cs->slots[0]);
 	if (ks) {
 		RCU_INIT_POINTER(cs->slots[0], NULL);
-		ovpn_crypto_key_slot_put(ks);
+		ovpn_crypto_key_slot_kill(ks);
 	}
 
 	ks = rcu_access_pointer(cs->slots[1]);
 	if (ks) {
 		RCU_INIT_POINTER(cs->slots[1], NULL);
-		ovpn_crypto_key_slot_put(ks);
+		ovpn_crypto_key_slot_kill(ks);
 	}
 }
 
@@ -66,7 +66,7 @@ bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
 	spin_unlock_bh(&cs->lock);
 
 	if (ks)
-		ovpn_crypto_key_slot_put(ks);
+		ovpn_crypto_key_slot_kill(ks);
 
 	/* let the caller know if a key was actually killed */
 	return ks;
@@ -104,7 +104,7 @@ int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
 	spin_unlock_bh(&cs->lock);
 
 	if (old)
-		ovpn_crypto_key_slot_put(old);
+		ovpn_crypto_key_slot_kill(old);
 
 	return 0;
 }
@@ -141,7 +141,7 @@ void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
 	}
 
 	pr_debug("deleting key slot %u, key_id=%u\n", slot, ks->key_id);
-	ovpn_crypto_key_slot_put(ks);
+	ovpn_crypto_key_slot_kill(ks);
 }
 
 void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index e3feb16d54985..a0209b1280de4 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/percpu-refcount.h>
+#include <linux/rcupdate.h>
 #include <linux/workqueue.h>
 
 #include "pktid.h"
@@ -47,8 +49,9 @@ struct ovpn_crypto_key_slot {
 
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
-	struct rcu_work free_work;
-	struct kref refcount;
+	struct work_struct free_work;
+	unsigned long rcu_state;
+	struct percpu_ref refcount;
 };
 
 struct ovpn_crypto_state {
@@ -61,7 +64,7 @@ struct ovpn_crypto_state {
 
 static inline bool ovpn_crypto_key_slot_hold(struct ovpn_crypto_key_slot *ks)
 {
-	return kref_get_unless_zero(&ks->refcount);
+	return percpu_ref_tryget_live_rcu(&ks->refcount);
 }
 
 static inline void ovpn_crypto_state_init(struct ovpn_crypto_state *cs)
@@ -121,11 +124,25 @@ ovpn_crypto_key_slot_primary(const struct ovpn_crypto_state *cs)
 	return ks;
 }
 
-void ovpn_crypto_key_slot_release(struct kref *kref);
+void ovpn_crypto_key_slot_release(struct percpu_ref *ref);
 
 static inline void ovpn_crypto_key_slot_put(struct ovpn_crypto_key_slot *ks)
 {
-	kref_put(&ks->refcount, ovpn_crypto_key_slot_release);
+	percpu_ref_put(&ks->refcount);
+}
+
+/**
+ * ovpn_crypto_key_slot_kill - stop new users and drop the initial reference
+ * @ks: key slot which has already been unpublished
+ *
+ * percpu_ref does not guarantee an RCU grace period before release. Record
+ * the RCU state after unpublishing the key so the final worker can synchronize
+ * with lockless readers without unconditionally starting another grace period.
+ */
+static inline void ovpn_crypto_key_slot_kill(struct ovpn_crypto_key_slot *ks)
+{
+	ks->rcu_state = get_state_synchronize_rcu();
+	percpu_ref_kill(&ks->refcount);
 }
 
 int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 74eaf6fac2f52..77ae958a971a5 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -391,8 +391,13 @@ static void ovpn_aead_crypto_key_slot_free_work(struct work_struct *work)
 {
 	struct ovpn_crypto_key_slot *ks;
 
-	ks = container_of(to_rcu_work(work), struct ovpn_crypto_key_slot,
-			  free_work);
+	ks = container_of(work, struct ovpn_crypto_key_slot, free_work);
+	/* Reaching this worker means every reference held by packet processing
+	 * and asynchronous crypto has been returned. Separately wait for any
+	 * RCU-only reader which observed the slot before it was unpublished.
+	 */
+	cond_synchronize_rcu(ks->rcu_state);
+	percpu_ref_exit(&ks->refcount);
 	ovpn_aead_crypto_key_slot_free(ks);
 	kfree(ks);
 }
@@ -427,8 +432,7 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 
 	ks->encrypt = NULL;
 	ks->decrypt = NULL;
-	INIT_RCU_WORK(&ks->free_work, ovpn_aead_crypto_key_slot_free_work);
-	kref_init(&ks->refcount);
+	INIT_WORK(&ks->free_work, ovpn_aead_crypto_key_slot_free_work);
 	ks->key_id = kc->key_id;
 
 	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
@@ -458,6 +462,11 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ovpn_pktid_xmit_init(&ks->pid_xmit);
 	ovpn_pktid_recv_init(&ks->pid_recv);
 
+	ret = percpu_ref_init(&ks->refcount, ovpn_crypto_key_slot_release, 0,
+			      GFP_KERNEL);
+	if (ret < 0)
+		goto destroy_ks;
+
 	return ks;
 
 destroy_ks:
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
