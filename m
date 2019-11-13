From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 13 Nov 2019 12:42:16 +0200
Message-Id: <20191113104216.1545-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun.c: refactor open_tun() implementation
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

This makes Windows's tun_open() method easier to read
by factoring out blocks of code, which perform certain task,
into separate functions. This also minimizes inflation of

  if (!tt->wintun)  { }

blocks.

While patch looks big and scary, there are no functional changes
at all, just tossing code around.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 Please note that this patch could be merged after 6/7 of wintun
 patch series.

 src/openvpn/tun.c | 961 ++++++++++++++++++++++++----------------------
 1 file changed, 509 insertions(+), 452 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8b16cd6a..c18059c6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5765,591 +5765,648 @@ dhcp_masq_addr(const in_addr_t local, const in_addr_t netmask, const int offset)
     return htonl(dsa);
 }
 
-void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+static void
+tuntap_get_version_info(const struct tuntap *tt)
 {
-    struct gc_arena gc = gc_new();
-    char tuntap_device_path[256];
-    char *path = NULL;
-    const char *device_guid = NULL;
+    ULONG info[3];
     DWORD len;
-    bool dhcp_masq = false;
-    bool dhcp_masq_post = false;
-
-    /*netcmd_semaphore_lock ();*/
-
-    msg( M_INFO, "open_tun");
-
-    if (tt->type == DEV_TYPE_NULL)
+    CLEAR(info);
+    if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_VERSION,
+        &info, sizeof(info),
+        &info, sizeof(info), &len, NULL))
     {
-        open_null(tt);
-        gc_free(&gc);
-        return;
+        msg(D_TUNTAP_INFO, "TAP-Windows Driver Version %d.%d %s",
+            (int)info[0],
+            (int)info[1],
+            (info[2] ? "(DEBUG)" : ""));
+
     }
-    else if (tt->type == DEV_TYPE_TAP || tt->type == DEV_TYPE_TUN)
+    if (!(info[0] == TAP_WIN_MIN_MAJOR && info[1] >= TAP_WIN_MIN_MINOR))
     {
+        msg(M_FATAL, "ERROR:  This version of " PACKAGE_NAME " requires a TAP-Windows driver that is at least version %d.%d -- If you recently upgraded your " PACKAGE_NAME " distribution, a reboot is probably required at this point to get Windows to see the new driver.",
+            TAP_WIN_MIN_MAJOR,
+            TAP_WIN_MIN_MINOR);
     }
-    else
+
+    /* usage of numeric constants is ugly, but this is really tied to
+     * *this* version of the driver
+     */
+    if (tt->type == DEV_TYPE_TUN
+        && info[0] == 9 && info[1] < 8)
     {
-        msg(M_FATAL|M_NOPREFIX, "Unknown virtual device type: '%s'", dev);
+        msg(M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support IPv6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 driver.", (int)info[0], (int)info[1]);
     }
 
-    /*
-     * Lookup the device name in the registry, using the --dev-node high level name.
+    /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy
      */
+    if (tt->type == DEV_TYPE_TUN
+        && info[0] == 9 && info[1] == 8)
     {
-        const struct tap_reg *tap_reg = get_tap_reg(&gc);
-        const struct panel_reg *panel_reg = get_panel_reg(&gc);
-        const struct device_instance_id_interface *device_instance_id_interface = get_device_instance_id_interface(&gc);
-
-        char actual_buffer[256];
-
-        at_least_one_tap_win(tap_reg);
-
-        if (dev_node)
-        {
-            /* Get the device GUID for the device specified with --dev-node. */
-            device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &gc);
+        msg(M_FATAL, "ERROR:  Tap-Win32 driver version %d.%d is buggy regarding small IPv4 packets in TUN mode. Upgrade your Tap-Win32 driver.", (int)info[0], (int)info[1]);
+    }
+}
 
-            if (!device_guid)
-            {
-                msg(M_FATAL, "TAP-Windows adapter '%s' not found", dev_node);
-            }
+static void
+tuntap_get_mtu(struct tuntap *tt)
+{
+    ULONG mtu = 0;
+    DWORD len;
+    if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU,
+        &mtu, sizeof(mtu),
+        &mtu, sizeof(mtu), &len, NULL))
+    {
+        tt->post_open_mtu = (int)mtu;
+        msg(D_MTU_INFO, "TAP-Windows MTU=%d", (int)mtu);
+    }
+}
 
-            /* Open Windows TAP-Windows adapter */
-            openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
-                             USERMODEDEVICEDIR,
-                             device_guid,
-                             TAP_WIN_SUFFIX);
+static void
+tuntap_set_ip_addr(struct tuntap *tt,
+                   const char *device_guid,
+                   bool dhcp_masq_post)
+{
+    struct gc_arena gc = gc_new();
+    const DWORD index = tt->adapter_index;
 
-            tt->hand = CreateFile(tuntap_device_path,
-                                  GENERIC_READ | GENERIC_WRITE,
-                                  0,                /* was: FILE_SHARE_READ */
-                                  0,
-                                  OPEN_EXISTING,
-                                  FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                                  0);
+    /* flush arp cache */
+    if (index != TUN_ADAPTER_INDEX_INVALID)
+    {
+        DWORD status = -1;
 
-            if (tt->hand == INVALID_HANDLE_VALUE)
+        if (tt->options.msg_channel)
+        {
+            ack_message_t ack;
+            flush_neighbors_message_t msg = {
+                .header = {
+                    msg_flush_neighbors,
+                    sizeof(flush_neighbors_message_t),
+                    0
+                },
+                .family = AF_INET,
+                .iface = {.index = index, .name = "" }
+            };
+
+            if (send_msg_iservice(tt->options.msg_channel, &msg, sizeof(msg),
+                &ack, "TUN"))
             {
-                msg(M_ERR, "CreateFile failed on TAP device: %s", tuntap_device_path);
+                status = ack.error_number;
             }
         }
         else
         {
-            int device_number = 0;
-
-            /* Try opening all TAP devices until we find one available */
-            while (true)
-            {
-                bool is_picked_device_wintun = false;
-                device_guid = get_unspecified_device_guid(device_number,
-                                                          actual_buffer,
-                                                          sizeof(actual_buffer),
-                                                          tap_reg,
-                                                          panel_reg,
-                                                          &is_picked_device_wintun,
-                                                          &gc);
-
-                if (!device_guid)
-                {
-                    msg(M_FATAL, "All %s adapters on this system are currently in use.", tt->wintun ? "wintun" : "TAP - Windows");
-                }
-
-                if (tt->wintun)
-                {
-                    const struct device_instance_id_interface* dev_if;
-
-                    if (!is_picked_device_wintun)
-                    {
-                        /* wintun driver specified but picked adapter is not wintun, proceed to next one */
-                        goto next;
-                    }
-
-                    path = NULL;
-                    for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
-                    {
-                        if (strcmp(dev_if->net_cfg_instance_id, device_guid) == 0)
-                        {
-                            path = (char *)dev_if->device_interface_list;
-                            break;
-                        }
-                    }
-                    if (path == NULL)
-                    {
-                        goto next;
-                    }
-                }
-                else
-                {
-                    if (is_picked_device_wintun)
-                    {
-                        /* tap-windows6 driver specified but picked adapter is wintun, proceed to next one */
-                        goto next;
-                    }
-
-                    /* Open Windows TAP-Windows adapter */
-                    openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
-                                     USERMODEDEVICEDIR,
-                                     device_guid,
-                                     TAP_WIN_SUFFIX);
-                    path = tuntap_device_path;
-                }
-
-                tt->hand = CreateFile(path,
-                                      GENERIC_READ | GENERIC_WRITE,
-                                      0,                /* was: FILE_SHARE_READ */
-                                      0,
-                                      OPEN_EXISTING,
-                                      FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                                      0);
-
-                if (tt->hand == INVALID_HANDLE_VALUE)
-                {
-                    msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", tt->wintun ? "wintun" : "TAP", tuntap_device_path);
-                }
-                else
-                {
-                    break;
-                }
-
-            next:
-                device_number++;
-            }
+            status = FlushIpNetTable(index);
         }
 
-        /* translate high-level device name into a device instance
-         * GUID using the registry */
-        tt->actual_name = string_alloc(actual_buffer, NULL);
+        if (status == NO_ERROR)
+        {
+            msg(M_INFO, "Successful ARP Flush on interface [%lu] %s",
+                index,
+                device_guid);
+        }
+        else if (status != -1)
+        {
+            msg(D_TUNTAP_INFO, "NOTE: FlushIpNetTable failed on interface [%lu] %s (status=%lu) : %s",
+                index,
+                device_guid,
+                status,
+                strerror_win32(status, &gc));
+        }
     }
 
-    msg(M_INFO, "%s device [%s] opened: %s", tt->wintun ? "Wintun" : "TAP-WIN32", tt->actual_name, path);
-    tt->adapter_index = get_adapter_index(device_guid);
-
-    /* get driver version info */
-    if (!tt->wintun)
+    /*
+     * If the TAP-Windows driver is masquerading as a DHCP server
+     * make sure the TCP/IP properties for the adapter are
+     * set correctly.
+     */
+    if (dhcp_masq_post)
     {
-        ULONG info[3];
-        CLEAR(info);
-        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_VERSION,
-                            &info, sizeof(info),
-                            &info, sizeof(info), &len, NULL))
+        /* check dhcp enable status */
+        if (dhcp_status(index) == DHCP_STATUS_DISABLED)
         {
-            msg(D_TUNTAP_INFO, "TAP-Windows Driver Version %d.%d %s",
-                (int) info[0],
-                (int) info[1],
-                (info[2] ? "(DEBUG)" : ""));
+            msg(M_WARN, "WARNING: You have selected '--ip-win32 dynamic', which will not work unless the TAP-Windows TCP/IP properties are set to 'Obtain an IP address automatically'");
+        }
 
+        /* force an explicit DHCP lease renewal on TAP adapter? */
+        if (tt->options.dhcp_pre_release)
+        {
+            dhcp_release(tt);
         }
-        if (!(info[0] == TAP_WIN_MIN_MAJOR && info[1] >= TAP_WIN_MIN_MINOR))
+        if (tt->options.dhcp_renew)
         {
-            msg(M_FATAL, "ERROR:  This version of " PACKAGE_NAME " requires a TAP-Windows driver that is at least version %d.%d -- If you recently upgraded your " PACKAGE_NAME " distribution, a reboot is probably required at this point to get Windows to see the new driver.",
-                TAP_WIN_MIN_MAJOR,
-                TAP_WIN_MIN_MINOR);
+            dhcp_renew(tt);
         }
+    }
+    else
+    {
+        fork_dhcp_action(tt);
+    }
 
-        /* usage of numeric constants is ugly, but this is really tied to
-         * *this* version of the driver
-         */
-        if (tt->type == DEV_TYPE_TUN
-            && info[0] == 9 && info[1] < 8)
+    if (tt->did_ifconfig_setup && tt->options.ip_win32_type == IPW32_SET_IPAPI)
+    {
+        DWORD status;
+        const char* error_suffix = "I am having trouble using the Windows 'IP helper API' to automatically set the IP address -- consider using other --ip-win32 methods (not 'ipapi')";
+
+        /* couldn't get adapter index */
+        if (index == TUN_ADAPTER_INDEX_INVALID)
         {
-            msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not support IPv6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 driver.", (int) info[0], (int) info[1] );
+            msg(M_FATAL, "ERROR: unable to get adapter index for interface %s -- %s",
+                device_guid,
+                error_suffix);
         }
 
-        /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy
-         */
-        if (tt->type == DEV_TYPE_TUN
-            && info[0] == 9 && info[1] == 8)
+        /* check dhcp enable status */
+        if (dhcp_status(index) == DHCP_STATUS_DISABLED)
         {
-            msg( M_FATAL, "ERROR:  Tap-Win32 driver version %d.%d is buggy regarding small IPv4 packets in TUN mode. Upgrade your Tap-Win32 driver.", (int) info[0], (int) info[1] );
+            msg(M_WARN, "NOTE: You have selected (explicitly or by default) '--ip-win32 ipapi', which has a better chance of working correctly if the TAP-Windows TCP/IP properties are set to 'Obtain an IP address automatically'");
         }
-    }
 
-    /* get driver MTU */
-    if (!tt->wintun)
-    {
-        ULONG mtu;
-        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU,
-                            &mtu, sizeof(mtu),
-                            &mtu, sizeof(mtu), &len, NULL))
+        /* delete previously added IP addresses which were not
+         * correctly deleted */
+        delete_temp_addresses(index);
+
+        /* add a new IP address */
+        if ((status = AddIPAddress(htonl(tt->local),
+                                   htonl(tt->adapter_netmask),
+                                   index,
+                                   &tt->ipapi_context,
+                                   &tt->ipapi_instance)) == NO_ERROR)
+        {
+            msg(M_INFO, "Succeeded in adding a temporary IP/netmask of %s/%s to interface %s using the Win32 IP Helper API",
+                print_in_addr_t(tt->local, 0, &gc),
+                print_in_addr_t(tt->adapter_netmask, 0, &gc),
+                device_guid
+            );
+        }
+        else
         {
-            tt->post_open_mtu = (int) mtu;
-            msg(D_MTU_INFO, "TAP-Windows MTU=%d", (int) mtu);
+            msg(M_FATAL, "ERROR: AddIPAddress %s/%s failed on interface %s, index=%lu, status=%lu (windows error: '%s') -- %s",
+                print_in_addr_t(tt->local, 0, &gc),
+                print_in_addr_t(tt->adapter_netmask, 0, &gc),
+                device_guid,
+                index,
+                status,
+                strerror_win32(status, &gc),
+                error_suffix);
         }
+        tt->ipapi_context_defined = true;
     }
 
-    /*
-     * Preliminaries for setting TAP-Windows adapter TCP/IP
-     * properties via --ip-win32 dynamic or --ip-win32 adaptive.
-     */
-    if (tt->did_ifconfig_setup)
+    gc_free(&gc);
+}
+
+static void
+wintun_register_ring_buffer(struct tuntap *tt)
+{
+    tt->wintun_send_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_send_ring_handle,
+                                                            FILE_MAP_ALL_ACCESS,
+                                                            0,
+                                                            0,
+                                                            sizeof(struct tun_ring));
+
+    tt->wintun_receive_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_receive_ring_handle,
+                                                               FILE_MAP_ALL_ACCESS,
+                                                               0,
+                                                               0,
+                                                               sizeof(struct tun_ring));
+
+    if (tt->options.msg_channel)
     {
-        if (tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ)
+        service_register_ring_buffers(tt);
+    }
+    else
+    {
+        if (!impersonate_as_system())
         {
-            /*
-             * If adapter is set to non-DHCP, set to DHCP mode.
-             */
-            if (dhcp_status(tt->adapter_index) == DHCP_STATUS_DISABLED)
-            {
-                /* try using the service if available, else directly execute netsh */
-                if (tt->options.msg_channel)
-                {
-                    service_enable_dhcp(tt);
-                }
-                else
-                {
-                    netsh_enable_dhcp(tt->actual_name);
-                }
-            }
-            dhcp_masq = true;
-            dhcp_masq_post = true;
+            msg(M_FATAL, "ERROR:  Failed to impersonate as SYSTEM, make sure process is running under privileged account");
         }
-        else if (tt->options.ip_win32_type == IPW32_SET_ADAPTIVE)
+        if (!register_ring_buffers(tt->hand,
+            tt->wintun_send_ring,
+            tt->wintun_receive_ring,
+            tt->rw_handle.read,
+            tt->rw_handle.write))
         {
-            /*
-             * If adapter is set to non-DHCP, use netsh right away.
-             */
-            if (dhcp_status(tt->adapter_index) != DHCP_STATUS_ENABLED)
-            {
-                netsh_ifconfig(&tt->options,
-                               tt->actual_name,
-                               tt->local,
-                               tt->adapter_netmask,
-                               NI_TEST_FIRST|NI_IP_NETMASK|NI_OPTIONS);
-            }
-            else
-            {
-                dhcp_masq = true;
-            }
+            msg(M_FATAL, "ERROR:  Failed to register ring buffers: %lu", GetLastError());
+        }
+        if (!RevertToSelf())
+        {
+            msg(M_FATAL, "ERROR:  RevertToSelf error: %lu", GetLastError());
         }
     }
+}
 
-    /* set point-to-point mode if TUN device */
+static void
+tuntap_set_connected(const struct tuntap *tt)
+{
+    ULONG status = TRUE;
+    DWORD len;
+    if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
+        &status, sizeof(status),
+        &status, sizeof(status), &len, NULL))
+    {
+        msg(M_WARN, "WARNING: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
+    }
 
-    if ((tt->type == DEV_TYPE_TUN) && !tt->wintun)
+    int s = tt->options.tap_sleep;
+    if (s > 0)
     {
-        if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
-        {
-            msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
-        }
+        msg(M_INFO, "Sleeping for %d seconds...", s);
+        management_sleep(s);
+    }
+}
 
-        /* send 0/0/0 to the TAP driver even if we have no IPv4 configured to
-         * ensure it is somehow initialized.
-         */
-        if (!tt->did_ifconfig_setup || tt->topology == TOP_SUBNET)
-        {
-            in_addr_t ep[3];
-            BOOL status;
+static void
+tuntap_set_ptp(const struct tuntap *tt)
+{
+    DWORD len;
+    struct gc_arena gc = gc_new();
 
-            ep[0] = htonl(tt->local);
-            ep[1] = htonl(tt->local & tt->remote_netmask);
-            ep[2] = htonl(tt->remote_netmask);
+    if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
+    {
+        msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
+    }
 
-            status = DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_TUN,
-                                     ep, sizeof(ep),
-                                     ep, sizeof(ep), &len, NULL);
+    /* send 0/0/0 to the TAP driver even if we have no IPv4 configured to
+     * ensure it is somehow initialized.
+     */
+    if (!tt->did_ifconfig_setup || tt->topology == TOP_SUBNET)
+    {
+        in_addr_t ep[3];
+        BOOL status;
 
-            if (tt->did_ifconfig_setup)
-            {
-                msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN subnet mode network/local/netmask = %s/%s/%s [%s]",
-                    print_in_addr_t(ep[1], IA_NET_ORDER, &gc),
-                    print_in_addr_t(ep[0], IA_NET_ORDER, &gc),
-                    print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
-                    status ? "SUCCEEDED" : "FAILED");
-            }
-            else
-            {
-                msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN with fake IPv4 [%s]",
-                    status ? "SUCCEEDED" : "FAILED");
-            }
+        ep[0] = htonl(tt->local);
+        ep[1] = htonl(tt->local & tt->remote_netmask);
+        ep[2] = htonl(tt->remote_netmask);
+
+        status = DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_TUN,
+            ep, sizeof(ep),
+            ep, sizeof(ep), &len, NULL);
+
+        if (tt->did_ifconfig_setup)
+        {
+            msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN subnet mode network/local/netmask = %s/%s/%s [%s]",
+                print_in_addr_t(ep[1], IA_NET_ORDER, &gc),
+                print_in_addr_t(ep[0], IA_NET_ORDER, &gc),
+                print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
+                status ? "SUCCEEDED" : "FAILED");
         }
         else
         {
+            msg(status ? M_INFO : M_FATAL, "Set TAP-Windows TUN with fake IPv4 [%s]",
+                status ? "SUCCEEDED" : "FAILED");
+        }
+    }
+    else
+    {
+        in_addr_t ep[2];
+        ep[0] = htonl(tt->local);
+        ep[1] = htonl(tt->remote_netmask);
 
-            in_addr_t ep[2];
-            ep[0] = htonl(tt->local);
-            ep[1] = htonl(tt->remote_netmask);
-
-            if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT,
-                                 ep, sizeof(ep),
-                                 ep, sizeof(ep), &len, NULL))
-            {
-                msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set Point-to-Point mode, which is required for --dev tun");
-            }
+        if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT,
+            ep, sizeof(ep),
+            ep, sizeof(ep), &len, NULL))
+        {
+            msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set Point-to-Point mode, which is required for --dev tun");
         }
     }
 
-    /* should we tell the TAP-Windows driver to masquerade as a DHCP server as a means
-     * of setting the adapter address? */
-    if (dhcp_masq && !tt->wintun)
-    {
-        uint32_t ep[4];
+    gc_free(&gc);
+}
 
-        /* We will answer DHCP requests with a reply to set IP/subnet to these values */
-        ep[0] = htonl(tt->local);
-        ep[1] = htonl(tt->adapter_netmask);
+static void
+tuntap_dhcp_mask(const struct tuntap *tt, const char *device_guid)
+{
+    struct gc_arena gc = gc_new();
+    DWORD len;
+    uint32_t ep[4];
 
-        /* At what IP address should the DHCP server masquerade at? */
-        if (tt->type == DEV_TYPE_TUN)
+    /* We will answer DHCP requests with a reply to set IP/subnet to these values */
+    ep[0] = htonl(tt->local);
+    ep[1] = htonl(tt->adapter_netmask);
+
+    /* At what IP address should the DHCP server masquerade at? */
+    if (tt->type == DEV_TYPE_TUN)
+    {
+        if (tt->topology == TOP_SUBNET)
         {
-            if (tt->topology == TOP_SUBNET)
+            if (tt->options.dhcp_masq_custom_offset)
             {
-                if (tt->options.dhcp_masq_custom_offset)
-                {
-                    ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, tt->options.dhcp_masq_offset);
-                }
-                else
-                {
-                    ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, -1);
-                }
+                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, tt->options.dhcp_masq_offset);
             }
             else
             {
-                ep[2] = htonl(tt->remote_netmask);
+                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, -1);
             }
         }
         else
         {
-            ASSERT(tt->type == DEV_TYPE_TAP);
-            ep[2] = dhcp_masq_addr(tt->local, tt->adapter_netmask, tt->options.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
+            ep[2] = htonl(tt->remote_netmask);
         }
+    }
+    else
+    {
+        ASSERT(tt->type == DEV_TYPE_TAP);
+        ep[2] = dhcp_masq_addr(tt->local, tt->adapter_netmask, tt->options.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
+    }
 
-        /* lease time in seconds */
-        ep[3] = (uint32_t) tt->options.dhcp_lease_time;
+    /* lease time in seconds */
+    ep[3] = (uint32_t)tt->options.dhcp_lease_time;
 
-        ASSERT(ep[3] > 0);
+    ASSERT(ep[3] > 0);
 
 #ifndef SIMULATE_DHCP_FAILED /* this code is disabled to simulate bad DHCP negotiation */
-        if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,
-                             ep, sizeof(ep),
-                             ep, sizeof(ep), &len, NULL))
-        {
-            msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
-        }
+    if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,
+        ep, sizeof(ep),
+        ep, sizeof(ep), &len, NULL))
+    {
+        msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
+    }
 
-        msg(M_INFO, "Notified TAP-Windows driver to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
-            print_in_addr_t(tt->local, 0, &gc),
-            print_in_addr_t(tt->adapter_netmask, 0, &gc),
-            device_guid,
-            print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
-            ep[3]
-            );
+    msg(M_INFO, "Notified TAP-Windows driver to set a DHCP IP/netmask of %s/%s on interface %s [DHCP-serv: %s, lease-time: %d]",
+        print_in_addr_t(tt->local, 0, &gc),
+        print_in_addr_t(tt->adapter_netmask, 0, &gc),
+        device_guid,
+        print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
+        ep[3]
+    );
 
-        /* user-supplied DHCP options capability */
-        if (tt->options.dhcp_options)
+    /* user-supplied DHCP options capability */
+    if (tt->options.dhcp_options)
+    {
+        struct buffer buf = alloc_buf(256);
+        if (build_dhcp_options_string(&buf, &tt->options))
         {
-            struct buffer buf = alloc_buf(256);
-            if (build_dhcp_options_string(&buf, &tt->options))
+            msg(D_DHCP_OPT, "DHCP option string: %s", format_hex(BPTR(&buf), BLEN(&buf), 0, &gc));
+            if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
+                BPTR(&buf), BLEN(&buf),
+                BPTR(&buf), BLEN(&buf), &len, NULL))
             {
-                msg(D_DHCP_OPT, "DHCP option string: %s", format_hex(BPTR(&buf), BLEN(&buf), 0, &gc));
-                if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
-                                     BPTR(&buf), BLEN(&buf),
-                                     BPTR(&buf), BLEN(&buf), &len, NULL))
-                {
-                    msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
-                }
+                msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
             }
-            else
-            {
-                msg(M_WARN, "DHCP option string not set due to error");
-            }
-            free_buf(&buf);
         }
-#endif /* ifndef SIMULATE_DHCP_FAILED */
+        else
+        {
+            msg(M_WARN, "DHCP option string not set due to error");
+        }
+        free_buf(&buf);
     }
+#endif /* ifndef SIMULATE_DHCP_FAILED */
 
-    /* set driver media status to 'connected' */
-    if (!tt->wintun)
+    gc_free(&gc);
+}
+
+static void
+tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid)
+{
+    struct gc_arena gc = gc_new();
+    char *path = NULL;
+    char tuntap_device_path[256];
+    const struct tap_reg* tap_reg = get_tap_reg(&gc);
+    const struct panel_reg* panel_reg = get_panel_reg(&gc);
+    const struct device_instance_id_interface* device_instance_id_interface = get_device_instance_id_interface(&gc);
+    char actual_buffer[256];
+
+    at_least_one_tap_win(tap_reg);
+
+    /*
+     * Lookup the device name in the registry, using the --dev-node high level name.
+     */
+    if (dev_node)
     {
-        ULONG status = TRUE;
-        if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
-                             &status, sizeof(status),
-                             &status, sizeof(status), &len, NULL))
+        /* Get the device GUID for the device specified with --dev-node. */
+        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), tap_reg, panel_reg, &gc);
+
+        if (!*device_guid)
         {
-            msg(M_WARN, "WARNING: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
+            msg(M_FATAL, "TAP-Windows adapter '%s' not found", dev_node);
         }
-    }
 
-    /* possible wait for adapter to come up */
-    {
-        int s = tt->options.tap_sleep;
-        if (s > 0)
+        /* Open Windows TAP-Windows adapter */
+        openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
+                         USERMODEDEVICEDIR,
+                         *device_guid,
+                         TAP_WIN_SUFFIX);
+
+        tt->hand = CreateFile(tuntap_device_path,
+                              GENERIC_READ | GENERIC_WRITE,
+                              0,                /* was: FILE_SHARE_READ */
+                              0,
+                              OPEN_EXISTING,
+                              FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                              0);
+
+        if (tt->hand == INVALID_HANDLE_VALUE)
         {
-            msg(M_INFO, "Sleeping for %d seconds...", s);
-            management_sleep(s);
+            msg(M_ERR, "CreateFile failed on TAP device: %s", tuntap_device_path);
         }
     }
-
-    /* possibly use IP Helper API to set IP address on adapter */
-    if (!tt->wintun)
+    else
     {
-        const DWORD index = tt->adapter_index;
+        int device_number = 0;
 
-        /* flush arp cache */
-        if (index != TUN_ADAPTER_INDEX_INVALID)
+        /* Try opening all TAP devices until we find one available */
+        while (true)
         {
-            DWORD status = -1;
+            bool is_picked_device_wintun = false;
+            *device_guid = get_unspecified_device_guid(device_number,
+                                                       actual_buffer,
+                                                       sizeof(actual_buffer),
+                                                       tap_reg,
+                                                       panel_reg,
+                                                       &is_picked_device_wintun,
+                                                       &gc);
 
-            if (tt->options.msg_channel)
+            if (!*device_guid)
+            {
+                msg(M_FATAL, "All %s adapters on this system are currently in use.", tt->wintun ? "wintun" : "TAP - Windows");
+            }
+
+            if (tt->wintun)
             {
-                ack_message_t ack;
-                flush_neighbors_message_t msg = {
-                    .header = {
-                        msg_flush_neighbors,
-                        sizeof(flush_neighbors_message_t),
-                        0
-                    },
-                    .family = AF_INET,
-                    .iface = { .index = index, .name = "" }
-                };
-
-                if (send_msg_iservice(tt->options.msg_channel, &msg, sizeof(msg),
-                                      &ack, "TUN"))
+                const struct device_instance_id_interface* dev_if;
+
+                if (!is_picked_device_wintun)
                 {
-                    status = ack.error_number;
+                    /* wintun driver specified but picked adapter is not wintun, proceed to next one */
+                    goto next;
+                }
+
+                path = NULL;
+                for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
+                {
+                    if (strcmp(dev_if->net_cfg_instance_id, *device_guid) == 0)
+                    {
+                        path = (char*)dev_if->device_interface_list;
+                        break;
+                    }
+                }
+                if (path == NULL)
+                {
+                    goto next;
                 }
             }
             else
             {
-                status = FlushIpNetTable(index);
+                if (is_picked_device_wintun)
+                {
+                    /* tap-windows6 driver specified but picked adapter is wintun, proceed to next one */
+                    goto next;
+                }
+
+                /* Open Windows TAP-Windows adapter */
+                openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
+                                 USERMODEDEVICEDIR,
+                                 *device_guid,
+                                 TAP_WIN_SUFFIX);
+                path = tuntap_device_path;
             }
 
-            if (status == NO_ERROR)
+            tt->hand = CreateFile(path,
+                                  GENERIC_READ | GENERIC_WRITE,
+                                  0,                /* was: FILE_SHARE_READ */
+                                  0,
+                                  OPEN_EXISTING,
+                                  FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                                  0);
+
+            if (tt->hand == INVALID_HANDLE_VALUE)
             {
-                msg(M_INFO, "Successful ARP Flush on interface [%lu] %s",
-                    index,
-                    device_guid);
+                msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", tt->wintun ? "wintun" : "TAP", tuntap_device_path);
             }
-            else if (status != -1)
+            else
             {
-                msg(D_TUNTAP_INFO, "NOTE: FlushIpNetTable failed on interface [%lu] %s (status=%lu) : %s",
-                    index,
-                    device_guid,
-                    status,
-                    strerror_win32(status, &gc));
+                break;
             }
+
+        next:
+            device_number++;
         }
+    }
+
+    /* translate high-level device name into a device instance
+     * GUID using the registry */
+    tt->actual_name = string_alloc(actual_buffer, NULL);
+
+    msg(M_INFO, "%s device [%s] opened: %s", tt->wintun ? "Wintun" : "TAP-WIN32", tt->actual_name, path);
+    tt->adapter_index = get_adapter_index(*device_guid);
+
+    gc_free(&gc);
+}
 
+static void
+tuntap_set_ip_props(const struct tuntap *tt, bool *dhcp_masq, bool *dhcp_masq_post)
+{
+    if (tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ)
+    {
         /*
-         * If the TAP-Windows driver is masquerading as a DHCP server
-         * make sure the TCP/IP properties for the adapter are
-         * set correctly.
+         * If adapter is set to non-DHCP, set to DHCP mode.
          */
-        if (dhcp_masq_post)
+        if (dhcp_status(tt->adapter_index) == DHCP_STATUS_DISABLED)
         {
-            /* check dhcp enable status */
-            if (dhcp_status(index) == DHCP_STATUS_DISABLED)
-            {
-                msg(M_WARN, "WARNING: You have selected '--ip-win32 dynamic', which will not work unless the TAP-Windows TCP/IP properties are set to 'Obtain an IP address automatically'");
-            }
-
-            /* force an explicit DHCP lease renewal on TAP adapter? */
-            if (tt->options.dhcp_pre_release)
+            /* try using the service if available, else directly execute netsh */
+            if (tt->options.msg_channel)
             {
-                dhcp_release(tt);
+                service_enable_dhcp(tt);
             }
-            if (tt->options.dhcp_renew)
+            else
             {
-                dhcp_renew(tt);
+                netsh_enable_dhcp(tt->actual_name);
             }
         }
+        *dhcp_masq = true;
+        *dhcp_masq_post = true;
+    }
+    else if (tt->options.ip_win32_type == IPW32_SET_ADAPTIVE)
+    {
+        /*
+         * If adapter is set to non-DHCP, use netsh right away.
+         */
+        if (dhcp_status(tt->adapter_index) != DHCP_STATUS_ENABLED)
+        {
+            netsh_ifconfig(&tt->options,
+                           tt->actual_name,
+                           tt->local,
+                           tt->adapter_netmask,
+                           NI_TEST_FIRST | NI_IP_NETMASK | NI_OPTIONS);
+        }
         else
         {
-            fork_dhcp_action(tt);
+            *dhcp_masq = true;
         }
+    }
+}
 
-        if (tt->did_ifconfig_setup && tt->options.ip_win32_type == IPW32_SET_IPAPI)
-        {
-            DWORD status;
-            const char *error_suffix = "I am having trouble using the Windows 'IP helper API' to automatically set the IP address -- consider using other --ip-win32 methods (not 'ipapi')";
+static void
+tuntap_post_open(struct tuntap *tt, const char *device_guid)
+{
+    bool dhcp_masq = false;
+    bool dhcp_masq_post = false;
 
-            /* couldn't get adapter index */
-            if (index == TUN_ADAPTER_INDEX_INVALID)
-            {
-                msg(M_FATAL, "ERROR: unable to get adapter index for interface %s -- %s",
-                    device_guid,
-                    error_suffix);
-            }
+    /* get driver version info */
+    tuntap_get_version_info(tt);
 
-            /* check dhcp enable status */
-            if (dhcp_status(index) == DHCP_STATUS_DISABLED)
-            {
-                msg(M_WARN, "NOTE: You have selected (explicitly or by default) '--ip-win32 ipapi', which has a better chance of working correctly if the TAP-Windows TCP/IP properties are set to 'Obtain an IP address automatically'");
-            }
+    /* get driver MTU */
+    tuntap_get_mtu(tt);
 
-            /* delete previously added IP addresses which were not
-             * correctly deleted */
-            delete_temp_addresses(index);
+    /*
+     * Preliminaries for setting TAP-Windows adapter TCP/IP
+     * properties via --ip-win32 dynamic or --ip-win32 adaptive.
+     */
+    if (tt->did_ifconfig_setup)
+    {
+        tuntap_set_ip_props(tt, &dhcp_masq, &dhcp_masq_post);
+    }
 
-            /* add a new IP address */
-            if ((status = AddIPAddress(htonl(tt->local),
-                                       htonl(tt->adapter_netmask),
-                                       index,
-                                       &tt->ipapi_context,
-                                       &tt->ipapi_instance)) == NO_ERROR)
-            {
-                msg(M_INFO, "Succeeded in adding a temporary IP/netmask of %s/%s to interface %s using the Win32 IP Helper API",
-                    print_in_addr_t(tt->local, 0, &gc),
-                    print_in_addr_t(tt->adapter_netmask, 0, &gc),
-                    device_guid
-                    );
-            }
-            else
-            {
-                msg(M_FATAL, "ERROR: AddIPAddress %s/%s failed on interface %s, index=%lu, status=%lu (windows error: '%s') -- %s",
-                    print_in_addr_t(tt->local, 0, &gc),
-                    print_in_addr_t(tt->adapter_netmask, 0, &gc),
-                    device_guid,
-                    index,
-                    status,
-                    strerror_win32(status, &gc),
-                    error_suffix);
-            }
-            tt->ipapi_context_defined = true;
-        }
+    /* set point-to-point mode if TUN device */
+    if (tt->type == DEV_TYPE_TUN)
+    {
+        tuntap_set_ptp(tt);
     }
 
-    if (tt->wintun)
+    /* should we tell the TAP-Windows driver to masquerade as a DHCP server as a means
+     * of setting the adapter address? */
+    if (dhcp_masq)
     {
-        tt->wintun_send_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_send_ring_handle,
-                                                                FILE_MAP_ALL_ACCESS,
-                                                                0,
-                                                                0,
-                                                                sizeof(struct tun_ring));
-        tt->wintun_receive_ring = (struct tun_ring *)MapViewOfFile(tt->wintun_receive_ring_handle,
-                                                                   FILE_MAP_ALL_ACCESS,
-                                                                   0,
-                                                                   0,
-                                                                   sizeof(struct tun_ring));
+        tuntap_dhcp_mask(tt, device_guid);
+    }
 
-        if (tt->options.msg_channel)
-        {
-            service_register_ring_buffers(tt);
-        }
-        else
-        {
-            if (!impersonate_as_system())
-            {
-                msg(M_FATAL, "ERROR:  Failed to impersonate as SYSTEM, make sure process is running under privileged account");
-            }
-            if (!register_ring_buffers(tt->hand,
-                                       tt->wintun_send_ring,
-                                       tt->wintun_receive_ring,
-                                       tt->rw_handle.read,
-                                       tt->rw_handle.write))
-            {
-                msg(M_FATAL, "ERROR:  Failed to register ring buffers: %lu", GetLastError());
-            }
-            if (!RevertToSelf())
-            {
-                msg(M_FATAL, "ERROR:  RevertToSelf error: %lu", GetLastError());
-            }
-        }
+    /* set driver media status to 'connected' */
+    tuntap_set_connected(tt);
+
+    /* possibly use IP Helper API to set IP address on adapter */
+    tuntap_set_ip_addr(tt, device_guid, dhcp_masq_post);
+}
+
+void
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+{
+    const char *device_guid = NULL;
+
+    /*netcmd_semaphore_lock ();*/
+
+    msg( M_INFO, "open_tun");
+
+    if (tt->type == DEV_TYPE_NULL)
+    {
+        open_null(tt);
+        return;
+    }
+    else if (tt->type != DEV_TYPE_TAP && tt->type != DEV_TYPE_TUN)
+    {
+        msg(M_FATAL|M_NOPREFIX, "Unknown virtual device type: '%s'", dev);
+    }
+
+    tun_open_device(tt, dev_node, &device_guid);
+
+    if (tt->wintun)
+    {
+        wintun_register_ring_buffer(tt);
+    }
+    else
+    {
+        tuntap_post_open(tt, device_guid);
     }
 
     /*netcmd_semaphore_release ();*/
-    gc_free(&gc);
 }
 
 const char *
-- 
2.17.1


