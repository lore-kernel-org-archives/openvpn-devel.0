From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 00:48:54 +0000
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2b1c779f10bc36e410aa0fee2c30a78564824cdf-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RykBHYKWIXQ="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RykBHYKWIXQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail

to review the following change.


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
15 files changed, 299 insertions(+), 213 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/489/1

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
index 41d367b..630e8f5 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -352,6 +352,9 @@
       Block access to local LAN when the tunnel is active, except for
       the LAN gateway itself. This is accomplished by routing the local
       LAN (except for the LAN gateway address) into the tunnel.
+      On Windows WFP filters are added in addition to the routes which
+      block access to resources not routed through the VPN adapter.
+      Push this flag to defend against the TunnelCrack attacks.

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
index 9e2b3845..4108e8c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1916,12 +1916,15 @@
                     c->c2.es);

 #if defined(_WIN32)
-        if (c->options.block_outside_dns)
+        /* Fortify 'redirect-gateway block-local' with firewall rules? */
+        bool block_local =3D do_block_local(c->c1.route_list);
+
+        if (c->options.block_outside_dns || block_local)
         {
-            dmsg(D_LOW, "Blocking outside DNS");
-            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options=
.msg_channel))
+            BOOL dns_only =3D !block_local;
+            if (!win_wfp_block(c->c1.tuntap->adapter_index, c->options.msg=
_channel, dns_only))
             {
-                msg(M_FATAL, "Blocking DNS failed!");
+                msg(M_FATAL, "WFP: blocking failed!");
             }
         }
 #endif
@@ -1965,12 +1968,15 @@
                         c->c2.es);
         }
 #if defined(_WIN32)
-        if (c->options.block_outside_dns)
+        /* Fortify 'redirect-gateway block-local' with firewall rules? */
+        bool block_local =3D do_block_local(c->c1.route_list);
+
+        if (c->options.block_outside_dns || block_local)
         {
-            dmsg(D_LOW, "Blocking outside DNS");
-            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options=
.msg_channel))
+            BOOL dns_only =3D !block_local;
+            if (!win_wfp_block(c->c1.tuntap->adapter_index, c->options.msg=
_channel, dns_only))
             {
-                msg(M_FATAL, "Blocking DNS failed!");
+                msg(M_FATAL, "WFP: blocking failed!");
             }
         }
 #endif
@@ -2093,7 +2099,7 @@
                     c->c2.es);

 #if defined(_WIN32)
-        if (c->options.block_outside_dns)
+        if (c->options.block_outside_dns || do_block_local(c->c1.route_lis=
t))
         {
             if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
             {
@@ -2132,7 +2138,7 @@
         }

 #if defined(_WIN32)
-        if (c->options.block_outside_dns)
+        if (c->options.block_outside_dns || do_block_local(c->c1.route_lis=
t))
         {
             if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
             {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6c027d9..19457ea 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -25,6 +25,7 @@
  * Support routines for adding/deleting network routes.
  */
 #include <stddef.h>
+#include <stdbool.h>

 #ifdef HAVE_CONFIG_H
 #include "config.h"
@@ -74,7 +75,13 @@

 #endif

-static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, un=
signed int flags, const struct route_gateway_info *rgi, const struct env_se=
t *es, openvpn_net_ctx_t *ctx);
+static bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsig=
ned int flags,
+                      const struct route_gateway_info *rgi, const struct e=
nv_set *es,
+                      openvpn_net_ctx_t *ctx);
+
+static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, un=
signed int flags,
+                         const struct route_gateway_info *rgi, const struc=
t env_set *es,
+                         openvpn_net_ctx_t *ctx);

 static void get_bypass_addresses(struct route_bypass *rb, const unsigned i=
nt flags);

@@ -566,9 +573,7 @@
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
@@ -593,39 +598,41 @@
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
+    size_t i;
+    for (i =3D 0; i < rl->rgi.n_addrs; ++i)
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
@@ -698,7 +705,10 @@

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
@@ -1241,6 +1251,7 @@
         }
         rl6->iflags |=3D RL_ROUTES_ADDED;
     }
+
     return ret;
 }

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 71b4cf4..7112936 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -243,6 +243,18 @@
     struct iroute_ipv6 *next;
 };

+/**
+ * Get the decision whether to block traffic to local networks while the V=
PN
+ * is connected. This definatly returns false when not redirecting the gat=
eway
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
@@ -263,10 +275,6 @@

 void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt=
, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);

-bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int=
 flags,
-               const struct route_gateway_info *rgi, const struct env_set =
*es,
-               openvpn_net_ctx_t *ctx);
-
 void add_route_to_option_list(struct route_option_list *l,
                               const char *network,
                               const char *netmask,
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
similarity index 70%
rename from src/openvpn/block_dns.c
rename to src/openvpn/wfp_block.c
index 05b2599..f694924 100644
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
@@ -159,31 +169,36 @@
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
+    /* Third filter. Block IPv4 to port 53 or all besided loopback. */
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
+    /* Forth filter. Block IPv6 to port 53 or all besides loopback */
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
=20
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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--RykBHYKWIXQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Windows: enforce &#39;block-local&#39; with WFP filters<br><b=
r>In an attempt to better defend against the TunnelCrack attacks, enforce<b=
r>that no traffic can pass to anything else than the VPN interface when<br>=
the &#39;block-local&#39; flags is given with either --redirect-gateway or<=
br>--redirect-private.<br><br>Reuse much of the existing --block-outside-dn=
s code, but make it more<br>general, so that it can also block any traffic,=
 not just port 53.<br><br>Uses the Windows Filtering Platform for enforceme=
nt in addition to the<br>routes redirecting the networks into the tunnel.<b=
r><br>Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba<br>Signed-off-by=
: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M CMakeLists.txt<br>M doc/m=
an-sections/vpn-network-options.rst<br>M include/openvpn-msg.h<br>M src/ope=
nvpn/Makefile.am<br>M src/openvpn/init.c<br>M src/openvpn/route.c<br>M src/=
openvpn/route.h<br>M src/openvpn/tun.c<br>R src/openvpn/wfp_block.c<br>R sr=
c/openvpn/wfp_block.h<br>M src/openvpn/win32.c<br>M src/openvpn/win32.h<br>=
M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/Makefile.am<br>M src/=
openvpnserv/interactive.c<br>15 files changed, 299 insertions(+), 213 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/89/489/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br=
><span>index bc46c27..e560ef3 100644</span><br><span>--- a/CMakeLists.txt</=
span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -352,8 +352,6 @@</sp=
an><br><span>     src/openvpn/base64.c</span><br><span>     src/openvpn/bas=
e64.h</span><br><span>     src/openvpn/basic.h</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    src/openvpn/block_dns.h</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/block_dns.c</span><br><span=
>     src/openvpn/buffer.c</span><br><span>     src/openvpn/buffer.h</span>=
<br><span>     src/openvpn/circ_list.h</span><br><span>@@ -533,6 +531,8 @@<=
/span><br><span>     src/openvpn/ssl_util.h</span><br><span>     src/openvp=
n/vlan.c</span><br><span>     src/openvpn/vlan.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    src/openvpn/wfp_block.c</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/wfp_block.h</span><br>=
<span>     src/openvpn/win32.c</span><br><span>     src/openvpn/win32-util.=
c</span><br><span>     src/openvpn/win32.h</span><br><span>diff --git a/doc=
/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-option=
s.rst</span><br><span>index 41d367b..630e8f5 100644</span><br><span>--- a/d=
oc/man-sections/vpn-network-options.rst</span><br><span>+++ b/doc/man-secti=
ons/vpn-network-options.rst</span><br><span>@@ -352,6 +352,9 @@</span><br><=
span>       Block access to local LAN when the tunnel is active, except for=
</span><br><span>       the LAN gateway itself. This is accomplished by rou=
ting the local</span><br><span>       LAN (except for the LAN gateway addre=
ss) into the tunnel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      On Windows WFP filters are added in addition to the routes which</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      block access to r=
esources not routed through the VPN adapter.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      Push this flag to defend against the TunnelC=
rack attacks.</span><br><span> </span><br><span>   :code:`ipv6`</span><br><=
span>       Redirect IPv6 routing into the tunnel. This works similar to</s=
pan><br><span>diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h</s=
pan><br><span>index a1464cd..0fa0cb5 100644</span><br><span>--- a/include/o=
penvpn-msg.h</span><br><span>+++ b/include/openvpn-msg.h</span><br><span>@@=
 -24,6 +24,9 @@</span><br><span> #ifndef OPENVPN_MSG_H_</span><br><span> #d=
efine OPENVPN_MSG_H_</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;windef.h&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;ws2tcpip.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef enum {</span><b=
r><span>     msg_acknowledgement,</span><br><span>     msg_add_address,</sp=
an><br><span>@@ -35,8 +38,8 @@</span><br><span>     msg_add_nbt_cfg,</span>=
<br><span>     msg_del_nbt_cfg,</span><br><span>     msg_flush_neighbors,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_add_block_dns,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_del_block_dns,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_add_wfp_blo=
ck,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_del_wfp_=
block,</span><br><span>     msg_register_dns,</span><br><span>     msg_enab=
le_dhcp,</span><br><span>     msg_register_ring_buffers,</span><br><span>@@=
 -61,6 +64,11 @@</span><br><span>     char name[256];</span><br><span> } in=
terface_t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef enum {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    wfp_block_local =3D 1&lt;&lt;0,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    wfp_block_dns =3D 1&lt;&lt;1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+} wfp_block_flags_t;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef struct {</span=
><br><span>     message_header_t header;</span><br><span>     short family;=
</span><br><span>@@ -120,8 +128,9 @@</span><br><span> </span><br><span> typ=
edef struct {</span><br><span>     message_header_t header;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_flags_t flags;</span>=
<br><span>     interface_t iface;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-} block_dns_message_t;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+} wfp_block_message_t;</span><br><span> </span><br><span> ty=
pedef struct {</span><br><span>     message_header_t header;</span><br><spa=
n>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br>=
<span>index b953961..6bf3862 100644</span><br><span>--- a/src/openvpn/Makef=
ile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -15=
6,6 +156,6 @@</span><br><span> 	$(OPTIONAL_DL_LIBS) \</span><br><span> 	$(O=
PTIONAL_INOTIFY_LIBS)</span><br><span> if WIN32</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-openvpn_SOURCES +=3D openvpn_win32_resources.rc b=
lock_dns.c block_dns.h ring_buffer.h</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+openvpn_SOURCES +=3D openvpn_win32_resources.rc wfp_block.=
c wfp_block.h ring_buffer.h</span><br><span> openvpn_LDADD +=3D -lgdi32 -lw=
s2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -=
lsetupapi -lbcrypt</span><br><span> endif</span><br><span>diff --git a/src/=
openvpn/init.c b/src/openvpn/init.c</span><br><span>index 9e2b3845..4108e8c=
 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/=
openvpn/init.c</span><br><span>@@ -1916,12 +1916,15 @@</span><br><span>    =
                 c-&gt;c2.es);</span><br><span> </span><br><span> #if defin=
ed(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(c-&gt;options.block_outside_dns)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* Fortify &#39;redirect-gateway block-local&#39; wit=
h firewall rules? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        bool block_local =3D do_block_local(c-&gt;c1.route_list);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (c-&gt;options.block_outside_dns || =
block_local)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            dmsg(D_LOW, &quot;Blocking outside DNS&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!win=
_wfp_block_dns(c-&gt;c1.tuntap-&gt;adapter_index, c-&gt;options.msg_channel=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            BOOL =
dns_only =3D !block_local;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (!win_wfp_block(c-&gt;c1.tuntap-&gt;adapter_index, c-=
&gt;options.msg_channel, dns_only))</span><br><span>             {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_FATAL, &=
quot;Blocking DNS failed!&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                msg(M_FATAL, &quot;WFP: blocking failed!&quot=
;);</span><br><span>             }</span><br><span>         }</span><br><sp=
an> #endif</span><br><span>@@ -1965,12 +1968,15 @@</span><br><span>        =
                 c-&gt;c2.es);</span><br><span>         }</span><br><span> =
#if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (c-&gt;options.block_outside_dns)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Fortify &#39;redirect-gateway block-local=
&#39; with firewall rules? */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        bool block_local =3D do_block_local(c-&gt;c1.route_list);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;options.block_outsid=
e_dns || block_local)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            dmsg(D_LOW, &quot;Blocking outside D=
NS&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (!win_wfp_block_dns(c-&gt;c1.tuntap-&gt;adapter_index, c-&gt;options.ms=
g_channel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    BOOL dns_only =3D !block_local;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (!win_wfp_block(c-&gt;c1.tuntap-&gt;adapter_=
index, c-&gt;options.msg_channel, dns_only))</span><br><span>             {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M=
_FATAL, &quot;Blocking DNS failed!&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                msg(M_FATAL, &quot;WFP: blocking fai=
led!&quot;);</span><br><span>             }</span><br><span>         }</spa=
n><br><span> #endif</span><br><span>@@ -2093,7 +2099,7 @@</span><br><span> =
                    c-&gt;c2.es);</span><br><span> </span><br><span> #if de=
fined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (c-&gt;options.block_outside_dns)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (c-&gt;options.block_outside_dns || do_block_lo=
cal(c-&gt;c1.route_list))</span><br><span>         {</span><br><span>      =
       if (!win_wfp_uninit(adapter_index, c-&gt;options.msg_channel))</span=
><br><span>             {</span><br><span>@@ -2132,7 +2138,7 @@</span><br><=
span>         }</span><br><span> </span><br><span> #if defined(_WIN32)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options.=
block_outside_dns)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (c-&gt;options.block_outside_dns || do_block_local(c-&gt;c1.route=
_list))</span><br><span>         {</span><br><span>             if (!win_wf=
p_uninit(adapter_index, c-&gt;options.msg_channel))</span><br><span>       =
      {</span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/rout=
e.c</span><br><span>index 6c027d9..19457ea 100644</span><br><span>--- a/src=
/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>=
@@ -25,6 +25,7 @@</span><br><span>  * Support routines for adding/deleting =
network routes.</span><br><span>  */</span><br><span> #include &lt;stddef.h=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;st=
dbool.h&gt;</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><=
br><span> #include &quot;config.h&quot;</span><br><span>@@ -74,7 +75,13 @@<=
/span><br><span> </span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static void delete_route(struct route=
_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_g=
ateway_info *rgi, const struct env_set *es, openvpn_net_ctx_t *ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static bool add_route(stru=
ct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                      const stru=
ct route_gateway_info *rgi, const struct env_set *es,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      openvpn_net_ctx_t *=
ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void delete_route(struct r=
oute_ipv4 *r, const struct tuntap *tt, unsigned int flags,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                         const struc=
t route_gateway_info *rgi, const struct env_set *es,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         openvpn_net_ctx_=
t *ctx);</span><br><span> </span><br><span> static void get_bypass_addresse=
s(struct route_bypass *rb, const unsigned int flags);</span><br><span> </sp=
an><br><span>@@ -566,9 +573,7 @@</span><br><span>                      cons=
t struct route_gateway_address *gateway,</span><br><span>                  =
    in_addr_t target)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMA=
SK_DEFINED);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((=
rl-&gt;rgi.flags &amp; rgi_needed) =3D=3D rgi_needed</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; rl-&gt;rgi.gateway.netma=
sk &lt; 0xFFFFFFFF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (rl-&gt;rgi.gateway.netmask &lt; 0xFFFFFFFF)</span><br><span>     {<=
/span><br><span>         struct route_ipv4 *r1, *r2;</span><br><span>      =
   unsigned int l2;</span><br><span>@@ -593,39 +598,41 @@</span><br><span> =
}</span><br><span> </span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-add_block_local(struct route_list *rl)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+add_block_local_routes(struct=
 route_list *rl)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DE=
FINED);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((rl-&g=
t;flags &amp; RG_BLOCK_LOCAL)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        &amp;&amp; (rl-&gt;rgi.flags &amp; rgi_needed) =3D=3D rgi_n=
eeded</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&am=
p; (rl-&gt;spec.flags &amp; RTSA_REMOTE_ENDPOINT)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        &amp;&amp; rl-&gt;spec.remote_host_loca=
l !=3D TLA_LOCAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        size_t i;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifnde=
f TARGET_ANDROID</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /* add bypass for gateway addr */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        add_bypass_address(&amp;rl-&gt;spec.bypass, rl-&gt;r=
gi.gateway.addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* add bypass for gateway addr */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    add_bypass_address(&amp;rl-&gt;spec.bypass, rl-&gt;rgi.=
gateway.addr);</span><br><span> #endif</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        /* block access to local subnet =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_block_l=
ocal_item(rl, &amp;rl-&gt;rgi.gateway, rl-&gt;spec.remote_endpoint);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* block access to loc=
al subnet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add=
_block_local_item(rl, &amp;rl-&gt;rgi.gateway, rl-&gt;spec.remote_endpoint)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* process additional subnets on gateway interface */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; rl-&gt;r=
gi.n_addrs; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* process additional subnets on gateway interface */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t i;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; rl-&gt;rgi.n_addrs; +=
+i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const struct route_gat=
eway_address *gwa =3D &amp;rl-&gt;rgi.addrs[i];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* omit the add/subnet in &amp;rl-&gt;r=
gi which we processed above */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!((rl-&gt;rgi.gateway.addr &amp; rl-&gt;rgi.gateway.=
netmask) =3D=3D (gwa-&gt;addr &amp; gwa-&gt;netmask)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              &amp;&amp; rl-&gt;rgi.gatew=
ay.netmask =3D=3D gwa-&gt;netmask))</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            const struct route_gat=
eway_address *gwa =3D &amp;rl-&gt;rgi.addrs[i];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            /* omit the add/subnet in &amp;rl-&gt=
;rgi which we processed above */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (!((rl-&gt;rgi.gateway.addr &amp; rl-&gt;rgi.gate=
way.netmask) =3D=3D (gwa-&gt;addr &amp; gwa-&gt;netmask)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                  &amp;&amp; rl-&gt;rgi.=
gateway.netmask =3D=3D gwa-&gt;netmask))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                add_block_local_item(rl, gwa, rl-&gt;spec.remote=
_endpoint);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            add_=
block_local_item(rl, gwa, rl-&gt;spec.remote_endpoint);</span><br><span>   =
      }</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_bl=
ock_local(const struct route_list *rl)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const int rgi_needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (rl-&gt;flags =
&amp; RG_BLOCK_LOCAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+           &amp;&amp; (rl-&gt;rgi.flags &amp; rgi_needed) =3D=3D rgi_need=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&=
amp; (rl-&gt;spec.flags &amp; RTSA_REMOTE_ENDPOINT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; rl-&gt;spec.remote_=
host_local !=3D TLA_LOCAL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> init_rou=
te_list(struct route_list *rl,</span><br><span>                 const struc=
t route_option_list *opt,</span><br><span>                 const char *remo=
te_endpoint,</span><br><span>@@ -698,7 +705,10 @@</span><br><span> </span><=
br><span>     if (rl-&gt;flags &amp; RG_ENABLE)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_block_local(rl=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (do_bl=
ock_local(rl))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            add=
_block_local_routes(rl);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>         get_bypass_addresses(&amp;rl-&gt;sp=
ec.bypass, rl-&gt;flags);</span><br><span> #ifdef ENABLE_DEBUG</span><br><s=
pan>         print_bypass_addresses(&amp;rl-&gt;spec.bypass);</span><br><sp=
an>@@ -1241,6 +1251,7 @@</span><br><span>         }</span><br><span>       =
  rl6-&gt;iflags |=3D RL_ROUTES_ADDED;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return ret;=
</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/open=
vpn/route.h b/src/openvpn/route.h</span><br><span>index 71b4cf4..7112936 10=
0644</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/op=
envpn/route.h</span><br><span>@@ -243,6 +243,18 @@</span><br><span>     str=
uct iroute_ipv6 *next;</span><br><span> };</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Get the decision whether to block traffic to lo=
cal networks while the VPN</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * is connected. This definatly returns false when not redirecting t=
he gateway</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * or whe=
n the &#39;block-local&#39; flag is not set. Also checks for other</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * prerequisites to redirect=
 local networks into the tunnel.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param rl const pointer to the struct route_list to base the decision on.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return boolean indicating whether l=
ocal traffic should be blocked.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 do_block_local(const struct route_list *rl);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> struct route_option_list *new_r=
oute_option_list(struct gc_arena *a);</span><br><span> </span><br><span> st=
ruct route_ipv6_option_list *new_route_ipv6_option_list(struct gc_arena *a)=
;</span><br><span>@@ -263,10 +275,6 @@</span><br><span> </span><br><span> v=
oid delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, =
unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool add=
_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-               const st=
ruct route_gateway_info *rgi, const struct env_set *es,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-               openvpn_net_ctx_t *ctx);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void =
add_route_to_option_list(struct route_option_list *l,</span><br><span>     =
                          const char *network,</span><br><span>            =
                   const char *netmask,</span><br><span>diff --git a/src/op=
envpn/tun.c b/src/openvpn/tun.c</span><br><span>index 8e96149..aa78c23 1006=
44</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvp=
n/tun.c</span><br><span>@@ -44,7 +44,7 @@</span><br><span> #include &quot;m=
anage.h&quot;</span><br><span> #include &quot;route.h&quot;</span><br><span=
> #include &quot;win32.h&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;block_dns.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;wfp_block.h&quot;</span><br><span> #in=
clude &quot;networking.h&quot;</span><br><span> </span><br><span> #include =
&quot;memdbg.h&quot;</span><br><span>diff --git a/src/openvpn/block_dns.c b=
/src/openvpn/wfp_block.c</span><br><span>similarity index 70%</span><br><sp=
an>rename from src/openvpn/block_dns.c</span><br><span>rename to src/openvp=
n/wfp_block.c</span><br><span>index 05b2599..f694924 100644</span><br><span=
>--- a/src/openvpn/block_dns.c</span><br><span>+++ b/src/openvpn/wfp_block.=
c</span><br><span>@@ -37,7 +37,8 @@</span><br><span> #include &lt;winsock2.=
h&gt;</span><br><span> #include &lt;ws2ipdef.h&gt;</span><br><span> #includ=
e &lt;iphlpapi.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
include &quot;block_dns.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;wfp_block.h&quot;</span><br><span> </span><br><span> /*</span><br><=
span>  * WFP-related defines and GUIDs not in mingw32</span><br><span>@@ -9=
2,10 +93,19 @@</span><br><span>     0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x9=
0, 0xa4</span><br><span>     );</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* 632ce23b-5167-435c-86d7-e903684aa80c */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+DEFINE_GUID(</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    FWPM_CONDITION_FLAGS,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x632ce23b,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    0x5167,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    0x435c,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    0x86, 0xd7, 0xe9, 0x03, 0x68, 0x4a, 0=
xa8, 0x0c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    );</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* UU=
ID of WFP sublayer used by all instances of openvpn</span><br><span>  * 2f6=
60d7e-6a37-11e6-a181-001e8c6e04a2 */</span><br><span> DEFINE_GUID(</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    OPENVPN_BLOCK_OUTSIDE_DNS_=
SUBLAYER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OPENVP=
N_WFP_BLOCK_SUBLAYER,</span><br><span>     0x2f660d7e,</span><br><span>    =
 0x6a37,</span><br><span>     0x11e6,</span><br><span>@@ -113,7 +123,7 @@</=
span><br><span>     return;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define CHECK_ERROR(err, msg) \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OUT_ON_ERROR=
(err, msg) \</span><br><span>     if (err) { msg_handler(err, msg); goto ou=
t; }</span><br><span> </span><br><span> /*</span><br><span>@@ -159,31 +169,=
36 @@</span><br><span>  * OR</span><br><span>  * (ii) processes with the sp=
ecified executable path</span><br><span>  * The firewall filters added here=
 are automatically removed when the process exits or</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * on calling delete_block_dns_filters().</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on calling delete_=
wfp_block_filters().</span><br><span>  * Arguments:</span><br><span>  *   e=
ngine_handle : On successful return contains the handle for a newly opened =
fwp session</span><br><span>  *                   in which the filters are =
added.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             =
      May be closed by passing to delete_block_dns_filters to remove the fi=
lters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
        May be closed by passing to delete_wfp_block_filters to remove the =
filters.</span><br><span>  *   index         : The index of adapter for whi=
ch traffic is permitted.</span><br><span>  *   exe_path      : Path of exec=
utable for which traffic is permitted.</span><br><span>  *   msg_handler   =
: An optional callback function for error reporting.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   dns_only      : Whether the blocking=
 filters should apply for DNS only.</span><br><span>  * Returns 0 on succes=
s, a non-zero status code of the last failed action on failure.</span><br><=
span>  */</span><br><span> </span><br><span> DWORD</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-add_block_dns_filters(HANDLE *engine_handle,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block_filters=
(HANDLE *engine_handle,</span><br><span>                       int index,</=
span><br><span>                       const WCHAR *exe_path,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                      block_dns_msg_=
handler_t msg_handler</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                      )</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                      wfp_block_msg_handler_t msg_handler,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                      BOOL dns_o=
nly)</span><br><span> {</span><br><span>     FWPM_SESSION0 session =3D {0};=
</span><br><span>     FWPM_SUBLAYER0 *sublayer_ptr =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    NET_LUID tapluid;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    NET_LUID itf_luid;</span><br><=
span>     UINT64 filterid;</span><br><span>     FWP_BYTE_BLOB *openvpnblob =
=3D NULL;</span><br><span>     FWPM_FILTER0 Filter =3D {0};</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    FWPM_FILTER_CONDITION0 Condition[=
2] =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FWPM=
_FILTER_CONDITION0 Condition[2];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    FWPM_FILTER_CONDITION0 match_openvpn =3D {0};</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    FWPM_FILTER_CONDITION0 match=
_port_53 =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  FWPM_FILTER_CONDITION0 match_interface =3D {0};</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    FWPM_FILTER_CONDITION0 match_not_loopback=
 =3D {0};</span><br><span>     DWORD err =3D 0;</span><br><span> </span><br=
><span>     if (!msg_handler)</span><br><span>@@ -197,116 +212,127 @@</span=
><br><span>     *engine_handle =3D NULL;</span><br><span> </span><br><span>=
     err =3D FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &amp;session, e=
ngine_handle);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CHE=
CK_ERROR(err, &quot;FwpEngineOpen: open fwp session failed&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg_handler(0, &quot;Block=
_DNS: WFP engine opened&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OUT_ON_ERROR(err, &quot;FwpEngineOpen: open fwp session fai=
led&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_=
handler(0, &quot;WFP Block: WFP engine opened&quot;);</span><br><span> </sp=
an><br><span>     /* Check sublayer exists and add one if it does not. */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (FwpmSubLayerGet=
ByKey0(*engine_handle, &amp;OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER, &amp;sublay=
er_ptr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (Fwpm=
SubLayerGetByKey0(*engine_handle, &amp;OPENVPN_WFP_BLOCK_SUBLAYER, &amp;sub=
layer_ptr)</span><br><span>         =3D=3D ERROR_SUCCESS)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg_hand=
ler(0, &quot;Block_DNS: Using existing sublayer&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg_handler(0, &quot;WFP Block:=
 Using existing sublayer&quot;);</span><br><span>         FwpmFreeMemory0((=
void **)&amp;sublayer_ptr);</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {  /* Add a new sublayer -- as another process may a=
dd it in the meantime,</span><br><span>         * do not treat &quot;alread=
y exists&quot; as an error */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        err =3D add_sublayer(OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D add_s=
ublayer(OPENVPN_WFP_BLOCK_SUBLAYER);</span><br><span> </span><br><span>    =
     if (err =3D=3D FWP_E_ALREADY_EXISTS || err =3D=3D ERROR_SUCCESS)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg_handler(0, &quot;Block_DNS: Added a persistent sublayer wit=
h pre-defined UUID&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg_handler(0, &quot;WFP Block: Added a persistent subla=
yer with pre-defined UUID&quot;);</span><br><span>         }</span><br><spa=
n>         else</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            CHECK_ERROR(err, &quot;add_sublayer: faile=
d to add persistent sublayer&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            OUT_ON_ERROR(err, &quot;add_sublayer: failed t=
o add persistent sublayer&quot;);</span><br><span>         }</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    err =3D ConvertInterfaceIndexToLuid(index, &amp;tapluid);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    CHECK_ERROR(err, &quot;Con=
vert interface index to luid failed&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    err =3D ConvertInterfaceIndexToLuid(index, &amp=
;itf_luid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_=
ON_ERROR(err, &quot;Convert interface index to luid failed&quot;);</span><b=
r><span> </span><br><span>     err =3D FwpmGetAppIdFromFileName0(exe_path, =
&amp;openvpnblob);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 CHECK_ERROR(err, &quot;Get byte blob for openvpn executable name failed&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERR=
OR(err, &quot;Get byte blob for openvpn executable name failed&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Prepare match conditions */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    match_openvpn.fieldKey=
 =3D FWPM_CONDITION_ALE_APP_ID;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    match_openvpn.matchType =3D FWP_MATCH_EQUAL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    match_openvpn.conditionValue.t=
ype =3D FWP_BYTE_BLOB_TYPE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    match_openvpn.conditionValue.byteBlob =3D openvpnblob;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    match_port_53.fieldKey =3D FWPM_CONDITION_I=
P_REMOTE_PORT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
atch_port_53.matchType =3D FWP_MATCH_EQUAL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    match_port_53.conditionValue.type =3D FWP_UINT1=
6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    match_port_53=
.conditionValue.uint16 =3D 53;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    matc=
h_interface.fieldKey =3D FWPM_CONDITION_IP_LOCAL_INTERFACE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    match_interface.matchType =3D F=
WP_MATCH_EQUAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
match_interface.conditionValue.type =3D FWP_UINT64;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    match_interface.conditionValue.uint64=
 =3D &amp;itf_luid.Value;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    match_not=
_loopback.fieldKey =3D FWPM_CONDITION_FLAGS;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    match_not_loopback.matchType =3D FWP_MATCH_FLA=
GS_NONE_SET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mat=
ch_not_loopback.conditionValue.type =3D FWP_UINT32;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    match_not_loopback.conditionValue.uin=
t32 =3D FWP_CONDITION_FLAG_IS_LOOPBACK;</span><br><span> </span><br><span> =
    /* Prepare filter. */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    Filter.subLayerKey =3D OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    Filter.subLayerKey =3D O=
PENVPN_WFP_BLOCK_SUBLAYER;</span><br><span>     Filter.displayData.name =3D=
 FIREWALL_NAME;</span><br><span>     Filter.weight.type =3D FWP_UINT8;</spa=
n><br><span>     Filter.weight.uint8 =3D 0xF;</span><br><span>     Filter.f=
ilterCondition =3D Condition;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    Filter.numFilterConditions =3D 2;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    Filter.numFilterConditions =3D 1;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* First fi=
lter. Permit IPv4 DNS queries from OpenVPN itself. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* First filter. Permit IPv4 from Ope=
nVPN itself. */</span><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AUT=
H_CONNECT_V4;</span><br><span>     Filter.action.type =3D FWP_ACTION_PERMIT=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    Condition[0].fieldKey =3D FWPM_CONDIT=
ION_IP_REMOTE_PORT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  Condition[0].matchType =3D FWP_MATCH_EQUAL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    Condition[0].conditionValue.type =3D FWP_UINT16=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[0].con=
ditionValue.uint16 =3D 53;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[1]=
.fieldKey =3D FWPM_CONDITION_ALE_APP_ID;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    Condition[1].matchType =3D FWP_MATCH_EQUAL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[1].conditionValu=
e.type =3D FWP_BYTE_BLOB_TYPE;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    Condition[1].conditionValue.byteBlob =3D openvpnblob;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    Condition[0] =3D match_openvpn;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (dns_only)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        Filter.numFilterConditions =3D 2;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        Condition[1] =3D ma=
tch_port_53;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span>     err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NUL=
L, &amp;filterid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 CHECK_ERROR(err, &quot;Add filter to permit IPv4 port 53 traffic from Open=
VPN failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OUT_ON_ERROR(err, &quot;Add filter to permit IPv4 traffic from OpenVPN f=
ailed&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /* Second filter. Permit IPv6 DNS queries from OpenVPN itself=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Second f=
ilter. Permit IPv6 from OpenVPN itself. */</span><br><span>     Filter.laye=
rKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span>     err =3D FwpmFilterAdd0(*engine_han=
dle, &amp;Filter, NULL, &amp;filterid);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    CHECK_ERROR(err, &quot;Add filter to permit IPv6 port=
 53 traffic from OpenVPN failed&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    OUT_ON_ERROR(err, &quot;Add filter to permit IPv6 t=
raffic from OpenVPN failed&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg_handler(0, &quot;Block_DNS: Added p=
ermit filters for exe_path&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg_handler(0, &quot;WFP Block: Added permit filters for=
 exe_path&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* Third filter. Block all IPv4 DNS queries. */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Third filter. Block IP=
v4 to port 53 or all besided loopback. */</span><br><span>     Filter.layer=
Key =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span><br><span>     Filter.action.=
type =3D FWP_ACTION_BLOCK;</span><br><span>     Filter.weight.type =3D FWP_=
EMPTY;</span><br><span>     Filter.numFilterConditions =3D 1;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    Condition[0] =3D dns_only ? match_port_53 : match_=
not_loopback;</span><br><span>     err =3D FwpmFilterAdd0(*engine_handle, &=
amp;Filter, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    CHECK_ERROR(err, &quot;Add filter to block IPv4 DNS traffic=
 failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OUT_ON_ERROR(err, &quot;Add filter to block IPv4 traffic failed&quot;);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
Forth filter. Block all IPv6 DNS queries. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Forth filter. Block IPv6 to port 53 or all =
besides loopback */</span><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE=
_AUTH_CONNECT_V6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL,=
 &amp;filterid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    C=
HECK_ERROR(err, &quot;Add filter to block IPv6 DNS traffic failed&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OUT_ON_ERROR(err,=
 &quot;Add filter to block IPv6 traffic failed&quot;);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_handler(0, &quot=
;Block_DNS: Added block filters for all interfaces&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg_handler(0, &quot;WFP Block: =
Added block filters for all interfaces&quot;);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* Fifth filter. Permit IPv4=
 DNS queries from TAP.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Fifth filter. Permit IPv4 for the VPN interface.</span><br><span>=
      * Use a non-zero weight so that the permit filters get higher priorit=
y</span><br><span>      * over the block filter added with automatic weight=
ing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>     Filter.weight.type =3D FWP_UINT8;</span><br><span>     Filter.weight=
.uint8 =3D 0xE;</span><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AUT=
H_CONNECT_V4;</span><br><span>     Filter.action.type =3D FWP_ACTION_PERMIT=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter.numFilter=
Conditions =3D 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[1].fieldKey=
 =3D FWPM_CONDITION_IP_LOCAL_INTERFACE;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    Condition[1].matchType =3D FWP_MATCH_EQUAL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    Condition[1].conditionValue=
.type =3D FWP_UINT64;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    Condition[1].conditionValue.uint64 =3D &amp;tapluid.Value;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    Filter.numFilterConditions =3D 1;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    Condition[0] =3D match_interfac=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dns_only)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        Filter.numFilterCondition=
s =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Con=
dition[1] =3D match_port_53;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span>     err =3D FwpmFilterAdd0(*engine_handle, =
&amp;Filter, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    CHECK_ERROR(err, &quot;Add filter to permit IPv4 DNS traff=
ic through TAP failed&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OUT_ON_ERROR(err, &quot;Add filter to permit IPv4 traffic thr=
ough VPN interface failed&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Sixth filter. Permit IPv6 DNS querie=
s from TAP.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* S=
ixth filter. Permit IPv6 for the VPN interface.</span><br><span>      * Use=
 same weight as IPv4 filter */</span><br><span>     Filter.layerKey =3D FWP=
M_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     err =3D FwpmFilterAdd0(*engine_handle, &amp;Fi=
lter, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    CHECK_ERROR(err, &quot;Add filter to permit IPv6 DNS traffic thro=
ugh TAP failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OUT_ON_ERROR(err, &quot;Add filter to permit IPv6 traffic through VP=
N interface failed&quot;);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    msg_handler(0, &quot;Block_DNS: Added permit fil=
ters for TAP interface&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg_handler(0, &quot;WFP Block: Added permit filters for VPN=
 interface&quot;);</span><br><span> </span><br><span> out:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (openvpnblob)=
</span><br><span>     {</span><br><span>         FwpmFreeMemory0((void **)&=
amp;openvpnblob);</span><br><span>@@ -322,7 +348,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> DWORD</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-delete_block_dns_filters(HANDLE engine_handle)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+delete_wfp_block_filters(HANDLE=
 engine_handle)</span><br><span> {</span><br><span>     DWORD err =3D 0;</s=
pan><br><span>     /*</span><br><span>diff --git a/src/openvpn/block_dns.h =
b/src/openvpn/wfp_block.h</span><br><span>similarity index 83%</span><br><s=
pan>rename from src/openvpn/block_dns.h</span><br><span>rename to src/openv=
pn/wfp_block.h</span><br><span>index 89b88d6..60c9171 100644</span><br><spa=
n>--- a/src/openvpn/block_dns.h</span><br><span>+++ b/src/openvpn/wfp_block=
.h</span><br><span>@@ -23,20 +23,24 @@</span><br><span> </span><br><span> #=
ifdef _WIN32</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifndef OPENVPN_BLOCK_DNS_H</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define OPENVPN_BLOCK_DNS_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifndef WFP_BLOCK_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define WFP_BLOCK_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;windef.h&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;iphlpapi.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;ws2tcpip.h&gt;</span><br><span> </span><br><=
span> /* Any value less than 5 should work fine. 3 is chosen without any re=
al reason. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
BLOCK_DNS_IFACE_METRIC 3</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define WFP_BLOCK_IFACE_METRIC 3</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-typedef void (*block_dns_msg_handler_t) (=
DWORD err, const char *msg);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef void (*wfp_block_msg_handler_t) (DWORD err, const char *ms=
g);</span><br><span> </span><br><span> DWORD</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-delete_block_dns_filters(HANDLE engine);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+delete_wfp_block_filters(HANDLE=
 engine);</span><br><span> </span><br><span> DWORD</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-add_block_dns_filters(HANDLE *engine, int ifac=
e_index, const WCHAR *exe_path,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                      block_dns_msg_handler_t msg_handler_callbac=
k);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_wfp_block_fi=
lters(HANDLE *engine, int iface_index, const WCHAR *exe_path,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                      wfp_block_m=
sg_handler_t msg_handler_callback, BOOL dns_only);</span><br><span> </span>=
<br><span> /**</span><br><span>  * Return interface metric value for the sp=
ecified interface index.</span><br><span>@@ -65,5 +69,5 @@</span><br><span>=
 set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,=
</span><br><span>                      const ULONG metric);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef OP=
ENVPN_BLOCK_DNS_H */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* ifndef WFP_BLOCK_H */</span><br><span> #endif /* ifdef _WIN32 */=
</span><br><span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</sp=
an><br><span>index 6b7ba5e..9d08554 100644</span><br><span>--- a/src/openvp=
n/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -34,=
6 +34,9 @@</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;minw=
indef.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;winsock2.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> #include &quot;buffer.h&quot;</span><br><span> #include &=
quot;error.h&quot;</span><br><span> #include &quot;mtu.h&quot;</span><br><s=
pan>@@ -47,7 +50,7 @@</span><br><span> </span><br><span> #include &lt;versi=
onhelpers.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#include &quot;block_dns.h&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;wfp_block.h&quot;</span><br><span> =
</span><br><span> /*</span><br><span>  * WFP handle</span><br><span>@@ -113=
8,43 +1141,19 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-win_block_dns_=
service(bool add, int index, const HANDLE pipe)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+win_get_exe_path(PWCHAR path, DWORD size)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool=
 ret =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ac=
k_message_t ack;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    block_d=
ns_message_t data =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        .header =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            (add ? msg_add_block_dns : msg_del_block_dns),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            sizeof(block_dns_message=
_t),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            0</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        },</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        .iface =3D { .index =3D inde=
x, .name =3D &quot;&quot; }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!send_msg_iservice(pip=
e, &amp;data, sizeof(data), &amp;ack, &quot;Block_DNS&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    DWORD status =3D GetModuleFil=
eNameW(NULL, path, size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (status =3D=3D 0 || status =3D=3D size)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN|M_ER=
RNO, &quot;cannot get executable path&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (ack.error_number !=3D NO_ERROR)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Block_DNS: %s blo=
ck dns filters using service failed: %s [status=3D0x%x if_index=3D%d]&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            (add ? &=
quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack.error_number,=
 &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 ack.error_number, data.iface.index);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        goto out;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_INFO, &quot;%s outs=
ide dns using service succeeded.&quot;, (add ? &quot;Blocking&quot; : &quot=
;Unblocking&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-o=
ut:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-block_dns_msg_handler(DWORD err, con=
st char *msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+win_wf=
p_msg_handler(DWORD err, const char *msg)</span><br><span> {</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@=
@ -1184,15 +1163,52 @@</span><br><span>     }</span><br><span>     else</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(M_WARN, &quot;Error in add_block_dns_filters(): %s : %s [status=
=3D0x%lx]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_WARN, &quot;Error in WFP: %s : %s [status=3D0x%lx]&quot;,</span>=
<br><span>             msg, strerror_win32(err, &amp;gc), err);</span><br><=
span>     }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+win_wfp_block_service(bool add, bool dns_only, int index, const HANDLE p=
ipe)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ack_message_t ack;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_message_t data=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        .head=
er =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 (add ? msg_add_wfp_block : msg_del_wfp_block),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            sizeof(wfp_block_message_t),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        .flags =3D dns_only ? wfp_block_d=
ns : wfp_block_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        .iface =3D { .index =3D index, .name =3D &quot;&quot; }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!send_msg_iservice(pipe, &amp;data, sizeof(data), &a=
mp;ack, &quot;WFP block&quot;))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (ack.error_number !=3D NO_ERRO=
R)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WFP b=
lock: %s block filters using service failed: %s [status=3D0x%x if_index=3D%=
d]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  (add ? &quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack.err=
or_number, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            ack.error_number, data.iface.index);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
et =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(M_INFO, &quot;%s WFP block filters using service succeeded.&quot;, (add ? =
&quot;Adding&quot; : &quot;Deleting&quot;));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-win_wfp_b=
lock_dns(const NET_IFINDEX index, const HANDLE msg_channel)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+win_wfp_block(const NET_IFINDEX ind=
ex, const HANDLE msg_channel, BOOL dns_only)</span><br><span> {</span><br><=
span>     WCHAR openvpnpath[MAX_PATH];</span><br><span>     bool ret =3D fa=
lse;</span><br><span>@@ -1200,20 +1216,19 @@</span><br><span> </span><br><s=
pan>     if (msg_channel)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        dmsg(D_LOW, &quot;Using service to add b=
lock dns filters&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ret =3D win_block_dns_service(true, index, msg_channel);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_LOW, &quot;U=
sing service to add WFP block filters&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ret =3D win_wfp_block_service(true, dns_o=
nly, index, msg_channel);</span><br><span>         goto out;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    status =3D GetModuleFileNameW(NULL, openvpnpath, _countof(openvpnp=
ath));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status =
=3D=3D 0 || status =3D=3D _countof(openvpnpath))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ret =3D win_get_exe_path(openvpnpath, _cou=
ntof(openvpnpath));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (ret =3D=3D false)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(M_WARN|M_ERRNO, &quot;block_dns: can=
not get executable path&quot;);</span><br><span>         goto out;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    status =3D add_block_dns_filters(&amp;m_hEngineHandle, index=
, openvpnpath,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                            block_dns_msg_handler);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    status =3D add_wfp_block_filters(&amp=
;m_hEngineHandle, index, openvpnpath,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                   win_wfp_msg_handler, d=
ns_only);</span><br><span>     if (status =3D=3D 0)</span><br><span>     {<=
/span><br><span>         int is_auto =3D 0;</span><br><span>@@ -1227,10 +12=
42,10 @@</span><br><span>         {</span><br><span>             tap_metric=
_v6 =3D 0;</span><br><span>         }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        status =3D set_interface_metric(index, AF_INET, BLO=
CK_DNS_IFACE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        status =3D set_interface_metric(index, AF_INET, WFP_BLOCK_IFACE_M=
ETRIC);</span><br><span>         if (!status)</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            set_interfac=
e_metric(index, AF_INET6, BLOCK_DNS_IFACE_METRIC);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            set_interface_metric(index, AF_I=
NET6, WFP_BLOCK_IFACE_METRIC);</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span>@@ -1248,12 +1263,12 @@</span><br><=
span> </span><br><span>     if (msg_channel)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;Usin=
g service to delete block dns filters&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        win_block_dns_service(false, index, msg_cha=
nnel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_LOW, &quot;Using service to delete WFP block filters&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        win_wfp_block_service(fal=
se, false, index, msg_channel);</span><br><span>     }</span><br><span>    =
 else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        delete_block_dns_filters(m_hEngineHandle);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        delete_wfp_block_filters(m_hE=
ngineHandle);</span><br><span>         m_hEngineHandle =3D NULL;</span><br>=
<span>         if (tap_metric_v4 &gt;=3D 0)</span><br><span>         {</spa=
n><br><span>diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h</span><b=
r><span>index aa8513b..92b3528 100644</span><br><span>--- a/src/openvpn/win=
32.h</span><br><span>+++ b/src/openvpn/win32.h</span><br><span>@@ -25,8 +25=
,10 @@</span><br><span> #ifndef OPENVPN_WIN32_H</span><br><span> #define OP=
ENVPN_WIN32_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#include &lt;winioctl.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;iphlpapi.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;ws2tcpip.h&gt;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.=
h&quot;</span><br><span> #include &quot;mtu.h&quot;</span><br><span> #inclu=
de &quot;openvpn-msg.h&quot;</span><br><span> #include &quot;argv.h&quot;</=
span><br><span>@@ -286,7 +288,7 @@</span><br><span> /* call self in a subpr=
ocess */</span><br><span> void fork_to_self(const char *cmdline);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool win_wfp_=
block_dns(const NET_IFINDEX index, const HANDLE msg_channel);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool win_wfp_block(const NET_IFIN=
DEX index, const HANDLE msg_channel, BOOL dns_only);</span><br><span> </spa=
n><br><span> bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_=
channel);</span><br><span> </span><br><span>diff --git a/src/openvpnserv/CM=
akeLists.txt b/src/openvpnserv/CMakeLists.txt</span><br><span>index 17cd90c=
..154e17c 100644</span><br><span>--- a/src/openvpnserv/CMakeLists.txt</span=
><br><span>+++ b/src/openvpnserv/CMakeLists.txt</span><br><span>@@ -17,7 +1=
7,7 @@</span><br><span>     interactive.c</span><br><span>     service.c se=
rvice.h</span><br><span>     validate.c validate.h</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ../openvpn/block_dns.c ../openvpn/block_dn=
s.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ../openvpn/w=
fp_block.c ../openvpn/wfp_block.h</span><br><span>     openvpnserv_resource=
s.rc</span><br><span>     ../openvpn/ring_buffer.h</span><br><span>     )</=
span><br><span>diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/M=
akefile.am</span><br><span>index d8ba4eb..49ad8aa 100644</span><br><span>--=
- a/src/openvpnserv/Makefile.am</span><br><span>+++ b/src/openvpnserv/Makef=
ile.am</span><br><span>@@ -33,6 +33,6 @@</span><br><span> 	interactive.c \<=
/span><br><span> 	service.c service.h \</span><br><span> 	validate.c valida=
te.h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/=
src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_dns.h \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/wfp_=
block.c $(top_srcdir)/src/openvpn/wfp_block.h \</span><br><span> 	openvpnse=
rv_resources.rc \</span><br><span> 	$(top_srcdir)/src/openvpn/ring_buffer.h=
</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnse=
rv/interactive.c</span><br><span>index 32c8996..68a8106 100644</span><br><s=
pan>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnse=
rv/interactive.c</span><br><span>@@ -38,7 +38,7 @@</span><br><span> </span>=
<br><span> #include &quot;openvpn-msg.h&quot;</span><br><span> #include &qu=
ot;validate.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &quot;block_dns.h&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;wfp_block.h&quot;</span><br><span> #include &quot=
;ring_buffer.h&quot;</span><br><span> </span><br><span> #define IO_TIMEOUT =
 2000 /*ms*/</span><br><span>@@ -84,7 +84,7 @@</span><br><span> typedef enu=
m {</span><br><span>     address,</span><br><span>     route,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    block_dns,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    wfp_block,</span><br><span>     undo=
_dns4,</span><br><span>     undo_dns6,</span><br><span>     undo_domain,</s=
pan><br><span>@@ -99,7 +99,7 @@</span><br><span>     int index;</span><br><=
span>     int metric_v4;</span><br><span>     int metric_v6;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-} block_dns_data_t;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+} wfp_block_data_t;</span><br><span>=
 </span><br><span> typedef struct {</span><br><span>     struct tun_ring *s=
end_ring;</span><br><span>@@ -774,74 +774,76 @@</span><br><span> }</span><b=
r><span> </span><br><span> static DWORD</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-DeleteBlockDNS(const block_dns_message_t *msg, undo_lists=
_t *lists)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+DeleteWfp=
Block(const wfp_block_message_t *msg, undo_lists_t *lists)</span><br><span>=
 {</span><br><span>     DWORD err =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    block_dns_data_t *interface_data =3D RemoveListItem(=
&amp;(*lists)[block_dns], CmpAny, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    wfp_block_data_t *block_data =3D RemoveListItem(&a=
mp;(*lists)[wfp_block], CmpAny, NULL);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (interface_data)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (block_data)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D=
 delete_block_dns_filters(interface_data-&gt;engine);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (interface_data-&gt;metric_v4 &g=
t;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err=
 =3D delete_wfp_block_filters(block_data-&gt;engine);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (block_data-&gt;metric_v4 &gt;=
=3D 0)</span><br><span>         {</span><br><span>             set_interfac=
e_metric(msg-&gt;iface.index, AF_INET,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                 interface_data-&gt;metric=
_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   block_data-&gt;metric_v4);</span><br><span>         }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (interface_da=
ta-&gt;metric_v6 &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (block_data-&gt;metric_v6 &gt;=3D 0)</span><br><span>   =
      {</span><br><span>             set_interface_metric(msg-&gt;iface.ind=
ex, AF_INET6,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                         interface_data-&gt;metric_v6);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                 block_=
data-&gt;metric_v6);</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        free(interface_data);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        free(block_data);</span><br><sp=
an>     }</span><br><span>     else</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_ERR, TEXT(&quo=
t;No previous block DNS filters to delete&quot;));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, TEXT(&quot;No p=
revious block filters to delete&quot;));</span><br><span>     }</span><br><=
span> </span><br><span>     return err;</span><br><span> }</span><br><span>=
 </span><br><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-AddBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+AddWfpBlock(const wf=
p_block_message_t *msg, undo_lists_t *lists)</span><br><span> {</span><br><=
span>     DWORD err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    block_dns_data_t *interface_data =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    wfp_block_data_t *block_data =3D NULL=
;</span><br><span>     HANDLE engine =3D NULL;</span><br><span>     LPCWSTR=
 exe_path;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL =
dns_only;</span><br><span> </span><br><span>     exe_path =3D settings.exe_=
path;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dns_only =
=3D (msg-&gt;flags =3D=3D wfp_block_dns);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    err =3D add_block_dns_filters(&am=
p;engine, msg-&gt;iface.index, exe_path, BlockDNSErrHandler);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    err =3D add_wfp_block_filters=
(&amp;engine, msg-&gt;iface.index, exe_path, BlockDNSErrHandler, dns_only);=
</span><br><span>     if (!err)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        interface_data =3D malloc(sizeof(b=
lock_dns_data_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (!interface_data)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        block_data =3D malloc(sizeof(wfp_block_data_t));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!block_data)</span><=
br><span>         {</span><br><span>             err =3D ERROR_OUTOFMEMORY;=
</span><br><span>             goto out;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        interface_data-&gt;eng=
ine =3D engine;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  interface_data-&gt;index =3D msg-&gt;iface.index;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        block_data-&gt;engine =3D engine;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        block_data-=
&gt;index =3D msg-&gt;iface.index;</span><br><span>         int is_auto =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        interface_=
data-&gt;metric_v4 =3D get_interface_metric(msg-&gt;iface.index,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
                         AF_INET, &amp;is_auto);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        block_data-&gt;metric_v4 =3D get_inter=
face_metric(msg-&gt;iface.index,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                                     AF_INET, =
&amp;is_auto);</span><br><span>         if (is_auto)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            inter=
face_data-&gt;metric_v4 =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            block_data-&gt;metric_v4 =3D 0;</span><br><span>    =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        interfa=
ce_data-&gt;metric_v6 =3D get_interface_metric(msg-&gt;iface.index,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
                            AF_INET6, &amp;is_auto);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        block_data-&gt;metric_v6 =3D get_=
interface_metric(msg-&gt;iface.index,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                                     AF_I=
NET6, &amp;is_auto);</span><br><span>         if (is_auto)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 interface_data-&gt;metric_v6 =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            block_data-&gt;metric_v6 =3D 0;</span><br><spa=
n>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        err =3D AddListItem(&amp;(*lists)[block_dns], interface_da=
ta);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D=
 AddListItem(&amp;(*lists)[wfp_block], block_data);</span><br><span>       =
  if (!err)</span><br><span>         {</span><br><span>             err =3D=
 set_interface_metric(msg-&gt;iface.index, AF_INET,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                       BLOC=
K_DNS_IFACE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                       WFP_BLOCK_IFACE_METRIC);</span><br>=
<span>             if (!err)</span><br><span>             {</span><br><span=
>                 /* for IPv6, we intentionally ignore errors, because</spa=
n><br><span>@@ -850,12 +852,12 @@</span><br><span>                  * (if O=
penVPN wants IPv6 ifconfig, we&#39;ll fail there)</span><br><span>         =
         */</span><br><span>                 set_interface_metric(msg-&gt;i=
face.index, AF_INET6,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                     BLOCK_DNS_IFACE_METRIC);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
    WFP_BLOCK_IFACE_METRIC);</span><br><span>             }</span><br><span=
>             if (err)</span><br><span>             {</span><br><span>     =
            /* delete the filters, remove undo item and free interface data=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                De=
leteBlockDNS(msg, lists);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                DeleteWfpBlock(msg, lists);</span><br><span>         =
        engine =3D NULL;</span><br><span>             }</span><br><span>   =
      }</span><br><span>@@ -864,23 +866,23 @@</span><br><span> out:</span><=
br><span>     if (err &amp;&amp; engine)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        delete_block_dns_filters(=
engine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(=
interface_data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     delete_wfp_block_filters(engine);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        free(block_data);</span><br><span>     }</span><=
br><span> </span><br><span>     return err;</span><br><span> }</span><br><s=
pan> </span><br><span> static DWORD</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-HandleBlockDNSMessage(const block_dns_message_t *msg, undo_li=
sts_t *lists)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Handle=
WfpBlockMessage(const wfp_block_message_t *msg, undo_lists_t *lists)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m=
sg-&gt;header.type =3D=3D msg_add_block_dns)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (msg-&gt;header.type =3D=3D msg_add_wfp_blo=
ck)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return AddBlockDNS(msg, lists);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return AddWfpBlock(msg, lists);</span><br>=
<span>     }</span><br><span>     else</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return DeleteBlockDNS(msg, =
lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn DeleteWfpBlock(msg, lists);</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span>@@ -1616,7 +1618,7 @@</span><br><span>     =
    address_message_t address;</span><br><span>         route_message_t rou=
te;</span><br><span>         flush_neighbors_message_t flush_neighbors;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        block_dns_message=
_t block_dns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  wfp_block_message_t wfp_block;</span><br><span>         dns_cfg_message_t=
 dns;</span><br><span>         enable_dhcp_message_t dhcp;</span><br><span>=
         register_ring_buffers_message_t rrb;</span><br><span>@@ -1665,11 +=
1667,11 @@</span><br><span>             }</span><br><span>             brea=
k;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case msg_add_block_dns:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        case msg_del_block_dns:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (msg.header.size =3D=3D sizeof(msg.block_=
dns))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case m=
sg_add_wfp_block:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case msg_del_wfp_block:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (msg.header.size =3D=3D sizeof(msg.wfp_block))</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                ack.error_number =3D HandleBlockDNSMessage(&amp;msg.b=
lock_dns, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              ack.error_number =3D HandleWfpBlockMessage(&amp;msg.wfp_block=
, lists);</span><br><span>             }</span><br><span>             break=
;</span><br><span> </span><br><span>@@ -1723,7 +1725,7 @@</span><br><span> =
Undo(undo_lists_t *lists)</span><br><span> {</span><br><span>     undo_type=
_t type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    block_dns=
_data_t *interface_data;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    wfp_block_data_t *interface_data;</span><br><span>     for (type =
=3D 0; type &lt; _undo_type_max; type++)</span><br><span>     {</span><br><=
span>         list_item_t **pnext =3D &amp;(*lists)[type];</span><br><span>=
@@ -1756,9 +1758,9 @@</span><br><span>                     SetDNSDomain(ite=
m-&gt;data, &quot;&quot;, NULL);</span><br><span>                     break=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              case block_dns:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    interface_data =3D (block_dns_data_t *)(item-&g=
t;data);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       delete_block_dns_filters(interface_data-&gt;engine);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                case wfp_block:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    int=
erface_data =3D (wfp_block_data_t *)(item-&gt;data);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    delete_wfp_block_filt=
ers(interface_data-&gt;engine);</span><br><span>                     if (in=
terface_data-&gt;metric_v4 &gt;=3D 0)</span><br><span>                     =
{</span><br><span>                         set_interface_metric(interface_d=
ata-&gt;index, AF_INET,</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">change 48=
9</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--RykBHYKWIXQ=--

