From: Fish <fish.thss@...277...>
Date: Mon, 14 Dec 2015 12:41:35 -0800
Message-Id: <1450125695-36596-1-git-send-email-fish.thss@...277...>
In-Reply-To: <1450121951-129541-1-git-send-email-fish.thss@...277...>
References: <1450121951-129541-1-git-send-email-fish.thss@...277...>
Subject: [Openvpn-devel] [PATCH v4] Make "block-outside-dns" option platform
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

Make the "block-outside-dns" option agnostic of Windows versions by dynamically
loading WFP-related functions. Cross-compiled on Linux and tested on Windows
XP/10.

Also make MSVC happy.
---
 src/openvpn/Makefile.am             |   4 +-
 src/openvpn/init.c                  |   4 +-
 src/openvpn/openvpn.vcxproj         |   6 +-
 src/openvpn/openvpn.vcxproj.filters |   5 +-
 src/openvpn/options.c               |  17 +-
 src/openvpn/win32.c                 | 117 ++++++------
 src/openvpn/win32.h                 |   1 +
 src/openvpn/win32_wfp.h             | 359 ++++++++++++++++++++++++++++++++++++
 8 files changed, 439 insertions(+), 74 deletions(-)
 create mode 100644 src/openvpn/win32_wfp.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 2e602f1..6d02fea 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -110,7 +110,7 @@ openvpn_SOURCES = \
 	status.c status.h \
 	syshead.h \
 	tun.c tun.h \
-	win32.h win32.c \
+	win32.h win32_wfp.h win32.c \
 	cryptoapi.h cryptoapi.c
 openvpn_LDADD = \
 	$(top_builddir)/src/compat/libcompat.la \
@@ -123,5 +123,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lrpcrt4 -lwinmm
 endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e8a96c2..1c0ed60 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1468,7 +1468,7 @@ do_open_tun (struct context *c)
 		   "up",
 		   c->c2.es);
 
-#if _WIN32_WINNT >= 0x0600
+#ifdef WIN32
       if (c->options.block_outside_dns)
       {
         dmsg (D_LOW, "Blocking outside DNS");
@@ -1603,7 +1603,7 @@ do_close_tun (struct context *c, bool force)
 		       "down",
 		       c->c2.es);
 
-#if _WIN32_WINNT >= 0x0600
+#ifdef WIN32
             if (c->options.block_outside_dns)
             {
                 if (!win_wfp_uninit())
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3b2340e..0b1b3fd 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -62,7 +62,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
@@ -87,7 +87,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
@@ -260,4 +260,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 40336ba..dbed3cd 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -449,10 +449,13 @@
     <ClInclude Include="win32.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="win32_wfp.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
       <Filter>Resource Files</Filter>
     </ResourceCompile>
   </ItemGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a6aacd..1832bc5 100644
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
@@ -6252,11 +6248,20 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_IPWIN32);
       options->tuntap_options.register_dns = true;
     }
-#if _WIN32_WINNT >= 0x0600
+#ifdef WIN32
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
 #endif
   else if (streq (p[0], "rdns-internal"))
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 9402361..e87cb7f 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -46,63 +46,17 @@
 
 #include "memdbg.h"
 
-/*
- * WFP-related defines and GUIDs.
- */
-#if _WIN32_WINNT >= 0x0600
-#include <fwpmu.h>
-#include <initguid.h>
-#include <fwpmtypes.h>
-#include <iphlpapi.h>
-
-#ifndef FWPM_SESSION_FLAG_DYNAMIC
-#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
-#endif
-
-// c38d57d1-05a7-4c33-904f-7fbceee60e82
-DEFINE_GUID(
-   FWPM_LAYER_ALE_AUTH_CONNECT_V4,
-   0xc38d57d1,
-   0x05a7,
-   0x4c33,
-   0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
-);
-
-// 4a72393b-319f-44bc-84c3-ba54dcb3b6b4
-DEFINE_GUID(
-   FWPM_LAYER_ALE_AUTH_CONNECT_V6,
-   0x4a72393b,
-   0x319f,
-   0x44bc,
-   0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
-);
-
-// d78e1e87-8644-4ea5-9437-d809ecefc971
-DEFINE_GUID(
-   FWPM_CONDITION_ALE_APP_ID,
-   0xd78e1e87,
-   0x8644,
-   0x4ea5,
-   0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
-);
-
-// c35a604d-d22b-4e1a-91b4-68f674ee674b
-DEFINE_GUID(
-   FWPM_CONDITION_IP_REMOTE_PORT,
-   0xc35a604d,
-   0xd22b,
-   0x4e1a,
-   0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
-);
-
-// 4cd62a49-59c3-4969-b7f3-bda5d32890a4
-DEFINE_GUID(
-   FWPM_CONDITION_IP_LOCAL_INTERFACE,
-   0x4cd62a49,
-   0x59c3,
-   0x4969,
-   0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
-);
+#include "win32_wfp.h"
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
 
 /*
  * WFP firewall name.
@@ -113,7 +67,6 @@ WCHAR * FIREWALL_NAME = L"OpenVPN"; /* GLOBAL */
  * WFP handle and GUID.
  */
 static HANDLE m_hEngineHandle = NULL; /* GLOBAL */
-#endif
 
 /*
  * Windows internal socket API state (opaque).
@@ -1147,7 +1100,52 @@ win_get_tempdir()
   return tmpdir;
 }
 
-#if _WIN32_WINNT >= 0x0600
+bool
+win_wfp_init_funcs ()
+{
+  /* Initialize all WFP-related function pointers */
+  HMODULE iphlpapiHandle;
+  HMODULE fwpuclntHandle;
+
+  iphlpapiHandle = LoadLibrary("iphlpapi.dll");
+  if (iphlpapiHandle == NULL)
+  {
+    msg (M_NONFATAL, "Can't load iphlpapi.dll");
+    return false;
+  }
+
+  fwpuclntHandle = LoadLibrary("fwpuclnt.dll");
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
@@ -1292,4 +1290,3 @@ win_wfp_uninit()
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
 
diff --git a/src/openvpn/win32_wfp.h b/src/openvpn/win32_wfp.h
new file mode 100644
index 0000000..a77ead9
--- /dev/null
+++ b/src/openvpn/win32_wfp.h
@@ -0,0 +1,359 @@
+/*
+ This Software is provided under the Zope Public License (ZPL) Version 2.1.
+
+ Copyright (c) 2009, 2010 by the mingw-w64 project
+
+ See the AUTHORS file for the list of contributors to the mingw-w64 project.
+
+ This license has been certified as open source. It has also been designated
+ as GPL compatible by the Free Software Foundation (FSF).
+
+ Redistribution and use in source and binary forms, with or without
+ modification, are permitted provided that the following conditions are met:
+
+   1. Redistributions in source code must retain the accompanying copyright
+      notice, this list of conditions, and the following disclaimer.
+   2. Redistributions in binary form must reproduce the accompanying
+      copyright notice, this list of conditions, and the following disclaimer
+      in the documentation and/or other materials provided with the
+      distribution.
+   3. Names of the copyright holders must not be used to endorse or promote
+      products derived from this software without prior written permission
+      from the copyright holders.
+   4. The right to distribute this software or to use it for any purpose does
+      not give you the right to use Servicemarks (sm) or Trademarks (tm) of
+      the copyright holders.  Use of them is covered by separate agreement
+      with the copyright holders.
+   5. If any files are modified, you must cause the modified files to carry
+      prominent notices stating that you changed the files and the date of
+      any change.
+
+ Disclaimer
+
+ THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
+ OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
+ EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
+ OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+ EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+*/
+
+/*
+ * Windows Filtering Platform (WFP) related prototypes, mostly stripped out of
+ * mingw-w64.
+ */
+
+/*
+ * WFP-related defines and GUIDs.
+ */
+
+#ifndef WIN32_WFP_H
+#define WIN32_WFP_H
+
+#include <initguid.h>
+#include <iphlpapi.h>
+#include <rpc.h>
+#include <rpcdce.h>
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
+    union {
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
+    };
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
+    union {
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
+    };
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
+  union {
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
+  BOOL            kernelMode;
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
+  union {
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
+typedef NETIO_STATUS *(WINAPI *func_ConvertInterfaceIndexToLuid)(
+  NET_IFINDEX InterfaceIndex,
+  PNET_LUID InterfaceLuid
+);
+
+typedef DWORD *(WINAPI *func_FwpmEngineOpen0)(
+  const wchar_t *serverName,
+  UINT32 authnService,
+  SEC_WINNT_AUTH_IDENTITY_W *authIdentity,
+  const FWPM_SESSION0 *session,
+  HANDLE *engineHandle
+);
+
+typedef DWORD *(WINAPI *func_FwpmEngineClose0)(
+  HANDLE engineHandle
+);
+
+typedef DWORD *(WINAPI *func_FwpmFilterAdd0)(
+  HANDLE engineHandle,
+  const FWPM_FILTER0 *filter,
+  PSECURITY_DESCRIPTOR sd,
+  UINT64 *id
+);
+
+typedef DWORD *(WINAPI *func_FwpmSubLayerAdd0)(
+  HANDLE engineHandle,
+  const FWPM_SUBLAYER0 *subLayer,
+  PSECURITY_DESCRIPTOR sd
+);
+
+typedef DWORD *(WINAPI *func_FwpmSubLayerDeleteByKey0)(
+  HANDLE engineHandle,
+  const GUID *key
+);
+
+typedef void *(WINAPI *func_FwpmFreeMemory0)(
+  void **p
+);
+
+typedef DWORD *(WINAPI *func_FwpmGetAppIdFromFileName0)(
+  const wchar_t *fileName,
+  FWP_BYTE_BLOB **appId
+);
+
+#endif
-- 
2.6.4


