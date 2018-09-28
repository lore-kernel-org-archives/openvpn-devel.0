From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 28 Sep 2018 16:26:49 +0300
Message-Id: <1538141209-32330-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] win: support for Visual Studio 2017
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

From: Lev Stipakov <lev@...515...>

This patch enables building openvpn with Visual Studio 2017.

It is advised to use openvpn-build/msvs/build.bat which
also downloads and build required dependencies.

Changes made:

 - updated path to Visual Studio toolchain
 - updated platform toolset
 - added missing libraries
 - added x64 configurations
 - enabled AEAD ciphers to make NCP work
 - enabled unicode support
 - updated source files in project settings
 - fix includes
 - restored variable which was erroneously removed
 - added properties file which sets required env variables
 	(required to build with IDE)
 - etc

Signed-off-by: Lev Stipakov <lev@...515...>
---

AppVeyor build with cygwin and VS2017: https://ci.appveyor.com/project/lstipakov/openvpn-build/build/openvpn-build-19

 build/msvc/msvc-generate/msvc-generate.vcxproj | 51 +++++++++++++-
 config-msvc.h                                  |  1 +
 msvc-build.bat                                 |  6 +-
 msvc-dev.bat                                   |  2 +
 msvc-env.bat                                   |  6 +-
 openvpn.sln                                    | 27 ++++++-
 src/compat/PropertySheet.props                 | 40 +++++++++++
 src/compat/compat.vcxproj                      | 65 ++++++++++++++++-
 src/openvpn/openvpn.vcxproj                    | 97 +++++++++++++++++++++++--
 src/openvpn/syshead.h                          |  1 +
 src/openvpnserv/interactive.c                  |  1 -
 src/openvpnserv/openvpnserv.vcxproj            | 98 ++++++++++++++++++++++++--
 src/openvpnserv/service.h                      |  1 +
 src/openvpnserv/validate.c                     |  3 +
 14 files changed, 375 insertions(+), 24 deletions(-)
 create mode 100644 src/compat/PropertySheet.props

diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
index 8b7ec22..72d310a 100644
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -1,35 +1,64 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|x64">
+      <Configuration>Debug</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|x64">
+      <Configuration>Release</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
   </ItemGroup>
   <PropertyGroup Label="Globals">
     <ProjectGuid>{8598C2C8-34C4-47A1-99B0-7C295A890615}</ProjectGuid>
     <RootNamespace>msvc-generate</RootNamespace>
     <Keyword>MakeFileProj</Keyword>
+    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\..\..\src\compat\PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\..\..\src\compat\PropertySheet.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\..\..\src\compat\PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\..\..\src\compat\PropertySheet.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
@@ -37,25 +66,43 @@
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
     <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
+    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
     <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">config-msvc-version.h</NMakeOutput>
+    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">config-msvc-version.h</NMakeOutput>
     <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
+    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
     <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
+    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
     <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
+    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
     <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
+    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
     <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
+    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
     <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
+    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
     <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|x64'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">config-msvc-version.h</NMakeOutput>
+    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|x64'">config-msvc-version.h</NMakeOutput>
     <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
+    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|x64'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
     <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
+    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
     <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
+    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
     <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
+    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
     <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
+    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
   </PropertyGroup>
   <ItemDefinitionGroup>
   </ItemDefinitionGroup>
@@ -66,4 +113,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/config-msvc.h b/config-msvc.h
index 8be9195..45fae8b 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -5,6 +5,7 @@
 #define ENABLE_DEF_AUTH 1
 #define ENABLE_PF 1
 #define ENABLE_CRYPTO_OPENSSL 1
+#define HAVE_AEAD_CIPHER_MODES 1
 #define ENABLE_DEBUG 1
 #define ENABLE_EUREPHIA 1
 #define ENABLE_FRAGMENT 1
diff --git a/msvc-build.bat b/msvc-build.bat
index fd6d558..8256c62 100644
--- a/msvc-build.bat
+++ b/msvc-build.bat
@@ -7,13 +7,15 @@ setlocal ENABLEDELAYEDEXPANSION
 cd /d %0\..
 call msvc-env.bat
 
-set PLATFORMS=Win32
-set CONFIGURATIONS=Release
+set PLATFORMS=x64
+set CONFIGURATIONS=Debug Release
 
 if exist "%VCHOME%\vcvarsall.bat" (
 	call "%VCHOME%\vcvarsall.bat"
 ) else if exist "%VCHOME%\bin\vcvars32.bat" (
 	call "%VCHOME%\bin\vcvars32.bat"
+) else if exist "%VCHOME%\Auxiliary\Build\vcvars32.bat" (
+	call "%VCHOME%\Auxiliary\Build\vcvars32.bat"
 ) else (
 	echo Cannot detect visual studio
 	goto error
diff --git a/msvc-dev.bat b/msvc-dev.bat
index dbd7be0..74aee0b 100644
--- a/msvc-dev.bat
+++ b/msvc-dev.bat
@@ -8,6 +8,8 @@ if exist "%VSHOME%\Common7\IDE\VCExpress.exe" (
 	set IDE=%VSHOME%\Common7\IDE\VCExpress.exe
 ) else if exist "%VSHOME%\Common7\IDE\devenv.exe" (
 	set IDE=%VSHOME%\Common7\IDE\devenv.exe
+) else if exist "%VCHOME%\Auxiliary\Build\vcvars64.bat" (
+	call "%VCHOME%\Auxiliary\Build\vcvars64.bat"
 ) else (
 	echo "Cannot detect visual studio environment"
 	goto error
diff --git a/msvc-env.bat b/msvc-env.bat
index aabed75..cc9663d 100644
--- a/msvc-env.bat
+++ b/msvc-env.bat
@@ -4,8 +4,8 @@ rem Put your own settings at msvc-env-local.bat
 if exist msvc-env-local.bat call msvc-env-local.bat
 
 if "%ProgramFiles(x86)%"=="" set ProgramFiles(x86)=%ProgramFiles%
-if "%VSCOMNTOOLS%"=="" SET VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio 10.0\Common7\Tools
-if "%VSCOMNTOOLS%"=="" SET VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio 9.0\Common7\Tools
+if "%VSCOMNTOOLS%"=="" set VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\Common7\Tools
+if not exist "%VSCOMNTOOLS%" set VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\Common7\Tools
 if "%VSHOME%"=="" SET VSHOME=%VSCOMNTOOLS%\..\..
 if "%VCHOME%"=="" SET VCHOME=%VSHOME%\VC
 
@@ -13,7 +13,7 @@ set SOURCEBASE=%cd%
 set SOLUTION=openvpn.sln
 set CPPFLAGS=%CPPFLAGS%;_CRT_SECURE_NO_WARNINGS;WIN32_LEAN_AND_MEAN;_CRT_NONSTDC_NO_WARNINGS;_CRT_SECURE_NO_WARNINGS
 set CPPFLAGS=%CPPFLAGS%;NTDDI_VERSION=NTDDI_VISTA;_WIN32_WINNT=_WIN32_WINNT_VISTA
-set CPPFLAGS=%CPPFLAGS%;_USE_32BIT_TIME_T
+set CPPFLAGS=%CPPFLAGS%;
 set CPPFLAGS=%CPPFLAGS%;%EXTRA_CPPFLAGS%
 
 if exist config-msvc-local.h set CPPFLAGS="%CPPFLAGS%;HAVE_CONFIG_MSVC_LOCAL_H"
diff --git a/openvpn.sln b/openvpn.sln
index 90c01b8..51fdaf0 100644
--- a/openvpn.sln
+++ b/openvpn.sln
@@ -1,6 +1,8 @@
 ﻿
-Microsoft Visual Studio Solution File, Format Version 11.00
-# Visual C++ Express 2010
+Microsoft Visual Studio Solution File, Format Version 12.00
+# Visual Studio 15
+VisualStudioVersion = 15.0.28010.2026
+MinimumVisualStudioVersion = 10.0.40219.1
 Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnserv", "src\openvpnserv\openvpnserv.vcxproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
 EndProject
 Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpn", "src\openvpn\openvpn.vcxproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
@@ -12,27 +14,48 @@ EndProject
 Global
 	GlobalSection(SolutionConfigurationPlatforms) = preSolution
 		Debug|Win32 = Debug|Win32
+		Debug|x64 = Debug|x64
 		Release|Win32 = Release|Win32
+		Release|x64 = Release|x64
 	EndGlobalSection
 	GlobalSection(ProjectConfigurationPlatforms) = postSolution
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.ActiveCfg = Debug|Win32
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.0 = Debug|Win32
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.ActiveCfg = Debug|x64
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|x64.Build.0 = Debug|x64
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg = Release|Win32
 		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 = Release|Win32
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.ActiveCfg = Release|x64
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|x64.Build.0 = Release|x64
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.ActiveCfg = Debug|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.0 = Debug|Win32
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.ActiveCfg = Debug|x64
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.Build.0 = Debug|x64
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg = Release|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 = Release|Win32
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.ActiveCfg = Release|x64
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.Build.0 = Release|x64
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.ActiveCfg = Debug|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.0 = Debug|Win32
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.ActiveCfg = Debug|x64
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|x64.Build.0 = Debug|x64
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg = Release|Win32
 		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Build.0 = Release|Win32
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.ActiveCfg = Release|x64
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|x64.Build.0 = Release|x64
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.ActiveCfg = Debug|Win32
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.0 = Debug|Win32
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.ActiveCfg = Debug|x64
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|x64.Build.0 = Debug|x64
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.ActiveCfg = Release|Win32
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 = Release|Win32
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.ActiveCfg = Release|x64
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.Build.0 = Release|x64
 	EndGlobalSection
 	GlobalSection(SolutionProperties) = preSolution
 		HideSolutionNode = FALSE
 	EndGlobalSection
+	GlobalSection(ExtensibilityGlobals) = postSolution
+		SolutionGuid = {EB3CE5D3-415C-46F0-96AB-E1CDA287AB6D}
+	EndGlobalSection
 EndGlobal
diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.props
new file mode 100644
index 0000000..97d3a3b
--- /dev/null
+++ b/src/compat/PropertySheet.props
@@ -0,0 +1,40 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ImportGroup Label="PropertySheets" />
+  <PropertyGroup Label="UserMacros">
+    <SOURCEBASE>$(SolutionDir)</SOURCEBASE>
+    <OPENVPN_DEPROOT>$(SOURCEBASE)\..\..\image</OPENVPN_DEPROOT>
+    <OPENSSL_HOME>$(OPENVPN_DEPROOT)</OPENSSL_HOME>
+    <TAP_WINDOWS_HOME>$(OPENVPN_DEPROOT)</TAP_WINDOWS_HOME>
+    <LZO_HOME>$(OPENVPN_DEPROOT)</LZO_HOME>
+    <PKCS11H_HOME>$(OPENVPN_DEPROOT)</PKCS11H_HOME>
+  </PropertyGroup>
+  <PropertyGroup />
+  <ItemDefinitionGroup />
+  <ItemGroup>
+    <BuildMacro Include="SOURCEBASE">
+      <Value>$(SOURCEBASE)</Value>
+      <EnvironmentVariable>true</EnvironmentVariable>
+    </BuildMacro>
+    <BuildMacro Include="OPENVPN_DEPROOT">
+      <Value>$(OPENVPN_DEPROOT)</Value>
+      <EnvironmentVariable>true</EnvironmentVariable>
+    </BuildMacro>
+    <BuildMacro Include="OPENSSL_HOME">
+      <Value>$(OPENSSL_HOME)</Value>
+      <EnvironmentVariable>true</EnvironmentVariable>
+    </BuildMacro>
+    <BuildMacro Include="TAP_WINDOWS_HOME">
+      <Value>$(TAP_WINDOWS_HOME)</Value>
+      <EnvironmentVariable>true</EnvironmentVariable>
+    </BuildMacro>
+    <BuildMacro Include="LZO_HOME">
+      <Value>$(LZO_HOME)</Value>
+      <EnvironmentVariable>true</EnvironmentVariable>
+    </BuildMacro>
+    <BuildMacro Include="PKCS11H_HOME">
+      <Value>$(PKCS11H_HOME)</Value>
+      <EnvironmentVariable>true</EnvironmentVariable>
+    </BuildMacro>
+  </ItemGroup>
+</Project>
\ No newline at end of file
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index d2695e6..07d6baf 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -1,47 +1,79 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="12.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|x64">
+      <Configuration>Debug</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|x64">
+      <Configuration>Release</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
   </ItemGroup>
   <PropertyGroup Label="Globals">
     <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
     <RootNamespace>compat</RootNamespace>
     <Keyword>Win32Proj</Keyword>
+    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="PropertySheet.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="PropertySheet.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
@@ -58,6 +90,19 @@
       <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <Optimization>MaxSpeed</Optimization>
@@ -72,6 +117,20 @@
       <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="compat-basename.c" />
     <ClCompile Include="compat-dirname.c" />
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index d1c0fde..e0da69f 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -1,50 +1,84 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="12.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|x64">
+      <Configuration>Debug</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|x64">
+      <Configuration>Release</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
   </ItemGroup>
   <PropertyGroup Label="Globals">
     <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
     <RootNamespace>openvpn</RootNamespace>
     <Keyword>Win32Proj</Keyword>
+    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
     <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">true</LinkIncremental>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">true</LinkIncremental>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
     <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">false</LinkIncremental>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|x64'">false</LinkIncremental>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
@@ -64,13 +98,36 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
       <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <Optimization>MaxSpeed</Optimization>
@@ -89,7 +146,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
@@ -98,6 +155,32 @@
       <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+      <OptimizeReferences>true</OptimizeReferences>
+      <EnableCOMDATFolding>true</EnableCOMDATFolding>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="argv.c" />
     <ClCompile Include="base64.c" />
@@ -112,6 +195,7 @@
     <ClCompile Include="crypto.c" />
     <ClCompile Include="crypto_openssl.c" />
     <ClCompile Include="cryptoapi.c" />
+    <ClCompile Include="env_set.c" />
     <ClCompile Include="dhcp.c" />
     <ClCompile Include="error.c" />
     <ClCompile Include="event.c" />
@@ -156,6 +240,7 @@
     <ClCompile Include="push.c" />
     <ClCompile Include="reliable.c" />
     <ClCompile Include="route.c" />
+    <ClCompile Include="run_command.c" />
     <ClCompile Include="schedule.c" />
     <ClCompile Include="session_id.c" />
     <ClCompile Include="shaper.c" />
@@ -189,6 +274,7 @@
     <ClInclude Include="crypto_openssl.h" />
     <ClInclude Include="cryptoapi.h" />
     <ClInclude Include="dhcp.h" />
+    <ClInclude Include="env_set.h" />
     <ClInclude Include="errlevel.h" />
     <ClInclude Include="error.h" />
     <ClInclude Include="event.h" />
@@ -240,6 +326,7 @@
     <ClInclude Include="pushlist.h" />
     <ClInclude Include="reliable.h" />
     <ClInclude Include="route.h" />
+    <ClInclude Include="run_command.h" />
     <ClInclude Include="schedule.h" />
     <ClInclude Include="session_id.h" />
     <ClInclude Include="shaper.h" />
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index e83f9a3..ced7fdc 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -47,6 +47,7 @@
 #ifdef _MSC_VER /* Visual Studio */
 #define __func__ __FUNCTION__
 #define __attribute__(x)
+#include <inttypes.h>
 #endif
 
 #if defined(__APPLE__)
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 861f5e7..9d459a6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -24,7 +24,6 @@
 
 #include "service.h"
 
-#include <winsock2.h>
 #include <ws2tcpip.h>
 #include <iphlpapi.h>
 #include <userenv.h>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index c6760da..9098920 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -1,55 +1,89 @@
 ﻿<?xml version="1.0" encoding="utf-8"?>
-<Project DefaultTargets="Build" ToolsVersion="12.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label="ProjectConfigurations">
     <ProjectConfiguration Include="Debug|Win32">
       <Configuration>Debug</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|x64">
+      <Configuration>Debug</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
     <ProjectConfiguration Include="Release|Win32">
       <Configuration>Release</Configuration>
       <Platform>Win32</Platform>
     </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|x64">
+      <Configuration>Release</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
   </ItemGroup>
   <PropertyGroup Label="Globals">
     <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
     <RootNamespace>openvpnserv</RootNamespace>
     <Keyword>Win32Proj</Keyword>
+    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\PropertySheet.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
     <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">true</LinkIncremental>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">true</LinkIncremental>
     <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
     <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
     <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">false</LinkIncremental>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|x64'">false</LinkIncremental>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
       <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <MinimalRebuild>true</MinimalRebuild>
       <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
@@ -63,16 +97,38 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
+      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
       <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <Optimization>MaxSpeed</Optimization>
       <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
       <FunctionLevelLinking>true</FunctionLevelLinking>
@@ -85,6 +141,7 @@
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
+      <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
       <OptimizeReferences>true</OptimizeReferences>
@@ -92,12 +149,41 @@
       <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+      <OptimizeReferences>true</OptimizeReferences>
+      <EnableCOMDATFolding>true</EnableCOMDATFolding>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup>
-    <ClCompile Include="openvpnserv.c" />
+    <ClCompile Include="automatic.c" />
+    <ClCompile Include="common.c" />
+    <ClCompile Include="interactive.c" />
     <ClCompile Include="service.c" />
+    <ClCompile Include="validate.c" />
+    <ClCompile Include="..\openvpn\block_dns.c" />
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="service.h" />
+    <ClInclude Include="validate.h" />
+    <ClInclude Include="..\openvpn\block_dns.h" />
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpnserv_resources.rc" />
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index af8f37f..4d03b88 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -30,6 +30,7 @@
 #include "config-msvc.h"
 #endif
 
+#include <winsock2.h>
 #include <windows.h>
 #include <stdlib.h>
 #include <tchar.h>
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 653bd12..91c6a2b 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -61,6 +61,9 @@ CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
     WCHAR tmp[MAX_PATH];
     const WCHAR *config_file = NULL;
     const WCHAR *config_dir = NULL;
+#ifndef UNICODE
+    WCHAR widepath[MAX_PATH];
+#endif
 
     /* convert fname to full path */
     if (PathIsRelativeW(fname) )
-- 
2.7.4


