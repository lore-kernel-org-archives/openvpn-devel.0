From: Arne Schwabe <arne@...1227...>
Date: Sun, 17 Nov 2019 22:23:17 +0100
Message-Id: <20191117212318.13428-1-arne@...1227...>
In-Reply-To: <20191117181243.28919-1-arne@...1227...>
References: <20191117181243.28919-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/4] Add ncp files to Visual studio print
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/openvpn.vcxproj | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 7446d97d..b3d35ba2 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -191,6 +191,7 @@
     <ClCompile Include="socks.c" />
     <ClCompile Include="ssl.c" />
     <ClCompile Include="ssl_openssl.c" />
+    <ClCompile Include="ssl_ncp.c" />
     <ClCompile Include="ssl_verify.c" />
     <ClCompile Include="ssl_verify_openssl.c" />
     <ClCompile Include="status.c" />
@@ -276,6 +277,7 @@
     <ClInclude Include="ssl.h" />
     <ClInclude Include="ssl_backend.h" />
     <ClInclude Include="ssl_common.h" />
+    <ClInclude Include="ssl_ncp.h" />
     <ClInclude Include="ssl_openssl.h" />
     <ClInclude Include="ssl_verify.h" />
     <ClInclude Include="ssl_verify_backend.h" />
-- 
2.22.0


