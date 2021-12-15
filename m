From: Arne Schwabe <arne@...1227...>
Date: Wed, 15 Dec 2021 13:34:49 +0100
Message-Id: <20211215123449.53818-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Make github actions names nicer,
 include Ubuntu18+OpenSSL 1.0.2
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

Also let other variants finish if one fails (fail-fast: false)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e5a4e857b..440ef7273 100644
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
@@ -125,14 +128,35 @@ jobs:
 
   ubuntu:
     strategy:
+      fail-fast: false
       matrix:
         os: [ubuntu-18.04, ubuntu-20.04]
-        ssllib: [mbedtls, openssl]
+        sslpkg: [libssl-dev]
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
+
+    name: "gcc - ${{matrix.os}} - ${{matrix.libname}}"
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
@@ -146,10 +170,13 @@ jobs:
 
   ubuntu-clang-asan:
     strategy:
+      fail-fast: false
       matrix:
         os: [ubuntu-20.04]
         ssllib: [mbedtls, openssl]
 
+    name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"
+
     runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
@@ -206,6 +233,7 @@ jobs:
 
   msvc:
       strategy:
+        fail-fast: false
         matrix:
           plat: [ARM64, Win32, x64]
           include:
@@ -216,6 +244,7 @@ jobs:
             - plat: x64
               triplet: x64
 
+      name: "msbuild - ${{matrix.triplet}} - openssl"
       env:
         BUILD_CONFIGURATION: Release
         VCPKG_OVERLAY_PORTS: ${{ github.workspace }}/contrib/vcpkg-ports
-- 
2.33.0


