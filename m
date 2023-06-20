From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 20 Jun 2023 15:53:07 +0200
Message-Id: <20230620135310.94455-3-frank@...2641...>
In-Reply-To: <20230620135310.94455-1-frank@...2641...>
References: <20230509111205.138997-1-frank@...2641...>
 <20230620135310.94455-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 2/5] CMake: Add complete MinGW and MSVC
 build
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

This is based on the initial CMake patch by
Arne Schwabe, but extends that to provide
a complete replacement for existing MinGW
build (autotools based) and MSVC build
(openvpn.sln).

The following features are added while switching
these builds to CMake:
 - vcpkg support for MinGW build, allowing for
   trivial cross-compilation on Linux
 - Add unittests to MSVC build
 - Rework MSVC config header generation, removing
   need for separate headers between autotools
   and MSVC

The following advantages are reasons for switching
to CMake over the existing MSVC build:
 - Easier to maintain CMake files without IDE
   than the sln and vcxproj files
 - Able to maintain MSVC and MinGW build side-by-side

The plan is to completely remove the existing MSVC
build system but leave the existing autotools builds
in place as-is, including MinGW support.

CMake is not the intended build system for Unix-like
platforms and there are no current plans to switch
to it.

v2:
 - Reduce default warning level for MSVC to /W2. With
   /W3 the build is just much too noisy, making it
   difficult to spot new warnings.
 - Change MSVC CMake presets to have hardcoded build
   type. When using pkg_search_module MSVC Multi-Config
   builds do not work correctly at all since PkgConfig
   doesn't seem to be able to create multi-config
   libraries like find_package does.
 - Change minGW presets to be Multi-Config capable.
 - Remove OPENVPN_VERSION_MAJOR, OPENVPN_VERSION_MINOR,
   OPENVPN_VERSION_PATCH from config.h.cmake.in.
   They are not required and cause macro redefinition
   warnings in MSVC (with openvpn-plugin.h). gcc doesn't
   warn about this because the definitions are identical
   so no need to fix this in autoheader config.h.in.
v3:
 - Apply fixes by Lev Stipakov to match MSVC compile
   options better to previous build.
 - Apply change by Lev Stipakov to enable generation
   of PDB files.
 - Move /Brepro to its own commit. This is a behavior
   change that should be more visible.
 - Rebase on top of my dist fixes.

Change-Id: I237f28eca618d4fc476225b887c0be26cca362b1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/build.yaml                  |  298 ++---
 .gitignore                                    |    1 +
 CMakeLists.txt                                | 1008 ++++++++++-------
 CMakePresets.json                             |  228 ++++
 Makefile.am                                   |    5 +-
 config.h.cmake.in                             |   25 +-
 contrib/cmake/git-version.py                  |   75 ++
 contrib/cmake/parse-version.m4.py             |   58 +
 contrib/vcpkg-manifests/mingw/vcpkg.json      |   13 +
 contrib/vcpkg-manifests/windows/vcpkg.json    |   20 +
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   22 +-
 doc/CMakeLists.txt                            |   81 ++
 doc/Makefile.am                               |    3 +-
 src/openvpnmsica/CMakeLists.txt               |   36 +
 src/openvpnmsica/Makefile.am                  |    3 +
 src/openvpnserv/CMakeLists.txt                |   34 +
 src/openvpnserv/Makefile.am                   |    3 +
 src/tapctl/CMakeLists.txt                     |   31 +
 src/tapctl/Makefile.am                        |    4 +
 19 files changed, 1286 insertions(+), 662 deletions(-)
 create mode 100644 CMakePresets.json
 create mode 100644 contrib/cmake/git-version.py
 create mode 100644 contrib/cmake/parse-version.m4.py
 create mode 100644 contrib/vcpkg-manifests/mingw/vcpkg.json
 create mode 100644 contrib/vcpkg-manifests/windows/vcpkg.json
 create mode 100644 doc/CMakeLists.txt
 create mode 100644 src/openvpnmsica/CMakeLists.txt
 create mode 100644 src/openvpnserv/CMakeLists.txt
 create mode 100644 src/tapctl/CMakeLists.txt

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 0c16d379..5f0a0761 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -39,230 +39,95 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        osslver: [1.1.1q, 3.0.5]
-        target: [mingw64, mingw]
-        include:
-          - target: mingw64
-            chost: x86_64-w64-mingw32
-          - target: mingw
-            chost: i686-w64-mingw32
+        arch: [x86, x64]
 
-    name: "gcc-mingw - ${{matrix.target}} - OSSL ${{ matrix.osslver }}"
+    name: "gcc-mingw - ${{ matrix.arch }} - OSSL"
     runs-on: ubuntu-22.04
     env:
-      MAKEFLAGS: -j3
-      LZO_VERSION: "2.10"
-      PKCS11_HELPER_VERSION: "1.29.0"
-      OPENSSL_VERSION: "${{ matrix.osslver }}"
-      TAP_WINDOWS_VERSION: "9.23.3"
-      CMOCKA_VERSION: "1.1.5"
+      VCPKG_ROOT: ${{ github.workspace }}/vcpkg
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip cmake ninja-build build-essential wget
+        run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake ninja-build build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
-        with:
-          path: openvpn
 
-      - name: autoconf
-        run: autoreconf -fvi
-        working-directory: openvpn
-
-      - name: Cache dependencies
-        id: cache
-        uses: actions/cache@...2689...
+      - name: Restore from cache and install vcpkg
+        uses: lukka/run-vcpkg@...2637...
         with:
-          path: '~/mingw/'
-          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}--${{ env.CMOCKA_VERSION }}
-
-      # Repeating  if: steps.cache.outputs.cache-hit != 'true'
-      # on every step for building dependencies is ugly but
-      # I haven't found a better solution so far.
-
-      - name: Download mingw dependencies
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: |
-          wget -c -P download-cache/ "https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
-          wget -c -P download-cache/ "https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
-          wget -c -P download-cache/ "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
-          wget -c -P download-cache/ "https://github.com/coreboot/cmocka/archive/refs/tags/cmocka-${CMOCKA_VERSION}.tar.gz"
-          tar jxf "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
-          wget -c -P download-cache/ "https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz" || wget -c -P download-cache/ "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
-          tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
-          tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
-          tar zxf "download-cache/cmocka-${CMOCKA_VERSION}.tar.gz"
-          unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
-
-      - name: create cmocka build directory
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: mkdir cmocka-build
-
-      - name: configure cmocka
-        if: steps.cache.outputs.cache-hit != 'true'
-        working-directory: "./cmocka-build"
-        run: cmake -GNinja -DCMAKE_C_COMPILER=${{ matrix.chost }}-gcc -DCMAKE_CXX_COMPILER=${{ matrix.chost }}-g++ -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_SHARED_LINKER_FLAGS=-static-libgcc -DCMAKE_PREFIX_PATH=${HOME}/mingw/opt/lib/pkgconfig/ -DCMAKE_INCLUDE_PATH=${HOME}/mingw/opt/lib/include -DCMAKE_LIBRARY_PATH=${HOME}/mingw/opt/lib -DCMAKE_INSTALL_PREFIX=${HOME}/mingw/opt/ ../cmocka-cmocka-${{ env.CMOCKA_VERSION }}
-
-      - name: build cmocka
-        if: steps.cache.outputs.cache-hit != 'true'
-        working-directory: "./cmocka-build"
-        run: ninja
-
-      - name: install cmocka
-        if: steps.cache.outputs.cache-hit != 'true'
-        working-directory: "./cmocka-build"
-        run: ninja install
-
-      - name: Configure OpenSSL
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: ./Configure --cross-compile-prefix=${{ matrix.chost }}- shared ${{ matrix.target }} no-capieng --prefix="${HOME}/mingw/opt" --openssldir="${HOME}/mingw/opt" -static-libgcc
-        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
-
-      - name: Build OpenSSL
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: make
-        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
-
-      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 instead of
-      # mingw/opt/lib, so we include both dirs in the following steps
-      # (pkcs11-helper and OpenVPN) so the libraries will be found
-      - name: Install OpenSSL
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: make install
-        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
-
-      - name: autoreconf pkcs11-helper
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: autoreconf -iv
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION }}"
-
-      - name: configure pkcs11-helper
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: OPENSSL_LIBS="-L${HOME}/mingw/opt/lib -L${HOME}/mingw/opt/lib64 -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig ./configure --host=${{ matrix.chost }} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION }}"
-
-      - name: build pkcs11-helper
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: make all
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION }}"
-
-      - name: install pkcs11-helper
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: make install
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION }}"
-
-      - name: Configure lzo
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: ./configure --host=${{ matrix.chost }} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu
-        working-directory: "./lzo-${{ env.LZO_VERSION }}"
-
-      - name: build lzo
-        if: steps.cache.outputs.cache-hit != 'true'
-        working-directory: "./lzo-${{ env.LZO_VERSION }}"
-        run: make
-
-      - name: install lzo
-        if: steps.cache.outputs.cache-hit != 'true'
-        working-directory: "./lzo-${{ env.LZO_VERSION }}"
-        run: make install
-
-      - name: copy tap-windows.h header
-        if: steps.cache.outputs.cache-hit != 'true'
-        run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h ${HOME}/mingw/opt/include/
-
-      - name: configure OpenVPN
-        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -L$HOME/mingw/opt/lib64 -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${{ matrix.chost }} --disable-lz4
-        working-directory: openvpn
-
-      - name: build OpenVPN
-        run: make -j3
-        working-directory: openvpn
-      - name: build OpenVPN unittests
-        run: make -j3 check
-        working-directory: openvpn
+          vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
+          vcpkgJsonGlob: '**/mingw/vcpkg.json'
+          appendedCacheKey: mingw_${{ matrix.arch }}
 
-      # We use multiple upload-artifact here, so it becomes a flat folder
-      # structure since we need the dlls on the same level as the binaries
-      - name: Archive cmocka/openssl/lzo dlls
-        uses: actions/upload-artifact@...2689...
+      - name: Run CMake with vcpkg.json manifest
+        uses: lukka/run-cmake@...2637...
         with:
-          retention-days: 1
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-dlls
-          path: '~/mingw/opt/bin/*.dll'
-
-      # libtool puts some wrapper binaries in openvpn/tests/unit_tests/openvpn/
-      # and the real binaries in openvpn/tests/unit_tests/openvpn/.libs/
-      - name: Archive unittest artifacts
-        uses: actions/upload-artifact@...2689...
+          configurePreset: mingw-${{ matrix.arch }}
+          buildPreset: mingw-${{ matrix.arch }}
+          buildPresetAdditionalArgs: "['--config Debug']"
+
+      - uses: actions/upload-artifact@...2689...
         with:
-          retention-days: 1
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-tests
-          path: openvpn/tests/unit_tests/openvpn/.libs/*.exe
-
-      # Currently not used by the unit test but might in the future and also
-      # helpful if manually downloading and running openvpn.exe from a mingw
-      # build
-      - name: Archive openvpn binary
-        uses: actions/upload-artifact@...2689...
+          name: openvpn-mingw-${{ matrix.arch }}
+          path: |
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
+            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
+
+      - uses: actions/upload-artifact@...2689...
         with:
-          retention-days: 1
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-tests
-          path: openvpn/src/openvpn/.libs/*.exe
+          name: openvpn-mingw-${{ matrix.arch }}-tests
+          path: |
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
 
   mingw-unittest:
     needs: [ mingw ]
     strategy:
       fail-fast: false
       matrix:
-        osslver: [ 1.1.1q, 3.0.5 ]
-        target: [ mingw64, mingw ]
+        arch: [x86, x64]
 
     runs-on: windows-latest
-    name: "mingw unittests - ${{matrix.target}} - OSSL ${{ matrix.osslver }}"
+    name: "mingw unittests - ${{ matrix.arch }} - OSSL"
     steps:
-      - name: Retrieve mingw unittest dlls
-        uses: actions/download-artifact@...2689...
-        with:
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-dlls
-          path: unittests
-
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2689...
         with:
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-tests
+          name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
 
       - name: List unittests directory
         run: "dir unittests"
 
-      - name: Run argvunit test
-        run: ./unittests/argv_testdriver.exe
+      - name: Run argv unit test
+        run: ./unittests/test_argv.exe
 
-      - name: Run auth_tokenunit test
-        run: ./unittests/auth_token_testdriver.exe
+      - name: Run auth_token unit test
+        run: ./unittests/test_auth_token.exe
 
-      - name: Run bufferunit test
-        run: ./unittests/buffer_testdriver.exe
+      - name: Run buffer unit test
+        run: ./unittests/test_buffer.exe
 
       - name: Run cryptoapi unit test
-        run: ./unittests/cryptoapi_testdriver.exe
+        run: ./unittests/test_cryptoapi.exe
 
-      - name: Run cryptounit test
-        run: ./unittests/crypto_testdriver.exe
+      - name: Run crypto unit test
+        run: ./unittests/test_crypto.exe
 
-      - name: Run miscunit test
-        run: ./unittests/misc_testdriver.exe
+      - name: Run misc unit test
+        run: ./unittests/test_misc.exe
 
-      - name: Run ncpunit test
-        run: ./unittests/ncp_testdriver.exe
+      - name: Run ncp unit test
+        run: ./unittests/test_ncp.exe
 
-      - name: Run packet idunit test
-        run: ./unittests/packet_id_testdriver.exe
+      - name: Run packet id unit test
+        run: ./unittests/test_packet_id.exe
 
-      - name: Run pktunit test
-        run: ./unittests/pkt_testdriver.exe
+      - name: Run pkt unit test
+        run: ./unittests/test_pkt.exe
 
-      - name: Run providerunit test
-        run: ./unittests/provider_testdriver.exe
+      - name: Run provider unit test
+        run: ./unittests/test_provider.exe
 
   ubuntu:
     strategy:
@@ -411,60 +276,51 @@ jobs:
       strategy:
         fail-fast: false
         matrix:
-          plat: [ARM64, Win32, x64]
-          include:
-            - plat: ARM64
-              triplet: arm64
-            - plat: Win32
-              triplet: x86
-            - plat: x64
-              triplet: x64
-
-      name: "msbuild - ${{matrix.triplet}} - openssl"
+          arch: [amd64, x86, arm64]
+
+      name: "msbuild - ${{ matrix.arch }} - openssl"
       env:
         BUILD_CONFIGURATION: Release
-        VCPKG_OVERLAY_PORTS: ${{ github.workspace }}/contrib/vcpkg-ports
-        VCPKG_OVERLAY_TRIPLETS: ${{ github.workspace }}/contrib/vcpkg-triplets
 
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2689...
-
-      - name: Add MSBuild to PATH
-        uses: microsoft/setup-msbuild@...2690...
-
-      - name: Set up Python
-        uses: actions/setup-python@...2691...
-        with:
-          python-version: '3.x'
+      - uses: lukka/get-cmake@...2729...
 
       - name: Install rst2html
-        run: python -m pip install --upgrade pip rst2html
+        run: python -m pip install --upgrade pip docutils
 
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2637...
         with:
           vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
-          vcpkgJsonGlob: '**/openvpn/vcpkg.json'
-          appendedCacheKey: '${{matrix.triplet}}'
+          vcpkgJsonGlob: '**/windows/vcpkg.json'
+          appendedCacheKey: msvc_${{ matrix.arch }}
 
-      - name: Run MSBuild consuming vcpkg.json
-        working-directory: ${{env.GITHUB_WORKSPACE}}
-        run: |
-            # workaround for GHA runner bug where vcpkg installation is detected at c:\vcpkg
-            # see https://github.com/lukka/run-vcpkg/issues/170
-            ${{ github.workspace }}/vcpkg/vcpkg.exe integrate install
-            msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
+      - name: Run CMake with vcpkg.json manifest (NO TESTS)
+        uses: lukka/run-cmake@...2637...
+        if: ${{ matrix.arch == 'arm64' }}
+        with:
+          configurePreset: win-${{ matrix.arch }}-release
+          buildPreset: win-${{ matrix.arch }}-release
+
+      - name: Run CMake with vcpkg.json manifest
+        uses: lukka/run-cmake@...2637...
+        if: ${{ matrix.arch != 'arm64' }}
+        with:
+          configurePreset: win-${{ matrix.arch }}-release
+          buildPreset: win-${{ matrix.arch }}-release
+          testPreset: win-${{ matrix.arch }}-release
 
-      - name: Archive artifacts
-        uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2689...
         with:
-          name: artifacts-${{ matrix.plat }}
+          name: openvpn-msvc-${{ matrix.arch }}
           path: |
-            ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.exe
-            ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll
-            ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.pdb
-            doc/openvpn.8.html
+            ${{ github.workspace }}/out/**/*.exe
+            ${{ github.workspace }}/out/**/*.dll
+            !${{ github.workspace }}/out/**/test_*.exe
+            !${{ github.workspace }}/out/**/CMakeFiles/**
+            !${{ github.workspace }}/out/**/vcpkg_installed/**
 
   trigger_openvpn_build:
     runs-on: windows-latest
diff --git a/.gitignore b/.gitignore
index bedbf519..658f57e5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,6 +17,7 @@
 Release
 Debug
 Win32-Output
+out
 .vs
 .deps
 .libs
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9978ea40..bdbc87b8 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,4 +1,5 @@
-  cmake_minimum_required(VERSION 3.3)
+cmake_minimum_required(VERSION 3.12)
+set(CMAKE_CONFIGURATION_TYPES "Release;Debug;ASAN")
 project(openvpn)
 
 # This CMake file implements building OpenVPN with CMAKE
@@ -11,10 +12,6 @@ project(openvpn)
 # and OpenSSL having version 1.1.1+ and generally does not offer the same
 # configurability like autoconf
 
-# -DCMAKE_TOOLCHAIN_FILE=C:/Users/User/source/repos/vcpkg/scripts/buildsystems/vcpkg.cmake
-#-DVCPKG_OVERLAY_PORTS=C:/Users/User/source/repos/openvpn/contrib/vcpkg-ports
-#-GNinja
-
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
 
 if (NOT WIN32 AND NOT ${UNSUPPORTED_BUILDS})
@@ -23,48 +20,83 @@ endif()
 
 option(MBED "BUILD with mbed" OFF)
 option(WOLFSSL "BUILD with wolfSSL" OFF)
-if (MSVC)
-    option(USE_WERROR "Treat compiler warnings as errors (-Werror)" OFF)
-else ()
-    option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
-endif ()
-option(PLUGIN_DIR "Location of the plugin directory" /usr/local/lib/openvpn/plugins)
+option(ENABLE_LZ4 "BUILD with lz4" ON)
+option(ENABLE_LZO "BUILD with lzo" ON)
+option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
+option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
+
+set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of the plugin directory")
 
 # AddressSanitize - use CXX=clang++ CC=clang cmake -DCMAKE_BUILD_TYPE=asan to build with ASAN
 set(CMAKE_C_FLAGS_ASAN
-        "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-        CACHE STRING "Flags used by the C compiler during AddressSanitizer builds."
-        FORCE)
+    "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+    CACHE STRING "Flags used by the C compiler during AddressSanitizer builds."
+    FORCE)
 set(CMAKE_CXX_FLAGS_ASAN
-        "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-        CACHE STRING "Flags used by the C++ compiler during AddressSanitizer builds."
-        FORCE)
+    "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+    CACHE STRING "Flags used by the C++ compiler during AddressSanitizer builds."
+    FORCE)
 
 if (MSVC)
-    target_compile_options(${target} PRIVATE /W3)
+    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_WINSOCK_DEPRECATED_NO_WARNINGS)
+    if (USE_WERROR)
+        add_compile_options(/WX)
+    endif ()
+    add_compile_options(
+        /MP
+        /W2
+        /sdl
+        /Qspectre
+        /guard:cf
+        /FC
+        /ZH:SHA_256
+        "$<$<CONFIG:Release>:/GL>"
+        "$<$<CONFIG:Release>:/Oi>"
+        "$<$<CONFIG:Release>:/Gy>"
+        "$<$<CONFIG:Release>:/Zi>"
+        )
+    add_link_options(
+        "$<$<CONFIG:Release>:/LTCG:incremental>"
+        "$<$<CONFIG:Release>:/DEBUG:FULL>"
+        "$<$<CONFIG:Release>:/OPT:REF>"
+        "$<$<CONFIG:Release>:/OPT:ICF>"
+        )
+    if (${CMAKE_GENERATOR_PLATFORM} STREQUAL "x64" OR ${CMAKE_GENERATOR_PLATFORM} STREQUAL "x86")
+        add_link_options("$<$<CONFIG:Release>:/CETCOMPAT>")
+    endif()
 else ()
-    add_compile_options(-Wall -Wuninitialized)
+    set(CMAKE_C_FLAGS_RELEASE "-O2")
+    set(CMAKE_CXX_FLAGS_RELEASE "-O2")
+    set(CMAKE_C_FLAGS_DEBUG "-g -O1")
+    set(CMAKE_CXX_FLAGS_DEBUG "-g -O1")
+    add_compile_options(-Wall -Wuninitialized -Wno-stringop-truncation)
     # We are not ready for this
-    #add_compile_options(-Wsign-compare)
+    #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)
+    if (USE_WERROR)
+        add_compile_options(-Werror)
+    endif ()
 endif ()
 
-find_package(PkgConfig)
-INCLUDE(CheckSymbolExists)
-INCLUDE(CheckIncludeFiles)
-INCLUDE(CheckTypeSize)
-INCLUDE(CheckStructHasMember)
+find_package(PkgConfig REQUIRED)
+include(CheckSymbolExists)
+include(CheckIncludeFiles)
+include(CheckTypeSize)
+include(CheckStructHasMember)
+include(CTest)
 
-set(OPENVPN_VERSION_MAJOR 2)
-set(OPENVPN_VERSION_MINOR 6)
-set(OPENVPN_VERSION_PATCH _git)
+find_program(PYTHON NAMES python3 python)
+execute_process(
+    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
+    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
+    )
+include(${CMAKE_CURRENT_BINARY_DIR}/version.cmake)
 
-if (NOT WIN32)
-    add_definitions(-DPLUGIN_LIBDIR=\"${PLUGIN_DIR}\")
-endif ()
-
-# TODO remove later when msvc-config.h is removed and we can always include config.h
-add_definitions(-DHAVE_CONFIG_H)
+set(OPENVPN_VERSION_MAJOR ${PRODUCT_VERSION_MAJOR})
+set(OPENVPN_VERSION_MINOR ${PRODUCT_VERSION_MINOR})
+set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})
+set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})
 
+set(CMAKE_C_STANDARD 99)
 
 # Set the various defines for config.h.cmake.in
 if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
@@ -97,139 +129,133 @@ elseif (WIN32)
     set(TARGET_WIN32 YES)
 endif ()
 
-CHECK_SYMBOL_EXISTS(chroot unistd.h HAVE_CHROOT)
-CHECK_SYMBOL_EXISTS(chdir unistd.h HAVE_CHDIR)
-CHECK_SYMBOL_EXISTS(dup unistd.h HAVE_DUP)
-CHECK_SYMBOL_EXISTS(dup2 unistd.h HAVE_DUP2)
-CHECK_SYMBOL_EXISTS(fork unistd.h HAVE_FORK)
-CHECK_SYMBOL_EXISTS(execve unistd.h HAVE_EXECVE)
-CHECK_SYMBOL_EXISTS(ftruncate unistd.h HAVE_FTRUNCATE)
-CHECK_SYMBOL_EXISTS(setgid unistd.h HAVE_SETGID)
-CHECK_SYMBOL_EXISTS(setuid unistd.h HAVE_SETUID)
-CHECK_SYMBOL_EXISTS(getpeereid unistd.h HAVE_GETPEEREID)
-
-CHECK_SYMBOL_EXISTS(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
-
-CHECK_SYMBOL_EXISTS(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
-CHECK_SYMBOL_EXISTS(basename libgen.h HAVE_BASENAME)
-CHECK_SYMBOL_EXISTS(chsize io.h HAVE_CHSIZE)
-CHECK_SYMBOL_EXISTS(daemon stdlib.h HAVE_DAEMON)
-CHECK_SYMBOL_EXISTS(dirname libgen.h HAVE_DIRNAME)
-CHECK_SYMBOL_EXISTS(getrlimit sys/resource.h HAVE_GETRLIMIT)
-CHECK_SYMBOL_EXISTS(mlockall sys/mman.h HAVE_MLOCKALL)
-
-CHECK_SYMBOL_EXISTS(sendmsg sys/socket.h HAVE_SENDMSG)
-CHECK_SYMBOL_EXISTS(recvmsg sys/socket.h HAVE_RECVMSG)
-CHECK_SYMBOL_EXISTS(cmsghdr sys/socket.h HAVE_CMSGHDR)
-CHECK_SYMBOL_EXISTS(openlog syslog.h HAVE_OPENLOG)
-CHECK_SYMBOL_EXISTS(syslog syslog.h HAVE_SYSLOG)
-CHECK_SYMBOL_EXISTS(getgrnam grp.h HAVE_GETGRNAM)
-CHECK_SYMBOL_EXISTS(getpwnam pwd.h HAVE_GETPWNAM)
-CHECK_SYMBOL_EXISTS(getsockname sys/socket.h HAVE_GETSOCKNAME)
+check_symbol_exists(chroot unistd.h HAVE_CHROOT)
+check_symbol_exists(chdir unistd.h HAVE_CHDIR)
+check_symbol_exists(dup unistd.h HAVE_DUP)
+check_symbol_exists(dup2 unistd.h HAVE_DUP2)
+check_symbol_exists(fork unistd.h HAVE_FORK)
+check_symbol_exists(execve unistd.h HAVE_EXECVE)
+check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
+check_symbol_exists(setgid unistd.h HAVE_SETGID)
+check_symbol_exists(setuid unistd.h HAVE_SETUID)
+check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)
+
+check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
+
+check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
+check_symbol_exists(basename libgen.h HAVE_BASENAME)
+check_symbol_exists(chsize io.h HAVE_CHSIZE)
+check_symbol_exists(daemon stdlib.h HAVE_DAEMON)
+check_symbol_exists(dirname libgen.h HAVE_DIRNAME)
+check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
+check_symbol_exists(mlockall sys/mman.h HAVE_MLOCKALL)
+
+check_symbol_exists(sendmsg sys/socket.h HAVE_SENDMSG)
+check_symbol_exists(recvmsg sys/socket.h HAVE_RECVMSG)
+check_symbol_exists(cmsghdr sys/socket.h HAVE_CMSGHDR)
+check_symbol_exists(openlog syslog.h HAVE_OPENLOG)
+check_symbol_exists(syslog syslog.h HAVE_SYSLOG)
+check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
+check_symbol_exists(getpwnam pwd.h HAVE_GETPWNAM)
+check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)
 
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
-SET(NETEXTRA sys/types.h)
-CHECK_INCLUDE_FILES("${NETEXTRA};netinet/in.h" HAVE_NETINET_IN_H)
+set(NETEXTRA sys/types.h)
+check_include_files("${NETEXTRA};netinet/in.h" HAVE_NETINET_IN_H)
 
 if (HAVE_NETINET_IN_H)
-    LIST(APPEND NETEXTRA netinet/in.h)
+    list(APPEND NETEXTRA netinet/in.h)
 endif ()
 
-CHECK_INCLUDE_FILES("${NETEXTRA};netinet/in6.h" HAVE_NETINET_IN_H)
-CHECK_INCLUDE_FILES(linux/if_tun.h HAVE_LINUX_IF_TUN_H)
-CHECK_INCLUDE_FILES(linux/sockios.h HAVE_LINUX_SOCKIOS_H)
-CHECK_INCLUDE_FILES(dlfcn.h HAVE_DLFCN_H)
-CHECK_INCLUDE_FILES(fcntl.h HAVE_FCNTL_H)
-CHECK_INCLUDE_FILES(dmalloc.h HAVE_DMALLOC_H)
-CHECK_INCLUDE_FILES(err.h HAVE_ERR_H)
-CHECK_INCLUDE_FILES(sys/epoll.h HAVE_SYS_EPOLL_H)
-CHECK_INCLUDE_FILES(poll.h HAVE_POLL_H)
-CHECK_INCLUDE_FILES(sys/socket.h HAVE_SYS_SOCKET_H)
-CHECK_INCLUDE_FILES(sys/time.h HAVE_SYS_TIME_H)
-CHECK_INCLUDE_FILES(netdb.h HAVE_NETDB_H)
-CHECK_INCLUDE_FILES(unistd.h HAVE_UNISTD_H)
-CHECK_INCLUDE_FILES(sys/un.h HAVE_SYS_UN_H)
-CHECK_INCLUDE_FILES(libgen.h HAVE_LIBGEN_H)
-CHECK_INCLUDE_FILES(net/if.h HAVE_NET_IF_H)
-CHECK_INCLUDE_FILES("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
-CHECK_INCLUDE_FILES(arpa/inet.h HAVE_ARPA_INET_H)
-CHECK_INCLUDE_FILES(net/if_utun.h HAVE_NET_UTUN_H)
-CHECK_INCLUDE_FILES(sys/ioctl.h HAVE_SYS_IOCTL_H)
-CHECK_INCLUDE_FILES(sys/inotify.h HAVE_SYS_INOTIFY_H)
-CHECK_INCLUDE_FILES("${NETEXTRA};sys/uio.h" HAVE_SYS_UIO_H)
-CHECK_INCLUDE_FILES(syslog.h HAVE_SYSLOG_H)
-CHECK_INCLUDE_FILES(sys/wait.h HAVE_SYS_WAIT_H)
-CHECK_INCLUDE_FILES(grp.h HAVE_GRP_H)
-CHECK_INCLUDE_FILES(pwd.h HAVE_PWD_H)
-CHECK_INCLUDE_FILES(sys/mman.h HAVE_SYS_MMAN_H)
-
-
-CHECK_INCLUDE_FILES("${NETEXTRA};resolv.h" HAVE_RESOLV_H)
-CHECK_INCLUDE_FILES("${NETEXTRA};net/if_tun.h" HAVE_NET_IF_TUN_H)
-
-# Is this obscure header needed anywhere?!
-CHECK_INCLUDE_FILES(netinet/in_systm.h HAVE_NETINET_IN_SYSTM_H)
-
-
-SET(CMAKE_EXTRA_INCLUDE_FILES netinet/ip.h)
-CHECK_TYPE_SIZE("struct in_pktinfo" IN_PKTINFO)
-CHECK_STRUCT_HAS_MEMBER("struct in_pktinfo" ipi_spec_dst netinet/ip.h HAVE_IPI_SPEC_DST)
-CHECK_TYPE_SIZE("struct msghdr" MSGHDR)
-SET(CMAKE_EXTRA_INCLUDE_FILES)
+check_include_files("${NETEXTRA};netinet/in6.h" HAVE_NETINET_IN_H)
+check_include_files(linux/if_tun.h HAVE_LINUX_IF_TUN_H)
+check_include_files(linux/sockios.h HAVE_LINUX_SOCKIOS_H)
+check_include_files(dlfcn.h HAVE_DLFCN_H)
+check_include_files(fcntl.h HAVE_FCNTL_H)
+check_include_files(dmalloc.h HAVE_DMALLOC_H)
+check_include_files(err.h HAVE_ERR_H)
+check_include_files(sys/epoll.h HAVE_SYS_EPOLL_H)
+check_include_files(poll.h HAVE_POLL_H)
+check_include_files(sys/socket.h HAVE_SYS_SOCKET_H)
+check_include_files(sys/time.h HAVE_SYS_TIME_H)
+check_include_files(netdb.h HAVE_NETDB_H)
+check_include_files(unistd.h HAVE_UNISTD_H)
+check_include_files(sys/un.h HAVE_SYS_UN_H)
+check_include_files(libgen.h HAVE_LIBGEN_H)
+check_include_files(net/if.h HAVE_NET_IF_H)
+check_include_files("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
+check_include_files(arpa/inet.h HAVE_ARPA_INET_H)
+check_include_files(net/if_utun.h HAVE_NET_UTUN_H)
+check_include_files(sys/ioctl.h HAVE_SYS_IOCTL_H)
+check_include_files(sys/inotify.h HAVE_SYS_INOTIFY_H)
+check_include_files("${NETEXTRA};sys/uio.h" HAVE_SYS_UIO_H)
+check_include_files(syslog.h HAVE_SYSLOG_H)
+check_include_files(sys/wait.h HAVE_SYS_WAIT_H)
+check_include_files(grp.h HAVE_GRP_H)
+check_include_files(pwd.h HAVE_PWD_H)
+check_include_files(sys/mman.h HAVE_SYS_MMAN_H)
+
+
+check_include_files("${NETEXTRA};resolv.h" HAVE_RESOLV_H)
+check_include_files("${NETEXTRA};net/if_tun.h" HAVE_NET_IF_TUN_H)
+
+set(CMAKE_EXTRA_INCLUDE_FILES netinet/ip.h)
+check_type_size("struct in_pktinfo" IN_PKTINFO)
+check_struct_has_member("struct in_pktinfo" ipi_spec_dst netinet/ip.h HAVE_IPI_SPEC_DST)
+check_type_size("struct msghdr" MSGHDR)
+set(CMAKE_EXTRA_INCLUDE_FILES)
 
 find_program(IFCONFIG_PATH ifconfig)
 find_program(IPROUTE_PATH ip)
 find_program(ROUTE_PATH route)
 
+if (${ENABLE_LZ4})
+    pkg_search_module(liblz4 liblz4 REQUIRED IMPORTED_TARGET)
+endif ()
 
-if (NOT WIN32)
-    set(ENABLE_LZ4 YES)
-    set(ENABLE_LZO YES)
+if (${ENABLE_LZO})
+    pkg_search_module(lzo2 lzo2 REQUIRED IMPORTED_TARGET)
+endif ()
+
+if (${ENABLE_PKCS11})
+    pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED_TARGET)
 endif ()
 
 function(add_library_deps target)
     if (${MBED})
-        target_include_directories(${target} PRIVATE $ENV{HOME}/oss/mbedtls2/include)
-        message("Building ${target} for mbed TLS")
-        target_link_libraries(${target} PUBLIC -L$ENV{HOME}/oss/mbedtls2/library -L/usr/local/opt/lzo/lib -lmbedtls -lmbedx509 -lmbedcrypto)
+        target_link_libraries(${target} -lmbedtls -lmbedx509 -lmbedcrypto)
     elseif (${WOLFSSL})
         pkg_search_module(wolfssl wolfssl REQUIRED)
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
         target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)
-        message("Building ${target} for WolfSSL: ${wolfssl_LINK_LIBRARIES} ${wolfssl_INCLUDE_DIRS}/wolfsll")
     else ()
         set(ENABLE_X509ALTUSERNAME YES)
 
         find_package(OpenSSL REQUIRED)
-        target_link_libraries(${target} PUBLIC OpenSSL::SSL)
-
-        message("Building ${target} for default OpenSSL")
-    endif ()
-
+        target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)
+        if (WIN32)
+            target_link_libraries(${target} PUBLIC
+                ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi.lib
+                wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib)
+        endif ()
 
-    if (${ENABLE_LZ4})
-        pkg_search_module(liblz4 liblz4 REQUIRED IMPORTED_TARGET)
-        target_link_libraries(${target} PUBLIC PkgConfig::liblz4)
     endif ()
 
-    if (${ENABLE_LZO})
-        pkg_search_module(lzo2 lzo2 REQUIRED IMPORTED_TARGET)
-        target_link_libraries(${target} PUBLIC PkgConfig::lzo2)
-    endif ()
+    # optional dependencies
+    target_link_libraries(${target} PUBLIC
+        $<TARGET_NAME_IF_EXISTS:PkgConfig::liblz4>
+        $<TARGET_NAME_IF_EXISTS:PkgConfig::lzo2>
+        $<TARGET_NAME_IF_EXISTS:PkgConfig::pkcs11-helper>
+        )
 
     if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
-        target_include_directories(${target} PUBLIC ${LIBNL_INCLUDE_DIRS})
-        target_link_libraries(${target} PUBLIC ${LIBNL_LIBRARIES})
-    endif ()
+        pkg_search_module(libcapng REQUIRED libcap-ng IMPORTED_TARGET)
+        pkg_search_module(libnl REQUIRED libnl-genl-3.0 IMPORTED_TARGET)
 
-    if (USE_WERROR)
-        if (MSVC)
-            target_compile_options(${target} PRIVATE /WX)
-        else ()
-            target_compile_options(${target} PRIVATE -Werror)
-        endif ()
+        target_link_libraries(${target} PUBLIC PkgConfig::libcapng PkgConfig::libnl)
     endif ()
+
 endfunction()
 
 if (${MBED})
@@ -245,240 +271,254 @@ endif ()
 
 include_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)
 
-if (WIN32)
-    find_package(OpenSSL REQUIRED)
-
-    link_libraries(OpenSSL::SSL OpenSSL::Crypto ws2_32.lib Crypt32.lib fwpuclnt.lib iphlpapi.lib
-            wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib Ncrypt.lib)
-    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D _WINSOCK_DEPRECATED_NO_WARNINGS -D_CONSOLE)
-endif ()
+add_custom_command(
+    OUTPUT always_rebuild config-version.h
+    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py
+    )
+set(HAVE_CONFIG_VERSION_H YES)
 
 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
+# TODO remove later when msvc-config.h is removed and we can always include config.h
+add_definitions(-DHAVE_CONFIG_H)
 
 include_directories(${CMAKE_CURRENT_BINARY_DIR})
 
-set(SOURCE_FILES
-        ${CMAKE_CURRENT_BINARY_DIR}/config.h
-        ${CMAKE_CURRENT_BINARY_DIR}/openvpn-plugin.h
+add_subdirectory(doc)
+add_subdirectory(src/openvpnmsica)
+add_subdirectory(src/openvpnserv)
+add_subdirectory(src/tapctl)
 
-        src/compat/compat-basename.c
-        src/compat/compat-daemon.c
-        src/compat/compat-dirname.c
-        src/compat/compat-gettimeofday.c
-        src/compat/compat-strsep.c
-        src/compat/compat-versionhelpers.h
-        src/openvpn/argv.c
-        src/openvpn/argv.h
-        src/openvpn/base64.c
-        src/openvpn/base64.h
-        src/openvpn/basic.h
-        src/openvpn/block_dns.h
-        src/openvpn/block_dns.c
-        src/openvpn/buffer.c
-        src/openvpn/buffer.h
-        src/openvpn/circ_list.h
-        src/openvpn/clinat.c
-        src/openvpn/clinat.h
-        src/openvpn/common.h
-        src/openvpn/comp-lz4.c
-        src/openvpn/comp-lz4.h
-        src/openvpn/comp.c
-        src/openvpn/comp.h
-        src/openvpn/compstub.c
-        src/openvpn/console.c
-        src/openvpn/console_builtin.c
-        src/openvpn/console.h
-        src/openvpn/crypto.c
-        src/openvpn/crypto.h
-        src/openvpn/crypto_backend.h
-        src/openvpn/crypto_openssl.c
-        src/openvpn/crypto_openssl.h
-        src/openvpn/crypto_mbedtls.c
-        src/openvpn/crypto_mbedtls.h
-        src/openvpn/cryptoapi.c
-        src/openvpn/cryptoapi.h
-        src/openvpn/dco.c
-        src/openvpn/dco.h
-        src/openvpn/dco_win.c
-        src/openvpn/dco_win.h
-        src/openvpn/dco_linux.c
-        src/openvpn/dco_linux.h
-        src/openvpn/dco_freebsd.c
-        src/openvpn/dco_freebsd.h
-        src/openvpn/dhcp.c
-        src/openvpn/dhcp.h
-        src/openvpn/dns.c
-        src/openvpn/dns.h
-        src/openvpn/errlevel.h
-        src/openvpn/env_set.c
-        src/openvpn/env_set.h
-        src/openvpn/error.c
-        src/openvpn/error.h
-        src/openvpn/event.c
-        src/openvpn/event.h
-        src/openvpn/fdmisc.c
-        src/openvpn/fdmisc.h
-        src/openvpn/forward.c
-        src/openvpn/forward.h
-        src/openvpn/fragment.c
-        src/openvpn/fragment.h
-        src/openvpn/gremlin.c
-        src/openvpn/gremlin.h
-        src/openvpn/helper.c
-        src/openvpn/helper.h
-        src/openvpn/httpdigest.c
-        src/openvpn/httpdigest.h
-        src/openvpn/init.c
-        src/openvpn/init.h
-        src/openvpn/integer.h
-        src/openvpn/interval.c
-        src/openvpn/interval.h
-        src/openvpn/list.c
-        src/openvpn/list.h
-        src/openvpn/lladdr.c
-        src/openvpn/lladdr.h
-        src/openvpn/lzo.c
-        src/openvpn/lzo.h
-        src/openvpn/manage.c
-        src/openvpn/manage.h
-        src/openvpn/mbuf.c
-        src/openvpn/mbuf.h
-        src/openvpn/memdbg.h
-        src/openvpn/misc.c
-        src/openvpn/misc.h
-        src/openvpn/mroute.c
-        src/openvpn/mroute.h
-        src/openvpn/mss.c
-        src/openvpn/mss.h
-        src/openvpn/mstats.c
-        src/openvpn/mstats.h
-        src/openvpn/mtcp.c
-        src/openvpn/mtcp.h
-        src/openvpn/mtu.c
-        src/openvpn/mtu.h
-        src/openvpn/mudp.c
-        src/openvpn/mudp.h
-        src/openvpn/multi.c
-        src/openvpn/multi.h
-        src/openvpn/ntlm.c
-        src/openvpn/ntlm.h
-        src/openvpn/occ.c
-        src/openvpn/occ.h
-        src/openvpn/openvpn.c
-        src/openvpn/openvpn.h
-        src/openvpn/options.c
-        src/openvpn/options.h
-        src/openvpn/options_util.c
-        src/openvpn/options_util.h
-        src/openvpn/otime.c
-        src/openvpn/otime.h
-        src/openvpn/ovpn_dco_win.h
-        src/openvpn/packet_id.c
-        src/openvpn/packet_id.h
-        src/openvpn/perf.c
-        src/openvpn/perf.h
-        src/openvpn/ping.c
-        src/openvpn/ping.h
-        src/openvpn/pkcs11.c
-        src/openvpn/pkcs11.h
-        src/openvpn/pkcs11_backend.h
-        src/openvpn/pkcs11_openssl.c
-        src/openvpn/pkcs11_mbedtls.c
-        src/openvpn/platform.c
-        src/openvpn/platform.h
-        src/openvpn/plugin.c
-        src/openvpn/plugin.h
-        src/openvpn/pool.c
-        src/openvpn/pool.h
-        src/openvpn/proto.c
-        src/openvpn/proto.h
-        src/openvpn/proxy.c
-        src/openvpn/proxy.h
-        src/openvpn/ps.c
-        src/openvpn/ps.h
-        src/openvpn/push.c
-        src/openvpn/push.h
-        src/openvpn/pushlist.h
-        src/openvpn/reliable.c
-        src/openvpn/reliable.h
-        src/openvpn/route.c
-        src/openvpn/route.h
-        src/openvpn/run_command.c
-        src/openvpn/run_command.h
-        src/openvpn/schedule.c
-        src/openvpn/schedule.h
-        src/openvpn/session_id.c
-        src/openvpn/session_id.h
-        src/openvpn/shaper.c
-        src/openvpn/shaper.h
-        src/openvpn/sig.c
-        src/openvpn/sig.h
-        src/openvpn/socket.c
-        src/openvpn/socket.h
-        src/openvpn/socks.c
-        src/openvpn/socks.h
-        src/openvpn/ssl.c
-        src/openvpn/ssl.h
-        src/openvpn/ssl_backend.h
-        src/openvpn/ssl_common.h
-        src/openvpn/ssl_openssl.c
-        src/openvpn/ssl_openssl.h
-        src/openvpn/ssl_mbedtls.c
-        src/openvpn/ssl_mbedtls.h
-        src/openvpn/ssl_verify.c
-        src/openvpn/ssl_verify.h
-        src/openvpn/ssl_verify_backend.h
-        src/openvpn/ssl_verify_openssl.c
-        src/openvpn/ssl_verify_openssl.h
-        src/openvpn/ssl_verify_mbedtls.c
-        src/openvpn/ssl_verify_mbedtls.h
-        src/openvpn/status.c
-        src/openvpn/status.h
-        src/openvpn/syshead.h
-        src/openvpn/tls_crypt.c
-        src/openvpn/tun.c
-        src/openvpn/tun.h
-        src/openvpn/networking_sitnl.c
-        src/openvpn/networking_freebsd.c
-        src/openvpn/auth_token.c
-        src/openvpn/auth_token.h
-        src/openvpn/ssl_ncp.c
-        src/openvpn/ssl_ncp.h
-        src/openvpn/ssl_pkt.c
-        src/openvpn/ssl_pkt.h
-        src/openvpn/ssl_util.c
-        src/openvpn/ssl_util.h
-        src/openvpn/vlan.c
-        src/openvpn/vlan.h
-        src/openvpn/win32.c
-        src/openvpn/win32-util.c
-        src/openvpn/win32.h
-        src/openvpn/win32-util.h
-        src/openvpn/xkey_helper.c
-        src/openvpn/xkey_provider.c
-        )
+set(SOURCE_FILES
+    ${CMAKE_CURRENT_BINARY_DIR}/config.h
+    ${CMAKE_CURRENT_BINARY_DIR}/config-version.h
+    ${CMAKE_CURRENT_BINARY_DIR}/openvpn-plugin.h
+
+    src/compat/compat-basename.c
+    src/compat/compat-daemon.c
+    src/compat/compat-dirname.c
+    src/compat/compat-gettimeofday.c
+    src/compat/compat-strsep.c
+    src/compat/compat-versionhelpers.h
+    src/openvpn/argv.c
+    src/openvpn/argv.h
+    src/openvpn/base64.c
+    src/openvpn/base64.h
+    src/openvpn/basic.h
+    src/openvpn/block_dns.h
+    src/openvpn/block_dns.c
+    src/openvpn/buffer.c
+    src/openvpn/buffer.h
+    src/openvpn/circ_list.h
+    src/openvpn/clinat.c
+    src/openvpn/clinat.h
+    src/openvpn/common.h
+    src/openvpn/comp-lz4.c
+    src/openvpn/comp-lz4.h
+    src/openvpn/comp.c
+    src/openvpn/comp.h
+    src/openvpn/compstub.c
+    src/openvpn/console.c
+    src/openvpn/console_builtin.c
+    src/openvpn/console.h
+    src/openvpn/crypto.c
+    src/openvpn/crypto.h
+    src/openvpn/crypto_backend.h
+    src/openvpn/crypto_openssl.c
+    src/openvpn/crypto_openssl.h
+    src/openvpn/crypto_mbedtls.c
+    src/openvpn/crypto_mbedtls.h
+    src/openvpn/cryptoapi.c
+    src/openvpn/cryptoapi.h
+    src/openvpn/dco.c
+    src/openvpn/dco.h
+    src/openvpn/dco_win.c
+    src/openvpn/dco_win.h
+    src/openvpn/dco_linux.c
+    src/openvpn/dco_linux.h
+    src/openvpn/dco_freebsd.c
+    src/openvpn/dco_freebsd.h
+    src/openvpn/dhcp.c
+    src/openvpn/dhcp.h
+    src/openvpn/dns.c
+    src/openvpn/dns.h
+    src/openvpn/errlevel.h
+    src/openvpn/env_set.c
+    src/openvpn/env_set.h
+    src/openvpn/error.c
+    src/openvpn/error.h
+    src/openvpn/event.c
+    src/openvpn/event.h
+    src/openvpn/fdmisc.c
+    src/openvpn/fdmisc.h
+    src/openvpn/forward.c
+    src/openvpn/forward.h
+    src/openvpn/fragment.c
+    src/openvpn/fragment.h
+    src/openvpn/gremlin.c
+    src/openvpn/gremlin.h
+    src/openvpn/helper.c
+    src/openvpn/helper.h
+    src/openvpn/httpdigest.c
+    src/openvpn/httpdigest.h
+    src/openvpn/init.c
+    src/openvpn/init.h
+    src/openvpn/integer.h
+    src/openvpn/interval.c
+    src/openvpn/interval.h
+    src/openvpn/list.c
+    src/openvpn/list.h
+    src/openvpn/lladdr.c
+    src/openvpn/lladdr.h
+    src/openvpn/lzo.c
+    src/openvpn/lzo.h
+    src/openvpn/manage.c
+    src/openvpn/manage.h
+    src/openvpn/mbuf.c
+    src/openvpn/mbuf.h
+    src/openvpn/memdbg.h
+    src/openvpn/misc.c
+    src/openvpn/misc.h
+    src/openvpn/mroute.c
+    src/openvpn/mroute.h
+    src/openvpn/mss.c
+    src/openvpn/mss.h
+    src/openvpn/mstats.c
+    src/openvpn/mstats.h
+    src/openvpn/mtcp.c
+    src/openvpn/mtcp.h
+    src/openvpn/mtu.c
+    src/openvpn/mtu.h
+    src/openvpn/mudp.c
+    src/openvpn/mudp.h
+    src/openvpn/multi.c
+    src/openvpn/multi.h
+    src/openvpn/ntlm.c
+    src/openvpn/ntlm.h
+    src/openvpn/occ.c
+    src/openvpn/occ.h
+    src/openvpn/openvpn.c
+    src/openvpn/openvpn.h
+    src/openvpn/openvpn_win32_resources.rc
+    src/openvpn/options.c
+    src/openvpn/options.h
+    src/openvpn/options_util.c
+    src/openvpn/options_util.h
+    src/openvpn/otime.c
+    src/openvpn/otime.h
+    src/openvpn/ovpn_dco_win.h
+    src/openvpn/packet_id.c
+    src/openvpn/packet_id.h
+    src/openvpn/perf.c
+    src/openvpn/perf.h
+    src/openvpn/ping.c
+    src/openvpn/ping.h
+    src/openvpn/pkcs11.c
+    src/openvpn/pkcs11.h
+    src/openvpn/pkcs11_backend.h
+    src/openvpn/pkcs11_openssl.c
+    src/openvpn/pkcs11_mbedtls.c
+    src/openvpn/platform.c
+    src/openvpn/platform.h
+    src/openvpn/plugin.c
+    src/openvpn/plugin.h
+    src/openvpn/pool.c
+    src/openvpn/pool.h
+    src/openvpn/proto.c
+    src/openvpn/proto.h
+    src/openvpn/proxy.c
+    src/openvpn/proxy.h
+    src/openvpn/ps.c
+    src/openvpn/ps.h
+    src/openvpn/push.c
+    src/openvpn/push.h
+    src/openvpn/pushlist.h
+    src/openvpn/reflect_filter.c
+    src/openvpn/reflect_filter.h
+    src/openvpn/reliable.c
+    src/openvpn/reliable.h
+    src/openvpn/route.c
+    src/openvpn/route.h
+    src/openvpn/run_command.c
+    src/openvpn/run_command.h
+    src/openvpn/schedule.c
+    src/openvpn/schedule.h
+    src/openvpn/session_id.c
+    src/openvpn/session_id.h
+    src/openvpn/shaper.c
+    src/openvpn/shaper.h
+    src/openvpn/sig.c
+    src/openvpn/sig.h
+    src/openvpn/socket.c
+    src/openvpn/socket.h
+    src/openvpn/socks.c
+    src/openvpn/socks.h
+    src/openvpn/ssl.c
+    src/openvpn/ssl.h
+    src/openvpn/ssl_backend.h
+    src/openvpn/ssl_common.h
+    src/openvpn/ssl_openssl.c
+    src/openvpn/ssl_openssl.h
+    src/openvpn/ssl_mbedtls.c
+    src/openvpn/ssl_mbedtls.h
+    src/openvpn/ssl_verify.c
+    src/openvpn/ssl_verify.h
+    src/openvpn/ssl_verify_backend.h
+    src/openvpn/ssl_verify_openssl.c
+    src/openvpn/ssl_verify_openssl.h
+    src/openvpn/ssl_verify_mbedtls.c
+    src/openvpn/ssl_verify_mbedtls.h
+    src/openvpn/status.c
+    src/openvpn/status.h
+    src/openvpn/syshead.h
+    src/openvpn/tls_crypt.c
+    src/openvpn/tun.c
+    src/openvpn/tun.h
+    src/openvpn/networking_sitnl.c
+    src/openvpn/networking_freebsd.c
+    src/openvpn/auth_token.c
+    src/openvpn/auth_token.h
+    src/openvpn/ssl_ncp.c
+    src/openvpn/ssl_ncp.h
+    src/openvpn/ssl_pkt.c
+    src/openvpn/ssl_pkt.h
+    src/openvpn/ssl_util.c
+    src/openvpn/ssl_util.h
+    src/openvpn/vlan.c
+    src/openvpn/vlan.h
+    src/openvpn/win32.c
+    src/openvpn/win32-util.c
+    src/openvpn/win32.h
+    src/openvpn/win32-util.h
+    src/openvpn/xkey_helper.c
+    src/openvpn/xkey_provider.c
+    )
 
 add_executable(openvpn ${SOURCE_FILES})
 
 add_library_deps(openvpn)
 
-if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
-    target_link_libraries(openvpn PUBLIC -ldl)
-
-    find_package(PkgConfig)
-    pkg_search_module(LIBNL REQUIRED libnl-genl-3.0)
-
-    target_link_libraries(openvpn PUBLIC ${LIBNL_LIBRARIES})
-    target_include_directories(openvpn PRIVATE ${LIBNL_INCLUDE_DIRS})
-endif ()
-
-
 if (MINGW)
+    target_compile_options(openvpn PRIVATE
+        -DWIN32_LEAN_AND_MEAN
+        -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+        )
+    target_compile_options(openvpn PRIVATE -municode -UUNICODE)
     target_link_options(openvpn PRIVATE -municode)
+endif()
+
+if (MSVC)
+    # we have our own manifest
+    target_link_options(openvpn PRIVATE /MANIFEST:NO)
+endif()
+
+if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+    target_link_libraries(openvpn PUBLIC -ldl)
 endif ()
 
 if (NOT WIN32)
+    target_compile_options(openvpn PRIVATE -DPLUGIN_LIBDIR=\"${PLUGIN_DIR}\")
+
     find_library(resolv resolv)
     # some platform like BSDs already include resolver functionality in the libc and not have an extra resolv library
     if (${resolv} OR APPLE)
@@ -487,58 +527,155 @@ if (NOT WIN32)
 endif ()
 
 
-pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
-enable_testing()
+if (BUILD_TESTING)
+    find_package(cmocka CONFIG)
+    if (TARGET cmocka::cmocka)
+        set(CMOCKA_LIBRARIES cmocka::cmocka)
+    else ()
+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
+        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
+    endif ()
 
-SET(unit_tests "test_packet_id" "test_crypto" "test_ncp" "test_auth_token" "test_misc" "test_buffer" "test_provider" "test_pkt")
+    set(unit_tests
+        "test_auth_token"
+        "test_buffer"
+        "test_crypto"
+        "test_misc"
+        "test_ncp"
+        "test_packet_id"
+        "test_pkt"
+        "test_provider"
+        )
 
-# These tests work on only on Linux since they depend on special linker features
-if (WIN32)
-    LIST(APPEND unit_tests "test_cryptoapi")
-elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
-    LIST(APPEND unit_tests "test_networking" "test_tls_crypt" "test_argv")
-endif ()
+    if (WIN32)
+        list(APPEND unit_tests
+            "test_cryptoapi"
+            )
+    endif ()
+
+    if (NOT MSVC)
+        # MSVC does not support --wrap
+        list(APPEND unit_tests
+            "test_argv"
+            )
+    endif ()
+
+    # These tests work on only on Linux since they depend on special linker features
+    if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+        list(APPEND unit_tests
+            "test_networking"
+            "test_tls_crypt"
+            )
+    endif ()
+
+    if (NOT WIN32 AND ${ENABLE_PKCS11})
+        set(_HAVE_SOFTHSM2 YES)
+        find_program(P11TOOL p11tool)
+        find_program(SOFTHSM2_UTIL softhsm2-util)
+        find_library(SOFTHSM2_MODULE softhsm2 PATH_SUFFIXES softhsm)
+
+        if (P11TOOL STREQUAL "P11TOOL-NOTFOUND")
+            message(STATUS "p11tool not found, pkcs11 UT disabled")
+            set(_HAVE_SOFTHSM2 NO)
+        elseif (SOFTHSM2_UTIL STREQUAL "SOFTHSM2_UTIL-NOTFOUND")
+            message(STATUS "softhsm2-util not found, pkcs11 UT disabled")
+            set(_HAVE_SOFTHSM2 NO)
+        elseif (SOFTHSM2_MODULE STREQUAL "SOFTHSM2_MODULE-NOTFOUND")
+            message(STATUS "softhsm2 module not found, pkcs11 UT disabled")
+            set(_HAVE_SOFTHSM2 NO)
+        endif ()
 
+        if (_HAVE_SOFTHSM2)
+            message(VERBOSE "pkcs11 UT enabled")
+            list(APPEND unit_tests
+                "test_pkcs11"
+                )
+        endif ()
+    endif ()
 
-FOREACH (test_name ${unit_tests})
-    add_executable(${test_name}
+    foreach (test_name ${unit_tests})
+        # test_networking needs special environment
+        if (NOT ${test_name} STREQUAL "test_networking")
+            add_test(${test_name} ${test_name})
+        endif ()
+        add_executable(${test_name}
             tests/unit_tests/openvpn/${test_name}.c
             tests/unit_tests/openvpn/mock_msg.c
+            tests/unit_tests/openvpn/mock_msg.h
             src/openvpn/platform.c
-            src/openvpn/crypto_mbedtls.c
-            src/openvpn/crypto_openssl.c
-            src/openvpn/crypto.c
-            src/openvpn/otime.c
-            src/openvpn/packet_id.c
-            src/openvpn/base64.c
             src/openvpn/win32-util.c
-            src/openvpn/mtu.c
-            src/openvpn/networking_sitnl.c
-            src/compat/compat-strsep.c
             src/compat/compat-gettimeofday.c
-            src/openvpn/ssl_util.c
-            src/openvpn/reliable.c
-            src/openvpn/session_id.c
-            src/openvpn/mss.c
-            src/openvpn/xkey_provider.c
             )
 
-    add_library_deps(${test_name})
-    target_link_libraries(${test_name} PUBLIC PkgConfig::cmocka)
+        add_library_deps(${test_name})
+        target_link_libraries(${test_name} PUBLIC ${CMOCKA_LIBRARIES})
 
-    target_include_directories(${test_name} PRIVATE src/openvpn)
+        target_include_directories(${test_name} PRIVATE src/openvpn)
 
-    if (NOT ${test_name} STREQUAL "test_buffer")
-        target_sources(${test_name} PRIVATE
+        if (NOT ${test_name} STREQUAL "test_buffer")
+            target_sources(${test_name} PRIVATE
                 src/openvpn/buffer.c
                 )
-    endif ()
-    add_test(NAME ${test_name} COMMAND ${test_name})
-ENDFOREACH ()
+        endif ()
+
+    endforeach()
 
-target_sources(test_pkt PRIVATE
+    target_sources(test_auth_token PRIVATE
+        src/openvpn/base64.c
+        src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_openssl.c
+        src/openvpn/crypto.c
+        src/openvpn/otime.c
+        src/openvpn/packet_id.c
+        )
+
+    target_sources(test_buffer PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        )
+
+    target_sources(test_crypto PRIVATE
+        src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_openssl.c
+        src/openvpn/crypto.c
+        src/openvpn/otime.c
+        src/openvpn/packet_id.c
+        src/openvpn/mtu.c
+        src/openvpn/mss.c
+        )
+
+    target_sources(test_misc PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/options_util.c
+        src/openvpn/ssl_util.c
+        )
+
+    target_sources(test_ncp PRIVATE
+        src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_openssl.c
+        src/openvpn/crypto.c
+        src/openvpn/otime.c
+        src/openvpn/packet_id.c
+        src/openvpn/ssl_util.c
+        src/compat/compat-strsep.c
+        )
+
+    target_sources(test_packet_id PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/otime.c
+        src/openvpn/packet_id.c
+        src/openvpn/reliable.c
+        src/openvpn/session_id.c
+        )
+
+    target_sources(test_pkt PRIVATE
         src/openvpn/argv.c
+        src/openvpn/base64.c
+        src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_openssl.c
+        src/openvpn/crypto.c
         src/openvpn/env_set.c
+        src/openvpn/otime.c
+        src/openvpn/packet_id.c
         src/openvpn/reliable.c
         src/openvpn/run_command.c
         src/openvpn/session_id.c
@@ -546,46 +683,83 @@ target_sources(test_pkt PRIVATE
         src/openvpn/tls_crypt.c
         )
 
-if (TARGET test_cryptoapi)
-    target_sources(test_cryptoapi PRIVATE
-            src/openvpn/xkey_helper.c
-            src/openvpn/xkey_provider.c
-            )
-endif ()
-
-target_sources(test_provider PRIVATE
+    target_sources(test_provider PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/xkey_provider.c
         src/openvpn/xkey_helper.c
+        src/openvpn/base64.c
         )
 
-target_sources(test_misc PRIVATE
-        src/openvpn/options_util.c
-        )
-
-IF (TARGET test_tls_crypt)
-    target_sources(test_tls_crypt PRIVATE
-            src/openvpn/argv.c
-            src/openvpn/env_set.c
-            src/openvpn/run_command.c)
-endif ()
-
-if (TARGET test_argv)
-    target_sources(test_argv PRIVATE
+    if (TARGET test_argv)
+        target_link_options(test_argv PRIVATE -Wl,--wrap=parse_line)
+        target_sources(test_argv PRIVATE
+            tests/unit_tests/openvpn/mock_get_random.c
             src/openvpn/argv.c
-            src/openvpn/env_set.c
-            src/openvpn/run_command.c)
-endif ()
+            )
+    endif ()
 
+    if (TARGET test_cryptoapi)
+        target_sources(test_cryptoapi PRIVATE
+            tests/unit_tests/openvpn/mock_get_random.c
+            tests/unit_tests/openvpn/cert_data.h
+            tests/unit_tests/openvpn/pkey_test_utils.c
+            src/openvpn/xkey_provider.c
+            src/openvpn/xkey_helper.c
+            src/openvpn/base64.c
+            )
+    endif ()
 
-FOREACH (test_name "networking" "tls_crypt" "argv")
-    if (TARGET test_${test_name})
-        target_link_options(test_${test_name} PRIVATE -Wl,--wrap=parse_line)
+    if (TARGET test_networking)
+        target_link_options(test_networking PRIVATE -Wl,--wrap=parse_line)
+        target_compile_options(test_networking PRIVATE -UNDEBUG)
+        target_sources(test_networking PRIVATE
+            src/openvpn/networking_sitnl.c
+            src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_openssl.c
+            src/openvpn/crypto.c
+            src/openvpn/otime.c
+            src/openvpn/packet_id.c
+            )
     endif ()
-ENDFOREACH ()
 
-if (TARGET test_tls_crypt)
-    target_link_options("test_tls_crypt" PRIVATE
+    if (TARGET test_tls_crypt)
+        target_link_options(test_tls_crypt PRIVATE -Wl,--wrap=parse_line)
+        target_link_options(test_tls_crypt PRIVATE
             -Wl,--wrap=buffer_read_from_file
             -Wl,--wrap=buffer_write_file
             -Wl,--wrap=rand_bytes)
-ENDIF ()
\ No newline at end of file
+        target_sources(test_tls_crypt PRIVATE
+            src/openvpn/argv.c
+            src/openvpn/base64.c
+            src/openvpn/crypto_mbedtls.c
+            src/openvpn/crypto_openssl.c
+            src/openvpn/crypto.c
+            src/openvpn/env_set.c
+            src/openvpn/otime.c
+            src/openvpn/packet_id.c
+            src/openvpn/run_command.c
+            )
+    endif ()
+
+    if (TARGET test_pkcs11)
+        target_compile_options(test_pkcs11 PRIVATE
+            -DP11TOOL_PATH=\"${P11TOOL}\"
+            -DSOFTHSM2_MODULE_PATH=\"${SOFTHSM2_MODULE}\"
+            -DSOFTHSM2_UTIL_PATH=\"${SOFTHSM2_UTIL}\"
+            )
+        target_sources(test_pkcs11 PRIVATE
+            tests/unit_tests/openvpn/mock_get_random.c
+            tests/unit_tests/openvpn/pkey_test_utils.c
+            src/openvpn/argv.c
+            src/openvpn/base64.c
+            src/openvpn/env_set.c
+            src/openvpn/otime.c
+            src/openvpn/pkcs11.c
+            src/openvpn/pkcs11_openssl.c
+            src/openvpn/run_command.c
+            src/openvpn/xkey_helper.c
+            src/openvpn/xkey_provider.c
+            )
+    endif ()
+
+endif (BUILD_TESTING)
diff --git a/CMakePresets.json b/CMakePresets.json
new file mode 100644
index 00000000..135b19d0
--- /dev/null
+++ b/CMakePresets.json
@@ -0,0 +1,228 @@
+{
+    "version": 3,
+    "configurePresets": [
+        {
+            "name": "base",
+            "hidden": true,
+            "cacheVariables": {
+                "CMAKE_TOOLCHAIN_FILE": {
+                    "value": "$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake",
+                    "type": "FILEPATH"
+                },
+                "VCPKG_OVERLAY_TRIPLETS": {
+                    "value": "${sourceDir}/contrib/vcpkg-triplets",
+                    "type": "FILEPATH"
+                },
+                "VCPKG_OVERLAY_PORTS": {
+                    "value": "${sourceDir}/contrib/vcpkg-ports",
+                    "type": "FILEPATH"
+                }
+            }
+        },
+        {
+            "name": "base-windows",
+            "hidden": true,
+            "binaryDir": "${sourceDir}/out/build/${presetName}",
+            "generator": "Visual Studio 17 2022",
+            "cacheVariables": {
+                "VCPKG_MANIFEST_DIR": "${sourceDir}/contrib/vcpkg-manifests/windows",
+                "VCPKG_HOST_TRIPLET": "x64-windows"
+            },
+            "vendor": { "microsoft.com/VisualStudioSettings/CMake/1.0": { "hostOS": [ "Windows" ] } }
+        },
+        {
+            "name": "base-mingw",
+            "hidden": true,
+            "generator": "Ninja Multi-Config",
+            "cacheVariables": {
+                "CMAKE_SYSTEM_NAME": {
+                    "value": "Windows",
+                    "type": "STRING"
+                },
+                "VCPKG_MANIFEST_DIR": "${sourceDir}/contrib/vcpkg-manifests/mingw"
+            }
+        },
+        {
+            "name": "x64",
+            "hidden": true,
+            "architecture": {
+                "value": "x64",
+                "strategy": "set"
+            },
+            "cacheVariables": {
+                "VCPKG_TARGET_TRIPLET": "x64-windows-ovpn"
+            }
+        },
+        {
+            "name": "x64-mingw",
+            "hidden": true,
+            "binaryDir": "out/build/mingw/x64",
+            "cacheVariables": {
+                "CMAKE_C_COMPILER": {
+                    "value": "x86_64-w64-mingw32-gcc",
+                    "type": "STRING"
+                },
+                "CMAKE_CXX_COMPILER": {
+                    "value": "x86_64-w64-mingw32-g++",
+                    "type": "STRING"
+                },
+                "VCPKG_TARGET_TRIPLET": "x64-mingw-ovpn"
+            }
+        },
+        {
+            "name": "arm64",
+            "hidden": true,
+            "architecture": {
+                "value": "arm64",
+                "strategy": "set"
+            },
+            "cacheVariables": {
+                "VCPKG_TARGET_TRIPLET": "arm64-windows-ovpn"
+            }
+        },
+        {
+            "name": "x86",
+            "hidden": true,
+            "architecture": {
+                "value": "Win32",
+                "strategy": "set"
+            },
+            "cacheVariables": {
+                "VCPKG_TARGET_TRIPLET": "x86-windows-ovpn"
+            }
+        },
+        {
+            "name": "i686-mingw",
+            "hidden": true,
+            "binaryDir": "out/build/mingw/x86",
+            "cacheVariables": {
+                "CMAKE_C_COMPILER": {
+                    "value": "i686-w64-mingw32-gcc",
+                    "type": "STRING"
+                },
+                "CMAKE_CXX_COMPILER": {
+                    "value": "i686-w64-mingw32-g++",
+                    "type": "STRING"
+                },
+                "VCPKG_TARGET_TRIPLET": "x86-mingw-ovpn"
+            }
+        },
+        {
+            "name": "debug",
+            "hidden": true,
+            "cacheVariables": {
+                "CMAKE_BUILD_TYPE": "Debug"
+            }
+        },
+        {
+            "name": "release",
+            "hidden": true,
+            "cacheVariables": {
+                "CMAKE_BUILD_TYPE": "Release"
+            }
+        },
+        {
+            "name": "mingw-x64",
+            "inherits": [ "base", "base-mingw", "x64-mingw" ]
+        },
+        {
+            "name": "mingw-x86",
+            "inherits": [ "base", "base-mingw", "i686-mingw" ]
+        },
+        {
+            "name": "win-amd64-release",
+            "inherits": [ "base", "base-windows", "x64", "release" ]
+        },
+        {
+            "name": "win-arm64-release",
+            "inherits": [ "base", "base-windows", "arm64", "release" ]
+        },
+        {
+            "name": "win-x86-release",
+            "inherits": [ "base", "base-windows", "x86", "release" ]
+        },
+        {
+            "name": "win-amd64-debug",
+            "inherits": [ "base", "base-windows", "x64", "debug" ]
+        },
+        {
+            "name": "win-arm64-debug",
+            "inherits": [ "base", "base-windows", "arm64", "debug" ]
+        },
+        {
+            "name": "win-x86-debug",
+            "inherits": [ "base", "base-windows", "x86", "debug" ]
+        },
+        {
+            "name": "unix-native",
+            "generator": "Ninja Multi-Config",
+            "binaryDir": "out/build/unix"
+        }
+    ],
+    "buildPresets": [
+        {
+            "name": "mingw-x64",
+            "configurePreset": "mingw-x64"
+        },
+        {
+            "name": "mingw-x86",
+            "configurePreset": "mingw-x86"
+        },
+        {
+            "name": "win-amd64-release",
+            "configurePreset": "win-amd64-release",
+            "configuration": "Release"
+        },
+        {
+            "name": "win-arm64-release",
+            "configurePreset": "win-arm64-release",
+            "configuration": "Release"
+        },
+        {
+            "name": "win-x86-release",
+            "configurePreset": "win-x86-release",
+            "configuration": "Release"
+        },
+        {
+            "name": "win-amd64-debug",
+            "configurePreset": "win-amd64-debug",
+            "configuration": "Debug"
+        },
+        {
+            "name": "win-arm64-debug",
+            "configurePreset": "win-arm64-debug",
+            "configuration": "Debug"
+        },
+        {
+            "name": "win-x86-debug",
+            "configurePreset": "win-x86-debug",
+            "configuration": "Debug"
+        },
+        {
+            "name": "unix-native",
+            "configurePreset": "unix-native"
+        }
+    ],
+    "testPresets": [
+        {
+            "name": "win-amd64-release",
+            "configurePreset": "win-amd64-release"
+        },
+        {
+            "name": "win-x86-release",
+            "configurePreset": "win-x86-release"
+        },
+        {
+            "name": "win-amd64-debug",
+            "configurePreset": "win-amd64-debug"
+        },
+        {
+            "name": "win-x86-debug",
+            "configurePreset": "win-x86-debug"
+        },
+        {
+            "name": "unix-native",
+            "configurePreset": "unix-native"
+        }
+     ]
+}
diff --git a/Makefile.am b/Makefile.am
index 27da974d..9bdbe7ea 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -41,7 +41,10 @@ CLEANFILES = \
 
 EXTRA_DIST = \
 	contrib \
-	debug
+	debug \
+	CMakeLists.txt \
+	CMakePresets.json \
+	config.h.cmake.in
 
 .PHONY: config-version.h doxygen
 
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 61859716..7ef7175e 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -42,7 +42,7 @@
 #define ENABLE_OFB_CFB_MODE
 
 /* Enable PKCS11 */
-/* #undef ENABLE_PKCS11 */
+#cmakedefine ENABLE_PKCS11
 
 /* Enable plug-in support */
 #define ENABLE_PLUGIN 1
@@ -83,6 +83,9 @@
 /* struct cmsghdr needed for extended socket error support */
 #cmakedefine HAVE_CMSGHDR
 
+/* git version information in config-version.h */
+#cmakedefine HAVE_CONFIG_VERSION_H
+
 /* Define to 1 if you have the `daemon' function. */
 #cmakedefine HAVE_DAEMON
 
@@ -193,9 +196,6 @@ don't. */
 /* Define to 1 if you have the <netinet/in.h> header file. */
 #cmakedefine HAVE_NETINET_IN_H
 
-/* Define to 1 if you have the <netinet/in_systm.h> header file. */
-#undef HAVE_NETINET_IN_SYSTM_H
-
 /* Define to 1 if you have the <netinet/ip.h> header file. */
 #cmakedefine HAVE_NETINET_IP_H
 
@@ -398,14 +398,8 @@ don't. */
 /* Path to route tool */
 #define ROUTE_PATH "@ROUTE_PATH@"
 
-/* OpenVPN major version - integer */
-#undef OPENVPN_VERSION_MAJOR
-
-/* OpenVPN minor version - integer */
-#undef OPENVPN_VERSION_MINOR
-
-/* OpenVPN patch level - may be a string or integer */
-#define OPENVPN_VERSION_PATCH "@OPENVPN_VERSION_PATCH@"
+/* OpenVPN version in Windows resource format - string */
+#define OPENVPN_VERSION_RESOURCE @OPENVPN_VERSION_RESOURCE@
 
 /* Name of package */
 #define PACKAGE "openvpn"
@@ -422,12 +416,6 @@ don't. */
 /* Define to the version of this package. */
 #define PACKAGE_VERSION "@OPENVPN_VERSION_MAJOR@...220...@OPENVPN_VERSION_MINOR@@OPENVPN_VERSION_PATCH@"
 
-/* OpenVPN major version - integer */
-#define OPENVPN_VERSION_MAJOR @OPENVPN_VERSION_MAJOR@
-
-/* OpenVPN minor version - integer */
-#define OPENVPN_VERSION_MINOR @OPENVPN_VERSION_MINOR@
-
 /* Path to systemd-ask-password tool */
 #undef SYSTEMD_ASK_PASSWORD_PATH
 
@@ -481,7 +469,6 @@ typedef SSIZE_T ssize_t;
 #define strncasecmp strnicmp
 #define strcasecmp _stricmp
 
-
 #define S_IRUSR 0
 #define S_IWUSR 0
 #define R_OK 4
diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
new file mode 100644
index 00000000..c2b44527
--- /dev/null
+++ b/contrib/cmake/git-version.py
@@ -0,0 +1,75 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+import os
+import sys
+import subprocess
+
+def run_command(args):
+    sp = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
+    o, _ = sp.communicate()
+    return o.decode("utf-8")[:-1]
+
+def get_branch_commit_id():
+    commit_id = run_command(["git", "rev-parse", "--short=16", "HEAD"])
+    if not commit_id:
+        raise
+    branch = run_command(["git", "describe", "--exact-match"])
+    if not branch:
+        # this returns an array like ["master"] or ["release", "2.6"]
+        branch = run_command(["git", "rev-parse", "--symbolic-full-name", "HEAD"]).split("/")[2:]
+        if not branch:
+            branch = ["none"]
+        branch = "/" .join(branch) # handle cases like release/2.6
+
+    return branch, commit_id
+
+def main():
+    try:
+        branch, commit_id = get_branch_commit_id()
+    except:
+        branch, commit_id = "unknown", "unknown"
+
+    prev_content = ""
+
+    name = os.path.join("%s" %  (sys.argv[1] if len(sys.argv) > 1 else "."), "config-version.h")
+    try:
+        with open(name, "r") as f:
+            prev_content = f.read()
+    except:
+        # file doesn't exist
+        pass
+
+    content = "#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch, commit_id)
+    content += "#define CONFIGURE_GIT_FLAGS \"\"\n"
+
+    if prev_content != content:
+        print("Writing %s" % name)
+        with open(name, "w") as f:
+            f.write(content)
+    else:
+        print("Content of %s hasn't changed" % name)
+
+if __name__ == "__main__":
+    main()
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-version.m4.py
new file mode 100644
index 00000000..26af6a8f
--- /dev/null
+++ b/contrib/cmake/parse-version.m4.py
@@ -0,0 +1,58 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+import os
+import re
+import sys
+
+def main():
+    assert len(sys.argv) > 1
+    version_path = sys.argv[1]
+    output = []
+    with open(version_path, 'r') as version_file:
+        for line in version_file:
+            match = re.match(r'[ \t]*define\(\[(.*)\],[ \t]*\[(.*)\]\)[ \t]*', line)
+            if match is not None:
+                output.append(match.expand(r'set(\1 \2)'))
+    out_path = os.path.join("%s" %  (sys.argv[2] if len(sys.argv) > 2 else "."), "version.cmake")
+
+    prev_content = ""
+    try:
+        with open(out_path, "r") as out_file:
+            prev_content = out_file.read()
+    except:
+        # file doesn't exist
+        pass
+
+    content = "\n".join(output) + "\n"
+    if prev_content != content:
+        print("Writing %s" % out_path)
+        with open(out_path, "w") as out_file:
+            out_file.write(content)
+    else:
+        print("Content of %s hasn't changed" % out_path)
+
+if __name__ == "__main__":
+    main()
+
diff --git a/contrib/vcpkg-manifests/mingw/vcpkg.json b/contrib/vcpkg-manifests/mingw/vcpkg.json
new file mode 100644
index 00000000..fc00b019
--- /dev/null
+++ b/contrib/vcpkg-manifests/mingw/vcpkg.json
@@ -0,0 +1,13 @@
+{
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json",
+  "name": "openvpn",
+  "version": "2.7",
+  "dependencies": [
+      "openssl",
+      "tap-windows6",
+      "lzo",
+      "lz4",
+      "pkcs11-helper",
+      "cmocka"
+  ]
+}
diff --git a/contrib/vcpkg-manifests/windows/vcpkg.json b/contrib/vcpkg-manifests/windows/vcpkg.json
new file mode 100644
index 00000000..67a1f87c
--- /dev/null
+++ b/contrib/vcpkg-manifests/windows/vcpkg.json
@@ -0,0 +1,20 @@
+{
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json",
+  "name": "openvpn",
+  "version": "2.7",
+  "dependencies": [
+      {
+        "name": "openssl",
+        "features": ["tools"]
+      },
+      "tap-windows6",
+      "lzo",
+      "lz4",
+      "pkcs11-helper",
+      "cmocka",
+      {
+          "name": "pkgconf",
+          "host": true
+      }
+  ]
+}
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 47919bc6..f8da979e 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -28,12 +28,28 @@ if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
         OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
   )
 
-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAME pkcs11-helper.lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib RENAME pkcs11-helper.lib)
 
   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
 
+  set(PACKAGE_VERSION "${VERSION}")
+    set(libdir [[${prefix}/lib]])
+    set(exec_prefix [[${prefix}]])
+    set(PKCS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine_crypto_openssl debug threading token data certificate slotevent engine_crypto)
+    set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32)
+    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
+        set(includedir [[${prefix}/include]])
+        set(outfile "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helper-1.pc")
+        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outfile}" @ONLY)
+    endif()
+    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
+        set(includedir [[${prefix}/../include]])
+        set(outfile "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libpkcs11-helper-1.pc")
+        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${outfile}" @ONLY)
+    endif()
+
   file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
 
 else()
@@ -45,11 +61,11 @@ else()
     --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
     )
   vcpkg_install_make()
-  vcpkg_fixup_pkgconfig()
 
   file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
 endif()
 
+vcpkg_fixup_pkgconfig()
 vcpkg_copy_pdbs()
 
 file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
diff --git a/doc/CMakeLists.txt b/doc/CMakeLists.txt
new file mode 100644
index 00000000..1034226d
--- /dev/null
+++ b/doc/CMakeLists.txt
@@ -0,0 +1,81 @@
+set(_GENERATE_HTML_DOC YES)
+set(_GENERATE_MAN_DOC  YES)
+find_program(RST2HTML NAMES rst2html rst2html.py)
+find_program(RST2MAN  NAMES rst2man  rst2man.py)
+
+if (RST2HTML STREQUAL "RST2HTML-NOTFOUND")
+    message(STATUS "rst2html not found, not generating HTML documentation")
+    set(_GENERATE_HTML_DOC NO)
+endif ()
+if (RST2MAN STREQUAL "RST2MAN-NOTFOUND")
+    message(STATUS "rst2man not found, not generating HTML documentation")
+    set(_GENERATE_MAN_DOC NO)
+endif ()
+
+set(OPENVPN_SECTIONS
+    man-sections/advanced-options.rst
+    man-sections/cipher-negotiation.rst
+    man-sections/client-options.rst
+    man-sections/connection-profiles.rst
+    man-sections/encryption-options.rst
+    man-sections/generic-options.rst
+    man-sections/inline-files.rst
+    man-sections/link-options.rst
+    man-sections/log-options.rst
+    man-sections/management-options.rst
+    man-sections/network-config.rst
+    man-sections/pkcs11-options.rst
+    man-sections/plugin-options.rst
+    man-sections/protocol-options.rst
+    man-sections/proxy-options.rst
+    man-sections/renegotiation.rst
+    man-sections/signals.rst
+    man-sections/script-options.rst
+    man-sections/server-options.rst
+    man-sections/tls-options.rst
+    man-sections/unsupported-options.rst
+    man-sections/virtual-routing-and-forwarding.rst
+    man-sections/vpn-network-options.rst
+    man-sections/windows-options.rst
+    )
+
+set(OPENVPN_EXAMPLES_SECTIONS
+    man-sections/example-fingerprint.rst
+    man-sections/examples.rst
+    )
+
+set(RST_FLAGS --strict)
+
+if (_GENERATE_HTML_DOC)
+    list(APPEND ALL_DOCS openvpn.8.html openvpn-examples.5.html)
+    add_custom_command(
+        OUTPUT openvpn.8.html
+        COMMAND ${PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html
+        MAIN_DEPENDENCY openvpn.8.rst
+        DEPENDS ${OPENVPN_SECTIONS}
+        )
+    add_custom_command(
+        OUTPUT openvpn-examples.5.html
+        COMMAND ${PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5.html
+        MAIN_DEPENDENCY openvpn-examples.5.rst
+        DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
+        )
+endif ()
+if (_GENERATE_MAN_DOC)
+    list(APPEND ALL_DOCS openvpn.8 openvpn-examples.5)
+    add_custom_command(
+        OUTPUT openvpn.8
+        COMMAND ${PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8
+        MAIN_DEPENDENCY openvpn.8.rst
+        DEPENDS ${OPENVPN_SECTIONS}
+        )
+    add_custom_command(
+        OUTPUT openvpn-examples.5
+        COMMAND ${PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5
+        MAIN_DEPENDENCY openvpn-examples.5.rst
+        DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
+        )
+endif ()
+
+add_custom_target(documentation ALL DEPENDS ${ALL_DOCS})
+
diff --git a/doc/Makefile.am b/doc/Makefile.am
index d8ffe2e0..087f0cee 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -63,7 +63,8 @@ dist_noinst_DATA = \
 	README.plugins \
 	tls-crypt-v2.txt \
 	$(openvpn_sections) \
-	$(openvpn_examples_sections)
+	$(openvpn_examples_sections) \
+	CMakeLists.txt
 
 EXTRA_DIST = tests
 
diff --git a/src/openvpnmsica/CMakeLists.txt b/src/openvpnmsica/CMakeLists.txt
new file mode 100644
index 00000000..683d38e0
--- /dev/null
+++ b/src/openvpnmsica/CMakeLists.txt
@@ -0,0 +1,36 @@
+if (NOT WIN32)
+    return ()
+endif ()
+
+project(openvpnmsica)
+
+add_library(openvpnmsica SHARED)
+
+target_include_directories(openvpnmsica PRIVATE
+    ${CMAKE_CURRENT_BINARY_DIR}/../../
+    ../../include/
+    ../compat/
+    )
+target_sources(openvpnmsica PRIVATE
+    dllmain.c
+    msiex.c msiex.h
+    msica_arg.c msica_arg.h
+    openvpnmsica.c openvpnmsica.h
+    ../tapctl/basic.h
+    ../tapctl/error.c ../tapctl/error.h
+    ../tapctl/tap.c ../tapctl/tap.h
+    openvpnmsica_resources.rc
+    )
+target_compile_options(openvpnmsica PRIVATE
+    -D_UNICODE
+    -UNTDDI_VERSION
+    -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+    )
+target_link_libraries(openvpnmsica
+    advapi32.lib ole32.lib msi.lib setupapi.lib iphlpapi.lib shell32.lib shlwapi.lib version.lib newdev.lib)
+if (MINGW)
+    target_compile_options(openvpnmsica PRIVATE -municode)
+    target_link_options(openvpnmsica PRIVATE -municode)
+    target_link_options(openvpnmsica PRIVATE
+        -Wl,--kill-at)
+endif ()
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 6da0754d..d68a0089 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -34,6 +34,9 @@ AM_CPPFLAGS = \
 AM_CFLAGS = \
 	$(TAP_CFLAGS)
 
+EXTRA_DIST = \
+	CMakeLists.txt
+
 if WIN32
 lib_LTLIBRARIES = libopenvpnmsica.la
 libopenvpnmsica_la_CFLAGS = \
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
new file mode 100644
index 00000000..17cd90c6
--- /dev/null
+++ b/src/openvpnserv/CMakeLists.txt
@@ -0,0 +1,34 @@
+if (NOT WIN32)
+    return ()
+endif ()
+
+project(openvpnserv)
+
+add_executable(openvpnserv)
+
+target_include_directories(openvpnserv PRIVATE
+    ${CMAKE_CURRENT_BINARY_DIR}/../../
+    ../../include/
+    ../openvpn/
+    ../compat/
+    )
+target_sources(openvpnserv PRIVATE
+    common.c
+    interactive.c
+    service.c service.h
+    validate.c validate.h
+    ../openvpn/block_dns.c ../openvpn/block_dns.h
+    openvpnserv_resources.rc
+    ../openvpn/ring_buffer.h
+    )
+target_compile_options(openvpnserv PRIVATE
+    -D_UNICODE
+    -UNTDDI_VERSION
+    -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+    )
+target_link_libraries(openvpnserv
+    advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib)
+if (MINGW)
+    target_compile_options(openvpnserv PRIVATE -municode)
+    target_link_options(openvpnserv PRIVATE -municode)
+endif ()
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index b8b2a378..4c0ac40c 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -19,6 +19,9 @@ EXTRA_DIST = \
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
 
+EXTRA_DIST = \
+	CMakeLists.txt
+
 if WIN32
 sbin_PROGRAMS = openvpnserv
 openvpnserv_CFLAGS = \
diff --git a/src/tapctl/CMakeLists.txt b/src/tapctl/CMakeLists.txt
new file mode 100644
index 00000000..97702c01
--- /dev/null
+++ b/src/tapctl/CMakeLists.txt
@@ -0,0 +1,31 @@
+if (NOT WIN32)
+    return ()
+endif ()
+
+project(tapctl)
+
+add_executable(tapctl)
+
+target_include_directories(tapctl PRIVATE
+    ${CMAKE_CURRENT_BINARY_DIR}/../../
+    ../../include/
+    ../compat/
+    )
+target_sources(tapctl PRIVATE
+    basic.h
+    error.c error.h
+    main.c
+    tap.c tap.h
+    tapctl_resources.rc
+    )
+target_compile_options(tapctl PRIVATE
+    -D_UNICODE
+    -UNTDDI_VERSION
+    -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+    )
+target_link_libraries(tapctl
+    advapi32.lib ole32.lib setupapi.lib)
+if (MINGW)
+    target_compile_options(tapctl PRIVATE -municode)
+    target_link_options(tapctl PRIVATE -municode)
+endif ()
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 3896351b..fe8ab2a5 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -33,6 +33,10 @@ AM_CPPFLAGS = \
 AM_CFLAGS = \
 	$(TAP_CFLAGS)
 
+EXTRA_DIST = \
+	CMakeLists.txt \
+	tapctl.exe.manifest
+
 if WIN32
 sbin_PROGRAMS = tapctl
 tapctl_CFLAGS = \
-- 
2.34.1


