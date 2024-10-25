From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 25 Oct 2024 06:50:13 +0000
In-Reply-To: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
References: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <fa60cae43b83a628b258dfe0f05067b9ecfad17f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+KWtKJoGsdM="; charset=UTF-8
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

--+KWtKJoGsdM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail

to look at the new patch set (#8).


Change subject: t_server_null: forcibly kill misbehaving servers
......................................................................

t_server_null: forcibly kill misbehaving servers

Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null.sh
M tests/t_server_null_default.rc
M tests/t_server_null_server.sh
3 files changed, 25 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/775/8

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
index f8ba3a3..4d86f46 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -34,6 +34,9 @@
 # Load local configuration, if any
 test -r ./t_server_null.rc && . ./t_server_null.rc

+# Remove server kill failure marker file, if any
+rm -f $SERVER_KILL_FAIL_FILE
+
 # Launch test servers
 for SUF in $TEST_SERVER_LIST
 do
@@ -75,6 +78,7 @@
 # Make sure that the server processes are truly dead before exiting.  If a
 # server process does not exit in 15 seconds assume it never will, move on=
 and
 # hope for the best.
+
 echo "Waiting for servers to exit"
 for PID_FILE in $server_pid_files
 do
@@ -85,22 +89,25 @@
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
Gerrit-PatchSet: 8
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-MessageType: newpatchset

--+KWtKJoGsdM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p>mattock <strong>uploaded patch set #8</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">View Change<=
/a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">t_server_null: forcibly kill misbehaving servers<br><br>Change-Id: Ic0f=
98cd3b87a7b86e032e63167ac9036f7c08fcb<br>Signed-off-by: Samuli Sepp=C3=A4ne=
n &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests/t_server_null.sh<br>M=
 tests/t_server_null_default.rc<br>M tests/t_server_null_server.sh<br>3 fil=
es changed, 25 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/75/775/8</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/test=
s/t_server_null.sh b/tests/t_server_null.sh</span><br><span>index d4311d4..=
3c0fc4b 100755</span><br><span>--- a/tests/t_server_null.sh</span><br><span=
>+++ b/tests/t_server_null.sh</span><br><span>@@ -71,4 +71,10 @@</span><br>=
<span> # pre and post ifconfig output does not match.</span><br><span> wait=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-exi=
t $retval</span><br><span style=3D"color: hsl(120, 100%, 40%);">+. ./t_serv=
er_null_default.rc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -e $SERVER_KILL=
_FAIL_FILE ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit $retval</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span>diff --gi=
t a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc</span><=
br><span>index 825bb52..cbf4877 100755</span><br><span>--- a/tests/t_server=
_null_default.rc</span><br><span>+++ b/tests/t_server_null_default.rc</span=
><br><span>@@ -20,6 +20,10 @@</span><br><span> SERVER_KEY=3D&quot;${sample_=
keys}/server.key&quot;</span><br><span> TA=3D&quot;${sample_keys}/ta.key&qu=
ot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# Used to detect if graceful kill of any server instance failed during th=
e test</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# run</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_KILL_FAIL_FILE=3D&qu=
ot;.t_server_null_server.kill_failed&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> # Test server configurations</span=
><br><span> MAX_CLIENTS=3D&quot;10&quot;</span><br><span> CLIENT_MATCH=3D&q=
uot;Test-Client&quot;</span><br><span>diff --git a/tests/t_server_null_serv=
er.sh b/tests/t_server_null_server.sh</span><br><span>index f8ba3a3..4d86f4=
6 100755</span><br><span>--- a/tests/t_server_null_server.sh</span><br><spa=
n>+++ b/tests/t_server_null_server.sh</span><br><span>@@ -34,6 +34,9 @@</sp=
an><br><span> # Load local configuration, if any</span><br><span> test -r .=
/t_server_null.rc &amp;&amp; . ./t_server_null.rc</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# Remove server kill failur=
e marker file, if any</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+rm -f $SERVER_KILL_FAIL_FILE</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> # Launch test servers</span><br><span> for SUF=
 in $TEST_SERVER_LIST</span><br><span> do</span><br><span>@@ -75,6 +78,7 @@=
</span><br><span> # Make sure that the server processes are truly dead befo=
re exiting.  If a</span><br><span> # server process does not exit in 15 sec=
onds assume it never will, move on and</span><br><span> # hope for the best=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
echo &quot;Waiting for servers to exit&quot;</span><br><span> for PID_FILE =
in $server_pid_files</span><br><span> do</span><br><span>@@ -85,22 +89,25 @=
@</span><br><span>         continue</span><br><span>     fi</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;$=
{RUN_SUDO}&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        $KILL_EXEC &quot;${SERVER_PID}&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        $RUN_SUDO $KILL_EXEC &quot;${SERVER_PID}&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # Attempt to kill the OpenVPN server =
gracefully with SIGTERM</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    $RUN_SUDO $KILL_EXEC &quot;${SERVER_PID}&quot;</span><br><span> </s=
pan><br><span>     count=3D0</span><br><span>     maxcount=3D75</span><br><=
span>     while [ $count -le $maxcount ]</span><br><span>     do</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ps -p &quot;${SERVER_PID=
}&quot; &gt; /dev/null || break</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        $RUN_SUDO kill -0 &quot;${SERVER_PID}&quot; 2&gt; /dev/=
null || break</span><br><span>         count=3D$(( count + 1))</span><br><s=
pan>         sleep 0.2</span><br><span>     done</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    # If server is still up =
send a SIGKILL</span><br><span>     if [ $count -ge $maxcount ]; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &quot;WARNING:=
 could not kill server with pid ${SERVER_PID}!&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        $RUN_SUDO $KILL_EXEC -9 &quot;${S=
ERVER_PID}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     SERVER_NAME=3D$(basename $PID_FILE|cut -d . -f 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        echo &quot;ERROR: had to send SI=
GKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;Tail of server =
log:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
ail -n 20 &quot;${t_server_null_logdir}/${SERVER_NAME}.log&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        touch $SERVER_KILL_FAI=
L_FILE</span><br><span>     fi</span><br><span> done</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/775?usp=3Demail">change 775</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167a=
c9036f7c08fcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 775 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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


--+KWtKJoGsdM=--

