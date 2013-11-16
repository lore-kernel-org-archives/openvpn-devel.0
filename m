From: David Sommerseth <dazo@...384...>
Date: Sat, 16 Nov 2013 11:23:43 +0100
Message-Id: <1384597423-11136-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] t_client.sh: Write errors to stderr and
	document requirements
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

Signed-off-by: David Sommerseth <davids@...1347...>
---
 INSTALL              | 4 ++++
 tests/t_client.sh.in | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 61dc975..2ef7904 100644
--- a/INSTALL
+++ b/INSTALL
@@ -87,6 +87,10 @@ OPTIONAL (for developers only):
       -- available from http://www.gnu.org/software/software.html
   (2) Dmalloc library
       -- available from http://dmalloc.com/
+  (3) If using t_client.sh test framework, fping/fping6 is needed
+      -- Available from http://www.fping.org/
+      Note: t_client.sh needs an external configured OpenVPN server.
+      See t_client.rc-sample for more info.
 
 *************************************************************************
 
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index af12e2d..b13c802 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -27,12 +27,12 @@ fi
 # Check for external dependencies
 which fping > /dev/null
 if [ $? -ne 0 ]; then
-    echo "$0: fping is not available in \$PATH"
+    echo "$0: fping is not available in \$PATH" >&2
     exit 77
 fi
 which fping6 > /dev/null
 if [ $? -ne 0 ]; then
-    echo "$0: fping6 is not available in \$PATH"
+    echo "$0: fping6 is not available in \$PATH" >&2
     exit 77
 fi
 
-- 
1.8.3.1


