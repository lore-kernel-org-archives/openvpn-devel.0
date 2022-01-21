From: Antonio Quartulli <a@...2181...>
Date: Fri, 21 Jan 2022 21:49:33 +0100
Message-Id: <20220121204933.591-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.5] GitHub Actions: update script to same
 version as master
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---

This patch combines some master commits in order to bring the GH script
up to the same state as the one in master (minus OpenSSL3 related
changes).

 .github/workflows/build.yaml | 68 ++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index feb6cc99..5c02504a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -5,6 +5,7 @@ on: [push, pull_request]
 jobs:
   mingw:
     strategy:
+      fail-fast: false
       matrix:
         include:
           - target: mingw64
@@ -12,6 +13,8 @@ jobs:
           - target: mingw
             chost: i686-w64-mingw32
 
+    name: "gcc-mingw - ${{matrix.target}}"
+
     runs-on: ubuntu-20.04
     env:
       MAKEFLAGS: -j3
@@ -125,32 +128,81 @@ jobs:
 
   ubuntu:
     strategy:
+      fail-fast: false
       matrix:
         os: [ubuntu-18.04, ubuntu-20.04]
-        ssllib: [mbedtls, openssl]
+        sslpkg: [libmbedtls-dev]
+        ssllib: [mbedtls]
+        libname: [mbed TLS]
+
+        include:
+          - os: ubuntu-18.04
+            sslpkg: "libssl1.0-dev"
+            ssllib: openssl
+            libname: OpenSSL 1.0.2
+          - os: ubuntu-18.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--enable-iproute2"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--enable-async-push"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--disable-management"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--enable-small"
+          - os: ubuntu-20.04
+            sslpkg: "libssl-dev"
+            libname: OpenSSL 1.1.1
+            ssllib: openssl
+            extraconf: "--disable-lzo --disable-lz4"
+
+    name: "gcc - ${{matrix.os}} - ${{matrix.libname}} ${{matrix.extraconf}}"
+    env:
+      SSLPKG: "${{matrix.sslpkg}}"
 
     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG}
       - name: Checkout OpenVPN
         uses: actions/checkout@...2620...
       - name: autoconf
         run: autoreconf -fvi
-      - name: configure --with-crypto-library=${{matrix.ssllib}}
-        run: ./configure
+      - name: configure
+        run: ./configure --with-crypto-library=${{matrix.ssllib}} ${{matrix.extraconf}}
       - name: make all
         run: make -j3
       - name: make check
         run: make check
 
-  ubutun20-clang-asan:
+  ubuntu-clang-asan:
     strategy:
+      fail-fast: false
       matrix:
-        os: [ubuntu-16.04, ubuntu-18.04]
+        os: [ubuntu-20.04]
         ssllib: [mbedtls, openssl]
 
-    runs-on: ubuntu-20.04
+    name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"
+
+    runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
@@ -184,6 +236,7 @@ jobs:
 
   msvc:
       strategy:
+        fail-fast: false
         matrix:
           plat: [ARM64, Win32, x64]
           include:
@@ -194,6 +247,7 @@ jobs:
             - plat: x64
               triplet: x64
 
+      name: "msbuild - ${{matrix.triplet}} - openssl"
       env:
         BUILD_CONFIGURATION: Release
         VCPKG_OVERLAY_PORTS: ${{ github.workspace }}/contrib/vcpkg-ports
-- 
2.34.1


