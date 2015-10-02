From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  2 Oct 2015 14:46:41 +0300
Message-Id: <1443786401-30416-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] This fixes MSVS 2013 compilation.
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

 * Tools version changed to 12
 * Added comp.c/h and compat.c/h to project files
 * Workaround for missing __attribute__ support

Also, as a preparation for MSVS2015, ensured that snprintf is not defined for that VS version.
---
 config-msvc.h                       |  3 +++
 src/compat/compat.vcxproj           |  6 ++++--
 src/openvpn/openvpn.vcxproj         | 10 ++++++++--
 src/openvpn/syshead.h               |  1 +
 src/openvpnserv/openvpnserv.vcxproj |  6 ++++--
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 8294c2c..ffd35f4 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -90,7 +90,10 @@
 
 #define strncasecmp strnicmp
 #define strcasecmp _stricmp
+
+#if _MSC_VER<1900
 #define snprintf _snprintf
+#endif
 
 #if _MSC_VER < 1800
 #define strtoull strtoul
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 42979c1..7fca62f 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -1,5 +1,5 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets="Build" ToolsVersion="12.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
@@ -20,10 +20,12 @@
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v120</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
+    <PlatformToolset>v120</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -84,4 +86,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3b2340e..b117b0b 100755
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -1,5 +1,5 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets="Build" ToolsVersion="12.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
@@ -20,10 +20,12 @@
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v120</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v120</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -100,6 +102,8 @@
     <ClCompile Include="base64.c" />
     <ClCompile Include="buffer.c" />
     <ClCompile Include="clinat.c" />
+    <ClCompile Include="comp.c" />
+    <ClCompile Include="compstub.c" />
     <ClCompile Include="console.c" />
     <ClCompile Include="crypto.c" />
     <ClCompile Include="crypto_openssl.c" />
@@ -168,6 +172,8 @@
     <ClInclude Include="buffer.h" />
     <ClInclude Include="circ_list.h" />
     <ClInclude Include="clinat.h" />
+    <ClInclude Include="comp.h" />
+    <ClInclude Include="compstub.h" />
     <ClInclude Include="common.h" />
     <ClInclude Include="console.h" />
     <ClInclude Include="crypto.h" />
@@ -260,4 +266,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 4bebb25..92f5834 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -47,6 +47,7 @@
 
 #ifdef _MSC_VER // Visual Studio
 #define __func__ __FUNCTION__
+#define __attribute__(x)
 #endif
 
 #if defined(__APPLE__)
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 0b75ed0..c6760da 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -1,5 +1,5 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets="Build" ToolsVersion="12.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
@@ -20,10 +20,12 @@
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v120</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
+    <PlatformToolset>v120</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -109,4 +111,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
\ No newline at end of file
+</Project>
-- 
1.9.1


