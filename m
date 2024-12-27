From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 12:44:25 +0000
References: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c4a63861308d30a80971a6d80ae168cafa3806c8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y/aqWWsKPgo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 t_server_null_default.rc: Add some tests with --data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--y/aqWWsKPgo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail

to review the following change.


Change subject: t_server_null_default.rc: Add some tests with --data-ciphers
......................................................................

t_server_null_default.rc: Add some tests with --data-ciphers

Trying to verify some of the negotiation parts.

Change-Id: I47d95eee8a00b9878331fd6cd6a7db12665f5537
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/t_server_null_default.rc
1 file changed, 30 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/847/1

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index cbf4877..c05f7eb 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -1,3 +1,4 @@
+# -*- shell-script -*-
 # Notes regarding --dev null server and client configurations:
 #
 # The t_server_null_server.sh exits when all client pid files have gone
@@ -33,7 +34,7 @@
 SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"

-TEST_SERVER_LIST=3D"1 2"
+TEST_SERVER_LIST=3D"1 2 3"

 SERVER_NAME_1=3D"t_server_null_server-1194_udp"
 SERVER_SERVER_1=3D"--server 10.29.41.0 255.255.255.0"
@@ -47,13 +48,19 @@
 SERVER_EXEC_2=3D"${SERVER_EXEC}"
 SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"

+SERVER_NAME_3=3D"t_server_null_server-1196_udp"
+SERVER_SERVER_3=3D"--server 10.29.43.0 255.255.255.0"
+SERVER_MGMT_PORT_3=3D"11196"
+SERVER_EXEC_3=3D"${SERVER_EXEC}"
+SERVER_CONF_3=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --=
data-ciphers DEFAULT:AES-192-CBC"
+
 # Test client configurations
 CLIENT_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
 CLIENT_BASE_OPTS=3D"--client --dev null --ifconfig-noexec --nobind --remot=
e-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connect-=
retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-secur=
ity 2 --up ${srcdir}/null_client_up.sh"
 CLIENT_CIPHER_OPTS=3D""
 CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"

-TEST_RUN_LIST=3D"1 2 3"
+TEST_RUN_LIST=3D"1 2 3 4a 4b 4c"
 CLIENT_CONF_BASE=3D"${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CER=
T_OPTS}"

 TEST_NAME_1=3D"t_server_null_client.sh-openvpn_current_udp"
@@ -70,3 +77,24 @@
 SHOULD_PASS_3=3D"no"
 CLIENT_EXEC_3=3D"${CLIENT_EXEC}"
 CLIENT_CONF_3=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto =
udp"
+
+# --data-cipher list against server with defaults
+# --cipher ignored
+TEST_NAME_4a=3D"t_server_null_client.sh-openvpn_current_udp_dc1"
+SHOULD_PASS_4a=3D"yes"
+CLIENT_EXEC_4a=3D"${CLIENT_EXEC}"
+CLIENT_CONF_4a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto =
udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT"
+
+# specific --data-cipher against server that supports that cipher
+# --cipher ignored
+TEST_NAME_4b=3D"t_server_null_client.sh-openvpn_current_udp_dc3"
+SHOULD_PASS_4b=3D"yes"
+CLIENT_EXEC_4b=3D"${CLIENT_EXEC}"
+CLIENT_CONF_4b=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-128-CBC --data-ciphers AES-192-CBC"
+
+# specific --data-cipher against server that doesn't support that cipher
+# --cipher ignored
+TEST_NAME_4c=3D"t_server_null_client.sh-openvpn_current_udp_dc3_fail"
+SHOULD_PASS_4c=3D"no"
+CLIENT_EXEC_4c=3D"${CLIENT_EXEC}"
+CLIENT_CONF_4c=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47d95eee8a00b9878331fd6cd6a7db12665f5537
Gerrit-Change-Number: 847
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--y/aqWWsKPgo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null_default.rc: Add some tests with --data-ciphers<=
br><br>Trying to verify some of the negotiation parts.<br><br>Change-Id: I4=
7d95eee8a00b9878331fd6cd6a7db12665f5537<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M tests/t_server_null_default.rc<br>1 f=
ile changed, 30 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/47/847/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tes=
ts/t_server_null_default.rc b/tests/t_server_null_default.rc</span><br><spa=
n>index cbf4877..c05f7eb 100755</span><br><span>--- a/tests/t_server_null_d=
efault.rc</span><br><span>+++ b/tests/t_server_null_default.rc</span><br><s=
pan>@@ -1,3 +1,4 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# -*- shell-script -*-</span><br><span> # Notes regarding --dev null server=
 and client configurations:</span><br><span> #</span><br><span> # The t_ser=
ver_null_server.sh exits when all client pid files have gone</span><br><spa=
n>@@ -33,7 +34,7 @@</span><br><span> SERVER_CERT_OPTS=3D&quot;--ca ${CA} --=
dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;=
</span><br><span> SERVER_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} ${SERVER_CIP=
HER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-TEST_SERVER_LIST=3D&quot;1 2&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+TEST_SERVER_LIST=3D&quot;1 2=
 3&quot;</span><br><span> </span><br><span> SERVER_NAME_1=3D&quot;t_server_=
null_server-1194_udp&quot;</span><br><span> SERVER_SERVER_1=3D&quot;--serve=
r 10.29.41.0 255.255.255.0&quot;</span><br><span>@@ -47,13 +48,19 @@</span>=
<br><span> SERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</span><br><span> SERV=
ER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}&quot;</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_NAME_3=3D&qu=
ot;t_server_null_server-1196_udp&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+SERVER_SERVER_3=3D&quot;--server 10.29.43.0 255.255.255.=
0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_MGMT_=
PORT_3=3D&quot;11196&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+SERVER_EXEC_3=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+SERVER_CONF_3=3D&quot;${SERVER_CONF_BASE} ${S=
ERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MG=
MT_PORT_3} --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Te=
st client configurations</span><br><span> CLIENT_EXEC=3D&quot;${top_builddi=
r}/src/openvpn/openvpn&quot;</span><br><span> CLIENT_BASE_OPTS=3D&quot;--cl=
ient --dev null --ifconfig-noexec --nobind --remote-cert-tls server --persi=
st-tun --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll=
-timeout 5 --explicit-exit-notify 3 --script-security 2 --up ${srcdir}/null=
_client_up.sh&quot;</span><br><span> CLIENT_CIPHER_OPTS=3D&quot;&quot;</spa=
n><br><span> CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --cert ${CLIENT_CERT} --ke=
y ${CLIENT_KEY} --tls-auth ${TA} 1&quot;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-TEST_RUN_LIST=3D&quot;1 2 3&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1 =
2 3 4a 4b 4c&quot;</span><br><span> CLIENT_CONF_BASE=3D&quot;${CLIENT_BASE_=
OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </sp=
an><br><span> TEST_NAME_1=3D&quot;t_server_null_client.sh-openvpn_current_u=
dp&quot;</span><br><span>@@ -70,3 +77,24 @@</span><br><span> SHOULD_PASS_3=
=3D&quot;no&quot;</span><br><span> CLIENT_EXEC_3=3D&quot;${CLIENT_EXEC}&quo=
t;</span><br><span> CLIENT_CONF_3=3D&quot;${CLIENT_CONF_BASE} --remote 127.=
0.0.1 11194 udp --proto udp&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --d=
ata-cipher list against server with defaults</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# --cipher ignored</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+TEST_NAME_4a=3D&quot;t_server_null_client.sh-openvp=
n_current_udp_dc1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+SHOULD_PASS_4a=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+CLIENT_EXEC_4a=3D&quot;${CLIENT_EXEC}&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_4a=3D&quot;${CLIENT_CO=
NF_BASE} --remote 127.0.0.1 1194 udp --proto udp --cipher AES-128-CBC --dat=
a-ciphers AES-192-CBC:DEFAULT&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# s=
pecific --data-cipher against server that supports that cipher</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# --cipher ignored</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4b=3D&quot;t_server_nul=
l_client.sh-openvpn_current_udp_dc3&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+SHOULD_PASS_4b=3D&quot;yes&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_4b=3D&quot;${CLIENT_EXEC}&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_4b=
=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --ciph=
er AES-128-CBC --data-ciphers AES-192-CBC&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# specific --data-cipher against server that doesn&#39;t support t=
hat cipher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --ciphe=
r ignored</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_=
4c=3D&quot;t_server_null_client.sh-openvpn_current_udp_dc3_fail&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_4c=3D&quot;no=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_4=
c=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+CLIENT_CONF_4c=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 11=
96 udp --proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC&quot;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/847?usp=3Demail">change 847</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/847?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47d95eee8a00b9878331fd6cd6a=
7db12665f5537 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 847 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--y/aqWWsKPgo=--

