From: "mattock (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 13:43:45 +0000
In-Reply-To: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
References: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b0a08274b958a45cb44b6ced9cc6f318189f9362-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hnseTag8yiI="; charset=UTF-8
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

--hnseTag8yiI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail

to look at the new patch set (#2).


Change subject: t_server_null: add multi-socket testing
......................................................................

t_server_null: add multi-socket testing

This adds a new multi-socket server that listens on IPv4 and IPv6
localhost addresses for TCP and UDP connections respectively. It also
adds two success tests and one failure test with wrong protocol defined
at the client side.

Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null_default.rc
1 file changed, 27 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/919/2

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index e7bf5bc..d1abad2 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -37,12 +37,14 @@
 MAX_CLIENTS=3D"10"
 CLIENT_MATCH=3D"Test-Client"
 SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BASE_OPTS=3D"--daemon --dev tun --topology subnet --max-clients $MA=
X_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BIND_OPTS=3D"--local 127.0.0.1"
 SERVER_CIPHER_OPTS=3D""
 SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
-SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"
+SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS} ${SERVER_BIND_OPTS}"
+SERVER_CONF_BASE_MULTISOCKET=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} =
${SERVER_CERT_OPTS}"

-TEST_SERVER_LIST=3D"1 2"
+TEST_SERVER_LIST=3D"1 2 4"

 SERVER_NAME_1=3D"t_server_null_server-1194_udp"
 SERVER_SERVER_1=3D"--server 10.29.41.0 255.255.255.0"
@@ -56,6 +58,12 @@
 SERVER_EXEC_2=3D"${SERVER_EXEC}"
 SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"

+SERVER_NAME_4=3D"t_server_null_server-1197_multisocket_ipv4_ipv6"
+SERVER_SERVER_4=3D"--server 10.29.43.0 255.255.255.0"
+SERVER_MGMT_PORT_4=3D"11197"
+SERVER_EXEC_4=3D"${SERVER_EXEC}"
+SERVER_CONF_4=3D"${SERVER_CONF_BASE_MULTISOCKET} ${SERVER_SERVER_4} --loca=
l 127.0.0.1 1197 tcp --local ::1 1197 udp --management 127.0.0.1 ${SERVER_M=
GMT_PORT_4}"
+
 # Test client configurations
 CLIENT_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
 CLIENT_BASE_OPTS=3D"--client --nobind --remote-cert-tls server --persist-t=
un --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-tim=
eout 5 --explicit-exit-notify 3 --script-security 2"
@@ -65,7 +73,7 @@
 CLIENT_CIPHER_OPTS=3D""
 CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"

-TEST_RUN_LIST=3D"1 1L 2 2L 3"
+TEST_RUN_LIST=3D"1 1L 2 2L 3 5a 5b 5c"
 CLIENT_CONF_BASE=3D"${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHE=
R_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP=3D"${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}"

@@ -93,3 +101,18 @@
 SHOULD_PASS_3=3D"no"
 CLIENT_EXEC_3=3D"${CLIENT_EXEC}"
 CLIENT_CONF_3=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto =
udp"
+
+TEST_NAME_5a=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv4_t=
cp"
+SHOULD_PASS_5a=3D"yes"
+CLIENT_EXEC_5a=3D"${CLIENT_EXEC}"
+CLIENT_CONF_5a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp"
+
+TEST_NAME_5b=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv6_u=
dp"
+SHOULD_PASS_5b=3D"yes"
+CLIENT_EXEC_5b=3D"${CLIENT_EXEC}"
+CLIENT_CONF_5b=3D"${CLIENT_CONF_BASE} --remote ::1 1197 udp"
+
+TEST_NAME_5c=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv6_t=
cp_fail"
+SHOULD_PASS_5c=3D"no"
+CLIENT_EXEC_5c=3D"${CLIENT_EXEC}"
+CLIENT_CONF_5c=3D"${CLIENT_CONF_BASE} --remote ::1 1197 tcp"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5
Gerrit-Change-Number: 919
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--hnseTag8yiI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock <strong>uploaded patch set #2</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail">View Change<=
/a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">t_server_null: add multi-socket testing<br><br>This adds a new multi-so=
cket server that listens on IPv4 and IPv6<br>localhost addresses for TCP an=
d UDP connections respectively. It also<br>adds two success tests and one f=
ailure test with wrong protocol defined<br>at the client side.<br><br>Chang=
e-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5<br>Signed-off-by: Samuli Se=
pp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests/t_server_nu=
ll_default.rc<br>1 file changed, 27 insertions(+), 4 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/919/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_defau=
lt.rc</span><br><span>index e7bf5bc..d1abad2 100755</span><br><span>--- a/t=
ests/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_def=
ault.rc</span><br><span>@@ -37,12 +37,14 @@</span><br><span> MAX_CLIENTS=3D=
&quot;10&quot;</span><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot;</spa=
n><br><span> SERVER_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&qu=
ot;--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clients $MA=
X_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SERVER_BASE_OPTS=3D&quot;--daemon --dev t=
un --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --du=
plicate-cn&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SER=
VER_BIND_OPTS=3D&quot;--local 127.0.0.1&quot;</span><br><span> SERVER_CIPHE=
R_OPTS=3D&quot;&quot;</span><br><span> SERVER_CERT_OPTS=3D&quot;--ca ${CA} =
--dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SERVER_CONF_BASE=3D=
&quot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_BASE=3D&q=
uot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS} ${SERVER_=
BIND_OPTS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SER=
VER_CONF_BASE_MULTISOCKET=3D&quot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS}=
 ${SERVER_CERT_OPTS}&quot;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-TEST_SERVER_LIST=3D&quot;1 2&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+TEST_SERVER_LIST=3D&quot;1 2 4&quot;<=
/span><br><span> </span><br><span> SERVER_NAME_1=3D&quot;t_server_null_serv=
er-1194_udp&quot;</span><br><span> SERVER_SERVER_1=3D&quot;--server 10.29.4=
1.0 255.255.255.0&quot;</span><br><span>@@ -56,6 +58,12 @@</span><br><span>=
 SERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</span><br><span> SERVER_CONF_2=
=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --=
management 127.0.0.1 ${SERVER_MGMT_PORT_2}&quot;</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_NAME_4=3D&quot;t_serv=
er_null_server-1197_multisocket_ipv4_ipv6&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+SERVER_SERVER_4=3D&quot;--server 10.29.43.0 255=
.255.255.0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SER=
VER_MGMT_PORT_4=3D&quot;11197&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+SERVER_EXEC_4=3D&quot;${SERVER_EXEC}&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_4=3D&quot;${SERVER_CONF_=
BASE_MULTISOCKET} ${SERVER_SERVER_4} --local 127.0.0.1 1197 tcp --local ::1=
 1197 udp --management 127.0.0.1 ${SERVER_MGMT_PORT_4}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Test client co=
nfigurations</span><br><span> CLIENT_EXEC=3D&quot;${top_builddir}/src/openv=
pn/openvpn&quot;</span><br><span> CLIENT_BASE_OPTS=3D&quot;--client --nobin=
d --remote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite -=
-connect-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --scr=
ipt-security 2&quot;</span><br><span>@@ -65,7 +73,7 @@</span><br><span> CLI=
ENT_CIPHER_OPTS=3D&quot;&quot;</span><br><span> CLIENT_CERT_OPTS=3D&quot;--=
ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-TES=
T_RUN_LIST=3D&quot;1 1L 2 2L 3&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1 1L 2 2L 3 5a 5b 5c&quot;</span><br=
><span> CLIENT_CONF_BASE=3D&quot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${=
CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> CLIENT_CONF_=
BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_O=
PTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span>@@ -93,3 +=
101,18 @@</span><br><span> SHOULD_PASS_3=3D&quot;no&quot;</span><br><span> =
CLIENT_EXEC_3=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF_3=
=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto udp&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_5a=3D&quot;t_server_null_cli=
ent.sh-openvpn_current_multisocket_ipv4_tcp&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+SHOULD_PASS_5a=3D&quot;yes&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_5a=3D&quot;${CLIENT_=
EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_C=
ONF_5a=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+TEST_NAME_5b=3D&quot;t_server_null_client.sh-=
openvpn_current_multisocket_ipv6_udp&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+SHOULD_PASS_5b=3D&quot;yes&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_5b=3D&quot;${CLIENT_EXEC}&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_5b=
=3D&quot;${CLIENT_CONF_BASE} --remote ::1 1197 udp&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+TEST_NAME_5c=3D&quot;t_server_null_client.sh-openvpn_curr=
ent_multisocket_ipv6_tcp_fail&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+SHOULD_PASS_5c=3D&quot;no&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+CLIENT_EXEC_5c=3D&quot;${CLIENT_EXEC}&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_5c=3D&quot;=
${CLIENT_CONF_BASE} --remote ::1 1197 tcp&quot;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/91=
9?usp=3Demail">change 919</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebe1158c36a641888131e824f5=
9004a0f8fb4c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--hnseTag8yiI=--

