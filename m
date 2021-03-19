From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 19 Mar 2021 04:33:17 +0200
Message-Id: <20210319023317.15050-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Remove compat-lz4 references from VS
 project files
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

Commit 24596b25 ("build: Remove compat-lz4") removed lz4 compat layer,
but didn't remove references from VS project files.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/compat/compat.vcxproj         | 3 +--
 src/compat/compat.vcxproj.filters | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 0c4c7b0f..23e9b9c0 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -101,7 +101,6 @@
     <ClCompile Include="compat-inet_ntop.c" />
     <ClCompile Include="compat-inet_pton.c" />
     <ClCompile Include="compat-daemon.c" />
-    <ClCompile Include="compat-lz4.c" />
     <ClCompile Include="compat-strsep.c" />
   </ItemGroup>
   <ItemGroup>
@@ -116,4 +115,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.filters
index 0f78e86e..404863ca 100644
--- a/src/compat/compat.vcxproj.filters
+++ b/src/compat/compat.vcxproj.filters
@@ -33,7 +33,7 @@
     <ClCompile Include="compat-daemon.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="compat-lz4.c">
+    <ClCompile Include="compat-strsep.c">
       <Filter>Source Files</Filter>
     </ClCompile>
   </ItemGroup>
-- 
2.17.1


