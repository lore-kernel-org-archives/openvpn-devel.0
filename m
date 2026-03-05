From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 5 Mar 2026 01:42:35 +0000
In-Reply-To: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@...2715...>
References: <gerrit.1771373435000.I0f7237720b0892f5ba0caf60f941f9cc2241cdb6@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fe5acbc25eee30666dab44197ee33fb7d41194e0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X4s2U6ymFds="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X4s2U6ymFds=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1541/3

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
index fdbc678..e70fd6c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -845,6 +845,7 @@
     o->tuntap_options.dhcp_masq_offset =3D 0;
     o->route_method =3D ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns =3D false;
+    o->allow_loopback_dns =3D false;
     o->windows_driver =3D WINDOWS_DRIVER_UNSPECIFIED;
 #endif
     o->vlan_accept =3D VLAN_ALL;
@@ -1950,6 +1951,7 @@
     SHOW_BOOL(show_net_up);
     SHOW_INT(route_method);
     SHOW_BOOL(block_outside_dns);
+    SHOW_BOOL(allow_loopback_dns);
     show_tuntap_options(&o->tuntap_options);
 #endif
 #endif /* ifndef ENABLE_SMALL */
@@ -5167,6 +5169,7 @@
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->block_outside_dns =3D false;
+        options->allow_loopback_dns =3D false;
     }
 #else /* ifdef _WIN32 */
     else if (streq(p[0], "dhcp-option") && !p[1])
@@ -8062,10 +8065,14 @@
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
index 3d8b505..83c20cf 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -691,6 +691,7 @@
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
index ac449fd..1026c78 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1166,7 +1166,7 @@
 }

 static bool
-win_wfp_block_service(bool add, bool dns_only, int index, const HANDLE pip=
e)
+win_wfp_block_service(bool add, const wfp_block_t block_type, int index, c=
onst HANDLE pipe)
 {
     bool ret =3D false;
     ack_message_t ack;
@@ -1174,7 +1174,7 @@

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
@@ -1199,7 +1199,7 @@
 }

 bool
-win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_=
only)
+win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, const wfp=
_block_t block_type)
 {
     WCHAR openvpnpath[MAX_PATH];
     bool ret =3D false;
@@ -1208,7 +1208,7 @@
     if (msg_channel)
     {
         dmsg(D_LOW, "Using service to add WFP block filters");
-        ret =3D win_wfp_block_service(true, dns_only, index, msg_channel);
+        ret =3D win_wfp_block_service(true, block_type, index, msg_channel=
);
         goto out;
     }

@@ -1219,7 +1219,7 @@
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
index 4fa4889..482cb6a 100644
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
+    if (msg->block_type < 0 || msg->block_type >=3D wfp_block_type_count)
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f941f9cc2241cdb6
Gerrit-Change-Number: 1541
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>

--X4s2U6ymFds=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">wfp: add flag to allow DNS t=
raffic to loopback<br><br>Add a flag &#39;allow-loopback&#39; to the --bloc=
k-outside-dns options. When it<br>is set DNS traffic to loopback (localhost=
) will not be blocked. This<br>flag will also allow DNS to localhost when a=
ll local traffic is to be<br>blocked via &#39;--redirect-gateway block-loca=
l&#39;.<br><br>Fixes #703<br><br>Change-Id: I0f7237720b0892f5ba0caf60f941f9=
cc2241cdb6<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>=
M doc/man-sections/windows-options.rst<br>M include/openvpn-msg.h<br>M src/=
openvpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M s=
rc/openvpn/wfp_block.c<br>M src/openvpn/wfp_block.h<br>M src/openvpn/win32.=
c<br>M src/openvpn/win32.h<br>M src/openvpnserv/interactive.c<br>10 files c=
hanged, 118 insertions(+), 59 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1541/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows=
-options.rst</span><br><span>index af2fb45..b31ff2e 100644</span><br><span>=
--- a/doc/man-sections/windows-options.rst</span><br><span>+++ b/doc/man-se=
ctions/windows-options.rst</span><br><span>@@ -10,11 +10,12 @@</span><br><s=
pan>   after a reboot, or if the driver is unloaded and reloaded. This</spa=
n><br><span>   directive can only be used by an administrator.</span><br><s=
pan> </span><br><span>---block-outside-dns</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+--block-outside-dns [allow-loopback]</span><br><span=
>   Block DNS servers on other network adapters to prevent DNS leaks. This<=
/span><br><span>   option prevents any application from accessing TCP or UD=
P port 53 except</span><br><span>   one inside the tunnel. It uses Windows =
Filtering Platform (WFP) and</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  works on Windows Vista or later.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  works on Windows Vista or later. If ``allow-loopbac=
k`` is set, traffic to</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  localhost port 53 is still allowed.</span><br><span> </span><br><span>=
   This option is considered unknown on non-Windows platforms and</span><br=
><span>   unsupported on Windows XP, resulting in fatal error. You may want=
 to use</span><br><span>diff --git a/include/openvpn-msg.h b/include/openvp=
n-msg.h</span><br><span>index a0cec53..58d4ea9 100644</span><br><span>--- a=
/include/openvpn-msg.h</span><br><span>+++ b/include/openvpn-msg.h</span><b=
r><span>@@ -72,9 +72,13 @@</span><br><span> </span><br><span> typedef enum<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 wfp_block_local =3D 1 &lt;&lt; 0,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    wfp_block_dns =3D 1 &lt;&lt; 1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-} wfp_block_flags_t;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    wfp_block_all,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    wfp_block_all_except_local_dns,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_dns,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_dns_except_local,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_type_cou=
nt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_no=
ne =3D -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} wfp_bloc=
k_t;</span><br><span> </span><br><span> typedef struct</span><br><span> {</=
span><br><span>@@ -162,7 +166,7 @@</span><br><span> typedef struct</span><b=
r><span> {</span><br><span>     message_header_t header;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    wfp_block_flags_t flags;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    wfp_block_t block_type;</sp=
an><br><span>     interface_t iface;</span><br><span> } wfp_block_message_t=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/init.c b/src/o=
penvpn/init.c</span><br><span>index 1391aa85..19ddece 100644</span><br><spa=
n>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><=
br><span>@@ -1771,12 +1771,14 @@</span><br><span> {</span><br><span> #if de=
fined(_WIN32)</span><br><span>     /* Fortify &#39;redirect-gateway block-l=
ocal&#39; with firewall rules? */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool block_local =3D block_local_needed(c-&gt;c1.route_list=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool bl=
ock_local =3D block_local_needed(c-&gt;c1.route_list);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const bool block_outside_dns =3D c-&=
gt;options.block_outside_dns;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const bool allow_loopback_dns =3D c-&gt;options.allow_loopbac=
k_dns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const wfp=
_block_t block_type =3D get_wfp_block_type(block_local, block_outside_dns, =
allow_loopback_dns);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (c-&gt;options.block_outside_dns || block_local)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (block_type !=
=3D wfp_block_none)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        BOOL dns_only =3D !block_local;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (!win_wfp_block(c-&gt;c1.=
tuntap-&gt;adapter_index, c-&gt;options.msg_channel, dns_only))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!win_wfp_block(c-&g=
t;c1.tuntap-&gt;adapter_index, c-&gt;options.msg_channel, block_type))</spa=
n><br><span>         {</span><br><span>             msg(M_FATAL, &quot;WFP:=
 initialization failed&quot;);</span><br><span>         }</span><br><span>@=
@ -1796,7 +1798,11 @@</span><br><span> del_wfp_block(struct context *c, uns=
igned long adapter_index)</span><br><span> {</span><br><span> #if defined(_=
WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;o=
ptions.block_outside_dns || block_local_needed(c-&gt;c1.route_list))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool block_local=
 =3D block_local_needed(c-&gt;c1.route_list);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const bool block_outside_dns =3D c-&gt;option=
s.block_outside_dns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const wfp_block_t block_type =3D get_wfp_block_type(block_local, block=
_outside_dns, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (block_typ=
e !=3D wfp_block_none)</span><br><span>     {</span><br><span>         if (=
!win_wfp_uninit(adapter_index, c-&gt;options.msg_channel))</span><br><span>=
         {</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn=
/options.c</span><br><span>index fdbc678..e70fd6c 100644</span><br><span>--=
- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span=
><br><span>@@ -845,6 +845,7 @@</span><br><span>     o-&gt;tuntap_options.dh=
cp_masq_offset =3D 0;</span><br><span>     o-&gt;route_method =3D ROUTE_MET=
HOD_ADAPTIVE;</span><br><span>     o-&gt;block_outside_dns =3D false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;allow_loopback_=
dns =3D false;</span><br><span>     o-&gt;windows_driver =3D WINDOWS_DRIVER=
_UNSPECIFIED;</span><br><span> #endif</span><br><span>     o-&gt;vlan_accep=
t =3D VLAN_ALL;</span><br><span>@@ -1950,6 +1951,7 @@</span><br><span>     =
SHOW_BOOL(show_net_up);</span><br><span>     SHOW_INT(route_method);</span>=
<br><span>     SHOW_BOOL(block_outside_dns);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    SHOW_BOOL(allow_loopback_dns);</span><br><span=
>     show_tuntap_options(&amp;o-&gt;tuntap_options);</span><br><span> #end=
if</span><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span>@@ -51=
67,6 +5169,7 @@</span><br><span>     {</span><br><span>         VERIFY_PERM=
ISSION(OPT_P_DHCPDNS);</span><br><span>         options-&gt;block_outside_d=
ns =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  options-&gt;allow_loopback_dns =3D false;</span><br><span>     }</span><b=
r><span> #else /* ifdef _WIN32 */</span><br><span>     else if (streq(p[0],=
 &quot;dhcp-option&quot;) &amp;&amp; !p[1])</span><br><span>@@ -8062,10 +80=
65,14 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><=
br><span>         options-&gt;tuntap_options.register_dns =3D true;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se if (streq(p[0], &quot;block-outside-dns&quot;) &amp;&amp; !p[1])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &q=
uot;block-outside-dns&quot;) &amp;&amp; !p[2])</span><br><span>     {</span=
><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span>     =
    options-&gt;block_outside_dns =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (p[1] &amp;&amp; streq(p[1], &quot;allow=
-loopback&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
options-&gt;allow_loopback_dns =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;rdns-internal&quot;) &amp;&amp; !p[1])</span><br=
><span>     /* standalone method for internal use</span><br><span>diff --gi=
t a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 3d8=
b505..83c20cf 100644</span><br><span>--- a/src/openvpn/options.h</span><br>=
<span>+++ b/src/openvpn/options.h</span><br><span>@@ -691,6 +691,7 @@</span=
><br><span>     bool show_net_up;</span><br><span>     int route_method;</s=
pan><br><span>     bool block_outside_dns;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool allow_loopback_dns;</span><br><span>     en=
um tun_driver_type windows_driver;</span><br><span> #endif</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_bl=
ock.c</span><br><span>index 212a4b2..6640178 100644</span><br><span>--- a/s=
rc/openvpn/wfp_block.c</span><br><span>+++ b/src/openvpn/wfp_block.c</span>=
<br><span>@@ -131,27 +131,10 @@</span><br><span>     return err;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Block outgo=
ing local traffic, possibly DNS only, except for</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * (i) adapter with the specified index (and loo=
pback, if all is blocked)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * OR</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (ii) proc=
esses with the specified executable path</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * The firewall filters added here are automatically rem=
oved when the process exits or</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * on calling delete_wfp_block_filters().</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Arguments:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *   engine_handle : On successful return contains the=
 handle for a newly opened fwp session</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *                   in which the filters are added.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *                   May be=
 closed by passing to delete_wfp_block_filters to remove the filters.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *   index         : The in=
dex of adapter for which traffic is permitted.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *   exe_path      : Path of executable for which =
traffic is permitted.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *   msg_handler   : An optional callback function for error reporting.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *   dns_only      : Whet=
her the blocking filters should apply for DNS only.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Returns 0 on success, a non-zero status =
code of the last failed action on failure.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- */</span><br><span> </span><br><span> DWORD</span><br=
><span> add_wfp_block_filters(HANDLE *engine_handle, int index, const WCHAR=
 *exe_path,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
            wfp_block_msg_handler_t msg_handler, BOOL dns_only)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                      wfp_block=
_msg_handler_t msg_handler, const wfp_block_t block_type)</span><br><span> =
{</span><br><span>     FWPM_SESSION0 session =3D { 0 };</span><br><span>   =
  FWPM_SUBLAYER0 *sublayer_ptr =3D NULL;</span><br><span>@@ -247,7 +230,7 @=
@</span><br><span>     Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;<=
/span><br><span>     Filter.action.type =3D FWP_ACTION_PERMIT;</span><br><s=
pan>     Condition[0] =3D match_openvpn;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (dns_only)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (block_type =3D=3D wfp_block_dns || block_type =3D=
=3D wfp_block_dns_except_local)</span><br><span>     {</span><br><span>    =
     Filter.numFilterConditions =3D 2;</span><br><span>         Condition[1=
] =3D match_port_53;</span><br><span>@@ -268,7 +251,7 @@</span><br><span>  =
   Filter.weight.type =3D FWP_EMPTY;</span><br><span>     Filter.numFilterC=
onditions =3D 1;</span><br><span>     Condition[0] =3D match_not_loopback;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dns_only)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (block_type =3D=
=3D wfp_block_dns || block_type =3D=3D wfp_block_dns_except_local)</span><b=
r><span>     {</span><br><span>         Filter.numFilterConditions =3D 2;</=
span><br><span>         Condition[1] =3D match_port_53;</span><br><span>@@ =
-292,7 +275,7 @@</span><br><span>     Filter.action.type =3D FWP_ACTION_PER=
MIT;</span><br><span>     Filter.numFilterConditions =3D 1;</span><br><span=
>     Condition[0] =3D match_interface;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (dns_only)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (block_type =3D=3D wfp_block_dns || block_type =3D=
=3D wfp_block_dns_except_local)</span><br><span>     {</span><br><span>    =
     Filter.numFilterConditions =3D 2;</span><br><span>         Condition[1=
] =3D match_port_53;</span><br><span>@@ -308,20 +291,23 @@</span><br><span>=
 </span><br><span>     msg_handler(0, &quot;WFP Block: Added permit filters=
 for VPN interface&quot;);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* Seventh Filter. Block IPv4 DNS requests to lo=
opback from other apps */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    Filter.action.type =3D FWP_ACTION=
_BLOCK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Filter.wei=
ght.type =3D FWP_EMPTY;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    Filter.numFilterConditions =3D 2;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    Condition[0] =3D match_loopback;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    Condition[1] =3D match_port_53;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D FwpmFilterAdd0(*=
engine_handle, &amp;Filter, NULL, &amp;filterid);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    OUT_ON_ERROR(err, &quot;Add filter to block=
 IPv4 DNS traffic to loopback failed&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (block_type !=3D wfp_block_all_except_local=
_dns &amp;&amp; block_type !=3D wfp_block_dns_except_local)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Seventh Filter. Block IPv4 DNS request=
s to loopback from other apps */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        Filter.action.=
type =3D FWP_ACTION_BLOCK;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        Filter.weight.type =3D FWP_EMPTY;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        Filter.numFilterConditions =3D 2;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        Condition[0] =3D=
 match_loopback;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     Condition[1] =3D match_port_53;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        err =3D FwpmFilterAdd0(*engine_handle, &amp;Filter=
, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        OUT_ON_ERROR(err, &quot;Add filter to block IPv4 DNS traffic to=
 loopback failed&quot;);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* Eighth Filter. Block IPv6 DNS requests to loopb=
ack from other apps */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    err =3D FwpmFilterAdd0(*engine_handl=
e, &amp;Filter, NULL, &amp;filterid);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    OUT_ON_ERROR(err, &quot;Add filter to block IPv6 DNS tr=
affic to loopback failed&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* Eighth Filter. Block IPv6 DNS requests to loopback =
from other apps */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        err =3D FwpmFilterAdd0(*engi=
ne_handle, &amp;Filter, NULL, &amp;filterid);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        OUT_ON_ERROR(err, &quot;Add filter to blo=
ck IPv6 DNS traffic to loopback failed&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     msg=
_handler(0, &quot;WFP Block: Added block filters for DNS traffic to loopbac=
k&quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/wfp_bl=
ock.h b/src/openvpn/wfp_block.h</span><br><span>index 8bc093a..2f28751 1006=
44</span><br><span>--- a/src/openvpn/wfp_block.h</span><br><span>+++ b/src/=
openvpn/wfp_block.h</span><br><span>@@ -28,18 +28,46 @@</span><br><span> #i=
nclude &lt;windef.h&gt;</span><br><span> #include &lt;iphlpapi.h&gt;</span>=
<br><span> #include &lt;ws2tcpip.h&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;stdbool.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;openvpn-msg.h&quot;</span><br><span> </span><br><span=
> /* Any value less than 5 should work fine. 3 is chosen without any real r=
eason. */</span><br><span> #define WFP_BLOCK_IFACE_METRIC 3</span><br><span=
> </span><br><span> typedef void (*wfp_block_msg_handler_t)(DWORD err, cons=
t char *msg);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-delete=
_wfp_block_filters(HANDLE engine);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Block outgoing loca=
l traffic, possibly DNS only, except for</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * (i) adapter with the specified index (and loopback,=
 if all is blocked)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (ii) proces=
ses with the specified executable path</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * The firewall filters added here are automatically rem=
oved when the process exits or</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * on calling \ref delete_wfp_block_filters().</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param engine_handle On successful return contains =
the handle for a newly opened fwp</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                      session in which the filters are adde=
d. May be closed by passing</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                      to \ref delete_wfp_block_filters() to remov=
e the filters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram index         The index of adapter for which traffic is permitted.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param exe_path     =
 Path of executable for which traffic is permitted.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param msg_handler   An optional callb=
ack function for error reporting.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param block_type    Whether the blocking filters should a=
pply for DNS only.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return ERROR_S=
UCCESS, or a non-zero status code of the last failed action on failure.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> DW=
ORD</span><br><span> add_wfp_block_filters(HANDLE *engine, int iface_index,=
 const WCHAR *exe_path,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                      wfp_block_msg_handler_t msg_handler_callback, BOOL =
dns_only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
             wfp_block_msg_handler_t msg_handler_callback, const wfp_block_=
t block_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Remove the firewall filter rules set =
with \ref add_wfp_block_filters()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param engine        The WFP session handle in which the firewall rules wer=
e added.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return ERROR_SUCCESS, or=
 a non-zero status code of the last failed action on failure.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+DWORD</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+delete_wfp_block_filters(HANDLE engine);</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Return interface metric value for the =
specified interface index.</span><br><span>diff --git a/src/openvpn/win32.c=
 b/src/openvpn/win32.c</span><br><span>index ac449fd..1026c78 100644</span>=
<br><span>--- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32=
.c</span><br><span>@@ -1166,7 +1166,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-win_wfp_block_service(bool add, bool dns_only, int index, const H=
ANDLE pipe)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+win_wfp_=
block_service(bool add, const wfp_block_t block_type, int index, const HAND=
LE pipe)</span><br><span> {</span><br><span>     bool ret =3D false;</span>=
<br><span>     ack_message_t ack;</span><br><span>@@ -1174,7 +1174,7 @@</sp=
an><br><span> </span><br><span>     wfp_block_message_t data =3D { .header =
=3D { (add ? msg_add_wfp_block : msg_del_wfp_block),</span><br><span>      =
                                        sizeof(wfp_block_message_t), 0 },</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
          .flags =3D dns_only ? wfp_block_dns : wfp_block_local,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
   .block_type =3D block_type,</span><br><span>                            =
      .iface =3D { .index =3D index, .name =3D &quot;&quot; } };</span><br>=
<span> </span><br><span>     if (!send_msg_iservice(pipe, &amp;data, sizeof=
(data), &amp;ack, &quot;WFP block&quot;))</span><br><span>@@ -1199,7 +1199,=
7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-win_wfp_block(const NET_IFINDEX i=
ndex, const HANDLE msg_channel, BOOL dns_only)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+win_wfp_block(const NET_IFINDEX index, const HAN=
DLE msg_channel, const wfp_block_t block_type)</span><br><span> {</span><br=
><span>     WCHAR openvpnpath[MAX_PATH];</span><br><span>     bool ret =3D =
false;</span><br><span>@@ -1208,7 +1208,7 @@</span><br><span>     if (msg_c=
hannel)</span><br><span>     {</span><br><span>         dmsg(D_LOW, &quot;U=
sing service to add WFP block filters&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ret =3D win_wfp_block_service(true, dns_onl=
y, index, msg_channel);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ret =3D win_wfp_block_service(true, block_type, index, msg_chan=
nel);</span><br><span>         goto out;</span><br><span>     }</span><br><=
span> </span><br><span>@@ -1219,7 +1219,7 @@</span><br><span>     }</span><=
br><span> </span><br><span>     status =3D</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        add_wfp_block_filters(&amp;m_hEngineHandle, in=
dex, openvpnpath, win_wfp_msg_handler, dns_only);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        add_wfp_block_filters(&amp;m_hEngineH=
andle, index, openvpnpath, win_wfp_msg_handler, block_type);</span><br><spa=
n>     if (status =3D=3D 0)</span><br><span>     {</span><br><span>        =
 int is_auto =3D 0;</span><br><span>diff --git a/src/openvpn/win32.h b/src/=
openvpn/win32.h</span><br><span>index ef32062..d3ef16b 100644</span><br><sp=
an>--- a/src/openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.h</spa=
n><br><span>@@ -289,7 +289,31 @@</span><br><span> /* call self in a subproc=
ess */</span><br><span> void fork_to_self(const char *cmdline);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool win_wfp_bl=
ock(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_only);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Get the wfp block type value accordin=
g to the parameters passed.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Block types are defined in the \ref wfp_block_t enum.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param block_local           Do we need to b=
lock traffic to local adapters</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param block_outside_dns     Do we need to block DNS to local=
 adapters</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
allow_loopback_dns    Do we need to make an exception for DNS to loopback</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return wfp_block_none if no blocki=
ng is needed, or the block type to use</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static inline wfp_block_t</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+get_wfp_block_type(const bool block_local, const bool block_outsid=
e_dns, const bool allow_loopback_dns)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (block_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n allow_loopback_dns ? wfp_block_all_except_local_dns : wfp_block_all;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (block_outside_dns)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return allow_loopback_dns ? wfp_=
block_dns_except_local : wfp_block_dns;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return wfp_block_none;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool win_wfp_block(const=
 NET_IFINDEX index, const HANDLE msg_channel, const wfp_block_t block_type)=
;</span><br><span> </span><br><span> bool win_wfp_uninit(const NET_IFINDEX =
index, const HANDLE msg_channel);</span><br><span> </span><br><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index 4fa4889..482cb6a 100644</span><br><span>--- a/src/openvpnser=
v/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><=
br><span>@@ -791,12 +791,10 @@</span><br><span>     wfp_block_data_t *block=
_data =3D NULL;</span><br><span>     HANDLE engine =3D NULL;</span><br><spa=
n>     LPCWSTR exe_path;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    BOOL dns_only;</span><br><span> </span><br><span>     exe_path =3D s=
ettings.exe_path;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
dns_only =3D (msg-&gt;flags =3D=3D wfp_block_dns);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D add_wfp_block_fi=
lters(&amp;engine, msg-&gt;iface.index, exe_path, BlockDNSErrHandler, dns_o=
nly);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D ad=
d_wfp_block_filters(&amp;engine, msg-&gt;iface.index, exe_path, BlockDNSErr=
Handler, msg-&gt;block_type);</span><br><span>     if (!err)</span><br><spa=
n>     {</span><br><span>         block_data =3D malloc(sizeof(wfp_block_da=
ta_t));</span><br><span>@@ -854,6 +852,10 @@</span><br><span> static DWORD<=
/span><br><span> HandleWfpBlockMessage(const wfp_block_message_t *msg, undo=
_lists_t *lists)</span><br><span> {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (msg-&gt;block_type &lt; 0 || msg-&gt;block_type &gt=
;=3D wfp_block_type_count)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return ERROR_MESSAGE_DATA;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span>     if (msg-&gt;header.type =3D=3D msg_add_w=
fp_block)</span><br><span>     {</span><br><span>         return AddWfpBloc=
k(msg, lists);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail">change 1541</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1541?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f7237720b0892f5ba0caf60f94=
1f9cc2241cdb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1541 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>

</body></html>=

--X4s2U6ymFds=--

