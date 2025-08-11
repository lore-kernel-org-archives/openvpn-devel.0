From: Ilia Shipitsin <chipitsine@...277...>
Date: Mon, 11 Aug 2025 18:13:23 +0200
Message-ID: <20250811161323.1599-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] GHA: limit "Deploy Doxygen documentation"
 to main repo only
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

that workflow was accidently triggered in fork repo, where
there's no github pages set

Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
---
 .github/workflows/doxygen.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
index ffd1b826..751258a9 100644
--- a/.github/workflows/doxygen.yml
+++ b/.github/workflows/doxygen.yml
@@ -9,6 +9,7 @@ concurrency:
 jobs:
   build:
     runs-on: ubuntu-24.04
+    if: ${{ github.repository_owner == 'openvpn' || github.event_name == 'workflow_dispatch' }}
     steps:
       - uses: actions/checkout@...2844... # v4.2.2
         with:
-- 
2.46.0.windows.1


