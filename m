Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13050CD6E43
	for <openvpn-devel@archiver.kernel.org>; Wed, 27 May 2026 16:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FCgcwW2Z2I8r9tomxjjOq3WUvIrC6IbU4fG0V2dsWI=; b=VPkf8GI57q6s2K0K1otfwSRHVY
	fEwf0ttJnsio+RUw6Z+mRvg9ZAg5IFl5weRMM+TrBik3o45PzyS3gx4iDfDXFET3yvAH2N9K62aWM
	xIqXUh1w2B74LAfGKjzVcDpCeiLQNEjTgK4Nj6R+FsY3+nJ0cpThiaJDcK+HTXG2PKr8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSHY2-0005uv-B4;
	Wed, 27 May 2026 16:56:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wSHY0-0005uf-R9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 16:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=soSHLTBlf2yKwFenoXJHsmCGh9UqJRcFW1hLZYPUVPI=; b=gVf3zeaZp2kq0FNUR0WcwStccM
 SFBwQKdDm2paVxzd9sRUg6hq8Z+ooQiqJ7yQ1TQQzyoEMX7bF/TxOO3NcWDZljD2Pbya0rbhKC2wl
 iSgjkeaJG0zEdIDBI+faHYWfqdPt4fIEUNAiG5LYT0VBFqt2QXvaHmpi3Wiuv35ZodBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=soSHLTBlf2yKwFenoXJHsmCGh9UqJRcFW1hLZYPUVPI=; b=Y8GK9roKgdhoU5tM4XdSc0UGpw
 s5tGbok1ruHUPTeYalTC0aPc7d6xfhv7WMofVssMjRE9IYYvtDFaEkBYzFq1xObxRCyOSLkWkT0GO
 BOsaZxt2vfwXX7ihMC/rKzQgOxqr6vh/xzO7In6XgHUPCOB5mBZ7NEMmgdJfzOJysLFE=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSHXy-0006hO-Or for openvpn-devel@lists.sourceforge.net;
 Wed, 27 May 2026 16:56:00 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4gQbNL65GJzDxRX;
 Wed, 27 May 2026 18:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779900946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=soSHLTBlf2yKwFenoXJHsmCGh9UqJRcFW1hLZYPUVPI=;
 b=npUoMdwXvyKoc7s7FVL6FSVLPf2n9jL6zABOnJ6x1fs1wLvHZKp+jGvs6XOuJo5Q2Dt+R6
 Xc7jqemO2/MKrKN1fu3l5xxNDKUfYYoTtn8sfu2ClZ2JLxGfltHKXJAGsrKbKdx3QhSDgY
 GfPIPgU5fP8E3oY8klwxiX5dqbKEgfLp2gRvbb/uRopb6nVY6SBszEVjqpg/PiVAsA9TDL
 7sQEXRy0NSFSiVk8cxREbaQwGnyfu5ag39Vlt5nEEUE/4NWr0vN4jhmF5fjtxGllXWPbUV
 N0JbVASEpdIMis2DOosLblKtDgR8P5Q5sSPkbjvWe4+NaseQM2liUYTFvZZDQA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 18:55:24 +0200
Message-ID: <20260527165527.24035-2-ralf@mandelbit.com>
In-Reply-To: <20260527165527.24035-1-ralf@mandelbit.com>
References: <20260527165527.24035-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gQbNL65GJzDxRX
X-Headers-End: 1wSHXy-0006hO-Or
Subject: [Openvpn-devel] [PATCH ovpn net-next 2/2] ovpn: add support for
 self-destroying interfaces
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

When the OpenVPN process exits unexpectedly, its ovpn netdev can remain
registered. This can leave stale interfaces behind and make a later
restart problematic.

Add IFLA_OVPN_SELFDESTROY to request automatic device deletion when the
rtnetlink socket that created the device is released. Store the creating
socket's net namespace and port ID in the ovpn private data and use the
NETLINK_URELEASE notifier to delete all ovpn devices matching the
released rtnetlink socket.

Keep self-destroying devices on a module-wide list, and match entries by
the saved rtnetlink socket net namespace and port ID. This lets the
notifier find matching devices without walking net namespaces or
unrelated netdevices.

The lifeline list is updated from newlink/dellink and the notifier
deletion path, all under RTNL, so no additional list lock is needed.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/main.c      | 107 ++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/ovpnpriv.h  |  15 +++++
 include/uapi/linux/if_link.h |   1 +
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..1c5e9666d7b5 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -11,6 +11,7 @@
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/list.h>
 #include <linux/inetdevice.h>
 #include <net/gro_cells.h>
 #include <net/ip.h>
@@ -26,6 +27,11 @@
 #include "tcp.h"
 #include "udp.h"
 
+/* Self-destroying devices indexed by their rtnetlink socket identity.
+ * Protected by RTNL.
+ */
+static LIST_HEAD(ovpn_lifeline_list);
+
 static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
@@ -108,6 +114,7 @@ static const struct device_type ovpn_type = {
 static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
 	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
 					    OVPN_MODE_MP),
+	[IFLA_OVPN_SELFDESTROY] = { .type = NLA_FLAG },
 };
 
 /**
@@ -174,6 +181,19 @@ static void ovpn_setup(struct net_device *dev)
 	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
 }
 
+static void ovpn_lifeline_detach(struct ovpn_priv *ovpn)
+{
+	ASSERT_RTNL();
+
+	if (!ovpn->lifeline.net)
+		return;
+
+	list_del_init(&ovpn->lifeline.node);
+	put_net(ovpn->lifeline.net);
+	ovpn->lifeline.net = NULL;
+	ovpn->lifeline.portid = 0;
+}
+
 static int ovpn_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
@@ -181,14 +201,33 @@ static int ovpn_newlink(struct net_device *dev,
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct nlattr **data = params->data;
 	enum ovpn_mode mode = OVPN_MODE_P2P;
+	struct net *net = NULL;
+	u32 portid = 0;
+	int err;
 
 	if (data && data[IFLA_OVPN_MODE]) {
 		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
 		netdev_dbg(dev, "setting device mode: %u\n", mode);
 	}
 
+	if (data && data[IFLA_OVPN_SELFDESTROY]) {
+		if (!params->portid) {
+			NL_SET_ERR_MSG(extack,
+				       "self-destroy requires a userspace netlink socket");
+			return -EINVAL;
+		}
+		/* save the identifiers for the NETLINK_URELEASE notification */
+		portid = params->portid;
+		net = get_net(params->src_net);
+		netdev_dbg(dev,
+			   "device will be destroyed when the netlink socket used to create it will be closed\n");
+	}
+
 	ovpn->dev = dev;
 	ovpn->mode = mode;
+	ovpn->lifeline.portid = portid;
+	ovpn->lifeline.net = net;
+	INIT_LIST_HEAD(&ovpn->lifeline.node);
 	spin_lock_init(&ovpn->lock);
 	INIT_DELAYED_WORK(&ovpn->keepalive_work, ovpn_peer_keepalive_work);
 
@@ -205,13 +244,27 @@ static int ovpn_newlink(struct net_device *dev,
 	else
 		netif_carrier_off(dev);
 
-	return register_netdevice(dev);
+	err = register_netdevice(dev);
+	if (err < 0) {
+		if (net)
+			put_net(net);
+		return err;
+	}
+
+	/* expose the device to the notifier only after registration succeeds */
+	if (portid) {
+		ASSERT_RTNL();
+		list_add_tail(&ovpn->lifeline.node, &ovpn_lifeline_list);
+	}
+
+	return 0;
 }
 
 static void ovpn_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
+	ovpn_lifeline_detach(ovpn);
 	cancel_delayed_work_sync(&ovpn->keepalive_work);
 	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	unregister_netdevice_queue(dev, head);
@@ -221,8 +274,12 @@ static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
+	ASSERT_RTNL();
+
 	if (nla_put_u8(skb, IFLA_OVPN_MODE, ovpn->mode))
 		return -EMSGSIZE;
+	if (ovpn->lifeline.net && nla_put_flag(skb, IFLA_OVPN_SELFDESTROY))
+		return -EMSGSIZE;
 
 	return 0;
 }
@@ -239,6 +296,46 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.fill_info = ovpn_fill_info,
 };
 
+static int ovpn_netlink_notify(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	const struct netlink_notify *notify = data;
+	struct ovpn_lifeline_info *entry, *tmp;
+	struct ovpn_priv *ovpn;
+	LIST_HEAD(unreg_list);
+
+	/* A self-destroying ovpn device uses the rtnetlink socket that created
+	 * it as its lifeline. When that socket is released, delete all ovpn
+	 * devices whose saved socket netns and port ID match the notification.
+	 */
+	if (action != NETLINK_URELEASE || notify->protocol != NETLINK_ROUTE)
+		return NOTIFY_DONE;
+
+	rtnl_lock();
+
+	/* ovpn_dellink removes entry->node, so use the safe iterator */
+	list_for_each_entry_safe(entry, tmp, &ovpn_lifeline_list, node) {
+		if (!net_eq(notify->net, entry->net) ||
+		    entry->portid != notify->portid)
+			continue;
+
+		ovpn = container_of(entry, struct ovpn_priv, lifeline);
+		ovpn_dellink(ovpn->dev, &unreg_list);
+	}
+
+	/* One rtnetlink socket may be the lifeline for multiple ovpn devices
+	 * so unregister the whole list built by ovpn_dellink in a batch.
+	 */
+	unregister_netdevice_many(&unreg_list);
+	rtnl_unlock();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ovpn_netlink_notifier = {
+	.notifier_call = ovpn_netlink_notify,
+};
+
 static int __init ovpn_init(void)
 {
 	int err = rtnl_link_register(&ovpn_link_ops);
@@ -254,6 +351,13 @@ static int __init ovpn_init(void)
 		goto unreg_rtnl;
 	}
 
+	err = netlink_register_notifier(&ovpn_netlink_notifier);
+	if (err) {
+		pr_err("ovpn: can't register netlink notifier: %d\n", err);
+		ovpn_nl_unregister();
+		goto unreg_rtnl;
+	}
+
 	ovpn_tcp_init();
 
 	return 0;
@@ -265,6 +369,7 @@ static int __init ovpn_init(void)
 
 static __exit void ovpn_cleanup(void)
 {
+	netlink_unregister_notifier(&ovpn_netlink_notifier);
 	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
 
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 5898f6adada7..788ac7022ae0 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <linux/list.h>
 #include <linux/workqueue.h>
 #include <net/gro_cells.h>
 #include <uapi/linux/if_link.h>
@@ -32,11 +33,24 @@ struct ovpn_peer_collection {
 	struct hlist_nulls_head by_transp_addr[1 << 12];
 };
 
+/**
+ * struct ovpn_lifeline_info - rtnetlink socket identity for self-destruction
+ * @node: entry on the module-wide lifeline list
+ * @net: net namespace of the rtnetlink socket
+ * @portid: port ID of the rtnetlink socket
+ */
+struct ovpn_lifeline_info {
+	struct list_head node;
+	struct net *net;
+	u32 portid;
+};
+
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @mode: device operation mode (i.e. p2p, mp, ..)
  * @lock: protect this object
+ * @lifeline: rtnetlink socket identity for self-destruction
  * @peers: data structures holding multi-peer references
  * @peer: in P2P mode, this is the only remote peer
  * @gro_cells: pointer to the Generic Receive Offload cell
@@ -46,6 +60,7 @@ struct ovpn_priv {
 	struct net_device *dev;
 	enum ovpn_mode mode;
 	spinlock_t lock; /* protect writing to the ovpn_priv object */
+	struct ovpn_lifeline_info lifeline;
 	struct ovpn_peer_collection *peers;
 	struct ovpn_peer __rcu *peer;
 	struct gro_cells gro_cells;
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 46413392b402..e503d048891f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -2066,6 +2066,7 @@ enum ovpn_mode {
 enum {
 	IFLA_OVPN_UNSPEC,
 	IFLA_OVPN_MODE,
+	IFLA_OVPN_SELFDESTROY,
 	__IFLA_OVPN_MAX,
 };
 
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
