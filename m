From: Marc Becker <becm@...68...>
Date: Sun, 24 Apr 2022 21:25:10 +0200
Message-Id: <20220424192510.75385-1-becm@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix GitHub workflow working directories in
 MinGW builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

replace hardcoded directory names with env variable version info
bump pkcs11-helper version to 1.29.0
bump OpenSSL version to 1.1.1n
add OpenSSL version to cache key
use release file for pkcs11-helper archive
use OpenSSL URL endpoint with all/current versions

Signed-off-by: Marc Becker <becm@...68...>
---
 .github/workflows/build.yaml | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index fa99e12b..34a9d9b9 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -19,8 +19,8 @@ jobs:
     env:
       MAKEFLAGS: -j3
       LZO_VERSION: "2.10"
-      PKCS11_HELPER_VERSION: "1.26"
-      OPENSSL_VERSION: "1.1.1j"
+      PKCS11_HELPER_VERSION: "1.29.0"
+      OPENSSL_VERSION: "1.1.1n"
       TAP_WINDOWS_VERSION: "9.23.3"
       CHOST: ${{ matrix.chost }}
       TARGET: ${{ matrix.target }}
@@ -46,20 +46,20 @@ jobs:
         uses: actions/cache@...2620...
         with:
           path: '~/mingw/'
-          key: ${{ matrix.target }}-mingw-${{ env.LZO_VERSION }}-${{ env.P=
KCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
+          key: ${{ matrix.target }}-mingw-${{ env.OPENSSL_VERSION }}-${{ e=
nv.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERS=
ION }}

       # Repeating  if: steps.cache.outputs.cache-hit !=3D 'true'
       # on every step for building dependencies is ugly but
       # I haven't found a better solution so far.

-      - name: Download mingw depnendencies
+      - name: Download mingw dependencies
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: |
           wget -c -P download-cache/ "https://build.openvpn.net/downloads/=
releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
           wget -c -P download-cache/ "https://www.oberhumer.com/opensource=
/lzo/download/lzo-${LZO_VERSION}.tar.gz"
-          wget -c -P download-cache/ "https://github.com/OpenSC/pkcs11-hel=
per/archive/pkcs11-helper-${PKCS11_HELPER_VERSION}.tar.gz"
-          wget -c -P download-cache/ "https://www.openssl.org/source/old/1=
.1.1/openssl-${OPENSSL_VERSION}.tar.gz"
-          tar zxf "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.t=
ar.gz"
+          wget -c -P download-cache/ "https://github.com/OpenSC/pkcs11-hel=
per/releases/download/pkcs11-helper-${PKCS11_HELPER_VERSION}/pkcs11-helper-=
${PKCS11_HELPER_VERSION}.tar.bz2"
+          wget -c -P download-cache/ "https://www.openssl.org/source/opens=
sl-${OPENSSL_VERSION}.tar.gz"
+          tar jxf "download-cache/pkcs11-helper-${PKCS11_HELPER_VERSION}.t=
ar.bz2"
           tar zxf "download-cache/openssl-${OPENSSL_VERSION}.tar.gz"
           tar zxf "download-cache/lzo-${LZO_VERSION}.tar.gz"
           unzip download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip
@@ -67,56 +67,56 @@ jobs:
       - name: Configure OpenSSL
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: ./Configure --cross-compile-prefix=3D${CHOST}- shared ${{ mat=
rix.target }} no-capieng --prefix=3D"${HOME}/mingw/opt" --openssldir=3D"${H=
OME}/mingw/opt" -static-libgcc
-        working-directory: "./openssl-1.1.1j"
+        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"

       - name: Build OpenSSL
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: make
-        working-directory: "./openssl-1.1.1j/"
+        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"

       - name: Install OpenSSL
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: make install
-        working-directory: "./openssl-1.1.1j/"
+        working-directory: "./openssl-${{ env.OPENSSL_VERSION }}"

       - name: autoreconf pkcs11-helper
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: autoreconf -iv
-        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"

       - name: configure pkcs11-helper
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: OPENSSL_LIBS=3D"-L${HOME}/mingw/opt/lib -lssl -lcrypto" OPENS=
SL_CFLAGS=3D-I$HOME/mingw/opt/include PKG_CONFIG_PATH=3D${HOME}/mingw/opt/l=
ib/pkgconfig ./configure --host=3D${CHOST} --program-prefix=3D'' --libdir=
=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-l=
inux-gnu --disable-crypto-engine-gnutls --disable-crypto-engine-nss --disab=
le-crypto-engine-polarssl --disable-crypto-engine-mbedtls
-        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"

       - name: build pkcs11-helper
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: make all
-        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"

       - name: install pkcs11-helper
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: make install
-        working-directory: "./pkcs11-helper-pkcs11-helper-1.26"
+        working-directory: "./pkcs11-helper-${{ env.PKCS11_HELPER_VERSION =
}}"

       - name: Configure lzo
         if: steps.cache.outputs.cache-hit !=3D 'true'
         run: ./configure --host=3D${CHOST} --program-prefix=3D'' --libdir=
=3D${HOME}/mingw/opt/lib --prefix=3D${HOME}/mingw/opt --build=3Dx86_64-pc-l=
inux-gnu
-        working-directory: "./lzo-2.10"
+        working-directory: "./lzo-${{ env.LZO_VERSION }}"

       - name: build lzo
         if: steps.cache.outputs.cache-hit !=3D 'true'
-        working-directory: "./lzo-2.10"
+        working-directory: "./lzo-${{ env.LZO_VERSION }}"
         run: make

       - name: install lzo
         if: steps.cache.outputs.cache-hit !=3D 'true'
-        working-directory: "./lzo-2.10"
+        working-directory: "./lzo-${{ env.LZO_VERSION }}"
         run: make install

       - name: copy tap-windows.h header
         if: steps.cache.outputs.cache-hit !=3D 'true'
-        run: cp ./tap-windows-9.23.3/include/tap-windows.h ${HOME}/mingw/o=
pt/include/
+        run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h=
 ${HOME}/mingw/opt/include/

       - name: configure OpenVPN
         run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig DCO_SOURCED=
IR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/mingw/opt/lib CFLAGS=3D-=
I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl -lcrypto" =
OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw/opt LZO_CFL=
AGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib -llzo2"=
 ./configure  --host=3D${CHOST} --disable-lz4 --enable-dco
--
2.30.2


