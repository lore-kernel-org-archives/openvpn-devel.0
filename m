From: Gert Doering <gert@...1296...>
Date: Mon, 26 Jan 2026 16:11:16 +0100
Message-ID: <20260126151122.588-1-gert@...1296...>
In-Reply-To: <gerrit.1769435786000.If61a91b4580864fd22162c94467ba3dda2045b7b@...2715...>
References: <gerrit.1769435786000.If61a91b4580864fd22162c94467ba3dda2045b7b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GHA: Run openvpnserv UT for MinGW builds
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

Should have been added in commit
b10ee38ccde5f155d02fcd3e8f1b1ab454826ab0.

Note that test_openvpnserv.exe lives in a
separate directory, so we need to make the
code a bit more flexible.

Change-Id: If61a91b4580864fd22162c94467ba3dda2045b7b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1487
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1487
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ef9b3f5..5f5d624 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -100,13 +100,13 @@
           path: |
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.exe
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.dll
-            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe
+            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/test_*.exe
 
       - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/test_*.exe
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/*.dll
 
   mingw-unittest:
@@ -115,7 +115,7 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, openvpnserv, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
         build: [Release, Debug]
 
     runs-on: windows-2025
@@ -129,7 +129,9 @@
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
       - name: Run ${{ matrix.test }} unit test
-        run: ./unittests/test_${{ matrix.test }}.exe
+        run: |
+          $test_file=(Get-ChildItem -Path unittests -Filter test_${{ matrix.test }}.exe -Recurse).fullname
+          & $test_file
         env:
           srcdir: "${{ github.workspace }}/tests/unit_tests/openvpn"
 

