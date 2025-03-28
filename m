From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 28 Mar 2025 07:38:18 +0000
In-Reply-To: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
References: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9b130e478dcb046418174f91d198f3aa305300e6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LG7M5iGwQWo="; charset=UTF-8
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

--LG7M5iGwQWo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail

to look at the new patch set (#3).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/919/3

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index ca8004a..5b74761 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -38,12 +38,14 @@
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

-TEST_SERVER_LIST=3D"1 2 3"
+TEST_SERVER_LIST=3D"1 2 3 4"

 SERVER_NAME_1=3D"t_server_null_server-1194_udp"
 SERVER_SERVER_1=3D"--server 10.29.41.0 255.255.255.0"
@@ -63,6 +65,12 @@
 SERVER_EXEC_3=3D"${SERVER_EXEC}"
 SERVER_CONF_3=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --=
data-ciphers DEFAULT:AES-192-CBC"

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
@@ -72,7 +80,7 @@
 CLIENT_CIPHER_OPTS=3D""
 CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"

-TEST_RUN_LIST=3D"1 1L 2 2L 3 4a 4b 4c"
+TEST_RUN_LIST=3D"1 1L 2 2L 3 4a 4b 4c 5a 5b 5c"
 CLIENT_CONF_BASE=3D"${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHE=
R_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP=3D"${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}"

@@ -121,3 +129,18 @@
 SHOULD_PASS_4c=3D"no"
 CLIENT_EXEC_4c=3D"${CLIENT_EXEC}"
 CLIENT_CONF_4c=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"
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
Gerrit-PatchSet: 3
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--LG7M5iGwQWo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock <strong>uploaded patch set #3</strong> to this change.</p><p><a =
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
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/919/3</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_defau=
lt.rc</span><br><span>index ca8004a..5b74761 100755</span><br><span>--- a/t=
ests/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_def=
ault.rc</span><br><span>@@ -38,12 +38,14 @@</span><br><span> MAX_CLIENTS=3D=
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
: hsl(0, 100%, 40%);">-TEST_SERVER_LIST=3D&quot;1 2 3&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+TEST_SERVER_LIST=3D&quot;1 2 3 4&qu=
ot;</span><br><span> </span><br><span> SERVER_NAME_1=3D&quot;t_server_null_=
server-1194_udp&quot;</span><br><span> SERVER_SERVER_1=3D&quot;--server 10.=
29.41.0 255.255.255.0&quot;</span><br><span>@@ -63,6 +65,12 @@</span><br><s=
pan> SERVER_EXEC_3=3D&quot;${SERVER_EXEC}&quot;</span><br><span> SERVER_CON=
F_3=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp=
 --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --data-c=
iphers DEFAULT:AES-192-CBC&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+SERVER_NAME_4=3D&quot;t_server_null_server-1=
197_multisocket_ipv4_ipv6&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+SERVER_SERVER_4=3D&quot;--server 10.29.43.0 255.255.255.0&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_MGMT_PORT_4=
=3D&quot;11197&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+SERVER_EXEC_4=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+SERVER_CONF_4=3D&quot;${SERVER_CONF_BASE_MULTISOCKE=
T} ${SERVER_SERVER_4} --local 127.0.0.1 1197 tcp --local ::1 1197 udp --man=
agement 127.0.0.1 ${SERVER_MGMT_PORT_4}&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> # Test client configurations</s=
pan><br><span> CLIENT_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot=
;</span><br><span> CLIENT_BASE_OPTS=3D&quot;--client --nobind --remote-cert=
-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-retry-=
max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-security 2&=
quot;</span><br><span>@@ -72,7 +80,7 @@</span><br><span> CLIENT_CIPHER_OPTS=
=3D&quot;&quot;</span><br><span> CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --cert=
 ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1&quot;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_RUN_LIST=3D&q=
uot;1 1L 2 2L 3 4a 4b 4c&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+TEST_RUN_LIST=3D&quot;1 1L 2 2L 3 4a 4b 4c 5a 5b 5c&quot;</span>=
<br><span> CLIENT_CONF_BASE=3D&quot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS}=
 ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> CLIENT_CO=
NF_BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHE=
R_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span>@@ -121=
,3 +129,18 @@</span><br><span> SHOULD_PASS_4c=3D&quot;no&quot;</span><br><s=
pan> CLIENT_EXEC_4c=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CO=
NF_4c=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp -=
-cipher AES-192-CBC --data-ciphers AES-128-CBC&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+TEST_NAME_5a=3D&quot;t_server_null_client.sh-openvpn_current=
_multisocket_ipv4_tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+SHOULD_PASS_5a=3D&quot;yes&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+CLIENT_EXEC_5a=3D&quot;${CLIENT_EXEC}&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_5a=3D&quot;${CLIEN=
T_CONF_BASE} --remote 127.0.0.1 1197 tcp&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+TEST_NAME_5b=3D&quot;t_server_null_client.sh-openvpn_current_multis=
ocket_ipv6_udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+SHOULD_PASS_5b=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+CLIENT_EXEC_5b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_5b=3D&quot;${CLIENT_CONF_=
BASE} --remote ::1 1197 udp&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_=
NAME_5c=3D&quot;t_server_null_client.sh-openvpn_current_multisocket_ipv6_tc=
p_fail&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_=
PASS_5c=3D&quot;no&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+CLIENT_EXEC_5c=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+CLIENT_CONF_5c=3D&quot;${CLIENT_CONF_BASE} --r=
emote ::1 1197 tcp&quot;</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail">change 9=
19</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebe1158c36a641888131e824f5=
9004a0f8fb4c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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


--LG7M5iGwQWo=--

