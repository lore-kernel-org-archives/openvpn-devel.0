From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 27 Dec 2024 15:36:52 +0100
Message-Id: <20241227143652.147284-1-frank@...2641...>
In-Reply-To: <gerrit.1730381354000.I91f68317450c3c0d69be2c489276739211ccb422@...2715...>
References: <gerrit.1730381354000.I91f68317450c3c0d69be2c489276739211ccb422@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GHA: General update December 2024
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
Cc: Yuriy Darnobyt <yura.uddr@...277...>, Lev Stipakov <lstipakov@...277...>

Contains the following renovate updates:

- Update dependency libressl/portable to v4
  - Requires setting LIBRESSL_GIT_OPTIONS
    since the default is --depth=8 which is
    unusable for checking out tags.
- Update dependency Mbed-TLS/mbedtls to v3.6.2
- Update mingw ubuntu runner to v24
  - Do NOT update the uncrustify runner since newer uncrustify
    is not usable with the current config
- Update vcpkg digest to 80d54ff
- Update github actions

Additionally change the action reference pinning
to consistently refer to the tags instead of the branches.

Change-Id: I91f68317450c3c0d69be2c489276739211ccb422
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/789
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>
Lev Stipakov <lstipakov@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 767de0b..90d5202 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -42,19 +42,19 @@
         arch: [x86, x64]
 
     name: "gcc-mingw - ${{ matrix.arch }} - OSSL"
-    runs-on: ubuntu-22.04
+    runs-on: ubuntu-24.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake ninja-build build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
 
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -64,7 +64,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -72,7 +72,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -91,9 +91,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2817... # v4
+        uses: actions/download-artifact@...2817... # v4.1.8
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -165,7 +165,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -195,7 +195,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -235,7 +235,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -267,8 +267,8 @@
 
       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2813... # v4
-      - uses: lukka/get-cmake@...2818... # v3.30.3
+      - uses: actions/checkout@...2844... # v4.2.2
+      - uses: lukka/get-cmake@...2846... # v3.31.3
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -276,7 +276,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
+          vcpkgGitCommitId: 80d54ff62d528339c626a6fbc3489a7f25956ade
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -295,7 +295,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@...2814... # v4
+      - uses: actions/upload-artifact@...2845... # v4.5.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -335,13 +335,15 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
         with:
           path: libressl
           # versioning=semver-coerced
           repository: libressl/portable
-          ref: v3.8.3
+          ref: v4.0.0
       - name: "libressl: autogen.sh"
+        env:
+          LIBRESSL_GIT_OPTIONS: "--no-single-branch"
         run: ./autogen.sh
         working-directory: libressl
       - name: "libressl: configure"
@@ -356,7 +358,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -397,13 +399,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
         with:
           path: mbedtls
           submodules: true
           # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.1
+          ref: v3.6.2
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=1
         working-directory: mbedtls
@@ -411,7 +413,7 @@
         run: sudo make install DESTDIR=/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index 16c979d..cb70022 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2819... # v4
+        uses: actions/cache/restore@...2847... # v4.2.0
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2813... # v4
+        uses: actions/checkout@...2844... # v4.2.2
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...2819... # v4
+        uses: actions/cache/save@...2847... # v4.2.0
         with:
           path: |
             cov-int

