From: Simon Rozman <simon@...2293...>
Date: Thu, 16 Jan 2020 15:19:00 +0100
Message-Id: <20200116141900.1524-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] wintun: refactor code to use enum driver
 type
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
 src/openvpn/forward.c |   4 +-
 src/openvpn/init.c    |   2 +-
 src/openvpn/options.c |  16 +++----
 src/openvpn/options.h |   2 +-
 src/openvpn/tun.c     | 108 ++++++++++++++++++++----------------------
 src/openvpn/tun.h     |  16 +++++--
 6 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6b823613..ea10f0bf 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1258,7 +1258,7 @@ read_incoming_tun(struct context *c)
     c->c2.buf = c->c2.buffers->read_tun_buf;
 
 #ifdef _WIN32
-    if (c->c1.tuntap->wintun)
+    if (c->c1.tuntap->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         read_wintun(c->c1.tuntap, &c->c2.buf);
         if (c->c2.buf.len == -1)
@@ -1274,7 +1274,7 @@ read_incoming_tun(struct context *c)
     {
         read_tun_buffered(c->c1.tuntap, &c->c2.buf);
     }
-#else
+#else  /* ifdef _WIN32 */
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
     ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
     c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), MAX_RW_SIZE_TUN(&c->c2.frame));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0bdb0a9c..ec444f47 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1734,7 +1734,7 @@ do_init_tun(struct context *c)
                             &c->net_ctx);
 
 #ifdef _WIN32
-    c->c1.tuntap->wintun = c->options.wintun;
+    c->c1.tuntap->windows_driver = c->options.windows_driver;
 #endif
 
     init_tun_post(c->c1.tuntap,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a6f40e10..709ba4bb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -854,7 +854,7 @@ init_options(struct options *o, const bool init_gc)
     o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
-    o->wintun = false;
+    o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
 #endif
     o->vlan_accept = VLAN_ALL;
     o->vlan_pvid = 1;
@@ -3002,7 +3002,7 @@ options_postprocess_mutate_invariant(struct options *options)
 
 #ifdef _WIN32
     /* when using wintun, kernel doesn't send DHCP requests, so use netsh to set IP address and netmask */
-    if (options->wintun)
+    if (options->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
     }
@@ -4076,23 +4076,23 @@ foreign_option(struct options *o, char *argv[], int len, struct env_set *es)
  *
  * @param str       value of --windows-driver option
  * @param msglevel  msglevel to report parsing error
- * @return bool     true if --windows-driver is wintun, false otherwise
+ * @return enum windows_driver_type  driver type, WINDOWS_DRIVER_UNSPECIFIED on unknown --windows-driver value
  */
-static bool
+static enum windows_driver_type
 parse_windows_driver(const char *str, const int msglevel)
 {
     if (streq(str, "tap-windows6"))
     {
-        return false;
+        return WINDOWS_DRIVER_TAP_WINDOWS6;
     }
     else if (streq(str, "wintun"))
     {
-        return true;
+        return WINDOWS_DRIVER_WINTUN;
     }
     else
     {
         msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
-        return false;
+        return WINDOWS_DRIVER_UNSPECIFIED;
     }
 }
 #endif
@@ -5367,7 +5367,7 @@ add_option(struct options *options,
     else if (streq(p[0], "windows-driver") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->wintun = parse_windows_driver(p[1], M_FATAL);
+        options->windows_driver = parse_windows_driver(p[1], M_FATAL);
     }
 #endif
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7fd2c00f..84d05f26 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -634,7 +634,7 @@ struct options
     bool show_net_up;
     int route_method;
     bool block_outside_dns;
-    bool wintun;
+    enum windows_driver_type windows_driver;
 #endif
 
     bool use_peer_id;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 32a3f756..af09e676 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -786,7 +786,7 @@ init_tun_post(struct tuntap *tt,
     overlapped_io_init(&tt->writes, frame, TRUE, true);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
 
-    if (tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         tt->wintun_send_ring_handle = CreateFileMapping(INVALID_HANDLE_VALUE, NULL,
                                                         PAGE_READWRITE,
@@ -1388,7 +1388,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         ASSERT(ifname != NULL);
 
-        if (tt->options.msg_channel && tt->wintun)
+        if (tt->options.msg_channel && tt->windows_driver == WINDOWS_DRIVER_WINTUN)
         {
             do_address_service(true, AF_INET, tt);
             do_dns_service(true, AF_INET, tt);
@@ -3253,6 +3253,22 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 
 #elif defined(_WIN32)
 
+static const char *
+print_windows_driver(enum windows_driver_type windows_driver)
+{
+    switch (windows_driver)
+    {
+        case WINDOWS_DRIVER_TAP_WINDOWS6:
+            return "tap-windows6";
+
+        case WINDOWS_DRIVER_WINTUN:
+            return "wintun";
+
+        default:
+            return "unspecified";
+    }
+}
+
 int
 tun_read_queue(struct tuntap *tt, int maxsize)
 {
@@ -3676,14 +3692,16 @@ get_tap_reg(struct gc_arena *gc)
 
                 if (status == ERROR_SUCCESS && data_type == REG_SZ)
                 {
-                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
-                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) ||
-                        !strcmp(component_id, WINTUN_COMPONENT_ID))
+                    enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
+
+                    if ((windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6, !strcmp(component_id, TAP_WIN_COMPONENT_ID))
+                        || (windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6, !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID))
+                        || (windows_driver = WINDOWS_DRIVER_WINTUN, !strcmp(component_id, WINTUN_COMPONENT_ID)))
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
                         reg->guid = string_alloc(net_cfg_instance_id, gc);
-                        reg->wintun = !strcmp(component_id, WINTUN_COMPONENT_ID);
+                        reg->windows_driver = windows_driver;
 
                         /* link into return list */
                         if (!first)
@@ -3926,7 +3944,7 @@ show_tap_win_adapters(int msglev, int warnlev)
         {
             if (!strcmp(tr->guid, pr->guid))
             {
-                msg(msglev, "'%s' %s %s", pr->name, tr->guid, tr->wintun ? "wintun" : "tap-windows6");
+                msg(msglev, "'%s' %s %s", pr->name, tr->guid, print_windows_driver(tr->windows_driver));
                 ++links;
             }
         }
@@ -4045,7 +4063,7 @@ get_unspecified_device_guid(const int device_number,
                             int actual_name_size,
                             const struct tap_reg *tap_reg_src,
                             const struct panel_reg *panel_reg_src,
-                            bool *wintun,
+                            enum windows_driver_type *windows_driver,
                             struct gc_arena *gc)
 {
     const struct tap_reg *tap_reg = tap_reg_src;
@@ -4095,9 +4113,9 @@ get_unspecified_device_guid(const int device_number,
     /* Save GUID for return value */
     ret = alloc_buf_gc(256, gc);
     buf_printf(&ret, "%s", tap_reg->guid);
-    if (wintun != NULL)
+    if (windows_driver != NULL)
     {
-        *wintun = tap_reg->wintun;
+        *windows_driver = tap_reg->windows_driver;
     }
     return BSTR(&ret);
 }
@@ -4110,7 +4128,7 @@ static const char *
 get_device_guid(const char *name,
                 char *actual_name,
                 int actual_name_size,
-                bool *wintun,
+                enum windows_driver_type *windows_driver,
                 const struct tap_reg *tap_reg,
                 const struct panel_reg *panel_reg,
                 struct gc_arena *gc)
@@ -4146,9 +4164,9 @@ get_device_guid(const char *name,
         {
             buf_printf(&actual, "%s", name);
         }
-        if (wintun)
+        if (windows_driver)
         {
-            *wintun = tr->wintun;
+            *windows_driver = tr->windows_driver;
         }
         return BSTR(&ret);
     }
@@ -4159,9 +4177,9 @@ get_device_guid(const char *name,
         if (tr)
         {
             buf_printf(&actual, "%s", name);
-            if (wintun)
+            if (windows_driver)
             {
-                *wintun = tr->wintun;
+                *windows_driver = tr->windows_driver;
             }
             buf_printf(&ret, "%s", tr->guid);
             return BSTR(&ret);
@@ -6135,7 +6153,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     const char *path = NULL;
     char tuntap_device_path[256];
 
-    if (tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         const struct device_instance_id_interface *dev_if;
 
@@ -6172,11 +6190,11 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
                    0);
     if (tt->hand == INVALID_HANDLE_VALUE)
     {
-        msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", tt->wintun ? "Wintun" : "TAP-Windows", path);
+        msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", print_windows_driver(tt->windows_driver), path);
         return false;
     }
 
-    if (tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         /* Wintun adapter may be considered "open" after ring buffers are successfuly registered. */
         if (!wintun_register_ring_buffer(tt))
@@ -6207,34 +6225,24 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
      */
     if (dev_node)
     {
-        bool is_picked_device_wintun = false;
+        enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
 
         /* Get the device GUID for the device specified with --dev-node. */
-        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), &is_picked_device_wintun, tap_reg, panel_reg, &gc);
+        *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), &windows_driver, tap_reg, panel_reg, &gc);
 
         if (!*device_guid)
         {
             msg(M_FATAL, "Adapter '%s' not found", dev_node);
         }
 
-        if (tt->wintun)
-        {
-            if (!is_picked_device_wintun)
-            {
-                msg(M_FATAL, "Adapter '%s' is TAP-Windows, Wintun expected. If you want to use this device, remove --windows-driver wintun.", dev_node);
-            }
-        }
-        else
+        if (tt->windows_driver != windows_driver)
         {
-            if (is_picked_device_wintun)
-            {
-                msg(M_FATAL, "Adapter '%s' is Wintun, TAP-Windows expected. If you want to use this device, add --windows-driver wintun.", dev_node);
-            }
+            msg(M_FATAL, "Adapter '%s' is using %s driver, %s expected. If you want to use this device, adjust --windows-driver.", dev_node, print_windows_driver(windows_driver), print_windows_driver(tt->windows_driver));
         }
 
         if (!tun_try_open_device(tt, *device_guid, device_instance_id_interface))
         {
-            msg(M_FATAL, "Failed to open %s adapter: %s", tt->wintun ? "Wintun" : "TAP-Windows", dev_node);
+            msg(M_FATAL, "Failed to open %s adapter: %s", print_windows_driver(tt->windows_driver), dev_node);
         }
     }
     else
@@ -6244,35 +6252,23 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
         /* Try opening all TAP devices until we find one available */
         while (true)
         {
-            bool is_picked_device_wintun = false;
+            enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
             *device_guid = get_unspecified_device_guid(device_number,
                                                        actual_buffer,
                                                        sizeof(actual_buffer),
                                                        tap_reg,
                                                        panel_reg,
-                                                       &is_picked_device_wintun,
+                                                       &windows_driver,
                                                        &gc);
 
             if (!*device_guid)
             {
-                msg(M_FATAL, "All %s adapters on this system are currently in use.", tt->wintun ? "wintun" : "TAP - Windows");
+                msg(M_FATAL, "All %s adapters on this system are currently in use.", print_windows_driver(tt->windows_driver));
             }
 
-            if (tt->wintun)
-            {
-                if (!is_picked_device_wintun)
-                {
-                    /* wintun driver specified but picked adapter is not wintun, proceed to next one */
-                    goto next;
-                }
-            }
-            else
+            if (tt->windows_driver != windows_driver)
             {
-                if (is_picked_device_wintun)
-                {
-                    /* tap-windows6 driver specified but picked adapter is wintun, proceed to next one */
-                    goto next;
-                }
+                goto next;
             }
 
             if (tun_try_open_device(tt, *device_guid, device_instance_id_interface))
@@ -6289,7 +6285,7 @@ tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_gui
      * GUID using the registry */
     tt->actual_name = string_alloc(actual_buffer, NULL);
 
-    msg(M_INFO, "%s device [%s] opened", tt->wintun ? "Wintun" : "TAP-WIN32", tt->actual_name);
+    msg(M_INFO, "%s device [%s] opened", print_windows_driver(tt->windows_driver), tt->actual_name);
     tt->adapter_index = get_adapter_index(*device_guid);
 
     gc_free(&gc);
@@ -6400,7 +6396,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     tun_open_device(tt, dev_node, &device_guid);
 
-    if (!tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         tuntap_post_open(tt, device_guid);
     }
@@ -6411,7 +6407,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 const char *
 tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 {
-    if (!tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         struct buffer out = alloc_buf_gc(256, gc);
         DWORD len;
@@ -6429,7 +6425,7 @@ tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 void
 tun_show_debug(struct tuntap *tt)
 {
-    if (!tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         struct buffer out = alloc_buf(1024);
         DWORD len;
@@ -6514,7 +6510,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
     }
 #if 1
-    if (tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         if (tt->options.msg_channel)
         {
@@ -6570,7 +6566,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         free(tt->actual_name);
     }
 
-    if (tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         CloseHandle(tt->rw_handle.read);
         CloseHandle(tt->rw_handle.write);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index b0b80d1a..97d28f45 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -43,6 +43,12 @@
 
 #ifdef _WIN32
 #define WINTUN_COMPONENT_ID "wintun"
+
+enum windows_driver_type {
+    WINDOWS_DRIVER_UNSPECIFIED,
+    WINDOWS_DRIVER_TAP_WINDOWS6,
+    WINDOWS_DRIVER_WINTUN
+};
 #endif
 
 #if defined(_WIN32) || defined(TARGET_ANDROID)
@@ -181,7 +187,7 @@ struct tuntap
      * ~0 if undefined */
     DWORD adapter_index;
 
-    bool wintun; /* true if wintun is used instead of tap-windows6 */
+    enum windows_driver_type windows_driver;
     int standby_iter;
 
     HANDLE wintun_send_ring_handle;
@@ -221,7 +227,7 @@ tuntap_defined(const struct tuntap *tt)
 inline bool
 tuntap_is_wintun(struct tuntap *tt)
 {
-    return tt && tt->wintun;
+    return tt && tt->windows_driver == WINDOWS_DRIVER_WINTUN;
 }
 
 inline bool
@@ -365,7 +371,7 @@ route_order(void)
 struct tap_reg
 {
     const char *guid;
-    bool wintun;
+    enum windows_driver_type windows_driver;
     struct tap_reg *next;
 };
 
@@ -642,7 +648,7 @@ write_wintun(struct tuntap *tt, struct buffer *buf)
 static inline int
 write_tun_buffered(struct tuntap *tt, struct buffer *buf)
 {
-    if (tt->wintun)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
         return write_wintun(tt, buf);
     }
@@ -712,7 +718,7 @@ tun_set(struct tuntap *tt,
             }
         }
 #ifdef _WIN32
-        if (!tt->wintun && (rwflags & EVENT_READ))
+        if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
         {
             tun_read_queue(tt, 0);
         }
-- 
2.24.1.windows.2


