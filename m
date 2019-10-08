From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  8 Oct 2019 15:26:46 +0300
Message-Id: <1570537606-29323-2-git-send-email-lstipakov@...277...>
In-Reply-To: <1570537606-29323-1-git-send-email-lstipakov@...277...>
References: <1570537606-29323-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] vcxproj: add missing source files
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

From: Lev Stipakov <lev@...515...>

Commit 1b9a88a has added new C source/header files which
have to be added to VS project file.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/openvpn.vcxproj         | 2 ++
 src/openvpn/openvpn.vcxproj.filters | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 92d7e32..3b0ee60 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -124,6 +124,7 @@
   </ItemDefinitionGroup>
   <ItemGroup>
     <ClCompile Include="argv.c" />
+    <ClCompile Include="auth_token.c" />
     <ClCompile Include="base64.c" />
     <ClCompile Include="block_dns.c" />
     <ClCompile Include="buffer.c" />
@@ -199,6 +200,7 @@
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="argv.h" />
+    <ClInclude Include="auth_token.h" />
     <ClInclude Include="base64.h" />
     <ClInclude Include="basic.h" />
     <ClInclude Include="block_dns.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 7a9aa63..e6068af 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -234,6 +234,9 @@
     <ClCompile Include="run_command.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="auth_token.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -488,6 +491,9 @@
     <ClInclude Include="run_command.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="auth_token.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
-- 
2.7.4


