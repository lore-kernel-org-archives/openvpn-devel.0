From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 26 Jan 2022 14:35:02 +0200
Message-Id: <20220126123502.403-1-lstipakov@...277...>
In-Reply-To: <20220121052259.508-3-lstipakov@...277...>
References: <20220121052259.508-3-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2 2/2] msvc: switch to openssl3
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

Add openssl3 vcpkg port, which is slightly modified version of
openssl1.1.1 port from official vcpkg repo.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v2:
  - rewrite openssl3 port based on upstream's openssl1.1.1 port
and statically link legacy provider into it

 .github/workflows/build.yaml                  |   2 +-
 contrib/vcpkg-ports/openssl3/portfile.cmake   | 168 ++++++++++++++++++
 contrib/vcpkg-ports/openssl3/usage            |   4 +
 contrib/vcpkg-ports/openssl3/vcpkg.json       |   7 +
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   2 +-
 5 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 contrib/vcpkg-ports/openssl3/portfile.cmake
 create mode 100644 contrib/vcpkg-ports/openssl3/usage
 create mode 100644 contrib/vcpkg-ports/openssl3/vcpkg.json

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 9f884ac2..f1a75736 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -294,7 +294,7 @@ jobs:
         uses: lukka/run-vcpkg@...2638...
         with:
           vcpkgGitCommitId: 'a2fcb03749ff5897b5985092934dc6057680c789'
-          vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
+          vcpkgArguments: 'openssl3 lz4 lzo pkcs11-helper tap-windows6'
           vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
           cleanAfterBuild: false
 
diff --git a/contrib/vcpkg-ports/openssl3/portfile.cmake b/contrib/vcpkg-ports/openssl3/portfile.cmake
new file mode 100644
index 00000000..333ad171
--- /dev/null
+++ b/contrib/vcpkg-ports/openssl3/portfile.cmake
@@ -0,0 +1,168 @@
+# based on openssl port from vcpkg official repo
+
+if(EXISTS ${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h)
+    message(FATAL_ERROR "Can't build '${PORT}' if another SSL library is installed. Please remove existing one and try install '${PORT}' again if you need it.")
+endif()
+
+vcpkg_fail_port_install(MESSAGE "${PORT} is only for Windows Desktop" ON_TARGET "UWP" "Linux" "OSX")
+
+vcpkg_from_github(
+    OUT_SOURCE_PATH SOURCE_PATH
+    REPO openssl/openssl
+    REF openssl-3.0.1
+    SHA512 7f303769a3a796b88478399d42aa2a9a70dc74f62c975bbb93e8903e3bb8e25f16ecfc436186c2d4aa7383302c73ad1dd8ac4fccaa589062bbce6059d6073f18
+)
+
+vcpkg_find_acquire_program(PERL)
+get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
+vcpkg_add_to_path("${PERL_EXE_PATH}")
+
+vcpkg_find_acquire_program(NASM)
+get_filename_component(NASM_EXE_PATH "${NASM}" DIRECTORY)
+vcpkg_add_to_path(PREPEND "${NASM_EXE_PATH}")
+
+vcpkg_find_acquire_program(JOM)
+
+set(OPENSSL_SHARED no-shared)
+if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
+    set(OPENSSL_SHARED shared)
+endif()
+
+# see ${SOURCE_PATH}/INSTALL.md
+list(APPEND CONFIGURE_OPTIONS
+    no-zlib
+    no-ui-console   # Don't build with the User Interface (UI) console method
+    no-makedepend   # Don't generate dependencies
+    no-module       # Don't build any dynamically loadable engines
+    no-tests        # Don't build test programs or run any tests
+    enable-legacy   # link statically legacy provider instead of generating legacy.dll
+    -utf-8
+    -FS
+    ${OPENSSL_SHARED}
+)
+
+set(CONFIGURE_COMMAND "${PERL}" Configure ${CONFIGURE_OPTIONS})
+
+if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
+    set(OPENSSL_ARCH VC-WIN32)
+elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+    set(OPENSSL_ARCH VC-WIN64A)
+elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
+    set(OPENSSL_ARCH VC-WIN32-ARM)
+elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
+    set(OPENSSL_ARCH VC-WIN64-ARM)
+else()
+    message(FATAL_ERROR "Unsupported target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
+endif()
+
+set(OPENSSL_MAKEFILE "makefile")
+
+file(REMOVE_RECURSE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
+                    "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
+
+if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
+
+    # Copy openssl sources.
+    message(STATUS "Copying openssl release source files...")
+    file(GLOB OPENSSL_SOURCE_FILES ${SOURCE_PATH}/*)
+    foreach(SOURCE_FILE ${OPENSSL_SOURCE_FILES})
+        file(COPY ${SOURCE_FILE} DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
+    endforeach()
+    message(STATUS "Copying openssl release source files... done")
+    set(SOURCE_PATH_RELEASE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
+
+    set(OPENSSLDIR_RELEASE ${CURRENT_PACKAGES_DIR})
+
+    message(STATUS "Configure ${TARGET_TRIPLET}-rel")
+    vcpkg_execute_required_process(
+        COMMAND ${CONFIGURE_COMMAND} ${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_RELEASE}" "--openssldir=${OPENSSLDIR_RELEASE}"
+        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
+        LOGNAME configure-perl-${TARGET_TRIPLET}-rel
+    )
+    message(STATUS "Configure ${TARGET_TRIPLET}-rel done")
+
+    message(STATUS "Build ${TARGET_TRIPLET}-rel")
+    # Openssl's buildsystem has a race condition which will cause JOM to fail at some point.
+    # This is ok; we just do as much work as we can in parallel first, then follow up with a single-threaded build.
+    execute_process(
+        COMMAND ${JOM} -k -j ${VCPKG_CONCURRENCY} -f ${OPENSSL_MAKEFILE}
+        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
+        OUTPUT_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-out.log
+        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-err.log
+    )
+    vcpkg_execute_required_process(
+        COMMAND nmake -f ${OPENSSL_MAKEFILE} install_dev install_runtime install_ssldirs
+        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
+        LOGNAME build-${TARGET_TRIPLET}-rel-1)
+
+    message(STATUS "Build ${TARGET_TRIPLET}-rel done")
+endif()
+
+if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
+    # Copy openssl sources.
+    message(STATUS "Copying openssl debug source files...")
+    file(GLOB OPENSSL_SOURCE_FILES ${SOURCE_PATH}/*)
+    foreach(SOURCE_FILE ${OPENSSL_SOURCE_FILES})
+        file(COPY ${SOURCE_FILE} DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
+    endforeach()
+    message(STATUS "Copying openssl debug source files... done")
+    set(SOURCE_PATH_DEBUG "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
+
+    set(OPENSSLDIR_DEBUG ${CURRENT_PACKAGES_DIR}/debug)
+
+    message(STATUS "Configure ${TARGET_TRIPLET}-dbg")
+    vcpkg_execute_required_process(
+        COMMAND ${CONFIGURE_COMMAND} debug-${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_DEBUG}" "--openssldir=${OPENSSLDIR_DEBUG}"
+        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
+        LOGNAME configure-perl-${TARGET_TRIPLET}-dbg
+    )
+    message(STATUS "Configure ${TARGET_TRIPLET}-dbg done")
+
+    message(STATUS "Build ${TARGET_TRIPLET}-dbg")
+    execute_process(
+        COMMAND "${JOM}" -k -j ${VCPKG_CONCURRENCY} -f "${OPENSSL_MAKEFILE}"
+        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
+        OUTPUT_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-out.log
+        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-err.log
+    )
+    vcpkg_execute_required_process(
+        COMMAND nmake -f "${OPENSSL_MAKEFILE}" install_dev install_runtime install_ssldirs
+        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
+        LOGNAME build-${TARGET_TRIPLET}-dbg-1)
+
+    message(STATUS "Build ${TARGET_TRIPLET}-dbg done")
+endif()
+
+file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/certs")
+file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/private")
+file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/certs")
+file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/private")
+file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
+
+file(REMOVE
+    "${CURRENT_PACKAGES_DIR}/ct_log_list.cnf"
+    "${CURRENT_PACKAGES_DIR}/ct_log_list.cnf.dist"
+    "${CURRENT_PACKAGES_DIR}/openssl.cnf.dist"
+    "${CURRENT_PACKAGES_DIR}/debug/bin/openssl.exe"
+    "${CURRENT_PACKAGES_DIR}/debug/ct_log_list.cnf"
+    "${CURRENT_PACKAGES_DIR}/debug/ct_log_list.cnf.dist"
+    "${CURRENT_PACKAGES_DIR}/debug/openssl.cnf"
+    "${CURRENT_PACKAGES_DIR}/debug/openssl.cnf.dist"
+)
+
+file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/openssl/")
+file(RENAME "${CURRENT_PACKAGES_DIR}/bin/openssl.exe" "${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.exe")
+file(RENAME "${CURRENT_PACKAGES_DIR}/openssl.cnf" "${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.cnf")
+
+vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/openssl")
+
+if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
+    # They should be empty, only the exes deleted above were in these directories
+    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin/")
+    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin/")
+endif()
+
+vcpkg_copy_pdbs()
+
+file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
+file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
diff --git a/contrib/vcpkg-ports/openssl3/usage b/contrib/vcpkg-ports/openssl3/usage
new file mode 100644
index 00000000..97e7760e
--- /dev/null
+++ b/contrib/vcpkg-ports/openssl3/usage
@@ -0,0 +1,4 @@
+The package openssl3 is compatible with built-in CMake targets:
+
+    find_package(OpenSSL REQUIRED)
+    target_link_libraries(main PRIVATE OpenSSL::SSL OpenSSL::Crypto)
diff --git a/contrib/vcpkg-ports/openssl3/vcpkg.json b/contrib/vcpkg-ports/openssl3/vcpkg.json
new file mode 100644
index 00000000..93db84b9
--- /dev/null
+++ b/contrib/vcpkg-ports/openssl3/vcpkg.json
@@ -0,0 +1,7 @@
+{
+  "name": "openssl3",
+  "version-semver": "3.0.1",
+  "description": "TLS/SSL and crypto library",
+  "homepage": "https://www.openssl.org/",
+  "license": "Apache-2.0"
+}
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 532aa69b..0723344e 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -23,7 +23,7 @@ vcpkg_build_nmake(
     PROJECT_NAME Makefile.w32-vc
     OPTIONS
         OPENSSL=1
-        OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
+        OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl3_${TARGET_TRIPLET}
 )
 
 file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
-- 
2.23.0.windows.1


