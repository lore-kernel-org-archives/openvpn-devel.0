Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D879CC43458
	for <openvpn-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sWa2iUK1IFRK7rCYVAQDB/blgrVDh/4Q4rFvPKb3stI=; b=XWgxLyCZNwo+qqhIgh6sKY3TCp
	uOZnSPt1WW3o7NbB5z5tSkUMHpDZgQUzjJHssYaOxGJI2FmSaT32Hd3aVTLTc4F0Rrak5MdXtCEMU
	okAHalGqoh1IpqXsv5unBRkwXexbw0nZ7ae+FiHCq1kSiuSireyw4h7YZqJEaXeT7K5c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfXE0-000121-7w;
	Fri, 03 Jul 2026 06:18:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wfXDt-00011i-3K
 for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 06:18:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FlCVIKx0HVM6heU3cDOddlYKKOwaVRErxyxoRkxEO6s=; b=DzXzlOo80BW6OnseZCkeMwloX4
 asnm23F0dZkb0O3+KiSayEXKNsZethBz7pY6BU9/Uh2cPZ0MdFN/CrURWToVkO0Zo9jrasfUD442T
 W//oZiJV4lPHN/mDvV4nz5La+HX1/c9ml7JEzun67fdGWMsFlb02bXsKcuLegd+5dIk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FlCVIKx0HVM6heU3cDOddlYKKOwaVRErxyxoRkxEO6s=; b=B
 D0aOOPW3b8WT6W7NPkdXknSAHAmHUVmX8zvLdXP2nQNOzNRkjUcgDzQ/ZxlK7nfJ8bhfanFh/gYX+
 Fc768DrOcOJlGixwkrKy0vWs7xgVK7thl7Z+7B3dJSCl1iuVOCabMnLQpCR3KQcdLWOBZwlBDueVL
 liRrO527oP6YR5qE=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfXDp-0004fN-0C for openvpn-devel@lists.sourceforge.net;
 Fri, 03 Jul 2026 06:18:01 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4gs3T42qVszB1Ph;
 Fri,  3 Jul 2026 08:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783059464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FlCVIKx0HVM6heU3cDOddlYKKOwaVRErxyxoRkxEO6s=;
 b=NhrmTWbuBtcQauvblMa1H9wqf55oj6oyrmHiHUjN7UAjd/wxD26QhC3MEl8GZgHN1Q5YFR
 0koa8ouPM5TPOzsczMtTV3HIsxkuCASeDcqKQrWlAcFqWSmqK9eeR17TAl5NVFW+IfOaOZ
 dvZYL9sCP0LxtEnY1L5spfqOplUh+n1tJZKj1fzEERnYJGvGQ8B4zZmGGzSP5n5MtupVQm
 Tzpv/hgrjMkReI3rn+TyIMQNcL3/+Mca7L57yOY3kxKxJzFdVAu/QxqALeOx7w8yc9W3CZ
 HAtFvZf3ZtO+IKSbBsdOflQxaAzzHLo55ZnzTPU2OkH/X6qu/sF+ivq0kTY0tg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  3 Jul 2026 08:17:24 +0200
Message-ID: <350f6b48c363dde5a8d0bdf7a1b9fd2abb8b1034.1783057762.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gs3T42qVszB1Ph
X-Headers-End: 1wfXDp-0004fN-0C
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: defer key slot crypto
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

Bypassing call_rcu for crypto teardown is safe because the AEAD
transforms are only used by key-slot kref holders. Once the kref reaches
zero, no transform user remains. The slot memory still needs RCU
protection because lockless readers may have observed the slot before
they failed to acquire the kref, so the worker releases the transforms
from process context and then frees the slot with kfree_rcu.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/crypto.c      | 20 +++++++++++++++-----
 drivers/net/ovpn/crypto.h      |  7 +++++++
 drivers/net/ovpn/crypto_aead.c | 20 ++++++++++++++------
 drivers/net/ovpn/crypto_aead.h |  1 -
 drivers/net/ovpn/main.c        | 15 +++++++++++++--
 5 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 8cb7078a1d93..3db44c26a22b 100644
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
