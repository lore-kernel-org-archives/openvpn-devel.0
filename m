From: =?UTF-8?q?Samuli=20Sepp=C3=A4nen?= <samuli.seppanen@...277...>
Date: Tue, 18 Jun 2024 08:55:36 +0300
Message-ID: <20240618055538.1936401-1-samuli.seppanen@...277...>
In-Reply-To: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
References: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add t_server_null test suite
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

Change-Id: I1b54da258c7d15551b6c3de7522a0d19afdb66de
Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/663
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.gitignore b/.gitignore
index 92d65bf..db8bb73 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,6 +55,7 @@
 
 tests/t_client.sh
 tests/t_client-*-20??????-??????/
+tests/t_server_null.rc
 t_client.rc
 t_client_ips.rc
 tests/unit_tests/**/*_testdriver
diff --git a/doc/t_server_null.rst b/doc/t_server_null.rst
new file mode 100644
index 0000000..e3a098a
--- /dev/null
+++ b/doc/t_server_null.rst
@@ -0,0 +1,147 @@
+Notes for the --dev null test suite
+===================================
+
+Introduction
+------------
+
+The *--dev null test suite* is primary targeted at testing client connections
+to the "just compiled" version of OpenVPN. The name is derived from "null"
+device type in OpenVPN. In particular, when *--dev null --ifconfig-noexec* is
+used in OpenVPN client configuration one does not need to run OpenVPN with root
+privileges because interface, routing, etc. configuration is not done at all.
+This is still enough to ensure that the OpenVPN client can connect to a server
+instance.
+
+The main features of the test suite:
+
+* Parallelized for fairly high performance
+* Mostly operating-system agnostic
+* Tested on Fedora Linux 38/39/40 and FreeBSD 14
+* POSIX-compliant
+* Tested and known to work with Bash, Dash, Ksh, Yash and FreeBSD's default /bin/sh
+* Uses the sample certificates and keys
+* Supports running multiple servers and clients
+* Supports running servers directly as root and with sudo
+* Supports using different OpenVPN client versions
+
+  * The "current" (just compiled) version
+  * Any other OpenVPN versions that is present on the filesystem
+
+* Support testing for success as well as failure
+* Test cases (client configurations) and server setups (server configurations) are stored in a configuration file, i.e. data and code have been separated
+* Configuration file format is nearly identical to t_client.rc configuration
+* Supports a set of default tests, overriding default test settings and adding local tests
+
+Prerequisites
+-------------
+
+Running the test suite requires the following:
+
+* *bash* for running the tests
+* root-level privileges for launching the servers
+
+  * run as root
+  * a privilege escalation tool (sudo, doas, su) and the permission to become root
+
+Technical implementation
+------------------------
+
+The test suite is completely parallelized to allow running a large number of
+server and client combinations quickly.
+
+A normal test run looks like this:
+
+#. Server instances start
+#. Brief wait
+#. Client instances start
+#. Tests run
+#. Client instances stop
+#. Brief wait
+#. Server instances stop
+
+The tests suite is launched via "make check":
+
+* make check
+
+  * t_server_null.sh
+
+    * t_server_null_server.sh
+
+      * Launches the compiled OpenVPN server instances as root (if necessary with sudo or su) in the background. The servers are killed using their management interface once all clients have exited.
+
+    * t_server_null_client.sh
+
+      * Waits until servers have launched. Then launch all clients, wait for them to exit and then check test results by parsing the client log files. Each client kills itself after some delay using an "--up" script.
+
+Note that "make check" moves on once *t_server_null_client.sh* has exited. At
+that point *t_server_null_server.sh* is still running, because it exists only
+after waiting a few seconds for more client connections to potentially appear.
+This is a feature and not a bug, but means that launching "make check" runs too
+quickly might cause test failures or unexpected behavior such as leftover
+OpenVPN server processes.
+
+Configuration
+-------------
+
+The test suite reads its configuration from two files:
+
+* *tests/t_server_null_defaults.rc:* default test configuration that should work on any system
+* *tests/t_server_null.rc:* a local configuration file; can be used to add additional tests or override settings from the default test configuration. Must be present or tests will be skipped, but can be an empty file.
+
+The configuration syntax is very similar to *t_client.rc*. New server instances can be
+defined like this::
+
+  SERVER_NAME_5="t_server_null_server-11195_udp"
+  SERVER_MGMT_PORT_5="11195"
+  SERVER_EXEC_5="${SERVER_EXEC}"
+  SERVER_CONF_5="${SERVER_CONF_BASE} --lport 11195 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_5}"
+
+In this case the server instance identifier is **5**. Variables such as
+*SERVER_EXEC* and *SERVER_CONF_BASE* are defined in
+*t_server_null_defaults.rc*. To enable this server instance add it to the
+server list::
+
+  TEST_SERVER_LIST="1 2 5"
+
+The client instances are added similarly::
+
+  TEST_NAME_9="t_server_null_client.sh-openvpn_current_udp_custom"
+  SHOULD_PASS_9="yes"
+  CLIENT_EXEC_9="${CLIENT_EXEC}"
+  CLIENT_CONF_9="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp"
+
+In this case the test identifier is **9**. *CLIENT_EXEC* and *CLIENT_CONF_BASE*
+are defined in *t_server_null_defaults.rc*. The variable *SHOULD_PASS*
+determines that this particular test is supposed to succeed and not fail.  To
+enable this client instance add it to the test list::
+
+  TEST_RUN_LIST="1 2 5 9"
+
+Stress-testing the --dev null test suite
+----------------------------------------
+
+It is very easy to introduce subtle, difficult to debug issues to the --dev
+null tests when you make changes to it. These issues can be difficult to spot:
+based on practical experience a bad change can make the test failure rate go
+from 0% (normal) to anywhere between 1% and 20%. You can spot these issues with
+the provided stress-test script, *t_server_null_stress.sh*. It calls *make check*
+over and over again in a loop and when failures occur it saves the output under
+*tests/make-check*.
+
+To follow the test flow on Linux you can run this while stress-testing::
+
+    watch -n 0.5 "ps aux|grep -E '(openvpn|t_server_null_server.sh)'|grep -vE '(suppress|grep|tail)'"
+
+Regarding privilege escalation
+------------------------------
+
+The --dev null test servers need to be launched as root. Either run the tests
+as root directly, or configure a privilege escalation tool of your choice in
+*t_server_null.rc*. For example, to use sudo::
+
+    SUDO_EXEC=`which sudo`
+    RUN_SUDO="${SUDO_EXEC} -E"
+
+If you do stress-testing with *t_server_null_stress.sh* make sure your
+privilege escalation authorization does not time out: if it does, then a
+reauthorization prompt will interrupt your tests.
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 5e9ad0a..f26b3b8 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -15,10 +15,10 @@
 SUBDIRS = unit_tests
 
 AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) System Tests'
-LOG_DRIVER = $(SHELL) $(top_srcdir)/forked-test-driver
+SH_LOG_DRIVER = $(SHELL) $(top_srcdir)/forked-test-driver
 
 if !WIN32
-test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
+test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh t_server_null.sh
 
 check_PROGRAMS = ntlm_support
 if HAVE_SITNL
@@ -27,6 +27,7 @@
 endif
 
 TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
+TEST_EXTENSIONS = .sh
 TESTS = $(test_scripts)
 
 dist_noinst_SCRIPTS = \
@@ -34,8 +35,14 @@
 	t_cltsrv-down.sh \
 	t_lpback.sh \
 	t_net.sh \
+	t_server_null.sh \
+	t_server_null_client.sh \
+	t_server_null_server.sh \
+	t_server_null_default.rc \
 	update_t_client_ips.sh
 
+t_client.log: t_server_null.log
+
 dist_noinst_DATA = \
 	t_client.rc-sample
 
diff --git a/tests/null_client_up.sh b/tests/null_client_up.sh
new file mode 100755
index 0000000..d4df0c6
--- /dev/null
+++ b/tests/null_client_up.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+#
+# Stop the parent process (openvpn) gracefully after a small delay
+
+# Determine the OpenVPN PID from its pid file. This works reliably even when
+# the OpenVPN process is backgrounded for parallel tests.
+MY_PPID=`cat $pid`
+
+# Allow OpenVPN to finish initializing while waiting in the background and then
+# killing the process gracefully.
+(sleep 5 ; kill -15 $MY_PPID) &
diff --git a/tests/t_server_null.rc-sample b/tests/t_server_null.rc-sample
new file mode 100644
index 0000000..28c3773
--- /dev/null
+++ b/tests/t_server_null.rc-sample
@@ -0,0 +1,15 @@
+# Uncomment to run tests with sudo
+#SUDO_EXEC=`which sudo`
+#RUN_SUDO="${SUDO_EXEC} -E"
+
+TEST_RUN_LIST="1 2 3 10 11"
+
+TEST_NAME_10="t_server_null_client.sh-openvpn_2_6_8_udp"
+SHOULD_PASS_10="yes"
+CLIENT_EXEC_10="/usr/sbin/openvpn"
+CLIENT_CONF_10="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp"
+
+TEST_NAME_11="t_server_null_client.sh-openvpn_2_6_8_tcp"
+SHOULD_PASS_11="yes"
+CLIENT_EXEC_11="/usr/sbin/openvpn"
+CLIENT_CONF_11="${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto tcp"
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
new file mode 100755
index 0000000..cfca5ee
--- /dev/null
+++ b/tests/t_server_null.sh
@@ -0,0 +1,72 @@
+#!/usr/bin/env sh
+#
+TSERVER_NULL_SKIP_RC="${TSERVER_NULL_SKIP_RC:-77}"
+
+if ! [ -r "./t_server_null.rc" ] ; then
+    echo "${0}: cannot find './t_server_null.rc. SKIPPING TEST.'" >&2
+    exit "${TSERVER_NULL_SKIP_RC}"
+fi
+
+. ./t_server_null.rc
+
+if KILL_EXEC=$(which kill); then
+    export KILL_EXEC
+else
+    echo "${0}: kill not found in \$PATH" >&2
+    exit "${TSERVER_NULL_SKIP_RC}"
+fi
+
+# Ensure PREFER_KSU is in a known state
+PREFER_KSU="${PREFER_KSU:-0}"
+
+# make sure we have permissions to run ifconfig/route from OpenVPN
+# can't use "id -u" here - doesn't work on Solaris
+ID=$(id)
+if expr "$ID" : "uid=0" >/dev/null
+then :
+else
+    if [ "${PREFER_KSU}" -eq 1 ];
+    then
+        # Check if we have a valid kerberos ticket
+        if klist -l 1>/dev/null 2>/dev/null; then
+            RUN_SUDO="ksu -q -e"
+        else
+            # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
+            PREFER_KSU=0
+            echo "${0}: No Kerberos ticket available.  Will not use ksu."
+        fi
+    fi
+
+    if [ -z "$RUN_SUDO" ]
+    then
+        echo "${0}: this test must run be as root, or RUN_SUDO=... " >&2
+        echo "      must be set correctly in 't_server_null.rc'. SKIP." >&2
+        exit "${TSERVER_NULL_SKIP_RC}"
+    else
+	# Run a no-op command with privilege escalation (e.g. sudo) so that
+	# we (hopefully) do not have to ask the users password during the test.
+	if $RUN_SUDO "${KILL_EXEC}" -0 $$
+	then
+	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
+	else
+	    echo "${0}: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
+	    exit "${TSERVER_NULL_SKIP_RC}"
+	fi
+    fi
+fi
+
+srcdir="${srcdir:-.}"
+
+if [ -z "${RUN_SUDO}" ]; then
+    "${srcdir}/t_server_null_server.sh" &
+else
+    $RUN_SUDO "${srcdir}/t_server_null_server.sh" &
+fi
+
+"${srcdir}/t_server_null_client.sh"
+
+# When running make jobs in parallel ("make -j<x> check") we need to ensure
+# that this script does not exit before all --dev null servers are dead and
+# their network interfaces are gone. Otherwise t_client.sh will fail because
+# pre and post ifconfig output does not match.
+wait
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
new file mode 100755
index 0000000..5d5542b
--- /dev/null
+++ b/tests/t_server_null_client.sh
@@ -0,0 +1,136 @@
+#!/usr/bin/env sh
+
+launch_client() {
+    test_name=$1
+    log="${test_name}.log"
+    pid="${test_name}.pid"
+    client_exec=$2
+    client_conf=$3
+
+    # Ensure that old log and pid files are gone
+    rm -f "${log}" "${pid}"
+
+    "${client_exec}" \
+        $client_conf \
+        --writepid "${pid}" \
+        --setenv pid $pid \
+        --log "${log}" &
+}
+
+wait_for_results() {
+    tests_running="yes"
+
+    # Wait a bit to allow an OpenVPN client process to create a pidfile to
+    # prevent exiting too early
+    sleep 1
+
+    while [ "${tests_running}" = "yes" ]; do
+        tests_running="no"
+        for t in $test_names; do
+            if [ -f "${t}.pid" ]; then
+                tests_running="yes"
+            fi
+        done
+
+        if [ "${tests_running}" = "yes" ]; then
+            echo "Clients still running"
+            sleep 1
+        fi
+    done
+}
+
+get_client_test_result() {
+    test_name=$1
+    should_pass=$2
+    log="${test_name}.log"
+
+    grep "Initialization Sequence Completed" "${log}" > /dev/null
+    exit_code=$?
+
+    if [ $exit_code -eq 0 ] && [ "${should_pass}" = "yes" ]; then
+        echo "PASS ${test_name}"
+    elif [ $exit_code -eq 1 ] && [ "${should_pass}" = "no" ]; then
+        echo "PASS ${test_name} (test failure)"
+    elif [ $exit_code -eq 0 ] && [ "${should_pass}" = "no" ]; then
+        echo "FAIL ${test_name} (test failure)"
+        cat "${log}"
+        retval=1
+    elif [ $exit_code -eq 1 ] && [ "${should_pass}" = "yes" ]; then
+        echo "FAIL ${test_name}"
+        cat "${log}"
+        retval=1
+    fi
+}
+
+# Load basic/default tests
+. ${srcdir}/t_server_null_default.rc || exit 1
+
+# Load additional local tests, if any
+test -r ./t_server_null.rc && . ./t_server_null.rc
+
+# Return value for the entire test suite. Gets set to 1 if any test fails.
+export retval=0
+
+# Wait until servers are up. This check is based on the presence of processes
+# matching the PIDs in each servers PID files
+count=0
+server_max_wait=15
+while [ $count -lt $server_max_wait ]; do
+    server_pids=""
+    server_count=$(set|grep 'SERVER_NAME_'|wc -l)
+
+    # We need to trim single-quotes because some shells return quoted values
+    # and some don't. Using "set -o posix" which would resolve this problem is
+    # not supported in all shells.
+    for i in `set|grep 'SERVER_NAME_'|cut -d "=" -f 2|tr -d "[\']"`; do
+        server_pid=$(cat $i.pid 2> /dev/null)
+        server_pids="${server_pids} ${server_pid}"
+    done
+
+    servers_up=$(ps -p $server_pids 2>/dev/null|sed '1d'|wc -l)
+
+    echo "OpenVPN test servers up: ${servers_up}/${server_count}"
+
+    if [ $servers_up -ge $server_count ]; then
+        retval=0
+        break
+    else
+        count=$(( count + 1))
+        sleep 1
+    fi
+
+    if [ $count -eq $server_max_wait ]; then
+        retval=1
+    fi
+done
+
+# Wait a while to let server processes to settle down
+sleep 1
+
+# Launch OpenVPN clients. While at it, construct a list of test names. The list
+# is used later to determine when all OpenVPN clients have exited and it is
+# safe to check the test results.
+test_names=""
+for SUF in $TEST_RUN_LIST
+do
+    eval test_name=\"\$TEST_NAME_$SUF\"
+    eval client_exec=\"\$CLIENT_EXEC_$SUF\"
+    eval client_conf=\"\$CLIENT_CONF_$SUF\"
+
+    test_names="${test_names} ${test_name}"
+    (launch_client "${test_name}" "${client_exec}" "${client_conf}")
+done
+
+# Wait until all OpenVPN clients have exited
+(wait_for_results)
+
+# Check test results
+for SUF in $TEST_RUN_LIST
+do
+    eval test_name=\"\$TEST_NAME_$SUF\"
+    eval should_pass=\"\$SHOULD_PASS_$SUF\"
+
+    (get_client_test_result "${test_name}" "${should_pass}")
+done
+
+exit $retval
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
new file mode 100755
index 0000000..63b6bcd
--- /dev/null
+++ b/tests/t_server_null_default.rc
@@ -0,0 +1,66 @@
+# Notes regarding --dev null server and client configurations:
+#
+# The t_server_null_server.sh exits when all client pid files have gone
+# missing. That is the most reliable and fastest way to detect client
+# disconnections in the "everything runs on localhost" context. Checking server
+# status files for client connections works, but introduces long delays as
+# --explicit-exit-notify does not seem to work on all client configurations.
+# This means that, by default, there is about 1 minute delay before the server
+# purges clients that have already exited and have not reported back.
+#
+srcdir="${srcdir:-.}"
+top_builddir="${top_builddir:-..}"
+sample_keys="${srcdir}/../sample/sample-keys"
+
+DH="${sample_keys}/dh2048.pem"
+CA="${sample_keys}/ca.crt"
+CLIENT_CERT="${sample_keys}/client.crt"
+CLIENT_KEY="${sample_keys}/client.key"
+SERVER_CERT="${sample_keys}/server.crt"
+SERVER_KEY="${sample_keys}/server.key"
+TA="${sample_keys}/ta.key"
+
+# Test server configurations
+MAX_CLIENTS="10"
+CLIENT_MATCH="Test-Client"
+SERVER_EXEC="${top_builddir}/src/openvpn/openvpn"
+SERVER_BASE_OPTS="--daemon --local 127.0.0.1 --dev tun --topology subnet --server 10.29.41.0 255.255.255.0 --max-clients $MAX_CLIENTS --persist-tun --verb 3"
+SERVER_CIPHER_OPTS=""
+SERVER_CERT_OPTS="--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0"
+SERVER_CONF_BASE="${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}"
+
+TEST_SERVER_LIST="1 2"
+
+SERVER_NAME_1="t_server_null_server-1194_udp"
+SERVER_MGMT_PORT_1="11194"
+SERVER_EXEC_1="${SERVER_EXEC}"
+SERVER_CONF_1="${SERVER_CONF_BASE} --lport 1194 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}"
+
+SERVER_NAME_2="t_server_null_server-1195_tcp"
+SERVER_MGMT_PORT_2="11195"
+SERVER_EXEC_2="${SERVER_EXEC}"
+SERVER_CONF_2="${SERVER_CONF_BASE} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"
+
+# Test client configurations
+CLIENT_EXEC="${top_builddir}/src/openvpn/openvpn"
+CLIENT_BASE_OPTS="--client --dev null --ifconfig-noexec --nobind --remote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2 --up ${srcdir}/null_client_up.sh"
+CLIENT_CIPHER_OPTS=""
+CLIENT_CERT_OPTS="--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1"
+
+TEST_RUN_LIST="1 2 3"
+CLIENT_CONF_BASE="${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}"
+
+TEST_NAME_1="t_server_null_client.sh-openvpn_current_udp"
+SHOULD_PASS_1="yes"
+CLIENT_EXEC_1="${CLIENT_EXEC}"
+CLIENT_CONF_1="${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp"
+
+TEST_NAME_2="t_server_null_client.sh-openvpn_current_tcp"
+SHOULD_PASS_2="yes"
+CLIENT_EXEC_2="${CLIENT_EXEC}"
+CLIENT_CONF_2="${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto tcp"
+
+TEST_NAME_3="t_server_null_client.sh-openvpn_current_udp_fail"
+SHOULD_PASS_3="no"
+CLIENT_EXEC_3="${CLIENT_EXEC}"
+CLIENT_CONF_3="${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto udp"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
new file mode 100755
index 0000000..9bc0c88
--- /dev/null
+++ b/tests/t_server_null_server.sh
@@ -0,0 +1,78 @@
+#!/usr/bin/env sh
+
+launch_server() {
+    server_name=$1
+    server_exec=$2
+    server_conf=$3
+    log="${server_name}.log"
+    status="${server_name}.status"
+    pid="${server_name}.pid"
+
+    # Ensure that old status, log and pid files are gone
+    rm -f "${status}" "${log}" "${pid}"
+
+    "${server_exec}" \
+        $server_conf \
+        --status "${status}" 1 \
+        --log "${log}" \
+        --writepid "${pid}" \
+        --explicit-exit-notify 3
+
+}
+
+# Load base/default configuration
+. "${srcdir}/t_server_null_default.rc" || exit 1
+
+# Load local configuration, if any
+test -r ./t_server_null.rc && . ./t_server_null.rc
+
+# Launch test servers
+for SUF in $TEST_SERVER_LIST
+do
+    eval server_name=\"\$SERVER_NAME_$SUF\"
+    eval server_exec=\"\$SERVER_EXEC_$SUF\"
+    eval server_conf=\"\$SERVER_CONF_$SUF\"
+
+    (launch_server "${server_name}" "${server_exec}" "${server_conf}")
+done
+
+# Create a list of server pid files so that servers can be killed at the end of
+# the test run.
+#
+export server_pid_files=""
+for SUF in $TEST_SERVER_LIST
+do
+    eval server_name=\"\$SERVER_NAME_$SUF\"
+    server_pid_files="${server_pid_files} ./${server_name}.pid"
+done
+
+# Wait until clients are no more, based on the presence of their pid files.
+# Based on practical testing we have to wait at least four seconds to avoid
+# accidentally exiting too early.
+count=0
+maxcount=4
+while [ $count -le $maxcount ]; do
+    if ls t_server_null_client.sh*.pid > /dev/null 2>&1
+    then
+        count=0
+        sleep 1
+    else
+	count=$(( count + 1))
+        sleep 1
+    fi
+done
+
+echo "All clients have disconnected from all servers"
+
+for PID_FILE in $server_pid_files
+do
+    SERVER_PID=$(cat "${PID_FILE}")
+    $KILL_EXEC "${SERVER_PID}"
+
+    # Make sure that the server processes are truly dead before exiting
+    while :
+    do
+        ps -p "${SERVER_PID}" > /dev/null || break
+        sleep 0.2
+    done
+done
diff --git a/tests/t_server_null_stress.sh b/tests/t_server_null_stress.sh
new file mode 100755
index 0000000..1281397
--- /dev/null
+++ b/tests/t_server_null_stress.sh
@@ -0,0 +1,33 @@
+#!/usr/bin/env sh
+#
+# Run this stress test as root to avoid sudo authorization from timing out.
+
+ITERATIONS="${1:-100}"
+
+. ./t_server_null_default.rc
+
+export pid_files=""
+for SUF in $TEST_SERVER_LIST
+do
+    eval server_name=\"\$SERVER_NAME_$SUF\"
+    pid_files="${pid_files} ./${server_name}.pid"
+done
+
+LOG_BASEDIR="make-check"
+mkdir -p "${LOG_BASEDIR}"
+
+count=0
+while [ $count -lt $ITERATIONS ]; do
+    count=$(( count + 1 ))
+    make check TESTS=t_server_null.sh SUBDIRS= > /dev/null 2>&1
+    retval=$?
+
+    echo "Iteration ${count}: return value ${retval}" >> "${LOG_BASEDIR}/make-check.log"
+    if [ $retval -ne 0 ]; then
+	DIR="${LOG_BASEDIR}/make-check-${count}"
+        mkdir -p "${DIR}"
+        cp t_server_null*.log "${DIR}/"
+        cp test-suite.log "${DIR}/"
+        ps aux|grep openvpn|grep -vE '(suppress|grep)' > "${DIR}/psaux"
+    fi
+done

