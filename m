From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 28 Feb 2025 18:00:45 +0100
Message-Id: <20250228170045.321832-1-frank@...2641...>
In-Reply-To: <gerrit.1739196465000.I3922714972fffb3d7b1592f882d09c1fe1137241@...2715...>
References: <gerrit.1739196465000.I3922714972fffb3d7b1592f882d09c1fe1137241@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Publish Doxygen documentation to
 Github Pages
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
Cc: Yuriy Darnobyt <yura.uddr@...277...>

To make it more easily available to everyone.

Change-Id: I3922714972fffb3d7b1592f882d09c1fe1137241
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/887
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/doxygen.yml b/.github/workflows/doxygen.yml
new file mode 100644
index 0000000..f1ece70
--- /dev/null
+++ b/.github/workflows/doxygen.yml
@@ -0,0 +1,53 @@
+name: Deploy Doxygen documentation to Pages
+on:
+  push:
+    branches: ["master"]
+  workflow_dispatch:
+concurrency:
+  group: "pages"
+  cancel-in-progress: false
+jobs:
+  build:
+    runs-on: ubuntu-24.04
+    steps:
+      - uses: actions/checkout@...2844... # v4.2.2
+        with:
+          path: openvpn
+
+      - name: Install dependencies
+        run: |
+          sudo apt update
+          sudo apt install -y --no-install-recommends \
+            build-essential doxygen graphviz \
+            liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf libssl-dev
+
+      - name: Build Doxygen documentation
+        id: build
+        run: |
+          cd openvpn
+          autoreconf -f -i
+          cd ..
+          mkdir doxygen
+          cd doxygen
+          ../openvpn/configure
+          make doxygen
+          touch doc/doxygen/html/.nojekyll
+      - name: Upload static files as artifact
+        id: deployment
+        uses: actions/upload-pages-artifact@...2858...
+        with:
+          path: doxygen/doc/doxygen/html/
+
+  deploy:
+    needs: build
+    permissions:
+      pages: write      # to deploy to Pages
+      id-token: write   # to verify the deployment originates from an appropriate source
+    environment:
+      name: github-pages
+      url: ${{ steps.deployment.outputs.page_url }}
+    runs-on: ubuntu-24.04
+    steps:
+      - name: Deploy to GitHub Pages
+        id: deployment
+        uses: actions/deploy-pages@...2859...

