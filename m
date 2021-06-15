From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 15 Jun 2021 15:56:16 +0300
Message-Id: <20210615125616.344-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] GitHub actions: add MSVC build
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 410d6e1d..5d7dd37b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -181,3 +181,49 @@ jobs:
         run: make -j4
       - name: make check
         run: make check
+
+  msvc:
+      strategy:
+        matrix:
+          plat: [ARM64, Win32, x64]
+          include:
+            - plat: ARM64
+              triplet: arm64
+            - plat: Win32
+              triplet: x86
+            - plat: x64
+              triplet: x64
+
+      env:
+        BUILD_CONFIGURATION: Release
+        VCPKG_OVERLAY_PORTS: ${{ github.workspace }}/contrib/vcpkg-ports
+        VCPKG_OVERLAY_TRIPLETS: ${{ github.workspace }}/contrib/vcpkg-triplets
+
+      runs-on: windows-latest
+      steps:
+      - uses: actions/checkout@...2620...
+
+      - name: Add MSBuild to PATH
+        uses: microsoft/setup-msbuild@...2621...
+
+      - name: Restore artifacts, or run vcpkg, build and cache artifacts
+        uses: lukka/run-vcpkg@...2622...
+        with:
+          vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
+          vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
+          vcpkgGitCommitId: '7d472dd25830da92108eb76642c667aaa40512cb'
+          cleanAfterBuild: false
+
+      - name: Build
+        working-directory: ${{env.GITHUB_WORKSPACE}}
+        run: |
+          vcpkg integrate install
+          msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
+
+      - name: Archive artifacts
+        uses: actions/upload-artifact@...2620...
+        with:
+          name: artifacts-${{ matrix.plat }}
+          path: |
+            ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.exe
+            ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll
-- 
2.23.0.windows.1


