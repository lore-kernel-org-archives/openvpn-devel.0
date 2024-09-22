From: Gert Doering <gert@...1296...>
Date: Sun, 22 Sep 2024 22:37:49 +0200
Message-ID: <20240922203749.9802-1-gert@...1296...>
In-Reply-To: <gerrit.1725891072000.I8c0e9f32b235cb262ca2be6aac8d520e49b30d74@...2715...>
References: <gerrit.1725891072000.I8c0e9f32b235cb262ca2be6aac8d520e49b30d74@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Move to common backend_driver type in
 struct tuntap
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

From: Arne Schwabe <arne@...1227...>

With the introduction of utun on macOS and DCO on Linux, FreeBSD and
Windows, a lot of platforms have now more than one driver/backend for
the tun interface but each one uses a different mechanism. Unify these
approach with using a common enum that defines the driver_type.

Change-Id: I8c0e9f32b235cb262ca2be6aac8d520e49b30d74
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/738
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7f0d53d..0df185e 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -328,7 +328,7 @@
         || (o->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6))
     {
         msg(msglevel, "--windows-driver is set to '%s'. Disabling Data Channel Offload",
-            print_windows_driver(o->windows_driver));
+            print_tun_backend_driver(o->windows_driver));
         return false;
     }
 
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 3ec946f..892c616 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -44,7 +44,7 @@
 struct tuntap
 create_dco_handle(const char *devname, struct gc_arena *gc)
 {
-    struct tuntap tt = { .windows_driver = WINDOWS_DRIVER_DCO };
+    struct tuntap tt = { .backend_driver = DRIVER_DCO };
     const char *device_guid;
 
     tun_open_device(&tt, devname, &device_guid, gc);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8c02407..a88a4bb 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1299,7 +1299,7 @@
     c->c2.buf = c->c2.buffers->read_tun_buf;
 
 #ifdef _WIN32
-    if (c->c1.tuntap->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (c->c1.tuntap->backend_driver == WINDOWS_DRIVER_WINTUN)
     {
         read_wintun(c->c1.tuntap, &c->c2.buf);
         if (c->c2.buf.len == -1)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dd56961..83cc670 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1126,7 +1126,7 @@
             msg(M_WARN, "Note: --mktun does not support DCO. Creating TUN interface.");
         }
 
-        options->tuntap_options.disable_dco = true;
+        options->disable_dco = true;
     }
 #endif
 
@@ -1759,7 +1759,16 @@
                             c->c1.tuntap);
 
 #ifdef _WIN32
-    c->c1.tuntap->windows_driver = c->options.windows_driver;
+    c->c1.tuntap->backend_driver = c->options.windows_driver;
+#else
+    if (dco_enabled(&c->options))
+    {
+        c->c1.tuntap->backend_driver = DRIVER_DCO;
+    }
+    else
+    {
+        c->c1.tuntap->backend_driver = DRIVER_GENERIC_TUNTAP;
+    }
 #endif
 
     init_tun_post(c->c1.tuntap,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 649f48b..61f6285 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -905,7 +905,7 @@
     o->allow_recursive_routing = false;
 
 #ifndef ENABLE_DCO
-    o->tuntap_options.disable_dco = true;
+    o->disable_dco = true;
 #endif /* ENABLE_DCO */
 }
 
@@ -1829,7 +1829,7 @@
     SHOW_STR(dev_type);
     SHOW_STR(dev_node);
 #if defined(ENABLE_DCO)
-    SHOW_BOOL(tuntap_options.disable_dco);
+    SHOW_BOOL(disable_dco);
 #endif
     SHOW_STR(lladdr);
     SHOW_INT(topology);
@@ -2489,7 +2489,7 @@
         if (options->windows_driver != WINDOWS_DRIVER_TAP_WINDOWS6)
         {
             msg(M_USAGE, "%s, which is not supported by the selected %s driver",
-                prefix, print_windows_driver(options->windows_driver));
+                prefix, print_tun_backend_driver(options->windows_driver));
         }
         else if (options->tuntap_options.ip_win32_type != IPW32_SET_DHCP_MASQ
                  && options->tuntap_options.ip_win32_type != IPW32_SET_ADAPTIVE)
@@ -3403,7 +3403,7 @@
 
     /* when using wintun/ovpn-dco, kernel doesn't send DHCP requests, so don't use it */
     if ((options->windows_driver == WINDOWS_DRIVER_WINTUN
-         || options->windows_driver == WINDOWS_DRIVER_DCO)
+         || options->windows_driver == DRIVER_DCO)
         && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ
             || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
     {
@@ -3777,8 +3777,8 @@
     if (dco_enabled(o))
     {
         /* check if any option should force disabling DCO */
-        o->tuntap_options.disable_dco = !dco_check_option(D_DCO, o)
-                                        || !dco_check_startup_option(D_DCO, o);
+        o->disable_dco = !dco_check_option(D_DCO, o)
+                         || !dco_check_startup_option(D_DCO, o);
     }
 #ifdef USE_COMP
     if (dco_enabled(o))
@@ -3790,11 +3790,11 @@
 #ifdef _WIN32
     if (dco_enabled(o))
     {
-        o->windows_driver = WINDOWS_DRIVER_DCO;
+        o->windows_driver = DRIVER_DCO;
     }
     else
     {
-        if (o->windows_driver == WINDOWS_DRIVER_DCO)
+        if (o->windows_driver == DRIVER_DCO)
         {
             msg(M_WARN, "Option --windows-driver ovpn-dco is ignored because Data Channel Offload is disabled");
             o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
@@ -4699,9 +4699,9 @@
  *
  * @param str       value of --windows-driver option
  * @param msglevel  msglevel to report parsing error
- * @return enum windows_driver_type  driver type, WINDOWS_DRIVER_UNSPECIFIED on unknown --windows-driver value
+ * @return enum tun_driver_type  driver type, WINDOWS_DRIVER_UNSPECIFIED on unknown --windows-driver value
  */
-static enum windows_driver_type
+static enum tun_driver_type
 parse_windows_driver(const char *str, const int msglevel)
 {
     if (streq(str, "tap-windows6"))
@@ -4715,7 +4715,7 @@
 
     else if (streq(str, "ovpn-dco"))
     {
-        return WINDOWS_DRIVER_DCO;
+        return DRIVER_DCO;
     }
     else
     {
@@ -6053,7 +6053,7 @@
 #endif
     else if (streq(p[0], "disable-dco"))
     {
-        options->tuntap_options.disable_dco = true;
+        options->disable_dco = true;
     }
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f608cb8..ee39dbb 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -354,6 +354,9 @@
     const char *ip_remote_hint;
 
     struct tuntap_options tuntap_options;
+    /* DCO is disabled and should not be used as backend driver for the
+     * tun/tap device */
+    bool disable_dco;
 
     /* Misc parms */
     const char *username;
@@ -676,7 +679,7 @@
     bool show_net_up;
     int route_method;
     bool block_outside_dns;
-    enum windows_driver_type windows_driver;
+    enum tun_driver_type windows_driver;
 #endif
 
     bool use_peer_id;
@@ -907,7 +910,7 @@
 dco_enabled(const struct options *o)
 {
 #ifdef ENABLE_DCO
-    return !o->tuntap_options.disable_dco;
+    return !o->disable_dco;
 #else
     return false;
 #endif /* ENABLE_DCO */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d5bad86..3959363 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -55,6 +55,31 @@
 
 #include <string.h>
 
+const char *
+print_tun_backend_driver(enum tun_driver_type driver)
+{
+    switch (driver)
+    {
+        case WINDOWS_DRIVER_TAP_WINDOWS6:
+            return "tap-windows6";
+
+        case WINDOWS_DRIVER_WINTUN:
+            return "wintun";
+
+        case DRIVER_GENERIC_TUNTAP:
+            return "tun/tap";
+
+        case DRIVER_DCO:
+            return "ovpn-dco";
+
+        case DRIVER_UTUN:
+            return "utun";
+
+        default:
+            return "unspecified";
+    }
+}
+
 #ifdef _WIN32
 
 const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
@@ -966,7 +991,7 @@
 {
     tt->options = *options;
 #ifdef _WIN32
-    if (tt->windows_driver == WINDOWS_DRIVER_DCO)
+    if (tt->backend_driver == DRIVER_DCO)
     {
         dco_start_tun(tt);
         return;
@@ -976,7 +1001,7 @@
     overlapped_io_init(&tt->writes, frame, TRUE);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
     {
         tt->wintun_send_ring_handle = CreateFileMapping(INVALID_HANDLE_VALUE, NULL,
                                                         PAGE_READWRITE,
@@ -1859,7 +1884,7 @@
 static bool
 tun_dco_enabled(struct tuntap *tt)
 {
-    return !tt->options.disable_dco;
+    return tt->backend_driver == DRIVER_DCO;
 }
 #endif
 
@@ -3339,7 +3364,7 @@
     tt->actual_name = string_alloc(utunname, NULL);
 
     msg(M_INFO, "Opened utun device %s", utunname);
-    tt->is_utun = true;
+    tt->backend_driver = DRIVER_UTUN;
 }
 
 #endif /* ifdef HAVE_NET_IF_UTUN_H */
@@ -3366,7 +3391,7 @@
          * and dev_node is not specified */
         open_darwin_utun(dev, dev_type, dev_node, tt);
 
-        if (!tt->is_utun)
+        if (tt->backend_driver != DRIVER_UTUN)
         {
             if (!dev_node)
             {
@@ -3428,7 +3453,7 @@
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
 #ifdef HAVE_NET_IF_UTUN_H
-    if (tt->is_utun)
+    if (tt->backend_driver == DRIVER_UTUN)
     {
         return write_tun_header(tt, buf, len);
     }
@@ -3441,7 +3466,7 @@
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
 #ifdef HAVE_NET_IF_UTUN_H
-    if (tt->is_utun)
+    if (tt->backend_driver == DRIVER_UTUN)
     {
         return read_tun_header(tt, buf, len);
     }
@@ -3972,7 +3997,7 @@
                 if (status == ERROR_SUCCESS && data_type == REG_SZ)
                 {
                     /* Is this adapter supported? */
-                    enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
+                    enum tun_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
                     if (strcasecmp(component_id, TAP_WIN_COMPONENT_ID) == 0
                         || strcasecmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) == 0)
                     {
@@ -3984,7 +4009,7 @@
                     }
                     else if (strcasecmp(component_id, "ovpn-dco") == 0)
                     {
-                        windows_driver = WINDOWS_DRIVER_DCO;
+                        windows_driver = DRIVER_DCO;
                     }
 
                     if (windows_driver != WINDOWS_DRIVER_UNSPECIFIED)
@@ -4006,7 +4031,7 @@
                         last = reg;
 
                         msg(D_TAP_WIN_DEBUG, "NetCfgInstanceId: %s, Driver: %s",
-                            reg->guid, print_windows_driver(reg->windows_driver));
+                            reg->guid, print_tun_backend_driver(reg->windows_driver));
                     }
                 }
             }
@@ -4238,7 +4263,7 @@
         {
             if (!strcmp(tr->guid, pr->guid))
             {
-                msg(msglev, "'%s' %s %s", pr->name, tr->guid, print_windows_driver(tr->windows_driver));
+                msg(msglev, "'%s' %s %s", pr->name, tr->guid, print_tun_backend_driver(tr->windows_driver));
                 ++links;
             }
         }
@@ -4359,7 +4384,7 @@
                             int actual_name_size,
                             const struct tap_reg *tap_reg_src,
                             const struct panel_reg *panel_reg_src,
-                            enum windows_driver_type *windows_driver,
+                            enum tun_driver_type *windows_driver,
                             struct gc_arena *gc)
 {
     const struct tap_reg *tap_reg = tap_reg_src;
@@ -4423,7 +4448,7 @@
 get_device_guid(const char *name,
                 uint8_t *actual_name,
                 int actual_name_size,
-                enum windows_driver_type *windows_driver,
+                enum tun_driver_type *windows_driver,
                 const struct tap_reg *tap_reg,
                 const struct panel_reg *panel_reg,
                 struct gc_arena *gc)
@@ -6209,7 +6234,7 @@
     const DWORD index = tt->adapter_index;
 
     /* flush arp cache */
-    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6
+    if (tt->backend_driver == WINDOWS_DRIVER_TAP_WINDOWS6
         && index != TUN_ADAPTER_INDEX_INVALID)
     {
         DWORD status = -1;
@@ -6546,8 +6571,8 @@
     const char *path = NULL;
     char tuntap_device_path[256];
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN
-        || tt->windows_driver == WINDOWS_DRIVER_DCO)
+    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN
+        || tt->backend_driver == DRIVER_DCO)
     {
         const struct device_instance_id_interface *dev_if;
 
@@ -6558,7 +6583,7 @@
                 continue;
             }
 
-            if (tt->windows_driver == WINDOWS_DRIVER_DCO)
+            if (tt->backend_driver == DRIVER_DCO)
             {
                 char *last_sep = strrchr(dev_if->device_interface, '\\');
                 if (!last_sep
@@ -6597,11 +6622,11 @@
                           0);
     if (tt->hand == INVALID_HANDLE_VALUE)
     {
-        msg(D_TUNTAP_INFO | M_ERRNO, "CreateFile failed on %s device: %s", print_windows_driver(tt->windows_driver), path);
+        msg(D_TUNTAP_INFO | M_ERRNO, "CreateFile failed on %s device: %s", print_tun_backend_driver(tt->backend_driver), path);
         return false;
     }
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
     {
         /* Wintun adapter may be considered "open" after ring buffers are successfuly registered. */
         if (!wintun_register_ring_buffer(tt, device_guid))
@@ -6631,7 +6656,7 @@
      */
     if (dev_node)
     {
-        enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
+        enum tun_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
 
         /* Get the device GUID for the device specified with --dev-node. */
         *device_guid = get_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), &windows_driver, tap_reg, panel_reg, gc);
@@ -6641,15 +6666,15 @@
             msg(M_FATAL, "Adapter '%s' not found", dev_node);
         }
 
-        if (tt->windows_driver != windows_driver)
+        if (tt->backend_driver != windows_driver)
         {
             msg(M_FATAL, "Adapter '%s' is using %s driver, %s expected. If you want to use this device, adjust --windows-driver.",
-                dev_node, print_windows_driver(windows_driver), print_windows_driver(tt->windows_driver));
+                dev_node, print_tun_backend_driver(windows_driver), print_tun_backend_driver(tt->backend_driver));
         }
 
         if (!tun_try_open_device(tt, *device_guid, device_instance_id_interface))
         {
-            msg(M_FATAL, "Failed to open %s adapter: %s", print_windows_driver(tt->windows_driver), dev_node);
+            msg(M_FATAL, "Failed to open %s adapter: %s", print_tun_backend_driver(tt->backend_driver), dev_node);
         }
     }
     else
@@ -6659,7 +6684,7 @@
         /* Try opening all TAP devices until we find one available */
         while (true)
         {
-            enum windows_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
+            enum tun_driver_type windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
             *device_guid = get_unspecified_device_guid(device_number,
                                                        actual_buffer,
                                                        sizeof(actual_buffer),
@@ -6670,10 +6695,10 @@
 
             if (!*device_guid)
             {
-                msg(M_FATAL, "All %s adapters on this system are currently in use or disabled.", print_windows_driver(tt->windows_driver));
+                msg(M_FATAL, "All %s adapters on this system are currently in use or disabled.", print_tun_backend_driver(tt->backend_driver));
             }
 
-            if (tt->windows_driver != windows_driver)
+            if (tt->backend_driver != windows_driver)
             {
                 goto next;
             }
@@ -6692,7 +6717,7 @@
      * GUID using the registry */
     tt->actual_name = string_alloc((const char *)actual_buffer, NULL);
 
-    msg(M_INFO, "%s device [%s] opened", print_windows_driver(tt->windows_driver), tt->actual_name);
+    msg(M_INFO, "%s device [%s] opened", print_tun_backend_driver(tt->backend_driver), tt->actual_name);
     tt->adapter_index = get_adapter_index(*device_guid);
 }
 
@@ -6745,7 +6770,7 @@
     bool dhcp_masq = false;
     bool dhcp_masq_post = false;
 
-    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
+    if (tt->backend_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         /* get driver version info */
         tuntap_get_version_info(tt);
@@ -6788,11 +6813,11 @@
          openvpn_net_ctx_t *ctx)
 {
     if ((tt->options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
-        && tt->windows_driver != WINDOWS_DRIVER_TAP_WINDOWS6)
+        && tt->backend_driver != WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         msg(M_WARN, "Some --dhcp-option or --dns options require DHCP server,"
             " which is not supported by the selected %s driver. They will be"
-            " ignored.", print_windows_driver(tt->windows_driver));
+            " ignored.", print_tun_backend_driver(tt->backend_driver));
     }
 
     /* dco-win already opened the device, which handle we treat as socket */
@@ -6830,7 +6855,7 @@
 const char *
 tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 {
-    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
+    if (tt->backend_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         struct buffer out = alloc_buf_gc(256, gc);
         DWORD len;
@@ -6848,7 +6873,7 @@
 void
 tun_show_debug(struct tuntap *tt)
 {
-    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
+    if (tt->backend_driver == WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         struct buffer out = alloc_buf(1024);
         DWORD len;
@@ -6925,7 +6950,7 @@
 void
 close_tun_handle(struct tuntap *tt)
 {
-    const char *adaptertype = print_windows_driver(tt->windows_driver);
+    const char *adaptertype = print_tun_backend_driver(tt->backend_driver);
 
     if (tt->hand)
     {
@@ -6952,7 +6977,7 @@
         tt->hand = NULL;
     }
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
     {
         CloseHandle(tt->rw_handle.read);
         CloseHandle(tt->rw_handle.write);
@@ -7113,25 +7138,6 @@
     return BSTR(&out);
 }
 
-const char *
-print_windows_driver(enum windows_driver_type windows_driver)
-{
-    switch (windows_driver)
-    {
-        case WINDOWS_DRIVER_TAP_WINDOWS6:
-            return "tap-windows6";
-
-        case WINDOWS_DRIVER_WINTUN:
-            return "wintun";
-
-        case WINDOWS_DRIVER_DCO:
-            return "ovpn-dco";
-
-        default:
-            return "unspecified";
-    }
-}
-
 #else /* generic */
 
 void
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 33b9552..80f8bfa 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -42,16 +42,19 @@
 #include "ring_buffer.h"
 #include "dco.h"
 
-#ifdef _WIN32
-#define WINTUN_COMPONENT_ID "wintun"
-#define DCO_WIN_REFERENCE_STRING "ovpn-dco"
-
-enum windows_driver_type {
+enum tun_driver_type {
     WINDOWS_DRIVER_UNSPECIFIED,
     WINDOWS_DRIVER_TAP_WINDOWS6,
     WINDOWS_DRIVER_WINTUN,
-    WINDOWS_DRIVER_DCO
+    DRIVER_GENERIC_TUNTAP,
+    DRIVER_DCO,
+    /** macOS internal tun driver */
+    DRIVER_UTUN
 };
+
+#ifdef _WIN32
+#define WINTUN_COMPONENT_ID "wintun"
+#define DCO_WIN_REFERENCE_STRING "ovpn-dco"
 #endif
 
 #if defined(_WIN32) || defined(TARGET_ANDROID)
@@ -70,8 +73,6 @@
     /* --ip-win32 options */
     bool ip_win32_defined;
 
-    bool disable_dco;
-
 #define IPW32_SET_MANUAL       0   /* "--ip-win32 manual" */
 #define IPW32_SET_NETSH        1   /* "--ip-win32 netsh" */
 #define IPW32_SET_IPAPI        2   /* "--ip-win32 ipapi" */
@@ -147,20 +148,12 @@
 
 struct tuntap_options {
     int txqueuelen;
-    bool disable_dco;
-};
-
-#elif defined(TARGET_FREEBSD)
-
-struct tuntap_options {
-    bool disable_dco;
 };
 
 #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 
 struct tuntap_options {
     int dummy; /* not used */
-    bool disable_dco; /* not used, but removes the need in #ifdefs */
 };
 
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
@@ -177,6 +170,11 @@
 #define TUNNEL_TOPOLOGY(tt) ((tt) ? ((tt)->topology) : TOP_UNDEF)
     int topology; /* one of the TOP_x values */
 
+    /** The backend driver that used for this tun/tap device. This can be
+     * one of the various windows drivers, "normal" tun/tap, utun, dco, ...
+     */
+    enum tun_driver_type backend_driver;
+
     bool did_ifconfig_setup;
     bool did_ifconfig_ipv6_setup;
 
@@ -211,7 +209,6 @@
      * ~0 if undefined */
     DWORD adapter_index;
 
-    enum windows_driver_type windows_driver;
     int standby_iter;
 
     HANDLE wintun_send_ring_handle;
@@ -226,9 +223,6 @@
     int ip_fd;
 #endif
 
-#ifdef HAVE_NET_IF_UTUN_H
-    bool is_utun;
-#endif
     /* used for printing status info only */
     unsigned int rwflags_debug;
 
@@ -249,7 +243,7 @@
 static inline bool
 tuntap_is_wintun(struct tuntap *tt)
 {
-    return tt && tt->windows_driver == WINDOWS_DRIVER_WINTUN;
+    return tt && tt->backend_driver == WINDOWS_DRIVER_WINTUN;
 }
 
 static inline bool
@@ -397,7 +391,7 @@
 struct tap_reg
 {
     const char *guid;
-    enum windows_driver_type windows_driver;
+    enum tun_driver_type windows_driver;
     struct tap_reg *next;
 };
 
@@ -643,7 +637,7 @@
 static inline int
 write_tun_buffered(struct tuntap *tt, struct buffer *buf)
 {
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver == WINDOWS_DRIVER_WINTUN)
     {
         return write_wintun(tt, buf);
     }
@@ -656,7 +650,7 @@
 static inline bool
 tuntap_is_dco_win(struct tuntap *tt)
 {
-    return tt && tt->windows_driver == WINDOWS_DRIVER_DCO;
+    return tt && tt->backend_driver == DRIVER_DCO;
 }
 
 static inline bool
@@ -666,7 +660,7 @@
 }
 
 const char *
-print_windows_driver(enum windows_driver_type windows_driver);
+print_tun_backend_driver(enum tun_driver_type driver);
 
 #else  /* ifdef _WIN32 */
 
@@ -744,7 +738,7 @@
         }
     }
 #ifdef _WIN32
-    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
+    if (tt->backend_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
     {
         tun_read_queue(tt, 0);
     }

