Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624C7C44500
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQplJI1sf7eOxIIUZ2THEuBemxIvY8ma6uPLuw6HfKo=; b=Jl6bF6+ztw9ucI/3eEyN8qxJIU
	5aWAyDKV34CpvxqycReAF78w3Ke8gt06YQDaz3unbAGXfZb+StLwlbkVOVDGdRHpglKvQ0Ebkr2/a
	jGq7asL7xGxvC8Cz0Vj2QLAMBYfQ8rHrKAcmg2UFs/zqgo2rZbh+7P+ilnkg+gvgTqrg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfcou-0005Xl-0R;
	Fri, 03 Jul 2026 12:16:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfcos-0005Xd-1C
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 12:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6LpY93VaxjXbodNdQ5fkiPzcsvsYdbLJBR/tpniFzew=; b=Ts+6maPBUhvV66wD3twXRtY9Wv
 JtW8uCdHR57/gDxznvrrqweTHczVP3rN7KfK8J9b0VFeuqWRGNaA9C0usl3joBhM8cXVEHJCX7jtH
 Jz4XNctb5G7Db4Nkb0Ve0GNeo9a29yYZp7TE+0As+qg1gDiI8kC1wgsRU0NPHEIZveHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6LpY93VaxjXbodNdQ5fkiPzcsvsYdbLJBR/tpniFzew=; b=Cqhw6bD9c2qFqQqCsPgxTlQK3n
 54MJjNlXDwKEqRXT9uPTIJaoOh8TcGdRTjROaHlMc0kxZWRqLhabyXfc6GHneMcep17IGe25ArhDj
 P/LzpPqrzhejsGfa/Y0JsERnWWKNEybf2NC6iHX93dGX4q3F6MrKmTxQl/ehtxw1DAT8=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfcom-0006yl-5s for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 12:16:31 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gsCQl1FlnzDsDV;
 Fri,  3 Jul 2026 14:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783080975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LpY93VaxjXbodNdQ5fkiPzcsvsYdbLJBR/tpniFzew=;
 b=LuuUpVArNYbcDcAJEPgZbvXTmfTSGRQaSKPPQj2XmBK5Na81H6YUNS4ysXY2kkxpq2fkZW
 a0Emxyiyr0hVA3oJ83iYAbnoxuzqA4Aw1pl9yIeu3AciOwc1YgIwIWVuwhPP/Ud3qzzSb1
 8sdOSOBTiD+3vOLC5QXq5GO//IRLlt1Qi/pk31AmNWvNZ3AwnWSYnEodSPifh1NOajt7SL
 68gxgPLbgfNInA7ymJKZyRpkUjgbW0TNV59a9oggZw3cV6tuV22RMMrX8c8m6ejffBoY+G
 quCE7SoPt5wPNzcN099xbQHypz2zMETrljVRcdSEsYWBw6uxlWlNc/srdzhjkw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  3 Jul 2026 14:15:57 +0200
Message-ID: <ac2842c8e759849c51447126343376dcc793c7ae.1783080055.git.ralf@mandelbit.com>
In-Reply-To: <f367b736f2597edb1677794173997d5a0f9f599c.1783080055.git.ralf@mandelbit.com>
References: <f367b736f2597edb1677794173997d5a0f9f599c.1783080055.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wfcom-0006yl-5s
Subject: [Openvpn-devel] [PATCH ovpn net v3 3/3] ovpn: defer key slot crypto
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

ovpn_crypto_key_slot_release currently schedules an RCU callback to
destroy the key slot. That callback calls into AEAD teardown and frees
the crypto transforms.

RCU callbacks run in atomic context, but crypto transform teardown is
not guaranteed to be atomic-safe. Some AEAD driver exit paths may wait
for hardware or take sleepable locks, so calling them from the RCU
callback can trigger sleeping-in-atomic bugs.

Queue key slot destruction on an ovpn-owned workqueue when the slot
refcount reaches zero. A system workqueue would not be drained by ovpn
module exit, so use a module-owned workqueue that is destroyed before
the final rcu_barrier.

This relies on the previous crypto-completion fix: callbacks now queue
key-slot release before dropping the peer reference that can unblock
module teardown.

ovpn_crypto_config_get was the only lockless path that queried the
transform without holding the slot. Take a temporary slot reference
there before reading the algorithm, preserving the invariant that AEAD
transforms are only reachable by key-slot kref holders.

Bypassing call_rcu for crypto teardown is safe because the AEAD
transforms are only used by key-slot kref holders. Once the kref
reaches zero, no transform user remains. The slot memory still needs
RCU protection because lockless readers may have observed the slot
before they failed to acquire the kref, so the worker releases the
transforms from process context and then frees the slot with kfree_rcu.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v2 https://lore.kernel.org/openvpn-devel/b5dfebec718f230783ff47aa354c3b3fa1aa2ed7.1783068961.git.ralf@mandelbit.com/
- Reword the message to note the dependency on patch 1.

Changes since v1 https://lore.kernel.org/openvpn-devel/350f6b48c363dde5a8d0bdf7a1b9fd2abb8b1034.1783057762.git.ralf@mandelbit.com/
- Fix a potential AEAD transform UAF in ovpn_crypto_config_get by
  holding a slot kref while reading the cipher algorithm.

 drivers/net/ovpn/crypto.c      | 25 ++++++++++++++++++-------
 drivers/net/ovpn/crypto.h      |  7 +++++++
 drivers/net/ovpn/crypto_aead.c | 20 ++++++++++++++------
 drivers/net/ovpn/crypto_aead.h |  1 -
 drivers/net/ovpn/main.c        | 15 +++++++++++++--
 5 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 8cb7078a1d93..3147d01e87c4 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/ovpn.h>
 
 #include "ovpnpriv.h"
@@ -18,12 +19,21 @@
 #include "crypto_aead.h"
 #include "crypto.h"
 
-static void ovpn_ks_destroy_rcu(struct rcu_head *head)
+static struct workqueue_struct *ovpn_wq;
+
+int ovpn_crypto_workqueue_init(void)
 {
-	struct ovpn_crypto_key_slot *ks;
+	ovpn_wq = alloc_workqueue("ovpn", 0, 0);
+	if (!ovpn_wq)
+		return -ENOMEM;
+
+	return 0;
+}
 
-	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
-	ovpn_aead_crypto_key_slot_destroy(ks);
+void ovpn_crypto_workqueue_destroy(void)
+{
+	destroy_workqueue(ovpn_wq);
+	ovpn_wq = NULL;
 }
 
 void ovpn_crypto_key_slot_release(struct kref *kref)
@@ -31,7 +41,7 @@ void ovpn_crypto_key_slot_release(struct kref *kref)
 	struct ovpn_crypto_key_slot *ks;
 
 	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
-	call_rcu(&ks->rcu, ovpn_ks_destroy_rcu);
+	queue_work(ovpn_wq, &ks->free_work);
 }
 
 /* can only be invoked when all peer references have been dropped (i.e. RCU
@@ -201,14 +211,15 @@ int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
 
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
index 0e284fec3a75..249d7e4de130 100644
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
@@ -121,6 +124,10 @@ ovpn_crypto_key_slot_primary(const struct ovpn_crypto_state *cs)
 
 void ovpn_crypto_key_slot_release(struct kref *kref);
 
+int ovpn_crypto_workqueue_init(void);
+
+void ovpn_crypto_workqueue_destroy(void);
+
 static inline void ovpn_crypto_key_slot_put(struct ovpn_crypto_key_slot *ks)
 {
 	kref_put(&ks->refcount, ovpn_crypto_key_slot_release);
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
 
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..10f61377bd54 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -18,6 +18,7 @@
 #include <uapi/linux/if_arp.h>
 
 #include "ovpnpriv.h"
+#include "crypto.h"
 #include "main.h"
 #include "netlink.h"
 #include "io.h"
@@ -233,13 +234,20 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err;
 
+	err = ovpn_crypto_workqueue_init();
 	if (err) {
-		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		pr_err("ovpn: can't allocate workqueue: %d\n", err);
 		return err;
 	}
 
+	err = rtnl_link_register(&ovpn_link_ops);
+	if (err) {
+		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		goto destroy_wq;
+	}
+
 	err = ovpn_nl_register();
 	if (err) {
 		pr_err("ovpn: can't register netlink family: %d\n", err);
@@ -252,6 +260,8 @@ static int __init ovpn_init(void)
 
 unreg_rtnl:
 	rtnl_link_unregister(&ovpn_link_ops);
+destroy_wq:
+	ovpn_crypto_workqueue_destroy();
 	return err;
 }
 
@@ -259,6 +269,7 @@ static __exit void ovpn_cleanup(void)
 {
 	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
+	ovpn_crypto_workqueue_destroy();
 
 	rcu_barrier();
 }
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
