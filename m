From: Gert Doering <gert@...1296...>
Date: Tue, 24 Nov 2020 17:13:13 +0100
Message-Id: <20201124161313.18831-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Change travis build scripts to use https
 when fetching prerequisites.
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

Reported by "jub0bs" on hackerone.com (#1039504)

Signed-off-by: Gert Doering <gert@...1296...>
---
 .travis/build-deps.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 08b93e7a..61673441 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -18,14 +18,14 @@ PREFIX="${PREFIX:-${HOME}/opt}"
 download_tap_windows () {
     if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then
        wget -P download-cache/ \
-           "http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
+           "https://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip"
     fi
 }
 
 download_lzo () {
     if [ ! -f "download-cache/lzo-${LZO_VERSION}.tar.gz" ]; then
         wget -P download-cache/ \
-            "http://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
+            "https://www.oberhumer.com/opensource/lzo/download/lzo-${LZO_VERSION}.tar.gz"
     fi
 }
 
-- 
2.29.2


