From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 06:40:27 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5a57d12dfb9760493e4fa5c2217e3b09cc43ee5e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9Vjw0tRk17Q="; charset=UTF-8
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

--9Vjw0tRk17Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
4 files changed, 145 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/811/3

diff --git a/doc/t_server_null.rst b/doc/t_server_null.rst
index 5fe9080..022793a 100644
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
t if
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
index 0000000..a07c4b7
--- /dev/null
+++ b/tests/lwip_client_up.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Add this client's IP to a file
+if ! grep "$ifconfig_local" ./$test_name.ips; then
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
=20
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
index cbf4877..cb6a2cd 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -19,6 +19,7 @@
 SERVER_CERT=3D"${sample_keys}/server.crt"
 SERVER_KEY=3D"${sample_keys}/server.key"
 TA=3D"${sample_keys}/ta.key"
+LWIPOVPN_PATH=3D"lwipovpn"

 # Used to detect if graceful kill of any server instance failed during the=
 test
 # run
@@ -28,7 +29,7 @@
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
@@ -49,23 +50,37 @@

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
Gerrit-PatchSet: 3
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-MessageType: newpatchset

--9Vjw0tRk17Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p>mattock <strong>uploaded patch set #3</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">View Change<=
/a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add lwip support to t_server_null<br><br>Chan=
ge-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250<br>Signed-off-by: Samuli S=
epp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>---<br>M doc/t_server_nul=
l.rst<br>A tests/lwip_client_up.sh<br>M tests/t_server_null_client.sh<br>M =
tests/t_server_null_default.rc<br>4 files changed, 145 insertions(+), 13 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/11/811/3</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/doc/t_server_null.rst b/doc/t_server_n=
ull.rst</span><br><span>index 5fe9080..022793a 100644</span><br><span>--- a=
/doc/t_server_null.rst</span><br><span>+++ b/doc/t_server_null.rst</span><b=
r><span>@@ -16,7 +16,7 @@</span><br><span> </span><br><span> * Parallelized=
 for fairly high performance</span><br><span> * Mostly operating-system agn=
ostic</span><br><span style=3D"color: hsl(0, 100%, 40%);">-* Tested on Fedo=
ra Linux 38/39/40 and FreeBSD 14</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+* Tested on Fedora Linux 38/39/40, FreeBSD 14, NetBSD 10.0 and=
 OpenBSD 7.5</span><br><span> * POSIX-compliant</span><br><span> * Tested a=
nd known to work with Bash, Dash, Ksh, Yash and FreeBSD&#39;s default /bin/=
sh</span><br><span> * Uses the sample certificates and keys</span><br><span=
>@@ -31,6 +31,7 @@</span><br><span> * Test cases (client configurations) an=
d server setups (server configurations) are stored in a configuration file,=
 i.e. data and code have been separated</span><br><span> * Configuration fi=
le format is nearly identical to t_client.rc configuration</span><br><span>=
 * Supports a set of default tests, overriding default test settings and ad=
ding local tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* S=
upports client ping tests if ovpnlwip is available</span><br><span> </span>=
<br><span> Prerequisites</span><br><span> -------------</span><br><span>@@ =
-60,8 +61,9 @@</span><br><span> #. Server instances start</span><br><span> =
#. Brief wait</span><br><span> #. Client instances start</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#. Tests run</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#. ovpnlwip ping tests run</span><br><span> #. =
Client instances stop</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#. Test results are collected</span><br><span> #. Brief wait</span><br><s=
pan> #. Server instances stop</span><br><span> </span><br><span>@@ -77,7 +7=
9,8 @@</span><br><span> </span><br><span>     * t_server_null_client.sh</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      *=
 Waits until servers have launched. Then launch all clients, wait for them =
to exit and then check test results by parsing the client log files. Each c=
lient kills itself after some delay using an &quot;--up&quot; script.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      * Waits until serve=
rs have launched. Then launch all clients, run ovpnlwip ping tests (if any)=
, wait for clients to exit and then check test results by parsing the clien=
t log files. Each client kills itself after some delay using an &quot;--up&=
quot; script.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> </span><br><span> Configuration</span><br><span> -------------<=
/span><br><span>@@ -116,6 +119,19 @@</span><br><span> </span><br><span>   T=
EST_RUN_LIST=3D&quot;1 2 5 9&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Client ping tests that use ovpnlwip can b=
e added similarly:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  TEST_NAME_9L=3D&qu=
ot;t_server_null_client.sh-openvpn_current_udp_custom_lwip&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  SHOULD_PASS_9L=3D&quot;yes&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  CLIENT_EXEC_9=
L=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  CLIENT_CONF_9L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0=
.0.1 1194 udp --proto udp&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Note th=
at all ovpnlwip test names need to include a &quot;_lwip&quot; suffix: with=
out if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ping tests wo=
n&#39;t get activated. Also note that the *tests* directory needs to</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+have the lwipovpn executab=
le or ovpnlwip tests will get skipped. The ovpnlwip</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ping tests get the IP addresses to ping f=
rom the \*.ips files created by the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+lwip_client_up.sh script --up script.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Stress-testing the --de=
v null test suite</span><br><span> ----------------------------------------=
</span><br><span> </span><br><span>diff --git a/tests/lwip_client_up.sh b/t=
ests/lwip_client_up.sh</span><br><span>new file mode 100755</span><br><span=
>index 0000000..a07c4b7</span><br><span>--- /dev/null</span><br><span>+++ b=
/tests/lwip_client_up.sh</span><br><span>@@ -0,0 +1,30 @@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# Add this client&#39;s IP to a file</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+if ! grep &quot;$ifconfig_local&quot; ./$test_na=
me.ips; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ech=
o -n &quot;$ifconfig_local &quot; &gt;&gt; ./$test_name.ips</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# Determine the OpenVPN PID from its pid file. This works reliably even=
 when</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# the OpenVPN =
process is backgrounded for parallel tests.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+MY_PPID=3D`cat $pid`</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Allow OpenVPN to finish initializing while waiting in the backgroun=
d and then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# killing=
 the process gracefully. Also wait for fping tests to finish.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+(sleep 5</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+count=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+maxcount=3D15</span><br><span style=3D"color: hsl(120, 100%, 40%);">+whil=
e [ $count -le $maxcount ]; do</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if pgrep fping &gt; /dev/null 2&gt;&amp;1; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;Waiting for f=
ping to exit ($count/$maxcount)&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        count=3D$(( count + 1))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        sleep 1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        echo &quot;fping not running anymore&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        break</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+done</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+kill -1=
5 $MY_PPID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+) &amp;</=
span><br><span>diff --git a/tests/t_server_null_client.sh b/tests/t_server_=
null_client.sh</span><br><span>index 2210e63..77e1cc5 100755</span><br><spa=
n>--- a/tests/t_server_null_client.sh</span><br><span>+++ b/tests/t_server_=
null_client.sh</span><br><span>@@ -1,5 +1,17 @@</span><br><span> #!/bin/sh<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sh=
ould_run_test() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  test_name=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ech=
o &quot;$test_name&quot;|grep -q _lwip; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if [ &quot;$has_lwipovpn&quot; =3D &quot;n=
o&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return 0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> launch_client() {</span><br><span>     test_name=3D=
$1</span><br><span>     log=3D&quot;${test_name}.log&quot;</span><br><span>=
@@ -13,10 +25,45 @@</span><br><span>     &quot;${client_exec}&quot; \</span=
><br><span>         $client_conf \</span><br><span>         --writepid &quo=
t;${pid}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   --setenv pid $pid \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        --setenv pid &quot;$pid&quot; \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        --setenv test_name &quot;$test_name&quot; \<=
/span><br><span>         --log &quot;${t_server_null_logdir}/${log}&quot; &=
amp;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ping_lwip_clients() {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if [ &quot;$has_lwipovpn&quot; =3D &quot;yes&qu=
ot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
lwip_client_count=3D$(echo &quot;$lwip_test_names&quot;|wc -w|tr -d &quot; =
&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        lwip_client_cou=
nt=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if [ $lwip_client_count -eq 0 ]; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    count=3D0</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    maxcount=3D10</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    while [ $count -le $maxcount ]; do</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        lwip_client_ips=3D$(cat ./*.ips 2&gt;/d=
ev/null|wc -w|tr -d &quot; &quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if [ $lwip_client_ips -lt $lwip_client_count ]; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &q=
uot;Waiting for LWIP clients to start up ($count/$maxcount)&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            count=3D$(( count=
 + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
leep 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            echo &qu=
ot;$lwip_client_ips/$lwip_client_count LWIP clients up&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            break</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    LWIP_CLIENTS=3D$(cat ./*.ips 2&gt;/dev/null)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if [ &quot;$LWIP_CLIENTS&quot; ]; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ! fping -c 5=
 $LWIP_CLIENTS; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            echo &quot;ERROR: pinging one or more openvpnlwip client IP ad=
dresses failed!&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            retval=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> wait_for_results(=
) {</span><br><span>     tests_running=3D&quot;yes&quot;</span><br><span> <=
/span><br><span>@@ -77,7 +124,7 @@</span><br><span> server_max_wait=3D15</s=
pan><br><span> while [ $count -lt $server_max_wait ]; do</span><br><span>  =
   servers_up=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
server_count=3D$(echo $TEST_SERVER_LIST|wc -w)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    server_count=3D$(echo &quot;$TEST_SERVER_LIS=
T&quot;|wc -w|tr -d &quot; &quot;)</span><br><span> </span><br><span>     #=
 We need to trim single-quotes because some shells return quoted values</sp=
an><br><span>     # and some don&#39;t. Using &quot;set -o posix&quot; whic=
h would resolve this problem is</span><br><span>@@ -85,8 +132,8 @@</span><b=
r><span>     #</span><br><span>     # While inactive server configurations =
may get checked they won&#39;t increase</span><br><span>     # the active s=
erver count as the processes won&#39;t be running.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    for i in `set|grep &#39;SERVER_NAME_&#39;|=
cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&#39;]&quot;`; do</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        server_pid=3D$(cat $i.pid 2&g=
t; /dev/null)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r i in $(set|grep &#39;SERVER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d =
&quot;[\&#39;]&quot;); do</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        server_pid=3D$(cat &quot;$i.pid&quot; 2&gt; /dev/null)</span>=
<br><span>         if [ -z &quot;$server_pid&quot; ] ; then</span><br><span=
>             continue</span><br><span>         fi</span><br><span>@@ -111,=
6 +158,18 @@</span><br><span>     fi</span><br><span> done</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Check for presen=
ce of the lwipovpn executable</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+if test -r &quot;$LWIPOVPN_PATH&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    has_lwipovpn=3D&quot;yes&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    has_lwipovpn=3D&quot;no&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;WARNING: lwi=
povpn executable is missing: lwip tests will be skipped&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# Remove existing LWIP client IP files. This is to avoid pinging non-=
existent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IP addres=
ses when tests are disabled.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+$RUN_SUDO rm -f ./*.ips</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> # Wait a while to let server processes to se=
ttle down</span><br><span> sleep 1</span><br><span> </span><br><span>@@ -11=
8,6 +177,7 @@</span><br><span> # is used later to determine when all OpenVP=
N clients have exited and it is</span><br><span> # safe to check the test r=
esults.</span><br><span> test_names=3D&quot;&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+lwip_test_names=3D&quot;&quot;</span><br><sp=
an> for SUF in $TEST_RUN_LIST</span><br><span> do</span><br><span>     eval=
 test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>@@ -125,9 +185,=
18 @@</span><br><span>     eval client_conf=3D\&quot;\$CLIENT_CONF_$SUF\&qu=
ot;</span><br><span> </span><br><span>     test_names=3D&quot;${test_names}=
 ${test_name}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  (launch_client &quot;${test_name}&quot; &quot;${client_exec}&quot; &quot;=
${client_conf}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if echo &quot=
;$test_name&quot;|grep -q _lwip; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        lwip_test_names=3D&quot;${lwip_test_names} ${test=
_name}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if should_run_test &quot;$test_name=
&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 (launch_client &quot;${test_name}&quot; &quot;${client_exec}&quot; &quot;$=
{client_conf}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    fi</span><br><span> done</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ping_lwip_clients</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> # Wait until all OpenVPN client=
s have exited</span><br><span> (wait_for_results)</span><br><span> </span><=
br><span>@@ -137,7 +206,9 @@</span><br><span>     eval test_name=3D\&quot;\=
$TEST_NAME_$SUF\&quot;</span><br><span>     eval should_pass=3D\&quot;\$SHO=
ULD_PASS_$SUF\&quot;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    get_client_test_result &quot;${test_name}&quot; &quot;=
${should_pass}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if should_run_test &quot;$test_name&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        get_client_test_result &quot;${te=
st_name}&quot; &quot;${should_pass}&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    fi</span><br><span> done</span><br><span> </span>=
<br><span> exit $retval</span><br><span>diff --git a/tests/t_server_null_de=
fault.rc b/tests/t_server_null_default.rc</span><br><span>index cbf4877..cb=
6a2cd 100755</span><br><span>--- a/tests/t_server_null_default.rc</span><br=
><span>+++ b/tests/t_server_null_default.rc</span><br><span>@@ -19,6 +19,7 =
@@</span><br><span> SERVER_CERT=3D&quot;${sample_keys}/server.crt&quot;</sp=
an><br><span> SERVER_KEY=3D&quot;${sample_keys}/server.key&quot;</span><br>=
<span> TA=3D&quot;${sample_keys}/ta.key&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+LWIPOVPN_PATH=3D&quot;lwipovpn&quot;</span><br><s=
pan> </span><br><span> # Used to detect if graceful kill of any server inst=
ance failed during the test</span><br><span> # run</span><br><span>@@ -28,7=
 +29,7 @@</span><br><span> MAX_CLIENTS=3D&quot;10&quot;</span><br><span> CL=
IENT_MATCH=3D&quot;Test-Client&quot;</span><br><span> SERVER_EXEC=3D&quot;$=
{top_builddir}/src/openvpn/openvpn&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&quot;--daemon --local 127.0.0.1 --de=
v tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_BASE_OPT=
S=3D&quot;--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clie=
nts $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;</span><br><spa=
n> SERVER_CIPHER_OPTS=3D&quot;&quot;</span><br><span> SERVER_CERT_OPTS=3D&q=
uot;--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-a=
uth ${TA} 0&quot;</span><br><span> SERVER_CONF_BASE=3D&quot;${SERVER_BASE_O=
PTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><br><span>@@ -49=
,23 +50,37 @@</span><br><span> </span><br><span> # Test client configuratio=
ns</span><br><span> CLIENT_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_BASE_OPT=
S=3D&quot;--client --dev null --ifconfig-noexec --nobind --remote-cert-tls =
server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-max 3=
 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2 --up =
${srcdir}/null_client_up.sh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+CLIENT_BASE_OPTS=3D&quot;--client --nobind --remote-cert-tls =
server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-max 3=
 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_NULL_OPTS=3D=
&quot;--dev null --ifconfig-noexec --up ${srcdir}/null_client_up.sh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_LWIP_OPTS=3D&q=
uot;--dev null --dev-node unix:${LWIPOVPN_PATH} --up ${srcdir}/lwip_client_=
up.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> CLIENT_CIPHER_OPTS=3D&quot;&quot;</span><br><span> CLIENT_CERT_OP=
TS=3D&quot;--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth =
${TA} 1&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-TEST_RUN_LIST=3D&quot;1 2 3&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-CLIENT_CONF_BASE=3D&quot;${CLIENT_BASE_OPTS} ${CLIENT=
_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1 1L 2 2L 3&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_BASE=3D&quot;${CLIENT_N=
ULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_BASE_=
LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} =
${CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span> TEST_NAME_1=3D=
&quot;t_server_null_client.sh-openvpn_current_udp&quot;</span><br><span> SH=
OULD_PASS_1=3D&quot;yes&quot;</span><br><span> CLIENT_EXEC_1=3D&quot;${CLIE=
NT_EXEC}&quot;</span><br><span> CLIENT_CONF_1=3D&quot;${CLIENT_CONF_BASE} -=
-remote 127.0.0.1 1194 udp --proto udp&quot;</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_1L=3D&quot;t_server_nu=
ll_client.sh-openvpn_current_udp_lwip&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+SHOULD_PASS_1L=3D&quot;yes&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_1L=3D&quot;${CLIENT_EXEC}&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1L=
=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --proto udp&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> TEST_NAME_2=3D&quot;t_server_null_client.sh-openvpn_current_tcp&quot;</s=
pan><br><span> SHOULD_PASS_2=3D&quot;yes&quot;</span><br><span> CLIENT_EXEC=
_2=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF_2=3D&quot;${CL=
IENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto tcp&quot;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_2L=3D=
&quot;t_server_null_client.sh-openvpn_current_tcp_lwip&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_2L=3D&quot;yes&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_2L=3D&quo=
t;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+CLIENT_CONF_2L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1195 =
tcp --proto tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> TEST_NAME_3=3D&quot;t_server_null_client.sh-openvpn_cur=
rent_udp_fail&quot;</span><br><span> SHOULD_PASS_3=3D&quot;no&quot;</span><=
br><span> CLIENT_EXEC_3=3D&quot;${CLIENT_EXEC}&quot;</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/811?usp=3Demail">change 811</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9Vjw0tRk17Q=--

