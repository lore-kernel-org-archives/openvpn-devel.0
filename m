From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 21 Jan 2022 07:22:59 +0200
Message-Id: <20220121052259.508-3-lstipakov@...277...>
In-Reply-To: <20220121052259.508-1-lstipakov@...277...>
References: <20220121052259.508-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] msvc: switch to openssl3
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

Add openssl3 vcpkg port from https://github.com/microsoft/vcpkg/pull/20428/files
with some changes:

 - switch to openssl 3.0.1
 - add install_runtime make target to build openssl.exe
 - create tools/openssl and copy there openssl.exe with dependency dlls

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml                  |   2 +-
 .../openssl3/detect_platform.cmake            |  86 ++++++++
 contrib/vcpkg-ports/openssl3/portfile.cmake   | 204 ++++++++++++++++++
 contrib/vcpkg-ports/openssl3/usage            |  11 +
 contrib/vcpkg-ports/openssl3/vcpkg.json       |   7 +
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   2 +-
 6 files changed, 310 insertions(+), 2 deletions(-)
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
index 00000000..25d6cdf0
--- /dev/null
+++ b/contrib/vcpkg-ports/openssl3/portfile.cmake
@@ -0,0 +1,204 @@
+# original version could be found at https://raw.githubusercontent.com/luncliff/vcpkg/2ab7467c8bacaf640cfc8e4fa7f3fdf16de1945d/ports/openssl/portfile.cmake
+# following changes are made:
+# - switch to openssl 3.0.1
+# - add install_runtime make target to build openssl.exe
+# - create tools/openssl and copy there openssl.exe with dependency dlls
+
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
-- 
2.23.0.windows.1


