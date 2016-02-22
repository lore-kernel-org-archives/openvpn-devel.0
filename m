From: fish.thss@...277...
Date: Mon, 22 Feb 2016 11:37:27 -0500
Message-Id: <1456159047-37064-1-git-send-email-fish.thss@...277...>
Subject: [Openvpn-devel] [PATCH] Make openvpnserv compilable under Visual
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

From: Fish <fish.thss@...277...>

Compiled under VS 2010/2013 and Windows 10.

The following major changes are made:
- Use the correct typedef construct to define function types.
- Make sure local header inclusion uses double-quotes instead of angle
  brackets.
- Update openvpnserv.vcxproj to include new source files and headers, as
  well as additional lib files.
---
 src/openvpnserv/common.c                    |  2 +-
 src/openvpnserv/interactive.c               | 16 ++++++++--------
 src/openvpnserv/openvpnserv.vcxproj         | 12 ++++++++----
 src/openvpnserv/openvpnserv.vcxproj.filters | 10 ++++++++--
 4 files changed, 25 insertions(+), 15 deletions(-)

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
index 0f3d1d4..96a15f6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -390,7 +390,7 @@ InterfaceLuid (const char *iface_name, PNET_LUID luid)
   LPWSTR wide_name;
   int n;
 
-  typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn) (LPCWSTR, PNET_LUID);
+  typedef NETIO_STATUS (WINAPI *ConvertInterfaceAliasToLuidFn) (LPCWSTR, PNET_LUID);
   static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLuid = NULL;
   if (!ConvertInterfaceAliasToLuid)
     {
@@ -421,7 +421,7 @@ CmpAddress (LPVOID item, LPVOID address)
 static DWORD
 DeleteAddress (PMIB_UNICASTIPADDRESS_ROW addr_row)
 {
-  typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
+  typedef NETIO_STATUS (NETIOAPI_API_ *DeleteUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
   static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEntry = NULL;
 
   if (!DeleteUnicastIpAddressEntry)
@@ -445,8 +445,8 @@ HandleAddressMessage (address_message_t *msg, undo_lists_t *lists)
   PMIB_UNICASTIPADDRESS_ROW addr_row;
   BOOL add = msg->header.type == msg_add_address;
 
-  typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
-  typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn) (PMIB_UNICASTIPADDRESS_ROW);
+  typedef NETIO_STATUS (NETIOAPI_API_ *CreateUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
+  typedef NETIO_STATUS (NETIOAPI_API_ *InitializeUnicastIpAddressEntryFn) (PMIB_UNICASTIPADDRESS_ROW);
   static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEntry = NULL;
   static InitializeUnicastIpAddressEntryFn InitializeUnicastIpAddressEntry = NULL;
 
@@ -522,7 +522,7 @@ CmpRoute (LPVOID item, LPVOID route)
 static DWORD
 DeleteRoute (PMIB_IPFORWARD_ROW2 fwd_row)
 {
-  typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
+  typedef NETIO_STATUS (NETIOAPI_API_ *DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
   static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 = NULL;
 
   if (!DeleteIpForwardEntry2)
@@ -546,7 +546,7 @@ HandleRouteMessage (route_message_t *msg, undo_lists_t *lists)
   PMIB_IPFORWARD_ROW2 fwd_row;
   BOOL add = msg->header.type == msg_add_route;
 
-  typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
+  typedef NETIO_STATUS (NETIOAPI_API_ *CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
   static CreateIpForwardEntry2Fn CreateIpForwardEntry2 = NULL;
 
   if (!CreateIpForwardEntry2)
@@ -616,7 +616,7 @@ out:
 static DWORD
 HandleFlushNeighborsMessage (flush_neighbors_message_t *msg)
 {
-  typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFINDEX);
+  typedef NETIO_STATUS (NETIOAPI_API_ *FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFINDEX);
   static FlushIpNetTable2Fn flush_fn = NULL;
 
   if (msg->family == AF_INET)
@@ -1154,6 +1154,7 @@ FreeWaitHandles (LPHANDLE h)
   free (h);
 }
 
+BOOL CmpHandle(LPVOID item, LPVOID hnd) { return item == hnd; }
 
 VOID WINAPI
 ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
@@ -1254,7 +1255,6 @@ ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
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


