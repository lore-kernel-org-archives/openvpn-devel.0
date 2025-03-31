From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 31 Mar 2025 17:33:09 +0200
Message-Id: <20250331153309.77901-1-frank@...2641...>
In-Reply-To: <gerrit.1743422979000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
References: <gerrit.1743422979000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Dependency and Actions update April
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

- Fix Android build with newer vcpkg
  Need to sync CMAKE_SYSTEM_VERSION with vcpkg.
- Update mbedTLS v3 builds to latest release.
  Depends on commit
  4897c522948c8cdb82c0325ee08f6907cfc16f57
- Update all actions to latest releases.

Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/926
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b1af7ec..3fc44f5 100644
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
@@ -57,11 +57,16 @@
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
-        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=yes -DCMAKE_SYSTEM_NAME=Android -DOPENSSL_ROOT_DIR=${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} -DENABLE_PKCS11=false -DBUILD_TESTING=true -DCMAKE_ANDROID_ARCH_ABI=${{ matrix.abi }} -DENABLE_LZO=false -DUSE_WERROR=no
+        run: |
+          cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=yes \
+            -DCMAKE_SYSTEM_NAME=Android -DCMAKE_SYSTEM_VERSION=28 \
+            -DCMAKE_ANDROID_ARCH_ABI=${{ matrix.abi }} \
+            -DOPENSSL_ROOT_DIR=${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} \
+            -DENABLE_PKCS11=false -DBUILD_TESTING=true -DENABLE_LZO=false -DUSE_WERROR=no
       - name: Build OpenVPN Android binary with cmake
         run: cmake --build openvpn-build
 
@@ -85,7 +90,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -95,7 +100,7 @@
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config Debug']"
 
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
@@ -103,7 +108,7 @@
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: |
@@ -124,7 +129,7 @@
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
       - name: Retrieve mingw unittest
-        uses: actions/download-artifact@...2817... # v4.1.8
+        uses: actions/download-artifact@...2869... # v4.2.1
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
@@ -269,7 +274,7 @@
       runs-on: windows-latest
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
-      - uses: lukka/get-cmake@...2861... # v3.31.5
+      - uses: lukka/get-cmake@...2870... # v3.31.6
 
       - name: Install rst2html
         run: python -m pip install --upgrade pip docutils
@@ -277,7 +282,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+          vcpkgGitCommitId: acd5bba5aac8b6573b5f6f463dc0341ac0ee6fa4
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
@@ -296,7 +301,7 @@
           testPreset: win-${{ matrix.arch }}-release
           testPresetAdditionalArgs: "['--output-on-failure']"
 
-      - uses: actions/upload-artifact@...2860... # v4.6.0
+      - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
           name: openvpn-msvc-${{ matrix.arch }}
           path: |
@@ -406,7 +411,7 @@
           submodules: true
           # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.2
+          ref: v3.6.3
       - name: "mbedtls: make no_test"
         run: make -j3 no_test SHARED=1
         working-directory: mbedtls
diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
index 3381d8f..222c57e 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -13,7 +13,7 @@
     steps:
       - name: Check submission cache
         id: check_submit
-        uses: actions/cache/restore@...2847... # v4.2.0
+        uses: actions/cache/restore@...2871... # v4.2.3
         with:
           path: |
             cov-int
@@ -65,7 +65,7 @@
 
       - name: Cache submission
         if: steps.check_submit.outputs.cache-hit != 'true'
-        uses: actions/cache/save@...2847... # v4.2.0
+        uses: actions/cache/save@...2871... # v4.2.3
         with:
           path: |
             cov-int
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index f1ece70..ffd1b82 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -34,7 +34,7 @@
           touch doc/doxygen/html/.nojekyll
       - name: Upload static files as artifact
         id: deployment
-        uses: actions/upload-pages-artifact@...2858...
+        uses: actions/upload-pages-artifact@...2872... # v3.0.1
         with:
           path: doxygen/doc/doxygen/html/
 
@@ -50,4 +50,4 @@
     steps:
       - name: Deploy to GitHub Pages
         id: deployment
-        uses: actions/deploy-pages@...2859...
+        uses: actions/deploy-pages@...2873... # v4.0.5

