From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Feb 2022 10:58:14 +0200
Message-Id: <20220217085814.274-1-lstipakov@...277...>
In-Reply-To: <20220107145522.435-1-lstipakov@...277...>
References: <20220107145522.435-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] msvc: adjust build options to harden
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
 v2:
   - rebase on top of latest master
   - mute ossl3 deprecation warnings treated as errors by msvc
   - add SDL checks to all configurations

 src/openvpn/crypto_openssl.c          |  5 +++
 src/openvpn/openvpn.vcxproj           | 44 +++++++++++++++---------
 src/openvpn/openvpn.vcxproj.filters   |  9 +++++
 src/openvpnmsica/openvpnmsica.vcxproj | 42 +++++++++++++++++++++++
 src/openvpnserv/openvpnserv.vcxproj   | 14 ++++++++
 src/tapctl/tapctl.vcxproj             | 48 +++++++++++++++++++++++----
 6 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 8bc41792..e84b33f1 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -62,6 +62,11 @@
 #error Windows build with OPENSSL_NO_EC: disabling EC key is not supported.
 #endif
 
+#ifdef _MSC_VER
+/* mute ossl3 deprecation warnings treated as errors in msvc */
+#pragma warning(disable: 4996)
+#endif
+
 /*
  * Check for key size creepage.
  */
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 56fdf520..1d32c41f 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -147,11 +147,13 @@
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -162,11 +164,13 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -177,11 +181,13 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -192,44 +198,52 @@
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <ClCompile>
-      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
-      <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
       <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
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
       <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
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
       <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <ControlFlowGuard>Guard</ControlFlowGuard>
+      <WarningLevel>Level2</WarningLevel>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -316,8 +330,8 @@
     <ClCompile Include="vlan.c" />
     <ClCompile Include="win32.c" />
     <ClCompile Include="win32-util.c" />
-    <ClCompile Include="xkey_helper.c"/>
-    <ClCompile Include="xkey_provider.c"/>
+    <ClCompile Include="xkey_helper.c" />
+    <ClCompile Include="xkey_provider.c" />
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="argv.h" />
@@ -409,7 +423,7 @@
     <ClInclude Include="vlan.h" />
     <ClInclude Include="win32.h" />
     <ClInclude Include="win32-util.h" />
-    <ClInclude Include="xkey_common.h"/>
+    <ClInclude Include="xkey_common.h" />
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index f5fdfcd7..4cf0bb00 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -246,6 +246,12 @@
     <ClCompile Include="ssl_util.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="xkey_helper.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="xkey_provider.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -515,6 +521,9 @@
     <ClInclude Include="win32-util.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="xkey_common.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
index 11aa78bb..bf384db6 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -135,6 +135,48 @@
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <VcpkgEnabled>true</VcpkgEnabled>
   </PropertyGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+      <SDLCheck>true</SDLCheck>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="..\tapctl\error.c" />
     <ClCompile Include="..\tapctl\tap.c" />
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 5fd7d60b..d42e9642 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -125,6 +125,8 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -136,6 +138,8 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -147,6 +151,8 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -158,28 +164,36 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
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
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
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
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
     </ClCompile>
     <ResourceCompile />
     <Link>
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
index 79da9d33..0fc22d97 100644
--- a/src/tapctl/tapctl.vcxproj
+++ b/src/tapctl/tapctl.vcxproj
@@ -135,12 +135,48 @@
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
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+    </ClCompile>
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+    <ClCompile>
+      <SDLCheck>true</SDLCheck>
+      <AdditionalOptions>/ZH:SHA_256 %(AdditionalOptions)</AdditionalOptions>
+    </ClCompile>
+  </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="error.c" />
     <ClCompile Include="tap.c" />
-- 
2.23.0.windows.1


