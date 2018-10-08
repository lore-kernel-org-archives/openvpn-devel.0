From: Simon Rozman <simon@...2293...>
Date: Mon,  8 Oct 2018 12:03:23 +0200
Message-Id: <20181008100323.11308-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Reference msvc-generate from compat to
 assure correct build order
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

Single-process builds start building compat project first and they fail,
since the referenced config-msvc-version.h is not available yet. Multi-
process rebuilds also tends to fail if the compat project is built
faster than msvc-generate is able to produce the required output files.

Adding a reference to msvc-generate project assures correct build order.
---
 src/compat/compat.vcxproj | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
index 07d6baf1..d6473581 100644
--- a/src/compat/compat.vcxproj
+++ b/src/compat/compat.vcxproj
@@ -143,6 +143,12 @@
   <ItemGroup>
     <ClInclude Include="compat.h" />
   </ItemGroup>
+  <ItemGroup>
+    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
+      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+  </ItemGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-- 
2.19.0.windows.1


