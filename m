From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 8 Mar 2025 08:55:03 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b11ec5293f03fec6155746e22c99e4ea03f3c021-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ypwZKy2vWtU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add lwip support to
 t_server_null
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <samuli@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ypwZKy2vWtU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#12) to the change originally created b=
y mattock. ( http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add lwip support to t_server_null
......................................................................

Add lwip support to t_server_null

Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250305134642.196598-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
019.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/t_server_null.rst
A tests/lwip_client_up.sh
M tests/t_server_null_client.sh
M tests/t_server_null_default.rc
4 files changed, 163 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/811/12

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
 * Tested and known to work with Bash, Dash, Ksh, Yash and FreeBSD's defaul=
t /bin/sh
 * Uses the sample certificates and keys
@@ -31,6 +31,7 @@
 * Test cases (client configurations) and server setups (server configurati=
ons) are stored in a configuration file, i.e. data and code have been separ=
ated
 * Configuration file format is nearly identical to t_client.rc configurati=
on
 * Supports a set of default tests, overriding default test settings and ad=
ding local tests
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

-      * Waits until servers have launched. Then launch all clients, wait f=
or them to exit and then check test results by parsing the client log files=
. Each client kills itself after some delay using an "--up" script.
+      * Waits until servers have launched. Then launch all clients, run ov=
pnlwip ping tests (if any), wait for clients to exit and then check test re=
sults by parsing the client log files. Each client kills itself after some =
delay using an "--up" script.
+

 Configuration
 -------------
@@ -116,6 +119,19 @@

   TEST_RUN_LIST=3D"1 2 5 9"

+Client ping tests that use ovpnlwip can be added similarly:
+
+  TEST_NAME_9L=3D"t_server_null_client.sh-openvpn_current_udp_custom_lwip"
+  SHOULD_PASS_9L=3D"yes"
+  CLIENT_EXEC_9L=3D"${CLIENT_EXEC}"
+  CLIENT_CONF_9L=3D"${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp -=
-proto udp"
+
+Note that all ovpnlwip test names need to include a "_lwip" suffix: withou=
t it
+ping tests won't get activated. Also note that the *tests* directory needs=
 to
+have the lwipovpn executable or ovpnlwip tests will get skipped. The ovpnl=
wip
+ping tests get the IP addresses to ping from the \*.ips files created by t=
he
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
+# Determine the OpenVPN PID from its pid file. This works reliably even wh=
en
+# the OpenVPN process is backgrounded for parallel tests.
+MY_PPID=3D`cat $pid`
+
+# Add this client's VPN IP and PID to a file. This enables
+# t_server_null_client.sh to kill this OpenVPN client after fping tests ha=
ve
+# finished.
+echo "$ifconfig_local,$MY_PPID" >> ./$test_name.lwip
+
+# Wait long enough to allow fping tests to finish. Also ensure that this
+# OpenVPN client is killed even if t_server_null_client.sh failed to do it.
+(sleep 15
+echo "ERROR: t_server_null_client.sh failed to kill OpenVPN client with PI=
D $MY_PPID in test $test_name. Killing it in lwip_client_up.sh."
+kill -15 $MY_PPID
+) &
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 2210e63..1745de5 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -1,5 +1,17 @@
 #!/bin/sh

+should_run_test() {
+    test_name=3D"$1"
+
+    if echo "$test_name"|grep -q _lwip; then
+        if [ "$has_lwipovpn" =3D "no" ]; then
+            return 1
+        fi
+    fi
+
+    return 0
+}
+
 launch_client() {
     test_name=3D$1
     log=3D"${test_name}.log"
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
+        # makes it hard to implement "fail the test suite if any single fp=
ing
+        # test fails" using exit codes or variables given the limitations =
of
+        # "wait".  Therefore we use a marker file here, which solves the
+        # problem trivially.
+        touch ./lwip_failed
+    fi
+    kill -15 $2
+}
+
+ping_lwip_clients() {
+    if [ "$has_lwipovpn" =3D "yes" ]; then
+        lwip_client_count=3D$(echo "$lwip_test_names"|wc -w|tr -d " ")
+    else
+        lwip_client_count=3D0
+    fi
+
+    if [ $lwip_client_count -eq 0 ]; then
+        return 0
+    fi
+
+    count=3D0
+    maxcount=3D10
+    while [ $count -le $maxcount ]; do
+        lwip_client_ips=3D$(cat ./*.lwip 2>/dev/null|wc -l)
+        if [ $lwip_client_ips -lt $lwip_client_count ]; then
+            echo "Waiting for LWIP clients to start up ($count/$maxcount)"
+            count=3D$(( count + 1))
+            sleep 1
+        else
+            echo "$lwip_client_ips/$lwip_client_count LWIP clients up"
+            break
+        fi
+    done
+
+    wait_pids=3D""
+    for line in $(cat ./*.lwip 2>/dev/null); do
+        target_ip=3D$(echo $line|cut -d "," -f 1)
+        client_pid=3D$(echo $line|cut -d "," -f 2)
+        ping_and_kill $target_ip $client_pid &
+        wait_pids=3D"$wait_pids $!"
+    done
+
+    wait $wait_pids
+
+    test -e ./lwip_failed && return 1 || return 0
+}
+
 wait_for_results() {
     tests_running=3D"yes"

@@ -77,7 +144,7 @@
 server_max_wait=3D15
 while [ $count -lt $server_max_wait ]; do
     servers_up=3D0
-    server_count=3D$(echo $TEST_SERVER_LIST|wc -w)
+    server_count=3D$(echo "$TEST_SERVER_LIST"|wc -w|tr -d " ")

     # We need to trim single-quotes because some shells return quoted valu=
es
     # and some don't. Using "set -o posix" which would resolve this proble=
m is
@@ -85,8 +152,8 @@
     #
     # While inactive server configurations may get checked they won't incr=
ease
     # the active server count as the processes won't be running.
-    for i in `set|grep 'SERVER_NAME_'|cut -d "=3D" -f 2|tr -d "[\']"`; do
-        server_pid=3D$(cat $i.pid 2> /dev/null)
+    for i in $(set|grep 'SERVER_NAME_'|cut -d "=3D" -f 2|tr -d "[\']"); do
+        server_pid=3D$(cat "$i.pid" 2> /dev/null)
         if [ -z "$server_pid" ] ; then
             continue
         fi
@@ -111,6 +178,19 @@
     fi
 done

+# Check for presence of the lwipovpn executable
+if test -r "$LWIPOVPN_PATH"; then
+    has_lwipovpn=3D"yes"
+else
+    has_lwipovpn=3D"no"
+    echo "WARNING: lwipovpn executable is missing: lwip tests will be skip=
ped"
+fi
+
+# Remove existing LWIP client IP files. This is to avoid pinging non-exist=
ent
+# IP addresses when tests are disabled.
+rm -f ./*.lwip
+rm -f ./lwip_failed
+
 # Wait a while to let server processes to settle down
 sleep 1

@@ -118,6 +198,7 @@
 # is used later to determine when all OpenVPN clients have exited and it is
 # safe to check the test results.
 test_names=3D""
+lwip_test_names=3D""
 for SUF in $TEST_RUN_LIST
 do
     eval test_name=3D\"\$TEST_NAME_$SUF\"
@@ -125,9 +206,20 @@
     eval client_conf=3D\"\$CLIENT_CONF_$SUF\"

     test_names=3D"${test_names} ${test_name}"
-    (launch_client "${test_name}" "${client_exec}" "${client_conf}")
+
+    if echo "$test_name"|grep -q _lwip; then
+        lwip_test_names=3D"${lwip_test_names} ${test_name}"
+    fi
+
+    if should_run_test "$test_name"; then
+        (launch_client "${test_name}" "${client_exec}" "${client_conf}")
+    fi
 done

+ping_lwip_clients
+retval=3D$?
+
+
 # Wait until all OpenVPN clients have exited
 (wait_for_results)

@@ -137,7 +229,9 @@
     eval test_name=3D\"\$TEST_NAME_$SUF\"
     eval should_pass=3D\"\$SHOULD_PASS_$SUF\"

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
 SERVER_KEY=3D"${sample_keys}/server.key"
 TA=3D"${sample_keys}/ta.key"

+# This parameter can't be overridden in t_server_null.rc because that gets
+# loaded too late. However, you can use
+#
+# LWIPOVPN_PATH=3D/some/path/to/lwipovpn make check
+#
+# to run the tests using lwipovpn in a custom location
+#
+LWIPOVPN_PATH=3D"${LWIPOVPN_PATH:-lwipovpn}"
+
 # Used to detect if graceful kill of any server instance failed during the=
 test
 # run
 SERVER_KILL_FAIL_FILE=3D".t_server_null_server.kill_failed"
@@ -28,7 +37,7 @@
 MAX_CLIENTS=3D"10"
 CLIENT_MATCH=3D"Test-Client"
 SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --max-clients $MAX_CLIENTS --persist-tun --verb 3"
+SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
 SERVER_CIPHER_OPTS=3D""
 SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"
@@ -49,23 +58,37 @@

 # Test client configurations
 CLIENT_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
-CLIENT_BASE_OPTS=3D"--client --dev null --ifconfig-noexec --nobind --remot=
e-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-=
retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-secur=
ity 2 --up ${srcdir}/null_client_up.sh"
+CLIENT_BASE_OPTS=3D"--client --nobind --remote-cert-tls server --persist-t=
un --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-tim=
eout 5 --explicit-exit-notify 3 --script-security 2"
+CLIENT_NULL_OPTS=3D"--dev null --ifconfig-noexec --up ${srcdir}/null_clien=
t_up.sh"
+CLIENT_LWIP_OPTS=3D"--dev null --dev-node unix:${LWIPOVPN_PATH} --up ${src=
dir}/lwip_client_up.sh"
+
 CLIENT_CIPHER_OPTS=3D""
 CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"

-TEST_RUN_LIST=3D"1 2 3"
-CLIENT_CONF_BASE=3D"${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CER=
T_OPTS}"
+TEST_RUN_LIST=3D"1 1L 2 2L 3"
+CLIENT_CONF_BASE=3D"${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHE=
R_OPTS} ${CLIENT_CERT_OPTS}"
+CLIENT_CONF_BASE_LWIP=3D"${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}"

 TEST_NAME_1=3D"t_server_null_client.sh-openvpn_current_udp"
 SHOULD_PASS_1=3D"yes"
 CLIENT_EXEC_1=3D"${CLIENT_EXEC}"
 CLIENT_CONF_1=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto u=
dp"

+TEST_NAME_1L=3D"t_server_null_client.sh-openvpn_current_udp_lwip"
+SHOULD_PASS_1L=3D"yes"
+CLIENT_EXEC_1L=3D"${CLIENT_EXEC}"
+CLIENT_CONF_1L=3D"${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --p=
roto udp"
+
 TEST_NAME_2=3D"t_server_null_client.sh-openvpn_current_tcp"
 SHOULD_PASS_2=3D"yes"
 CLIENT_EXEC_2=3D"${CLIENT_EXEC}"
 CLIENT_CONF_2=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto t=
cp"

+TEST_NAME_2L=3D"t_server_null_client.sh-openvpn_current_tcp_lwip"
+SHOULD_PASS_2L=3D"yes"
+CLIENT_EXEC_2L=3D"${CLIENT_EXEC}"
+CLIENT_CONF_2L=3D"${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1195 tcp --p=
roto tcp"
+
 TEST_NAME_3=3D"t_server_null_client.sh-openvpn_current_udp_fail"
 SHOULD_PASS_3=3D"no"
 CLIENT_EXEC_3=3D"${CLIENT_EXEC}"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Gerrit-Change-Number: 811
Gerrit-PatchSet: 12
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mattock <samuli@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--ypwZKy2vWtU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #12</strong> to the change originally c=
reated by mattock.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
11?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add lwip support to t_server_null<br><br>Chan=
ge-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250<br>Signed-off-by: Samuli S=
epp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>Acked-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250305134642.196598-1-fran=
k@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg31019.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M doc/t_server_null.rst<br>A tests/lwip_client_up.sh<br>=
M tests/t_server_null_client.sh<br>M tests/t_server_null_default.rc<br>4 fi=
les changed, 163 insertions(+), 13 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/11/811/12</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
doc/t_server_null.rst b/doc/t_server_null.rst</span><br><span>index 5fe9080=
..473a7bd 100644</span><br><span>--- a/doc/t_server_null.rst</span><br><spa=
n>+++ b/doc/t_server_null.rst</span><br><span>@@ -16,7 +16,7 @@</span><br><=
span> </span><br><span> * Parallelized for fairly high performance</span><b=
r><span> * Mostly operating-system agnostic</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-* Tested on Fedora Linux 38/39/40 and FreeBSD 14</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+* Tested on Fedora Linux=
 38/39/40, FreeBSD 14, NetBSD 10.0 and OpenBSD 7.5</span><br><span> * POSIX=
-compliant</span><br><span> * Tested and known to work with Bash, Dash, Ksh=
, Yash and FreeBSD&#39;s default /bin/sh</span><br><span> * Uses the sample=
 certificates and keys</span><br><span>@@ -31,6 +31,7 @@</span><br><span> *=
 Test cases (client configurations) and server setups (server configuration=
s) are stored in a configuration file, i.e. data and code have been separat=
ed</span><br><span> * Configuration file format is nearly identical to t_cl=
ient.rc configuration</span><br><span> * Supports a set of default tests, o=
verriding default test settings and adding local tests</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+* Supports client ping tests if ovpnlwip=
 is available</span><br><span> </span><br><span> Prerequisites</span><br><s=
pan> -------------</span><br><span>@@ -60,8 +61,9 @@</span><br><span> #. Se=
rver instances start</span><br><span> #. Brief wait</span><br><span> #. Cli=
ent instances start</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#.=
 Tests run</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#. ovpnlw=
ip ping tests run</span><br><span> #. Client instances stop</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#. Test results are collected</span=
><br><span> #. Brief wait</span><br><span> #. Server instances stop</span><=
br><span> </span><br><span>@@ -77,7 +79,8 @@</span><br><span> </span><br><s=
pan>     * t_server_null_client.sh</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      * Waits until servers have launched. =
Then launch all clients, wait for them to exit and then check test results =
by parsing the client log files. Each client kills itself after some delay =
using an &quot;--up&quot; script.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      * Waits until servers have launched. Then launch all cl=
ients, run ovpnlwip ping tests (if any), wait for clients to exit and then =
check test results by parsing the client log files. Each client kills itsel=
f after some delay using an &quot;--up&quot; script.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> Confi=
guration</span><br><span> -------------</span><br><span>@@ -116,6 +119,19 @=
@</span><br><span> </span><br><span>   TEST_RUN_LIST=3D&quot;1 2 5 9&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Cl=
ient ping tests that use ovpnlwip can be added similarly:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  TEST_NAME_9L=3D&quot;t_server_null_client.sh-openvpn_c=
urrent_udp_custom_lwip&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  SHOULD_PASS_9L=3D&quot;yes&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  CLIENT_EXEC_9L=3D&quot;${CLIENT_EXEC}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  CLIENT_CONF_9L=3D&quot;=
${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --proto udp&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Note that all ovpnlwip test names need to=
 include a &quot;_lwip&quot; suffix: without it</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ping tests won&#39;t get activated. Also note t=
hat the *tests* directory needs to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+have the lwipovpn executable or ovpnlwip tests will get skip=
ped. The ovpnlwip</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pi=
ng tests get the IP addresses to ping from the \*.ips files created by the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+lwip_client_up.sh sc=
ript --up script.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> Stress-testing the --dev null test suite</span><br><span> -=
---------------------------------------</span><br><span> </span><br><span>d=
iff --git a/tests/lwip_client_up.sh b/tests/lwip_client_up.sh</span><br><sp=
an>new file mode 100755</span><br><span>index 0000000..a6b4d24</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/tests/lwip_client_up.sh</span><br><=
span>@@ -0,0 +1,17 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#!/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# Determine the OpenVPN PI=
D from its pid file. This works reliably even when</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# the OpenVPN process is backgrounded for pa=
rallel tests.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MY_PPI=
D=3D`cat $pid`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# Add this client&#39;s =
VPN IP and PID to a file. This enables</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# t_server_null_client.sh to kill this OpenVPN client af=
ter fping tests have</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# finished.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+echo &q=
uot;$ifconfig_local,$MY_PPID&quot; &gt;&gt; ./$test_name.lwip</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# Wait long enough to allow fping tests to finish. A=
lso ensure that this</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# OpenVPN client is killed even if t_server_null_client.sh failed to do it=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(sleep 15</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+echo &quot;ERROR: t_server_n=
ull_client.sh failed to kill OpenVPN client with PID $MY_PPID in test $test=
_name. Killing it in lwip_client_up.sh.&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+kill -15 $MY_PPID</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+) &amp;</span><br><span>diff --git a/tests/t_server=
_null_client.sh b/tests/t_server_null_client.sh</span><br><span>index 2210e=
63..1745de5 100755</span><br><span>--- a/tests/t_server_null_client.sh</spa=
n><br><span>+++ b/tests/t_server_null_client.sh</span><br><span>@@ -1,5 +1,=
17 @@</span><br><span> #!/bin/sh</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+should_run_test() {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    test_name=3D&quot;$1&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if echo &quot;$test_name&quot;|grep -q _lwip; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ &quo=
t;$has_lwipovpn&quot; =3D &quot;no&quot; ]; then</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return 1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> launch_client() {<=
/span><br><span>     test_name=3D$1</span><br><span>     log=3D&quot;${test=
_name}.log&quot;</span><br><span>@@ -13,10 +25,65 @@</span><br><span>     &=
quot;${client_exec}&quot; \</span><br><span>         $client_conf \</span><=
br><span>         --writepid &quot;${pid}&quot; \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        --setenv pid $pid \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        --setenv pid &quot;$pid&quot; \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --setenv te=
st_name &quot;$test_name&quot; \</span><br><span>         --log &quot;${t_s=
erver_null_logdir}/${log}&quot; &amp;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ping_and_kill() {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if fping -q -c 5 $=
1; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo=
 &quot;PASS: fping lwipovpn client $target&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        echo &quot;FAIL: fping lwipovpn client $target&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        # This function runs multip=
le times in parallel in subshells. That</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        # makes it hard to implement &quot;fail the tes=
t suite if any single fping</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        # test fails&quot; using exit codes or variables given the =
limitations of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   # &quot;wait&quot;.  Therefore we use a marker file here, which solves t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # problem=
 trivially.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
touch ./lwip_failed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    kill -15 =
$2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ping_lwip_clients() {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if [ &quot;$has_lwipovpn&quot; =3D &quot;yes&quo=
t; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
wip_client_count=3D$(echo &quot;$lwip_test_names&quot;|wc -w|tr -d &quot; &=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_coun=
t=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if [ $lwip_client_count -eq 0 ]; then</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    count=3D0</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    maxcount=3D10</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    while [ $count -le $maxcount ]; do</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        lwip_client_ips=3D$(cat ./*.lwip 2&gt;/d=
ev/null|wc -l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if [ $lwip_client_ips -lt $lwip_client_count ]; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            echo &quot;Waiting for LWIP=
 clients to start up ($count/$maxcount)&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            count=3D$(( count + 1))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            sleep 1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            echo &quot;$lwip_client_ips/=
$lwip_client_count LWIP clients up&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wait_pids=3D&quo=
t;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for lin=
e in $(cat ./*.lwip 2&gt;/dev/null); do</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        target_ip=3D$(echo $line|cut -d &quot;,&quot; -=
f 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client_=
pid=3D$(echo $line|cut -d &quot;,&quot; -f 2)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ping_and_kill $target_ip $client_pid &amp=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wait_pids=
=3D&quot;$wait_pids $!&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wait $wait_pids</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    test -e ./lwip_failed &amp;&amp; ret=
urn 1 || return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> wa=
it_for_results() {</span><br><span>     tests_running=3D&quot;yes&quot;</sp=
an><br><span> </span><br><span>@@ -77,7 +144,7 @@</span><br><span> server_m=
ax_wait=3D15</span><br><span> while [ $count -lt $server_max_wait ]; do</sp=
an><br><span>     servers_up=3D0</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    server_count=3D$(echo $TEST_SERVER_LIST|wc -w)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    server_count=3D$(echo &quot;$=
TEST_SERVER_LIST&quot;|wc -w|tr -d &quot; &quot;)</span><br><span> </span><=
br><span>     # We need to trim single-quotes because some shells return qu=
oted values</span><br><span>     # and some don&#39;t. Using &quot;set -o p=
osix&quot; which would resolve this problem is</span><br><span>@@ -85,8 +15=
2,8 @@</span><br><span>     #</span><br><span>     # While inactive server =
configurations may get checked they won&#39;t increase</span><br><span>    =
 # the active server count as the processes won&#39;t be running.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    for i in `set|grep &#39;SER=
VER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&#39;]&quot;`; do<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pid=3D$=
(cat $i.pid 2&gt; /dev/null)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for i in $(set|grep &#39;SERVER_NAME_&#39;|cut -d &quot;=3D&qu=
ot; -f 2|tr -d &quot;[\&#39;]&quot;); do</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        server_pid=3D$(cat &quot;$i.pid&quot; 2&gt; /d=
ev/null)</span><br><span>         if [ -z &quot;$server_pid&quot; ] ; then<=
/span><br><span>             continue</span><br><span>         fi</span><br=
><span>@@ -111,6 +178,19 @@</span><br><span>     fi</span><br><span> done</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# C=
heck for presence of the lwipovpn executable</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+if test -r &quot;$LWIPOVPN_PATH&quot;; then</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    has_lwipovpn=3D&quot;y=
es&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    has_lwipovpn=3D&quot;n=
o&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &qu=
ot;WARNING: lwipovpn executable is missing: lwip tests will be skipped&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# Remove existing LWIP client IP files. This is to avo=
id pinging non-existent</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# IP addresses when tests are disabled.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+rm -f ./*.lwip</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+rm -f ./lwip_failed</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> # Wait a while to let server processes=
 to settle down</span><br><span> sleep 1</span><br><span> </span><br><span>=
@@ -118,6 +198,7 @@</span><br><span> # is used later to determine when all =
OpenVPN clients have exited and it is</span><br><span> # safe to check the =
test results.</span><br><span> test_names=3D&quot;&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+lwip_test_names=3D&quot;&quot;</span><=
br><span> for SUF in $TEST_RUN_LIST</span><br><span> do</span><br><span>   =
  eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>@@ -125,9=
 +206,20 @@</span><br><span>     eval client_conf=3D\&quot;\$CLIENT_CONF_$S=
UF\&quot;</span><br><span> </span><br><span>     test_names=3D&quot;${test_=
names} ${test_name}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    (launch_client &quot;${test_name}&quot; &quot;${client_exec}&quot; =
&quot;${client_conf}&quot;)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if echo=
 &quot;$test_name&quot;|grep -q _lwip; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        lwip_test_names=3D&quot;${lwip_test_names} =
${test_name}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if should_run_test &quot;$tes=
t_name&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       (launch_client &quot;${test_name}&quot; &quot;${client_exec}&quot; &=
quot;${client_conf}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    fi</span><br><span> done</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ping_lwip_clients</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+retval=3D$?</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> # Wait until all OpenVPN clients have exited</span=
><br><span> (wait_for_results)</span><br><span> </span><br><span>@@ -137,7 =
+229,9 @@</span><br><span>     eval test_name=3D\&quot;\$TEST_NAME_$SUF\&qu=
ot;</span><br><span>     eval should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  get_client_test_result &quot;${test_name}&quot; &quot;${should_pass}&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if should_run_=
test &quot;$test_name&quot;; then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        get_client_test_result &quot;${test_name}&quot; &quot=
;${should_pass}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    fi</span><br><span> done</span><br><span> </span><br><span> exit $ret=
val</span><br><span>diff --git a/tests/t_server_null_default.rc b/tests/t_s=
erver_null_default.rc</span><br><span>index cbf4877..e7bf5bc 100755</span><=
br><span>--- a/tests/t_server_null_default.rc</span><br><span>+++ b/tests/t=
_server_null_default.rc</span><br><span>@@ -20,6 +20,15 @@</span><br><span>=
 SERVER_KEY=3D&quot;${sample_keys}/server.key&quot;</span><br><span> TA=3D&=
quot;${sample_keys}/ta.key&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# This parameter can&#39;t be overridden in =
t_server_null.rc because that gets</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# loaded too late. However, you can use</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# LWIPOVPN_PATH=3D/some/path/to/lwipovpn make check</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# to run the tests using lwipovpn in a custo=
m location</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+LWIPOVPN_PATH=3D&quot;${LWI=
POVPN_PATH:-lwipovpn}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> # Used to detect if graceful kill of any server i=
nstance failed during the test</span><br><span> # run</span><br><span> SERV=
ER_KILL_FAIL_FILE=3D&quot;.t_server_null_server.kill_failed&quot;</span><br=
><span>@@ -28,7 +37,7 @@</span><br><span> MAX_CLIENTS=3D&quot;10&quot;</spa=
n><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot;</span><br><span> SERVER=
_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&quot;--daemon --local=
 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist=
-tun --verb 3&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
SERVER_BASE_OPTS=3D&quot;--daemon --local 127.0.0.1 --dev tun --topology su=
bnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;=
</span><br><span> SERVER_CIPHER_OPTS=3D&quot;&quot;</span><br><span> SERVER=
_CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERV=
ER_KEY} --tls-auth ${TA} 0&quot;</span><br><span> SERVER_CONF_BASE=3D&quot;=
${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><=
br><span>@@ -49,23 +58,37 @@</span><br><span> </span><br><span> # Test clie=
nt configurations</span><br><span> CLIENT_EXEC=3D&quot;${top_builddir}/src/=
openvpn/openvpn&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
CLIENT_BASE_OPTS=3D&quot;--client --dev null --ifconfig-noexec --nobind --r=
emote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --conn=
ect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-s=
ecurity 2 --up ${srcdir}/null_client_up.sh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+CLIENT_BASE_OPTS=3D&quot;--client --nobind --r=
emote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --conn=
ect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-s=
ecurity 2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIE=
NT_NULL_OPTS=3D&quot;--dev null --ifconfig-noexec --up ${srcdir}/null_clien=
t_up.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT=
_LWIP_OPTS=3D&quot;--dev null --dev-node unix:${LWIPOVPN_PATH} --up ${srcdi=
r}/lwip_client_up.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> CLIENT_CIPHER_OPTS=3D&quot;&quot;</span><br><span>=
 CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_K=
EY} --tls-auth ${TA} 1&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-TEST_RUN_LIST=3D&quot;1 2 3&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_BASE=3D&quot;${CLIENT_BASE=
_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1 1L 2 2L 3&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_BASE=3D&=
quot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT=
_CERT_OPTS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CL=
IENT_CONF_BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIEN=
T_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span>=
 TEST_NAME_1=3D&quot;t_server_null_client.sh-openvpn_current_udp&quot;</spa=
n><br><span> SHOULD_PASS_1=3D&quot;yes&quot;</span><br><span> CLIENT_EXEC_1=
=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF_1=3D&quot;${CLIE=
NT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_1L=3D&q=
uot;t_server_null_client.sh-openvpn_current_udp_lwip&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_1L=3D&quot;yes&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_1L=3D&quot;=
${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+CLIENT_CONF_1L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 ud=
p --proto udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> TEST_NAME_2=3D&quot;t_server_null_client.sh-openvpn_curre=
nt_tcp&quot;</span><br><span> SHOULD_PASS_2=3D&quot;yes&quot;</span><br><sp=
an> CLIENT_EXEC_2=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF=
_2=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto tcp&quot=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
TEST_NAME_2L=3D&quot;t_server_null_client.sh-openvpn_current_tcp_lwip&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_2L=3D&q=
uot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT=
_EXEC_2L=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+CLIENT_CONF_2L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote =
127.0.0.1 1195 tcp --proto tcp&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> TEST_NAME_3=3D&quot;t_server_null_client=
.sh-openvpn_current_udp_fail&quot;</span><br><span> SHOULD_PASS_3=3D&quot;n=
o&quot;</span><br><span> CLIENT_EXEC_3=3D&quot;${CLIENT_EXEC}&quot;</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/811?usp=3Demail">change 811</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/811?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mattock &lt;samuli@...515...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ypwZKy2vWtU=--

