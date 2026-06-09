Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3CDCD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yf48obztzeE6B5wpq0QnbdbSQjVC6rvd6iUjRB9UYms=; b=F58V46VahOwC+8iCHNVKidcp5y
	4pxcsmoSSDoPLDhneFqcfuH8BqFeAP/8LpswSzEMB0oRBgY8adcI+lxrv/QaSjJ8upWzTbfrJxlIf
	PupI8Rle3TGnCCqcZ3HdsRXeyrVTMVbhP3P5VMGAXzTpGN9w3Tya4wN0ij/Vf/CB5Vqg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxJ0-0003kn-1e;
	Tue, 09 Jun 2026 14:19:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWxIv-0003kW-0L
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JaJE2yTGDV8EL68oHDKx7Go+lcg1Mjvkaty9V2YHE+M=; b=aLN4WVvcWbfeUeH6xfszTFEB6Q
 YDCNJtkF9d1NU4HBpp/e+v6Qy1Ik8NMdtx5vIYJMzE9oSmglj/bcOrJyR6c/hqlPVn0Q0+oufBg8t
 0AmZeKGbstrtDtr5XetGbVvgj0nVKDuXE3CwUEXnmEFj9zqdRAYkVe/Dyc5LX3ozkYrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JaJE2yTGDV8EL68oHDKx7Go+lcg1Mjvkaty9V2YHE+M=; b=EVG2t3/Xb07hljoJ+V4hecPjzk
 2Qtsg+1qbn++bQfIr3gY+iaRcND3e1rGN/XCDAxm3rzZcOaN/ZLZbWOCTM5AcbAzfyshqtOi1Z6gL
 lfzOfd456HIN5YC9BG1ggMESpeuacX9uyXj1FKkpwNKgsWAX3/VtDAuT+uSL/LnwHtwE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWxIt-00014z-9d for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:45 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6599iWbk028636
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 11:44:32 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6599iWnF028635
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 11:44:32 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 11:44:25 +0200
Message-ID: <20260609094432.28620-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWxIt-00014z-9d
Subject: [Openvpn-devel] [PATCH v3] multi/dco: simplify dco_delete_iroutes
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
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1682
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1682
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index f5b7081..1e6638b 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -724,26 +724,25 @@
 }
 
 void
-dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, struct context *c)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
-    if (!dco_enabled(&m->top.options))
+    if (!dco_enabled(&c->options))
     {
         return;
     }
-    ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN);
+    ASSERT(TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TUN);
 
-    struct context *c = &mi->context;
 
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
@@ -751,27 +750,26 @@
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
@@ -779,11 +777,11 @@
         /* Checked if we added a host route as the assigned client IP address was
          * outside the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN32)
-        struct in6_addr *dest = &mi->context.c2.push_ifconfig_ipv6_local;
-        if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
+        struct in6_addr *dest = &c->c2.push_ifconfig_ipv6_local;
+        if (multi_check_push_ifconfig_ipv6_extra_route(&c->options, dest))
         {
             /* On windows we do not install these routes, so we also do not need to delete them */
-            net_route_v6_del(&m->top.net_ctx, dest, 128, NULL,
+            net_route_v6_del(net_ctx, dest, 128, NULL,
                              c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
         }
 #endif
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 4e5aad5..733f59a1 100644
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
+void dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, struct context *c);
 
 /**
  * Update traffic statistics for all peers
@@ -361,7 +361,7 @@
 }
 
 static inline void
-dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, struct context *c)
 {
 }
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a957fdf..a72dcd1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -479,7 +479,7 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(m, mi);
+    dco_delete_iroutes(&m->top.net_ctx, &mi->context);
 
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
@@ -1198,7 +1198,7 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifconfig_extra_route(mi, addr.v4.addr))
+    if (primary && multi_check_push_ifconfig_extra_route(&mi->context.options, addr.v4.addr))
     {
         /* "primary" is the VPN ifconfig address of the peer */
         /* if it does not fall into the network defined by ifconfig_local
@@ -1243,7 +1243,7 @@
         management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
     }
 #endif
-    if (primary && multi_check_push_ifconfig_ipv6_extra_route(mi, &addr.v6.addr))
+    if (primary && multi_check_push_ifconfig_ipv6_extra_route(&mi->context.options, &addr.v6.addr))
     {
         /* "primary" is the VPN ifconfig address of the peer */
         /* if it does not fall into the network defined by ifconfig_local
@@ -4373,9 +4373,8 @@
 }
 
 bool
-multi_check_push_ifconfig_extra_route(struct multi_instance *mi, in_addr_t dest)
+multi_check_push_ifconfig_extra_route(struct options *o, in_addr_t dest)
 {
-    struct options *o = &mi->context.options;
     in_addr_t local_addr, local_netmask;
 
     if (!o->ifconfig_local || !o->ifconfig_remote_netmask)
@@ -4394,11 +4393,8 @@
 }
 
 bool
-multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                                           struct in6_addr *dest)
+multi_check_push_ifconfig_ipv6_extra_route(struct options *o, struct in6_addr *dest)
 {
-    struct options *o = &mi->context.options;
-
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbits)
     {
         /* If we do not have a local address, we just return false as
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3ed08d4..f4459d2 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -673,28 +673,27 @@
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
+multi_check_push_ifconfig_extra_route(struct options *o, in_addr_t dest);
 
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
+multi_check_push_ifconfig_ipv6_extra_route(struct options *o, struct in6_addr *dest);
 
 /*
  * Check for signals.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
