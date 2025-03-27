From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 15:56:00 +0000
In-Reply-To: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
References: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <d520e2188e68eda86cf550630e8eda3b86ee54a4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="08KKMzLNp60="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: mattock <sasepp@...2783...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--08KKMzLNp60=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/84=
7?usp=3Demail )

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
Gerrit-MessageType: merged

--08KKMzLNp60=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/847?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">t_server_null_default.rc: Add some tests with =
--data-ciphers<br><br>Trying to verify some of the negotiation parts.<br><b=
r>Change-Id: I47d95eee8a00b9878331fd6cd6a7db12665f5537<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Samuli Sepp=C3=A4nen =
&lt;sasepp@...2783...&gt;<br>Message-Id: &lt;20250327094700.305156-1-frank@=
...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg31258.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M tests/t_server_null_default.rc<br>1 file changed, 30 ins=
ertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_defaul=
t.rc</span><br><span>index e7bf5bc..ca8004a 100755</span><br><span>--- a/te=
sts/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_defa=
ult.rc</span><br><span>@@ -1,3 +1,4 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# -*- shell-script -*-</span><br><span> # Notes regardin=
g --dev null server and client configurations:</span><br><span> #</span><br=
><span> # The t_server_null_server.sh exits when all client pid files have =
gone</span><br><span>@@ -42,7 +43,7 @@</span><br><span> SERVER_CERT_OPTS=3D=
&quot;--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls=
-auth ${TA} 0&quot;</span><br><span> SERVER_CONF_BASE=3D&quot;${SERVER_BASE=
_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_SERVER_LIST=3D&quot=
;1 2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_SERV=
ER_LIST=3D&quot;1 2 3&quot;</span><br><span> </span><br><span> SERVER_NAME_=
1=3D&quot;t_server_null_server-1194_udp&quot;</span><br><span> SERVER_SERVE=
R_1=3D&quot;--server 10.29.41.0 255.255.255.0&quot;</span><br><span>@@ -56,=
6 +57,12 @@</span><br><span> SERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</sp=
an><br><span> SERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} =
--lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+S=
ERVER_NAME_3=3D&quot;t_server_null_server-1196_udp&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+SERVER_SERVER_3=3D&quot;--server 10.29=
.43.0 255.255.255.0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+SERVER_MGMT_PORT_3=3D&quot;11196&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+SERVER_EXEC_3=3D&quot;${SERVER_EXEC}&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_3=3D&quot;${SER=
VER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127=
.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --data-ciphers DEFAULT:AE=
S-192-CBC&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> # Test client configurations</span><br><span> CLIENT_EXEC=3D&=
quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span> CLIENT_BASE=
_OPTS=3D&quot;--client --nobind --remote-cert-tls server --persist-tun --ve=
rb 3 --resolv-retry infinite --connect-retry-max 3 --server-poll-timeout 5 =
--explicit-exit-notify 3 --script-security 2&quot;</span><br><span>@@ -65,7=
 +72,7 @@</span><br><span> CLIENT_CIPHER_OPTS=3D&quot;&quot;</span><br><spa=
n> CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT=
_KEY} --tls-auth ${TA} 1&quot;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-TEST_RUN_LIST=3D&quot;1 1L 2 2L 3&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1 1L 2=
 2L 3 4a 4b 4c&quot;</span><br><span> CLIENT_CONF_BASE=3D&quot;${CLIENT_NUL=
L_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;=
</span><br><span> CLIENT_CONF_BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIEN=
T_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><spa=
n> </span><br><span>@@ -93,3 +100,24 @@</span><br><span> SHOULD_PASS_3=3D&q=
uot;no&quot;</span><br><span> CLIENT_EXEC_3=3D&quot;${CLIENT_EXEC}&quot;</s=
pan><br><span> CLIENT_CONF_3=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1=
 11194 udp --proto udp&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --data-c=
ipher list against server with defaults</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# --cipher ignored</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+TEST_NAME_4a=3D&quot;t_server_null_client.sh-openvpn_cur=
rent_udp_dc1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+S=
HOULD_PASS_4a=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+CLIENT_EXEC_4a=3D&quot;${CLIENT_EXEC}&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_4a=3D&quot;${CLIENT_CONF_BA=
SE} --remote 127.0.0.1 1194 udp --proto udp --cipher AES-128-CBC --data-cip=
hers AES-192-CBC:DEFAULT&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# specif=
ic --data-cipher against server that supports that cipher</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# --cipher ignored</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4b=3D&quot;t_server_null_cli=
ent.sh-openvpn_current_udp_dc3&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+SHOULD_PASS_4b=3D&quot;yes&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+CLIENT_EXEC_4b=3D&quot;${CLIENT_EXEC}&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_4b=3D&quo=
t;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-=
128-CBC --data-ciphers AES-192-CBC&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# specific --data-cipher against server that doesn&#39;t support that cip=
her</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --cipher ignor=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4c=3D&q=
uot;t_server_null_client.sh-openvpn_current_udp_dc3_fail&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_4c=3D&quot;no&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_4c=3D&qu=
ot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+CLIENT_CONF_4c=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp =
--proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC&quot;</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/847?usp=3Demail">change 847</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
47?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--08KKMzLNp60=--

