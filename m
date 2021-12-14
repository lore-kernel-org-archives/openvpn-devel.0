From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:28 -0500
Message-Id: <20211214165928.30676-19-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 18/18] Add xkey_provider sources and
 includes to MSVC project
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

From: Selva Nair <selva.nair@...277...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/openvpn.vcxproj | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 65ee6839..2f0cee60 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -316,6 +316,8 @@
     <ClCompile Include="vlan.c" />
     <ClCompile Include="win32.c" />
     <ClCompile Include="win32-util.c" />
+    <ClCompile Include="xkey_helper.c"/>
+    <ClCompile Include="xkey_provider.c"/>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="argv.h" />
@@ -407,6 +409,7 @@
     <ClInclude Include="vlan.h" />
     <ClInclude Include="win32.h" />
     <ClInclude Include="win32-util.h" />
+    <ClInclude Include="xkey_common.h"/>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc" />
-- 
2.30.2


