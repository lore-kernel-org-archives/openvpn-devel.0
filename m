From: Simon Rozman <simon@...2293...>
Date: Fri, 13 Apr 2018 17:29:15 +0200
Message-Id: <20180413152915.7940-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH] Add missing (but optional) escape backslash
 to sed replace string
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

---
 dev-tools/lz4-rebaser.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dev-tools/lz4-rebaser.sh b/dev-tools/lz4-rebaser.sh
index 03debcb..3771639 100755
--- a/dev-tools/lz4-rebaser.sh
+++ b/dev-tools/lz4-rebaser.sh
@@ -58,7 +58,7 @@ echo "* Porting upstream lz4.c to compat-lz4.c"
 
 #ifdef NEED_COMPAT_LZ4
 EOF
-    sed 's/\"lz4\.h\"/\"compat-lz4.h"/' "$LZ4_C"
+    sed 's/\"lz4\.h\"/\"compat-lz4.h\"/' "$LZ4_C"
 cat <<EOF
 #endif /* NEED_COMPAT_LZ4 */
 EOF
-- 
2.9.0.windows.1


