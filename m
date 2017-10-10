From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:24 +0200
Message-Id: <20171010231130.6832-7-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 07/13] compat.vcxproj project file upgraded
 to Visual Studio 2017
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
---
 src/compat/compat.vcxproj         | 36 +++++++++++++++++-------------------
 src/compat/compat.vcxproj.filters |  4 ++--
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index d2695e6..997aaf7 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -1,5 +1,5 @@
 =EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
-<Project DefaultTargets=3D"Build" ToolsVersion=3D"12.0" xmlns=3D"http://sc=
hemas.microsoft.com/developer/msbuild/2003">
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
     <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
     <RootNamespace>compat</RootNamespace>
     <Keyword>Win32Proj</Keyword>
@@ -18,18 +19,20 @@
   <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
+    <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
-    <PlatformToolset>v120</PlatformToolset>
+    <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v141</PlatformToolset>
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
@@ -37,39 +40,34 @@
     <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props=
" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)" Label=3D"LocalAppDataPlatform" />
   </ImportGroup>
   <PropertyGroup Label=3D"UserMacros" />
-  <PropertyGroup>
-    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'=
">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'=
">$(Configuration)\</IntDir>
-    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(Configuration)\</IntDir>
+  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'">
+    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\</IntDir>
+  </PropertyGroup>
+  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'">
+    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\</IntDir>
   </PropertyGroup>
   <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">
     <ClCompile>
       <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(=
OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Additio=
nalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(=
OPENSSL_HOME)\include;$(LZO_HOME)\include;$(PKCS11H_HOME)\include;%(Additio=
nalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(Preprocesso=
rDefinitions)</PreprocessorDefinitions>
-      <MinimalRebuild>true</MinimalRebuild>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
       <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
       <PrecompiledHeader>
       </PrecompiledHeader>
       <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">
     <ClCompile>
       <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(=
OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Additio=
nalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(=
OPENSSL_HOME)\include;$(LZO_HOME)\include;$(PKCS11H_HOME)\include;%(Additio=
nalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(Preprocesso=
rDefinitions)</PreprocessorDefinitions>
       <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
       <PrecompiledHeader>
       </PrecompiledHeader>
       <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemGroup>
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.=
filters
index 0f78e86..acff7e7 100644
--- a/src/compat/compat.vcxproj.filters
+++ b/src/compat/compat.vcxproj.filters
@@ -7,11 +7,11 @@
     </Filter>
     <Filter Include=3D"Header Files">
       <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIden=
tifier>
-      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
+      <Extensions>h;hh;hpp;hxx;hm;inl;inc;xsd</Extensions>
     </Filter>
     <Filter Include=3D"Resource Files">
       <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIden=
tifier>
-      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx=
;tiff;tif;png;wav</Extensions>
+      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx=
;tiff;tif;png;wav;mfcribbon-ms</Extensions>
     </Filter>
   </ItemGroup>
   <ItemGroup>
--=20
2.9.0.windows.1


