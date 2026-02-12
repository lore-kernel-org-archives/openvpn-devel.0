From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 12 Feb 2026 12:09:35 +0100
Message-ID: <20260212110935.19541-1-frank@...2641...>
In-Reply-To: <gerrit.1770830490000.I7462869a473a7afe2e9ed9474c69de0af96c011c@...2715...>
References: <gerrit.1770830490000.I7462869a473a7afe2e9ed9474c69de0af96c011c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] vcpkg-ports: Review pkcs11-helper port
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
Cc: Yuriy Darnobyt <yura.uddr@...277...>

- Replace deprecated functions with newer alternatives
- Improve vcpkg.json by documenting openssl dependency
- Remove unnecessary duplicated version number
- Fix whitespaces

Change-Id: I7462869a473a7afe2e9ed9474c69de0af96c011c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1518
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1518
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index af19831..f5742a4 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,15 +1,12 @@
-set(VERSION 1.31.0)
-
 vcpkg_download_distfile(ARCHIVE
     URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2"
     FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
     SHA512 0833efc59e9093dd398a54640d858b01a830ef7adfb40321c1e0ed0afa004500fc1259cc66bc49c5263935adeda0a3bfe658de538eefd66888685a71f731c484
 )
 
-vcpkg_extract_source_archive_ex(
-    OUT_SOURCE_PATH SOURCE_PATH
+vcpkg_extract_source_archive(
+    SOURCE_PATH
     ARCHIVE ${ARCHIVE}
-    REF ${VERSION}
     PATCHES
         nmake-compatibility-with-vcpkg-nmake.patch
         config-w32-vc.h.in-indicate-OpenSSL.patch
@@ -33,20 +30,20 @@
   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
 
   set(PACKAGE_VERSION "${VERSION}")
-    set(libdir [[${prefix}/lib]])
-    set(exec_prefix [[${prefix}]])
-    set(PKCS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine_crypto_openssl debug threading token data certificate slotevent engine_crypto)
-    set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32)
-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
-        set(includedir [[${prefix}/include]])
-        set(outfile "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helper-1.pc")
-        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outfile}" @ONLY)
-    endif()
-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
-        set(includedir [[${prefix}/../include]])
-        set(outfile "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libpkcs11-helper-1.pc")
-        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outfile}" @ONLY)
-    endif()
+  set(libdir [[${prefix}/lib]])
+  set(exec_prefix [[${prefix}]])
+  set(PKCS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine_crypto_openssl debug threading token data certificate slotevent engine_crypto)
+  set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32)
+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
+      set(includedir [[${prefix}/include]])
+      set(outfile "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helper-1.pc")
+      configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outfile}" @ONLY)
+  endif()
+  if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
+      set(includedir [[${prefix}/../include]])
+      set(outfile "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libpkcs11-helper-1.pc")
+      configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outfile}" @ONLY)
+  endif()
 
   file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
 
@@ -66,4 +63,4 @@
 vcpkg_fixup_pkgconfig()
 vcpkg_copy_pdbs()
 
-file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
+vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
index 382a3d3..da54646 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
@@ -1,7 +1,11 @@
 {
-    "name": "pkcs11-helper",
-    "version": "1.31.0",
-    "description": "pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.",
-    "homepage": "https://github.com/OpenSC/pkcs11-helper",
-    "license": "BSD-3-Clause OR GPL-2.0-only"
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json",
+  "name": "pkcs11-helper",
+  "version": "1.31.0",
+  "description": "pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.",
+  "homepage": "https://github.com/OpenSC/pkcs11-helper",
+  "license": "BSD-3-Clause OR GPL-2.0-only",
+  "dependencies": [
+    "openssl"
+  ]
 }

