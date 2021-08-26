From: Ilya Shipitsin <chipitsine@...277...>
Date: Thu, 26 Aug 2021 15:02:21 +0500
Message-Id: <20210826100221.1378-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] CI: github actions: keep "pdb" in artifacts
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

"pdb" files are important for example, for BinSkim analysis. Let us
keep them
---
 .github/workflows/build.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b2c16449..4c963114 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -227,3 +227,4 @@ jobs:
           path: |
             ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.exe
             ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll
+            ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.pdb
\ No newline at end of file
-- 
2.29.2.windows.2


