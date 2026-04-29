From: Gert Doering <gert@...1296...>
Date: Wed, 29 Apr 2026 11:39:51 +0200
Message-ID: <20260429093957.23705-1-gert@...1296...>
In-Reply-To: <gerrit.1777390515000.I43851d96c28af0ebcf0c6beab21659e68919d0c6@...2715...>
References: <gerrit.1777390515000.I43851d96c28af0ebcf0c6beab21659e68919d0c6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Maintenance Update April 2026
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

- Updates GHA actions
- Switch clang-format job to archive: false supported
  in new actions/upload-artifact version. This way the
  file is not encapsulated in a zip
- Drop macos-14 builds. This runner is considered
  deprecated and will be removed later this year.

Change-Id: I43851d96c28af0ebcf0c6beab21659e68919d0c6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1641
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1641
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e4cb799..895f469 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -19,9 +19,9 @@
         run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
         run: git diff --output=format-changes.patch
-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
-          name: format-changes.patch
+          archive: false
           path: format-changes.patch
       - name: Set job status
         run: test ! -s format-changes.patch
@@ -45,9 +45,9 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
-      - uses: lukka/get-cmake@...2999... # v4.2.3
+      - uses: lukka/get-cmake@...3028... # v4.3.2
       - name: Install vcpkg
-        uses: lukka/run-vcpkg@...2815... # v11.5
+        uses: lukka/run-vcpkg@...3029... # v11.6
         with:
           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
       - name: Install dependencies
@@ -80,21 +80,21 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
 
-      - uses: lukka/get-cmake@...2999... # v4.2.3
+      - uses: lukka/get-cmake@...3028... # v4.3.2
       - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@...2815... # v11.5
+        uses: lukka/run-vcpkg@...3029... # v11.6
         with:
           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2816... # v10.8
+        uses: lukka/run-cmake@...3030... # v10.9
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config ${{ matrix.build }}']"
 
-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}
           path: |
@@ -102,7 +102,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/test_*.exe
 
-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
@@ -124,7 +124,7 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2980... # v7.0.0
+        uses: actions/download-artifact@...3032... # v8.0.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
@@ -211,7 +211,7 @@
       matrix:
         ssllib: [openssl@...1554..., libressl]
         build: [normal, asan]
-        os: [macos-14, macos-15, macos-26]
+        os: [macos-15, macos-26]
         include:
           - build: asan
             cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
@@ -266,26 +266,26 @@
       runs-on: windows-2025
       steps:
       - uses: actions/checkout@...2998... # v6.0.2
-      - uses: lukka/get-cmake@...2999... # v4.2.3
+      - uses: lukka/get-cmake@...3028... # v4.3.2
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
 
       - name: Restore artifacts, or setup vcpkg (do not install any package)
-        uses: lukka/run-vcpkg@...2815... # v11.5
+        uses: lukka/run-vcpkg@...3029... # v11.6
         with:
           vcpkgGitCommitId: e5a1490e1409d175932ef6014519e9ae149ddb7c
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
-        uses: lukka/run-cmake@...2816... # v10.8
+        uses: lukka/run-cmake@...3030... # v10.9
         if: ${{ matrix.arch == 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
 
       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2816... # v10.8
+        uses: lukka/run-cmake@...3030... # v10.9
         if: ${{ matrix.arch != 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
@@ -293,7 +293,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@...2978... # v6.0.0
+      - uses: actions/upload-artifact@...3031... # v7.0.1
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index 5554c4d..1eec1ed 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...3000... # v5.0.3
+        uses: actions/cache/restore@...3024... # v5.0.5
         with:
           path: |
             cov-int
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...3000... # v5.0.3
+        uses: actions/cache/save@...3024... # v5.0.5
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index b28dd70..30988b5 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -35,7 +35,7 @@
           touch doc/doxygen/html/.nojekyll
       - name: Upload static files as artifact
         id: deployment
-        uses: actions/upload-pages-artifact@...2930... # v4.0.0
+        uses: actions/upload-pages-artifact@...3033... # v5
         with:
           path: doxygen/doc/doxygen/html/
 
@@ -51,4 +51,4 @@
     steps:
       - name: Deploy to GitHub Pages
         id: deployment
-        uses: actions/deploy-pages@...2873... # v4.0.5
+        uses: actions/deploy-pages@...3034... # v5

