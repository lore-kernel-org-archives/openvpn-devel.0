From: Arne Schwabe <arne@...1227...>
Date: Fri,  6 May 2022 15:28:35 +0200
Message-Id: <20220506132836.1318985-1-arne@...1227...>
In-Reply-To: <20220422142953.3805364-13-arne@...1227...>
References: <20220422142953.3805364-13-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Add uncrustify check to github actions
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

This adds checking if the code style is still clean github actions with the
exact version of uncrustify that is required and might also be helpful for
external commiters to get notified about code style problem when running
the Github actions on their own repository.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ac46a72cd..dd23b1426 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -3,6 +3,35 @@ name: Build
 on: [push, pull_request]
 
 jobs:
+  checkuncrustify:
+    name: "Check code style with Uncrustify"
+    # Ubuntu 22.04 has uncrustify 0.72_f
+    runs-on: ubuntu-22.04
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y uncrustify
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2620...
+        with:
+          path: openvpn
+      - name: Show uncrustify version
+        run: uncrustify --version
+      - name: Run uncrustify
+        run: ./dev-tools/reformat-all.sh
+        working-directory: openvpn
+      - name: Check for changes
+        run: git diff --output=uncrustify-changes.patch
+        working-directory: openvpn
+      - name: Show changes on standard output
+        run: git diff
+        working-directory: openvpn
+      - uses: actions/upload-artifact@...2620...
+        with:
+          name: uncrustify-changes.patch
+          path: 'openvpn/uncrustify-changes.patch'
+      - name: Set job status
+        run: test ! -s uncrustify-changes.patch
+        working-directory: openvpn
   mingw:
     strategy:
       fail-fast: false
-- 
2.32.0 (Apple Git-132)


