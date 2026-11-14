Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9CB606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RZAL/i9t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fnXFgH58;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lxuzllJu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CiZA0B4ccOQqyDA78FWbUpJeo44OklAwGwn5r83dpCQ=; b=RZAL/i9tLXZQDD
	nr+NsKCB5JayBp33sHnQ55seOgVmWswkugCT4XU5I2QK13XljlJsvHMhIzmfX0Y0A0W7hVA6Uj0VP
	NsrDnPQn6FmYHkqG1QzcnDHp8J+Z4nq+HCyHviBXB0iup1m0LPBWr74O2vuwXCwUZ7w4Gd/SGmmW3
	HJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSI1o-000000000X8-1zYW;
	Sat, 14 Nov 2026 17:59:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSI1o-000000000Vi-0JIy for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:59:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DBel12LlwhnpG6iF3mVtLRVGq3Uvq6ZcH/sYtjvepc0=; b=fnXFgH588T+j6dziFU+kG0iUgK
 dsysCo8YJV8Fun4PuTkgio+4q+T0tWVIGGTtDP+VgBZa4Rdf81kMTy2szNlCERpdXjm6pxvjzmz+A
 pvJ563YqzSzT8qsd53NpUdZK4wh7bXYx3NzFxThTy+mu2gtNFKB0Hsj3IG6Yc1174/7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DBel12LlwhnpG6iF3mVtLRVGq3Uvq6ZcH/sYtjvepc0=; b=lxuzllJuzNe+zN4LJUMZVPEwJb
 bpcjFWrn1CflpQU7jUvyQ2/A9BQqyPy36Vcjerf2orf49oxZoGEOpZ0dVBxxxYez48G5lDM5srgES
 RaEgTvruRKav2MqFA/3VOEZOgVuK69Z+BBaHbBNDtwrbDaeqvy9XovvytSzAHI1hs7Rw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSI1m-0000000038K-206I for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:59:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEHwt6F014199
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 18:58:55 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEHwtbL014198
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 18:58:55 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 18:58:48 +0100
Message-ID: <20261114175853.14185-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSI1m-0000000038K-206I
Subject: [Openvpn-devel] [PATCH v3] dco: track installed iroutes separately
 for IPv4 and IPv6
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marco Baffo <marco@mandelbit.com>

Track successful route installation per address family and split route
deletion into IPv4 and IPv6 helpers. Update delayed-exit cleanup.
Return installation status from the Windows helpers and keep the
non-DCO declarations compatible.

Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2061
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2061
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index f3b5d44..f807002 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -706,8 +706,8 @@
     if (addrtype == MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits,
-                                c->c2.tls_multi->rx_peer_id);
+        bool installed = dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits,
+                                                 c->c2.tls_multi->rx_peer_id);
 #else
         const struct in6_addr *gateway = &mi->context.c2.push_ifconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -715,16 +715,18 @@
             gateway = NULL;
         }
 
-        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
-                         gateway, c->c1.tuntap->actual_name, 0,
-                         DCO_IROUTE_METRIC);
+        bool installed = net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
+                                          gateway, c->c1.tuntap->actual_name, 0,
+                                          DCO_IROUTE_METRIC)
+                         == 0;
 #endif
+        mi->context.did_dco_iroutes_v6 |= installed;
     }
     else if (addrtype == MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->netbits,
-                                c->c2.tls_multi->rx_peer_id);
+        bool installed = dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->netbits,
+                                                 c->c2.tls_multi->rx_peer_id);
 #else
         in_addr_t dest = htonl(addr->v4.addr);
         const in_addr_t *gateway = &mi->context.c2.push_ifconfig_local;
@@ -733,15 +735,17 @@
             gateway = NULL;
         }
 
-        net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, gateway,
-                         c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
+        bool installed = net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, gateway,
+                                          c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC)
+                         == 0;
 #endif
+        mi->context.did_dco_iroutes_v4 |= installed;
     }
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
 }
 
 void
-dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)
+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&c->options))
@@ -750,7 +754,7 @@
     }
     ASSERT(TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TUN);
 
-    msg(D_DCO, "DCO: attempt removing iroutes from system table");
+    msg(D_DCO, "DCO: attempt removing IPv4 iroutes from system table");
 
     if (c->c2.push_ifconfig_defined)
     {
@@ -778,6 +782,20 @@
         }
 #endif
     }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
+}
+
+void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)
+{
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
+    if (!dco_enabled(&c->options))
+    {
+        return;
+    }
+    ASSERT(TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TUN);
+
+    msg(D_DCO, "DCO: attempt removing IPv6 iroutes from system table");
 
     if (c->c2.push_ifconfig_ipv6_defined)
     {
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index c435f8c..ce44331 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -218,12 +218,20 @@
                         const struct mroute_addr *addr);
 
 /**
- * Remove all routes added through the specified client
+ * Remove all IPv4 routes added through the specified client
  *
  * @param net_ctx   the iface networking context
  * @param c         the client context for which routes have to be removed
  */
-void dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c);
+void dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *c);
+
+/**
+ * Remove all IPv6 routes added through the specified client
+ *
+ * @param net_ctx   the iface networking context
+ * @param c         the client context for which routes have to be removed
+ */
+void dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c);
 
 /**
  * Update traffic statistics for all peers
@@ -356,12 +364,17 @@
 }
 
 static inline void
-dco_install_iroute(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *addr)
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi, const struct mroute_addr *addr)
 {
 }
 
 static inline void
-dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)
+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *c)
+{
+}
+
+static inline void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {
 }
 
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 12b0666..68ae7c5 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -1007,7 +1007,7 @@
     return dco_get_version(&ver) && ver.Major >= 2;
 }
 
-void
+bool
 dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
                         unsigned int peer_id)
 {
@@ -1021,16 +1021,18 @@
         netbits, peer_id);
 
     DWORD bytes_returned = 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-                         &bytes_returned, NULL))
+    bool installed = DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
+                                     &bytes_returned, NULL);
+    if (!installed)
     {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed");
     }
 
     gc_free(&gc);
+    return installed;
 }
 
-void
+bool
 dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,
                         unsigned int peer_id)
 {
@@ -1042,13 +1044,15 @@
         netbits, peer_id);
 
     DWORD bytes_returned = 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-                         &bytes_returned, NULL))
+    bool installed = DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
+                                     &bytes_returned, NULL);
+    if (!installed)
     {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) failed");
     }
 
     gc_free(&gc);
+    return installed;
 }
 
 void
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index a92e5ad..28795b7 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -67,10 +67,10 @@
 
 bool dco_win_supports_multipeer(void);
 
-void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
+bool dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
                              unsigned int peer_id);
 
-void dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,
+bool dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits,
                              unsigned int peer_id);
 
 void dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index eb41d03..6ef480e 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -555,10 +555,17 @@
      * last connecting client claiming the iroutes takes ownership. Therefore
      * they are not removed during delayed cleanup.
      */
-    if (c->did_dco_iroutes)
+
+    if (c->did_dco_iroutes_v4)
     {
-        c->did_dco_iroutes = false;
-        dco_delete_iroutes(&c->net_ctx, c);
+        c->did_dco_iroutes_v4 = false;
+        dco_delete_iroutes_v4(&c->net_ctx, c);
+    }
+
+    if (c->did_dco_iroutes_v6)
+    {
+        c->did_dco_iroutes_v6 = false;
+        dco_delete_iroutes_v6(&c->net_ctx, c);
     }
 
     tls_set_single_session(c->c2.tls_multi);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0027550..a850e72 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -479,6 +479,28 @@
     set_prefix(mi);
 }
 
+static void
+multi_del_dco_iroutes_v4(struct multi_context *m, struct multi_instance *mi)
+{
+    /* Only remove DCO IPv4 iroutes this instance installed. */
+    if (mi->context.did_dco_iroutes_v4)
+    {
+        mi->context.did_dco_iroutes_v4 = false;
+        dco_delete_iroutes_v4(&m->top.net_ctx, &mi->context);
+    }
+}
+
+static void
+multi_del_dco_iroutes_v6(struct multi_context *m, struct multi_instance *mi)
+{
+    /* Only remove DCO IPv6 iroutes this instance installed. */
+    if (mi->context.did_dco_iroutes_v6)
+    {
+        mi->context.did_dco_iroutes_v6 = false;
+        dco_delete_iroutes_v6(&m->top.net_ctx, &mi->context);
+    }
+}
+
 /*
  * Tell the route helper about deleted iroutes so
  * that it can update its mask of currently used
@@ -490,12 +512,8 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
-    /* check if DCO iroutes were already removed when scheduling a delayed exit */
-    if (mi->context.did_dco_iroutes)
-    {
-        mi->context.did_dco_iroutes = false;
-        dco_delete_iroutes(&m->top.net_ctx, &mi->context);
-    }
+    multi_del_dco_iroutes_v4(m, mi);
+    multi_del_dco_iroutes_v6(m, mi);
 
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
@@ -1309,8 +1327,6 @@
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
         mi->did_iroutes = true;
-        /* multi_learn_in{6}_addr_t takes care of installing the DCO iroute */
-        mi->context.did_dco_iroutes = true;
         for (ir = mi->context.options.iroutes; ir != NULL; ir = ir->next)
         {
             if (ir->netbits >= 0)
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index cdd02b6..72436fe 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -507,7 +507,8 @@
     bool did_we_daemonize;       /**< Whether demonization has already
                                   *   taken place. */
 
-    bool did_dco_iroutes;        /**< Whether DCO iroutes have been installed */
+    bool did_dco_iroutes_v4;     /**< Whether DCO IPv4 iroutes have been installed */
+    bool did_dco_iroutes_v6;     /**< Whether DCO IPv6 iroutes have been installed */
 
     struct context_persist persist;
     /**< Persistent %context. */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
