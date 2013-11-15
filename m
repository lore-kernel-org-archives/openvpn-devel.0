From: David Sommerseth <dazo@...384...>
Date: Fri, 15 Nov 2013 18:12:04 +0100
Message-Id: <1384535524-6366-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] t_client.sh: Check for fping/fping6
	availability
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: David Sommerseth <davids@...1347...>

Check if fping and fping6 is available before running the real tests,
to avoid misleading test failures.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 tests/t_client.sh.in | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 189eecc..69278ee 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -24,6 +24,18 @@ else
     exit 77
 fi
 
+# Check for external dependencies
+which fping > /dev/null
+if [ $? -ne 0 ]; then
+    echo "$0: fping is not available in \$PATH"
+    exit 77
+fi
+which fping6 > /dev/null
+if [ $? -ne 0 ]; then
+    echo "$0: fping6 is not available \$PATH"
+    exit 77
+fi
+
 if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
 then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
-- 
1.8.3.1


