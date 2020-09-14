From: Gert Doering <gert@...1296...>
Date: Mon, 14 Sep 2020 20:23:23 +0200
Message-Id: <20200914182323.71971-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix netbits setting (in TAP mode) for IPv6
 on Windows.
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

For TUN interfaces, the IPv6 address needs to be configured with
"address/128" and a local subnet route is needed, pointing to our
fake gateway fe80::8.  There is no ethernet headers or ND outside
the tun/tap interface, so anything but fe80::8 is not resolvable.

For TAP interfaces, the proper subnet mask (netbits) must be configured,
and no connected route to "our local host address" must be configured,
to make make IPv6 ND work inside the local subnet.

Our code was nicely consistent in doing the same thing in tun.c
("gui/openvpn running with admin privileges") and in the requests
to the interactive service ("gui running with user privs").  Fix in
both places.

On tun close, symmetric to addition, remove the on-link subnet route only
for "tun" interfaces.  Address removal works without specifying netbits.

While at it, extend do_address_service() to actually log both IPv4
and IPv6 addresses requested via it.

Tested on Win10/64.

Reported-By: Laurent Fasnacht <l@...2534...>
Reported-By: Klara Mall <klara.mall@...2577...>
Trac: #1054

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index fde94294..8b3a3b8a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -115,11 +115,15 @@ do_address_service(const bool add, const short family, const struct tuntap *tt)
     {
         addr.address.ipv4.s_addr = htonl(tt->local);
         addr.prefix_len = netmask_to_netbits2(tt->adapter_netmask);
+        msg(D_ROUTE, "INET address service: %s %s/%d", add? "add": "remove",
+            print_in_addr_t(tt->local, 0, &gc), addr.prefix_len);
     }
     else
     {
         addr.address.ipv6 = tt->local_ipv6;
-        addr.prefix_len = tt->netbits_ipv6;
+        addr.prefix_len = (tt->type == DEV_TYPE_TUN)? 128: tt->netbits_ipv6;
+        msg(D_ROUTE, "INET6 address service: %s %s/%d", add? "add": "remove",
+            print_in6_addr(tt->local_ipv6, 0, &gc), addr.prefix_len);
     }
 
     if (!send_msg_iservice(pipe, &addr, sizeof(addr), &ack, "TUN"))
@@ -1088,24 +1092,36 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     else if (tt->options.msg_channel)
     {
         do_address_service(true, AF_INET6, tt);
-        add_route_connected_v6_net(tt, es);
+        if (tt->type == DEV_TYPE_TUN)
+        {
+            add_route_connected_v6_net(tt, es);
+        }
         do_dns_service(true, AF_INET6, tt);
         do_set_mtu_service(tt, AF_INET6, tun_mtu);
     }
     else
     {
         /* example: netsh interface ipv6 set address interface=42
-         *                  2001:608:8003::d store=active
+         *                  2001:608:8003::d/bits store=active
          */
         char iface[64];
 
+        /* in TUN mode, we only simulate a subnet, so the interface
+         * is configured with /128 + a route to fe80::8.  In TAP mode,
+         * the correct netbits must be set, and no on-link route
+         */
+        int netbits = (tt->type == DEV_TYPE_TUN)? 128: tt->netbits_ipv6;
+
         openvpn_snprintf(iface, sizeof(iface), "interface=%lu",
                          tt->adapter_index);
-        argv_printf(&argv, "%s%s interface ipv6 set address %s %s store=active",
+        argv_printf(&argv, "%s%s interface ipv6 set address %s %s/%d store=active",
                     get_win_sys_path(), NETSH_PATH_SUFFIX, iface,
-                    ifconfig_ipv6_local);
+                    ifconfig_ipv6_local, netbits);
         netsh_command(&argv, 4, M_FATAL);
-        add_route_connected_v6_net(tt, es);
+        if (tt->type == DEV_TYPE_TUN)
+        {
+            add_route_connected_v6_net(tt, es);
+        }
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
         windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
@@ -6688,7 +6704,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
         netsh_command(&argv, 1, M_WARN);
     }
 
-    if (ipv6)
+    if (ipv6 && tt->type == DEV_TYPE_TUN)
     {
         delete_route_connected_v6_net(tt);
     }
-- 
2.28.0


