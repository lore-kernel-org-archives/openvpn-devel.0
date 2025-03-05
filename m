From: Frank Lichtenheld <frank@...2641...>
Date: Wed,  5 Mar 2025 14:46:42 +0100
Message-Id: <20250305134642.196598-1-frank@...2641...>
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Add lwip support to t_server_null
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

Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/811
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/t_server_null.rst b/doc/t_server_null.rst
index 5fe9080..473a7bd 100644
--- a/doc/t_server_null.rst
+++ b/doc/t_server_null.rst
@@ -16,7 +16,7 @@
 
 * Parallelized for fairly high performance
 * Mostly operating-system agnostic
-* Tested on Fedora Linux 38/39/40 and FreeBSD 14
+* Tested on Fedora Linux 38/39/40, FreeBSD 14, NetBSD 10.0 and OpenBSD 7.5
 * POSIX-compliant
 * Tested and known to work with Bash, Dash, Ksh, Yash and FreeBSD's default /bin/sh
 * Uses the sample certificates and keys
@@ -31,6 +31,7 @@
 * Test cases (client configurations) and server setups (server configurations) are stored in a configuration file, i.e. data and code have been separated
 * Configuration file format is nearly identical to t_client.rc configuration
 * Supports a set of default tests, overriding default test settings and adding local tests
+* Supports client ping tests if ovpnlwip is available
 
 Prerequisites
 -------------
@@ -60,8 +61,9 @@
 #. Server instances start
 #. Brief wait
 #. Client instances start
-#. Tests run
+#. ovpnlwip ping tests run
 #. Client instances stop
+#. Test results are collected
 #. Brief wait
 #. Server instances stop
 
@@ -77,7 +79,8 @@
 
     * t_server_null_client.sh
 
-      * Waits until servers have launched. Then launch all clients, wait for them to exit and then check test results by parsing the client log files. Each client kills itself after some delay using an "--up" script.
+      * Waits until servers have launched. Then launch all clients, run ovpnlwip ping tests (if any), wait for clients to exit and then check test results by parsing the client log files. Each client kills itself after some delay using an "--up" script.
+
 
 Configuration
 -------------
@@ -116,6 +119,19 @@
 
   TEST_RUN_LIST="1 2 5 9"
 
+Client ping tests that use ovpnlwip can be added similarly:
+
+  TEST_NAME_9L="t_server_null_client.sh-openvpn_current_udp_custom_lwip"
+  SHOULD_PASS_9L="yes"
+  CLIENT_EXEC_9L="${CLIENT_EXEC}"
+  CLIENT_CONF_9L="${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --proto udp"
+
+Note that all ovpnlwip test names need to include a "_lwip" suffix: without it
+ping tests won't get activated. Also note that the *tests* directory needs to
+have the lwipovpn executable or ovpnlwip tests will get skipped. The ovpnlwip
+ping tests get the IP addresses to ping from the \*.ips files created by the
+lwip_client_up.sh script --up script.
+
 Stress-testing the --dev null test suite
 ----------------------------------------
 
diff --git a/tests/lwip_client_up.sh b/tests/lwip_client_up.sh
new file mode 100755
index 0000000..a6b4d24
--- /dev/null
+++ b/tests/lwip_client_up.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+#
+# Determine the OpenVPN PID from its pid file. This works reliably even when
+# the OpenVPN process is backgrounded for parallel tests.
+MY_PPID=`cat $pid`
+
+# Add this client's VPN IP and PID to a file. This enables
+# t_server_null_client.sh to kill this OpenVPN client after fping tests have
+# finished.
+echo "$ifconfig_local,$MY_PPID" >> ./$test_name.lwip
+
+# Wait long enough to allow fping tests to finish. Also ensure that this
+# OpenVPN client is killed even if t_server_null_client.sh failed to do it.
+(sleep 15
+echo "ERROR: t_server_null_client.sh failed to kill OpenVPN client with PID $MY_PPID in test $test_name. Killing it in lwip_client_up.sh."
+kill -15 $MY_PPID
+) &
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 2210e63..1745de5 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -1,5 +1,17 @@
 #!/bin/sh
 
+should_run_test() {
+    test_name="$1"
+
+    if echo "$test_name"|grep -q _lwip; then
+        if [ "$has_lwipovpn" = "no" ]; then
+            return 1
+        fi
+    fi
+
+    return 0
+}
+
 launch_client() {
     test_name=$1
     log="${test_name}.log"
@@ -13,10 +25,65 @@
     "${client_exec}" \
         $client_conf \
         --writepid "${pid}" \
-        --setenv pid $pid \
+        --setenv pid "$pid" \
+        --setenv test_name "$test_name" \
         --log "${t_server_null_logdir}/${log}" &
 }
 
+ping_and_kill() {
+    if fping -q -c 5 $1; then
+        echo "PASS: fping lwipovpn client $target"
+    else
+        echo "FAIL: fping lwipovpn client $target"
+
+        # This function runs multiple times in parallel in subshells. That
+        # makes it hard to implement "fail the test suite if any single fping
+        # test fails" using exit codes or variables given the limitations of
+        # "wait".  Therefore we use a marker file here, which solves the
+        # problem trivially.
+        touch ./lwip_failed
+    fi
+    kill -15 $2
+}
+
+ping_lwip_clients() {
+    if [ "$has_lwipovpn" = "yes" ]; then
+        lwip_client_count=$(echo "$lwip_test_names"|wc -w|tr -d " ")
+    else
+        lwip_client_count=0
+    fi
+
+    if [ $lwip_client_count -eq 0 ]; then
+        return 0
+    fi
+
+    count=0
+    maxcount=10
+    while [ $count -le $maxcount ]; do
+        lwip_client_ips=$(cat ./*.lwip 2>/dev/null|wc -l)
+        if [ $lwip_client_ips -lt $lwip_client_count ]; then
+            echo "Waiting for LWIP clients to start up ($count/$maxcount)"
+            count=$(( count + 1))
+            sleep 1
+        else
+            echo "$lwip_client_ips/$lwip_client_count LWIP clients up"
+            break
+        fi
+    done
+
+    wait_pids=""
+    for line in $(cat ./*.lwip 2>/dev/null); do
+        target_ip=$(echo $line|cut -d "," -f 1)
+        client_pid=$(echo $line|cut -d "," -f 2)
+        ping_and_kill $target_ip $client_pid &
+        wait_pids="$wait_pids $!"
+    done
+
+    wait $wait_pids
+
+    test -e ./lwip_failed && return 1 || return 0
+}
+
 wait_for_results() {
     tests_running="yes"
 
@@ -77,7 +144,7 @@
 server_max_wait=15
 while [ $count -lt $server_max_wait ]; do
     servers_up=0
-    server_count=$(echo $TEST_SERVER_LIST|wc -w)
+    server_count=$(echo "$TEST_SERVER_LIST"|wc -w|tr -d " ")
 
     # We need to trim single-quotes because some shells return quoted values
     # and some don't. Using "set -o posix" which would resolve this problem is
@@ -85,8 +152,8 @@
     #
     # While inactive server configurations may get checked they won't increase
     # the active server count as the processes won't be running.
-    for i in `set|grep 'SERVER_NAME_'|cut -d "=" -f 2|tr -d "[\']"`; do
-        server_pid=$(cat $i.pid 2> /dev/null)
+    for i in $(set|grep 'SERVER_NAME_'|cut -d "=" -f 2|tr -d "[\']"); do
+        server_pid=$(cat "$i.pid" 2> /dev/null)
         if [ -z "$server_pid" ] ; then
             continue
         fi
@@ -111,6 +178,19 @@
     fi
 done
 
+# Check for presence of the lwipovpn executable
+if test -r "$LWIPOVPN_PATH"; then
+    has_lwipovpn="yes"
+else
+    has_lwipovpn="no"
+    echo "WARNING: lwipovpn executable is missing: lwip tests will be skipped"
+fi
+
+# Remove existing LWIP client IP files. This is to avoid pinging non-existent
+# IP addresses when tests are disabled.
+rm -f ./*.lwip
+rm -f ./lwip_failed
+
 # Wait a while to let server processes to settle down
 sleep 1
 
@@ -118,6 +198,7 @@
 # is used later to determine when all OpenVPN clients have exited and it is
 # safe to check the test results.
 test_names=""
+lwip_test_names=""
 for SUF in $TEST_RUN_LIST
 do
     eval test_name=\"\$TEST_NAME_$SUF\"
@@ -125,9 +206,20 @@
     eval client_conf=\"\$CLIENT_CONF_$SUF\"
 
     test_names="${test_names} ${test_name}"
-    (launch_client "${test_name}" "${client_exec}" "${client_conf}")
+
+    if echo "$test_name"|grep -q _lwip; then
+        lwip_test_names="${lwip_test_names} ${test_name}"
+    fi
+
+    if should_run_test "$test_name"; then
+        (launch_client "${test_name}" "${client_exec}" "${client_conf}")
+    fi
 done
 
+ping_lwip_clients
+retval=$?
+
+
 # Wait until all OpenVPN clients have exited
 (wait_for_results)
 
@@ -137,7 +229,9 @@
     eval test_name=\"\$TEST_NAME_$SUF\"
     eval should_pass=\"\$SHOULD_PASS_$SUF\"
 
-    get_client_test_result "${test_name}" "${should_pass}"
+    if should_run_test "$test_name"; then
+        get_client_test_result "${test_name}" "${should_pass}"
+    fi
 done
 
 exit $retval
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index cbf4877..e7bf5bc 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -20,6 +20,15 @@
 SERVER_KEY="${sample_keys}/server.key"
 TA="${sample_keys}/ta.key"
 
+# This parameter can't be overridden in t_server_null.rc because that gets
+# loaded too late. However, you can use
+#
+# LWIPOVPN_PATH=/some/path/to/lwipovpn make check
+#
+# to run the tests using lwipovpn in a custom location
+#
+LWIPOVPN_PATH="${LWIPOVPN_PATH:-lwipovpn}"
+
 # Used to detect if graceful kill of any server instance failed during the test
 # run
 SERVER_KILL_FAIL_FILE=".t_server_null_server.kill_failed"
@@ -28,7 +37,7 @@
 MAX_CLIENTS="10"
 CLIENT_MATCH="Test-Client"
 SERVER_EXEC="${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS="--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3"
+SERVER_BASE_OPTS="--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
 SERVER_CIPHER_OPTS=""
 SERVER_CERT_OPTS="--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}"
@@ -49,23 +58,37 @@
 
 # Test client configurations
 CLIENT_EXEC="${top_builddir}/src/openvpn/openvpn"
-CLIENT_BASE_OPTS="--client --dev null --ifconfig-noexec --nobind --remote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2 --up ${srcdir}/null_client_up.sh"
+CLIENT_BASE_OPTS="--client --nobind --remote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2"
+CLIENT_NULL_OPTS="--dev null --ifconfig-noexec --up ${srcdir}/null_client_up.sh"
+CLIENT_LWIP_OPTS="--dev null --dev-node unix:${LWIPOVPN_PATH} --up ${srcdir}/lwip_client_up.sh"
+
 CLIENT_CIPHER_OPTS=""
 CLIENT_CERT_OPTS="--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1"
 
-TEST_RUN_LIST="1 2 3"
-CLIENT_CONF_BASE="${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
+TEST_RUN_LIST="1 1L 2 2L 3"
+CLIENT_CONF_BASE="${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
+CLIENT_CONF_BASE_LWIP="${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
 
 TEST_NAME_1="t_server_null_client.sh-openvpn_current_udp"
 SHOULD_PASS_1="yes"
 CLIENT_EXEC_1="${CLIENT_EXEC}"
 CLIENT_CONF_1="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp"
 
+TEST_NAME_1L="t_server_null_client.sh-openvpn_current_udp_lwip"
+SHOULD_PASS_1L="yes"
+CLIENT_EXEC_1L="${CLIENT_EXEC}"
+CLIENT_CONF_1L="${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --proto udp"
+
 TEST_NAME_2="t_server_null_client.sh-openvpn_current_tcp"
 SHOULD_PASS_2="yes"
 CLIENT_EXEC_2="${CLIENT_EXEC}"
 CLIENT_CONF_2="${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto tcp"
 
+TEST_NAME_2L="t_server_null_client.sh-openvpn_current_tcp_lwip"
+SHOULD_PASS_2L="yes"
+CLIENT_EXEC_2L="${CLIENT_EXEC}"
+CLIENT_CONF_2L="${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1195 tcp --proto tcp"
+
 TEST_NAME_3="t_server_null_client.sh-openvpn_current_udp_fail"
 SHOULD_PASS_3="no"
 CLIENT_EXEC_3="${CLIENT_EXEC}"

