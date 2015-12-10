From: ValdikSS <iam@...2070...>
Date: Thu, 10 Dec 2015 23:51:55 +0300
Message-Id: <1449780715-4027-1-git-send-email-iam@...2070...>
In-Reply-To: <CAKuzo_i6Q_13D3pV5QW58MQ-5ybC9JU7qCTLKybpQ0yZvNzghw@...278...>
References: <CAKuzo_i6Q_13D3pV5QW58MQ-5ybC9JU7qCTLKybpQ0yZvNzghw@...278...>
Subject: [Openvpn-devel] [PATCH v9-master] Add Windows DNS Leak fix using
	WFP ('block-outside-dns')
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
To: openvpn-devel@lists.sourceforge.net

This option blocks all out-of-tunnel communication on TCP/UDP port 53 (except
for OpenVPN itself), preventing DNS Leaks on Windows 8.1 and 10.
---
 doc/openvpn.8               |  12 ++-
 src/openvpn/Makefile.am     |   2 +-
 src/openvpn/init.c          |  17 ++++
 src/openvpn/openvpn.vcxproj |   4 +-
 src/openvpn/options.c       |  10 +++
 src/openvpn/options.h       |   1 +
 src/openvpn/win32.c         | 211 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/win32.h         |   3 +
 8 files changed, 255 insertions(+), 5 deletions(-)
 mode change 100755 => 100644 src/openvpn/openvpn.vcxproj

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 9889540..7e73073 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1129,8 +1129,8 @@ When used with
 .B \-\-client
 or
 .B \-\-pull,
-accept options pushed by server EXCEPT for routes and dhcp options
-like DNS servers.
+accept options pushed by server EXCEPT for routes, block-outside-dns and dhcp
+options like DNS servers.
 
 When used on the client, this option effectively bars the
 server from adding routes to the client's routing table,
@@ -5574,6 +5574,14 @@ adapter list to the syslog or log file after the TUN/TAP adapter
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
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index c840f16..c55a520 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -127,5 +127,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4
 endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c5c0ab6..9f3da60 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1468,6 +1468,15 @@ do_open_tun (struct context *c)
 		   "up",
 		   c->c2.es);
 
+#if defined(WIN32)
+      if (c->options.block_outside_dns)
+      {
+        dmsg (D_LOW, "Blocking outside DNS");
+        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
+            msg (M_FATAL, "Blocking DNS failed!");
+      }
+#endif
+
       /* possibly add routes */
       if ((route_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
 	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
@@ -1596,6 +1605,14 @@ do_close_tun (struct context *c, bool force)
 		       "down",
 		       c->c2.es);
 
+#if defined(WIN32)
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
index b117b0b..821c46c
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -64,7 +64,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
@@ -89,7 +89,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 36290a0..4b98275 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -704,6 +704,9 @@ static const char usage_message[] =
   "                       optional parameter controls the initial state of ex.\n"
   "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
   "                  after TAP adapter is up and routes have been added.\n"
+#ifdef WIN32
+  "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
+#endif
   "Windows Standalone Options:\n"
   "\n"
   "--show-adapters : Show all TAP-Windows adapters.\n"
@@ -805,6 +808,7 @@ init_options (struct options *o, const bool init_gc)
   o->tuntap_options.dhcp_lease_time = 31536000; /* one year */
   o->tuntap_options.dhcp_masq_offset = 0;       /* use network address as internal DHCP server address */
   o->route_method = ROUTE_METHOD_ADAPTIVE;
+  o->block_outside_dns = false;
 #endif
 #if P2MP_SERVER
   o->real_hash_size = 256;
@@ -1673,6 +1677,7 @@ show_settings (const struct options *o)
 #ifdef WIN32
   SHOW_BOOL (show_net_up);
   SHOW_INT (route_method);
+  SHOW_BOOL (block_outside_dns);
   show_tuntap_options (&o->tuntap_options);
 #endif
 #endif
@@ -6192,6 +6197,11 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_IPWIN32);
       options->tuntap_options.register_dns = true;
     }
+  else if (streq (p[0], "block-outside-dns") && !p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_IPWIN32);
+      options->block_outside_dns = true;
+    }
   else if (streq (p[0], "rdns-internal") && !p[1])
      /* standalone method for internal use
       *
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ebc0591..2f6c8b4 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -585,6 +585,7 @@ struct options
   bool exit_event_initial_state;
   bool show_net_up;
   int route_method;
+  bool block_outside_dns;
 #endif
 
   bool use_peer_id;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 1f9bda0..64dc1f7 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -47,6 +47,73 @@
 #include "memdbg.h"
 
 /*
+ * WFP-related defines and GUIDs.
+ */
+#include <fwpmu.h>
+#include <initguid.h>
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
+
+/*
  * Windows internal socket API state (opaque).
  */
 static struct WSAData wsa_state; /* GLOBAL */
@@ -1077,4 +1144,148 @@ win_get_tempdir()
   WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof (tmpdir), NULL, NULL);
   return tmpdir;
 }
+
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
+    if (ConvertInterfaceIndexToLuid(index, &tapluid) != NO_ERROR)
+    {
+        msg (M_NONFATAL, "Can't convert interface index to LUID");
+        return false;
+    }
+    dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
+
+    /* Get OpenVPN path. */
+    GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
+
+    if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) != ERROR_SUCCESS)
+        return false;
+
+    /* Prepare filter. */
+    Filter.subLayerKey = SubLayer.subLayerKey;
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
+        FwpmEngineClose0(m_hEngineHandle);
+        m_hEngineHandle = NULL;
+    }
+    return true;
+}
+
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
2.6.4


