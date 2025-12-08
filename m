From: Gert Doering <gert@...1296...>
Date: Mon,  8 Dec 2025 18:09:32 +0100
Message-ID: <20251208170937.5221-1-gert@...1296...>
In-Reply-To: <gerrit.1765212547000.I9e1d935f617db9198ed5934b88c0fcdef61a8568@...2715...>
References: <gerrit.1765212547000.I9e1d935f617db9198ed5934b88c0fcdef61a8568@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Add minGW Release build
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

There are sometimes differences in the build results.

Change-Id: I9e1d935f617db9198ed5934b88c0fcdef61a8568
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1421
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1421
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ea45740..ce730f6 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -68,8 +68,9 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
+        build: [Release, Debug]
 
-    name: "gcc-mingw - ${{ matrix.arch }} - OSSL"
+    name: "gcc-mingw - ${{ matrix.arch }} - ${{matrix.build }} - OSSL"
     runs-on: ubuntu-24.04
     env:
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
@@ -91,22 +92,22 @@
         with:
           configurePreset: mingw-${{ matrix.arch }}
           buildPreset: mingw-${{ matrix.arch }}
-          buildPresetAdditionalArgs: "['--config Debug']"
+          buildPresetAdditionalArgs: "['--config ${{ matrix.build }}']"
 
       - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
-          name: openvpn-mingw-${{ matrix.arch }}
+          name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.exe
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.dll
-            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.dll
+            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe
 
       - uses: actions/upload-artifact@...2956... # v5.0.0
         with:
-          name: openvpn-mingw-${{ matrix.arch }}-tests
+          name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/*.dll
 
   mingw-unittest:
     needs: [ mingw ]
@@ -115,16 +116,17 @@
       matrix:
         arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
+        build: [Release, Debug]
 
     runs-on: windows-2025
-    name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
+    name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
         uses: actions/checkout@...2955... # v5.0.1
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2958... # v6.0.0
         with:
-          name: openvpn-mingw-${{ matrix.arch }}-tests
+          name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
       - name: Run ${{ matrix.test }} unit test
         run: ./unittests/test_${{ matrix.test }}.exe

