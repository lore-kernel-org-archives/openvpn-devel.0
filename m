From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:27 +0200
Message-Id: <20171010231130.6832-10-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 10/13] msvc-generate.vcxproj project file
 upgraded to Visual Studio 2017
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Simon Rozman <simon@...2293...>

1. The project file was ported to VS2017.
2. All non-essential settings reset to MSVC defaults.
3. -ls flags added to NMake to reduce output clutter.
---
 build/msvc/msvc-generate/msvc-generate.vcxproj     | 42 +++++++++---------=
----
 .../msvc-generate/msvc-generate.vcxproj.filters    |  7 ++++
 2 files changed, 24 insertions(+), 25 deletions(-)
 create mode 100644 build/msvc/msvc-generate/msvc-generate.vcxproj.filters

diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/ms=
vc-generate/msvc-generate.vcxproj
index 8b7ec22..f5fc921 100644
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -1,5 +1,5 @@
 =EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"4.0" xmlns=3D"http://sch=
emas.microsoft.com/developer/msbuild/2003">
+<Project DefaultTargets=3D"Build" ToolsVersion=3D"15.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
   <ItemGroup Label=3D"ProjectConfigurations">
     <ProjectConfiguration Include=3D"Debug|Win32">
       <Configuration>Debug</Configuration>
@@ -11,6 +11,7 @@
     </ProjectConfiguration>
   </ItemGroup>
   <PropertyGroup Label=3D"Globals">
+    <VCProjectVersion>15.0</VCProjectVersion>
     <ProjectGuid>{8598C2C8-34C4-47A1-99B0-7C295A890615}</ProjectGuid>
     <RootNamespace>msvc-generate</RootNamespace>
     <Keyword>MakeFileProj</Keyword>
@@ -18,13 +19,19 @@
   <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
+    <OutDir>$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\</IntDir>
   </PropertyGroup>
   <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
+    <OutDir>$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\</IntDir>
   </PropertyGroup>
   <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label=3D"ExtensionSettings">
   </ImportGroup>
+  <ImportGroup Label=3D"Shared">
+  </ImportGroup>
   <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|W=
in32'" Label=3D"PropertySheets">
     <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
   </ImportGroup>
@@ -32,30 +39,15 @@
     <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
   </ImportGroup>
   <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'=
">$(Configuration)\</OutDir>
-    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'=
">$(Configuration)\</IntDir>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLi=
ne>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'">config-msvc-version.h</NMakeOutput>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Debug|Win32'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMake=
PreprocessorDefinitions>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Debug|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Debug|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemb=
lies>
-    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(Configuration)\</OutDir>
-    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(Configuration)\</IntDir>
-    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
-    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommand=
Line>
-    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
-    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'">config-msvc-version.h</NMakeOutput>
-    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Release|Win32'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMa=
kePreprocessorDefinitions>
-    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
-    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Release|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
-    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
-    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platform)=
'=3D=3D'Release|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAsse=
mblies>
+  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'">
+    <NMakeBuildCommandLine>nmake -ls -f Makefile.mak all</NMakeBuildComman=
dLine>
+    <NMakeCleanCommandLine>nmake -ls -f Makefile.mak clean</NMakeCleanComm=
andLine>
+    <NMakeReBuildCommandLine>nmake -lsa -f Makefile.mak all</NMakeReBuildC=
ommandLine>
+  </PropertyGroup>
+  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'">
+    <NMakeBuildCommandLine>nmake -ls -f Makefile.mak all</NMakeBuildComman=
dLine>
+    <NMakeCleanCommandLine>nmake -ls -f Makefile.mak clean</NMakeCleanComm=
andLine>
+    <NMakeReBuildCommandLine>nmake -lsa -f Makefile.mak all</NMakeReBuildC=
ommandLine>
   </PropertyGroup>
   <ItemDefinitionGroup>
   </ItemDefinitionGroup>
diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj.filters b/build=
/msvc/msvc-generate/msvc-generate.vcxproj.filters
new file mode 100644
index 0000000..1d04662
--- /dev/null
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj.filters
@@ -0,0 +1,7 @@
+=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
+<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/develo=
per/msbuild/2003">
+  <ItemGroup>
+    <None Include=3D"Makefile.mak" />
+    <None Include=3D"msc-generate.js" />
+  </ItemGroup>
+</Project>
\ No newline at end of file
--=20
2.9.0.windows.1


