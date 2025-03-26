From: "mattock (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 12:51:35 +0000
References: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4442e5997690138788e140bbca04009fa98657b8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i+DA1WJ8adw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null: add
 multi-socket testing
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

--i+DA1WJ8adw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail

to review the following change.


Change subject: t_server_null: add multi-socket testing
......................................................................

t_server_null: add multi-socket testing

This makes the first server instance listen on both 127.0.0.1 and ::1
and adds a client that connects to the latter.

Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null_default.rc
1 file changed, 11 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/919/1

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index e7bf5bc..0775192 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -48,7 +48,7 @@
 SERVER_SERVER_1=3D"--server 10.29.41.0 255.255.255.0"
 SERVER_MGMT_PORT_1=3D"11194"
 SERVER_EXEC_1=3D"${SERVER_EXEC}"
-SERVER_CONF_1=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_1} --lport 1194 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}"
+SERVER_CONF_1=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_1} --local ::1 --lpor=
t 1194 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}"

 SERVER_NAME_2=3D"t_server_null_server-1195_tcp"
 SERVER_SERVER_2=3D"--server 10.29.42.0 255.255.255.0"
@@ -65,14 +65,19 @@
 CLIENT_CIPHER_OPTS=3D""
 CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"

-TEST_RUN_LIST=3D"1 1L 2 2L 3"
+TEST_RUN_LIST=3D"1a 1b 1L 2 2L 3"
 CLIENT_CONF_BASE=3D"${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHE=
R_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP=3D"${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}"

-TEST_NAME_1=3D"t_server_null_client.sh-openvpn_current_udp"
-SHOULD_PASS_1=3D"yes"
-CLIENT_EXEC_1=3D"${CLIENT_EXEC}"
-CLIENT_CONF_1=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto u=
dp"
+TEST_NAME_1a=3D"t_server_null_client.sh-openvpn_current_udp_ipv4_remote"
+SHOULD_PASS_1a=3D"yes"
+CLIENT_EXEC_1a=3D"${CLIENT_EXEC}"
+CLIENT_CONF_1a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto =
udp"
+
+TEST_NAME_1b=3D"t_server_null_client.sh-openvpn_current_udp_ipv6_remote"
+SHOULD_PASS_1b=3D"yes"
+CLIENT_EXEC_1b=3D"${CLIENT_EXEC}"
+CLIENT_CONF_1b=3D"${CLIENT_CONF_BASE} --remote ::1 1194 udp --proto udp"

 TEST_NAME_1L=3D"t_server_null_client.sh-openvpn_current_udp_lwip"
 SHOULD_PASS_1L=3D"yes"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5
Gerrit-Change-Number: 919
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--i+DA1WJ8adw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null: add multi-socket testing<br><br>This makes the=
 first server instance listen on both 127.0.0.1 and ::1<br>and adds a clien=
t that connects to the latter.<br><br>Change-Id: I4ebe1158c36a641888131e824=
f59004a0f8fb4c5<br>Signed-off-by: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@=
...277...&gt;<br>---<br>M tests/t_server_null_default.rc<br>1 file changed,=
 11 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/19/919/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_server_=
null_default.rc b/tests/t_server_null_default.rc</span><br><span>index e7bf=
5bc..0775192 100755</span><br><span>--- a/tests/t_server_null_default.rc</s=
pan><br><span>+++ b/tests/t_server_null_default.rc</span><br><span>@@ -48,7=
 +48,7 @@</span><br><span> SERVER_SERVER_1=3D&quot;--server 10.29.41.0 255.=
255.255.0&quot;</span><br><span> SERVER_MGMT_PORT_1=3D&quot;11194&quot;</sp=
an><br><span> SERVER_EXEC_1=3D&quot;${SERVER_EXEC}&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-SERVER_CONF_1=3D&quot;${SERVER_CONF_BASE=
} ${SERVER_SERVER_1} --lport 1194 --proto udp --management 127.0.0.1 ${SERV=
ER_MGMT_PORT_1}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+SERVER_CONF_1=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_1} --local ::1 =
--lport 1194 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}&quot;=
</span><br><span> </span><br><span> SERVER_NAME_2=3D&quot;t_server_null_ser=
ver-1195_tcp&quot;</span><br><span> SERVER_SERVER_2=3D&quot;--server 10.29.=
42.0 255.255.255.0&quot;</span><br><span>@@ -65,14 +65,19 @@</span><br><spa=
n> CLIENT_CIPHER_OPTS=3D&quot;&quot;</span><br><span> CLIENT_CERT_OPTS=3D&q=
uot;--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1=
&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-TEST_RUN_LIST=3D&quot;1 1L 2 2L 3&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1a 1b 1L 2 2L 3&quot;</span><b=
r><span> CLIENT_CONF_BASE=3D&quot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} $=
{CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> CLIENT_CONF=
_BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_=
OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-TEST_NAME_1=3D&quot;t_server_null_client.sh-ope=
nvpn_current_udp&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-SHOULD_PASS_1=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-CLIENT_EXEC_1=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_1=3D&quot;${CLIENT_CONF_BASE} -=
-remote 127.0.0.1 1194 udp --proto udp&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+TEST_NAME_1a=3D&quot;t_server_null_client.sh-openv=
pn_current_udp_ipv4_remote&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+SHOULD_PASS_1a=3D&quot;yes&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+CLIENT_EXEC_1a=3D&quot;${CLIENT_EXEC}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1a=3D&quot;${=
CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+TEST_NAME_1b=3D&quot;t_server_null_client.sh-openv=
pn_current_udp_ipv6_remote&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+SHOULD_PASS_1b=3D&quot;yes&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+CLIENT_EXEC_1b=3D&quot;${CLIENT_EXEC}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1b=3D&quot;${=
CLIENT_CONF_BASE} --remote ::1 1194 udp --proto udp&quot;</span><br><span> =
</span><br><span> TEST_NAME_1L=3D&quot;t_server_null_client.sh-openvpn_curr=
ent_udp_lwip&quot;</span><br><span> SHOULD_PASS_1L=3D&quot;yes&quot;</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/919?usp=3Demail">change 919</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/919?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebe1158c36a641888131e824f5=
9004a0f8fb4c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
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


--i+DA1WJ8adw=--

