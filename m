From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 17:44:01 +0200
Message-ID: <20250402154409.12205-1-gert@...1296...>
In-Reply-To: <gerrit.1743589873000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
References: <gerrit.1743589873000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Dependency and Actions update April
 2025 (2.6)
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

- Update all actions to latest releases.
- Update vcpkg commit to latest master.

Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250331153309.77901-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31290.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
(cherry picked from commit 0ffa7b57fdfb2658ae326baea0871ccca2c01b7d)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/931
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 37ac6ec..22b7aca 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -27,7 +27,7 @@
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -55,7 +55,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -65,7 +65,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -73,7 +73,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -92,7 +92,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2817... # v4.1.8
+        uses: actions/download-artifact@...2869... # v4.2.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -227,7 +227,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2861... # v3.31.5
+      - uses: lukka/get-cmake@...2870... # v3.31.6
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -235,7 +235,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -254,7 +254,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index b5e1920..7998632d6 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2691...
+        uses: actions/cache/restore@...2871... # v4.2.3
         with:
           path: |
             cov-int
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...2691...
+        uses: actions/cache/save@...2871... # v4.2.3
         with:
           path: |
             cov-int

