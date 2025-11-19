From: Gert Doering <gert@...1296...>
Date: Wed, 19 Nov 2025 14:54:52 +0100
Message-ID: <20251119135458.31160-1-gert@...1296...>
In-Reply-To: <gerrit.1763560274000.Ifd63130832e3bf20bf9816887e218ae73e2f5cd1@...2715...>
References: <gerrit.1763560274000.Ifd63130832e3bf20bf9816887e218ae73e2f5cd1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Maintenance update November 2025
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

From: Frank Lichtenheld <frank@...2641...>

Includes the following renovate changes:
- chore(deps): update dependency mbed-tls/mbedtls to v3.6.5
- chore(deps): update vcpkg digest to 3bbc280
- chore(deps): update dependency libressl/portable to v4.2.1
- chore(deps): update github actions
- chore(deps): update dependency aws/aws-lc to v1.64.0
- chore(deps): update github actions

Additionally, drop macos-13 since the
worker is deprecated.

Change-Id: Ifd63130832e3bf20bf9816887e218ae73e2f5cd1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1381
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1381
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e068f58..96d2292 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,12 +14,12 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
         run: git diff --output=format-changes.patch
-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: format-changes.patch
           path: format-changes.patch
@@ -44,12 +44,12 @@
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+        uses: actions/checkout@...2955... # v5.0.1
+      - uses: lukka/get-cmake@...2957... # v4.1.2
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
+          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -77,13 +77,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
 
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - uses: lukka/get-cmake@...2957... # v4.1.2
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
+          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -93,7 +93,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -101,7 +101,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -120,9 +120,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2928... # v5.0.0
+        uses: actions/download-artifact@...2958... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -164,7 +164,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -194,7 +194,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -212,7 +212,7 @@
       matrix:
         ssllib: [openssl@...2560..., openssl@...1554..., libressl]
         build: [normal, asan]
-        os: [macos-13, macos-14, macos-15]
+        os: [macos-14, macos-15]
         include:
           - build: asan
             cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
@@ -234,7 +234,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -266,8 +266,8 @@
 
       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@...2926... # v5.0.0
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - uses: actions/checkout@...2955... # v5.0.1
+      - uses: lukka/get-cmake@...2957... # v4.1.2
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -275,7 +275,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 9c5c2a0ab75aff5bcd08142525f6ff7f6f7ddeee
+          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -294,7 +294,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@...2868... # v4.6.2
+      - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -334,12 +334,12 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
         with:
           path: libressl
           # versioning=semver-coerced
           repository: libressl/portable
-          ref: v4.1.0
+          ref: v4.2.1
       - name: "libressl: autogen.sh"
         env:
           LIBRESSL_GIT_OPTIONS: "--no-single-branch"
@@ -357,7 +357,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -398,13 +398,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
         with:
           path: mbedtls
           submodules: true
           # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.4
+          ref: v3.6.5
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=1
         working-directory: mbedtls
@@ -412,7 +412,7 @@
         run: sudo make install DESTDIR=/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -457,13 +457,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
         with:
           path: aws-lc
           # versioning=semver-coerced
           repository: aws/aws-lc
-          ref: v1.61.3
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+          ref: v1.64.0
+      - uses: lukka/get-cmake@...2957... # v4.1.2
       - name: "AWS-LC: build"
         run: |
           mkdir build
@@ -472,7 +472,7 @@
           ninja install
         working-directory: aws-lc
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure with AWS-LC
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index e90aa2e..fa18115 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2929... # v4.2.4
+        uses: actions/cache/restore@...2959... # v4.3.0
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2926... # v5.0.0
+        uses: actions/checkout@...2955... # v5.0.1
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...2929... # v4.2.4
+        uses: actions/cache/save@...2959... # v4.3.0
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index eaa7e4c..0828dd0 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner == 'openvpn' || github.event_name == 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@...2926... # v5.0.0
+      - uses: actions/checkout@...2955... # v5.0.1
         with:
           path: openvpn
 

