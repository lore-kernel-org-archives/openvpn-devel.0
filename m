From: ValdikSS <iam@...2070...>
Date: Wed, 25 Nov 2015 21:56:21 +0300
Message-Id: <1448477781-21564-1-git-send-email-iam@...2070...>
In-Reply-To: <20151125082651.GT24952@...1296...>
References: <20151125082651.GT24952@...1296...>
Subject: [Openvpn-devel] [PATCH v5-2.3] Add Windows DNS Leak fix using WFP
	('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, gert@...1296...

This option blocks all out-of-tunnel communication on TCP/UDP port 53 (except
for OpenVPN itself), preventing DNS Leaks on Windows 8.1 and 10.
---
 doc/openvpn.8               |  12 ++-
 src/openvpn/init.c          |  17 ++++
 src/openvpn/openvpn.vcxproj |   0
 src/openvpn/options.c       |  16 ++++
 src/openvpn/options.h       |   1 +
 src/openvpn/win32.c         | 215 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/win32.h         |   3 +
 7 files changed, 262 insertions(+), 2 deletions(-)
 mode change 100755 => 100644 src/openvpn/openvpn.vcxproj

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 46c1e0c..95aafdd 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1119,8 +1119,8 @@ When used with
 .B \-\-client
 or
 .B \-\-pull,
-accept options pushed by server EXCEPT for routes and dhcp options
-like DNS servers.
+accept options pushed by server EXCEPT for routes, block-outside-dns and dhcp
+options like DNS servers.
 
 When used on the client, this option effectively bars the
 server from adding routes to the client's routing table,
@@ -5454,6 +5454,14 @@ adapter list to the syslog or log file after the TUN/TAP adapter
 has been brought up and any routes have been added.
 .\"*********************************************************
 .TP
+.B \-\-block\-outside\-dns
+Block DNS servers on other network adapters to prevent
+DNS leaks. This option prevents any application from accessing
+TCP or UDP port 53 except one inside the tunnel. It uses
+Windows Filtering Platform (WFP) and works on Windows Vista or
+later.
+.\"*********************************************************
+.TP
 .B \-\-dhcp\-renew
 Ask Windows to renew the TAP adapter lease on startup.
 This option is normally unnecessary, as Windows automatically
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ceef4f7..e8a96c2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1468,6 +1468,15 @@ do_open_tun (struct context *c)
 		   "up",
 		   c->c2.es);
 
+#if _WIN32_WINNT >= 0x0600
+      if (c->options.block_outside_dns)
+      {
+        dmsg (D_LOW, "Blocking outside DNS");
+        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
+            msg (M_FATAL, "Blocking DNS failed!");
+      }
+#endif
+
       /* possibly add routes */
       if (!c->options.route_delay_defined)
 	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
@@ -1594,6 +1603,14 @@ do_close_tun (struct context *c, bool force)
 		       "down",
 		       c->c2.es);
 
+#if _WIN32_WINNT >= 0x0600
+            if (c->options.block_outside_dns)
+            {
+                if (!win_wfp_uninit())
+                    msg (M_FATAL, "Uninitialising WFP failed!");
+            }
+#endif
+
 	  /* actually close tun/tap device based on --down-pre flag */
 	  if (c->options.down_pre)
 	    do_close_tun_simple (c);
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
old mode 100755
new mode 100644
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f609aa6..45c29ba 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -715,6 +715,9 @@ static const char usage_message[] =
   "                       optional parameter controls the initial state of ex.\n"
   "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
   "                  after TAP adapter is up and routes have been added.\n"
+#if _WIN32_WINNT >= 0x0600
+  "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
+#endif
   "Windows Standalone Options:\n"
   "\n"
   "--show-adapters : Show all TAP-Windows adapters.\n"
@@ -814,6 +817,7 @@ init_options (struct options *o, const bool init_gc)
   o->tuntap_options.dhcp_lease_time = 31536000; /* one year */
   o->tuntap_options.dhcp_masq_offset = 0;       /* use network address as internal DHCP server address */
   o->route_method = ROUTE_METHOD_ADAPTIVE;
+  o->block_outside_dns = false;
 #endif
 #if P2MP_SERVER
   o->real_hash_size = 256;
@@ -1678,6 +1682,9 @@ show_settings (const struct options *o)
 #ifdef WIN32
   SHOW_BOOL (show_net_up);
   SHOW_INT (route_method);
+#if _WIN32_WINNT >= 0x0600
+  SHOW_BOOL (block_outside_dns);
+#endif
   show_tuntap_options (&o->tuntap_options);
 #endif
 #endif
@@ -6312,6 +6319,15 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
     }
 #endif
+  else if (streq (p[0], "block-outside-dns") && !p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_IPWIN32);
+#if _WIN32_WINNT >= 0x0600
+      options->block_outside_dns = true;
+#else
+      msg (M_WARN, "NOTE: block-outside-dns option works only on Windows");
+#endif
+    }
 #if PASSTOS_CAPABILITY
   else if (streq (p[0], "passtos"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 40cf71e..622706a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -593,6 +593,7 @@ struct options
   bool exit_event_initial_state;
   bool show_net_up;
   int route_method;
+  bool block_outside_dns;
 #endif
 
   bool use_peer_id;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 5e7f13c..912344a 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -47,6 +47,75 @@
 #include "memdbg.h"
 
 /*
+ * WFP-related defines and GUIDs.
+ */
+#if _WIN32_WINNT >= 0x0600
+#include <fwpmu.h>
+#include <fwpmtypes.h>
+#include <iphlpapi.h>
+
+#ifndef FWPM_SESSION_FLAG_DYNAMIC
+#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
+#endif
+
+// c38d57d1-05a7-4c33-904f-7fbceee60e82
+DEFINE_GUID(
+   FWPM_LAYER_ALE_AUTH_CONNECT_V4,
+   0xc38d57d1,
+   0x05a7,
+   0x4c33,
+   0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
+);
+
+// 4a72393b-319f-44bc-84c3-ba54dcb3b6b4
+DEFINE_GUID(
+   FWPM_LAYER_ALE_AUTH_CONNECT_V6,
+   0x4a72393b,
+   0x319f,
+   0x44bc,
+   0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
+);
+
+// d78e1e87-8644-4ea5-9437-d809ecefc971
+DEFINE_GUID(
+   FWPM_CONDITION_ALE_APP_ID,
+   0xd78e1e87,
+   0x8644,
+   0x4ea5,
+   0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
+);
+
+// c35a604d-d22b-4e1a-91b4-68f674ee674b
+DEFINE_GUID(
+   FWPM_CONDITION_IP_REMOTE_PORT,
+   0xc35a604d,
+   0xd22b,
+   0x4e1a,
+   0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
+);
+
+// 4cd62a49-59c3-4969-b7f3-bda5d32890a4
+DEFINE_GUID(
+   FWPM_CONDITION_IP_LOCAL_INTERFACE,
+   0x4cd62a49,
+   0x59c3,
+   0x4969,
+   0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
+);
+
+/*
+ * WFP firewall name.
+ */
+WCHAR * FIREWALL_NAME = L"OpenVPN"; /* GLOBAL */
+
+/*
+ * WFP handle and GUID.
+ */
+static HANDLE m_hEngineHandle = NULL; /* GLOBAL */
+static GUID m_subLayerGUID; /* GLOBAL */
+#endif
+
+/*
  * Windows internal socket API state (opaque).
  */
 static struct WSAData wsa_state; /* GLOBAL */
@@ -1077,4 +1146,150 @@ win_get_tempdir()
   WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof (tmpdir), NULL, NULL);
   return tmpdir;
 }
+
+#if _WIN32_WINNT >= 0x0600
+bool
+win_wfp_add_filter (HANDLE engineHandle,
+                    const FWPM_FILTER0 *filter,
+                    PSECURITY_DESCRIPTOR sd,
+                    UINT64 *id)
+{
+    if (FwpmFilterAdd0(engineHandle, filter, sd, id) != ERROR_SUCCESS)
+    {
+        msg (M_NONFATAL, "Can't add WFP filter");
+        return false;
+    }
+    return true;
+}
+
+bool
+win_wfp_block_dns (const NET_IFINDEX index)
+{
+    CLEAR(m_subLayerGUID);
+    FWPM_SESSION0 session = {0};
+    FWPM_SUBLAYER0 SubLayer = {0};
+    NET_LUID tapluid;
+    UINT64 filterid;
+    WCHAR openvpnpath[MAX_PATH];
+    FWP_BYTE_BLOB *openvpnblob = NULL;
+    FWPM_FILTER0 Filter = {0};
+    FWPM_FILTER_CONDITION0 Condition[2] = {0};
+
+    /* Add temporary filters which don't survive reboots or crashes. */
+    session.flags = FWPM_SESSION_FLAG_DYNAMIC;
+
+    dmsg (D_LOW, "Opening WFP engine");
+
+    if (FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session, &m_hEngineHandle) != ERROR_SUCCESS)
+    {
+        msg (M_NONFATAL, "Can't open WFP engine");
+        return false;
+    }
+
+    if (UuidCreate(&SubLayer.subLayerKey) != NO_ERROR)
+        return false;
+    memcpy(&m_subLayerGUID, &SubLayer.subLayerKey, sizeof(SubLayer.subLayerKey));
+
+    /* Populate packet filter layer information. */
+    SubLayer.displayData.name = FIREWALL_NAME;
+    SubLayer.displayData.description = FIREWALL_NAME;
+    SubLayer.flags = 0;
+    SubLayer.weight = 0x100;
+
+    /* Add packet filter to our interface. */
+    dmsg (D_LOW, "Adding WFP sublayer");
+    if (FwpmSubLayerAdd0(m_hEngineHandle, &SubLayer, NULL) != ERROR_SUCCESS)
+    {
+        msg (M_NONFATAL, "Can't add WFP sublayer");
+        return false;
+    }
+
+    dmsg (D_LOW, "Blocking DNS using WFP");
+    if (ConvertInterfaceIndexToLuid(index, &tapluid) == NO_ERROR)
+        dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
+
+    /* Get OpenVPN path. */
+    GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
+
+    if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) != ERROR_SUCCESS)
+        return false;
+
+    /* Prepare filter. */
+    Filter.subLayerKey = m_subLayerGUID;
+    Filter.displayData.name = FIREWALL_NAME;
+    Filter.weight.type = FWP_EMPTY;
+    Filter.filterCondition = Condition;
+    Filter.numFilterConditions = 2;
+
+    /* First filter. Block IPv4 DNS queries except from OpenVPN itself. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type = FWP_ACTION_BLOCK;
+
+    Condition[0].fieldKey = FWPM_CONDITION_IP_REMOTE_PORT;
+    Condition[0].matchType = FWP_MATCH_EQUAL;
+    Condition[0].conditionValue.type = FWP_UINT16;
+    Condition[0].conditionValue.uint16 = 53;
+
+    Condition[1].fieldKey = FWPM_CONDITION_ALE_APP_ID;
+    Condition[1].matchType = FWP_MATCH_NOT_EQUAL;
+    Condition[1].conditionValue.type = FWP_BYTE_BLOB_TYPE;
+    Condition[1].conditionValue.byteBlob = openvpnblob;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        goto err;
+    dmsg (D_LOW, "Filter (Block IPv4 DNS) added with ID=%I64d", filterid);
+
+    /* Second filter. Block IPv6 DNS queries except from OpenVPN itself. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        goto err;
+    dmsg (D_LOW, "Filter (Block IPv6 DNS) added with ID=%I64d", filterid);
+
+    /* Third filter. Permit IPv4 DNS queries from TAP. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type = FWP_ACTION_PERMIT;
+
+    Condition[1].fieldKey = FWPM_CONDITION_IP_LOCAL_INTERFACE;
+    Condition[1].matchType = FWP_MATCH_EQUAL;
+    Condition[1].conditionValue.type = FWP_UINT64;
+    Condition[1].conditionValue.uint64 = &tapluid.Value;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        goto err;
+    dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with ID=%I64d", filterid);
+
+    /* Forth filter. Permit IPv6 DNS queries from TAP. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        goto err;
+    dmsg (D_LOW, "Filter (Permit IPv6 DNS queries from TAP) added with ID=%I64d", filterid);
+
+    FwpmFreeMemory0((void **)&openvpnblob);
+    return true;
+
+    err:
+        FwpmFreeMemory0((void **)&openvpnblob);
+        return false;
+}
+
+bool
+win_wfp_uninit()
+{
+    dmsg (D_LOW, "Uninitializing WFP");
+    if (m_hEngineHandle) {
+        FwpmSubLayerDeleteByKey0(m_hEngineHandle, &m_subLayerGUID);
+        CLEAR(m_subLayerGUID);
+        FwpmEngineClose0(m_hEngineHandle);
+        m_hEngineHandle = NULL;
+    }
+    return true;
+}
+
+#endif
 #endif
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index cc18f02..a5baebd 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -271,5 +271,8 @@ const char *win_get_tempdir();
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string (const char* utf8, struct gc_arena *gc);
 
+bool win_wfp_block_dns(const NET_IFINDEX index);
+bool win_wfp_uninit();
+
 #endif
 #endif
-- 
2.6.2


