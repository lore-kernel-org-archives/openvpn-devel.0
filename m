Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEA1CA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fM9eXL6B53JSND+TN4PWC3tLBMS0lvVEVXFyrEY9LWk=; b=bocs9NXzXh244SjksTAe83HmMS
	BNoTPLs/yhtXo5ZW+qyzwi4bXyOqg0+ga1QqIBWg1Q764g+1Yk+6FedqmfQPnuRB6OYufTVQ3fDFh
	Z1Amgkmx2EN9zFfQ2NvgOi2LRmhtpHwUufzcr86ALGyltkaT9vGMbz1csBnKESgnTMgI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE0mu-0005g8-Ds;
	Tue, 06 Oct 2026 08:44:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xE0mt-0005g1-11
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:44:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RdA7p5Wrbs3VSku18D+wf/QNScht5lowQ9AK6XwTcRo=; b=QWprMpfb6EEz9gROqF/ELdzIBx
 7aZFidfetLHjgxXkQSzzVitXCqxJWBTNLwPlZQMbZJ3w557P9DYbZdLzXoJ1SlFFF7ZWLDa+CBwFF
 S5LdGmydOewG76xAuVO3KoAKFAybRD+2r58zbUsCN+AoF4wELaxyObZ01i932VBNfv6w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RdA7p5Wrbs3VSku18D+wf/QNScht5lowQ9AK6XwTcRo=; b=fvjd2yMwTrHQUKpQmdgUOBf7ae
 bkDTQlf2tzPsawz698qqltBTeKN2lfoKqnq5Nwb51kt6SofyHwLmubIexl6YOK8MXjoDptDaiy60n
 xs7EbnlD5EXRtks0e+tlAJFR5zVMJ7CxpLsGinFEqveoaPfXp48NEZ6F8Cf3zOuwd/jc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0mp-0001N5-P2 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:44:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6968iShl008436
 for <openvpn-devel@lists.sourceforge.net>; Tue, 6 Oct 2026 10:44:28 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6968iShs008430
 for openvpn-devel@lists.sourceforge.net; Tue, 6 Oct 2026 10:44:28 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  6 Oct 2026 10:44:21 +0200
Message-ID: <20261006084428.8398-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xE0mp-0001N5-P2
Subject: [Openvpn-devel] [PATCH v2] Support pre-existing Linux DCO interfaces
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

When creating an ovpn interface returns -EEXIST, still retrieve the
ifindex and return the error to the generic DCO open path. This lets the
caller mark the interface as pre-existing and avoid deleting it on
close.

Before accepting the existing interface, query its rtnetlink link info
and verify that it is an ovpn device with the expected mode. The ovpn
mode is fixed at interface creation time, so attaching to an interface
created for the other mode cannot work.

Honor the pre-existing state on close by skipping net_iface_del() for
persistent interfaces.

Github: closes OpenVPN/openvpn#1064
Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1734
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1734
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 4e5aad5..4584004 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -109,7 +109,8 @@
 bool ovpn_dco_init(struct context *c);
 
 /**
- * Open/create a DCO interface
+ * Open/create a DCO interface and store its ifindex.
+ * If the interface already exists, save the ifindex anyway and return -EEXIST.
  *
  * @param tt        the tuntap context
  * @param ctx       the networking API context
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 56f6259..777b43c 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -502,6 +502,19 @@
     CLEAR(dco);
 }
 
+static const char *
+ovpn_mode_to_str(enum ovpn_mode mode)
+{
+    switch (mode)
+    {
+        case OVPN_MODE_P2P:
+            return "p2p";
+        case OVPN_MODE_MP:
+            return "server";
+    }
+    return "unknown";
+}
+
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
 {
@@ -509,11 +522,30 @@
     ASSERT(tt->type == DEV_TYPE_TUN);
 
     int ret = net_iface_new(ctx, dev, OVPN_FAMILY_NAME, &tt->dco);
-    if (ret < 0)
+    if (ret < 0 && ret != -EEXIST)
     {
         msg(D_DCO_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);
         return ret;
     }
+    if (ret == -EEXIST)
+    {
+        enum ovpn_mode mode;
+        int mode_ret = net_iface_ovpn_mode(ctx, dev, &mode);
+
+        if (mode_ret < 0)
+        {
+            msg(M_WARN, "DCO: cannot retrieve mode of existing interface %s: %s (%d)", dev,
+                strerror(-mode_ret), mode_ret);
+            return mode_ret;
+        }
+
+        if (mode != tt->dco.ifmode)
+        {
+            msg(M_WARN, "DCO: existing interface %s is in %s mode, expected %s mode",
+                dev, ovpn_mode_to_str(mode), ovpn_mode_to_str(tt->dco.ifmode));
+            return -EINVAL;
+        }
+    }
 
     tt->dco.ifindex = if_nametoindex(dev);
     if (!tt->dco.ifindex)
@@ -521,7 +553,7 @@
         msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
-    return 0;
+    return ret;
 }
 
 void
@@ -529,7 +561,10 @@
 {
     msg(D_DCO_DEBUG, __func__);
 
-    net_iface_del(ctx, tt->actual_name);
+    if (!tt->persistent_if)
+    {
+        net_iface_del(ctx, tt->actual_name);
+    }
     ovpn_dco_uninit_netlink(&tt->dco);
 }
 
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index e3e4824..42df09e 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -24,6 +24,7 @@
 #if defined(ENABLE_DCO) && defined(TARGET_LINUX)
 
 #include "event.h"
+#include "networking_sitnl.h"
 
 #include "ovpn_dco_linux.h"
 
@@ -38,28 +39,6 @@
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;
 
-/* OVPN section */
-
-#ifndef IFLA_OVPN_MAX
-
-enum ovpn_mode
-{
-    OVPN_MODE_P2P,
-    OVPN_MODE_MP,
-};
-
-enum ovpn_ifla_attrs
-{
-    IFLA_OVPN_UNSPEC = 0,
-    IFLA_OVPN_MODE,
-
-    __IFLA_OVPN_MAX,
-};
-
-#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
-
-#endif /* ifndef IFLA_OVPN_MAX */
-
 typedef struct
 {
     struct nl_sock *nl_sock;
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index bce0c19..cab560c 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -115,6 +115,19 @@
  */
 int net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX]);
 
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+/**
+ * Retrieve the ovpn interface mode
+ *
+ * @param ctx       the implementation specific context
+ * @param iface     interface to query
+ * @param mode      variable where the ovpn mode attribute will be stored
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode);
+#endif
+
 /**
  * Remove an interface
  *
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index a1f3525..85ab158 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -82,6 +82,16 @@
     return -1;
 }
 
+#if defined(ENABLE_DCO)
+int
+net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)
+{
+    /* not supported by iproute2 */
+    msg(M_WARN, "%s: operation not supported by iproute2 backend", __func__);
+    return -EOPNOTSUPP;
+}
+#endif
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index a396255..9d07638 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1432,8 +1432,18 @@
     return 0;
 }
 
-int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
+/**
+ * Issue an RTM_GETLINK query for an interface and feed the reply to the given
+ * parsing callback.
+ *
+ * @param iface     name of the interface to query
+ * @param cb        callback invoked with the netlink reply
+ * @param arg       opaque argument passed through to the callback
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+static int
+sitnl_link_get(const char *iface, sitnl_parse_reply_cb cb, void *arg)
 {
     struct sitnl_link_req req = {};
     int ifindex = if_nametoindex(iface);
@@ -1450,9 +1460,15 @@
     req.i.ifi_family = AF_PACKET;
     req.i.ifi_index = ifindex;
 
+    return sitnl_send(&req.n, 0, 0, cb, arg);
+}
+
+int
+net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
+{
     memset(type, 0, IFACE_TYPE_LEN_MAX);
 
-    int ret = sitnl_send(&req.n, 0, 0, sitnl_type_save, type);
+    int ret = sitnl_link_get(iface, sitnl_type_save, type);
     if (ret < 0)
     {
         msg(D_ROUTE, "%s: cannot retrieve iface %s: %s (%d)", __func__, iface, strerror(-ret), ret);
@@ -1464,6 +1480,82 @@
     return 0;
 }
 
+#if defined(ENABLE_DCO)
+static int
+sitnl_ovpn_mode_save(struct nlmsghdr *n, void *arg)
+{
+    struct ifinfomsg *ifi = NLMSG_DATA(n);
+    struct rtattr *tb[IFLA_MAX + 1];
+    struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+    struct rtattr *tb_data[IFLA_OVPN_MAX + 1];
+    enum ovpn_mode *mode = arg;
+    uint8_t raw_mode;
+
+    if (n->nlmsg_type != RTM_NEWLINK)
+    {
+        return -EINVAL;
+    }
+
+    if (n->nlmsg_len < NLMSG_LENGTH(sizeof(*ifi)))
+    {
+        return -EINVAL;
+    }
+
+    sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));
+
+    if (!tb[IFLA_LINKINFO])
+    {
+        return -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
+
+    if (!tb_link[IFLA_INFO_KIND]
+        || strcmp(RTA_DATA(tb_link[IFLA_INFO_KIND]), OVPN_FAMILY_NAME) != 0)
+    {
+        return -EINVAL;
+    }
+
+    if (!tb_link[IFLA_INFO_DATA])
+    {
+        return -ENOENT;
+    }
+
+    sitnl_parse_rtattr_nested(tb_data, IFLA_OVPN_MAX, tb_link[IFLA_INFO_DATA]);
+
+    if (!tb_data[IFLA_OVPN_MODE])
+    {
+        return -ENOENT;
+    }
+
+    if (RTA_PAYLOAD(tb_data[IFLA_OVPN_MODE]) < sizeof(raw_mode))
+    {
+        return -EINVAL;
+    }
+
+    raw_mode = *(uint8_t *)RTA_DATA(tb_data[IFLA_OVPN_MODE]);
+    *mode = (enum ovpn_mode)raw_mode;
+
+    return 0;
+}
+
+int
+net_iface_ovpn_mode(openvpn_net_ctx_t *ctx, const char *iface, enum ovpn_mode *mode)
+{
+    int ret = sitnl_link_get(iface, sitnl_ovpn_mode_save, mode);
+    if (ret < 0)
+    {
+        msg(D_ROUTE, "%s: cannot retrieve ovpn mode for iface %s: %s (%d)", __func__, iface,
+            strerror(-ret), ret);
+        return ret;
+    }
+
+    msg(D_ROUTE, "%s: mode of %s: %d", __func__, iface, *mode);
+
+    return 0;
+}
+#endif /* defined(ENABLE_DCO) */
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index 481cc36..7a2d964 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -24,4 +24,30 @@
 typedef char openvpn_net_iface_t;
 typedef void *openvpn_net_ctx_t;
 
+#if defined(TARGET_LINUX)
+
+#include <linux/if_link.h>
+
+#ifndef IFLA_OVPN_MAX
+
+enum ovpn_mode
+{
+    OVPN_MODE_P2P,
+    OVPN_MODE_MP,
+};
+
+enum ovpn_ifla_attrs
+{
+    IFLA_OVPN_UNSPEC = 0,
+    IFLA_OVPN_MODE,
+
+    __IFLA_OVPN_MAX,
+};
+
+#define IFLA_OVPN_MAX (__IFLA_OVPN_MAX - 1)
+
+#endif /* ifndef IFLA_OVPN_MAX */
+
+#endif /* if defined(TARGET_LINUX) */
+
 #endif /* NETWORKING_SITNL_H_ */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
