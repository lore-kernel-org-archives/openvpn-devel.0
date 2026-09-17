Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1D7C982D6
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wJimdI5h6dPYH8fNvbnM9flCIEpiRu/LLTfU+WDhyI0=; b=IU+JzFx3zGnkM4iVXshf96jFqJ
	0fePhT2CU9QlvQZpjswvuAVi6fkFxEx6TFPgYKNiPQPaRSLmULiOyZY2M3aDqBr62KtG0AJ8a0PS+
	8JEgO7o26sVFevQ3rr/RHQS+g48OUjCGPOL9DRLfAT/Fh1sf4rDEltzldBsj2PGNZS30=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7E48-00015L-S2;
	Thu, 17 Sep 2026 15:30:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1x7E45-00015D-0G
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 15:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBdxZjtHts8nK9raX5QZTeLbt7Tda72d2ZPfgf4p59w=; b=RpA8KqDkejbWhyHiQ4RO2i3+/U
 vb10QTemctZiajCq+sYZTLnMQCN+nD0uwVlm35YixsOlcq0TYfeJ+ZdkEytJ+qs03ygUC82F7koe2
 jnJlSGthsvIa8lbde367LaKL7BdphXA/Wc0yHsMB7+ox5J1IuYvKfliD9E6h4XtMTO2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hBdxZjtHts8nK9raX5QZTeLbt7Tda72d2ZPfgf4p59w=; b=RBWe+Hc0GOHRtLzI2glYkQ7Tbc
 00fqQ/QowX67NsbJUXNgIms2hvdslp21sJTjR9PxNDKKMeE3LHkhDgbt4OBitQKuz2m3sYzVwZW6x
 9vka+Gz7h2LTTeShb2ce0lyOcrpBSmWkJdM7XDYyTZ2yeIjviPxvdtALP9KlINSIeOao=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7E43-0005Ym-Gr for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 15:30:20 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4hm07R4sj2z3yQs
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 17:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1789659011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBdxZjtHts8nK9raX5QZTeLbt7Tda72d2ZPfgf4p59w=;
 b=mKHAtGxedEPJXTHqbF9e8+SkFgdj9MJdfhWZbXpd8ZWcNRip9+Afx7nuLgX1el12eX0A8V
 JvYcs4v3phwpgtW7Z7Osea/EPvVtP8hE7GRRirZFMKLEx/fJoXeRib2yyG7pcQuuBMLAOW
 RMHDfqSmqr6oNf9LIvIK1UC+jRAbgSzAIH+T14PUtTHMstb1M8zU01W9nqVExKCEus/AjJ
 utDBvLwJe9XOErcHwk1OMJtDNoRKfwF54HcZqJnpjjJQ3k1XcpnUBq7KIpYmEpUEtsxzxj
 uRXC2PweqfXFiko60sOaXjYWSZjYY8rPxGgyhjhC7s4/yl0f9yvkAeIR/Y6ioQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 17 Sep 2026 17:29:56 +0200
Message-ID: <9551c9c842e4ac926089badc81f445becca513e5.1789658051.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789658051.git.ralf@mandelbit.com>
References: <cover.1789658051.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hm07R4sj2z3yQs
X-Headers-End: 1x7E43-0005Ym-Gr
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/2] ovpn: use percpu
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

Packet processing holds a key slot until asynchronous crypto completion.
Parallel traffic using one key consequently updates the same kref cache
line for every packet, even though key slots are normally long-lived.

Replace the key-slot kref with percpu_ref. Kill the initial reference
after atomically unpublishing a slot, while ordinary packet completions
only put their live references. The release callback retains the
existing rcu_work teardown so lockless readers receive an RCU grace
period and crypto transforms are freed from workqueue context. Release
the percpu_ref storage from that final worker.

Initialize the reference only after the rest of the key slot is ready,
allowing the existing destruction path to handle allocation failure.

After the peer conversion, perf c2c still identified the key-slot kref
cacheline, with 15 sampled HITM loads attributed to its locked reference
update. This change removed that line from the shared-cacheline profile
as well. In a set interleaved 32-flow iperf3 runs, the combined peer and
key conversion moved throughput to 8.812 Gbit/s, against 7.734 Gbit/s
for the baseline, a +13.95% improvement. Single-stream control found no
reproducible regression.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.c      | 14 +++++++-------
 drivers/net/ovpn/crypto.h      | 15 +++++++++++----
 drivers/net/ovpn/crypto_aead.c |  7 ++++++-
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 7e545428900a..23502aa125db 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -18,11 +18,11 @@
 #include "crypto_aead.h"
 #include "crypto.h"
 
-void ovpn_crypto_key_slot_release(struct kref *kref)
+void ovpn_crypto_key_slot_release(struct percpu_ref *ref)
 {
 	struct ovpn_crypto_key_slot *ks;
 
-	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
+	ks = container_of(ref, struct ovpn_crypto_key_slot, refcount);
 	queue_rcu_work(ovpn_wq, &ks->free_work);
 }
 
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
index e3feb16d5498..bd4056570d54 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/percpu-refcount.h>
 #include <linux/workqueue.h>
 
 #include "pktid.h"
@@ -48,7 +49,7 @@ struct ovpn_crypto_key_slot {
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
 	struct rcu_work free_work;
-	struct kref refcount;
+	struct percpu_ref refcount;
 };
 
 struct ovpn_crypto_state {
@@ -61,7 +62,7 @@ struct ovpn_crypto_state {
 
 static inline bool ovpn_crypto_key_slot_hold(struct ovpn_crypto_key_slot *ks)
 {
-	return kref_get_unless_zero(&ks->refcount);
+	return percpu_ref_tryget_live_rcu(&ks->refcount);
 }
 
 static inline void ovpn_crypto_state_init(struct ovpn_crypto_state *cs)
@@ -121,11 +122,17 @@ ovpn_crypto_key_slot_primary(const struct ovpn_crypto_state *cs)
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
+static inline void
+ovpn_crypto_key_slot_kill(struct ovpn_crypto_key_slot *ks)
+{
+	percpu_ref_kill(&ks->refcount);
 }
 
 int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 74eaf6fac2f5..414e5d7d32bf 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -393,6 +393,7 @@ static void ovpn_aead_crypto_key_slot_free_work(struct work_struct *work)
 
 	ks = container_of(to_rcu_work(work), struct ovpn_crypto_key_slot,
 			  free_work);
+	percpu_ref_exit(&ks->refcount);
 	ovpn_aead_crypto_key_slot_free(ks);
 	kfree(ks);
 }
@@ -428,7 +429,6 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	ks->encrypt = NULL;
 	ks->decrypt = NULL;
 	INIT_RCU_WORK(&ks->free_work, ovpn_aead_crypto_key_slot_free_work);
-	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
 
 	ks->encrypt = ovpn_aead_init("encrypt", alg_name,
@@ -458,6 +458,11 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
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
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
