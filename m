From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 20 Jan 2022 23:22:43 +0200
Message-Id: <20220120212243.306-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] msvc: switch to openssl3
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

 - add openssl3 port from https://github.com/microsoft/vcpkg/pull/20428/files
with small changes:

--- portfile.cmake.orig 2022-01-24 11:04:44.914467900 +0200
+++ portfile.cmake      2022-01-24 11:02:46.066088800 +0200
@@ -5,8 +5,8 @@
 vcpkg_from_github(
     OUT_SOURCE_PATH SOURCE_PATH
     REPO openssl/openssl
-    REF openssl-3.0.0
-    SHA512
50b4fefa3e5a3359e7b06bfbc4ecc525ef9d76e13d087aa8e2d29880f08f74cc9d0c76b9bf1895c118def2bb0e4db0095e799a752b64b60721a423bd2cf989da
+    REF openssl-3.0.1
+    SHA512
7f303769a3a796b88478399d42aa2a9a70dc74f62c975bbb93e8903e3bb8e25f16ecfc436186c2d4aa7383302c73ad1dd8ac4fccaa589062bbce6059d6073f18
 )

 if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
@@ -114,13 +114,13 @@
 if(VCPKG_TARGET_IS_UWP OR VCPKG_TARGET_IS_WINDOWS)
     message(STATUS "Building ${TARGET_TRIPLET}-dbg")
     vcpkg_execute_required_process(
-        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
install_dev
+        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
install_dev install_runtime
         WORKING_DIRECTORY
"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
         LOGNAME install-${TARGET_TRIPLET}-dbg
     )
     message(STATUS "Building ${TARGET_TRIPLET}-rel")
     vcpkg_execute_required_process(
-        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
install_dev
+        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
install_dev install_runtime
         WORKING_DIRECTORY
"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
         LOGNAME install-${TARGET_TRIPLET}-rel
     )
@@ -129,13 +129,13 @@
 else()
     message(STATUS "Building ${TARGET_TRIPLET}-dbg")
     vcpkg_execute_required_process(
-        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
+        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
install_runtime
         WORKING_DIRECTORY
"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
         LOGNAME install-${TARGET_TRIPLET}-dbg
     )
     message(STATUS "Building ${TARGET_TRIPLET}-rel")
     vcpkg_execute_required_process(
-        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
+        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
install_runtime
         WORKING_DIRECTORY
"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
         LOGNAME install-${TARGET_TRIPLET}-rel
     )
@@ -161,6 +161,17 @@

 endif()

+if(VCPKG_TARGET_IS_WINDOWS)
+    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/openssl/")
+    file(RENAME "${CURRENT_PACKAGES_DIR}/bin/openssl.exe"
"${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.exe")
+
+    file(REMOVE
+        "${CURRENT_PACKAGES_DIR}/debug/bin/openssl.exe"
+    )
+endif()
+
+vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/openssl")
+
 if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
     file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/libcrypto.a"
                 "${CURRENT_PACKAGES_DIR}/debug/lib/libssl.a"
@@ -184,4 +195,4 @@
 )
 file(INSTALL     "${CURRENT_PORT_DIR}/usage"
      DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
-)
\ No newline at end of file
+)

 - use sizeof(void *) since msvc doesn't support sizeof of function ptr

 - use XKEY_PROV_PROPS macro instead of props since msvc
  requires constant expression in aggregate initializers

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml                  |   2 +-
 .../openssl3/detect_platform.cmake            |  86 ++++++++
 contrib/vcpkg-ports/openssl3/portfile.cmake   | 198 ++++++++++++++++++
 contrib/vcpkg-ports/openssl3/usage            |  11 +
 contrib/vcpkg-ports/openssl3/vcpkg.json       |   7 +
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   2 +-
 src/openvpn/xkey_helper.c                     |   4 +-
 src/openvpn/xkey_provider.c                   |  13 +-
 8 files changed, 311 insertions(+), 12 deletions(-)
 create mode 100644 contrib/vcpkg-ports/openssl3/detect_platform.cmake
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
 
diff --git a/contrib/vcpkg-ports/openssl3/detect_platform.cmake b/contrib/vcpkg-ports/openssl3/detect_platform.cmake
new file mode 100644
index 00000000..5f67f8d5
--- /dev/null
+++ b/contrib/vcpkg-ports/openssl3/detect_platform.cmake
@@ -0,0 +1,86 @@
+if(VCPKG_TARGET_IS_ANDROID)
+    # ${SOURCE_PATH}/Configuration/15-android.conf
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
+        set(PLATFORM "android-arm64")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
+        set(PLATFORM "android-arm")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "android-x86_64")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
+        set(PLATFORM "android-x86")
+    endif()
+
+elseif(VCPKG_TARGET_IS_LINUX)
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
+        set(PLATFORM "linux-aarch64")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
+        set(PLATFORM "linux-armv4")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "linux-x86_64")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
+        set(PLATFORM "linux-x86")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "ppc64le")
+        set(PLATFORM "linux-ppc64le")
+    endif()
+
+elseif(VCPKG_TARGET_IS_IOS)
+    # ${SOURCE_PATH}/Configuration/15-ios.conf
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
+        set(PLATFORM "ios64-xcrun")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
+        set(PLATFORM "ios-xcrun")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86" OR
+           VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "iossimulator-xcrun")
+    endif()
+
+elseif(VCPKG_TARGET_IS_OSX)
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
+        set(PLATFORM "darwin64-arm64-cc")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "darwin64-x86_64-cc")
+    endif()
+
+elseif(VCPKG_TARGET_IS_FREEBSD OR VCPKG_TARGET_IS_OPENBSD)
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "BSD-x86_64")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
+        set(PLATFORM "BSD-x86")
+    endif()
+
+elseif(VCPKG_TARGET_IS_MINGW)
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "mingw64")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
+        set(PLATFORM "mingw")
+    endif()
+
+elseif(VCPKG_TARGET_IS_UWP)
+    # ${SOURCE_PATH}/Configuration/50-win-onecore.conf
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
+        set(PLATFORM "VC-WIN32-UWP")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "VC-WIN64A-UWP")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
+        set(PLATFORM "VC-WIN32-ARM-UWP")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
+        set(PLATFORM "VC-WIN64-ARM-UWP")
+    endif()
+
+elseif(VCPKG_TARGET_IS_WINDOWS)
+    # ${SOURCE_PATH}/Configuration/50-win-onecore.conf
+    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
+        set(PLATFORM "VC-WIN32")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
+        set(PLATFORM "VC-WIN64A")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
+        set(PLATFORM "VC-WIN32-ARM")
+    elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
+        set(PLATFORM "VC-WIN64-ARM")
+    endif()
+
+endif()
+
+if(NOT DEFINED PLATFORM)
+    message(FATAL_ERROR "PLATFORM is unknown for the target platform/architecture")
+endif()
diff --git a/contrib/vcpkg-ports/openssl3/portfile.cmake b/contrib/vcpkg-ports/openssl3/portfile.cmake
new file mode 100644
index 00000000..90a920f9
--- /dev/null
+++ b/contrib/vcpkg-ports/openssl3/portfile.cmake
@@ -0,0 +1,198 @@
+if(EXISTS ${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h)
+    message(FATAL_ERROR "Can't build '${PORT}' if another SSL library is installed. Please remove existing one and try install '${PORT}' again if you need it.")
+endif()
+
+vcpkg_from_github(
+    OUT_SOURCE_PATH SOURCE_PATH
+    REPO openssl/openssl
+    REF openssl-3.0.1
+    SHA512 7f303769a3a796b88478399d42aa2a9a70dc74f62c975bbb93e8903e3bb8e25f16ecfc436186c2d4aa7383302c73ad1dd8ac4fccaa589062bbce6059d6073f18
+)
+
+if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
+    list(APPEND CONFIGURE_OPTIONS shared)
+else()
+    list(APPEND CONFIGURE_OPTIONS no-shared)
+endif()
+
+# see ${SOURCE_PATH}/INSTALL.md
+list(APPEND CONFIGURE_OPTIONS
+    no-zlib
+    no-ui-console   # Don't build with the User Interface (UI) console method
+    no-module       # Don't build any dynamically loadable engines
+    no-makedepend   # Don't generate dependencies
+    no-tests        # Don't build test programs or run any tests
+)
+if(VCPKG_TARGET_IS_UWP)
+    list(APPEND CONFIGURE_OPTIONS no-async)
+endif()
+if(VCPKG_TARGET_IS_WINDOWS)
+    # jom will build in parallel mode, we need /FS for PDB access
+    list(APPEND CONFIGURE_OPTIONS -utf-8 -FS)
+
+elseif(VCPKG_TARGET_IS_IOS)
+    # see https://github.com/microsoft/vcpkg PR 12527
+    # disable that makes linkage error (e.g. require stderr usage)
+    list(APPEND CONFIGURE_OPTIONS no-stdio no-ui no-asm)
+
+endif()
+
+# Option: platform/architecture. Defined a variable 'PLATFORM'
+include(${CMAKE_CURRENT_LIST_DIR}/detect_platform.cmake)
+
+# Clean & copy source files for working directories
+file(REMOVE_RECURSE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
+                    "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
+)
+get_filename_component(SOURCE_DIR_NAME "${SOURCE_PATH}" NAME)
+file(COPY        "${SOURCE_PATH}"
+     DESTINATION "${CURRENT_BUILDTREES_DIR}")
+file(RENAME      "${CURRENT_BUILDTREES_DIR}/${SOURCE_DIR_NAME}"
+                 "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
+file(COPY        "${SOURCE_PATH}"
+     DESTINATION "${CURRENT_BUILDTREES_DIR}")
+file(RENAME      "${CURRENT_BUILDTREES_DIR}/${SOURCE_DIR_NAME}"
+                 "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
+
+# see ${SOURCE_PATH}/NOTES-PERL.md
+vcpkg_find_acquire_program(PERL)
+get_filename_component(PERL_EXE_PATH "${PERL}" PATH)
+vcpkg_add_to_path("${PERL_EXE_PATH}")
+
+if(NOT VCPKG_HOST_IS_WINDOWS)
+    # see ${SOURCE_PATH}/NOTES-UNIX.md
+    find_program(MAKE make REQUIRED)
+endif()
+
+if(VCPKG_TARGET_IS_WINDOWS)
+    # see ${SOURCE_PATH}/NOTES-WINDOWS.md
+    vcpkg_find_acquire_program(NASM)
+    get_filename_component(NASM_EXE_PATH "${NASM}" PATH)
+    vcpkg_add_to_path(PREPEND "${NASM_EXE_PATH}")
+    # note: jom is not for `vcpkg_add_to_path`
+    vcpkg_find_acquire_program(JOM)
+
+elseif(VCPKG_TARGET_IS_ANDROID)
+    # see ${SOURCE_PATH}/NOTES-ANDROID.md
+    if(NOT DEFINED ENV{ANDROID_NDK_ROOT} AND DEFINED ENV{ANDROID_NDK_HOME})
+        set(ENV{ANDROID_NDK_ROOT} $ENV{ANDROID_NDK_HOME})
+    endif()
+    if(NOT DEFINED ENV{ANDROID_NDK_ROOT})
+        message(FATAL_ERROR "ENV{ANDROID_NDK_ROOT} is required by ${SOURCE_PATH}/Configurations/15-android.conf")
+    endif()
+    if(VCPKG_HOST_IS_LINUX)
+        set(NDK_HOST_TAG "linux-x86_64")
+    elseif(VCPKG_HOST_IS_OSX)
+        set(NDK_HOST_TAG "darwin-x86_64")
+    elseif(VCPKG_HOST_IS_WINDOWS)
+        set(NDK_HOST_TAG "windows-x86_64")
+    else()
+        message(FATAL_ERROR "Unknown NDK host platform")
+    endif()
+    get_filename_component(NDK_TOOL_PATH "$ENV{ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/${NDK_HOST_TAG}/bin" ABSOLUTE)
+    vcpkg_add_to_path(PREPEND "${NDK_TOOL_PATH}")
+
+endif()
+
+# Configure / Install
+# note: we need a PERL so can't use `vcpkg_configure_make` directly...
+message(STATUS "Configuring ${TARGET_TRIPLET}-dbg")
+vcpkg_execute_required_process(
+    COMMAND ${PERL} Configure ${OPENSSL_SHARED} ${CONFIGURE_OPTIONS}
+                ${PLATFORM} "--prefix=${CURRENT_PACKAGES_DIR}/debug"
+    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
+    LOGNAME configure-perl-${TARGET_TRIPLET}-dbg
+)
+message(STATUS "Configuring ${TARGET_TRIPLET}-rel")
+vcpkg_execute_required_process(
+    COMMAND ${PERL} Configure ${OPENSSL_SHARED} ${CONFIGURE_OPTIONS}
+                ${PLATFORM} "--prefix=${CURRENT_PACKAGES_DIR}"
+    WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
+    LOGNAME configure-perl-${TARGET_TRIPLET}-rel
+)
+
+if(VCPKG_TARGET_IS_UWP OR VCPKG_TARGET_IS_WINDOWS)
+    message(STATUS "Building ${TARGET_TRIPLET}-dbg")
+    vcpkg_execute_required_process(
+        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile install_dev install_runtime
+        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
+        LOGNAME install-${TARGET_TRIPLET}-dbg
+    )
+    message(STATUS "Building ${TARGET_TRIPLET}-rel")
+    vcpkg_execute_required_process(
+        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile install_dev install_runtime
+        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
+        LOGNAME install-${TARGET_TRIPLET}-rel
+    )
+    vcpkg_copy_pdbs()
+
+else()
+    message(STATUS "Building ${TARGET_TRIPLET}-dbg")
+    vcpkg_execute_required_process(
+        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev install_runtime
+        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
+        LOGNAME install-${TARGET_TRIPLET}-dbg
+    )
+    message(STATUS "Building ${TARGET_TRIPLET}-rel")
+    vcpkg_execute_required_process(
+        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev install_runtime
+        WORKING_DIRECTORY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
+        LOGNAME install-${TARGET_TRIPLET}-rel
+    )
+    if(VCPKG_TARGET_IS_ANDROID AND VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
+        # install_dev copies symbolic link. overwrite them with the actual shared objects
+        file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/libcrypto.so"
+                     "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/libssl.so"
+             DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib"
+        )
+        file(INSTALL "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/libcrypto.so"
+                     "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/libssl.so"
+             DESTINATION "${CURRENT_PACKAGES_DIR}/lib"
+        )
+    endif()
+    # rename lib64 to lib for lib/pkgconfig
+    if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib64")
+        file(RENAME "${CURRENT_PACKAGES_DIR}/debug/lib64" "${CURRENT_PACKAGES_DIR}/debug/lib")
+    endif()
+    if(EXISTS "${CURRENT_PACKAGES_DIR}/lib64")
+        file(RENAME "${CURRENT_PACKAGES_DIR}/lib64" "${CURRENT_PACKAGES_DIR}/lib")
+    endif()
+    vcpkg_fixup_pkgconfig()
+
+endif()
+
+if(VCPKG_TARGET_IS_WINDOWS)
+    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/openssl/")
+    file(RENAME "${CURRENT_PACKAGES_DIR}/bin/openssl.exe" "${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.exe")
+
+    file(REMOVE
+        "${CURRENT_PACKAGES_DIR}/debug/bin/openssl.exe"
+    )
+endif()
+
+vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/openssl")
+
+if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
+    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/libcrypto.a"
+                "${CURRENT_PACKAGES_DIR}/debug/lib/libssl.a"
+                "${CURRENT_PACKAGES_DIR}/lib/libcrypto.a"
+                "${CURRENT_PACKAGES_DIR}/lib/libssl.a"
+    )
+else()
+    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin"
+                        "${CURRENT_PACKAGES_DIR}/bin"
+    )
+    if(VCPKG_TARGET_IS_WINDOWS)
+        file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/ossl_static.pdb"
+                    "${CURRENT_PACKAGES_DIR}/lib/ossl_static.pdb"
+        )
+    endif()
+endif()
+file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
+
+file(INSTALL     "${SOURCE_PATH}/LICENSE.txt"
+     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME "copyright"
+)
+file(INSTALL     "${CURRENT_PORT_DIR}/usage"
+     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
+)
diff --git a/contrib/vcpkg-ports/openssl3/usage b/contrib/vcpkg-ports/openssl3/usage
new file mode 100644
index 00000000..1f4298f7
--- /dev/null
+++ b/contrib/vcpkg-ports/openssl3/usage
@@ -0,0 +1,11 @@
+The package openssl3 can be imported via CMake FindOpenSSL module:
+
+    find_package(OpenSSL REQUIRED)
+    target_link_libraries(main PRIVATE OpenSSL::SSL OpenSSL::Crypto)
+
+Also, FindPkgConfig module can be used if pkg-config(.pc) files are installed:
+
+    find_package(PkgConfig REQUIRED)
+    pkg_check_modules(openssl REQUIRED IMPORTED_TARGET GLOBAL openssl>=3.0)
+    
+    target_link_libraries(main PRIVATE PkgConfig::openssl)
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
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index c667f7be..50231335 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -125,8 +125,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
         {"xkey-origin", OSSL_PARAM_UTF8_STRING, (char *) origin, 0, 0},
         {"pubkey", OSSL_PARAM_OCTET_STRING, &pubkey, sizeof(pubkey), 0},
         {"handle", OSSL_PARAM_OCTET_PTR, &handle, sizeof(handle), 0},
-        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(sign_op), 0},
-        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(free_op), 0},
+        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(void *), 0},
+        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(void *), 0},
         {NULL, 0, NULL, 0, 0}};
 
     /* Do not use EVP_PKEY_new_from_pkey as that will take keymgmt from pubkey */
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index c2d560c5..115b9931 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -44,9 +44,6 @@
 #include <openssl/evp.h>
 #include <openssl/err.h>
 
-/* propq set all on all ops we implement */
-static const char *const props = XKEY_PROV_PROPS;
-
 /* A descriptive name */
 static const char *provname = "OpenVPN External Key Provider";
 
@@ -592,9 +589,9 @@ static const OSSL_DISPATCH ec_keymgmt_functions[] = {
 };
 
 const OSSL_ALGORITHM keymgmts[] = {
-    {"RSA:rsaEncryption", props, rsa_keymgmt_functions, "OpenVPN xkey RSA Key Manager"},
-    {"RSA-PSS:RSASSA-PSS", props, rsa_keymgmt_functions, "OpenVPN xkey RSA-PSS Key Manager"},
-    {"EC:id-ecPublicKey", props, ec_keymgmt_functions, "OpenVPN xkey EC Key Manager"},
+    {"RSA:rsaEncryption", XKEY_PROV_PROPS, rsa_keymgmt_functions, "OpenVPN xkey RSA Key Manager"},
+    {"RSA-PSS:RSASSA-PSS", XKEY_PROV_PROPS, rsa_keymgmt_functions, "OpenVPN xkey RSA-PSS Key Manager"},
+    {"EC:id-ecPublicKey", XKEY_PROV_PROPS, ec_keymgmt_functions, "OpenVPN xkey EC Key Manager"},
     {NULL, NULL, NULL, NULL}
 };
 
@@ -1074,8 +1071,8 @@ static const OSSL_DISPATCH signature_functions[] = {
 };
 
 const OSSL_ALGORITHM signatures[] = {
-    {"RSA:rsaEncryption", props, signature_functions, "OpenVPN xkey RSA Signature"},
-    {"ECDSA", props, signature_functions, "OpenVPN xkey ECDSA Signature"},
+    {"RSA:rsaEncryption", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey RSA Signature"},
+    {"ECDSA", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey ECDSA Signature"},
     {NULL, NULL, NULL, NULL}
 };
 
-- 
2.23.0.windows.1


