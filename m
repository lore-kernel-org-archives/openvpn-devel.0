From: Gert Doering <gert@...1296...>
Date: Thu, 18 Sep 2025 15:59:03 +0200
Message-ID: <20250918135908.14364-1-gert@...1296...>
In-Reply-To: <gerrit.1758198221000.Iaebc46f9156657128dc52c979202545be8865656@...2715...>
References: <gerrit.1758198221000.Iaebc46f9156657128dc52c979202545be8865656@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: collect more artifacts for mingw
 builds
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

From: Lev Stipakov <lev@...515...>

Collect also binaries for openvpnserv, tapctl and openvpnmsica.

Change-Id: Iaebc46f9156657128dc52c979202545be8865656
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1200
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1200
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f7883c7..a306670 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -97,8 +97,8 @@
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.exe
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_*.exe
 
       - uses: actions/upload-artifact@...2868... # v4.6.2

