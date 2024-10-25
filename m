From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 25 Oct 2024 13:00:12 +0000
References: <gerrit.1729861210000.Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f79af1a3decd6d195e80859c0ec4867fccc5f703-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VdH33AM+W68="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null: use
 wait instead of marker files
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

--VdH33AM+W68=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/786?usp=3Demail

to review the following change.


Change subject: t_server_null: use wait instead of marker files
......................................................................

t_server_null: use wait instead of marker files

By using wait in a more inventive way we can avoid using a marker file
to detect the "server could not be killed gracefully" situation.

Change-Id: Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null.sh
M tests/t_server_null_server.sh
2 files changed, 10 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/786/1

diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 3c0fc4b..74ffd52 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -62,6 +62,8 @@
 mkdir $t_server_null_logdir

 "${srcdir}/t_server_null_server.sh" &
+T_SERVER_NULL_SERVER_PID=3D$!
+
 "${srcdir}/t_server_null_client.sh"
 retval=3D$?

@@ -69,11 +71,9 @@
 # that this script does not exit before all --dev null servers are dead and
 # their network interfaces are gone. Otherwise t_client.sh will fail becau=
se
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
+# We can't exit immediately on the first failure as that could leave proce=
sses
+# lying around.
+retval=3D0

 # Launch test servers
 for SUF in $TEST_SERVER_LIST
@@ -81,7 +82,6 @@
 # Make sure that the server processes are truly dead before exiting.  If a
 # server process does not exit in 15 seconds assume it never will, move on=
 and
 # hope for the best.
-
 echo "Waiting for servers to exit"
 for PID_FILE in $server_pid_files
 do
@@ -111,6 +111,8 @@
         echo "ERROR: had to send SIGKILL to server ${SERVER_NAME} with pid=
 ${SERVER_PID}!"
         echo "Tail of server log:"
         tail -n 20 "${t_server_null_logdir}/${SERVER_NAME}.log"
-        touch $SERVER_KILL_FAIL_FILE
+        retval=3D1
     fi
 done
+
+exit $retval

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/786?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb
Gerrit-Change-Number: 786
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--VdH33AM+W68=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/786?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null: use wait instead of marker files<br><br>By usi=
ng wait in a more inventive way we can avoid using a marker file<br>to dete=
ct the &quot;server could not be killed gracefully&quot; situation.<br><br>=
Change-Id: Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb<br>Signed-off-by: Samu=
li Sepp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests/t_serv=
er_null.sh<br>M tests/t_server_null_server.sh<br>2 files changed, 10 insert=
ions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/86/786/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/tests/t_server_null.sh b/=
tests/t_server_null.sh</span><br><span>index 3c0fc4b..74ffd52 100755</span>=
<br><span>--- a/tests/t_server_null.sh</span><br><span>+++ b/tests/t_server=
_null.sh</span><br><span>@@ -62,6 +62,8 @@</span><br><span> mkdir $t_server=
_null_logdir</span><br><span> </span><br><span> &quot;${srcdir}/t_server_nu=
ll_server.sh&quot; &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+T_SERVER_NULL_SERVER_PID=3D$!</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> &quot;${srcdir}/t_server_null_client.sh&qu=
ot;</span><br><span> retval=3D$?</span><br><span> </span><br><span>@@ -69,1=
1 +71,9 @@</span><br><span> # that this script does not exit before all --d=
ev null servers are dead and</span><br><span> # their network interfaces ar=
e gone. Otherwise t_client.sh will fail because</span><br><span> # pre and =
post ifconfig output does not match.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-wait</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
wait $T_SERVER_NULL_SERVER_PID</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-. ./t_server_null_default.rc</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-if [ -e $SERVER_KILL_FAIL_FILE ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if [ $? -ne 0 ]; then</span><br><span>   =
  exit 1</span><br><span> else</span><br><span>     exit $retval</span><br>=
<span>diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_serv=
er.sh</span><br><span>index ab01dd2..acf8479 100755</span><br><span>--- a/t=
ests/t_server_null_server.sh</span><br><span>+++ b/tests/t_server_null_serv=
er.sh</span><br><span>@@ -37,8 +37,9 @@</span><br><span> # Load local confi=
guration, if any</span><br><span> test -r ./t_server_null.rc &amp;&amp; . .=
/t_server_null.rc</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# Remove server kill failure marker file, if any</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-rm -f $SERVER_KILL_FAIL_FILE</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# We can&#39;t exit immed=
iately on the first failure as that could leave processes</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# lying around.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+retval=3D0</span><br><span> </span><br><s=
pan> # Launch test servers</span><br><span> for SUF in $TEST_SERVER_LIST</s=
pan><br><span>@@ -81,7 +82,6 @@</span><br><span> # Make sure that the serve=
r processes are truly dead before exiting.  If a</span><br><span> # server =
process does not exit in 15 seconds assume it never will, move on and</span=
><br><span> # hope for the best.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> echo &quot;Waiting for servers to exit&quot;</=
span><br><span> for PID_FILE in $server_pid_files</span><br><span> do</span=
><br><span>@@ -111,6 +111,8 @@</span><br><span>         echo &quot;ERROR: h=
ad to send SIGKILL to server ${SERVER_NAME} with pid ${SERVER_PID}!&quot;</=
span><br><span>         echo &quot;Tail of server log:&quot;</span><br><spa=
n>         tail -n 20 &quot;${t_server_null_logdir}/${SERVER_NAME}.log&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        touch $SERVE=
R_KILL_FAIL_FILE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     retval=3D1</span><br><span>     fi</span><br><span> done</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+exit $retval</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/786?usp=3Demai=
l">change 786</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/786?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib385080e1dd1c3046c54e6267db=
8aa7d5c09e2fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 786 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--VdH33AM+W68=--

