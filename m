From: Simon Rozman <simon@...2293...>
Date: Mon,  8 Oct 2018 11:46:00 +0200
Message-Id: <20181008094600.10164-2-simon@...2293...>
In-Reply-To: <20181008094600.10164-1-simon@...2293...>
References: <20181008094600.10164-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] msvc: Move common project settings to
 reusable property sheets
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

The Visual Studio 2017 project files were refactored by migrating all
repeating common settings into three property sheets: Debug.props,
Release.props and the existing PropertySheet.props.
This simplifies configuration management while providing uniformity
across projects, configurations and platforms.
---
 src/compat/Debug.props                      | 22 +++++
 src/compat/PropertySheet.props              | 19 +++-
 src/compat/Release.props                    | 25 ++++++
 src/compat/compat.vcxproj                   | 61 +++----------
 src/openvpn/openvpn.vcxproj                 | 99 +++++----------------
 src/openvpn/openvpn.vcxproj.filters         | 12 +++
 src/openvpnserv/openvpnserv.vcxproj         | 90 ++++---------------
 src/openvpnserv/openvpnserv.vcxproj.filters | 22 ++++-
 8 files changed, 144 insertions(+), 206 deletions(-)
 create mode 100644 src/compat/Debug.props
 create mode 100644 src/compat/Release.props

diff --git a/src/compat/Debug.props b/src/compat/Debug.props
new file mode 100644
index 00000000..e5e9f681
--- /dev/null
+++ b/src/compat/Debug.props
@@ -0,0 +1,22 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ImportGroup Label="PropertySheets">
+    <Import Project="PropertySheet.props" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <_PropertySheetDisplayName>compat-Debug</_PropertySheetDisplayName>
+    <LinkIncremental>true</LinkIncremental>
+  </PropertyGroup>
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
+      <Optimization>Disabled</Optimization>
+      <PreprocessorDefinitions>_DEBUG;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+      <MinimalRebuild>true</MinimalRebuild>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemGroup />
+</Project>
\ No newline at end of file
diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.props
index 1e5c2f96..4cad994b 100644
--- a/src/compat/PropertySheet.props
+++ b/src/compat/PropertySheet.props
@@ -9,8 +9,23 @@
     <LZO_HOME>$(OPENVPN_DEPROOT)</LZO_HOME>
     <PKCS11H_HOME>$(OPENVPN_DEPROOT)</PKCS11H_HOME>
   </PropertyGroup>
-  <PropertyGroup />
-  <ItemDefinitionGroup />
+  <PropertyGroup>
+    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <_PropertySheetDisplayName>compat</_PropertySheetDisplayName>
+  </PropertyGroup>
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <WarningLevel>Level3</WarningLevel>
+      <PreprocessorDefinitions>WIN32;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ClCompile>
+    <Link>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+    </Link>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <BuildMacro Include="SOURCEBASE">
       <Value>$(SOURCEBASE)</Value>
diff --git a/src/compat/Release.props b/src/compat/Release.props
new file mode 100644
index 00000000..63828b79
--- /dev/null
+++ b/src/compat/Release.props
@@ -0,0 +1,25 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ImportGroup Label="PropertySheets">
+    <Import Project="PropertySheet.props" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <_PropertySheetDisplayName>compat-Release</_PropertySheetDisplayName>
+    <LinkIncremental>false</LinkIncremental>
+  </PropertyGroup>
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <PreprocessorDefinitions>NDEBUG;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+    <Link>
+      <EnableCOMDATFolding>true</EnableCOMDATFolding>
+      <OptimizeReferences>true</OptimizeReferences>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemGroup />
+</Project>
\ No newline at end of file
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index d6473581..111dacdd 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -52,83 +52,46 @@
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="PropertySheet.props" />
+    <Import Project="Release.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="PropertySheet.props" />
+    <Import Project="Release.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="PropertySheet.props" />
+    <Import Project="Debug.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="PropertySheet.props" />
+    <Import Project="Debug.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <MinimalRebuild>true</MinimalRebuild>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
-      <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemGroup>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 8fb7bee8..92d7e32e 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -52,133 +52,74 @@
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Release.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Release.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Debug.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Debug.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">true</LinkIncremental>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">true</LinkIncremental>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">false</LinkIncremental>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|x64'">false</LinkIncremental>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <MinimalRebuild>true</MinimalRebuild>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
-      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
+      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
-      <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
-      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
+      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
-      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
+      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
-      <OptimizeReferences>true</OptimizeReferences>
-      <EnableCOMDATFolding>true</EnableCOMDATFolding>
-      <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
-      <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
-      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
+      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
-      <OptimizeReferences>true</OptimizeReferences>
-      <EnableCOMDATFolding>true</EnableCOMDATFolding>
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 4152236d..7a9aa631 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -228,6 +228,12 @@
     <ClCompile Include="tls_crypt.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="env_set.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="run_command.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -476,6 +482,12 @@
     <ClInclude Include="tls_crypt.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="env_set.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="run_command.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 4edcf851..74077570 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -52,124 +52,66 @@
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Release.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Release.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Debug.props" />
   </ImportGroup>
   <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="PropertySheets">
     <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
-    <Import Project="..\compat\PropertySheet.props" />
+    <Import Project="..\compat\Debug.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">true</LinkIncremental>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">true</LinkIncremental>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|x64'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
-    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">false</LinkIncremental>
-    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|x64'">false</LinkIncremental>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <MinimalRebuild>true</MinimalRebuild>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
-      <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <Optimization>Disabled</Optimization>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
-      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
-      <OptimizeReferences>true</OptimizeReferences>
-      <EnableCOMDATFolding>true</EnableCOMDATFolding>
-      <TargetMachine>MachineX86</TargetMachine>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
-      <Optimization>MaxSpeed</Optimization>
-      <IntrinsicFunctions>true</IntrinsicFunctions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
-      <FunctionLevelLinking>true</FunctionLevelLinking>
-      <PrecompiledHeader>
-      </PrecompiledHeader>
-      <WarningLevel>Level3</WarningLevel>
-      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
-    <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-    </ResourceCompile>
+    <ResourceCompile />
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
-      <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
-      <OptimizeReferences>true</OptimizeReferences>
-      <EnableCOMDATFolding>true</EnableCOMDATFolding>
     </Link>
   </ItemDefinitionGroup>
   <ItemGroup>
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/openvpnserv.vcxproj.filters
index 0c89b4f4..3ce9bb24 100644
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -15,10 +15,22 @@
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
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="validate.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="..\openvpn\block_dns.c">
       <Filter>Source Files</Filter>
     </ClCompile>
   </ItemGroup>
@@ -26,6 +38,12 @@
     <ClInclude Include="service.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="validate.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="..\openvpn\block_dns.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpnserv_resources.rc">
-- 
2.19.0.windows.1


