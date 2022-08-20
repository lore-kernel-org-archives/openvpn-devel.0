From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 20 Aug 2022 14:27:55 +0300
Message-Id: <20220820112755.285-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] vcpkg: bump baseline version
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

This allows us to use newer versions of
dependencies, such as openssl 3.0.2 -> 3.0.5.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 2 +-
 src/openvpn/vcpkg.json       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 49b7d6d1..f42469af 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -335,7 +335,7 @@ jobs:
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2637...
         with:
-          vcpkgGitCommitId: '4b766c1cd17205e1b768c4fadfd5f867c1d0510e'
+          vcpkgGitCommitId: '9259a0719d94c402aae2ab7975bc096afdec15df'
           appendedCacheKey: '${{matrix.triplet}}'
 
       - name: Run MSBuild consuming vcpkg.json
diff --git a/src/openvpn/vcpkg.json b/src/openvpn/vcpkg.json
index 5489d146..40db1fd2 100644
--- a/src/openvpn/vcpkg.json
+++ b/src/openvpn/vcpkg.json
@@ -9,5 +9,5 @@
     "lz4",
     "pkcs11-helper"
   ],
-  "builtin-baseline": "4b766c1cd17205e1b768c4fadfd5f867c1d0510e"
+  "builtin-baseline": "9259a0719d94c402aae2ab7975bc096afdec15df"
 }
-- 
2.23.0.windows.1


