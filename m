From: Simon Rozman <simon@...2293...>
Date: Wed,  5 Feb 2020 18:59:44 +0100
Message-Id: <20200205175944.432-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tun.c: uncrustify
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

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 117 +++++++++++++++++++++++-----------------------
 src/openvpn/tun.h |   8 ++--
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 070b0fa0..47c3088d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -817,7 +817,7 @@ init_tun_post(struct tuntap *tt,
         tt->rw_handle.read = tt->reads.overlapped.hEvent;
         tt->rw_handle.write = tt->writes.overlapped.hEvent;
     }
-#endif
+#endif /* ifdef _WIN32 */
 }
 
 #if defined(_WIN32)    \
@@ -1397,18 +1397,18 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         {
             switch (tt->options.ip_win32_type)
             {
-            case IPW32_SET_MANUAL:
-                msg(M_INFO,
-                    "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
-                    ifname, ifconfig_local,
-                    print_in_addr_t(tt->adapter_netmask, 0, &gc));
-                break;
-
-            case IPW32_SET_NETSH:
-                netsh_ifconfig(&tt->options, ifname, tt->local,
-                               tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
-
-                break;
+                case IPW32_SET_MANUAL:
+                    msg(M_INFO,
+                        "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
+                        ifname, ifconfig_local,
+                        print_in_addr_t(tt->adapter_netmask, 0, &gc));
+                    break;
+
+                case IPW32_SET_NETSH:
+                    netsh_ifconfig(&tt->options, ifname, tt->local,
+                                   tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
+
+                    break;
             }
         }
     }
@@ -3481,7 +3481,7 @@ tun_finalize(
 }
 
 static const struct device_instance_id_interface *
-get_device_instance_id_interface(struct gc_arena* gc)
+get_device_instance_id_interface(struct gc_arena *gc)
 {
     HDEVINFO dev_info_set;
     DWORD err;
@@ -3552,7 +3552,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
         }
 
         cr = CM_Get_Device_Interface_List_Size(&dev_interface_list_size,
-                                               (LPGUID)& GUID_DEVINTERFACE_NET,
+                                               (LPGUID)&GUID_DEVINTERFACE_NET,
                                                device_instance_id,
                                                CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
 
@@ -3562,7 +3562,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
         }
 
         dev_interface_list = alloc_buf_gc(dev_interface_list_size, gc);
-        cr = CM_Get_Device_Interface_List((LPGUID)& GUID_DEVINTERFACE_NET, device_instance_id,
+        cr = CM_Get_Device_Interface_List((LPGUID)&GUID_DEVINTERFACE_NET, device_instance_id,
                                           BPTR(&dev_interface_list),
                                           dev_interface_list_size,
                                           CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
@@ -3571,7 +3571,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
             goto next;
         }
 
-        struct device_instance_id_interface* dev_if;
+        struct device_instance_id_interface *dev_if;
         ALLOC_OBJ_CLEAR_GC(dev_if, struct device_instance_id_interface, gc);
         dev_if->net_cfg_instance_id = string_alloc(net_cfg_instance_id, gc);
         dev_if->device_interface_list = string_alloc(BSTR(&dev_interface_list), gc);
@@ -3587,7 +3587,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
         }
         last = dev_if;
 
-    next:
+next:
         RegCloseKey(dev_key);
     }
 
@@ -3694,8 +3694,8 @@ get_tap_reg(struct gc_arena *gc)
                 {
                     /* Is this adapter supported? */
                     enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
-                    if (strcasecmp(component_id, TAP_WIN_COMPONENT_ID) == 0 ||
-                        strcasecmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) == 0)
+                    if (strcasecmp(component_id, TAP_WIN_COMPONENT_ID) == 0
+                        || strcasecmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) == 0)
                     {
                         windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
                     }
@@ -5768,8 +5768,8 @@ tuntap_get_version_info(const struct tuntap *tt)
     DWORD len;
     CLEAR(info);
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_VERSION,
-        &info, sizeof(info),
-        &info, sizeof(info), &len, NULL))
+                        &info, sizeof(info),
+                        &info, sizeof(info), &len, NULL))
     {
         msg(D_TUNTAP_INFO, "TAP-Windows Driver Version %d.%d %s",
             (int)info[0],
@@ -5808,8 +5808,8 @@ tuntap_get_mtu(struct tuntap *tt)
     ULONG mtu = 0;
     DWORD len;
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU,
-        &mtu, sizeof(mtu),
-        &mtu, sizeof(mtu), &len, NULL))
+                        &mtu, sizeof(mtu),
+                        &mtu, sizeof(mtu), &len, NULL))
     {
         tt->post_open_mtu = (int)mtu;
         msg(D_MTU_INFO, "TAP-Windows MTU=%d", (int)mtu);
@@ -5843,7 +5843,7 @@ tuntap_set_ip_addr(struct tuntap *tt,
             };
 
             if (send_msg_iservice(tt->options.msg_channel, &msg, sizeof(msg),
-                &ack, "TUN"))
+                                  &ack, "TUN"))
             {
                 status = ack.error_number;
             }
@@ -5900,7 +5900,7 @@ tuntap_set_ip_addr(struct tuntap *tt,
     if (tt->did_ifconfig_setup && tt->options.ip_win32_type == IPW32_SET_IPAPI)
     {
         DWORD status;
-        const char* error_suffix = "I am having trouble using the Windows 'IP helper API' to automatically set the IP address -- consider using other --ip-win32 methods (not 'ipapi')";
+        const char *error_suffix = "I am having trouble using the Windows 'IP helper API' to automatically set the IP address -- consider using other --ip-win32 methods (not 'ipapi')";
 
         /* couldn't get adapter index */
         if (index == TUN_ADAPTER_INDEX_INVALID)
@@ -5931,7 +5931,7 @@ tuntap_set_ip_addr(struct tuntap *tt,
                 print_in_addr_t(tt->local, 0, &gc),
                 print_in_addr_t(tt->adapter_netmask, 0, &gc),
                 device_guid
-            );
+                );
         }
         else
         {
@@ -5978,10 +5978,10 @@ wintun_register_ring_buffer(struct tuntap *tt)
             msg(M_FATAL, "ERROR:  Failed to impersonate as SYSTEM, make sure process is running under privileged account");
         }
         if (!register_ring_buffers(tt->hand,
-            tt->wintun_send_ring,
-            tt->wintun_receive_ring,
-            tt->rw_handle.read,
-            tt->rw_handle.write))
+                                   tt->wintun_send_ring,
+                                   tt->wintun_receive_ring,
+                                   tt->rw_handle.read,
+                                   tt->rw_handle.write))
         {
             msg(M_NONFATAL, "Failed to register ring buffers: %lu", GetLastError());
             ret = false;
@@ -6001,8 +6001,8 @@ tuntap_set_connected(const struct tuntap *tt)
     ULONG status = TRUE;
     DWORD len;
     if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_SET_MEDIA_STATUS,
-        &status, sizeof(status),
-        &status, sizeof(status), &len, NULL))
+                         &status, sizeof(status),
+                         &status, sizeof(status), &len, NULL))
     {
         msg(M_WARN, "WARNING: The TAP-Windows driver rejected a TAP_WIN_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.");
     }
@@ -6039,8 +6039,8 @@ tuntap_set_ptp(const struct tuntap *tt)
         ep[2] = htonl(tt->remote_netmask);
 
         status = DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_TUN,
-            ep, sizeof(ep),
-            ep, sizeof(ep), &len, NULL);
+                                 ep, sizeof(ep),
+                                 ep, sizeof(ep), &len, NULL);
 
         if (tt->did_ifconfig_setup)
         {
@@ -6063,8 +6063,8 @@ tuntap_set_ptp(const struct tuntap *tt)
         ep[1] = htonl(tt->remote_netmask);
 
         if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT,
-            ep, sizeof(ep),
-            ep, sizeof(ep), &len, NULL))
+                             ep, sizeof(ep),
+                             ep, sizeof(ep), &len, NULL))
         {
             msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set Point-to-Point mode, which is required for --dev tun");
         }
@@ -6116,8 +6116,8 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char *device_guid)
 
 #ifndef SIMULATE_DHCP_FAILED /* this code is disabled to simulate bad DHCP negotiation */
     if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_MASQ,
-        ep, sizeof(ep),
-        ep, sizeof(ep), &len, NULL))
+                         ep, sizeof(ep),
+                         ep, sizeof(ep), &len, NULL))
     {
         msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a DeviceIoControl call to set TAP_WIN_IOCTL_CONFIG_DHCP_MASQ mode");
     }
@@ -6128,7 +6128,7 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char *device_guid)
         device_guid,
         print_in_addr_t(ep[2], IA_NET_ORDER, &gc),
         ep[3]
-    );
+        );
 
     /* user-supplied DHCP options capability */
     if (tt->options.dhcp_options)
@@ -6138,8 +6138,8 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char *device_guid)
         {
             msg(D_DHCP_OPT, "DHCP option string: %s", format_hex(BPTR(&buf), BLEN(&buf), 0, &gc));
             if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT,
-                BPTR(&buf), BLEN(&buf),
-                BPTR(&buf), BLEN(&buf), &len, NULL))
+                                 BPTR(&buf), BLEN(&buf),
+                                 BPTR(&buf), BLEN(&buf), &len, NULL))
             {
                 msg(M_FATAL, "ERROR: The TAP-Windows driver rejected a TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT DeviceIoControl call");
             }
@@ -6183,19 +6183,19 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     {
         /* Open TAP-Windows adapter */
         openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
-                            USERMODEDEVICEDIR,
-                            device_guid,
-                            TAP_WIN_SUFFIX);
+                         USERMODEDEVICEDIR,
+                         device_guid,
+                         TAP_WIN_SUFFIX);
         path = tuntap_device_path;
     }
 
     tt->hand = CreateFile(path,
-                   GENERIC_READ | GENERIC_WRITE,
-                   0,                /* was: FILE_SHARE_READ */
-                   0,
-                   OPEN_EXISTING,
-                   FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
-                   0);
+                          GENERIC_READ | GENERIC_WRITE,
+                          0,         /* was: FILE_SHARE_READ */
+                          0,
+                          OPEN_EXISTING,
+                          FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED,
+                          0);
     if (tt->hand == INVALID_HANDLE_VALUE)
     {
         msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", print_windows_driver(tt->windows_driver), path);
@@ -6221,9 +6221,9 @@ static void
 tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid)
 {
     struct gc_arena gc = gc_new();
-    const struct tap_reg* tap_reg = get_tap_reg(&gc);
-    const struct panel_reg* panel_reg = get_panel_reg(&gc);
-    const struct device_instance_id_interface* device_instance_id_interface = get_device_instance_id_interface(&gc);
+    const struct tap_reg *tap_reg = get_tap_reg(&gc);
+    const struct panel_reg *panel_reg = get_panel_reg(&gc);
+    const struct device_instance_id_interface *device_instance_id_interface = get_device_instance_id_interface(&gc);
     char actual_buffer[256];
 
     at_least_one_tap_win(tap_reg);
@@ -6245,7 +6245,8 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
 
         if (tt->windows_driver != windows_driver)
         {
-            msg(M_FATAL, "Adapter '%s' is using %s driver, %s expected. If you want to use this device, adjust --windows-driver.", dev_node, print_windows_driver(windows_driver), print_windows_driver(tt->windows_driver));
+            msg(M_FATAL, "Adapter '%s' is using %s driver, %s expected. If you want to use this device, adjust --windows-driver.",
+                dev_node, print_windows_driver(windows_driver), print_windows_driver(tt->windows_driver));
         }
 
         if (!tun_try_open_device(tt, *device_guid, device_instance_id_interface))
@@ -6284,7 +6285,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
                 break;
             }
 
-        next:
+next:
             device_number++;
         }
     }
@@ -6458,7 +6459,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
      * address we added (pointed out by Cedric Tabary).
      */
 
-     /* netsh interface ipvX delete address \"%s\" %s */
+    /* netsh interface ipvX delete address \"%s\" %s */
     if (ipv6)
     {
         ifconfig_ip_local = print_in6_addr(tt->local_ipv6, 0, gc);
@@ -6541,7 +6542,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
                 strerror_win32(status, &gc));
         }
     }
-#endif
+#endif /* if 1 */
 
     dhcp_release(tt);
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 97d28f45..d6e23ea7 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -196,7 +196,7 @@ struct tuntap
     struct tun_ring *wintun_receive_ring;
 #else  /* ifdef _WIN32 */
     int fd; /* file descriptor for TUN/TAP dev */
-#endif
+#endif /* ifdef _WIN32 */
 
 #ifdef TARGET_SOLARIS
     int ip_fd;
@@ -517,7 +517,7 @@ wintun_ring_wrap(ULONG value)
 }
 
 static inline void
-read_wintun(struct tuntap *tt, struct buffer* buf)
+read_wintun(struct tuntap *tt, struct buffer *buf)
 {
     struct tun_ring *ring = tt->wintun_send_ring;
     ULONG head = ring->head;
@@ -575,7 +575,7 @@ read_wintun(struct tuntap *tt, struct buffer* buf)
 static inline bool
 is_ip_packet_valid(const struct buffer *buf)
 {
-    const struct openvpn_iphdr* ih = (const struct openvpn_iphdr *)BPTR(buf);
+    const struct openvpn_iphdr *ih = (const struct openvpn_iphdr *)BPTR(buf);
 
     if (OPENVPN_IPH_GET_VER(ih->version_len) == 4)
     {
@@ -631,7 +631,7 @@ write_wintun(struct tuntap *tt, struct buffer *buf)
     }
 
     /* copy packet size and data into ring */
-    packet = (struct TUN_PACKET* )&ring->data[tail];
+    packet = (struct TUN_PACKET * )&ring->data[tail];
     packet->size = BLEN(buf);
     memcpy(packet->data, BPTR(buf), BLEN(buf));
 
-- 
2.24.1.windows.2


