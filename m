From: Fish <fish.thss@...277...>
Date: Mon, 22 Feb 2016 15:41:57 -0500
Message-Id: <1456173717-45378-1-git-send-email-fish.thss@...277...>
In-Reply-To: <1456171237-43673-1-git-send-email-fish.thss@...277...>
References: <1456171237-43673-1-git-send-email-fish.thss@...277...>
Subject: [Openvpn-devel] [PATCH v3] Make openvpn and openvpnserv compilable
	under Visual Studio.
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
---
 src/openvpn/route.c                         |  1 +
 src/openvpnserv/common.c                    |  2 +-
 src/openvpnserv/interactive.c               | 98 +----------------------------
 src/openvpnserv/openvpnserv.vcxproj         | 12 ++--
 src/openvpnserv/openvpnserv.vcxproj.filters | 10 ++-
 5 files changed, 21 insertions(+), 102 deletions(-)

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
index a293796..9a58e39 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -22,7 +22,7 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <service.h>
+#include "service.h"
 
 /*
  * These are necessary due to certain buggy implementations of (v)snprintf,
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0f3d1d4..a85b859 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,6 +33,7 @@
 #include <aclapi.h>
 #include <stdio.h>
 #include <sddl.h>
+#include <netioapi.h>
 
 #include "openvpn-msg.h"
 
@@ -390,19 +391,6 @@ InterfaceLuid (const char *iface_name, PNET_LUID luid)
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
@@ -421,20 +409,6 @@ CmpAddress (LPVOID item, LPVOID address)
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
 
@@ -445,26 +419,6 @@ HandleAddressMessage (address_message_t *msg, undo_lists_t *lists)
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
@@ -522,20 +476,6 @@ CmpRoute (LPVOID item, LPVOID route)
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
 
@@ -546,20 +486,6 @@ HandleRouteMessage (route_message_t *msg, undo_lists_t *lists)
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
@@ -616,28 +542,10 @@ out:
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
 
 
@@ -1154,6 +1062,7 @@ FreeWaitHandles (LPHANDLE h)
   free (h);
 }
 
+BOOL CmpHandle(LPVOID item, LPVOID hnd) { return item == hnd; }
 
 VOID WINAPI
 ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
@@ -1254,7 +1163,6 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
             }
 
           /* Worker thread ended */
-          BOOL CmpHandle (LPVOID item, LPVOID hnd) { return item == hnd; }
           HANDLE thread = RemoveListItem (&threads, CmpHandle, handles[error]);
           UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
           CloseHandleEx (&thread);
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index c6760da..545a846 100644
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
+      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
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
@@ -90,10 +91,13 @@
       <OptimizeReferences>true</OptimizeReferences>
       <EnableCOMDATFolding>true</EnableCOMDATFolding>
       <TargetMachine>MachineX86</TargetMachine>
+      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
-    <ClCompile Include="openvpnserv.c" />
+    <ClCompile Include="automatic.c" />
+    <ClCompile Include="common.c" />
+    <ClCompile Include="interactive.c" />
     <ClCompile Include="service.c" />
   </ItemGroup>
   <ItemGroup>
@@ -111,4 +115,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/openvpnserv.vcxproj.filters
index 0c89b4f..a016c52 100644
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -15,10 +15,16 @@
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
       <Filter>Source Files</Filter>
     </ClCompile>
   </ItemGroup>
-- 
2.6.4


