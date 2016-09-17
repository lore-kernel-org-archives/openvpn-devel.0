From: David Sommerseth <davids@...515...>
Date: Sat, 17 Sep 2016 14:18:05 +0300
Message-Id: <1474111085-10678-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] t_client.sh: Improve detection if the
	OpenVPN process did start during tests
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

This will check the OpenVPN log file if the process initialized successfully.
It will check the log file for 30 seconds before aborting the test run.  This
also has the advantage of starting the testing quicker if the initialization
goes faster than 10 seconds (which was the old sleep time).

The umask is also set to a more permissive mode to ensure the test script is
capable of reading the OpenVPN PID file, as that will be created by root.

Signed-off-by: David Sommerseth <davids@...515...>
---
 tests/t_client.sh.in | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 64a3b9a..bde07a6 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -297,23 +297,39 @@ do
     openvpn_conf="$openvpn_conf --writepid $pidfile"
     echo " run openvpn $openvpn_conf"
     echo "# src/openvpn/openvpn $openvpn_conf" >$LOGDIR/$SUF:openvpn.log
+    umask 022
     $RUN_SUDO "${top_builddir}/src/openvpn/openvpn" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
-    sleep 3  # Wait for OpenVPN to initialize and have had time to write the pid file
-    opid=`cat $pidfile`
-    echo "  OpenVPN running with PID $opid"
-
-    # make sure openvpn client is terminated in case shell exits
-    trap "$RUN_SUDO $KILL_EXEC $opid" 0
-    trap "$RUN_SUDO $KILL_EXEC $opid ; trap - 0 ; exit 1" 1 2 3 15
+    sudopid=$!
 
-    echo "wait for connection to establish..."
-    sleep ${SETUP_TIME_WAIT:-10}
+    # Check if OpenVPN has initialized before continuing.  It will check every 3rd second up
+    # to $ovpn_init_check times.
+    ovpn_init_check=10
+    ovpn_init_success=0
+    while [ $ovpn_init_check -gt 0 ];
+    do
+       sleep 3  # Wait for OpenVPN to initialize and have had time to write the pid file
+       grep -q "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log
+       if [ $? -eq 0 ]; then
+           ovpn_init_check=0
+           ovpn_init_success=1
+       fi
+       ovpn_init_check=$(( $ovpn_init_check - 1 ))
+    done
 
-    # test whether OpenVPN process is still there
-    if $RUN_SUDO $KILL_EXEC -0 $opid
-    then :
+    opid=`cat $pidfile`
+    if [ -n "$opid" ]; then
+        echo "  OpenVPN running with PID $opid"
     else
-	fail "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:openvpn.log)."
+        echo "  Could not read OpenVPN PID file" >&2
+    fi
+
+    # If OpenVPN did not start
+    if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
+        echo "$0:  OpenVPN did not initialize in a reasonable time" >&2
+        if [ -n "$opid" ]; then
+           $RUN_SUDO $KILL_EXEC $opid
+        fi
+        $RUN_SUDO $KILL_EXEC $sudopid
 	echo "tail -5 $SUF:openvpn.log" >&2
 	tail -5 $LOGDIR/$SUF:openvpn.log >&2
 	echo -e "\nFAIL. skip rest of sub-tests for test run $SUF.\n" >&2
@@ -323,6 +339,10 @@ do
 	continue
     fi
 
+    # make sure openvpn client is terminated in case shell exits
+    trap "$RUN_SUDO $KILL_EXEC $opid" 0
+    trap "$RUN_SUDO $KILL_EXEC $opid ; trap - 0 ; exit 1" 1 2 3 15
+
     # compare whether anything changed in ifconfig/route setup?
     echo "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
-- 
1.8.3.1


