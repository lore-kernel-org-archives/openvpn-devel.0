From: Arne Schwabe <arne@...1227...>
Date: Wed, 24 Aug 2022 12:53:11 +0200
Message-Id: <20220824105311.71288-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add OpenSSL 3.0 to mingw build
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

This also updates the host system to ubuntu 22.04 and remove the ovpn-dco-win
checkout as we now include the required headers in our own repository.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b0f67a785..f2472fdcf 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -39,31 +39,25 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
+        osslver: [1.1.1q, 3.0.5]
+        target: [mingw64, mingw]
         include:
           - target: mingw64
             chost: x86_64-w64-mingw32
           - target: mingw
             chost: i686-w64-mingw32
 
-    name: "gcc-mingw - ${{matrix.target}}"
-
-    runs-on: ubuntu-20.04
+    name: "gcc-mingw - ${{matrix.target}} - OSSL ${{ matrix.osslver }}"
+    runs-on: ubuntu-22.04
     env:
       MAKEFLAGS: -j3
       LZO_VERSION: "2.10"
       PKCS11_HELPER_VERSION: "1.29.0"
-      OPENSSL_VERSION: "1.1.1n"
+      OPENSSL_VERSION: "${{ matrix.osslver }}"
       TAP_WINDOWS_VERSION: "9.23.3"
-      CHOST: ${{ matrix.chost }}
-      TARGET: ${{ matrix.target }}
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
-      - name: Checkout ovpn-dco-win
-        uses: actions/checkout@...2689...
-        with:
-          repository: OpenVPN/ovpn-dco-win
-          path: ovpn-dco-win
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
         with:
@@ -78,7 +72,7 @@ jobs:
         uses: actions/cache@...2689...
         with:
           path: '~/mingw/'
-          key: ${{ matrix.target }}-mingw-${{ env.OPENSSL_VERSION }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
+          key: ${{ matrix.target }}-mingw-${{ matrix.osslver }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
 
       # Repeating  if: steps.cache.outputs.cache-hit != 'true'
       # on every step for building dependencies is ugly but
@@ -90,15 +84,15 @@ jobs:
           wget -c -P download-cache/ "https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
           wget -c -P download-cache/ "https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
           wget -c -P download-cache/ "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
-          wget -c -P download-cache/ "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
           tar jxf "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.bz2"
+          wget -c -P download-cache/ "https://www.openssl.org/source/old/1.1.1/openssl-${OPENSSL_VERSION}.tar.gz" || wget -c -P download-cache/ "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz" 
           tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
           tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
           unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
 
       - name: Configure OpenSSL
         if: steps.cache.outputs.cache-hit != 'true'
-        run: ./Configure --cross-compile-prefix=${CHOST}- shared ${{ matrix.target }} no-capieng --prefix="${HOME}/mingw/opt" --openssldir="${HOME}/mingw/opt" -static-libgcc
+        run: ./Configure --cross-compile-prefix=${{ matrix.chost }}- shared ${{ matrix.target }} no-capieng --prefix="${HOME}/mingw/opt" --openssldir="${HOME}/mingw/opt" -static-libgcc
         working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
 
       - name: Build OpenSSL
@@ -106,6 +100,9 @@ jobs:
         run: make
         working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"
 
+      # OpenSSL 3.0.5 installs itself into mingw/opt/lib64 instead of
+      # mingw/opt/lib, so we include both dirs in the following steps
+      # (pkcs11-helper and OpenVPN) so the libraries will be found
       - name: Install OpenSSL
         if: steps.cache.outputs.cache-hit != 'true'
         run: make install
@@ -118,7 +115,7 @@ jobs:
 
       - name: configure pkcs11-helper
         if: steps.cache.outputs.cache-hit != 'true'
-        run: OPENSSL_LIBS="-L${HOME}/mingw/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig ./configure --host=${CHOST} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
+        run: OPENSSL_LIBS="-L${HOME}/mingw/opt/lib -L${HOME}/mingw/opt/lib64 -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig ./configure --host=${{ matrix.chost }} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
         working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION }}"
 
       - name: build pkcs11-helper
@@ -133,7 +130,7 @@ jobs:
 
       - name: Configure lzo
         if: steps.cache.outputs.cache-hit != 'true'
-        run: ./configure --host=${CHOST} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu
+        run: ./configure --host=${{ matrix.chost }} --program-prefix='' --libdir=${HOME}/mingw/opt/lib --prefix=${HOME}/mingw/opt --build=x86_64-pc-linux-gnu
         working-directory: "./lzo-${{ env.LZO_VERSION }}"
 
       - name: build lzo
@@ -151,7 +148,7 @@ jobs:
         run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h ${HOME}/mingw/opt/include/
 
       - name: configure OpenVPN
-        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig DCO_SOURCEDIR=$(realpath ../ovpn-dco-win) LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4 --enable-dco
+        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig DCO_SOURCEDIR=$(realpath ../ovpn-dco-win) LDFLAGS="-L$HOME/mingw/opt/lib -L$HOME/mingw/opt/lib64" CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${{ matrix.chost }} --disable-lz4 --enable-dco
         working-directory: openvpn
 
       - name: build OpenVPN
-- 
2.32.1 (Apple Git-133)


