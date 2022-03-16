From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 16 Mar 2022 15:54:11 +0200
Message-Id: <20220316135411.217-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+release/2.5]
 vcpkg-ports\pkcs11-helper: shorten patch filename
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

"make dist" uses tar which breaks on long filenames:

  tar:
  openvpn-2.5.6/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch:
  file name is too long (max 99); not dumped
  tar: Exiting with failure status due to previous errors

and then "make dist" continues.

Make filename shorter to make tar happy.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 ...ort.patch => 0003-config-w32-vc.h.in-indicate-OpenSSL.patch} | 0
 contrib/vcpkg-ports/pkcs11-helper/portfile.cmake                | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename contrib/vcpkg-ports/pkcs11-helper/{0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch => 0003-config-w32-vc.h.in-indicate-OpenSSL.patch} (100%)

diff --git a/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch b/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL.patch
similarity index 100%
rename from contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch
rename to contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL.patch
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 55c65335..22e9bd1f 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -13,7 +13,7 @@ vcpkg_extract_source_archive_ex(
     PATCHES
         0001-nmake-compatibility-with-vcpkg-nmake.patch
         0002-pkcs11.h-rename-interface-parameter.patch
-        0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch
+        0003-config-w32-vc.h.in-indicate-OpenSSL.patch
         pkcs11-helper-001-RFC7512.patch
 )
 
-- 
2.23.0.windows.1


