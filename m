From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 24 Jul 2020 22:56:34 +0300
Message-Id: <20200724195634.493-1-lstipakov@...277...>
In-Reply-To: <20200724184020.GJ1431@...1296...>
References: <20200724184020.GJ1431@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Improve Windows version detection with
 manifest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Add manifest file to detect Windows versions greater than Windows 8.

Below is example output on Windows 10.

Before:
        Windows version 6.2 (Windows 8 or greater) 64bit

After:
        Windows version 10.0 (Windows 10 or greater) 64bit

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v2: 
     - fix build from tarball (added manifest file to EXTRA_DIST)
     - fix build on old mingw like ubuntu 18.04 (added missig define)

 src/compat/compat-versionhelpers.h     | 10 ++++++++
 src/openvpn/Makefile.am                |  3 ++-
 src/openvpn/openvpn.manifest           | 33 ++++++++++++++++++++++++++
 src/openvpn/openvpn.vcxproj            | 15 ++++++++++++
 src/openvpn/openvpn.vcxproj.filters    |  5 ++++
 src/openvpn/openvpn_win32_resources.rc |  2 ++
 src/openvpn/win32.c                    | 20 ++++++++++++++--
 src/openvpn/win32.h                    |  8 ++++---
 8 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100644 src/openvpn/openvpn.manifest

diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
index 251fb047..9e25470e 100644
--- a/src/compat/compat-versionhelpers.h
+++ b/src/compat/compat-versionhelpers.h
@@ -18,6 +18,10 @@
 
 #define _WIN32_WINNT_WINBLUE    0x0603
 
+#ifndef _WIN32_WINNT_WINTHRESHOLD
+#define _WIN32_WINNT_WINTHRESHOLD    0x0A00 // Windows 10
+#endif
+
 VERSIONHELPERAPI
 IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
 {
@@ -95,6 +99,12 @@ IsWindows8Point1OrGreater(void)
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0);
 }
 
+VERSIONHELPERAPI
+IsWindows10OrGreater()
+{
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), LOBYTE(_WIN32_WINNT_WINTHRESHOLD), 0);
+}
+
 VERSIONHELPERAPI
 IsWindowsServer(void)
 {
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 47ad762d..37b002c6 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -16,7 +16,8 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = \
 	openvpn.vcxproj \
-	openvpn.vcxproj.filters
+	openvpn.vcxproj.filters \
+	openvpn.manifest
 
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include \
diff --git a/src/openvpn/openvpn.manifest b/src/openvpn/openvpn.manifest
new file mode 100644
index 00000000..fa5b3d7f
--- /dev/null
+++ b/src/openvpn/openvpn.manifest
@@ -0,0 +1,33 @@
+<?xml version="1.0" encoding="utf-8" standalone="yes"?>
+<assembly manifestVersion="1.0" xmlns="urn:schemas-microsoft-com:asm.v1" xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">
+    <compatibility xmlns="urn:schemas-microsoft-com:compatibility.v1">
+        <application>
+            <!-- Windows 10 -->
+            <supportedOS Id="{8e0f7a12-bfb3-4fe8-b9a5-48fd50a15a9a}"/>
+            <!-- Windows 8.1 -->
+            <supportedOS Id="{1f676c76-80e1-4239-95bb-83d0f6d0da78}"/>
+            <!-- Windows 8 -->
+            <supportedOS Id="{4a2f28e3-53b9-4441-ba9c-d69d4a4a6e38}"/>
+            <!-- Windows 7 -->
+            <supportedOS Id="{35138b9a-5d96-4fbd-8e2d-a2440225f93a}"/>
+            <!-- Windows Vista -->
+            <supportedOS Id="{e2011457-1546-43c5-a5fe-008deee3d3f0}"/>
+        </application>
+    </compatibility>
+    <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
+        <security>
+            <requestedPrivileges>
+                <!--
+                  UAC settings:
+                  - app should run at same integrity level as calling process
+                  - app does not need to manipulate windows belonging to
+                    higher-integrity-level processes
+                  -->
+                <requestedExecutionLevel
+                    level="asInvoker"
+                    uiAccess="false"
+                />
+            </requestedPrivileges>
+        </security>
+    </trustInfo>
+</assembly>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index bd1a5844..5367979d 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -70,6 +70,18 @@
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <GenerateManifest>false</GenerateManifest>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <GenerateManifest>false</GenerateManifest>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <GenerateManifest>false</GenerateManifest>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <GenerateManifest>false</GenerateManifest>
+  </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
@@ -311,6 +323,9 @@
       <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
     </ProjectReference>
   </ItemGroup>
+  <ItemGroup>
+    <Manifest Include="openvpn.manifest" />
+  </ItemGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index e0bc7d5e..cf5748c7 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -515,4 +515,9 @@
       <Filter>Resource Files</Filter>
     </ResourceCompile>
   </ItemGroup>
+  <ItemGroup>
+    <Manifest Include="openvpn.manifest">
+      <Filter>Resource Files</Filter>
+    </Manifest>
+  </ItemGroup>
 </Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn_win32_resources.rc
index e4f1ee95..1ea5f878 100644
--- a/src/openvpn/openvpn_win32_resources.rc
+++ b/src/openvpn/openvpn_win32_resources.rc
@@ -7,6 +7,8 @@
 
 #pragma code_page(65001) /* UTF8 */
 
+1 RT_MANIFEST "openvpn.manifest"
+
 LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
 
 VS_VERSION_INFO VERSIONINFO
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eb4c0307..7e913165 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1417,10 +1417,18 @@ win32_version_info(void)
     {
         return WIN_7;
     }
-    else
+
+    if (!IsWindows8Point1OrGreater())
     {
         return WIN_8;
     }
+
+    if (!IsWindows10OrGreater())
+    {
+        return WIN_8_1;
+    }
+
+    return WIN_10;
 }
 
 bool
@@ -1458,7 +1466,15 @@ win32_version_string(struct gc_arena *gc, bool add_name)
             break;
 
         case WIN_8:
-            buf_printf(&out, "6.2%s", add_name ? " (Windows 8 or greater)" : "");
+            buf_printf(&out, "6.2%s", add_name ? " (Windows 8)" : "");
+            break;
+
+        case WIN_8_1:
+            buf_printf(&out, "6.3%s", add_name ? " (Windows 8.1)" : "");
+            break;
+
+        case WIN_10:
+            buf_printf(&out, "10.0%s", add_name ? " (Windows 10 or greater)" : "");
             break;
 
         default:
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 79504776..da85ed4d 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -298,10 +298,12 @@ bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);
 
 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);
 
-#define WIN_XP 0
+#define WIN_XP    0
 #define WIN_VISTA 1
-#define WIN_7 2
-#define WIN_8 3
+#define WIN_7     2
+#define WIN_8     3
+#define WIN_8_1   4
+#define WIN_10    5
 
 int win32_version_info(void);
 
-- 
2.17.1


