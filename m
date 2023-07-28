From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 28 Jul 2023 14:40:05 +0200
Message-Id: <20230728124005.177414-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] GHA: new workflow to submit scan to
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

Change-Id: I302ccc82f9d5c43b58350bbbf7f16ad1c559248f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/coverity-scan.yml | 45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 .github/workflows/coverity-scan.yml

diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coverity-scan.yml
new file mode 100644
index 00000000..0620f638
--- /dev/null
+++ b/.github/workflows/coverity-scan.yml
@@ -0,0 +1,45 @@
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
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev libnl-genl-3-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf libssl-dev libpkcs11-helper1-dev softhsm2 gnutls-bin
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2689...
+
+      - name: Download Coverity Build Tool
+        run: |
+          wget -q https://scan.coverity.com/download/cxx/linux64 --post-data "token=$TOKEN&project=OpenVPN%2Fopenvpn" -O cov-analysis-linux64.tar.gz
+          mkdir cov-analysis-linux64
+          tar xzf cov-analysis-linux64.tar.gz --strip 1 -C cov-analysis-linux64
+        env:
+          TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
+
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure
+        run: ./configure --enable-pkcs11
+
+      - name: Build with cov-build
+        run: |
+          PATH=`pwd`/cov-analysis-linux64/bin:$PATH
+          cov-build --dir cov-int make
+
+      - name: Submit the result to Coverity Scan
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
-- 
2.34.1


