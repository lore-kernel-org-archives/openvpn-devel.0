From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 8 Jul 2025 07:54:56 +0000
In-Reply-To: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
References: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <ea29da2f282308ef2f214b13b5a3818e533b4bd3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bPeLWhNXtHg="; charset=UTF-8
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
To: mattock <sasepp@...2783...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bPeLWhNXtHg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/91=
9?usp=3Demail )

Change subject: t_server_null: add multi-socket testing
......................................................................

t_server_null: add multi-socket testing

This adds a new multi-socket server that listens on IPv4 and IPv6
localhost addresses for TCP and UDP connections respectively. It also
adds two success tests and one failure test with wrong protocol defined
at the client side.

Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5
Signed-off-by: Samuli Sepp=C3=A4nen <sasepp@...2705...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250708073359.32549-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
061.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null_default.rc
1 file changed, 27 insertions(+), 4 deletions(-)




diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 41ec591..a1c68cd 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -38,12 +38,14 @@
 MAX_CLIENTS=3D"10"
 CLIENT_MATCH=3D"Test-Client"
 SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS=3D"--local 127.0.0.1 --dev tun --topology subnet --max-cl=
ients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BASE_OPTS=3D"--dev tun --topology subnet --max-clients $MAX_CLIENTS=
 --persist-tun --verb 3 --duplicate-cn"
+SERVER_BIND_OPTS=3D"--local 127.0.0.1"
 SERVER_CIPHER_OPTS=3D""
 SERVER_CERT_OPTS=3D"--ca ${CA} --cert ${SERVER_CERT} --key ${SERVER_KEY} -=
-tls-auth ${TA} 0"
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
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --dh none --cipher AES-=
192-CBC --data-ciphers DEFAULT:AES-192-CBC"

+SERVER_NAME_4=3D"t_server_null_server-1197_multisocket_ipv4_ipv6"
+SERVER_SERVER_4=3D"--server 10.29.44.0 255.255.255.0"
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
Gerrit-PatchSet: 7
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--bPeLWhNXtHg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/919?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">t_server_null: add multi-socket testing<br><br=
>This adds a new multi-socket server that listens on IPv4 and IPv6<br>local=
host addresses for TCP and UDP connections respectively. It also<br>adds tw=
o success tests and one failure test with wrong protocol defined<br>at the =
client side.<br><br>Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5<br=
>Signed-off-by: Samuli Sepp=C3=A4nen &lt;sasepp@...2705...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250708073359.325=
49-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg32061.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M tests/t_server_null_default.rc<br>1 file chang=
ed, 27 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_defaul=
t.rc</span><br><span>index 41ec591..a1c68cd 100755</span><br><span>--- a/te=
sts/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_defa=
ult.rc</span><br><span>@@ -38,12 +38,14 @@</span><br><span> MAX_CLIENTS=3D&=
quot;10&quot;</span><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot;</span=
><br><span> SERVER_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&quo=
t;--local 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS =
--persist-tun --verb 3 --duplicate-cn&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+SERVER_BASE_OPTS=3D&quot;--dev tun --topology subne=
t --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_BIND_OPTS=3D&qu=
ot;--local 127.0.0.1&quot;</span><br><span> SERVER_CIPHER_OPTS=3D&quot;&quo=
t;</span><br><span> SERVER_CERT_OPTS=3D&quot;--ca ${CA} --cert ${SERVER_CER=
T} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-SERVER_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} ${SE=
RVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+SERVER_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} ${SERV=
ER_CIPHER_OPTS} ${SERVER_CERT_OPTS} ${SERVER_BIND_OPTS}&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_BASE_MULTISOCKET=3D&q=
uot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_SE=
RVER_LIST=3D&quot;1 2 3&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+TEST_SERVER_LIST=3D&quot;1 2 3 4&quot;</span><br><span> </span><b=
r><span> SERVER_NAME_1=3D&quot;t_server_null_server-1194_udp&quot;</span><b=
r><span> SERVER_SERVER_1=3D&quot;--server 10.29.41.0 255.255.255.0&quot;</s=
pan><br><span>@@ -63,6 +65,12 @@</span><br><span> SERVER_EXEC_3=3D&quot;${S=
ERVER_EXEC}&quot;</span><br><span> SERVER_CONF_3=3D&quot;${SERVER_CONF_BASE=
} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERV=
ER_MGMT_PORT_3} --dh none --cipher AES-192-CBC --data-ciphers DEFAULT:AES-1=
92-CBC&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+SERVER_NAME_4=3D&quot;t_server_null_server-1197_multisocket_ipv4=
_ipv6&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_S=
ERVER_4=3D&quot;--server 10.29.44.0 255.255.255.0&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+SERVER_MGMT_PORT_4=3D&quot;11197&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_EXEC_4=3D&quo=
t;${SERVER_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+SERVER_CONF_4=3D&quot;${SERVER_CONF_BASE_MULTISOCKET} ${SERVER_SERVER_4}=
 --local 127.0.0.1 1197 tcp --local ::1 1197 udp --management 127.0.0.1 ${S=
ERVER_MGMT_PORT_4}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> # Test client configurations</span><br><span> CLIENT=
_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span> CL=
IENT_BASE_OPTS=3D&quot;--client --nobind --remote-cert-tls server --persist=
-tun --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-t=
imeout 5 --explicit-exit-notify 3 --script-security 2&quot;</span><br><span=
>@@ -72,7 +80,7 @@</span><br><span> CLIENT_CIPHER_OPTS=3D&quot;&quot;</span=
><br><span> CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --cert ${CLIENT_CERT} --key=
 ${CLIENT_KEY} --tls-auth ${TA} 1&quot;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-TEST_RUN_LIST=3D&quot;1 1L 2 2L 3 4a 4b=
 4c&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_RUN_L=
IST=3D&quot;1 1L 2 2L 3 4a 4b 4c 5a 5b 5c&quot;</span><br><span> CLIENT_CON=
F_BASE=3D&quot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS=
} ${CLIENT_CERT_OPTS}&quot;</span><br><span> CLIENT_CONF_BASE_LWIP=3D&quot;=
${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT=
_OPTS}&quot;</span><br><span> </span><br><span>@@ -121,3 +129,18 @@</span><=
br><span> SHOULD_PASS_4c=3D&quot;no&quot;</span><br><span> CLIENT_EXEC_4c=
=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF_4c=3D&quot;${CLI=
ENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-192-CBC=
 --data-ciphers AES-128-CBC&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_=
NAME_5a=3D&quot;t_server_null_client.sh-openvpn_current_multisocket_ipv4_tc=
p&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_=
5a=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+CLIENT_EXEC_5a=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+CLIENT_CONF_5a=3D&quot;${CLIENT_CONF_BASE} --remot=
e 127.0.0.1 1197 tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_5b=
=3D&quot;t_server_null_client.sh-openvpn_current_multisocket_ipv6_udp&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_5b=3D&q=
uot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT=
_EXEC_5b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+CLIENT_CONF_5b=3D&quot;${CLIENT_CONF_BASE} --remote ::1 1=
197 udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_5c=3D&quot;t_se=
rver_null_client.sh-openvpn_current_multisocket_ipv6_tcp_fail&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_5c=3D&quot;no&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_5c=
=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CLIENT_CONF_5c=3D&quot;${CLIENT_CONF_BASE} --remote ::1 1197 tcp&=
quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail">change 919</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/919?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebe1158c36a641888131e824f5=
9004a0f8fb4c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--bPeLWhNXtHg=--

