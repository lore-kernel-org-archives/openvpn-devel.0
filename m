From: Gert Doering <gert@...1296...>
Date: Sat, 26 Oct 2024 11:25:14 +0200
Message-ID: <20241026092515.30559-1-gert@...1296...>
In-Reply-To: <gerrit.1729861210000.Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb@...2715...>
References: <gerrit.1729861210000.Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] t_server_null: use wait instead of
 marker files
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

By using wait in a more inventive way we can avoid using a marker file
to detect the "server could not be killed gracefully" situation.

Change-Id: Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb
Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/786
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 3c0fc4b..74ffd52 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -62,6 +62,8 @@
 mkdir $t_server_null_logdir
 
 "${srcdir}/t_server_null_server.sh" &
+T_SERVER_NULL_SERVER_PID=$!
+
 "${srcdir}/t_server_null_client.sh"
 retval=$?
 
@@ -69,11 +71,9 @@
 # that this script does not exit before all --dev null servers are dead and
 # their network interfaces are gone. Otherwise t_client.sh will fail because
 # pre and post ifconfig output does not match.
-wait
+wait $T_SERVER_NULL_SERVER_PID
 
-. ./t_server_null_default.rc
-
-if [ -e $SERVER_KILL_FAIL_FILE ]; then
+if [ $? -ne 0 ]; then
     exit 1
 else
     exit $retval
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index ab01dd2..acf8479 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -37,8 +37,9 @@
 # Load local configuration, if any
 test -r ./t_server_null.rc && . ./t_server_null.rc
 
-# Remove server kill failure marker file, if any
-rm -f $SERVER_KILL_FAIL_FILE
+# We can't exit immediately on the first failure as that could leave processes
+# lying around.
+retval=0
 
 # Launch test servers
 for SUF in $TEST_SERVER_LIST
@@ -81,7 +82,6 @@
 # Make sure that the server processes are truly dead before exiting.  If a
 # server process does not exit in 15 seconds assume it never will, move on and
 # hope for the best.
-
 echo "Waiting for servers to exit"
 for PID_FILE in $server_pid_files
 do
@@ -111,6 +111,8 @@
         echo "ERROR: had to send SIGKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!"
         echo "Tail of server log:"
         tail -n 20 "${t_server_null_logdir}/${SERVER_NAME}.log"
-        touch $SERVER_KILL_FAIL_FILE
+        retval=1
     fi
 done
+
+exit $retval

