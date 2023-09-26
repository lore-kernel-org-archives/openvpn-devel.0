From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 26 Sep 2023 11:50:30 +0200
Message-Id: <20230926095030.29779-1-frank@...2641...>
In-Reply-To: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
References: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] CMake: backport CMake buildsystem from
 master to release/2.6
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
Cc: Lev Stipakov <lstipakov@...277...>, Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>

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

This commits squashes a lot of commits from master
together, since most of them are just fixes or
enhancements for the original CMake commit. The
decisions was not to bloat the release/2.6 commit
history with these detours.

It contains the following commits:
- add basic CMake based build
  (commit 0134184012dd46ec44cbca7eb3ece39037ae0bfa by
   Arne Schwabe)
- CMake: Add complete MinGW and MSVC build
  (commit e8881ec6dd63bd80ce05202573eac54ab8657fcb)
- CMake: Add /Brepro to MSVC link options
  (commit 5e94e8de4bfaf6637124947a3489710b591e5e26)
- Do not blindly assume python3 is also the interpreter that runs rst2html
  (commit 5dbec1c019d14880ae7bf364b062d3589c7fd9e7 by
   Arne Schwabe)
- Only add -Wno-stringop-truncation on supported compilers
  (commit eb3cd5ea36f9bf235da7b8a51fd6ce29780f0e39 by
   Arne Schwabe)
- CMake: Throw a clear error when config.h in top-level source directory
  (commit 0652ae84f4528daa57da344eee28b7385a6659a1)
- openvpnmsica: link C runtime statically
  (commit 3be4986ea3d6e27acd3e3a317c15dfe07688e135 by
   Lev Stipakov)
- CMake: Support doc builds on Windows machines that do not have .py file association
  (commit 22213a8834ba5ba5c9818015730edbf3766ad915)
- README.cmake.md: Add new documentation for CMake buildsystem
  (commit 53055fd23efb6209b12d3662427158e25247f1fe)
- Check if the -wrap argument is actually supported by the platform's ld
  (commit 4ef76f0ee4e122dcd616e1b1e2d652562ab10756 by
   Arne Schwabe)
- GHA: update to run-vcpkg@...2735...
  (commit 66e33ee81d1d7fa3495ae3aad6e673766e296687)
- GHA: refactor mingw UTs and add missing tls_crypt
  (commit 26c663f12815f55c483dbe660e28448dc63221d1)
- CMake: various small non-functional improvements
  (commit 95cc5faa16833acaf12a4d273c5c848984fc73ce)
- CMake: fix broken daemonization and syslog functionality
  (commit 8ae6c48d5d52dec8ec6e47cc1cfe89de9f2ffbcd)
- CMake: fix HAVE_DAEMON detection on Linux
  (commit e363b393f2d1b72590666554e17d928c1603f8d5)

Change-Id: I6de18261d5dc7f8561612184059656c73f33a5f2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Co-authored-by: Arne Schwabe <arne@...1227...>
Co-authored-by: Lev Stipakov <lev@...515...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/315
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 34ade61..429a205 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -39,230 +39,64 @@
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
+
+      - name: Restore from cache and install vcpkg
+        uses: lukka/run-vcpkg@...2735...
         with:
-          path: openvpn
+          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
+          vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
-      - name: autoconf
-        run: autoreconf -fvi
-        working-directory: openvpn
-
-      - name: Cache dependencies
-        id: cache
-        uses: actions/cache@...2689...
+      - name: Run CMake with vcpkg.json manifest
+        uses: lukka/run-cmake@...2637...
         with:
-          path: '~/mingw/'
-          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}--${{ env.CMOCKA_VERSION }}
+          configurePreset: mingw-${{ matrix.arch }}
+          buildPreset: mingw-${{ matrix.arch }}
+          buildPresetAdditionalArgs: "['--config Debug']"
 
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
-
-      # We use multiple upload-artifact here, so it becomes a flat folder
-      # structure since we need the dlls on the same level as the binaries
-      - name: Archive cmocka/openssl/lzo dlls
-        uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2689...
         with:
-          retention-days: 1
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-dlls
-          path: '~/mingw/opt/bin/*.dll'
+          name: openvpn-mingw-${{ matrix.arch }}
+          path: |
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
+            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
-      # libtool puts some wrapper binaries in openvpn/tests/unit_tests/openvpn/
-      # and the real binaries in openvpn/tests/unit_tests/openvpn/.libs/
-      - name: Archive unittest artifacts
-        uses: actions/upload-artifact@...2689...
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
-        with:
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
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, tls_crypt]
 
     runs-on: windows-latest
-    name: "mingw unittests - ${{matrix.target}} - OSSL ${{ matrix.osslver }}"
+    name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
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
-
-      - name: List unittests directory
-        run: "dir unittests"
-
-      - name: Run argvunit test
-        run: ./unittests/argv_testdriver.exe
-
-      - name: Run auth_tokenunit test
-        run: ./unittests/auth_token_testdriver.exe
-
-      - name: Run bufferunit test
-        run: ./unittests/buffer_testdriver.exe
-
-      - name: Run cryptoapi unit test
-        run: ./unittests/cryptoapi_testdriver.exe
-
-      - name: Run cryptounit test
-        run: ./unittests/crypto_testdriver.exe
-
-      - name: Run miscunit test
-        run: ./unittests/misc_testdriver.exe
-
-      - name: Run ncpunit test
-        run: ./unittests/ncp_testdriver.exe
-
-      - name: Run packet idunit test
-        run: ./unittests/packet_id_testdriver.exe
-
-      - name: Run pktunit test
-        run: ./unittests/pkt_testdriver.exe
-
-      - name: Run providerunit test
-        run: ./unittests/provider_testdriver.exe
+      - name: Run ${{ matrix.test }} unit test
+        run: ./unittests/test_${{ matrix.test }}.exe
 
   ubuntu:
     strategy:
@@ -407,60 +241,50 @@
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
+          arch: [amd64, x86, arm64]
 
-      name: "msbuild - ${{matrix.triplet}} - openssl"
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
-        uses: lukka/run-vcpkg@...2637...
+        uses: lukka/run-vcpkg@...2735...
         with:
-          vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
-          vcpkgJsonGlob: '**/openvpn/vcpkg.json'
-          appendedCacheKey: '${{matrix.triplet}}'
+          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
+          vcpkgJsonGlob: '**/windows/vcpkg.json'
 
-      - name: Run MSBuild consuming vcpkg.json
-        working-directory: ${{env.GITHUB_WORKSPACE}}
-        run: |
-            # workaround for GHA runner bug where vcpkg installation is detected at c:\vcpkg
-            # see https://github.com/lukka/run-vcpkg/issues/170
-            ${{ github.workspace }}/vcpkg/vcpkg.exe integrate install
-            msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
-
-      - name: Archive artifacts
-        uses: actions/upload-artifact@...2689...
+      - name: Run CMake with vcpkg.json manifest (NO TESTS)
+        uses: lukka/run-cmake@...2637...
+        if: ${{ matrix.arch == 'arm64' }}
         with:
-          name: artifacts-${{ matrix.plat }}
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
+
+      - uses: actions/upload-artifact@...2689...
+        with:
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
 
   libressl:
     strategy:
diff --git a/.gitignore b/.gitignore
index 813413f..f44b924 100644
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
new file mode 100644
index 0000000..3240be7
--- /dev/null
+++ b/CMakeLists.txt
@@ -0,0 +1,739 @@
+cmake_minimum_required(VERSION 3.12)
+set(CMAKE_CONFIGURATION_TYPES "Release;Debug;ASAN")
+project(openvpn)
+
+# This CMake file implements building OpenVPN with CMAKE
+#
+# Note that this is *NOT* the official way to build openvpn on anything
+# other than Windows/mingw despite working on other platforms too. You will need
+# to add -DUNSUPPORTED_BUILDS=true to build on non Windows platforms.
+#
+# This cmake also makes a few assertions like lzo, lz4 being used
+# and OpenSSL having version 1.1.1+ and generally does not offer the same
+# configurability like autoconf
+
+find_package(PkgConfig REQUIRED)
+include(CheckSymbolExists)
+include(CheckIncludeFiles)
+include(CheckCCompilerFlag)
+include(CheckLinkerFlag OPTIONAL)
+include(CheckTypeSize)
+include(CheckStructHasMember)
+include(CTest)
+
+option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
+
+if (NOT WIN32 AND NOT ${UNSUPPORTED_BUILDS})
+    message(FATAL_ERROR "Note: on Unix platform the official and supported build method is using autoconfig. CMake based build should be only used for Windows and internal testing/development.")
+endif()
+
+if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/config.h")
+    message(FATAL_ERROR "The top level source directory has a config.h file. Note that you can't mix in-tree autoconfig builds with out-of-tree cmake builds.")
+endif ()
+
+option(MBED "BUILD with mbed" OFF)
+option(WOLFSSL "BUILD with wolfSSL" OFF)
+option(ENABLE_LZ4 "BUILD with lz4" ON)
+option(ENABLE_LZO "BUILD with lzo" ON)
+option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
+option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
+
+set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of the plugin directory")
+
+# AddressSanitize - use CXX=clang++ CC=clang cmake -DCMAKE_BUILD_TYPE=asan to build with ASAN
+set(CMAKE_C_FLAGS_ASAN
+    "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+    CACHE STRING "Flags used by the C compiler during AddressSanitizer builds."
+    FORCE)
+set(CMAKE_CXX_FLAGS_ASAN
+    "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+    CACHE STRING "Flags used by the C++ compiler during AddressSanitizer builds."
+    FORCE)
+
+if (MSVC)
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
+        /Brepro
+        "$<$<CONFIG:Release>:/LTCG:incremental>"
+        "$<$<CONFIG:Release>:/DEBUG:FULL>"
+        "$<$<CONFIG:Release>:/OPT:REF>"
+        "$<$<CONFIG:Release>:/OPT:ICF>"
+        )
+    if (${CMAKE_GENERATOR_PLATFORM} STREQUAL "x64" OR ${CMAKE_GENERATOR_PLATFORM} STREQUAL "x86")
+        add_link_options("$<$<CONFIG:Release>:/CETCOMPAT>")
+    endif()
+else ()
+    set(CMAKE_C_FLAGS_RELEASE "-O2")
+    set(CMAKE_CXX_FLAGS_RELEASE "-O2")
+    set(CMAKE_C_FLAGS_DEBUG "-g -O1")
+    set(CMAKE_CXX_FLAGS_DEBUG "-g -O1")
+    add_compile_options(-Wall -Wuninitialized)
+    check_c_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
+
+    if (${NoStringOpTruncation})
+        add_compile_options(-Wno-stringop-truncation)
+    endif()
+    # We are not ready for this
+    #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)
+    if (USE_WERROR)
+        add_compile_options(-Werror)
+    endif ()
+endif ()
+
+find_program(PYTHON NAMES python3 python)
+execute_process(
+    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
+    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
+    )
+include(${CMAKE_CURRENT_BINARY_DIR}/version.cmake)
+
+set(OPENVPN_VERSION_MAJOR ${PRODUCT_VERSION_MAJOR})
+set(OPENVPN_VERSION_MINOR ${PRODUCT_VERSION_MINOR})
+set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})
+set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})
+
+set(CMAKE_C_STANDARD 99)
+
+# Set the various defines for config.h.cmake.in
+if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+    set(TARGET_LINUX YES)
+    set(ENABLE_ASYNC_PUSH YES)
+    set(ENABLE_LINUXDCO YES)
+    set(ENABLE_SITNL YES)
+    set(HAVE_DECL_SO_MARK YES)
+    set(ENABLE_FEATURE_TUN_PERSIST 1)
+    set(HAVE_LINUX_TYPES_H 1)
+    set(ENABLE_DCO YES)
+    set(HAVE_CMSGHDR YES)
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD")
+    set(TARGET_FREEBSD YES)
+    set(ENABLE_DCO YES)
+    link_libraries(-lnv)
+elseif (WIN32)
+    set(ENABLE_DCO YES)
+elseif (APPLE)
+    set(TARGET_DARWIN YES)
+    set(HAVE_NET_IF_UTUN_H YES)
+endif ()
+
+if (UNIX)
+    set(PATH_SEPARATOR /)
+    set(ENABLE_PORT_SHARE YES)
+    set(HAVE_SA_FAMILY_T YES)
+elseif (WIN32)
+    set(PATH_SEPARATOR \\\\)
+    set(TARGET_WIN32 YES)
+endif ()
+
+check_symbol_exists(chroot unistd.h HAVE_CHROOT)
+check_symbol_exists(chdir unistd.h HAVE_CHDIR)
+check_symbol_exists(dup unistd.h HAVE_DUP)
+check_symbol_exists(dup2 unistd.h HAVE_DUP2)
+check_symbol_exists(fork unistd.h HAVE_FORK)
+check_symbol_exists(execve unistd.h HAVE_EXECVE)
+check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
+check_symbol_exists(setgid unistd.h HAVE_SETGID)
+check_symbol_exists(setuid unistd.h HAVE_SETUID)
+check_symbol_exists(setsid unistd.h HAVE_SETSID)
+check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)
+
+check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
+
+check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)
+check_symbol_exists(basename libgen.h HAVE_BASENAME)
+check_symbol_exists(chsize io.h HAVE_CHSIZE)
+check_symbol_exists(daemon "unistd.h;stdlib.h" HAVE_DAEMON)
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
+
+# Some OS (e.g. FreeBSD) need some basic headers to allow
+# including network headers
+set(NETEXTRA sys/types.h)
+check_include_files("${NETEXTRA};netinet/in.h" HAVE_NETINET_IN_H)
+
+if (HAVE_NETINET_IN_H)
+    list(APPEND NETEXTRA netinet/in.h)
+endif ()
+
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
+
+find_program(IFCONFIG_PATH ifconfig)
+find_program(IPROUTE_PATH ip)
+find_program(ROUTE_PATH route)
+
+if (${ENABLE_LZ4})
+    pkg_search_module(liblz4 liblz4 REQUIRED IMPORTED_TARGET)
+endif ()
+
+if (${ENABLE_LZO})
+    pkg_search_module(lzo2 lzo2 REQUIRED IMPORTED_TARGET)
+endif ()
+
+if (${ENABLE_PKCS11})
+    pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED_TARGET)
+endif ()
+
+function(add_library_deps target)
+    if (${MBED})
+        target_link_libraries(${target} -lmbedtls -lmbedx509 -lmbedcrypto)
+    elseif (${WOLFSSL})
+        pkg_search_module(wolfssl wolfssl REQUIRED)
+        target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
+        target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)
+    else ()
+        set(ENABLE_X509ALTUSERNAME YES)
+
+        find_package(OpenSSL REQUIRED)
+        target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)
+        if (WIN32)
+            target_link_libraries(${target} PUBLIC
+                ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi.lib
+                wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib)
+        endif ()
+
+    endif ()
+
+    # optional dependencies
+    target_link_libraries(${target} PUBLIC
+        $<TARGET_NAME_IF_EXISTS:PkgConfig::liblz4>
+        $<TARGET_NAME_IF_EXISTS:PkgConfig::lzo2>
+        $<TARGET_NAME_IF_EXISTS:PkgConfig::pkcs11-helper>
+        )
+
+    if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+        pkg_search_module(libcapng REQUIRED libcap-ng IMPORTED_TARGET)
+        pkg_search_module(libnl REQUIRED libnl-genl-3.0 IMPORTED_TARGET)
+
+        target_link_libraries(${target} PUBLIC PkgConfig::libcapng PkgConfig::libnl)
+    endif ()
+
+endfunction()
+
+if (${MBED})
+    set(ENABLE_CRYPTO_MBEDTLS YES)
+elseif (${WOLFSSL})
+    set(ENABLE_CRYPTO_OPENSSL YES)
+    set(ENABLE_CRYPTO_WOLFSSL YES)
+    set(ENABLE_X509ALTUSERNAME YES)
+else ()
+    set(ENABLE_CRYPTO_OPENSSL YES)
+    set(ENABLE_X509ALTUSERNAME YES)
+endif ()
+
+include_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)
+
+add_custom_command(
+    OUTPUT always_rebuild config-version.h
+    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py
+    )
+set(HAVE_CONFIG_VERSION_H YES)
+
+configure_file(config.h.cmake.in config.h)
+configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
+# TODO we should remove the need for this, and always include config.h
+add_definitions(-DHAVE_CONFIG_H)
+
+include_directories(${CMAKE_CURRENT_BINARY_DIR})
+
+add_subdirectory(doc)
+add_subdirectory(src/openvpnmsica)
+add_subdirectory(src/openvpnserv)
+add_subdirectory(src/tapctl)
+
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
+
+add_executable(openvpn ${SOURCE_FILES})
+
+add_library_deps(openvpn)
+
+if (MINGW)
+    target_compile_options(openvpn PRIVATE
+        -DWIN32_LEAN_AND_MEAN
+        -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+        )
+    target_compile_options(openvpn PRIVATE -municode -UUNICODE)
+    target_link_options(openvpn PRIVATE -municode)
+endif()
+
+if (MSVC)
+    # we have our own manifest
+    target_link_options(openvpn PRIVATE /MANIFEST:NO)
+endif()
+
+if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+    target_link_libraries(openvpn PUBLIC -ldl)
+endif ()
+
+if (NOT WIN32)
+    target_compile_options(openvpn PRIVATE -DPLUGIN_LIBDIR=\"${PLUGIN_DIR}\")
+
+    find_library(resolv resolv)
+    # some platform like BSDs already include resolver functionality in the libc and not have an extra resolv library
+    if (${resolv} OR APPLE)
+        target_link_libraries(openvpn PUBLIC -lresolv)
+    endif ()
+endif ()
+
+
+if (BUILD_TESTING)
+    find_package(cmocka CONFIG)
+    if (TARGET cmocka::cmocka)
+        set(CMOCKA_LIBRARIES cmocka::cmocka)
+    else ()
+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
+        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
+    endif ()
+
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
+
+    if (WIN32)
+        list(APPEND unit_tests
+            "test_cryptoapi"
+            )
+    endif ()
+
+    # MSVC and Apple's LLVM ld do not support --wrap
+    # This test requires cmake >= 3.18, so check if check_linker_flag is
+    # available
+    if (COMMAND check_linker_flag)
+        check_linker_flag(C -Wl,--wrap=parse_line LD_SUPPORTS_WRAP)
+    endif()
+
+    if (${LD_SUPPORTS_WRAP})
+        list(APPEND unit_tests
+            "test_argv"
+            "test_tls_crypt"
+            )
+    endif ()
+
+    # These tests work on only on Linux since they depend on special Linux features
+    if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+        list(APPEND unit_tests
+            "test_networking"
+            )
+    endif ()
+
+    foreach (test_name ${unit_tests})
+        # test_networking needs special environment
+        if (NOT ${test_name} STREQUAL "test_networking")
+            add_test(${test_name} ${test_name})
+        endif ()
+        add_executable(${test_name}
+            tests/unit_tests/openvpn/${test_name}.c
+            tests/unit_tests/openvpn/mock_msg.c
+            tests/unit_tests/openvpn/mock_msg.h
+            src/openvpn/platform.c
+            src/openvpn/win32-util.c
+            src/compat/compat-gettimeofday.c
+            )
+
+        add_library_deps(${test_name})
+        target_link_libraries(${test_name} PUBLIC ${CMOCKA_LIBRARIES})
+
+        target_include_directories(${test_name} PRIVATE src/openvpn)
+
+        if (NOT ${test_name} STREQUAL "test_buffer")
+            target_sources(${test_name} PRIVATE
+                src/openvpn/buffer.c
+                )
+        endif ()
+
+    endforeach()
+
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
+        tests/unit_tests/openvpn/mock_win32_execve.c
+        src/openvpn/argv.c
+        src/openvpn/base64.c
+        src/openvpn/crypto_mbedtls.c
+        src/openvpn/crypto_openssl.c
+        src/openvpn/crypto.c
+        src/openvpn/env_set.c
+        src/openvpn/otime.c
+        src/openvpn/packet_id.c
+        src/openvpn/reliable.c
+        src/openvpn/run_command.c
+        src/openvpn/session_id.c
+        src/openvpn/ssl_pkt.c
+        src/openvpn/tls_crypt.c
+        )
+
+    target_sources(test_provider PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/xkey_provider.c
+        src/openvpn/xkey_helper.c
+        src/openvpn/base64.c
+        )
+
+    if (TARGET test_argv)
+        target_link_options(test_argv PRIVATE -Wl,--wrap=parse_line)
+        target_sources(test_argv PRIVATE
+            tests/unit_tests/openvpn/mock_get_random.c
+            src/openvpn/argv.c
+            )
+    endif ()
+
+    if (TARGET test_cryptoapi)
+        target_sources(test_cryptoapi PRIVATE
+            tests/unit_tests/openvpn/mock_get_random.c
+            tests/unit_tests/openvpn/cert_data.h
+            src/openvpn/xkey_provider.c
+            src/openvpn/xkey_helper.c
+            src/openvpn/base64.c
+            )
+    endif ()
+
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
+    endif ()
+
+    if (TARGET test_tls_crypt)
+        target_link_options(test_tls_crypt PRIVATE -Wl,--wrap=parse_line)
+        target_link_options(test_tls_crypt PRIVATE
+            -Wl,--wrap=buffer_read_from_file
+            -Wl,--wrap=buffer_write_file
+            -Wl,--wrap=rand_bytes)
+        target_sources(test_tls_crypt PRIVATE
+            tests/unit_tests/openvpn/mock_win32_execve.c
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
+endif (BUILD_TESTING)
diff --git a/CMakePresets.json b/CMakePresets.json
new file mode 100644
index 0000000..135b19d
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
index 2ddf6f7..f4ac7be 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -41,7 +41,10 @@
 
 EXTRA_DIST = \
 	contrib \
-	debug
+	debug \
+	CMakeLists.txt \
+	CMakePresets.json \
+	config.h.cmake.in
 
 .PHONY: config-version.h doxygen
 
@@ -64,6 +67,7 @@
 	.gitattributes \
 	CONTRIBUTING.rst \
 	PORTS \
+	README.cmake.md \
 	README.dco.md \
 	README.ec \
 	README.wolfssl \
diff --git a/README b/README
index 04eb16f..8576dba 100644
--- a/README
+++ b/README
@@ -21,6 +21,9 @@
 
 or see the file INSTALL for more info.
 
+For information on how to build OpenVPN on/for Windows with MinGW
+or MSVC see README.cmake.md.
+
 *************************************************************************
 
 For detailed information on OpenVPN, including examples, see the man page
@@ -69,8 +72,7 @@
   https://github.com/OpenVPN/easy-rsa
   https://github.com/OpenVPN/tap-windows6
 
-The old cross-compilation environment (domake-win) and the Python-based
-buildsystem have been replaced with openvpn-build:
+Community-provided Windows installers (MSI) and Debian packages are built from
 
   https://github.com/OpenVPN/openvpn-build
 
diff --git a/README.cmake.md b/README.cmake.md
new file mode 100644
index 0000000..d181b64
--- /dev/null
+++ b/README.cmake.md
@@ -0,0 +1,137 @@
+OpenVPN Builds with CMake
+=========================
+
+For Windows builds we do not use the autotools-based buildsystem that we use
+for our Unix-like (Linux, BSDs, macOS, etc.) builds. Instead we added a
+separate (CMake)[https://cmake.org/]-based buildsystem.
+
+This buildsystem supports building for Windows both with MSVC (i.e. Visual
+Studio) and MinGW. MinGW builds are also supported as cross-compile
+from Linux.
+
+The official builds, which are also available as CMake presets (see
+`cmake --list-presets` and `CMakePresets.json`) all use
+(VCPKG)[https://github.com/microsoft/vcpkg/#vcpkg-overview] for dependency
+management. This allows us to do proper supply-chain management and
+also makes cross-building with MinGW on Linux much simpler. However,
+builds are also possible by providing the build dependencies manually,
+but that might require specifying more information to CMake.
+
+If you're looking to build the full Windows installer MSI, take a look
+at https://github.com/OpenVPN/openvpn-build.git .
+
+MSVC builds
+-----------
+
+The following tools are expected to be present on the system, you
+can install them with a package manager of your choice (e.g.
+chocolatey, winget) or manually:
+
+* CMake
+* Git
+* Python (3.x), plus the Python module `docutils`
+* Visual Studion 17 (2022), C/C++ Environment
+
+For example, to prepare the required tools with chocolatey, you
+can use the following commands (Powershell):
+
+    # Installing Chocolatey
+    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
+    & choco.exe install -y git --params "/GitAndUnixToolsOnPath"
+    & choco.exe install -y python
+    & python.exe -m ensurepip
+    & python.exe -m pip install --upgrade pip
+    & python.exe -m pip install docutils
+    & choco.exe install -y cmake --installargs 'ADD_CMAKE_TO_PATH=System'
+    & choco.exe install -y "visualstudio2022buildtools"
+    & choco.exe install -y "visualstudio2022-workload-vctools" --params "--add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.VC.ATL.Spectre --add Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre --add Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre --quiet"
+    & choco.exe install -y windows-sdk-10-version-2004-windbg
+
+One or more restarts of Powershell might be required to pick up new additions
+to `PATH` between steps. A Windows restart is probably required after
+installing Visual Studio before being able to use it.
+You can find the exact commands we use to set up the community build machines
+at https://github.com/OpenVPN/openvpn-buildbot/blob/master/jenkins/windows-server/msibuild.pkr.hcl
+
+To do a default build, assuming you are in a MSVC 17 2022 environment:
+
+    mkdir C:\OpenVPN
+    cd C:\OpenVPN
+    git clone https://github.com/microsoft/vcpkg.git
+    git clone https://github.com/OpenVPN/openvpn.git
+    set VCPKG_ROOT=C:\OpenVPN\vcpkg
+    cd openvpn
+    cmake --preset win-amd64-release
+    cmake --build --preset win-amd64-release
+    ctest --preset win-amd64-release
+
+When using the presets, the build directory is
+`out/build/<preset-name>/`, you can find the output files there.
+No install support is provided directly in OpenVPN build, take a look
+at https://github.com/OpenVPN/openvpn-build.git instead.
+
+MinGW builds (cross-compile on Linux)
+-------------------------------------
+
+To build the Windows executables on a Linux system:
+
+    # install mingw with the package manager of your choice, e.g.
+    sudo apt-get install -y mingw-w64
+    # in addition to mingw we also need a toolchain for host builds, e.g.
+    sudo apt-get install -y build-essential
+    # minimum required tools for vcpkg bootstrap: curl, zip, unzip, tar, e.g.
+    sudo apt-get install -y curl zip unzip tar
+    # additionally vcpkg requires powershell when building Windows binaries.
+    # See https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux
+    # e.g.
+    sudo apt-get install -y wget apt-transport-https software-properties-common
+    wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
+    sudo dpkg -i packages-microsoft-prod.deb
+    sudo apt-get update
+    sudo apt-get install -y powershell
+    # minimum required tools for build: cmake, docutils, git, ninja,
+    # pkg-config, python e.g.
+    sudo apt-get install -y cmake git ninja-build pkg-config python3 python3-docutils
+    # additionally required to build pkcs11-helper: automake, autoconf,
+    # man2html, e.g.
+    sudo apt-get install -y automake autoconf man2html-base
+    mkdir mingw
+    cd mingw
+    git clone https://github.com/microsoft/vcpkg.git
+    git clone https://github.com/OpenVPN/openvpn.git
+    export VCPKG_ROOT=$PWD/vcpkg
+    cd openvpn
+    cmake --preset mingw-x64
+    cmake --build --preset mingw-x64
+    # unit tests are built, but no testPreset is provided. You need to copy
+    # them to a Windows system manually
+
+The instructions have been verified on a Ubuntu 22.04 LTS system in a
+bash shell, and might need adaptions to other Linux distributions/versions.
+
+Note that the MinGW preset builds use the `Ninja multi-config` generator, so
+if you want to build the Debug binaries, use
+
+    cmake --build --preset mingw-x64 --config Debug
+
+The default build is equivalent to specifying `--config Release`.
+
+When using the presets, the build directory is
+`out/build/mingw/<arch>`, you can find the actual output files in
+sub-directories called `<buildtype>`.
+No install support is provided directly in OpenVPN build, take a look
+at https://github.com/OpenVPN/openvpn-build.git instead.
+
+Unsupported builds
+------------------
+
+The CMake buildsystem also supports builds on Unix-like platforms. These builds
+are sometimes useful for OpenVPN developers (e.g. when they use IDEs with
+integrated CMake support). However, they are not officially supported, do not
+include any install support and should not be used to distribute/package
+OpenVPN. To emphasize this fact, you need to specify `-DUNSUPPORTED_BUILDS=ON`
+to cmake to be able to use these builds.
+
+The `unix-native` CMake preset is available for these builds. This preset does
+not require VCPKG and instead assumes all build-dependencies are provided by
+the system natively.
diff --git a/README.dco.md b/README.dco.md
index aa93d66..3f7e00c 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -59,8 +59,11 @@
 
 Getting started (Windows)
 -------------------------
-The simplest way to test DCO under Windows is to download the latest installer
-from https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/ .
+Official releases published at https://openvpn.net/community-downloads/
+include ovpn-dco-win driver since 2.6.0.
+
+There are also snapshot releases available at
+https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/ .
 This installer contains the latest OpenVPN code and the ovpn-dco-win driver.
 
 
diff --git a/config.h.cmake.in b/config.h.cmake.in
new file mode 100644
index 0000000..fddee75
--- /dev/null
+++ b/config.h.cmake.in
@@ -0,0 +1,479 @@
+
+/* Configuration settings */
+#define CONFIGURE_DEFINES "N/A"
+
+/* Enable async push */
+#cmakedefine ENABLE_ASYNC_PUSH
+
+/* Use mbed TLS library */
+#cmakedefine ENABLE_CRYPTO_MBEDTLS
+
+/* Use Openssl */
+#cmakedefine ENABLE_CRYPTO_OPENSSL
+
+/* Use wolfSSL crypto library */
+#cmakedefine ENABLE_CRYPTO_WOLFSSL
+
+/* Enable shared data channel offload */
+#cmakedefine ENABLE_DCO
+
+/* Enable debugging support (needed for verb>=4) */
+#define ENABLE_DEBUG 1
+
+/* We have persist tun capability */
+#cmakedefine ENABLE_FEATURE_TUN_PERSIST
+
+/* Enable internal fragmentation support */
+#define ENABLE_FRAGMENT 1
+
+/* Enable linux data channel offload */
+#cmakedefine ENABLE_LINUXDCO
+
+/* Enable LZ4 compression library */
+#cmakedefine ENABLE_LZ4
+
+/* Enable LZO compression library */
+#cmakedefine ENABLE_LZO
+
+/* Enable management server capability */
+#define ENABLE_MANAGEMENT 1
+
+/* Enable OFB and CFB cipher modes */
+#define ENABLE_OFB_CFB_MODE
+
+/* Enable PKCS11 */
+#cmakedefine ENABLE_PKCS11
+
+/* Enable plug-in support */
+#define ENABLE_PLUGIN 1
+
+/* Enable TCP Server port sharing */
+#cmakedefine ENABLE_PORT_SHARE
+
+/* SELinux support */
+#cmakedefine ENABLE_SELINUX
+
+/* enable sitnl support */
+#cmakedefine ENABLE_SITNL
+
+/* Enable systemd integration */
+/* #undef ENABLE_SYSTEMD */
+
+/* Enable --x509-username-field feature */
+#cmakedefine ENABLE_X509ALTUSERNAME
+
+/* Compiler supports anonymous unions */
+#define HAVE_ANONYMOUS_UNION_SUPPORT
+
+/* Define to 1 if you have the <arpa/inet.h> header file. */
+#cmakedefine HAVE_ARPA_INET_H 1
+
+/* Define to 1 if you have the `basename' function. */
+#cmakedefine HAVE_BASENAME
+
+/* Define to 1 if you have the `chdir' function. */
+#cmakedefine HAVE_CHDIR
+
+/* Define to 1 if you have the `chroot' function. */
+#cmakedefine HAVE_CHROOT
+
+/* Define to 1 if you have the `chsize' function. */
+#cmakedefine HAVE_CHSIZE
+
+/* struct cmsghdr needed for extended socket error support */
+#cmakedefine HAVE_CMSGHDR
+
+/* git version information in config-version.h */
+#cmakedefine HAVE_CONFIG_VERSION_H
+
+/* Define to 1 if you have the `daemon' function. */
+#cmakedefine HAVE_DAEMON
+
+/* Define to 1 if you have the declaration of `SO_MARK', and to 0 if you
+don't. */
+#cmakedefine01 HAVE_DECL_SO_MARK
+
+/* Define to 1 if you have the <direct.h> header file. */
+#cmakedefine HAVE_DIRECT_H
+
+/* Define to 1 if you have the `dirname' function. */
+#cmakedefine HAVE_DIRNAME
+
+/* Define to 1 if you have the <dlfcn.h> header file. */
+#cmakedefine HAVE_DLFCN_H
+
+/* Define to 1 if you have the <dmalloc.h> header file. */
+#cmakedefine HAVE_DMALLOC_H
+
+/* Define to 1 if you have the `dup' function. */
+#cmakedefine HAVE_DUP
+
+/* Define to 1 if you have the `dup2' function. */
+#cmakedefine HAVE_DUP2
+
+/* Define to 1 if you have the `epoll_create' function. */
+#cmakedefine HAVE_EPOLL_CREATE
+
+/* Define to 1 if you have the <err.h> header file. */
+#cmakedefine HAVE_ERR_H
+
+/* Crypto library supports keying material exporter */
+#define HAVE_EXPORT_KEYING_MATERIAL 1
+
+/* Define to 1 if you have the <fcntl.h> header file. */
+#cmakedefine HAVE_FCNTL_H
+
+/* Define to 1 if you have the `fork' function. */
+#cmakedefine HAVE_FORK
+#cmakedefine HAVE_EXECVE
+
+/* Define to 1 if you have the `ftruncate' function. */
+#cmakedefine HAVE_FTRUNCATE
+
+/* Define to 1 if you have the `getgrnam' function. */
+#cmakedefine HAVE_GETGRNAM
+
+/* Define to 1 if you have the `getpeereid' function. */
+#cmakedefine HAVE_GETPEEREID
+
+/* Define to 1 if you have the `getpwnam' function. */
+#cmakedefine HAVE_GETPWNAM
+
+/* Define to 1 if you have the `getrlimit' function. */
+#undef HAVE_GETRLIMIT
+
+/* Define to 1 if you have the `getsockname' function. */
+#cmakedefine HAVE_GETSOCKNAME
+
+/* Define to 1 if you have the `gettimeofday' function. */
+#cmakedefine HAVE_GETTIMEOFDAY
+
+/* Define to 1 if you have the <grp.h> header file. */
+#cmakedefine HAVE_GRP_H
+
+/* struct in_pktinfo needed for IP_PKTINFO support */
+#cmakedefine HAVE_IN_PKTINFO
+
+/* Define to 1 if you have the <io.h> header file. */
+#cmakedefine HAVE_IO_H
+
+/* struct in_pktinfo.ipi_spec_dst needed for IP_PKTINFO support */
+#cmakedefine HAVE_IPI_SPEC_DST
+
+/* Define to 1 if you have the <libgen.h> header file. */
+#cmakedefine HAVE_LIBGEN_H
+
+/* Define to 1 if you have the <limits.h> header file. */
+#define HAVE_LIMITS_H 1
+
+/* Define to 1 if you have the <linux/if_tun.h> header file. */
+#cmakedefine HAVE_LINUX_IF_TUN_H
+
+/* Define to 1 if you have the <linux/sockios.h> header file. */
+#cmakedefine HAVE_LINUX_SOCKIOS_H
+
+/* Define to 1 if you have the <linux/types.h> header file. */
+#cmakedefine HAVE_LINUX_TYPES_H
+
+/* Define to 1 if you have the <lzoconf.h> header file. */
+#define HAVE_LZO_CONF_H
+
+/* Define to 1 if you have the <lzo1x.h> header file. */
+#define HAVE_LZO1X_H 1
+
+/* Define to 1 if you have the <lzoutil.h> header file. */
+#define HAVE_LZOUTIL_H 1
+
+/* Define to 1 if you have the `mlockall' function. */
+#cmakedefine HAVE_MLOCKALL
+
+/* struct msghdr needed for extended socket error support */
+#cmakedefine HAVE_MSGHDR
+
+/* Define to 1 if you have the <netdb.h> header file. */
+#cmakedefine HAVE_NETDB_H
+
+/* Define to 1 if you have the <netinet/in.h> header file. */
+#cmakedefine HAVE_NETINET_IN_H
+
+/* Define to 1 if you have the <netinet/ip.h> header file. */
+#cmakedefine HAVE_NETINET_IP_H
+
+/* Define to 1 if you have the <netinet/tcp.h> header file. */
+#undef HAVE_NETINET_TCP_H
+
+/* Define to 1 if you have the <net/if.h> header file. */
+#cmakedefine HAVE_NET_IF_H
+
+/* Define to 1 if you have the <net/if_tun.h> header file. */
+#cmakedefine HAVE_NET_IF_TUN_H
+
+/* Define to 1 if you have the <net/if_utun.h> header file. */
+#cmakedefine01 HAVE_NET_IF_UTUN_H
+
+/* Define to 1 if you have the <net/tun/if_tun.h> header file. */
+#cmakedefine HAVE_NET_TUN_IF_TUN_H
+
+/* Define to 1 if you have the `nice' function. */
+#undef HAVE_NICE
+
+/* Define to 1 if you have the `openlog' function. */
+#cmakedefine HAVE_OPENLOG
+
+/* OpenSSL engine support available */
+#undef HAVE_OPENSSL_ENGINE
+
+/* Define to 1 if you have the `poll' function. */
+#undef HAVE_POLL
+
+/* Define to 1 if you have the <poll.h> header file. */
+#cmakedefine HAVE_POLL_H
+
+/* Define to 1 if you have the `putenv' function. */
+#undef HAVE_PUTENV
+
+/* Define to 1 if you have the <pwd.h> header file. */
+#cmakedefine HAVE_PWD_H
+
+/* Define to 1 if you have the `readv' function. */
+#undef HAVE_READV
+
+/* Define to 1 if you have the `recvmsg' function. */
+#cmakedefine HAVE_RECVMSG
+#cmakedefine HAVE_SENDMSG
+
+/* Define to 1 if you have the <resolv.h> header file. */
+#cmakedefine HAVE_RESOLV_H
+
+/* sa_family_t, needed to hold AF_* info */
+#cmakedefine HAVE_SA_FAMILY_T
+
+/* Define to 1 if you have the `sd_booted' function. */
+#undef HAVE_SD_BOOTED
+
+/* Define to 1 if you have the `setgid' function. */
+#cmakedefine HAVE_SETGID
+
+/* Define to 1 if you have the `setgroups' function. */
+#undef HAVE_SETGROUPS
+
+/* Define to 1 if you have the `setsid' function. */
+#cmakedefine HAVE_SETSID
+
+/* Define to 1 if you have the `setsockopt' function. */
+#define HAVE_SETSOCKOPT 1
+
+/* Define to 1 if you have the `setuid' function. */
+#cmakedefine HAVE_SETUID
+
+/* Define to 1 if you have the <signal.h> header file. */
+#undef HAVE_SIGNAL_H
+
+/* Define to 1 if you have the `socket' function. */
+#undef HAVE_SOCKET
+
+/* struct sock_extended_err needed for extended socket error support */
+#undef HAVE_SOCK_EXTENDED_ERR
+
+/* Define to 1 if you have the `stat' function. */
+#define HAVE_STAT 1
+
+/* Define to 1 if you have the <stdarg.h> header file. */
+#define HAVE_STDARG_H 1
+
+/* Define to 1 if you have the <stdint.h> header file. */
+#define HAVE_STDINT_H 1
+
+/* Define to 1 if you have the <stdio.h> header file. */
+#define HAVE_STDIO_H 1
+
+/* Define to 1 if you have the <stdlib.h> header file. */
+#define HAVE_STDLIB_H 1
+
+/* Define to 1 if you have the `strdup' function. */
+#undef HAVE_STRDUP
+
+/* Define to 1 if you have the <strings.h> header file. */
+#define HAVE_STRINGS_H 1
+
+/* Define to 1 if you have the <string.h> header file. */
+#define HAVE_STRING_H 1
+
+/* Define to 1 if you have the `strsep' function. */
+#undef HAVE_STRSEP
+
+/* Define to 1 if you have the `syslog' function. */
+#cmakedefine HAVE_SYSLOG
+
+/* Define to 1 if you have the <syslog.h> header file. */
+#cmakedefine HAVE_SYSLOG_H
+
+/* Define to 1 if you have the `system' function. */
+#undef HAVE_SYSTEM
+
+/* Define to 1 if you have the <systemd/sd-daemon.h> header file. */
+#undef HAVE_SYSTEMD_SD_DAEMON_H
+
+/* Define to 1 if you have the <sys/epoll.h> header file. */
+#cmakedefine HAVE_SYS_EPOLL_H
+
+/* Define to 1 if you have the <sys/file.h> header file. */
+#undef HAVE_SYS_FILE_H
+
+/* Define to 1 if you have the <sys/inotify.h> header file. */
+#cmakedefine HAVE_SYS_INOTIFY_H
+
+/* Define to 1 if you have the <sys/ioctl.h> header file. */
+#cmakedefine HAVE_SYS_IOCTL_H
+
+/* Define to 1 if you have the <sys/kern_control.h> header file. */
+#undef HAVE_SYS_KERN_CONTROL_H
+
+/* Define to 1 if you have the <sys/mman.h> header file. */
+#cmakedefine HAVE_SYS_MMAN_H
+
+/* Define to 1 if you have the <sys/socket.h> header file. */
+#cmakedefine HAVE_SYS_SOCKET_H
+
+/* Define to 1 if you have the <sys/sockio.h> header file. */
+#undef HAVE_SYS_SOCKIO_H
+
+/* Define to 1 if you have the <sys/stat.h> header file. */
+#define HAVE_SYS_STAT_H 1
+
+/* Define to 1 if you have the <sys/time.h> header file. */
+#cmakedefine HAVE_SYS_TIME_H
+
+/* Define to 1 if you have the <sys/types.h> header file. */
+#undef HAVE_SYS_TYPES_H
+
+/* Define to 1 if you have the <sys/uio.h> header file. */
+#cmakedefine HAVE_SYS_UIO_H
+
+/* Define to 1 if you have the <sys/un.h> header file. */
+#cmakedefine HAVE_SYS_UN_H
+
+/* Define to 1 if you have the <sys/wait.h> header file. */
+#cmakedefine HAVE_SYS_WAIT_H
+
+/* Define to 1 if you have the <tap-windows.h> header file. */
+#undef HAVE_TAP_WINDOWS_H
+
+/* Define to 1 if you have the `time' function. */
+#define HAVE_TIME 1
+
+/* Define to 1 if you have the <time.h> header file. */
+#define HAVE_TIME_H 1
+
+/* Define to 1 if you have the <uapi.h> header file. */
+#undef HAVE_UAPI_H
+
+/* Define to 1 if you have the <unistd.h> header file. */
+#cmakedefine HAVE_UNISTD_H
+
+/* Define to 1 if you have the <valgrind/memcheck.h> header file. */
+#undef HAVE_VALGRIND_MEMCHECK_H
+
+/* Define to 1 if you have the <versionhelpers.h> header file. */
+#undef HAVE_VERSIONHELPERS_H
+
+/* Define to 1 if you have the `vfork' function. */
+#undef HAVE_VFORK
+
+/* Define to 1 if you have the <vfork.h> header file. */
+#undef HAVE_VFORK_H
+
+/* Define to 1 if you have the `vsnprintf' function. */
+#undef HAVE_VSNPRINTF
+
+/* we always assume a recent mbed TLS version */
+#define HAVE_CTR_DRBG_UPDATE_RET 1
+
+/* Path to ifconfig tool */
+#define IFCONFIG_PATH "@IFCONFIG_PATH@"
+
+/* Path to iproute tool */
+#define IPROUTE_PATH "@IPROUTE_PATH@"
+
+/* Path to route tool */
+#define ROUTE_PATH "@ROUTE_PATH@"
+
+/* OpenVPN version in Windows resource format - string */
+#define OPENVPN_VERSION_RESOURCE @OPENVPN_VERSION_RESOURCE@
+
+/* Name of package */
+#define PACKAGE "openvpn"
+
+/* Define to the address where bug reports for this package should be sent. */
+#undef PACKAGE_BUGREPORT
+
+/* Define to the full name of this package. */
+#define PACKAGE_NAME "OpenVPN"
+
+/* Define to the full name and version of this package. */
+#define PACKAGE_STRING "OpenVPN @OPENVPN_VERSION_MAJOR@...220...@OPENVPN_VERSION_MINOR@@OPENVPN_VERSION_PATCH@"
+
+/* Define to the version of this package. */
+#define PACKAGE_VERSION "@OPENVPN_VERSION_MAJOR@...220...@OPENVPN_VERSION_MINOR@@OPENVPN_VERSION_PATCH@"
+
+/* Path to systemd-ask-password tool */
+#undef SYSTEMD_ASK_PASSWORD_PATH
+
+/* systemd is newer than v216 */
+#define SYSTEMD_NEWER_THAN_216
+
+/* The tap-windows id */
+#define TAP_WIN_COMPONENT_ID "tap0901"
+
+/* The tap-windows version number is required for OpenVPN */
+#define TAP_WIN_MIN_MAJOR 9
+
+/* The tap-windows version number is required for OpenVPN */
+#define TAP_WIN_MIN_MINOR 9
+
+/* Are we running on Mac OS X? */
+#cmakedefine TARGET_DARWIN
+
+/* Are we running on FreeBSD? */
+#cmakedefine TARGET_FREEBSD
+
+/* Are we running on Linux? */
+#cmakedefine TARGET_LINUX
+
+/* Are we running WIN32? */
+#cmakedefine TARGET_WIN32
+
+#define TARGET_ALIAS "@CMAKE_SYSTEM_NAME@"
+
+/* Enable GNU extensions on systems that have them.  */
+#ifndef _GNU_SOURCE
+# define _GNU_SOURCE 1
+#endif
+
+
+#if defined(_WIN32)
+#include <inttypes.h>
+typedef uint32_t in_addr_t;
+typedef uint16_t in_port_t;
+
+#define SIGHUP    1
+#define SIGINT    2
+#define SIGUSR1   10
+#define SIGUSR2   12
+#define SIGTERM   15
+#endif
+
+#if defined(_MSC_VER)
+#include <BaseTsd.h>
+typedef SSIZE_T ssize_t;
+#define strncasecmp strnicmp
+#define strcasecmp _stricmp
+
+#define S_IRUSR 0
+#define S_IWUSR 0
+#define R_OK 4
+#define W_OK 2
+#define X_OK 1
+#define F_OK 0
+#endif
+
diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
new file mode 100644
index 0000000..4f78ac4
--- /dev/null
+++ b/contrib/cmake/git-version.py
@@ -0,0 +1,83 @@
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
+# Usage: ./git-version.py [directory]
+# Find a good textual representation of the git commit currently checked out.
+# Make that representation available as CONFIGURE_GIT_REVISION in
+# <directory>/config-version.h.
+# It will prefer a tag name if it is checked out exactly, otherwise will use
+# the branch name. 'none' if no branch is checked out (detached HEAD).
+# This is used to enhance the output of openvpn --version with Git information.
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
index 0000000..791d2ec
--- /dev/null
+++ b/contrib/cmake/parse-version.m4.py
@@ -0,0 +1,64 @@
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
+# Usage: ./parse-version.m4.py m4file [directory]
+# Read <m4file>, extract all lines looking like M4 define(), and translate
+# them into CMake style set(). Those are then written out to file
+# <directory>/version.cmake.
+# Intended to be used on top-level version.m4 file.
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
index 0000000..fc00b01
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
index 0000000..67a1f87
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
index 47919bc..f8da979 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -28,12 +28,28 @@
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
@@ -45,11 +61,11 @@
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
index 0000000..8dfb883
--- /dev/null
+++ b/doc/CMakeLists.txt
@@ -0,0 +1,113 @@
+set(_GENERATE_HTML_DOC YES)
+set(_GENERATE_MAN_DOC  YES)
+set(_MAYBE_PYTHON "")
+find_program(RST2HTML NAMES rst2html rst2html.py)
+find_program(RST2MAN  NAMES rst2man  rst2man.py)
+
+if (RST2HTML STREQUAL "RST2HTML-NOTFOUND")
+    message(STATUS "rst2html not found, not generating HTML documentation")
+    set(_GENERATE_HTML_DOC NO)
+else ()
+    # We only run this for RST2HTML and assume the result would be the same
+    # for RST2MAN
+    if (DEFINED CACHE{DOCUTILS_NEED_PYTHON})
+        if ($CACHE{DOCUTILS_NEED_PYTHON})
+            set(_MAYBE_PYTHON ${PYTHON})
+        endif ()
+    else ()
+        execute_process(
+            COMMAND ${RST2HTML} --version
+            OUTPUT_VARIABLE RST2HTML_VERSION_EXE
+            )
+        execute_process(
+            COMMAND ${PYTHON} ${RST2HTML} --version
+            OUTPUT_VARIABLE RST2HTML_VERSION_PY
+            )
+        set(_DOCUTILS_NEED_PYTHON OFF)
+        if(RST2HTML_VERSION_EXE STREQUAL "")
+            if(RST2HTML_VERSION_PY STREQUAL "")
+                message(STATUS "${RST2HTML} found but not working, not generating documentation")
+                set(_GENERATE_HTML_DOC NO)
+                set(_GENERATE_MAN_DOC NO)
+            else ()
+                message(STATUS "${RST2HTML} needs to be executed by ${PYTHON} to work")
+                set(_MAYBE_PYTHON ${PYTHON})
+                set(_DOCUTILS_NEED_PYTHON ON)
+            endif ()
+        endif ()
+        set(DOCUTILS_NEED_PYTHON ${_DOCUTILS_NEED_PYTHON} CACHE BOOL
+            "Whether we need to call python instead of rst2*.py directly")
+    endif (DEFINED CACHE{DOCUTILS_NEED_PYTHON})
+endif ()
+if (RST2MAN STREQUAL "RST2MAN-NOTFOUND")
+    message(STATUS "rst2man not found, not generating man pages")
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
+        COMMAND ${_MAYBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html
+        MAIN_DEPENDENCY openvpn.8.rst
+        DEPENDS ${OPENVPN_SECTIONS}
+        )
+    add_custom_command(
+        OUTPUT openvpn-examples.5.html
+        COMMAND ${_MAYBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5.html
+        MAIN_DEPENDENCY openvpn-examples.5.rst
+        DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
+        )
+endif ()
+if (_GENERATE_MAN_DOC)
+    list(APPEND ALL_DOCS openvpn.8 openvpn-examples.5)
+    add_custom_command(
+        OUTPUT openvpn.8
+        COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8
+        MAIN_DEPENDENCY openvpn.8.rst
+        DEPENDS ${OPENVPN_SECTIONS}
+        )
+    add_custom_command(
+        OUTPUT openvpn-examples.5
+        COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5
+        MAIN_DEPENDENCY openvpn-examples.5.rst
+        DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
+        )
+endif ()
+
+add_custom_target(documentation ALL DEPENDS ${ALL_DOCS})
+
diff --git a/doc/Makefile.am b/doc/Makefile.am
index d8ffe2e..087f0ce 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -63,7 +63,8 @@
 	README.plugins \
 	tls-crypt-v2.txt \
 	$(openvpn_sections) \
-	$(openvpn_examples_sections)
+	$(openvpn_examples_sections) \
+	CMakeLists.txt
 
 EXTRA_DIST = tests
 
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index 460b9e9..a01814d 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -72,7 +72,10 @@
 
     if (!nochdir)
     {
-        chdir("/");
+        if (chdir("/") == -1)
+        {
+            return (-1);
+        }
     }
 
     if (!noclose)
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index c572354..f05c002 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -37,7 +37,14 @@
  * @addtogroup compression
  * @{
  */
-
+#if defined(HAVE_LZO_CONF_H)
+/* The lzo.h magic gets confused and still wants
+ * to include lzo/lzoconf.h even if our include paths
+ * are setup to include the paths without lzo/ include lzoconf.h to
+ * avoid it being include by lzoutil.h */
+#include <lzodefs.h>
+#include <lzoconf.h>
+#endif
 #if defined(HAVE_LZO_LZOUTIL_H)
 #include <lzo/lzoutil.h>
 #elif defined(HAVE_LZOUTIL_H)
diff --git a/src/openvpnmsica/CMakeLists.txt b/src/openvpnmsica/CMakeLists.txt
new file mode 100644
index 0000000..9126b80
--- /dev/null
+++ b/src/openvpnmsica/CMakeLists.txt
@@ -0,0 +1,44 @@
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
+
+if (MSVC)
+    target_compile_options(openvpnmsica PRIVATE
+        "$<$<CONFIG:Release>:/MT>"
+        "$<$<CONFIG:Debug>:/MTd>"
+        )
+endif ()
+
+target_link_libraries(openvpnmsica
+    advapi32.lib ole32.lib msi.lib setupapi.lib iphlpapi.lib shell32.lib shlwapi.lib version.lib newdev.lib)
+if (MINGW)
+    target_compile_options(openvpnmsica PRIVATE -municode)
+    target_link_options(openvpnmsica PRIVATE -municode)
+    target_link_options(openvpnmsica PRIVATE
+        -Wl,--kill-at)
+endif ()
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 6da0754..d68a008 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -34,6 +34,9 @@
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
index 0000000..17cd90c
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
index b8b2a37..4c0ac40 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -19,6 +19,9 @@
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
index 0000000..97702c0
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
index 3896351..fe8ab2a 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -33,6 +33,10 @@
 AM_CFLAGS = \
 	$(TAP_CFLAGS)
 
+EXTRA_DIST = \
+	CMakeLists.txt \
+	tapctl.exe.manifest
+
 if WIN32
 sbin_PROGRAMS = tapctl
 tapctl_CFLAGS = \

