From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 14 Sep 2020 11:44:44 +0300
Message-Id: <20200914084444.96-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] msvc: better support for 32bit architecture
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

Previously dependency directory was hardcoded to

..\openvpn-build\msvc\image

which means that to build for 32bit architecture,
one needs to rebuild dependencies and do the same again
for 64bit architecture.

Add architecture's "bitness" to dependency directory.

As a bonus, add missing libraries to 32bit targets.

This requires correspondig change to openvpn-build:

https://github.com/OpenVPN/openvpn-build/pull/190
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/compat/PropertySheet.props | 2 +-
 src/openvpn/openvpn.vcxproj    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.props
index fdded318..4f94b972 100644
--- a/src/compat/PropertySheet.props
+++ b/src/compat/PropertySheet.props
@@ -3,7 +3,7 @@
   <ImportGroup Label="PropertySheets" />
   <PropertyGroup Label="UserMacros">
     <SOURCEBASE>$(SolutionDir)</SOURCEBASE>
-    <OPENVPN_DEPROOT>$(SOURCEBASE)\..\openvpn-build\msvc\image</OPENVPN_DEPROOT>
+    <OPENVPN_DEPROOT>$(SOURCEBASE)\..\openvpn-build\msvc\image$(PlatformArchitecture)</OPENVPN_DEPROOT>
     <OPENSSL_HOME>$(OPENVPN_DEPROOT)</OPENSSL_HOME>
     <TAP_WINDOWS_HOME>$(OPENVPN_DEPROOT)</TAP_WINDOWS_HOME>
     <LZO_HOME>$(OPENVPN_DEPROOT)</LZO_HOME>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 5367979d..3863854b 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -92,7 +92,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -122,7 +122,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
-- 
2.17.1


