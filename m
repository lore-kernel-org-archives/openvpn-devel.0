From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Mar 2022 15:57:28 +0200
Message-Id: <20220317135728.183-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH release/2.5] vcpkg-ports: remove openssl port
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

We've added functionality to openvpn-build

  f83f21ef "windows-msi: add ability to specify port overlays in
  openvpn-build"

(which is used for release building) to use overlay ports, which
enables us to build releases with updated ports (like openssl)
without making changes to openvpn repo. This means that openssl port
overlay from this repo could be removed.

Developers can still use openvpn repo for Windows development and
use whatever openssl version is provided by vcpkg official repo. When
we need to build a release and the latest openssl is not there, we add
port overlay to openvpn-build.

While on it, bump vcpkg commit id in github actions.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml                  |   2 +-
 .../openssl/install-pc-files.cmake            |  32 ----
 contrib/vcpkg-ports/openssl/openssl.pc.in     |   6 -
 contrib/vcpkg-ports/openssl/portfile.cmake    |  28 ---
 contrib/vcpkg-ports/openssl/usage             |   4 -
 .../openssl/vcpkg-cmake-wrapper.cmake.in      |  78 --------
 contrib/vcpkg-ports/openssl/vcpkg.json        |  18 --
 .../openssl/windows/portfile.cmake            | 172 ------------------
 8 files changed, 1 insertion(+), 339 deletions(-)
 delete mode 100644 contrib/vcpkg-ports/openssl/install-pc-files.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/openssl.pc.in
 delete mode 100644 contrib/vcpkg-ports/openssl/portfile.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/usage
 delete mode 100644 contrib/vcpkg-ports/openssl/vcpkg-cmake-wrapper.cmake.in
 delete mode 100644 contrib/vcpkg-ports/openssl/vcpkg.json
 delete mode 100644 contrib/vcpkg-ports/openssl/windows/portfile.cmake

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 6f49350e..dbb05739 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -271,7 +271,7 @@ jobs:
       - name: Restore artifacts, or run vcpkg, build and cache artifacts
         uses: lukka/run-vcpkg@...2638...
         with:
-          vcpkgGitCommitId: 'a2fcb03749ff5897b5985092934dc6057680c789'
+          vcpkgGitCommitId: 'a69b65229b3956b7f45abd81671b7330114bcaad'
           vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
           vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
           cleanAfterBuild: false
diff --git a/contrib/vcpkg-ports/openssl/install-pc-files.cmake b/contrib/vcpkg-ports/openssl/install-pc-files.cmake
deleted file mode 100644
index eb8d2b8c..00000000
--- a/contrib/vcpkg-ports/openssl/install-pc-files.cmake
+++ /dev/null
@@ -1,32 +0,0 @@
-function(install_pc_file name pc_data)
-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
-        configure_file("${CMAKE_CURRENT_LIST_DIR}/openssl.pc.in" "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/${name}.pc" @ONLY)
-    endif()
-    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
-        configure_file("${CMAKE_CURRENT_LIST_DIR}/openssl.pc.in" "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/${name}.pc" @ONLY)
-    endif()
-endfunction()
-
-install_pc_file(openssl [[
-Name: OpenSSL
-Description: Secure Sockets Layer and cryptography libraries and tools
-Requires: libssl libcrypto
-]])
-
-install_pc_file(libssl [[
-Name: OpenSSL-libssl
-Description: Secure Sockets Layer and cryptography libraries
-Libs: -L"${libdir}" -llibssl
-Requires: libcrypto
-Cflags: -I"${includedir}"
-]])
-
-install_pc_file(libcrypto [[
-Name: OpenSSL-libcrypto
-Description: OpenSSL cryptography library
-Libs: -L"${libdir}" -llibcrypto
-Libs.private: -lcrypt32 -lws2_32
-Cflags: -I"${includedir}"
-]])
-
-vcpkg_fixup_pkgconfig()
diff --git a/contrib/vcpkg-ports/openssl/openssl.pc.in b/contrib/vcpkg-ports/openssl/openssl.pc.in
deleted file mode 100644
index 3033e180..00000000
--- a/contrib/vcpkg-ports/openssl/openssl.pc.in
+++ /dev/null
@@ -1,6 +0,0 @@
-prefix=${pcfiledir}/../..
-exec_prefix=${prefix}
-libdir=${exec_prefix}/lib
-includedir=${prefix}/include
-Version: @OPENSSL_VERSION@
-@...2665...@
diff --git a/contrib/vcpkg-ports/openssl/portfile.cmake b/contrib/vcpkg-ports/openssl/portfile.cmake
deleted file mode 100644
index e94e7a83..00000000
--- a/contrib/vcpkg-ports/openssl/portfile.cmake
+++ /dev/null
@@ -1,28 +0,0 @@
-if(EXISTS "${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h")
-    message(FATAL_ERROR "Can't build openssl if libressl/boringssl is installed. Please remove libressl/boringssl, and try install openssl again if you need it.")
-endif()
-
-set(OPENSSL_VERSION 1.1.1n)
-vcpkg_download_distfile(
-    ARCHIVE
-    URLS "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz" "https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz"
-    FILENAME "openssl-${OPENSSL_VERSION}.tar.gz"
-    SHA512 1937796736613dcf4105a54e42ecb61f95a1cea74677156f9459aea0f2c95159359e766089632bf364ee6b0d28d661eb9957bce8fecc9d2436378d8d79e8d0a4
-)
-
-vcpkg_find_acquire_program(PERL)
-get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
-vcpkg_add_to_path("${PERL_EXE_PATH}")
-
-if(VCPKG_TARGET_IS_UWP)
-    include("${CMAKE_CURRENT_LIST_DIR}/uwp/portfile.cmake")
-    include("${CMAKE_CURRENT_LIST_DIR}/install-pc-files.cmake")
-elseif(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
-    include("${CMAKE_CURRENT_LIST_DIR}/windows/portfile.cmake")
-    include("${CMAKE_CURRENT_LIST_DIR}/install-pc-files.cmake")
-else()
-    include("${CMAKE_CURRENT_LIST_DIR}/unix/portfile.cmake")
-endif()
-
-configure_file("${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake.in" "${CURRENT_PACKAGES_DIR}/share/${PORT}/vcpkg-cmake-wrapper.cmake" @ONLY)
-file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
diff --git a/contrib/vcpkg-ports/openssl/usage b/contrib/vcpkg-ports/openssl/usage
deleted file mode 100644
index cf83f339..00000000
--- a/contrib/vcpkg-ports/openssl/usage
+++ /dev/null
@@ -1,4 +0,0 @@
-The package openssl is compatible with built-in CMake targets:
-
-    find_package(OpenSSL REQUIRED)
-    target_link_libraries(main PRIVATE OpenSSL::SSL OpenSSL::Crypto)
diff --git a/contrib/vcpkg-ports/openssl/vcpkg-cmake-wrapper.cmake.in b/contrib/vcpkg-ports/openssl/vcpkg-cmake-wrapper.cmake.in
deleted file mode 100644
index 4a5ee893..00000000
--- a/contrib/vcpkg-ports/openssl/vcpkg-cmake-wrapper.cmake.in
+++ /dev/null
@@ -1,78 +0,0 @@
-cmake_policy(PUSH)
-cmake_policy(SET CMP0012 NEW)
-cmake_policy(SET CMP0054 NEW)
-cmake_policy(SET CMP0057 NEW)
-
-if(OPENSSL_USE_STATIC_LIBS)
-    if("@VCPKG_LIBRARY_LINKAGE@" STREQUAL "dynamic")
-        message(WARNING "OPENSSL_USE_STATIC_LIBS is set, but vcpkg port openssl was built with dynamic linkage")
-    endif()
-    set(OPENSSL_USE_STATIC_LIBS_BAK "${OPENSSL_USE_STATIC_LIBS}")
-    set(OPENSSL_USE_STATIC_LIBS FALSE)
-endif()
-
-if(DEFINED OPENSSL_ROOT_DIR)
-    set(OPENSSL_ROOT_DIR_BAK "${OPENSSL_ROOT_DIR}")
-endif()
-get_filename_component(OPENSSL_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}" DIRECTORY)
-get_filename_component(OPENSSL_ROOT_DIR "${OPENSSL_ROOT_DIR}" DIRECTORY)
-find_path(OPENSSL_INCLUDE_DIR NAMES openssl/ssl.h PATH "${OPENSSL_ROOT_DIR}/include" NO_DEFAULT_PATH)
-if(MSVC)
-    find_library(LIB_EAY_DEBUG NAMES libcrypto PATHS "${OPENSSL_ROOT_DIR}/debug/lib" NO_DEFAULT_PATH)
-    find_library(LIB_EAY_RELEASE NAMES libcrypto PATHS "${OPENSSL_ROOT_DIR}/lib" NO_DEFAULT_PATH)
-    find_library(SSL_EAY_DEBUG NAMES libssl PATHS "${OPENSSL_ROOT_DIR}/debug/lib" NO_DEFAULT_PATH)
-    find_library(SSL_EAY_RELEASE NAMES libssl PATHS "${OPENSSL_ROOT_DIR}/lib" NO_DEFAULT_PATH)
-elseif(WIN32)
-    find_library(LIB_EAY NAMES libcrypto crypto NAMES_PER_DIR)
-    find_library(SSL_EAY NAMES libssl ssl NAMES_PER_DIR)
-else()
-    find_library(OPENSSL_CRYPTO_LIBRARY NAMES crypto)
-    find_library(OPENSSL_SSL_LIBRARY NAMES ssl)
-endif()
-
-_find_package(${ARGS})
-
-unset(OPENSSL_ROOT_DIR)
-if(DEFINED OPENSSL_ROOT_DIR_BAK)
-    set(OPENSSL_ROOT_DIR "${OPENSSL_ROOT_DIR_BAK}")
-    unset(OPENSSL_ROOT_DIR_BAK)
-endif()
-
-if(DEFINED OPENSSL_USE_STATIC_LIBS_BAK)
-    set(OPENSSL_USE_STATIC_LIBS "${OPENSSL_USE_STATIC_LIBS_BAK}")
-    unset(OPENSSL_USE_STATIC_LIBS_BAK)
-endif()
-
-if(OPENSSL_FOUND AND "@VCPKG_LIBRARY_LINKAGE@" STREQUAL "static")
-    if(WIN32)
-        list(APPEND OPENSSL_LIBRARIES crypt32 ws2_32)
-        if(TARGET OpenSSL::Crypto)
-            set_property(TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES "crypt32;ws2_32")
-        endif()
-        if(TARGET OpenSSL::SSL)
-            set_property(TARGET OpenSSL::SSL APPEND PROPERTY INTERFACE_LINK_LIBRARIES "crypt32;ws2_32")
-        endif()
-    else()
-        find_library(OPENSSL_DL_LIBRARY NAMES dl)
-        if(OPENSSL_DL_LIBRARY)
-            list(APPEND OPENSSL_LIBRARIES "dl")
-            if(TARGET OpenSSL::Crypto)
-                set_property(TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES "dl")
-            endif()
-        endif()
-
-        if("REQUIRED" IN_LIST ARGS)
-           find_package(Threads REQUIRED)
-        else()
-           find_package(Threads)
-        endif()
-        list(APPEND OPENSSL_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})
-        if(TARGET OpenSSL::Crypto)
-            set_property(TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES "Threads::Threads")
-        endif()
-        if(TARGET OpenSSL::SSL)
-            set_property(TARGET OpenSSL::SSL APPEND PROPERTY INTERFACE_LINK_LIBRARIES "Threads::Threads")
-        endif()
-    endif()
-endif()
-cmake_policy(POP)
diff --git a/contrib/vcpkg-ports/openssl/vcpkg.json b/contrib/vcpkg-ports/openssl/vcpkg.json
deleted file mode 100644
index 18e6dde6..00000000
--- a/contrib/vcpkg-ports/openssl/vcpkg.json
+++ /dev/null
@@ -1,18 +0,0 @@
-{
-  "name": "openssl",
-  "version-string": "1.1.1n",
-  "port-version": 2,
-  "description": "OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library.",
-  "homepage": "https://www.openssl.org",
-  "license": "OpenSSL",
-  "dependencies": [
-    {
-      "name": "vcpkg-cmake",
-      "host": true
-    },
-    {
-      "name": "vcpkg-cmake-config",
-      "host": true
-    }
-  ]
-}
diff --git a/contrib/vcpkg-ports/openssl/windows/portfile.cmake b/contrib/vcpkg-ports/openssl/windows/portfile.cmake
deleted file mode 100644
index e4469ef3..00000000
--- a/contrib/vcpkg-ports/openssl/windows/portfile.cmake
+++ /dev/null
@@ -1,172 +0,0 @@
-vcpkg_extract_source_archive_ex(
-    OUT_SOURCE_PATH SOURCE_PATH
-    ARCHIVE ${ARCHIVE}
-)
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
-set(CONFIGURE_OPTIONS
-    enable-static-engine
-    enable-capieng
-    no-ssl2
-    no-tests
-    -utf-8
-    ${OPENSSL_SHARED}
-)
-
-if(DEFINED OPENSSL_USE_NOPINSHARED)
-    set(CONFIGURE_OPTIONS ${CONFIGURE_OPTIONS} no-pinshared)
-endif()
-
-if(OPENSSL_NO_AUTOLOAD_CONFIG)
-    set(CONFIGURE_OPTIONS ${CONFIGURE_OPTIONS} no-autoload-config)
-endif()
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
-        COMMAND ${CONFIGURE_COMMAND} ${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_RELEASE}" "--openssldir=${OPENSSLDIR_RELEASE}" -FS
-        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
-        LOGNAME configure-perl-${TARGET_TRIPLET}-rel
-    )
-    message(STATUS "Configure ${TARGET_TRIPLET}-rel done")
-
-    message(STATUS "Build ${TARGET_TRIPLET}-rel")
-    # Openssl's buildsystem has a race condition which will cause JOM to fail at some point.
-    # This is ok; we just do as much work as we can in parallel first, then follow up with a single-threaded build.
-    make_directory(${SOURCE_PATH_RELEASE}/inc32/openssl)
-    execute_process(
-        COMMAND ${JOM} -k -j $ENV{NUMBER_OF_PROCESSORS} -f ${OPENSSL_MAKEFILE}
-        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
-        OUTPUT_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-out.log
-        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-err.log
-    )
-    vcpkg_execute_required_process(
-        COMMAND nmake -f ${OPENSSL_MAKEFILE} install_sw install_ssldirs
-        WORKING_DIRECTORY ${SOURCE_PATH_RELEASE}
-        LOGNAME build-${TARGET_TRIPLET}-rel-1)
-
-    message(STATUS "Build ${TARGET_TRIPLET}-rel done")
-endif()
-
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
-        COMMAND ${CONFIGURE_COMMAND} debug-${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_DEBUG}" "--openssldir=${OPENSSLDIR_DEBUG}" -FS
-        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
-        LOGNAME configure-perl-${TARGET_TRIPLET}-dbg
-    )
-    message(STATUS "Configure ${TARGET_TRIPLET}-dbg done")
-
-    message(STATUS "Build ${TARGET_TRIPLET}-dbg")
-    make_directory(${SOURCE_PATH_DEBUG}/inc32/openssl)
-    execute_process(
-        COMMAND "${JOM}" -k -j ${VCPKG_CONCURRENCY} -f "${OPENSSL_MAKEFILE}"
-        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
-        OUTPUT_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-out.log
-        ERROR_FILE ${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-err.log
-    )
-    vcpkg_execute_required_process(
-        COMMAND nmake -f "${OPENSSL_MAKEFILE}" install_sw install_ssldirs
-        WORKING_DIRECTORY ${SOURCE_PATH_DEBUG}
-        LOGNAME build-${TARGET_TRIPLET}-dbg-1)
-
-    message(STATUS "Build ${TARGET_TRIPLET}-dbg done")
-endif()
-
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/certs")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/private")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/engines-1_1")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/certs")
-file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/engines-1_1")
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
-vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/openssl/dtls1.h"
-    "<winsock.h>"
-    "<winsock2.h>"
-)
-
-vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/openssl/rand.h"
-    "#  include <windows.h>"
-    "#ifndef _WINSOCKAPI_\n#define _WINSOCKAPI_\n#endif\n#  include <windows.h>"
-)
-
-vcpkg_copy_pdbs()
-
-file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
-- 
2.23.0.windows.1


