From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 26 Oct 2024 09:52:00 +0000
In-Reply-To: <gerrit.1729861210000.Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb@...2715...>
References: <gerrit.1729861210000.Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0e03a9ff7b73b10d31269594a81d817a986dcfc2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GjDvT7D+gsg="; charset=UTF-8
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
To: mattock <samuli@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GjDvT7D+gsg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 mattock. ( http://gerrit.openvpn.net/c/openvpn/+/786?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: t_server_null: use wait instead of marker files
......................................................................

t_server_null: use wait instead of marker files

By using wait in a more inventive way we can avoid using a marker file
to detect the "server could not be killed gracefully" situation.

Change-Id: Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241026092515.30559-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
664.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null.sh
M tests/t_server_null_server.sh
2 files changed, 10 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/786/2

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
=20
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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/786?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb
Gerrit-Change-Number: 786
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--GjDvT7D+gsg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by mattock.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/78=
6?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">t_server_null: use wait instead of marker files<br><=
br>By using wait in a more inventive way we can avoid using a marker file<b=
r>to detect the &quot;server could not be killed gracefully&quot; situation=
.<br><br>Change-Id: Ib385080e1dd1c3046c54e6267db8aa7d5c09e2fb<br>Signed-off=
-by: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>Acked-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20241026092515.30559-=
1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg29664.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M tests/t_server_null.sh<br>M tests/t_server_null_s=
erver.sh<br>2 files changed, 10 insertions(+), 8 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/786/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh</span><br><spa=
n>index 3c0fc4b..74ffd52 100755</span><br><span>--- a/tests/t_server_null.s=
h</span><br><span>+++ b/tests/t_server_null.sh</span><br><span>@@ -62,6 +62=
,8 @@</span><br><span> mkdir $t_server_null_logdir</span><br><span> </span>=
<br><span> &quot;${srcdir}/t_server_null_server.sh&quot; &amp;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+T_SERVER_NULL_SERVER_PID=3D$!</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> &quo=
t;${srcdir}/t_server_null_client.sh&quot;</span><br><span> retval=3D$?</spa=
n><br><span> </span><br><span>@@ -69,11 +71,9 @@</span><br><span> # that th=
is script does not exit before all --dev null servers are dead and</span><b=
r><span> # their network interfaces are gone. Otherwise t_client.sh will fa=
il because</span><br><span> # pre and post ifconfig output does not match.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-wait</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+wait $T_SERVER_NULL_SERVER_PID</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-. ./t_serv=
er_null_default.rc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -e $SERVER_KILL_FAI=
L_FILE ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ =
$? -ne 0 ]; then</span><br><span>     exit 1</span><br><span> else</span><b=
r><span>     exit $retval</span><br><span>diff --git a/tests/t_server_null_=
server.sh b/tests/t_server_null_server.sh</span><br><span>index ab01dd2..ac=
f8479 100755</span><br><span>--- a/tests/t_server_null_server.sh</span><br>=
<span>+++ b/tests/t_server_null_server.sh</span><br><span>@@ -37,8 +37,9 @@=
</span><br><span> # Load local configuration, if any</span><br><span> test =
-r ./t_server_null.rc &amp;&amp; . ./t_server_null.rc</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# Remove server kill fail=
ure marker file, if any</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-rm -f $SERVER_KILL_FAIL_FILE</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# We can&#39;t exit immediately on the first failure as that cou=
ld leave processes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 lying around.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+retva=
l=3D0</span><br><span> </span><br><span> # Launch test servers</span><br><s=
pan> for SUF in $TEST_SERVER_LIST</span><br><span>@@ -81,7 +82,6 @@</span><=
br><span> # Make sure that the server processes are truly dead before exiti=
ng.  If a</span><br><span> # server process does not exit in 15 seconds ass=
ume it never will, move on and</span><br><span> # hope for the best.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> echo &quot=
;Waiting for servers to exit&quot;</span><br><span> for PID_FILE in $server=
_pid_files</span><br><span> do</span><br><span>@@ -111,6 +111,8 @@</span><b=
r><span>         echo &quot;ERROR: had to send SIGKILL to server ${SERVER_N=
AME} with pid ${SERVER_PID}!&quot;</span><br><span>         echo &quot;Tail=
 of server log:&quot;</span><br><span>         tail -n 20 &quot;${t_server_=
null_logdir}/${SERVER_NAME}.log&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        touch $SERVER_KILL_FAIL_FILE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        retval=3D1</span><br><span>     f=
i</span><br><span> done</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exit $retval</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/786?usp=3Demail">change 786</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/786?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib385080e1dd1c3046c54e6267db=
8aa7d5c09e2fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 786 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--GjDvT7D+gsg=--

