From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  3 Jun 2022 11:03:00 +0300
Message-Id: <20220603080300.182-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] GitHub Actions: trigger openvpn-build GHA
 on success
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

After successfult builds on all platforms,
start openvpn-build GHA which produces
Windows MSI installers.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d34f4e9a..99968aae 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -1,6 +1,7 @@
 # The name of our workflow
 name: Build
-on: [push, pull_request]
+on:
+  push:
 
 jobs:
   checkuncrustify:
@@ -32,6 +33,7 @@ jobs:
       - name: Set job status
         run: test ! -s uncrustify-changes.patch
         working-directory: openvpn
+
   mingw:
     strategy:
       fail-fast: false
@@ -250,7 +252,6 @@ jobs:
       - name: make check
         run: make check
 
-
   macos:
     runs-on: macos-latest
     strategy:
@@ -344,3 +345,19 @@ jobs:
             ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.dll
             ${{ matrix.plat }}-Output/${{env.BUILD_CONFIGURATION}}/*.pdb
             doc/openvpn.8.html
+
+  trigger_openvpn_build:
+    runs-on: windows-latest
+    needs: [checkuncrustify, mingw, ubuntu, ubuntu-clang-asan, macos, msvc]
+    if: github.ref == 'refs/heads/master'
+    env:
+      REPO_DISPATCH: ${{ secrets.OPENVPN_BUILD_REPO_DISPATCH }}
+
+    steps:
+    - name: Repository Dispatch
+      if: "${{ env.REPO_DISPATCH != '' }}"
+      uses: peter-evans/repository-dispatch@...2620...
+      with:
+        token: ${{ env.REPO_DISPATCH }}
+        repository: openvpn/openvpn-build
+        event-type: openvpn-commit
-- 
2.23.0.windows.1


