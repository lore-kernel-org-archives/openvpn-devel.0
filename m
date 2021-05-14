From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 14 May 2021 07:57:04 +0300
Message-Id: <20210514045704.686-1-lstipakov@...277...>
In-Reply-To: <20210513164322.369-1-lstipakov@...277...>
References: <20210513164322.369-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] msvc: standalone building
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

This finally enables standalone MSVC building, without
dependency on openvpn-build/msvc. This makes MSVC build
process much simpler.

Dependencies are managed by vcpkg. To install dependencies, run:

  > vcpkg --overlay-ports=<openvpn>\contrib\vcpkg-ports
          --overlay-triplets=<openvpn>\contrib\vcpkg-triplets install
          lz4:x64-windows-ovpn lzo:x64-windows-ovpn openssl-windows:x64-windows-ovpn pkcs11-helper:x64-windows-ovpn tap-windows6:x64-windows-ovpn

To build for other arch, use x86-windows-ovpn or arm64-windows-ovpn.
Custom triplets are defines so that lz4 is linked statically and
other libraries dynamically.

Since we don't have CMake support yet, we cannot use vcpkg manifest
mode, since it doesn't work with overlay ports (https://github.com/microsoft/vcpkg/issues/12289),
therefore this one-time manual dependency installation is required.

While on it, bump msvc-generate project target version to VS2019 and
cleanup leftovers from compat.vcxproj.filters.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v2: add custom triplets to support lz4 static linkage

 .../msvc/msvc-generate/msvc-generate.vcxproj  | 14 +++---
 .../vcpkg-triplets/arm64-windows-ovpn.cmake   |  8 ++++
 contrib/vcpkg-triplets/x64-windows-ovpn.cmake |  7 +++
 contrib/vcpkg-triplets/x86-windows-ovpn.cmake |  7 +++
 src/compat/compat.vcxproj                     | 30 +++++++++---
 src/compat/compat.vcxproj.filters             |  6 ---
 src/openvpn/openvpn.vcxproj                   | 48 ++++++++++++++-----
 src/openvpnmsica/openvpnmsica.vcxproj         | 18 +++++++
 src/openvpnserv/openvpnserv.vcxproj           | 18 +++++++
 src/tapctl/tapctl.vcxproj                     | 18 +++++++
 10 files changed, 143 insertions(+), 31 deletions(-)
 create mode 100644 contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
 create mode 100644 contrib/vcpkg-triplets/x64-windows-ovpn.cmake
 create mode 100644 contrib/vcpkg-triplets/x86-windows-ovpn.cmake

diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
index dd947f98..dda8b051 100644
--- a/build/msvc/msvc-generate/msvc-generate.vcxproj
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -30,32 +30,32 @@
     <ProjectGuid>{8598C2C8-34C4-47A1-99B0-7C295A890615}</ProjectGuid>
     <RootNamespace>msvc-generate</RootNamespace>
     <Keyword>MakeFileProj</Keyword>
-    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
     <ConfigurationType>Makefile</ConfigurationType>
-    <PlatformToolset>v141</PlatformToolset>
+    <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
diff --git a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
new file mode 100644
index 00000000..a3aa87f7
--- /dev/null
+++ b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
@@ -0,0 +1,8 @@
+set(VCPKG_TARGET_ARCHITECTURE arm64)
+set(VCPKG_CRT_LINKAGE dynamic)
+set(VCPKG_LIBRARY_LINKAGE dynamic)
+
+if(PORT STREQUAL "lz4")
+    set(VCPKG_LIBRARY_LINKAGE static)
+endif()
+
diff --git a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
new file mode 100644
index 00000000..7036ed2d
--- /dev/null
+++ b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
@@ -0,0 +1,7 @@
+set(VCPKG_TARGET_ARCHITECTURE x64)
+set(VCPKG_CRT_LINKAGE dynamic)
+set(VCPKG_LIBRARY_LINKAGE dynamic)
+
+if(PORT STREQUAL "lz4")
+    set(VCPKG_LIBRARY_LINKAGE static)
+endif()
diff --git a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
new file mode 100644
index 00000000..7d3bf340
--- /dev/null
+++ b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
@@ -0,0 +1,7 @@
+set(VCPKG_TARGET_ARCHITECTURE x86)
+set(VCPKG_CRT_LINKAGE dynamic)
+set(VCPKG_LIBRARY_LINKAGE dynamic)
+
+if(PORT STREQUAL "lz4")
+    set(VCPKG_LIBRARY_LINKAGE static)
+endif()
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 1a11deb4..49824783 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -97,39 +97,57 @@
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
   </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
   </ItemDefinitionGroup>
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.filters
index 404863ca..96ca026a 100644
--- a/src/compat/compat.vcxproj.filters
+++ b/src/compat/compat.vcxproj.filters
@@ -24,12 +24,6 @@
     <ClCompile Include="compat-gettimeofday.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="compat-inet_ntop.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="compat-inet_pton.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
     <ClCompile Include="compat-daemon.c">
       <Filter>Source Files</Filter>
     </ClCompile>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 370345a1..3cf47f07 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -115,92 +115,116 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <GenerateManifest>false</GenerateManifest>
   </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+    <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+    <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+    <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+    <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+    <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+    <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
+  </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
+      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
+      <AdditionalIncludeDirectories>..\compat;$(SolutionDir)include;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
+      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
+      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
+      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
     <ClCompile>
-      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
+      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
index 4b429806..c39b1240 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -111,6 +111,24 @@
     <Import Project="openvpnmsica-Release.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
   <ItemGroup>
     <ClCompile Include="..\tapctl\error.c" />
     <ClCompile Include="..\tapctl\tap.c" />
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index ee7d52ea..8009ab3d 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -97,6 +97,24 @@
   <PropertyGroup>
     <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
   </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
index 1d593fc1..ad96f02c 100644
--- a/src/tapctl/tapctl.vcxproj
+++ b/src/tapctl/tapctl.vcxproj
@@ -111,6 +111,24 @@
     <Import Project="tapctl.props" />
   </ImportGroup>
   <PropertyGroup Label="UserMacros" />
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <VcpkgEnabled>true</VcpkgEnabled>
+  </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" />
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" />
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" />
-- 
2.23.0.windows.1


