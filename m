From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  6 Sep 2024 17:12:43 +0200
Message-Id: <20240906151243.69549-1-frank@...2641...>
In-Reply-To: <gerrit.1723151372000.I06253be7ed783e3bf30e7df1d6da8ca888016711@...2715...>
References: <gerrit.1723151372000.I06253be7ed783e3bf30e7df1d6da8ca888016711@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Configure Renovate
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
Cc: OpenVPN Renovate <pkg@...515...>, Yuriy Darnobyt <yura.uddr@...277...>

From: OpenVPN Renovate <pkg@...515...>

Maintain GitHub actions and other version references
in GHA.

Switch some GHA references from branch versions to
tag version so the pinning works correctly.

Change-Id: I06253be7ed783e3bf30e7df1d6da8ca888016711
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/722
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 6e361d5..6207c95 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -52,13 +52,13 @@
         uses: actions/checkout@...2691...
 
       - name: Restore from cache and install vcpkg
-        uses: lukka/run-vcpkg@...2735...
+        uses: lukka/run-vcpkg@...2807...
         with:
           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2808...
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
@@ -274,26 +274,26 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2691...
-      - uses: lukka/get-cmake@...2729...
+      - uses: lukka/get-cmake@...2809...
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
 
       - name: Restore artifacts, or setup vcpkg (do not install any package)
-        uses: lukka/run-vcpkg@...2735...
+        uses: lukka/run-vcpkg@...2807...
         with:
           vcpkgGitCommitId: 8d3649ba34aab36914ddd897958599aa0a91b08e
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2808...
         if: ${{ matrix.arch == 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
 
       - name: Run CMake with vcpkg.json manifest
-        uses: lukka/run-cmake@...2637...
+        uses: lukka/run-cmake@...2808...
         if: ${{ matrix.arch != 'arm64' }}
         with:
           configurePreset: win-${{ matrix.arch }}-release
@@ -344,6 +344,7 @@
         uses: actions/checkout@...2691...
         with:
           path: libressl
+          # versioning=semver-coerced
           repository: libressl/portable
           ref: v3.8.3
       - name: "libressl: autogen.sh"
@@ -403,6 +404,7 @@
         uses: actions/checkout@...2691...
         with:
           path: mbedtls
+          # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
           ref: v3.5.2
       - name: "mbedtls: make no_test"
diff --git a/renovate.json b/renovate.json
new file mode 100644
index 0000000..1e69955
--- /dev/null
+++ b/renovate.json
@@ -0,0 +1,40 @@
+{
+    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
+    "packageRules": [
+        {
+            "matchDepTypes": [
+                "action"
+            ],
+            "groupName": "github actions",
+            "pinDigests": true,
+            "extends": [
+                "schedule:monthly"
+            ]
+        },
+        {
+            "matchDepNames": [
+                "vcpkg"
+            ],
+            "extends": [
+                "schedule:monthly"
+            ]
+        }
+    ],
+    "customManagers": [
+        {
+            "customType": "regex",
+            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
+            "matchStrings": ["vcpkgGitCommitId:\\s*(?<currentDigest>.*?)\\n"],
+            "currentValueTemplate": "master",
+            "depNameTemplate": "vcpkg",
+            "packageNameTemplate": "https://github.com/microsoft/vcpkg",
+            "datasourceTemplate": "git-refs"
+        },
+        {
+            "customType": "regex",
+            "fileMatch": ["^\\.github/workflows/.+\\.ya?ml$"],
+            "matchStrings": ["versioning=(?<versioning>.*?)\\n\\s*repository:\\s*(?<depName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"],
+            "datasourceTemplate": "github-tags"
+        }
+    ]
+}

