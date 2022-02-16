From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 16 Feb 2022 15:42:27 +0200
Message-Id: <20220216134227.147-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+release/2.5] vcpkg: link lzo
 statically
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

Having .dll for a single executable doesn't make
much sense. Static linking removes 117kb .dll
and grows .exe size by only 4kb.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 contrib/vcpkg-triplets/arm64-windows-ovpn.cmake | 3 ++-
 contrib/vcpkg-triplets/x64-windows-ovpn.cmake   | 3 ++-
 contrib/vcpkg-triplets/x86-windows-ovpn.cmake   | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
index dd3c6c0a..dc600056 100644
--- a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
+++ b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
@@ -2,6 +2,7 @@ set(VCPKG_TARGET_ARCHITECTURE arm64)
 set(VCPKG_CRT_LINKAGE dynamic)
 set(VCPKG_LIBRARY_LINKAGE dynamic)
 
-if(PORT STREQUAL "lz4")
+set(STATIC_PORTS lz4 lzo)
+if(PORT IN_LIST STATIC_PORTS)
     set(VCPKG_LIBRARY_LINKAGE static)
 endif()
diff --git a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
index 7036ed2d..76e5cd55 100644
--- a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
+++ b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
@@ -2,6 +2,7 @@ set(VCPKG_TARGET_ARCHITECTURE x64)
 set(VCPKG_CRT_LINKAGE dynamic)
 set(VCPKG_LIBRARY_LINKAGE dynamic)
 
-if(PORT STREQUAL "lz4")
+set(STATIC_PORTS lz4 lzo)
+if(PORT IN_LIST STATIC_PORTS)
     set(VCPKG_LIBRARY_LINKAGE static)
 endif()
diff --git a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
index 7d3bf340..643d7bdd 100644
--- a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
+++ b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
@@ -2,6 +2,7 @@ set(VCPKG_TARGET_ARCHITECTURE x86)
 set(VCPKG_CRT_LINKAGE dynamic)
 set(VCPKG_LIBRARY_LINKAGE dynamic)
 
-if(PORT STREQUAL "lz4")
+set(STATIC_PORTS lz4 lzo)
+if(PORT IN_LIST STATIC_PORTS)
     set(VCPKG_LIBRARY_LINKAGE static)
 endif()
-- 
2.23.0.windows.1


