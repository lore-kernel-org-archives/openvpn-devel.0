From: Simon Rozman <simon@...2293...>
Date: Tue, 10 Mar 2020 10:48:21 +0100
Message-Id: <20200310094822.588-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] tun.c: reorder IPv6 ifconfig on Windows
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

The IPv6 interface network route should be setup as soon as possible
after the interface address is set. Actually, all routes should be added
before DNS servers are configured. This would allow Windows to validate
DNS servers properly instead of shutting the validation off.

The cleanup order has been changed to match reverse order of ifconfig.
An additional check was added to skip the cleanup when --ip-win32 is set
to manual.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 51 +++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 1f848d24..42193d97 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1016,6 +1016,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     else if (tt->options.msg_channel)
     {
         do_address_service(true, AF_INET6, tt);
+        add_route_connected_v6_net(tt, es);
         do_dns_service(true, AF_INET6, tt);
     }
     else
@@ -1031,15 +1032,10 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
                     get_win_sys_path(), NETSH_PATH_SUFFIX, iface,
                     ifconfig_ipv6_local);
         netsh_command(&argv, 4, M_FATAL);
+        add_route_connected_v6_net(tt, es);
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
     }
-
-    /* explicit route needed */
-    if (tt->options.ip_win32_type != IPW32_SET_MANUAL)
-    {
-        add_route_connected_v6_net(tt, es);
-    }
 #else /* platforms we have no IPv6 code for */
     msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* outer "if defined(TARGET_xxx)" conditional */
@@ -6467,6 +6463,24 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
     const char *ifconfig_ip_local;
     struct argv argv = argv_new();
 
+    /* delete ipvX dns servers if any were set */
+    int len = ipv6 ? tt->options.dns6_len : tt->options.dns_len;
+    if (len > 0)
+    {
+        argv_printf(&argv,
+                    "%s%s interface %s delete dns %s all",
+                    get_win_sys_path(),
+                    NETSH_PATH_SUFFIX,
+                    ipv6 ? "ipv6" : "ipv4",
+                    tt->actual_name);
+        netsh_command(&argv, 1, M_WARN);
+    }
+
+    if (ipv6)
+    {
+        delete_route_connected_v6_net(tt, NULL);
+    }
+
     /* "store=active" is needed in Windows 8(.1) to delete the
      * address we added (pointed out by Cedric Tabary).
      */
@@ -6487,21 +6501,8 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
                 ipv6 ? "ipv6" : "ipv4",
                 tt->actual_name,
                 ifconfig_ip_local);
-
     netsh_command(&argv, 1, M_WARN);
 
-    /* delete ipvX dns servers if any were set */
-    int len = ipv6 ? tt->options.dns6_len : tt->options.dns_len;
-    if (len > 0)
-    {
-        argv_printf(&argv,
-                    "%s%s interface %s delete dns %s all",
-                    get_win_sys_path(),
-                    NETSH_PATH_SUFFIX,
-                    ipv6 ? "ipv6" : "ipv4",
-                    tt->actual_name);
-        netsh_command(&argv, 1, M_WARN);
-    }
     argv_free(&argv);
 }
 
@@ -6514,16 +6515,18 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 
     if (tt->did_ifconfig_ipv6_setup)
     {
-        /* remove route pointing to interface */
-        delete_route_connected_v6_net(tt, NULL);
-
-        if (tt->options.msg_channel)
+        if (tt->options.ip_win32_type == IPW32_SET_MANUAL)
+        {
+            /* We didn't do ifconfig. */
+        }
+        else if (tt->options.msg_channel)
         {
-            do_address_service(false, AF_INET6, tt);
             if (tt->options.dns6_len > 0)
             {
                 do_dns_service(false, AF_INET6, tt);
             }
+            delete_route_connected_v6_net(tt, NULL);
+            do_address_service(false, AF_INET6, tt);
         }
         else
         {
-- 
2.24.1.windows.2


