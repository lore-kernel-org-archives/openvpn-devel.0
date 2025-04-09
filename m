From: Gert Doering <gert@...1296...>
Date: Wed,  9 Apr 2025 15:11:42 +0200
Message-ID: <20250409131148.18147-1-gert@...1296...>
In-Reply-To: <gerrit.1744115087000.Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd@...2715...>
References: <gerrit.1744115087000.Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Use CMake 4.0 and apply required
 fixes
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

- update vcpkg reference to 856505bb76
  This includes a general work-around for the CMake 4.0
  compat. See commit
  a1aebfa9d5eae7cf493e0a706b43915d687bb860.
- update lukka/get-cmake action to v4
- update dependency aws/aws-lc to v1.49.1

Change-Id: Ibabb4aa80d7786614dbd6b76bd4cd096f217acfd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/934
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 2df495c..0f5e617 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,11 +54,11 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2881... # v4.0.0
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -88,11 +88,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
 
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2881... # v4.0.0
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -276,7 +276,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+      - uses: lukka/get-cmake@...2881... # v4.0.0
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -284,7 +284,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
+          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -471,8 +471,8 @@
           path: aws-lc
           # versioning=semver-coerced
           repository: aws/aws-lc
-          ref: v1.42.0
-      - uses: lukka/get-cmake@...2870... # v3.31.6
+          ref: v1.49.1
+      - uses: lukka/get-cmake@...2881... # v4.0.0
       - name: "AWS-LC: build"
         run: |
           mkdir build

