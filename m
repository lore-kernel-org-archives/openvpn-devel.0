From: Gert Doering <gert@...1296...>
Date: Mon,  2 Mar 2026 16:25:04 +0100
Message-ID: <20260302152510.11918-1-gert@...1296...>
In-Reply-To: <gerrit.1771348259000.I4536e06b082ae17baba1490246244b5923063c93@...2715...>
References: <gerrit.1771348259000.I4536e06b082ae17baba1490246244b5923063c93@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Maintenance update February 2026
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

Switch libressl and mbedTLS 4 builds to Ubuntu 24.04.

Includes the following renovate changes:
- chore(deps): update dependency aws/aws-lc to v1.67.0
- chore(deps): update github actions
- chore(deps): update vcpkg digest to e5a1490

Change-Id: I4536e06b082ae17baba1490246244b5923063c93
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1540
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1540
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 7d1574c..b213192 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -14,7 +14,7 @@
           sudo apt update && sudo apt install -y python3-pip
           pip3 install pre-commit
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: Run clang-format
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
@@ -44,12 +44,12 @@
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
-      - uses: lukka/get-cmake@...2979... # v4.2.1
+        uses: actions/checkout@...2998... # v6.0.2
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
+          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -78,13 +78,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
 
-      - uses: lukka/get-cmake@...2979... # v4.2.1
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
+          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -122,7 +122,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2980... # v7.0.0
         with:
@@ -163,7 +163,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${PKCS11PKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -193,7 +193,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -233,7 +233,7 @@
       - name: Install dependencies
         run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: Set environment
         run: |
           cat >>$GITHUB_ENV <<EOF;
@@ -265,8 +265,8 @@
 
       runs-on: windows-2025
       steps:
-      - uses: actions/checkout@...2977... # v6.0.1
-      - uses: lukka/get-cmake@...2979... # v4.2.1
+      - uses: actions/checkout@...2998... # v6.0.2
+      - uses: lukka/get-cmake@...2999... # v4.2.3
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -274,7 +274,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
+          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -307,7 +307,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-22.04]
+        os: [ubuntu-24.04]
         ssllib: [libressl]
         build: [ normal, asan ]
         configureflags: ["--with-openssl-engine=no"]
@@ -333,7 +333,7 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "libressl: checkout"
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
         with:
           path: libressl
           # versioning=semver-coerced
@@ -356,7 +356,7 @@
       - name: "ldconfig"
         run: sudo ldconfig
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -372,7 +372,7 @@
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-22.04]
+        os: [ubuntu-24.04]
         ssllib: [mbedtls4]
         build: [ normal, asan ]
         include:
@@ -397,14 +397,14 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "mbedtls: checkout"
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
         with:
           path: mbedtls
           submodules: recursive
           # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
           ref: v4.0.0
-      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "mbedtls: cmake"
         run: cmake -B build
         working-directory: mbedtls
@@ -415,7 +415,7 @@
         run: sudo cmake --install build --prefix /usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -460,13 +460,13 @@
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
       - name: "AWS-LC: checkout"
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
         with:
           path: aws-lc
           # versioning=semver-coerced
           repository: aws/aws-lc
-          ref: v1.66.2
-      - uses: lukka/get-cmake@...2979... # v4.2.1
+          ref: v1.67.0
+      - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
         run: |
           mkdir build
@@ -475,7 +475,7 @@
           ninja install
         working-directory: aws-lc
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
       - name: autoconf
         run: autoreconf -fvi
       - name: configure with AWS-LC
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index f329482..5554c4d 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2981... # v5.0.1
+        uses: actions/cache/restore@...3000... # v5.0.3
         with:
           path: |
             cov-int
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2977... # v6.0.1
+        uses: actions/checkout@...2998... # v6.0.2
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...2981... # v5.0.1
+        uses: actions/cache/save@...3000... # v5.0.3
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index b510dc8..b28dd70 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -11,7 +11,7 @@
     runs-on: ubuntu-24.04
     if: ${{ github.repository_owner == 'openvpn' || github.event_name == 'workflow_dispatch' }}
     steps:
-      - uses: actions/checkout@...2977... # v6.0.1
+      - uses: actions/checkout@...2998... # v6.0.2
         with:
           path: openvpn
 

