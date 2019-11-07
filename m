From: Simon Rozman <simon@...2293...>
Date: Thu,  7 Nov 2019 14:29:01 +0100
Message-Id: <20191107132901.1280-1-simon@...2293...>
In-Reply-To: <20191107122743.GQ40538@...1296...>
References: <20191107122743.GQ40538@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] msvc: Add vlan.c/h
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

This upgrades 99f28081477ca325a14b13c38abec2c9b619eb01 to support MSVC
building.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/openvpn.vcxproj         | 2 ++
 src/openvpn/openvpn.vcxproj.filters | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 85af466f..48e8e140 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -196,6 +196,7 @@
     <ClCompile Include="status.c" />
     <ClCompile Include="tls_crypt.c" />
     <ClCompile Include="tun.c" />
+    <ClCompile Include="vlan.c" />
     <ClCompile Include="win32.c" />
   </ItemGroup>
   <ItemGroup>
@@ -283,6 +284,7 @@
     <ClInclude Include="syshead.h" />
     <ClInclude Include="tls_crypt.h" />
     <ClInclude Include="tun.h" />
+    <ClInclude Include="vlan.h" />
     <ClInclude Include="win32.h" />
   </ItemGroup>
   <ItemGroup>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index e6068aff..653e892c 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -237,6 +237,9 @@
     <ClCompile Include="auth_token.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="vlan.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -494,6 +497,9 @@
     <ClInclude Include="auth_token.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="vlan.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
-- 
2.23.0.windows.1


