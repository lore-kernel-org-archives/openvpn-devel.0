From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  7 May 2021 17:56:44 +0300
Message-Id: <20210507145644.195-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] msvc: add ARM64 configuration
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

While on it, bump msvc solution version.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .../msvc/msvc-generate/msvc-generate.vcxproj  | 44 ++++++++++++-
 openvpn.sln                                   | 30 ++++++++-
 src/compat/compat.vcxproj                     | 39 ++++++++++++
 src/openvpn/openvpn.vcxproj                   | 63 +++++++++++++++++++
 src/openvpnserv/openvpnserv.vcxproj           | 49 +++++++++++++++
 5 files changed, 222 insertions(+), 3 deletions(-)

diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
index 72d310af..dd947f98 100644
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -1,6 +1,10 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
 <Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|ARM64">
+      <Configuration>Debug</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
@@ -9,6 +13,10 @@
       <Configuration>Debug</Configuration>
       <Platform>x64</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|ARM64">
+      <Configuration>Release</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
@@ -33,6 +41,10 @@
     <ConfigurationType>Makefile</ConfigurationType>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
     <PlatformToolset>v141</PlatformToolset>
@@ -41,6 +53,10 @@
     <ConfigurationType>Makefile</ConfigurationType>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
@@ -52,6 +68,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\..\..\src\compat\PropertySheet.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\..\..\src\compat\PropertySheet.props" />
+  </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\..\..\src\compat\PropertySheet.props" />
@@ -60,6 +80,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\..\..\src\compat\PropertySheet.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\..\..\src\compat\PropertySheet.props" />
+  </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
@@ -67,42 +91,60 @@
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
     <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
     <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
+    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
     <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">config-msvc-version.h</NMakeOutput>
     <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">config-msvc-version.h</NMakeOutput>
+    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">config-msvc-version.h</NMakeOutput>
     <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
     <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
+    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
     <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
     <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
+    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
     <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
     <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
+    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
     <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
     <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
+    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
     <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
     <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
+    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
     <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
     <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
+    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
     <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">config-msvc-version.h</NMakeOutput>
     <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|x64'">config-msvc-version.h</NMakeOutput>
+    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">config-msvc-version.h</NMakeOutput>
     <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
     <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|x64'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
+    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
     <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
     <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
+    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
     <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
     <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
+    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
     <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
     <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
+    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
     <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
     <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
+    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
   </PropertyGroup>
   <ItemDefinitionGroup>
   </ItemDefinitionGroup>
@@ -113,4 +155,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/openvpn.sln b/openvpn.sln
index 803f555d..3485bc94 100644
--- a/openvpn.sln
+++ b/openvpn.sln
@@ -1,7 +1,7 @@
 ﻿
 Microsoft Visual Studio Solution File, Format Version 12.00
-# Visual Studio 15
-VisualStudioVersion = 15.0.28010.2026
+# Visual Studio Version 16
+VisualStudioVersion = 16.0.31205.134
 MinimumVisualStudioVersion = 10.0.40219.1
 Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnserv", "src\openvpnserv\openvpnserv.vcxproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
 EndProject
@@ -17,56 +17,82 @@ Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnmsica", "src\openvpn
 EndProject
 Global
 	GlobalSection(SolutionConfigurationPlatforms) = preSolution
+		Debug|ARM64 = Debug|ARM64
 		Debug|Win32 = Debug|Win32
 		Debug|x64 = Debug|x64
+		Release|ARM64 = Release|ARM64
 		Release|Win32 = Release|Win32
 		Release|x64 = Release|x64
 	EndGlobalSection
 	GlobalSection(ProjectConfigurationPlatforms) = postSolution
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|ARM64.ActiveCfg = Debug|ARM64
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|ARM64.Build.0 = Debug|ARM64
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.ActiveCfg = Debug|Win32
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.0 = Debug|Win32
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.ActiveCfg = Debug|x64
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.Build.0 = Debug|x64
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM64.ActiveCfg = Release|ARM64
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|ARM64.Build.0 = Release|ARM64
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg = Release|Win32
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 = Release|Win32
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.ActiveCfg = Release|x64
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.Build.0 = Release|x64
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|ARM64.ActiveCfg = Debug|ARM64
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|ARM64.Build.0 = Debug|ARM64
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.ActiveCfg = Debug|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.0 = Debug|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.ActiveCfg = Debug|x64
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.Build.0 = Debug|x64
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|ARM64.ActiveCfg = Release|ARM64
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|ARM64.Build.0 = Release|ARM64
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg = Release|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 = Release|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.ActiveCfg = Release|x64
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.Build.0 = Release|x64
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|ARM64.ActiveCfg = Debug|ARM64
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|ARM64.Build.0 = Debug|ARM64
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.ActiveCfg = Debug|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.0 = Debug|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.ActiveCfg = Debug|x64
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.Build.0 = Debug|x64
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|ARM64.ActiveCfg = Release|ARM64
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|ARM64.Build.0 = Release|ARM64
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg = Release|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Build.0 = Release|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.ActiveCfg = Release|x64
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.Build.0 = Release|x64
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.ActiveCfg = Debug|ARM64
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|ARM64.Build.0 = Debug|ARM64
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.ActiveCfg = Debug|Win32
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.0 = Debug|Win32
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.ActiveCfg = Debug|x64
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.Build.0 = Debug|x64
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|ARM64.ActiveCfg = Release|ARM64
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|ARM64.Build.0 = Release|ARM64
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.ActiveCfg = Release|Win32
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 = Release|Win32
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.ActiveCfg = Release|x64
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.Build.0 = Release|x64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.ActiveCfg = Debug|ARM64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|ARM64.Build.0 = Debug|ARM64
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.ActiveCfg = Debug|Win32
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.Build.0 = Debug|Win32
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.ActiveCfg = Debug|x64
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.Build.0 = Debug|x64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|ARM64.ActiveCfg = Release|ARM64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|ARM64.Build.0 = Release|ARM64
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.ActiveCfg = Release|Win32
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.Build.0 = Release|Win32
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.ActiveCfg = Release|x64
 		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.Build.0 = Release|x64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM64.ActiveCfg = Debug|ARM64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|ARM64.Build.0 = Debug|ARM64
 		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.ActiveCfg = Debug|Win32
 		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.Build.0 = Debug|Win32
 		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.ActiveCfg = Debug|x64
 		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.Build.0 = Debug|x64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|ARM64.ActiveCfg = Release|ARM64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|ARM64.Build.0 = Release|ARM64
 		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.ActiveCfg = Release|Win32
 		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.Build.0 = Release|Win32
 		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.ActiveCfg = Release|x64
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index b9dba0c4..1a11deb4 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -1,6 +1,10 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
 <Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|ARM64">
+      <Configuration>Debug</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
@@ -9,6 +13,10 @@
       <Configuration>Debug</Configuration>
       <Platform>x64</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|ARM64">
+      <Configuration>Release</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
@@ -37,6 +45,12 @@
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v142</PlatformToolset>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
@@ -47,6 +61,11 @@
     <CharacterSet>MultiByte</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <PlatformToolset>v142</PlatformToolset>
+  </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
@@ -58,6 +77,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="Release.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="Release.props" />
+  </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="Debug.props" />
@@ -66,6 +89,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="Debug.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="Debug.props" />
+  </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
@@ -82,6 +109,12 @@
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <ClCompile>
+      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
@@ -94,6 +127,12 @@
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <ClCompile>
+      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="compat-basename.c" />
     <ClCompile Include="compat-dirname.c" />
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index cf31940c..18272296 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -1,6 +1,10 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
 <Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|ARM64">
+      <Configuration>Debug</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
@@ -9,6 +13,10 @@
       <Configuration>Debug</Configuration>
       <Platform>x64</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|ARM64">
+      <Configuration>Release</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
@@ -37,6 +45,12 @@
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>NotSet</CharacterSet>
+    <PlatformToolset>v142</PlatformToolset>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>NotSet</CharacterSet>
@@ -47,6 +61,11 @@
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>NotSet</CharacterSet>
+    <PlatformToolset>v142</PlatformToolset>
+  </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
@@ -58,6 +77,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\compat\Release.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+  </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\compat\Debug.props" />
@@ -66,6 +89,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\compat\Debug.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+  </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
@@ -73,9 +100,15 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <GenerateManifest>false</GenerateManifest>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <GenerateManifest>false</GenerateManifest>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <GenerateManifest>false</GenerateManifest>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <GenerateManifest>false</GenerateManifest>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <GenerateManifest>false</GenerateManifest>
   </PropertyGroup>
@@ -112,6 +145,21 @@
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <ClCompile>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
+      <TreatWarningAsError>true</TreatWarningAsError>
+    </ClCompile>
+    <ResourceCompile />
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
+      <SubSystem>Console</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
@@ -142,6 +190,21 @@
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <ClCompile>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
+      <TreatWarningAsError>true</TreatWarningAsError>
+    </ClCompile>
+    <ResourceCompile />
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
+      <SubSystem>Console</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="argv.c" />
     <ClCompile Include="auth_token.c" />
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index d0f210ad..ee7d52ea 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -1,6 +1,10 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
 <Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|ARM64">
+      <Configuration>Debug</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
@@ -9,6 +13,10 @@
       <Configuration>Debug</Configuration>
       <Platform>x64</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|ARM64">
+      <Configuration>Release</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
@@ -37,6 +45,12 @@
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v142</PlatformToolset>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
@@ -47,6 +61,11 @@
     <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v142</PlatformToolset>
+  </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
@@ -58,6 +77,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\compat\Release.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+  </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\compat\Debug.props" />
@@ -66,6 +89,10 @@
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
     <Import Project="..\compat\Debug.props" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+  </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
@@ -92,6 +119,17 @@
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <ClCompile>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+    <ResourceCompile />
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <SubSystem>Console</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
@@ -114,6 +152,17 @@
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <ClCompile>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+    <ResourceCompile />
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <SubSystem>Console</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="common.c" />
     <ClCompile Include="interactive.c" />
-- 
2.17.1


