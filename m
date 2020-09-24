From: Simon Rozman <simon@...2293...>
Date: Thu, 24 Sep 2020 08:44:50 +0200
Message-Id: <20200924064452.1001-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] netsh: Specify interfaces by index
 rather than name
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

This is more efficient and less error prone.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/route.c | 26 +++++++-------
 src/openvpn/tun.c   | 88 +++++++++++++++++++++------------------------
 2 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bd6b968b..d75aa5f4 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1987,25 +1987,24 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     }
     else
     {
-        struct buffer out = alloc_buf_gc(64, &gc);
+        DWORD adapter_index;
         if (r6->adapter_index)          /* vpn server special route */
         {
-            buf_printf(&out, "interface=%lu", r6->adapter_index );
+            adapter_index = r6->adapter_index;
             gateway_needed = true;
         }
         else
         {
-            buf_printf(&out, "interface=%lu", tt->adapter_index );
+            adapter_index = tt->adapter_index;
         }
-        device = buf_bptr(&out);
 
-        /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
-        argv_printf(&argv, "%s%s interface ipv6 add route %s/%d %s",
+        /* netsh interface ipv6 add route 2001:db8::/32 42 */
+        argv_printf(&argv, "%s%s interface ipv6 add route %s/%d %lu",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     network,
                     r6->netbits,
-                    device);
+                    adapter_index);
 
         /* next-hop depends on TUN or TAP mode:
          * - in TAP mode, we use the "real" next-hop
@@ -2431,25 +2430,24 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     }
     else
     {
-        struct buffer out = alloc_buf_gc(64, &gc);
+        DWORD adapter_index;
         if (r6->adapter_index)          /* vpn server special route */
         {
-            buf_printf(&out, "interface=%lu", r6->adapter_index );
+            adapter_index = r6->adapter_index;
             gateway_needed = true;
         }
         else
         {
-            buf_printf(&out, "interface=%lu", tt->adapter_index );
+            adapter_index = tt->adapter_index;
         }
-        device = buf_bptr(&out);
 
-        /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
-        argv_printf(&argv, "%s%s interface ipv6 delete route %s/%d %s",
+        /* netsh interface ipv6 delete route 2001:db8::/32 42 */
+        argv_printf(&argv, "%s%s interface ipv6 delete route %s/%d %lu",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     network,
                     r6->netbits,
-                    device);
+                    adapter_index);
 
         /* next-hop depends on TUN or TAP mode:
          * - in TAP mode, we use the "real" next-hop
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index faa02504..8fd3229f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -68,7 +68,7 @@ const static GUID GUID_DEVINTERFACE_NET = { 0xcac88484, 0x7515, 0x4c03, { 0x82,
 #define NI_OPTIONS     (1<<2)
 
 static void netsh_ifconfig(const struct tuntap_options *to,
-                           const char *flex_name,
+                           DWORD adapter_index,
                            const in_addr_t ip,
                            const in_addr_t netmask,
                            const unsigned int flags);
@@ -79,7 +79,7 @@ static void windows_set_mtu(const int iface_index,
 
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
                                    const int addr_len,
-                                   const char *flex_name);
+                                   DWORD adapter_index);
 
 static void netsh_command(const struct argv *a, int n, int msglevel);
 
@@ -1103,10 +1103,9 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     }
     else
     {
-        /* example: netsh interface ipv6 set address interface=42
+        /* example: netsh interface ipv6 set address 42
          *                  2001:608:8003::d/bits store=active
          */
-        char iface[64];
 
         /* in TUN mode, we only simulate a subnet, so the interface
          * is configured with /128 + a route to fe80::8.  In TAP mode,
@@ -1114,10 +1113,8 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
          */
         int netbits = (tt->type == DEV_TYPE_TUN) ? 128 : tt->netbits_ipv6;
 
-        openvpn_snprintf(iface, sizeof(iface), "interface=%lu",
-                         tt->adapter_index);
-        argv_printf(&argv, "%s%s interface ipv6 set address %s %s/%d store=active",
-                    get_win_sys_path(), NETSH_PATH_SUFFIX, iface,
+        argv_printf(&argv, "%s%s interface ipv6 set address %lu %s/%d store=active",
+                    get_win_sys_path(), NETSH_PATH_SUFFIX, tt->adapter_index,
                     ifconfig_ipv6_local, netbits);
         netsh_command(&argv, 4, M_FATAL);
         if (tt->type == DEV_TYPE_TUN)
@@ -1125,7 +1122,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
             add_route_connected_v6_net(tt, es);
         }
         /* set ipv6 dns servers if any are specified */
-        netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
+        netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, tt->adapter_index);
         windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
     }
 #else /* platforms we have no IPv6 code for */
@@ -1473,8 +1470,6 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         env_set_destroy(aix_es);
     }
 #elif defined (_WIN32)
-    ASSERT(ifname != NULL);
-
     if (tt->options.ip_win32_type == IPW32_SET_MANUAL)
     {
         msg(M_INFO,
@@ -1493,7 +1488,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     }
     else if (tt->options.ip_win32_type == IPW32_SET_NETSH)
     {
-        netsh_ifconfig(&tt->options, ifname, tt->local,
+        netsh_ifconfig(&tt->options, tt->adapter_index, tt->local,
                        tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
     }
     if (tt->options.msg_channel)
@@ -5291,7 +5286,7 @@ ip_addr_member_of(const in_addr_t addr, const IP_ADDR_STRING *ias)
 static void
 netsh_set_dns6_servers(const struct in6_addr *addr_list,
                        const int addr_len,
-                       const char *flex_name)
+                       DWORD adapter_index)
 {
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
@@ -5299,10 +5294,10 @@ netsh_set_dns6_servers(const struct in6_addr *addr_list,
     for (int i = 0; i < addr_len; ++i)
     {
         const char *fmt = (i == 0) ?
-                          "%s%s interface ipv6 set dns %s static %s"
-                          : "%s%s interface ipv6 add dns %s %s";
+                          "%s%s interface ipv6 set dns %lu static %s"
+                          : "%s%s interface ipv6 add dns %lu %s";
         argv_printf(&argv, fmt, get_win_sys_path(),
-                    NETSH_PATH_SUFFIX, flex_name,
+                    NETSH_PATH_SUFFIX, adapter_index,
                     print_in6_addr(addr_list[i], 0, &gc));
 
         /* disable slow address validation on Windows 7 and higher */
@@ -5324,7 +5319,7 @@ netsh_ifconfig_options(const char *type,
                        const in_addr_t *addr_list,
                        const int addr_len,
                        const IP_ADDR_STRING *current,
-                       const char *flex_name,
+                       DWORD adapter_index,
                        const bool test_first)
 {
     struct gc_arena gc = gc_new();
@@ -5348,11 +5343,11 @@ netsh_ifconfig_options(const char *type,
     /* delete existing DNS/WINS settings from TAP interface */
     if (delete_first)
     {
-        argv_printf(&argv, "%s%s interface ip delete %s %s all",
+        argv_printf(&argv, "%s%s interface ip delete %s %lu all",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     type,
-                    flex_name);
+                    adapter_index);
         netsh_command(&argv, 2, M_FATAL);
     }
 
@@ -5365,14 +5360,14 @@ netsh_ifconfig_options(const char *type,
             if (delete_first || !test_first || !ip_addr_member_of(addr_list[i], current))
             {
                 const char *fmt = count ?
-                                  "%s%s interface ip add %s %s %s"
-                                  : "%s%s interface ip set %s %s static %s";
+                                  "%s%s interface ip add %s %lu %s"
+                                  : "%s%s interface ip set %s %lu static %s";
 
                 argv_printf(&argv, fmt,
                             get_win_sys_path(),
                             NETSH_PATH_SUFFIX,
                             type,
-                            flex_name,
+                            adapter_index,
                             print_in_addr_t(addr_list[i], 0, &gc));
 
                 /* disable slow address validation on Windows 7 and higher */
@@ -5388,8 +5383,8 @@ netsh_ifconfig_options(const char *type,
             }
             else
             {
-                msg(M_INFO, "NETSH: \"%s\" %s %s [already set]",
-                    flex_name,
+                msg(M_INFO, "NETSH: %lu %s %s [already set]",
+                    adapter_index,
                     type,
                     print_in_addr_t(addr_list[i], 0, &gc));
             }
@@ -5420,7 +5415,7 @@ init_ip_addr_string2(IP_ADDR_STRING *dest, const IP_ADDR_STRING *src1, const IP_
 
 static void
 netsh_ifconfig(const struct tuntap_options *to,
-               const char *flex_name,
+               DWORD adapter_index,
                const in_addr_t ip,
                const in_addr_t netmask,
                const unsigned int flags)
@@ -5433,27 +5428,26 @@ netsh_ifconfig(const struct tuntap_options *to,
     if (flags & NI_TEST_FIRST)
     {
         const IP_ADAPTER_INFO *list = get_adapter_info_list(&gc);
-        const int index = get_adapter_index_flexible(flex_name);
-        ai = get_adapter(list, index);
-        pai = get_per_adapter_info(index, &gc);
+        ai = get_adapter(list, adapter_index);
+        pai = get_per_adapter_info(adapter_index, &gc);
     }
 
     if (flags & NI_IP_NETMASK)
     {
         if (test_adapter_ip_netmask(ai, ip, netmask))
         {
-            msg(M_INFO, "NETSH: \"%s\" %s/%s [already set]",
-                flex_name,
+            msg(M_INFO, "NETSH: %lu %s/%s [already set]",
+                adapter_index,
                 print_in_addr_t(ip, 0, &gc),
                 print_in_addr_t(netmask, 0, &gc));
         }
         else
         {
-            /* example: netsh interface ip set address my-tap static 10.3.0.1 255.255.255.0 */
-            argv_printf(&argv, "%s%s interface ip set address %s static %s %s",
+            /* example: netsh interface ip set address 42 static 10.3.0.1 255.255.255.0 */
+            argv_printf(&argv, "%s%s interface ip set address %lu static %s %s",
                         get_win_sys_path(),
                         NETSH_PATH_SUFFIX,
-                        flex_name,
+                        adapter_index,
                         print_in_addr_t(ip, 0, &gc),
                         print_in_addr_t(netmask, 0, &gc));
 
@@ -5472,7 +5466,7 @@ netsh_ifconfig(const struct tuntap_options *to,
                                to->dns,
                                to->dns_len,
                                pai ? &pai->DnsServerList : NULL,
-                               flex_name,
+                               adapter_index,
                                BOOL_CAST(flags & NI_TEST_FIRST));
         if (ai && ai->HaveWins)
         {
@@ -5483,7 +5477,7 @@ netsh_ifconfig(const struct tuntap_options *to,
                                to->wins,
                                to->wins_len,
                                ai ? wins : NULL,
-                               flex_name,
+                               adapter_index,
                                BOOL_CAST(flags & NI_TEST_FIRST));
     }
 
@@ -5492,16 +5486,16 @@ netsh_ifconfig(const struct tuntap_options *to,
 }
 
 static void
-netsh_enable_dhcp(const char *actual_name)
+netsh_enable_dhcp(DWORD adapter_index)
 {
     struct argv argv = argv_new();
 
-    /* example: netsh interface ip set address my-tap dhcp */
+    /* example: netsh interface ip set address 42 dhcp */
     argv_printf(&argv,
-                "%s%s interface ip set address %s dhcp",
+                "%s%s interface ip set address %lu dhcp",
                 get_win_sys_path(),
                 NETSH_PATH_SUFFIX,
-                actual_name);
+                adapter_index);
 
     netsh_command(&argv, 4, M_FATAL);
 
@@ -5647,7 +5641,7 @@ tun_standby(struct tuntap *tt)
         {
             msg(M_INFO, "NOTE: now trying netsh (this may take some time)");
             netsh_ifconfig(&tt->options,
-                           tt->actual_name,
+                           tt->adapter_index,
                            tt->local,
                            tt->adapter_netmask,
                            NI_TEST_FIRST|NI_IP_NETMASK|NI_OPTIONS);
@@ -6552,7 +6546,7 @@ tuntap_set_ip_props(const struct tuntap *tt, bool *dhcp_masq, bool *dhcp_masq_po
             }
             else
             {
-                netsh_enable_dhcp(tt->actual_name);
+                netsh_enable_dhcp(tt->adapter_index);
             }
         }
         *dhcp_masq = true;
@@ -6566,7 +6560,7 @@ tuntap_set_ip_props(const struct tuntap *tt, bool *dhcp_masq, bool *dhcp_masq_po
         if (dhcp_status(tt->adapter_index) != DHCP_STATUS_ENABLED)
         {
             netsh_ifconfig(&tt->options,
-                           tt->actual_name,
+                           tt->adapter_index,
                            tt->local,
                            tt->adapter_netmask,
                            NI_TEST_FIRST | NI_IP_NETMASK | NI_OPTIONS);
@@ -6698,11 +6692,11 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
     if (len > 0)
     {
         argv_printf(&argv,
-                    "%s%s interface %s delete dns %s all",
+                    "%s%s interface %s delete dns %lu all",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     ipv6 ? "ipv6" : "ipv4",
-                    tt->actual_name);
+                    tt->adapter_index);
         netsh_command(&argv, 1, M_WARN);
     }
 
@@ -6715,7 +6709,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
      * address we added (pointed out by Cedric Tabary).
      */
 
-    /* netsh interface ipvX delete address \"%s\" %s */
+    /* netsh interface ipvX delete address %lu %s */
     if (ipv6)
     {
         ifconfig_ip_local = print_in6_addr(tt->local_ipv6, 0, gc);
@@ -6725,11 +6719,11 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
         ifconfig_ip_local = print_in_addr_t(tt->local, 0, gc);
     }
     argv_printf(&argv,
-                "%s%s interface %s delete address %s %s store=active",
+                "%s%s interface %s delete address %lu %s store=active",
                 get_win_sys_path(),
                 NETSH_PATH_SUFFIX,
                 ipv6 ? "ipv6" : "ipv4",
-                tt->actual_name,
+                tt->adapter_index,
                 ifconfig_ip_local);
     netsh_command(&argv, 1, M_WARN);
 
-- 
2.28.0.windows.1


