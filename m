From: Eric Thorpe <eric@...1918...>
Message-ID: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
Date: Tue, 14 Mar 2017 09:26:52 +1100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix Building Using MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

This patch enables the building of OpenVPN for the 2.4 and master 
branches using MSVC (Visual Studio 2013 / MSVC v120), which currently 
doesn't work with 2.4 or a clone of master. 2013 is being used as it 
reduces the complexity of the redistributable requirements and has 
mostly complete C99 support. Further changes will be necessary for 2015 
support when the switch is made.

Note the changes to config-msvc-version.h.in are more of a work around. 
It was a simpler approach when compared to modifying msvc-generate.js to 
handle m4 syntax, and so it may be dropped if there is an intention to 
update the javascript generator.

Signed-off by: Eric Thorpe <eric@...1918...>
---
diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
index 4bc89e7..7977cb8 100644
--- a/config-msvc-version.h.in
+++ b/config-msvc-version.h.in
@@ -1,8 +1,12 @@
  #define PACKAGE_NAME "@PRODUCT_NAME@"
-#define PACKAGE_STRING "@PRODUCT_NAME@ @PRODUCT_VERSION@"
+#define PACKAGE_STRING "@PRODUCT_NAME@ 
@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@@PRODUCT_VERSION_PATCH@"
  #define PACKAGE_TARNAME "@PRODUCT_TARNAME@"
  #define PACKAGE "@PRODUCT_TARNAME@"
-#define PACKAGE_VERSION "@PRODUCT_VERSION@"
+#define PRODUCT_VERSION_MAJOR "@PRODUCT_VERSION_MAJOR@"
+#define PRODUCT_VERSION_MINOR "@PRODUCT_VERSION_MINOR@"
+#define PRODUCT_VERSION_PATCH "@PRODUCT_VERSION_PATCH@"
+#define PACKAGE_VERSION 
"@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@...220...@PRODUCT_VERSION_PATCH@"
+#define PRODUCT_VERSION 
"@PRODUCT_VERSION_MAJOR@...220...@PRODUCT_VERSION_MINOR@...220...@PRODUCT_VERSION_PATCH@"
  #define PRODUCT_BUGREPORT "@PRODUCT_BUGREPORT@"
  #define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@
  #define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
diff --git a/config-msvc.h b/config-msvc.h
index 3e71c85..9b97e71 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -126,6 +126,7 @@ typedef __int64 int64_t;
  typedef __int32 int32_t;
  typedef __int16 int16_t;
  typedef __int8 int8_t;
+typedef uint16_t in_port_t;

  #ifdef HAVE_CONFIG_MSVC_LOCAL_H
  #include <config-msvc-local.h>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5549d70..bed39f3 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -287,7 +287,12 @@ show_available_ciphers()

      /* If we ever exceed this, we must be more selective */
      const size_t cipher_list_len = 1000;
+#ifdef _MSC_VER
+    //While GCC will allow you to use a const, MSVC won't (at least 
with a simple declaration). Use a compile time constant for now
+    const EVP_CIPHER *cipher_list[1000];
+#else
      const EVP_CIPHER *cipher_list[cipher_list_len];
+#endif
      size_t num_ciphers = 0;
  #ifndef ENABLE_SMALL
      printf("The following ciphers and cipher modes are available for 
use\n"
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 8dfbea5..e8a48e2 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -99,13 +99,16 @@
      </Link>
    </ItemDefinitionGroup>
    <ItemGroup>
+    <ClCompile Include="argv.c" />
      <ClCompile Include="base64.c" />
+    <ClCompile Include="block_dns.c" />
      <ClCompile Include="buffer.c" />
      <ClCompile Include="clinat.c" />
      <ClCompile Include="comp-lz4.c" />
      <ClCompile Include="comp.c" />
      <ClCompile Include="compstub.c" />
      <ClCompile Include="console.c" />
+    <ClCompile Include="console_builtin.c" />
      <ClCompile Include="crypto.c" />
      <ClCompile Include="crypto_openssl.c" />
      <ClCompile Include="cryptoapi.c" />
@@ -164,12 +167,15 @@
      <ClCompile Include="ssl_verify.c" />
      <ClCompile Include="ssl_verify_openssl.c" />
      <ClCompile Include="status.c" />
+    <ClCompile Include="tls_crypt.c" />
      <ClCompile Include="tun.c" />
      <ClCompile Include="win32.c" />
    </ItemGroup>
    <ItemGroup>
+    <ClInclude Include="argv.h" />
      <ClInclude Include="base64.h" />
      <ClInclude Include="basic.h" />
+    <ClInclude Include="block_dns.h" />
      <ClInclude Include="buffer.h" />
      <ClInclude Include="circ_list.h" />
      <ClInclude Include="clinat.h" />
@@ -249,6 +255,7 @@
      <ClInclude Include="ssl_verify_openssl.h" />
      <ClInclude Include="status.h" />
      <ClInclude Include="syshead.h" />
+    <ClInclude Include="tls_crypt.h" />
      <ClInclude Include="tun.h" />
      <ClInclude Include="win32.h" />
    </ItemGroup>
@@ -268,4 +275,4 @@
    <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
    <ImportGroup Label="ExtensionTargets">
    </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn.vcxproj.filters 
b/src/openvpn/openvpn.vcxproj.filters
index 8b6a269..30df5ec 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -216,6 +216,18 @@
      <ClCompile Include="comp-lz4.c">
        <Filter>Source Files</Filter>
      </ClCompile>
+    <ClCompile Include="argv.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="block_dns.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="console_builtin.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="tls_crypt.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
    </ItemGroup>
    <ItemGroup>
      <ClInclude Include="base64.h">
@@ -464,10 +476,22 @@
      <ClInclude Include="win32.h">
        <Filter>Header Files</Filter>
      </ClInclude>
+    <ClInclude Include="compstub.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="argv.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="block_dns.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="tls_crypt.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
    </ItemGroup>
    <ItemGroup>
      <ResourceCompile Include="openvpn_win32_resources.rc">
        <Filter>Resource Files</Filter>
      </ResourceCompile>
    </ItemGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index c64c65f..a974e7e 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -49,7 +49,11 @@
   */
  struct tls_root_ctx {
      SSL_CTX *ctx;
+#ifdef _MSC_VER
+    struct timeval crl_last_mtime;
+#else
      struct timespec crl_last_mtime;
+#endif
      off_t crl_last_size;
  };


