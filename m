From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 16 Oct 2021 00:31:15 +0300
Message-Id: <20211015213115.516-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] GitHub Actions: use latest working
 lukka/run-vcpkg
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

Latest lukka/run-vcpkg@...2637... seem to break non-manifest
mode with custom triplets, so revert to latest working version.

While on it, bump vcpkg commit.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 514ae66b..abf32b14 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -215,11 +215,11 @@ jobs:
         run: python -m pip install --upgrade pip rst2html
 
       - name: Restore artifacts, or run vcpkg, build and cache artifacts
-        uses: lukka/run-vcpkg@...2622...
+        uses: lukka/run-vcpkg@...2638...
         with:
+          vcpkgGitCommitId: '71422c627264daedcbcd46f01f1ed0dcd8460f1b'
           vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
           vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
-          vcpkgGitCommitId: '261c458af6e3eed5d099144aff95d2b5035f656b'
           cleanAfterBuild: false
 
       - name: Build
-- 
2.23.0.windows.1


