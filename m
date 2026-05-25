Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9361CD5BD5
	for <openvpn-devel@archiver.kernel.org>; Mon, 25 May 2026 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1s0W5+KSDT8fh8DlDW/PDkMbvvigyXTsSDNp3IeXmQ4=; b=QpEyHlCaqzSO6mJIohNOVZZ6+u
	SKYiSA49RVx8E83/nEa6pNuCsdv8a6GPYtF4Auei9c8oxi5t+o4ZH+VIjvQGyW2IMyzO49q0bi6Uk
	xLab1ML1GqHX5GY9kH8CNnZnS7NV3hvt9M8kSqUchGhbg/RpGHd9cN97+Ji7GB3a0xm8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRWPu-0001Cc-LB;
	Mon, 25 May 2026 14:36:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wRWPt-0001C0-2y
 for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3RJEfaEDNJg6717gaUTwcgxYlg32mZHgUWqZMEtXJOw=; b=crxvxFLloHk7FNrg9AwPbSjF0U
 iiq/w12yAJAwbvBZZPQtMWgf0+GEh6LUMz9yUSemKfUEsRds0EPLrpp77lTSTSV9s9qdpZewZRmF4
 JQZBq63G+X9Yww+GyqwzzvIcIxo7glVmorub81wHaGaWK4vmLxODINgiijr6j2THwTTo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3RJEfaEDNJg6717gaUTwcgxYlg32mZHgUWqZMEtXJOw=; b=X6MlQ/lUYnaxju6ZC4Gxc+6KPV
 ogoys7N+BOSD5xFQTZamCIymf2PIy4+ex3eeks8h78rGwcRhDaJI6PrxjRM4d+pbybsEguBQ/lWYu
 1BIbLAWNMACZml9w78E8/pITQRd363mwa4+1wILImF/bIOOj/dYfOnfXIZWMWkJVmv74=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRWPm-0003pQ-8a for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:36:26 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gPJN96HxTz9t9S;
 Mon, 25 May 2026 16:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779719769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RJEfaEDNJg6717gaUTwcgxYlg32mZHgUWqZMEtXJOw=;
 b=GD5IwS7TlFnyudd9JW12QYSa4CTFKKgH8werKZ5E8ga4ovlVj+D79mGadOMHZhL4qyh2LM
 i1Th7/Fxr877hq4lDskYD9mTUghw/towGGWa62is5XySyFfBHeY6Y6wXdVkibUg+LrGTDg
 FVo/AiuWs+0E5JdMHSL8LqovFV38DHv2ZoJHQBJl/FjVcpUkEU+EUbH6H5DIdpR3LgoHp/
 z289lnBhdPgKJ/IlsLSPXP9KYDzRU+xSyMTol/pwZZ3+HyTynPuEt0mYjSt+dML3fDjt5t
 /OT0QLNdi9QCYlI0yt5uXmJzyixAhSzSKhav92hS6Ar0ZykAxfBkufOVSrreWg==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 25 May 2026 16:36:05 +0200
Message-ID: <20260525143606.1532168-3-a@unstable.cc>
In-Reply-To: <20260525143606.1532168-1-a@unstable.cc>
References: <20260525143606.1532168-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wRWPm-0003pQ-8a
Subject: [Openvpn-devel] [PATCH 3/4] ovpn: cap number of ovpn devices per
 netns
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>

The previous patches bound resource use within a single ovpn
interface, but a userns owner can still spin many MP-mode devices,
each costing ~128 KiB just for its peer hashtables.

Cap the number of ovpn netdevs per netns with a compile-time
constant (OVPN_MAX_DEVS, 256). The counter lives in a per-netns
struct registered via register_pernet_subsys() - the framework
zero-allocates and frees the storage, so no init/exit callbacks are
needed. ovpn_net_init() increments and rejects with -ENOSPC past
the cap; ovpn_net_uninit() decrements, keeping the counter balanced
across both ndo_init failure and normal teardown.

Also set dev->netns_immutable in ovpn_setup() to forbid moving an
ovpn device between netns. Without it, ndo_uninit would decrement
a different netns' counter than ndo_init incremented, eventually
wrapping the atomic_t and defeating the cap - a userns owner with
multiple child netns could trigger this on purpose.

A sysctl was rejected: net.* sysctls in a non-init netns are
writable by anyone with CAP_NET_ADMIN in that netns, i.e. the exact
actor this cap constrains. A compile-time constant cannot be raised
by an attacker; 256 is generous for any realistic deployment.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 71 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 425f4367f0ab..540ba89d81b7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -14,6 +14,8 @@
 #include <linux/inetdevice.h>
 #include <net/gro_cells.h>
 #include <net/ip.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
 #include <net/rtnetlink.h>
 #include <uapi/linux/if_arp.h>
 
@@ -26,6 +28,29 @@
 #include "tcp.h"
 #include "udp.h"
 
+/* Hard cap on number of ovpn netdevs per network namespace. Pairs with the
+ * per-MP-instance OVPN_MAX_PEERS cap to bound total kernel memory an
+ * unprivileged userns owner can pin via repeated `ip link add ... type ovpn`
+ * calls (each MP-mode device costs ~128 KiB just for its peer hashtables).
+ *
+ * This is a compile-time constant on purpose: a sysctl in net.* would be
+ * writable by anyone with CAP_NET_ADMIN in the namespace - i.e. exactly the
+ * unprivileged userns owner this cap is meant to constrain - which would
+ * defeat the defence. 256 is generous for any realistic deployment.
+ */
+#define OVPN_MAX_DEVS 256
+
+struct ovpn_net {
+	atomic_t n_devs;
+};
+
+static unsigned int ovpn_net_id __read_mostly;
+
+static struct pernet_operations ovpn_pernet_ops = {
+	.id	= &ovpn_net_id,
+	.size	= sizeof(struct ovpn_net),
+};
+
 static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
@@ -74,27 +99,40 @@ static int ovpn_mp_alloc(struct ovpn_priv *ovpn)
 static int ovpn_net_init(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
-	int err = gro_cells_init(&ovpn->gro_cells, dev);
+	struct ovpn_net *on = net_generic(dev_net(dev), ovpn_net_id);
+	int err;
+
+	if (atomic_fetch_inc(&on->n_devs) >= OVPN_MAX_DEVS) {
+		atomic_dec(&on->n_devs);
+		return -ENOSPC;
+	}
 
+	err = gro_cells_init(&ovpn->gro_cells, dev);
 	if (err < 0)
-		return err;
+		goto err_dec;
 
 	err = ovpn_mp_alloc(ovpn);
-	if (err < 0) {
-		gro_cells_destroy(&ovpn->gro_cells);
-		return err;
-	}
+	if (err < 0)
+		goto err_gro;
 
 	return 0;
+
+err_gro:
+	gro_cells_destroy(&ovpn->gro_cells);
+err_dec:
+	atomic_dec(&on->n_devs);
+	return err;
 }
 
 static void ovpn_net_uninit(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
+	struct ovpn_net *on = net_generic(dev_net(dev), ovpn_net_id);
 
 	disable_delayed_work_sync(&ovpn->keepalive_work);
 	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	gro_cells_destroy(&ovpn->gro_cells);
+	atomic_dec(&on->n_devs);
 }
 
 static const struct net_device_ops ovpn_netdev_ops = {
@@ -173,6 +211,14 @@ static void ovpn_setup(struct net_device *dev)
 	dev->needed_headroom = ALIGN(OVPN_HEAD_ROOM, 4);
 	dev->needed_tailroom = OVPN_MAX_PADDING;
 
+	/* forbid moving the device between network namespaces: ndo_init and
+	 * ndo_uninit are called in the originating and current netns
+	 * respectively, so a migrated device would dec a different netns'
+	 * n_devs counter than the one it incremented, eventually wrapping it
+	 * and defeating the per-netns cap.
+	 */
+	dev->netns_immutable = true;
+
 	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
 }
 
@@ -233,13 +279,19 @@ static struct rtnl_link_ops ovpn_link_ops = {
 
 static int __init ovpn_init(void)
 {
-	int err = rtnl_link_register(&ovpn_link_ops);
+	int err = register_pernet_subsys(&ovpn_pernet_ops);
 
 	if (err) {
-		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		pr_err("ovpn: can't register pernet ops: %d\n", err);
 		return err;
 	}
 
+	err = rtnl_link_register(&ovpn_link_ops);
+	if (err) {
+		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		goto unreg_pernet;
+	}
+
 	err = ovpn_nl_register();
 	if (err) {
 		pr_err("ovpn: can't register netlink family: %d\n", err);
@@ -252,6 +304,8 @@ static int __init ovpn_init(void)
 
 unreg_rtnl:
 	rtnl_link_unregister(&ovpn_link_ops);
+unreg_pernet:
+	unregister_pernet_subsys(&ovpn_pernet_ops);
 	return err;
 }
 
@@ -259,6 +313,7 @@ static __exit void ovpn_cleanup(void)
 {
 	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
+	unregister_pernet_subsys(&ovpn_pernet_ops);
 
 	rcu_barrier();
 }
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
