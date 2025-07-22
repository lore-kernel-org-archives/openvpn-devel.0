From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 22 Jul 2025 12:28:10 +0200
Message-Id: <20250722102810.85915-1-frank@...2641...>
In-Reply-To: <gerrit.1752061641000.I46177b0614ad8b167a421c50d3cc8e7da4054e42@...2715...>
References: <gerrit.1752061641000.I46177b0614ad8b167a421c50d3cc8e7da4054e42@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GHA: Update dependencies July 2025 (2.6)
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
Cc: Yuriy Darnobyt <yura.uddr@...277...>

Pin dependencies
chore(deps): update lukka/get-cmake action to v4
chore(deps): update vcpkg digest to f33cc49

Change-Id: I46177b0614ad8b167a421c50d3cc8e7da4054e42
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1080
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 22b7aca..65d5fd4 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -51,11 +51,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
 
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -92,7 +92,7 @@
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2869... # v4.2.1
+        uses: actions/download-artifact@...2894... # v4.3.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -227,7 +227,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2897... # v4.0.3
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -235,7 +235,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index 7998632d6..1a9e5a3 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -25,7 +25,7 @@
 
       - name: Checkout OpenVPN
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2691...
+        uses: actions/checkout@...2844... # v4
 
       - name: Download Coverity Build Tool
         if: steps.check_submit.outputs.cache-hit != 'true'

