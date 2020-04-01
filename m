From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Apr 2020 14:40:19 +0200
Message-Id: <20200401124019.10529-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fetch OpenSSL versions via source/old links
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

New versions are already available as source/old but old version at
some point disappear from the normal download path. Use the source/old
path for all OpenSSL versions to avoid this problem.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .travis/build-deps.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 0c8d69b8..e8a1f101 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -90,9 +90,11 @@ build_mbedtls () {
 }
 
 download_openssl () {
+    
     if [ ! -f "download-cache/openssl-${OPENSSL_VERSION}.tar.gz" ]; then
+        MAJOR=`echo $OPENSSL_VERSION | sed -e 's/\([0-9.]*\).*/\1/'`
         wget -P download-cache/ \
-            "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
+             "https://www.openssl.org/source/old/${MAJOR}/openssl-${OPENSSL_VERSION}.tar.gz"
     fi
 }
 
-- 
2.26.0


