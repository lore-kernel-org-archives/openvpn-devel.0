From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:30 +0200
Message-Id: <20171010231130.6832-13-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 13/13] x64 MSVC configurations introduced
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

From: Simon Rozman <simon@...2293...>

---
 .gitignore                                     |  1 +
 build/msvc/msvc-generate/msvc-generate.vcxproj | 42 ++++++++++++--
 msvc-env.bat                                   |  1 -
 openvpn.sln                                    | 16 ++++++
 src/compat/compat.vcxproj                      | 61 +++++++++++++++++++-
 src/openvpnserv/openvpnserv.vcxproj            | 77 ++++++++++++++++++++++++--
 6 files changed, 186 insertions(+), 12 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4543674..ced65ec 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,6 +17,7 @@
 Release
 Debug
 Win32-Output
+x64-Output
 .vs
 .deps
 .libs
diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
index f5fc921..8978197 100644
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -5,10 +5,18 @@
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
     <VCProjectVersion>15.0</VCProjectVersion>
@@ -19,13 +27,23 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <OutDir>$(Configuration)\</OutDir>
-    <IntDir>$(Configuration)\</IntDir>
+    <OutDir>$(Configuration)\$(Platform)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+    <OutDir>$(Configuration)\$(Platform)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <OutDir>$(Configuration)\</OutDir>
-    <IntDir>$(Configuration)\</IntDir>
+    <OutDir>$(Configuration)\$(Platform)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+    <OutDir>$(Configuration)\$(Platform)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -35,20 +53,36 @@
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <NMakeBuildCommandLine>nmake -ls -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeCleanCommandLine>nmake -ls -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeReBuildCommandLine>nmake -lsa -f Makefile.mak all</NMakeReBuildCommandLine>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <NMakeBuildCommandLine>nmake -ls -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeCleanCommandLine>nmake -ls -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeReBuildCommandLine>nmake -lsa -f Makefile.mak all</NMakeReBuildCommandLine>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <NMakeBuildCommandLine>nmake -ls -f Makefile.mak all</NMakeBuildCommandLine>
     <NMakeCleanCommandLine>nmake -ls -f Makefile.mak clean</NMakeCleanCommandLine>
     <NMakeReBuildCommandLine>nmake -lsa -f Makefile.mak all</NMakeReBuildCommandLine>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <NMakeBuildCommandLine>nmake -ls -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeCleanCommandLine>nmake -ls -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeReBuildCommandLine>nmake -lsa -f Makefile.mak all</NMakeReBuildCommandLine>
+  </PropertyGroup>
   <ItemDefinitionGroup>
   </ItemDefinitionGroup>
   <ItemGroup>
diff --git a/msvc-env.bat b/msvc-env.bat
index aabed75..56b469f 100644
--- a/msvc-env.bat
+++ b/msvc-env.bat
@@ -13,7 +13,6 @@ set SOURCEBASE=%cd%
 set SOLUTION=openvpn.sln
 set CPPFLAGS=%CPPFLAGS%;_CRT_SECURE_NO_WARNINGS;WIN32_LEAN_AND_MEAN;_CRT_NONSTDC_NO_WARNINGS;_CRT_SECURE_NO_WARNINGS
 set CPPFLAGS=%CPPFLAGS%;NTDDI_VERSION=NTDDI_VISTA;_WIN32_WINNT=_WIN32_WINNT_VISTA
-set CPPFLAGS=%CPPFLAGS%;_USE_32BIT_TIME_T
 set CPPFLAGS=%CPPFLAGS%;%EXTRA_CPPFLAGS%
 
 if exist config-msvc-local.h set CPPFLAGS="%CPPFLAGS%;HAVE_CONFIG_MSVC_LOCAL_H"
diff --git a/openvpn.sln b/openvpn.sln
index ac865bb..cf5a089 100644
--- a/openvpn.sln
+++ b/openvpn.sln
@@ -14,23 +14,39 @@ EndProject
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
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|x64.ActiveCfg = Debug|Win32
 		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg = Release|Win32
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|x64.ActiveCfg = Release|Win32
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
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 997aaf7..0ebd3d5 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -5,10 +5,18 @@
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
     <VCProjectVersion>15.0</VCProjectVersion>
@@ -23,11 +31,22 @@
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
@@ -36,17 +55,31 @@
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir>$(Configuration)\</IntDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir>$(Configuration)\</IntDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
@@ -59,6 +92,17 @@
       <WarningLevel>Level3</WarningLevel>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(OPENSSL_HOME)\include;$(LZO_HOME)\include;$(PKCS11H_HOME)\include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <Optimization>MaxSpeed</Optimization>
@@ -70,6 +114,17 @@
       <WarningLevel>Level3</WarningLevel>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(OPENSSL_HOME)\include;$(LZO_HOME)\include;$(PKCS11H_HOME)\include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="compat-basename.c" />
     <ClCompile Include="compat-dirname.c" />
@@ -85,4 +140,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index a865bf0..3cbc287 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -5,10 +5,18 @@
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
     <VCProjectVersion>15.0</VCProjectVersion>
@@ -23,11 +31,22 @@
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v141</PlatformToolset>
   </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>Unicode</CharacterSet>
+    <PlatformToolset>v141</PlatformToolset>
+  </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
   </ImportGroup>
@@ -36,17 +55,31 @@
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
   </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir>$(Configuration)\</IntDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir>$(Configuration)\</IntDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir>$(Configuration)\$(Platform)\</IntDir>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
@@ -63,7 +96,24 @@
     </ResourceCompile>
     <Link>
       <SubSystem>Console</SubSystem>
-      <TargetMachine>MachineX86</TargetMachine>
+      <AdditionalDependencies>fwpuclnt.lib;ntdll.lib;shlwapi.lib;netapi32.lib;userenv.lib;iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(SOURCEBASE)\src\openvpn;$(SOURCEBASE)\src\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <SubSystem>Console</SubSystem>
       <AdditionalDependencies>fwpuclnt.lib;ntdll.lib;shlwapi.lib;netapi32.lib;userenv.lib;iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
     </Link>
   </ItemDefinitionGroup>
@@ -84,7 +134,26 @@
       <SubSystem>Console</SubSystem>
       <OptimizeReferences>true</OptimizeReferences>
       <EnableCOMDATFolding>true</EnableCOMDATFolding>
-      <TargetMachine>MachineX86</TargetMachine>
+      <AdditionalDependencies>fwpuclnt.lib;ntdll.lib;shlwapi.lib;netapi32.lib;userenv.lib;iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)\include;$(SOURCEBASE)\src\openvpn;$(SOURCEBASE)\src\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <SubSystem>Console</SubSystem>
+      <OptimizeReferences>true</OptimizeReferences>
+      <EnableCOMDATFolding>true</EnableCOMDATFolding>
       <AdditionalDependencies>fwpuclnt.lib;ntdll.lib;shlwapi.lib;netapi32.lib;userenv.lib;iphlpapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
     </Link>
   </ItemDefinitionGroup>
-- 
2.9.0.windows.1


