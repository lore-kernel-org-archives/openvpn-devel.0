From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 19 Mar 2024 16:44:56 +0100
Message-Id: <20240319154456.2967716-1-frank@...2641...>
In-Reply-To: <gerrit.1710522333000.I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126@...2715...>
References: <gerrit.1710522333000.I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: general update March 2024
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

- Update to Node 20 versions of actions to avoid warnings
- Update to current vcpkg
- Update mbedTLS and LibreSSL to latest releases

Change-Id: I1ad6a0b1323ce0872f4a3299c5a9f18a982e0126
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/544
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index bc937e5..f771f5a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -49,12 +49,12 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake ninja-build build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
 
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2735...
         with:
-          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
+          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -64,7 +64,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -91,9 +91,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2689...
+        uses: actions/download-artifact@...2691...
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -159,7 +159,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -186,7 +186,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -235,7 +235,7 @@
       - name: Install dependencies
         run: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf libressl
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -257,7 +257,7 @@
 
       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2689...
+      - uses: actions/checkout@...2691...
       - uses: lukka/get-cmake@...2729...
 
       - name: Install rst2html
@@ -266,7 +266,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2735...
         with:
-          vcpkgGitCommitId: '1ba9a2591f15af5900f2ce2b3e2bf31771e3ac48'
+          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -285,7 +285,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@...2689...
+      - uses: actions/upload-artifact@...2691...
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -325,11 +325,11 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
         with:
           path: libressl
           repository: libressl/portable
-          ref: v3.8.2
+          ref: v3.8.3
       - name: "libressl: autogen.sh"
         run: ./autogen.sh
         working-directory: libressl
@@ -345,7 +345,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -384,11 +384,11 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
         with:
           path: mbedtls
           repository: Mbed-TLS/mbedtls
-          ref: v3.5.0
+          ref: v3.5.2
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=1
         working-directory: mbedtls
@@ -396,7 +396,7 @@
         run: sudo make install DESTDIR=/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index c107933..e289746 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -10,7 +10,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2689...
+        uses: actions/cache/restore@...2691...
         with:
           path: |
             cov-int
@@ -22,7 +22,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2689...
+        uses: actions/checkout@...2691...
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
@@ -62,7 +62,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...2689...
+        uses: actions/cache/save@...2691...
         with:
           path: |
             cov-int

