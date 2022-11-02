From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  2 Nov 2022 17:15:36 +0200
Message-Id: <20221102151536.255-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] vcpkg: use the latest versions of
 dependency ports
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

By removing builin-baseline constraint, we force
vcpkg to use latest versions of ports. As a side effect,
this bumps OpenSSL to 3.0.7.

While on it, update vcpkg commit in GHA.

We also have to apply a workaround for GHA
to make it use our vcpkg checkout instead of c:\vcpkg,
see

 https://github.com/actions/runner-images/issues/6376
 https://github.com/lukka/run-vcpkg/issues/170

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 6 ++++--
 src/openvpn/vcpkg.json       | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f7d2d383..2db90bcd 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -342,13 +342,15 @@ jobs:
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2637...
         with:
-          vcpkgGitCommitId: '9259a0719d94c402aae2ab7975bc096afdec15df'
+          vcpkgGitCommitId: 'cafd398be781144787573ca78390e951673c7055'
           appendedCacheKey: '${{matrix.triplet}}'
 
       - name: Run MSBuild consuming vcpkg.json
         working-directory: ${{env.GITHUB_WORKSPACE}}
         run: |
-            vcpkg integrate install
+            # workaround for GHA runner bug where vcpkg installation is detected at c:\vcpkg
+            # see https://github.com/lukka/run-vcpkg/issues/170
+            ${{ github.workspace }}/vcpkg/vcpkg.exe integrate install
             msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
 
       - name: Archive artifacts
diff --git a/src/openvpn/vcpkg.json b/src/openvpn/vcpkg.json
index 40db1fd2..80645677 100644
--- a/src/openvpn/vcpkg.json
+++ b/src/openvpn/vcpkg.json
@@ -8,6 +8,5 @@
     "lzo",
     "lz4",
     "pkcs11-helper"
-  ],
-  "builtin-baseline": "9259a0719d94c402aae2ab7975bc096afdec15df"
+  ]
 }
-- 
2.23.0.windows.1


