Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427CBC982E1
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ObZibR3aYsnJmBeAjuY9/3PjD8hVxCDnIHHD3iomng4=; b=Q7j9VTFJZa5LX/cYMWwdrSWiut
	eqPh+nA00gVLk1HgccWVfuZRPHjKxzFG3hOtVMUqhjKkVt/IiITf4G1pvQ6Aq7yRyAhw+I4/yBQpp
	NR315t5SRAmvujorwP6r7rDLtemMKYgpLQeqJLyOFj4In/N3gP8SBgYMb4k8akiKvReE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8ZIG-0007KO-AH;
	Mon, 21 Sep 2026 08:22:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x8ZIF-0007KA-5i
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kk2Pzq+HKUrsMOVfDRqpCS6N9NoiY8Cjun2miGmk+hU=; b=ciTC0mdwJ4yJVj2AKmlS0qJAWC
 4H9KvIQHd1DGvMHV+ACjIcyUZAYp4mptCpPC4JQbFmq+VPnp0/8hvajFigmxWp6XhfJUVPCqxS5L6
 lwO6iZEqhf7y9RK2WDyS3aXOnhtb2p1sKVHmTspIfo015O70Ce5DsupqXOM6a/H62RbU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Kk2Pzq+HKUrsMOVfDRqpCS6N9NoiY8Cjun2miGmk+hU=; b=XUu0UqJu8NdmJGbnJfZ8PcuXjC
 pJUy3h97/FemdefDj8KNBOofP8ZTJ/ea+IzaWnSVy9Gqtrcv0fytWSdrU2Cn9u9Q03R5wGMycPsPe
 ioz/31wFul3V8kd6887yor2CU205aR5Qoz2NFEyy4KOdPPa5hTTFh6+yrGGunYHOlrmw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8ZID-0008L0-W0 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 08:22:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68L8MM2G017829
 for <openvpn-devel@lists.sourceforge.net>; Mon, 21 Sep 2026 10:22:22 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68L8MMPN017828
 for openvpn-devel@lists.sourceforge.net; Mon, 21 Sep 2026 10:22:22 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 21 Sep 2026 10:22:16 +0200
Message-ID: <20260921082222.17813-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x8ZID-0008L0-W0
Subject: [Openvpn-devel] [PATCH v4] multi/dco: simplify dco_delete_iroutes
 call chain
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

From: Antonio Quartulli <antonio@mandelbit.com>

In order to be able to delete DCO iroutes from areas of the code
where the multi_context and the multi_instance objects may not be
available, let's simplify the call chain by passing the smallest
scoped context required.

This is a refactoring only and does not include any functional change.

This patch is required in preparation of fixing DCO iroutes removal
upon client exit, without waiting for the delayed exit routine
to kick in.

Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1682
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1682
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 8eae4bf..ba1c85f 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -741,26 +741,24 @@
 }
 
 void
-dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
-    if (!dco_enabled(&m->top.options))
+    if (!dco_enabled(&c->options))
     {
         return;
     }
-    ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN);
+    ASSERT(TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TUN);
 
-    const struct context *c = &mi->context;
-
-    if (mi->context.c2.push_ifconfig_defined)
+    if (c->c2.push_ifconfig_defined)
     {
         for (const struct iroute *ir = c->options.iroutes; ir; ir = ir->next)
         {
 #if defined(_WIN32)
             dco_win_del_iroute_ipv4(&c->c1.tuntap->dco, htonl(ir->network), ir->netbits);
 #else
-            net_route_v4_del(&m->top.net_ctx, &ir->network, ir->netbits,
-                             &mi->context.c2.push_ifconfig_local, c->c1.tuntap->actual_name, 0,
+            net_route_v4_del(net_ctx, &ir->network, ir->netbits,
+                             &c->c2.push_ifconfig_local, c->c1.tuntap->actual_name, 0,
                              DCO_IROUTE_METRIC);
 #endif
         }
@@ -768,27 +766,26 @@
 #if !defined(_WIN32)
         /* Check if we added a host route as the assigned client IP address was
          * not in the on link scope defined by --ifconfig */
-        in_addr_t ifconfig_local = mi->context.c2.push_ifconfig_local;
+        in_addr_t ifconfig_local = c->c2.push_ifconfig_local;
 
-        if (multi_check_push_ifconfig_extra_route(mi, htonl(ifconfig_local)))
+        if (multi_check_push_ifconfig_extra_route(&c->options, htonl(ifconfig_local)))
         {
             /* On windows we do not install these routes, so we also do not need to delete them */
-            net_route_v4_del(&m->top.net_ctx, &ifconfig_local,
-                             32, NULL, c->c1.tuntap->actual_name, 0,
-                             DCO_IROUTE_METRIC);
+            net_route_v4_del(net_ctx, &ifconfig_local, 32, NULL,
+                             c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
         }
 #endif
     }
 
-    if (mi->context.c2.push_ifconfig_ipv6_defined)
+    if (c->c2.push_ifconfig_ipv6_defined)
     {
         for (const struct iroute_ipv6 *ir6 = c->options.iroutes_ipv6; ir6; ir6 = ir6->next)
         {
 #if defined(_WIN32)
             dco_win_del_iroute_ipv6(&c->c1.tuntap->dco, ir6->network, ir6->netbits);
 #else
-            net_route_v6_del(&m->top.net_ctx, &ir6->network, ir6->netbits,
-                             &mi->context.c2.push_ifconfig_ipv6_local, c->c1.tuntap->actual_name, 0,
+            net_route_v6_del(net_ctx, &ir6->network, ir6->netbits,
+                             &c->c2.push_ifconfig_ipv6_local, c->c1.tuntap->actual_name, 0,
                              DCO_IROUTE_METRIC);
 #endif
         }
@@ -796,11 +793,11 @@
         /* Checked if we added a host route as the assigned client IP address was
          * outside the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN32)
-        struct in6_addr *dest = &mi->context.c2.push_ifconfig_ipv6_local;
-        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
+        const struct in6_addr *dest = &c->c2.push_ifconfig_ipv6_local;
+        if (multi_check_push_ifconfig_ipv6_extra_route(&c->options, dest))
         {
             /* On windows we do not install these routes, so we also do not need to delete them */
-            net_route_v6_del(&m->top.net_ctx, dest, 128, NULL,
+            net_route_v6_del(net_ctx, dest, 128, NULL,
                              c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
         }
 #endif
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 4e5aad5..7ef75fee 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -220,10 +220,10 @@
 /**
  * Remove all routes added through the specified client
  *
- * @param m         the server context
- * @param mi        the client instance for which routes have to be removed
+ * @param net_ctx   the iface networking context
+ * @param c         the client context for which routes have to be removed
  */
-void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
+void dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c);
 
 /**
  * Update traffic statistics for all peers
@@ -361,7 +361,7 @@
 }
 
 static inline void
-dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 }
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 46ff1ba..a167071 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -479,7 +479,7 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(m, mi);
+    dco_delete_iroutes(&m->top.net_ctx, &mi->context);
 
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
@@ -1197,7 +1197,7 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifconfig_extra_route(mi, addr.v4.addr))
+    if (primary && multi_check_push_ifconfig_extra_route(&mi->context.options, addr.v4.addr))
     {
         /* "primary" is the VPN ifconfig address of the peer */
         /* if it does not fall into the network defined by ifconfig_local
@@ -1242,7 +1242,7 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifconfig_ipv6_extra_route(mi, &addr.v6.addr))
+    if (primary && multi_check_push_ifconfig_ipv6_extra_route(&mi->context.options, &addr.v6.addr))
     {
         /* "primary" is the VPN ifconfig address of the peer */
         /* if it does not fall into the network defined by ifconfig_local
@@ -4438,9 +4438,8 @@
 }
 
 bool
-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)
+multi_check_push_ifconfig_extra_route(const struct options *o, in_addr_t dest)
 {
-    const struct options *o = &mi->context.options;
     in_addr_t local_addr, local_netmask;
 
     if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
@@ -4459,11 +4458,8 @@
 }
 
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                                           struct in6_addr *dest)
+multi_check_push_ifconfig_ipv6_extra_route(const struct options *o, const struct in6_addr *dest)
 {
-    const struct options *o = &mi->context.options;
-
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
     {
         /* If we do not have a local address, we just return false as
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 6cb86c7..18e57b8 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -670,28 +670,27 @@
  * Determines if the ifconfig_push_local address falls into the range of the local
  * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)
  *
- * @param mi           The multi-instance to check this condition for
+ * @param o            The instance wide options
  * @param dest         The destination IP address to check
  *
  * @return Returns true if ifconfig_push is outside that range and requires an extra
  * route to be installed.
  */
 bool
-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest);
+multi_check_push_ifconfig_extra_route(const struct options *o, in_addr_t dest);
 
 /**
  * Determines if the ifconfig_ipv6_local address falls into the range of the local
  * IP addresses of the VPN interface (ifconfig_local with ifconfig_remote_netmask)
  *
- * @param mi           The multi-instance to check this condition for
+ * @param o            The instance wide options
  * @param dest         The destination IPv6 address to check
  *
  * @return Returns true if ifconfig_push is outside that range and requires an extra
  * route to be installed.
  */
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                                           struct in6_addr *dest);
+multi_check_push_ifconfig_ipv6_extra_route(const struct options *o, const struct in6_addr *dest);
 
 /*
  * Check for signals.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
