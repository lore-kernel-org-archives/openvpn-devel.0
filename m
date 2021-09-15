From: Ilya Shipitsin <chipitsine@...277...>
Date: Wed, 15 Sep 2021 17:25:34 +0500
Message-Id: <20210915122534.355-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] BUILD: enable CFG and Spectre mitigation
 for MSVC
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

found by BinSkim

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 src/compat/Debug.props                |  1 +
 src/compat/Release.props              |  1 +
 src/compat/compat.vcxproj             |  6 ++++++
 src/openvpn/openvpn.vcxproj           | 12 ++++++++++++
 src/openvpnmsica/openvpnmsica.props   |  1 +
 src/openvpnmsica/openvpnmsica.vcxproj |  6 ++++++
 src/openvpnserv/openvpnserv.vcxproj   |  6 ++++++
 src/tapctl/tapctl.vcxproj             |  6 ++++++
 8 files changed, 39 insertions(+)

diff --git a/src/compat/Debug.props b/src/compat/Debug.props
index 31bb9d91..810609bf 100644
--- a/src/compat/Debug.props
+++ b/src/compat/Debug.props
@@ -15,6 +15,7 @@
       <PreprocessorDefinitions>_DEBUG;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
       <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemGroup />
diff --git a/src/compat/Release.props b/src/compat/Release.props
index 63828b79..50eaa8de 100644
--- a/src/compat/Release.props
+++ b/src/compat/Release.props
@@ -15,6 +15,7 @@
       <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
       <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
       <PreprocessorDefinitions>NDEBUG;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <Link>
       <EnableCOMDATFolding>true</EnableCOMDATFolding>
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 49824783..fe03a51a 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -38,33 +38,39 @@
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>StaticLibrary</ConfigurationType>
     <CharacterSet>MultiByte</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 5b3e0c6c..8d27f9c6 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -38,33 +38,39 @@
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -146,6 +152,7 @@
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -161,6 +168,7 @@
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir)include;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -176,6 +184,7 @@
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -191,6 +200,7 @@
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -206,6 +216,7 @@
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -221,6 +232,7 @@
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
     <Link>
diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpnmsica.props
index 074635d0..9e934a73 100644
--- a/src/openvpnmsica/openvpnmsica.props
+++ b/src/openvpnmsica/openvpnmsica.props
@@ -9,6 +9,7 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_WIN32_WINNT=_WIN32_WINNT_VISTA;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <Link>
       <SubSystem>Windows</SubSystem>
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
index c39b1240..11aa78bb 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -40,18 +40,21 @@
     <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
     <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
     <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
@@ -60,6 +63,7 @@
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
@@ -67,6 +71,7 @@
     <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>DynamicLibrary</ConfigurationType>
@@ -74,6 +79,7 @@
     <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 8009ab3d..5fd7d60b 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -38,33 +38,39 @@
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
index ad96f02c..79da9d33 100644
--- a/src/tapctl/tapctl.vcxproj
+++ b/src/tapctl/tapctl.vcxproj
@@ -40,18 +40,21 @@
     <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
     <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <UseDebugLibraries>true</UseDebugLibraries>
     <PlatformToolset>v142</PlatformToolset>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
@@ -60,6 +63,7 @@
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
     <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
@@ -67,6 +71,7 @@
     <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
@@ -74,6 +79,7 @@
     <PlatformToolset>v142</PlatformToolset>
     <WholeProgramOptimization>true</WholeProgramOptimization>
     <CharacterSet>Unicode</CharacterSet>
+    <SpectreMitigation>Spectre</SpectreMitigation>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
-- 
2.29.2.windows.2


