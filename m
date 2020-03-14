From: Simon Rozman <simon@...2293...>
Date: Sat, 14 Mar 2020 13:58:01 +0100
Message-Id: <20200314125801.1031-1-simon@...2293...>
In-Reply-To: <20200314124428.GE1431@...1296...>
References: <20200314124428.GE1431@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/2] tun.c: revise the IPv4 ifconfig flow
 on Windows
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

When provisioning IP configuration, we shall not ask what kind of
adapter this is. Rather, we should ask what method of provisioning we
are configured to use.

It is options.c's job to rule out invalid combinations.

- do_ifconfig_ipv4(): unify the workflow with its IPv6 counterpart
  No need to distinguish Wintun and TAP-Windows6 here. This also fixes
  an issue with --windows-driver wintun overriding --ip-win32 manual,
  the later being perfectly fine choice for Wintun too.

- open_tun(), tuntap_post_open(), tuntap_set_ip_addr(): unify Wintun and
  TAP-Windows6 workflow. This allows allows --ip-win32 ipapi now.

- close_tun() the cleanup has been revised to match the ifconfig
  workflow in reverse.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/options.c |   5 +-
 src/openvpn/tun.c     | 130 ++++++++++++++++++++++--------------------
 2 files changed, 70 insertions(+), 65 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e79a1215..f1fc91e9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3007,8 +3007,9 @@ options_postprocess_mutate_invariant(struct options *options)
     }
 
 #ifdef _WIN32
-    /* when using wintun, kernel doesn't send DHCP requests, so use netsh to set IP address and netmask */
-    if (options->windows_driver == WINDOWS_DRIVER_WINTUN)
+    /* when using wintun, kernel doesn't send DHCP requests, so don't use it */
+    if (options->windows_driver == WINDOWS_DRIVER_WINTUN
+        && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
     {
         options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
     }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 42193d97..1afa7f07 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1381,34 +1381,29 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         env_set_destroy(aix_es);
     }
 #elif defined (_WIN32)
-    {
-        ASSERT(ifname != NULL);
-
-        if (tt->options.msg_channel && tt->windows_driver == WINDOWS_DRIVER_WINTUN)
-        {
-            do_address_service(true, AF_INET, tt);
-            do_dns_service(true, AF_INET, tt);
-        }
-        else
-        {
-            switch (tt->options.ip_win32_type)
-            {
-                case IPW32_SET_MANUAL:
-                    msg(M_INFO,
-                        "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
-                        ifname, ifconfig_local,
-                        print_in_addr_t(tt->adapter_netmask, 0, &gc));
-                    break;
+    ASSERT(ifname != NULL);
 
-                case IPW32_SET_NETSH:
-                    netsh_ifconfig(&tt->options, ifname, tt->local,
-                                   tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
-
-                    break;
-            }
-        }
+    if (tt->options.ip_win32_type == IPW32_SET_MANUAL)
+    {
+        msg(M_INFO,
+            "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
+            ifname, ifconfig_local,
+            print_in_addr_t(tt->adapter_netmask, 0, &gc));
+    }
+    else if (tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ || tt->options.ip_win32_type == IPW32_SET_ADAPTIVE)
+    {
+        /* Let the DHCP configure the interface. */
+    }
+    else if (tt->options.msg_channel)
+    {
+        do_address_service(true, AF_INET, tt);
+        do_dns_service(true, AF_INET, tt);
+    }
+    else if (tt->options.ip_win32_type == IPW32_SET_NETSH)
+    {
+        netsh_ifconfig(&tt->options, ifname, tt->local,
+                       tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
     }
-
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
@@ -5821,7 +5816,8 @@ tuntap_set_ip_addr(struct tuntap *tt,
     const DWORD index = tt->adapter_index;
 
     /* flush arp cache */
-    if (index != TUN_ADAPTER_INDEX_INVALID)
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6
+        && index != TUN_ADAPTER_INDEX_INVALID)
     {
         DWORD status = -1;
 
@@ -6357,36 +6353,39 @@ tuntap_post_open(struct tuntap *tt, const char *device_guid)
     bool dhcp_masq = false;
     bool dhcp_masq_post = false;
 
-    /* get driver version info */
-    tuntap_get_version_info(tt);
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
+    {
+        /* get driver version info */
+        tuntap_get_version_info(tt);
 
-    /* get driver MTU */
-    tuntap_get_mtu(tt);
+        /* get driver MTU */
+        tuntap_get_mtu(tt);
 
-    /*
-     * Preliminaries for setting TAP-Windows adapter TCP/IP
-     * properties via --ip-win32 dynamic or --ip-win32 adaptive.
-     */
-    if (tt->did_ifconfig_setup)
-    {
-        tuntap_set_ip_props(tt, &dhcp_masq, &dhcp_masq_post);
-    }
+        /*
+         * Preliminaries for setting TAP-Windows adapter TCP/IP
+         * properties via --ip-win32 dynamic or --ip-win32 adaptive.
+         */
+        if (tt->did_ifconfig_setup)
+        {
+            tuntap_set_ip_props(tt, &dhcp_masq, &dhcp_masq_post);
+        }
 
-    /* set point-to-point mode if TUN device */
-    if (tt->type == DEV_TYPE_TUN)
-    {
-        tuntap_set_ptp(tt);
-    }
+        /* set point-to-point mode if TUN device */
+        if (tt->type == DEV_TYPE_TUN)
+        {
+            tuntap_set_ptp(tt);
+        }
 
-    /* should we tell the TAP-Windows driver to masquerade as a DHCP server as a means
-     * of setting the adapter address? */
-    if (dhcp_masq)
-    {
-        tuntap_dhcp_mask(tt, device_guid);
-    }
+        /* should we tell the TAP-Windows driver to masquerade as a DHCP server as a means
+         * of setting the adapter address? */
+        if (dhcp_masq)
+        {
+            tuntap_dhcp_mask(tt, device_guid);
+        }
 
-    /* set driver media status to 'connected' */
-    tuntap_set_connected(tt);
+        /* set driver media status to 'connected' */
+        tuntap_set_connected(tt);
+    }
 
     /* possibly use IP Helper API to set IP address on adapter */
     tuntap_set_ip_addr(tt, device_guid, dhcp_masq_post);
@@ -6413,10 +6412,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     tun_open_device(tt, dev_node, &device_guid);
 
-    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
-    {
-        tuntap_post_open(tt, device_guid);
-    }
+    tuntap_post_open(tt, device_guid);
 
     /*netcmd_semaphore_release ();*/
 }
@@ -6533,20 +6529,29 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
             netsh_delete_address_dns(tt, true, &gc);
         }
     }
-#if 1
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+
+    if (tt->did_ifconfig_setup)
     {
-        if (tt->options.msg_channel)
+        if (tt->options.ip_win32_type == IPW32_SET_MANUAL)
+        {
+            /* We didn't do ifconfig. */
+        }
+        else if (tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ || tt->options.ip_win32_type == IPW32_SET_ADAPTIVE)
+        {
+            /* We don't have to clean the configuration with DHCP. */
+        }
+        else if (tt->options.msg_channel)
         {
-            do_address_service(false, AF_INET, tt);
             do_dns_service(false, AF_INET, tt);
+            do_address_service(false, AF_INET, tt);
         }
-        else
+        else if (tt->options.ip_win32_type == IPW32_SET_NETSH)
         {
             netsh_delete_address_dns(tt, false, &gc);
         }
     }
-    else if (tt->ipapi_context_defined)
+
+    if (tt->ipapi_context_defined)
     {
         DWORD status;
         if ((status = DeleteIPAddress(tt->ipapi_context)) != NO_ERROR)
@@ -6557,7 +6562,6 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
                 strerror_win32(status, &gc));
         }
     }
-#endif /* if 1 */
 
     dhcp_release(tt);
 
-- 
2.24.1.windows.2


