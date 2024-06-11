From: "mattock (Code Review)" <gerrit@...515...>
Date: Tue, 11 Jun 2024 10:49:32 +0000
In-Reply-To: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
References: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <386837f63e9692e24f6935d3ab0b3334454437ba-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ErG8nJVqCTQ="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add t_server_null
 test suite
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ErG8nJVqCTQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail

to look at the new patch set (#2).


Change subject: Add t_server_null test suite
......................................................................

Add t_server_null test suite

Change-Id: I1b54da258c7d15551b6c3de7522a0d19afdb66de
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M .gitignore
A doc/t_server_null.rst
M tests/Makefile.am
A tests/null_client_up.sh
A tests/t_server_null.rc-sample
A tests/t_server_null.sh
A tests/t_server_null_client.sh
A tests/t_server_null_default.rc
A tests/t_server_null_server.sh
A tests/t_server_null_stress.sh
10 files changed, 568 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/663/2

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
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Introduction
+------------
+
+The *--dev null test suite* is primary targeted at testing client connecti=
ons
+to the "just compiled" version of OpenVPN. The name is derived from "null"
+device type in OpenVPN. In particular, when *--dev null --ifconfig-noexec*=
 is
+used in OpenVPN client configuration one does not need to run OpenVPN with=
 root
+privileges because interface, routing, etc. configuration is not done at a=
ll.
+This is still enough to ensure that the OpenVPN client can connect to a se=
rver
+instance.
+
+The main features of the test suite:
+
+* Parallelized for fairly high performance
+* Mostly operating-system agnostic
+* Tested on Fedora Linux 38/39/40 and FreeBSD 14
+* POSIX-compliant
+* Tested and known to work with Bash, Dash, Ksh, Yash and FreeBSD's defaul=
t /bin/sh
+* Uses the sample certificates and keys
+* Supports running multiple servers and clients
+* Supports running servers directly as root and with sudo
+* Supports using different OpenVPN client versions
+
+  * The "current" (just compiled) version
+  * Any other OpenVPN versions that is present on the filesystem
+
+* Support testing for success as well as failure
+* Test cases (client configurations) and server setups (server configurati=
ons) are stored in a configuration file, i.e. data and code have been separ=
ated
+* Configuration file format is nearly identical to t_client.rc configurati=
on
+* Supports a set of default tests, overriding default test settings and ad=
ding local tests
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
+  * a privilege escalation tool (sudo, doas, su) and the permission to bec=
ome root
+
+Technical implementation
+------------------------
+
+The test suite is completely parallelized to allow running a large number =
of
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
+      * Launches the compiled OpenVPN server instances as root (if necessa=
ry with sudo or su) in the background. The servers are killed using their m=
anagement interface once all clients have exited.
+
+    * t_server_null_client.sh
+
+      * Waits until servers have launched. Then launch all clients, wait f=
or them to exit and then check test results by parsing the client log files=
. Each client kills itself after some delay using an "--up" script.
+
+Note that "make check" moves on once *t_server_null_client.sh* has exited.=
 At
+that point *t_server_null_server.sh* is still running, because it exists o=
nly
+after waiting a few seconds for more client connections to potentially app=
ear.
+This is a feature and not a bug, but means that launching "make check" run=
s too
+quickly might cause test failures or unexpected behavior such as leftover
+OpenVPN server processes.
+
+Configuration
+-------------
+
+The test suite reads its configuration from two files:
+
+* *tests/t_server_null_defaults.rc:* default test configuration that shoul=
d work on any system
+* *tests/t_server_null.rc:* a local configuration file; can be used to add=
 additional tests or override settings from the default test configuration.=
 Must be present or tests will be skipped, but can be an empty file.
+
+The configuration syntax is very similar to *t_client.rc*. New server inst=
ances can be
+defined like this::
+
+  SERVER_NAME_5=3D"t_server_null_server-11195_udp"
+  SERVER_MGMT_PORT_5=3D"11195"
+  SERVER_EXEC_5=3D"${SERVER_EXEC}"
+  SERVER_CONF_5=3D"${SERVER_CONF_BASE} --lport 11195 --proto udp --managem=
ent 127.0.0.1 ${SERVER_MGMT_PORT_5}"
+
+In this case the server instance identifier is **5**. Variables such as
+*SERVER_EXEC* and *SERVER_CONF_BASE* are defined in
+*t_server_null_defaults.rc*. To enable this server instance add it to the
+server list::
+
+  TEST_SERVER_LIST=3D"1 2 5"
+
+The client instances are added similarly::
+
+  TEST_NAME_9=3D"t_server_null_client.sh-openvpn_current_udp_custom"
+  SHOULD_PASS_9=3D"yes"
+  CLIENT_EXEC_9=3D"${CLIENT_EXEC}"
+  CLIENT_CONF_9=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto=
 udp"
+
+In this case the test identifier is **9**. *CLIENT_EXEC* and *CLIENT_CONF_=
BASE*
+are defined in *t_server_null_defaults.rc*. The variable *SHOULD_PASS*
+determines that this particular test is supposed to succeed and not fail. =
 To
+enable this client instance add it to the test list::
+
+  TEST_RUN_LIST=3D"1 2 5 9"
+
+Stress-testing the --dev null test suite
+----------------------------------------
+
+It is very easy to introduce subtle, difficult to debug issues to the --dev
+null tests when you make changes to it. These issues can be difficult to s=
pot:
+based on practical experience a bad change can make the test failure rate =
go
+from 0% (normal) to anywhere between 1% and 20%. You can spot these issues=
 with
+the provided stress-test script, *t_server_null_stress.sh*. It calls *make=
 check*
+over and over again in a loop and when failures occur it saves the output =
under
+*tests/make-check*.
+
+To follow the test flow on Linux you can run this while stress-testing::
+
+    watch -n 0.5 "ps aux|grep -E '(openvpn|t_server_null_server.sh)'|grep =
-vE '(suppress|grep|tail)'"
+
+Regarding privilege escalation
+------------------------------
+
+The --dev null test servers need to be launched as root. Either run the te=
sts
+as root directly, or configure a privilege escalation tool of your choice =
in
+*t_server_null.rc*. For example, to use sudo::
+
+    SUDO_EXEC=3D`which sudo`
+    RUN_SUDO=3D"${SUDO_EXEC} -E"
+
+If you do stress-testing with *t_server_null_stress.sh* make sure your
+privilege escalation authorization does not time out: if it does, then a
+reauthorization prompt will interrupt your tests.
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 5e9ad0a..f26b3b8 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -15,10 +15,10 @@
 SUBDIRS =3D unit_tests

 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) System Tests'
-LOG_DRIVER =3D $(SHELL) $(top_srcdir)/forked-test-driver
+SH_LOG_DRIVER =3D $(SHELL) $(top_srcdir)/forked-test-driver

 if !WIN32
-test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
+test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh t_server_null.sh

 check_PROGRAMS =3D ntlm_support
 if HAVE_SITNL
@@ -27,6 +27,7 @@
 endif

 TESTS_ENVIRONMENT =3D top_srcdir=3D"$(top_srcdir)"
+TEST_EXTENSIONS =3D .sh
 TESTS =3D $(test_scripts)

 dist_noinst_SCRIPTS =3D \
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
 dist_noinst_DATA =3D \
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
+# Determine the OpenVPN PID from its pid file. This works reliably even wh=
en
+# the OpenVPN process is backgrounded for parallel tests.
+MY_PPID=3D`cat $pid`
+
+# Allow OpenVPN to finish initializing while waiting in the background and=
 then
+# killing the process gracefully.
+(sleep 5 ; kill -15 $MY_PPID) &
diff --git a/tests/t_server_null.rc-sample b/tests/t_server_null.rc-sample
new file mode 100644
index 0000000..28c3773
--- /dev/null
+++ b/tests/t_server_null.rc-sample
@@ -0,0 +1,15 @@
+# Uncomment to run tests with sudo
+#SUDO_EXEC=3D`which sudo`
+#RUN_SUDO=3D"${SUDO_EXEC} -E"
+
+TEST_RUN_LIST=3D"1 2 3 10 11"
+
+TEST_NAME_10=3D"t_server_null_client.sh-openvpn_2_6_8_udp"
+SHOULD_PASS_10=3D"yes"
+CLIENT_EXEC_10=3D"/usr/sbin/openvpn"
+CLIENT_CONF_10=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto =
udp"
+
+TEST_NAME_11=3D"t_server_null_client.sh-openvpn_2_6_8_tcp"
+SHOULD_PASS_11=3D"yes"
+CLIENT_EXEC_11=3D"/usr/sbin/openvpn"
+CLIENT_CONF_11=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto =
tcp"
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
new file mode 100755
index 0000000..cfca5ee
--- /dev/null
+++ b/tests/t_server_null.sh
@@ -0,0 +1,72 @@
+#!/usr/bin/env sh
+#
+TSERVER_NULL_SKIP_RC=3D"${TSERVER_NULL_SKIP_RC:-77}"
+
+if ! [ -r "./t_server_null.rc" ] ; then
+    echo "${0}: cannot find './t_server_null.rc. SKIPPING TEST.'" >&2
+    exit "${TSERVER_NULL_SKIP_RC}"
+fi
+
+. ./t_server_null.rc
+
+if KILL_EXEC=3D$(which kill); then
+    export KILL_EXEC
+else
+    echo "${0}: kill not found in \$PATH" >&2
+    exit "${TSERVER_NULL_SKIP_RC}"
+fi
+
+# Ensure PREFER_KSU is in a known state
+PREFER_KSU=3D"${PREFER_KSU:-0}"
+
+# make sure we have permissions to run ifconfig/route from OpenVPN
+# can't use "id -u" here - doesn't work on Solaris
+ID=3D$(id)
+if expr "$ID" : "uid=3D0" >/dev/null
+then :
+else
+    if [ "${PREFER_KSU}" -eq 1 ];
+    then
+        # Check if we have a valid kerberos ticket
+        if klist -l 1>/dev/null 2>/dev/null; then
+            RUN_SUDO=3D"ksu -q -e"
+        else
+            # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
+            PREFER_KSU=3D0
+            echo "${0}: No Kerberos ticket available.  Will not use ksu."
+        fi
+    fi
+
+    if [ -z "$RUN_SUDO" ]
+    then
+        echo "${0}: this test must run be as root, or RUN_SUDO=3D... " >&2
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
+srcdir=3D"${srcdir:-.}"
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
+# their network interfaces are gone. Otherwise t_client.sh will fail becau=
se
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
+    test_name=3D$1
+    log=3D"${test_name}.log"
+    pid=3D"${test_name}.pid"
+    client_exec=3D$2
+    client_conf=3D$3
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
+    tests_running=3D"yes"
+
+    # Wait a bit to allow an OpenVPN client process to create a pidfile to
+    # prevent exiting too early
+    sleep 1
+
+    while [ "${tests_running}" =3D "yes" ]; do
+        tests_running=3D"no"
+        for t in $test_names; do
+            if [ -f "${t}.pid" ]; then
+                tests_running=3D"yes"
+            fi
+        done
+
+        if [ "${tests_running}" =3D "yes" ]; then
+            echo "Clients still running"
+            sleep 1
+        fi
+    done
+}
+
+get_client_test_result() {
+    test_name=3D$1
+    should_pass=3D$2
+    log=3D"${test_name}.log"
+
+    grep "Initialization Sequence Completed" "${log}" > /dev/null
+    exit_code=3D$?
+
+    if [ $exit_code -eq 0 ] && [ "${should_pass}" =3D "yes" ]; then
+        echo "PASS ${test_name}"
+    elif [ $exit_code -eq 1 ] && [ "${should_pass}" =3D "no" ]; then
+        echo "PASS ${test_name} (test failure)"
+    elif [ $exit_code -eq 0 ] && [ "${should_pass}" =3D "no" ]; then
+        echo "FAIL ${test_name} (test failure)"
+        cat "${log}"
+        retval=3D1
+    elif [ $exit_code -eq 1 ] && [ "${should_pass}" =3D "yes" ]; then
+        echo "FAIL ${test_name}"
+        cat "${log}"
+        retval=3D1
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
+export retval=3D0
+
+# Wait until servers are up. This check is based on the presence of proces=
ses
+# matching the PIDs in each servers PID files
+count=3D0
+server_max_wait=3D15
+while [ $count -lt $server_max_wait ]; do
+    server_pids=3D""
+    server_count=3D$(set|grep 'SERVER_NAME_'|wc -l)
+
+    # We need to trim single-quotes because some shells return quoted valu=
es
+    # and some don't. Using "set -o posix" which would resolve this proble=
m is
+    # not supported in all shells.
+    for i in `set|grep 'SERVER_NAME_'|cut -d "=3D" -f 2|tr -d "[\']"`; do
+        server_pid=3D$(cat $i.pid 2> /dev/null)
+        server_pids=3D"${server_pids} ${server_pid}"
+    done
+
+    servers_up=3D$(ps -p $server_pids 2>/dev/null|sed '1d'|wc -l)
+
+    echo "OpenVPN test servers up: ${servers_up}/${server_count}"
+
+    if [ $servers_up -ge $server_count ]; then
+        retval=3D0
+        break
+    else
+        count=3D$(( count + 1))
+        sleep 1
+    fi
+
+    if [ $count -eq $server_max_wait ]; then
+        retval=3D1
+    fi
+done
+
+# Wait a while to let server processes to settle down
+sleep 1
+
+# Launch OpenVPN clients. While at it, construct a list of test names. The=
 list
+# is used later to determine when all OpenVPN clients have exited and it is
+# safe to check the test results.
+test_names=3D""
+for SUF in $TEST_RUN_LIST
+do
+    eval test_name=3D\"\$TEST_NAME_$SUF\"
+    eval client_exec=3D\"\$CLIENT_EXEC_$SUF\"
+    eval client_conf=3D\"\$CLIENT_CONF_$SUF\"
+
+    test_names=3D"${test_names} ${test_name}"
+    (launch_client "${test_name}" "${client_exec}" "${client_conf}")
+done
+
+# Wait until all OpenVPN clients have exited
+(wait_for_results)
+
+# Check test results
+for SUF in $TEST_RUN_LIST
+do
+    eval test_name=3D\"\$TEST_NAME_$SUF\"
+    eval should_pass=3D\"\$SHOULD_PASS_$SUF\"
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
+# disconnections in the "everything runs on localhost" context. Checking s=
erver
+# status files for client connections works, but introduces long delays as
+# --explicit-exit-notify does not seem to work on all client configuration=
s.
+# This means that, by default, there is about 1 minute delay before the se=
rver
+# purges clients that have already exited and have not reported back.
+#
+srcdir=3D"${srcdir:-.}"
+top_builddir=3D"${top_builddir:-..}"
+sample_keys=3D"${srcdir}/../sample/sample-keys"
+
+DH=3D"${sample_keys}/dh2048.pem"
+CA=3D"${sample_keys}/ca.crt"
+CLIENT_CERT=3D"${sample_keys}/client.crt"
+CLIENT_KEY=3D"${sample_keys}/client.key"
+SERVER_CERT=3D"${sample_keys}/server.crt"
+SERVER_KEY=3D"${sample_keys}/server.key"
+TA=3D"${sample_keys}/ta.key"
+
+# Test server configurations
+MAX_CLIENTS=3D"10"
+CLIENT_MATCH=3D"Test-Client"
+SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
+SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --server 10.29.41.0 255.255.255.0 --max-clients $MAX_CLIENTS --persist-tun=
 --verb 3"
+SERVER_CIPHER_OPTS=3D""
+SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
+SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"
+
+TEST_SERVER_LIST=3D"1 2"
+
+SERVER_NAME_1=3D"t_server_null_server-1194_udp"
+SERVER_MGMT_PORT_1=3D"11194"
+SERVER_EXEC_1=3D"${SERVER_EXEC}"
+SERVER_CONF_1=3D"${SERVER_CONF_BASE} --lport 1194 --proto udp --management=
 127.0.0.1 ${SERVER_MGMT_PORT_1}"
+
+SERVER_NAME_2=3D"t_server_null_server-1195_tcp"
+SERVER_MGMT_PORT_2=3D"11195"
+SERVER_EXEC_2=3D"${SERVER_EXEC}"
+SERVER_CONF_2=3D"${SERVER_CONF_BASE} --lport 1195 --proto tcp --management=
 127.0.0.1 ${SERVER_MGMT_PORT_2}"
+
+# Test client configurations
+CLIENT_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
+CLIENT_BASE_OPTS=3D"--client --dev null --ifconfig-noexec --nobind --remot=
e-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-=
retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-secur=
ity 2 --up ${srcdir}/null_client_up.sh"
+CLIENT_CIPHER_OPTS=3D""
+CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"
+
+TEST_RUN_LIST=3D"1 2 3"
+CLIENT_CONF_BASE=3D"${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CER=
T_OPTS}"
+
+TEST_NAME_1=3D"t_server_null_client.sh-openvpn_current_udp"
+SHOULD_PASS_1=3D"yes"
+CLIENT_EXEC_1=3D"${CLIENT_EXEC}"
+CLIENT_CONF_1=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto u=
dp"
+
+TEST_NAME_2=3D"t_server_null_client.sh-openvpn_current_tcp"
+SHOULD_PASS_2=3D"yes"
+CLIENT_EXEC_2=3D"${CLIENT_EXEC}"
+CLIENT_CONF_2=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto t=
cp"
+
+TEST_NAME_3=3D"t_server_null_client.sh-openvpn_current_udp_fail"
+SHOULD_PASS_3=3D"no"
+CLIENT_EXEC_3=3D"${CLIENT_EXEC}"
+CLIENT_CONF_3=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto =
udp"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
new file mode 100755
index 0000000..9bc0c88
--- /dev/null
+++ b/tests/t_server_null_server.sh
@@ -0,0 +1,78 @@
+#!/usr/bin/env sh
+
+launch_server() {
+    server_name=3D$1
+    server_exec=3D$2
+    server_conf=3D$3
+    log=3D"${server_name}.log"
+    status=3D"${server_name}.status"
+    pid=3D"${server_name}.pid"
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
+    eval server_name=3D\"\$SERVER_NAME_$SUF\"
+    eval server_exec=3D\"\$SERVER_EXEC_$SUF\"
+    eval server_conf=3D\"\$SERVER_CONF_$SUF\"
+
+    (launch_server "${server_name}" "${server_exec}" "${server_conf}")
+done
+
+# Create a list of server pid files so that servers can be killed at the e=
nd of
+# the test run.
+#
+export server_pid_files=3D""
+for SUF in $TEST_SERVER_LIST
+do
+    eval server_name=3D\"\$SERVER_NAME_$SUF\"
+    server_pid_files=3D"${server_pid_files} ./${server_name}.pid"
+done
+
+# Wait until clients are no more, based on the presence of their pid files.
+# Based on practical testing we have to wait at least four seconds to avoid
+# accidentally exiting too early.
+count=3D0
+maxcount=3D4
+while [ $count -le $maxcount ]; do
+    if ls t_server_null_client.sh*.pid > /dev/null 2>&1
+    then
+        count=3D0
+        sleep 1
+    else
+	count=3D$(( count + 1))
+        sleep 1
+    fi
+done
+
+echo "All clients have disconnected from all servers"
+
+for PID_FILE in $server_pid_files
+do
+    SERVER_PID=3D$(cat "${PID_FILE}")
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
+ITERATIONS=3D"${1:-100}"
+
+. ./t_server_null_default.rc
+
+export pid_files=3D""
+for SUF in $TEST_SERVER_LIST
+do
+    eval server_name=3D\"\$SERVER_NAME_$SUF\"
+    pid_files=3D"${pid_files} ./${server_name}.pid"
+done
+
+LOG_BASEDIR=3D"make-check"
+mkdir -p "${LOG_BASEDIR}"
+
+count=3D0
+while [ $count -lt $ITERATIONS ]; do
+    count=3D$(( count + 1 ))
+    make check TESTS=3Dt_server_null.sh SUBDIRS=3D > /dev/null 2>&1
+    retval=3D$?
+
+    echo "Iteration ${count}: return value ${retval}" >> "${LOG_BASEDIR}/m=
ake-check.log"
+    if [ $retval -ne 0 ]; then
+	DIR=3D"${LOG_BASEDIR}/make-check-${count}"
+        mkdir -p "${DIR}"
+        cp t_server_null*.log "${DIR}/"
+        cp test-suite.log "${DIR}/"
+        ps aux|grep openvpn|grep -vE '(suppress|grep)' > "${DIR}/psaux"
+    fi
+done

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522a0d19afdb66de
Gerrit-Change-Number: 663
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-MessageType: newpatchset

--ErG8nJVqCTQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>mattock <strong>uploaded patch set #2</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail">View Change<=
/a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add t_server_null test suite<br><br>Change-Id: I1b54da258c7d15551b6c3de=
7522a0d19afdb66de<br>Signed-off-by: Samuli Sepp=C3=A4nen &lt;samuli.seppane=
n@...277...&gt;<br>---<br>M .gitignore<br>A doc/t_server_null.rst<br>M test=
s/Makefile.am<br>A tests/null_client_up.sh<br>A tests/t_server_null.rc-samp=
le<br>A tests/t_server_null.sh<br>A tests/t_server_null_client.sh<br>A test=
s/t_server_null_default.rc<br>A tests/t_server_null_server.sh<br>A tests/t_=
server_null_stress.sh<br>10 files changed, 568 insertions(+), 2 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63=
/663/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/.gitignore b/.gitignore</span><br><span>index 9=
2d65bf..db8bb73 100644</span><br><span>--- a/.gitignore</span><br><span>+++=
 b/.gitignore</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </span><br=
><span> tests/t_client.sh</span><br><span> tests/t_client-*-20??????-??????=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tests/t_server_nul=
l.rc</span><br><span> t_client.rc</span><br><span> t_client_ips.rc</span><b=
r><span> tests/unit_tests/**/*_testdriver</span><br><span>diff --git a/doc/=
t_server_null.rst b/doc/t_server_null.rst</span><br><span>new file mode 100=
644</span><br><span>index 0000000..e3a098a</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/doc/t_server_null.rst</span><br><span>@@ -0,0 +1,147 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Notes for the --dev=
 null test suite</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Introductio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+------------</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+The *--dev null test suite* is primary targe=
ted at testing client connections</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+to the &quot;just compiled&quot; version of OpenVPN. The name=
 is derived from &quot;null&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+device type in OpenVPN. In particular, when *--dev null --ifc=
onfig-noexec* is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+use=
d in OpenVPN client configuration one does not need to run OpenVPN with roo=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+privileges because=
 interface, routing, etc. configuration is not done at all.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+This is still enough to ensure that=
 the OpenVPN client can connect to a server</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+instance.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The m=
ain features of the test suite:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Paral=
lelized for fairly high performance</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+* Mostly operating-system agnostic</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+* Tested on Fedora Linux 38/39/40 and FreeBS=
D 14</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* POSIX-complia=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Tested and know=
n to work with Bash, Dash, Ksh, Yash and FreeBSD&#39;s default /bin/sh</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+* Uses the sample certif=
icates and keys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Su=
pports running multiple servers and clients</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+* Supports running servers directly as root and wit=
h sudo</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Supports us=
ing different OpenVPN client versions</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 * The &quot;current&quot; (just compiled) version</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  * Any other OpenVPN versions that is prese=
nt on the filesystem</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Support testing =
for success as well as failure</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+* Test cases (client configurations) and server setups (server c=
onfigurations) are stored in a configuration file, i.e. data and code have =
been separated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Con=
figuration file format is nearly identical to t_client.rc configuration</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+* Supports a set of def=
ault tests, overriding default test settings and adding local tests</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+Prerequisites</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+-------------</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Ru=
nning the test suite requires the following:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+* *bash* for running the tests</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+* root-level privileges for launching the servers</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  * run as root</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  * a privilege escalation tool (sudo, doas, su) an=
d the permission to become root</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Technic=
al implementation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--=
----------------------</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The test suite i=
s completely parallelized to allow running a large number of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+server and client combinations qui=
ckly.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+A normal test run looks like this=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#. Server instances start</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#. Brief wait</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#. Client instances start</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#. Tests run</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#. Client instances stop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#. Brief wait</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#. Server instances stop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+The tests suite is launched via &quot;make check&quot=
;:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+* make check</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  * t_server_null.sh</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 * t_server_null_server.sh</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      * Laun=
ches the compiled OpenVPN server instances as root (if necessary with sudo =
or su) in the background. The servers are killed using their management int=
erface once all clients have exited.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  * t_server_null_client.sh</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      * Wai=
ts until servers have launched. Then launch all clients, wait for them to e=
xit and then check test results by parsing the client log files. Each clien=
t kills itself after some delay using an &quot;--up&quot; script.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+Note that &quot;make check&quot; moves on once *=
t_server_null_client.sh* has exited. At</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+that point *t_server_null_server.sh* is still running, =
because it exists only</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+after waiting a few seconds for more client connections to potentially a=
ppear.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+This is a fea=
ture and not a bug, but means that launching &quot;make check&quot; runs to=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+quickly might caus=
e test failures or unexpected behavior such as leftover</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+OpenVPN server processes.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+Configuration</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+-------------</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The test=
 suite reads its configuration from two files:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+* *tests/t_server_null_defaults.rc:* default test configuration tha=
t should work on any system</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+* *tests/t_server_null.rc:* a local configuration file; can be used=
 to add additional tests or override settings from the default test configu=
ration. Must be present or tests will be skipped, but can be an empty file.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+The configuration syntax is very simil=
ar to *t_client.rc*. New server instances can be</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+defined like this::</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  SERVER_NAME_5=3D&quot;t_server_null_server-11195_udp&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  SERVER_MGMT_PORT_5=3D&=
quot;11195&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  S=
ERVER_EXEC_5=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  SERVER_CONF_5=3D&quot;${SERVER_CONF_BASE} --lport 1=
1195 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_5}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+In this case the server instance identifier is=
 **5**. Variables such as</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+*SERVER_EXEC* and *SERVER_CONF_BASE* are defined in</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+*t_server_null_defaults.rc*. To enabl=
e this server instance add it to the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+server list::</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  TEST_S=
ERVER_LIST=3D&quot;1 2 5&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The clie=
nt instances are added similarly::</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  TE=
ST_NAME_9=3D&quot;t_server_null_client.sh-openvpn_current_udp_custom&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  SHOULD_PASS_9=3D&q=
uot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  CLIE=
NT_EXEC_9=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  CLIENT_CONF_9=3D&quot;${CLIENT_CONF_BASE} --remote 127=
.0.0.1 1194 udp --proto udp&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+In th=
is case the test identifier is **9**. *CLIENT_EXEC* and *CLIENT_CONF_BASE*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+are defined in *t_se=
rver_null_defaults.rc*. The variable *SHOULD_PASS*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+determines that this particular test is supp=
osed to succeed and not fail.  To</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+enable this client instance add it to the test list::</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  TEST_RUN_LIST=3D&quot;1 2 5 9&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+Stress-testing the --dev null test suite</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+--------------------------=
--------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+It is very easy to intro=
duce subtle, difficult to debug issues to the --dev</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+null tests when you make changes to it. T=
hese issues can be difficult to spot:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+based on practical experience a bad change can make the t=
est failure rate go</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
from 0% (normal) to anywhere between 1% and 20%. You can spot these issues =
with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the provided st=
ress-test script, *t_server_null_stress.sh*. It calls *make check*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+over and over again in a loo=
p and when failures occur it saves the output under</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+*tests/make-check*.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+To follow the test flow on Linux you can run this while stre=
ss-testing::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    watch -n 0.5 &quot;ps =
aux|grep -E &#39;(openvpn|t_server_null_server.sh)&#39;|grep -vE &#39;(supp=
ress|grep|tail)&#39;&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Regarding pr=
ivilege escalation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-----------------------------</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The --dev=
 null test servers need to be launched as root. Either run the tests</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+as root directly, or confi=
gure a privilege escalation tool of your choice in</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+*t_server_null.rc*. For example, to use sudo=
::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SUDO_EXEC=3D`which sudo`</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    RUN_SUDO=3D&quot;${SUDO=
_EXEC} -E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+If you do stress-testin=
g with *t_server_null_stress.sh* make sure your</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+privilege escalation authorization does not tim=
e out: if it does, then a</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+reauthorization prompt will interrupt your tests.</span><br><span>dif=
f --git a/tests/Makefile.am b/tests/Makefile.am</span><br><span>index 5e9ad=
0a..f26b3b8 100644</span><br><span>--- a/tests/Makefile.am</span><br><span>=
+++ b/tests/Makefile.am</span><br><span>@@ -15,10 +15,10 @@</span><br><span=
> SUBDIRS =3D unit_tests</span><br><span> </span><br><span> AM_TESTSUITE_SU=
MMARY_HEADER =3D &#39; for $(PACKAGE_STRING) System Tests&#39;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-LOG_DRIVER =3D $(SHELL) $(top_srcd=
ir)/forked-test-driver</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+SH_LOG_DRIVER =3D $(SHELL) $(top_srcdir)/forked-test-driver</span><br><s=
pan> </span><br><span> if !WIN32</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_scripts =3D t_client.sh t_=
lpback.sh t_cltsrv.sh t_server_null.sh</span><br><span> </span><br><span> c=
heck_PROGRAMS =3D ntlm_support</span><br><span> if HAVE_SITNL</span><br><sp=
an>@@ -27,6 +27,7 @@</span><br><span> endif</span><br><span> </span><br><sp=
an> TESTS_ENVIRONMENT =3D top_srcdir=3D&quot;$(top_srcdir)&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+TEST_EXTENSIONS =3D .sh</span>=
<br><span> TESTS =3D $(test_scripts)</span><br><span> </span><br><span> dis=
t_noinst_SCRIPTS =3D \</span><br><span>@@ -34,8 +35,14 @@</span><br><span> =
	t_cltsrv-down.sh \</span><br><span> 	t_lpback.sh \</span><br><span> 	t_net=
.sh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	t_server_null=
.sh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	t_server_null=
_client.sh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	t_serv=
er_null_server.sh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	t_server_null_default.rc \</span><br><span> 	update_t_client_ips.sh</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+t_client=
.log: t_server_null.log</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> dist_noinst_DATA =3D \</span><br><span> 	t_client.rc-=
sample</span><br><span> </span><br><span>diff --git a/tests/null_client_up.=
sh b/tests/null_client_up.sh</span><br><span>new file mode 100755</span><br=
><span>index 0000000..d4df0c6</span><br><span>--- /dev/null</span><br><span=
>+++ b/tests/null_client_up.sh</span><br><span>@@ -0,0 +1,11 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Stop the parent process (openvpn) gracefully after a smal=
l delay</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# Determine the OpenVPN PID fro=
m its pid file. This works reliably even when</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# the OpenVPN process is backgrounded for paralle=
l tests.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MY_PPID=3D`=
cat $pid`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# Allow OpenVPN to finish ini=
tializing while waiting in the background and then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# killing the process gracefully.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+(sleep 5 ; kill -15 $MY_PPID) =
&amp;</span><br><span>diff --git a/tests/t_server_null.rc-sample b/tests/t_=
server_null.rc-sample</span><br><span>new file mode 100644</span><br><span>=
index 0000000..28c3773</span><br><span>--- /dev/null</span><br><span>+++ b/=
tests/t_server_null.rc-sample</span><br><span>@@ -0,0 +1,15 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Uncomment to run tests with su=
do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#SUDO_EXEC=3D`whi=
ch sudo`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#RUN_SUDO=
=3D&quot;${SUDO_EXEC} -E&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_RUN=
_LIST=3D&quot;1 2 3 10 11&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NA=
ME_10=3D&quot;t_server_null_client.sh-openvpn_2_6_8_udp&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_10=3D&quot;yes&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_10=3D&qu=
ot;/usr/sbin/openvpn&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+CLIENT_CONF_10=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 u=
dp --proto udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_11=3D&qu=
ot;t_server_null_client.sh-openvpn_2_6_8_tcp&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+SHOULD_PASS_11=3D&quot;yes&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_11=3D&quot;/usr/sbi=
n/openvpn&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIE=
NT_CONF_11=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto =
tcp&quot;</span><br><span>diff --git a/tests/t_server_null.sh b/tests/t_ser=
ver_null.sh</span><br><span>new file mode 100755</span><br><span>index 0000=
000..cfca5ee</span><br><span>--- /dev/null</span><br><span>+++ b/tests/t_se=
rver_null.sh</span><br><span>@@ -0,0 +1,72 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#!/usr/bin/env sh</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+TSERVER_NULL_SKIP_RC=3D&quot;${TSERVER_NULL_SKIP_RC:-77}&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+if ! [ -r &quot;./t_server_null.rc&quot; ] ; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;=
${0}: cannot find &#39;./t_server_null.rc. SKIPPING TEST.&#39;&quot; &gt;&a=
mp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit &quot;=
${TSERVER_NULL_SKIP_RC}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+. ./t_server_null.rc</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+if KILL_EXEC=3D$(which kill); then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    export KILL_EXEC</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo &quot;${0}: kill not found in \$=
PATH&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Ensure =
PREFER_KSU is in a known state</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+PREFER_KSU=3D&quot;${PREFER_KSU:-0}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# make sure we have permissions to run ifconfig/route from O=
penVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# can&#39;t u=
se &quot;id -u&quot; here - doesn&#39;t work on Solaris</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ID=3D$(id)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+if expr &quot;$ID&quot; : &quot;uid=3D0&quot; &g=
t;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+then :</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;${PREFER_KSU}&quot; -=
eq 1 ];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        # Check if we h=
ave a valid kerberos ticket</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if klist -l 1&gt;/dev/null 2&gt;/dev/null; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            RUN_SUDO=3D&quot;ks=
u -q -e&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            #=
 No kerberos ticket found, skip ksu and fallback to RUN_SUDO</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            PREFER_KSU=3D0</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;${0}=
: No Kerberos ticket available.  Will not use ksu.&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if [ -z &quot;$RUN_SUDO&quot; ]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        echo &quot;${0}: this test must run be as root, or RUN_SUDO=3D... =
&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      echo &quot;      must be set correctly in &#39;t_server_null.rc&#39;.=
 SKIP.&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	# Run a no-op command with privilege escalation (e.=
g. sudo) so that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# =
we (hopefully) do not have to ask the users password during the test.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	if $RUN_SUDO &quot;${KIL=
L_EXEC}&quot; -0 $$</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    echo &quo=
t;${0}: $RUN_SUDO $KILL_EXEC -0 succeeded, good.&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	    echo &quot;${0}: $RUN_SUDO $KILL_EXEC -0 failed, =
cannot go on. SKIP.&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	    exit &quot;${TSERVER_NULL_SKIP_RC}&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	fi</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+srcdir=3D&quot;${srcdi=
r:-.}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;${RUN_SUDO}&q=
uot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;${srcdir}/t_server_null_server.sh&quot; &amp;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    $RUN_SUDO &quot;${srcdir}/t_server_null_server.sh&quot; &=
amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+&quot;${srcdir}/t_server_null_client.sh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# When running make jobs in parallel (&quot;=
make -j&lt;x&gt; check&quot;) we need to ensure</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# that this script does not exit before all --d=
ev null servers are dead and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# their network interfaces are gone. Otherwise t_client.sh will fa=
il because</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# pre and=
 post ifconfig output does not match.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+wait</span><br><span>diff --git a/tests/t_server_null_cli=
ent.sh b/tests/t_server_null_client.sh</span><br><span>new file mode 100755=
</span><br><span>index 0000000..5d5542b</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/t_server_null_client.sh</span><br><span>@@ -0,0 +1,1=
36 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env=
 sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+launch_client() {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    test_name=3D$1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    log=3D&quot;${test_name}.log&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pid=3D&quot;${t=
est_name}.pid&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    client_exec=3D$2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    client_conf=3D$3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Ensure that=
 old log and pid files are gone</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    rm -f &quot;${log}&quot; &quot;${pid}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;${client_exec}&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        $client_conf \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        --writepid &quot;${pid}&quot; =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --setenv p=
id $pid \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --=
log &quot;${log}&quot; &amp;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+wait_for_results() {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    tests_running=3D&quot;y=
es&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    # Wait a bit to allow an O=
penVPN client process to create a pidfile to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    # prevent exiting too early</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    sleep 1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    while [ &quot;${tests_running}&quot; =3D &quot;yes&quot; ]; d=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests_runn=
ing=3D&quot;no&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        for t in $test_names; do</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if [ -f &quot;${t}.pid&quot; ]; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                tests_running=3D=
&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if [ &quot;${tests_running}=
&quot; =3D &quot;yes&quot; ]; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            echo &quot;Clients still running&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            sleep 1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_client_=
test_result() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
test_name=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
hould_pass=3D$2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
log=3D&quot;${test_name}.log&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
grep &quot;Initialization Sequence Completed&quot; &quot;${log}&quot; &gt; =
/dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit_c=
ode=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if [ $exit_code -eq 0 ] &a=
mp;&amp; [ &quot;${should_pass}&quot; =3D &quot;yes&quot; ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;PASS ${tes=
t_name}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
if [ $exit_code -eq 1 ] &amp;&amp; [ &quot;${should_pass}&quot; =3D &quot;n=
o&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    echo &quot;PASS ${test_name} (test failure)&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    elif [ $exit_code -eq 0 ] &amp;&amp; =
[ &quot;${should_pass}&quot; =3D &quot;no&quot; ]; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        echo &quot;FAIL ${test_name} (t=
est failure)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cat &quot;${log}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        retval=3D1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    elif [ $exit_code -eq 1 ] &amp;&amp; [ &quot;${should_pass}&qu=
ot; =3D &quot;yes&quot; ]; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        echo &quot;FAIL ${test_name}&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cat &quot;${log}&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        retval=3D1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# L=
oad basic/default tests</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+. ${srcdir}/t_server_null_default.rc || exit 1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# Load additional local tests, if any</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test -r ./t_server_null.rc &amp;&amp; . ./t_s=
erver_null.rc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# Return value for the en=
tire test suite. Gets set to 1 if any test fails.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+export retval=3D0</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# Wait until servers are up. This check is based on the presence o=
f processes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# matchi=
ng the PIDs in each servers PID files</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+count=3D0</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+server_max_wait=3D15</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+while [ $count -lt $server_max_wait ]; do</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    server_pids=3D&quot;&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    server_count=3D$(set|grep &#3=
9;SERVER_NAME_&#39;|wc -l)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # We nee=
d to trim single-quotes because some shells return quoted values</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    # and some don&#39;t. Usin=
g &quot;set -o posix&quot; which would resolve this problem is</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    # not supported in all shell=
s.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for i in `set=
|grep &#39;SERVER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&#39=
;]&quot;`; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  server_pid=3D$(cat $i.pid 2&gt; /dev/null)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        server_pids=3D&quot;${server_pids} ${serve=
r_pid}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    don=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    servers_up=3D$(ps -p $server_pids=
 2&gt;/dev/null|sed &#39;1d&#39;|wc -l)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    echo &quot;OpenVPN test servers up: ${servers_up}/${server_count}&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if [ $servers_up -ge $server_coun=
t ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
tval=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bre=
ak</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        count=3D$(( count + =
1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if [ $count -eq $server_max_wait ]; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        retval=3D1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+done</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Wait a while to let server processes to settle down</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sleep 1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# Launch OpenVPN clients. While at it, construct a list of test names. T=
he list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# is used la=
ter to determine when all OpenVPN clients have exited and it is</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# safe to check the test result=
s.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_names=3D&quo=
t;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for SUF in =
$TEST_RUN_LIST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    eval test_name=3D\=
&quot;\$TEST_NAME_$SUF\&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    eval client_exec=3D\&quot;\$CLIENT_EXEC_$SUF\&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    eval client_conf=3D\&quot=
;\$CLIENT_CONF_$SUF\&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    test_nam=
es=3D&quot;${test_names} ${test_name}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    (launch_client &quot;${test_name}&quot; &quot;$=
{client_exec}&quot; &quot;${client_conf}&quot;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+done</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Wait=
 until all OpenVPN clients have exited</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+(wait_for_results)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 Check test results</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
for SUF in $TEST_RUN_LIST</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    eval te=
st_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    eval should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    (get_client_test_result &quot;${t=
est_name}&quot; &quot;${should_pass}&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+done</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exit $retv=
al</span><br><span>diff --git a/tests/t_server_null_default.rc b/tests/t_se=
rver_null_default.rc</span><br><span>new file mode 100755</span><br><span>i=
ndex 0000000..63b6bcd</span><br><span>--- /dev/null</span><br><span>+++ b/t=
ests/t_server_null_default.rc</span><br><span>@@ -0,0 +1,66 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Notes regarding --dev null ser=
ver and client configurations:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The t=
_server_null_server.sh exits when all client pid files have gone</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# missing. That is the most re=
liable and fastest way to detect client</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# disconnections in the &quot;everything runs on localh=
ost&quot; context. Checking server</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# status files for client connections works, but introduces =
long delays as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --e=
xplicit-exit-notify does not seem to work on all client configurations.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# This means that, by d=
efault, there is about 1 minute delay before the server</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# purges clients that have already exit=
ed and have not reported back.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+srcdir=
=3D&quot;${srcdir:-.}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+top_builddir=3D&quot;${top_builddir:-..}&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+sample_keys=3D&quot;${srcdir}/../sample/=
sample-keys&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+DH=3D&quot;${sample_k=
eys}/dh2048.pem&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+CA=3D&quot;${sample_keys}/ca.crt&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+CLIENT_CERT=3D&quot;${sample_keys}/client.crt&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_KEY=3D&quot;${s=
ample_keys}/client.key&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+SERVER_CERT=3D&quot;${sample_keys}/server.crt&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+SERVER_KEY=3D&quot;${sample_keys}/=
server.key&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TA=
=3D&quot;${sample_keys}/ta.key&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
Test server configurations</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+MAX_CLIENTS=3D&quot;10&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+CLIENT_MATCH=3D&quot;Test-Client&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+SERVER_EXEC=3D&quot;${top_builddir}/src/=
openvpn/openvpn&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+SERVER_BASE_OPTS=3D&quot;--daemon --local 127.0.0.1 --dev tun --topology =
subnet --server 10.29.41.0 255.255.255.0 --max-clients $MAX_CLIENTS --persi=
st-tun --verb 3&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+SERVER_CIPHER_OPTS=3D&quot;&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+SERVER_CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${SER=
VER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_BASE=3D&quot;${SERVER_BASE_O=
PTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+TEST_SERVER_LIST=3D&quot;1 2&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+SERVER_NAME_1=3D&quot;t_server_null_server-1194_udp&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_MGMT_PORT_1=3D&quot=
;11194&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_=
EXEC_1=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+SERVER_CONF_1=3D&quot;${SERVER_CONF_BASE} --lport 1194 --pr=
oto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+SERVER_NAME_2=3D&quot;t_server_null_server-1195_tcp&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_MGMT_PORT_=
2=3D&quot;11195&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+SERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+SERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} --lport =
1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# Test client configurations</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC=3D&quot;${top_builddir}/s=
rc/openvpn/openvpn&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+CLIENT_BASE_OPTS=3D&quot;--client --dev null --ifconfig-noexec --nobin=
d --remote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite -=
-connect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --scr=
ipt-security 2 --up ${srcdir}/null_client_up.sh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CLIENT_CIPHER_OPTS=3D&quot;&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CERT_OPTS=3D&quot;--=
ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1 2 3&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_BASE=3D&quot=
;${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+TEST_NAME_1=3D&quot;t_server_null_client.sh-o=
penvpn_current_udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+SHOULD_PASS_1=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+CLIENT_EXEC_1=3D&quot;${CLIENT_EXEC}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1=3D&quot;${CLIENT_CONF=
_BASE} --remote 127.0.0.1 1194 udp --proto udp&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+TEST_NAME_2=3D&quot;t_server_null_client.sh-openvpn_current_=
tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PAS=
S_2=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+CLIENT_EXEC_2=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+CLIENT_CONF_2=3D&quot;${CLIENT_CONF_BASE} --remote=
 127.0.0.1 1195 tcp --proto tcp&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+T=
EST_NAME_3=3D&quot;t_server_null_client.sh-openvpn_current_udp_fail&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_3=3D&quot=
;no&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXE=
C_3=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+CLIENT_CONF_3=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1=
1194 udp --proto udp&quot;</span><br><span>diff --git a/tests/t_server_null=
_server.sh b/tests/t_server_null_server.sh</span><br><span>new file mode 10=
0755</span><br><span>index 0000000..9bc0c88</span><br><span>--- /dev/null</=
span><br><span>+++ b/tests/t_server_null_server.sh</span><br><span>@@ -0,0 =
+1,78 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/=
env sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+launch_server() {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    server_name=3D$1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    server_exec=3D$2</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    server_conf=3D$3</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    log=3D&quot;${server_name}.=
log&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status=
=3D&quot;${server_name}.status&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    pid=3D&quot;${server_name}.pid&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    # Ensure that old status, log and pid files are gone=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rm -f &quot;${s=
tatus}&quot; &quot;${log}&quot; &quot;${pid}&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &quot;${server_exec}&quot; \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        $server_conf \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        --status &quot;${status}&quot; 1 \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        --log &quot;${lo=
g}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        -=
-writepid &quot;${pid}&quot; \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        --explicit-exit-notify 3</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Load base/default configuratio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+. &quot;${srcdir}/=
t_server_null_default.rc&quot; || exit 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# Load local configuration, if any</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test -r ./t_server_null.rc &amp;&amp; . ./t_server_null.rc=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# Launch test servers</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+for SUF in $TEST_SERVER_LIST</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+do</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    eval server_name=3D\&quot;\$SERVER_NAME_=
$SUF\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    eval=
 server_exec=3D\&quot;\$SERVER_EXEC_$SUF\&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    eval server_conf=3D\&quot;\$SERVER_CONF_$SU=
F\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    (launch_server &quot;${ser=
ver_name}&quot; &quot;${server_exec}&quot; &quot;${server_conf}&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+done</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# Create a list of server pid files so that servers can be=
 killed at the end of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# the test run.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+export server_pid_fi=
les=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
or SUF in $TEST_SERVER_LIST</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    eval =
server_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    server_pid_files=3D&quot;${server_pid_files}=
 ./${server_name}.pid&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# Wait until clients are n=
o more, based on the presence of their pid files.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# Based on practical testing we have to wait =
at least four seconds to avoid</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# accidentally exiting too early.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+count=3D0</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+maxcount=3D4</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+while [ $count -le $maxcount ]; do</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if ls t_server_null_client.sh*.pid &gt; /dev/nul=
l 2&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        count=3D0=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	count=3D$(( count + 1))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+done</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+echo =
&quot;All clients have disconnected from all servers&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+for PID_FILE in $server_pid_files</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+do</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SERVER_PID=3D$(cat &quot;${PID_FILE}&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    $KILL_EXEC &quot;${SERVER_=
PID}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    # Make sure that the ser=
ver processes are truly dead before exiting</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    while :</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    do</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ps -p &quot;${SERVER_PID}&quot; &gt; /dev/null || break</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        sleep 0.2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+done</span><br><span>diff --git a/tests/t=
_server_null_stress.sh b/tests/t_server_null_stress.sh</span><br><span>new =
file mode 100755</span><br><span>index 0000000..1281397</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/t_server_null_stress.sh</span><br><s=
pan>@@ -0,0 +1,33 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#!/usr/bin/env sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Run this stress t=
est as root to avoid sudo authorization from timing out.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ITERATIONS=3D&quot;${1:-100}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+. ./t_server_null_default.rc</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+export pid_files=3D&quot;&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+for SUF in $TEST_SERVER_LIST</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+do</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    eval server_name=3D\&quot;\$SERVER_NAME_$SUF\&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    pid_files=3D&quot;${pid_fi=
les} ./${server_name}.pid&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+LOG_BASEDIR=3D&quot;ma=
ke-check&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mkdir=
 -p &quot;${LOG_BASEDIR}&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+count=3D=
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+while [ $count -lt=
 $ITERATIONS ]; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   count=3D$(( count + 1 ))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    make check TESTS=3Dt_server_null.sh SUBDIRS=3D &gt; /dev/null 2=
&gt;&amp;1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retva=
l=3D$?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;Iteration ${count=
}: return value ${retval}&quot; &gt;&gt; &quot;${LOG_BASEDIR}/make-check.lo=
g&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ $re=
tval -ne 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
DIR=3D&quot;${LOG_BASEDIR}/make-check-${count}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mkdir -p &quot;${DIR}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cp t_server_null*=
.log &quot;${DIR}/&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cp test-suite.log &quot;${DIR}/&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ps aux|grep openvpn|grep -vE &#39;(s=
uppress|grep)&#39; &gt; &quot;${DIR}/psaux&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+done</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail">change 663</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/663?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522=
a0d19afdb66de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ErG8nJVqCTQ=--

