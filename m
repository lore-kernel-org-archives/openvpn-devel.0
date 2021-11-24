From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 24 Nov 2021 12:08:38 +0200
Message-Id: <20211124100838.861-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+release/2.5] vcpkg/pkcs11-helper:
 compatibility with latest vcpkg
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

Starting from commit 21b2dbd3 "[scripts-audit] nmake buildsystem"
vcpkg has removed NO_DEBUG support from nmake buildsystem
and now builds debug variant unconditionally. Debug flags contradict
build options hardcoded in pkcs11 nmake script (like /O2).

Remove hardcoded release options and other options which
are (also) set by vcpkg nmake buildsystem.

Bump vcpkg commit in GitHub actions.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml                  |  2 +-
 ...nmake-compatibility-with-vcpkg-nmake.patch | 38 +++++++++++++++++++
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  | 10 ++---
 3 files changed, 44 insertions(+), 6 deletions(-)
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/0002-nmake-compatibility-with-vcpkg-nmake.patch

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index abf32b14..51d9dd4d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -217,7 +217,7 @@ jobs:
       - name: Restore artifacts, or run vcpkg, build and cache artifacts
         uses: lukka/run-vcpkg@...2638...
         with:
-          vcpkgGitCommitId: '71422c627264daedcbcd46f01f1ed0dcd8460f1b'
+          vcpkgGitCommitId: 'a2fcb03749ff5897b5985092934dc6057680c789'
           vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
           vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
           cleanAfterBuild: false
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-nmake-compatibility-with-vcpkg-nmake.patch b/contrib/vcpkg-ports/pkcs11-helper/0002-nmake-compatibility-with-vcpkg-nmake.patch
new file mode 100644
index 00000000..a6034f7e
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/0002-nmake-compatibility-with-vcpkg-nmake.patch
@@ -0,0 +1,38 @@
+From 68d12f3e955cc9df435e9289b1244a4c1f24b96b Mon Sep 17 00:00:00 2001
+From: Lev Stipakov <lev@...515...>
+Date: Wed, 24 Nov 2021 11:21:36 +0200
+Subject: [PATCH] nmake: compatibility with vcpkg nmake
+
+Remove options which contradict or already set
+by vcpkg nmake scripts.
+
+Signed-off-by: Lev Stipakov <lev@...515...>
+---
+ lib/Makefile.w32-vc | 8 ++------
+ 1 file changed, 2 insertions(+), 6 deletions(-)
+
+diff --git a/lib/Makefile.w32-vc b/lib/Makefile.w32-vc
+index 0e64f42..18af03b 100644
+--- a/lib/Makefile.w32-vc
++++ b/lib/Makefile.w32-vc
+@@ -75,15 +75,11 @@ OPENSSL_LIBS=-LIBPATH:$(OPENSSL_LIB) user32.lib advapi32.lib $(OPENSSL_STATIC)
+ CFLAGS = -I../include $(OPENSSL_CFLAGS) -DWIN32 -DWIN32_LEAN_AND_MEAN -D_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_WIN32_WINNT=0x0400
+ CC=cl.exe
+ RC=rc.exe
+-CCPARAMS=/nologo /W3 /O2 /FD /c
+-
+-CCPARAMS=$(CCPARAMS) /MD
+-CFLAGS=$(CFLAGS) -DNDEBUG
++CCPARAMS=/c
+ 
+ LINK32=link.exe
+ LIB32=lib.exe
+-LINK32_FLAGS=/nologo /subsystem:windows /dll /incremental:no
+-LIB32_FLAGS=/nologo
++LINK32_FLAGS=/dll
+ 
+ HEADERS = \
+ 	config.h \
+-- 
+2.23.0.windows.1
+
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 54a0009d..ad19fccb 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -12,12 +12,12 @@ vcpkg_extract_source_archive_ex(
     REF ${VERSION}
     PATCHES
         0001-nmake-openssl-1.1.1-support.patch
+        0002-nmake-compatibility-with-vcpkg-nmake.patch
         pkcs11-helper-001-RFC7512.patch
 )
 
 vcpkg_build_nmake(
     SOURCE_PATH ${SOURCE_PATH}
-    NO_DEBUG
     PROJECT_SUBPATH lib
     PROJECT_NAME Makefile.w32-vc
     OPTIONS
@@ -26,10 +26,10 @@ vcpkg_build_nmake(
 )
 
 file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
+file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
+file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
 
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
+file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
+file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
 
 file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
-- 
2.23.0.windows.1


