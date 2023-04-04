From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  4 Apr 2023 10:59:32 +0300
Message-Id: <20230404075931.840-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Support of DNS domain for DHCP-less drivers
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

We set DNS domain either via interactve service or DHCP.
When interactive service is not used, for example,
when profiles are started by OpenVPNService, this option
is not working for DCO and wintun.

This implements setting DNS domain via WMIC command,
similar to implementation in interactive service.
This is done when:

 - interactive service is not used
 - ip_win32_type is either METSH or IPAPI, which is
the case for DCO and wintun.

Fixes https://github.com/OpenVPN/openvpn/issues/306

Change-Id: I9ab51bf1c0774564204c75ecce9ebfb818db2f5b
---
 src/openvpn/options.c |  8 ++---
 src/openvpn/tun.c     | 72 ++++++++++++++++++++++++++++++++++---------
 src/openvpn/tun.h     |  6 ++++
 src/openvpn/win32.h   |  1 +
 4 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2680f268..36d54ceb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3396,11 +3396,11 @@ options_postprocess_mutate_invariant(struct options *options)
 #ifdef _WIN32
     const int dev = dev_type_enum(options->dev, options->dev_type);
 
+    const bool dhcp = tuntap_maybe_dhcp(&options->tuntap_options);
+
     /* when using wintun/ovpn-dco, kernel doesn't send DHCP requests, so don't use it */
     if ((options->windows_driver == WINDOWS_DRIVER_WINTUN
-         || options->windows_driver == WINDOWS_DRIVER_DCO)
-        && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ
-            || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
+         || options->windows_driver == WINDOWS_DRIVER_DCO) && dhcp)
     {
         options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
     }
@@ -3408,8 +3408,6 @@ options_postprocess_mutate_invariant(struct options *options)
     if ((dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP) && !options->route_delay_defined)
     {
         /* delay may only be necessary when we perform DHCP handshake */
-        const bool dhcp = (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ)
-                          || (options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE);
         if ((options->mode == MODE_POINT_TO_POINT) && dhcp)
         {
             options->route_delay_defined = true;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2ebe4809..c2cc7e26 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -84,6 +84,8 @@ static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
 
 static void netsh_command(const struct argv *a, int n, int msglevel);
 
+static void exec_command(const char *prefix, const struct argv *a, int n, int msglevel);
+
 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);
 
 static bool
@@ -324,6 +326,22 @@ out:
     return ret;
 }
 
+static void
+wmic_do_dns_domain(bool add, const struct tuntap *tt)
+{
+    if (!tt->options.domain)
+    {
+        return;
+    }
+
+    struct argv argv = argv_new();
+    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=%ld) call SetDNSDomain %s",
+                get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index, add ? tt->options.domain : "");
+    exec_command("WMIC", &argv, 1, M_WARN);
+
+    argv_free(&argv);
+}
+
 #endif /* ifdef _WIN32 */
 
 #ifdef TARGET_SOLARIS
@@ -1190,6 +1208,11 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, tt->adapter_index);
         windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
+
+        if (!tt->did_ifconfig_setup && !tuntap_maybe_dhcp(&tt->options))
+        {
+            wmic_do_dns_domain(true, tt);
+        }
     }
 #else /* platforms we have no IPv6 code for */
     msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
@@ -1525,7 +1548,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
             ifname, ifconfig_local,
             ifconfig_remote_netmask);
     }
-    else if (tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ || tt->options.ip_win32_type == IPW32_SET_ADAPTIVE)
+    else if (tuntap_maybe_dhcp(&tt->options))
     {
         /* Let the DHCP configure the interface. */
     }
@@ -1535,11 +1558,18 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         do_dns_service(true, AF_INET, tt);
         do_dns_domain_service(true, tt);
     }
-    else if (tt->options.ip_win32_type == IPW32_SET_NETSH)
+    else
     {
-        netsh_ifconfig(&tt->options, tt->adapter_index, tt->local,
-                       tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
+        if (tt->options.ip_win32_type == IPW32_SET_NETSH)
+        {
+            netsh_ifconfig(&tt->options, tt->adapter_index, tt->local,
+                           tt->adapter_netmask, NI_IP_NETMASK | NI_OPTIONS);
+        }
+
+        wmic_do_dns_domain(true, tt);
     }
+
+
     if (tt->options.msg_channel)
     {
         do_set_mtu_service(tt, AF_INET, tun_mtu);
@@ -5238,12 +5268,8 @@ dhcp_renew(const struct tuntap *tt)
     }
 }
 
-/*
- * netsh functions
- */
-
 static void
-netsh_command(const struct argv *a, int n, int msglevel)
+exec_command(const char *prefix, const struct argv *a, int n, int msglevel)
 {
     int i;
     for (i = 0; i < n; ++i)
@@ -5251,8 +5277,8 @@ netsh_command(const struct argv *a, int n, int msglevel)
         bool status;
         management_sleep(0);
         netcmd_semaphore_lock();
-        argv_msg_prefix(M_INFO, a, "NETSH");
-        status = openvpn_execve_check(a, NULL, 0, "ERROR: netsh command failed");
+        argv_msg_prefix(M_INFO, a, prefix);
+        status = openvpn_execve_check(a, NULL, 0, "ERROR: command failed");
         netcmd_semaphore_release();
         if (status)
         {
@@ -5260,7 +5286,13 @@ netsh_command(const struct argv *a, int n, int msglevel)
         }
         management_sleep(4);
     }
-    msg(msglevel, "NETSH: command failed");
+    msg(msglevel, "%s: command failed", prefix);
+}
+
+static void
+netsh_command(const struct argv *a, int n, int msglevel)
+{
+    exec_command("NETSH", a, n, msglevel);
 }
 
 void
@@ -6927,6 +6959,11 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
         else
         {
+            if (!tt->did_ifconfig_setup && !tuntap_maybe_dhcp(&tt->options))
+            {
+                wmic_do_dns_domain(false, tt);
+            }
+
             netsh_delete_address_dns(tt, true, &gc);
         }
     }
@@ -6937,7 +6974,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         {
             /* We didn't do ifconfig. */
         }
-        else if (tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ || tt->options.ip_win32_type == IPW32_SET_ADAPTIVE)
+        else if (tuntap_maybe_dhcp(&tt->options))
         {
             /* We don't have to clean the configuration with DHCP. */
         }
@@ -6947,9 +6984,14 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
             do_dns_service(false, AF_INET, tt);
             do_address_service(false, AF_INET, tt);
         }
-        else if (tt->options.ip_win32_type == IPW32_SET_NETSH)
+        else
         {
-            netsh_delete_address_dns(tt, false, &gc);
+            wmic_do_dns_domain(false, tt);
+
+            if (tt->options.ip_win32_type == IPW32_SET_NETSH)
+            {
+                netsh_delete_address_dns(tt, false, &gc);
+            }
         }
     }
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index e19e1a2e..0d8e2307 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -668,6 +668,12 @@ tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
 const char *
 print_windows_driver(enum windows_driver_type windows_driver);
 
+static inline bool
+tuntap_maybe_dhcp(struct tuntap_options *o)
+{
+    return o->ip_win32_type == IPW32_SET_DHCP_MASQ || o->ip_win32_type == IPW32_SET_ADAPTIVE;
+}
+
 #else  /* ifdef _WIN32 */
 
 static inline bool
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 72ffb012..36059662 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -38,6 +38,7 @@
 #define WIN_ROUTE_PATH_SUFFIX "\\system32\\route.exe"
 #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
 #define WIN_NET_PATH_SUFFIX "\\system32\\net.exe"
+#define WMIC_PATH_SUFFIX "\\system32\\wbem\\wmic.exe"
 
 /*
  * Win32-specific OpenVPN code, targeted at the mingw
-- 
2.23.0.windows.1


