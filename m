From: Fish <fish.thss@...277...>
Date: Mon, 22 Feb 2016 15:09:23 -0500
Message-Id: <1456171763-44172-1-git-send-email-fish.thss@...277...>
Subject: [Openvpn-devel] [PATCH] Add lz4 support to MSVC project.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

- Include lz4 code and header in VC project files.
- Fix an issue in comp-lz4.h that prevents it from compiling under MSVC.
---
 config-msvc.h                       |  2 ++
 src/compat/compat.vcxproj           |  1 +
 src/compat/compat.vcxproj.filters   |  3 +++
 src/openvpn/comp-lz4.h              |  1 +
 src/openvpn/openvpn.vcxproj         |  4 +++-
 src/openvpn/openvpn.vcxproj.filters | 15 +++++++++++++++
 6 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/config-msvc.h b/config-msvc.h
index 2fb7824..87c114b 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -12,6 +12,8 @@
 #define ENABLE_FRAGMENT 1
 #define ENABLE_HTTP_PROXY 1
 #define ENABLE_LZO 1
+#define ENABLE_LZ4 1
+#define NEED_COMPAT_LZ4 1
 #define ENABLE_MANAGEMENT 1
 #define ENABLE_MULTIHOME 1
 #define ENABLE_PKCS11 1
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 1402e48..6d39f0c 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -133,6 +133,7 @@
     <ClCompile Include="compat-inet_ntop.c" />
     <ClCompile Include="compat-inet_pton.c" />
     <ClCompile Include="compat-daemon.c" />
+    <ClCompile Include="compat-lz4.c" />
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="compat.h" />
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.filters
index 00bb0ff..0f78e86 100644
--- a/src/compat/compat.vcxproj.filters
+++ b/src/compat/compat.vcxproj.filters
@@ -33,6 +33,9 @@
     <ClCompile Include="compat-daemon.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="compat-lz4.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="compat.h">
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index 9d3c664..7774ca5 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -35,6 +35,7 @@ extern const struct compress_alg lz4v2_alg;
 
 struct lz4_workspace
 {
+  int dummy;
 };
 
 #endif /* ENABLE_LZ4 */
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index ffb0f71..5cedd13 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -188,6 +188,7 @@
     <ClCompile Include="base64.c" />
     <ClCompile Include="buffer.c" />
     <ClCompile Include="clinat.c" />
+    <ClCompile Include="comp-lz4.c" />
     <ClCompile Include="comp.c" />
     <ClCompile Include="compstub.c" />
     <ClCompile Include="console.c" />
@@ -260,9 +261,10 @@
     <ClInclude Include="buffer.h" />
     <ClInclude Include="circ_list.h" />
     <ClInclude Include="clinat.h" />
+    <ClInclude Include="common.h" />
+    <ClInclude Include="comp-lz4.h" />
     <ClInclude Include="comp.h" />
     <ClInclude Include="compstub.h" />
-    <ClInclude Include="common.h" />
     <ClInclude Include="console.h" />
     <ClInclude Include="crypto.h" />
     <ClInclude Include="crypto_backend.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 367a1df..a83525e 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -207,6 +207,15 @@
     <ClCompile Include="win32.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="comp.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="compstub.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="comp-lz4.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -461,6 +470,12 @@
     <ClInclude Include="resource.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="comp.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="comp-lz4.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
-- 
2.6.4


