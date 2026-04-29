From: Gert Doering <gert@...1296...>
Date: Wed, 29 Apr 2026 11:39:33 +0200
Message-ID: <20260429093938.23601-1-gert@...1296...>
In-Reply-To: <gerrit.1777390515000.I933227aa4bc4f05b58d0e754b4330da807504d01@...2715...>
References: <gerrit.1777390515000.I933227aa4bc4f05b58d0e754b4330da807504d01@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Add caching for vcpkg builds
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

The nice automatic caching was removed last year,
so go back to manual caching of the binary cache
dir.

While here, also update vcpkg to latest master.

Change-Id: I933227aa4bc4f05b58d0e754b4330da807504d01
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1642
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1642
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 895f469..b530fcc 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -42,14 +42,23 @@
       VCPKG_DEFAULT_TRIPLET: ${{ matrix.vcpkg_triplet }}
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
       VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
+      VCPKG_BINARY_SOURCES: clear;default,readwrite
+      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
       - uses: lukka/get-cmake@...3028... # v4.3.2
-      - name: Install vcpkg
+      - name: Setup vcpkg
         uses: lukka/run-vcpkg@...3029... # v11.6
         with:
-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
+      - name: Set up vcpkg binary cache
+        uses: actions/cache@...3024... # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: android-${{ matrix.abi }}-vcpkg-binary-cache-${{ env.VCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+            android-${{ matrix.abi }}-vcpkg-binary-cache-
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -70,10 +79,12 @@
         arch: [x86, x64]
         build: [Release, Debug]
 
-    name: "gcc-mingw - ${{ matrix.arch }} - ${{matrix.build }} - OSSL"
+    name: "gcc-mingw - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     runs-on: ubuntu-24.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
+      VCPKG_BINARY_SOURCES: clear;default,readwrite
+      VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 unzip build-essential wget python3-docutils man2html-base
@@ -81,12 +92,21 @@
         uses: actions/checkout@...2998... # v6.0.2
 
       - uses: lukka/get-cmake@...3028... # v4.3.2
-      - name: Restore from cache and install vcpkg
+      - name: Setup vcpkg
         uses: lukka/run-vcpkg@...3029... # v11.6
         with:
-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
+      - name: Set up vcpkg binary cache
+        uses: actions/cache@...3024... # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/mingw/vcpkg.json') }}-
+            mingw-${{ matrix.arch }}-vcpkg-binary-cache-
+
       - name: Run CMake with vcpkg.json manifest
         uses: lukka/run-cmake@...3030... # v10.9
         with:
@@ -262,6 +282,8 @@
       name: "msbuild - ${{ matrix.arch }} - openssl"
       env:
         BUILD_CONFIGURATION: Release
+        VCPKG_BINARY_SOURCES: clear;default,readwrite
+        VCPKG_GIT_COMMIT_ID: 031f4afe03be385aee354f15be6e6b1fe57497c7
 
       runs-on: windows-2025
       steps:
@@ -271,12 +293,22 @@
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
 
-      - name: Restore artifacts, or setup vcpkg (do not install any package)
+      - name: Setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...3029... # v11.6
         with:
-          vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
+          vcpkgGitCommitId: ${{ env.VCPKG_GIT_COMMIT_ID }}
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
+      - name: Set up vcpkg binary cache
+        uses: actions/cache@...3024... # v5.0.5
+        with:
+          path: ${{ env.VCPKG_DEFAULT_BINARY_CACHE }}
+          key: msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg.json') }}-${{ env.VCPKG_GIT_COMMIT_ID }}
+          restore-keys: |
+            msvc-${{ matrix.arch }}-vcpkg-binary-cache-${{ hashFiles('**/windows/vcpkg.json') }}-
+            msvc-${{ matrix.arch }}-vcpkg-binary-cache-
+
+
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
         uses: lukka/run-cmake@...3030... # v10.9
         if: ${{ matrix.arch == 'arm64' }}
diff --git a/renovate.json b/renovate.json
index 809ac3f..3bd0917 100644
--- a/renovate.json
+++ b/renovate.json
@@ -27,7 +27,7 @@
                 "/^\\.github/workflows/.+\\.ya?ml$/"
             ],
             "matchStrings": [
-                "vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\n"
+                "VCPKG_GIT_COMMIT_ID:\\s*(?<currentDigest>.*?)\\n"
             ],
             "currentValueTemplate": "master",
             "depNameTemplate": "vcpkg",

