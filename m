From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 28 Jun 2021 11:08:32 +0300
Message-Id: <20210628080832.510-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] contrib/vcpkg-ports: remove openssl port
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

MSFT has merged PR to vcpkg which
added OPENSSL_NO_AUTOLOAD_CONFIG option

  https://github.com/microsoft/vcpkg/pull/18389

This means that we don't need to have our own openssl port
and instead we just add

  set(OPENSSL_NO_AUTOLOAD_CONFIG ON)

to our custom triplets.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml                  |   2 +-
 contrib/vcpkg-ports/openssl/portfile.cmake    |  25 --
 .../vcpkg-ports/openssl/unix/CMakeLists.txt   | 280 ------------------
 .../vcpkg-ports/openssl/unix/portfile.cmake   |  49 ---
 .../openssl/unix/remove-deps.cmake            |   7 -
 .../openssl/unix/vcpkg-cmake-wrapper.cmake    |  18 --
 contrib/vcpkg-ports/openssl/usage             |   4 -
 .../openssl/uwp/EnableUWPSupport.patch        | 170 -----------
 .../vcpkg-ports/openssl/uwp/make-openssl.bat  |  16 -
 .../vcpkg-ports/openssl/uwp/portfile.cmake    | 156 ----------
 contrib/vcpkg-ports/openssl/vcpkg.json        |   7 -
 .../openssl/windows/portfile.cmake            | 174 -----------
 .../openssl/windows/vcpkg-cmake-wrapper.cmake |  10 -
 .../vcpkg-triplets/arm64-windows-ovpn.cmake   |   2 +
 contrib/vcpkg-triplets/x64-windows-ovpn.cmake |   2 +
 contrib/vcpkg-triplets/x86-windows-ovpn.cmake |   2 +
 16 files changed, 7 insertions(+), 917 deletions(-)
 delete mode 100644 contrib/vcpkg-ports/openssl/portfile.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/unix/CMakeLists.txt
 delete mode 100644 contrib/vcpkg-ports/openssl/unix/portfile.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/unix/remove-deps.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/unix/vcpkg-cmake-wrapper.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/usage
 delete mode 100644 contrib/vcpkg-ports/openssl/uwp/EnableUWPSupport.patch
 delete mode 100644 contrib/vcpkg-ports/openssl/uwp/make-openssl.bat
 delete mode 100644 contrib/vcpkg-ports/openssl/uwp/portfile.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/vcpkg.json
 delete mode 100644 contrib/vcpkg-ports/openssl/windows/portfile.cmake
 delete mode 100644 contrib/vcpkg-ports/openssl/windows/vcpkg-cmake-wrapper.cmake

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5d7dd37b..64044da9 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -211,7 +211,7 @@ jobs:
         with:
           vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
           vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
-          vcpkgGitCommitId: '7d472dd25830da92108eb76642c667aaa40512cb'
+          vcpkgGitCommitId: 'b361c2eefa3966cb7cec45275aff32e90430aaa6'
           cleanAfterBuild: false
 
       - name: Build
diff --git a/contrib/vcpkg-ports/openssl/portfile.cmake b/contrib/vcpkg-ports/openssl/portfile.cmake
deleted file mode 100644
index 9b59a3c8..00000000
--- a/contrib/vcpkg-ports/openssl/portfile.cmake
+++ /dev/null
@@ -1,25 +0,0 @@
-if(EXISTS "${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h")
-  message(FATAL_ERROR "Can't build openssl if libressl/boringssl is installed. Please remove libressl/boringssl, and try install openssl again if you need it.")
-endif()
-
-set(OPENSSL_VERSION 1.1.1k)
-vcpkg_download_distfile(ARCHIVE
-    URLS "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz" "https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz"
-    FILENAME "openssl-${OPENSSL_VERSION}.tar.gz"
-    SHA512 73cd042d4056585e5a9dd7ab68e7c7310a3a4c783eafa07ab0b560e7462b924e4376436a6d38a155c687f6942a881cfc0c1b9394afcde1d8c46bf396e7d51121
-)
-
-vcpkg_find_acquire_program(PERL)
-get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
-vcpkg_add_to_path("${PERL_EXE_PATH}")
-
-if(VCPKG_TARGET_IS_UWP)
-    include("${CMAKE_CURRENT_LIST_DIR}/uwp/portfile.cmake")
-elseif(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
-    include("${CMAKE_CURRENT_LIST_DIR}/windows/portfile.cmake")
-else()
-    include("${CMAKE_CURRENT_LIST_DIR}/unix/portfile.cmake")
-endif()
-
-
-file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
diff --git a/contrib/vcpkg-ports/openssl/unix/CMakeLists.txt b/contrib/vcpkg-ports/openssl/unix/CMakeLists.txt
deleted file mode 100644
index fd848169..00000000
--- a/contrib/vcpkg-ports/openssl/unix/CMakeLists.txt
+++ /dev/null
@@ -1,280 +0,0 @@
-cmake_minimum_required(VERSION 3.9)
-project(openssl C)
-
-if(NOT SOURCE_PATH)
-    message(FATAL_ERROR "Requires SOURCE_PATH")
-endif()
-
-if(CMAKE_SYSTEM_NAME STREQUAL "Android" OR CMAKE_SYSTEM_NAME STREQUAL "Linux")
-    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
-        set(PLATFORM linux-x86_64)
-    else()
-        set(PLATFORM linux-generic32)
-    endif()
-elseif(CMAKE_SYSTEM_NAME STREQUAL "iOS")
-    if(VCPKG_TARGET_ARCHITECTURE MATCHES "arm64")
-        set(PLATFORM ios64-xcrun)
-    elseif(VCPKG_TARGET_ARCHITECTURE MATCHES "arm")
-        set(PLATFORM ios-xcrun)
-    elseif(VCPKG_TARGET_ARCHITECTURE MATCHES "x86" OR
-           VCPKG_TARGET_ARCHITECTURE MATCHES "x64")
-        set(PLATFORM iossimulator-xcrun)
-    else()
-        message(FATAL_ERROR "Unknown iOS target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
-    endif()
-    # disable that makes linkage error (e.g. require stderr usage)
-    list(APPEND DISABLES no-stdio no-ui no-asm)
-elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
-    if(VCPKG_TARGET_ARCHITECTURE MATCHES "arm64")
-        set(PLATFORM darwin64-arm64-cc)
-    else()
-        set(PLATFORM darwin64-x86_64-cc)
-    endif()
-elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
-    set(PLATFORM BSD-generic64)
-elseif(CMAKE_SYSTEM_NAME STREQUAL "OpenBSD")
-    set(PLATFORM BSD-generic64)
-elseif(MINGW)
-    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
-        set(PLATFORM mingw64)
-    else()
-        set(PLATFORM mingw)
-    endif()
-elseif(EMSCRIPTEN)
-    set(MAKE $ENV{EMSDK}/upstream/emscripten/emmake)
-    set(ENV{MAKE} $ENV{EMSDK}/upstream/emscripten/emmake)
-else()
-    message(FATAL_ERROR "Unknown platform")
-endif()
-
-get_filename_component(COMPILER_ROOT "${CMAKE_C_COMPILER}" DIRECTORY)
-
-message("CMAKE_C_COMPILER=${CMAKE_C_COMPILER}")
-message("COMPILER_ROOT=${COMPILER_ROOT}")
-message("CMAKE_SYSROOT=${CMAKE_SYSROOT}")
-message("CMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}")
-message("CMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}")
-message("CMAKE_C_FLAGS=${CMAKE_C_FLAGS}")
-message("CMAKE_C_FLAGS_RELEASE=${CMAKE_C_FLAGS_RELEASE}")
-message("CMAKE_C_FLAGS_DEBUG=${CMAKE_C_FLAGS_DEBUG}")
-message("CMAKE_INCLUDE_SYSTEM_FLAG_C=${CMAKE_INCLUDE_SYSTEM_FLAG_C}")
-message("CMAKE_C_OSX_DEPLOYMENT_TARGET_FLAG=${CMAKE_C_OSX_DEPLOYMENT_TARGET_FLAG}")
-
-set(CFLAGS "${CMAKE_C_FLAGS}")
-if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
-    set(CFLAGS "-Wno-error=unused-command-line-argument ${CMAKE_C_FLAGS}")
-endif()
-if(CMAKE_C_COMPILER_TARGET AND CMAKE_C_COMPILE_OPTIONS_TARGET)
-    set(CFLAGS "${CFLAGS} ${CMAKE_C_COMPILE_OPTIONS_TARGET}${CMAKE_C_COMPILER_TARGET}")
-endif()
-if(CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN AND CMAKE_C_COMPILE_OPTIONS_EXTERNAL_TOOLCHAIN)
-    set(CFLAGS "${CFLAGS} ${CMAKE_C_COMPILE_OPTIONS_EXTERNAL_TOOLCHAIN}${CMAKE_C_COMPILER_EXTERNAL_TOOLCHAIN}")
-endif()
-if(CMAKE_SYSROOT AND CMAKE_C_COMPILE_OPTIONS_SYSROOT)
-    set(CFLAGS "${CFLAGS} ${CMAKE_C_COMPILE_OPTIONS_SYSROOT}${CMAKE_SYSROOT}")
-elseif(CMAKE_OSX_SYSROOT AND CMAKE_C_COMPILE_OPTIONS_SYSROOT)
-    set(CFLAGS "${CFLAGS} ${CMAKE_C_COMPILE_OPTIONS_SYSROOT}${CMAKE_OSX_SYSROOT}")
-endif()
-if (CMAKE_OSX_DEPLOYMENT_TARGET AND CMAKE_C_OSX_DEPLOYMENT_TARGET_FLAG)
-    set(CFLAGS "${CFLAGS} ${CMAKE_C_OSX_DEPLOYMENT_TARGET_FLAG}${CMAKE_OSX_DEPLOYMENT_TARGET}")
-endif()
-
-string(REGEX REPLACE "^ " "" CFLAGS "${CFLAGS}")
-
-if(CMAKE_HOST_WIN32)
-    file(TO_NATIVE_PATH ENV_PATH "${COMPILER_ROOT};$ENV{PATH}")
-else()
-    file(TO_NATIVE_PATH ENV_PATH "${COMPILER_ROOT}:$ENV{PATH}")
-endif()
-set(ENV{ANDROID_DEV} "${CMAKE_SYSROOT}/usr")
-
-if(NOT IOS)
-    set(ENV{CC} "${CMAKE_C_COMPILER}")
-endif()
-
-message("ENV{ANDROID_DEV}=$ENV{ANDROID_DEV}")
-
-get_filename_component(SOURCE_PATH_NAME "${SOURCE_PATH}" NAME)
-set(BUILDDIR "${CMAKE_CURRENT_BINARY_DIR}/${SOURCE_PATH_NAME}")
-
-if(NOT EXISTS "${BUILDDIR}")
-    file(COPY ${SOURCE_PATH} DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
-endif()
-
-get_filename_component(MSYS_BIN_DIR "${MAKE}" DIRECTORY)
-
-if(BUILD_SHARED_LIBS)
-    set(SHARED shared)
-    file(STRINGS "${BUILDDIR}/include/openssl/opensslv.h" SHLIB_VERSION
-        REGEX "^#[\t ]*define[\t ]+SHLIB_VERSION_NUMBER[\t ]+\".*\".*")
-    string(REGEX REPLACE "^.*SHLIB_VERSION_NUMBER[\t ]+\"([^\"]*)\".*$" "\\1"
-        SHLIB_VERSION "${SHLIB_VERSION}")
-    if(CMAKE_SYSTEM_NAME STREQUAL "Darwin" OR CMAKE_SYSTEM_NAME STREQUAL "iOS")
-        set(LIB_EXT dylib)
-        set(LIB_EXTS ${SHLIB_VERSION}.${LIB_EXT})
-    elseif(MINGW)
-        string(REPLACE "." "_" SHLIB_VERSION "${SHLIB_VERSION}")
-        set(BIN_EXT dll)
-        set(LIB_EXT dll.a)
-    else()
-        set(LIB_EXT so)
-        set(LIB_EXTS ${LIB_EXT}.${SHLIB_VERSION})
-    endif()
-    list(APPEND BIN_EXTS ${BIN_EXT})
-    list(APPEND LIB_EXTS ${LIB_EXT})
-else()
-    set(SHARED no-shared)
-    set(LIB_EXTS a)
-endif()
-foreach(lib ssl crypto)
-    foreach(ext ${LIB_EXTS})
-        list(APPEND INSTALL_LIBS "${BUILDDIR}/lib${lib}.${ext}")
-        list(APPEND INSTALL_PKG_CONFIGS "${BUILDDIR}/lib${lib}.pc")
-    endforeach()
-    foreach(ext ${BIN_EXTS})
-    # This might be wrong for targets which don't follow this naming scheme, but I'm not aware of any
-        if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
-            list(APPEND INSTALL_BINS "${BUILDDIR}/lib${lib}-${SHLIB_VERSION}-x64.${ext}")
-        else()
-            list(APPEND INSTALL_BINS "${BUILDDIR}/lib${lib}-${SHLIB_VERSION}.${ext}")
-        endif()
-    endforeach()
-endforeach()
-
-if(CMAKE_HOST_WIN32)
-    set(ENV_COMMAND set)
-    set(PATH_VAR ";%PATH%")
-else()
-    set(ENV_COMMAND export)
-    set(PATH_VAR ":$ENV{PATH}")
-endif()
-
-add_custom_command(
-        OUTPUT "${BUILDDIR}/Makefile"
-        COMMAND ${ENV_COMMAND} "PATH=${MSYS_BIN_DIR}${PATH_VAR}"
-        VERBATIM
-        WORKING_DIRECTORY "${BUILDDIR}"
-)
-
-if(NOT IOS)
-    add_custom_command(
-        OUTPUT "${BUILDDIR}/Makefile"
-        COMMAND ${ENV_COMMAND} CC=${CMAKE_C_COMPILER}
-        COMMAND ${ENV_COMMAND} AR=${CMAKE_AR}
-        COMMAND ${ENV_COMMAND} LD=${CMAKE_LINKER}
-        COMMAND ${ENV_COMMAND} RANLIB=${CMAKE_RANLIB}
-        COMMAND ${ENV_COMMAND} MAKE=${MAKE}
-        COMMAND ${ENV_COMMAND} MAKEDEPPROG=${CMAKE_C_COMPILER}
-        VERBATIM
-        APPEND
-    )
-
-    if(EMSCRIPTEN)
-        list(APPEND DISABLES
-                threads
-                no-engine
-                no-dso
-                no-asm
-                no-shared
-                no-sse2
-                no-srtp
-                )
-    else()
-        list(APPEND DISABLES
-                enable-static-engine
-                no-zlib
-                no-ssl2
-                no-idea
-                no-cast
-                no-seed
-                no-md2
-                no-tests)
-    endif()
-endif()
-
-if(EMSCRIPTEN)
-    add_custom_command(
-            OUTPUT "${BUILDDIR}/Makefile"
-            COMMAND "$ENV{EMSDK}/upstream/emscripten/emconfigure" ./config
-            ${SHARED}
-            ${DISABLES}
-            "--prefix=${CMAKE_INSTALL_PREFIX}"
-            "--openssldir=/etc/ssl"
-            "--cross-compile-prefix=\"/\""
-            VERBATIM
-            APPEND
-    )
-
-    add_custom_target(build_libs ALL
-            COMMAND ${ENV_COMMAND} "PATH=${MSYS_BIN_DIR}${PATH_VAR}"
-            COMMAND "${CMAKE_COMMAND}" -E touch "${BUILDDIR}/krb5.h"
-            COMMAND "${MAKE}" make build_libs
-            VERBATIM
-            WORKING_DIRECTORY "${BUILDDIR}"
-            DEPENDS "${BUILDDIR}/Makefile"
-            BYPRODUCTS ${INSTALL_LIBS}
-            )
-else()
-    add_custom_command(
-            OUTPUT "${BUILDDIR}/Makefile"
-            COMMAND "${PERL}" Configure
-            ${SHARED}
-            ${DISABLES}
-            ${PLATFORM}
-            "--prefix=${CMAKE_INSTALL_PREFIX}"
-            "--openssldir=/etc/ssl"
-            ${CFLAGS}
-            VERBATIM
-            APPEND
-    )
-
-    add_custom_target(build_libs ALL
-            COMMAND ${ENV_COMMAND} "PATH=${MSYS_BIN_DIR}${PATH_VAR}"
-            COMMAND "${CMAKE_COMMAND}" -E touch "${BUILDDIR}/krb5.h"
-            COMMAND "${MAKE}" -j ${VCPKG_CONCURRENCY} build_libs
-            VERBATIM
-            WORKING_DIRECTORY "${BUILDDIR}"
-            DEPENDS "${BUILDDIR}/Makefile"
-            BYPRODUCTS ${INSTALL_LIBS}
-            )
-endif()
-
-add_custom_command(
-        OUTPUT "${BUILDDIR}/Makefile"
-        COMMAND "${CMAKE_COMMAND}" "-DDIR=${BUILDDIR}" -P "${CMAKE_CURRENT_LIST_DIR}/remove-deps.cmake"
-        VERBATIM
-        APPEND
-)
-
-if((CMAKE_SYSTEM_NAME STREQUAL "Darwin" OR CMAKE_SYSTEM_NAME STREQUAL "iOS") AND BUILD_SHARED_LIBS)
-    if(DEFINED CMAKE_INSTALL_NAME_DIR)
-        set(ID_PREFIX "${CMAKE_INSTALL_NAME_DIR}")
-    else()
-        set(ID_PREFIX "@rpath")
-    endif()
-
-    add_custom_command(
-        TARGET build_libs
-        COMMAND /usr/bin/install_name_tool -id "${ID_PREFIX}/libssl.${SHLIB_VERSION}.dylib"
-                                               "${BUILDDIR}/libssl.${SHLIB_VERSION}.dylib"
-        COMMAND /usr/bin/install_name_tool -id "${ID_PREFIX}/libcrypto.${SHLIB_VERSION}.dylib"
-                                               "${BUILDDIR}/libcrypto.1.1.dylib"
-        COMMAND /usr/bin/install_name_tool -change "${CMAKE_INSTALL_PREFIX}/lib/libcrypto.${SHLIB_VERSION}.dylib"
-                                                   "${ID_PREFIX}/libcrypto.${SHLIB_VERSION}.dylib"
-                                                   "${BUILDDIR}/libssl.${SHLIB_VERSION}.dylib"
-        VERBATIM
-    )
-endif()
-
-install(
-    FILES ${INSTALL_LIBS}
-    DESTINATION lib
-)
-install(
-    FILES ${INSTALL_BINS}
-    DESTINATION bin
-)
-install(
-    FILES ${INSTALL_PKG_CONFIGS}
-    DESTINATION lib/pkgconfig
-)
diff --git a/contrib/vcpkg-ports/openssl/unix/portfile.cmake b/contrib/vcpkg-ports/openssl/unix/portfile.cmake
deleted file mode 100644
index 91223492..00000000
--- a/contrib/vcpkg-ports/openssl/unix/portfile.cmake
+++ /dev/null
@@ -1,49 +0,0 @@
-if (NOT VCPKG_TARGET_IS_MINGW)
-    vcpkg_fail_port_install(MESSAGE "${PORT} is only for openssl on Unix-like systems" ON_TARGET "UWP" "Windows")
-endif()
-
-vcpkg_extract_source_archive_ex(
-    OUT_SOURCE_PATH MASTER_COPY_SOURCE_PATH
-    ARCHIVE "${ARCHIVE}"
-    REF ${OPENSSL_VERSION}
-)
-
-if(CMAKE_HOST_WIN32)
-    vcpkg_acquire_msys(MSYS_ROOT PACKAGES make perl)
-    set(MAKE ${MSYS_ROOT}/usr/bin/make.exe)
-    set(PERL ${MSYS_ROOT}/usr/bin/perl.exe)
-else()
-    find_program(MAKE make)
-    if(NOT MAKE)
-        message(FATAL_ERROR "Could not find make. Please install it through your package manager.")
-    endif()
-endif()
-
-vcpkg_configure_cmake(
-    SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR}
-    PREFER_NINJA
-    OPTIONS
-        -DSOURCE_PATH=${MASTER_COPY_SOURCE_PATH}
-        -DPERL=${PERL}
-        -DMAKE=${MAKE}
-        -DVCPKG_CONCURRENCY=${VCPKG_CONCURRENCY}
-    OPTIONS_RELEASE
-        -DINSTALL_HEADERS=ON
-)
-
-vcpkg_install_cmake()
-vcpkg_fixup_pkgconfig()
-
-file(GLOB HEADERS ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/*/include/openssl/*.h)
-set(RESOLVED_HEADERS)
-foreach(HEADER ${HEADERS})
-    get_filename_component(X "${HEADER}" REALPATH)
-    list(APPEND RESOLVED_HEADERS "${X}")
-endforeach()
-
-file(INSTALL ${RESOLVED_HEADERS} DESTINATION ${CURRENT_PACKAGES_DIR}/include/openssl)
-file(INSTALL ${MASTER_COPY_SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
-
-if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
-    file(COPY ${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/openssl)
-endif()
diff --git a/contrib/vcpkg-ports/openssl/unix/remove-deps.cmake b/contrib/vcpkg-ports/openssl/unix/remove-deps.cmake
deleted file mode 100644
index 53ad6ef2..00000000
--- a/contrib/vcpkg-ports/openssl/unix/remove-deps.cmake
+++ /dev/null
@@ -1,7 +0,0 @@
-file(GLOB_RECURSE MAKEFILES ${DIR}/*/Makefile)
-foreach(MAKEFILE ${MAKEFILES})
-    message("removing deps from ${MAKEFILE}")
-    file(READ "${MAKEFILE}" _contents)
-    string(REGEX REPLACE "\n# DO NOT DELETE THIS LINE.*" "" _contents "${_contents}")
-    file(WRITE "${MAKEFILE}" "${_contents}")
-endforeach()
diff --git a/contrib/vcpkg-ports/openssl/unix/vcpkg-cmake-wrapper.cmake b/contrib/vcpkg-ports/openssl/unix/vcpkg-cmake-wrapper.cmake
deleted file mode 100644
index f36b6876..00000000
--- a/contrib/vcpkg-ports/openssl/unix/vcpkg-cmake-wrapper.cmake
+++ /dev/null
@@ -1,18 +0,0 @@
-_find_package(${ARGS})
-if(OPENSSL_FOUND)
-    find_library(OPENSSL_DL_LIBRARY NAMES dl)
-    if(OPENSSL_DL_LIBRARY)
-        list(APPEND OPENSSL_LIBRARIES "dl")
-        if(TARGET OpenSSL::Crypto)
-            set_property(TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES "dl")
-        endif()
-    endif()
-    find_package(Threads REQUIRED)
-    list(APPEND OPENSSL_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})
-    if(TARGET OpenSSL::Crypto)
-        set_property(TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES "Threads::Threads")
-    endif()
-    if(TARGET OpenSSL::SSL)
-        set_property(TARGET OpenSSL::SSL APPEND PROPERTY INTERFACE_LINK_LIBRARIES "Threads::Threads")
-    endif()
-endif()
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
diff --git a/contrib/vcpkg-ports/openssl/uwp/EnableUWPSupport.patch b/contrib/vcpkg-ports/openssl/uwp/EnableUWPSupport.patch
deleted file mode 100644
index fe783744..00000000
--- a/contrib/vcpkg-ports/openssl/uwp/EnableUWPSupport.patch
+++ /dev/null
@@ -1,170 +0,0 @@
-diff --git a/Configurations/10-main.conf b/Configurations/10-main.conf
-index 3c4299d264..99fcb1f713 100644
---- a/Configurations/10-main.conf
-+++ b/Configurations/10-main.conf
-@@ -1287,7 +1287,7 @@ my %targets = (
-     },
-     "VC-WIN64I" => {
-         inherit_from     => [ "VC-WIN64-common", asm("ia64_asm"),
--                              sub { $disabled{shared} ? () : "ia64_uplink" } ],
-+                              sub { $disabled{uplink} ? () : "ia64_uplink" } ],
-         AS               => "ias",
-         ASFLAGS          => "-d debug",
-         asoutflag        => "-o ",
-@@ -1299,7 +1299,7 @@ my %targets = (
-     },
-     "VC-WIN64A" => {
-         inherit_from     => [ "VC-WIN64-common", asm("x86_64_asm"),
--                              sub { $disabled{shared} ? () : "x86_64_uplink" } ],
-+                              sub { $disabled{uplink} ? () : "x86_64_uplink" } ],
-         AS               => sub { vc_win64a_info()->{AS} },
-         ASFLAGS          => sub { vc_win64a_info()->{ASFLAGS} },
-         asoutflag        => sub { vc_win64a_info()->{asoutflag} },
-@@ -1312,7 +1312,7 @@ my %targets = (
-     },
-     "VC-WIN32" => {
-         inherit_from     => [ "VC-noCE-common", asm("x86_asm"),
--                              sub { $disabled{shared} ? () : "uplink_common" } ],
-+                              sub { $disabled{uplink} ? () : "uplink_common" } ],
-         AS               => sub { vc_win32_info()->{AS} },
-         ASFLAGS          => sub { vc_win32_info()->{ASFLAGS} },
-         asoutflag        => sub { vc_win32_info()->{asoutflag} },
-@@ -1374,7 +1374,7 @@ my %targets = (
- #### MinGW
-     "mingw" => {
-         inherit_from     => [ "BASE_unix", asm("x86_asm"),
--                              sub { $disabled{shared} ? () : "x86_uplink" } ],
-+                              sub { $disabled{uplink} ? () : "x86_uplink" } ],
-         CC               => "gcc",
-         CFLAGS           => picker(default => "-Wall",
-                                    debug   => "-g -O0",
-diff --git a/Configurations/50-win-onecore.conf b/Configurations/50-win-onecore.conf
-index d478f42b0f..e0fb70daca 100644
---- a/Configurations/50-win-onecore.conf
-+++ b/Configurations/50-win-onecore.conf
-@@ -1,3 +1,4 @@
-+## -*- mode: perl; -*-
- # Windows OneCore targets.
- #
- # OneCore is new API stability "contract" that transcends Desktop, IoT and
-@@ -10,6 +11,25 @@
- # TODO: extend error handling to use ETW based eventing
- # (Or rework whole error messaging)
- 
-+my $UWP_info = {};
-+sub UWP_info {
-+    unless (%$UWP_info) {
-+        my $SDKver = `pwsh.exe -Command  \"& {\$(Get-Item \\\"hklm:\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\\").GetValue(\\\"CurrentVersion\\\")}\"`;
-+        $SDKver =~ s|\R$||;
-+        my @SDKver_split = split(/\./, $SDKver);
-+        # SDK version older than 10.0.17763 don't support our ASM builds
-+        if ($SDKver_split[0] < 10
-+            || ($SDKver_split[0] == 10
-+                && $SDKver_split[1] == 0
-+                && $SDKver_split[2] < 17763)) {
-+            $UWP_info->{disable} = [ 'asm' ];
-+        } else {
-+            $UWP_info->{disable} = [ ];
-+        }
-+    }
-+    return $UWP_info;
-+}
-+
- my %targets = (
-     "VC-WIN32-ONECORE" => {
-         inherit_from    => [ "VC-WIN32" ],
-@@ -61,4 +81,57 @@ my %targets = (
-         ex_libs         => "onecore.lib",
-         multilib        => "-arm64",
-     },
-+
-+    # Universal Windows Platform (UWP) App Support
-+
-+    # TODO
-+    #
-+    # The 'disable' attribute should have 'uplink'.
-+    # however, these are checked in some 'inherit_from', which is processed
-+    # very early, before the 'disable' attributes are seen.
-+    # This is a problem that needs to be resolved in Configure first.
-+    #
-+    # But if you want to build library with Windows 10 Version 1809 SDK or
-+    # earlier, the 'disable' attribute should also have 'asm'.
-+
-+    "VC-WIN32-UWP" => {
-+        inherit_from    => [ "VC-WIN32-ONECORE" ],
-+        lflags          => add("/APPCONTAINER"),
-+        defines         => add("WINAPI_FAMILY=WINAPI_FAMILY_APP",
-+                               "_WIN32_WINNT=0x0A00"),
-+        dso_scheme      => "",
-+        disable         => sub { [ 'ui-console', 'stdio', 'async', 'uplink',
-+                                   @{ UWP_info()->{disable} } ] },
-+        ex_libs         => "WindowsApp.lib",
-+    },
-+     "VC-WIN64A-UWP" => {
-+        inherit_from    => [ "VC-WIN64A-ONECORE" ],
-+        lflags          => add("/APPCONTAINER"),
-+        defines         => add("WINAPI_FAMILY=WINAPI_FAMILY_APP",
-+                               "_WIN32_WINNT=0x0A00"),
-+        dso_scheme      => "",
-+        disable         => sub { [ 'ui-console', 'stdio', 'async', 'uplink',
-+                                   @{ UWP_info()->{disable} } ] },
-+        ex_libs         => "WindowsApp.lib",
-+    },
-+    "VC-WIN32-ARM-UWP" => {
-+        inherit_from    => [ "VC-WIN32-ARM" ],
-+        lflags          => add("/APPCONTAINER"),
-+        defines         => add("WINAPI_FAMILY=WINAPI_FAMILY_APP",
-+                               "_WIN32_WINNT=0x0A00"),
-+        dso_scheme      => "",
-+        disable         => sub { [ 'ui-console', 'stdio', 'async', 'uplink',
-+                                   @{ UWP_info()->{disable} } ] },
-+        ex_libs         => "WindowsApp.lib",
-+    },
-+     "VC-WIN64-ARM-UWP" => {
-+        inherit_from    => [ "VC-WIN64-ARM" ],
-+        lflags          => add("/APPCONTAINER"),
-+        defines         => add("WINAPI_FAMILY=WINAPI_FAMILY_APP",
-+                               "_WIN32_WINNT=0x0A00"),
-+        dso_scheme      => "",
-+        disable         => sub { [ 'ui-console', 'stdio', 'async', 'uplink',
-+                                   @{ UWP_info()->{disable} } ] },
-+        ex_libs         => "WindowsApp.lib",
-+    },
- );
-diff --git a/Configure b/Configure
-index 5a699836f3..de45f1e299 100755
---- a/Configure
-+++ b/Configure
-@@ -407,6 +408,7 @@ my @disablables = (
-     "ubsan",
-     "ui-console",
-     "unit-test",
-+    "uplink",
-     "whirlpool",
-     "weak-ssl-ciphers",
-     "zlib",
-@@ -491,8 +493,8 @@ my @disable_cascades = (
- 
-     # Without position independent code, there can be no shared libraries or DSOs
-     "pic"               => [ "shared" ],
--    "shared"            => [ "dynamic-engine" ],
-+    "shared"            => [ "dynamic-engine", "uplink" ],
-     "dso"               => [ "dynamic-engine" ],
-     "engine"            => [ "afalgeng", "devcryptoeng" ],
- 
-     # no-autoalginit is only useful when building non-shared
-diff --git a/INSTALL b/INSTALL
-index 2119cbae9e..ee54e8c215 100644
---- a/INSTALL
-+++ b/INSTALL
-@@ -560,6 +560,10 @@
-                    likely to complement configuration command line with
-                    suitable compiler-specific option.
- 
-+  no-uplink
-+                   Don't build support for UPLINK interface.
-+
-+
-   no-<prot>
-                    Don't build support for negotiating the specified SSL/TLS
-                    protocol (one of ssl, ssl3, tls, tls1, tls1_1, tls1_2,
diff --git a/contrib/vcpkg-ports/openssl/uwp/make-openssl.bat b/contrib/vcpkg-ports/openssl/uwp/make-openssl.bat
deleted file mode 100644
index 6f6166a2..00000000
--- a/contrib/vcpkg-ports/openssl/uwp/make-openssl.bat
+++ /dev/null
@@ -1,16 +0,0 @@
-set build=%1
-
-perl Configure no-asm no-hw no-dso VC-WINUNIVERSAL -FS -FIWindows.h
-
-for /D %%f in ("%WindowsSdkDir%References\%WindowsSDKLibVersion%Windows.Foundation.FoundationContract\*") do set LibPath=%LibPath%;%%f\
-for /D %%f in ("%WindowsSdkDir%References\%WindowsSDKLibVersion%Windows.Foundation.UniversalApiContract\*") do set LibPath=%LibPath%;%%f\
-for /D %%f in ("%WindowsSdkDir%References\Windows.Foundation.FoundationContract\*") do set LibPath=%LibPath%;%%f\
-for /D %%f in ("%WindowsSdkDir%References\Windows.Foundation.UniversalApiContract\*") do set LibPath=%LibPath%;%%f\
-
-call ms\do_winuniversal.bat
-
-mkdir inc32\openssl
-
-jom -j %NUMBER_OF_PROCESSORS% -k -f ms\ntdll.mak
-REM due to a race condition in the build, we need to have a second single-threaded pass.
-nmake -f ms\ntdll.mak
diff --git a/contrib/vcpkg-ports/openssl/uwp/portfile.cmake b/contrib/vcpkg-ports/openssl/uwp/portfile.cmake
deleted file mode 100644
index 08a523cd..00000000
--- a/contrib/vcpkg-ports/openssl/uwp/portfile.cmake
+++ /dev/null
@@ -1,156 +0,0 @@
-vcpkg_fail_port_install(MESSAGE "${PORT} is only for Windows Universal Platform" ON_TARGET "Linux" "OSX")
-
-vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
-
-vcpkg_find_acquire_program(JOM)
-get_filename_component(JOM_EXE_PATH ${JOM} DIRECTORY)
-vcpkg_add_to_path("${PERL_EXE_PATH}")
-
-vcpkg_extract_source_archive_ex(
-  OUT_SOURCE_PATH SOURCE_PATH
-  ARCHIVE ${ARCHIVE}
-  PATCHES
-    uwp/EnableUWPSupport.patch
-)
-
-vcpkg_find_acquire_program(NASM)
-get_filename_component(NASM_EXE_PATH ${NASM} DIRECTORY)
-vcpkg_add_to_path(PREPEND "${NASM_EXE_PATH}")
-
-set(CONFIGURE_COMMAND ${PERL} Configure
-    enable-static-engine
-    enable-capieng
-    no-unit-test
-    no-ssl2
-    no-asm
-    no-uplink
-    no-tests
-    -utf-8
-    shared
-)
-
-if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
-    set(OPENSSL_ARCH VC-WIN32-UWP)
-elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
-    set(OPENSSL_ARCH VC-WIN64A-UWP)
-elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
-    set(OPENSSL_ARCH VC-WIN32-ARM-UWP)
-elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
-    set(OPENSSL_ARCH VC-WIN64-ARM-UWP)
-else()
-    message(FATAL_ERROR "Unsupported target architecture: ${VCPKG_TARGET_ARCHITECTURE}")
-endif()
-
-set(OPENSSL_MAKEFILE "makefile")
-
-file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg)
-
-
-if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
-
-    # Copy openssl sources.
-    message(STATUS "Copying openssl release source files...")
-    file(GLOB OPENSSL_SOURCE_FILES "${SOURCE_PATH}/*")
-    foreach(SOURCE_FILE ${OPENSSL_SOURCE_FILES})
-        file(COPY ${SOURCE_FILE} DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
-    endforeach()
-    message(STATUS "Copying openssl release source files... done")
-    set(SOURCE_PATH_RELEASE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel")
-
-    set(OPENSSLDIR_RELEASE "${CURRENT_PACKAGES_DIR}")
-
-    message(STATUS "Configure ${TARGET_TRIPLET}-rel")
-    vcpkg_execute_required_process(
-        COMMAND ${CONFIGURE_COMMAND} ${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_RELEASE}" "--openssldir=${OPENSSLDIR_RELEASE}" -FS
-        WORKING_DIRECTORY "${SOURCE_PATH_RELEASE}"
-        LOGNAME configure-perl-${TARGET_TRIPLET}-${VCPKG_BUILD_TYPE}-rel
-    )
-    message(STATUS "Configure ${TARGET_TRIPLET}-rel done")
-
-    message(STATUS "Build ${TARGET_TRIPLET}-rel")
-    # Openssl's buildsystem has a race condition which will cause JOM to fail at some point.
-    # This is ok; we just do as much work as we can in parallel first, then follow up with a single-threaded build.
-    make_directory(${SOURCE_PATH_RELEASE}/inc32/openssl)
-    execute_process(
-        COMMAND "${JOM}" -k -j ${VCPKG_CONCURRENCY} -f "${OPENSSL_MAKEFILE}" build_libs
-        WORKING_DIRECTORY "${SOURCE_PATH_RELEASE}"
-        OUTPUT_FILE "${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-out.log"
-        ERROR_FILE "${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-rel-0-err.log"
-    )
-    vcpkg_execute_required_process(
-        COMMAND nmake -f "${OPENSSL_MAKEFILE}" install_dev
-        WORKING_DIRECTORY "${SOURCE_PATH_RELEASE}"
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
-        file(COPY "${SOURCE_FILE}" DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
-    endforeach()
-    message(STATUS "Copying openssl debug source files... done")
-    set(SOURCE_PATH_DEBUG "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg")
-
-    set(OPENSSLDIR_DEBUG "${CURRENT_PACKAGES_DIR}/debug")
-
-    message(STATUS "Configure ${TARGET_TRIPLET}-dbg")
-    vcpkg_execute_required_process(
-        COMMAND ${CONFIGURE_COMMAND} debug-${OPENSSL_ARCH} "--prefix=${OPENSSLDIR_DEBUG}" "--openssldir=${OPENSSLDIR_DEBUG}" -FS
-        WORKING_DIRECTORY "${SOURCE_PATH_DEBUG}"
-        LOGNAME configure-perl-${TARGET_TRIPLET}-${VCPKG_BUILD_TYPE}-dbg
-    )
-    message(STATUS "Configure ${TARGET_TRIPLET}-dbg done")
-
-    message(STATUS "Build ${TARGET_TRIPLET}-dbg")
-    make_directory("${SOURCE_PATH_DEBUG}/inc32/openssl")
-    execute_process(
-        COMMAND "${JOM}" -k -j ${VCPKG_CONCURRENCY} -f "${OPENSSL_MAKEFILE}" build_libs
-        WORKING_DIRECTORY "${SOURCE_PATH_DEBUG}"
-        OUTPUT_FILE "${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-out.log"
-        ERROR_FILE "${CURRENT_BUILDTREES_DIR}/build-${TARGET_TRIPLET}-dbg-0-err.log"
-    )
-    vcpkg_execute_required_process(
-        COMMAND nmake -f "${OPENSSL_MAKEFILE}" install_dev
-        WORKING_DIRECTORY "${SOURCE_PATH_DEBUG}"
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
-    "${CURRENT_PACKAGES_DIR}/bin/openssl.exe"
-    "${CURRENT_PACKAGES_DIR}/debug/bin/openssl.exe"
-    "${CURRENT_PACKAGES_DIR}/debug/openssl.cnf"
-    "${CURRENT_PACKAGES_DIR}/openssl.cnf"
-    "${CURRENT_PACKAGES_DIR}/ct_log_list.cnf"
-    "${CURRENT_PACKAGES_DIR}/ct_log_list.cnf.dist"
-    "${CURRENT_PACKAGES_DIR}/openssl.cnf.dist"
-    "${CURRENT_PACKAGES_DIR}/debug/ct_log_list.cnf"
-    "${CURRENT_PACKAGES_DIR}/debug/ct_log_list.cnf.dist"
-    "${CURRENT_PACKAGES_DIR}/debug/openssl.cnf.dist"
-)
-
-file(READ "${CURRENT_PACKAGES_DIR}/include/openssl/dtls1.h" _contents)
-string(REPLACE "<winsock.h>" "<winsock2.h>" _contents "${_contents}")
-file(WRITE "${CURRENT_PACKAGES_DIR}/include/openssl/dtls1.h" "${_contents}")
-
-file(READ "${CURRENT_PACKAGES_DIR}/include/openssl/rand.h" _contents)
-string(REPLACE "#  include <windows.h>" "#ifndef _WINSOCKAPI_\n#define _WINSOCKAPI_\n#endif\n#  include <windows.h>" _contents "${_contents}")
-file(WRITE "${CURRENT_PACKAGES_DIR}/include/openssl/rand.h" "${_contents}")
-
-vcpkg_copy_pdbs()
-
-file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
diff --git a/contrib/vcpkg-ports/openssl/vcpkg.json b/contrib/vcpkg-ports/openssl/vcpkg.json
deleted file mode 100644
index 2d0eb137..00000000
--- a/contrib/vcpkg-ports/openssl/vcpkg.json
+++ /dev/null
@@ -1,7 +0,0 @@
-{
-  "name": "openssl",
-  "version-string": "1.1.1k",
-  "port-version": 4,
-  "description": "OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library.",
-  "homepage": "https://www.openssl.org"
-}
diff --git a/contrib/vcpkg-ports/openssl/windows/portfile.cmake b/contrib/vcpkg-ports/openssl/windows/portfile.cmake
deleted file mode 100644
index c873eb75..00000000
--- a/contrib/vcpkg-ports/openssl/windows/portfile.cmake
+++ /dev/null
@@ -1,174 +0,0 @@
-vcpkg_fail_port_install(MESSAGE "${PORT} is only for Windows Desktop" ON_TARGET "UWP" "Linux" "OSX")
-
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
-    no-autoload-config
-    -utf-8
-    ${OPENSSL_SHARED}
-)
-
-if(DEFINED OPENSSL_USE_NOPINSHARED)
-    set(CONFIGURE_OPTIONS ${CONFIGURE_OPTIONS} no-pinshared)
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
-if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
-    file(COPY "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/openssl")
-endif()
diff --git a/contrib/vcpkg-ports/openssl/windows/vcpkg-cmake-wrapper.cmake b/contrib/vcpkg-ports/openssl/windows/vcpkg-cmake-wrapper.cmake
deleted file mode 100644
index 1e3b837e..00000000
--- a/contrib/vcpkg-ports/openssl/windows/vcpkg-cmake-wrapper.cmake
+++ /dev/null
@@ -1,10 +0,0 @@
-_find_package(${ARGS})
-if(OPENSSL_FOUND)
-    list(APPEND OPENSSL_LIBRARIES Crypt32.lib ws2_32.lib)
-    if(TARGET OpenSSL::Crypto)
-        set_property(TARGET OpenSSL::Crypto APPEND PROPERTY INTERFACE_LINK_LIBRARIES "Crypt32.lib;ws2_32.lib")
-    endif()
-    if(TARGET OpenSSL::SSL)
-        set_property(TARGET OpenSSL::SSL APPEND PROPERTY INTERFACE_LINK_LIBRARIES "Crypt32.lib;ws2_32.lib")
-    endif()
-endif()
diff --git a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
index dd3c6c0a..89f6a279 100644
--- a/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
+++ b/contrib/vcpkg-triplets/arm64-windows-ovpn.cmake
@@ -5,3 +5,5 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
 if(PORT STREQUAL "lz4")
     set(VCPKG_LIBRARY_LINKAGE static)
 endif()
+
+set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
diff --git a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
index 7036ed2d..d860eed6 100644
--- a/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
+++ b/contrib/vcpkg-triplets/x64-windows-ovpn.cmake
@@ -5,3 +5,5 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
 if(PORT STREQUAL "lz4")
     set(VCPKG_LIBRARY_LINKAGE static)
 endif()
+
+set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
diff --git a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
index 7d3bf340..c1ea6ef3 100644
--- a/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
+++ b/contrib/vcpkg-triplets/x86-windows-ovpn.cmake
@@ -5,3 +5,5 @@ set(VCPKG_LIBRARY_LINKAGE dynamic)
 if(PORT STREQUAL "lz4")
     set(VCPKG_LIBRARY_LINKAGE static)
 endif()
+
+set(OPENSSL_NO_AUTOLOAD_CONFIG ON)
-- 
2.23.0.windows.1


