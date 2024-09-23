From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 06:13:30 +0000
In-Reply-To: <gerrit.1725891072000.I8c0e9f32b235cb262ca2be6aac8d520e49b30d74@...2715...>
References: <gerrit.1725891072000.I8c0e9f32b235cb262ca2be6aac8d520e49b30d74@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c10c9e6d1569a84fe35ecdd88b54bdbb74ebd30f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9x//Fi6R7Es="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move to common
 backend_driver type in struct tuntap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9x//Fi6R7Es=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#12) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/738?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Move to common backend_driver type in struct tuntap
......................................................................

Move to common backend_driver type in struct tuntap

With the introduction of utun on macOS and DCO on Linux, FreeBSD and
Windows, a lot of platforms have now more than one driver/backend for
the tun interface but each one uses a different mechanism. Unify these
approach with using a common enum that defines the driver_type.

Change-Id: I8c0e9f32b235cb262ca2be6aac8d520e49b30d74
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240922203749.9802-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
352.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/tun.c
M src/openvpn/tun.h
8 files changed, 110 insertions(+), 98 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/738/12

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7f0d53d..0df185e 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -328,7 +328,7 @@
         || (o->windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6))
     {
         msg(msglevel, "--windows-driver is set to '%s'. Disabling Data Cha=
nnel Offload",
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
-    struct tuntap tt =3D { .windows_driver =3D WINDOWS_DRIVER_DCO };
+    struct tuntap tt =3D { .backend_driver =3D DRIVER_DCO };
     const char *device_guid;

     tun_open_device(&tt, devname, &device_guid, gc);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8c02407..a88a4bb 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1299,7 +1299,7 @@
     c->c2.buf =3D c->c2.buffers->read_tun_buf;

 #ifdef _WIN32
-    if (c->c1.tuntap->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN)
+    if (c->c1.tuntap->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
     {
         read_wintun(c->c1.tuntap, &c->c2.buf);
         if (c->c2.buf.len =3D=3D -1)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dd56961..83cc670 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1126,7 +1126,7 @@
             msg(M_WARN, "Note: --mktun does not support DCO. Creating TUN =
interface.");
         }

-        options->tuntap_options.disable_dco =3D true;
+        options->disable_dco =3D true;
     }
 #endif

@@ -1759,7 +1759,16 @@
                             c->c1.tuntap);

 #ifdef _WIN32
-    c->c1.tuntap->windows_driver =3D c->options.windows_driver;
+    c->c1.tuntap->backend_driver =3D c->options.windows_driver;
+#else
+    if (dco_enabled(&c->options))
+    {
+        c->c1.tuntap->backend_driver =3D DRIVER_DCO;
+    }
+    else
+    {
+        c->c1.tuntap->backend_driver =3D DRIVER_GENERIC_TUNTAP;
+    }
 #endif

     init_tun_post(c->c1.tuntap,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 649f48b..61f6285 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -905,7 +905,7 @@
     o->allow_recursive_routing =3D false;

 #ifndef ENABLE_DCO
-    o->tuntap_options.disable_dco =3D true;
+    o->disable_dco =3D true;
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
         if (options->windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)
         {
             msg(M_USAGE, "%s, which is not supported by the selected %s dr=
iver",
-                prefix, print_windows_driver(options->windows_driver));
+                prefix, print_tun_backend_driver(options->windows_driver));
         }
         else if (options->tuntap_options.ip_win32_type !=3D IPW32_SET_DHCP=
_MASQ
                  && options->tuntap_options.ip_win32_type !=3D IPW32_SET_A=
DAPTIVE)
@@ -3403,7 +3403,7 @@

     /* when using wintun/ovpn-dco, kernel doesn't send DHCP requests, so d=
on't use it */
     if ((options->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN
-         || options->windows_driver =3D=3D WINDOWS_DRIVER_DCO)
+         || options->windows_driver =3D=3D DRIVER_DCO)
         && (options->tuntap_options.ip_win32_type =3D=3D IPW32_SET_DHCP_MA=
SQ
             || options->tuntap_options.ip_win32_type =3D=3D IPW32_SET_ADAP=
TIVE))
     {
@@ -3777,8 +3777,8 @@
     if (dco_enabled(o))
     {
         /* check if any option should force disabling DCO */
-        o->tuntap_options.disable_dco =3D !dco_check_option(D_DCO, o)
-                                        || !dco_check_startup_option(D_DCO=
, o);
+        o->disable_dco =3D !dco_check_option(D_DCO, o)
+                         || !dco_check_startup_option(D_DCO, o);
     }
 #ifdef USE_COMP
     if (dco_enabled(o))
@@ -3790,11 +3790,11 @@
 #ifdef _WIN32
     if (dco_enabled(o))
     {
-        o->windows_driver =3D WINDOWS_DRIVER_DCO;
+        o->windows_driver =3D DRIVER_DCO;
     }
     else
     {
-        if (o->windows_driver =3D=3D WINDOWS_DRIVER_DCO)
+        if (o->windows_driver =3D=3D DRIVER_DCO)
         {
             msg(M_WARN, "Option --windows-driver ovpn-dco is ignored becau=
se Data Channel Offload is disabled");
             o->windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;
@@ -4699,9 +4699,9 @@
  *
  * @param str       value of --windows-driver option
  * @param msglevel  msglevel to report parsing error
- * @return enum windows_driver_type  driver type, WINDOWS_DRIVER_UNSPECIFI=
ED on unknown --windows-driver value
+ * @return enum tun_driver_type  driver type, WINDOWS_DRIVER_UNSPECIFIED o=
n unknown --windows-driver value
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
-        options->tuntap_options.disable_dco =3D true;
+        options->disable_dco =3D true;
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

 const static GUID GUID_DEVCLASS_NET =3D { 0x4d36e972L, 0xe325, 0x11ce, { 0=
xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
@@ -966,7 +991,7 @@
 {
     tt->options =3D *options;
 #ifdef _WIN32
-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_DCO)
+    if (tt->backend_driver =3D=3D DRIVER_DCO)
     {
         dco_start_tun(tt);
         return;
@@ -976,7 +1001,7 @@
     overlapped_io_init(&tt->writes, frame, TRUE);
     tt->adapter_index =3D TUN_ADAPTER_INDEX_INVALID;

-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
     {
         tt->wintun_send_ring_handle =3D CreateFileMapping(INVALID_HANDLE_V=
ALUE, NULL,
                                                         PAGE_READWRITE,
@@ -1859,7 +1884,7 @@
 static bool
 tun_dco_enabled(struct tuntap *tt)
 {
-    return !tt->options.disable_dco;
+    return tt->backend_driver =3D=3D DRIVER_DCO;
 }
 #endif

@@ -3339,7 +3364,7 @@
     tt->actual_name =3D string_alloc(utunname, NULL);

     msg(M_INFO, "Opened utun device %s", utunname);
-    tt->is_utun =3D true;
+    tt->backend_driver =3D DRIVER_UTUN;
 }

 #endif /* ifdef HAVE_NET_IF_UTUN_H */
@@ -3366,7 +3391,7 @@
          * and dev_node is not specified */
         open_darwin_utun(dev, dev_type, dev_node, tt);

-        if (!tt->is_utun)
+        if (tt->backend_driver !=3D DRIVER_UTUN)
         {
             if (!dev_node)
             {
@@ -3428,7 +3453,7 @@
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
 #ifdef HAVE_NET_IF_UTUN_H
-    if (tt->is_utun)
+    if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
         return write_tun_header(tt, buf, len);
     }
@@ -3441,7 +3466,7 @@
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
 #ifdef HAVE_NET_IF_UTUN_H
-    if (tt->is_utun)
+    if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
         return read_tun_header(tt, buf, len);
     }
@@ -3972,7 +3997,7 @@
                 if (status =3D=3D ERROR_SUCCESS && data_type =3D=3D REG_SZ)
                 {
                     /* Is this adapter supported? */
-                    enum windows_driver_type windows_driver =3D WINDOWS_DR=
IVER_UNSPECIFIED;
+                    enum tun_driver_type windows_driver =3D WINDOWS_DRIVER=
_UNSPECIFIED;
                     if (strcasecmp(component_id, TAP_WIN_COMPONENT_ID) =3D=
=3D 0
                         || strcasecmp(component_id, "root\\" TAP_WIN_COMPO=
NENT_ID) =3D=3D 0)
                     {
@@ -3984,7 +4009,7 @@
                     }
                     else if (strcasecmp(component_id, "ovpn-dco") =3D=3D 0)
                     {
-                        windows_driver =3D WINDOWS_DRIVER_DCO;
+                        windows_driver =3D DRIVER_DCO;
                     }

                     if (windows_driver !=3D WINDOWS_DRIVER_UNSPECIFIED)
@@ -4006,7 +4031,7 @@
                         last =3D reg;
=20
                         msg(D_TAP_WIN_DEBUG, "NetCfgInstanceId: %s, Driver=
: %s",
-                            reg->guid, print_windows_driver(reg->windows_d=
river));
+                            reg->guid, print_tun_backend_driver(reg->windo=
ws_driver));
                     }
                 }
             }
@@ -4238,7 +4263,7 @@
         {
             if (!strcmp(tr->guid, pr->guid))
             {
-                msg(msglev, "'%s' %s %s", pr->name, tr->guid, print_window=
s_driver(tr->windows_driver));
+                msg(msglev, "'%s' %s %s", pr->name, tr->guid, print_tun_ba=
ckend_driver(tr->windows_driver));
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
     const struct tap_reg *tap_reg =3D tap_reg_src;
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
     const DWORD index =3D tt->adapter_index;

     /* flush arp cache */
-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6
         && index !=3D TUN_ADAPTER_INDEX_INVALID)
     {
         DWORD status =3D -1;
@@ -6546,8 +6571,8 @@
     const char *path =3D NULL;
     char tuntap_device_path[256];

-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN
-        || tt->windows_driver =3D=3D WINDOWS_DRIVER_DCO)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN
+        || tt->backend_driver =3D=3D DRIVER_DCO)
     {
         const struct device_instance_id_interface *dev_if;

@@ -6558,7 +6583,7 @@
                 continue;
             }

-            if (tt->windows_driver =3D=3D WINDOWS_DRIVER_DCO)
+            if (tt->backend_driver =3D=3D DRIVER_DCO)
             {
                 char *last_sep =3D strrchr(dev_if->device_interface, '\\');
                 if (!last_sep
@@ -6597,11 +6622,11 @@
                           0);
     if (tt->hand =3D=3D INVALID_HANDLE_VALUE)
     {
-        msg(D_TUNTAP_INFO | M_ERRNO, "CreateFile failed on %s device: %s",=
 print_windows_driver(tt->windows_driver), path);
+        msg(D_TUNTAP_INFO | M_ERRNO, "CreateFile failed on %s device: %s",=
 print_tun_backend_driver(tt->backend_driver), path);
         return false;
     }

-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
     {
         /* Wintun adapter may be considered "open" after ring buffers are =
successfuly registered. */
         if (!wintun_register_ring_buffer(tt, device_guid))
@@ -6631,7 +6656,7 @@
      */
     if (dev_node)
     {
-        enum windows_driver_type windows_driver =3D WINDOWS_DRIVER_UNSPECI=
FIED;
+        enum tun_driver_type windows_driver =3D WINDOWS_DRIVER_UNSPECIFIED;

         /* Get the device GUID for the device specified with --dev-node. */
         *device_guid =3D get_device_guid(dev_node, actual_buffer, sizeof(a=
ctual_buffer), &windows_driver, tap_reg, panel_reg, gc);
@@ -6641,15 +6666,15 @@
             msg(M_FATAL, "Adapter '%s' not found", dev_node);
         }

-        if (tt->windows_driver !=3D windows_driver)
+        if (tt->backend_driver !=3D windows_driver)
         {
             msg(M_FATAL, "Adapter '%s' is using %s driver, %s expected. If=
 you want to use this device, adjust --windows-driver.",
-                dev_node, print_windows_driver(windows_driver), print_wind=
ows_driver(tt->windows_driver));
+                dev_node, print_tun_backend_driver(windows_driver), print_=
tun_backend_driver(tt->backend_driver));
         }

         if (!tun_try_open_device(tt, *device_guid, device_instance_id_inte=
rface))
         {
-            msg(M_FATAL, "Failed to open %s adapter: %s", print_windows_dr=
iver(tt->windows_driver), dev_node);
+            msg(M_FATAL, "Failed to open %s adapter: %s", print_tun_backen=
d_driver(tt->backend_driver), dev_node);
         }
     }
     else
@@ -6659,7 +6684,7 @@
         /* Try opening all TAP devices until we find one available */
         while (true)
         {
-            enum windows_driver_type windows_driver =3D WINDOWS_DRIVER_UNS=
PECIFIED;
+            enum tun_driver_type windows_driver =3D WINDOWS_DRIVER_UNSPECI=
FIED;
             *device_guid =3D get_unspecified_device_guid(device_number,
                                                        actual_buffer,
                                                        sizeof(actual_buffe=
r),
@@ -6670,10 +6695,10 @@
=20
             if (!*device_guid)
             {
-                msg(M_FATAL, "All %s adapters on this system are currently=
 in use or disabled.", print_windows_driver(tt->windows_driver));
+                msg(M_FATAL, "All %s adapters on this system are currently=
 in use or disabled.", print_tun_backend_driver(tt->backend_driver));
             }

-            if (tt->windows_driver !=3D windows_driver)
+            if (tt->backend_driver !=3D windows_driver)
             {
                 goto next;
             }
@@ -6692,7 +6717,7 @@
      * GUID using the registry */
     tt->actual_name =3D string_alloc((const char *)actual_buffer, NULL);

-    msg(M_INFO, "%s device [%s] opened", print_windows_driver(tt->windows_=
driver), tt->actual_name);
+    msg(M_INFO, "%s device [%s] opened", print_tun_backend_driver(tt->back=
end_driver), tt->actual_name);
     tt->adapter_index =3D get_adapter_index(*device_guid);
 }

@@ -6745,7 +6770,7 @@
     bool dhcp_masq =3D false;
     bool dhcp_masq_post =3D false;

-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         /* get driver version info */
         tuntap_get_version_info(tt);
@@ -6788,11 +6813,11 @@
          openvpn_net_ctx_t *ctx)
 {
     if ((tt->options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
-        && tt->windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)
+        && tt->backend_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         msg(M_WARN, "Some --dhcp-option or --dns options require DHCP serv=
er,"
             " which is not supported by the selected %s driver. They will =
be"
-            " ignored.", print_windows_driver(tt->windows_driver));
+            " ignored.", print_tun_backend_driver(tt->backend_driver));
     }

     /* dco-win already opened the device, which handle we treat as socket =
*/
@@ -6830,7 +6855,7 @@
 const char *
 tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
 {
-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         struct buffer out =3D alloc_buf_gc(256, gc);
         DWORD len;
@@ -6848,7 +6873,7 @@
 void
 tun_show_debug(struct tuntap *tt)
 {
-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)
     {
         struct buffer out =3D alloc_buf(1024);
         DWORD len;
@@ -6925,7 +6950,7 @@
 void
 close_tun_handle(struct tuntap *tt)
 {
-    const char *adaptertype =3D print_windows_driver(tt->windows_driver);
+    const char *adaptertype =3D print_tun_backend_driver(tt->backend_drive=
r);

     if (tt->hand)
     {
@@ -6952,7 +6977,7 @@
         tt->hand =3D NULL;
     }

-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
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
-    return tt && tt->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN;
+    return tt && tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN;
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
-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_WINTUN)
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)
     {
         return write_wintun(tt, buf);
     }
@@ -656,7 +650,7 @@
 static inline bool
 tuntap_is_dco_win(struct tuntap *tt)
 {
-    return tt && tt->windows_driver =3D=3D WINDOWS_DRIVER_DCO;
+    return tt && tt->backend_driver =3D=3D DRIVER_DCO;
 }

 static inline bool
@@ -666,7 +660,7 @@
 }
=20
 const char *
-print_windows_driver(enum windows_driver_type windows_driver);
+print_tun_backend_driver(enum tun_driver_type driver);

 #else  /* ifdef _WIN32 */

@@ -744,7 +738,7 @@
         }
     }
 #ifdef _WIN32
-    if (tt->windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags =
& EVENT_READ))
+    if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags =
& EVENT_READ))
     {
         tun_read_queue(tt, 0);
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/738?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8c0e9f32b235cb262ca2be6aac8d520e49b30d74
Gerrit-Change-Number: 738
Gerrit-PatchSet: 12
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--9x//Fi6R7Es=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #12</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/738?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Move to common backend_driver type in struct tuntap<=
br><br>With the introduction of utun on macOS and DCO on Linux, FreeBSD and=
<br>Windows, a lot of platforms have now more than one driver/backend for<b=
r>the tun interface but each one uses a different mechanism. Unify these<br=
>approach with using a common enum that defines the driver_type.<br><br>Cha=
nge-Id: I8c0e9f32b235cb262ca2be6aac8d520e49b30d74<br>Signed-off-by: Arne Sc=
hwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...=
&gt;<br>Message-Id: &lt;20240922203749.9802-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29352.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/dco.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/forward.c<br>M src=
/openvpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M =
src/openvpn/tun.c<br>M src/openvpn/tun.h<br>8 files changed, 110 insertions=
(+), 98 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/38/738/12</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/ope=
nvpn/dco.c</span><br><span>index 7f0d53d..0df185e 100644</span><br><span>--=
- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><sp=
an>@@ -328,7 +328,7 @@</span><br><span>         || (o-&gt;windows_driver =
=3D=3D WINDOWS_DRIVER_TAP_WINDOWS6))</span><br><span>     {</span><br><span=
>         msg(msglevel, &quot;--windows-driver is set to &#39;%s&#39;. Disa=
bling Data Channel Offload&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            print_windows_driver(o-&gt;windows_driver));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            print_tun_back=
end_driver(o-&gt;windows_driver));</span><br><span>         return false;</=
span><br><span>     }</span><br><span> </span><br><span>diff --git a/src/op=
envpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 3ec946f..892c=
616 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ =
b/src/openvpn/dco_win.c</span><br><span>@@ -44,7 +44,7 @@</span><br><span> =
struct tuntap</span><br><span> create_dco_handle(const char *devname, struc=
t gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct tuntap tt =3D { .windows_driver =3D WINDOWS_DRIVER_=
DCO };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tu=
ntap tt =3D { .backend_driver =3D DRIVER_DCO };</span><br><span>     const =
char *device_guid;</span><br><span> </span><br><span>     tun_open_device(&=
amp;tt, devname, &amp;device_guid, gc);</span><br><span>diff --git a/src/op=
envpn/forward.c b/src/openvpn/forward.c</span><br><span>index 8c02407..a88a=
4bb 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ =
b/src/openvpn/forward.c</span><br><span>@@ -1299,7 +1299,7 @@</span><br><sp=
an>     c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;read_tun_buf;</span><br><span=
> </span><br><span> #ifdef _WIN32</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (c-&gt;c1.tuntap-&gt;windows_driver =3D=3D WINDOWS_DRIVE=
R_WINTUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-=
&gt;c1.tuntap-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)</span><br><s=
pan>     {</span><br><span>         read_wintun(c-&gt;c1.tuntap, &amp;c-&gt=
;c2.buf);</span><br><span>         if (c-&gt;c2.buf.len =3D=3D -1)</span><b=
r><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><spa=
n>index dd56961..83cc670 100644</span><br><span>--- a/src/openvpn/init.c</s=
pan><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1126,7 +1126,7 @=
@</span><br><span>             msg(M_WARN, &quot;Note: --mktun does not sup=
port DCO. Creating TUN interface.&quot;);</span><br><span>         }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        op=
tions-&gt;tuntap_options.disable_dco =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        options-&gt;disable_dco =3D true;</span>=
<br><span>     }</span><br><span> #endif</span><br><span> </span><br><span>=
@@ -1759,7 +1759,16 @@</span><br><span>                             c-&gt;c=
1.tuntap);</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c1.tuntap-&gt;windows_drive=
r =3D c-&gt;options.windows_driver;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    c-&gt;c1.tuntap-&gt;backend_driver =3D c-&gt;options.wi=
ndows_driver;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(=
&amp;c-&gt;options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt=
;c1.tuntap-&gt;backend_driver =3D DRIVER_DCO;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt=
;c1.tuntap-&gt;backend_driver =3D DRIVER_GENERIC_TUNTAP;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #endif</span><b=
r><span> </span><br><span>     init_tun_post(c-&gt;c1.tuntap,</span><br><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 649f48b..61f6285 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -905,7 +90=
5,7 @@</span><br><span>     o-&gt;allow_recursive_routing =3D false;</span>=
<br><span> </span><br><span> #ifndef ENABLE_DCO</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    o-&gt;tuntap_options.disable_dco =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;disable_dco =
=3D true;</span><br><span> #endif /* ENABLE_DCO */</span><br><span> }</span=
><br><span> </span><br><span>@@ -1829,7 +1829,7 @@</span><br><span>     SHO=
W_STR(dev_type);</span><br><span>     SHOW_STR(dev_node);</span><br><span> =
#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    SHOW_BOOL(tuntap_options.disable_dco);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(disable_dco);</span><br><span> #endi=
f</span><br><span>     SHOW_STR(lladdr);</span><br><span>     SHOW_INT(topo=
logy);</span><br><span>@@ -2489,7 +2489,7 @@</span><br><span>         if (o=
ptions-&gt;windows_driver !=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span=
>         {</span><br><span>             msg(M_USAGE, &quot;%s, which is no=
t supported by the selected %s driver&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                prefix, print_windows_driver(options=
-&gt;windows_driver));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                prefix, print_tun_backend_driver(options-&gt;windows_dri=
ver));</span><br><span>         }</span><br><span>         else if (options=
-&gt;tuntap_options.ip_win32_type !=3D IPW32_SET_DHCP_MASQ</span><br><span>=
                  &amp;&amp; options-&gt;tuntap_options.ip_win32_type !=3D =
IPW32_SET_ADAPTIVE)</span><br><span>@@ -3403,7 +3403,7 @@</span><br><span> =
</span><br><span>     /* when using wintun/ovpn-dco, kernel doesn&#39;t sen=
d DHCP requests, so don&#39;t use it */</span><br><span>     if ((options-&=
gt;windows_driver =3D=3D WINDOWS_DRIVER_WINTUN</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         || options-&gt;windows_driver =3D=3D WIND=
OWS_DRIVER_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     || options-&gt;windows_driver =3D=3D DRIVER_DCO)</span><br><span>     =
    &amp;&amp; (options-&gt;tuntap_options.ip_win32_type =3D=3D IPW32_SET_D=
HCP_MASQ</span><br><span>             || options-&gt;tuntap_options.ip_win3=
2_type =3D=3D IPW32_SET_ADAPTIVE))</span><br><span>     {</span><br><span>@=
@ -3777,8 +3777,8 @@</span><br><span>     if (dco_enabled(o))</span><br><sp=
an>     {</span><br><span>         /* check if any option should force disa=
bling DCO */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
-&gt;tuntap_options.disable_dco =3D !dco_check_option(D_DCO, o)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
       || !dco_check_startup_option(D_DCO, o);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        o-&gt;disable_dco =3D !dco_check_option(=
D_DCO, o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
               || !dco_check_startup_option(D_DCO, o);</span><br><span>    =
 }</span><br><span> #ifdef USE_COMP</span><br><span>     if (dco_enabled(o)=
)</span><br><span>@@ -3790,11 +3790,11 @@</span><br><span> #ifdef _WIN32</s=
pan><br><span>     if (dco_enabled(o))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;windows_driver =3D WI=
NDOWS_DRIVER_DCO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      o-&gt;windows_driver =3D DRIVER_DCO;</span><br><span>     }</span><br=
><span>     else</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (o-&gt;windows_driver =3D=3D WINDOWS_DRIVER_DC=
O)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt=
;windows_driver =3D=3D DRIVER_DCO)</span><br><span>         {</span><br><sp=
an>             msg(M_WARN, &quot;Option --windows-driver ovpn-dco is ignor=
ed because Data Channel Offload is disabled&quot;);</span><br><span>       =
      o-&gt;windows_driver =3D WINDOWS_DRIVER_TAP_WINDOWS6;</span><br><span=
>@@ -4699,9 +4699,9 @@</span><br><span>  *</span><br><span>  * @param str  =
     value of --windows-driver option</span><br><span>  * @param msglevel  =
msglevel to report parsing error</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @return enum windows_driver_type  driver type, WINDOWS_DRIVER=
_UNSPECIFIED on unknown --windows-driver value</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return enum tun_driver_type  driver type, WI=
NDOWS_DRIVER_UNSPECIFIED on unknown --windows-driver value</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static enum windo=
ws_driver_type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c enum tun_driver_type</span><br><span> parse_windows_driver(const char *st=
r, const int msglevel)</span><br><span> {</span><br><span>     if (streq(st=
r, &quot;tap-windows6&quot;))</span><br><span>@@ -4715,7 +4715,7 @@</span><=
br><span> </span><br><span>     else if (streq(str, &quot;ovpn-dco&quot;))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return WINDOWS_DRIVER_DCO;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return DRIVER_DCO;</span><br><span>     }</span><br=
><span>     else</span><br><span>     {</span><br><span>@@ -6053,7 +6053,7 =
@@</span><br><span> #endif</span><br><span>     else if (streq(p[0], &quot;=
disable-dco&quot;))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        options-&gt;tuntap_options.disable_dco =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&=
gt;disable_dco =3D true;</span><br><span>     }</span><br><span>     else i=
f (streq(p[0], &quot;dev-node&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/options.h b/src=
/openvpn/options.h</span><br><span>index f608cb8..ee39dbb 100644</span><br>=
<span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options=
.h</span><br><span>@@ -354,6 +354,9 @@</span><br><span>     const char *ip_=
remote_hint;</span><br><span> </span><br><span>     struct tuntap_options t=
untap_options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* DCO is disabled and should not be used as backend driver for the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * tun/tap device */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool disable_dco;</=
span><br><span> </span><br><span>     /* Misc parms */</span><br><span>    =
 const char *username;</span><br><span>@@ -676,7 +679,7 @@</span><br><span>=
     bool show_net_up;</span><br><span>     int route_method;</span><br><sp=
an>     bool block_outside_dns;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    enum windows_driver_type windows_driver;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    enum tun_driver_type windows_driver;=
</span><br><span> #endif</span><br><span> </span><br><span>     bool use_pe=
er_id;</span><br><span>@@ -907,7 +910,7 @@</span><br><span> dco_enabled(con=
st struct options *o)</span><br><span> {</span><br><span> #ifdef ENABLE_DCO=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return !o-&gt;tun=
tap_options.disable_dco;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return !o-&gt;disable_dco;</span><br><span> #else</span><br><span>=
     return false;</span><br><span> #endif /* ENABLE_DCO */</span><br><span=
>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index d=
5bad86..3959363 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><s=
pan>+++ b/src/openvpn/tun.c</span><br><span>@@ -55,6 +55,31 @@</span><br><s=
pan> </span><br><span> #include &lt;string.h&gt;</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+print_tun_backend_driver(enum tun_d=
river_type driver)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (driver)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case WINDOWS_DRIVER_TAP_W=
INDOWS6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return &quot;tap-windows6&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case WINDOWS_DRIVER_WINTUN:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return &quot;wintun&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case DRIVER_GENERIC_TUNTAP:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return &quot;tun/tap&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        case DRIVER_DCO:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return &quot;ovpn-dco&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case DRIVER_UTUN:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return &quot;utun&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return &quot;unspecified&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><spa=
n> </span><br><span> const static GUID GUID_DEVCLASS_NET =3D { 0x4d36e972L,=
 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };</spa=
n><br><span>@@ -966,7 +991,7 @@</span><br><span> {</span><br><span>     tt-=
&gt;options =3D *options;</span><br><span> #ifdef _WIN32</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;windows_driver =3D=3D WIN=
DOWS_DRIVER_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (tt-&gt;backend_driver =3D=3D DRIVER_DCO)</span><br><span>     {</span>=
<br><span>         dco_start_tun(tt);</span><br><span>         return;</spa=
n><br><span>@@ -976,7 +1001,7 @@</span><br><span>     overlapped_io_init(&a=
mp;tt-&gt;writes, frame, TRUE);</span><br><span>     tt-&gt;adapter_index =
=3D TUN_ADAPTER_INDEX_INVALID;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (tt-&gt;windows_driver =3D=3D WINDOWS_DRI=
VER_WINTUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)</span><br><span>     {<=
/span><br><span>         tt-&gt;wintun_send_ring_handle =3D CreateFileMappi=
ng(INVALID_HANDLE_VALUE, NULL,</span><br><span>                            =
                             PAGE_READWRITE,</span><br><span>@@ -1859,7 +18=
84,7 @@</span><br><span> static bool</span><br><span> tun_dco_enabled(struc=
t tuntap *tt)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return !tt-&gt;options.disable_dco;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return tt-&gt;backend_driver =3D=3D DRIV=
ER_DCO;</span><br><span> }</span><br><span> #endif</span><br><span> </span>=
<br><span>@@ -3339,7 +3364,7 @@</span><br><span>     tt-&gt;actual_name =3D=
 string_alloc(utunname, NULL);</span><br><span> </span><br><span>     msg(M=
_INFO, &quot;Opened utun device %s&quot;, utunname);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;is_utun =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;backend_driver =3D DRIV=
ER_UTUN;</span><br><span> }</span><br><span> </span><br><span> #endif /* if=
def HAVE_NET_IF_UTUN_H */</span><br><span>@@ -3366,7 +3391,7 @@</span><br><=
span>          * and dev_node is not specified */</span><br><span>         =
open_darwin_utun(dev, dev_type, dev_node, tt);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (!tt-&gt;is_utun)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tt-&gt;back=
end_driver !=3D DRIVER_UTUN)</span><br><span>         {</span><br><span>   =
          if (!dev_node)</span><br><span>             {</span><br><span>@@ =
-3428,7 +3453,7 @@</span><br><span> write_tun(struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span> {</span><br><span> #ifdef HAVE_NET_IF_UTUN_H<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;is_utun=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;bac=
kend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br><span>    =
     return write_tun_header(tt, buf, len);</span><br><span>     }</span><b=
r><span>@@ -3441,7 +3466,7 @@</span><br><span> read_tun(struct tuntap *tt, =
uint8_t *buf, int len)</span><br><span> {</span><br><span> #ifdef HAVE_NET_=
IF_UTUN_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&=
gt;is_utun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>     {</span><br>=
<span>         return read_tun_header(tt, buf, len);</span><br><span>     }=
</span><br><span>@@ -3972,7 +3997,7 @@</span><br><span>                 if =
(status =3D=3D ERROR_SUCCESS &amp;&amp; data_type =3D=3D REG_SZ)</span><br>=
<span>                 {</span><br><span>                     /* Is this ad=
apter supported? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  enum windows_driver_type windows_driver =3D WINDOWS_DRIVE=
R_UNSPECIFIED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               enum tun_driver_type windows_driver =3D WINDOWS_DRIVER_UNSPE=
CIFIED;</span><br><span>                     if (strcasecmp(component_id, T=
AP_WIN_COMPONENT_ID) =3D=3D 0</span><br><span>                         || s=
trcasecmp(component_id, &quot;root\\&quot; TAP_WIN_COMPONENT_ID) =3D=3D 0)<=
/span><br><span>                     {</span><br><span>@@ -3984,7 +4009,7 @=
@</span><br><span>                     }</span><br><span>                  =
   else if (strcasecmp(component_id, &quot;ovpn-dco&quot;) =3D=3D 0)</span>=
<br><span>                     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        windows_driver =3D WINDOWS_DRIVER_DCO;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   windows_driver =3D DRIVER_DCO;</span><br><span>                     }</s=
pan><br><span> </span><br><span>                     if (windows_driver !=
=3D WINDOWS_DRIVER_UNSPECIFIED)</span><br><span>@@ -4006,7 +4031,7 @@</span=
><br><span>                         last =3D reg;</span><br><span> </span><=
br><span>                         msg(D_TAP_WIN_DEBUG, &quot;NetCfgInstance=
Id: %s, Driver: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                            reg-&gt;guid, print_windows_driver(reg-&gt;=
windows_driver));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          reg-&gt;guid, print_tun_backend_driver(reg-&gt;wi=
ndows_driver));</span><br><span>                     }</span><br><span>    =
             }</span><br><span>             }</span><br><span>@@ -4238,7 +4=
263,7 @@</span><br><span>         {</span><br><span>             if (!strcm=
p(tr-&gt;guid, pr-&gt;guid))</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                msg(msglev, &quot;&#3=
9;%s&#39; %s %s&quot;, pr-&gt;name, tr-&gt;guid, print_windows_driver(tr-&g=
t;windows_driver));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(msglev, &quot;&#39;%s&#39; %s %s&quot;, pr-&gt;name, tr=
-&gt;guid, print_tun_backend_driver(tr-&gt;windows_driver));</span><br><spa=
n>                 ++links;</span><br><span>             }</span><br><span>=
         }</span><br><span>@@ -4359,7 +4384,7 @@</span><br><span>          =
                   int actual_name_size,</span><br><span>                  =
           const struct tap_reg *tap_reg_src,</span><br><span>             =
                const struct panel_reg *panel_reg_src,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                            enum windows_d=
river_type *windows_driver,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            enum tun_driver_type *windows_driver,</=
span><br><span>                             struct gc_arena *gc)</span><br>=
<span> {</span><br><span>     const struct tap_reg *tap_reg =3D tap_reg_src=
;</span><br><span>@@ -4423,7 +4448,7 @@</span><br><span> get_device_guid(co=
nst char *name,</span><br><span>                 uint8_t *actual_name,</spa=
n><br><span>                 int actual_name_size,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                enum windows_driver_type *wind=
ows_driver,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        enum tun_driver_type *windows_driver,</span><br><span>             =
    const struct tap_reg *tap_reg,</span><br><span>                 const s=
truct panel_reg *panel_reg,</span><br><span>                 struct gc_aren=
a *gc)</span><br><span>@@ -6209,7 +6234,7 @@</span><br><span>     const DWO=
RD index =3D tt-&gt;adapter_index;</span><br><span> </span><br><span>     /=
* flush arp cache */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (tt-&gt;windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_driver =
=3D=3D WINDOWS_DRIVER_TAP_WINDOWS6</span><br><span>         &amp;&amp; inde=
x !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><br><span>  =
       DWORD status =3D -1;</span><br><span>@@ -6546,8 +6571,8 @@</span><br=
><span>     const char *path =3D NULL;</span><br><span>     char tuntap_dev=
ice_path[256];</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (tt-&gt;windows_driver =3D=3D WINDOWS_DRIVER_WINTUN</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        || tt-&gt;windows_d=
river =3D=3D WINDOWS_DRIVER_DCO)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WINTUN</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        || tt-&gt;backe=
nd_driver =3D=3D DRIVER_DCO)</span><br><span>     {</span><br><span>       =
  const struct device_instance_id_interface *dev_if;</span><br><span> </spa=
n><br><span>@@ -6558,7 +6583,7 @@</span><br><span>                 continue=
;</span><br><span>             }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if (tt-&gt;windows_driver =3D=3D W=
INDOWS_DRIVER_DCO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (tt-&gt;backend_driver =3D=3D DRIVER_DCO)</span><br><span>   =
          {</span><br><span>                 char *last_sep =3D strrchr(dev=
_if-&gt;device_interface, &#39;\\&#39;);</span><br><span>                 i=
f (!last_sep</span><br><span>@@ -6597,11 +6622,11 @@</span><br><span>      =
                     0);</span><br><span>     if (tt-&gt;hand =3D=3D INVALI=
D_HANDLE_VALUE)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_TUNTAP_INFO | M_ERRNO, &quot;CreateFile fail=
ed on %s device: %s&quot;, print_windows_driver(tt-&gt;windows_driver), pat=
h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TU=
NTAP_INFO | M_ERRNO, &quot;CreateFile failed on %s device: %s&quot;, print_=
tun_backend_driver(tt-&gt;backend_driver), path);</span><br><span>         =
return false;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;windows_driver =3D=3D WINDO=
WS_DRIVER_WINTUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WINTUN)</span><br><span> =
    {</span><br><span>         /* Wintun adapter may be considered &quot;op=
en&quot; after ring buffers are successfuly registered. */</span><br><span>=
         if (!wintun_register_ring_buffer(tt, device_guid))</span><br><span=
>@@ -6631,7 +6656,7 @@</span><br><span>      */</span><br><span>     if (de=
v_node)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        enum windows_driver_type windows_driver =3D WINDOWS_DRIVER=
_UNSPECIFIED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  enum tun_driver_type windows_driver =3D WINDOWS_DRIVER_UNSPECIFIED;</span=
><br><span> </span><br><span>         /* Get the device GUID for the device=
 specified with --dev-node. */</span><br><span>         *device_guid =3D ge=
t_device_guid(dev_node, actual_buffer, sizeof(actual_buffer), &amp;windows_=
driver, tap_reg, panel_reg, gc);</span><br><span>@@ -6641,15 +6666,15 @@</s=
pan><br><span>             msg(M_FATAL, &quot;Adapter &#39;%s&#39; not foun=
d&quot;, dev_node);</span><br><span>         }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (tt-&gt;windows_drive=
r !=3D windows_driver)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (tt-&gt;backend_driver !=3D windows_driver)</span><br><span> =
        {</span><br><span>             msg(M_FATAL, &quot;Adapter &#39;%s&#=
39; is using %s driver, %s expected. If you want to use this device, adjust=
 --windows-driver.&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                dev_node, print_windows_driver(windows_driver), print_w=
indows_driver(tt-&gt;windows_driver));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                dev_node, print_tun_backend_driver(windo=
ws_driver), print_tun_backend_driver(tt-&gt;backend_driver));</span><br><sp=
an>         }</span><br><span> </span><br><span>         if (!tun_try_open_=
device(tt, *device_guid, device_instance_id_interface))</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_FATAL, &quot;Failed to open %s adapter: %s&quot;, print_windows_driver(=
tt-&gt;windows_driver), dev_node);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(M_FATAL, &quot;Failed to open %s adapter: %s=
&quot;, print_tun_backend_driver(tt-&gt;backend_driver), dev_node);</span><=
br><span>         }</span><br><span>     }</span><br><span>     else</span>=
<br><span>@@ -6659,7 +6684,7 @@</span><br><span>         /* Try opening all=
 TAP devices until we find one available */</span><br><span>         while =
(true)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            enum windows_driver_type windows_driver =3D WINDOWS=
_DRIVER_UNSPECIFIED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            enum tun_driver_type windows_driver =3D WINDOWS_DRIVER_UNSPECI=
FIED;</span><br><span>             *device_guid =3D get_unspecified_device_=
guid(device_number,</span><br><span>                                       =
                 actual_buffer,</span><br><span>                           =
                             sizeof(actual_buffer),</span><br><span>@@ -667=
0,10 +6695,10 @@</span><br><span> </span><br><span>             if (!*devic=
e_guid)</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                msg(M_FATAL, &quot;All %s adapters on this=
 system are currently in use or disabled.&quot;, print_windows_driver(tt-&g=
t;windows_driver));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(M_FATAL, &quot;All %s adapters on this system are curre=
ntly in use or disabled.&quot;, print_tun_backend_driver(tt-&gt;backend_dri=
ver));</span><br><span>             }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (tt-&gt;windows_driver !=
=3D windows_driver)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (tt-&gt;backend_driver !=3D windows_driver)</span><br><span>=
             {</span><br><span>                 goto next;</span><br><span>=
             }</span><br><span>@@ -6692,7 +6717,7 @@</span><br><span>      =
* GUID using the registry */</span><br><span>     tt-&gt;actual_name =3D st=
ring_alloc((const char *)actual_buffer, NULL);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_INFO, &quot;%s device =
[%s] opened&quot;, print_windows_driver(tt-&gt;windows_driver), tt-&gt;actu=
al_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_=
INFO, &quot;%s device [%s] opened&quot;, print_tun_backend_driver(tt-&gt;ba=
ckend_driver), tt-&gt;actual_name);</span><br><span>     tt-&gt;adapter_ind=
ex =3D get_adapter_index(*device_guid);</span><br><span> }</span><br><span>=
 </span><br><span>@@ -6745,7 +6770,7 @@</span><br><span>     bool dhcp_masq=
 =3D false;</span><br><span>     bool dhcp_masq_post =3D false;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;=
windows_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D WINDOWS=
_DRIVER_TAP_WINDOWS6)</span><br><span>     {</span><br><span>         /* ge=
t driver version info */</span><br><span>         tuntap_get_version_info(t=
t);</span><br><span>@@ -6788,11 +6813,11 @@</span><br><span>          openv=
pn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     if ((tt-&gt;opti=
ons.dhcp_options &amp; DHCP_OPTIONS_DHCP_REQUIRED)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        &amp;&amp; tt-&gt;windows_driver !=3D =
WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &amp;&amp; tt-&gt;backend_driver !=3D WINDOWS_DRIVER_TAP_W=
INDOWS6)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;=
Some --dhcp-option or --dns options require DHCP server,&quot;</span><br><s=
pan>             &quot; which is not supported by the selected %s driver. T=
hey will be&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &quot; ignored.&quot;, print_windows_driver(tt-&gt;windows_driver))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;=
 ignored.&quot;, print_tun_backend_driver(tt-&gt;backend_driver));</span><b=
r><span>     }</span><br><span> </span><br><span>     /* dco-win already op=
ened the device, which handle we treat as socket */</span><br><span>@@ -683=
0,7 +6855,7 @@</span><br><span> const char *</span><br><span> tap_win_getin=
fo(const struct tuntap *tt, struct gc_arena *gc)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;windows_driver=
 =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WI=
NDOWS6)</span><br><span>     {</span><br><span>         struct buffer out =
=3D alloc_buf_gc(256, gc);</span><br><span>         DWORD len;</span><br><s=
pan>@@ -6848,7 +6873,7 @@</span><br><span> void</span><br><span> tun_show_d=
ebug(struct tuntap *tt)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (tt-&gt;windows_driver =3D=3D WINDOWS_DRIVER_TA=
P_WINDOWS6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><span> =
    {</span><br><span>         struct buffer out =3D alloc_buf(1024);</span=
><br><span>         DWORD len;</span><br><span>@@ -6925,7 +6950,7 @@</span>=
<br><span> void</span><br><span> close_tun_handle(struct tuntap *tt)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 char *adaptertype =3D print_windows_driver(tt-&gt;windows_driver);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *adaptertype=
 =3D print_tun_backend_driver(tt-&gt;backend_driver);</span><br><span> </sp=
an><br><span>     if (tt-&gt;hand)</span><br><span>     {</span><br><span>@=
@ -6952,7 +6977,7 @@</span><br><span>         tt-&gt;hand =3D NULL;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (tt-&gt;windows_driver =3D=3D WINDOWS_DRIVER_WINTUN)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_=
driver =3D=3D WINDOWS_DRIVER_WINTUN)</span><br><span>     {</span><br><span=
>         CloseHandle(tt-&gt;rw_handle.read);</span><br><span>         Clos=
eHandle(tt-&gt;rw_handle.write);</span><br><span>@@ -7113,25 +7138,6 @@</sp=
an><br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-print_windows_driver(enum wi=
ndows_driver_type windows_driver)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swit=
ch (windows_driver)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case WINDO=
WS_DRIVER_TAP_WINDOWS6:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return &quot;tap-windows6&quot;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        case WINDOWS_DRIVER_WINTUN:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            return &quot;wintun&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        case WINDOWS_DRIVER_DCO:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return &quot;ovpn-dco&quot;;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            return &quot;unspecified&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> #else /* generic */</span><br><span> </span><br><span=
> void</span><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</=
span><br><span>index 33b9552..80f8bfa 100644</span><br><span>--- a/src/open=
vpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -42,16=
 +42,19 @@</span><br><span> #include &quot;ring_buffer.h&quot;</span><br><s=
pan> #include &quot;dco.h&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define WINTUN_COMPONENT_ID &quot;wintun&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define DCO_WIN_REFERENCE_STRI=
NG &quot;ovpn-dco&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum windows_driver=
_type {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum tun_dri=
ver_type {</span><br><span>     WINDOWS_DRIVER_UNSPECIFIED,</span><br><span=
>     WINDOWS_DRIVER_TAP_WINDOWS6,</span><br><span>     WINDOWS_DRIVER_WINT=
UN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    WINDOWS_DRIVER=
_DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DRIVER_GENE=
RIC_TUNTAP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DRIV=
ER_DCO,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** macO=
S internal tun driver */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    DRIVER_UTUN</span><br><span> };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine WINTUN_COMPONENT_ID &quot;wintun&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define DCO_WIN_REFERENCE_STRING &quot;ovpn-dco&quot=
;</span><br><span> #endif</span><br><span> </span><br><span> #if defined(_W=
IN32) || defined(TARGET_ANDROID)</span><br><span>@@ -70,8 +73,6 @@</span><b=
r><span>     /* --ip-win32 options */</span><br><span>     bool ip_win32_de=
fined;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    bool disable_dco;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> #define IPW32_SET_MANUAL       0   /* &quot;--ip-win32=
 manual&quot; */</span><br><span> #define IPW32_SET_NETSH        1   /* &qu=
ot;--ip-win32 netsh&quot; */</span><br><span> #define IPW32_SET_IPAPI      =
  2   /* &quot;--ip-win32 ipapi&quot; */</span><br><span>@@ -147,20 +148,12=
 @@</span><br><span> </span><br><span> struct tuntap_options {</span><br><s=
pan>     int txqueuelen;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    bool disable_dco;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-struct tuntap_options {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool disable_dco;</span><br><span> };</span>=
<br><span> </span><br><span> #else  /* if defined(_WIN32) || defined(TARGET=
_ANDROID) */</span><br><span> </span><br><span> struct tuntap_options {</sp=
an><br><span>     int dummy; /* not used */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bool disable_dco; /* not used, but removes the ne=
ed in #ifdefs */</span><br><span> };</span><br><span> </span><br><span> #en=
dif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span>@@ =
-177,6 +170,11 @@</span><br><span> #define TUNNEL_TOPOLOGY(tt) ((tt) ? ((tt=
)-&gt;topology) : TOP_UNDEF)</span><br><span>     int topology; /* one of t=
he TOP_x values */</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /** The backend driver that used for this tun/tap devi=
ce. This can be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * one of the various windows drivers, &quot;normal&quot; tun/tap, utun, dc=
o, ...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum tun_driver_type =
backend_driver;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     bool did_ifconfig_setup;</span><br><span>     bool did_if=
config_ipv6_setup;</span><br><span> </span><br><span>@@ -211,7 +209,6 @@</s=
pan><br><span>      * ~0 if undefined */</span><br><span>     DWORD adapter=
_index;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    enum windows_driver_type windows_driver;</span><br><span>     int s=
tandby_iter;</span><br><span> </span><br><span>     HANDLE wintun_send_ring=
_handle;</span><br><span>@@ -226,9 +223,6 @@</span><br><span>     int ip_fd=
;</span><br><span> #endif</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef HAVE_NET_IF_UTUN_H</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    bool is_utun;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span>     /* used for printing stat=
us info only */</span><br><span>     unsigned int rwflags_debug;</span><br>=
<span> </span><br><span>@@ -249,7 +243,7 @@</span><br><span> static inline =
bool</span><br><span> tuntap_is_wintun(struct tuntap *tt)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return tt &amp;&=
amp; tt-&gt;windows_driver =3D=3D WINDOWS_DRIVER_WINTUN;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return tt &amp;&amp; tt-&gt;backen=
d_driver =3D=3D WINDOWS_DRIVER_WINTUN;</span><br><span> }</span><br><span> =
</span><br><span> static inline bool</span><br><span>@@ -397,7 +391,7 @@</s=
pan><br><span> struct tap_reg</span><br><span> {</span><br><span>     const=
 char *guid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    enum =
windows_driver_type windows_driver;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    enum tun_driver_type windows_driver;</span><br><span>  =
   struct tap_reg *next;</span><br><span> };</span><br><span> </span><br><s=
pan>@@ -643,7 +637,7 @@</span><br><span> static inline int</span><br><span>=
 write_tun_buffered(struct tuntap *tt, struct buffer *buf)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;wind=
ows_driver =3D=3D WINDOWS_DRIVER_WINTUN)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_WI=
NTUN)</span><br><span>     {</span><br><span>         return write_wintun(t=
t, buf);</span><br><span>     }</span><br><span>@@ -656,7 +650,7 @@</span><=
br><span> static inline bool</span><br><span> tuntap_is_dco_win(struct tunt=
ap *tt)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return tt &amp;&amp; tt-&gt;windows_driver =3D=3D WINDOWS_DRIVER_D=
CO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tt &a=
mp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span>=
<br><span> </span><br><span> static inline bool</span><br><span>@@ -666,7 +=
660,7 @@</span><br><span> }</span><br><span> </span><br><span> const char *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_windows_driver(=
enum windows_driver_type windows_driver);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+print_tun_backend_driver(enum tun_driver_type driver)=
;</span><br><span> </span><br><span> #else  /* ifdef _WIN32 */</span><br><s=
pan> </span><br><span>@@ -744,7 +738,7 @@</span><br><span>         }</span>=
<br><span>     }</span><br><span> #ifdef _WIN32</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (tt-&gt;windows_driver =3D=3D WINDOWS_DRIV=
ER_TAP_WINDOWS6 &amp;&amp; (rwflags &amp; EVENT_READ))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D WIN=
DOWS_DRIVER_TAP_WINDOWS6 &amp;&amp; (rwflags &amp; EVENT_READ))</span><br><=
span>     {</span><br><span>         tun_read_queue(tt, 0);</span><br><span=
>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/738?usp=3Demail">change 738</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/738?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8c0e9f32b235cb262ca2be6aac8=
d520e49b30d74 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 738 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9x//Fi6R7Es=--

