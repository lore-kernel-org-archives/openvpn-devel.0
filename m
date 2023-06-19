From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 19 Jun 2023 15:29:32 +0200
Message-Id: <20230619132934.76085-3-frank@...2641...>
In-Reply-To: <20230619132934.76085-1-frank@...2641...>
References: <20230614102115.138724-1-frank@...2641...>
 <20230619132934.76085-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] vcpkg-ports/pkcs11-helper: rename
 patches to make file names shorter
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

Remove the number prefixes we do not use anyway.

And then rename Allow-the-build-to-succeed-if-configured-with-disabl.patch
to make it short enough that it can fit in a tar archive
built with --old-archive. Otherwise make dist might not include it:

tar: openvpn-2.7_git/contrib/vcpkg-ports/pkcs11-helper/Allow-the-build-to-succeed-if-configured-with-disabl.patch:
file name is too long (max 99); not dumped

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 ...ith-disabl.patch => Fix-build-with-disable-shared.patch} | 0
 ...nSSL.patch => config-w32-vc.h.in-indicate-OpenSSL.patch} | 0
 ...ake.patch => nmake-compatibility-with-vcpkg-nmake.patch} | 0
 contrib/vcpkg-ports/pkcs11-helper/portfile.cmake            | 6 +++---
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename contrib/vcpkg-ports/pkcs11-helper/{0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch => Fix-build-with-disable-shared.patch} (100%)
 rename contrib/vcpkg-ports/pkcs11-helper/{0002-config-w32-vc.h.in-indicate-OpenSSL.patch => config-w32-vc.h.in-indicate-OpenSSL.patch} (100%)
 rename contrib/vcpkg-ports/pkcs11-helper/{0001-nmake-compatibility-with-vcpkg-nmake.patch => nmake-compatibility-with-vcpkg-nmake.patch} (100%)

Note: unchanged from previous submission

diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch b/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
similarity index 100%
rename from contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
rename to contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch b/contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-OpenSSL.patch
similarity index 100%
rename from contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch
rename to contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-OpenSSL.patch
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch b/contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-nmake.patch
similarity index 100%
rename from contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch
rename to contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-nmake.patch
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 67e9a2bf..47919bc6 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -11,9 +11,9 @@ vcpkg_extract_source_archive_ex(
     ARCHIVE ${ARCHIVE}
     REF ${VERSION}
     PATCHES
-        0001-nmake-compatibility-with-vcpkg-nmake.patch
-        0002-config-w32-vc.h.in-indicate-OpenSSL.patch
-        0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
+        nmake-compatibility-with-vcpkg-nmake.patch
+        config-w32-vc.h.in-indicate-OpenSSL.patch
+        Fix-build-with-disable-shared.patch
         pkcs11-helper-001-RFC7512.patch
         pkcs11-helper-002-dynamic_loader_flags.patch
 )
-- 
2.34.1


