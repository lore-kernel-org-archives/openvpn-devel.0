From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 14 Oct 2021 02:04:17 +0300
Message-Id: <20211013230417.252-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 2/3] msvc: add missing header to project file
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

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/openvpn.vcxproj         | 1 +
 src/openvpn/openvpn.vcxproj.filters | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 2144775f..a3350410 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -355,6 +355,7 @@
     <ClInclude Include="multi.h" />
     <ClInclude Include="ntlm.h" />
     <ClInclude Include="occ.h" />
+    <ClInclude Include="openssl_compat.h" />
     <ClInclude Include="openvpn.h" />
     <ClInclude Include="options.h" />
     <ClInclude Include="otime.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index cf5748c7..bbcbff34 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -509,6 +509,9 @@
     <ClInclude Include="ssl_ncp.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="openssl_compat.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
-- 
2.23.0.windows.1


