From: Gert Doering <gert@...1296...>
Date: Sun, 18 May 2025 17:37:18 +0200
Message-ID: <20250518153724.8099-1-gert@...1296...>
In-Reply-To: <gerrit.1746807825000.I515f96c99f92ba144b60e8504cee74915de3efa3@...2715...>
References: <gerrit.1746807825000.I515f96c99f92ba144b60e8504cee74915de3efa3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Dependency and Actions update May
 2025
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

From: OpenVPN Renovate <pkg@...515...>

chore(deps): update dependency aws/aws-lc to v1.51.2
chore(deps): update github actions
chore(deps): update dependency libressl/portable to v4.1.0
chore(config): migrate config renovate.json
chore(deps): update vcpkg digest to b12aa38

Change-Id: I515f96c99f92ba144b60e8504cee74915de3efa3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1001
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 0f5e617..d4fdc9d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -54,11 +54,11 @@
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2881... # v4.0.0
+      - uses: lukka/get-cmake@...2893... # v4.0.1
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
+          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -88,11 +88,11 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
 
-      - uses: lukka/get-cmake@...2881... # v4.0.0
+      - uses: lukka/get-cmake@...2893... # v4.0.1
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
+          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -131,7 +131,7 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2869... # v4.2.1
+        uses: actions/download-artifact@...2894... # v4.3.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -276,7 +276,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2881... # v4.0.0
+      - uses: lukka/get-cmake@...2893... # v4.0.1
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -284,7 +284,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 856505bb767458c99d8e3c3ed441f59a058d3687
+          vcpkgGitCommitId: b12aa38a44a29bd8461404f2514e4c7cf00e1fc5
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -348,7 +348,7 @@
           path: libressl
           # versioning=semver-coerced
           repository: libressl/portable
-          ref: v4.0.0
+          ref: v4.1.0
       - name: "libressl: autogen.sh"
         env:
           LIBRESSL_GIT_OPTIONS: "--no-single-branch"
@@ -471,8 +471,8 @@
           path: aws-lc
           # versioning=semver-coerced
           repository: aws/aws-lc
-          ref: v1.49.1
-      - uses: lukka/get-cmake@...2881... # v4.0.0
+          ref: v1.51.2
+      - uses: lukka/get-cmake@...2893... # v4.0.1
       - name: "AWS-LC: build"
         run: |
           mkdir build
diff --git a/renovate.json b/renovate.json
index 1e69955..d0f319d 100644
--- a/renovate.json
+++ b/renovate.json
@@ -23,8 +23,12 @@
     "customManagers": [
         {
             "customType": "regex",
-            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
-            "matchStrings": ["vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\n"],
+            "managerFilePatterns": [
+                "/^\\.github/workflows/.+\\.ya?ml$/"
+            ],
+            "matchStrings": [
+                "vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\n"
+            ],
             "currentValueTemplate": "master",
             "depNameTemplate": "vcpkg",
             "packageNameTemplate": "https://github.com/microsoft/vcpkg",
@@ -32,8 +36,12 @@
         },
         {
             "customType": "regex",
-            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
-            "matchStrings": ["versioning=(?<versioning>.*?)\\n\\s*repository:\\s*(?<depName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"],
+            "managerFilePatterns": [
+                "/^\\.github/workflows/.+\\.ya?ml$/"
+            ],
+            "matchStrings": [
+                "versioning=(?<versioning>.*?)\\n\\s*repository:\\s*(?<depName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"
+            ],
             "datasourceTemplate": "github-tags"
         }
     ]

