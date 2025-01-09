From: "mattock (Code Review)" <gerrit@...515...>
Date: Thu, 9 Jan 2025 12:03:32 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <98f2eb2f2b77c56951a7b6ac04dfa2a62ad237cb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3ZYs3H/iiPw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3ZYs3H/iiPw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail

to look at the new patch set (#6).


Change subject: Add lwip support to t_server_null
......................................................................

Add lwip support to t_server_null

Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M doc/t_server_null.rst
A tests/lwip_client_up.sh
M tests/t_server_null_client.sh
M tests/t_server_null_default.rc
4 files changed, 153 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/811/6

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
index 0000000..307a9cb
--- /dev/null
+++ b/tests/lwip_client_up.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Add this client's IP to a file
+if ! grep -q "$ifconfig_local" ./$test_name.ips; then
+    echo -n "$ifconfig_local " >> ./$test_name.ips
+fi
+
+# Determine the OpenVPN PID from its pid file. This works reliably even wh=
en
+# the OpenVPN process is backgrounded for parallel tests.
+MY_PPID=3D`cat $pid`
+
+# Allow OpenVPN to finish initializing while waiting in the background and=
 then
+# killing the process gracefully. Also wait for fping tests to finish.
+(sleep 5
+
+count=3D0
+maxcount=3D15
+while [ $count -le $maxcount ]; do
+    if pgrep fping > /dev/null 2>&1; then
+        echo "Waiting for fping to exit ($count/$maxcount)"
+        count=3D$(( count + 1))
+        sleep 1
+    else
+        echo "fping not running anymore"
+        break
+    fi
+done
+
+kill -15 $MY_PPID
+) &
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 2210e63..77e1cc5 100755
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
@@ -13,10 +25,45 @@
     "${client_exec}" \
         $client_conf \
         --writepid "${pid}" \
-        --setenv pid $pid \
+        --setenv pid "$pid" \
+        --setenv test_name "$test_name" \
         --log "${t_server_null_logdir}/${log}" &
 }

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
+        lwip_client_ips=3D$(cat ./*.ips 2>/dev/null|wc -w|tr -d " ")
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
+    LWIP_CLIENTS=3D$(cat ./*.ips 2>/dev/null)
+    if [ "$LWIP_CLIENTS" ]; then
+        if ! fping -c 5 $LWIP_CLIENTS; then
+            echo "ERROR: pinging one or more openvpnlwip client IP address=
es failed!"
+            retval=3D1
+        fi
+    fi
+}
+
 wait_for_results() {
     tests_running=3D"yes"

@@ -77,7 +124,7 @@
 server_max_wait=3D15
 while [ $count -lt $server_max_wait ]; do
     servers_up=3D0
-    server_count=3D$(echo $TEST_SERVER_LIST|wc -w)
+    server_count=3D$(echo "$TEST_SERVER_LIST"|wc -w|tr -d " ")

     # We need to trim single-quotes because some shells return quoted valu=
es
     # and some don't. Using "set -o posix" which would resolve this proble=
m is
@@ -85,8 +132,8 @@
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
@@ -111,6 +158,18 @@
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
+$RUN_SUDO rm -f ./*.ips
+
 # Wait a while to let server processes to settle down
 sleep 1

@@ -118,6 +177,7 @@
 # is used later to determine when all OpenVPN clients have exited and it is
 # safe to check the test results.
 test_names=3D""
+lwip_test_names=3D""
 for SUF in $TEST_RUN_LIST
 do
     eval test_name=3D\"\$TEST_NAME_$SUF\"
@@ -125,9 +185,18 @@
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
+
 # Wait until all OpenVPN clients have exited
 (wait_for_results)

@@ -137,7 +206,9 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-MessageType: newpatchset

--3ZYs3H/iiPw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>mattock <strong>uploaded patch set #6</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">View Change<=
/a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add lwip support to t_server_null<br><br>Change-Id: Ie63f302402f469c3aa=
48ac146ca6b8c029f0d250<br>Signed-off-by: Samuli Sepp=C3=A4nen &lt;samuli.se=
ppanen@...277...&gt;<br>---<br>M doc/t_server_null.rst<br>A tests/lwip_clie=
nt_up.sh<br>M tests/t_server_null_client.sh<br>M tests/t_server_null_defaul=
t.rc<br>4 files changed, 153 insertions(+), 13 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/811/6</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/doc/t_server_null.rst b/doc/t_server_null.rst</span><br><span>in=
dex 5fe9080..473a7bd 100644</span><br><span>--- a/doc/t_server_null.rst</sp=
an><br><span>+++ b/doc/t_server_null.rst</span><br><span>@@ -16,7 +16,7 @@<=
/span><br><span> </span><br><span> * Parallelized for fairly high performan=
ce</span><br><span> * Mostly operating-system agnostic</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-* Tested on Fedora Linux 38/39/40 and Free=
BSD 14</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Tested on F=
edora Linux 38/39/40, FreeBSD 14, NetBSD 10.0 and OpenBSD 7.5</span><br><sp=
an> * POSIX-compliant</span><br><span> * Tested and known to work with Bash=
, Dash, Ksh, Yash and FreeBSD&#39;s default /bin/sh</span><br><span> * Uses=
 the sample certificates and keys</span><br><span>@@ -31,6 +31,7 @@</span><=
br><span> * Test cases (client configurations) and server setups (server co=
nfigurations) are stored in a configuration file, i.e. data and code have b=
een separated</span><br><span> * Configuration file format is nearly identi=
cal to t_client.rc configuration</span><br><span> * Supports a set of defau=
lt tests, overriding default test settings and adding local tests</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+* Supports client ping tests =
if ovpnlwip is available</span><br><span> </span><br><span> Prerequisites</=
span><br><span> -------------</span><br><span>@@ -60,8 +61,9 @@</span><br><=
span> #. Server instances start</span><br><span> #. Brief wait</span><br><s=
pan> #. Client instances start</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#. Tests run</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#. ovpnlwip ping tests run</span><br><span> #. Client instances stop</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#. Test results are coll=
ected</span><br><span> #. Brief wait</span><br><span> #. Server instances s=
top</span><br><span> </span><br><span>@@ -77,7 +79,8 @@</span><br><span> </=
span><br><span>     * t_server_null_client.sh</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      * Waits until servers have =
launched. Then launch all clients, wait for them to exit and then check tes=
t results by parsing the client log files. Each client kills itself after s=
ome delay using an &quot;--up&quot; script.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      * Waits until servers have launched. Then lau=
nch all clients, run ovpnlwip ping tests (if any), wait for clients to exit=
 and then check test results by parsing the client log files. Each client k=
ills itself after some delay using an &quot;--up&quot; script.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><sp=
an> Configuration</span><br><span> -------------</span><br><span>@@ -116,6 =
+119,19 @@</span><br><span> </span><br><span>   TEST_RUN_LIST=3D&quot;1 2 5=
 9&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+Client ping tests that use ovpnlwip can be added similarly:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  TEST_NAME_9L=3D&quot;t_server_null_client.sh-=
openvpn_current_udp_custom_lwip&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  SHOULD_PASS_9L=3D&quot;yes&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  CLIENT_EXEC_9L=3D&quot;${CLIENT_EXEC}&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  CLIENT_CONF_9=
L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --proto udp&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+Note that all ovpnlwip test names=
 need to include a &quot;_lwip&quot; suffix: without it</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ping tests won&#39;t get activated. Als=
o note that the *tests* directory needs to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+have the lwipovpn executable or ovpnlwip tests will =
get skipped. The ovpnlwip</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ping tests get the IP addresses to ping from the \*.ips files created=
 by the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+lwip_client_=
up.sh script --up script.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> Stress-testing the --dev null test suite</span><br>=
<span> ----------------------------------------</span><br><span> </span><br=
><span>diff --git a/tests/lwip_client_up.sh b/tests/lwip_client_up.sh</span=
><br><span>new file mode 100755</span><br><span>index 0000000..307a9cb</spa=
n><br><span>--- /dev/null</span><br><span>+++ b/tests/lwip_client_up.sh</sp=
an><br><span>@@ -0,0 +1,30 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#!/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Add this client&=
#39;s IP to a file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f ! grep -q &quot;$ifconfig_local&quot; ./$test_name.ips; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    echo -n &quot;$ifconfig_loca=
l &quot; &gt;&gt; ./$test_name.ips</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Determine the OpenV=
PN PID from its pid file. This works reliably even when</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# the OpenVPN process is backgrounded f=
or parallel tests.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+M=
Y_PPID=3D`cat $pid`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Allow OpenVPN to =
finish initializing while waiting in the background and then</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# killing the process gracefully. =
Also wait for fping tests to finish.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+(sleep 5</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+count=3D0</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+maxcount=3D15</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+while [ $count -le $maxcount =
]; do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if pgrep f=
ping &gt; /dev/null 2&gt;&amp;1; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        echo &quot;Waiting for fping to exit ($count/$max=
count)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 count=3D$(( count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        sleep 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ec=
ho &quot;fping not running anymore&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        break</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+kill -15 $MY_PPID</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+) &amp;</span><br><span>diff --git=
 a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh</span><br>=
<span>index 2210e63..77e1cc5 100755</span><br><span>--- a/tests/t_server_nu=
ll_client.sh</span><br><span>+++ b/tests/t_server_null_client.sh</span><br>=
<span>@@ -1,5 +1,17 @@</span><br><span> #!/bin/sh</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+should_run_test() {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    test_name=3D&quot;$1&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if echo &quot;$test_name&quot;|=
grep -q _lwip; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if [ &quot;$has_lwipovpn&quot; =3D &quot;no&quot; ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return 1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> l=
aunch_client() {</span><br><span>     test_name=3D$1</span><br><span>     l=
og=3D&quot;${test_name}.log&quot;</span><br><span>@@ -13,10 +25,45 @@</span=
><br><span>     &quot;${client_exec}&quot; \</span><br><span>         $clie=
nt_conf \</span><br><span>         --writepid &quot;${pid}&quot; \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        --setenv pid $pid \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        --setenv pid &=
quot;$pid&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      --setenv test_name &quot;$test_name&quot; \</span><br><span>         =
--log &quot;${t_server_null_logdir}/${log}&quot; &amp;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+pin=
g_lwip_clients() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if [ &quot;$has_lwipovpn&quot; =3D &quot;yes&quot; ]; then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_count=3D$(ech=
o &quot;$lwip_test_names&quot;|wc -w|tr -d &quot; &quot;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        lwip_client_count=3D0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if [ $lwip_client_count -eq 0 ]; then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return 0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    coun=
t=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    maxcount=
=3D10</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while [ $c=
ount -le $maxcount ]; do</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        lwip_client_ips=3D$(cat ./*.ips 2&gt;/dev/null|wc -w|tr -d &qu=
ot; &quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if [ $lwip_client_ips -lt $lwip_client_count ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;Waiting for LWIP c=
lients to start up ($count/$maxcount)&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            count=3D$(( count + 1))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            sleep 1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            echo &quot;$lwip_client_ips/$=
lwip_client_count LWIP clients up&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            break</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LWIP_CLIENTS=3D$(=
cat ./*.ips 2&gt;/dev/null)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if [ &quot;$LWIP_CLIENTS&quot; ]; then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if ! fping -c 5 $LWIP_CLIENTS; then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &qu=
ot;ERROR: pinging one or more openvpnlwip client IP addresses failed!&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retval=
=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> wait_for_results() {</span><br><span>=
     tests_running=3D&quot;yes&quot;</span><br><span> </span><br><span>@@ -=
77,7 +124,7 @@</span><br><span> server_max_wait=3D15</span><br><span> while=
 [ $count -lt $server_max_wait ]; do</span><br><span>     servers_up=3D0</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    server_count=3D$(ech=
o $TEST_SERVER_LIST|wc -w)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    server_count=3D$(echo &quot;$TEST_SERVER_LIST&quot;|wc -w|tr -d =
&quot; &quot;)</span><br><span> </span><br><span>     # We need to trim sin=
gle-quotes because some shells return quoted values</span><br><span>     # =
and some don&#39;t. Using &quot;set -o posix&quot; which would resolve this=
 problem is</span><br><span>@@ -85,8 +132,8 @@</span><br><span>     #</span=
><br><span>     # While inactive server configurations may get checked they=
 won&#39;t increase</span><br><span>     # the active server count as the p=
rocesses won&#39;t be running.</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    for i in `set|grep &#39;SERVER_NAME_&#39;|cut -d &quot;=3D&quo=
t; -f 2|tr -d &quot;[\&#39;]&quot;`; do</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        server_pid=3D$(cat $i.pid 2&gt; /dev/null)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for i in $(set|grep &#=
39;SERVER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&#39;]&quot;=
); do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        server=
_pid=3D$(cat &quot;$i.pid&quot; 2&gt; /dev/null)</span><br><span>         i=
f [ -z &quot;$server_pid&quot; ] ; then</span><br><span>             contin=
ue</span><br><span>         fi</span><br><span>@@ -111,6 +158,18 @@</span><=
br><span>     fi</span><br><span> done</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# Check for presence of the lwipovpn e=
xecutable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test -r=
 &quot;$LWIPOVPN_PATH&quot;; then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    has_lwipovpn=3D&quot;yes&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    has_lwipovpn=3D&quot;no&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    echo &quot;WARNING: lwipovpn executable is =
missing: lwip tests will be skipped&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Remove exist=
ing LWIP client IP files. This is to avoid pinging non-existent</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# IP addresses when tests are d=
isabled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+$RUN_SUDO r=
m -f ./*.ips</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> # Wait a while to let server processes to settle down</span><br>=
<span> sleep 1</span><br><span> </span><br><span>@@ -118,6 +177,7 @@</span>=
<br><span> # is used later to determine when all OpenVPN clients have exite=
d and it is</span><br><span> # safe to check the test results.</span><br><s=
pan> test_names=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+lwip_test_names=3D&quot;&quot;</span><br><span> for SUF in $TEST=
_RUN_LIST</span><br><span> do</span><br><span>     eval test_name=3D\&quot;=
\$TEST_NAME_$SUF\&quot;</span><br><span>@@ -125,9 +185,18 @@</span><br><spa=
n>     eval client_conf=3D\&quot;\$CLIENT_CONF_$SUF\&quot;</span><br><span>=
 </span><br><span>     test_names=3D&quot;${test_names} ${test_name}&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (launch_client &qu=
ot;${test_name}&quot; &quot;${client_exec}&quot; &quot;${client_conf}&quot;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if echo &quot;$test_name&quot;|gr=
ep -q _lwip; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      lwip_test_names=3D&quot;${lwip_test_names} ${test_name}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if should_run_test &quot;$test_name&quot;; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        (launch_client &quo=
t;${test_name}&quot; &quot;${client_exec}&quot; &quot;${client_conf}&quot;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><s=
pan> done</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ping_lwip_clients</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> # Wait until all OpenVPN clients have exited</span>=
<br><span> (wait_for_results)</span><br><span> </span><br><span>@@ -137,7 +=
206,9 @@</span><br><span>     eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quo=
t;</span><br><span>     eval should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 get_client_test_result &quot;${test_name}&quot; &quot;${should_pass}&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if should_run_t=
est &quot;$test_name&quot;; then</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        get_client_test_result &quot;${test_name}&quot; &quot;=
${should_pass}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    fi</span><br><span> done</span><br><span> </span><br><span> exit $retv=
al</span><br><span>diff --git a/tests/t_server_null_default.rc b/tests/t_se=
rver_null_default.rc</span><br><span>index cbf4877..e7bf5bc 100755</span><b=
r><span>--- a/tests/t_server_null_default.rc</span><br><span>+++ b/tests/t_=
server_null_default.rc</span><br><span>@@ -20,6 +20,15 @@</span><br><span> =
SERVER_KEY=3D&quot;${sample_keys}/server.key&quot;</span><br><span> TA=3D&q=
uot;${sample_keys}/ta.key&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# This parameter can&#39;t be overridden in t=
_server_null.rc because that gets</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# loaded too late. However, you can use</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# LWIPOVPN_PATH=3D/some/path/to/lwipovpn make check</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# to run the tests using lwipovpn in a custom=
 location</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+LWIPOVPN_PATH=3D&quot;${LWIP=
OVPN_PATH:-lwipovpn}&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> # Used to detect if graceful kill of any server in=
stance failed during the test</span><br><span> # run</span><br><span> SERVE=
R_KILL_FAIL_FILE=3D&quot;.t_server_null_server.kill_failed&quot;</span><br>=
<span>@@ -28,7 +37,7 @@</span><br><span> MAX_CLIENTS=3D&quot;10&quot;</span=
><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot;</span><br><span> SERVER_=
EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&quot;--daemon --local =
127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-=
tun --verb 3&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+S=
ERVER_BASE_OPTS=3D&quot;--daemon --local 127.0.0.1 --dev tun --topology sub=
net --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;<=
/span><br><span> SERVER_CIPHER_OPTS=3D&quot;&quot;</span><br><span> SERVER_=
CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVE=
R_KEY} --tls-auth ${TA} 0&quot;</span><br><span> SERVER_CONF_BASE=3D&quot;$=
{SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><b=
r><span>@@ -49,23 +58,37 @@</span><br><span> </span><br><span> # Test clien=
t configurations</span><br><span> CLIENT_EXEC=3D&quot;${top_builddir}/src/o=
penvpn/openvpn&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-C=
LIENT_BASE_OPTS=3D&quot;--client --dev null --ifconfig-noexec --nobind --re=
mote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --conne=
ct-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-se=
curity 2 --up ${srcdir}/null_client_up.sh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+CLIENT_BASE_OPTS=3D&quot;--client --nobind --re=
mote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --conne=
ct-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-se=
curity 2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIEN=
T_NULL_OPTS=3D&quot;--dev null --ifconfig-noexec --up ${srcdir}/null_client=
_up.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_=
LWIP_OPTS=3D&quot;--dev null --dev-node unix:${LWIPOVPN_PATH} --up ${srcdir=
}/lwip_client_up.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> CLIENT_CIPHER_OPTS=3D&quot;&quot;</span><br><span> =
CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KE=
Y} --tls-auth ${TA} 1&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-TEST_RUN_LIST=3D&quot;1 2 3&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_BASE=3D&quot;${CLIENT_BASE_=
OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1 1L 2 2L 3&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_BASE=3D&q=
uot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_=
CERT_OPTS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLI=
ENT_CONF_BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT=
_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span> =
TEST_NAME_1=3D&quot;t_server_null_client.sh-openvpn_current_udp&quot;</span=
><br><span> SHOULD_PASS_1=3D&quot;yes&quot;</span><br><span> CLIENT_EXEC_1=
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
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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


--3ZYs3H/iiPw=--

