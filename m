From: Gert Doering <gert@...1296...>
Date: Fri, 31 Jan 2025 16:41:35 +0100
Message-ID: <20250131154135.32169-1-gert@...1296...>
In-Reply-To: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
References: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] route.c: improve get_default_gateway()
 logic on Windows
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

From: Lev Stipakov <lev@...515...>

When adding host route for IPv4, we use the default gateway. There are
cases, however, when this does not work - for example when remote
is not accessible via default gateway but via dedicated route.

Factor out code to look for the best gateway to reach the host from
get_default_gateway_ipv6() and generalize is for IPv4/6.

Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/879
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index dd37fb9..d895e1c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2732,40 +2732,105 @@
     return ret;
 }
 
+/**
+ * @brief Determines the best route to a destination for both IPv4 and IPv6.
+ *
+ * Uses `GetBestInterfaceEx` and `GetBestRoute2` to find the optimal route
+ * and network interface for the specified destination address.
+ *
+ * @param gc Pointer to struct gc_arena for internal string allocation.
+ * @param dest The destination IP address (IPv4 or IPv6).
+ * @param best_route Pointer to a `MIB_IPFORWARD_ROW2` structure to store the best route.
+ * @return DWORD `NO_ERROR` on success, or an error code.
+ */
+static DWORD
+get_best_route(struct gc_arena *gc, SOCKADDR_INET *dest, MIB_IPFORWARD_ROW2 *best_route)
+{
+    DWORD best_if_index;
+    DWORD status;
+
+    CLEAR(*best_route);
+
+    /* get the best interface index to reach dest */
+    status = GetBestInterfaceEx((struct sockaddr *)dest, &best_if_index);
+    if (status != NO_ERROR)
+    {
+        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=%u)",
+            strerror_win32(status, gc),
+            (unsigned int)status);
+        goto done;
+    }
+
+    msg(D_ROUTE_DEBUG, "GetBestInterfaceEx() returned if=%d", (int)best_if_index);
+
+    /* get the routing information (such as NextHop) for the destination and interface */
+    NET_LUID luid;
+    CLEAR(luid);
+    SOCKADDR_INET best_src;
+    CLEAR(best_src);
+    status = GetBestRoute2(&luid, best_if_index, NULL,
+                           dest, 0, best_route, &best_src);
+    if (status != NO_ERROR)
+    {
+        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=%u)",
+            strerror_win32(status, gc),
+            (unsigned int)status);
+        goto done;
+    }
+
+done:
+    return status;
+}
+
 void
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc = gc_new();
-
-    const IP_ADAPTER_INFO *adapters = get_adapter_info_list(&gc);
-    const MIB_IPFORWARDTABLE *routes = get_windows_routing_table(&gc);
-    const MIB_IPFORWARDROW *row = get_default_gateway_row(routes);
-    DWORD a_index;
-    const IP_ADAPTER_INFO *ai;
-
     CLEAR(*rgi);
 
-    if (row)
+    struct gc_arena gc = gc_new();
+
+    /* convert in_addr_t into SOCKADDR_INET */
+    SOCKADDR_INET sa;
+    CLEAR(sa);
+    sa.si_family = AF_INET;
+    sa.Ipv4.sin_addr.s_addr = htonl(dest);
+
+    /* get the best route to the destination */
+    MIB_IPFORWARD_ROW2 best_route;
+    CLEAR(best_route);
+    DWORD status = get_best_route(&gc, &sa, &best_route);
+    if (status != NO_ERROR)
     {
-        rgi->gateway.addr = ntohl(row->dwForwardNextHop);
-        if (rgi->gateway.addr)
+        goto done;
+    }
+
+    rgi->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+    rgi->gateway.addr = ntohl(best_route.NextHop.Ipv4.sin_addr.S_un.S_addr);
+    rgi->adapter_index = best_route.InterfaceIndex;
+
+    if (rgi->gateway.addr == INADDR_ANY)
+    {
+        rgi->flags |= RGI_ON_LINK;
+    }
+
+    /* get netmask and MAC address */
+    const IP_ADAPTER_INFO *adapters = get_adapter_info_list(&gc);
+    const IP_ADAPTER_INFO *ai = get_adapter(adapters, rgi->adapter_index);
+    if (ai)
+    {
+        memcpy(rgi->hwaddr, ai->Address, 6);
+        rgi->flags |= RGI_HWADDR_DEFINED;
+
+        /* get netmask for non-onlink routes */
+        in_addr_t nm = inet_addr(ai->IpAddressList.IpMask.String);
+        if (!(rgi->flags & RGI_ON_LINK) && (nm != INADDR_NONE))
         {
-            rgi->flags |= RGI_ADDR_DEFINED;
-            a_index = adapter_index_of_ip(adapters, rgi->gateway.addr, NULL, &rgi->gateway.netmask);
-            if (a_index != TUN_ADAPTER_INDEX_INVALID)
-            {
-                rgi->adapter_index = a_index;
-                rgi->flags |= (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);
-                ai = get_adapter(adapters, a_index);
-                if (ai)
-                {
-                    memcpy(rgi->hwaddr, ai->Address, 6);
-                    rgi->flags |= RGI_HWADDR_DEFINED;
-                }
-            }
+            rgi->gateway.netmask = ntohl(nm);
+            rgi->flags |= RGI_NETMASK_DEFINED;
         }
     }
 
+done:
     gc_free(&gc);
 }
 
@@ -2823,43 +2888,22 @@
                          const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
-    MIB_IPFORWARD_ROW2 BestRoute;
-    SOCKADDR_INET DestinationAddress, BestSourceAddress;
-    DWORD BestIfIndex;
-    DWORD status;
-    NET_LUID InterfaceLuid;
-
     CLEAR(*rgi6);
-    CLEAR(InterfaceLuid);               /* cleared = not used for lookup */
-    CLEAR(DestinationAddress);
 
+    SOCKADDR_INET DestinationAddress;
+    CLEAR(DestinationAddress);
     DestinationAddress.si_family = AF_INET6;
     if (dest)
     {
         DestinationAddress.Ipv6.sin6_addr = *dest;
     }
 
-    status = GetBestInterfaceEx( (struct sockaddr *)&DestinationAddress, &BestIfIndex );
+    MIB_IPFORWARD_ROW2 BestRoute;
+    CLEAR(BestRoute);
+    DWORD status = get_best_route(&gc, &DestinationAddress, &BestRoute);
 
     if (status != NO_ERROR)
     {
-        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=%u)",
-            strerror_win32(status, &gc),
-            (unsigned int)status);
-        goto done;
-    }
-
-    msg( D_ROUTE, "GetBestInterfaceEx() returned if=%d", (int) BestIfIndex );
-
-    status = GetBestRoute2( &InterfaceLuid, BestIfIndex, NULL,
-                            &DestinationAddress, 0,
-                            &BestRoute, &BestSourceAddress );
-
-    if (status != NO_ERROR)
-    {
-        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=%u)",
-            strerror_win32(status, &gc),
-            (unsigned int)status);
         goto done;
     }
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 0bbedbb..98ea79e 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -334,6 +334,13 @@
 
 bool is_special_addr(const char *addr_str);
 
+/**
+ * @brief Retrieves the best gateway for a given destination based on the routing table.
+ *
+ * @param rgi  Pointer to a struct to store the gateway information.
+ * @param dest Destination IP address in host byte order.
+ * @param ctx  Pointer to a platform-specific network context struct.
+ */
 void get_default_gateway(struct route_gateway_info *rgi,
                          in_addr_t dest,
                          openvpn_net_ctx_t *ctx);

