From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 22 Jul 2025 12:27:18 +0200
Message-Id: <20250722102718.85403-1-frank@...2641...>
In-Reply-To: <gerrit.1752061618000.I6122225cc12c4f299a2a48db24bc7379ac6c5921@...2715...>
References: <gerrit.1752061618000.I6122225cc12c4f299a2a48db24bc7379ac6c5921@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] GHA: Dependency updates July 2025
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

chore(deps): update dependency aws/aws-lc to v1.55.0
chore(deps): update lukka/get-cmake action to v4.0.3
chore(deps): update vcpkg digest to f33cc49
chore(deps): update dependency mbed-tls/mbedtls to v3.6.4

Change-Id: I6122225cc12c4f299a2a48db24bc7379ac6c5921
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1079
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d4fdc9d..bd5895b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,11 +54,11 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2893... # v4.0.1
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -88,11 +88,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
 
-      - uses: lukka/get-cmake@...2893... # v4.0.1
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -276,7 +276,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2893... # v4.0.1
+      - uses: lukka/get-cmake@...2897... # v4.0.3
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -284,7 +284,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
+          vcpkgGitCommitId: f33cc491c85a7d643c5ab6da1667c1458e6d7abf
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -413,7 +413,7 @@
           submodules: true
           # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.3
+          ref: v3.6.4
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=1
         working-directory: mbedtls
@@ -471,8 +471,8 @@
           path: aws-lc
           # versioning=semver-coerced
           repository: aws/aws-lc
-          ref: v1.51.2
-      - uses: lukka/get-cmake@...2893... # v4.0.1
+          ref: v1.55.0
+      - uses: lukka/get-cmake@...2897... # v4.0.3
       - name: "AWS-LC: build"
         run: |
           mkdir build

