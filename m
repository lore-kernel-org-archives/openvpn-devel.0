From: Gert Doering <gert@...1296...>
Date: Wed,  7 Jan 2026 18:33:56 +0100
Message-ID: <20260107173402.5614-1-gert@...1296...>
In-Reply-To: <gerrit.1767796244000.I637cc37f82d96a7d15738cc39523664777714e97@...2715...>
References: <gerrit.1767796244000.I637cc37f82d96a7d15738cc39523664777714e97@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Maintenance update January 2026
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
- chore(deps): update dependency aws/aws-lc to v1.66.2
- Update lukka/get-cmake action to v4.2.1
- chore(deps): update github actions
- chore(deps): update vcpkg digest to eeb00f1

Change-Id: I637cc37f82d96a7d15738cc39523664777714e97
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1455
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1455
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 11c2d65..d1322c7 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,12 +14,12 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
         run: git diff --output=format-changes.patch
-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: format-changes.patch
           path: format-changes.patch
@@ -44,12 +44,12 @@
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
-      - uses: lukka/get-cmake@...2957... # v4.1.2
+        uses: actions/checkout@...2977... # v6.0.1
+      - uses: lukka/get-cmake@...2979... # v4.2.1
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -78,13 +78,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
 
-      - uses: lukka/get-cmake@...2957... # v4.1.2
+      - uses: lukka/get-cmake@...2979... # v4.2.1
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -94,7 +94,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config ${{ matrix.build }}']"
 
-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}
           path: |
@@ -102,7 +102,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe
 
-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
@@ -122,9 +122,9 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2958... # v6.0.0
+        uses: actions/download-artifact@...2980... # v7.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
@@ -161,7 +161,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -191,7 +191,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -231,7 +231,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -263,8 +263,8 @@
 
       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@...2955... # v5.0.1
-      - uses: lukka/get-cmake@...2957... # v4.1.2
+      - uses: actions/checkout@...2977... # v6.0.1
+      - uses: lukka/get-cmake@...2979... # v4.2.1
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -272,7 +272,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 3bbc2809d3625cb83a0d7cbd413bd6ad769d46d4
+          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -291,7 +291,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@...2956... # v5.0.0
+      - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -331,7 +331,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
         with:
           path: libressl
           # versioning=semver-coerced
@@ -354,7 +354,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -395,7 +395,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
         with:
           path: mbedtls
           submodules: true
@@ -409,7 +409,7 @@
         run: sudo make install DESTDIR=/usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -454,13 +454,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
         with:
           path: aws-lc
           # versioning=semver-coerced
           repository: aws/aws-lc
-          ref: v1.64.0
-      - uses: lukka/get-cmake@...2957... # v4.1.2
+          ref: v1.66.2
+      - uses: lukka/get-cmake@...2979... # v4.2.1
       - name: "AWS-LC: build"
         run: |
           mkdir build
@@ -469,7 +469,7 @@
           ninja install
         working-directory: aws-lc
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
       - name: autoconf
         run: autoreconf -fvi
       - name: configure with AWS-LC
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index fa18115..f329482 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2959... # v4.3.0
+        uses: actions/cache/restore@...2981... # v5.0.1
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2955... # v5.0.1
+        uses: actions/checkout@...2977... # v6.0.1
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...2959... # v4.3.0
+        uses: actions/cache/save@...2981... # v5.0.1
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index 0828dd0..b510dc8 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner == 'openvpn' || github.event_name == 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@...2955... # v5.0.1
+      - uses: actions/checkout@...2977... # v6.0.1
         with:
           path: openvpn
 

