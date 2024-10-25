From: Gert Doering <gert@...1296...>
Date: Fri, 25 Oct 2024 12:36:31 +0200
Message-ID: <20241025103632.4413-1-gert@...1296...>
In-Reply-To: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
References: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] t_server_null: forcibly kill misbehaving
 servers
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

From: Samuli Seppänen <samuli.seppanen@...277...>

Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/775
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index d4311d4..3c0fc4b 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -71,4 +71,10 @@
 # pre and post ifconfig output does not match.
 wait
 
-exit $retval
+. ./t_server_null_default.rc
+
+if [ -e $SERVER_KILL_FAIL_FILE ]; then
+    exit 1
+else
+    exit $retval
+fi
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 846f790..2210e63 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -53,11 +53,11 @@
         echo "PASS ${test_name} (test failure)"
     elif [ $exit_code -eq 0 ] && [ "${should_pass}" = "no" ]; then
         echo "FAIL ${test_name} (test failure)"
-        cat "${log}"
+        cat "${t_server_null_logdir}/${log}"
         retval=1
     elif [ $exit_code -eq 1 ] && [ "${should_pass}" = "yes" ]; then
         echo "FAIL ${test_name}"
-        cat "${log}"
+        cat "${t_server_null_logdir}/${log}"
         retval=1
     fi
 }
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 825bb52..cbf4877 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -20,6 +20,10 @@
 SERVER_KEY="${sample_keys}/server.key"
 TA="${sample_keys}/ta.key"
 
+# Used to detect if graceful kill of any server instance failed during the test
+# run
+SERVER_KILL_FAIL_FILE=".t_server_null_server.kill_failed"
+
 # Test server configurations
 MAX_CLIENTS="10"
 CLIENT_MATCH="Test-Client"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index f8ba3a3..ab01dd2 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -8,6 +8,9 @@
     status="${server_name}.status"
     pid="${server_name}.pid"
 
+    # Allow reading this file even umask values are strict
+    touch "$log"
+
     if [ -z "${RUN_SUDO}" ]; then
         "${server_exec}" \
          $server_conf \
@@ -34,6 +37,9 @@
 # Load local configuration, if any
 test -r ./t_server_null.rc && . ./t_server_null.rc
 
+# Remove server kill failure marker file, if any
+rm -f $SERVER_KILL_FAIL_FILE
+
 # Launch test servers
 for SUF in $TEST_SERVER_LIST
 do
@@ -75,6 +81,7 @@
 # Make sure that the server processes are truly dead before exiting.  If a
 # server process does not exit in 15 seconds assume it never will, move on and
 # hope for the best.
+
 echo "Waiting for servers to exit"
 for PID_FILE in $server_pid_files
 do
@@ -85,22 +92,25 @@
         continue
     fi
 
-    if [ -z "${RUN_SUDO}" ]; then
-        $KILL_EXEC "${SERVER_PID}"
-    else
-        $RUN_SUDO $KILL_EXEC "${SERVER_PID}"
-    fi
+    # Attempt to kill the OpenVPN server gracefully with SIGTERM
+    $RUN_SUDO $KILL_EXEC "${SERVER_PID}"
 
     count=0
     maxcount=75
     while [ $count -le $maxcount ]
     do
-        ps -p "${SERVER_PID}" > /dev/null || break
+        $RUN_SUDO kill -0 "${SERVER_PID}" 2> /dev/null || break
         count=$(( count + 1))
         sleep 0.2
     done
 
+    # If server is still up send a SIGKILL
     if [ $count -ge $maxcount ]; then
-        echo "WARNING: could not kill server with pid ${SERVER_PID}!"
+        $RUN_SUDO $KILL_EXEC -9 "${SERVER_PID}"
+        SERVER_NAME=$(basename $PID_FILE|cut -d . -f 1)
+        echo "ERROR: had to send SIGKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!"
+        echo "Tail of server log:"
+        tail -n 20 "${t_server_null_logdir}/${SERVER_NAME}.log"
+        touch $SERVER_KILL_FAIL_FILE
     fi
 done

