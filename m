From: Gert Doering <gert@...1296...>
Date: Wed, 19 Nov 2025 12:40:35 +0100
Message-ID: <20251119114041.17665-1-gert@...1296...>
In-Reply-To: <gerrit.1758894427000.I16d90221d0a75193035253817ff195f6da9dc0b3@...2715...>
References: <gerrit.1758894427000.I16d90221d0a75193035253817ff195f6da9dc0b3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] route: handle default gateway
 (net_gateway) and nexthop towards VPN server separately
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Marco Baffo <marco@...2726...>

Right now there is the assumption that the gateway used for net_gateway is the same used to reach the VPN server.
However, these two gateways may be different (i.e. when there is a specific hostroute for the VPN server using a different nexthop).
For this reason we must adapt init_route_list() to fetch the two gateways separately.

Github: fixes OpenVPN/openvpn#890

Change-Id: I16d90221d0a75193035253817ff195f6da9dc0b3
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1222
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1222
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7d988da..770300a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -257,9 +257,9 @@
     {
         if (rl)
         {
-            if (rl->rgi.flags & RGI_ADDR_DEFINED)
+            if (rl->ngi.flags & RGI_ADDR_DEFINED)
             {
-                *out = rl->rgi.gateway.addr;
+                *out = rl->ngi.gateway.addr;
             }
             else
             {
@@ -624,10 +624,10 @@
         rl->spec.flags |= RTSA_DEFAULT_METRIC;
     }
 
-    get_default_gateway(&rl->rgi, remote_host != IPV4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);
-    if (rl->rgi.flags & RGI_ADDR_DEFINED)
+    get_default_gateway(&rl->ngi, INADDR_ANY, ctx);
+    if (rl->ngi.flags & RGI_ADDR_DEFINED)
     {
-        setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);
+        setenv_route_addr(es, "net_gateway", rl->ngi.gateway.addr, -1);
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
@@ -637,6 +637,8 @@
         dmsg(D_ROUTE, "ROUTE: default_gateway=UNDEF");
     }
 
+    get_default_gateway(&rl->rgi, remote_host != IPV4_INVALID_ADDR ? remote_host : INADDR_ANY, ctx);
+
     if (rl->spec.flags & RTSA_REMOTE_HOST)
     {
         rl->spec.remote_host_local = test_local_addr(remote_host, &rl->rgi);
@@ -773,10 +775,10 @@
     msg(D_ROUTE, "GDG6: remote_host_ipv6=%s",
         remote_host_ipv6 ? print_in6_addr(*remote_host_ipv6, 0, &gc) : "n/a");
 
-    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
-    if (rl6->rgi6.flags & RGI_ADDR_DEFINED)
+    get_default_gateway_ipv6(&rl6->ngi6, NULL, ctx);
+    if (rl6->ngi6.flags & RGI_ADDR_DEFINED)
     {
-        setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->rgi6.gateway.addr_ipv6, 0, &gc));
+        setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6.gateway.addr_ipv6, 0, &gc));
 #if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
@@ -786,6 +788,8 @@
         dmsg(D_ROUTE, "ROUTE6: default_gateway=UNDEF");
     }
 
+    get_default_gateway_ipv6(&rl6->rgi6, remote_host_ipv6, ctx);
+
     if (is_route_parm_defined(remote_endpoint))
     {
         if (inet_pton(AF_INET6, remote_endpoint, &rl6->remote_endpoint_ipv6) == 1)
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 54fa137..3d19dbd 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -234,7 +234,8 @@
 
     struct route_special_addr spec;
     struct route_gateway_info rgi;
-    unsigned int flags; /* RG_x flags */
+    struct route_gateway_info ngi; /* net_gateway */
+    unsigned int flags;            /* RG_x flags */
     struct route_ipv4 *routes;
     struct gc_arena gc;
 };
@@ -249,7 +250,8 @@
     int default_metric;
 
     struct route_ipv6_gateway_info rgi6;
-    unsigned int flags; /* RG_x flags, see route_option_list */
+    struct route_ipv6_gateway_info ngi6; /* net_gateway_ipv6 */
+    unsigned int flags;                  /* RG_x flags, see route_option_list */
     struct route_ipv6 *routes_ipv6;
     struct gc_arena gc;
 };

