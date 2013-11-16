From: David Sommerseth <dazo@...384...>
Date: Sat, 16 Nov 2013 16:17:54 +0100
Message-Id: <1384615074-22345-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] t_client.sh: Add prepare/cleanup
	possibilties for each test case
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

By adding PREPARE_$NUM and CLEANUP_$NUM variables containing command lines
to execute before and after the test case is run.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 tests/t_client.sh.in | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index b13c802..9b83e14 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -221,6 +221,8 @@ SUMMARY_FAIL=
 for SUF in $TEST_RUN_LIST
 do
     # get config variables
+    eval test_prep=\"\$PREPARE_$SUF\"
+    eval test_cleanup=\"\$CLEANUP_$SUF\"
     eval test_run_title=\"\$RUN_TITLE_$SUF\"
     eval openvpn_conf=\"\$OPENVPN_CONF_$SUF\"
     eval expect_ifconfig4=\"\$EXPECT_IFCONFIG4_$SUF\"
@@ -231,6 +233,11 @@ do
     echo -e "\n### test run $SUF: '$test_run_title' ###\n"
     fail_count=0
 
+    if [ -n "$test_prep" ]; then
+        echo -e "running preparation: '$test_prep'"
+        eval $test_prep
+    fi
+
     echo "save pre-openvpn ifconfig + route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
 
@@ -316,6 +323,12 @@ do
 	SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
 	exit_code=30
     fi
+
+    if [ -n "$test_cleanup" ]; then
+        echo -e "cleaning up: '$test_cleanup'"
+        eval $test_cleanup
+    fi
+
 done
 
 if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=" none"; fi
-- 
1.8.3.1


