MIME-Version: 1.0
From: Fish Wang <fish.thss@...277...>
Date: Wed, 9 Dec 2015 17:30:14 -0800
Message-ID: <CADCH5OiOnfpf1XZ6HTgJVkFjS8MTcwBTCNdD9m5JKz8U0147jA@...278...>
Content-Type: multipart/alternative; boundary=001a11c1176c35efe30526812755
Subject: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
	agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: iam@...2070...

--001a11c1176c35efe30526812755
Content-Type: text/plain; charset=UTF-8

Based on release/2.3 branch, this patch is cross-compiled in MinGW and
tested on Windows XP/10. The VC project file is left untouched - you might
want to add rpcrt4.lib to compile and link it under MSVC.

Also, I didn't figure out how to keep ValdikSS's authorship of his code in
the patch (sorry :-( ). Definitely no expert in git... Maybe I should
generate a patch on top of his latest patch?

Take ValdikSS<iam@...2070...>'s patch for "block-outside-dns" option
and
make it Windows-version-agnostic. My code is pretty messy right now, will
send
out a secondary patch later after tidying WFP-related code.
---
 doc/openvpn.8               |  12 +-
 src/openvpn/Makefile.am     |   2 +-
 src/openvpn/init.c          |  13 ++
 src/openvpn/openvpn.vcxproj |   0
 src/openvpn/options.c       |  11 +
 src/openvpn/options.h       |   1 +
 src/openvpn/win32.c         | 520
++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/win32.h         |   4 +
 8 files changed, 560 insertions(+), 3 deletions(-)
 mode change 100755 => 100644 src/openvpn/openvpn.vcxproj

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 8968c2e..9e4b01e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1119,8 +1119,8 @@ When used with
 .B \-\-client
 or
 .B \-\-pull,
-accept options pushed by server EXCEPT for routes and dhcp options
-like DNS servers.
+accept options pushed by server EXCEPT for routes, block-outside-dns and
dhcp
+options like DNS servers.

 When used on the client, this option effectively bars the
 server from adding routes to the client's routing table,
@@ -5448,6 +5448,14 @@ adapter list to the syslog or log file after the
TUN/TAP adapter
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
index 2e602f1..149a533 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -123,5 +123,5 @@ openvpn_LDADD = \
  $(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lrpcrt4
-lwinmm
 endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ceef4f7..960535d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1468,6 +1468,13 @@ do_open_tun (struct context *c)
      "up",
      c->c2.es);

+      if (c->options.block_outside_dns)
+      {
+        dmsg (D_LOW, "Blocking outside DNS");
+        if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
+            msg (M_FATAL, "Blocking DNS failed!");
+      }
+
       /* possibly add routes */
       if (!c->options.route_delay_defined)
  do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
@@ -1594,6 +1601,12 @@ do_close_tun (struct context *c, bool force)
          "down",
          c->c2.es);

+            if (c->options.block_outside_dns)
+            {
+                if (!win_wfp_uninit())
+                    msg (M_FATAL, "Uninitialising WFP failed!");
+            }
+
    /* actually close tun/tap device based on --down-pre flag */
    if (c->options.down_pre)
      do_close_tun_simple (c);
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
old mode 100755
new mode 100644
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f609aa6..564e670 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -715,6 +715,7 @@ static const char usage_message[] =
   "                       optional parameter controls the initial state of
ex.\n"
   "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net
adapter list\n"
   "                  after TAP adapter is up and routes have been added.\n"
+  "--block-outside-dns   : Block DNS on other network adapters to prevent
DNS leaks\n"
   "Windows Standalone Options:\n"
   "\n"
   "--show-adapters : Show all TAP-Windows adapters.\n"
@@ -814,6 +815,7 @@ init_options (struct options *o, const bool init_gc)
   o->tuntap_options.dhcp_lease_time = 31536000; /* one year */
   o->tuntap_options.dhcp_masq_offset = 0;       /* use network address as
internal DHCP server address */
   o->route_method = ROUTE_METHOD_ADAPTIVE;
+  o->block_outside_dns = false;
 #endif
 #if P2MP_SERVER
   o->real_hash_size = 256;
@@ -1678,6 +1680,7 @@ show_settings (const struct options *o)
 #ifdef WIN32
   SHOW_BOOL (show_net_up);
   SHOW_INT (route_method);
+  SHOW_BOOL (block_outside_dns);
   show_tuntap_options (&o->tuntap_options);
 #endif
 #endif
@@ -6241,6 +6244,14 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_IPWIN32);
       options->tuntap_options.register_dns = true;
     }
+  else if (streq (p[0], "block-outside-dns") && !p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_IPWIN32);
+      if (win_wfp_init_funcs())
+      {
+        options->block_outside_dns = true;
+      }
+    }
   else if (streq (p[0], "rdns-internal"))
      /* standalone method for internal use
       *
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
index 5e7f13c..55eec95 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -47,6 +47,74 @@
 #include "memdbg.h"

 /*
+ * WFP-related defines and GUIDs.
+ */
+// #include <fwpmu.h>
+#include <initguid.h>
+// #include <fwpmtypes.h>
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
+
+/*
  * Windows internal socket API state (opaque).
  */
 static struct WSAData wsa_state; /* GLOBAL */
@@ -1077,4 +1145,456 @@ win_get_tempdir()
   WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof (tmpdir),
NULL, NULL);
   return tmpdir;
 }
+
+/* From fwptypes.h */
+
+#define FWP_ACTION_FLAG_TERMINATING     (0x00001000)
+#define FWP_ACTION_FLAG_NON_TERMINATING (0x00002000)
+
+#define FWP_ACTION_BLOCK  (0x1 | FWP_ACTION_FLAG_TERMINATING)
+#define FWP_ACTION_PERMIT (0x2 | FWP_ACTION_FLAG_TERMINATING)
+
+typedef UINT32 FWP_ACTION_TYPE;
+
+typedef enum FWP_DATA_TYPE_ {
+    FWP_EMPTY = 0,
+    FWP_UINT8 = 1,
+    FWP_UINT16 = 2,
+    FWP_UINT32 = 3,
+    FWP_UINT64 = 4,
+    FWP_INT8 = 5,
+    FWP_INT16 = 6,
+    FWP_INT32 = 7,
+    FWP_INT64 = 8,
+    FWP_FLOAT = 9,
+    FWP_DOUBLE = 10,
+    FWP_BYTE_ARRAY16_TYPE = 11,
+    FWP_BYTE_BLOB_TYPE = 12,
+    FWP_SID = 13,
+    FWP_SECURITY_DESCRIPTOR_TYPE = 14,
+    FWP_TOKEN_INFORMATION_TYPE = 15,
+    FWP_TOKEN_ACCESS_INFORMATION_TYPE = 16,
+    FWP_UNICODE_STRING_TYPE = 17,
+    FWP_BYTE_ARRAY6_TYPE = 18,
+    FWP_SINGLE_DATA_TYPE_MAX = 0xff,
+    FWP_V4_ADDR_MASK = 0x100,
+    FWP_V6_ADDR_MASK = 0x101,
+    FWP_RANGE_TYPE = 0x102,
+    FWP_DATA_TYPE_MAX = 0x103
+} FWP_DATA_TYPE;
+
+typedef enum FWP_MATCH_TYPE_ {
+    FWP_MATCH_EQUAL = 0,
+    FWP_MATCH_GREATER = 1,
+    FWP_MATCH_LESS = 2,
+    FWP_MATCH_GREATER_OR_EQUAL = 3,
+    FWP_MATCH_LESS_OR_EQUAL = 4,
+    FWP_MATCH_RANGE = 5,
+    FWP_MATCH_FLAGS_ALL_SET = 6,
+    FWP_MATCH_FLAGS_ANY_SET = 7,
+    FWP_MATCH_FLAGS_NONE_SET = 8,
+    FWP_MATCH_EQUAL_CASE_INSENSITIVE = 9,
+    FWP_MATCH_NOT_EQUAL = 10,
+    FWP_MATCH_TYPE_MAX = 11
+} FWP_MATCH_TYPE;
+
+typedef struct FWP_BYTE_ARRAY6_ {
+    UINT8 byteArray6[6];
+} FWP_BYTE_ARRAY6;
+
+typedef struct FWP_BYTE_ARRAY16_ {
+    UINT8 byteArray16[16];
+} FWP_BYTE_ARRAY16;
+
+typedef struct FWP_BYTE_BLOB_ {
+    UINT32 size;
+    UINT8 *data;
+} FWP_BYTE_BLOB;
+
+typedef struct FWP_TOKEN_INFORMATION_ {
+    ULONG sidCount;
+    PSID_AND_ATTRIBUTES sids;
+    ULONG restrictedSidCount;
+    PSID_AND_ATTRIBUTES restrictedSids;
+} FWP_TOKEN_INFORMATION;
+
+typedef struct FWP_VALUE0_ {
+    FWP_DATA_TYPE type;
+    __C89_NAMELESS union {
+        UINT8 uint8;
+        UINT16 uint16;
+        UINT32 uint32;
+        UINT64 *uint64;
+        INT8 int8;
+        INT16 int16;
+        INT32 int32;
+        INT64 *int64;
+        float float32;
+        double *double64;
+        FWP_BYTE_ARRAY16 *byteArray16;
+        FWP_BYTE_BLOB *byteBlob;
+        SID *sid;
+        FWP_BYTE_BLOB *sd;
+        FWP_TOKEN_INFORMATION *tokenInformation;
+        FWP_BYTE_BLOB *tokenAccessInformation;
+        LPWSTR unicodeString;
+        FWP_BYTE_ARRAY6 *byteArray6;
+    } __C89_NAMELESSUNIONNAME;
+} FWP_VALUE0;
+
+typedef struct FWP_V4_ADDR_AND_MASK_ {
+    UINT32 addr;
+    UINT32 mask;
+} FWP_V4_ADDR_AND_MASK;
+
+typedef struct FWP_V6_ADDR_AND_MASK_ {
+    UINT8 addr[16];
+    UINT8 prefixLength;
+} FWP_V6_ADDR_AND_MASK;
+
+typedef struct FWP_RANGE0_ {
+    FWP_VALUE0 valueLow;
+    FWP_VALUE0 valueHigh;
+} FWP_RANGE0;
+
+typedef struct FWP_CONDITION_VALUE0_ {
+    FWP_DATA_TYPE type;
+    __C89_NAMELESS union {
+        UINT8 uint8;
+        UINT16 uint16;
+        UINT32 uint32;
+        UINT64 *uint64;
+        INT8 int8;
+        INT16 int16;
+        INT32 int32;
+        INT64 *int64;
+        float float32;
+        double *double64;
+        FWP_BYTE_ARRAY16 *byteArray16;
+        FWP_BYTE_BLOB *byteBlob;
+        SID *sid;
+        FWP_BYTE_BLOB *sd;
+        FWP_TOKEN_INFORMATION *tokenInformation;
+        FWP_BYTE_BLOB *tokenAccessInformation;
+        LPWSTR unicodeString;
+        FWP_BYTE_ARRAY6 *byteArray6;
+        FWP_V4_ADDR_AND_MASK *v4AddrMask;
+        FWP_V6_ADDR_AND_MASK *v6AddrMask;
+        FWP_RANGE0 *rangeValue;
+    } __C89_NAMELESSUNIONNAME;
+} FWP_CONDITION_VALUE0;
+
+typedef struct FWPM_DISPLAY_DATA0_ {
+    wchar_t *name;
+    wchar_t *description;
+} FWPM_DISPLAY_DATA0;
+
+/* From fwpmtypes.h */
+
+typedef struct FWPM_ACTION0_ {
+  FWP_ACTION_TYPE type;
+  __C89_NAMELESS union {
+    GUID filterType;
+    GUID calloutKey;
+  };
+} FWPM_ACTION0;
+
+typedef struct FWPM_SESSION0_ {
+  GUID               sessionKey;
+  FWPM_DISPLAY_DATA0 displayData;
+  UINT32             flags;
+  UINT32             txnWaitTimeoutInMSec;
+  DWORD              processId;
+  SID                *sid;
+  wchar_t            *username;
+  WINBOOL            kernelMode;
+} FWPM_SESSION0;
+
+typedef struct FWPM_SUBLAYER0_ {
+  GUID               subLayerKey;
+  FWPM_DISPLAY_DATA0 displayData;
+  UINT16             flags;
+  GUID               *providerKey;
+  FWP_BYTE_BLOB      providerData;
+  UINT16             weight;
+} FWPM_SUBLAYER0;
+
+typedef struct FWPM_FILTER_CONDITION0_ {
+  GUID                 fieldKey;
+  FWP_MATCH_TYPE       matchType;
+  FWP_CONDITION_VALUE0 conditionValue;
+} FWPM_FILTER_CONDITION0;
+
+typedef struct FWPM_FILTER0_ {
+  GUID                   filterKey;
+  FWPM_DISPLAY_DATA0     displayData;
+  UINT32                 flags;
+  GUID                   *providerKey;
+  FWP_BYTE_BLOB          providerData;
+  GUID                   layerKey;
+  GUID                   subLayerKey;
+  FWP_VALUE0             weight;
+  UINT32                 numFilterConditions;
+  FWPM_FILTER_CONDITION0 *filterCondition;
+  FWPM_ACTION0           action;
+  __C89_NAMELESS union {
+    UINT64 rawContext;
+    GUID   providerContextKey;
+  };
+  GUID                   *reserved;
+  UINT64                 filterId;
+  FWP_VALUE0             effectiveWeight;
+} FWPM_FILTER0;
+
+#include <rpc.h>
+#include <rpcdce.h>
+
+/* Typedefs of WFP functions */
+
+#define NETIO_STATUS DWORD
+
+typedef NETIO_STATUS WINAPI *(*func_ConvertInterfaceIndexToLuid)(
+  NET_IFINDEX InterfaceIndex,
+  PNET_LUID InterfaceLuid
+);
+
+typedef DWORD WINAPI *(*func_FwpmEngineOpen0)(
+  const wchar_t *serverName,
+  UINT32 authnService,
+  SEC_WINNT_AUTH_IDENTITY_W *authIdentity,
+  const FWPM_SESSION0 *session,
+  HANDLE *engineHandle
+);
+
+typedef DWORD WINAPI *(*func_FwpmEngineClose0)(
+  HANDLE engineHandle
+);
+
+typedef DWORD WINAPI *(*func_FwpmFilterAdd0)(
+  HANDLE engineHandle,
+  const FWPM_FILTER0 *filter,
+  PSECURITY_DESCRIPTOR sd,
+  UINT64 *id
+);
+
+typedef DWORD WINAPI *(*func_FwpmSubLayerAdd0)(
+  HANDLE engineHandle,
+  const FWPM_SUBLAYER0 *subLayer,
+  PSECURITY_DESCRIPTOR sd
+);
+
+typedef DWORD WINAPI *(*func_FwpmSubLayerDeleteByKey0)(
+  HANDLE engineHandle,
+  const GUID *key
+);
+
+typedef void WINAPI *(*func_FwpmFreeMemory0)(
+  void **p
+);
+
+typedef DWORD WINAPI *(*func_FwpmGetAppIdFromFileName0)(
+  const wchar_t *fileName,
+  FWP_BYTE_BLOB **appId
+);
+
+/* WFP function pointers */
+func_ConvertInterfaceIndexToLuid ConvertInterfaceIndexToLuid = NULL;
+func_FwpmEngineOpen0 FwpmEngineOpen0 = NULL;
+func_FwpmEngineClose0 FwpmEngineClose0 = NULL;
+func_FwpmFilterAdd0 FwpmFilterAdd0 = NULL;
+func_FwpmSubLayerAdd0 FwpmSubLayerAdd0 = NULL;
+func_FwpmSubLayerDeleteByKey0 FwpmSubLayerDeleteByKey0 = NULL;
+func_FwpmFreeMemory0 FwpmFreeMemory0 = NULL;
+func_FwpmGetAppIdFromFileName0 FwpmGetAppIdFromFileName0 = NULL;
+
+bool
+win_wfp_init_funcs ()
+{
+  /* Initialize all WFP-related function pointers */
+  HMODULE iphlpapiHandle = LoadLibrary("iphlpapi.dll");
+  if (iphlpapiHandle == NULL)
+  {
+    msg (M_NONFATAL, "Can't load iphlpapi.dll");
+    return false;
+  }
+
+  HMODULE fwpuclntHandle = LoadLibrary("fwpuclnt.dll");
+  if (fwpuclntHandle == NULL)
+  {
+    msg (M_NONFATAL, "Can't load fwpuclnt.dll");
+    return false;
+  }
+
+  ConvertInterfaceIndexToLuid =
(func_ConvertInterfaceIndexToLuid)GetProcAddress(iphlpapiHandle,
"ConvertInterfaceIndexToLuid");
+  FwpmFilterAdd0 = (func_FwpmFilterAdd0)GetProcAddress(fwpuclntHandle,
"FwpmFilterAdd0");
+  FwpmEngineOpen0 = (func_FwpmEngineOpen0)GetProcAddress(fwpuclntHandle,
"FwpmEngineOpen0");
+  FwpmEngineClose0 = (func_FwpmEngineClose0)GetProcAddress(fwpuclntHandle,
"FwpmEngineClose0");
+  FwpmSubLayerAdd0 = (func_FwpmSubLayerAdd0)GetProcAddress(fwpuclntHandle,
"FwpmSubLayerAdd0");
+  FwpmSubLayerDeleteByKey0 =
(func_FwpmSubLayerDeleteByKey0)GetProcAddress(fwpuclntHandle,
"FwpmSubLayerDeleteByKey0");
+  FwpmFreeMemory0 = (func_FwpmFreeMemory0)GetProcAddress(fwpuclntHandle,
"FwpmFreeMemory0");
+  FwpmGetAppIdFromFileName0 =
(func_FwpmGetAppIdFromFileName0)GetProcAddress(fwpuclntHandle,
"FwpmGetAppIdFromFileName0");
+
+  if (!ConvertInterfaceIndexToLuid ||
+      !FwpmFilterAdd0 ||
+      !FwpmEngineOpen0 ||
+      !FwpmEngineClose0 ||
+      !FwpmSubLayerAdd0 ||
+      !FwpmSubLayerDeleteByKey0 ||
+      !FwpmFreeMemory0 ||
+      !FwpmGetAppIdFromFileName0)
+  {
+    msg (M_NONFATAL, "Can't get address for all WFP-related procedures.");
+    return false;
+  }
+
+  return true;
+}
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
+    if (FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session,
&m_hEngineHandle) != ERROR_SUCCESS)
+    {
+        msg (M_NONFATAL, "Can't open WFP engine");
+        return false;
+    }
+
+    if (UuidCreate(&SubLayer.subLayerKey) != NO_ERROR)
+        return false;
+    memcpy(&m_subLayerGUID, &SubLayer.subLayerKey,
sizeof(SubLayer.subLayerKey));
+
+    /* Populate packet filter layer information. */
+    SubLayer.displayData.name = FIREWALL_NAME;
+    SubLayer.displayData.description = FIREWALL_NAME;
+    SubLayer.flags = 0;
+    SubLayer.weight = 0x100;
+
+    /* Add packet filter to our interface. */
+    dmsg (D_LOW, "Adding WFP sublayer");
+    if (FwpmSubLayerAdd0(m_hEngineHandle, &SubLayer, NULL) !=
ERROR_SUCCESS)
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
+    if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) !=
ERROR_SUCCESS)
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
+    dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with
ID=%I64d", filterid);
+
+    /* Forth filter. Permit IPv6 DNS queries from TAP. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+    /* Add filter condition to our interface. */
+    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
+        goto err;
+    dmsg (D_LOW, "Filter (Permit IPv6 DNS queries from TAP) added with
ID=%I64d", filterid);
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
 #endif
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index cc18f02..776ef36 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -271,5 +271,9 @@ const char *win_get_tempdir();
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string (const char* utf8, struct gc_arena *gc);

+bool win_wfp_init_funcs();
+bool win_wfp_block_dns(const NET_IFINDEX index);
+bool win_wfp_uninit();
+
 #endif
 #endif
-- 
1.9.1

--001a11c1176c35efe30526812755
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Based on release/2.3 branch, this patch is cross-comp=
iled in MinGW and tested on Windows XP/10. The VC project file is left unto=
uched - you might want to add rpcrt4.lib to compile and link it under MSVC.=
</div><div><br></div><div>Also, I didn&#39;t figure out how to keep ValdikS=
S&#39;s authorship of his code in the patch=C2=A0(sorry :-( ). Definitely n=
o expert in git... Maybe I should generate a patch on top of his latest pat=
ch?</div><div><br></div><div>Take ValdikSS&lt;<a href=3D"mailto:iam@...2103...=
...">iam@...2070...</a>&gt;&#39;s patch for &quot;block-outside-dns&quot; o=
ption and<br>make it Windows-version-agnostic. My code is pretty messy righ=
t now, will send<br>out a secondary patch later after tidying WFP-related c=
ode.<br>---<br>=C2=A0doc/openvpn.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-<br>=C2=A0src/op=
envpn/Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-<br>=C2=A0src/o=
penvpn/init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 13 ++<br>=C2=A0src/openvpn/openvpn.vcxproj |=C2=A0=C2=A0 0<br>=C2=A0src/op=
envpn/options.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +<br>=C2=A0s=
rc/openvpn/options.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +<=
br>=C2=A0src/openvpn/win32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 520 ++++++++++++++++++++++++++++++++++++++++++++<br>=C2=A0src/openvpn=
/win32.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +<=
br>=C2=A08 files changed, 560 insertions(+), 3 deletions(-)<br>=C2=A0mode c=
hange 100755 =3D&gt; 100644 src/openvpn/openvpn.vcxproj</div><div><br></div=
><div>diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>index 8968c2e..9e4b01e =
100644<br>--- a/doc/openvpn.8<br>+++ b/doc/openvpn.8<br>@@ -1119,8 +1119,8 =
@@ When used with<br>=C2=A0.B \-\-client<br>=C2=A0or<br>=C2=A0.B \-\-pull,<=
br>-accept options pushed by server EXCEPT for routes and dhcp options<br>-=
like DNS servers.<br>+accept options pushed by server EXCEPT for routes, bl=
ock-outside-dns and dhcp<br>+options like DNS servers.<br>=C2=A0<br>=C2=A0W=
hen used on the client, this option effectively bars the<br>=C2=A0server fr=
om adding routes to the client&#39;s routing table,<br>@@ -5448,6 +5448,14 =
@@ adapter list to the syslog or log file after the TUN/TAP adapter<br>=C2=
=A0has been brought up and any routes have been added.<br>=C2=A0.\&quot;***=
******************************************************<br>=C2=A0.TP<br>+.B =
\-\-block\-outside\-dns<br>+Block DNS servers on other network adapters to =
prevent<br>+DNS leaks. This option prevents any application from accessing<=
br>+TCP or UDP port 53 except one inside the tunnel. It uses<br>+Windows Fi=
ltering Platform (WFP) and works on Windows Vista or<br>+later.<br>+.\&quot=
;*********************************************************<br>+.TP<br>=C2=
=A0.B \-\-dhcp\-renew<br>=C2=A0Ask Windows to renew the TAP adapter lease o=
n startup.<br>=C2=A0This option is normally unnecessary, as Windows automat=
ically<br>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am<br=
>index 2e602f1..149a533 100644<br>--- a/src/openvpn/Makefile.am<br>+++ b/sr=
c/openvpn/Makefile.am<br>@@ -123,5 +123,5 @@ openvpn_LDADD =3D \<br>=C2=A0=
=C2=A0$(OPTIONAL_DL_LIBS)<br>=C2=A0if WIN32<br>=C2=A0openvpn_SOURCES +=3D o=
penvpn_win32_resources.rc<br>-openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwininet=
 -lcrypt32 -liphlpapi -lwinmm<br>+openvpn_LDADD +=3D -lgdi32 -lws2_32 -lwin=
inet -lcrypt32 -liphlpapi -lrpcrt4 -lwinmm<br>=C2=A0endif<br>diff --git a/s=
rc/openvpn/init.c b/src/openvpn/init.c<br>index ceef4f7..960535d 100644<br>=
--- a/src/openvpn/init.c<br>+++ b/src/openvpn/init.c<br>@@ -1468,6 +1468,13=
 @@ do_open_tun (struct context *c)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot=
;up&quot;,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c-&gt;<a href=3D"http://c2.es"=
>c2.es</a>);<br>=C2=A0<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c-&gt;options=
.block_outside_dns)<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Blocking outside DNS&quot=
;);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!win_wfp_block_dns(c=
-&gt;c1.tuntap-&gt;adapter_index))<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg (M_FATAL, &quot;Blocking DNS failed!&quo=
t;);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>+<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* possibly add routes */<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!c-&gt;options.route_delay_defined)<br>=C2=A0=C2=A0do_route (&amp;c=
-&gt;options, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,<br>@@ -1594,6 =
+1601,12 @@ do_close_tun (struct context *c, bool force)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;down&quot;,<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c-&gt;<a href=3D"http://c2.es">c=
2.es</a>);<br>=C2=A0<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (c-&gt;options.block_outside_dns)<br>+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (!win_wfp_uninit())<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg (=
M_FATAL, &quot;Uninitialising WFP failed!&quot;);<br>+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>+<br>=C2=A0=C2=A0=C2=A0 =
/* actually close tun/tap device based on --down-pre flag */<br>=C2=A0=C2=
=A0=C2=A0 if (c-&gt;options.down_pre)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_=
close_tun_simple (c);<br>diff --git a/src/openvpn/openvpn.vcxproj b/src/ope=
nvpn/openvpn.vcxproj<br>old mode 100755<br>new mode 100644<br>diff --git a/=
src/openvpn/options.c b/src/openvpn/options.c<br>index f609aa6..564e670 100=
644<br>--- a/src/openvpn/options.c<br>+++ b/src/openvpn/options.c<br>@@ -71=
5,6 +715,7 @@ static const char usage_message[] =3D<br>=C2=A0=C2=A0 &quot;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optional paramete=
r controls the initial state of ex.\n&quot;<br>=C2=A0=C2=A0 &quot;--show-ne=
t-up=C2=A0=C2=A0 : Show &quot; PACKAGE_NAME &quot;&#39;s view of routing ta=
ble and net adapter list\n&quot;<br>=C2=A0=C2=A0 &quot;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 after TAP adapter is up and routes have been added.\n&quot;<br>+=
=C2=A0 &quot;--block-outside-dns=C2=A0=C2=A0 : Block DNS on other network a=
dapters to prevent DNS leaks\n&quot;<br>=C2=A0=C2=A0 &quot;Windows Standalo=
ne Options:\n&quot;<br>=C2=A0=C2=A0 &quot;\n&quot;<br>=C2=A0=C2=A0 &quot;--=
show-adapters : Show all TAP-Windows adapters.\n&quot;<br>@@ -814,6 +815,7 =
@@ init_options (struct options *o, const bool init_gc)<br>=C2=A0=C2=A0 o-&=
gt;tuntap_options.dhcp_lease_time =3D 31536000; /* one year */<br>=C2=A0=C2=
=A0 o-&gt;tuntap_options.dhcp_masq_offset =3D 0;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* use network address as internal DHCP server address */<br>=C2=
=A0=C2=A0 o-&gt;route_method =3D ROUTE_METHOD_ADAPTIVE;<br>+=C2=A0 o-&gt;bl=
ock_outside_dns =3D false;<br>=C2=A0#endif<br>=C2=A0#if P2MP_SERVER<br>=C2=
=A0=C2=A0 o-&gt;real_hash_size =3D 256;<br>@@ -1678,6 +1680,7 @@ show_setti=
ngs (const struct options *o)<br>=C2=A0#ifdef WIN32<br>=C2=A0=C2=A0 SHOW_BO=
OL (show_net_up);<br>=C2=A0=C2=A0 SHOW_INT (route_method);<br>+=C2=A0 SHOW_=
BOOL (block_outside_dns);<br>=C2=A0=C2=A0 show_tuntap_options (&amp;o-&gt;t=
untap_options);<br>=C2=A0#endif<br>=C2=A0#endif<br>@@ -6241,6 +6244,14 @@ a=
dd_option (struct options *options,<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 VERIFY_PERMISSION (OPT_P_IPWIN32);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 options-&gt;tuntap_options.register_dns =3D true;<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 }<br>+=C2=A0 else if (streq (p[0], &quot;block-outside-dns&quot;) &amp;=
&amp; !p[1])<br>+=C2=A0=C2=A0=C2=A0 {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VE=
RIFY_PERMISSION (OPT_P_IPWIN32);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (win=
_wfp_init_funcs())<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 options-&gt;block_outside_dns =3D true;<br>+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0 else=
 if (streq (p[0], &quot;rdns-internal&quot;))<br>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* standalone method for internal use<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *<br>diff --git a/src/openvpn/options.h b/src/openvpn/options.h<b=
r>index 40cf71e..622706a 100644<br>--- a/src/openvpn/options.h<br>+++ b/src=
/openvpn/options.h<br>@@ -593,6 +593,7 @@ struct options<br>=C2=A0=C2=A0 bo=
ol exit_event_initial_state;<br>=C2=A0=C2=A0 bool show_net_up;<br>=C2=A0=C2=
=A0 int route_method;<br>+=C2=A0 bool block_outside_dns;<br>=C2=A0#endif<br=
>=C2=A0<br>=C2=A0=C2=A0 bool use_peer_id;<br>diff --git a/src/openvpn/win32=
.c b/src/openvpn/win32.c<br>index 5e7f13c..55eec95 100644<br>--- a/src/open=
vpn/win32.c<br>+++ b/src/openvpn/win32.c<br>@@ -47,6 +47,74 @@<br>=C2=A0#in=
clude &quot;memdbg.h&quot;<br>=C2=A0<br>=C2=A0/*<br>+ * WFP-related defines=
 and GUIDs.<br>+ */<br>+// #include &lt;fwpmu.h&gt;<br>+#include &lt;initgu=
id.h&gt;<br>+// #include &lt;fwpmtypes.h&gt;<br>+#include &lt;iphlpapi.h&gt=
;<br>+<br>+#ifndef FWPM_SESSION_FLAG_DYNAMIC<br>+#define FWPM_SESSION_FLAG_=
DYNAMIC 0x00000001<br>+#endif<br>+<br>+// c38d57d1-05a7-4c33-904f-7fbceee60=
e82<br>+DEFINE_GUID(<br>+=C2=A0=C2=A0 FWPM_LAYER_ALE_AUTH_CONNECT_V4,<br>+=
=C2=A0=C2=A0 0xc38d57d1,<br>+=C2=A0=C2=A0 0x05a7,<br>+=C2=A0=C2=A0 0x4c33,<=
br>+=C2=A0=C2=A0 0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82<br>+);<br>+=
<br>+// 4a72393b-319f-44bc-84c3-ba54dcb3b6b4<br>+DEFINE_GUID(<br>+=C2=A0=C2=
=A0 FWPM_LAYER_ALE_AUTH_CONNECT_V6,<br>+=C2=A0=C2=A0 0x4a72393b,<br>+=C2=A0=
=C2=A0 0x319f,<br>+=C2=A0=C2=A0 0x44bc,<br>+=C2=A0=C2=A0 0x84, 0xc3, 0xba, =
0x54, 0xdc, 0xb3, 0xb6, 0xb4<br>+);<br>+<br>+// d78e1e87-8644-4ea5-9437-d80=
9ecefc971<br>+DEFINE_GUID(<br>+=C2=A0=C2=A0 FWPM_CONDITION_ALE_APP_ID,<br>+=
=C2=A0=C2=A0 0xd78e1e87,<br>+=C2=A0=C2=A0 0x8644,<br>+=C2=A0=C2=A0 0x4ea5,<=
br>+=C2=A0=C2=A0 0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71<br>+);<br>+=
<br>+// c35a604d-d22b-4e1a-91b4-68f674ee674b<br>+DEFINE_GUID(<br>+=C2=A0=C2=
=A0 FWPM_CONDITION_IP_REMOTE_PORT,<br>+=C2=A0=C2=A0 0xc35a604d,<br>+=C2=A0=
=C2=A0 0xd22b,<br>+=C2=A0=C2=A0 0x4e1a,<br>+=C2=A0=C2=A0 0x91, 0xb4, 0x68, =
0xf6, 0x74, 0xee, 0x67, 0x4b<br>+);<br>+<br>+// 4cd62a49-59c3-4969-b7f3-bda=
5d32890a4<br>+DEFINE_GUID(<br>+=C2=A0=C2=A0 FWPM_CONDITION_IP_LOCAL_INTERFA=
CE,<br>+=C2=A0=C2=A0 0x4cd62a49,<br>+=C2=A0=C2=A0 0x59c3,<br>+=C2=A0=C2=A0 =
0x4969,<br>+=C2=A0=C2=A0 0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4<br>=
+);<br>+<br>+/*<br>+ * WFP firewall name.<br>+ */<br>+WCHAR * FIREWALL_NAME=
 =3D L&quot;OpenVPN&quot;; /* GLOBAL */<br>+<br>+/*<br>+ * WFP handle and G=
UID.<br>+ */<br>+static HANDLE m_hEngineHandle =3D NULL; /* GLOBAL */<br>+s=
tatic GUID m_subLayerGUID; /* GLOBAL */<br>+<br>+/*<br>=C2=A0 * Windows int=
ernal socket API state (opaque).<br>=C2=A0 */<br>=C2=A0static struct WSADat=
a wsa_state; /* GLOBAL */<br>@@ -1077,4 +1145,456 @@ win_get_tempdir()<br>=
=C2=A0=C2=A0 WideCharToMultiByte (CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof (=
tmpdir), NULL, NULL);<br>=C2=A0=C2=A0 return tmpdir;<br>=C2=A0}<br>+<br>+/*=
 From fwptypes.h */<br>+<br>+#define FWP_ACTION_FLAG_TERMINATING=C2=A0=C2=
=A0=C2=A0=C2=A0 (0x00001000)<br>+#define FWP_ACTION_FLAG_NON_TERMINATING (0=
x00002000)<br>+<br>+#define FWP_ACTION_BLOCK=C2=A0 (0x1 | FWP_ACTION_FLAG_T=
ERMINATING)<br>+#define FWP_ACTION_PERMIT (0x2 | FWP_ACTION_FLAG_TERMINATIN=
G)<br>+<br>+typedef UINT32 FWP_ACTION_TYPE;<br>+<br>+typedef enum FWP_DATA_=
TYPE_ {<br>+=C2=A0=C2=A0=C2=A0 FWP_EMPTY =3D 0,<br>+=C2=A0=C2=A0=C2=A0 FWP_=
UINT8 =3D 1,<br>+=C2=A0=C2=A0=C2=A0 FWP_UINT16 =3D 2,<br>+=C2=A0=C2=A0=C2=
=A0 FWP_UINT32 =3D 3,<br>+=C2=A0=C2=A0=C2=A0 FWP_UINT64 =3D 4,<br>+=C2=A0=
=C2=A0=C2=A0 FWP_INT8 =3D 5,<br>+=C2=A0=C2=A0=C2=A0 FWP_INT16 =3D 6,<br>+=
=C2=A0=C2=A0=C2=A0 FWP_INT32 =3D 7,<br>+=C2=A0=C2=A0=C2=A0 FWP_INT64 =3D 8,=
<br>+=C2=A0=C2=A0=C2=A0 FWP_FLOAT =3D 9,<br>+=C2=A0=C2=A0=C2=A0 FWP_DOUBLE =
=3D 10,<br>+=C2=A0=C2=A0=C2=A0 FWP_BYTE_ARRAY16_TYPE =3D 11,<br>+=C2=A0=C2=
=A0=C2=A0 FWP_BYTE_BLOB_TYPE =3D 12,<br>+=C2=A0=C2=A0=C2=A0 FWP_SID =3D 13,=
<br>+=C2=A0=C2=A0=C2=A0 FWP_SECURITY_DESCRIPTOR_TYPE =3D 14,<br>+=C2=A0=C2=
=A0=C2=A0 FWP_TOKEN_INFORMATION_TYPE =3D 15,<br>+=C2=A0=C2=A0=C2=A0 FWP_TOK=
EN_ACCESS_INFORMATION_TYPE =3D 16,<br>+=C2=A0=C2=A0=C2=A0 FWP_UNICODE_STRIN=
G_TYPE =3D 17,<br>+=C2=A0=C2=A0=C2=A0 FWP_BYTE_ARRAY6_TYPE =3D 18,<br>+=C2=
=A0=C2=A0=C2=A0 FWP_SINGLE_DATA_TYPE_MAX =3D 0xff,<br>+=C2=A0=C2=A0=C2=A0 F=
WP_V4_ADDR_MASK =3D 0x100,<br>+=C2=A0=C2=A0=C2=A0 FWP_V6_ADDR_MASK =3D 0x10=
1,<br>+=C2=A0=C2=A0=C2=A0 FWP_RANGE_TYPE =3D 0x102,<br>+=C2=A0=C2=A0=C2=A0 =
FWP_DATA_TYPE_MAX =3D 0x103<br>+} FWP_DATA_TYPE;<br>+<br>+typedef enum FWP_=
MATCH_TYPE_ {<br>+=C2=A0=C2=A0=C2=A0 FWP_MATCH_EQUAL =3D 0,<br>+=C2=A0=C2=
=A0=C2=A0 FWP_MATCH_GREATER =3D 1,<br>+=C2=A0=C2=A0=C2=A0 FWP_MATCH_LESS =
=3D 2,<br>+=C2=A0=C2=A0=C2=A0 FWP_MATCH_GREATER_OR_EQUAL =3D 3,<br>+=C2=A0=
=C2=A0=C2=A0 FWP_MATCH_LESS_OR_EQUAL =3D 4,<br>+=C2=A0=C2=A0=C2=A0 FWP_MATC=
H_RANGE =3D 5,<br>+=C2=A0=C2=A0=C2=A0 FWP_MATCH_FLAGS_ALL_SET =3D 6,<br>+=
=C2=A0=C2=A0=C2=A0 FWP_MATCH_FLAGS_ANY_SET =3D 7,<br>+=C2=A0=C2=A0=C2=A0 FW=
P_MATCH_FLAGS_NONE_SET =3D 8,<br>+=C2=A0=C2=A0=C2=A0 FWP_MATCH_EQUAL_CASE_I=
NSENSITIVE =3D 9,<br>+=C2=A0=C2=A0=C2=A0 FWP_MATCH_NOT_EQUAL =3D 10,<br>+=
=C2=A0=C2=A0=C2=A0 FWP_MATCH_TYPE_MAX =3D 11<br>+} FWP_MATCH_TYPE;<br>+<br>=
+typedef struct FWP_BYTE_ARRAY6_ {<br>+=C2=A0=C2=A0=C2=A0 UINT8 byteArray6[=
6];<br>+} FWP_BYTE_ARRAY6;<br>+<br>+typedef struct FWP_BYTE_ARRAY16_ {<br>+=
=C2=A0=C2=A0=C2=A0 UINT8 byteArray16[16];<br>+} FWP_BYTE_ARRAY16;<br>+<br>+=
typedef struct FWP_BYTE_BLOB_ {<br>+=C2=A0=C2=A0=C2=A0 UINT32 size;<br>+=C2=
=A0=C2=A0=C2=A0 UINT8 *data;<br>+} FWP_BYTE_BLOB;<br>+<br>+typedef struct F=
WP_TOKEN_INFORMATION_ {<br>+=C2=A0=C2=A0=C2=A0 ULONG sidCount;<br>+=C2=A0=
=C2=A0=C2=A0 PSID_AND_ATTRIBUTES sids;<br>+=C2=A0=C2=A0=C2=A0 ULONG restric=
tedSidCount;<br>+=C2=A0=C2=A0=C2=A0 PSID_AND_ATTRIBUTES restrictedSids;<br>=
+} FWP_TOKEN_INFORMATION;<br>+<br>+typedef struct FWP_VALUE0_ {<br>+=C2=A0=
=C2=A0=C2=A0 FWP_DATA_TYPE type;<br>+=C2=A0=C2=A0=C2=A0 __C89_NAMELESS unio=
n {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UINT8 uint8;<br>+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UINT16 uint16;<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 UINT32 uint32;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 UINT64 *uint64;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 INT8 int8;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INT16 int16;<br>=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INT32 int32;<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INT64 *int64;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 float float32;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 double *double64;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP=
_BYTE_ARRAY16 *byteArray16;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
FWP_BYTE_BLOB *byteBlob;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SID=
 *sid;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_BYTE_BLOB *sd;<br=
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_TOKEN_INFORMATION *tokenIn=
formation;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_BYTE_BLOB *to=
kenAccessInformation;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LPWSTR=
 unicodeString;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_BYTE_ARR=
AY6 *byteArray6;<br>+=C2=A0=C2=A0=C2=A0 } __C89_NAMELESSUNIONNAME;<br>+} FW=
P_VALUE0;<br>+<br>+typedef struct FWP_V4_ADDR_AND_MASK_ {<br>+=C2=A0=C2=A0=
=C2=A0 UINT32 addr;<br>+=C2=A0=C2=A0=C2=A0 UINT32 mask;<br>+} FWP_V4_ADDR_A=
ND_MASK;<br>+<br>+typedef struct FWP_V6_ADDR_AND_MASK_ {<br>+=C2=A0=C2=A0=
=C2=A0 UINT8 addr[16];<br>+=C2=A0=C2=A0=C2=A0 UINT8 prefixLength;<br>+} FWP=
_V6_ADDR_AND_MASK;<br>+<br>+typedef struct FWP_RANGE0_ {<br>+=C2=A0=C2=A0=
=C2=A0 FWP_VALUE0 valueLow;<br>+=C2=A0=C2=A0=C2=A0 FWP_VALUE0 valueHigh;<br=
>+} FWP_RANGE0;<br>+<br>+typedef struct FWP_CONDITION_VALUE0_ {<br>+=C2=A0=
=C2=A0=C2=A0 FWP_DATA_TYPE type;<br>+=C2=A0=C2=A0=C2=A0 __C89_NAMELESS unio=
n {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UINT8 uint8;<br>+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UINT16 uint16;<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 UINT32 uint32;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 UINT64 *uint64;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 INT8 int8;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INT16 int16;<br>=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INT32 int32;<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INT64 *int64;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 float float32;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 double *double64;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP=
_BYTE_ARRAY16 *byteArray16;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
FWP_BYTE_BLOB *byteBlob;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SID=
 *sid;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_BYTE_BLOB *sd;<br=
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_TOKEN_INFORMATION *tokenIn=
formation;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_BYTE_BLOB *to=
kenAccessInformation;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LPWSTR=
 unicodeString;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_BYTE_ARR=
AY6 *byteArray6;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_V4_ADDR=
_AND_MASK *v4AddrMask;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FWP_V=
6_ADDR_AND_MASK *v6AddrMask;<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 FWP_RANGE0 *rangeValue;<br>+=C2=A0=C2=A0=C2=A0 } __C89_NAMELESSUNIONNAME;<=
br>+} FWP_CONDITION_VALUE0;<br>+<br>+typedef struct FWPM_DISPLAY_DATA0_ {<b=
r>+=C2=A0=C2=A0=C2=A0 wchar_t *name;<br>+=C2=A0=C2=A0=C2=A0 wchar_t *descri=
ption;<br>+} FWPM_DISPLAY_DATA0;<br>+<br>+/* From fwpmtypes.h */<br>+<br>+t=
ypedef struct FWPM_ACTION0_ {<br>+=C2=A0 FWP_ACTION_TYPE type;<br>+=C2=A0 _=
_C89_NAMELESS union {<br>+=C2=A0=C2=A0=C2=A0 GUID filterType;<br>+=C2=A0=C2=
=A0=C2=A0 GUID calloutKey;<br>+=C2=A0 };<br>+} FWPM_ACTION0;<br>+<br>+typed=
ef struct FWPM_SESSION0_ {<br>+=C2=A0 GUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sessionKey;<br>+=C2=A0 =
FWPM_DISPLAY_DATA0 displayData;<br>+=C2=A0 UINT32=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags;<br>+=C2=A0 UINT32=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tx=
nWaitTimeoutInMSec;<br>+=C2=A0 DWORD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 processId;<br>+=C2=A0 SID=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *sid;<br>+=C2=A0 wchar_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *username;<br>+=C2=A0 WINBOOL=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernelMode;<br>+} FWPM_SESSIO=
N0;<br>+<br>+typedef struct FWPM_SUBLAYER0_ {<br>+=C2=A0 GUID=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 su=
bLayerKey;<br>+=C2=A0 FWPM_DISPLAY_DATA0 displayData;<br>+=C2=A0 UINT16=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags=
;<br>+=C2=A0 GUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *providerKey;<br>+=C2=A0 FWP_BYTE_BLOB=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 providerData;<br>+=C2=A0 UINT16=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 weight;<br>+} FWPM_SUBL=
AYER0;<br>+<br>+typedef struct FWPM_FILTER_CONDITION0_ {<br>+=C2=A0 GUID=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fieldKey;<br>+=C2=A0 FWP_MATCH_TYPE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 matchType;<br>+=C2=A0 FWP_CONDITION_VALUE0 conditionValue;<=
br>+} FWPM_FILTER_CONDITION0;<br>+<br>+typedef struct FWPM_FILTER0_ {<br>+=
=C2=A0 GUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filterKey;<br>+=C2=A0 FWPM_DI=
SPLAY_DATA0=C2=A0=C2=A0=C2=A0=C2=A0 displayData;<br>+=C2=A0 UINT32=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 flags;<br>+=C2=A0 GUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *prov=
iderKey;<br>+=C2=A0 FWP_BYTE_BLOB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 providerData;<br>+=C2=A0 GUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 layerKey;<br>+=C2=A0 GUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subLayerKey;<b=
r>+=C2=A0 FWP_VALUE0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 weight;<br>+=C2=A0 UINT32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 numFilte=
rConditions;<br>+=C2=A0 FWPM_FILTER_CONDITION0 *filterCondition;<br>+=C2=A0=
 FWPM_ACTION0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ction;<br>+=C2=A0 __C89_NAMELESS union {<br>+=C2=A0=C2=A0=C2=A0 UINT64 rawC=
ontext;<br>+=C2=A0=C2=A0=C2=A0 GUID=C2=A0=C2=A0 providerContextKey;<br>+=C2=
=A0 };<br>+=C2=A0 GUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *reserved;<br>+=
=C2=A0 UINT64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filterId;<br>+=C2=A0 FWP_VALUE0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 effectiv=
eWeight;<br>+} FWPM_FILTER0;<br>+<br>+#include &lt;rpc.h&gt;<br>+#include &=
lt;rpcdce.h&gt;<br>+<br>+/* Typedefs of WFP functions */<br>+<br>+#define N=
ETIO_STATUS DWORD<br>+<br>+typedef NETIO_STATUS WINAPI *(*func_ConvertInter=
faceIndexToLuid)(<br>+=C2=A0 NET_IFINDEX InterfaceIndex,<br>+=C2=A0 PNET_LU=
ID InterfaceLuid<br>+);<br>+<br>+typedef DWORD WINAPI *(*func_FwpmEngineOpe=
n0)(<br>+=C2=A0 const wchar_t *serverName,<br>+=C2=A0 UINT32 authnService,<=
br>+=C2=A0 SEC_WINNT_AUTH_IDENTITY_W *authIdentity,<br>+=C2=A0 const FWPM_S=
ESSION0 *session,<br>+=C2=A0 HANDLE *engineHandle<br>+);<br>+<br>+typedef D=
WORD WINAPI *(*func_FwpmEngineClose0)(<br>+=C2=A0 HANDLE engineHandle<br>+)=
;<br>+<br>+typedef DWORD WINAPI *(*func_FwpmFilterAdd0)(<br>+=C2=A0 HANDLE =
engineHandle,<br>+=C2=A0 const FWPM_FILTER0 *filter,<br>+=C2=A0 PSECURITY_D=
ESCRIPTOR sd,<br>+=C2=A0 UINT64 *id<br>+);<br>+<br>+typedef DWORD WINAPI *(=
*func_FwpmSubLayerAdd0)(<br>+=C2=A0 HANDLE engineHandle,<br>+=C2=A0 const F=
WPM_SUBLAYER0 *subLayer,<br>+=C2=A0 PSECURITY_DESCRIPTOR sd<br>+);<br>+<br>=
+typedef DWORD WINAPI *(*func_FwpmSubLayerDeleteByKey0)(<br>+=C2=A0 HANDLE =
engineHandle,<br>+=C2=A0 const GUID *key<br>+);<br>+<br>+typedef void WINAP=
I *(*func_FwpmFreeMemory0)(<br>+=C2=A0 void **p<br>+);<br>+<br>+typedef DWO=
RD WINAPI *(*func_FwpmGetAppIdFromFileName0)(<br>+=C2=A0 const wchar_t *fil=
eName,<br>+=C2=A0 FWP_BYTE_BLOB **appId<br>+);<br>+<br>+/* WFP function poi=
nters */<br>+func_ConvertInterfaceIndexToLuid ConvertInterfaceIndexToLuid =
=3D NULL;<br>+func_FwpmEngineOpen0 FwpmEngineOpen0 =3D NULL;<br>+func_FwpmE=
ngineClose0 FwpmEngineClose0 =3D NULL;<br>+func_FwpmFilterAdd0 FwpmFilterAd=
d0 =3D NULL;<br>+func_FwpmSubLayerAdd0 FwpmSubLayerAdd0 =3D NULL;<br>+func_=
FwpmSubLayerDeleteByKey0 FwpmSubLayerDeleteByKey0 =3D NULL;<br>+func_FwpmFr=
eeMemory0 FwpmFreeMemory0 =3D NULL;<br>+func_FwpmGetAppIdFromFileName0 Fwpm=
GetAppIdFromFileName0 =3D NULL;<br>+<br>+bool<br>+win_wfp_init_funcs ()<br>=
+{<br>+=C2=A0 /* Initialize all WFP-related function pointers */<br>+=C2=A0=
 HMODULE iphlpapiHandle =3D LoadLibrary(&quot;iphlpapi.dll&quot;);<br>+=C2=
=A0 if (iphlpapiHandle =3D=3D NULL)<br>+=C2=A0 {<br>+=C2=A0=C2=A0=C2=A0 msg=
 (M_NONFATAL, &quot;Can&#39;t load iphlpapi.dll&quot;);<br>+=C2=A0=C2=A0=C2=
=A0 return false;<br>+=C2=A0 }<br>+<br>+=C2=A0 HMODULE fwpuclntHandle =3D L=
oadLibrary(&quot;fwpuclnt.dll&quot;);<br>+=C2=A0 if (fwpuclntHandle =3D=3D =
NULL)<br>+=C2=A0 {<br>+=C2=A0=C2=A0=C2=A0 msg (M_NONFATAL, &quot;Can&#39;t =
load fwpuclnt.dll&quot;);<br>+=C2=A0=C2=A0=C2=A0 return false;<br>+=C2=A0 }=
<br>+<br>+=C2=A0 ConvertInterfaceIndexToLuid =3D (func_ConvertInterfaceInde=
xToLuid)GetProcAddress(iphlpapiHandle, &quot;ConvertInterfaceIndexToLuid&qu=
ot;);<br>+=C2=A0 FwpmFilterAdd0 =3D (func_FwpmFilterAdd0)GetProcAddress(fwp=
uclntHandle, &quot;FwpmFilterAdd0&quot;);<br>+=C2=A0 FwpmEngineOpen0 =3D (f=
unc_FwpmEngineOpen0)GetProcAddress(fwpuclntHandle, &quot;FwpmEngineOpen0&qu=
ot;);<br>+=C2=A0 FwpmEngineClose0 =3D (func_FwpmEngineClose0)GetProcAddress=
(fwpuclntHandle, &quot;FwpmEngineClose0&quot;);<br>+=C2=A0 FwpmSubLayerAdd0=
 =3D (func_FwpmSubLayerAdd0)GetProcAddress(fwpuclntHandle, &quot;FwpmSubLay=
erAdd0&quot;);<br>+=C2=A0 FwpmSubLayerDeleteByKey0 =3D (func_FwpmSubLayerDe=
leteByKey0)GetProcAddress(fwpuclntHandle, &quot;FwpmSubLayerDeleteByKey0&qu=
ot;);<br>+=C2=A0 FwpmFreeMemory0 =3D (func_FwpmFreeMemory0)GetProcAddress(f=
wpuclntHandle, &quot;FwpmFreeMemory0&quot;);<br>+=C2=A0 FwpmGetAppIdFromFil=
eName0 =3D (func_FwpmGetAppIdFromFileName0)GetProcAddress(fwpuclntHandle, &=
quot;FwpmGetAppIdFromFileName0&quot;);<br>+<br>+=C2=A0 if (!ConvertInterfac=
eIndexToLuid ||<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !FwpmFilterAdd0 ||<br>+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !FwpmEngineOpen0 ||<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 !FwpmEngineClose0 ||<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !FwpmS=
ubLayerAdd0 ||<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !FwpmSubLayerDeleteByKey0=
 ||<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !FwpmFreeMemory0 ||<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 !FwpmGetAppIdFromFileName0)<br>+=C2=A0 {<br>+=C2=A0=C2=
=A0=C2=A0 msg (M_NONFATAL, &quot;Can&#39;t get address for all WFP-related =
procedures.&quot;);<br>+=C2=A0=C2=A0=C2=A0 return false;<br>+=C2=A0 }<br>+<=
br>+=C2=A0 return true;<br>+}<br>+<br>+bool<br>+win_wfp_add_filter (HANDLE =
engineHandle,<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const FWPM_FILTER=
0 *filter,<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PSECURITY_DESCRIPTOR=
 sd,<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UINT64 *id)<br>+{<br>+=C2=
=A0=C2=A0=C2=A0 if (FwpmFilterAdd0(engineHandle, filter, sd, id) !=3D ERROR=
_SUCCESS)<br>+=C2=A0=C2=A0=C2=A0 {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 msg (M_NONFATAL, &quot;Can&#39;t add WFP filter&quot;);<br>+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>+=C2=A0=C2=A0=C2=A0 }=
<br>+=C2=A0=C2=A0=C2=A0 return true;<br>+}<br>+<br>+bool<br>+win_wfp_block_=
dns (const NET_IFINDEX index)<br>+{<br>+=C2=A0=C2=A0=C2=A0 CLEAR(m_subLayer=
GUID);<br>+=C2=A0=C2=A0=C2=A0 FWPM_SESSION0 session =3D {0};<br>+=C2=A0=C2=
=A0=C2=A0 FWPM_SUBLAYER0 SubLayer =3D {0};<br>+=C2=A0=C2=A0=C2=A0 NET_LUID =
tapluid;<br>+=C2=A0=C2=A0=C2=A0 UINT64 filterid;<br>+=C2=A0=C2=A0=C2=A0 WCH=
AR openvpnpath[MAX_PATH];<br>+=C2=A0=C2=A0=C2=A0 FWP_BYTE_BLOB *openvpnblob=
 =3D NULL;<br>+=C2=A0=C2=A0=C2=A0 FWPM_FILTER0 Filter =3D {0};<br>+=C2=A0=
=C2=A0=C2=A0 FWPM_FILTER_CONDITION0 Condition[2] =3D {0};<br>+<br>+=C2=A0=
=C2=A0=C2=A0 /* Add temporary filters which don&#39;t survive reboots or cr=
ashes. */<br>+=C2=A0=C2=A0=C2=A0 session.flags =3D FWPM_SESSION_FLAG_DYNAMI=
C;<br>+<br>+=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Opening WFP engine&quot;)=
;<br>+<br>+=C2=A0=C2=A0=C2=A0 if (FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, =
NULL, &amp;session, &amp;m_hEngineHandle) !=3D ERROR_SUCCESS)<br>+=C2=A0=C2=
=A0=C2=A0 {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg (M_NONFATAL,=
 &quot;Can&#39;t open WFP engine&quot;);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return false;<br>+=C2=A0=C2=A0=C2=A0 }<br>+<br>+=C2=A0=C2=A0=
=C2=A0 if (UuidCreate(&amp;SubLayer.subLayerKey) !=3D NO_ERROR)<br>+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>+=C2=A0=C2=A0=C2=A0 m=
emcpy(&amp;m_subLayerGUID, &amp;SubLayer.subLayerKey, sizeof(SubLayer.subLa=
yerKey));<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Populate packet filter layer infor=
mation. */<br>+=C2=A0=C2=A0=C2=A0 <a href=3D"http://SubLayer.displayData.na=
me">SubLayer.displayData.name</a> =3D FIREWALL_NAME;<br>+=C2=A0=C2=A0=C2=A0=
 SubLayer.displayData.description =3D FIREWALL_NAME;<br>+=C2=A0=C2=A0=C2=A0=
 SubLayer.flags =3D 0;<br>+=C2=A0=C2=A0=C2=A0 SubLayer.weight =3D 0x100;<br=
>+<br>+=C2=A0=C2=A0=C2=A0 /* Add packet filter to our interface. */<br>+=C2=
=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Adding WFP sublayer&quot;);<br>+=C2=A0=
=C2=A0=C2=A0 if (FwpmSubLayerAdd0(m_hEngineHandle, &amp;SubLayer, NULL) !=
=3D ERROR_SUCCESS)<br>+=C2=A0=C2=A0=C2=A0 {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 msg (M_NONFATAL, &quot;Can&#39;t add WFP sublayer&quot;);<b=
r>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>+=C2=A0=C2=
=A0=C2=A0 }<br>+<br>+=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Blocking DNS usi=
ng WFP&quot;);<br>+=C2=A0=C2=A0=C2=A0 if (ConvertInterfaceIndexToLuid(index=
, &amp;tapluid) !=3D NO_ERROR)<br>+=C2=A0=C2=A0=C2=A0 {<br>+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg (M_NONFATAL, &quot;Can&#39;t convert interf=
ace index to LUID&quot;);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn false;<br>+=C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &q=
uot;Tap Luid: %I64d&quot;, tapluid.Value);<br>+<br>+=C2=A0=C2=A0=C2=A0 /* G=
et OpenVPN path. */<br>+=C2=A0=C2=A0=C2=A0 GetModuleFileNameW(NULL, openvpn=
path, MAX_PATH);<br>+<br>+=C2=A0=C2=A0=C2=A0 if (FwpmGetAppIdFromFileName0(=
openvpnpath, &amp;openvpnblob) !=3D ERROR_SUCCESS)<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Prepa=
re filter. */<br>+=C2=A0=C2=A0=C2=A0 Filter.subLayerKey =3D m_subLayerGUID;=
<br>+=C2=A0=C2=A0=C2=A0 <a href=3D"http://Filter.displayData.name">Filter.d=
isplayData.name</a> =3D FIREWALL_NAME;<br>+=C2=A0=C2=A0=C2=A0 Filter.weight=
.type =3D FWP_EMPTY;<br>+=C2=A0=C2=A0=C2=A0 Filter.filterCondition =3D Cond=
ition;<br>+=C2=A0=C2=A0=C2=A0 Filter.numFilterConditions =3D 2;<br>+<br>+=
=C2=A0=C2=A0=C2=A0 /* First filter. Block IPv4 DNS queries except from Open=
VPN itself. */<br>+=C2=A0=C2=A0=C2=A0 Filter.layerKey =3D FWPM_LAYER_ALE_AU=
TH_CONNECT_V4;<br>+=C2=A0=C2=A0=C2=A0 Filter.action.type =3D FWP_ACTION_BLO=
CK;<br>+<br>+=C2=A0=C2=A0=C2=A0 Condition[0].fieldKey =3D FWPM_CONDITION_IP=
_REMOTE_PORT;<br>+=C2=A0=C2=A0=C2=A0 Condition[0].matchType =3D FWP_MATCH_E=
QUAL;<br>+=C2=A0=C2=A0=C2=A0 Condition[0].conditionValue.type =3D FWP_UINT1=
6;<br>+=C2=A0=C2=A0=C2=A0 Condition[0].conditionValue.uint16 =3D 53;<br>+<b=
r>+=C2=A0=C2=A0=C2=A0 Condition[1].fieldKey =3D FWPM_CONDITION_ALE_APP_ID;<=
br>+=C2=A0=C2=A0=C2=A0 Condition[1].matchType =3D FWP_MATCH_NOT_EQUAL;<br>+=
=C2=A0=C2=A0=C2=A0 Condition[1].conditionValue.type =3D FWP_BYTE_BLOB_TYPE;=
<br>+=C2=A0=C2=A0=C2=A0 Condition[1].conditionValue.byteBlob =3D openvpnblo=
b;<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Add filter condition to our interface. */=
<br>+=C2=A0=C2=A0=C2=A0 if (!win_wfp_add_filter(m_hEngineHandle, &amp;Filte=
r, NULL, &amp;filterid))<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o err;<br>+=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Filter (Block IPv4 DNS) ad=
ded with ID=3D%I64d&quot;, filterid);<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Second=
 filter. Block IPv6 DNS queries except from OpenVPN itself. */<br>+=C2=A0=
=C2=A0=C2=A0 Filter.layerKey =3D FWPM_LAYER_ALE_AUTH_CONNECT_V6;<br>+<br>+=
=C2=A0=C2=A0=C2=A0 /* Add filter condition to our interface. */<br>+=C2=A0=
=C2=A0=C2=A0 if (!win_wfp_add_filter(m_hEngineHandle, &amp;Filter, NULL, &a=
mp;filterid))<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;<br>+=
=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Filter (Block IPv6 DNS) added with ID=
=3D%I64d&quot;, filterid);<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Third filter. Per=
mit IPv4 DNS queries from TAP. */<br>+=C2=A0=C2=A0=C2=A0 Filter.layerKey =
=3D FWPM_LAYER_ALE_AUTH_CONNECT_V4;<br>+=C2=A0=C2=A0=C2=A0 Filter.action.ty=
pe =3D FWP_ACTION_PERMIT;<br>+<br>+=C2=A0=C2=A0=C2=A0 Condition[1].fieldKey=
 =3D FWPM_CONDITION_IP_LOCAL_INTERFACE;<br>+=C2=A0=C2=A0=C2=A0 Condition[1]=
.matchType =3D FWP_MATCH_EQUAL;<br>+=C2=A0=C2=A0=C2=A0 Condition[1].conditi=
onValue.type =3D FWP_UINT64;<br>+=C2=A0=C2=A0=C2=A0 Condition[1].conditionV=
alue.uint64 =3D &amp;tapluid.Value;<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Add filt=
er condition to our interface. */<br>+=C2=A0=C2=A0=C2=A0 if (!win_wfp_add_f=
ilter(m_hEngineHandle, &amp;Filter, NULL, &amp;filterid))<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err;<br>+=C2=A0=C2=A0=C2=A0 dmsg (D_LOW=
, &quot;Filter (Permit IPv4 DNS queries from TAP) added with ID=3D%I64d&quo=
t;, filterid);<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Forth filter. Permit IPv6 DNS=
 queries from TAP. */<br>+=C2=A0=C2=A0=C2=A0 Filter.layerKey =3D FWPM_LAYER=
_ALE_AUTH_CONNECT_V6;<br>+<br>+=C2=A0=C2=A0=C2=A0 /* Add filter condition t=
o our interface. */<br>+=C2=A0=C2=A0=C2=A0 if (!win_wfp_add_filter(m_hEngin=
eHandle, &amp;Filter, NULL, &amp;filterid))<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto err;<br>+=C2=A0=C2=A0=C2=A0 dmsg (D_LOW, &quot;Filter =
(Permit IPv6 DNS queries from TAP) added with ID=3D%I64d&quot;, filterid);<=
br>+<br>+=C2=A0=C2=A0=C2=A0 FwpmFreeMemory0((void **)&amp;openvpnblob);<br>=
+=C2=A0=C2=A0=C2=A0 return true;<br>+<br>+=C2=A0=C2=A0=C2=A0 err:<br>+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FwpmFreeMemory0((void **)&amp;openv=
pnblob);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>+}=
<br>+<br>+bool<br>+win_wfp_uninit()<br>+{<br>+=C2=A0=C2=A0=C2=A0 dmsg (D_LO=
W, &quot;Uninitializing WFP&quot;);<br>+=C2=A0=C2=A0=C2=A0 if (m_hEngineHan=
dle) {<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FwpmSubLayerDeleteByK=
ey0(m_hEngineHandle, &amp;m_subLayerGUID);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CLEAR(m_subLayerGUID);<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 FwpmEngineClose0(m_hEngineHandle);<br>+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 m_hEngineHandle =3D NULL;<br>+=C2=A0=C2=A0=C2=A0 }<br=
>+=C2=A0=C2=A0=C2=A0 return true;<br>+}<br>+<br>=C2=A0#endif<br>diff --git =
a/src/openvpn/win32.h b/src/openvpn/win32.h<br>index cc18f02..776ef36 10064=
4<br>--- a/src/openvpn/win32.h<br>+++ b/src/openvpn/win32.h<br>@@ -271,5 +2=
71,9 @@ const char *win_get_tempdir();<br>=C2=A0/* Convert a string from UT=
F-8 to UCS-2 */<br>=C2=A0WCHAR *wide_string (const char* utf8, struct gc_ar=
ena *gc);<br>=C2=A0<br>+bool win_wfp_init_funcs();<br>+bool win_wfp_block_d=
ns(const NET_IFINDEX index);<br>+bool win_wfp_uninit();<br>+<br>=C2=A0#endi=
f<br>=C2=A0#endif<br>-- <br>1.9.1<br></div></div>

--001a11c1176c35efe30526812755--

