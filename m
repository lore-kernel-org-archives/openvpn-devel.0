From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 4 Oct 2024 06:00:24 +0000
References: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3086a86985d7f9217cde0db8b3104088fe6c513c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IaUa6GqGNys="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null:
 forcibly kill misbehaving servers
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

--IaUa6GqGNys=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail

to review the following change.


Change subject: t_server_null: forcibly kill misbehaving servers
......................................................................

t_server_null: forcibly kill misbehaving servers

Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null_server.sh
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/775/1

diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 10bb44b..dea2a04 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -88,9 +88,9 @@
     fi

     if [ -z "${RUN_SUDO}" ]; then
-        $KILL_EXEC "${SERVER_PID}"
+        $KILL_EXEC -15 "${SERVER_PID}" || $KILL_EXEC -9 "${SERVER_PID}"
     else
-        $RUN_SUDO $KILL_EXEC "${SERVER_PID}"
+        $RUN_SUDO $KILL_EXEC -15 "${SERVER_PID}" || $RUN_SUDO $KILL_EXEC -=
9 "${SERVER_PID}"
     fi

     count=3D0

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Gerrit-Change-Number: 775
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--IaUa6GqGNys=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null: forcibly kill misbehaving servers<br><br>Chang=
e-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb<br>Signed-off-by: Samuli Se=
pp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests/t_server_nu=
ll_server.sh<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/775/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.s=
h</span><br><span>index 10bb44b..dea2a04 100755</span><br><span>--- a/tests=
/t_server_null_server.sh</span><br><span>+++ b/tests/t_server_null_server.s=
h</span><br><span>@@ -88,9 +88,9 @@</span><br><span>     fi</span><br><span=
> </span><br><span>     if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        $KILL_EXEC &quot;${SERVER=
_PID}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
$KILL_EXEC -15 &quot;${SERVER_PID}&quot; || $KILL_EXEC -9 &quot;${SERVER_PI=
D}&quot;</span><br><span>     else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        $RUN_SUDO $KILL_EXEC &quot;${SERVER_PID}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        $RUN_SUDO $KILL_EXE=
C -15 &quot;${SERVER_PID}&quot; || $RUN_SUDO $KILL_EXEC -9 &quot;${SERVER_P=
ID}&quot;</span><br><span>     fi</span><br><span> </span><br><span>     co=
unt=3D0</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">change 775</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/775?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167a=
c9036f7c08fcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 775 </div>
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


--IaUa6GqGNys=--

