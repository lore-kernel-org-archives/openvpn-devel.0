From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 11 Sep 2023 13:07:35 +0200
Message-Id: <20230911110735.34491-1-frank@...2641...>
In-Reply-To: <20230728124005.177414-1-frank@...2641...>
References: <20230728124005.177414-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GHA: new workflow to submit scan to
 Coverity Scan service
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

Not on every push due to submit limits.

Use caching to not submit a scan for the same git commit
twice. Since we have many days without pushes to master
this saves a lot of Github and Coverity resources.

v2:
 - add caching to not submit redundant scans

Change-Id: I302ccc82f9d5c43b58350bbbf7f16ad1c559248f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/coverity-scan.yml | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 .github/workflows/coverity-scan.yml

diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
new file mode 100644
index 00000000..c1079332
--- /dev/null
+++ b/.github/workflows/coverity-scan.yml
@@ -0,0 +1,69 @@
+name: coverity-scan
+on:
+  schedule:
+    - cron: '0 20 * * *' # Daily at 20:00 UTC
+  workflow_dispatch:
+
+jobs:
+  latest:
+    runs-on: ubuntu-latest
+    steps:
+      - name: Check submission cache
+        id: check_submit
+        uses: actions/cache/restore@...2689...
+        with:
+          path: |
+            cov-int
+          key: check-submit-${{ github.sha }}
+
+      - name: Install dependencies
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf libssl-dev libpkcs11-helper1-dev softhsm2 gnutls-bin
+
+      - name: Checkout OpenVPN
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        uses: actions/checkout@...2689...
+
+      - name: Download Coverity Build Tool
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        run: |
+          wget -q https://scan.coverity.com/download/cxx/linux64 --post-data "token=$TOKEN&project=OpenVPN%2Fopenvpn" -O cov-analysis-linux64.tar.gz
+          mkdir cov-analysis-linux64
+          tar xzf cov-analysis-linux64.tar.gz --strip 1 -C cov-analysis-linux64
+        env:
+          TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
+
+      - name: autoconf
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        run: autoreconf -fvi
+      - name: configure
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        run: ./configure --enable-pkcs11
+
+      - name: Build with cov-build
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        run: |
+          PATH=`pwd`/cov-analysis-linux64/bin:$PATH
+          cov-build --dir cov-int make
+
+      - name: Submit the result to Coverity Scan
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        run: |
+          tar czvf openvpn.tgz cov-int
+          curl --form token=$TOKEN \
+          --form email=$EMAIL \
+          --form file=@openvpn.tgz \
+          --form version="$GITHUB_SHA" \
+          --form description="master" \
+          https://scan.coverity.com/builds?project=OpenVPN%2Fopenvpn
+        env:
+          TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
+          EMAIL: ${{ secrets.COVERITY_SCAN_EMAIL }}
+
+      - name: Cache submission
+        if: steps.check_submit.outputs.cache-hit != 'true'
+        uses: actions/cache/save@...2689...
+        with:
+          path: |
+            cov-int
+          key: ${{ steps.check_submit.outputs.cache-primary-key }}
-- 
2.34.1


