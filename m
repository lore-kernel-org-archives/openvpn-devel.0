From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  7 Nov 2019 19:45:29 +0200
Message-Id: <1573148729-27339-8-git-send-email-lstipakov@...277...>
In-Reply-To: <1573148729-27339-1-git-send-email-lstipakov@...277...>
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2 7/7] wintun: clear adapter settings on
 tun close
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

With tap-windows6 we clear adapter settings with DHCP,
but since wintun doesn't do DHCP we do it with netsh.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 79 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index c3ea4a8..9bdd707 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6369,6 +6369,50 @@ tun_show_debug(struct tuntap *tt)
     }
 }
 
+static void
+netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc)
+{
+    const char* ifconfig_ip_local;
+    struct argv argv = argv_new();
+
+    /* "store=active" is needed in Windows 8(.1) to delete the
+     * address we added (pointed out by Cedric Tabary).
+     */
+
+     /* netsh interface ipvX delete address \"%s\" %s */
+    if (ipv6)
+    {
+        ifconfig_ip_local = print_in6_addr(tt->local_ipv6, 0, gc);
+    }
+    else
+    {
+        ifconfig_ip_local = print_in_addr_t(tt->local, 0, gc);
+    }
+    argv_printf(&argv,
+                "%s%sc interface %s delete address %s %s store=active",
+                get_win_sys_path(),
+                NETSH_PATH_SUFFIX,
+                ipv6 ? "ipv6" : "ipv4",
+                tt->actual_name,
+                ifconfig_ip_local);
+
+    netsh_command(&argv, 1, M_WARN);
+
+    /* delete ipvX dns servers if any were set */
+    int len = ipv6 ? tt->options.dns6_len : tt->options.dns_len;
+    if (len > 0)
+    {
+        argv_printf(&argv,
+                    "%s%sc interface %s delete dns %s all",
+                    get_win_sys_path(),
+                    NETSH_PATH_SUFFIX,
+                    ipv6 ? "ipv6" : "ipv4",
+                    tt->actual_name);
+        netsh_command(&argv, 1, M_WARN);
+    }
+    argv_reset(&argv);
+}
+
 void
 close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
@@ -6391,35 +6435,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
         else
         {
-            const char *ifconfig_ipv6_local;
-            struct argv argv = argv_new();
-
-            /* "store=active" is needed in Windows 8(.1) to delete the
-             * address we added (pointed out by Cedric Tabary).
-             */
-
-            /* netsh interface ipv6 delete address \"%s\" %s */
-            ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0,  &gc);
-            argv_printf(&argv,
-                        "%s%sc interface ipv6 delete address %s %s store=active",
-                        get_win_sys_path(),
-                        NETSH_PATH_SUFFIX,
-                        tt->actual_name,
-                        ifconfig_ipv6_local);
-
-            netsh_command(&argv, 1, M_WARN);
-
-            /* delete ipv6 dns servers if any were set */
-            if (tt->options.dns6_len > 0)
-            {
-                argv_printf(&argv,
-                            "%s%sc interface ipv6 delete dns %s all",
-                            get_win_sys_path(),
-                            NETSH_PATH_SUFFIX,
-                            tt->actual_name);
-                netsh_command(&argv, 1, M_WARN);
-            }
-            argv_reset(&argv);
+            netsh_delete_address_dns(tt, true, &gc);
         }
     }
 #if 1
@@ -6441,6 +6457,11 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
                 strerror_win32(status, &gc));
         }
     }
+    else
+    if (tt->wintun)
+    {
+        netsh_delete_address_dns(tt, false, &gc);
+    }
 #endif
 
     dhcp_release(tt);
-- 
2.7.4


