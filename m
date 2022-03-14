From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 14 Mar 2022 14:03:34 +0200
Message-Id: <20220314120334.231-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+release/2.5]
 vcpkg-ports/pkcs11-helper: adapt to new upstream URL
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
 contrib/vcpkg-ports/pkcs11-helper/CONTROL        | 2 +-
 contrib/vcpkg-ports/pkcs11-helper/portfile.cmake | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
index 6a5077fd..ff116364 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
+++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
@@ -1,4 +1,4 @@
 Source: pkcs11-helper
-Version: 1.28-3
+Version: 1.28-4
 Homepage: https://github.com/OpenSC/pkcs11-helper
 Description: pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 0723344e..4a9cd20c 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,9 +1,9 @@
-set(VERSION 1.28)
+set(VERSION 1.28.0)
 
 vcpkg_download_distfile(ARCHIVE
-    URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.0.tar.bz2"
-    FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
-    SHA512 11b8e554d9223ab9305a3ad7e2b6a9bbece1c09ca8d49276618dec31eefdccf6a32b0db85a28a90334ea42fe809beec83514a31930b79bdbefa368ed4658945b
+    URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.gz"
+    FILENAME "pkcs11-helper-${VERSION}.tar.gz"
+    SHA512 1c1cc7f83ed360fabdcfa68d0eafa7d25be03e68c6a202e7ad2907feb472663bb34e12b9e162344ec221a4298abc02acdc75f0f45d9a89657aa7ac55e59badd5
 )
 
 vcpkg_extract_source_archive_ex(
-- 
2.23.0.windows.1


