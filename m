From: Fish <fish.thss@...277...>
Date: Thu, 10 Dec 2015 16:46:30 -0800
Message-Id: <1449794790-45430-1-git-send-email-fish.thss@...277...>
In-Reply-To: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
References: <CADCH5Ogh2ROBNti_hmBUBcQYBz4SuHJo_-cii14_E6aj9jmj-A@...278...>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: iam@...2070...

Based on release/2.3 branch and ValdikSS's v9 patch, this patch is
cross-compiled on Linux and tested on Windows XP/10. The VC project file is
left untouched - you might want to add rpcrt4.lib to compile and link it under
MSVC.

Take ValdikSS<iam@...2070...>'s patch for "block-outside-dns" option and
make it Windows-version-agnostic.
---
 src/openvpn/Makefile.am |   2 +-
 src/openvpn/init.c      |   4 -
 src/openvpn/options.c   |  17 +--
 src/openvpn/win32.c     | 309 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/win32.h     |   1 +
 5 files changed, 315 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 2e602f1..149a533 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -123,5 +123,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lrpcrt4 -lwinmm
 endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e8a96c2..960535d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1468,14 +1468,12 @@ do_open_tun (struct context *c)
 		   "up",
 		   c->c2.es);
 
-#if _WIN32_WINNT >= 0x0600
       if (c->options.block_outside_dns)
       {
         dmsg (D_LOW, "Blocking outside DNS");
         if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
             msg (M_FATAL, "Blocking DNS failed!");
       }
-#endif
 
       /* possibly add routes */
       if (!c->options.route_delay_defined)
@@ -1603,13 +1601,11 @@ do_close_tun (struct context *c, bool force)
 		       "down",
 		       c->c2.es);
 
-#if _WIN32_WINNT >= 0x0600
             if (c->options.block_outside_dns)
             {
                 if (!win_wfp_uninit())
                     msg (M_FATAL, "Uninitialising WFP failed!");
             }
-#endif
 
 	  /* actually close tun/tap device based on --down-pre flag */
 	  if (c->options.down_pre)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a6aacd..8d85502 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -715,9 +715,7 @@ static const char usage_message[] =
   "                       optional parameter controls the initial state of ex.\n"
   "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
   "                  after TAP adapter is up and routes have been added.\n"
-#if _WIN32_WINNT >= 0x0600
   "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
-#endif
   "Windows Standalone Options:\n"
   "\n"
   "--show-adapters : Show all TAP-Windows adapters.\n"
@@ -1682,9 +1680,7 @@ show_settings (const struct options *o)
 #ifdef WIN32
   SHOW_BOOL (show_net_up);
   SHOW_INT (route_method);
-#if _WIN32_WINNT >= 0x0600
   SHOW_BOOL (block_outside_dns);
-#endif
   show_tuntap_options (&o->tuntap_options);
 #endif
 #endif
@@ -6252,13 +6248,20 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_IPWIN32);
       options->tuntap_options.register_dns = true;
     }
-#if _WIN32_WINNT >= 0x0600
   else if (streq (p[0], "block-outside-dns") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_IPWIN32);
-      options->block_outside_dns = true;
+      if (win_wfp_init_funcs())
+      {
+        options->block_outside_dns = true;
+      }
+      else
+      {
+        msg (msglevel_fc, "Failed to enable --block-outside-dns. "
+                       "Maybe WFP is not supported on your system?");
+	      goto err;
+      }
     }
-#endif
   else if (streq (p[0], "rdns-internal"))
      /* standalone method for internal use
       *
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 9402361..f4d0433 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -49,11 +49,10 @@
 /*
  * WFP-related defines and GUIDs.
  */
-#if _WIN32_WINNT >= 0x0600
-#include <fwpmu.h>
 #include <initguid.h>
-#include <fwpmtypes.h>
 #include <iphlpapi.h>
+#include <rpc.h>
+#include <rpcdce.h>
 
 #ifndef FWPM_SESSION_FLAG_DYNAMIC
 #define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
@@ -104,6 +103,264 @@ DEFINE_GUID(
    0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
 );
 
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
+/* WFP function pointers. Initialized in win_wfp_init_funcs() */
+func_ConvertInterfaceIndexToLuid ConvertInterfaceIndexToLuid = NULL;
+func_FwpmEngineOpen0 FwpmEngineOpen0 = NULL;
+func_FwpmEngineClose0 FwpmEngineClose0 = NULL;
+func_FwpmFilterAdd0 FwpmFilterAdd0 = NULL;
+func_FwpmSubLayerAdd0 FwpmSubLayerAdd0 = NULL;
+func_FwpmSubLayerDeleteByKey0 FwpmSubLayerDeleteByKey0 = NULL;
+func_FwpmFreeMemory0 FwpmFreeMemory0 = NULL;
+func_FwpmGetAppIdFromFileName0 FwpmGetAppIdFromFileName0 = NULL;
+
 /*
  * WFP firewall name.
  */
@@ -113,7 +370,6 @@ WCHAR * FIREWALL_NAME = L"OpenVPN"; /* GLOBAL */
  * WFP handle and GUID.
  */
 static HANDLE m_hEngineHandle = NULL; /* GLOBAL */
-#endif
 
 /*
  * Windows internal socket API state (opaque).
@@ -1147,7 +1403,49 @@ win_get_tempdir()
   return tmpdir;
 }
 
-#if _WIN32_WINNT >= 0x0600
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
+  ConvertInterfaceIndexToLuid = (func_ConvertInterfaceIndexToLuid)GetProcAddress(iphlpapiHandle, "ConvertInterfaceIndexToLuid");
+  FwpmFilterAdd0 = (func_FwpmFilterAdd0)GetProcAddress(fwpuclntHandle, "FwpmFilterAdd0");
+  FwpmEngineOpen0 = (func_FwpmEngineOpen0)GetProcAddress(fwpuclntHandle, "FwpmEngineOpen0");
+  FwpmEngineClose0 = (func_FwpmEngineClose0)GetProcAddress(fwpuclntHandle, "FwpmEngineClose0");
+  FwpmSubLayerAdd0 = (func_FwpmSubLayerAdd0)GetProcAddress(fwpuclntHandle, "FwpmSubLayerAdd0");
+  FwpmSubLayerDeleteByKey0 = (func_FwpmSubLayerDeleteByKey0)GetProcAddress(fwpuclntHandle, "FwpmSubLayerDeleteByKey0");
+  FwpmFreeMemory0 = (func_FwpmFreeMemory0)GetProcAddress(fwpuclntHandle, "FwpmFreeMemory0");
+  FwpmGetAppIdFromFileName0 = (func_FwpmGetAppIdFromFileName0)GetProcAddress(fwpuclntHandle, "FwpmGetAppIdFromFileName0");
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
 bool
 win_wfp_add_filter (HANDLE engineHandle,
                     const FWPM_FILTER0 *filter,
@@ -1292,4 +1590,3 @@ win_wfp_uninit()
 }
 
 #endif
-#endif
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index a5baebd..776ef36 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -271,6 +271,7 @@ const char *win_get_tempdir();
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_string (const char* utf8, struct gc_arena *gc);
 
+bool win_wfp_init_funcs();
 bool win_wfp_block_dns(const NET_IFINDEX index);
 bool win_wfp_uninit();
 
-- 
2.6.4


