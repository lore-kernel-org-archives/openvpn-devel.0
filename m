From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 15:55:55 +0000
In-Reply-To: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
References: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <d520e2188e68eda86cf550630e8eda3b86ee54a4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HBhvEiGpdHg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, mattock <sasepp@...2783...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HBhvEiGpdHg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by mattock


Change subject: t_server_null_default.rc: Add some tests with --data-ciphers
......................................................................

t_server_null_default.rc: Add some tests with --data-ciphers

Trying to verify some of the negotiation parts.

Change-Id: I47d95eee8a00b9878331fd6cd6a7db12665f5537
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Samuli Sepp=C3=A4nen <sasepp@...2783...>
Message-Id: <20250327094700.305156-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
258.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null_default.rc
1 file changed, 30 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/847/3

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index e7bf5bc..ca8004a 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -1,3 +1,4 @@
+# -*- shell-script -*-
 # Notes regarding --dev null server and client configurations:
 #
 # The t_server_null_server.sh exits when all client pid files have gone
@@ -42,7 +43,7 @@
 SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"

-TEST_SERVER_LIST=3D"1 2"
+TEST_SERVER_LIST=3D"1 2 3"

 SERVER_NAME_1=3D"t_server_null_server-1194_udp"
 SERVER_SERVER_1=3D"--server 10.29.41.0 255.255.255.0"
@@ -56,6 +57,12 @@
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
 CLIENT_BASE_OPTS=3D"--client --nobind --remote-cert-tls server --persist-t=
un --verb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-tim=
eout 5 --explicit-exit-notify 3 --script-security 2"
@@ -65,7 +72,7 @@
 CLIENT_CIPHER_OPTS=3D""
 CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"

-TEST_RUN_LIST=3D"1 1L 2 2L 3"
+TEST_RUN_LIST=3D"1 1L 2 2L 3 4a 4b 4c"
 CLIENT_CONF_BASE=3D"${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHE=
R_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP=3D"${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}"

@@ -93,3 +100,24 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mattock <sasepp@...2783...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--HBhvEiGpdHg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/847?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by mattock</p><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">t_server_null_default.rc: Add some tests with --da=
ta-ciphers<br><br>Trying to verify some of the negotiation parts.<br><br>Ch=
ange-Id: I47d95eee8a00b9878331fd6cd6a7db12665f5537<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Samuli Sepp=C3=A4nen &lt;=
sasepp@...2783...&gt;<br>Message-Id: &lt;20250327094700.305156-1-frank@...1665...=
641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg31258.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M tests/t_server_null_default.rc<br>1 file changed, 30 inserti=
ons(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/47/847/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/tests/t_server_null_defaul=
t.rc b/tests/t_server_null_default.rc</span><br><span>index e7bf5bc..ca8004=
a 100755</span><br><span>--- a/tests/t_server_null_default.rc</span><br><sp=
an>+++ b/tests/t_server_null_default.rc</span><br><span>@@ -1,3 +1,4 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# -*- shell-script -*-<=
/span><br><span> # Notes regarding --dev null server and client configurati=
ons:</span><br><span> #</span><br><span> # The t_server_null_server.sh exit=
s when all client pid files have gone</span><br><span>@@ -42,7 +43,7 @@</sp=
an><br><span> SERVER_CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${SERVE=
R_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span> SERVE=
R_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT=
_OPTS}&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-TEST_SERVER_LIST=3D&quot;1 2&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+TEST_SERVER_LIST=3D&quot;1 2 3&quot;</span><br><spa=
n> </span><br><span> SERVER_NAME_1=3D&quot;t_server_null_server-1194_udp&qu=
ot;</span><br><span> SERVER_SERVER_1=3D&quot;--server 10.29.41.0 255.255.25=
5.0&quot;</span><br><span>@@ -56,6 +57,12 @@</span><br><span> SERVER_EXEC_2=
=3D&quot;${SERVER_EXEC}&quot;</span><br><span> SERVER_CONF_2=3D&quot;${SERV=
ER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.=
0.0.1 ${SERVER_MGMT_PORT_2}&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SERVER_NAME_3=3D&quot;t_server_null_serve=
r-1196_udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SER=
VER_SERVER_3=3D&quot;--server 10.29.43.0 255.255.255.0&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+SERVER_MGMT_PORT_3=3D&quot;11196&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_EXEC_3=
=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+SERVER_CONF_3=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lp=
ort 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher =
AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Test client configura=
tions</span><br><span> CLIENT_EXEC=3D&quot;${top_builddir}/src/openvpn/open=
vpn&quot;</span><br><span> CLIENT_BASE_OPTS=3D&quot;--client --nobind --rem=
ote-cert-tls server --persist-tun --verb 3 --resolv-retry infinite --connec=
t-retry-max 3 --server-poll-timeout 5 --explicit-exit-notify 3 --script-sec=
urity 2&quot;</span><br><span>@@ -65,7 +72,7 @@</span><br><span> CLIENT_CIP=
HER_OPTS=3D&quot;&quot;</span><br><span> CLIENT_CERT_OPTS=3D&quot;--ca ${CA=
} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1&quot;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_RUN_L=
IST=3D&quot;1 1L 2 2L 3&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+TEST_RUN_LIST=3D&quot;1 1L 2 2L 3 4a 4b 4c&quot;</span><br><span>=
 CLIENT_CONF_BASE=3D&quot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> CLIENT_CONF_BASE_LW=
IP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${=
CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span>@@ -93,3 +100,24 =
@@</span><br><span> SHOULD_PASS_3=3D&quot;no&quot;</span><br><span> CLIENT_=
EXEC_3=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF_3=3D&quot;=
${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto udp&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# --data-cipher list against server with defaul=
ts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --cipher ignore=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4a=3D&qu=
ot;t_server_null_client.sh-openvpn_current_udp_dc1&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_4a=3D&quot;yes&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_4a=3D&quot;${=
CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+C=
LIENT_CONF_4a=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --pro=
to udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# specific --data-cipher against server that =
supports that cipher</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# --cipher ignored</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
TEST_NAME_4b=3D&quot;t_server_null_client.sh-openvpn_current_udp_dc3&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_4b=3D&qu=
ot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_=
EXEC_4b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+CLIENT_CONF_4b=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.=
0.1 1196 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# specific --data-cipher against se=
rver that doesn&#39;t support that cipher</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# --cipher ignored</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+TEST_NAME_4c=3D&quot;t_server_null_client.sh-openvpn_c=
urrent_udp_dc3_fail&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+SHOULD_PASS_4c=3D&quot;no&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+CLIENT_EXEC_4c=3D&quot;${CLIENT_EXEC}&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_4c=3D&quot;${CLIENT_C=
ONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-192-CBC --da=
ta-ciphers AES-128-CBC&quot;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail">chan=
ge 847</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47d95eee8a00b9878331fd6cd6a=
7db12665f5537 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 847 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mattock &lt;sasepp@...2783...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--HBhvEiGpdHg=--

