From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 22 Aug 2022 16:18:06 +0200
Message-Id: <20220822141806.39406-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_client.sh: do not require fping6
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

fping and fping6 were merged in version 4.0,
released in 2017. Many recent distributions do
not include the compatibility symlink anymore.

So if we find fping but not fping6 do not error
out but assume that fping is capable of IPv6.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/t_client.sh.in | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 465c3a33..76ac9b22 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -9,7 +9,7 @@
 # - writable current directory to create subdir for logs
 # - t_client.rc in current directory OR source dir that specifies tests
 # - for "ping4" checks: fping binary in $PATH
-# - for "ping6" checks: fping6 binary in $PATH
+# - for "ping6" checks: fping (4.0+) or fping6 binary in $PATH
 #
 
 # by changing this to 1 we can force automated builds to fail
@@ -29,6 +29,8 @@ else
 fi
 
 # Check for external dependencies
+FPING="fping"
+FPING6="fping6"
 which fping > /dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping is not available in \$PATH" >&2
@@ -36,8 +38,9 @@ if [ $? -ne 0 ]; then
 fi
 which fping6 > /dev/null
 if [ $? -ne 0 ]; then
-    echo "$0: fping6 is not available in \$PATH" >&2
-    exit "${TCLIENT_SKIP_RC}"
+    echo "$0: fping6 is not available in \$PATH, assuming fping 4.0 or later" >&2
+    FPING="fping -4"
+    FPING6="fping -6"
 fi
 
 KILL_EXEC=`which kill`
@@ -220,8 +223,8 @@ run_ping_tests()
     if [ -z "$targetlist" ] ; then return ; fi
 
     case $proto in
-	4) cmd=fping ;;
-	6) cmd=fping6 ;;
+	4) cmd="$FPING" ;;
+	6) cmd="$FPING6" ;;
 	*) echo "internal error in run_ping_tests arg 1: '$proto'" >&2
 	   exit 1 ;;
     esac
-- 
2.34.1


