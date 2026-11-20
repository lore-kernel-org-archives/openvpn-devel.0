Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68F606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JEpr1/Re;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JNwQ8GiR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lIcDxhHn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=g+gZbz56b85F62r45mdFnSn6AZXHnNXdktJS+8tlLtg=; b=JEpr1/Rejrpb8b
	bBV39DFyoUmnJCoLQPE1c5M51jyON3U6+pe7AQUHdLb7e9ykTDkPsRV6mQoIN7zgpmQ2fqKZEw4Ek
	akIzrnPHVze3PeReM8qK3oPcLN907y66aGsInMmF/thkaVD4XXA6R1hm2UtCzKLVvOcvMIRTvr5tj
	cr4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUK5v-000000007Tp-0cXY;
	Fri, 20 Nov 2026 08:35:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUK5t-000000007Ti-0CYT for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:35:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ipiT+yZ7BFP1ovO1fs0aCi+sQMz5/gGV3b8nCWU3cTU=; b=JNwQ8GiR2hEfZwS5IP9f4Ipq+1
 ZWICcdsvX+BBrDjEzOphNPjH8HjANrnUwDg67pW7gx47CHrgPNDu9PbFaH6U8dnF+/Jy1o/uJA/MV
 nB0wlfnbp+ppRIkPBOwthPKFCzJVRo2vjQXYGveYFzjpk1Nbp08EGmdLY+FAm8FWintw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ipiT+yZ7BFP1ovO1fs0aCi+sQMz5/gGV3b8nCWU3cTU=; b=lIcDxhHnv3rL1Dthry9l7leFpu
 NbMYDDLwSBbC7k8o1BnJG3SXNmOCaUtg5DhspSU57vcibPb05YyjxLPIRc+Wrb7LxVnBUw+1LB0fO
 mr8J8BYwyDJ8CgiE1NUc75DxF//V7KiUvUSjGWp1N/TQ9vxdBPn2NC1moQP3wIBv/3Qs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUK5q-000000000YD-3soF for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:35:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AK8ZWQN007430
 for <openvpn-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 09:35:32 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AK8ZWit007417
 for openvpn-devel@lists.sourceforge.net; Fri, 20 Nov 2026 09:35:32 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 20 Nov 2026 09:35:25 +0100
Message-ID: <20261120083531.7390-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUK5q-000000000YD-3soF
Subject: [Openvpn-devel] [PATCH v3] networking: use NET_ROUTE_TABLE_DEFAULT
 (-1) for "no route table"
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

From: Razvan Cojocaru <razvanc@mailbox.org>

Table 0 meant "default table" in the net_route_*() API. That is fine on
Linux, where table 0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0 is a real
FIB, which could then not be selected from a process running in another
FIB.

Make the table argument an int, with NET_ROUTE_TABLE_DEFAULT (-1) for
the default table, and default --route-table to it. An invalid
--route-table value is now an error, instead of table 0. sitnl maps -1
and 0 to the main table, as before. On FreeBSD, -fib is now passed only
for a set table; DCO iroutes no longer force FIB 0 but use the FIB of
the process.

Routes that route.c creates internally get it too; block-local routes
passed an uninitialized table before.

Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2224
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2224
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 236be93..fdee465 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -721,7 +721,7 @@
         }
 
         net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
-                         gateway, c->c1.tuntap->actual_name, 0,
+                         gateway, c->c1.tuntap->actual_name, NET_ROUTE_TABLE_DEFAULT,
                          DCO_IROUTE_METRIC);
 #endif
     }
@@ -739,7 +739,7 @@
         }
 
         net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, gateway,
-                         c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
+                         c->c1.tuntap->actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
 #endif
     }
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
@@ -765,7 +765,7 @@
             dco_win_del_iroute_ipv4(&c->c1.tuntap->dco, htonl(ir->network), ir->netbits);
 #else
             net_route_v4_del(net_ctx, &ir->network, ir->netbits,
-                             &c->c2.push_ifconfig_local, c->c1.tuntap->actual_name, 0,
+                             &c->c2.push_ifconfig_local, c->c1.tuntap->actual_name, NET_ROUTE_TABLE_DEFAULT,
                              DCO_IROUTE_METRIC);
 #endif
         }
@@ -779,7 +779,7 @@
         {
             /* On windows we do not install these routes, so we also do not need to delete them */
             net_route_v4_del(net_ctx, &ifconfig_local, 32, NULL,
-                             c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
+                             c->c1.tuntap->actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
         }
 #endif
     }
@@ -792,7 +792,7 @@
             dco_win_del_iroute_ipv6(&c->c1.tuntap->dco, ir6->network, ir6->netbits);
 #else
             net_route_v6_del(net_ctx, &ir6->network, ir6->netbits,
-                             &c->c2.push_ifconfig_ipv6_local, c->c1.tuntap->actual_name, 0,
+                             &c->c2.push_ifconfig_ipv6_local, c->c1.tuntap->actual_name, NET_ROUTE_TABLE_DEFAULT,
                              DCO_IROUTE_METRIC);
 #endif
         }
@@ -805,7 +805,7 @@
         {
             /* On windows we do not install these routes, so we also do not need to delete them */
             net_route_v6_del(net_ctx, dest, 128, NULL,
-                             c->c1.tuntap->actual_name, 0, DCO_IROUTE_METRIC);
+                             c->c1.tuntap->actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
         }
 #endif
     }
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 7ad6e2e..f42ef4b 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -24,6 +24,9 @@
 
 #define IFACE_TYPE_LEN_MAX 64
 
+/** net_route_*() table: Linux main table, FreeBSD FIB of the process */
+#define NET_ROUTE_TABLE_DEFAULT -1
+
 struct context;
 
 #ifdef ENABLE_SITNL
@@ -245,14 +248,13 @@
  * @param prefixlen the length of the prefix of the destination
  * @param gw        the gateway for this route
  * @param iface     the interface for this route (can be NULL)
- * @param table     the table to add this route to (if 0, will be added to the
- *                  main table)
+ * @param table     the table to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric associated with the route
  *
  * @return          0 on success, a negative error code otherwise
  */
 int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
-                     const in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,
+                     const in_addr_t *gw, const openvpn_net_iface_t *iface, int table,
                      int metric);
 
 /**
@@ -263,14 +265,13 @@
  * @param prefixlen the length of the prefix of the destination
  * @param gw        the gateway for this route
  * @param iface     the interface for this route (can be NULL)
- * @param table     the table to add this route to (if 0, will be added to the
- *                  main table)
+ * @param table     the table to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric associated with the route
  *
  * @return          0 on success, a negative error code otherwise
  */
 int net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                     const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
+                     const struct in6_addr *gw, const openvpn_net_iface_t *iface, int table,
                      int metric);
 
 /**
@@ -281,14 +282,13 @@
  * @param prefixlen the length of the prefix of the destination
  * @param gw        the gateway for this route
  * @param iface     the interface for this route (can be NULL)
- * @param table     the table to add this route to (if 0, will be added to the
- *                  main table)
+ * @param table     the table to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric associated with the route
  *
  * @return          0 on success, a negative error code otherwise
  */
 int net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
-                     const in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,
+                     const in_addr_t *gw, const openvpn_net_iface_t *iface, int table,
                      int metric);
 
 /**
@@ -299,14 +299,13 @@
  * @param prefixlen the length of the prefix of the destination
  * @param gw        the gateway for this route
  * @param iface     the interface for this route (can be NULL)
- * @param table     the table to add this route to (if 0, will be added to the
- *                  main table)
+ * @param table     the table to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric associated with the route
  *
  * @return          0 on success, a negative error code otherwise
  */
 int net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                     const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
+                     const struct in6_addr *gw, const openvpn_net_iface_t *iface, int table,
                      int metric);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */
diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c
index 88fd5c0..8ba6326 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -10,7 +10,7 @@
 
 static int
 net_route_v4(const char *op, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-             const char *iface, uint32_t table, int metric)
+             const char *iface, int table, int metric)
 {
     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
     in_addr_t _dst, _gw;
@@ -27,15 +27,20 @@
     if (gw)
     {
         _gw = ntohl(*gw);
-        argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s -net %s/%d %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+                    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)));
     }
     else
     {
-        argv_printf(&argv, "%s %s -net %s/%d -iface %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s -net %s/%d -iface %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                    iface, table);
+                    iface);
+    }
+    /* without -fib, route(8) uses the FIB of the process */
+    if (table >= 0)
+    {
+        argv_printf_cat(&argv, "-fib %d", table);
     }
 
     argv_msg(M_INFO, &argv);
@@ -48,7 +53,7 @@
 
 static int
 net_route_v6(const char *op, const struct in6_addr *dst, int prefixlen, const struct in6_addr *gw,
-             const char *iface, uint32_t table, int metric)
+             const char *iface, int table, int metric)
 {
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct argv argv = argv_new();
@@ -61,15 +66,19 @@
      */
     if (gw)
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s -6 %s -net %s/%d %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));
     }
     else
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s", ROUTE_PATH, op,
                     inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                    iface, table);
+                    iface);
+    }
+    if (table >= 0)
+    {
+        argv_printf_cat(&argv, "-fib %d", table);
     }
 
 
@@ -83,28 +92,28 @@
 
 int
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t table, int metric)
+                 const char *iface, int table, int metric)
 {
     return net_route_v4("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+                 const struct in6_addr *gw, const char *iface, int table, int metric)
 {
     return net_route_v6("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t table, int metric)
+                 const char *iface, int table, int metric)
 {
     return net_route_v4("del", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+                 const struct in6_addr *gw, const char *iface, int table, int metric)
 {
     return net_route_v6("del", dst, prefixlen, gw, iface, table, metric);
 }
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index d987478..6c4c8f4 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -243,7 +243,7 @@
 
 int
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t table, int metric)
+                 const char *iface, int table, int metric)
 {
     struct argv argv = argv_new();
     const char *dst_str = print_in_addr_t(*dst, 0, &argv.gc);
@@ -281,7 +281,7 @@
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+                 const struct in6_addr *gw, const char *iface, int table, int metric)
 {
     struct argv argv = argv_new();
     char *dst_str = (char *)print_in6_addr(*dst, 0, &argv.gc);
@@ -314,7 +314,7 @@
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t table, int metric)
+                 const char *iface, int table, int metric)
 {
     struct argv argv = argv_new();
     const char *dst_str = print_in_addr_t(*dst, 0, &argv.gc);
@@ -340,7 +340,7 @@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+                 const struct in6_addr *gw, const char *iface, int table, int metric)
 {
     struct argv argv = argv_new();
     char *dst_str = (char *)print_in6_addr(*dst, 0, &argv.gc);
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b7c0f58..af4ed27 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1115,14 +1115,11 @@
 
 static int
 sitnl_route_add(const char *iface, sa_family_t af_family, const void *dst, int prefixlen,
-                const void *gw, uint32_t table, int metric)
+                const void *gw, int table, int metric)
 {
     enum rt_scope_t scope = RT_SCOPE_UNIVERSE;
-
-    if (table == 0)
-    {
-        table = RT_TABLE_MAIN;
-    }
+    /* table 0 is RT_TABLE_UNSPEC */
+    const uint32_t rt_table = table > 0 ? (uint32_t)table : RT_TABLE_MAIN;
 
     if (!gw && iface)
     {
@@ -1130,12 +1127,12 @@
     }
 
     return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,
-                           table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
+                           rt_table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
 int
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t table, int metric)
+                 const char *iface, int table, int metric)
 {
     const in_addr_t *dst_ptr = NULL, *gw_ptr = NULL;
     in_addr_t dst_be = 0, gw_be = 0;
@@ -1154,7 +1151,7 @@
         gw_ptr = &gw_be;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1163,7 +1160,7 @@
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+                 const struct in6_addr *gw, const char *iface, int table, int metric)
 {
     inet_address_t dst_v6;
     inet_address_t gw_v6;
@@ -1183,7 +1180,7 @@
         gw_v6.ipv6 = *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1192,20 +1189,18 @@
 
 static int
 sitnl_route_del(const char *iface, sa_family_t af_family, const inet_address_t *dst, int prefixlen,
-                const inet_address_t *gw, uint32_t table, int metric)
+                const inet_address_t *gw, int table, int metric)
 {
-    if (table == 0)
-    {
-        table = RT_TABLE_MAIN;
-    }
+    /* table 0 is RT_TABLE_UNSPEC */
+    const uint32_t rt_table = table > 0 ? (uint32_t)table : RT_TABLE_MAIN;
 
-    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, metric,
+    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, rt_table, metric,
                            RT_SCOPE_NOWHERE, 0, 0);
 }
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const char *iface, uint32_t table, int metric)
+                 const char *iface, int table, int metric)
 {
     inet_address_t dst_v4;
     inet_address_t gw_v4;
@@ -1225,7 +1220,7 @@
         gw_v4.ipv4 = htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET, &dst_v4.ipv4, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4.ipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1234,7 +1229,7 @@
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+                 const struct in6_addr *gw, const char *iface, int table, int metric)
 {
     inet_address_t dst_v6;
     inet_address_t gw_v6;
@@ -1254,7 +1249,7 @@
         gw_v6.ipv6 = *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 947439d..e51ece7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -831,7 +831,7 @@
     o->ce.mssfix = 0;
     o->ce.mssfix_default = true;
     o->ce.mssfix_encap = true;
-    o->route_default_table_id = 0;
+    o->route_default_table_id = NET_ROUTE_TABLE_DEFAULT;
     o->route_delay_window = 30;
     o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
     o->resolve_in_advance = false;
@@ -5297,7 +5297,11 @@
         msg(M_WARN, "NOTE: --route-table is supported only on Linux when SITNL is built-in");
 #endif
         VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);
-        options->route_default_table_id = positive_atoi(p[1], msglevel);
+        if (!atoi_constrained(p[1], &options->route_default_table_id, p[0], 0, INT_MAX,
+                              msglevel))
+        {
+            goto err;
+        }
     }
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 9086529..82cb7f0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -545,6 +545,7 @@
         /* split a route into two smaller blocking routes, and direct them to target */
         l2 = ((~gateway->netmask) + 1) >> 1;
         r1->flags = RT_DEFINED;
+        r1->table_id = NET_ROUTE_TABLE_DEFAULT;
         r1->gateway = target;
         r1->network = gateway->addr & gateway->netmask;
         r1->netmask = ~(l2 - 1);
@@ -854,6 +855,7 @@
                 r6->gateway = rl6->rgi6.gateway.addr_ipv6;
             }
             r6->metric = 1;
+            r6->table_id = NET_ROUTE_TABLE_DEFAULT;
 #ifdef _WIN32
             r6->adapter_index = rl6->rgi6.adapter_index;
 #else
@@ -883,6 +885,7 @@
     struct route_ipv4 r;
     CLEAR(r);
     r.flags = RT_DEFINED;
+    r.table_id = NET_ROUTE_TABLE_DEFAULT;
     r.network = network;
     r.netmask = netmask;
     r.gateway = gateway;
@@ -897,6 +900,7 @@
     struct route_ipv4 r;
     CLEAR(r);
     r.flags = RT_DEFINED | RT_ADDED;
+    r.table_id = NET_ROUTE_TABLE_DEFAULT;
     r.network = network;
     r.netmask = netmask;
     r.gateway = gateway;
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index b580d32..636adda 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -112,7 +112,7 @@
     }
     printf("\n");
 
-    return net_route_v4_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+    return net_route_v4_add(NULL, &dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static int
@@ -148,7 +148,7 @@
     }
     printf("\n");
 
-    return net_route_v4_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_v4_add(NULL, &dst, prefixlen, &gw, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static int
@@ -175,7 +175,7 @@
     }
     printf("\n");
 
-    return net_route_v6_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+    return net_route_v6_add(NULL, &dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static int
@@ -208,7 +208,7 @@
     }
     printf("\n");
 
-    return net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+    return net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
