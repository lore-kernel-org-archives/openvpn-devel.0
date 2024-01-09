From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 14:49:32 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <25f6322be2ce5a5f8967cf0e9d61ff980a3f6ec0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LCokERmS+lE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Windows: enforce
 'block-local' with WFP filters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LCokERmS+lE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail

to look at the new patch set (#3).


Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................

Windows: enforce 'block-local' with WFP filters

In an attempt to better defend against the TunnelCrack attacks, enforce
that no traffic can pass to anything else than the VPN interface when
the 'block-local' flags is given with either --redirect-gateway or
--redirect-private.

Reuse much of the existing --block-outside-dns code, but make it more
general, so that it can also block any traffic, not just port 53.

Uses the Windows Filtering Platform for enforcement in addition to the
routes redirecting the networks into the tunnel.

Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M CMakeLists.txt
M doc/man-sections/vpn-network-options.rst
M include/openvpn-msg.h
M src/openvpn/Makefile.am
M src/openvpn/init.c
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/tun.c
R src/openvpn/wfp_block.c
R src/openvpn/wfp_block.h
M src/openvpn/win32.c
M src/openvpn/win32.h
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/Makefile.am
M src/openvpnserv/interactive.c
15 files changed, 333 insertions(+), 240 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/489/3

diff --git a/CMakeLists.txt b/CMakeLists.txt
index bc46c27..e560ef3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -352,8 +352,6 @@
     src/openvpn/base64.c
     src/openvpn/base64.h
     src/openvpn/basic.h
-    src/openvpn/block_dns.h
-    src/openvpn/block_dns.c
     src/openvpn/buffer.c
     src/openvpn/buffer.h
     src/openvpn/circ_list.h
@@ -533,6 +531,8 @@
     src/openvpn/ssl_util.h
     src/openvpn/vlan.c
     src/openvpn/vlan.h
+    src/openvpn/wfp_block.c
+    src/openvpn/wfp_block.h
     src/openvpn/win32.c
     src/openvpn/win32-util.c
     src/openvpn/win32.h
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 41d367b..7160a17 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -352,6 +352,10 @@
       Block access to local LAN when the tunnel is active, except for
       the LAN gateway itself. This is accomplished by routing the local
       LAN (except for the LAN gateway address) into the tunnel.
+      On Windows WFP filters are added in addition to the routes which
+      block access to resources not routed through the VPN adapter.
+      Push this flag to protect against TunnelCrack type of attacks
+      (see: https://tunnelcrack.mathyvanhoef.com/).

   :code:`ipv6`
       Redirect IPv6 routing into the tunnel. This works similar to
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index a1464cd..0fa0cb5 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -24,6 +24,9 @@
 #ifndef OPENVPN_MSG_H_
 #define OPENVPN_MSG_H_

+#include <windef.h>
+#include <ws2tcpip.h>
+
 typedef enum {
     msg_acknowledgement,
     msg_add_address,
@@ -35,8 +38,8 @@
     msg_add_nbt_cfg,
     msg_del_nbt_cfg,
     msg_flush_neighbors,
-    msg_add_block_dns,
-    msg_del_block_dns,
+    msg_add_wfp_block,
+    msg_del_wfp_block,
     msg_register_dns,
     msg_enable_dhcp,
     msg_register_ring_buffers,
@@ -61,6 +64,11 @@
     char name[256];
 } interface_t;

+typedef enum {
+    wfp_block_local =3D 1<<0,
+    wfp_block_dns =3D 1<<1
+} wfp_block_flags_t;
+
 typedef struct {
     message_header_t header;
     short family;
@@ -120,8 +128,9 @@

 typedef struct {
     message_header_t header;
+    wfp_block_flags_t flags;
     interface_t iface;
-} block_dns_message_t;
+} wfp_block_message_t;

 typedef struct {
     message_header_t header;
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index b953961..6bf3862 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -156,6 +156,6 @@
 	$(OPTIONAL_DL_LIBS) \
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
-openvpn_SOURCES +=3D openvpn_win32_resources.rc block_dns.c block_dns.h ri=
ng_buffer.h
+openvpn_SOURCES +=3D openvpn_win32_resources.rc wfp_block.c wfp_block.h ri=
ng_buffer.h
 openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm=
 -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
 endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9e2b3845..efc5f14 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1793,6 +1793,54 @@
 #endif
 }

+/**
+ * Add WFP filters to block traffic to local networks.
+ * Depending on the configuration all or just DNS is filtered.
+ * This functionality is only available on Windows on all other
+ * systems this function is a noop.
+ *
+ * @param c pointer to the connection context
+ */
+static void
+add_wfp_block(struct context *c)
+{
+#if defined(_WIN32)
+    /* Fortify 'redirect-gateway block-local' with firewall rules? */
+    bool block_local =3D do_block_local(c->c1.route_list);
+
+    if (c->options.block_outside_dns || block_local)
+    {
+        BOOL dns_only =3D !block_local;
+        if (!win_wfp_block(c->c1.tuntap->adapter_index, c->options.msg_cha=
nnel, dns_only))
+        {
+            msg(M_FATAL, "WFP: initialization failed");
+        }
+    }
+#endif
+}
+
+/**
+ * Remove any WFP block filters previously added.
+ * This functionality is only available on Windows on all other
+ * systems the function is a noop.
+ *
+ * @param c             pointer to the connection context
+ * @param adapter_index the VPN adapter index
+ */
+static void
+del_wfp_block(struct context *c, unsigned long adapter_index)
+{
+#if defined(_WIN32)
+    if (c->options.block_outside_dns || do_block_local(c->c1.route_list))
+    {
+        if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
+        {
+            msg(M_FATAL, "WFP: deinitialization failed");
+        }
+    }
+#endif
+}
+
 static bool
 do_open_tun(struct context *c, int *error_flags)
 {
@@ -1915,16 +1963,7 @@
                     "up",
                     c->c2.es);

-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            dmsg(D_LOW, "Blocking outside DNS");
-            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options=
.msg_channel))
-            {
-                msg(M_FATAL, "Blocking DNS failed!");
-            }
-        }
-#endif
+        add_wfp_block(c);

         /* possibly add routes */
         if ((route_order() =3D=3D ROUTE_AFTER_TUN) && (!c->options.route_d=
elay_defined))
@@ -1964,17 +2003,8 @@
                         "up",
                         c->c2.es);
         }
-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            dmsg(D_LOW, "Blocking outside DNS");
-            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options=
.msg_channel))
-            {
-                msg(M_FATAL, "Blocking DNS failed!");
-            }
-        }
-#endif

+        add_wfp_block(c);
     }
     gc_free(&gc);
     return ret;
@@ -2092,15 +2122,7 @@
                     "down",
                     c->c2.es);

-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
-            {
-                msg(M_FATAL, "Uninitialising WFP failed!");
-            }
-        }
-#endif
+        del_wfp_block(c, adapter_index);

         /* actually close tun/tap device based on --down-pre flag */
         if (c->options.down_pre)
@@ -2131,16 +2153,7 @@
                         c->c2.es);
         }

-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
-            {
-                msg(M_FATAL, "Uninitialising WFP failed!");
-            }
-        }
-#endif
-
+        del_wfp_block(c, adapter_index);
     }
     gc_free(&gc);
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6c027d9..3900c51 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -25,6 +25,7 @@
  * Support routines for adding/deleting network routes.
  */
 #include <stddef.h>
+#include <stdbool.h>

 #ifdef HAVE_CONFIG_H
 #include "config.h"
@@ -74,7 +75,9 @@

 #endif

-static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, un=
signed int flags, const struct route_gateway_info *rgi, const struct env_se=
t *es, openvpn_net_ctx_t *ctx);
+static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, un=
signed int flags,
+                         const struct route_gateway_info *rgi, const struc=
t env_set *es,
+                         openvpn_net_ctx_t *ctx);

 static void get_bypass_addresses(struct route_bypass *rb, const unsigned i=
nt flags);

@@ -566,9 +569,7 @@
                      const struct route_gateway_address *gateway,
                      in_addr_t target)
 {
-    const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
-    if ((rl->rgi.flags & rgi_needed) =3D=3D rgi_needed
-        && rl->rgi.gateway.netmask < 0xFFFFFFFF)
+    if (rl->rgi.gateway.netmask < 0xFFFFFFFF)
     {
         struct route_ipv4 *r1, *r2;
         unsigned int l2;
@@ -593,39 +594,40 @@
 }

 static void
-add_block_local(struct route_list *rl)
+add_block_local_routes(struct route_list *rl)
 {
-    const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
-    if ((rl->flags & RG_BLOCK_LOCAL)
-        && (rl->rgi.flags & rgi_needed) =3D=3D rgi_needed
-        && (rl->spec.flags & RTSA_REMOTE_ENDPOINT)
-        && rl->spec.remote_host_local !=3D TLA_LOCAL)
-    {
-        size_t i;
-
 #ifndef TARGET_ANDROID
-        /* add bypass for gateway addr */
-        add_bypass_address(&rl->spec.bypass, rl->rgi.gateway.addr);
+    /* add bypass for gateway addr */
+    add_bypass_address(&rl->spec.bypass, rl->rgi.gateway.addr);
 #endif

-        /* block access to local subnet */
-        add_block_local_item(rl, &rl->rgi.gateway, rl->spec.remote_endpoin=
t);
+    /* block access to local subnet */
+    add_block_local_item(rl, &rl->rgi.gateway, rl->spec.remote_endpoint);

-        /* process additional subnets on gateway interface */
-        for (i =3D 0; i < rl->rgi.n_addrs; ++i)
+    /* process additional subnets on gateway interface */
+    for (size_t i =3D 0; i < rl->rgi.n_addrs; ++i)
+    {
+        const struct route_gateway_address *gwa =3D &rl->rgi.addrs[i];
+        /* omit the add/subnet in &rl->rgi which we processed above */
+        if (!((rl->rgi.gateway.addr & rl->rgi.gateway.netmask) =3D=3D (gwa=
->addr & gwa->netmask)
+              && rl->rgi.gateway.netmask =3D=3D gwa->netmask))
         {
-            const struct route_gateway_address *gwa =3D &rl->rgi.addrs[i];
-            /* omit the add/subnet in &rl->rgi which we processed above */
-            if (!((rl->rgi.gateway.addr & rl->rgi.gateway.netmask) =3D=3D =
(gwa->addr & gwa->netmask)
-                  && rl->rgi.gateway.netmask =3D=3D gwa->netmask))
-            {
-                add_block_local_item(rl, gwa, rl->spec.remote_endpoint);
-            }
+            add_block_local_item(rl, gwa, rl->spec.remote_endpoint);
         }
     }
 }

 bool
+do_block_local(const struct route_list *rl)
+{
+    const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+    return (rl->flags & RG_BLOCK_LOCAL)
+           && (rl->rgi.flags & rgi_needed) =3D=3D rgi_needed
+           && (rl->spec.flags & RTSA_REMOTE_ENDPOINT)
+           && rl->spec.remote_host_local !=3D TLA_LOCAL;
+}
+
+bool
 init_route_list(struct route_list *rl,
                 const struct route_option_list *opt,
                 const char *remote_endpoint,
@@ -698,7 +700,10 @@

     if (rl->flags & RG_ENABLE)
     {
-        add_block_local(rl);
+        if (do_block_local(rl))
+        {
+            add_block_local_routes(rl);
+        }
         get_bypass_addresses(&rl->spec.bypass, rl->flags);
 #ifdef ENABLE_DEBUG
         print_bypass_addresses(&rl->spec.bypass);
@@ -1241,6 +1246,7 @@
         }
         rl6->iflags |=3D RL_ROUTES_ADDED;
     }
+
     return ret;
 }

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 71b4cf4..568718b 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -243,6 +243,18 @@
     struct iroute_ipv6 *next;
 };

+/**
+ * Get the decision whether to block traffic to local networks while the V=
PN
+ * is connected. This definitely returns false when not redirecting the ga=
teway
+ * or when the 'block-local' flag is not set. Also checks for other
+ * prerequisites to redirect local networks into the tunnel.
+ *
+ * @param rl const pointer to the struct route_list to base the decision o=
n.
+ *
+ * @return boolean indicating whether local traffic should be blocked.
+ */
+bool do_block_local(const struct route_list *rl);
+
 struct route_option_list *new_route_option_list(struct gc_arena *a);

 struct route_ipv6_option_list *new_route_ipv6_option_list(struct gc_arena =
*a);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8e96149..aa78c23 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -44,7 +44,7 @@
 #include "manage.h"
 #include "route.h"
 #include "win32.h"
-#include "block_dns.h"
+#include "wfp_block.h"
 #include "networking.h"

 #include "memdbg.h"
diff --git a/src/openvpn/block_dns.c b/src/openvpn/wfp_block.c
similarity index 69%
rename from src/openvpn/block_dns.c
rename to src/openvpn/wfp_block.c
index 05b2599..2ff117b 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/wfp_block.c
@@ -37,7 +37,8 @@
 #include <winsock2.h>
 #include <ws2ipdef.h>
 #include <iphlpapi.h>
-#include "block_dns.h"
+
+#include "wfp_block.h"

 /*
  * WFP-related defines and GUIDs not in mingw32
@@ -92,10 +93,19 @@
     0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
     );

+/* 632ce23b-5167-435c-86d7-e903684aa80c */
+DEFINE_GUID(
+    FWPM_CONDITION_FLAGS,
+    0x632ce23b,
+    0x5167,
+    0x435c,
+    0x86, 0xd7, 0xe9, 0x03, 0x68, 0x4a, 0xa8, 0x0c
+    );
+
 /* UUID of WFP sublayer used by all instances of openvpn
  * 2f660d7e-6a37-11e6-a181-001e8c6e04a2 */
 DEFINE_GUID(
-    OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER,
+    OPENVPN_WFP_BLOCK_SUBLAYER,
     0x2f660d7e,
     0x6a37,
     0x11e6,
@@ -113,7 +123,7 @@
     return;
 }

-#define CHECK_ERROR(err, msg) \
+#define OUT_ON_ERROR(err, msg) \
     if (err) { msg_handler(err, msg); goto out; }

 /*
@@ -154,36 +164,41 @@
 }

 /*
- * Block outgoing port 53 traffic except for
- * (i) adapter with the specified index
+ * Block outgoing local traffic, possibly DNS only, except for
+ * (i) adapter with the specified index (and loopback, if all is blocked)
  * OR
  * (ii) processes with the specified executable path
  * The firewall filters added here are automatically removed when the proc=
ess exits or
- * on calling delete_block_dns_filters().
+ * on calling delete_wfp_block_filters().
  * Arguments:
  *   engine_handle : On successful return contains the handle for a newly =
opened fwp session
  *                   in which the filters are added.
- *                   May be closed by passing to delete_block_dns_filters =
to remove the filters.
+ *                   May be closed by passing to delete_wfp_block_filters =
to remove the filters.
  *   index         : The index of adapter for which traffic is permitted.
  *   exe_path      : Path of executable for which traffic is permitted.
  *   msg_handler   : An optional callback function for error reporting.
+ *   dns_only      : Whether the blocking filters should apply for DNS onl=
y.
  * Returns 0 on success, a non-zero status code of the last failed action =
on failure.
  */

 DWORD
-add_block_dns_filters(HANDLE *engine_handle,
+add_wfp_block_filters(HANDLE *engine_handle,
                       int index,
                       const WCHAR *exe_path,
-                      block_dns_msg_handler_t msg_handler
-                      )
+                      wfp_block_msg_handler_t msg_handler,
+                      BOOL dns_only)
 {
     FWPM_SESSION0 session =3D {0};
     FWPM_SUBLAYER0 *sublayer_ptr =3D NULL;
-    NET_LUID tapluid;
+    NET_LUID itf_luid;
     UINT64 filterid;
     FWP_BYTE_BLOB *openvpnblob =3D NULL;
     FWPM_FILTER0 Filter =3D {0};
-    FWPM_FILTER_CONDITION0 Condition[2] =3D {0};
+    FWPM_FILTER_CONDITION0 Condition[2];
+    FWPM_FILTER_CONDITION0 match_openvpn =3D {0};
+    FWPM_FILTER_CONDITION0 match_port_53 =3D {0};
+    FWPM_FILTER_CONDITION0 match_interface =3D {0};
+    FWPM_FILTER_CONDITION0 match_not_loopback =3D {0};
     DWORD err =3D 0;

     if (!msg_handler)
@@ -197,116 +212,127 @@
     *engine_handle =3D NULL;

     err =3D FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session, engin=
e_handle);
-    CHECK_ERROR(err, "FwpEngineOpen: open fwp session failed");
-    msg_handler(0, "Block_DNS: WFP engine opened");
+    OUT_ON_ERROR(err, "FwpEngineOpen: open fwp session failed");
+    msg_handler(0, "WFP Block: WFP engine opened");

     /* Check sublayer exists and add one if it does not. */
-    if (FwpmSubLayerGetByKey0(*engine_handle, &OPENVPN_BLOCK_OUTSIDE_DNS_S=
UBLAYER, &sublayer_ptr)
+    if (FwpmSubLayerGetByKey0(*engine_handle, &OPENVPN_WFP_BLOCK_SUBLAYER,=
 &sublayer_ptr)
         =3D=3D ERROR_SUCCESS)
     {
-        msg_handler(0, "Block_DNS: Using existing sublayer");
+        msg_handler(0, "WFP Block: Using existing sublayer");
         FwpmFreeMemory0((void **)&sublayer_ptr);
     }
     else
     {  /* Add a new sublayer -- as another process may add it in the meant=
ime,
         * do not treat "already exists" as an error */
-        err =3D add_sublayer(OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER);
+        err =3D add_sublayer(OPENVPN_WFP_BLOCK_SUBLAYER);

         if (err =3D=3D FWP_E_ALREADY_EXISTS || err =3D=3D ERROR_SUCCESS)
         {
-            msg_handler(0, "Block_DNS: Added a persistent sublayer with pr=
e-defined UUID");
+            msg_handler(0, "WFP Block: Added a persistent sublayer with pr=
e-defined UUID");
         }
         else
         {
-            CHECK_ERROR(err, "add_sublayer: failed to add persistent subla=
yer");
+            OUT_ON_ERROR(err, "add_sublayer: failed to add persistent subl=
ayer");
         }
     }

-    err =3D ConvertInterfaceIndexToLuid(index, &tapluid);
-    CHECK_ERROR(err, "Convert interface index to luid failed");
+    err =3D ConvertInterfaceIndexToLuid(index, &itf_luid);
+    OUT_ON_ERROR(err, "Convert interface index to luid failed");

     err =3D FwpmGetAppIdFromFileName0(exe_path, &openvpnblob);
-    CHECK_ERROR(err, "Get byte blob for openvpn executable name failed");
+    OUT_ON_ERROR(err, "Get byte blob for openvpn executable name failed");
+
+    /* Prepare match conditions */
+    match_openvpn.fieldKey =3D FWPM_CONDITION_ALE_APP_ID;
+    match_openvpn.matchType =3D FWP_MATCH_EQUAL;
+    match_openvpn.conditionValue.type =3D FWP_BYTE_BLOB_TYPE;
+    match_openvpn.conditionValue.byteBlob =3D openvpnblob;
+
+    match_port_53.fieldKey =3D FWPM_CONDITION_IP_REMOTE_PORT;
+    match_port_53.matchType =3D FWP_MATCH_EQUAL;
+    match_port_53.conditionValue.type =3D FWP_UINT16;
+    match_port_53.conditionValue.uint16 =3D 53;
+
+    match_interface.fieldKey =3D FWPM_CONDITION_IP_LOCAL_INTERFACE;
+    match_interface.matchType =3D FWP_MATCH_EQUAL;
+    match_interface.conditionValue.type =3D FWP_UINT64;
+    match_interface.conditionValue.uint64 =3D &itf_luid.Value;
+
+    match_not_loopback.fieldKey =3D FWPM_CONDITION_FLAGS;
+    match_not_loopback.matchType =3D FWP_MATCH_FLAGS_NONE_SET;
+    match_not_loopback.conditionValue.type =3D FWP_UINT32;
+    match_not_loopback.conditionValue.uint32 =3D FWP_CONDITION_FLAG_IS_LOO=
PBACK;

     /* Prepare filter. */
-    Filter.subLayerKey =3D OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER;
+    Filter.subLayerKey =3D OPENVPN_WFP_BLOCK_SUBLAYER;
     Filter.displayData.name =3D FIREWALL_NAME;
     Filter.weight.type =3D FWP_UINT8;
     Filter.weight.uint8 =3D 0xF;
     Filter.filterCondition =3D Condition;
-    Filter.numFilterConditions =3D 2;
+    Filter.numFilterConditions =3D 1;

-    /* First filter. Permit IPv4 DNS queries from OpenVPN itself. */
+    /* First filter. Permit IPv4 from OpenVPN itself. */
     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
     Filter.action.type =3D FWP_ACTION_PERMIT;
-
-    Condition[0].fieldKey =3D FWPM_CONDITION_IP_REMOTE_PORT;
-    Condition[0].matchType =3D FWP_MATCH_EQUAL;
-    Condition[0].conditionValue.type =3D FWP_UINT16;
-    Condition[0].conditionValue.uint16 =3D 53;
-
-    Condition[1].fieldKey =3D FWPM_CONDITION_ALE_APP_ID;
-    Condition[1].matchType =3D FWP_MATCH_EQUAL;
-    Condition[1].conditionValue.type =3D FWP_BYTE_BLOB_TYPE;
-    Condition[1].conditionValue.byteBlob =3D openvpnblob;
-
+    Condition[0] =3D match_openvpn;
+    if (dns_only)
+    {
+        Filter.numFilterConditions =3D 2;
+        Condition[1] =3D match_port_53;
+    }
     err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv4 port 53 traffic from OpenV=
PN failed");
+    OUT_ON_ERROR(err, "Add filter to permit IPv4 traffic from OpenVPN fail=
ed");

-    /* Second filter. Permit IPv6 DNS queries from OpenVPN itself. */
+    /* Second filter. Permit IPv6 from OpenVPN itself. */
     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
     err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv6 port 53 traffic from OpenV=
PN failed");
+    OUT_ON_ERROR(err, "Add filter to permit IPv6 traffic from OpenVPN fail=
ed");

-    msg_handler(0, "Block_DNS: Added permit filters for exe_path");
+    msg_handler(0, "WFP Block: Added permit filters for exe_path");

-    /* Third filter. Block all IPv4 DNS queries. */
+    /* Third filter. Block IPv4 to port 53 or all except loopback. */
     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
     Filter.action.type =3D FWP_ACTION_BLOCK;
     Filter.weight.type =3D FWP_EMPTY;
     Filter.numFilterConditions =3D 1;
-
+    Condition[0] =3D dns_only ? match_port_53 : match_not_loopback;
     err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to block IPv4 DNS traffic failed");
+    OUT_ON_ERROR(err, "Add filter to block IPv4 traffic failed");

-    /* Forth filter. Block all IPv6 DNS queries. */
+    /* Fourth filter. Block IPv6 to port 53 or all besides loopback */
     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
     err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to block IPv6 DNS traffic failed");
+    OUT_ON_ERROR(err, "Add filter to block IPv6 traffic failed");

-    msg_handler(0, "Block_DNS: Added block filters for all interfaces");
+    msg_handler(0, "WFP Block: Added block filters for all interfaces");

-    /* Fifth filter. Permit IPv4 DNS queries from TAP.
+    /* Fifth filter. Permit IPv4 for the VPN interface.
      * Use a non-zero weight so that the permit filters get higher priority
      * over the block filter added with automatic weighting */
-
     Filter.weight.type =3D FWP_UINT8;
     Filter.weight.uint8 =3D 0xE;
     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
     Filter.action.type =3D FWP_ACTION_PERMIT;
-    Filter.numFilterConditions =3D 2;
-
-    Condition[1].fieldKey =3D FWPM_CONDITION_IP_LOCAL_INTERFACE;
-    Condition[1].matchType =3D FWP_MATCH_EQUAL;
-    Condition[1].conditionValue.type =3D FWP_UINT64;
-    Condition[1].conditionValue.uint64 =3D &tapluid.Value;
-
+    Filter.numFilterConditions =3D 1;
+    Condition[0] =3D match_interface;
+    if (dns_only)
+    {
+        Filter.numFilterConditions =3D 2;
+        Condition[1] =3D match_port_53;
+    }
     err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv4 DNS traffic through TAP fa=
iled");
+    OUT_ON_ERROR(err, "Add filter to permit IPv4 traffic through VPN inter=
face failed");

-    /* Sixth filter. Permit IPv6 DNS queries from TAP.
+    /* Sixth filter. Permit IPv6 for the VPN interface.
      * Use same weight as IPv4 filter */
     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
     err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv6 DNS traffic through TAP fa=
iled");
+    OUT_ON_ERROR(err, "Add filter to permit IPv6 traffic through VPN inter=
face failed");

-    msg_handler(0, "Block_DNS: Added permit filters for TAP interface");
+    msg_handler(0, "WFP Block: Added permit filters for VPN interface");

 out:
-
     if (openvpnblob)
     {
         FwpmFreeMemory0((void **)&openvpnblob);
@@ -322,7 +348,7 @@
 }

 DWORD
-delete_block_dns_filters(HANDLE engine_handle)
+delete_wfp_block_filters(HANDLE engine_handle)
 {
     DWORD err =3D 0;
     /*
diff --git a/src/openvpn/block_dns.h b/src/openvpn/wfp_block.h
similarity index 83%
rename from src/openvpn/block_dns.h
rename to src/openvpn/wfp_block.h
index 89b88d6..60c9171 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/wfp_block.h
@@ -23,20 +23,24 @@

 #ifdef _WIN32

-#ifndef OPENVPN_BLOCK_DNS_H
-#define OPENVPN_BLOCK_DNS_H
+#ifndef WFP_BLOCK_H
+#define WFP_BLOCK_H
+
+#include <windef.h>
+#include <iphlpapi.h>
+#include <ws2tcpip.h>

 /* Any value less than 5 should work fine. 3 is chosen without any real re=
ason. */
-#define BLOCK_DNS_IFACE_METRIC 3
+#define WFP_BLOCK_IFACE_METRIC 3

-typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);
+typedef void (*wfp_block_msg_handler_t) (DWORD err, const char *msg);

 DWORD
-delete_block_dns_filters(HANDLE engine);
+delete_wfp_block_filters(HANDLE engine);

 DWORD
-add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *exe_pa=
th,
-                      block_dns_msg_handler_t msg_handler_callback);
+add_wfp_block_filters(HANDLE *engine, int iface_index, const WCHAR *exe_pa=
th,
+                      wfp_block_msg_handler_t msg_handler_callback, BOOL d=
ns_only);

 /**
  * Return interface metric value for the specified interface index.
@@ -65,5 +69,5 @@
 set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
                      const ULONG metric);

-#endif /* ifndef OPENVPN_BLOCK_DNS_H */
+#endif /* ifndef WFP_BLOCK_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 6b7ba5e..9d08554 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -34,6 +34,9 @@

 #ifdef _WIN32

+#include <minwindef.h>
+#include <winsock2.h>
+
 #include "buffer.h"
 #include "error.h"
 #include "mtu.h"
@@ -47,7 +50,7 @@

 #include <versionhelpers.h>

-#include "block_dns.h"
+#include "wfp_block.h"

 /*
  * WFP handle
@@ -1138,43 +1141,19 @@
 }

 static bool
-win_block_dns_service(bool add, int index, const HANDLE pipe)
+win_get_exe_path(PWCHAR path, DWORD size)
 {
-    bool ret =3D false;
-    ack_message_t ack;
-    struct gc_arena gc =3D gc_new();
-
-    block_dns_message_t data =3D {
-        .header =3D {
-            (add ? msg_add_block_dns : msg_del_block_dns),
-            sizeof(block_dns_message_t),
-            0
-        },
-        .iface =3D { .index =3D index, .name =3D "" }
-    };
-
-    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "Block_DNS"))
+    DWORD status =3D GetModuleFileNameW(NULL, path, size);
+    if (status =3D=3D 0 || status =3D=3D size)
     {
-        goto out;
+        msg(M_WARN|M_ERRNO, "cannot get executable path");
+        return false;
     }
-
-    if (ack.error_number !=3D NO_ERROR)
-    {
-        msg(M_WARN, "Block_DNS: %s block dns filters using service failed:=
 %s [status=3D0x%x if_index=3D%d]",
-            (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc),
-            ack.error_number, data.iface.index);
-        goto out;
-    }
-
-    ret =3D true;
-    msg(M_INFO, "%s outside dns using service succeeded.", (add ? "Blockin=
g" : "Unblocking"));
-out:
-    gc_free(&gc);
-    return ret;
+    return true;
 }

 static void
-block_dns_msg_handler(DWORD err, const char *msg)
+win_wfp_msg_handler(DWORD err, const char *msg)
 {
     struct gc_arena gc =3D gc_new();

@@ -1184,15 +1163,52 @@
     }
     else
     {
-        msg(M_WARN, "Error in add_block_dns_filters(): %s : %s [status=3D0=
x%lx]",
+        msg(M_WARN, "Error in WFP: %s : %s [status=3D0x%lx]",
             msg, strerror_win32(err, &gc), err);
     }

     gc_free(&gc);
 }

+static bool
+win_wfp_block_service(bool add, bool dns_only, int index, const HANDLE pip=
e)
+{
+    bool ret =3D false;
+    ack_message_t ack;
+    struct gc_arena gc =3D gc_new();
+
+    wfp_block_message_t data =3D {
+        .header =3D {
+            (add ? msg_add_wfp_block : msg_del_wfp_block),
+            sizeof(wfp_block_message_t),
+            0
+        },
+        .flags =3D dns_only ? wfp_block_dns : wfp_block_local,
+        .iface =3D { .index =3D index, .name =3D "" }
+    };
+
+    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "WFP block"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number !=3D NO_ERROR)
+    {
+        msg(M_WARN, "WFP block: %s block filters using service failed: %s =
[status=3D0x%x if_index=3D%d]",
+            (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc),
+            ack.error_number, data.iface.index);
+        goto out;
+    }
+
+    ret =3D true;
+    msg(M_INFO, "%s WFP block filters using service succeeded.", (add ? "A=
dding" : "Deleting"));
+out:
+    gc_free(&gc);
+    return ret;
+}
+
 bool
-win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel)
+win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_=
only)
 {
     WCHAR openvpnpath[MAX_PATH];
     bool ret =3D false;
@@ -1200,20 +1216,19 @@

     if (msg_channel)
     {
-        dmsg(D_LOW, "Using service to add block dns filters");
-        ret =3D win_block_dns_service(true, index, msg_channel);
+        dmsg(D_LOW, "Using service to add WFP block filters");
+        ret =3D win_wfp_block_service(true, dns_only, index, msg_channel);
         goto out;
     }

-    status =3D GetModuleFileNameW(NULL, openvpnpath, _countof(openvpnpath)=
);
-    if (status =3D=3D 0 || status =3D=3D _countof(openvpnpath))
+    ret =3D win_get_exe_path(openvpnpath, _countof(openvpnpath));
+    if (ret =3D=3D false)
     {
-        msg(M_WARN|M_ERRNO, "block_dns: cannot get executable path");
         goto out;
     }

-    status =3D add_block_dns_filters(&m_hEngineHandle, index, openvpnpath,
-                                   block_dns_msg_handler);
+    status =3D add_wfp_block_filters(&m_hEngineHandle, index, openvpnpath,
+                                   win_wfp_msg_handler, dns_only);
     if (status =3D=3D 0)
     {
         int is_auto =3D 0;
@@ -1227,10 +1242,10 @@
         {
             tap_metric_v6 =3D 0;
         }
-        status =3D set_interface_metric(index, AF_INET, BLOCK_DNS_IFACE_ME=
TRIC);
+        status =3D set_interface_metric(index, AF_INET, WFP_BLOCK_IFACE_ME=
TRIC);
         if (!status)
         {
-            set_interface_metric(index, AF_INET6, BLOCK_DNS_IFACE_METRIC);
+            set_interface_metric(index, AF_INET6, WFP_BLOCK_IFACE_METRIC);
         }
     }

@@ -1248,12 +1263,12 @@

     if (msg_channel)
     {
-        msg(D_LOW, "Using service to delete block dns filters");
-        win_block_dns_service(false, index, msg_channel);
+        msg(D_LOW, "Using service to delete WFP block filters");
+        win_wfp_block_service(false, false, index, msg_channel);
     }
     else
     {
-        delete_block_dns_filters(m_hEngineHandle);
+        delete_wfp_block_filters(m_hEngineHandle);
         m_hEngineHandle =3D NULL;
         if (tap_metric_v4 >=3D 0)
         {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index aa8513b..92b3528 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -25,8 +25,10 @@
 #ifndef OPENVPN_WIN32_H
 #define OPENVPN_WIN32_H

-#include <winioctl.h>
+#include <iphlpapi.h>
+#include <ws2tcpip.h>

+#include "syshead.h"
 #include "mtu.h"
 #include "openvpn-msg.h"
 #include "argv.h"
@@ -286,7 +288,7 @@
 /* call self in a subprocess */
 void fork_to_self(const char *cmdline);

-bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);
+bool win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL=
 dns_only);

 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);

diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 17cd90c..154e17c 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -17,7 +17,7 @@
     interactive.c
     service.c service.h
     validate.c validate.h
-    ../openvpn/block_dns.c ../openvpn/block_dns.h
+    ../openvpn/wfp_block.c ../openvpn/wfp_block.h
     openvpnserv_resources.rc
     ../openvpn/ring_buffer.h
     )
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index d8ba4eb..49ad8aa 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -33,6 +33,6 @@
 	interactive.c \
 	service.c service.h \
 	validate.c validate.h \
-	$(top_srcdir)/src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_dns=
.h \
+	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/openvpn/wfp_block=
.h \
 	openvpnserv_resources.rc \
 	$(top_srcdir)/src/openvpn/ring_buffer.h
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 32c8996..68a8106 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -38,7 +38,7 @@

 #include "openvpn-msg.h"
 #include "validate.h"
-#include "block_dns.h"
+#include "wfp_block.h"
 #include "ring_buffer.h"

 #define IO_TIMEOUT  2000 /*ms*/
@@ -84,7 +84,7 @@
 typedef enum {
     address,
     route,
-    block_dns,
+    wfp_block,
     undo_dns4,
     undo_dns6,
     undo_domain,
@@ -99,7 +99,7 @@
     int index;
     int metric_v4;
     int metric_v6;
-} block_dns_data_t;
+} wfp_block_data_t;

 typedef struct {
     struct tun_ring *send_ring;
@@ -774,74 +774,76 @@
 }

 static DWORD
-DeleteBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
+DeleteWfpBlock(const wfp_block_message_t *msg, undo_lists_t *lists)
 {
     DWORD err =3D 0;
-    block_dns_data_t *interface_data =3D RemoveListItem(&(*lists)[block_dn=
s], CmpAny, NULL);
+    wfp_block_data_t *block_data =3D RemoveListItem(&(*lists)[wfp_block], =
CmpAny, NULL);

-    if (interface_data)
+    if (block_data)
     {
-        err =3D delete_block_dns_filters(interface_data->engine);
-        if (interface_data->metric_v4 >=3D 0)
+        err =3D delete_wfp_block_filters(block_data->engine);
+        if (block_data->metric_v4 >=3D 0)
         {
             set_interface_metric(msg->iface.index, AF_INET,
-                                 interface_data->metric_v4);
+                                 block_data->metric_v4);
         }
-        if (interface_data->metric_v6 >=3D 0)
+        if (block_data->metric_v6 >=3D 0)
         {
             set_interface_metric(msg->iface.index, AF_INET6,
-                                 interface_data->metric_v6);
+                                 block_data->metric_v6);
         }
-        free(interface_data);
+        free(block_data);
     }
     else
     {
-        MsgToEventLog(M_ERR, TEXT("No previous block DNS filters to delete=
"));
+        MsgToEventLog(M_ERR, TEXT("No previous block filters to delete"));
     }

     return err;
 }

 static DWORD
-AddBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
+AddWfpBlock(const wfp_block_message_t *msg, undo_lists_t *lists)
 {
     DWORD err =3D 0;
-    block_dns_data_t *interface_data =3D NULL;
+    wfp_block_data_t *block_data =3D NULL;
     HANDLE engine =3D NULL;
     LPCWSTR exe_path;
+    BOOL dns_only;

     exe_path =3D settings.exe_path;
+    dns_only =3D (msg->flags =3D=3D wfp_block_dns);

-    err =3D add_block_dns_filters(&engine, msg->iface.index, exe_path, Blo=
ckDNSErrHandler);
+    err =3D add_wfp_block_filters(&engine, msg->iface.index, exe_path, Blo=
ckDNSErrHandler, dns_only);
     if (!err)
     {
-        interface_data =3D malloc(sizeof(block_dns_data_t));
-        if (!interface_data)
+        block_data =3D malloc(sizeof(wfp_block_data_t));
+        if (!block_data)
         {
             err =3D ERROR_OUTOFMEMORY;
             goto out;
         }
-        interface_data->engine =3D engine;
-        interface_data->index =3D msg->iface.index;
+        block_data->engine =3D engine;
+        block_data->index =3D msg->iface.index;
         int is_auto =3D 0;
-        interface_data->metric_v4 =3D get_interface_metric(msg->iface.inde=
x,
-                                                         AF_INET, &is_auto=
);
+        block_data->metric_v4 =3D get_interface_metric(msg->iface.index,
+                                                     AF_INET, &is_auto);
         if (is_auto)
         {
-            interface_data->metric_v4 =3D 0;
+            block_data->metric_v4 =3D 0;
         }
-        interface_data->metric_v6 =3D get_interface_metric(msg->iface.inde=
x,
-                                                         AF_INET6, &is_aut=
o);
+        block_data->metric_v6 =3D get_interface_metric(msg->iface.index,
+                                                     AF_INET6, &is_auto);
         if (is_auto)
         {
-            interface_data->metric_v6 =3D 0;
+            block_data->metric_v6 =3D 0;
         }

-        err =3D AddListItem(&(*lists)[block_dns], interface_data);
+        err =3D AddListItem(&(*lists)[wfp_block], block_data);
         if (!err)
         {
             err =3D set_interface_metric(msg->iface.index, AF_INET,
-                                       BLOCK_DNS_IFACE_METRIC);
+                                       WFP_BLOCK_IFACE_METRIC);
             if (!err)
             {
                 /* for IPv6, we intentionally ignore errors, because
@@ -850,12 +852,12 @@
                  * (if OpenVPN wants IPv6 ifconfig, we'll fail there)
                  */
                 set_interface_metric(msg->iface.index, AF_INET6,
-                                     BLOCK_DNS_IFACE_METRIC);
+                                     WFP_BLOCK_IFACE_METRIC);
             }
             if (err)
             {
                 /* delete the filters, remove undo item and free interface=
 data */
-                DeleteBlockDNS(msg, lists);
+                DeleteWfpBlock(msg, lists);
                 engine =3D NULL;
             }
         }
@@ -864,23 +866,23 @@
 out:
     if (err && engine)
     {
-        delete_block_dns_filters(engine);
-        free(interface_data);
+        delete_wfp_block_filters(engine);
+        free(block_data);
     }

     return err;
 }

 static DWORD
-HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
+HandleWfpBlockMessage(const wfp_block_message_t *msg, undo_lists_t *lists)
 {
-    if (msg->header.type =3D=3D msg_add_block_dns)
+    if (msg->header.type =3D=3D msg_add_wfp_block)
     {
-        return AddBlockDNS(msg, lists);
+        return AddWfpBlock(msg, lists);
     }
     else
     {
-        return DeleteBlockDNS(msg, lists);
+        return DeleteWfpBlock(msg, lists);
     }
 }

@@ -1616,7 +1618,7 @@
         address_message_t address;
         route_message_t route;
         flush_neighbors_message_t flush_neighbors;
-        block_dns_message_t block_dns;
+        wfp_block_message_t wfp_block;
         dns_cfg_message_t dns;
         enable_dhcp_message_t dhcp;
         register_ring_buffers_message_t rrb;
@@ -1665,11 +1667,11 @@
             }
             break;

-        case msg_add_block_dns:
-        case msg_del_block_dns:
-            if (msg.header.size =3D=3D sizeof(msg.block_dns))
+        case msg_add_wfp_block:
+        case msg_del_wfp_block:
+            if (msg.header.size =3D=3D sizeof(msg.wfp_block))
             {
-                ack.error_number =3D HandleBlockDNSMessage(&msg.block_dns,=
 lists);
+                ack.error_number =3D HandleWfpBlockMessage(&msg.wfp_block,=
 lists);
             }
             break;

@@ -1723,7 +1725,7 @@
 Undo(undo_lists_t *lists)
 {
     undo_type_t type;
-    block_dns_data_t *interface_data;
+    wfp_block_data_t *interface_data;
     for (type =3D 0; type < _undo_type_max; type++)
     {
         list_item_t **pnext =3D &(*lists)[type];
@@ -1756,9 +1758,9 @@
                     SetDNSDomain(item->data, "", NULL);
                     break;

-                case block_dns:
-                    interface_data =3D (block_dns_data_t *)(item->data);
-                    delete_block_dns_filters(interface_data->engine);
+                case wfp_block:
+                    interface_data =3D (wfp_block_data_t *)(item->data);
+                    delete_wfp_block_filters(interface_data->engine);
                     if (interface_data->metric_v4 >=3D 0)
                     {
                         set_interface_metric(interface_data->index, AF_INE=
T,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Gerrit-Change-Number: 489
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--LCokERmS+lE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>d12fk <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">Windows: enforce &#39;block-local&#39; with WFP filters<br><br>In an atte=
mpt to better defend against the TunnelCrack attacks, enforce<br>that no tr=
affic can pass to anything else than the VPN interface when<br>the &#39;blo=
ck-local&#39; flags is given with either --redirect-gateway or<br>--redirec=
t-private.<br><br>Reuse much of the existing --block-outside-dns code, but =
make it more<br>general, so that it can also block any traffic, not just po=
rt 53.<br><br>Uses the Windows Filtering Platform for enforcement in additi=
on to the<br>routes redirecting the networks into the tunnel.<br><br>Change=
-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba<br>Signed-off-by: Heiko Hund=
 &lt;heiko@...2662...&gt;<br>---<br>M CMakeLists.txt<br>M doc/man-sections/=
vpn-network-options.rst<br>M include/openvpn-msg.h<br>M src/openvpn/Makefil=
e.am<br>M src/openvpn/init.c<br>M src/openvpn/route.c<br>M src/openvpn/rout=
e.h<br>M src/openvpn/tun.c<br>R src/openvpn/wfp_block.c<br>R src/openvpn/wf=
p_block.h<br>M src/openvpn/win32.c<br>M src/openvpn/win32.h<br>M src/openvp=
nserv/CMakeLists.txt<br>M src/openvpnserv/Makefile.am<br>M src/openvpnserv/=
interactive.c<br>15 files changed, 333 insertions(+), 240 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/489/3=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index=
 bc46c27..e560ef3 100644</span><br><span>--- a/CMakeLists.txt</span><br><sp=
an>+++ b/CMakeLists.txt</span><br><span>@@ -352,8 +352,6 @@</span><br><span=
>     src/openvpn/base64.c</span><br><span>     src/openvpn/base64.h</span>=
<br><span>     src/openvpn/basic.h</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    src/openvpn/block_dns.h</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    src/openvpn/block_dns.c</span><br><span>     src/ope=
nvpn/buffer.c</span><br><span>     src/openvpn/buffer.h</span><br><span>   =
  src/openvpn/circ_list.h</span><br><span>@@ -533,6 +531,8 @@</span><br><sp=
an>     src/openvpn/ssl_util.h</span><br><span>     src/openvpn/vlan.c</spa=
n><br><span>     src/openvpn/vlan.h</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/wfp_block.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/openvpn/wfp_block.h</span><br><span>     sr=
c/openvpn/win32.c</span><br><span>     src/openvpn/win32-util.c</span><br><=
span>     src/openvpn/win32.h</span><br><span>diff --git a/doc/man-sections=
/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst</span><=
br><span>index 41d367b..7160a17 100644</span><br><span>--- a/doc/man-sectio=
ns/vpn-network-options.rst</span><br><span>+++ b/doc/man-sections/vpn-netwo=
rk-options.rst</span><br><span>@@ -352,6 +352,10 @@</span><br><span>       =
Block access to local LAN when the tunnel is active, except for</span><br><=
span>       the LAN gateway itself. This is accomplished by routing the loc=
al</span><br><span>       LAN (except for the LAN gateway address) into the=
 tunnel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      On Wi=
ndows WFP filters are added in addition to the routes which</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      block access to resources not=
 routed through the VPN adapter.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      Push this flag to protect against TunnelCrack type of at=
tacks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      (see: ht=
tps://tunnelcrack.mathyvanhoef.com/).</span><br><span> </span><br><span>   =
:code:`ipv6`</span><br><span>       Redirect IPv6 routing into the tunnel. =
This works similar to</span><br><span>diff --git a/include/openvpn-msg.h b/=
include/openvpn-msg.h</span><br><span>index a1464cd..0fa0cb5 100644</span><=
br><span>--- a/include/openvpn-msg.h</span><br><span>+++ b/include/openvpn-=
msg.h</span><br><span>@@ -24,6 +24,9 @@</span><br><span> #ifndef OPENVPN_MS=
G_H_</span><br><span> #define OPENVPN_MSG_H_</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;windef.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;ws2tcpip.h&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
typedef enum {</span><br><span>     msg_acknowledgement,</span><br><span>  =
   msg_add_address,</span><br><span>@@ -35,8 +38,8 @@</span><br><span>     =
msg_add_nbt_cfg,</span><br><span>     msg_del_nbt_cfg,</span><br><span>    =
 msg_flush_neighbors,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg_add_block_dns,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg_del_block_dns,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg_add_wfp_block,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg_del_wfp_block,</span><br><span>     msg_register_dns,</span>=
<br><span>     msg_enable_dhcp,</span><br><span>     msg_register_ring_buff=
ers,</span><br><span>@@ -61,6 +64,11 @@</span><br><span>     char name[256]=
;</span><br><span> } interface_t;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    wfp_block_local =3D 1&lt;&lt;0,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_dns =3D 1&lt;&lt=
;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} wfp_block_flags=
_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> typedef struct {</span><br><span>     message_header_t header;</span><br>=
<span>     short family;</span><br><span>@@ -120,8 +128,9 @@</span><br><spa=
n> </span><br><span> typedef struct {</span><br><span>     message_header_t=
 header;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_blo=
ck_flags_t flags;</span><br><span>     interface_t iface;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-} block_dns_message_t;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+} wfp_block_message_t;</span><br><sp=
an> </span><br><span> typedef struct {</span><br><span>     message_header_=
t header;</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvp=
n/Makefile.am</span><br><span>index b953961..6bf3862 100644</span><br><span=
>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.a=
m</span><br><span>@@ -156,6 +156,6 @@</span><br><span> 	$(OPTIONAL_DL_LIBS)=
 \</span><br><span> 	$(OPTIONAL_INOTIFY_LIBS)</span><br><span> if WIN32</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_SOURCES +=3D open=
vpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+openvpn_SOURCES +=3D openvpn_win32=
_resources.rc wfp_block.c wfp_block.h ring_buffer.h</span><br><span> openvp=
n_LDADD +=3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpu=
clnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt</span><br><span> endif</span><br=
><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span=
>index 9e2b3845..efc5f14 100644</span><br><span>--- a/src/openvpn/init.c</s=
pan><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1793,6 +1793,54 =
@@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Add WFP filters to block traffic to local ne=
tworks.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Depending=
 on the configuration all or just DNS is filtered.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * This functionality is only available on W=
indows on all other</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * systems this function is a noop.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param c pointer to the connection context</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+add_wfp_block(struct context *c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Fortify &#39;redirect-gateway block-local&#39; with firewall rules? */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool block_local =
=3D do_block_local(c-&gt;c1.route_list);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (c-&gt;options.block_outside_dns || block_local)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        BOOL dns_only =3D !block_local;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!win_wfp_block(c-&g=
t;c1.tuntap-&gt;adapter_index, c-&gt;options.msg_channel, dns_only))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;WFP: =
initialization failed&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Re=
move any WFP block filters previously added.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * This functionality is only available on Windows=
 on all other</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sys=
tems the function is a noop.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m c             pointer to the connection context</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param adapter_index the VPN adapter index=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+del_wfp_block(struct context *c, unsigned=
 long adapter_index)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN3=
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;opt=
ions.block_outside_dns || do_block_local(c-&gt;c1.route_list))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!win_wfp_uninit(adapter_index, c-&=
gt;options.msg_channel))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(M_FATAL, &quot;WFP: deinitialization failed&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static bool</span><br><span> do_open_tun(struct context *c, int *err=
or_flags)</span><br><span> {</span><br><span>@@ -1915,16 +1963,7 @@</span><=
br><span>                     &quot;up&quot;,</span><br><span>             =
        c-&gt;c2.es);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (c-&gt;options.block_outside_dns)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            dmsg(D_LOW, &quot;Blocking outside D=
NS&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (!win_wfp_block_dns(c-&gt;c1.tuntap-&gt;adapter_index, c-&gt;options.ms=
g_channel))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ms=
g(M_FATAL, &quot;Blocking DNS failed!&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
dd_wfp_block(c);</span><br><span> </span><br><span>         /* possibly add=
 routes */</span><br><span>         if ((route_order() =3D=3D ROUTE_AFTER_T=
UN) &amp;&amp; (!c-&gt;options.route_delay_defined))</span><br><span>@@ -19=
64,17 +2003,8 @@</span><br><span>                         &quot;up&quot;,</=
span><br><span>                         c-&gt;c2.es);</span><br><span>     =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN=
32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;=
options.block_outside_dns)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     dmsg(D_LOW, &quot;Blocking outside DNS&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!win_wfp_block_dns(c-&gt;c1=
.tuntap-&gt;adapter_index, c-&gt;options.msg_channel))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                msg(M_FATAL, &quot;Blocking DNS fa=
iled!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_wfp_block(c=
);</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br>=
<span>     return ret;</span><br><span>@@ -2092,15 +2122,7 @@</span><br><sp=
an>                     &quot;down&quot;,</span><br><span>                 =
    c-&gt;c2.es);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (c-&gt;options.block_outside_dns)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (!win_wfp_uninit(adapter_index, c-&gt=
;options.msg_channel))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         msg(M_FATAL, &quot;Uninitialising WFP failed!&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        del_wfp_block(c, adapter_index);</span><br><span> </span><b=
r><span>         /* actually close tun/tap device based on --down-pre flag =
*/</span><br><span>         if (c-&gt;options.down_pre)</span><br><span>@@ =
-2131,16 +2153,7 @@</span><br><span>                         c-&gt;c2.es);<=
/span><br><span>         }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (c-&gt;options.block_outside_dns)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!win_wfp_uninit(adapter_ind=
ex, c-&gt;options.msg_channel))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                msg(M_FATAL, &quot;Uninitialising WFP failed!&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      del_wfp_block(c, adapter_index);</span><br><span>     }</span><br><sp=
an>     gc_free(&amp;gc);</span><br><span> }</span><br><span>diff --git a/s=
rc/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 6c027d9..390=
0c51 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b=
/src/openvpn/route.c</span><br><span>@@ -25,6 +25,7 @@</span><br><span>  * =
Support routines for adding/deleting network routes.</span><br><span>  */</=
span><br><span> #include &lt;stddef.h&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</span><br><span> </span><b=
r><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config.h&quot=
;</span><br><span>@@ -74,7 +75,9 @@</span><br><span> </span><br><span> #end=
if</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsi=
gned int flags, const struct route_gateway_info *rgi, const struct env_set =
*es, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void delete_route(struct route_ipv4 *r, const struct tunta=
p *tt, unsigned int flags,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                         const struct route_gateway_info *rgi, const=
 struct env_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         openvpn_net_ctx_t *ctx);</span><br><span> </span>=
<br><span> static void get_bypass_addresses(struct route_bypass *rb, const =
unsigned int flags);</span><br><span> </span><br><span>@@ -566,9 +569,7 @@<=
/span><br><span>                      const struct route_gateway_address *g=
ateway,</span><br><span>                      in_addr_t target)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int =
rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if ((rl-&gt;rgi.flags &amp; rgi_needed=
) =3D=3D rgi_needed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      &amp;&amp; rl-&gt;rgi.gateway.netmask &lt; 0xFFFFFFFF)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (rl-&gt;rgi.gateway.netmask=
 &lt; 0xFFFFFFFF)</span><br><span>     {</span><br><span>         struct ro=
ute_ipv4 *r1, *r2;</span><br><span>         unsigned int l2;</span><br><spa=
n>@@ -593,39 +594,40 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-add_blo=
ck_local(struct route_list *rl)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+add_block_local_routes(struct route_list *rl)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int rgi_ne=
eded =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if ((rl-&gt;flags &amp; RG_BLOCK_LOCAL)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; (rl-&gt=
;rgi.flags &amp; rgi_needed) =3D=3D rgi_needed</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        &amp;&amp; (rl-&gt;spec.flags &amp; RTSA_R=
EMOTE_ENDPOINT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  &amp;&amp; rl-&gt;spec.remote_host_local !=3D TLA_LOCAL)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        size_t i;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #ifndef TARGET_ANDROID</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* add bypass for gateway addr =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_bypass_=
address(&amp;rl-&gt;spec.bypass, rl-&gt;rgi.gateway.addr);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* add bypass for gateway addr *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_bypass_add=
ress(&amp;rl-&gt;spec.bypass, rl-&gt;rgi.gateway.addr);</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* block access to local subnet */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        add_block_local_item(rl, &amp;rl-&gt;rgi.gate=
way, rl-&gt;spec.remote_endpoint);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* block access to local subnet */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    add_block_local_item(rl, &amp;rl-&gt;=
rgi.gateway, rl-&gt;spec.remote_endpoint);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* process additional subnet=
s on gateway interface */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        for (i =3D 0; i &lt; rl-&gt;rgi.n_addrs; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* process additional subnets on =
gateway interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (size_t i =3D 0; i &lt; rl-&gt;rgi.n_addrs; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const struct route_gateway_address *gwa =3D=
 &amp;rl-&gt;rgi.addrs[i];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* omit the add/subnet in &amp;rl-&gt;rgi which we processed=
 above */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!((rl-&gt;rgi.gateway.addr &amp; rl-&gt;rgi.gateway.netmask) =3D=3D (gwa-=
&gt;addr &amp; gwa-&gt;netmask)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+              &amp;&amp; rl-&gt;rgi.gateway.netmask =3D=3D gwa-=
&gt;netmask))</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            const struct route_gateway_address *gwa =3D =
&amp;rl-&gt;rgi.addrs[i];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /* omit the add/subnet in &amp;rl-&gt;rgi which we processe=
d above */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (!((rl-&gt;rgi.gateway.addr &amp; rl-&gt;rgi.gateway.netmask) =3D=3D (g=
wa-&gt;addr &amp; gwa-&gt;netmask)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                  &amp;&amp; rl-&gt;rgi.gateway.netmask =3D=3D=
 gwa-&gt;netmask))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     add_block_local_item(rl, gwa, rl-&gt;spec.remote_endpoint);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            add_block_local_item(rl, g=
wa, rl-&gt;spec.remote_endpoint);</span><br><span>         }</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+do_block_local(const struct=
 route_list *rl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int rgi_nee=
ded =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return (rl-&gt;flags &amp; RG_BLOCK_LOCAL)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp=
; (rl-&gt;rgi.flags &amp; rgi_needed) =3D=3D rgi_needed</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; (rl-&gt;spec.flag=
s &amp; RTSA_REMOTE_ENDPOINT)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           &amp;&amp; rl-&gt;spec.remote_host_local !=3D TLA_LOCA=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span> init_route_list(struct route_lis=
t *rl,</span><br><span>                 const struct route_option_list *opt=
,</span><br><span>                 const char *remote_endpoint,</span><br><=
span>@@ -698,7 +700,10 @@</span><br><span> </span><br><span>     if (rl-&gt=
;flags &amp; RG_ENABLE)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        add_block_local(rl);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (do_block_local(rl))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            add_block_local_routes(rl);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span>         get_bypass_addresses(&amp;rl-&gt;spec.bypass, rl-&gt;flags)=
;</span><br><span> #ifdef ENABLE_DEBUG</span><br><span>         print_bypas=
s_addresses(&amp;rl-&gt;spec.bypass);</span><br><span>@@ -1241,6 +1246,7 @@=
</span><br><span>         }</span><br><span>         rl6-&gt;iflags |=3D RL=
_ROUTES_ADDED;</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/route.h b/src/openvp=
n/route.h</span><br><span>index 71b4cf4..568718b 100644</span><br><span>---=
 a/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br>=
<span>@@ -243,6 +243,18 @@</span><br><span>     struct iroute_ipv6 *next;</=
span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Get the decision whether to block traffic to local networks while the V=
PN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is connected. =
This definitely returns false when not redirecting the gateway</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * or when the &#39;block-local&=
#39; flag is not set. Also checks for other</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * prerequisites to redirect local networks into th=
e tunnel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param rl const pointer =
to the struct route_list to base the decision on.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return boolean indicating whether local traffic should be =
blocked.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool do_block_local(const s=
truct route_list *rl);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> struct route_option_list *new_route_option_list(struct=
 gc_arena *a);</span><br><span> </span><br><span> struct route_ipv6_option_=
list *new_route_ipv6_option_list(struct gc_arena *a);</span><br><span>diff =
--git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 8e96149=
..aa78c23 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>++=
+ b/src/openvpn/tun.c</span><br><span>@@ -44,7 +44,7 @@</span><br><span> #i=
nclude &quot;manage.h&quot;</span><br><span> #include &quot;route.h&quot;</=
span><br><span> #include &quot;win32.h&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;block_dns.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;wfp_block.h&quot;</span>=
<br><span> #include &quot;networking.h&quot;</span><br><span> </span><br><s=
pan> #include &quot;memdbg.h&quot;</span><br><span>diff --git a/src/openvpn=
/block_dns.c b/src/openvpn/wfp_block.c</span><br><span>similarity index 69%=
</span><br><span>rename from src/openvpn/block_dns.c</span><br><span>rename=
 to src/openvpn/wfp_block.c</span><br><span>index 05b2599..2ff117b 100644</=
span><br><span>--- a/src/openvpn/block_dns.c</span><br><span>+++ b/src/open=
vpn/wfp_block.c</span><br><span>@@ -37,7 +37,8 @@</span><br><span> #include=
 &lt;winsock2.h&gt;</span><br><span> #include &lt;ws2ipdef.h&gt;</span><br>=
<span> #include &lt;iphlpapi.h&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;block_dns.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;wfp_block.h&quot;</span><br><span> </span><br><span> =
/*</span><br><span>  * WFP-related defines and GUIDs not in mingw32</span><=
br><span>@@ -92,10 +93,19 @@</span><br><span>     0xb7, 0xf3, 0xbd, 0xa5, 0=
xd3, 0x28, 0x90, 0xa4</span><br><span>     );</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* 632ce23b-5167-435c-86d7-e903=
684aa80c */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+DEFINE_G=
UID(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FWPM_CONDIT=
ION_FLAGS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x632=
ce23b,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x5167,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x435c,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0x86, 0xd7, 0xe9, 0x03, 0=
x68, 0x4a, 0xa8, 0x0c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /* UUID of WFP sublayer used by all instances of openvpn</span><br><=
span>  * 2f660d7e-6a37-11e6-a181-001e8c6e04a2 */</span><br><span> DEFINE_GU=
ID(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OPENVPN_BLOCK_=
OUTSIDE_DNS_SUBLAYER,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    OPENVPN_WFP_BLOCK_SUBLAYER,</span><br><span>     0x2f660d7e,</span><b=
r><span>     0x6a37,</span><br><span>     0x11e6,</span><br><span>@@ -113,7=
 +123,7 @@</span><br><span>     return;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHECK_ERROR(=
err, msg) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
OUT_ON_ERROR(err, msg) \</span><br><span>     if (err) { msg_handler(err, m=
sg); goto out; }</span><br><span> </span><br><span> /*</span><br><span>@@ -=
154,36 +164,41 @@</span><br><span> }</span><br><span> </span><br><span> /*<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Block outgoing port=
 53 traffic except for</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * (i) adapter with the specified index</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Block outgoing local traffic, possibly DNS only, ex=
cept for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (i) adap=
ter with the specified index (and loopback, if all is blocked)</span><br><s=
pan>  * OR</span><br><span>  * (ii) processes with the specified executable=
 path</span><br><span>  * The firewall filters added here are automatically=
 removed when the process exits or</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * on calling delete_block_dns_filters().</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * on calling delete_wfp_block_filters()=
.</span><br><span>  * Arguments:</span><br><span>  *   engine_handle : On s=
uccessful return contains the handle for a newly opened fwp session</span><=
br><span>  *                   in which the filters are added.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *                   May be closed=
 by passing to delete_block_dns_filters to remove the filters.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *                   May be clos=
ed by passing to delete_wfp_block_filters to remove the filters.</span><br>=
<span>  *   index         : The index of adapter for which traffic is permi=
tted.</span><br><span>  *   exe_path      : Path of executable for which tr=
affic is permitted.</span><br><span>  *   msg_handler   : An optional callb=
ack function for error reporting.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *   dns_only      : Whether the blocking filters should appl=
y for DNS only.</span><br><span>  * Returns 0 on success, a non-zero status=
 code of the last failed action on failure.</span><br><span>  */</span><br>=
<span> </span><br><span> DWORD</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-add_block_dns_filters(HANDLE *engine_handle,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+add_wfp_block_filters(HANDLE *engine_hand=
le,</span><br><span>                       int index,</span><br><span>     =
                  const WCHAR *exe_path,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                      block_dns_msg_handler_t msg_handle=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
  )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      wfp_block_msg_handler_t msg_handler,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      BOOL dns_only)</span><br><span=
> {</span><br><span>     FWPM_SESSION0 session =3D {0};</span><br><span>   =
  FWPM_SUBLAYER0 *sublayer_ptr =3D NULL;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    NET_LUID tapluid;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    NET_LUID itf_luid;</span><br><span>     UINT64 fil=
terid;</span><br><span>     FWP_BYTE_BLOB *openvpnblob =3D NULL;</span><br>=
<span>     FWPM_FILTER0 Filter =3D {0};</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    FWPM_FILTER_CONDITION0 Condition[2] =3D {0};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    FWPM_FILTER_CONDITION0 C=
ondition[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FWP=
M_FILTER_CONDITION0 match_openvpn =3D {0};</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    FWPM_FILTER_CONDITION0 match_port_53 =3D {0};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    FWPM_FILTER_CONDIT=
ION0 match_interface =3D {0};</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    FWPM_FILTER_CONDITION0 match_not_loopback =3D {0};</span><br>=
<span>     DWORD err =3D 0;</span><br><span> </span><br><span>     if (!msg=
_handler)</span><br><span>@@ -197,116 +212,127 @@</span><br><span>     *eng=
ine_handle =3D NULL;</span><br><span> </span><br><span>     err =3D FwpmEng=
ineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &amp;session, engine_handle);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHECK_ERROR(err, &quot;=
FwpEngineOpen: open fwp session failed&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg_handler(0, &quot;Block_DNS: WFP engine ope=
ned&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_=
ON_ERROR(err, &quot;FwpEngineOpen: open fwp session failed&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg_handler(0, &quot;WFP=
 Block: WFP engine opened&quot;);</span><br><span> </span><br><span>     /*=
 Check sublayer exists and add one if it does not. */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (FwpmSubLayerGetByKey0(*engine_handl=
e, &amp;OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER, &amp;sublayer_ptr)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (FwpmSubLayerGetByKey0(*e=
ngine_handle, &amp;OPENVPN_WFP_BLOCK_SUBLAYER, &amp;sublayer_ptr)</span><br=
><span>         =3D=3D ERROR_SUCCESS)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg_handler(0, &quot;Block_D=
NS: Using existing sublayer&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg_handler(0, &quot;WFP Block: Using existing subl=
ayer&quot;);</span><br><span>         FwpmFreeMemory0((void **)&amp;sublaye=
r_ptr);</span><br><span>     }</span><br><span>     else</span><br><span>  =
   {  /* Add a new sublayer -- as another process may add it in the meantim=
e,</span><br><span>         * do not treat &quot;already exists&quot; as an=
 error */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =
=3D add_sublayer(OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        err =3D add_sublayer(OPENVPN_WFP_=
BLOCK_SUBLAYER);</span><br><span> </span><br><span>         if (err =3D=3D =
FWP_E_ALREADY_EXISTS || err =3D=3D ERROR_SUCCESS)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg_hand=
ler(0, &quot;Block_DNS: Added a persistent sublayer with pre-defined UUID&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg_handler(0, &quot;WFP Block: Added a persistent sublayer with pre-defined=
 UUID&quot;);</span><br><span>         }</span><br><span>         else</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            CHECK_ERROR(err, &quot;add_sublayer: failed to add persistent =
sublayer&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         OUT_ON_ERROR(err, &quot;add_sublayer: failed to add persistent sub=
layer&quot;);</span><br><span>         }</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D Con=
vertInterfaceIndexToLuid(index, &amp;tapluid);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    CHECK_ERROR(err, &quot;Convert interface index=
 to luid failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    err =3D ConvertInterfaceIndexToLuid(index, &amp;itf_luid);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERROR(err, &quot;=
Convert interface index to luid failed&quot;);</span><br><span> </span><br>=
<span>     err =3D FwpmGetAppIdFromFileName0(exe_path, &amp;openvpnblob);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHECK_ERROR(err, &q=
uot;Get byte blob for openvpn executable name failed&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERROR(err, &quot;Get by=
te blob for openvpn executable name failed&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Prepare match conditions */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    match_openvpn.fieldKey =3D FWPM_CONDITION_AL=
E_APP_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    match_=
openvpn.matchType =3D FWP_MATCH_EQUAL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    match_openvpn.conditionValue.type =3D FWP_BYTE_BLOB_=
TYPE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    match_open=
vpn.conditionValue.byteBlob =3D openvpnblob;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    match_port_53.fieldKey =3D FWPM_CONDITION_IP_REMOTE_PORT;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    match_port_53.matchType=
 =3D FWP_MATCH_EQUAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    match_port_53.conditionValue.type =3D FWP_UINT16;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    match_port_53.conditionValue.uint16=
 =3D 53;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    match_interface.fieldKey =
=3D FWPM_CONDITION_IP_LOCAL_INTERFACE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    match_interface.matchType =3D FWP_MATCH_EQUAL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    match_interface.condi=
tionValue.type =3D FWP_UINT64;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    match_interface.conditionValue.uint64 =3D &amp;itf_luid.Valu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    match_not_loopback.fieldKey =3D =
FWPM_CONDITION_FLAGS;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    match_not_loopback.matchType =3D FWP_MATCH_FLAGS_NONE_SET;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    match_not_loopback.conditi=
onValue.type =3D FWP_UINT32;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    match_not_loopback.conditionValue.uint32 =3D FWP_CONDITION_FLA=
G_IS_LOOPBACK;</span><br><span> </span><br><span>     /* Prepare filter. */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter.subLayerKe=
y =3D OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    Filter.subLayerKey =3D OPENVPN_WFP_BLOCK_SUBLAYER=
;</span><br><span>     Filter.displayData.name =3D FIREWALL_NAME;</span><br=
><span>     Filter.weight.type =3D FWP_UINT8;</span><br><span>     Filter.w=
eight.uint8 =3D 0xF;</span><br><span>     Filter.filterCondition =3D Condit=
ion;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter.numFil=
terConditions =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    Filter.numFilterConditions =3D 1;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* First filter. Permit IPv4 DNS que=
ries from OpenVPN itself. */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* First filter. Permit IPv4 from OpenVPN itself. */</span><br=
><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span><br><=
span>     Filter.action.type =3D FWP_ACTION_PERMIT;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    Condition[0].fieldKey =3D FWPM_CONDITION_IP_REMOTE_PORT;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[0].matchTyp=
e =3D FWP_MATCH_EQUAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    Condition[0].conditionValue.type =3D FWP_UINT16;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    Condition[0].conditionValue.uint16 =3D =
53;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    Condition[1].fieldKey =3D FWPM_COND=
ITION_ALE_APP_ID;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
Condition[1].matchType =3D FWP_MATCH_EQUAL;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    Condition[1].conditionValue.type =3D FWP_BYTE_BLO=
B_TYPE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[=
1].conditionValue.byteBlob =3D openvpnblob;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    Condition[0] =3D match_openvpn;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (dns_only)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        Filter.numFilterConditions =3D 2;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        Condition[1] =3D match_port_53;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     err=
 =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &amp;filterid);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHECK_ERROR(err, &quot=
;Add filter to permit IPv4 port 53 traffic from OpenVPN failed&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERROR(err, &q=
uot;Add filter to permit IPv4 traffic from OpenVPN failed&quot;);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Second=
 filter. Permit IPv6 DNS queries from OpenVPN itself. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Second filter. Permit IPv6 from=
 OpenVPN itself. */</span><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE=
_AUTH_CONNECT_V6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL,=
 &amp;filterid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    C=
HECK_ERROR(err, &quot;Add filter to permit IPv6 port 53 traffic from OpenVP=
N failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 OUT_ON_ERROR(err, &quot;Add filter to permit IPv6 traffic from OpenVPN fai=
led&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    msg_handler(0, &quot;Block_DNS: Added permit filters for exe_pa=
th&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_h=
andler(0, &quot;WFP Block: Added permit filters for exe_path&quot;);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Thi=
rd filter. Block all IPv4 DNS queries. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Third filter. Block IPv4 to port 53 or all exc=
ept loopback. */</span><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AU=
TH_CONNECT_V4;</span><br><span>     Filter.action.type =3D FWP_ACTION_BLOCK=
;</span><br><span>     Filter.weight.type =3D FWP_EMPTY;</span><br><span>  =
   Filter.numFilterConditions =3D 1;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
Condition[0] =3D dns_only ? match_port_53 : match_not_loopback;</span><br><=
span>     err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &amp;fi=
lterid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHECK_ERR=
OR(err, &quot;Add filter to block IPv4 DNS traffic failed&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERROR(err, &quot;A=
dd filter to block IPv4 traffic failed&quot;);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* Forth filter. Block all I=
Pv6 DNS queries. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Fourth filter. Block IPv6 to port 53 or all besides loopback */</spa=
n><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     err =
=3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &amp;filterid);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHECK_ERROR(err, &quot;=
Add filter to block IPv6 DNS traffic failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERROR(err, &quot;Add filter to=
 block IPv6 traffic failed&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg_handler(0, &quot;Block_DNS: Added b=
lock filters for all interfaces&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg_handler(0, &quot;WFP Block: Added block filters=
 for all interfaces&quot;);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Fifth filter. Permit IPv4 DNS queries from T=
AP.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Fifth fil=
ter. Permit IPv4 for the VPN interface.</span><br><span>      * Use a non-z=
ero weight so that the permit filters get higher priority</span><br><span> =
     * over the block filter added with automatic weighting */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     Filter.weigh=
t.type =3D FWP_UINT8;</span><br><span>     Filter.weight.uint8 =3D 0xE;</sp=
an><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span=
><br><span>     Filter.action.type =3D FWP_ACTION_PERMIT;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    Filter.numFilterConditions =3D 2;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    Condition[1].fieldKey =3D FWPM_CONDITIO=
N_IP_LOCAL_INTERFACE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    Condition[1].matchType =3D FWP_MATCH_EQUAL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    Condition[1].conditionValue.type =3D FWP_UINT=
64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[1].c=
onditionValue.uint64 =3D &amp;tapluid.Value;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    Filter.numFilterConditions =3D 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    Condition[0] =3D match_interface;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (dns_only)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        Filter.numFilterConditions =3D 2;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        Condition[1] =3D matc=
h_port_53;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span>     err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL,=
 &amp;filterid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    C=
HECK_ERROR(err, &quot;Add filter to permit IPv4 DNS traffic through TAP fai=
led&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_=
ON_ERROR(err, &quot;Add filter to permit IPv4 traffic through VPN interface=
 failed&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* Sixth filter. Permit IPv6 DNS queries from TAP.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Sixth filter. Permit =
IPv6 for the VPN interface.</span><br><span>      * Use same weight as IPv4=
 filter */</span><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CON=
NECT_V6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>     err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &amp;fil=
terid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHECK_ERRO=
R(err, &quot;Add filter to permit IPv6 DNS traffic through TAP failed&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERROR(=
err, &quot;Add filter to permit IPv6 traffic through VPN interface failed&q=
uot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg_handler(0, &quot;Block_DNS: Added permit filters for TAP interfa=
ce&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_h=
andler(0, &quot;WFP Block: Added permit filters for VPN interface&quot;);</=
span><br><span> </span><br><span> out:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     if (openvpnblob)</span><br><span>   =
  {</span><br><span>         FwpmFreeMemory0((void **)&amp;openvpnblob);</s=
pan><br><span>@@ -322,7 +348,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-del=
ete_block_dns_filters(HANDLE engine_handle)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+delete_wfp_block_filters(HANDLE engine_handle)</spa=
n><br><span> {</span><br><span>     DWORD err =3D 0;</span><br><span>     /=
*</span><br><span>diff --git a/src/openvpn/block_dns.h b/src/openvpn/wfp_bl=
ock.h</span><br><span>similarity index 83%</span><br><span>rename from src/=
openvpn/block_dns.h</span><br><span>rename to src/openvpn/wfp_block.h</span=
><br><span>index 89b88d6..60c9171 100644</span><br><span>--- a/src/openvpn/=
block_dns.h</span><br><span>+++ b/src/openvpn/wfp_block.h</span><br><span>@=
@ -23,20 +23,24 @@</span><br><span> </span><br><span> #ifdef _WIN32</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef OPE=
NVPN_BLOCK_DNS_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne OPENVPN_BLOCK_DNS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef WFP_BLOCK_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define WFP_BLOCK_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;win=
def.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;iphlpapi.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;ws2tcpip.h&gt;</span><br><span> </span><br><span> /* Any value l=
ess than 5 should work fine. 3 is chosen without any real reason. */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define BLOCK_DNS_IFACE_METR=
IC 3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define WFP_BLO=
CK_IFACE_METRIC 3</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-typedef void (*block_dns_msg_handler_t) (DWORD err, const cha=
r *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef voi=
d (*wfp_block_msg_handler_t) (DWORD err, const char *msg);</span><br><span>=
 </span><br><span> DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-delete_block_dns_filters(HANDLE engine);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+delete_wfp_block_filters(HANDLE engine);</span><br>=
<span> </span><br><span> DWORD</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR=
 *exe_path,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
            block_dns_msg_handler_t msg_handler_callback);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block_filters(HANDLE *engine=
, int iface_index, const WCHAR *exe_path,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                      wfp_block_msg_handler_t msg_han=
dler_callback, BOOL dns_only);</span><br><span> </span><br><span> /**</span=
><br><span>  * Return interface metric value for the specified interface in=
dex.</span><br><span>@@ -65,5 +69,5 @@</span><br><span> set_interface_metri=
c(const NET_IFINDEX index, const ADDRESS_FAMILY family,</span><br><span>   =
                   const ULONG metric);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef OPENVPN_BLOCK_DNS_H */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef WF=
P_BLOCK_H */</span><br><span> #endif /* ifdef _WIN32 */</span><br><span>dif=
f --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><span>index 6=
b7ba5e..9d08554 100644</span><br><span>--- a/src/openvpn/win32.c</span><br>=
<span>+++ b/src/openvpn/win32.c</span><br><span>@@ -34,6 +34,9 @@</span><br=
><span> </span><br><span> #ifdef _WIN32</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;minwindef.h&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;winsock2.h&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #i=
nclude &quot;buffer.h&quot;</span><br><span> #include &quot;error.h&quot;</=
span><br><span> #include &quot;mtu.h&quot;</span><br><span>@@ -47,7 +50,7 @=
@</span><br><span> </span><br><span> #include &lt;versionhelpers.h&gt;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &quot;block_dns.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;wfp_block.h&quot;</span><br><span> </span><br><span> /*=
</span><br><span>  * WFP handle</span><br><span>@@ -1138,43 +1141,19 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-win_block_dns_service(bool add, in=
t index, const HANDLE pipe)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+win_get_exe_path(PWCHAR path, DWORD size)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ack_message_t ack;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    block_dns_message_t data =
=3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        .header =
=3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            (add=
 ? msg_add_block_dns : msg_del_block_dns),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            sizeof(block_dns_message_t),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            0</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        },</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        .iface =3D { .index =3D index, .name =3D &quot=
;&quot; }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    };</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!send_msg_iservice(pipe, &amp;data, size=
of(data), &amp;ack, &quot;Block_DNS&quot;))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    DWORD status =3D GetModuleFileNameW(NULL, path,=
 size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (stat=
us =3D=3D 0 || status =3D=3D size)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN|M_ERRNO, &quot;cannot =
get executable path&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (ack.error_number !=3D NO_ERROR)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        msg(M_WARN, &quot;Block_DNS: %s block dns filters usin=
g service failed: %s [status=3D0x%x if_index=3D%d]&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            (add ? &quot;adding&quot; :=
 &quot;deleting&quot;), strerror_win32(ack.error_number, &amp;gc),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ack.error_number, =
data.iface.index);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    msg(M_INFO, &quot;%s outside dns using serv=
ice succeeded.&quot;, (add ? &quot;Blocking&quot; : &quot;Unblocking&quot;)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-out:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span> }</spa=
n><br><span> </span><br><span> static void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-block_dns_msg_handler(DWORD err, const char *msg)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+win_wfp_msg_handler(DWOR=
D err, const char *msg)</span><br><span> {</span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span> </span><br><span>@@ -1184,15 +1163,5=
2 @@</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, =
&quot;Error in add_block_dns_filters(): %s : %s [status=3D0x%lx]&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &qu=
ot;Error in WFP: %s : %s [status=3D0x%lx]&quot;,</span><br><span>          =
   msg, strerror_win32(err, &amp;gc), err);</span><br><span>     }</span><b=
r><span> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+win_wfp_block_ser=
vice(bool add, bool dns_only, int index, const HANDLE pipe)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ack_message_t ack;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    wfp_block_message_t data =3D {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        .header =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            (add ? msg_add_wfp_=
block : msg_del_wfp_block),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            sizeof(wfp_block_message_t),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            0</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        .flags =3D dns_only ? wfp_block_dns : wfp_block_local=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        .iface =3D=
 { .index =3D index, .name =3D &quot;&quot; }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!send_msg_iservice(pipe, &amp;data, sizeof(data), &amp;ack, &quot;WFP blo=
ck&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (ack.error_number !=3D NO_ERROR)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WFP block: %s block filter=
s using service failed: %s [status=3D0x%x if_index=3D%d]&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            (add ? &quot;adding=
&quot; : &quot;deleting&quot;), strerror_win32(ack.error_number, &amp;gc),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ack.erro=
r_number, data.iface.index);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;%s WFP=
 block filters using service succeeded.&quot;, (add ? &quot;Adding&quot; : =
&quot;Deleting&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-win_wfp_block_dns(const NET_IF=
INDEX index, const HANDLE msg_channel)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+win_wfp_block(const NET_IFINDEX index, const HANDLE msg_=
channel, BOOL dns_only)</span><br><span> {</span><br><span>     WCHAR openv=
pnpath[MAX_PATH];</span><br><span>     bool ret =3D false;</span><br><span>=
@@ -1200,20 +1216,19 @@</span><br><span> </span><br><span>     if (msg_chan=
nel)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        dmsg(D_LOW, &quot;Using service to add block dns filters&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D wi=
n_block_dns_service(true, index, msg_channel);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        dmsg(D_LOW, &quot;Using service to add W=
FP block filters&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ret =3D win_wfp_block_service(true, dns_only, index, msg_chann=
el);</span><br><span>         goto out;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D G=
etModuleFileNameW(NULL, openvpnpath, _countof(openvpnpath));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (status =3D=3D 0 || status =
=3D=3D _countof(openvpnpath))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ret =3D win_get_exe_path(openvpnpath, _countof(openvpnpath));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D =
false)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(M_WARN|M_ERRNO, &quot;block_dns: cannot get executable =
path&quot;);</span><br><span>         goto out;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stat=
us =3D add_block_dns_filters(&amp;m_hEngineHandle, index, openvpnpath,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
         block_dns_msg_handler);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    status =3D add_wfp_block_filters(&amp;m_hEngineHandle, ind=
ex, openvpnpath,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                win_wfp_msg_handler, dns_only);</span><br><=
span>     if (status =3D=3D 0)</span><br><span>     {</span><br><span>     =
    int is_auto =3D 0;</span><br><span>@@ -1227,10 +1242,10 @@</span><br><s=
pan>         {</span><br><span>             tap_metric_v6 =3D 0;</span><br>=
<span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   status =3D set_interface_metric(index, AF_INET, BLOCK_DNS_IFACE_METRIC);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D =
set_interface_metric(index, AF_INET, WFP_BLOCK_IFACE_METRIC);</span><br><sp=
an>         if (!status)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            set_interface_metric(index, AF_=
INET6, BLOCK_DNS_IFACE_METRIC);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            set_interface_metric(index, AF_INET6, WFP_BLOCK_IFA=
CE_METRIC);</span><br><span>         }</span><br><span>     }</span><br><sp=
an> </span><br><span>@@ -1248,12 +1263,12 @@</span><br><span> </span><br><s=
pan>     if (msg_channel)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;Using service to delete=
 block dns filters&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        win_block_dns_service(false, index, msg_channel);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;Using s=
ervice to delete WFP block filters&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        win_wfp_block_service(false, false, index, m=
sg_channel);</span><br><span>     }</span><br><span>     else</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dele=
te_block_dns_filters(m_hEngineHandle);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        delete_wfp_block_filters(m_hEngineHandle);</span=
><br><span>         m_hEngineHandle =3D NULL;</span><br><span>         if (=
tap_metric_v4 &gt;=3D 0)</span><br><span>         {</span><br><span>diff --=
git a/src/openvpn/win32.h b/src/openvpn/win32.h</span><br><span>index aa851=
3b..92b3528 100644</span><br><span>--- a/src/openvpn/win32.h</span><br><spa=
n>+++ b/src/openvpn/win32.h</span><br><span>@@ -25,8 +25,10 @@</span><br><s=
pan> #ifndef OPENVPN_WIN32_H</span><br><span> #define OPENVPN_WIN32_H</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include =
&lt;winioctl.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;iphlpapi.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;ws2tcpip.h&gt;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br>=
<span> #include &quot;mtu.h&quot;</span><br><span> #include &quot;openvpn-m=
sg.h&quot;</span><br><span> #include &quot;argv.h&quot;</span><br><span>@@ =
-286,7 +288,7 @@</span><br><span> /* call self in a subprocess */</span><br=
><span> void fork_to_self(const char *cmdline);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-bool win_wfp_block_dns(const NE=
T_IFINDEX index, const HANDLE msg_channel);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool win_wfp_block(const NET_IFINDEX index, const H=
ANDLE msg_channel, BOOL dns_only);</span><br><span> </span><br><span> bool =
win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);</span><b=
r><span> </span><br><span>diff --git a/src/openvpnserv/CMakeLists.txt b/src=
/openvpnserv/CMakeLists.txt</span><br><span>index 17cd90c..154e17c 100644</=
span><br><span>--- a/src/openvpnserv/CMakeLists.txt</span><br><span>+++ b/s=
rc/openvpnserv/CMakeLists.txt</span><br><span>@@ -17,7 +17,7 @@</span><br><=
span>     interactive.c</span><br><span>     service.c service.h</span><br>=
<span>     validate.c validate.h</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ../openvpn/block_dns.c ../openvpn/block_dns.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ../openvpn/wfp_block.c ../open=
vpn/wfp_block.h</span><br><span>     openvpnserv_resources.rc</span><br><sp=
an>     ../openvpn/ring_buffer.h</span><br><span>     )</span><br><span>dif=
f --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am</span><=
br><span>index d8ba4eb..49ad8aa 100644</span><br><span>--- a/src/openvpnser=
v/Makefile.am</span><br><span>+++ b/src/openvpnserv/Makefile.am</span><br><=
span>@@ -33,6 +33,6 @@</span><br><span> 	interactive.c \</span><br><span> 	=
service.c service.h \</span><br><span> 	validate.c validate.h \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/block_=
dns.c $(top_srcdir)/src/openvpn/block_dns.h \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcd=
ir)/src/openvpn/wfp_block.h \</span><br><span> 	openvpnserv_resources.rc \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/ring_buffer.h</span><br><span>d=
iff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</=
span><br><span>index 32c8996..68a8106 100644</span><br><span>--- a/src/open=
vpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</=
span><br><span>@@ -38,7 +38,7 @@</span><br><span> </span><br><span> #includ=
e &quot;openvpn-msg.h&quot;</span><br><span> #include &quot;validate.h&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;block=
_dns.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;wfp_block.h&quot;</span><br><span> #include &quot;ring_buffer.h&quo=
t;</span><br><span> </span><br><span> #define IO_TIMEOUT  2000 /*ms*/</span=
><br><span>@@ -84,7 +84,7 @@</span><br><span> typedef enum {</span><br><spa=
n>     address,</span><br><span>     route,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    block_dns,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    wfp_block,</span><br><span>     undo_dns4,</span><br><=
span>     undo_dns6,</span><br><span>     undo_domain,</span><br><span>@@ -=
99,7 +99,7 @@</span><br><span>     int index;</span><br><span>     int metr=
ic_v4;</span><br><span>     int metric_v6;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-} block_dns_data_t;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+} wfp_block_data_t;</span><br><span> </span><br><span>=
 typedef struct {</span><br><span>     struct tun_ring *send_ring;</span><b=
r><span>@@ -774,74 +774,76 @@</span><br><span> }</span><br><span> </span><b=
r><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
DeleteBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+DeleteWfpBlock(const wfp_bl=
ock_message_t *msg, undo_lists_t *lists)</span><br><span> {</span><br><span=
>     DWORD err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    block_dns_data_t *interface_data =3D RemoveListItem(&amp;(*lists)[bloc=
k_dns], CmpAny, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    wfp_block_data_t *block_data =3D RemoveListItem(&amp;(*lists)[wfp_bl=
ock], CmpAny, NULL);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (interface_data)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (block_data)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        err =3D delete_block_dns_=
filters(interface_data-&gt;engine);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (interface_data-&gt;metric_v4 &gt;=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D delete_wfp_bl=
ock_filters(block_data-&gt;engine);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (block_data-&gt;metric_v4 &gt;=3D 0)</span><br><=
span>         {</span><br><span>             set_interface_metric(msg-&gt;i=
face.index, AF_INET,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                interface_data-&gt;metric_v4);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
 block_data-&gt;metric_v4);</span><br><span>         }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (interface_data-&gt;metric_v6 &=
gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (block_data-&gt;metric_v6 &gt;=3D 0)</span><br><span>         {</span><br>=
<span>             set_interface_metric(msg-&gt;iface.index, AF_INET6,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
       interface_data-&gt;metric_v6);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                 block_data-&gt;metric_v6=
);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        free(interface_data);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        free(block_data);</span><br><span>     }</span><b=
r><span>     else</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quot;No previous bloc=
k DNS filters to delete&quot;));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;No previous block filt=
ers to delete&quot;));</span><br><span>     }</span><br><span> </span><br><=
span>     return err;</span><br><span> }</span><br><span> </span><br><span>=
 static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AddBlock=
DNS(const block_dns_message_t *msg, undo_lists_t *lists)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+AddWfpBlock(const wfp_block_message_t =
*msg, undo_lists_t *lists)</span><br><span> {</span><br><span>     DWORD er=
r =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    block_dns=
_data_t *interface_data =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    wfp_block_data_t *block_data =3D NULL;</span><br><span>  =
   HANDLE engine =3D NULL;</span><br><span>     LPCWSTR exe_path;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL dns_only;</span><br>=
<span> </span><br><span>     exe_path =3D settings.exe_path;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    dns_only =3D (msg-&gt;flags =
=3D=3D wfp_block_dns);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    err =3D add_block_dns_filters(&amp;engine, msg-&gt;i=
face.index, exe_path, BlockDNSErrHandler);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    err =3D add_wfp_block_filters(&amp;engine, msg-&=
gt;iface.index, exe_path, BlockDNSErrHandler, dns_only);</span><br><span>  =
   if (!err)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        interface_data =3D malloc(sizeof(block_dns_data_t));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!interface=
_data)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        block=
_data =3D malloc(sizeof(wfp_block_data_t));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!block_data)</span><br><span>         {=
</span><br><span>             err =3D ERROR_OUTOFMEMORY;</span><br><span>  =
           goto out;</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        interface_data-&gt;engine =3D engine;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        interface_data-&g=
t;index =3D msg-&gt;iface.index;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        block_data-&gt;engine =3D engine;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        block_data-&gt;index =3D msg-&gt=
;iface.index;</span><br><span>         int is_auto =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        interface_data-&gt;metric_v4 =
=3D get_interface_metric(msg-&gt;iface.index,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                                   =
      AF_INET, &amp;is_auto);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        block_data-&gt;metric_v4 =3D get_interface_metric(msg-&gt=
;iface.index,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                               AF_INET, &amp;is_auto);</spa=
n><br><span>         if (is_auto)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            interface_data-&gt;metri=
c_v4 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    block_data-&gt;metric_v4 =3D 0;</span><br><span>         }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        interface_data-&gt;metric_=
v6 =3D get_interface_metric(msg-&gt;iface.index,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                                =
         AF_INET6, &amp;is_auto);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        block_data-&gt;metric_v6 =3D get_interface_metric(msg=
-&gt;iface.index,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                                   AF_INET6, &amp;is_auto);=
</span><br><span>         if (is_auto)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            interface_data-&gt;=
metric_v6 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         block_data-&gt;metric_v6 =3D 0;</span><br><span>         }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err=
 =3D AddListItem(&amp;(*lists)[block_dns], interface_data);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        err =3D AddListItem(&amp;(*=
lists)[wfp_block], block_data);</span><br><span>         if (!err)</span><b=
r><span>         {</span><br><span>             err =3D set_interface_metri=
c(msg-&gt;iface.index, AF_INET,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                       BLOCK_DNS_IFACE_METRIC);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                  WFP_BLOCK_IFACE_METRIC);</span><br><span>             if =
(!err)</span><br><span>             {</span><br><span>                 /* f=
or IPv6, we intentionally ignore errors, because</span><br><span>@@ -850,12=
 +852,12 @@</span><br><span>                  * (if OpenVPN wants IPv6 ifco=
nfig, we&#39;ll fail there)</span><br><span>                  */</span><br>=
<span>                 set_interface_metric(msg-&gt;iface.index, AF_INET6,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
               BLOCK_DNS_IFACE_METRIC);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                     WFP_BLOCK_IFACE_ME=
TRIC);</span><br><span>             }</span><br><span>             if (err)=
</span><br><span>             {</span><br><span>                 /* delete =
the filters, remove undo item and free interface data */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                DeleteBlockDNS(msg, list=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
DeleteWfpBlock(msg, lists);</span><br><span>                 engine =3D NUL=
L;</span><br><span>             }</span><br><span>         }</span><br><spa=
n>@@ -864,23 +866,23 @@</span><br><span> out:</span><br><span>     if (err =
&amp;&amp; engine)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        delete_block_dns_filters(engine);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        free(interface_data);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        delete_wfp_block_=
filters(engine);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     free(block_data);</span><br><span>     }</span><br><span> </span><br><=
span>     return err;</span><br><span> }</span><br><span> </span><br><span>=
 static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-HandleBl=
ockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+HandleWfpBlockMessage(const =
wfp_block_message_t *msg, undo_lists_t *lists)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (msg-&gt;header.type =3D=
=3D msg_add_block_dns)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (msg-&gt;header.type =3D=3D msg_add_wfp_block)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return Ad=
dBlockDNS(msg, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return AddWfpBlock(msg, lists);</span><br><span>     }</span><br=
><span>     else</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return DeleteBlockDNS(msg, lists);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return DeleteWfpBlock(msg,=
 lists);</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span>@@ -1616,7 +1618,7 @@</span><br><span>         address_message_t =
address;</span><br><span>         route_message_t route;</span><br><span>  =
       flush_neighbors_message_t flush_neighbors;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        block_dns_message_t block_dns;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        wfp_block_message_t =
wfp_block;</span><br><span>         dns_cfg_message_t dns;</span><br><span>=
         enable_dhcp_message_t dhcp;</span><br><span>         register_ring=
_buffers_message_t rrb;</span><br><span>@@ -1665,11 +1667,11 @@</span><br><=
span>             }</span><br><span>             break;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case msg_add_bl=
ock_dns:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case =
msg_del_block_dns:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (msg.header.size =3D=3D sizeof(msg.block_dns))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case msg_add_wfp_block:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case msg_del_wfp=
_block:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (msg.header.size =3D=3D sizeof(msg.wfp_block))</span><br><span>         =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
ack.error_number =3D HandleBlockDNSMessage(&amp;msg.block_dns, lists);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                ack.erro=
r_number =3D HandleWfpBlockMessage(&amp;msg.wfp_block, lists);</span><br><s=
pan>             }</span><br><span>             break;</span><br><span> </s=
pan><br><span>@@ -1723,7 +1725,7 @@</span><br><span> Undo(undo_lists_t *lis=
ts)</span><br><span> {</span><br><span>     undo_type_t type;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    block_dns_data_t *interface_dat=
a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_dat=
a_t *interface_data;</span><br><span>     for (type =3D 0; type &lt; _undo_=
type_max; type++)</span><br><span>     {</span><br><span>         list_item=
_t **pnext =3D &amp;(*lists)[type];</span><br><span>@@ -1756,9 +1758,9 @@</=
span><br><span>                     SetDNSDomain(item-&gt;data, &quot;&quot=
;, NULL);</span><br><span>                     break;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                case bloc=
k_dns:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     interface_data =3D (block_dns_data_t *)(item-&gt;data);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    delete_block_dns=
_filters(interface_data-&gt;engine);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                case wfp_block:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    interface_data =3D (wfp_bl=
ock_data_t *)(item-&gt;data);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    delete_wfp_block_filters(interface_data-&gt;e=
ngine);</span><br><span>                     if (interface_data-&gt;metric_=
v4 &gt;=3D 0)</span><br><span>                     {</span><br><span>      =
                   set_interface_metric(interface_data-&gt;index, AF_INET,<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/489?usp=3Demail">change 489</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/489?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--LCokERmS+lE=--

