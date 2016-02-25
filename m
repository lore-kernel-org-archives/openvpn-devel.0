From: Fish <fish.thss@...277...>
Date: Thu, 25 Feb 2016 16:00:07 -0500
Message-Id: <1456434007-5361-1-git-send-email-fish.thss@...277...>
In-Reply-To: <20160225120415.GB24952@...1296...>
References: <20160225120415.GB24952@...1296...>
Subject: [Openvpn-devel] [PATCH v4] Make openvpnserv compilable under Visual
	Studio.
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

Compiled under VS 2010/2013 and Windows 10.

The following major changes are made:
- Remove all runtime function resolving code since OpenVPN 2.4 is
  targeting Vista+.
- Make sure local header inclusion uses double-quotes instead of angle
  brackets.
- Update openvpnserv.vcxproj to include new source files and headers, as
  well as additional lib files.
- Include <netioapi.h> in two source files.

Signed-off-by: Fish <fish.thss@...277...>
---
 src/openvpn/route.c                         |   1 +
 src/openvpnserv/common.c                    |   5 +-
 src/openvpnserv/interactive.c               | 107 +++-------------------------
 src/openvpnserv/openvpnserv.vcxproj         |  14 ++--
 src/openvpnserv/openvpnserv.vcxproj.filters |  16 ++++-
 src/openvpnserv/validate.c                  |   2 +
 src/openvpnserv/win32.h                     |  32 +++++++++
 7 files changed, 70 insertions(+), 107 deletions(-)
 create mode 100644 src/openvpnserv/win32.h

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a90195f..9a67276 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -50,6 +50,7 @@
 #endif
 
 #ifdef WIN32
+#include <netioapi.h>
 #include "openvpn-msg.h"
 
 #define METRIC_NOT_USED ((DWORD)-1)
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index dba4724..15e3a68 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -22,8 +22,9 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <service.h>
-#include <validate.h>
+#include "service.h"
+#include "validate.h"
+
 /*
  * These are necessary due to certain buggy implementations of (v)snprintf,
  * that don't guarantee null termination for size > 0.
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 22239b2..375532a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -34,9 +34,11 @@
 #include <stdio.h>
 #include <sddl.h>
 #include <shellapi.h>
+#include <netioapi.h>
 
 #include "openvpn-msg.h"
 #include "validate.h"
+#include "win32.h"
 
 #define IO_TIMEOUT  2000 /*ms*/
 
@@ -308,12 +310,12 @@ ValidateOptions (HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
     BOOL ret = FALSE;
     int i;
     const WCHAR *msg1 = L"You have specified a config file location (%s relative to %s)"
-                        " that requires admin approval. This error may be avoided"
-                        " by adding your account to the \"%s\" group";
+                        L" that requires admin approval. This error may be avoided"
+                        L" by adding your account to the \"%s\" group";
 
     const WCHAR *msg2 = L"You have specified an option (%s) that may be used"
-                         " only with admin approval. This error may be avoided"
-                         " by adding your account to the \"%s\" group";
+                        L" only with admin approval. This error may be avoided"
+                        L" by adding your account to the \"%s\" group";
 
     argv = CommandLineToArgvW (options, &argc);
 
@@ -479,19 +481,6 @@ InterfaceLuid (const char *iface_name, PNET_LUID luid)
   LPWSTR wide_name;
   int n;
 
-  typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn) (LPCWSTR, PNET_LUID);
-  static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLuid = NULL;
-  if (!ConvertInterfaceAliasToLuid)
-    {
-      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
-      if (iphlpapi == NULL)
-        return GetLastError ();
-
-      ConvertInterfaceAliasToLuid = (ConvertInterfaceAliasToLuidFn) GetProcAddress (iphlpapi, "ConvertInterfaceAliasToLuid");
-      if (!ConvertInterfaceAliasToLuid)
-        return GetLastError ();
-    }
-
   n = MultiByteToWideChar (CP_UTF8, 0, iface_name, -1, NULL, 0);
   wide_name = malloc (n * sizeof (WCHAR));
   MultiByteToWideChar (CP_UTF8, 0, iface_name, -1, wide_name, n);
@@ -510,20 +499,6 @@ CmpAddress (LPVOID item, LPVOID address)
 static DWORD
 DeleteAddress (PMIB_UNICASTIPADDRESS_ROW addr_row)
 {
-  typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
-  static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEntry = NULL;
-
-  if (!DeleteUnicastIpAddressEntry)
-    {
-      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
-      if (iphlpapi == NULL)
-        return GetLastError ();
-
-      DeleteUnicastIpAddressEntry = (DeleteUnicastIpAddressEntryFn) GetProcAddress (iphlpapi, "DeleteUnicastIpAddressEntry");
-      if (!DeleteUnicastIpAddressEntry)
-        return GetLastError ();
-    }
-
   return DeleteUnicastIpAddressEntry (addr_row);
 }
 
@@ -534,26 +509,6 @@ HandleAddressMessage (address_message_t *msg, undo_lists_t *lists)
   PMIB_UNICASTIPADDRESS_ROW addr_row;
   BOOL add = msg->header.type == msg_add_address;
 
-  typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
-  typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn) (PMIB_UNICASTIPADDRESS_ROW);
-  static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEntry = NULL;
-  static InitializeUnicastIpAddressEntryFn InitializeUnicastIpAddressEntry = NULL;
-
-  if (!CreateUnicastIpAddressEntry || !InitializeUnicastIpAddressEntry)
-    {
-      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
-      if (iphlpapi == NULL)
-        return GetLastError ();
-
-      CreateUnicastIpAddressEntry = (CreateUnicastIpAddressEntryFn) GetProcAddress (iphlpapi, "CreateUnicastIpAddressEntry");
-      if (!CreateUnicastIpAddressEntry)
-        return GetLastError ();
-
-      InitializeUnicastIpAddressEntry = (InitializeUnicastIpAddressEntryFn) GetProcAddress (iphlpapi, "InitializeUnicastIpAddressEntry");
-      if (!InitializeUnicastIpAddressEntry)
-        return GetLastError ();
-    }
-
   addr_row = malloc (sizeof (*addr_row));
   if (addr_row == NULL)
     return ERROR_OUTOFMEMORY;
@@ -611,20 +566,6 @@ CmpRoute (LPVOID item, LPVOID route)
 static DWORD
 DeleteRoute (PMIB_IPFORWARD_ROW2 fwd_row)
 {
-  typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
-  static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 = NULL;
-
-  if (!DeleteIpForwardEntry2)
-    {
-      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
-      if (iphlpapi == NULL)
-        return GetLastError ();
-
-      DeleteIpForwardEntry2 = (DeleteIpForwardEntry2Fn) GetProcAddress (iphlpapi, "DeleteIpForwardEntry2");
-      if (!DeleteIpForwardEntry2)
-        return GetLastError ();
-    }
-
   return DeleteIpForwardEntry2 (fwd_row);
 }
 
@@ -635,20 +576,6 @@ HandleRouteMessage (route_message_t *msg, undo_lists_t *lists)
   PMIB_IPFORWARD_ROW2 fwd_row;
   BOOL add = msg->header.type == msg_add_route;
 
-  typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
-  static CreateIpForwardEntry2Fn CreateIpForwardEntry2 = NULL;
-
-  if (!CreateIpForwardEntry2)
-    {
-      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
-      if (iphlpapi == NULL)
-        return GetLastError ();
-
-      CreateIpForwardEntry2 = (CreateIpForwardEntry2Fn) GetProcAddress (iphlpapi, "CreateIpForwardEntry2");
-      if (!CreateIpForwardEntry2)
-        return GetLastError ();
-    }
-
   fwd_row = malloc (sizeof (*fwd_row));
   if (fwd_row == NULL)
     return ERROR_OUTOFMEMORY;
@@ -705,28 +632,10 @@ out:
 static DWORD
 HandleFlushNeighborsMessage (flush_neighbors_message_t *msg)
 {
-  typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFINDEX);
-  static FlushIpNetTable2Fn flush_fn = NULL;
-
   if (msg->family == AF_INET)
     return FlushIpNetTable (msg->iface.index);
 
-  if (!flush_fn)
-    {
-      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
-      if (iphlpapi == NULL)
-        return GetLastError ();
-
-      flush_fn = (FlushIpNetTable2Fn) GetProcAddress (iphlpapi, "FlushIpNetTable2");
-      if (!flush_fn)
-        {
-          if (GetLastError () == ERROR_PROC_NOT_FOUND)
-            return WSAEPFNOSUPPORT;
-          else
-            return GetLastError ();
-        }
-    }
-  return flush_fn (msg->family, msg->iface.index);
+  return FlushIpNetTable2 (msg->family, msg->iface.index);
 }
 
 
@@ -1261,6 +1170,7 @@ FreeWaitHandles (LPHANDLE h)
   free (h);
 }
 
+BOOL CmpHandle(LPVOID item, LPVOID hnd) { return item == hnd; }
 
 VOID WINAPI
 ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
@@ -1361,7 +1271,6 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
             }
 
           /* Worker thread ended */
-          BOOL CmpHandle (LPVOID item, LPVOID hnd) { return item == hnd; }
           HANDLE thread = RemoveListItem (&threads, CmpHandle, handles[error]);
           UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
           CloseHandleEx (&thread);
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index c6760da..4154fe9 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -49,7 +49,7 @@
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
       <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <MinimalRebuild>true</MinimalRebuild>
       <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
@@ -66,13 +66,14 @@
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
       <TargetMachine>MachineX86</TargetMachine>
+      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <Optimization>MaxSpeed</Optimization>
       <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
       <FunctionLevelLinking>true</FunctionLevelLinking>
@@ -90,14 +91,19 @@
       <OptimizeReferences>true</OptimizeReferences>
       <EnableCOMDATFolding>true</EnableCOMDATFolding>
       <TargetMachine>MachineX86</TargetMachine>
+      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
-    <ClCompile Include="openvpnserv.c" />
+    <ClCompile Include="automatic.c" />
+    <ClCompile Include="common.c" />
+    <ClCompile Include="interactive.c" />
     <ClCompile Include="service.c" />
+    <ClCompile Include="validate.c" />
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="service.h" />
+    <ClInclude Include="validate.h" />
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpnserv_resources.rc" />
@@ -111,4 +117,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/openvpnserv.vcxproj.filters
index 0c89b4f..7ccc652 100644
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -15,10 +15,19 @@
     </Filter>
   </ItemGroup>
   <ItemGroup>
-    <ClCompile Include="openvpnserv.c">
+    <ClCompile Include="service.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="service.c">
+    <ClCompile Include="automatic.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="common.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="interactive.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="validate.c">
       <Filter>Source Files</Filter>
     </ClCompile>
   </ItemGroup>
@@ -26,6 +35,9 @@
     <ClInclude Include="service.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="validate.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpnserv_resources.rc">
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index b5809b3..019763e 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -28,6 +28,8 @@
 #include <shlwapi.h>
 #include <lm.h>
 
+#include "win32.h"
+
 static const WCHAR *white_list[] =
     {
        L"auth-retry",
diff --git a/src/openvpnserv/win32.h b/src/openvpnserv/win32.h
new file mode 100644
index 0000000..4d1d4f8
--- /dev/null
+++ b/src/openvpnserv/win32.h
@@ -0,0 +1,32 @@
+/*
+*  OpenVPN -- An application to securely tunnel IP networks
+*             over a single TCP/UDP port, with support for SSL/TLS-based
+*             session authentication and key exchange,
+*             packet encryption, packet authentication, and
+*             packet compression.
+*
+*  Copyright (C) 2013 Heiko Hund <heiko.hund@...1489...>
+*
+*  This program is free software; you can redistribute it and/or modify
+*  it under the terms of the GNU General Public License version 2
+*  as published by the Free Software Foundation.
+*
+*  This program is distributed in the hope that it will be useful,
+*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+*  GNU General Public License for more details.
+*
+*  You should have received a copy of the GNU General Public License
+*  along with this program (see the file COPYING included with this
+*  distribution); if not, write to the Free Software Foundation, Inc.,
+*  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#ifndef _WIN32_H
+#define _WIN32_H
+
+#if defined(_MSC_VER)
+#define snwprintf _snwprintf
+#endif
+
+#endif
-- 
2.6.4


