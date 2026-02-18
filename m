From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 18 Feb 2026 00:10:38 +0000
References: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d43af0dc606fa7f17a3611c8f0c201c7a002c682-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1uFfbYuGpc0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: wfp: add flag to
 allow DNS traffic to loopback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1uFfbYuGpc0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail

to review the following change.


Change subject: wfp: add flag to allow DNS traffic to loopback
......................................................................

wfp: add flag to allow DNS traffic to loopback

Add a flag 'allow-loopback' to the --block-outside-dns options. When it
is set DNS traffic to loopback (localhost) will not be blocked. This
flag will also allow DNS to localhost when all local traffic is to be
blocked via '--redirect-gateway block-local'.

Fixes #703

Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M doc/man-sections/windows-options.rst
M include/openvpn-msg.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/wfp_block.c
M src/openvpn/wfp_block.h
M src/openvpn/win32.c
M src/openvpn/win32.h
M src/openvpnserv/interactive.c
10 files changed, 118 insertions(+), 59 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1541/1

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/window=
s-options.rst
index af2fb45..b31ff2e 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -10,11 +10,12 @@
   after a reboot, or if the driver is unloaded and reloaded. This
   directive can only be used by an administrator.

---block-outside-dns
+--block-outside-dns [allow-loopback]
   Block DNS servers on other network adapters to prevent DNS leaks. This
   option prevents any application from accessing TCP or UDP port 53 except
   one inside the tunnel. It uses Windows Filtering Platform (WFP) and
-  works on Windows Vista or later.
+  works on Windows Vista or later. If ``allow-loopback`` is set, traffic to
+  localhost port 53 is still allowed.

   This option is considered unknown on non-Windows platforms and
   unsupported on Windows XP, resulting in fatal error. You may want to use
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index a0cec53..58d4ea9 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -72,9 +72,13 @@
=20
 typedef enum
 {
-    wfp_block_local =3D 1 << 0,
-    wfp_block_dns =3D 1 << 1
-} wfp_block_flags_t;
+    wfp_block_all,
+    wfp_block_all_except_local_dns,
+    wfp_block_dns,
+    wfp_block_dns_except_local,
+    wfp_block_type_count,
+    wfp_block_none =3D -1
+} wfp_block_t;

 typedef struct
 {
@@ -162,7 +166,7 @@
 typedef struct
 {
     message_header_t header;
-    wfp_block_flags_t flags;
+    wfp_block_t block_type;
     interface_t iface;
 } wfp_block_message_t;

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1391aa85..19ddece 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1771,12 +1771,14 @@
 {
 #if defined(_WIN32)
     /* Fortify 'redirect-gateway block-local' with firewall rules? */
-    bool block_local =3D block_local_needed(c->c1.route_list);
+    const bool block_local =3D block_local_needed(c->c1.route_list);
+    const bool block_outside_dns =3D c->options.block_outside_dns;
+    const bool allow_loopback_dns =3D c->options.allow_loopback_dns;
+    const wfp_block_t block_type =3D get_wfp_block_type(block_local, block=
_outside_dns, allow_loopback_dns);

-    if (c->options.block_outside_dns || block_local)
+    if (block_type !=3D wfp_block_none)
     {
-        BOOL dns_only =3D !block_local;
-        if (!win_wfp_block(c->c1.tuntap->adapter_index, c->options.msg_cha=
nnel, dns_only))
+        if (!win_wfp_block(c->c1.tuntap->adapter_index, c->options.msg_cha=
nnel, block_type))
         {
             msg(M_FATAL, "WFP: initialization failed");
         }
@@ -1796,7 +1798,11 @@
 del_wfp_block(struct context *c, unsigned long adapter_index)
 {
 #if defined(_WIN32)
-    if (c->options.block_outside_dns || block_local_needed(c->c1.route_lis=
t))
+    const bool block_local =3D block_local_needed(c->c1.route_list);
+    const bool block_outside_dns =3D c->options.block_outside_dns;
+    const wfp_block_t block_type =3D get_wfp_block_type(block_local, block=
_outside_dns, false);
+
+    if (block_type !=3D wfp_block_none)
     {
         if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
         {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cdb02e9..4c8a0bd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -848,6 +848,7 @@
     o->tuntap_options.dhcp_masq_offset =3D 0;
     o->route_method =3D ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns =3D false;
+    o->allow_loopback_dns =3D false;
     o->windows_driver =3D WINDOWS_DRIVER_UNSPECIFIED;
 #endif
     o->vlan_accept =3D VLAN_ALL;
@@ -1955,6 +1956,7 @@
     SHOW_BOOL(show_net_up);
     SHOW_INT(route_method);
     SHOW_BOOL(block_outside_dns);
+    SHOW_BOOL(allow_loopback_dns);
     show_tuntap_options(&o->tuntap_options);
 #endif
 #endif /* ifndef ENABLE_SMALL */
@@ -5172,6 +5174,7 @@
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->block_outside_dns =3D false;
+        options->allow_loopback_dns =3D false;
     }
 #else /* ifdef _WIN32 */
     else if (streq(p[0], "dhcp-option") && !p[1])
@@ -8067,10 +8070,14 @@
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->tuntap_options.register_dns =3D true;
     }
-    else if (streq(p[0], "block-outside-dns") && !p[1])
+    else if (streq(p[0], "block-outside-dns") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->block_outside_dns =3D true;
+        if (p[1] && streq(p[1], "allow-loopback"))
+        {
+            options->allow_loopback_dns =3D true;
+        }
     }
     else if (streq(p[0], "rdns-internal") && !p[1])
     /* standalone method for internal use
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cf9936b..f69a053 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -692,6 +692,7 @@
     bool show_net_up;
     int route_method;
     bool block_outside_dns;
+    bool allow_loopback_dns;
     enum tun_driver_type windows_driver;
 #endif

diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 212a4b2..6640178 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -131,27 +131,10 @@
     return err;
 }

-/*
- * Block outgoing local traffic, possibly DNS only, except for
- * (i) adapter with the specified index (and loopback, if all is blocked)
- * OR
- * (ii) processes with the specified executable path
- * The firewall filters added here are automatically removed when the proc=
ess exits or
- * on calling delete_wfp_block_filters().
- * Arguments:
- *   engine_handle : On successful return contains the handle for a newly =
opened fwp session
- *                   in which the filters are added.
- *                   May be closed by passing to delete_wfp_block_filters =
to remove the filters.
- *   index         : The index of adapter for which traffic is permitted.
- *   exe_path      : Path of executable for which traffic is permitted.
- *   msg_handler   : An optional callback function for error reporting.
- *   dns_only      : Whether the blocking filters should apply for DNS onl=
y.
- * Returns 0 on success, a non-zero status code of the last failed action =
on failure.
- */
=20
 DWORD
 add_wfp_block_filters(HANDLE *engine_handle, int index, const WCHAR *exe_p=
ath,
-                      wfp_block_msg_handler_t msg_handler, BOOL dns_only)
+                      wfp_block_msg_handler_t msg_handler, const wfp_block=
_t block_type)
 {
     FWPM_SESSION0 session =3D { 0 };
     FWPM_SUBLAYER0 *sublayer_ptr =3D NULL;
@@ -247,7 +230,7 @@
     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
     Filter.action.type =3D FWP_ACTION_PERMIT;
     Condition[0] =3D match_openvpn;
-    if (dns_only)
+    if (block_type =3D=3D wfp_block_dns || block_type =3D=3D wfp_block_dns=
_except_local)
     {
         Filter.numFilterConditions =3D 2;
         Condition[1] =3D match_port_53;
@@ -268,7 +251,7 @@
     Filter.weight.type =3D FWP_EMPTY;
     Filter.numFilterConditions =3D 1;
     Condition[0] =3D match_not_loopback;
-    if (dns_only)
+    if (block_type =3D=3D wfp_block_dns || block_type =3D=3D wfp_block_dns=
_except_local)
     {
         Filter.numFilterConditions =3D 2;
         Condition[1] =3D match_port_53;
@@ -292,7 +275,7 @@
     Filter.action.type =3D FWP_ACTION_PERMIT;
     Filter.numFilterConditions =3D 1;
     Condition[0] =3D match_interface;
-    if (dns_only)
+    if (block_type =3D=3D wfp_block_dns || block_type =3D=3D wfp_block_dns=
_except_local)
     {
         Filter.numFilterConditions =3D 2;
         Condition[1] =3D match_port_53;
@@ -308,20 +291,23 @@

     msg_handler(0, "WFP Block: Added permit filters for VPN interface");

-    /* Seventh Filter. Block IPv4 DNS requests to loopback from other apps=
 */
-    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filter.action.type =3D FWP_ACTION_BLOCK;
-    Filter.weight.type =3D FWP_EMPTY;
-    Filter.numFilterConditions =3D 2;
-    Condition[0] =3D match_loopback;
-    Condition[1] =3D match_port_53;
-    err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    OUT_ON_ERROR(err, "Add filter to block IPv4 DNS traffic to loopback fa=
iled");
+    if (block_type !=3D wfp_block_all_except_local_dns && block_type !=3D =
wfp_block_dns_except_local)
+    {
+        /* Seventh Filter. Block IPv4 DNS requests to loopback from other =
apps */
+        Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+        Filter.action.type =3D FWP_ACTION_BLOCK;
+        Filter.weight.type =3D FWP_EMPTY;
+        Filter.numFilterConditions =3D 2;
+        Condition[0] =3D match_loopback;
+        Condition[1] =3D match_port_53;
+        err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+        OUT_ON_ERROR(err, "Add filter to block IPv4 DNS traffic to loopbac=
k failed");

-    /* Eighth Filter. Block IPv6 DNS requests to loopback from other apps =
*/
-    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-    err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    OUT_ON_ERROR(err, "Add filter to block IPv6 DNS traffic to loopback fa=
iled");
+        /* Eighth Filter. Block IPv6 DNS requests to loopback from other a=
pps */
+        Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+        err =3D FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+        OUT_ON_ERROR(err, "Add filter to block IPv6 DNS traffic to loopbac=
k failed");
+    }

     msg_handler(0, "WFP Block: Added block filters for DNS traffic to loop=
back");

diff --git a/src/openvpn/wfp_block.h b/src/openvpn/wfp_block.h
index 8bc093a..2f28751 100644
--- a/src/openvpn/wfp_block.h
+++ b/src/openvpn/wfp_block.h
@@ -28,18 +28,46 @@
 #include <windef.h>
 #include <iphlpapi.h>
 #include <ws2tcpip.h>
+#include <stdbool.h>
+
+#include "openvpn-msg.h"

 /* Any value less than 5 should work fine. 3 is chosen without any real re=
ason. */
 #define WFP_BLOCK_IFACE_METRIC 3

 typedef void (*wfp_block_msg_handler_t)(DWORD err, const char *msg);

-DWORD
-delete_wfp_block_filters(HANDLE engine);
-
+/**
+ * Block outgoing local traffic, possibly DNS only, except for
+ * (i) adapter with the specified index (and loopback, if all is blocked)
+ * OR
+ * (ii) processes with the specified executable path
+ * The firewall filters added here are automatically removed when the proc=
ess exits or
+ * on calling \ref delete_wfp_block_filters().
+ *
+ * @param engine_handle On successful return contains the handle for a new=
ly opened fwp
+ *                      session in which the filters are added. May be clo=
sed by passing
+ *                      to \ref delete_wfp_block_filters() to remove the f=
ilters.
+ * @param index         The index of adapter for which traffic is permitte=
d.
+ * @param exe_path      Path of executable for which traffic is permitted.
+ * @param msg_handler   An optional callback function for error reporting.
+ * @param block_type    Whether the blocking filters should apply for DNS =
only.
+ *
+ * @return ERROR_SUCCESS, or a non-zero status code of the last failed act=
ion on failure.
+ */
 DWORD
 add_wfp_block_filters(HANDLE *engine, int iface_index, const WCHAR *exe_pa=
th,
-                      wfp_block_msg_handler_t msg_handler_callback, BOOL d=
ns_only);
+                      wfp_block_msg_handler_t msg_handler_callback, const =
wfp_block_t block_type);
+
+/**
+ * Remove the firewall filter rules set with \ref add_wfp_block_filters()
+ *
+ * @param engine        The WFP session handle in which the firewall rules=
 were added.
+ *
+ * @return ERROR_SUCCESS, or a non-zero status code of the last failed act=
ion on failure.
+ */
+DWORD
+delete_wfp_block_filters(HANDLE engine);

 /**
  * Return interface metric value for the specified interface index.
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index b938d7b..54dab85 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1167,7 +1167,7 @@
 }

 static bool
-win_wfp_block_service(bool add, bool dns_only, int index, const HANDLE pip=
e)
+win_wfp_block_service(bool add, const wfp_block_t block_type, int index, c=
onst HANDLE pipe)
 {
     bool ret =3D false;
     ack_message_t ack;
@@ -1175,7 +1175,7 @@

     wfp_block_message_t data =3D { .header =3D { (add ? msg_add_wfp_block =
: msg_del_wfp_block),
                                              sizeof(wfp_block_message_t), =
0 },
-                                 .flags =3D dns_only ? wfp_block_dns : wfp=
_block_local,
+                                 .block_type =3D block_type,
                                  .iface =3D { .index =3D index, .name =3D =
"" } };

     if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "WFP block"))
@@ -1200,7 +1200,7 @@
 }

 bool
-win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_=
only)
+win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, const wfp=
_block_t block_type)
 {
     WCHAR openvpnpath[MAX_PATH];
     bool ret =3D false;
@@ -1209,7 +1209,7 @@
     if (msg_channel)
     {
         dmsg(D_LOW, "Using service to add WFP block filters");
-        ret =3D win_wfp_block_service(true, dns_only, index, msg_channel);
+        ret =3D win_wfp_block_service(true, block_type, index, msg_channel=
);
         goto out;
     }

@@ -1220,7 +1220,7 @@
     }

     status =3D
-        add_wfp_block_filters(&m_hEngineHandle, index, openvpnpath, win_wf=
p_msg_handler, dns_only);
+        add_wfp_block_filters(&m_hEngineHandle, index, openvpnpath, win_wf=
p_msg_handler, block_type);
     if (status =3D=3D 0)
     {
         int is_auto =3D 0;
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index ef32062..d3ef16b 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -289,7 +289,31 @@
 /* call self in a subprocess */
 void fork_to_self(const char *cmdline);

-bool win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL=
 dns_only);
+/**
+ * Get the wfp block type value according to the parameters passed.
+ * Block types are defined in the \ref wfp_block_t enum.
+ *
+ * @param block_local           Do we need to block traffic to local adapt=
ers
+ * @param block_outside_dns     Do we need to block DNS to local adapters
+ * @param allow_loopback_dns    Do we need to make an exception for DNS to=
 loopback
+ *
+ * @return wfp_block_none if no blocking is needed, or the block type to u=
se
+ */
+static inline wfp_block_t
+get_wfp_block_type(const bool block_local, const bool block_outside_dns, c=
onst bool allow_loopback_dns)
+{
+    if (block_local)
+    {
+        return allow_loopback_dns ? wfp_block_all_except_local_dns : wfp_b=
lock_all;
+    }
+    else if (block_outside_dns)
+    {
+        return allow_loopback_dns ? wfp_block_dns_except_local : wfp_block=
_dns;
+    }
+    return wfp_block_none;
+}
+
+bool win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, cons=
t wfp_block_t block_type);

 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ad19e2c..58040a2 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -791,12 +791,10 @@
     wfp_block_data_t *block_data =3D NULL;
     HANDLE engine =3D NULL;
     LPCWSTR exe_path;
-    BOOL dns_only;

     exe_path =3D settings.exe_path;
-    dns_only =3D (msg->flags =3D=3D wfp_block_dns);

-    err =3D add_wfp_block_filters(&engine, msg->iface.index, exe_path, Blo=
ckDNSErrHandler, dns_only);
+    err =3D add_wfp_block_filters(&engine, msg->iface.index, exe_path, Blo=
ckDNSErrHandler, msg->block_type);
     if (!err)
     {
         block_data =3D malloc(sizeof(wfp_block_data_t));
@@ -854,6 +852,10 @@
 static DWORD
 HandleWfpBlockMessage(const wfp_block_message_t *msg, undo_lists_t *lists)
 {
+    if (msg->block_type >=3D 0 && msg->block_type < wfp_block_type_count)
+    {
+        return ERROR_MESSAGE_DATA;
+    }
     if (msg->header.type =3D=3D msg_add_wfp_block)
     {
         return AddWfpBlock(msg, lists);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6
Gerrit-Change-Number: 1541
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--1uFfbYuGpc0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">wfp: add flag to allow DNS traffic to loopb=
ack<br><br>Add a flag &#39;allow-loopback&#39; to the --block-outside-dns o=
ptions. When it<br>is set DNS traffic to loopback (localhost) will not be b=
locked. This<br>flag will also allow DNS to localhost when all local traffi=
c is to be<br>blocked via &#39;--redirect-gateway block-local&#39;.<br><br>=
Fixes #703<br><br>Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6<br>S=
igned-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M doc/man-secti=
ons/windows-options.rst<br>M include/openvpn-msg.h<br>M src/openvpn/init.c<=
br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/wfp_=
block.c<br>M src/openvpn/wfp_block.h<br>M src/openvpn/win32.c<br>M src/open=
vpn/win32.h<br>M src/openvpnserv/interactive.c<br>10 files changed, 118 ins=
ertions(+), 59 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/41/1541/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc=
/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst</s=
pan><br><span>index af2fb45..b31ff2e 100644</span><br><span>--- a/doc/man-s=
ections/windows-options.rst</span><br><span>+++ b/doc/man-sections/windows-=
options.rst</span><br><span>@@ -10,11 +10,12 @@</span><br><span>   after a =
reboot, or if the driver is unloaded and reloaded. This</span><br><span>   =
directive can only be used by an administrator.</span><br><span> </span><br=
><span>---block-outside-dns</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+--block-outside-dns [allow-loopback]</span><br><span>   Block DNS s=
ervers on other network adapters to prevent DNS leaks. This</span><br><span=
>   option prevents any application from accessing TCP or UDP port 53 excep=
t</span><br><span>   one inside the tunnel. It uses Windows Filtering Platf=
orm (WFP) and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  works =
on Windows Vista or later.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  works on Windows Vista or later. If ``allow-loopback`` is set, tra=
ffic to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  localhost =
port 53 is still allowed.</span><br><span> </span><br><span>   This option =
is considered unknown on non-Windows platforms and</span><br><span>   unsup=
ported on Windows XP, resulting in fatal error. You may want to use</span><=
br><span>diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h</span><=
br><span>index a0cec53..58d4ea9 100644</span><br><span>--- a/include/openvp=
n-msg.h</span><br><span>+++ b/include/openvpn-msg.h</span><br><span>@@ -72,=
9 +72,13 @@</span><br><span> </span><br><span> typedef enum</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wfp_block_loca=
l =3D 1 &lt;&lt; 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  wfp_block_dns =3D 1 &lt;&lt; 1</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-} wfp_block_flags_t;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    wfp_block_all,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    wfp_block_all_except_local_dns,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    wfp_block_dns,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    wfp_block_dns_except_local,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    wfp_block_type_count,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_none =3D -1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+} wfp_block_t;</span><br>=
<span> </span><br><span> typedef struct</span><br><span> {</span><br><span>=
@@ -162,7 +166,7 @@</span><br><span> typedef struct</span><br><span> {</spa=
n><br><span>     message_header_t header;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    wfp_block_flags_t flags;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    wfp_block_t block_type;</span><br><span>  =
   interface_t iface;</span><br><span> } wfp_block_message_t;</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</=
span><br><span>index 1391aa85..19ddece 100644</span><br><span>--- a/src/ope=
nvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -17=
71,12 +1771,14 @@</span><br><span> {</span><br><span> #if defined(_WIN32)</=
span><br><span>     /* Fortify &#39;redirect-gateway block-local&#39; with =
firewall rules? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 bool block_local =3D block_local_needed(c-&gt;c1.route_list);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const bool block_local =3D b=
lock_local_needed(c-&gt;c1.route_list);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const bool block_outside_dns =3D c-&gt;options.bloc=
k_outside_dns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst bool allow_loopback_dns =3D c-&gt;options.allow_loopback_dns;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const wfp_block_t block_=
type =3D get_wfp_block_type(block_local, block_outside_dns, allow_loopback_=
dns);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (c-&gt;options.block_outside_dns || block_local)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (block_type !=3D wfp_block_non=
e)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        BOOL dns_only =3D !block_local;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (!win_wfp_block(c-&gt;c1.tuntap-&gt;adapte=
r_index, c-&gt;options.msg_channel, dns_only))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!win_wfp_block(c-&gt;c1.tuntap-&gt;a=
dapter_index, c-&gt;options.msg_channel, block_type))</span><br><span>     =
    {</span><br><span>             msg(M_FATAL, &quot;WFP: initialization f=
ailed&quot;);</span><br><span>         }</span><br><span>@@ -1796,7 +1798,1=
1 @@</span><br><span> del_wfp_block(struct context *c, unsigned long adapte=
r_index)</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options.block_outs=
ide_dns || block_local_needed(c-&gt;c1.route_list))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const bool block_local =3D block_loca=
l_needed(c-&gt;c1.route_list);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const bool block_outside_dns =3D c-&gt;options.block_outside=
_dns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const wfp_=
block_t block_type =3D get_wfp_block_type(block_local, block_outside_dns, f=
alse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (block_type !=3D wfp_bloc=
k_none)</span><br><span>     {</span><br><span>         if (!win_wfp_uninit=
(adapter_index, c-&gt;options.msg_channel))</span><br><span>         {</spa=
n><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</spa=
n><br><span>index cdb02e9..4c8a0bd 100644</span><br><span>--- a/src/openvpn=
/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -=
848,6 +848,7 @@</span><br><span>     o-&gt;tuntap_options.dhcp_masq_offset =
=3D 0;</span><br><span>     o-&gt;route_method =3D ROUTE_METHOD_ADAPTIVE;</=
span><br><span>     o-&gt;block_outside_dns =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    o-&gt;allow_loopback_dns =3D false;<=
/span><br><span>     o-&gt;windows_driver =3D WINDOWS_DRIVER_UNSPECIFIED;</=
span><br><span> #endif</span><br><span>     o-&gt;vlan_accept =3D VLAN_ALL;=
</span><br><span>@@ -1955,6 +1956,7 @@</span><br><span>     SHOW_BOOL(show_=
net_up);</span><br><span>     SHOW_INT(route_method);</span><br><span>     =
SHOW_BOOL(block_outside_dns);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_BOOL(allow_loopback_dns);</span><br><span>     show_tunt=
ap_options(&amp;o-&gt;tuntap_options);</span><br><span> #endif</span><br><s=
pan> #endif /* ifndef ENABLE_SMALL */</span><br><span>@@ -5172,6 +5174,7 @@=
</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_DH=
CPDNS);</span><br><span>         options-&gt;block_outside_dns =3D false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;a=
llow_loopback_dns =3D false;</span><br><span>     }</span><br><span> #else =
/* ifdef _WIN32 */</span><br><span>     else if (streq(p[0], &quot;dhcp-opt=
ion&quot;) &amp;&amp; !p[1])</span><br><span>@@ -8067,10 +8070,14 @@</span>=
<br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span>      =
   options-&gt;tuntap_options.register_dns =3D true;</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[=
0], &quot;block-outside-dns&quot;) &amp;&amp; !p[1])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;block-outs=
ide-dns&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><br><span>   =
      VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span>         options-&g=
t;block_outside_dns =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (p[1] &amp;&amp; streq(p[1], &quot;allow-loopback&quot=
;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;al=
low_loopback_dns =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span>     }</span><br><span>     else if (streq=
(p[0], &quot;rdns-internal&quot;) &amp;&amp; !p[1])</span><br><span>     /*=
 standalone method for internal use</span><br><span>diff --git a/src/openvp=
n/options.h b/src/openvpn/options.h</span><br><span>index cf9936b..f69a053 =
100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/sr=
c/openvpn/options.h</span><br><span>@@ -692,6 +692,7 @@</span><br><span>   =
  bool show_net_up;</span><br><span>     int route_method;</span><br><span>=
     bool block_outside_dns;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool allow_loopback_dns;</span><br><span>     enum tun_driver_=
type windows_driver;</span><br><span> #endif</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c</span><b=
r><span>index 212a4b2..6640178 100644</span><br><span>--- a/src/openvpn/wfp=
_block.c</span><br><span>+++ b/src/openvpn/wfp_block.c</span><br><span>@@ -=
131,27 +131,10 @@</span><br><span>     return err;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Block outgoing local traf=
fic, possibly DNS only, except for</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * (i) adapter with the specified index (and loopback, if all =
is blocked)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * OR</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * (ii) processes with the=
 specified executable path</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * The firewall filters added here are automatically removed when the =
process exits or</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * on=
 calling delete_wfp_block_filters().</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Arguments:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *   engine_handle : On successful return contains the handle for a =
newly opened fwp session</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *                   in which the filters are added.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *                   May be closed by pas=
sing to delete_wfp_block_filters to remove the filters.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *   index         : The index of adapter=
 for which traffic is permitted.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *   exe_path      : Path of executable for which traffic is per=
mitted.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   msg_handl=
er   : An optional callback function for error reporting.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *   dns_only      : Whether the blocki=
ng filters should apply for DNS only.</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Returns 0 on success, a non-zero status code of the last=
 failed action on failure.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span> </span><br><span> DWORD</span><br><span> add_wfp_=
block_filters(HANDLE *engine_handle, int index, const WCHAR *exe_path,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                      wfp_=
block_msg_handler_t msg_handler, BOOL dns_only)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                      wfp_block_msg_handler_t m=
sg_handler, const wfp_block_t block_type)</span><br><span> {</span><br><spa=
n>     FWPM_SESSION0 session =3D { 0 };</span><br><span>     FWPM_SUBLAYER0=
 *sublayer_ptr =3D NULL;</span><br><span>@@ -247,7 +230,7 @@</span><br><spa=
n>     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span><br><span>=
     Filter.action.type =3D FWP_ACTION_PERMIT;</span><br><span>     Conditi=
on[0] =3D match_openvpn;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (dns_only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (block_type =3D=3D wfp_block_dns || block_type =3D=3D wfp_block_dns=
_except_local)</span><br><span>     {</span><br><span>         Filter.numFi=
lterConditions =3D 2;</span><br><span>         Condition[1] =3D match_port_=
53;</span><br><span>@@ -268,7 +251,7 @@</span><br><span>     Filter.weight.=
type =3D FWP_EMPTY;</span><br><span>     Filter.numFilterConditions =3D 1;<=
/span><br><span>     Condition[0] =3D match_not_loopback;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (dns_only)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (block_type =3D=3D wfp_block_dns |=
| block_type =3D=3D wfp_block_dns_except_local)</span><br><span>     {</spa=
n><br><span>         Filter.numFilterConditions =3D 2;</span><br><span>    =
     Condition[1] =3D match_port_53;</span><br><span>@@ -292,7 +275,7 @@</s=
pan><br><span>     Filter.action.type =3D FWP_ACTION_PERMIT;</span><br><spa=
n>     Filter.numFilterConditions =3D 1;</span><br><span>     Condition[0] =
=3D match_interface;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (dns_only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (block_type =3D=3D wfp_block_dns || block_type =3D=3D wfp_block_dns_exc=
ept_local)</span><br><span>     {</span><br><span>         Filter.numFilter=
Conditions =3D 2;</span><br><span>         Condition[1] =3D match_port_53;<=
/span><br><span>@@ -308,20 +291,23 @@</span><br><span> </span><br><span>   =
  msg_handler(0, &quot;WFP Block: Added permit filters for VPN interface&qu=
ot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* Seventh Filter. Block IPv4 DNS requests to loopback from other app=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter.layerK=
ey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    Filter.action.type =3D FWP_ACTION_BLOCK;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    Filter.weight.type =3D FWP_EMPT=
Y;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter.numFilte=
rConditions =3D 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 Condition[0] =3D match_loopback;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    Condition[1] =3D match_port_53;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    err =3D FwpmFilterAdd0(*engine_handle, &amp;F=
ilter, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    OUT_ON_ERROR(err, &quot;Add filter to block IPv4 DNS traffic to =
loopback failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (block_type !=3D wfp_block_all_except_local_dns &amp;&amp; block=
_type !=3D wfp_block_dns_except_local)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Seventh Filter. Block IPv4 DNS requests to loopback from ot=
her apps */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        Filter.action.type =3D FWP_ACTION=
_BLOCK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Filt=
er.weight.type =3D FWP_EMPTY;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        Filter.numFilterConditions =3D 2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        Condition[0] =3D match_loopback;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Condition[1]=
 =3D match_port_53;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, NULL, &amp;filt=
erid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OUT_O=
N_ERROR(err, &quot;Add filter to block IPv4 DNS traffic to loopback failed&=
quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* Eighth Filter. Block IPv6 DNS requests to loopback from other ap=
ps */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter.layer=
Key =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter, N=
ULL, &amp;filterid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   OUT_ON_ERROR(err, &quot;Add filter to block IPv6 DNS traffic to loopback=
 failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Eighth Filter. Block IPv6 DNS requests to loopback from other apps *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Filter.lay=
erKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        err =3D FwpmFilterAdd0(*engine_handle, &amp;F=
ilter, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        OUT_ON_ERROR(err, &quot;Add filter to block IPv6 DNS traff=
ic to loopback failed&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span> </span><br><span>     msg_handler(0, &quot=
;WFP Block: Added block filters for DNS traffic to loopback&quot;);</span><=
br><span> </span><br><span>diff --git a/src/openvpn/wfp_block.h b/src/openv=
pn/wfp_block.h</span><br><span>index 8bc093a..2f28751 100644</span><br><spa=
n>--- a/src/openvpn/wfp_block.h</span><br><span>+++ b/src/openvpn/wfp_block=
.h</span><br><span>@@ -28,18 +28,46 @@</span><br><span> #include &lt;windef=
.h&gt;</span><br><span> #include &lt;iphlpapi.h&gt;</span><br><span> #inclu=
de &lt;ws2tcpip.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;stdbool.h&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;openvpn-msg.h&quot;</span><br><span> </span><br><span> /* Any value le=
ss than 5 should work fine. 3 is chosen without any real reason. */</span><=
br><span> #define WFP_BLOCK_IFACE_METRIC 3</span><br><span> </span><br><spa=
n> typedef void (*wfp_block_msg_handler_t)(DWORD err, const char *msg);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-DWORD</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-delete_wfp_block_filter=
s(HANDLE engine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Block outgoing local traffic, possib=
ly DNS only, except for</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * (i) adapter with the specified index (and loopback, if all is blocke=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OR</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * (ii) processes with the spec=
ified executable path</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * The firewall filters added here are automatically removed when the pro=
cess exits or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on =
calling \ref delete_wfp_block_filters().</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param engine_handle On successful return contains the handle for a =
newly opened fwp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
                     session in which the filters are added. May be closed =
by passing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
               to \ref delete_wfp_block_filters() to remove the filters.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param index       =
  The index of adapter for which traffic is permitted.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param exe_path      Path of executab=
le for which traffic is permitted.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param msg_handler   An optional callback function for er=
ror reporting.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram block_type    Whether the blocking filters should apply for DNS only.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return ERROR_SUCCESS, or a non-ze=
ro status code of the last failed action on failure.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> DWORD</span><br><spa=
n> add_wfp_block_filters(HANDLE *engine, int iface_index, const WCHAR *exe_=
path,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
      wfp_block_msg_handler_t msg_handler_callback, BOOL dns_only);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      wfp_b=
lock_msg_handler_t msg_handler_callback, const wfp_block_t block_type);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Remove the firewall filter rules set with \ref add_wfp=
_block_filters()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param engine    =
    The WFP session handle in which the firewall rules were added.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return ERROR_SUCCESS, or a non-zero statu=
s code of the last failed action on failure.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+delet=
e_wfp_block_filters(HANDLE engine);</span><br><span> </span><br><span> /**<=
/span><br><span>  * Return interface metric value for the specified interfa=
ce index.</span><br><span>diff --git a/src/openvpn/win32.c b/src/openvpn/wi=
n32.c</span><br><span>index b938d7b..54dab85 100644</span><br><span>--- a/s=
rc/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br><spa=
n>@@ -1167,7 +1167,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-win_wfp=
_block_service(bool add, bool dns_only, int index, const HANDLE pipe)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+win_wfp_block_service(boo=
l add, const wfp_block_t block_type, int index, const HANDLE pipe)</span><b=
r><span> {</span><br><span>     bool ret =3D false;</span><br><span>     ac=
k_message_t ack;</span><br><span>@@ -1175,7 +1175,7 @@</span><br><span> </s=
pan><br><span>     wfp_block_message_t data =3D { .header =3D { (add ? msg_=
add_wfp_block : msg_del_wfp_block),</span><br><span>                       =
                       sizeof(wfp_block_message_t), 0 },</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                 .flags =
=3D dns_only ? wfp_block_dns : wfp_block_local,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                 .block_type =
=3D block_type,</span><br><span>                                  .iface =
=3D { .index =3D index, .name =3D &quot;&quot; } };</span><br><span> </span=
><br><span>     if (!send_msg_iservice(pipe, &amp;data, sizeof(data), &amp;=
ack, &quot;WFP block&quot;))</span><br><span>@@ -1200,7 +1200,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-win_wfp_block(const NET_IFINDEX index, const H=
ANDLE msg_channel, BOOL dns_only)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+win_wfp_block(const NET_IFINDEX index, const HANDLE msg_chann=
el, const wfp_block_t block_type)</span><br><span> {</span><br><span>     W=
CHAR openvpnpath[MAX_PATH];</span><br><span>     bool ret =3D false;</span>=
<br><span>@@ -1209,7 +1209,7 @@</span><br><span>     if (msg_channel)</span=
><br><span>     {</span><br><span>         dmsg(D_LOW, &quot;Using service =
to add WFP block filters&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ret =3D win_wfp_block_service(true, dns_only, index, msg=
_channel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
et =3D win_wfp_block_service(true, block_type, index, msg_channel);</span><=
br><span>         goto out;</span><br><span>     }</span><br><span> </span>=
<br><span>@@ -1220,7 +1220,7 @@</span><br><span>     }</span><br><span> </s=
pan><br><span>     status =3D</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        add_wfp_block_filters(&amp;m_hEngineHandle, index, openvpnp=
ath, win_wfp_msg_handler, dns_only);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        add_wfp_block_filters(&amp;m_hEngineHandle, index,=
 openvpnpath, win_wfp_msg_handler, block_type);</span><br><span>     if (st=
atus =3D=3D 0)</span><br><span>     {</span><br><span>         int is_auto =
=3D 0;</span><br><span>diff --git a/src/openvpn/win32.h b/src/openvpn/win32=
.h</span><br><span>index ef32062..d3ef16b 100644</span><br><span>--- a/src/=
openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.h</span><br><span>@=
@ -289,7 +289,31 @@</span><br><span> /* call self in a subprocess */</span>=
<br><span> void fork_to_self(const char *cmdline);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool win_wfp_block(const NET=
_IFINDEX index, const HANDLE msg_channel, BOOL dns_only);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Get the wfp block type value according to the para=
meters passed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Bl=
ock types are defined in the \ref wfp_block_t enum.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param block_local           Do we need to block traffi=
c to local adapters</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param block_outside_dns     Do we need to block DNS to local adapters</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param allow_loopb=
ack_dns    Do we need to make an exception for DNS to loopback</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return wfp_block_none if no blocking is neede=
d, or the block type to use</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline wfp_block_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ge=
t_wfp_block_type(const bool block_local, const bool block_outside_dns, cons=
t bool allow_loopback_dns)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (blo=
ck_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return allow_loo=
pback_dns ? wfp_block_all_except_local_dns : wfp_block_all;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (block_outside_dns)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return allow_loopback_dns ? wfp_block_dns_e=
xcept_local : wfp_block_dns;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn wfp_block_none;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool win_wfp_block(const NET_IFINDE=
X index, const HANDLE msg_channel, const wfp_block_t block_type);</span><br=
><span> </span><br><span> bool win_wfp_uninit(const NET_IFINDEX index, cons=
t HANDLE msg_channel);</span><br><span> </span><br><span>diff --git a/src/o=
penvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>in=
dex ad19e2c..58040a2 100644</span><br><span>--- a/src/openvpnserv/interacti=
ve.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@=
 -791,12 +791,10 @@</span><br><span>     wfp_block_data_t *block_data =3D N=
ULL;</span><br><span>     HANDLE engine =3D NULL;</span><br><span>     LPCW=
STR exe_path;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BOOL=
 dns_only;</span><br><span> </span><br><span>     exe_path =3D settings.exe=
_path;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dns_only =
=3D (msg-&gt;flags =3D=3D wfp_block_dns);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    err =3D add_wfp_block_filters(&am=
p;engine, msg-&gt;iface.index, exe_path, BlockDNSErrHandler, dns_only);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D add_wfp_blo=
ck_filters(&amp;engine, msg-&gt;iface.index, exe_path, BlockDNSErrHandler, =
msg-&gt;block_type);</span><br><span>     if (!err)</span><br><span>     {<=
/span><br><span>         block_data =3D malloc(sizeof(wfp_block_data_t));</=
span><br><span>@@ -854,6 +852,10 @@</span><br><span> static DWORD</span><br=
><span> HandleWfpBlockMessage(const wfp_block_message_t *msg, undo_lists_t =
*lists)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (msg-&gt;block_type &gt;=3D 0 &amp;&amp; msg-&gt;block_type &=
lt; wfp_block_type_count)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return ERROR_MESSAGE_DATA;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span>     if (msg-&gt;header.type =3D=3D msg_add_wf=
p_block)</span><br><span>     {</span><br><span>         return AddWfpBlock=
(msg, lists);</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">change 1541</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f94=
1f9cc2241cdb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1541 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--1uFfbYuGpc0=--

