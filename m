From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Feb 2023 01:18:19 +0100
Message-Id: <20230208001819.244694-6-arne@...1227...>
In-Reply-To: <20230208001819.244694-1-arne@...1227...>
References: <20230208001819.244694-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] Add building and running mingw
 unittests to github actions
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 110 ++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 132624547..c71bd2c4d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -55,9 +55,10 @@ jobs:
       PKCS11_HELPER_VERSION: "1.29.0"
       OPENSSL_VERSION: "${{ matrix.osslver }}"
       TAP_WINDOWS_VERSION: "9.23.3"
+      CMOCKA_VERSION: "1.1.5"
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
+        run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip cmake ninja-build build-essential wget
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
         with:
@@ -72,7 +73,7 @@ jobs:
         uses: actions/cache@...2689...
         with:
           path: '~/mingw/'
-          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
+          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}--${{ env.CMOCKA_VERSION }}
 
       # Repeating  if: steps.cache.outputs.cache-hit != 'true'
       # on every step for building dependencies is ugly but
@@ -84,12 +85,33 @@ jobs:
           wget -c -P download-cache/ "https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
           wget -c -P download-cache/ "https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
           wget -c -P download-cache/ "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
+          wget -c -P download-cache/ "https://github.com/coreboot/cmocka/archive/refs/tags/cmocka-${CMOCKA_VERSION}.tar.gz"
           tar jxf "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
           wget -c -P download-cache/ "https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz" || wget -c -P download-cache/ "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
           tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
           tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
+          tar zxf "download-cache/cmocka-${CMOCKA_VERSION}.tar.gz"
           unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
 
+      - name: create cmocka build directory
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: mkdir cmocka-build
+
+      - name: configure cmocka
+        if: steps.cache.outputs.cache-hit != 'true'
+        working-directory: "./cmocka-build"
+        run: cmake -GNinja -DCMAKE_C_COMPILER=${{ matrix.chost }}-gcc -DCMAKE_CXX_COMPILER=${{ matrix.chost }}-g++ -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_PREFIX_PATH=${HOME}/mingw/opt/lib/pkgconfig/ -DCMAKE_INCLUDE_PATH=${HOME}/mingw/opt/lib/include -DCMAKE_LIBRARY_PATH=${HOME}/mingw/opt/lib -DCMAKE_INSTALL_PREFIX=${HOME}/mingw/opt/ ../cmocka-cmocka-${{ env.CMOCKA_VERSION }}
+
+      - name: build cmocka
+        if: steps.cache.outputs.cache-hit != 'true'
+        working-directory: "./cmocka-build"
+        run: ninja
+
+      - name: install cmocka
+        if: steps.cache.outputs.cache-hit != 'true'
+        working-directory: "./cmocka-build"
+        run: ninja install
+
       - name: Configure OpenSSL
         if: steps.cache.outputs.cache-hit != 'true'
         run: ./Configure --cross-compile-prefix=${{ matrix.chost }}- shared ${{ matrix.target }} no-capieng --prefix="${HOME}/mingw/opt" --openssldir="${HOME}/mingw/opt" -static-libgcc
@@ -154,6 +176,89 @@ jobs:
       - name: build OpenVPN
         run: make -j3
         working-directory: openvpn
+      - name: build OpenVPN unittests
+        run: make -j3 check
+        working-directory: openvpn
+
+      # We use multiple upload-artifact here, so it becomes a flat folder
+      # structure since we need the ddls on the same level as the binaries
+      - name: Archive cmocka/openssl/lzo ddls
+        uses: actions/upload-artifact@...2689...
+        with:
+          retention-days: 1
+          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-dlls
+          path: '~/mingw/opt/bin/*.dll'
+
+      - name: Archive gcc dlls
+        uses: actions/upload-artifact@...2689...
+        with:
+          retention-days: 1
+          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-dlls
+          path: /usr/lib/gcc/${{ matrix.chost }}/10-win32/*.dll
+
+      - name: Archive mingw dlls
+        uses: actions/upload-artifact@...2689...
+        with:
+          retention-days: 1
+          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-dlls
+          path: /usr/${{ matrix.chost }}/lib/*.dll
+
+      # libtool puts some wrapper binaries in openvpn/tests/unit_tests/openvpn/
+      # and the real binaries in openvpn/tests/unit_tests/openvpn/.libs/
+      - name: Archive unittest artifacts
+        uses: actions/upload-artifact@...2689...
+        with:
+          retention-days: 1
+          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-tests
+          path: openvpn/tests/unit_tests/openvpn/.libs/*.exe
+
+      # Currently not used by the unit test but might in the future and also
+      # helpful if manually downloading and running openvpn.exe from a mingw
+      # build
+      - name: Archive openvpn binary
+        uses: actions/upload-artifact@...2689...
+        with:
+          retention-days: 1
+          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-tests
+          path: openvpn/src/openvpn/.libs/*.exe
+
+  mingw-unittest:
+    needs: [ mingw ]
+    strategy:
+      fail-fast: false
+      matrix:
+        osslver: [ 1.1.1q, 3.0.5 ]
+        target: [ mingw64, mingw ]
+
+    runs-on: windows-latest
+    name: "mingw unittests - ${{matrix.target}} - OSSL ${{ matrix.osslver }}"
+    steps:
+      - name: Retrieve mingw unittest dlls
+        uses: actions/download-artifact@...2689...
+        with:
+          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-dlls
+          path: unittests
+
+      - name: Retrieve mingw unittest
+        uses: actions/download-artifact@...2689...
+        with:
+          name: mingw-unittest-${{matrix.target}}-ossl${{ matrix.osslver }}-tests
+          path: unittests
+
+      - name: List unittests directory
+        run: "dir unittests"
+
+      - name: Run unit tests
+        run: |
+          ./unittests/argv_testdriver.exe
+          ./unittests/auth_token_testdriver.exe
+          ./unittests/buffer_testdriver.exe
+          ./unittests/crypto_testdriver.exe
+          ./unittests/misc_testdriver.exe
+          ./unittests/ncp_testdriver.exe
+          ./unittests/packet_id_testdriver.exe
+          ./unittests/pkt_testdriver.exe
+          ./unittests/provider_testdriver.exe
 
   ubuntu:
     strategy:
@@ -442,3 +547,4 @@ jobs:
         run: make -j3
       - name: make check
         run: make check
+
-- 
2.37.1 (Apple Git-137.1)


