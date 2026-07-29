Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F52C54FD1
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T5OtqUONyaKJsw/ZeyjIuO7djlmvLmzh4KZuWu2ilFY=; b=d5h2nelVQoMag0wZy7qUIssk2k
	0n8O0TN4ds2hnGpB7nSxQtIDVs7EBloLNRsZOLf9oAZCapV8j4B6D9qN8XDw9sQsKUSO2ApiP02AY
	jrOVALy0a5eTvRE533ybFPjZu6iKUXEUyAT5azLKhj4NKmLWSLzBXzOEVOBX82PubMxI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp1QY-00083W-PV;
	Wed, 29 Jul 2026 10:22:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp1QO-00083C-EW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BSrmGFLfmj1vxpGXTQtMWYMXzpjTnVrd2FUwOb2GXB0=; b=CGPG4LEM3nXFMtEAn641rYbnsP
 rjDL/F12OJ+Ada/0qx/jxwNrKj1MBHTajYabOPiK0BEdC0UQhDL4G1Q+RNfm2M4DQWTsnkHK57YLs
 yyLh7Gh+ZewwU9y8Rt6w6+nT1diKH1tnCk0h1LzLlkuVU5fGjaBvDWiQvf6/JPEK6NlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BSrmGFLfmj1vxpGXTQtMWYMXzpjTnVrd2FUwOb2GXB0=; b=CWa1+tuaFYp9aqqr2HrVOdWzas
 lTTi1OTSELJXnuR3J/02DppQx+vR5n1R0MSW2+/tSf7hKjljSMLfAJ20u8gS3xOtJIu6jPOQPD3al
 0FfoOyU1Kv9QYiSHbltdP/DcnmRljjcLcVNfi5M93nRpNU2N2ZwRpqTLmX2hYAHCY8GU=;
Received: from mout-b-105.mailbox.org ([195.10.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp1QR-0002fE-6Z for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 10:22:09 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4h97fv5LXJz9tbx;
 Wed, 29 Jul 2026 12:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785320519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSrmGFLfmj1vxpGXTQtMWYMXzpjTnVrd2FUwOb2GXB0=;
 b=DqN/JyP8NKGywg33IjW+6PciPl+I/nKNAoTDSrFR8tiVlr2vC6qHM/syZlSpf+x4BuFzD1
 KORLcX96thnZirOro4CpgrYOxdjSs6Td02u1mmTkQmP3FyQ3sMdbcPze7fw/RoYefK1Ez+
 KST8sz328wjG3vnE5pOb8SH9qIP1FzyD/dvCcbjjVua0IPleaMvv1yMKWyYTqi2ITJo8HE
 iVM+YomssC5VHWG01SslOWEoOWIcBYea9zaibB/n6MedA9lh2tKKT6TTgjHyWHymL9Pcb3
 Ux642MK+pOFDAreiLnNfe+NXQ5gzqEO4l71zSTUjafUATWiFILvvluM3GIti5Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 12:21:46 +0200
Message-ID: <99bd088e56302f9bd7cd565eb4208912e6fd26e7.1785318038.git.ralf@mandelbit.com>
In-Reply-To: <cover.1785318038.git.ralf@mandelbit.com>
References: <cover.1785318038.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h97fv5LXJz9tbx
X-Headers-End: 1wp1QR-0002fE-6Z
Subject: [Openvpn-devel] [PATCH ovpn net v6 6/6] ovpn: defer key slot crypto
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

Key slots are released through a kref and the existing release path
frees the AEAD transforms from an RCU callback. That is not safe for all
crypto implementations: crypto_free_aead can sleep, for example when an
async or hardware implementation has teardown work to complete.

Use queue_rcu_work for key-slot release. This keeps the RCU grace period
needed by lockless key-slot readers, but runs the actual crypto teardown
from workqueue context where sleeping is allowed. Once the rcu_work
callback runs, pre-existing RCU readers are gone, and the final kref put
already proves that no transform user remains, so the worker can release
the AEAD transforms and free the slot directly.

The previous patch drains ovpn_wq during module exit, so queued key-slot
teardown work cannot outlive module text.

Fixes: 8534731dbf2d ("ovpn: implement packet processing")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v5 https://lore.kernel.org/openvpn-devel/5e4de5963ea48d7e7431e55192f0d6a5784c2a47.1783336121.git.ralf@mandelbit.com/
- Use queue_rcu_work for key-slot release so RCU readers are preserved
  without adding a key-slot reference in ovpn_crypto_config_get
  (Sabrina).

No changes since v4 https://lore.kernel.org/openvpn-devel/b53ae1a9714bae7081c71bdab7b30623ce3cb77b.1783099626.git.ralf@mandelbit.com/

Changes since v3 https://lore.kernel.org/openvpn-devel/ac2842c8e759849c51447126343376dcc793c7ae.1783080055.git.ralf@mandelbit.com/
- Reuse the module-owned ovpn workqueue instead of allocating a
  crypto-specific workqueue for key-slot teardown.

Changes since v2 https://lore.kernel.org/openvpn-devel/b5dfebec718f230783ff47aa354c3b3fa1aa2ed7.1783068961.git.ralf@mandelbit.com/
- Reword the message to note the dependency on patch 1.

Changes since v1 https://lore.kernel.org/openvpn-devel/350f6b48c363dde5a8d0bdf7a1b9fd2abb8b1034.1783057762.git.ralf@mandelbit.com/
- Fix a potential AEAD transform UAF in ovpn_crypto_config_get by
  holding a slot kref while reading the cipher algorithm.

 drivers/net/ovpn/crypto.c      | 10 +---------
 drivers/net/ovpn/crypto.h      |  4 +++-
 drivers/net/ovpn/crypto_aead.c | 19 ++++++++++++++-----
 drivers/net/ovpn/crypto_aead.h |  1 -
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 2e95f29514fc..7e545428900a 100644
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
+	queue_rcu_work(ovpn_wq, &ks->free_work);
 }
 
 /* can only be invoked when all peer references have been dropped (i.e. RCU
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 0e284fec3a75..e3feb16d5498 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/workqueue.h>
+
 #include "pktid.h"
 #include "proto.h"
 
@@ -45,8 +47,8 @@ struct ovpn_crypto_key_slot {
 
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
+	struct rcu_work free_work;
 	struct kref refcount;
-	struct rcu_head rcu;
 };
 
 struct ovpn_crypto_state {
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 8f07c418622b..74eaf6fac2f5 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -9,6 +9,7 @@
 
 #include <crypto/aead.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
@@ -380,13 +381,19 @@ static struct crypto_aead *ovpn_aead_init(const char *title,
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
+}
+
+static void ovpn_aead_crypto_key_slot_free_work(struct work_struct *work)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(to_rcu_work(work), struct ovpn_crypto_key_slot,
+			  free_work);
+	ovpn_aead_crypto_key_slot_free(ks);
 	kfree(ks);
 }
 
@@ -420,6 +427,7 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 
 	ks->encrypt = NULL;
 	ks->decrypt = NULL;
+	INIT_RCU_WORK(&ks->free_work, ovpn_aead_crypto_key_slot_free_work);
 	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
 
@@ -453,7 +461,8 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
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
