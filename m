From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:23 +0200
Message-Id: <20171010231130.6832-6-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 06/13] openvpnserv.vcxproj project file
 recreated using Visual Studio 2017
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

1. The project file was created from scratch.
2. XML nodes were reordered to match old project order for easier diff-ing.
3. All non-essential settings reset to MSVC defaults.
4. .h/.c file list updated.
5. Missing /I include paths added.
6. List of required .lib files updated.

The openvpnserv.exe compiles now. Warnings will be addressed in future patc=
hes.
---
 openvpn.sln                                 |  6 ++--
 src/openvpnserv/openvpnserv.vcxproj         | 52 +++++++++++++++----------=
----
 src/openvpnserv/openvpnserv.vcxproj.filters | 34 ++++++++++++++-----
 3 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/openvpn.sln b/openvpn.sln
index 90c01b8..9f50f11 100644
--- a/openvpn.sln
+++ b/openvpn.sln
@@ -1,6 +1,8 @@
 =EF=BB=BF
-Microsoft Visual Studio Solution File, Format Version 11.00
-# Visual C++ Express 2010
+Microsoft Visual Studio Solution File, Format Version 12.00
+# Visual Studio 15
+VisualStudioVersion =3D 15.0.26430.16
+MinimumVisualStudioVersion =3D 10.0.40219.1
 Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpnserv", "src\=
openvpnserv\openvpnserv.vcxproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
 EndProject
 Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpn", "src\open=
vpn\openvpn.vcxproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj
index c6760da..a865bf0 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
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
     <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
     <RootNamespace>openvpnserv</RootNamespace>
     <Keyword>Win32Proj</Keyword>
@@ -18,18 +19,20 @@
   <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
+    <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <PlatformToolset>v120</PlatformToolset>
+    <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"Configuration">
     <ConfigurationType>Application</ConfigurationType>
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
@@ -37,67 +40,66 @@
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
-    <LinkIncremental Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Deb=
ug|Win32'">true</LinkIncremental>
-    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win3=
2'">$(Configuration)\</IntDir>
-    <LinkIncremental Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Rel=
ease|Win32'">false</LinkIncremental>
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
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirec=
tories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(=
SOURCEBASE)\src\openvpn;$(SOURCEBASE)\src\compat;%(AdditionalIncludeDirecto=
ries)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(Preproc=
essorDefinitions)</PreprocessorDefinitions>
-      <MinimalRebuild>true</MinimalRebuild>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
       <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
       <PrecompiledHeader>
       </PrecompiledHeader>
       <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
     </ClCompile>
     <ResourceCompile>
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirec=
tories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
       <TargetMachine>MachineX86</TargetMachine>
+      <AdditionalDependencies>fwpuclnt.lib;ntdll.lib;shlwapi.lib;netapi32.=
lib;userenv.lib;iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependenc=
ies>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">
     <ClCompile>
       <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirec=
tories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(=
SOURCEBASE)\src\openvpn;$(SOURCEBASE)\src\compat;%(AdditionalIncludeDirecto=
ries)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(Preproc=
essorDefinitions)</PreprocessorDefinitions>
       <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
       <PrecompiledHeader>
       </PrecompiledHeader>
       <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
     </ClCompile>
     <ResourceCompile>
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirec=
tories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
       <OptimizeReferences>true</OptimizeReferences>
       <EnableCOMDATFolding>true</EnableCOMDATFolding>
       <TargetMachine>MachineX86</TargetMachine>
+      <AdditionalDependencies>fwpuclnt.lib;ntdll.lib;shlwapi.lib;netapi32.=
lib;userenv.lib;iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependenc=
ies>
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
-    <ClCompile Include=3D"openvpnserv.c" />
+    <ClCompile Include=3D"..\openvpn\block_dns.c" />
+    <ClCompile Include=3D"automatic.c" />
+    <ClCompile Include=3D"common.c" />
+    <ClCompile Include=3D"interactive.c" />
     <ClCompile Include=3D"service.c" />
+    <ClCompile Include=3D"validate.c" />
   </ItemGroup>
   <ItemGroup>
+    <ClInclude Include=3D"..\openvpn\block_dns.h" />
     <ClInclude Include=3D"service.h" />
+    <ClInclude Include=3D"validate.h" />
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include=3D"openvpnserv_resources.rc" />
@@ -111,4 +113,4 @@
   <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label=3D"ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/=
openvpnserv.vcxproj.filters
index 0c89b4f..c3267d1 100644
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -7,29 +7,47 @@
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
-    <ClCompile Include=3D"openvpnserv.c">
+    <ClCompile Include=3D"automatic.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include=3D"common.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include=3D"interactive.c">
       <Filter>Source Files</Filter>
     </ClCompile>
     <ClCompile Include=3D"service.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include=3D"service.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
+    <ClCompile Include=3D"validate.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include=3D"..\openvpn\block_dns.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include=3D"openvpnserv_resources.rc">
       <Filter>Resource Files</Filter>
     </ResourceCompile>
   </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include=3D"service.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include=3D"validate.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include=3D"..\openvpn\block_dns.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+  </ItemGroup>
 </Project>
\ No newline at end of file
--=20
2.9.0.windows.1


