From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 4 Oct 2024 07:20:01 +0000
In-Reply-To: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
References: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <c29f34244a9c38f4cf10fe8713a5c8f2ba8a0e2e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xp5Jr9dzJ+g="; charset=UTF-8
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

--xp5Jr9dzJ+g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail

to look at the new patch set (#3).


Change subject: t_server_null: forcibly kill misbehaving servers
......................................................................

t_server_null: forcibly kill misbehaving servers

Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null_server.sh
1 file changed, 5 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/775/3

diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 10bb44b..b85d145 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -87,11 +87,8 @@
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
@@ -102,7 +99,9 @@
         sleep 0.2
     done

+    # If server is still up send a SIGKILL
     if [ $count -ge $maxcount ]; then
-        echo "WARNING: could not kill server with pid ${SERVER_PID}!"
+        $RUN_SUDO $KILL_EXEC -9 "${SERVER_PID}"
+        echo "WARNING: had to send SIGKILL to server with pid ${SERVER_PID=
}!"
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
Gerrit-PatchSet: 3
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-MessageType: newpatchset

--xp5Jr9dzJ+g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p>mattock <strong>uploaded patch set #3</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">View Change<=
/a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">t_server_null: forcibly kill misbehaving servers<br><br>Change-Id: Ic0f=
98cd3b87a7b86e032e63167ac9036f7c08fcb<br>Signed-off-by: Samuli Sepp=C3=A4ne=
n &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests/t_server_null_server.=
sh<br>1 file changed, 5 insertions(+), 6 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/75/775/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh</span><=
br><span>index 10bb44b..b85d145 100755</span><br><span>--- a/tests/t_server=
_null_server.sh</span><br><span>+++ b/tests/t_server_null_server.sh</span><=
br><span>@@ -87,11 +87,8 @@</span><br><span>         continue</span><br><sp=
an>     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        $KILL_EXEC &quot;${SERVER_PID}&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        $RUN_SUDO $KILL_EXEC &quot;$=
{SERVER_PID}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Attempt to=
 kill the OpenVPN server gracefully with SIGTERM</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    $RUN_SUDO $KILL_EXEC &quot;${SERVER_PID}&q=
uot;</span><br><span> </span><br><span>     count=3D0</span><br><span>     =
maxcount=3D75</span><br><span>@@ -102,7 +99,9 @@</span><br><span>         s=
leep 0.2</span><br><span>     done</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # If server is still up send a SIGKIL=
L</span><br><span>     if [ $count -ge $maxcount ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        echo &quot;WARNING: could not ki=
ll server with pid ${SERVER_PID}!&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        $RUN_SUDO $KILL_EXEC -9 &quot;${SERVER_PID}&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quo=
t;WARNING: had to send SIGKILL to server with pid ${SERVER_PID}!&quot;</spa=
n><br><span>     fi</span><br><span> done</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=
=3Demail">change 775</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167a=
c9036f7c08fcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 775 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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


--xp5Jr9dzJ+g=--

