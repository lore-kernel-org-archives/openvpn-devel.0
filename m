From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  5 May 2022 15:14:49 +0300
Message-Id: <20220505121449.347-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] vcpkg: switch to manifest
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

Add vcpkg manifest file which lists
dependencies and enable manifest usage in
project file.

This simplifies build process by eliminating
separate "vcpkg install" step to install dependencies.

Since vcpkg added openssl3 port, remove ours.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml                  |  16 +-
 .gitignore                                    |   1 +
 contrib/vcpkg-ports/openssl3/portfile.cmake   | 166 ------------------
 contrib/vcpkg-ports/openssl3/usage            |   4 -
 contrib/vcpkg-ports/openssl3/vcpkg.json       |   7 -
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   2 +-
 src/openvpn/openvpn.vcxproj                   |   9 +
 src/openvpn/vcpkg.json                        |  13 ++
 8 files changed, 31 insertions(+), 187 deletions(-)
 delete mode 100644 contrib/vcpkg-ports/openssl3/portfile.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl3/usage
 delete mode 100644 contrib/vcpkg-ports/openssl3/vcpkg.json
 create mode 100644 src/openvpn/vcpkg.json

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 34a9d9b9..ac46a72c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -290,19 +290,17 @@ jobs:
       - name: Install rst2html
         run: python -m pip install --upgrade pip rst2html
 
-      - name: Restore artifacts, or run vcpkg, build and cache artifacts
-        uses: lukka/run-vcpkg@...2638...
+      - name: Restore artifacts, or setup vcpkg (do not install any package)
+        uses: lukka/run-vcpkg@...2637...
         with:
-          vcpkgGitCommitId: 'a69b65229b3956b7f45abd81671b7330114bcaad'
-          vcpkgArguments: 'openssl3 lz4 lzo pkcs11-helper tap-windows6'
-          vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
-          cleanAfterBuild: false
+          vcpkgGitCommitId: '4b766c1cd17205e1b768c4fadfd5f867c1d0510e'
+          appendedCacheKey: '${{matrix.triplet}}'
 
-      - name: Build
+      - name: Run MSBuild consuming vcpkg.json
         working-directory: ${{env.GITHUB_WORKSPACE}}
         run: |
-          vcpkg integrate install
-          msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
+            vcpkg integrate install
+            msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
 
       - name: Archive artifacts
         uses: actions/upload-artifact@...2620...
diff --git a/.gitignore b/.gitignore
index 178076ed..7335154f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,7 @@ m4/ltoptions.m4
 m4/ltsugar.m4
 m4/ltversion.m4
 m4/lt~obsolete.m4
+vcpkg_installed
 
 version.sh
 msvc-env-local.bat
diff --git a/contrib/vcpkg-ports/openssl3/portfile.cmake b/contrib/vcpkg-ports/openssl3/portfile.cmake
deleted file mode 100644
index 40fe97b7..00000000
--- a/contrib/vcpkg-ports/openssl3/portfile.cmake
+++ /dev/null
@@ -1,166 +0,0 @@
-# based on openssl port from vcpkg official repo
-
-if(EXISTS ${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h)
-    message(FATAL_ERROR "Can't build '${PORT}' if another SSL library is installed. Please remove existing one and try install '${PORT}' again if you need it.")
-endif()
-
-vcpkg_from_github(
-    OUT_SOURCE_PATH SOURCE_PATH
-    REPO openssl/openssl
-    REF openssl-3.0.2
-    SHA512 d69c87b8250da813f282ead0bd005ebde663e77595ee8d99560d25f345570da2fa552b57c372956d461e3b631a19d6d60bebafe6ff89aeebbb5d34ad516b62ac
-)
-
-vcpkg_find_acquire_program(PERL)
-get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
-vcpkg_add_to_path("${PERL_EXE_PATH}")
-
-vcpkg_find_acquire_program(NASM)
-get_filename_component(NASM_EXE_PATH "${NASM}" DIRECTORY)
-vcpkg_add_to_path(PREPEND "${NASM_EXE_PATH}")
-
-vcpkg_find_acquire_program(JOM)
-
-set(OPENSSL_SHARED no-shared)
-if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
-    set(OPENSSL_SHARED shared)
-endif()
-
-# see ${SOURCE_PATH}/INSTALL.md
-list(APPEND CONFIGURE_OPTIONS
-    no-zlib
-    no-ui-console   # Don't build with the User Interface (UI) console method
-    no-makedepend   # Don't generate dependencies
-    no-module       # Don't build any dynamically loadable engines
-    no-tests        # Don't build test programs or run any tests
-    enable-legacy   # link statically legacy provider instead of generating legacy.dll
-    -utf-8
-    -FS
-    ${OPENSSL_SHARED}
-)
-
-set(CONFIGURE_COMMAND "${PERL}" Configure ${CONFIGURE_OPTIONS})
-
-if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
-    set(OPENSSL_ARCH VC-WIN32)
-elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
-    set(OPENSSL_ARCH VC-WIN64A)
-elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
-    set(OPENSSL_ARCH VC-WIN32-ARM)
-elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
-    set(OPENSSL_ARCH VC-WIN64-ARM)
-else()
-    message(FATAL_ERROR "Unsupported target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
-endif()
-
-set(OPENSSL_MAKEFILE "makefile")
-
-file(REMOVE_RECURSE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
-                    "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
-
-if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
-
-    # Copy openssl sources.
-    message(STATUS "Copying openssl release source files...")
-    file(GLOB OPENSSL_SOURCE_FILES ${SOURCE_PATH}/*)
-    foreach(SOURCE_FILE ${OPENSSL_SOURCE_FILES})
-        file(COPY ${SOURCE_FILE} DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
-    endforeach()
-    message(STATUS "Copying openssl release source files... done")
-    set(SOURCE_PATH_RELEASE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
-
-    set(OPENSSLDIR_RELEASE ${CURRENT_PACKAGES_DIR})
-
-    message(STATUS "Configure ${TARGET_TRIPLET}-rel")
-    vcpkg_execute_required_process(
-        COMMAND ${CONFIGURE_COMMAND} ${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_RELEASE}" "--openssldir=${OPENSSLDIR_RELEASE}"
-        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
-        LOGNAME configure-perl-${TARGET_TRIPLET}-rel
-    )
-    message(STATUS "Configure ${TARGET_TRIPLET}-rel done")
-
-    message(STATUS "Build ${TARGET_TRIPLET}-rel")
-    # Openssl's buildsystem has a race condition which will cause JOM to fail at some point.
-    # This is ok; we just do as much work as we can in parallel first, then follow up with a single-threaded build.
-    execute_process(
-        COMMAND ${JOM} -k -j ${VCPKG_CONCURRENCY} -f ${OPENSSL_MAKEFILE}
-        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
-        OUTPUT_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-out.log
-        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-err.log
-    )
-    vcpkg_execute_required_process(
-        COMMAND nmake -f ${OPENSSL_MAKEFILE} install_dev install_runtime install_ssldirs
-        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
-        LOGNAME build-${TARGET_TRIPLET}-rel-1)
-
-    message(STATUS "Build ${TARGET_TRIPLET}-rel done")
-endif()
-
-if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
-    # Copy openssl sources.
-    message(STATUS "Copying openssl debug source files...")
-    file(GLOB OPENSSL_SOURCE_FILES ${SOURCE_PATH}/*)
-    foreach(SOURCE_FILE ${OPENSSL_SOURCE_FILES})
-        file(COPY ${SOURCE_FILE} DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
-    endforeach()
-    message(STATUS "Copying openssl debug source files... done")
-    set(SOURCE_PATH_DEBUG "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
-
-    set(OPENSSLDIR_DEBUG ${CURRENT_PACKAGES_DIR}/debug)
-
-    message(STATUS "Configure ${TARGET_TRIPLET}-dbg")
-    vcpkg_execute_required_process(
-        COMMAND ${CONFIGURE_COMMAND} debug-${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_DEBUG}" "--openssldir=${OPENSSLDIR_DEBUG}"
-        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
-        LOGNAME configure-perl-${TARGET_TRIPLET}-dbg
-    )
-    message(STATUS "Configure ${TARGET_TRIPLET}-dbg done")
-
-    message(STATUS "Build ${TARGET_TRIPLET}-dbg")
-    execute_process(
-        COMMAND "${JOM}" -k -j ${VCPKG_CONCURRENCY} -f "${OPENSSL_MAKEFILE}"
-        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
-        OUTPUT_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-out.log
-        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-err.log
-    )
-    vcpkg_execute_required_process(
-        COMMAND nmake -f "${OPENSSL_MAKEFILE}" install_dev install_runtime install_ssldirs
-        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
-        LOGNAME build-${TARGET_TRIPLET}-dbg-1)
-
-    message(STATUS "Build ${TARGET_TRIPLET}-dbg done")
-endif()
-
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/certs")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/private")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/certs")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/private")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
-
-file(REMOVE
-    "${CURRENT_PACKAGES_DIR}/ct_log_list.cnf"
-    "${CURRENT_PACKAGES_DIR}/ct_log_list.cnf.dist"
-    "${CURRENT_PACKAGES_DIR}/openssl.cnf.dist"
-    "${CURRENT_PACKAGES_DIR}/debug/bin/openssl.exe"
-    "${CURRENT_PACKAGES_DIR}/debug/ct_log_list.cnf"
-    "${CURRENT_PACKAGES_DIR}/debug/ct_log_list.cnf.dist"
-    "${CURRENT_PACKAGES_DIR}/debug/openssl.cnf"
-    "${CURRENT_PACKAGES_DIR}/debug/openssl.cnf.dist"
-)
-
-file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/openssl/")
-file(RENAME "${CURRENT_PACKAGES_DIR}/bin/openssl.exe" "${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.exe")
-file(RENAME "${CURRENT_PACKAGES_DIR}/openssl.cnf" "${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.cnf")
-
-vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/openssl")
-
-if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
-    # They should be empty, only the exes deleted above were in these directories
-    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin/")
-    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin/")
-endif()
-
-vcpkg_copy_pdbs()
-
-file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
-file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
diff --git a/contrib/vcpkg-ports/openssl3/usage b/contrib/vcpkg-ports/openssl3/usage
deleted file mode 100644
index 97e7760e..00000000
--- a/contrib/vcpkg-ports/openssl3/usage
+++ /dev/null
@@ -1,4 +0,0 @@
-The package openssl3 is compatible with built-in CMake targets:
-
-    find_package(OpenSSL REQUIRED)
-    target_link_libraries(main PRIVATE OpenSSL::SSL OpenSSL::Crypto)
diff --git a/contrib/vcpkg-ports/openssl3/vcpkg.json b/contrib/vcpkg-ports/openssl3/vcpkg.json
deleted file mode 100644
index ecf7a8d0..00000000
--- a/contrib/vcpkg-ports/openssl3/vcpkg.json
+++ /dev/null
@@ -1,7 +0,0 @@
-{
-  "name": "openssl3",
-  "version-semver": "3.0.2",
-  "description": "TLS/SSL and crypto library",
-  "homepage": "https://www.openssl.org/",
-  "license": "Apache-2.0"
-}
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index a19ea254..4432b550 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -22,7 +22,7 @@ vcpkg_build_nmake(
     PROJECT_NAME Makefile.w32-vc
     OPTIONS
         OPENSSL=1
-        OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl3_${TARGET_TRIPLET}
+        OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
 )
 
 file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 5e7d94d9..860ef892 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -124,26 +124,35 @@
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>arm64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x86-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
   </PropertyGroup>
   <PropertyGroup Label="Vcpkg" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
     <VcpkgEnabled>true</VcpkgEnabled>
     <VcpkgTriplet>x64-windows-ovpn</VcpkgTriplet>
+    <VcpkgAdditionalInstallOptions>--overlay-triplets=$(SolutionDir)contrib\vcpkg-triplets --overlay-ports=$(SolutionDir)contrib\vcpkg-ports</VcpkgAdditionalInstallOptions>
+  </PropertyGroup>
+  <PropertyGroup Label="Vcpkg">
+    <VcpkgEnableManifest>true</VcpkgEnableManifest>
   </PropertyGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
     <ClCompile>
diff --git a/src/openvpn/vcpkg.json b/src/openvpn/vcpkg.json
new file mode 100644
index 00000000..5489d146
--- /dev/null
+++ b/src/openvpn/vcpkg.json
@@ -0,0 +1,13 @@
+{
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json",
+  "name": "openvpn",
+  "version": "2.6",
+  "dependencies": [
+    "openssl",
+    "tap-windows6",
+    "lzo",
+    "lz4",
+    "pkcs11-helper"
+  ],
+  "builtin-baseline": "4b766c1cd17205e1b768c4fadfd5f867c1d0510e"
+}
-- 
2.23.0.windows.1


