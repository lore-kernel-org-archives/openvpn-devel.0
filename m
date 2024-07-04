From: Gert Doering <gert@...1296...>
Date: Thu,  4 Jul 2024 15:33:36 +0200
Message-ID: <20240704133337.26595-1-gert@...1296...>
In-Reply-To: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
References: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] t_server_null: multiple improvements and
 fixes
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

- exit after a timeout if unable to kill servers
- use sudo or equivalent only for server stop/start
- use /bin/sh directly instead of through /usr/bin/env
- simplify sudo call in the sample rc file
- remove misleading and outdated documentation
- make it work on OpenBSD 7.5
- make it work on NetBSD 10.0
- make server logs readable by normal users

Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a
Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/669
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/t_server_null.rst b/doc/t_server_null.rst
index e3a098a..5fe9080 100644
--- a/doc/t_server_null.rst
+++ b/doc/t_server_null.rst
@@ -43,6 +43,12 @@
   * run as root
   * a privilege escalation tool (sudo, doas, su) and the permission to become root
 
+If you use "doas" you should enable nopass feature in */etc/doas.conf*. For
+example to allow users in the *wheel* group to run commands without a password
+prompt::
+
+    permit nopass keepenv :wheel
+
 Technical implementation
 ------------------------
 
@@ -73,13 +79,6 @@
 
       * Waits until servers have launched. Then launch all clients, wait for them to exit and then check test results by parsing the client log files. Each client kills itself after some delay using an "--up" script.
 
-Note that "make check" moves on once *t_server_null_client.sh* has exited. At
-that point *t_server_null_server.sh* is still running, because it exists only
-after waiting a few seconds for more client connections to potentially appear.
-This is a feature and not a bug, but means that launching "make check" runs too
-quickly might cause test failures or unexpected behavior such as leftover
-OpenVPN server processes.
-
 Configuration
 -------------
 
diff --git a/tests/t_server_null.rc-sample b/tests/t_server_null.rc-sample
index 28c3773..98d7869 100644
--- a/tests/t_server_null.rc-sample
+++ b/tests/t_server_null.rc-sample
@@ -1,6 +1,5 @@
 # Uncomment to run tests with sudo
-#SUDO_EXEC=`which sudo`
-#RUN_SUDO="${SUDO_EXEC} -E"
+#RUN_SUDO="sudo -E"
 
 TEST_RUN_LIST="1 2 3 10 11"
 
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 0e53ba4..7627edf 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh
 #
 TSERVER_NULL_SKIP_RC="${TSERVER_NULL_SKIP_RC:-77}"
 
@@ -57,12 +57,7 @@
 
 srcdir="${srcdir:-.}"
 
-if [ -z "${RUN_SUDO}" ]; then
-    "${srcdir}/t_server_null_server.sh" &
-else
-    $RUN_SUDO "${srcdir}/t_server_null_server.sh" &
-fi
-
+"${srcdir}/t_server_null_server.sh" &
 "${srcdir}/t_server_null_client.sh"
 retval=$?
 
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 8890007..e7dd332 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh
 
 launch_client() {
     test_name=$1
@@ -76,19 +76,22 @@
 count=0
 server_max_wait=15
 while [ $count -lt $server_max_wait ]; do
-    server_pids=""
-    server_count=$(set|grep 'SERVER_NAME_'|wc -l)
+    servers_up=0
+    server_count=$(echo $TEST_SERVER_LIST|wc -w)
 
     # We need to trim single-quotes because some shells return quoted values
     # and some don't. Using "set -o posix" which would resolve this problem is
     # not supported in all shells.
+    #
+    # While inactive server configurations may get checked they won't increase
+    # the active server count as the processes won't be running.
     for i in `set|grep 'SERVER_NAME_'|cut -d "=" -f 2|tr -d "[\']"`; do
         server_pid=$(cat $i.pid 2> /dev/null)
-        server_pids="${server_pids} ${server_pid}"
+        if ps -p $server_pid > /dev/null 2>&1; then
+            servers_up=$(( $servers_up + 1 ))
+        fi
     done
 
-    servers_up=$(ps -p $server_pids 2>/dev/null|sed '1d'|wc -l)
-
     echo "OpenVPN test servers up: ${servers_up}/${server_count}"
 
     if [ $servers_up -ge $server_count ]; then
@@ -101,6 +104,7 @@
 
     if [ $count -eq $server_max_wait ]; then
         retval=1
+        exit $retval
     fi
 done
 
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 63b6bcd..825bb52 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -24,7 +24,7 @@
 MAX_CLIENTS="10"
 CLIENT_MATCH="Test-Client"
 SERVER_EXEC="${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS="--daemon --local 127.0.0.1 --dev tun --topology subnet --server 10.29.41.0 255.255.255.0 --max-clients $MAX_CLIENTS --persist-tun --verb 3"
+SERVER_BASE_OPTS="--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3"
 SERVER_CIPHER_OPTS=""
 SERVER_CERT_OPTS="--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}"
@@ -32,14 +32,16 @@
 TEST_SERVER_LIST="1 2"
 
 SERVER_NAME_1="t_server_null_server-1194_udp"
+SERVER_SERVER_1="--server 10.29.41.0 255.255.255.0"
 SERVER_MGMT_PORT_1="11194"
 SERVER_EXEC_1="${SERVER_EXEC}"
-SERVER_CONF_1="${SERVER_CONF_BASE} --lport 1194 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}"
+SERVER_CONF_1="${SERVER_CONF_BASE} ${SERVER_SERVER_1} --lport 1194 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}"
 
 SERVER_NAME_2="t_server_null_server-1195_tcp"
+SERVER_SERVER_2="--server 10.29.42.0 255.255.255.0"
 SERVER_MGMT_PORT_2="11195"
 SERVER_EXEC_2="${SERVER_EXEC}"
-SERVER_CONF_2="${SERVER_CONF_BASE} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"
+SERVER_CONF_2="${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"
 
 # Test client configurations
 CLIENT_EXEC="${top_builddir}/src/openvpn/openvpn"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 9bc0c88..e5906ee 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh
 
 launch_server() {
     server_name=$1
@@ -8,18 +8,28 @@
     status="${server_name}.status"
     pid="${server_name}.pid"
 
-    # Ensure that old status, log and pid files are gone
-    rm -f "${status}" "${log}" "${pid}"
-
-    "${server_exec}" \
-        $server_conf \
-        --status "${status}" 1 \
-        --log "${log}" \
-        --writepid "${pid}" \
-        --explicit-exit-notify 3
-
+    if [ -z "${RUN_SUDO}" ]; then
+        rm -f "${status}" "${log}" "${pid}"
+        "${server_exec}" \
+         $server_conf \
+         --status "${status}" 1 \
+         --log "${log}" \
+         --writepid "${pid}" \
+         --explicit-exit-notify 3
+    else
+        $RUN_SUDO rm -f "${status}" "${log}" "${pid}"
+        $RUN_SUDO "${server_exec}" \
+                   $server_conf \
+                   --status "${status}" 1 \
+                   --log "${log}" \
+                   --writepid "${pid}" \
+                   --explicit-exit-notify 3
+    fi
 }
 
+# Make server log files readable by normal users
+umask 022
+
 # Load base/default configuration
 . "${srcdir}/t_server_null_default.rc" || exit 1
 
@@ -64,15 +74,30 @@
 
 echo "All clients have disconnected from all servers"
 
+# Make sure that the server processes are truly dead before exiting.  If a
+# server process does not exit in 15 seconds assume it never will, move on and
+# hope for the best.
+echo "Waiting for servers to exit"
 for PID_FILE in $server_pid_files
 do
     SERVER_PID=$(cat "${PID_FILE}")
-    $KILL_EXEC "${SERVER_PID}"
 
-    # Make sure that the server processes are truly dead before exiting
-    while :
+    if [ -z "${RUN_SUDO}" ]; then
+        $KILL_EXEC "${SERVER_PID}"
+    else
+        $RUN_SUDO $KILL_EXEC "${SERVER_PID}"
+    fi
+
+    count=0
+    maxcount=75
+    while [ $count -le $maxcount ]
     do
         ps -p "${SERVER_PID}" > /dev/null || break
+        count=$(( count + 1))
         sleep 0.2
     done
+
+    if [ $count -ge $maxcount ]; then
+        echo "WARNING: could not kill server with pid ${SERVER_PID}!"
+    fi
 done
diff --git a/tests/t_server_null_stress.sh b/tests/t_server_null_stress.sh
index 1281397..0bb9452 100755
--- a/tests/t_server_null_stress.sh
+++ b/tests/t_server_null_stress.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh
 #
 # Run this stress test as root to avoid sudo authorization from timing out.
 

