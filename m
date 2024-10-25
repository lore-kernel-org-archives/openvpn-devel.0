From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 25 Oct 2024 10:19:06 +0000
In-Reply-To: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
References: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <d97f0ffd117a7d581cbc2c1b89f20bce036575de-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="60/x7Ouu2RU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null:
 forcibly kill misbehaving servers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--60/x7Ouu2RU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail

to look at the new patch set (#9).


Change subject: t_server_null: forcibly kill misbehaving servers
......................................................................

t_server_null: forcibly kill misbehaving servers

Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null.sh
M tests/t_server_null_client.sh
M tests/t_server_null_default.rc
M tests/t_server_null_server.sh
4 files changed, 30 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/775/9

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
     elif [ $exit_code -eq 0 ] && [ "${should_pass}" =3D "no" ]; then
         echo "FAIL ${test_name} (test failure)"
-        cat "${log}"
+        cat "${t_server_null_logdir}/${log}"
         retval=3D1
     elif [ $exit_code -eq 1 ] && [ "${should_pass}" =3D "yes" ]; then
         echo "FAIL ${test_name}"
-        cat "${log}"
+        cat "${t_server_null_logdir}/${log}"
         retval=3D1
     fi
 }
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 825bb52..cbf4877 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -20,6 +20,10 @@
 SERVER_KEY=3D"${sample_keys}/server.key"
 TA=3D"${sample_keys}/ta.key"

+# Used to detect if graceful kill of any server instance failed during the=
 test
+# run
+SERVER_KILL_FAIL_FILE=3D".t_server_null_server.kill_failed"
+
 # Test server configurations
 MAX_CLIENTS=3D"10"
 CLIENT_MATCH=3D"Test-Client"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index f8ba3a3..ab01dd2 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -8,6 +8,9 @@
     status=3D"${server_name}.status"
     pid=3D"${server_name}.pid"

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
 # server process does not exit in 15 seconds assume it never will, move on=
 and
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

     count=3D0
     maxcount=3D75
     while [ $count -le $maxcount ]
     do
-        ps -p "${SERVER_PID}" > /dev/null || break
+        $RUN_SUDO kill -0 "${SERVER_PID}" 2> /dev/null || break
         count=3D$(( count + 1))
         sleep 0.2
     done

+    # If server is still up send a SIGKILL
     if [ $count -ge $maxcount ]; then
-        echo "WARNING: could not kill server with pid ${SERVER_PID}!"
+        $RUN_SUDO $KILL_EXEC -9 "${SERVER_PID}"
+        SERVER_NAME=3D$(basename $PID_FILE|cut -d . -f 1)
+        echo "ERROR: had to send SIGKILL to server ${SERVER_NAME} with pid=
 ${SERVER_PID}!"
+        echo "Tail of server log:"
+        tail -n 20 "${t_server_null_logdir}/${SERVER_NAME}.log"
+        touch $SERVER_KILL_FAIL_FILE
     fi
 done

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Gerrit-Change-Number: 775
Gerrit-PatchSet: 9
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-MessageType: newpatchset

--60/x7Ouu2RU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p>mattock <strong>uploaded patch set #9</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">View Change<=
/a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">t_server_null: forcibly kill misbehaving servers<br><br>Change-Id: Ic0f=
98cd3b87a7b86e032e63167ac9036f7c08fcb<br>Signed-off-by: Samuli Sepp=C3=A4ne=
n &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests/t_server_null.sh<br>M=
 tests/t_server_null_client.sh<br>M tests/t_server_null_default.rc<br>M tes=
ts/t_server_null_server.sh<br>4 files changed, 30 insertions(+), 10 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/75/775/9</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/tests/t_server_null.sh b/tests/t_server_nul=
l.sh</span><br><span>index d4311d4..3c0fc4b 100755</span><br><span>--- a/te=
sts/t_server_null.sh</span><br><span>+++ b/tests/t_server_null.sh</span><br=
><span>@@ -71,4 +71,10 @@</span><br><span> # pre and post ifconfig output d=
oes not match.</span><br><span> wait</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-exit $retval</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+. ./t_server_null_default.rc</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+if [ -e $SERVER_KILL_FAIL_FILE ]; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    exit 1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    exit $retval</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+fi</span><br><span>diff --git a/tests/t_server_null_client.sh b/tes=
ts/t_server_null_client.sh</span><br><span>index 846f790..2210e63 100755</s=
pan><br><span>--- a/tests/t_server_null_client.sh</span><br><span>+++ b/tes=
ts/t_server_null_client.sh</span><br><span>@@ -53,11 +53,11 @@</span><br><s=
pan>         echo &quot;PASS ${test_name} (test failure)&quot;</span><br><s=
pan>     elif [ $exit_code -eq 0 ] &amp;&amp; [ &quot;${should_pass}&quot; =
=3D &quot;no&quot; ]; then</span><br><span>         echo &quot;FAIL ${test_=
name} (test failure)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        cat &quot;${log}&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cat &quot;${t_server_null_logdir}/${log}&quot;</spa=
n><br><span>         retval=3D1</span><br><span>     elif [ $exit_code -eq =
1 ] &amp;&amp; [ &quot;${should_pass}&quot; =3D &quot;yes&quot; ]; then</sp=
an><br><span>         echo &quot;FAIL ${test_name}&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        cat &quot;${log}&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cat &quot;${t_server_=
null_logdir}/${log}&quot;</span><br><span>         retval=3D1</span><br><sp=
an>     fi</span><br><span> }</span><br><span>diff --git a/tests/t_server_n=
ull_default.rc b/tests/t_server_null_default.rc</span><br><span>index 825bb=
52..cbf4877 100755</span><br><span>--- a/tests/t_server_null_default.rc</sp=
an><br><span>+++ b/tests/t_server_null_default.rc</span><br><span>@@ -20,6 =
+20,10 @@</span><br><span> SERVER_KEY=3D&quot;${sample_keys}/server.key&quo=
t;</span><br><span> TA=3D&quot;${sample_keys}/ta.key&quot;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Used to detect i=
f graceful kill of any server instance failed during the test</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# run</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+SERVER_KILL_FAIL_FILE=3D&quot;.t_server_null_se=
rver.kill_failed&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> # Test server configurations</span><br><span> MAX_CLIE=
NTS=3D&quot;10&quot;</span><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot=
;</span><br><span>diff --git a/tests/t_server_null_server.sh b/tests/t_serv=
er_null_server.sh</span><br><span>index f8ba3a3..ab01dd2 100755</span><br><=
span>--- a/tests/t_server_null_server.sh</span><br><span>+++ b/tests/t_serv=
er_null_server.sh</span><br><span>@@ -8,6 +8,9 @@</span><br><span>     stat=
us=3D&quot;${server_name}.status&quot;</span><br><span>     pid=3D&quot;${s=
erver_name}.pid&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    # Allow reading this file even umask values are str=
ict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    touch &quot;=
$log&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span>      =
   &quot;${server_exec}&quot; \</span><br><span>          $server_conf \</s=
pan><br><span>@@ -34,6 +37,9 @@</span><br><span> # Load local configuration=
, if any</span><br><span> test -r ./t_server_null.rc &amp;&amp; . ./t_serve=
r_null.rc</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# Remove server kill failure marker file, if any</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+rm -f $SERVER_KILL_FAIL_FILE</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Launch te=
st servers</span><br><span> for SUF in $TEST_SERVER_LIST</span><br><span> d=
o</span><br><span>@@ -75,6 +81,7 @@</span><br><span> # Make sure that the s=
erver processes are truly dead before exiting.  If a</span><br><span> # ser=
ver process does not exit in 15 seconds assume it never will, move on and</=
span><br><span> # hope for the best.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> echo &quot;Waiting for servers to exit&q=
uot;</span><br><span> for PID_FILE in $server_pid_files</span><br><span> do=
</span><br><span>@@ -85,22 +92,25 @@</span><br><span>         continue</spa=
n><br><span>     fi</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        $KILL_EXEC &quot;${SERVER_PID=
}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        $RUN_SUDO $KILL_EXE=
C &quot;${SERVER_PID}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # A=
ttempt to kill the OpenVPN server gracefully with SIGTERM</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    $RUN_SUDO $KILL_EXEC &quot;${SERV=
ER_PID}&quot;</span><br><span> </span><br><span>     count=3D0</span><br><s=
pan>     maxcount=3D75</span><br><span>     while [ $count -le $maxcount ]<=
/span><br><span>     do</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ps -p &quot;${SERVER_PID}&quot; &gt; /dev/null || break</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        $RUN_SUDO kill -0 &qu=
ot;${SERVER_PID}&quot; 2&gt; /dev/null || break</span><br><span>         co=
unt=3D$(( count + 1))</span><br><span>         sleep 0.2</span><br><span>  =
   done</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    # If server is still up send a SIGKILL</span><br><span>     if [ =
$count -ge $maxcount ]; then</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        echo &quot;WARNING: could not kill server with pid ${SERVER_=
PID}!&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
$RUN_SUDO $KILL_EXEC -9 &quot;${SERVER_PID}&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        SERVER_NAME=3D$(basename $PID_FILE|cu=
t -d . -f 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 echo &quot;ERROR: had to send SIGKILL to server ${SERVER_NAME} with pid ${=
SERVER_PID}!&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       echo &quot;Tail of server log:&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tail -n 20 &quot;${t_server_null_logdir}/${=
SERVER_NAME}.log&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        touch $SERVER_KILL_FAIL_FILE</span><br><span>     fi</span><br><=
span> done</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">change 775</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/775?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167a=
c9036f7c08fcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 775 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
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


--60/x7Ouu2RU=--

