From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  7 Jan 2022 16:53:59 +0200
Message-Id: <20220107145359.311-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 2.5] msvc: adjust build options to harden
 binaries
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

 - enable hardware-enforced stack protection on
compatible hardware/software (/CETCOMPAT linker option)

 - hash object files with SHA256 (/ZH:SHA_256 compiler option)

 - enable SDL. The required to add

    _CRT_NONSTDC_NO_DEPRECATE
    _CRT_SECURE_NO_WARNINGS
    _WINSOCK_DEPRECATED_NO_WARNINGS

preprocessor definitions. I don't feel like replacing strdup (which is
correct POSIX function) and inet_ntoa (we always pass IPv4 address to
it, inet_ntop will make code more complex)

Above issues were discovered by bitskim.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 Note that one needs to cherry-pick commit

     "e5e9a07" (tapctl: Resolve MSVC C4996 warnings)

 before applying this patch.

 src/openvpn/openvpn.vcxproj           | 35 +++++++++++------
 src/openvpnmsica/openvpnmsica.vcxproj | 43 +++++++++++++++++++++
 src/openvpnserv/openvpnserv.vcxproj   | 26 ++++++++++---
 src/tapctl/tapctl.vcxproj             | 54 ++++++++++++++++++++++++---
 4 files changed, 134 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 33b8f19a..a540ec22 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -147,11 +147,12 @@
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -162,11 +163,12 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir)include;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -177,11 +179,12 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -192,44 +195,52 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <ControlFlowGuard>Guard</ControlFlowGuard>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
     </ClCompile>
     <ResourceCompile />
     <Link>
       <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <ControlFlowGuard>Guard</ControlFlowGuard>
+      <SDLCheck>true</SDLCheck>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
       <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <ControlFlowGuard>Guard</ControlFlowGuard>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
     </ClCompile>
     <ResourceCompile />
     <Link>
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
index 11aa78bb..5e774430 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -135,6 +135,49 @@
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <VcpkgEnabled>true</VcpkgEnabled>
   </PropertyGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="..\tapctl\error.c" />
     <ClCompile Include="..\tapctl\tap.c" />
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 520242f4..c70db229 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -124,7 +124,9 @@
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -135,7 +137,9 @@
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -146,7 +150,9 @@
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -157,29 +163,37 @@
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
       <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
index 79da9d33..f439dc4f 100644
--- a/src/tapctl/tapctl.vcxproj
+++ b/src/tapctl/tapctl.vcxproj
@@ -135,12 +135,54 @@
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <VcpkgEnabled>true</VcpkgEnabled>
   </PropertyGroup>
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" />
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" />
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" />
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" />
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" />
-  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" />
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinitions>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="error.c" />
     <ClCompile Include="tap.c" />
-- 
2.23.0.windows.1


