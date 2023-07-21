From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 21 Jul 2023 13:55:46 +0000
References: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <b8c6bb0c399dc2dc55455d08c65cc03211be28f5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w9/13h64Bn8="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.6]: CMake:
 backport CMake buildsystem from master to release/2.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w9/13h64Bn8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/315?usp=3Demail )


Change subject: CMake: backport CMake buildsystem from master to release/2.6
......................................................................

CMake: backport CMake buildsystem from master to release/2.6

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
- CMake: Support doc builds on Windows machines that do not have .py file a=
ssociation
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

Change-Id: I6de18261d5dc7f8561612184059656c73f33a5f2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Co-authored-by: Arne Schwabe <arne@...1227...>
Co-authored-by: Lev Stipakov <lev@...515...>
---
M .github/workflows/build.yaml
M .gitignore
A CMakeLists.txt
A CMakePresets.json
M Makefile.am
M README
A README.cmake.md
M README.dco.md
A config.h.cmake.in
A contrib/cmake/git-version.py
A contrib/cmake/parse-version.m4.py
A contrib/vcpkg-manifests/mingw/vcpkg.json
A contrib/vcpkg-manifests/windows/vcpkg.json
M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
A doc/CMakeLists.txt
M doc/Makefile.am
M src/openvpn/lzo.h
A src/openvpnmsica/CMakeLists.txt
M src/openvpnmsica/Makefile.am
A src/openvpnserv/CMakeLists.txt
M src/openvpnserv/Makefile.am
A src/tapctl/CMakeLists.txt
M src/tapctl/Makefile.am
23 files changed, 2,084 insertions(+), 246 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/315/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 8a80c67..29fe6d7 100644
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
-        run: sudo apt update && sudo apt install -y mingw-w64 libtool auto=
make autoconf man2html unzip cmake ninja-build build-essential wget
+        run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake =
ninja-build build-essential wget python3-docutils man2html-base
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
-          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{ env.LZ=
O_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }=
}--${{ env.CMOCKA_VERSION }}
+          configurePreset: mingw-${{ matrix.arch }}
+          buildPreset: mingw-${{ matrix.arch }}
+          buildPresetAdditionalArgs: "['--config Debug']"

-      # Repeating  if: steps.cache.outputs.cache-hit !=3D 'true'
-      # on every step for building dependencies is ugly but
-      # I haven't found a better solution so far.
-
-      - name: Download mingw dependencies
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: |
-          wget -c -P download-cache/ "https://build.openvpn.net/downloads/=
releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
-          wget -c -P download-cache/ "https://www.oberhumer.com/opensource=
/lzo/download/lzo-${LZO_VERSION}.tar.gz"
-          wget -c -P download-cache/ "https://github.com/OpenSC/pkcs11-hel=
per/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-=
${PKCS11_HELPER_VERSION}.tar.bz2"
-          wget -c -P download-cache/ "https://github.com/coreboot/cmocka/a=
rchive/refs/tags/cmocka-${CMOCKA_VERSION}.tar.gz"
-          tar jxf "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.t=
ar.bz2"
-          wget -c -P download-cache/ "https://www.openssl.org/source/old/1=
.1.1/openssl-${OPENSSL_VERSION}.tar.gz" || wget -c -P download-cache/ "http=
s://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
-          tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
-          tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
-          tar zxf "download-cache/cmocka-${CMOCKA_VERSION}.tar.gz"
-          unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
-
-      - name: create cmocka build directory
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: mkdir cmocka-build
-
-      - name: configure cmocka
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        working-directory: "./cmocka-build"
-        run: cmake -GNinja -DCMAKE_C_COMPILER=3D${{ matrix.chost }}-gcc -D=
CMAKE_CXX_COMPILER=3D${{ matrix.chost }}-g++ -DCMAKE_SYSTEM_NAME=3DWindows =
-DCMAKE_SHARED_LINKER_FLAGS=3D-static-libgcc -DCMAKE_PREFIX_PATH=3D${HOME}/=
mingw/opt/lib/pkgconfig/ -DCMAKE_INCLUDE_PATH=3D${HOME}/mingw/opt/lib/inclu=
de -DCMAKE_LIBRARY_PATH=3D${HOME}/mingw/opt/lib -DCMAKE_INSTALL_PREFIX=3D${=
HOME}/mingw/opt/ ../cmocka-cmocka-${{ env.CMOCKA_VERSION }}
-
-      - name: build cmocka
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        working-directory: "./cmocka-build"
-        run: ninja
-
-      - name: install cmocka
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        working-directory: "./cmocka-build"
-        run: ninja install
-
-      - name: Configure OpenSSL
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: ./Configure --cross-compile-prefix=3D${{ matrix.chost }}- sha=
red ${{ matrix.target }} no-capieng --prefix=3D"${HOME}/mingw/opt" --openss=
ldir=3D"${HOME}/mingw/opt" -static-libgcc
-        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
-
-      - name: Build OpenSSL
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: make
-        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
-
-      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 instead of
-      # mingw/opt/lib, so we include both dirs in the following steps
-      # (pkcs11-helper and OpenVPN) so the libraries will be found
-      - name: Install OpenSSL
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: make install
-        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
-
-      - name: autoreconf pkcs11-helper
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: autoreconf -iv
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"
-
-      - name: configure pkcs11-helper
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: OPENSSL_LIBS=3D"-L${HOME}/mingw/opt/lib -L${HOME}/mingw/opt/l=
ib64 -lssl -lcrypto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PKG_CONFIG_=
PATH=3D${HOME}/mingw/opt/lib/pkgconfig ./configure --host=3D${{ matrix.chos=
t }} --program-prefix=3D'' --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HO=
ME}/mingw/opt --build=3Dx86_64-pc-linux-gnu --disable-crypto-engine-gnutls =
--disable-crypto-engine-nss --disable-crypto-engine-polarssl --disable-cryp=
to-engine-mbedtls
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"
-
-      - name: build pkcs11-helper
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: make all
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"
-
-      - name: install pkcs11-helper
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: make install
-        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"
-
-      - name: Configure lzo
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: ./configure --host=3D${{ matrix.chost }} --program-prefix=3D'=
' --libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt --build=3Dx=
86_64-pc-linux-gnu
-        working-directory: "./lzo-${{ env.LZO_VERSION }}"
-
-      - name: build lzo
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        working-directory: "./lzo-${{ env.LZO_VERSION }}"
-        run: make
-
-      - name: install lzo
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        working-directory: "./lzo-${{ env.LZO_VERSION }}"
-        run: make install
-
-      - name: copy tap-windows.h header
-        if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h=
 ${HOME}/mingw/opt/include/
-
-      - name: configure OpenVPN
-        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig LDFLAGS=3D-=
L$HOME/mingw/opt/lib CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L$=
{HOME}/opt/lib -L$HOME/mingw/opt/lib64 -lssl -lcrypto" OPENSSL_CFLAGS=3D-I$=
HOME/mingw/opt/include PREFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/=
opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=
=3D${{ matrix.chost }} --disable-lz4
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
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }=
}-dlls
-          path: '~/mingw/opt/bin/*.dll'
+          name: openvpn-mingw-${{ matrix.arch }}
+          path: |
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
+            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

-      # libtool puts some wrapper binaries in openvpn/tests/unit_tests/ope=
nvpn/
-      # and the real binaries in openvpn/tests/unit_tests/openvpn/.libs/
-      - name: Archive unittest artifacts
-        uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2689...
         with:
-          retention-days: 1
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }=
}-tests
-          path: openvpn/tests/unit_tests/openvpn/.libs/*.exe
-
-      # Currently not used by the unit test but might in the future and al=
so
-      # helpful if manually downloading and running openvpn.exe from a min=
gw
-      # build
-      - name: Archive openvpn binary
-        uses: actions/upload-artifact@...2689...
-        with:
-          retention-days: 1
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }=
}-tests
-          path: openvpn/src/openvpn/.libs/*.exe
+          name: openvpn-mingw-${{ matrix.arch }}-tests
+          path: |
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll

   mingw-unittest:
     needs: [ mingw ]
     strategy:
       fail-fast: false
       matrix:
-        osslver: [ 1.1.1q, 3.0.5 ]
-        target: [ mingw64, mingw ]
+        arch: [x86, x64]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, tls_crypt]

     runs-on: windows-latest
-    name: "mingw unittests - ${{matrix.target}} - OSSL ${{ matrix.osslver =
}}"
+    name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
-      - name: Retrieve mingw unittest dlls
-        uses: actions/download-artifact@...2689...
-        with:
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }=
}-dlls
-          path: unittests
-
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2689...
         with:
-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }=
}-tests
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
-        VCPKG_OVERLAY_TRIPLETS: ${{ github.workspace }}/contrib/vcpkg-trip=
lets

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

       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
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
-            # workaround for GHA runner bug where vcpkg installation is de=
tected at c:\vcpkg
-            # see https://github.com/lukka/run-vcpkg/issues/170
-            ${{ github.workspace }}/vcpkg/vcpkg.exe integrate install
-            msbuild /m /p:Configuration=3D${{env.BUILD_CONFIGURATION}} /p:=
Platform=3D"${{ matrix.plat }}" .
-
-      - name: Archive artifacts
-        uses: actions/upload-artifact@...2689...
+      - name: Run CMake with vcpkg.json manifest (NO TESTS)
+        uses: lukka/run-cmake@...2637...
+        if: ${{ matrix.arch =3D=3D 'arm64' }}
         with:
-          name: artifacts-${{ matrix.plat }}
+          configurePreset: win-${{ matrix.arch }}-release
+          buildPreset: win-${{ matrix.arch }}-release
+
+      - name: Run CMake with vcpkg.json manifest
+        uses: lukka/run-cmake@...2637...
+        if: ${{ matrix.arch !=3D 'arm64' }}
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

   trigger_openvpn_build:
     runs-on: windows-latest
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
index 0000000..5490582
--- /dev/null
+++ b/CMakeLists.txt
@@ -0,0 +1,738 @@
+cmake_minimum_required(VERSION 3.12)
+set(CMAKE_CONFIGURATION_TYPES "Release;Debug;ASAN")
+project(openvpn)
+
+# This CMake file implements building OpenVPN with CMAKE
+#
+# Note that this is *NOT* the official way to build openvpn on anything
+# other than Windows/mingw despite working on other platforms too. You wil=
l need
+# to add -DUNSUPPORTED_BUILDS=3Dtrue to build on non Windows platforms.
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
+    message(FATAL_ERROR "Note: on Unix platform the official and supported=
 build method is using autoconfig. CMake based build should be only used fo=
r Windows and internal testing/development.")
+endif()
+
+if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/config.h")
+    message(FATAL_ERROR "The top level source directory has a config.h fil=
e. Note that you can't mix in-tree autoconfig builds with out-of-tree cmake=
 builds.")
+endif ()
+
+option(MBED "BUILD with mbed" OFF)
+option(WOLFSSL "BUILD with wolfSSL" OFF)
+option(ENABLE_LZ4 "BUILD with lz4" ON)
+option(ENABLE_LZO "BUILD with lzo" ON)
+option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
+option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
+
+set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")
+
+# AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=
=3Dasan to build with ASAN
+set(CMAKE_C_FLAGS_ASAN
+    "-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-optim=
ize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointe=
r -g -O1"
+    CACHE STRING "Flags used by the C compiler during AddressSanitizer bui=
lds."
+    FORCE)
+set(CMAKE_CXX_FLAGS_ASAN
+    "-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-optim=
ize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointe=
r -g -O1"
+    CACHE STRING "Flags used by the C++ compiler during AddressSanitizer b=
uilds."
+    FORCE)
+
+if (MSVC)
+    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE =
-D_WINSOCK_DEPRECATED_NO_WARNINGS)
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
+    if (${CMAKE_GENERATOR_PLATFORM} STREQUAL "x64" OR ${CMAKE_GENERATOR_PL=
ATFORM} STREQUAL "x86")
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
+    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-vers=
ion.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
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
+check_struct_has_member("struct in_pktinfo" ipi_spec_dst netinet/ip.h HAVE=
_IPI_SPEC_DST)
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
+    pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED_T=
ARGET)
+endif ()
+
+function(add_library_deps target)
+    if (${MBED})
+        target_link_libraries(${target} -lmbedtls -lmbedx509 -lmbedcrypto)
+    elseif (${WOLFSSL})
+        pkg_search_module(wolfssl wolfssl REQUIRED)
+        target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
+        target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIR=
S}/wolfssl)
+    else ()
+        set(ENABLE_X509ALTUSERNAME YES)
+
+        find_package(OpenSSL REQUIRED)
+        target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypt=
o)
+        if (WIN32)
+            target_link_libraries(${target} PUBLIC
+                ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi.lib
+                wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.li=
b bcrypt.lib)
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
+        target_link_libraries(${target} PUBLIC PkgConfig::libcapng PkgConf=
ig::libnl)
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
+    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-versio=
n.py
+    )
+set(HAVE_CONFIG_VERSION_H YES)
+
+configure_file(config.h.cmake.in config.h)
+configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
+# TODO remove later when msvc-config.h is removed and we can always includ=
e config.h
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
+        -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
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
+    target_compile_options(openvpn PRIVATE -DPLUGIN_LIBDIR=3D\"${PLUGIN_DI=
R}\")
+
+    find_library(resolv resolv)
+    # some platform like BSDs already include resolver functionality in th=
e libc and not have an extra resolv library
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
+    # This test requires cmake >=3D 3.18, so check if check_linker_flag is
+    # available
+    if (COMMAND check_linker_flag)
+        check_linker_flag(C -Wl,--wrap=3Dparse_line LD_SUPPORTS_WRAP)
+    endif()
+
+    if (${LD_SUPPORTS_WRAP})
+        list(APPEND unit_tests
+            "test_argv"
+            "test_tls_crypt"
+            )
+    endif ()
+
+    # These tests work on only on Linux since they depend on special Linux=
 features
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
+        target_link_options(test_argv PRIVATE -Wl,--wrap=3Dparse_line)
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
+        target_link_options(test_networking PRIVATE -Wl,--wrap=3Dparse_lin=
e)
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
+        target_link_options(test_tls_crypt PRIVATE -Wl,--wrap=3Dparse_line)
+        target_link_options(test_tls_crypt PRIVATE
+            -Wl,--wrap=3Dbuffer_read_from_file
+            -Wl,--wrap=3Dbuffer_write_file
+            -Wl,--wrap=3Drand_bytes)
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
+                    "value": "$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.=
cmake",
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
+                "VCPKG_MANIFEST_DIR": "${sourceDir}/contrib/vcpkg-manifest=
s/windows",
+                "VCPKG_HOST_TRIPLET": "x64-windows"
+            },
+            "vendor": { "microsoft.com/VisualStudioSettings/CMake/1.0": { =
"hostOS": [ "Windows" ] } }
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
+                "VCPKG_MANIFEST_DIR": "${sourceDir}/contrib/vcpkg-manifest=
s/mingw"
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

 EXTRA_DIST =3D \
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
+Community-provided Windows installers (MSI) and Debian packages are built =
from

   https://github.com/OpenVPN/openvpn-build

diff --git a/README.cmake.md b/README.cmake.md
new file mode 100644
index 0000000..599d8dc
--- /dev/null
+++ b/README.cmake.md
@@ -0,0 +1,137 @@
+OpenVPN Builds with CMake
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+For Windows builds we do not use the autotools-based buildsystem that we u=
se
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
+can them install with a package manager of your choice (e.g.
+chocolatey, winget) or manually:
+
+* CMake
+* Git
+* Python (3.x), plus the Python module `docutils`
+* Visual Studion 17 (2022), C/C++ Enviroment
+
+For example, to prepare the required tools with chocolatey, you
+can use the following commands (Powershell):
+
+    # Installing Chocolatey
+    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServiceP=
ointManager]::SecurityProtocol =3D [System.Net.ServicePointManager]::Securi=
tyProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString=
('https://chocolatey.org/install.ps1'))
+    & choco.exe install -y git --params "/GitAndUnixToolsOnPath"
+    & choco.exe install -y python
+    & python.exe -m ensurepip
+    & python.exe -m pip install --upgrade pip
+    & python.exe -m pip install docutils
+    & choco.exe install -y cmake --installargs 'ADD_CMAKE_TO_PATH=3DSystem'
+    & choco.exe install -y "visualstudio2022buildtools"
+    & choco.exe install -y "visualstudio2022-workload-vctools" --params "-=
-add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Microsoft.VisualSt=
udio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.VC.ATL=
.Spectre --add Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre --add Mic=
rosoft.VisualStudio.Component.VC.ATL.ARM64.Spectre --add Microsoft.VisualSt=
udio.Component.VC.MFC.ARM64.Spectre --add Microsoft.VisualStudio.Component.=
VC.Runtimes.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.Runtime=
s.x86.x64.Spectre --quiet"
+    & choco.exe install -y windows-sdk-10-version-2004-windbg
+
+One or more restarts of Powershell might be required to pick up new additi=
ons
+to `PATH` between steps. A Windows restart is probably required after
+installing Visual Studio before being able to use it.
+You can find the exact commands we use to set up the community build machi=
nes
+at https://github.com/OpenVPN/openvpn-buildbot/blob/master/jenkins/windows=
-server/msibuild.pkr.hcl
+
+To do a default build, assuming you are in a MSVC 17 2022 environment:
+
+    mkdir C:\OpenVPN
+    cd C:\OpenVPN
+    git clone https://github.com/microsoft/vcpkg.git
+    git clone https://github.com/OpenVPN/openvpn.git
+    set VCPKG_ROOT=3DC:\OpenVPN\vcpkg
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
+    # minimum required tools for vcpkg bootstrap: curl, zip, unzip, tar, e=
.g.
+    sudo apt-get install -y curl zip unzip tar
+    # additionally vcpkg requires powershell when building Windows binarie=
s.
+    # See https://learn.microsoft.com/en-us/powershell/scripting/install/i=
nstalling-powershell-on-linux
+    # e.g.
+    sudo apt-get install -y wget apt-transport-https software-properties-c=
ommon
+    wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -r=
s)/packages-microsoft-prod.deb"
+    sudo dpkg -i packages-microsoft-prod.deb
+    sudo apt-get update
+    sudo apt-get install -y powershell
+    # minimum required tools for build: cmake, docutils, git, ninja,
+    # pkg-config, python e.g.
+    sudo apt-get install -y cmake git ninja-build pkg-config python3 pytho=
n3-docutils
+    # additionally required to build pkcs11-helper: automake, autoconf,
+    # man2html, e.g.
+    sudo apt-get install -y automake autoconf man2html-base
+    mkdir mingw
+    cd mingw
+    git clone https://github.com/microsoft/vcpkg.git
+    git clone https://github.com/OpenVPN/openvpn.git
+    export VCPKG_ROOT=3D$PWD/vcpkg
+    cd openvpn
+    cmake --preset mingw-x64
+    cmake --build --preset mingw-x64
+    # unit tests are built, but no testPreset is provided. You need to copy
+    # them to a Windows system manually
+
+The instructions have been verified on a Ubuntu 22.04 LTS system in a
+bash shell, and might need adaptions to other Linux distributions/versions.
+
+Note that the MinGW preset builds use the `Ninja multi-config` generator, =
so
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
+The CMake buildsystem also supports builds on Unix-like platforms. These b=
uilds
+are sometimes useful for OpenVPN developers (e.g. when they use IDEs with
+integrated CMake support). However, they are not officially supported, do =
not
+include any install support and should not be used to distribute/package
+OpenVPN. To emphasize this fact, you need to specify `-DUNSUPPORTED_BUILDS=
=3DON`
+to cmake to be able to use these builds.
+
+The `unix-native` CMake preset is available for these builds. This preset =
does
+not require VCPKG and instead assumes all build-dependencies are provided =
by
+the system natively.
diff --git a/README.dco.md b/README.dco.md
index aa93d66..3f7e00c 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -59,8 +59,11 @@

 Getting started (Windows)
 -------------------------
-The simplest way to test DCO under Windows is to download the latest insta=
ller
-from https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2=
/ .
+Official releases published at https://openvpn.net/community-downloads/
+include ovpn-dco-win driver since 2.6.0.
+
+There are also snapshot releases available at
+https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/ .
 This installer contains the latest OpenVPN code and the ovpn-dco-win drive=
r.


diff --git a/config.h.cmake.in b/config.h.cmake.in
new file mode 100644
index 0000000..7ef7175
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
+/* Enable debugging support (needed for verb>=3D4) */
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
+#undef HAVE_OPENLOG
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
+#undef HAVE_SETSID
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
+#undef HAVE_SYSLOG
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
+/* Define to the address where bug reports for this package should be sent=
. */
+#undef PACKAGE_BUGREPORT
+
+/* Define to the full name of this package. */
+#define PACKAGE_NAME "OpenVPN"
+
+/* Define to the full name and version of this package. */
+#define PACKAGE_STRING "OpenVPN @OPENVPN_VERSION_MAJOR@...220...@OPENVPN_V=
ERSION_MINOR@@OPENVPN_VERSION_PATCH@"
+
+/* Define to the version of this package. */
+#define PACKAGE_VERSION "@OPENVPN_VERSION_MAJOR@...220...@OPENVPN_VERSION_=
MINOR@@OPENVPN_VERSION_PATCH@"
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
index 0000000..c2b4452
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
+    sp =3D subprocess.Popen(args, stdout=3Dsubprocess.PIPE, stderr=3Dsubpr=
ocess.DEVNULL)
+    o, _ =3D sp.communicate()
+    return o.decode("utf-8")[:-1]
+
+def get_branch_commit_id():
+    commit_id =3D run_command(["git", "rev-parse", "--short=3D16", "HEAD"])
+    if not commit_id:
+        raise
+    branch =3D run_command(["git", "describe", "--exact-match"])
+    if not branch:
+        # this returns an array like ["master"] or ["release", "2.6"]
+        branch =3D run_command(["git", "rev-parse", "--symbolic-full-name"=
, "HEAD"]).split("/")[2:]
+        if not branch:
+            branch =3D ["none"]
+        branch =3D "/" .join(branch) # handle cases like release/2.6
+
+    return branch, commit_id
+
+def main():
+    try:
+        branch, commit_id =3D get_branch_commit_id()
+    except:
+        branch, commit_id =3D "unknown", "unknown"
+
+    prev_content =3D ""
+
+    name =3D os.path.join("%s" %  (sys.argv[1] if len(sys.argv) > 1 else "=
."), "config-version.h")
+    try:
+        with open(name, "r") as f:
+            prev_content =3D f.read()
+    except:
+        # file doesn't exist
+        pass
+
+    content =3D "#define CONFIGURE_GIT_REVISION \"%s/%s\"\n" % (branch, co=
mmit_id)
+    content +=3D "#define CONFIGURE_GIT_FLAGS \"\"\n"
+
+    if prev_content !=3D content:
+        print("Writing %s" % name)
+        with open(name, "w") as f:
+            f.write(content)
+    else:
+        print("Content of %s hasn't changed" % name)
+
+if __name__ =3D=3D "__main__":
+    main()
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-versio=
n.m4.py
new file mode 100644
index 0000000..26af6a8
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
+    version_path =3D sys.argv[1]
+    output =3D []
+    with open(version_path, 'r') as version_file:
+        for line in version_file:
+            match =3D re.match(r'[ \t]*define\(\[(.*)\],[ \t]*\[(.*)\]\)[ =
\t]*', line)
+            if match is not None:
+                output.append(match.expand(r'set(\1 \2)'))
+    out_path =3D os.path.join("%s" %  (sys.argv[2] if len(sys.argv) > 2 el=
se "."), "version.cmake")
+
+    prev_content =3D ""
+    try:
+        with open(out_path, "r") as out_file:
+            prev_content =3D out_file.read()
+    except:
+        # file doesn't exist
+        pass
+
+    content =3D "\n".join(output) + "\n"
+    if prev_content !=3D content:
+        print("Writing %s" % out_path)
+        with open(out_path, "w") as out_file:
+            out_file.write(content)
+    else:
+        print("Content of %s hasn't changed" % out_path)
+
+if __name__ =3D=3D "__main__":
+    main()
+
diff --git a/contrib/vcpkg-manifests/mingw/vcpkg.json b/contrib/vcpkg-manif=
ests/mingw/vcpkg.json
new file mode 100644
index 0000000..fc00b01
--- /dev/null
+++ b/contrib/vcpkg-manifests/mingw/vcpkg.json
@@ -0,0 +1,13 @@
+{
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scr=
ipts/vcpkg.schema.json",
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
diff --git a/contrib/vcpkg-manifests/windows/vcpkg.json b/contrib/vcpkg-man=
ifests/windows/vcpkg.json
new file mode 100644
index 0000000..67a1f87
--- /dev/null
+++ b/contrib/vcpkg-manifests/windows/vcpkg.json
@@ -0,0 +1,20 @@
+{
+  "$schema": "https://raw.githubusercontent.com/microsoft/vcpkg/master/scr=
ipts/vcpkg.schema.json",
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
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake
index 47919bc..f8da979 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -28,12 +28,28 @@
         OPENSSL_HOME=3D${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
   )

-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib RENAME pkcs11-helper=
.lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-=
helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib RENAME pkcs11-=
helper.lib)

   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs=
11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

+  set(PACKAGE_VERSION "${VERSION}")
+    set(libdir [[${prefix}/lib]])
+    set(exec_prefix [[${prefix}]])
+    set(PKCS11H_FEATURES key_prompt openssl engine_crypto_cryptoapi engine=
_crypto_openssl debug threading token data certificate slotevent engine_cry=
pto)
+    set(LIBS -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -lol=
eaut32 -luuid -lcomdlg32 -ladvapi32)
+    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "release")
+        set(includedir [[${prefix}/include]])
+        set(outfile "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helpe=
r-1.pc")
+        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${ou=
tfile}" @ONLY)
+    endif()
+    if(NOT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL "debug")
+        set(includedir [[${prefix}/../include]])
+        set(outfile "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libpkcs11=
-helper-1.pc")
+        configure_file("${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in" "${ou=
tfile}" @ONLY)
+    endif()
+
   file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURR=
ENT_PACKAGES_DIR}/include/)

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

 file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/sh=
are/${PORT} RENAME copyright)
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
+                message(STATUS "${RST2HTML} found but not working, not gen=
erating documentation")
+                set(_GENERATE_HTML_DOC NO)
+                set(_GENERATE_MAN_DOC NO)
+            else ()
+                message(STATUS "${RST2HTML} needs to be executed by ${PYTH=
ON} to work")
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
+        COMMAND ${_MAYBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_=
SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html
+        MAIN_DEPENDENCY openvpn.8.rst
+        DEPENDS ${OPENVPN_SECTIONS}
+        )
+    add_custom_command(
+        OUTPUT openvpn-examples.5.html
+        COMMAND ${_MAYBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_=
SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-exam=
ples.5.html
+        MAIN_DEPENDENCY openvpn-examples.5.rst
+        DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
+        )
+endif ()
+if (_GENERATE_MAN_DOC)
+    list(APPEND ALL_DOCS openvpn.8 openvpn-examples.5)
+    add_custom_command(
+        OUTPUT openvpn.8
+        COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_S=
OURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8
+        MAIN_DEPENDENCY openvpn.8.rst
+        DEPENDS ${OPENVPN_SECTIONS}
+        )
+    add_custom_command(
+        OUTPUT openvpn-examples.5
+        COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_S=
OURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examp=
les.5
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

 EXTRA_DIST =3D tests

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
diff --git a/src/openvpnmsica/CMakeLists.txt b/src/openvpnmsica/CMakeLists.=
txt
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
+    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
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
+    advapi32.lib ole32.lib msi.lib setupapi.lib iphlpapi.lib shell32.lib s=
hlwapi.lib version.lib newdev.lib)
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
 AM_CFLAGS =3D \
 	$(TAP_CFLAGS)

+EXTRA_DIST =3D \
+	CMakeLists.txt
+
 if WIN32
 lib_LTLIBRARIES =3D libopenvpnmsica.la
 libopenvpnmsica_la_CFLAGS =3D \
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
+    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
+    )
+target_link_libraries(openvpnserv
+    advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib shlwapi.=
lib netapi32.lib ws2_32.lib ntdll.lib)
+if (MINGW)
+    target_compile_options(openvpnserv PRIVATE -municode)
+    target_link_options(openvpnserv PRIVATE -municode)
+endif ()
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index b8b2a37..4c0ac40 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -19,6 +19,9 @@
 AM_CPPFLAGS =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/c=
ompat

+EXTRA_DIST =3D \
+	CMakeLists.txt
+
 if WIN32
 sbin_PROGRAMS =3D openvpnserv
 openvpnserv_CFLAGS =3D \
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
+    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
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
 AM_CFLAGS =3D \
 	$(TAP_CFLAGS)

+EXTRA_DIST =3D \
+	CMakeLists.txt \
+	tapctl.exe.manifest
+
 if WIN32
 sbin_PROGRAMS =3D tapctl
 tapctl_CFLAGS =3D \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6de18261d5dc7f8561612184059656c73f33a5f2
Gerrit-Change-Number: 315
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--w9/13h64Bn8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">CMake: backport CMake buildsystem from master to release/2.6<br><br=
>This is based on the initial CMake patch by<br>Arne Schwabe, but extends t=
hat to provide<br>a complete replacement for existing MinGW<br>build (autot=
ools based) and MSVC build<br>(openvpn.sln).<br><br>The following features =
are added while switching<br>these builds to CMake:<br> - vcpkg support for=
 MinGW build, allowing for<br>   trivial cross-compilation on Linux<br> - A=
dd unittests to MSVC build<br> - Rework MSVC config header generation, remo=
ving<br>   need for separate headers between autotools<br>   and MSVC<br><b=
r>The following advantages are reasons for switching<br>to CMake over the e=
xisting MSVC build:<br> - Easier to maintain CMake files without IDE<br>   =
than the sln and vcxproj files<br> - Able to maintain MSVC and MinGW build =
side-by-side<br><br>The plan is to completely remove the existing MSVC<br>b=
uild system but leave the existing autotools builds<br>in place as-is, incl=
uding MinGW support.<br><br>CMake is not the intended build system for Unix=
-like<br>platforms and there are no current plans to switch<br>to it.<br><b=
r>This commits squashes a lot of commits from master<br>together, since mos=
t of them are just fixes or<br>enhancements for the original CMake commit. =
The<br>decisions was not to bloat the release/2.6 commit<br>history with th=
ese detours.<br><br>It contains the following commits:<br>- add basic CMake=
 based build<br>  (commit 0134184012dd46ec44cbca7eb3ece39037ae0bfa by<br>  =
 Arne Schwabe)<br>- CMake: Add complete MinGW and MSVC build<br>  (commit e=
8881ec6dd63bd80ce05202573eac54ab8657fcb)<br>- CMake: Add /Brepro to MSVC li=
nk options<br>  (commit 5e94e8de4bfaf6637124947a3489710b591e5e26)<br>- Do n=
ot blindly assume python3 is also the interpreter that runs rst2html<br>  (=
commit 5dbec1c019d14880ae7bf364b062d3589c7fd9e7 by<br>   Arne Schwabe)<br>-=
 Only add -Wno-stringop-truncation on supported compilers<br>  (commit eb3c=
d5ea36f9bf235da7b8a51fd6ce29780f0e39 by<br>   Arne Schwabe)<br>- CMake: Thr=
ow a clear error when config.h in top-level source directory<br>  (commit 0=
652ae84f4528daa57da344eee28b7385a6659a1)<br>- openvpnmsica: link C runtime =
statically<br>  (commit 3be4986ea3d6e27acd3e3a317c15dfe07688e135 by<br>   L=
ev Stipakov)<br>- CMake: Support doc builds on Windows machines that do not=
 have .py file association<br>  (commit 22213a8834ba5ba5c9818015730edbf3766=
ad915)<br>- README.cmake.md: Add new documentation for CMake buildsystem<br=
>  (commit 53055fd23efb6209b12d3662427158e25247f1fe)<br>- Check if the -wra=
p argument is actually supported by the platform&#39;s ld<br>  (commit 4ef7=
6f0ee4e122dcd616e1b1e2d652562ab10756 by<br>   Arne Schwabe)<br>- GHA: updat=
e to run-vcpkg@...2735...<br>  (commit 66e33ee81d1d7fa3495ae3aad6e673766e29=
6687)<br>- GHA: refactor mingw UTs and add missing tls_crypt<br>  (commit 2=
6c663f12815f55c483dbe660e28448dc63221d1)<br><br>Change-Id: I6de18261d5dc7f8=
561612184059656c73f33a5f2<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Co-authored-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Co-a=
uthored-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M .github/workflow=
s/build.yaml<br>M .gitignore<br>A CMakeLists.txt<br>A CMakePresets.json<br>=
M Makefile.am<br>M README<br>A README.cmake.md<br>M README.dco.md<br>A conf=
ig.h.cmake.in<br>A contrib/cmake/git-version.py<br>A contrib/cmake/parse-ve=
rsion.m4.py<br>A contrib/vcpkg-manifests/mingw/vcpkg.json<br>A contrib/vcpk=
g-manifests/windows/vcpkg.json<br>M contrib/vcpkg-ports/pkcs11-helper/portf=
ile.cmake<br>A doc/CMakeLists.txt<br>M doc/Makefile.am<br>M src/openvpn/lzo=
.h<br>A src/openvpnmsica/CMakeLists.txt<br>M src/openvpnmsica/Makefile.am<b=
r>A src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/Makefile.am<br>A sr=
c/tapctl/CMakeLists.txt<br>M src/tapctl/Makefile.am<br>23 files changed, 2,=
084 insertions(+), 246 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/15/315/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workf=
lows/build.yaml b/.github/workflows/build.yaml</span><br><span>index 8a80c6=
7..29fe6d7 100644</span><br><span>--- a/.github/workflows/build.yaml</span>=
<br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -39,230 +39=
,64 @@</span><br><span>     strategy:</span><br><span>       fail-fast: fal=
se</span><br><span>       matrix:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        osslver: [1.1.1q, 3.0.5]</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        target: [mingw64, mingw]</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        include:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-          - target: mingw64</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            chost: x86_64-w64-mingw32</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-          - target: ming=
w</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            chost: i=
686-w64-mingw32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    arch: [x86, x64]</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    name: &quot;gcc-mingw - ${{matrix.target}} - OSSL ${{ =
matrix.osslver }}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    name: &quot;gcc-mingw - ${{ matrix.arch }} - OSSL&quot;</span><br><=
span>     runs-on: ubuntu-22.04</span><br><span>     env:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      MAKEFLAGS: -j3</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-      LZO_VERSION: &quot;2.10&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      PKCS11_HELPER_VERSIO=
N: &quot;1.29.0&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
      OPENSSL_VERSION: &quot;${{ matrix.osslver }}&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-      TAP_WINDOWS_VERSION: &quot;9.23.3&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      CMOCKA_VER=
SION: &quot;1.1.5&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      VCPKG_ROOT: ${{ github.workspace }}/vcpkg</span><br><span>     st=
eps:</span><br><span>       - name: Install dependencies</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt update &amp;&amp; =
sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip cmak=
e ninja-build build-essential wget</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        run: sudo apt update &amp;&amp; sudo apt install -y =
mingw-w64 unzip cmake ninja-build build-essential wget python3-docutils man=
2html-base</span><br><span>       - name: Checkout OpenVPN</span><br><span>=
         uses: actions/checkout@...2689...</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+      - name: Restore from cache and install vcpkg</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uses: lukka/run-vcpkg@...2735...=
</span><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          path: openvpn</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          vcpkgGitCommitId: &#39;1ba9a2591f15af5900f2ce2b3e2b=
f31771e3ac48&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: autoconf</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: autoreconf -=
fvi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-di=
rectory: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Cache depend=
encies</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        id: cac=
he</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actio=
ns/cache@...2689...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      - name: Run CMake with vcpkg.json manifest</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...2637...</span=
><br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          path: &#39;~/mingw/&#39;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          key: ${{ matrix.target }}-mingw-${{ matrix.osslv=
er }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_W=
INDOWS_VERSION }}--${{ env.CMOCKA_VERSION }}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+          configurePreset: mingw-${{ matrix.arch }=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          buildPre=
set: mingw-${{ matrix.arch }}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          buildPresetAdditionalArgs: &quot;[&#39;--config Debug&#=
39;]&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      # Repeating  if: steps.cache.outputs.cache-hit !=3D &#39;true&=
#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      # on every =
step for building dependencies is ugly but</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      # I haven&#39;t found a better solution so far.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: Download mingw dependencies</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: steps.cache=
.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        run: |</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          wget -c -P download-cache/ &quot;https://build.openvpn.=
net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-          wget -c -P download=
-cache/ &quot;https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_V=
ERSION}.tar.gz&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
         wget -c -P download-cache/ &quot;https://github.com/OpenSC/pkcs11-=
helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-help=
er-${PKCS11_HELPER_VERSION}.tar.bz2&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          wget -c -P download-cache/ &quot;https://gith=
ub.com/coreboot/cmocka/archive/refs/tags/cmocka-${CMOCKA_VERSION}.tar.gz&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          tar jxf =
&quot;download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-          wget -c -P do=
wnload-cache/ &quot;https://www.openssl.org/source/old/1.1.1/openssl-${OPEN=
SSL_VERSION}.tar.gz&quot; || wget -c -P download-cache/ &quot;https://www.o=
penssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-          tar zxf &quot;download-cache/=
openssl-${OPENSSL_VERSION}.tar.gz&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-          tar zxf &quot;download-cache/lzo-${LZO_VERSION}=
.tar.gz&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
  tar zxf &quot;download-cache/cmocka-${CMOCKA_VERSION}.tar.gz&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-          unzip download-cac=
he/tap-windows-${TAP_WINDOWS_VERSION}.zip</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     - name: create cmocka build directory</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if: steps.cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: m=
kdir cmocka-build</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: configure c=
mocka</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: step=
s.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        working-directory: &quot;./cmocka-build&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: cmake =
-GNinja -DCMAKE_C_COMPILER=3D${{ matrix.chost }}-gcc -DCMAKE_CXX_COMPILER=
=3D${{ matrix.chost }}-g++ -DCMAKE_SYSTEM_NAME=3DWindows -DCMAKE_SHARED_LIN=
KER_FLAGS=3D-static-libgcc -DCMAKE_PREFIX_PATH=3D${HOME}/mingw/opt/lib/pkgc=
onfig/ -DCMAKE_INCLUDE_PATH=3D${HOME}/mingw/opt/lib/include -DCMAKE_LIBRARY=
_PATH=3D${HOME}/mingw/opt/lib -DCMAKE_INSTALL_PREFIX=3D${HOME}/mingw/opt/ .=
./cmocka-cmocka-${{ env.CMOCKA_VERSION }}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     - name: build cmocka</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        working-directory: &quo=
t;./cmocka-build&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        run: ninja</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: install c=
mocka</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: step=
s.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        working-directory: &quot;./cmocka-build&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ninja =
install</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      - name: Configure OpenSSL</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: steps.cache.o=
utputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        run: ./Configure --cross-compile-prefix=3D${{ matrix=
.chost }}- shared ${{ matrix.target }} no-capieng --prefix=3D&quot;${HOME}/=
mingw/opt&quot; --openssldir=3D&quot;${HOME}/mingw/opt&quot; -static-libgcc=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-direc=
tory: &quot;./openssl-${{ env.OPENSSL_VERSION }}&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      - name: Build OpenSSL</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if: steps.cache.outputs.cache-hit !=3D &#39;true&=
#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: make=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-direc=
tory: &quot;./openssl-${{ env.OPENSSL_VERSION }}&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 inst=
ead of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      # mingw/o=
pt/lib, so we include both dirs in the following steps</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      # (pkcs11-helper and OpenVPN) so the=
 libraries will be found</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      - name: Install OpenSSL</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: make instal=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-dire=
ctory: &quot;./openssl-${{ env.OPENSSL_VERSION }}&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      - name: autoreconf pkcs11-helper</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if: steps.cache.outputs.cache-hit !=
=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     run: autoreconf -iv</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        working-directory: &quot;./pkcs11-helper-${{ env.PKCS11_HELPER_V=
ERSION }}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: configure pkc=
s11-helper</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if:=
 steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        run: OPENSSL_LIBS=3D&quot;-L${HOME}/mi=
ngw/opt/lib -L${HOME}/mingw/opt/lib64 -lssl -lcrypto&quot; OPENSSL_CFLAGS=
=3D-I$HOME/mingw/opt/include PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgcon=
fig ./configure --host=3D${{ matrix.chost }} --program-prefix=3D&#39;&#39; =
--libdir=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt --build=3Dx86=
_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss=
 --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        working-directory: &quo=
t;./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION }}&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-      - name: build pkcs11-helper</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if: steps.cache.outputs.cache-hit !=3D &#=
39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
un: make all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        w=
orking-directory: &quot;./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION }}&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      - name: install pkcs11-helper</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: steps.cache.o=
utputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        run: make install</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        working-directory: &quot;./pkcs11-helper-${{ env=
.PKCS11_HELPER_VERSION }}&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - nam=
e: Configure lzo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        run: ./configure --host=3D${{ ma=
trix.chost }} --program-prefix=3D&#39;&#39; --libdir=3D${HOME}/mingw/opt/li=
b --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-linux-gnu</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        working-directory: &quot;./l=
zo-${{ env.LZO_VERSION }}&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - nam=
e: build lzo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        working-directory: &quot;./lzo-${{ =
env.LZO_VERSION }}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        run: make</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: install =
lzo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: steps.=
cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        working-directory: &quot;./lzo-${{ env.LZO_VE=
RSION }}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 run: make install</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: copy tap-w=
indows.h header</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        run: cp ./tap-windows-${TAP_WINDO=
WS_VERSION}/include/tap-windows.h ${HOME}/mingw/opt/include/</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - name: configure OpenVPN</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        run: PKG_CONFIG_PATH=3D${HOME}/mingw/op=
t/lib/pkgconfig LDFLAGS=3D-L$HOME/mingw/opt/lib CFLAGS=3D-I$HOME/mingw/opt/=
include OPENSSL_LIBS=3D&quot;-L${HOME}/opt/lib -L$HOME/mingw/opt/lib64 -lss=
l -lcrypto&quot; OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/=
mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D&quot;-L${HOME}=
/mingw/opt/lib -llzo2&quot; ./configure  --host=3D${{ matrix.chost }} --dis=
able-lz4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        worki=
ng-directory: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: build O=
penVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ma=
ke -j3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working=
-directory: openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    - name: build OpenVPN unittests</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        run: make -j3 check</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        working-directory: openvpn</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      # We use multiple upload-artifact here, so it becomes a f=
lat folder</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      # str=
ucture since we need the dlls on the same level as the binaries</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      - name: Archive cmocka/open=
ssl/lzo dlls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ses: actions/upload-artifact@...2689...</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      - uses: actions/upload-artifact@...2689...</span>=
<br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          retention-days: 1</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.o=
sslver }}-dlls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
   path: &#39;~/mingw/opt/bin/*.dll&#39;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          name: openvpn-mingw-${{ matrix.arch }}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: |</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ${{ github.work=
space }}/out/build/mingw/${{ matrix.arch }}/Debug/*.exe</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/out=
/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            !${{ github.workspace }}/out/build/ming=
w/${{ matrix.arch }}/Debug/test_*.exe</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-      # libtool puts some wrapper binarie=
s in openvpn/tests/unit_tests/openvpn/</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      # and the real binaries in openvpn/tests/unit_tests/=
openvpn/.libs/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      -=
 name: Archive unittest artifacts</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        uses: actions/upload-artifact@...2689...</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - uses: actions/upload-artif=
act@...2689...</span><br><span>         with:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-          retention-days: 1</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-          name: mingw-unittest-${{matrix.ta=
rget}}-ossl${{ matrix.osslver }}-tests</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          path: openvpn/tests/unit_tests/openvpn/.libs/*.e=
xe</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-      # Currently not used by the unit t=
est but might in the future and also</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      # helpful if manually downloading and running openvpn.=
exe from a mingw</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 # build</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name:=
 Archive openvpn binary</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        uses: actions/upload-artifact@...2689...</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        with:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-          retention-days: 1</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-          name: mingw-unittest-${{matrix.target}=
}-ossl${{ matrix.osslver }}-tests</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-          path: openvpn/src/openvpn/.libs/*.exe</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+          name: openvpn-mingw-${{ m=
atrix.arch }}-tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
          path: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/=
test_*.exe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</=
span><br><span> </span><br><span>   mingw-unittest:</span><br><span>     ne=
eds: [ mingw ]</span><br><span>     strategy:</span><br><span>       fail-f=
ast: false</span><br><span>       matrix:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        osslver: [ 1.1.1q, 3.0.5 ]</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        target: [ mingw64, mingw ]</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        arch: [x86, x64]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        test: [argv, a=
uth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, =
tls_crypt]</span><br><span> </span><br><span>     runs-on: windows-latest</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    name: &quot;mingw u=
nittests - ${{matrix.target}} - OSSL ${{ matrix.osslver }}&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    name: &quot;mingw unittest=
 ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</span><br><span>     =
steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: R=
etrieve mingw unittest dlls</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        uses: actions/download-artifact@...2689...</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        with:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-          name: mingw-unittest-${{matrix.target}=
}-ossl${{ matrix.osslver }}-dlls</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-          path: unittests</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span>       - name: Retrieve mingw unittest</spa=
n><br><span>         uses: actions/download-artifact@...2689...</span><br><=
span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
        name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-t=
ests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          name:=
 openvpn-mingw-${{ matrix.arch }}-tests</span><br><span>           path: un=
ittests</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      - name: List unittests direct=
ory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: &quot=
;dir unittests&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Run argv=
unit test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run:=
 ./unittests/argv_testdriver.exe</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - na=
me: Run auth_tokenunit test</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        run: ./unittests/auth_token_testdriver.exe</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-      - name: Run bufferunit test</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        run: ./unittests/buffer_testdriver.exe</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: Run cryptoapi unit test</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ./unittests/cr=
yptoapi_testdriver.exe</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Run cr=
yptounit test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
run: ./unittests/crypto_testdriver.exe</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  - name: Run miscunit test</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        run: ./unittests/misc_testdriver.exe</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-      - name: Run ncpunit test</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        run: ./unittests/ncp_testdriver.exe</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      - name: Run packet idunit test</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        run: ./unittests/packet_id_testdri=
ver.exe</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      - name: Run pktunit test</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ./unittests/p=
kt_testdriver.exe</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Run provide=
runit test</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run=
: ./unittests/provider_testdriver.exe</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      - name: Run ${{ matrix.test }} unit test</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        run: ./unittests/test_=
${{ matrix.test }}.exe</span><br><span> </span><br><span>   ubuntu:</span><=
br><span>     strategy:</span><br><span>@@ -407,60 +241,50 @@</span><br><sp=
an>       strategy:</span><br><span>         fail-fast: false</span><br><sp=
an>         matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
        plat: [ARM64, Win32, x64]</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-          include:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            - plat: ARM64</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-              triplet: arm64</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            - plat: Win32</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-              triplet: x86</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            - plat: x64</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-              triplet: x64</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+          arch: [amd64, x86, arm64]<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  name: &quot;msbuild - ${{matrix.triplet}} - openssl&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      name: &quot;msbuild - ${{ mat=
rix.arch }} - openssl&quot;</span><br><span>       env:</span><br><span>   =
      BUILD_CONFIGURATION: Release</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        VCPKG_OVERLAY_PORTS: ${{ github.workspace }}/contrib/v=
cpkg-ports</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        VCP=
KG_OVERLAY_TRIPLETS: ${{ github.workspace }}/contrib/vcpkg-triplets</span><=
br><span> </span><br><span>       runs-on: windows-latest</span><br><span> =
      steps:</span><br><span>       - uses: actions/checkout@...2689...</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-      - name: Add MSBuild to PATH</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        uses: microsoft/setup-msbu=
ild@...2690...</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Set up Python<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/=
setup-python@...2691...</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
    python-version: &#39;3.x&#39;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      - uses: lukka/get-cmake@...2729...</span><br><span> </s=
pan><br><span>       - name: Install rst2html</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        run: python -m pip install --upgrade pip rs=
t2html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: =
python -m pip install --upgrade pip docutils</span><br><span> </span><br><s=
pan>       - name: Restore artifacts, or setup vcpkg (do not install any pa=
ckage)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: l=
ukka/run-vcpkg@...2637...</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uses: lukka/run-vcpkg@...2735...</span><br><span>         wit=
h:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitC=
ommitId: &#39;d10d511f25620ca0f315cd83dcef6485efc63010&#39;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-          vcpkgJsonGlob: &#39;**/open=
vpn/vcpkg.json&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
        appendedCacheKey: &#39;${{matrix.triplet}}&#39;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: &#39;1ba9a2=
591f15af5900f2ce2b3e2bf31771e3ac48&#39;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    - name: Run MSBuild consuming vcpkg.json</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        working-directory: ${{env.GITHUB_WORKSPACE}}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: |</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            # workaround for=
 GHA runner bug where vcpkg installation is detected at c:\vcpkg</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            # see https://github=
.com/lukka/run-vcpkg/issues/170</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ${{ github.workspace }}/vcpkg/vcpkg.exe integrate ins=
tall</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msbui=
ld /m /p:Configuration=3D${{env.BUILD_CONFIGURATION}} /p:Platform=3D&quot;$=
{{ matrix.plat }}&quot; .</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: Arc=
hive artifacts</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uses: actions/upload-artifact@...2689...</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - name: Run CMake with vcpkg.json manifest (NO =
TESTS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses:=
 lukka/run-cmake@...2637...</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if: ${{ matrix.arch =3D=3D &#39;arm64&#39; }}</span><br><sp=
an>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
      name: artifacts-${{ matrix.plat }}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          configurePreset: win-${{ matrix.arch }}-rele=
ase</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          buildP=
reset: win-${{ matrix.arch }}-release</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     - name: Run CMake with vcpkg.json manifest</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        uses: lukka/run-cmake@...2637...</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if: ${{ matrix.arc=
h !=3D &#39;arm64&#39; }}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
          configurePreset: win-${{ matrix.arch }}-release</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          buildPreset: win-${{ matrix=
.arch }}-release</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       testPreset: win-${{ matrix.arch }}-release</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      - uses: actions/upload-artifact@...2689...</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          name: openvpn-msvc-${{ matrix.a=
rch }}</span><br><span>           path: |</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            ${{ matrix.plat }}-Output/${{env.BUILD_CONF=
IGURATION}}/*.exe</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ${{ matrix.plat =
}}-Output/${{env.BUILD_CONFIGURATION}}/*.pdb</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            doc/openvpn.8.html</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/out/*=
*/*.exe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
${{ github.workspace }}/out/**/*.dll</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            !${{ github.workspace }}/out/**/test_*.exe</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            !${{ github=
.workspace }}/out/**/CMakeFiles/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            !${{ github.workspace }}/out/**/vcpkg_installed/=
**</span><br><span> </span><br><span>   trigger_openvpn_build:</span><br><s=
pan>     runs-on: windows-latest</span><br><span>diff --git a/.gitignore b/=
.gitignore</span><br><span>index 813413f..f44b924 100644</span><br><span>--=
- a/.gitignore</span><br><span>+++ b/.gitignore</span><br><span>@@ -17,6 +1=
7,7 @@</span><br><span> Release</span><br><span> Debug</span><br><span> Win=
32-Output</span><br><span style=3D"color: hsl(120, 100%, 40%);">+out</span>=
<br><span> .vs</span><br><span> .deps</span><br><span> .libs</span><br><spa=
n>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>new file mod=
e 100644</span><br><span>index 0000000..5490582</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -0,0 +1,738 @@</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+cmake_minimum_require=
d(VERSION 3.12)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(=
CMAKE_CONFIGURATION_TYPES &quot;Release;Debug;ASAN&quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+project(openvpn)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# This CMake file implements building OpenVPN with CMAKE</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# Note that this is *NOT* the official w=
ay to build openvpn on anything</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# other than Windows/mingw despite working on other platforms t=
oo. You will need</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
to add -DUNSUPPORTED_BUILDS=3Dtrue to build on non Windows platforms.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# This cmake also makes a few assertions =
like lzo, lz4 being used</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# and OpenSSL having version 1.1.1+ and generally does not offer the s=
ame</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# configurabilit=
y like autoconf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+find_package(PkgConfig =
REQUIRED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include(Ch=
eckSymbolExists)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inc=
lude(CheckIncludeFiles)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+include(CheckCCompilerFlag)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+include(CheckLinkerFlag OPTIONAL)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+include(CheckTypeSize)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+include(CheckStructHasMember)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+include(CTest)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+option(UNSUPPORTED_BUILDS &quot;Allow unsupported builds&quo=
t; OFF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+if (NOT WIN32 AND NOT ${UNSUPPO=
RTED_BUILDS})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    me=
ssage(FATAL_ERROR &quot;Note: on Unix platform the official and supported b=
uild method is using autoconfig. CMake based build should be only used for =
Windows and internal testing/development.&quot;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
 (EXISTS &quot;${CMAKE_CURRENT_SOURCE_DIR}/config.h&quot;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    message(FATAL_ERROR &quot;The to=
p level source directory has a config.h file. Note that you can&#39;t mix i=
n-tree autoconfig builds with out-of-tree cmake builds.&quot;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+option(MBED &quot;BUILD with mbed&quot; OFF)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+option(WOLFSSL &quot;BUILD with wol=
fSSL&quot; OFF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opti=
on(ENABLE_LZ4 &quot;BUILD with lz4&quot; ON)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+option(ENABLE_LZO &quot;BUILD with lzo&quot; ON)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+option(ENABLE_PKCS11 =
&quot;BUILD with pkcs11-helper&quot; ON)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+option(USE_WERROR &quot;Treat compiler warnings as err=
ors (-Werror)&quot; ON)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(PLUGIN_DIR =
/usr/local/lib/openvpn/plugins CACHE FILEPATH &quot;Location of the plugin =
directory&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# AddressSanitize - us=
e CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=3Dasan to build with AS=
AN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(CMAKE_C_FLAGS=
_ASAN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-fsa=
nitize=3Daddress,undefined -fno-sanitize-recover=3Dall -fno-optimize-siblin=
g-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CACHE STRIN=
G &quot;Flags used by the C compiler during AddressSanitizer builds.&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FORCE)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+set(CMAKE_CXX_FLAGS_ASAN</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-fsanitize=3Da=
ddress,undefined -fno-sanitize-recover=3Dall -fno-optimize-sibling-calls -f=
sanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    CACHE STRING &quot;Fl=
ags used by the C++ compiler during AddressSanitizer builds.&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    FORCE)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if (MSVC)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DE=
PRECATE -D_WINSOCK_DEPRECATED_NO_WARNINGS)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (USE_WERROR)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        add_compile_options(/WX)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    add_compile_options(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /MP</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /W2</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /sdl</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /Qspectre</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /guard:cf</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /FC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /ZH:SHA_256</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;$&lt;$&lt;CONFIG:Release&gt;:/GL&gt;&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        &quot;$&lt;$&lt;CONFIG:Release&=
gt;:/Oi&gt;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      &quot;$&lt;$&lt;CONFIG:Release&gt;:/Gy&gt;&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &quot;$&lt;$&lt;CONFIG:Release&g=
t;:/Zi&gt;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_link_=
options(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /Br=
epro</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;$=
&lt;$&lt;CONFIG:Release&gt;:/LTCG:incremental&gt;&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        &quot;$&lt;$&lt;CONFIG:Release&=
gt;:/DEBUG:FULL&gt;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        &quot;$&lt;$&lt;CONFIG:Release&gt;:/OPT:REF&gt;&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;$&lt;$&lt;CON=
FIG:Release&gt;:/OPT:ICF&gt;&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (${CMAKE_GENERATOR_PLATFORM} STREQUAL &quot;x64&quot; OR ${CMAK=
E_GENERATOR_PLATFORM} STREQUAL &quot;x86&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        add_link_options(&quot;$&lt;$&lt;CONFIG=
:Release&gt;:/CETCOMPAT&gt;&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    endif()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+else ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
et(CMAKE_C_FLAGS_RELEASE &quot;-O2&quot;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    set(CMAKE_CXX_FLAGS_RELEASE &quot;-O2&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(CMAKE_C_FLAGS_DE=
BUG &quot;-g -O1&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    set(CMAKE_CXX_FLAGS_DEBUG &quot;-g -O1&quot;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    add_compile_options(-Wall -Wuninitial=
ized)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_c_co=
mpiler_flag(-Wno-stringop-truncation NoStringOpTruncation)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (${NoStringOpTruncation})</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        add_compile_options(-Wno-stringop=
-truncation)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    end=
if()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # We are no=
t ready for this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (USE_WERROR)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_compile_opt=
ions(-Werror)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    en=
dif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+find_program(PYTHON NAMES python3 python)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+execute_process(</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    COMMAND ${PYTHON} =
${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRE=
NT_SOURCE_DIR}/version.m4</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+include(${CMAKE_CURRENT_BINARY_DIR}/version.cmake)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+set(OPENVPN_VERSION_MAJOR ${PRODUCT_VERSI=
ON_MAJOR})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(OPENV=
PN_VERSION_MINOR ${PRODUCT_VERSION_MINOR})</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(OPENVPN_VERSION_=
RESOURCE ${PRODUCT_VERSION_RESOURCE})</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
et(CMAKE_C_STANDARD 99)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Set the vario=
us defines for config.h.cmake.in</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    set(TARGET_LINUX YES)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_ASYNC_PU=
SH YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENAB=
LE_LINUXDCO YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 set(ENABLE_SITNL YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    set(HAVE_DECL_SO_MARK YES)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    set(ENABLE_FEATURE_TUN_PERSIST 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set(HAVE_LINUX_TYPES_H 1)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_DCO YES)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    set(HAVE_CMSGHDR YES)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+elseif (${CMAKE_SYSTE=
M_NAME} STREQUAL &quot;FreeBSD&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    set(TARGET_FREEBSD YES)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    set(ENABLE_DCO YES)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    link_libraries(-lnv)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+elseif (WIN32)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    set(ENABLE_DCO YES)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+elseif (APPLE)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    set(TARGET_DARWIN YES)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    set(HAVE_NET_IF_UTUN_H YES)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+if (UNIX)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    set(PATH_SEPARATOR /)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    set(ENABLE_PORT_SHARE YES)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    set(HAVE_SA_FAMILY_T YES)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+elseif (WIN32)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    set(PATH_SEPARATOR \\\\)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    set(TARGET_WIN32 YES)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+check_symbol_exists(chroot unistd.h HAVE_CHROOT)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(chdir unist=
d.h HAVE_CHDIR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+chec=
k_symbol_exists(dup unistd.h HAVE_DUP)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+check_symbol_exists(dup2 unistd.h HAVE_DUP2)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(fork unistd=
.h HAVE_FORK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_=
symbol_exists(execve unistd.h HAVE_EXECVE)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCAT=
E)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exis=
ts(setgid unistd.h HAVE_SETGID)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check_symbol_exists(setuid unistd.h HAVE_SETUID)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(getpeereid uni=
std.h HAVE_GETPEEREID)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exi=
sts(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+check_symbol_exists(gettimeofday sys/time.h HAVE_GETTIMEOFDAY)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(bas=
ename libgen.h HAVE_BASENAME)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+check_symbol_exists(chsize io.h HAVE_CHSIZE)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(daemon stdlib.h HAVE=
_DAEMON)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbo=
l_exists(dirname libgen.h HAVE_DIRNAME)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+check_symbol_exists(getrlimit sys/resource.h HAVE_GETRL=
IMIT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_e=
xists(mlockall sys/mman.h HAVE_MLOCKALL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+check_symbol_exists(sendmsg sys/socket.h HAVE_SENDMSG)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(recvmsg sys/socket=
.h HAVE_RECVMSG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+che=
ck_symbol_exists(cmsghdr sys/socket.h HAVE_CMSGHDR)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(openlog syslog.h HAVE=
_OPENLOG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symb=
ol_exists(syslog syslog.h HAVE_SYSLOG)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(getpwn=
am pwd.h HAVE_GETPWNAM)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# Some OS (e.g. FreeBSD) need some basic header=
s to allow</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# includi=
ng network headers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
et(NETEXTRA sys/types.h)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+check_include_files(&quot;${NETEXTRA};netinet/in.h&quot; HAVE_NETINET_=
IN_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+if (HAVE_NETINET_IN_H)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    list(APPEND NETEXTRA netin=
et/in.h)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_include_files(&quot;${NETEXTRA};net=
inet/in6.h&quot; HAVE_NETINET_IN_H)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+check_include_files(linux/if_tun.h HAVE_LINUX_IF_TUN_H)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_files(lin=
ux/sockios.h HAVE_LINUX_SOCKIOS_H)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+check_include_files(dlfcn.h HAVE_DLFCN_H)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+check_include_files(fcntl.h HAVE_FCNTL=
_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_fi=
les(dmalloc.h HAVE_DMALLOC_H)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+check_include_files(err.h HAVE_ERR_H)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+check_include_files(sys/epoll.h HAVE_SYS_EPOLL_=
H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_fil=
es(poll.h HAVE_POLL_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+check_include_files(sys/socket.h HAVE_SYS_SOCKET_H)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_include_files(sys/time.h HAVE_SYS_=
TIME_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_includ=
e_files(netdb.h HAVE_NETDB_H)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+check_include_files(unistd.h HAVE_UNISTD_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_include_files(sys/un.h HAVE_SYS_UN_=
H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_fil=
es(libgen.h HAVE_LIBGEN_H)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+check_include_files(net/if.h HAVE_NET_IF_H)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+check_include_files(&quot;${NETEXTRA};netine=
t/ip.h&quot; HAVE_NETINET_IP_H)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check_include_files(arpa/inet.h HAVE_ARPA_INET_H)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+check_include_files(net/if_utun.h=
 HAVE_NET_UTUN_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
eck_include_files(sys/ioctl.h HAVE_SYS_IOCTL_H)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+check_include_files(sys/inotify.h HAVE_SYS_INOT=
IFY_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include=
_files(&quot;${NETEXTRA};sys/uio.h&quot; HAVE_SYS_UIO_H)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+check_include_files(syslog.h HAVE_SYSL=
OG_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_=
files(sys/wait.h HAVE_SYS_WAIT_H)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+check_include_files(grp.h HAVE_GRP_H)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_include_files(pwd.h HAVE_PWD_H)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_include_files(sys=
/mman.h HAVE_SYS_MMAN_H)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+check_include_files(&quot;${NETEX=
TRA};resolv.h&quot; HAVE_RESOLV_H)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+check_include_files(&quot;${NETEXTRA};net/if_tun.h&quot; HAV=
E_NET_IF_TUN_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+set(CMAKE_EXTRA_INCLUDE=
_FILES netinet/ip.h)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+check_type_size(&quot;struct in_pktinfo&quot; IN_PKTINFO)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+check_struct_has_member(&quot;struct=
 in_pktinfo&quot; ipi_spec_dst netinet/ip.h HAVE_IPI_SPEC_DST)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+check_type_size(&quot;struct msg=
hdr&quot; MSGHDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+se=
t(CMAKE_EXTRA_INCLUDE_FILES)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_progr=
am(IFCONFIG_PATH ifconfig)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+find_program(IPROUTE_PATH ip)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+find_program(ROUTE_PATH route)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+if (${ENABLE_LZ4})</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    pkg_search_module(liblz4 liblz4 REQUIRED IMPORTED_TARGET)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+if (${ENABLE_LZO})</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    pkg_search_module(lzo2 lzo2 REQUIRED IMPORTED_TARGET=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+if (${ENABLE_PKCS11})</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    pkg_search_module(pkcs11-helper libpkcs11-=
helper-1 REQUIRED IMPORTED_TARGET)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+function(add_li=
brary_deps target)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (${MBED})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    target_link_libraries(${target} -lmbedtls -lmbedx509 -lmbedcrypto)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    elseif (${WOLFSSL})<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pkg_search_m=
odule(wolfssl wolfssl REQUIRED)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        target_link_libraries(${target} PUBLIC ${wolfssl_LINK_L=
IBRARIES})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
arget_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else ()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        set(ENABLE_X509ALT=
USERNAME YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        find_package(Open=
SSL REQUIRED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (WIN32)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            target_link_l=
ibraries(${target} PUBLIC</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi.lib</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                wininet.=
lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        endif ()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
# optional dependencies</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    target_link_libraries(${target} PUBLIC</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        $&lt;TARGET_NAME_IF_EXISTS:PkgConfig::li=
blz4&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        $&l=
t;TARGET_NAME_IF_EXISTS:PkgConfig::lzo2&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        $&lt;TARGET_NAME_IF_EXISTS:PkgConfig::pkcs1=
1-helper&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (${CMAKE_SYSTEM_NAME} STREQUA=
L &quot;Linux&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        pkg_search_module(libcapng REQUIRED libcap-ng IMPORTED_TARGET)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        pkg_search_modu=
le(libnl REQUIRED libnl-genl-3.0 IMPORTED_TARGET)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        target_link_libraries(${target} PUBLIC PkgConfig::libcap=
ng PkgConfig::libnl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+endfunction()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+if (${MBED})</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    set(ENABLE_CRYPTO_MBEDTLS YES)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+elseif (${WOLFSSL})</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_CRYPTO_OPENSSL YES)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENABLE_CRYPTO_WOLF=
SSL YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(ENA=
BLE_X509ALTUSERNAME YES)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+else ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set=
(ENABLE_CRYPTO_OPENSSL YES)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    set(ENABLE_X509ALTUSERNAME YES)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+includ=
e_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+add_custom_command(</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OUTPUT always_rebuild config-version.h</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    COMMAND ${PYTHON} ${CMAKE=
_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+set(HAVE_CONFIG_VERSION_H YES)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+configure_file(config.h.cmake.in config.h)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+configure_file(include/openvpn-plugin.h.in o=
penvpn-plugin.h)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# T=
ODO remove later when msvc-config.h is removed and we can always include co=
nfig.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_definitio=
ns(-DHAVE_CONFIG_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include_directories=
(${CMAKE_CURRENT_BINARY_DIR})</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_subdi=
rectory(doc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_sub=
directory(src/openvpnmsica)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+add_subdirectory(src/openvpnserv)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+add_subdirectory(src/tapctl)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+set(SOURCE_FILES</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ${CMAKE_CURRENT_BINARY_DIR}/config.h</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ${CMAKE_CURRENT_BINARY_DIR}/config-versio=
n.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ${CMAKE_CURR=
ENT_BINARY_DIR}/openvpn-plugin.h</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/compat/compat-basename.c</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    src/compat/compat-daemon.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    src/compat/compat-dirname.c</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/compat/compat-gettimeofday.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/compat/compat-strsep=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/compat/co=
mpat-versionhelpers.h</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    src/openvpn/argv.c</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    src/openvpn/argv.h</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/base64.c</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/base64.h</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    src/openvpn/basic.h</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    src/openvpn/block_dns.h</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/openvpn/block_dns.c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/buffer.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/buffer.h</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/circ_list.h=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/cli=
nat.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/clinat.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/common.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/comp-lz4.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    src/openvpn/comp-lz4.h</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/comp.c</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/comp.h</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/compstub.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/console.c</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    src/openvpn/console_builtin.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/console.h</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/crypto.c</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/crypt=
o.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/=
crypto_backend.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/crypto_openssl.c</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/crypto_openssl.h</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/crypto_mbedtls.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/crypto_mbedtls.h</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/cryptoapi.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/cr=
yptoapi.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/op=
envpn/dco.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/dco.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/openvpn/dco_win.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    src/openvpn/dco_win.h</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/dco_linux.c</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src/openvpn/dco_linux.h</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    src/openvpn/dco_freebsd.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/dco_freebsd.h</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/dhcp.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/dhcp.h</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/dns.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/dns.h</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/errle=
vel.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/env_set.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/env_set.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn/error.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    src/openvpn/error.h</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/event.c</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/event.h</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src/openvpn/fdmisc.c</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    src/openvpn/fdmisc.h</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/openvpn/forward.c</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/openvpn/forward.h</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/fragment.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/fragment.h</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/gremlin.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/gre=
mlin.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openv=
pn/helper.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/helper.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/httpdigest.c</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/httpdigest.h</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    src/openvpn/init.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    src/openvpn/init.h</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    src/openvpn/integer.h</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/interval.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/interval.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/list.c</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/list.h</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/lladdr.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/lladdr.=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/lz=
o.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/=
lzo.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/manage.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/manage.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/mbuf.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   src/openvpn/mbuf.h</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    src/openvpn/memdbg.h</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    src/openvpn/misc.c</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/misc.h</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/mroute.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    src/openvpn/mroute.h</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/mss.c</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    src/openvpn/mss.h</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/mstats.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mstats.h</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mtcp.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mtcp.h</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mtu.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mtu.h</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mudp.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mudp.h<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/mult=
i.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/=
multi.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/open=
vpn/ntlm.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/ntlm.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/openvpn/occ.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/occ.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn/openvpn.c</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    src/openvpn/openvpn.h</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/openvpn/openvpn_win32_resources.rc</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options.c</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options.h</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/options_util.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/op=
tions_util.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src=
/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/otime.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/ovpn_dco_win.h</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    src/openvpn/packet_id.c</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    src/openvpn/packet_id.h</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    src/openvpn/perf.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/perf.h</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ping.c</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ping.h</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pkcs11.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pkcs11.h</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pkcs11_ba=
ckend.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/open=
vpn/pkcs11_openssl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/pkcs11_mbedtls.c</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src/openvpn/platform.c</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    src/openvpn/platform.h</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    src/openvpn/plugin.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/plugin.h</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pool.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pool.h</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/proto.c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/proto.h</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/proxy.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/pr=
oxy.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvp=
n/ps.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openv=
pn/ps.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/open=
vpn/push.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/push.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/openvpn/pushlist.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/reflect_filter.c</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src/openvpn/reflect_filter.h</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/reliable.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/reliable.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/route.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/route.h</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/run_comman=
d.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/=
run_command.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sr=
c/openvpn/schedule.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/schedule.h</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/session_id.c</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    src/openvpn/session_id.h</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/openvpn/shaper.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/shaper.h</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/sig.c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/sig.h</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/socket.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/socket.h</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/socks.c</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/socks=
.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/s=
sl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/ssl.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openv=
pn/ssl_backend.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/ssl_common.h</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/ssl_openssl.c</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/ssl_openssl.h</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/openvpn/ssl_mbedtls.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ssl_mbedtls.h</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ssl_verify.c<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ssl_=
verify.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/ope=
nvpn/ssl_verify_backend.h</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/ssl_verify_openssl.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/ssl_verify_openssl.h</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ssl_verify_mbedtls.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ss=
l_verify_mbedtls.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   src/openvpn/status.c</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    src/openvpn/status.h</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    src/openvpn/syshead.h</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    src/openvpn/tls_crypt.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/tun.c</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    src/openvpn/tun.h</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    src/openvpn/networking_sitnl.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/networking_freebs=
d.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/=
auth_token.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src=
/openvpn/auth_token.h</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    src/openvpn/ssl_ncp.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/ssl_ncp.h</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src/openvpn/ssl_pkt.c</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    src/openvpn/ssl_pkt.h</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/openvpn/ssl_util.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/ssl_util.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/vlan.c</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/vlan.h</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/win32.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/win32-ut=
il.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/win32.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/ope=
nvpn/win32-util.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn/xkey_helper.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/xkey_provider.c</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_executabl=
e(openvpn ${SOURCE_FILES})</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_library_=
deps(openvpn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if (MINGW)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    target_compile_options(openvpn=
 PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        -DW=
IN32_LEAN_AND_MEAN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       -DNTDDI_VERSION=3DNTDDI_VISTA -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    target_compile_options(openv=
pn PRIVATE -municode -UUNICODE)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    target_link_options(openvpn PRIVATE -municode)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+if (MSVC)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    # we have our own manifest</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    target_link_options(openvpn PRIVATE /MANIFEST:NO)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    target_link_libraries(=
openvpn PUBLIC -ldl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+if (NOT WIN32)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    target_compile_options(openvpn=
 PRIVATE -DPLUGIN_LIBDIR=3D\&quot;${PLUGIN_DIR}\&quot;)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    find_library(resolv resolv)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    # some platform like BSDs already include =
resolver functionality in the libc and not have an extra resolv library</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (${resolv} OR AP=
PLE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_=
link_libraries(openvpn PUBLIC -lresolv)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+if (BUILD_TESTING)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    find_package(cmocka CONFIG)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TARGET cmocka::cm=
ocka)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(CM=
OCKA_LIBRARIES cmocka::cmocka)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else ()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        set(CMOCKA_LIBRARI=
ES PkgConfig::cmocka)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(unit_tests</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;test_auth_t=
oken&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &=
quot;test_buffer&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &quot;test_crypto&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &quot;test_misc&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        &quot;test_ncp&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;test_packet_id&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;test_pkt&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;tes=
t_provider&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (WIN32)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        list(APPEND unit_tests</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;test_cry=
ptoapi&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    # MSVC and Apple&#39;s LLVM ld do n=
ot support --wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  # This test requires cmake &gt;=3D 3.18, so check if check_linker_flag is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # available</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (COMMAND check_l=
inker_flag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
check_linker_flag(C -Wl,--wrap=3Dparse_line LD_SUPPORTS_WRAP)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    endif()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (${LD_SUPPORTS_WRAP})</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        list(APPEND unit_tests</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;test_argv&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;test_tls=
_crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    # These tests work on only on Linux=
 since they depend on special Linux features</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        list(=
APPEND unit_tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;test_networking&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            )</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    foreach (t=
est_name ${unit_tests})</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        # test_networking needs special environment</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (NOT ${test_name} STREQUAL &=
quot;test_networking&quot;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            add_test(${test_name} ${test_name})</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        endif ()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        add_executable(${test_name}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_te=
sts/openvpn/${test_name}.c</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            tests/unit_tests/openvpn/mock_msg.c</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/moc=
k_msg.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
src/openvpn/platform.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            src/openvpn/win32-util.c</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            src/compat/compat-gettimeofday.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            )</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        add_library_deps(${test_name})</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        target_link_libraries(${test=
_name} PUBLIC ${CMOCKA_LIBRARIES})</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    target_include_directories(${test_name} PRIVATE src/openvpn)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (NOT ${test_name} STREQUAL &quot;test_=
buffer&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      target_sources(${test_name} PRIVATE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                src/openvpn/buffer.c</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                )</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        endif ()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    endforeach()</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tar=
get_sources(test_auth_token PRIVATE</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        src/openvpn/base64.c</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/crypto_mbedtls.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_openss=
l.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/open=
vpn/crypto.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        src/openvpn/packet_id.c</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sourc=
es(test_buffer PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        tests/unit_tests/openvpn/mock_get_random.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    target_sources(test_crypto PRIVATE</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        src/openvpn/crypto_mbedtls.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_openssl=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openv=
pn/crypto.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/openvpn/packet_id.c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/mtu.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        src/openvpn/mss.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
arget_sources(test_misc PRIVATE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tests/unit_tests/openvpn/mock_get_random.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/options_util=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openv=
pn/ssl_util.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_ncp PRIVATE=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn=
/crypto_mbedtls.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      src/openvpn/crypto_openssl.c</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        src/openvpn/crypto.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        src/openvpn/otime.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/packet_id.c</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ssl_util.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/compat=
/compat-strsep.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_packet_i=
d PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        te=
sts/unit_tests/openvpn/mock_get_random.c</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        src/openvpn/otime.c</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        src/openvpn/packet_id.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/reliable.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/ses=
sion_id.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_pkt PRIVATE</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_test=
s/openvpn/mock_win32_execve.c</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        src/openvpn/argv.c</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/base64.c</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        src/openvpn/crypto_mbedtls.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/crypto_opens=
sl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/crypto.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/env_set.c</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        src/openvpn/otime.c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/packet_id.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        src/openvpn/reliable.c</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/run_command.c</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/sessio=
n_id.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpn/ssl_pkt.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     src/openvpn/tls_crypt.c</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sources(t=
est_provider PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tests/unit_tests/openvpn/mock_get_random.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/xkey_provider.c</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/xkey_=
helper.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src=
/openvpn/base64.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (TARGET test_argv)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_link_optio=
ns(test_argv PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        target_sources(test_argv PRIVATE</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests=
/openvpn/mock_get_random.c</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            src/openvpn/argv.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            )</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TARGET=
 test_cryptoapi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     target_sources(test_cryptoapi PRIVATE</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/mock_get_random=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests=
/unit_tests/openvpn/cert_data.h</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            src/openvpn/xkey_provider.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/xkey_helper.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn=
/base64.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (TARGET test_networking)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        target_link_options(t=
est_networking PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        target_compile_options(test_networking =
PRIVATE -UNDEBUG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      target_sources(test_networking PRIVATE</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            src/openvpn/networking_sitnl.c</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/cry=
pto_mbedtls.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      src/openvpn/crypto_openssl.c</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            src/openvpn/crypto.c</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            src/openvpn/otime.c</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/packet_id.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            )</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (TARGET test_tls_crypt)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        target_link_options(test_tls_cry=
pt PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        target_link_options(test_tls_crypt PRIVATE</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            -Wl,--wrap=3Dbuf=
fer_read_from_file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           -Wl,--wrap=3Dbuffer_write_file</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            -Wl,--wrap=3Drand_bytes)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        target_sources(test_tls_cryp=
t PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  tests/unit_tests/openvpn/mock_win32_execve.c</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            src/openvpn/argv.c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/base64.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/=
crypto_mbedtls.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         src/openvpn/crypto_openssl.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            src/openvpn/crypto.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/env_set.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/otime.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/op=
envpn/packet_id.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          src/openvpn/run_command.c</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            )</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif (BUILD_TES=
TING)</span><br><span>diff --git a/CMakePresets.json b/CMakePresets.json</s=
pan><br><span>new file mode 100644</span><br><span>index 0000000..135b19d</=
span><br><span>--- /dev/null</span><br><span>+++ b/CMakePresets.json</span>=
<br><span>@@ -0,0 +1,228 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
version&quot;: 3,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;configurePresets&quot;: [</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;name&quot;: &quot;base&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;hidden&quot;: true,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;cache=
Variables&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               &quot;CMAKE_TOOLCHAIN_FILE&quot;: {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    &quot;value&quot;: &quot=
;$env{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;type&quot;:=
 &quot;FILEPATH&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                },</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                &quot;VCPKG_OVERLAY_TRIPLETS&quot;: {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    &quot;value&quot;: &=
quot;${sourceDir}/contrib/vcpkg-triplets&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;type&quot;: &quot;FIL=
EPATH&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       &quot;VCPKG_OVERLAY_PORTS&quot;: {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;value&quot;: &quot;${source=
Dir}/contrib/vcpkg-ports&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &quot;type&quot;: &quot;FILEPATH&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;base-windows&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;hidden&quot;: true,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;binaryDir&quot;: &quot;${sourceDir}/out/build/${preset=
Name}&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;generator&quot;: &quot;Visual Studio 17 2022&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;cacheVariables=
&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      &quot;VCPKG_MANIFEST_DIR&quot;: &quot;${sourceDir}/contrib/vcpkg-mani=
fests/windows&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                &quot;VCPKG_HOST_TRIPLET&quot;: &quot;x64-windows&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;vendor&qu=
ot;: { &quot;microsoft.com/VisualStudioSettings/CMake/1.0&quot;: { &quot;ho=
stOS&quot;: [ &quot;Windows&quot; ] } }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;name&quot;: &quot;base-mingw&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;hidden&quot;: true,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;gene=
rator&quot;: &quot;Ninja Multi-Config&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &quot;cacheVariables&quot;: {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;CMAKE_=
SYSTEM_NAME&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    &quot;value&quot;: &quot;Windows&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    &quot;type&quo=
t;: &quot;STRING&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                &quot;VCPKG_MANIFEST_DIR&quot;: &quot;${sourceDir}/contri=
b/vcpkg-manifests/mingw&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;name&quot;: &quot;x64&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;hidden&quot;: true,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;architecture&quot;: {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;val=
ue&quot;: &quot;x64&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                &quot;strategy&quot;: &quot;set&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            },</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;cacheVariables&quot;:=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &=
quot;VCPKG_TARGET_TRIPLET&quot;: &quot;x64-windows-ovpn&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;name&quot;: &quot;x64-mingw&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;hidden&=
quot;: true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;binaryDir&quot;: &quot;out/build/mingw/x64&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;cacheVariables&q=
uot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    &quot;CMAKE_C_COMPILER&quot;: {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    &quot;value&quot;: &quot;x86_64-w64-min=
gw32-gcc&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                &quot;type&quot;: &quot;STRING&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;CMAKE_CXX_COMPILER&=
quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         &quot;value&quot;: &quot;x86_64-w64-mingw32-g++&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;type&=
quot;: &quot;STRING&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;VCPKG_TARGET_TRIPLET&quot;: &quot;x64-mingw-ovpn=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;ar=
m64&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;hidden&quot;: true,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;architecture&quot;: {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                &quot;value&quot;: &quot;arm64=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    &quot;strategy&quot;: &quot;set&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            },</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;cacheVariables&quot;: {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot;VCPKG_TARGET_T=
RIPLET&quot;: &quot;arm64-windows-ovpn&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;name&quot;: &quot;x86&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;hidden&quot;: true,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;architecture=
&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      &quot;value&quot;: &quot;Win32&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                &quot;strategy&quot;: &quot;set&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;cach=
eVariables&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;VCPKG_TARGET_TRIPLET&quot;: &quot;x86-windows-ovpn&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;i686-=
mingw&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;hidden&quot;: true,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;binaryDir&quot;: &quot;out/build/mingw/x86&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;cacheVariables&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                &quot;CMAKE_C_COMPILER&quot;: {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;value&quot;: &q=
uot;i686-w64-mingw32-gcc&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &quot;type&quot;: &quot;STRING&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;CMAKE=
_CXX_COMPILER&quot;: {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    &quot;value&quot;: &quot;i686-w64-mingw32-g++&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &quot;type&quot;: &quot;STRING&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                },</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                &quot;VCPKG_TARGET_TRIPLET&quot;: &quot;x8=
6-mingw-ovpn&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quo=
t;: &quot;debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;hidden&quot;: true,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;cacheVariables&quot;: {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                &quot;CMAKE_BUIL=
D_TYPE&quot;: &quot;Debug&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
quot;name&quot;: &quot;release&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;hidden&quot;: true,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;cacheVariables&quot;:=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &=
quot;CMAKE_BUILD_TYPE&quot;: &quot;Release&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;name&quot;: &quot;mingw-x64&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [ &q=
uot;base&quot;, &quot;base-mingw&quot;, &quot;x64-mingw&quot; ]</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;mingw-x86&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;inherits&quot;: [ &quot;base&quot;, &quot;base-mingw&quot;, &quot;i686-min=
gw&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;=
: &quot;win-amd64-release&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &quot;inherits&quot;: [ &quot;base&quot;, &quot;ba=
se-windows&quot;, &quot;x64&quot;, &quot;release&quot; ]</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;name&quot;: &quot;win-arm64-release&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;arm64=
&quot;, &quot;release&quot; ]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;name&quot;: &quot;win-x86-release&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [ &quot;bas=
e&quot;, &quot;base-windows&quot;, &quot;x86&quot;, &quot;release&quot; ]</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-=
amd64-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quo=
t;, &quot;x64&quot;, &quot;debug&quot; ]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;name&quot;: &quot;win-arm64-debug&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: =
[ &quot;base&quot;, &quot;base-windows&quot;, &quot;arm64&quot;, &quot;debu=
g&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;:=
 &quot;win-x86-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-wi=
ndows&quot;, &quot;x86&quot;, &quot;debug&quot; ]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;name&quot;: &quot;unix-native&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;generator&q=
uot;: &quot;Ninja Multi-Config&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;binaryDir&quot;: &quot;out/build/unix&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ],</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;buildPresets&quot;: [</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;=
mingw-x64&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;configurePreset&quot;: &quot;mingw-x64&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;name&quot;: &quot;mingw-x86&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;con=
figurePreset&quot;: &quot;mingw-x86&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;name&quot;: &quot;win-amd64-release&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePres=
et&quot;: &quot;win-amd64-release&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;configuration&quot;: &quot;Release&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quo=
t;win-arm64-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;configurePreset&quot;: &quot;win-arm64-release&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;configuration&quot;: &quot;Release&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;name&quot;: &quot;win-x86-release&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePrese=
t&quot;: &quot;win-x86-release&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;configuration&quot;: &quot;Release&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;w=
in-amd64-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;configurePreset&quot;: &quot;win-amd64-debug&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;confi=
guration&quot;: &quot;Debug&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &quot;name&quot;: &quot;win-arm64-debug&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePreset&quot;: =
&quot;win-arm64-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;configuration&quot;: &quot;Debug&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-debu=
g&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;configurePreset&quot;: &quot;win-x86-debug&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;configuration&quot;:=
 &quot;Debug&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;na=
me&quot;: &quot;unix-native&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;configurePreset&quot;: &quot;unix-native&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ],</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;testPresets&quot;: [</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;w=
in-amd64-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;configurePreset&quot;: &quot;win-amd64-release&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win=
-x86-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;configurePreset&quot;: &quot;win-x86-release&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64=
-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;configurePreset&quot;: &quot;win-amd64-debug&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-debug&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;configurePreset&quot;: &quot;win-x86-debug&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;name&quot;: &quot;unix-native&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configu=
rePreset&quot;: &quot;unix-native&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span>diff --git a/Makefile.am b/Makefile.am</span><br><span>index=
 2ddf6f7..f4ac7be 100644</span><br><span>--- a/Makefile.am</span><br><span>=
+++ b/Makefile.am</span><br><span>@@ -41,7 +41,10 @@</span><br><span> </spa=
n><br><span> EXTRA_DIST =3D \</span><br><span> 	contrib \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	debug</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	debug \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	CMakeLists.txt \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	CMakePresets.json \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	config.h.cmake.in</span><br><span> </span><br><span> .PHONY: co=
nfig-version.h doxygen</span><br><span> </span><br><span>@@ -64,6 +67,7 @@<=
/span><br><span> 	.gitattributes \</span><br><span> 	CONTRIBUTING.rst \</sp=
an><br><span> 	PORTS \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	README.cmake.md \</span><br><span> 	README.dco.md \</span><br><span> 	R=
EADME.ec \</span><br><span> 	README.wolfssl \</span><br><span>diff --git a/=
README b/README</span><br><span>index 04eb16f..8576dba 100644</span><br><sp=
an>--- a/README</span><br><span>+++ b/README</span><br><span>@@ -21,6 +21,9=
 @@</span><br><span> </span><br><span> or see the file INSTALL for more inf=
o.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+For information on how to build OpenVPN on/for Windows with MinGW</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+or MSVC see README.cmake.md.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> *=
************************************************************************</s=
pan><br><span> </span><br><span> For detailed information on OpenVPN, inclu=
ding examples, see the man page</span><br><span>@@ -69,8 +72,7 @@</span><br=
><span>   https://github.com/OpenVPN/easy-rsa</span><br><span>   https://gi=
thub.com/OpenVPN/tap-windows6</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-The old cross-compilation environment (domake-win=
) and the Python-based</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-buildsystem have been replaced with openvpn-build:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Community-provided Windows installers (MS=
I) and Debian packages are built from</span><br><span> </span><br><span>   =
https://github.com/OpenVPN/openvpn-build</span><br><span> </span><br><span>=
diff --git a/README.cmake.md b/README.cmake.md</span><br><span>new file mod=
e 100644</span><br><span>index 0000000..599d8dc</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/README.cmake.md</span><br><span>@@ -0,0 +1,137 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN Builds with =
CMake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+For Windows builds we do not use the autotools-bas=
ed buildsystem that we use</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+for our Unix-like (Linux, BSDs, macOS, etc.) builds. Instead we adde=
d a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+separate (CMake)=
[https://cmake.org/]-based buildsystem.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+This buildsystem supports building for Windows both with MSVC (i.e. Visual=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Studio) and MinGW. =
MinGW builds are also supported as cross-compile</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+from Linux.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+The official builds, which are also available as CMake presets (see</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+`cmake --list-presets` an=
d `CMakePresets.json`) all use</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+(VCPKG)[https://github.com/microsoft/vcpkg/#vcpkg-overview] for =
dependency</span><br><span style=3D"color: hsl(120, 100%, 40%);">+managemen=
t. This allows us to do proper supply-chain management and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+also makes cross-building with MinGW=
 on Linux much simpler. However,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+builds are also possible by providing the build dependencies m=
anually,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+but that mi=
ght require specifying more information to CMake.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+If you&#39;re looking to build the full Windows installer MSI, t=
ake a look</span><br><span style=3D"color: hsl(120, 100%, 40%);">+at https:=
//github.com/OpenVPN/openvpn-build.git .</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+MSVC builds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+------=
-----</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+The following tools are expected =
to be present on the system, you</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+can them install with a package manager of your choice (e.g.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+chocolatey, winget) o=
r manually:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+* CMake</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+* Git</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+* Python (3.x), plus the Python module `docutils`</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+* Visual Studion 17 (20=
22), C/C++ Enviroment</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+For example, to p=
repare the required tools with chocolatey, you</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+can use the following commands (Powershell):</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # Installing Chocolatey</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    Set-ExecutionPolicy Bypass -S=
cope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol =3D=
 [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Ob=
ject System.Net.WebClient).DownloadString(&#39;https://chocolatey.org/insta=
ll.ps1&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &a=
mp; choco.exe install -y git --params &quot;/GitAndUnixToolsOnPath&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp; choco.exe in=
stall -y python</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&amp; python.exe -m ensurepip</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &amp; python.exe -m pip install --upgrade pip</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &amp; python.exe -m pip install=
 docutils</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp; =
choco.exe install -y cmake --installargs &#39;ADD_CMAKE_TO_PATH=3DSystem&#3=
9;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp; choco.e=
xe install -y &quot;visualstudio2022buildtools&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &amp; choco.exe install -y &quot;visu=
alstudio2022-workload-vctools&quot; --params &quot;--add Microsoft.VisualSt=
udio.Component.UWP.VC.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools=
.ARM64 --add Microsoft.VisualStudio.Component.VC.ATL.Spectre --add Microsof=
t.VisualStudio.Component.VC.ATLMFC.Spectre --add Microsoft.VisualStudio.Com=
ponent.VC.ATL.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.MFC.A=
RM64.Spectre --add Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spect=
re --add Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre --qui=
et&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp; c=
hoco.exe install -y windows-sdk-10-version-2004-windbg</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+One or more restarts of Powershell might be required to pic=
k up new additions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
o `PATH` between steps. A Windows restart is probably required after</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+installing Visual Studio b=
efore being able to use it.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+You can find the exact commands we use to set up the community buil=
d machines</span><br><span style=3D"color: hsl(120, 100%, 40%);">+at https:=
//github.com/OpenVPN/openvpn-buildbot/blob/master/jenkins/windows-server/ms=
ibuild.pkr.hcl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+To do a default build, a=
ssuming you are in a MSVC 17 2022 environment:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    mkdir C:\OpenVPN</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    cd C:\OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    git clone https://github.com/microsoft/vcpkg.git</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    git clone https://github.com/Op=
enVPN/openvpn.git</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  set VCPKG_ROOT=3DC:\OpenVPN\vcpkg</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    cd openvpn</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    cmake --preset win-amd64-release</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    cmake --build --preset win-amd64-release</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctest --preset win=
-amd64-release</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+When using the presets, =
the build directory is</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+`out/build/&lt;preset-name&gt;/`, you can find the output files there.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+No install support is=
 provided directly in OpenVPN build, take a look</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+at https://github.com/OpenVPN/openvpn-build.gi=
t instead.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+MinGW builds (cross-compile =
on Linux)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+----------=
---------------------------</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+To build th=
e Windows executables on a Linux system:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    # install mingw with the package manager of your choice, e.g.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sudo apt-get install -y=
 mingw-w64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # in =
addition to mingw we also need a toolchain for host builds, e.g.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    sudo apt-get install -y bu=
ild-essential</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # =
minimum required tools for vcpkg bootstrap: curl, zip, unzip, tar, e.g.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    sudo apt-get instal=
l -y curl zip unzip tar</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    # additionally vcpkg requires powershell when building Windows bina=
ries.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # See http=
s://learn.microsoft.com/en-us/powershell/scripting/install/installing-power=
shell-on-linux</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #=
 e.g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sudo apt-g=
et install -y wget apt-transport-https software-properties-common</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    wget -q &quot;https://pac=
kages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-pro=
d.deb&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sudo=
 dpkg -i packages-microsoft-prod.deb</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    sudo apt-get update</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    sudo apt-get install -y powershell</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    # minimum required tools for bu=
ild: cmake, docutils, git, ninja,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    # pkg-config, python e.g.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    sudo apt-get install -y cmake git ninja-build p=
kg-config python3 python3-docutils</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    # additionally required to build pkcs11-helper: automake=
, autoconf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # ma=
n2html, e.g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sud=
o apt-get install -y automake autoconf man2html-base</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mkdir mingw</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    cd mingw</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    git clone https://github.com/microsoft/vcpkg.git=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    git clone https=
://github.com/OpenVPN/openvpn.git</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    export VCPKG_ROOT=3D$PWD/vcpkg</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    cd openvpn</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    cmake --preset mingw-x64</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmake --build --preset mingw-x64</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    # unit tests are bui=
lt, but no testPreset is provided. You need to copy</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # them to a Windows system manually</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+The instructions have been verified on a=
 Ubuntu 22.04 LTS system in a</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bash shell, and might need adaptions to other Linux distributions=
/versions.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+Note that the MinGW preset b=
uilds use the `Ninja multi-config` generator, so</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if you want to build the Debug binaries, use</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    cmake --build --preset mingw-x64 --c=
onfig Debug</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+The default build is equiva=
lent to specifying `--config Release`.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
When using the presets, the build directory is</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+`out/build/mingw/&lt;arch&gt;`, you can find the=
 actual output files in</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+sub-directories called `&lt;buildtype&gt;`.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+No install support is provided directly in Open=
VPN build, take a look</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+at https://github.com/OpenVPN/openvpn-build.git instead.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+Unsupported builds</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+------------------</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
The CMake buildsystem also supports builds on Unix-like platforms. These bu=
ilds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+are sometimes u=
seful for OpenVPN developers (e.g. when they use IDEs with</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+integrated CMake support). However, =
they are not officially supported, do not</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+include any install support and should not be used to=
 distribute/package</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
OpenVPN. To emphasize this fact, you need to specify `-DUNSUPPORTED_BUILDS=
=3DON`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+to cmake to b=
e able to use these builds.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The `unix-n=
ative` CMake preset is available for these builds. This preset does</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+not require VCPKG and inste=
ad assumes all build-dependencies are provided by</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+the system natively.</span><br><span>diff --g=
it a/README.dco.md b/README.dco.md</span><br><span>index aa93d66..3f7e00c 1=
00644</span><br><span>--- a/README.dco.md</span><br><span>+++ b/README.dco.=
md</span><br><span>@@ -59,8 +59,11 @@</span><br><span> </span><br><span> Ge=
tting started (Windows)</span><br><span> -------------------------</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-The simplest way to test DCO u=
nder Windows is to download the latest installer</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-from https://build.openvpn.net/downloads/snapsho=
ts/github-actions/openvpn2/ .</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+Official releases published at https://openvpn.net/community-down=
loads/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include ovpn-=
dco-win driver since 2.6.0.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+There are a=
lso snapshot releases available at</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+https://build.openvpn.net/downloads/snapshots/github-actions=
/openvpn2/ .</span><br><span> This installer contains the latest OpenVPN co=
de and the ovpn-dco-win driver.</span><br><span> </span><br><span> </span><=
br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span=
>new file mode 100644</span><br><span>index 0000000..7ef7175</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ =
-0,0 +1,479 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Configuration setting=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CONFIGU=
RE_DEFINES &quot;N/A&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable as=
ync push */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakede=
fine ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Use mbed TLS =
library */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedef=
ine ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Use Openss=
l */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine EN=
ABLE_CRYPTO_OPENSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Use wolfSSL cryp=
to library */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmake=
define ENABLE_CRYPTO_WOLFSSL</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable =
shared data channel offload */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#cmakedefine ENABLE_DCO</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* E=
nable debugging support (needed for verb&gt;=3D4) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define ENABLE_DEBUG 1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* We have persist tun capability */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_FEATURE_TUN_PERSIST<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Enable internal fragmentation suppor=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ENABLE_=
FRAGMENT 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable linux data channel=
 offload */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakede=
fine ENABLE_LINUXDCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable LZ4 comp=
ression library */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
cmakedefine ENABLE_LZ4</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable LZO co=
mpression library */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#cmakedefine ENABLE_LZO</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable mana=
gement server capability */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define ENABLE_MANAGEMENT 1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Enable OFB and CFB cipher modes */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define ENABLE_OFB_CFB_MODE</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Enable PKCS11 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#cmakedefine ENABLE_PKCS11</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enabl=
e plug-in support */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define ENABLE_PLUGIN 1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable TCP =
Server port sharing */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#cmakedefine ENABLE_PORT_SHARE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* SE=
Linux support */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cm=
akedefine ENABLE_SELINUX</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* enable sitn=
l support */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmaked=
efine ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable systemd in=
tegration */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* #und=
ef ENABLE_SYSTEMD */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable --x509-u=
sername-field feature */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#cmakedefine ENABLE_X509ALTUSERNAME</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Compiler supports anonymous unions */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define HAVE_ANONYMOUS_UNION_SUPPORT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Define to 1 if you have the &lt;arpa/inet.h&gt; hea=
der file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmaked=
efine HAVE_ARPA_INET_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1=
 if you have the `basename&#39; function. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#cmakedefine HAVE_BASENAME</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `chdir&#39; function. */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CHDIR<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `chroot&=
#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#c=
makedefine HAVE_CHROOT</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 i=
f you have the `chsize&#39; function. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#cmakedefine HAVE_CHSIZE</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* struct cmsghdr needed for extended socket error support */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CMSGHDR<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* git version information in config-ve=
rsion.h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedef=
ine HAVE_CONFIG_VERSION_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to =
1 if you have the `daemon&#39; function. */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#cmakedefine HAVE_DAEMON</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Define to 1 if you have the declaration of `SO_MARK&#39;, and =
to 0 if you</span><br><span style=3D"color: hsl(120, 100%, 40%);">+don&#39;=
t. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine01=
 HAVE_DECL_SO_MARK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if yo=
u have the &lt;direct.h&gt; header file. */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#cmakedefine HAVE_DIRECT_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Define to 1 if you have the `dirname&#39; function. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DIRNAME=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;dlf=
cn.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#cmakedefine HAVE_DLFCN_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defin=
e to 1 if you have the &lt;dmalloc.h&gt; header file. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_DMALLOC_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `dup&#39; function=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HA=
VE_DUP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `=
dup2&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#cmakedefine HAVE_DUP2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to =
1 if you have the `epoll_create&#39; function. */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_EPOLL_CREATE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;err.h&gt; header f=
ile. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine=
 HAVE_ERR_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Crypto library supports =
keying material exporter */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define HAVE_EXPORT_KEYING_MATERIAL 1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Define to 1 if you have the &lt;fcntl.h&gt; header file. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_FCNTL_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `fork&#=
39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cm=
akedefine HAVE_FORK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#cmakedefine HAVE_EXECVE</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1=
 if you have the `ftruncate&#39; function. */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#cmakedefine HAVE_FTRUNCATE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `getgrnam&#39; function. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_GET=
GRNAM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `g=
etpeereid&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#cmakedefine HAVE_GETPEEREID</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Define to 1 if you have the `getpwnam&#39; function. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_GETPWNAM</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `getrlimit&#39; fun=
ction. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAV=
E_GETRLIMIT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have =
the `getsockname&#39; function. */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#cmakedefine HAVE_GETSOCKNAME</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Define to 1 if you have the `gettimeofday&#39; function. */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_GETTIMEO=
FDAY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt=
;grp.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#cmakedefine HAVE_GRP_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* struc=
t in_pktinfo needed for IP_PKTINFO support */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#cmakedefine HAVE_IN_PKTINFO</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Define to 1 if you have the &lt;io.h&gt; header file. */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_I=
O_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* struct in_pktinfo.ipi_spec_dst n=
eeded for IP_PKTINFO support */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#cmakedefine HAVE_IPI_SPEC_DST</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Define to 1 if you have the &lt;libgen.h&gt; header file. */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_LIBGEN_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;limi=
ts.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define HAVE_LIMITS_H 1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define =
to 1 if you have the &lt;linux/if_tun.h&gt; header file. */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_LINUX_IF_TUN_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;linux/=
sockios.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#cmakedefine HAVE_LINUX_SOCKIOS_H</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Define to 1 if you have the &lt;linux/types.h&gt; header file. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_LIN=
UX_TYPES_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have t=
he &lt;lzoconf.h&gt; header file. */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define HAVE_LZO_CONF_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Define to 1 if you have the &lt;lzo1x.h&gt; header file. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_LZO1X_H 1</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;lzoutil.h&g=
t; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define HAVE_LZOUTIL_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 =
if you have the `mlockall&#39; function. */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#cmakedefine HAVE_MLOCKALL</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* struct msghdr needed for extended socket error support */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_MSGH=
DR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;n=
etdb.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#cmakedefine HAVE_NETDB_H</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Def=
ine to 1 if you have the &lt;netinet/in.h&gt; header file. */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_NETINET_IN_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;netine=
t/ip.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#cmakedefine HAVE_NETINET_IP_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Define to 1 if you have the &lt;netinet/tcp.h&gt; header file. */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_NETINET_TCP_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;net/i=
f.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#cmakedefine HAVE_NET_IF_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defin=
e to 1 if you have the &lt;net/if_tun.h&gt; header file. */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_NET_IF_TUN_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;net/if=
_utun.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#cmakedefine01 HAVE_NET_IF_UTUN_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Define to 1 if you have the &lt;net/tun/if_tun.h&gt; header file. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_NE=
T_TUN_IF_TUN_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you ha=
ve the `nice&#39; function. */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#undef HAVE_NICE</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define t=
o 1 if you have the `openlog&#39; function. */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#undef HAVE_OPENLOG</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* OpenSSL engine support available */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#undef HAVE_OPENSSL_ENGINE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `poll&#39; function. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_POLL</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;poll.h&gt; h=
eader file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmak=
edefine HAVE_POLL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if y=
ou have the `putenv&#39; function. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#undef HAVE_PUTENV</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Define to 1 if you have the &lt;pwd.h&gt; header file. */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_PWD_H</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Define to 1 if you have the `readv&#39; function=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_REA=
DV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `recv=
msg&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#cmakedefine HAVE_RECVMSG</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#cmakedefine HAVE_SENDMSG</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* De=
fine to 1 if you have the &lt;resolv.h&gt; header file. */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_RESOLV_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* sa_family_t, needed to hold AF_* info */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SA_FAM=
ILY_T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `s=
d_booted&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#undef HAVE_SD_BOOTED</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define =
to 1 if you have the `setgid&#39; function. */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SETGID</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `setgroups&#39; function. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SETGROUP=
S</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `setsi=
d&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#undef HAVE_SETSID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if yo=
u have the `setsockopt&#39; function. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define HAVE_SETSOCKOPT 1</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Define to 1 if you have the `setuid&#39; function. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SETUID</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;signal.h&=
gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#undef HAVE_SIGNAL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if =
you have the `socket&#39; function. */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#undef HAVE_SOCKET</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* struct sock_extended_err needed for extended socket error support */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SOCK_EXTENDE=
D_ERR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `s=
tat&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define HAVE_STAT 1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if=
 you have the &lt;stdarg.h&gt; header file. */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define HAVE_STDARG_H 1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Define to 1 if you have the &lt;stdint.h&gt; header file. */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_STDINT=
_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt=
;stdio.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define HAVE_STDIO_H 1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Defi=
ne to 1 if you have the &lt;stdlib.h&gt; header file. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define HAVE_STDLIB_H 1</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Define to 1 if you have the `strdup&#39; function.=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_STRD=
UP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;s=
trings.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define HAVE_STRINGS_H 1</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* De=
fine to 1 if you have the &lt;string.h&gt; header file. */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_STRING_H 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Define to 1 if you have the `strsep&#39; functio=
n. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_ST=
RSEP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `sy=
slog&#39; function. */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#undef HAVE_SYSLOG</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if=
 you have the &lt;syslog.h&gt; header file. */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYSLOG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `system&#39; function. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SYSTEM</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;system=
d/sd-daemon.h&gt; header file. */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#undef HAVE_SYSTEMD_SD_DAEMON_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Define to 1 if you have the &lt;sys/epoll.h&gt; header file. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS=
_EPOLL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the=
 &lt;sys/file.h&gt; header file. */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#undef HAVE_SYS_FILE_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Define to 1 if you have the &lt;sys/inotify.h&gt; header file. */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_INOT=
IFY_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &l=
t;sys/ioctl.h&gt; header file. */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#cmakedefine HAVE_SYS_IOCTL_H</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Define to 1 if you have the &lt;sys/kern_control.h&gt; header file.=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SYS_=
KERN_CONTROL_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you ha=
ve the &lt;sys/mman.h&gt; header file. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_MMAN_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Define to 1 if you have the &lt;sys/socket.h&gt; header file=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HA=
VE_SYS_SOCKET_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you h=
ave the &lt;sys/sockio.h&gt; header file. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#undef HAVE_SYS_SOCKIO_H</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Define to 1 if you have the &lt;sys/stat.h&gt; header file. *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_SYS_S=
TAT_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the =
&lt;sys/time.h&gt; header file. */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#cmakedefine HAVE_SYS_TIME_H</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Define to 1 if you have the &lt;sys/types.h&gt; header file. */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_SYS_TYPES_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;sys=
/uio.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#cmakedefine HAVE_SYS_UIO_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* D=
efine to 1 if you have the &lt;sys/un.h&gt; header file. */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYS_UN_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;sys/wait.h&g=
t; header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
cmakedefine HAVE_SYS_WAIT_H</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define t=
o 1 if you have the &lt;tap-windows.h&gt; header file. */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_TAP_WINDOWS_H</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `time&#39; function=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_TI=
ME 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt=
;time.h&gt; header file. */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define HAVE_TIME_H 1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define=
 to 1 if you have the &lt;uapi.h&gt; header file. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_UAPI_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the &lt;unistd.h&gt; header file.=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAV=
E_UNISTD_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have t=
he &lt;valgrind/memcheck.h&gt; header file. */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#undef HAVE_VALGRIND_MEMCHECK_H</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Define to 1 if you have the &lt;versionhelpers.h&gt;=
 header file. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#un=
def HAVE_VERSIONHELPERS_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to =
1 if you have the `vfork&#39; function. */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#undef HAVE_VFORK</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Define to 1 if you have the &lt;vfork.h&gt; header file. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#undef HAVE_VFORK_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `vsnprintf&#39; fu=
nction. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#undef HA=
VE_VSNPRINTF</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* we always assume a rece=
nt mbed TLS version */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define HAVE_CTR_DRBG_UPDATE_RET 1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Path to ifconfig tool */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define IFCONFIG_PATH &quot;@IFCONFIG_PATH@&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Path to iproute tool */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define IPROUTE_PATH &quot;@IPROUTE_PATH@&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Path to route tool */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define ROUTE_PATH &quot;@ROUTE_PATH=
@&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* OpenVPN version in Windows r=
esource format - string */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define OPENVPN_VERSION_RESOURCE @OPENVPN_VERSION_RESOURCE@</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Name of package */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define PACKAGE &quot;openvpn&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Define to the address where bug reports for t=
his package should be sent. */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#undef PACKAGE_BUGREPORT</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Define to the full name of this package. */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define PACKAGE_NAME &quot;OpenVPN&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Define to the full name and version of this pa=
ckage. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PA=
CKAGE_STRING &quot;OpenVPN @OPENVPN_VERSION_MAJOR@...220...@OPENVPN_VERSION=
_MINOR@@OPENVPN_VERSION_PATCH@&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Define to the version of this package. */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define PACKAGE_VERSION &quot;@OPENVPN_VERSION_MAJOR=
@...220...@...2740...@@OPENVPN_VERSION_PATCH@&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Path to systemd-ask-password tool */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#undef SYSTEMD_ASK_PASSWORD_PAT=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* systemd is newer than v216 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SYSTEMD_NEWER_TH=
AN_216</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* The tap-windows id */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define TAP_WIN_COMPONENT_I=
D &quot;tap0901&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The tap-window=
s version number is required for OpenVPN */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define TAP_WIN_MIN_MAJOR 9</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* The tap-windows version number is required for OpenVPN */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TAP_WIN_MIN=
_MINOR 9</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Are we running on Mac OS X?=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TAR=
GET_DARWIN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Are we running on FreeBSD=
? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TA=
RGET_FREEBSD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Are we running on Linux=
? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TA=
RGET_LINUX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Are we running WIN32? */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TARGET_=
WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define TARGET_ALIAS &quot;@CMAKE=
_SYSTEM_NAME@&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable GNU exten=
sions on systems that have them.  */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef _GNU_SOURCE</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# define _GNU_SOURCE 1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint32_t in_add=
r_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint16_=
t in_port_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIGHUP    1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIGINT    2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIGUSR1   10</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIGUSR2   12</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SIGTERM   15</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(_MSC_VER)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;BaseTsd.h&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+typedef SSIZE_T ssize_t;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define strncasecmp strnicmp</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define strcasecmp _stricmp</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define S_IRUSR 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define S_IWUSR 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define R_OK 4</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define W_OK 2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define X_OK 1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define F_OK 0</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>diff --git a/contrib/cmake/git-version.py b/contrib/cmake=
/git-version.py</span><br><span>new file mode 100644</span><br><span>index =
0000000..c2b4452</span><br><span>--- /dev/null</span><br><span>+++ b/contri=
b/cmake/git-version.py</span><br><span>@@ -0,0 +1,75 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#             ove=
r a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#             session authentication and =
key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     =
        packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#             packet compression.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#  Copyright (C) 2022-2023 OpenVPN Inc &lt;sa=
les@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
 Copyright (C) 2022-2022 Lev Stipakov &lt;lev@...2698...&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#  This program is free software; you can redistribu=
te it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#  it under the terms of the GNU General Public License version 2</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#  as published by the Free S=
oftware Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  This program is=
 distributed in the hope that it will be useful,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#  but WITHOUT ANY WARRANTY; without even the =
implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#  GNU General Public License =
for more details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  You should have r=
eceived a copy of the GNU General Public License along</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 US=
A.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+import os</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+import sys</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+import subprocess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def run_command(arg=
s):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp =3D subpr=
ocess.Popen(args, stdout=3Dsubprocess.PIPE, stderr=3Dsubprocess.DEVNULL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    o, _ =3D sp.commun=
icate()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return o=
.decode(&quot;utf-8&quot;)[:-1]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def get=
_branch_commit_id():</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    commit_id =3D run_command([&quot;git&quot;, &quot;rev-parse&quot;, &qu=
ot;--short=3D16&quot;, &quot;HEAD&quot;])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if not commit_id:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        raise</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    branch =3D run_command([&quot;git&quot;, &quot;descri=
be&quot;, &quot;--exact-match&quot;])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if not branch:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        # this returns an array like [&quot;master&quot;] =
or [&quot;release&quot;, &quot;2.6&quot;]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        branch =3D run_command([&quot;git&quot;, &quo=
t;rev-parse&quot;, &quot;--symbolic-full-name&quot;, &quot;HEAD&quot;]).spl=
it(&quot;/&quot;)[2:]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if not branch:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            branch =3D [&quot;none&quot;]</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        branch =3D &quot;/&quot; .join(branch) #=
 handle cases like release/2.6</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn branch, commit_id</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def main():</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    try:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        branch, commit_id =3D get_bra=
nch_commit_id()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
except:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bran=
ch, commit_id =3D &quot;unknown&quot;, &quot;unknown&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    prev_content =3D &quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    name =3D os.path.join(&quot;%s&quot; %  (sys.argv[1] if =
len(sys.argv) &gt; 1 else &quot;.&quot;), &quot;config-version.h&quot;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    try:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        with open(name, &quot;r&qu=
ot;) as f:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   prev_content =3D f.read()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    except:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        # file doesn&#39;t exist</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        pass</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    content =
=3D &quot;#define CONFIGURE_GIT_REVISION \&quot;%s/%s\&quot;\n&quot; % (bra=
nch, commit_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
content +=3D &quot;#define CONFIGURE_GIT_FLAGS \&quot;\&quot;\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if prev_content !=3D content:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        print(&quot;Writing %s=
&quot; % name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   with open(name, &quot;w&quot;) as f:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            f.write(content)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        print(&quot;Content of %s hasn&#39;t changed&quo=
t; % name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &quot;__m=
ain__&quot;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mai=
n()</span><br><span>diff --git a/contrib/cmake/parse-version.m4.py b/contri=
b/cmake/parse-version.m4.py</span><br><span>new file mode 100644</span><br>=
<span>index 0000000..26af6a8</span><br><span>--- /dev/null</span><br><span>=
+++ b/contrib/cmake/parse-version.m4.py</span><br><span>@@ -0,0 +1,58 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#             over a single UDP port, with support for SSL/TLS-based</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#             session auth=
entication and key exchange,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#             packet encryption, packet authentication, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#             packet compr=
ession.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#  Copyright (C) 2022-2023 Ope=
nVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#  Copyright (C) 2022-2022 Lev Stipakov &lt;lev@...2698...&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#  This program is free software; you=
 can redistribute it and/or modify</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#  it under the terms of the GNU General Public License vers=
ion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  as publishe=
d by the Free Software Foundation.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
This program is distributed in the hope that it will be useful,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#  but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  GNU General =
Public License for more details.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#  51 Franklin Street, Fifth Floor, Boston, M=
A 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+import os</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+import re</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+import sys</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+def main():<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert len(sys.a=
rgv) &gt; 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    vers=
ion_path =3D sys.argv[1]</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    output =3D []</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    with open(version_path, &#39;r&#39;) as version_file:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        for line in version_file:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            match =
=3D re.match(r&#39;[ \t]*define\(\[(.*)\],[ \t]*\[(.*)\]\)[ \t]*&#39;, line=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if mat=
ch is not None:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            output.append(match.expand(r&#39;set(\1 \2)&#39;))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    out_path =3D os.path.join(&q=
uot;%s&quot; %  (sys.argv[2] if len(sys.argv) &gt; 2 else &quot;.&quot;), &=
quot;version.cmake&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prev_cont=
ent =3D &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    try:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wi=
th open(out_path, &quot;r&quot;) as out_file:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            prev_content =3D out_file.read()</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    except:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        # file doesn&#39;t exist=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pass</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    content =3D &quot;\n&quot;.join(output) +=
 &quot;\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if prev_content !=3D content:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        print(&quot;Writing %s&quot; % out_path)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        with open(out_path, &quot;w&=
quot;) as out_file:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            out_file.write(content)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        print(&quot;Content of %s hasn&#39;t changed&quot; % out_path=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+if __name__ =3D=3D &quot;__main__&quo=
t;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    main()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --g=
it a/contrib/vcpkg-manifests/mingw/vcpkg.json b/contrib/vcpkg-manifests/min=
gw/vcpkg.json</span><br><span>new file mode 100644</span><br><span>index 00=
00000..fc00b01</span><br><span>--- /dev/null</span><br><span>+++ b/contrib/=
vcpkg-manifests/mingw/vcpkg.json</span><br><span>@@ -0,0 +1,13 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &quot;$schema&quot;: &quot;https://raw.github=
usercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;name&quot;: &qu=
ot;openvpn&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&quot;version&quot;: &quot;2.7&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &quot;dependencies&quot;: [</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      &quot;openssl&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      &quot;tap-windows6&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      &quot;lzo&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      &quot;lz4&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      &quot;pkcs11-hel=
per&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      &qu=
ot;cmocka&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ]<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>di=
ff --git a/contrib/vcpkg-manifests/windows/vcpkg.json b/contrib/vcpkg-manif=
ests/windows/vcpkg.json</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000..67a1f87</span><br><span>--- /dev/null</span><br><span>+++ =
b/contrib/vcpkg-manifests/windows/vcpkg.json</span><br><span>@@ -0,0 +1,20 =
@@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &quot;$schema&quot;: &quot;https:=
//raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.jso=
n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;nam=
e&quot;: &quot;openvpn&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  &quot;version&quot;: &quot;2.7&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &quot;dependencies&quot;: [</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &quot;name&quot;: &quot;openssl&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;featur=
es&quot;: [&quot;tools&quot;]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     &quot;tap-windows6&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      &quot;lzo&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      &quot;lz4&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      &quot;pkcs11-helper&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      &quot;cmocka&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          &quot;name&quot;: &quot;pkgconf&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          &quot;host&q=
uot;: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/contri=
b/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-hel=
per/portfile.cmake</span><br><span>index 47919bc..f8da979 100644</span><br>=
<span>--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><spa=
n>+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>@@=
 -28,12 +28,28 @@</span><br><span>         OPENSSL_HOME=3D${CURRENT_PACKAGE=
S_DIR}/../openssl_${TARGET_TRIPLET}</span><br><span>   )</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  file(INSTALL ${CURRE=
NT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINAT=
ION ${CURRENT_PACKAGES_DIR}/lib)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/l=
ib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  file(INSTALL ${CURREN=
T_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATI=
ON ${CURRENT_PACKAGES_DIR}/lib RENAME pkcs11-helper.lib)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  file(INSTALL ${CURRENT_BUILDTREES_DI=
R}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PA=
CKAGES_DIR}/debug/lib RENAME pkcs11-helper.lib)</span><br><span> </span><br=
><span>   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/=
libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)</span><br><=
span>   file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/li=
bpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  set(PAC=
KAGE_VERSION &quot;${VERSION}&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    set(libdir [[${prefix}/lib]])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    set(exec_prefix [[${prefix}]])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    set(PKCS11H_FEATURES key_=
prompt openssl engine_crypto_cryptoapi engine_crypto_openssl debug threadin=
g token data certificate slotevent engine_crypto)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    set(LIBS -lkernel32 -luser32 -lgdi32 -lwi=
nspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if(NOT DEFINED VCPKG_BUIL=
D_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;release&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        set(includedir [[${prefix}/inc=
lude]])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(=
outfile &quot;${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libpkcs11-helper-1.pc&q=
uot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        config=
ure_file(&quot;${SOURCE_PATH}/lib/libpkcs11-helper-1.pc.in&quot; &quot;${ou=
tfile}&quot; @ONLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if(N=
OT DEFINED VCPKG_BUILD_TYPE OR VCPKG_BUILD_TYPE STREQUAL &quot;debug&quot;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(include=
dir [[${prefix}/../include]])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        set(outfile &quot;${CURRENT_PACKAGES_DIR}/debug/lib/pkgco=
nfig/libpkcs11-helper-1.pc&quot;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        configure_file(&quot;${SOURCE_PATH}/lib/libpkcs11-hel=
per-1.pc.in&quot; &quot;${outfile}&quot; @ONLY)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    endif()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>   file(INSTALL ${SOURCE_PATH}/include=
/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)</span><br>=
<span> </span><br><span> else()</span><br><span>@@ -45,11 +61,11 @@</span><=
br><span>     --disable-crypto-engine-polarssl --disable-crypto-engine-mbed=
tls</span><br><span>     )</span><br><span>   vcpkg_install_make()</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  vcpkg_fixup_pkgconfig()</spa=
n><br><span> </span><br><span>   file(REMOVE_RECURSE &quot;${CURRENT_PACKAG=
ES_DIR}/debug/share&quot;)</span><br><span> endif()</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+vcpkg_fixup_pkgconfig()</=
span><br><span> vcpkg_copy_pdbs()</span><br><span> </span><br><span> file(I=
NSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${P=
ORT} RENAME copyright)</span><br><span>diff --git a/doc/CMakeLists.txt b/do=
c/CMakeLists.txt</span><br><span>new file mode 100644</span><br><span>index=
 0000000..8dfb883</span><br><span>--- /dev/null</span><br><span>+++ b/doc/C=
MakeLists.txt</span><br><span>@@ -0,0 +1,113 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+set(_GENERATE_HTML_DOC YES)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+set(_GENERATE_MAN_DOC  YES)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+set(_MAYBE_PYTHON &quot;&quot;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_program(RST2HT=
ML NAMES rst2html rst2html.py)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+find_program(RST2MAN  NAMES rst2man  rst2man.py)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+if (RST2HTML STREQUAL &quot;RST2HTML-NOTFOUND&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    message(STATUS &q=
uot;rst2html not found, not generating HTML documentation&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    set(_GENERATE_HTML_DOC NO)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else ()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    # We only run this for RST2=
HTML and assume the result would be the same</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    # for RST2MAN</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (DEFINED CACHE{DOCUTILS_NEED_PYTHON})</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if ($CACHE{DOCUTILS=
_NEED_PYTHON})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       set(_MAYBE_PYTHON ${PYTHON})</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        endif ()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else ()</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        execute_process(</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            COMMAND ${RST2HTML} --version</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            OUTPUT_VARIABLE RST2HTML_VERS=
ION_EXE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        execute_pr=
ocess(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            C=
OMMAND ${PYTHON} ${RST2HTML} --version</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            OUTPUT_VARIABLE RST2HTML_VERSION_PY</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            )</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        set(_DOCUTILS_NEED_PYTHON =
OFF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if(RST2=
HTML_VERSION_EXE STREQUAL &quot;&quot;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if(RST2HTML_VERSION_PY STREQUAL &quot;&quot=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
essage(STATUS &quot;${RST2HTML} found but not working, not generating docum=
entation&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            set(_GENERATE_HTML_DOC NO)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                set(_GENERATE_MAN_DOC NO)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else ()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                message(STATUS &qu=
ot;${RST2HTML} needs to be executed by ${PYTHON} to work&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                set(_MAYBE_PYTH=
ON ${PYTHON})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          set(_DOCUTILS_NEED_PYTHON ON)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            endif ()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        endif ()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        set(DOCUTILS_NEED_PYTHON ${_DOCUTILS_NEED_PYTHON}=
 CACHE BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &quot;Whether we need to call python instead of rst2*.py directly&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif (DEFINED=
 CACHE{DOCUTILS_NEED_PYTHON})</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f (RST2MAN STREQUAL &quot;RST2MAN-NOTFOUND&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    message(STATUS &quot;rst2man not found, n=
ot generating man pages&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    set(_GENERATE_MAN_DOC NO)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(OPENV=
PN_SECTIONS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-=
sections/advanced-options.rst</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    man-sections/cipher-negotiation.rst</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    man-sections/client-options.rst</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    man-sections/connection-p=
rofiles.rst</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-=
sections/encryption-options.rst</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    man-sections/generic-options.rst</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    man-sections/inline-files.rst</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    man-sections/link-options.rs=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-sections/l=
og-options.rst</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
an-sections/management-options.rst</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    man-sections/network-config.rst</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    man-sections/pkcs11-options.rst</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    man-sections/plugin-opti=
ons.rst</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-sect=
ions/protocol-options.rst</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    man-sections/proxy-options.rst</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    man-sections/renegotiation.rst</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    man-sections/signals.rst</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    man-sections/script-option=
s.rst</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man-sectio=
ns/server-options.rst</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    man-sections/tls-options.rst</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    man-sections/unsupported-options.rst</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    man-sections/virtual-routing-and-fo=
rwarding.rst</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    man=
-sections/vpn-network-options.rst</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    man-sections/windows-options.rst</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+se=
t(OPENVPN_EXAMPLES_SECTIONS</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    man-sections/example-fingerprint.rst</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    man-sections/examples.rst</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+set(RST_FLAGS --strict)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (_GENE=
RATE_HTML_DOC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    l=
ist(APPEND ALL_DOCS openvpn.8.html openvpn-examples.5.html)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    add_custom_command(</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        OUTPUT openvpn.8.html</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        COMMAND ${_MA=
YBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.=
rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MAIN_DEPENDENCY openvpn.8.rst</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        DEPENDS ${OPENVPN_SECT=
IONS}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_custom_command(<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OUTPUT openv=
pn-examples.5.html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       COMMAND ${_MAYBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SO=
URCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-exampl=
es.5.html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MA=
IN_DEPENDENCY openvpn-examples.5.rst</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+if (_GENERATE_MAN_DOC)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    list(APPEND ALL_DOCS openvpn.8 openvpn-exampl=
es.5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_custom=
_command(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OU=
TPUT openvpn.8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_=
DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        MAIN_DEPENDENCY openvpn.8.rst<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DEPENDS ${OP=
ENVPN_SECTIONS}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_custom=
_command(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        OU=
TPUT openvpn-examples.5</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURREN=
T_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-ex=
amples.5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MAI=
N_DEPENDENCY openvpn-examples.5.rst</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+add_custom_target(documentation ALL DEPENDS ${ALL_DOCS})</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>diff --git a/doc/Mak=
efile.am b/doc/Makefile.am</span><br><span>index d8ffe2e..087f0ce 100644</s=
pan><br><span>--- a/doc/Makefile.am</span><br><span>+++ b/doc/Makefile.am</=
span><br><span>@@ -63,7 +63,8 @@</span><br><span> 	README.plugins \</span><=
br><span> 	tls-crypt-v2.txt \</span><br><span> 	$(openvpn_sections) \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(openvpn_examples_section=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(openvpn_exampl=
es_sections) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CMak=
eLists.txt</span><br><span> </span><br><span> EXTRA_DIST =3D tests</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.=
h</span><br><span>index c572354..f05c002 100644</span><br><span>--- a/src/o=
penvpn/lzo.h</span><br><span>+++ b/src/openvpn/lzo.h</span><br><span>@@ -37=
,7 +37,14 @@</span><br><span>  * @addtogroup compression</span><br><span>  =
* @{</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAV=
E_LZO_CONF_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The=
 lzo.h magic gets confused and still wants</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * to include lzo/lzoconf.h even if our include path=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are setup to in=
clude the paths without lzo/ include lzoconf.h to</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * avoid it being include by lzoutil.h */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;lzodefs.h&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;lzo=
conf.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span> #if defined(HAVE_LZO_LZOUTIL_H)</span><br><span> #include &l=
t;lzo/lzoutil.h&gt;</span><br><span> #elif defined(HAVE_LZOUTIL_H)</span><b=
r><span>diff --git a/src/openvpnmsica/CMakeLists.txt b/src/openvpnmsica/CMa=
keLists.txt</span><br><span>new file mode 100644</span><br><span>index 0000=
000..9126b80</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvp=
nmsica/CMakeLists.txt</span><br><span>@@ -0,0 +1,44 @@</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+if (NOT WIN32)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return ()</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+projec=
t(openvpnmsica)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+add_library(openvpnmsic=
a SHARED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+target_include_directories(op=
envpnmsica PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ${CMAKE_CURRENT_BINARY_DIR}/../../</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ../../include/</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ../compat/</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ta=
rget_sources(openvpnmsica PRIVATE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    dllmain.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msiex.c msiex.h</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msica_arg.c msica_arg.h</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    openvpnmsica.c openvpnmsica.h</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ../tapctl/basic.h</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ../tapctl/error.c ../tapctl/error.h</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ../tapctl/tap.c .=
./tapctl/tap.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
penvpnmsica_resources.rc</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+target_co=
mpile_options(openvpnmsica PRIVATE</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    -D_UNICODE</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    -UNTDDI_VERSION</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if =
(MSVC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_co=
mpile_options(openvpnmsica PRIVATE</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &quot;$&lt;$&lt;CONFIG:Release&gt;:/MT&gt;&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;$&lt;$&lt=
;CONFIG:Debug&gt;:/MTd&gt;&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+target_link_libraries(openv=
pnmsica</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    advapi32=
.lib ole32.lib msi.lib setupapi.lib iphlpapi.lib shell32.lib shlwapi.lib ve=
rsion.lib newdev.lib)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+if (MINGW)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tar=
get_compile_options(openvpnmsica PRIVATE -municode)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    target_link_options(openvpnmsica PRIV=
ATE -municode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
arget_link_options(openvpnmsica PRIVATE</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        -Wl,--kill-at)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+endif ()</span><br><span>diff --git a/src/openvpnmsi=
ca/Makefile.am b/src/openvpnmsica/Makefile.am</span><br><span>index 6da0754=
..d68a008 100644</span><br><span>--- a/src/openvpnmsica/Makefile.am</span><=
br><span>+++ b/src/openvpnmsica/Makefile.am</span><br><span>@@ -34,6 +34,9 =
@@</span><br><span> AM_CFLAGS =3D \</span><br><span> 	$(TAP_CFLAGS)</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+EXTRA_DIS=
T =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	CMakeLists.=
txt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> if WIN32</span><br><span> lib_LTLIBRARIES =3D libopenvpnmsica.la</span><b=
r><span> libopenvpnmsica_la_CFLAGS =3D \</span><br><span>diff --git a/src/o=
penvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt</span><br><span>=
new file mode 100644</span><br><span>index 0000000..17cd90c</span><br><span=
>--- /dev/null</span><br><span>+++ b/src/openvpnserv/CMakeLists.txt</span><=
br><span>@@ -0,0 +1,34 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+if (NOT WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif=
 ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+project(openvpnserv)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+add_executable(openvpnserv)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+target_include_directories(openvpnserv PRIVATE</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ${CMAKE_CURRENT_BINARY_DIR}/../..=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ../../include/=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ../openvpn/</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ../compat/</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+target_sources(openvpnserv PRIVATE</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    common.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    interactive.c</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    service.c service.h</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    validate.c validate.h</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ../openvpn/block_dns.=
c ../openvpn/block_dns.h</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    openvpnserv_resources.rc</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ../openvpn/ring_buffer.h</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+target_compile_options(openvpnserv PRIVATE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    -D_UNICODE</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    -UNTDDI_VERSION</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+target_link_libraries(openvpnserv</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    advapi32.lib userenv.l=
ib iphlpapi.lib fwpuclnt.lib rpcrt4.lib shlwapi.lib netapi32.lib ws2_32.lib=
 ntdll.lib)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (MING=
W)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_compil=
e_options(openvpnserv PRIVATE -municode)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    target_link_options(openvpnserv PRIVATE -municode)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br>=
<span>diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.a=
m</span><br><span>index b8b2a37..4c0ac40 100644</span><br><span>--- a/src/o=
penvpnserv/Makefile.am</span><br><span>+++ b/src/openvpnserv/Makefile.am</s=
pan><br><span>@@ -19,6 +19,9 @@</span><br><span> AM_CPPFLAGS =3D \</span><b=
r><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdi=
r)/src/compat</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+EXTRA_DIST =3D \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	CMakeLists.txt</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> if WIN32</span><br><span> sbin_PROGRAMS =3D openvpns=
erv</span><br><span> openvpnserv_CFLAGS =3D \</span><br><span>diff --git a/=
src/tapctl/CMakeLists.txt b/src/tapctl/CMakeLists.txt</span><br><span>new f=
ile mode 100644</span><br><span>index 0000000..97702c0</span><br><span>--- =
/dev/null</span><br><span>+++ b/src/tapctl/CMakeLists.txt</span><br><span>@=
@ -0,0 +1,31 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (=
NOT WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+project(tapctl)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+add_executable(tapctl)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+target_in=
clude_directories(tapctl PRIVATE</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ${CMAKE_CURRENT_BINARY_DIR}/../../</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ../../include/</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ../compat/</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+target_sources(tapctl PRIVATE</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    basic.h</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    error.c error.h</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    main.c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tap.c tap.h</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    tapctl_resources.rc</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+target=
_compile_options(tapctl PRIVATE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    -D_UNICODE</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    -UNTDDI_VERSION</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    -D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+target_link_libraries(tapctl</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    advapi32.lib ole32.lib setupapi.lib)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+if (MINGW)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    target_compile_options(tapctl PRIVATE=
 -municode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    targ=
et_link_options(tapctl PRIVATE -municode)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+endif ()</span><br><span>diff --git a/src/tapctl/Make=
file.am b/src/tapctl/Makefile.am</span><br><span>index 3896351..fe8ab2a 100=
644</span><br><span>--- a/src/tapctl/Makefile.am</span><br><span>+++ b/src/=
tapctl/Makefile.am</span><br><span>@@ -33,6 +33,10 @@</span><br><span> AM_C=
FLAGS =3D \</span><br><span> 	$(TAP_CFLAGS)</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+EXTRA_DIST =3D \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	CMakeLists.txt \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	tapctl.exe.manifest</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if WIN32</span><br>=
<span> sbin_PROGRAMS =3D tapctl</span><br><span> tapctl_CFLAGS =3D \</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/315?usp=3Demail">change 315</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/315?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6de18261d5dc7f8561612184059=
656c73f33a5f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 315 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--w9/13h64Bn8=--

