From: selva.nair@...277...
Date: Wed,  4 Jan 2023 21:27:16 -0500
Message-Id: <20230105022718.1641751-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Use IPAPI for setting ipv6 routes when
 iservice not available
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

From: Selva Nair <selva.nair@...277...>

Currently we use netsh for this. The new code closely follows
what interactive service does.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c | 175 ++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 104 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ded8fec8..eabfe0a5 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -65,6 +65,8 @@ static bool add_route_ipv6_service(const struct route_ipv6 *, const struct tunta
 
 static bool del_route_ipv6_service(const struct route_ipv6 *, const struct tuntap *);
 
+static bool route_ipv6_ipapi(bool add, const struct route_ipv6 *, const struct tuntap *);
+
 #endif
 
 static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es, openvpn_net_ctx_t *ctx);
@@ -1975,58 +1977,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     }
     else
     {
-        DWORD adapter_index;
-        if (r6->adapter_index)          /* vpn server special route */
-        {
-            adapter_index = r6->adapter_index;
-            gateway_needed = true;
-        }
-        else
-        {
-            adapter_index = tt->adapter_index;
-        }
-
-        /* netsh interface ipv6 add route 2001:db8::/32 42 */
-        argv_printf(&argv, "%s%s interface ipv6 add route %s/%d %lu",
-                    get_win_sys_path(),
-                    NETSH_PATH_SUFFIX,
-                    network,
-                    r6->netbits,
-                    adapter_index);
-
-        /* next-hop depends on TUN or TAP mode:
-         * - in TAP mode, we use the "real" next-hop
-         * - in TUN mode we use a special-case link-local address that the tapdrvr
-         *   knows about and will answer ND (neighbor discovery) packets for
-         */
-        if (tt->type == DEV_TYPE_TUN && !gateway_needed)
-        {
-            argv_printf_cat( &argv, " %s", "fe80::8" );
-        }
-        else if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
-        {
-            argv_printf_cat( &argv, " %s", gateway );
-        }
-
-#if 0
-        if (r6->flags & RT_METRIC_DEFINED)
-        {
-            argv_printf_cat(&argv, " METRIC %d", r->metric);
-        }
-#endif
-
-        /* in some versions of Windows, routes are persistent across reboots by
-         * default, unless "store=active" is set (pointed out by Tony Lim, thanks)
-         */
-        argv_printf_cat( &argv, " store=active" );
-
-        argv_msg(D_ROUTE, &argv);
-
-        netcmd_semaphore_lock();
-        status = openvpn_execve_check(&argv, es, 0, "ERROR: Windows route add ipv6 command failed");
-        netcmd_semaphore_release();
+        status = route_ipv6_ipapi(true, r6, tt);
     }
-
 #elif defined (TARGET_SOLARIS)
 
     /* example: route add -inet6 2001:db8::/32 somegateway 0 */
@@ -2416,60 +2368,8 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     }
     else
     {
-        DWORD adapter_index;
-        if (r6->adapter_index)          /* vpn server special route */
-        {
-            adapter_index = r6->adapter_index;
-            gateway_needed = true;
-        }
-        else
-        {
-            adapter_index = tt->adapter_index;
-        }
-
-        /* netsh interface ipv6 delete route 2001:db8::/32 42 */
-        argv_printf(&argv, "%s%s interface ipv6 delete route %s/%d %lu",
-                    get_win_sys_path(),
-                    NETSH_PATH_SUFFIX,
-                    network,
-                    r6->netbits,
-                    adapter_index);
-
-        /* next-hop depends on TUN or TAP mode:
-         * - in TAP mode, we use the "real" next-hop
-         * - in TUN mode we use a special-case link-local address that the tapdrvr
-         *   knows about and will answer ND (neighbor discovery) packets for
-         * (and "route deletion without specifying next-hop" does not work...)
-         */
-        if (tt->type == DEV_TYPE_TUN && !gateway_needed)
-        {
-            argv_printf_cat( &argv, " %s", "fe80::8" );
-        }
-        else if (!IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
-        {
-            argv_printf_cat( &argv, " %s", gateway );
-        }
-
-#if 0
-        if (r6->flags & RT_METRIC_DEFINED)
-        {
-            argv_printf_cat(&argv, "METRIC %d", r->metric);
-        }
-#endif
-
-        /* Windows XP to 7 "just delete" routes, wherever they came from, but
-         * in Windows 8(.1?), if you create them with "store=active", this is
-         * how you should delete them as well (pointed out by Cedric Tabary)
-         */
-        argv_printf_cat( &argv, " store=active" );
-
-        argv_msg(D_ROUTE, &argv);
-
-        netcmd_semaphore_lock();
-        openvpn_execve_check(&argv, es, 0, "ERROR: Windows route delete ipv6 command failed");
-        netcmd_semaphore_release();
+        route_ipv6_ipapi(false, r6, tt);
     }
-
 #elif defined (TARGET_SOLARIS)
 
     /* example: route delete -inet6 2001:db8::/32 somegateway */
@@ -3049,6 +2949,73 @@ do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct t
     return do_route_service(add, &msg, sizeof(msg), tt->options.msg_channel);
 }
 
+/* Add or delete an ipv6 route */
+static bool
+route_ipv6_ipapi(const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
+{
+    DWORD err;
+    PMIB_IPFORWARD_ROW2 fwd_row;
+    struct gc_arena gc = gc_new();
+
+    fwd_row = gc_malloc(sizeof(*fwd_row), true, &gc);
+
+    fwd_row->ValidLifetime = 0xffffffff;
+    fwd_row->PreferredLifetime = 0xffffffff;
+    fwd_row->Protocol = MIB_IPPROTO_NETMGMT;
+    fwd_row->Metric = ((r->flags & RT_METRIC_DEFINED) ? r->metric : -1);
+    fwd_row->DestinationPrefix.Prefix.si_family = AF_INET6;
+    fwd_row->DestinationPrefix.Prefix.Ipv6.sin6_addr = r->network;
+    fwd_row->DestinationPrefix.PrefixLength = (UINT8) r->netbits;
+    fwd_row->NextHop.si_family = AF_INET6;
+    fwd_row->NextHop.Ipv6.sin6_addr = r->gateway;
+    fwd_row->InterfaceIndex = r->adapter_index ? r->adapter_index : tt->adapter_index;
+
+    /* In TUN mode we use a special link-local address as the next hop.
+     * The tapdrvr knows about it and will answer neighbor discovery packets.
+     * (only do this for routes actually using the tun/tap device)
+     */
+    if (tt->type == DEV_TYPE_TUN && !r->adapter_index)
+    {
+        inet_pton(AF_INET6, "fe80::8", &fwd_row->NextHop.Ipv6.sin6_addr);
+    }
+
+    /* Use LUID if interface index not available */
+    if (fwd_row->InterfaceIndex == TUN_ADAPTER_INDEX_INVALID && strlen(tt->actual_name))
+    {
+        NET_LUID luid;
+        err = ConvertInterfaceAliasToLuid(wide_string(tt->actual_name, &gc), &luid);
+        if (err != NO_ERROR)
+        {
+            goto out;
+        }
+        fwd_row->InterfaceLuid = luid;
+        fwd_row->InterfaceIndex = 0;
+    }
+
+    if (add)
+    {
+        err = CreateIpForwardEntry2(fwd_row);
+    }
+    else
+    {
+        err = DeleteIpForwardEntry2(fwd_row);
+    }
+
+out:
+    if (err != NO_ERROR)
+    {
+        msg(M_WARN, "ROUTE: route %s failed using ipapi: %s [status=%lu if_index=%lu]",
+            (add ? "addition" : "deletion"), strerror_win32(err, &gc), err, fwd_row->InterfaceIndex);
+    }
+    else
+    {
+        msg(D_ROUTE, "IPv6 route %s using ipapi", add ? "added" : "deleted");
+    }
+    gc_free(&gc);
+
+    return (err == NO_ERROR);
+}
+
 static bool
 do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
 {
-- 
2.34.1


