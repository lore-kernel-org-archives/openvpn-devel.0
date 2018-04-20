From: Antonio Quartulli <a@...2181...>
Date: Fri, 20 Apr 2018 19:16:19 +0800
Message-Id: <20180420111624.7230-4-a@...2181...>
In-Reply-To: <20180420111624.7230-1-a@...2181...>
References: <20180420111624.7230-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 3/8] tun.c: use new networking API to handle
 tun interface on Linux
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
Cc: Antonio Quartulli <a@...2181...>

By switching to the networking API (for Linux) openvpn will
now use any of the available implementations to handle the tun
interface.

At the moment only iproute2 is implemented.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/tun.c | 199 ++++++++++++++--------------------------------
 1 file changed, 58 insertions(+), 141 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 263cacdf..3eec6899 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -46,6 +46,7 @@
 #include "route.h"
 #include "win32.h"
 #include "block_dns.h"
+#include "networking.h"
 
 #include "memdbg.h"
 
@@ -883,10 +884,12 @@ do_ifconfig(struct tuntap *tt,
     if (tt->did_ifconfig_setup)
     {
         bool tun = false;
+#if !defined(TARGET_LINUX)
         const char *ifconfig_local = NULL;
         const char *ifconfig_remote_netmask = NULL;
         const char *ifconfig_broadcast = NULL;
         const char *ifconfig_ipv6_local = NULL;
+#endif
         bool do_ipv6 = false;
         struct argv argv = argv_new();
 
@@ -898,18 +901,23 @@ do_ifconfig(struct tuntap *tt,
          */
         tun = is_tun_p2p(tt);
 
+#if !defined(TARGET_LINUX)
         /*
          * Set ifconfig parameters
          */
         ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
         ifconfig_remote_netmask = print_in_addr_t(tt->remote_netmask, 0, &gc);
+#endif
 
         if (tt->did_ifconfig_ipv6_setup)
         {
+#if !defined(TARGET_LINUX)
             ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
+#endif
             do_ipv6 = true;
         }
 
+#if !defined(TARGET_LINUX)
         /*
          * If TAP-style device, generate broadcast address.
          */
@@ -917,6 +925,7 @@ do_ifconfig(struct tuntap *tt,
         {
             ifconfig_broadcast = print_in_addr_t(tt->broadcast, 0, &gc);
         }
+#endif
 
 #ifdef ENABLE_MANAGEMENT
         if (management)
@@ -933,102 +942,42 @@ do_ifconfig(struct tuntap *tt,
 
 
 #if defined(TARGET_LINUX)
-#ifdef ENABLE_IPROUTE
-        /*
-         * Set the MTU for the device
-         */
-        argv_printf(&argv,
-                    "%s link set dev %s up mtu %d",
-                    iproute_path,
-                    actual,
-                    tun_mtu
-                    );
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "Linux ip link set failed");
-
-        if (tun)
-        {
-
-            /*
-             * Set the address for the device
-             */
-            argv_printf(&argv,
-                        "%s addr add dev %s local %s peer %s",
-                        iproute_path,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
-        }
-        else
+        if (net_iface_mtu_set(actual, tun_mtu) < 0)
         {
-            argv_printf(&argv,
-                        "%s addr add dev %s %s/%d broadcast %s",
-                        iproute_path,
-                        actual,
-                        ifconfig_local,
-                        netmask_to_netbits2(tt->remote_netmask),
-                        ifconfig_broadcast
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
+            msg(M_FATAL, "Linux can't set mtu (%d) on %s", tun_mtu, actual);
         }
-        if (do_ipv6)
+
+        if (net_iface_up(actual, true) < 0)
         {
-            argv_printf( &argv,
-                         "%s -6 addr add %s/%d dev %s",
-                         iproute_path,
-                         ifconfig_ipv6_local,
-                         tt->netbits_ipv6,
-                         actual
-                         );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add failed");
+            msg(M_FATAL, "Linux can't bring %s up", actual);
         }
-        tt->did_ifconfig = true;
-#else  /* ifdef ENABLE_IPROUTE */
+
         if (tun)
         {
-            argv_printf(&argv,
-                        "%s %s %s pointopoint %s mtu %d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu
-                        );
+            if (net_addr_ptp_v4_add(actual, &tt->local,
+                                    &tt->remote_netmask) < 0)
+            {
+                msg(M_FATAL, "Linux can't add IP to TUN interface %s", actual);
+            }
         }
         else
         {
-            argv_printf(&argv,
-                        "%s %s %s netmask %s mtu %d broadcast %s",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_local,
-                        ifconfig_remote_netmask,
-                        tun_mtu,
-                        ifconfig_broadcast
-                        );
+            if (net_addr_v4_add(actual, &tt->local,
+                                netmask_to_netbits2(tt->remote_netmask),
+                                &tt->remote_netmask) < 0)
+            {
+                msg(M_FATAL, "Linux can't add IP to TAP interface %s", actual);
+            }
         }
-        argv_msg(M_INFO, &argv);
-        openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig failed");
         if (do_ipv6)
         {
-            argv_printf(&argv,
-                        "%s %s add %s/%d",
-                        IFCONFIG_PATH,
-                        actual,
-                        ifconfig_ipv6_local,
-                        tt->netbits_ipv6
-                        );
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, es, S_FATAL, "Linux ifconfig inet6 failed");
+            if (net_addr_v6_add(actual, &tt->local_ipv6, tt->netbits_ipv6) < 0)
+            {
+                msg(M_FATAL, "Linux can't add IPv6 to interface %s", actual);
+            }
         }
         tt->did_ifconfig = true;
 
-#endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_ANDROID)
 
         if (do_ipv6)
@@ -2103,77 +2052,45 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_
 void
 close_tun(struct tuntap *tt)
 {
-    if (tt)
+    if (!tt)
     {
-        if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig)
-        {
-            struct argv argv = argv_new();
-            struct gc_arena gc = gc_new();
+        return;
+    }
 
-#ifdef ENABLE_IPROUTE
-            if (is_tun_p2p(tt))
+    if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig)
+    {
+        int netbits = netmask_to_netbits2(tt->remote_netmask);
+        if (is_tun_p2p(tt))
+        {
+            if (net_addr_ptp_v4_del(tt->actual_name, &tt->local,
+                                    &tt->remote_netmask) < 0)
             {
-                argv_printf(&argv,
-                            "%s addr del dev %s local %s peer %s",
-                            iproute_path,
-                            tt->actual_name,
-                            print_in_addr_t(tt->local, 0, &gc),
-                            print_in_addr_t(tt->remote_netmask, 0, &gc)
-                            );
+                msg(M_WARN, "Linux can't del IP from TUN iface %s",
+                    tt->actual_name);
             }
-            else
+        }
+        else
+        {
+            if (net_addr_v4_del(tt->actual_name, &tt->local, netbits) < 0)
             {
-                argv_printf(&argv,
-                            "%s addr del dev %s %s/%d",
-                            iproute_path,
-                            tt->actual_name,
-                            print_in_addr_t(tt->local, 0, &gc),
-                            netmask_to_netbits2(tt->remote_netmask)
-                            );
+                msg(M_WARN, "Linux can't del IP from TAP iface %s",
+                    tt->actual_name);
             }
-#else  /* ifdef ENABLE_IPROUTE */
-            argv_printf(&argv,
-                        "%s %s 0.0.0.0",
-                        IFCONFIG_PATH,
-                        tt->actual_name
-                        );
-#endif /* ifdef ENABLE_IPROUTE */
-
-            argv_msg(M_INFO, &argv);
-            openvpn_execve_check(&argv, NULL, 0, "Linux ip addr del failed");
+        }
 
-            if (tt->did_ifconfig_ipv6_setup)
+        if (tt->did_ifconfig_ipv6_setup)
+        {
+            if (net_addr_v6_del(tt->actual_name, &tt->local_ipv6,
+                                tt->netbits_ipv6) < 0)
             {
-                const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
-
-#ifdef ENABLE_IPROUTE
-                argv_printf(&argv, "%s -6 addr del %s/%d dev %s",
-                            iproute_path,
-                            ifconfig_ipv6_local,
-                            tt->netbits_ipv6,
-                            tt->actual_name
-                            );
-                argv_msg(M_INFO, &argv);
-                openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
-#else  /* ifdef ENABLE_IPROUTE */
-                argv_printf(&argv,
-                            "%s %s del %s/%d",
-                            IFCONFIG_PATH,
-                            tt->actual_name,
-                            ifconfig_ipv6_local,
-                            tt->netbits_ipv6
-                            );
-                argv_msg(M_INFO, &argv);
-                openvpn_execve_check(&argv, NULL, 0, "Linux ifconfig inet6 del failed");
-#endif
+                msg(M_WARN, "Linux can't del IPv6 from iface %s",
+                    tt->actual_name);
             }
-
-            argv_reset(&argv);
-            gc_free(&gc);
         }
-        close_tun_generic(tt);
-        free(tt);
     }
+
+    close_tun_generic(tt);
+    free(tt);
 }
 
 int
-- 
2.17.0


