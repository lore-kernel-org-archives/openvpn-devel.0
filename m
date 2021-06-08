From: Arne Schwabe <arne@...1227...>
Date: Tue,  8 Jun 2021 17:24:34 +0200
Message-Id: <20210608152434.1403999-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add github actions
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

dummy0 gives strange errors on the Ubuntu 16 runner on github actions because
dummy already exist, so use a more unique ovpn-dummy0 name instead.

Github actions are a good alternative to travis-ci, which futrure is questionable
at the moment without payment. The github actions also allows building on macOS
and Windows (not included in this commit). The  matrix is a bit different
than Coverity and uses different Ubuntu version with their native OpenSSL
(1.0.2, 1.1.1)/mbed TLS instead of manually compiling different OpenSSL
versions on just Ubuntu 20.04.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml               | 184 +++++++++++++++++++++
 tests/t_net.sh                             |   2 +-
 tests/unit_tests/openvpn/test_networking.c |   2 +-
 3 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 .github/workflows/build.yaml

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
new file mode 100644
index 000000000..7ff379802
--- /dev/null
+++ b/.github/workflows/build.yaml
@@ -0,0 +1,184 @@
+# The name of our workflow
+name: Build
+on: [push, pull_request]
+
+jobs:
+  mingw:
+    strategy:
+      matrix:
+        include:
+          - target: mingw64
+            chost: x86_64-w64-mingw32
+          - target: mingw
+            chost: i686-w64-mingw32
+
+    runs-on: ubuntu-20.04
+    env:
+      MAKEFLAGS: -j3
+      LZO_VERSION: "2.10"
+      PKCS11_HELPER_VERSION: "1.26"
+      OPENSSL_VERSION: "1.1.1j"
+      TAP_WINDOWS_VERSION: "9.23.3"
+      CHOST: ${{ matrix.chost }}
+      TARGET: ${{ matrix.target }}
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
+      - name: Checkout ovpn-dco-win
+        uses: actions/checkout@...2620...
+        with:
+          repository: OpenVPN/ovpn-dco-win
+          path: ovpn-dco-win
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2620...
+        with:
+          path: openvpn
+          
+      - name: autoconf
+        run: autoreconf -fvi
+        working-directory: openvpn
+
+      - name: Cache dependencies
+        id: cache
+        uses: actions/cache@...2620...
+        with:
+          path: '~/mingw/'
+          key: ${{ matrix.target }}-mingw-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
+
+      # Repeating  if: steps.cache.outputs.cache-hit != 'true'
+      # on every step for building dependencies is ugly but
+      # I haven't found a better solution so far.
+          
+      - name: Download mingw depnendencies
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: |
+          wget -c -P download-cache/ "https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
+          wget -c -P download-cache/ "https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
+          wget -c -P download-cache/ "https://github.com/OpenSC/pkcs11-helper/archive/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz"
+          wget -c -P download-cache/ "https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz"
+          tar zxf "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz"
+          tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
+          tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
+          unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
+
+      - name: Configure OpenSSL
+        if: steps.cache.outputs.cache-hit != 'true'        
+        run: ./Configure --cross-compile-prefix=${CHOST}- shared ${{ matrix.target }} no-capieng --prefix="${HOME}/mingw/opt" --openssldir="${HOME}/mingw/opt" -static-libgcc
+        working-directory: "./openssl-1.1.1j"
+        
+      - name: Build OpenSSL
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: make
+        working-directory: "./openssl-1.1.1j/"
+
+      - name: Install OpenSSL
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: make install
+        working-directory: "./openssl-1.1.1j/"
+        
+      - name: autoreconf pkcs11-helper
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: autoreconf -iv
+        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+
+      - name: configure pkcs11-helper
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: OPENSSL_LIBS="-L${HOME}/mingw/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig ./configure --host=${CHOST} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
+        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+        
+      - name: build pkcs11-helper
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: make all
+        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+        
+      - name: install pkcs11-helper
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: make install
+        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+
+      - name: Configure lzo
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: ./configure --host=${CHOST} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu
+        working-directory: "./lzo-2.10"
+        
+      - name: build lzo
+        if: steps.cache.outputs.cache-hit != 'true'
+        working-directory: "./lzo-2.10"
+        run: make
+        
+      - name: install lzo
+        if: steps.cache.outputs.cache-hit != 'true'
+        working-directory: "./lzo-2.10"
+        run: make install
+
+      - name: copy tap-windows.h header
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: cp ./tap-windows-9.23.3/include/tap-windows.h ${HOME}/mingw/opt/include/
+
+      - name: configure OpenVPN
+        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig DCO_SOURCEDIR=$(realpath ../ovpn-dco-win) LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4 --enable-dco
+        working-directory: openvpn
+                
+      - name: build OpenVPN
+        run: make -j3
+        working-directory: openvpn
+  
+  ubuntu:
+    strategy:
+      matrix:
+        os: [ubuntu-16.04, ubuntu-18.04, ubuntu-20.04]
+        ssllib: [mbedtls, openssl]
+
+    runs-on: ${{matrix.os}}
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2620...
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure --with-crypto-library=${{matrix.ssllib}}
+        run: ./configure
+      - name: make all
+        run: make -j3
+      - name: make check
+        run: make check
+          
+  ubutun20-clang-asan:
+    strategy:
+      matrix:
+        os: [ubuntu-16.04, ubuntu-18.04]
+        ssllib: [mbedtls, openssl]
+
+    runs-on: ubuntu-20.04
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2620...
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure
+        run: CFLAGS="-fsanitize=address -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}}
+      - name: make all
+        run: make -j3
+      - name: make check
+        run: make check
+
+
+  macos:
+    runs-on: macos-latest
+    steps:
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2620...
+      - name: Install dependencies
+        run: brew install openssl lzo lz4 man2html cmocka libtool automake autoconf
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure
+        run: OPENSSL_CFLAGS=-I/usr/local/opt/openssl@...2560.../include  OPENSSL_LIBS="-L/usr/local/opt/openssl@...2560.../lib -lcrypto -lssl" ./configure
+      - name: make all
+        run: make -j4
+      - name: make check
+        run: make check
+
diff --git a/tests/t_net.sh b/tests/t_net.sh
index 246ee07bd..f9dba4040 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 
-IFACE="dummy0"
+IFACE="ovpn-dummy0"
 UNIT_TEST="./unit_tests/openvpn/networking_testdriver"
 MAX_TEST=${1:-7}
 
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index e7c148f0e..9e9744f48 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -3,7 +3,7 @@
 #include "networking.h"
 
 
-static char *iface = "dummy0";
+static char *iface = "ovpn-dummy0";
 
 static int
 net__iface_up(bool up)
-- 
2.32.0


