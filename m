From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 21:02:47 +0000
In-Reply-To: <gerrit.1752565606000.I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75@...2715...>
References: <gerrit.1752565606000.I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <88afeed904750262e9a25f160be201526df28c6c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k22Z2v+3twk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_server_null: match
 test numbers with server numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <sasepp@...2783...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--k22Z2v+3twk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
86?usp=3Demail )

Change subject: t_server_null: match test numbers with server numbers
......................................................................

t_server_null: match test numbers with server numbers

This makes it obvious which server each test connects to

Change-Id: I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75
Signed-off-by: Samuli Sepp=C3=A4nen <sasepp@...2705...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250716165656.18887-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
194.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null_default.rc
1 file changed, 42 insertions(+), 42 deletions(-)




diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index a1c68cd..900f189 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -80,67 +80,67 @@
 CLIENT_CIPHER_OPTS=3D""
 CLIENT_CERT_OPTS=3D"--ca ${CA} --cert ${CLIENT_CERT} --key ${CLIENT_KEY} -=
-tls-auth ${TA} 1"

-TEST_RUN_LIST=3D"1 1L 2 2L 3 4a 4b 4c 5a 5b 5c"
+TEST_RUN_LIST=3D"1a 1b 1c 1L 2a 2L 3a 3b 4a 4b 4c"
 CLIENT_CONF_BASE=3D"${CLIENT_NULL_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_CIPHE=
R_OPTS} ${CLIENT_CERT_OPTS}"
 CLIENT_CONF_BASE_LWIP=3D"${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}"

-TEST_NAME_1=3D"t_server_null_client.sh-openvpn_current_udp"
-SHOULD_PASS_1=3D"yes"
-CLIENT_EXEC_1=3D"${CLIENT_EXEC}"
-CLIENT_CONF_1=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto u=
dp"
+TEST_NAME_1a=3D"t_server_null_client.sh-openvpn_current_udp"
+SHOULD_PASS_1a=3D"yes"
+CLIENT_EXEC_1a=3D"${CLIENT_EXEC}"
+CLIENT_CONF_1a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto =
udp"
+
+TEST_NAME_1b=3D"t_server_null_client.sh-openvpn_current_udp_fail"
+SHOULD_PASS_1b=3D"no"
+CLIENT_EXEC_1b=3D"${CLIENT_EXEC}"
+CLIENT_CONF_1b=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto=
 udp"
+
+# --data-cipher list against server with defaults
+# --cipher ignored
+TEST_NAME_1c=3D"t_server_null_client.sh-openvpn_current_udp_dc1"
+SHOULD_PASS_1c=3D"yes"
+CLIENT_EXEC_1c=3D"${CLIENT_EXEC}"
+CLIENT_CONF_1c=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto =
udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT"

 TEST_NAME_1L=3D"t_server_null_client.sh-openvpn_current_udp_lwip"
 SHOULD_PASS_1L=3D"yes"
 CLIENT_EXEC_1L=3D"${CLIENT_EXEC}"
 CLIENT_CONF_1L=3D"${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --p=
roto udp"

-TEST_NAME_2=3D"t_server_null_client.sh-openvpn_current_tcp"
-SHOULD_PASS_2=3D"yes"
-CLIENT_EXEC_2=3D"${CLIENT_EXEC}"
-CLIENT_CONF_2=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto t=
cp"
+TEST_NAME_2a=3D"t_server_null_client.sh-openvpn_current_tcp"
+SHOULD_PASS_2a=3D"yes"
+CLIENT_EXEC_2a=3D"${CLIENT_EXEC}"
+CLIENT_CONF_2a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1195 tcp --proto =
tcp"

 TEST_NAME_2L=3D"t_server_null_client.sh-openvpn_current_tcp_lwip"
 SHOULD_PASS_2L=3D"yes"
 CLIENT_EXEC_2L=3D"${CLIENT_EXEC}"
 CLIENT_CONF_2L=3D"${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1195 tcp --p=
roto tcp"

-TEST_NAME_3=3D"t_server_null_client.sh-openvpn_current_udp_fail"
-SHOULD_PASS_3=3D"no"
-CLIENT_EXEC_3=3D"${CLIENT_EXEC}"
-CLIENT_CONF_3=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto =
udp"
-
-# --data-cipher list against server with defaults
-# --cipher ignored
-TEST_NAME_4a=3D"t_server_null_client.sh-openvpn_current_udp_dc1"
-SHOULD_PASS_4a=3D"yes"
-CLIENT_EXEC_4a=3D"${CLIENT_EXEC}"
-CLIENT_CONF_4a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto =
udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT"
-
 # specific --data-cipher against server that supports that cipher
 # --cipher ignored
-TEST_NAME_4b=3D"t_server_null_client.sh-openvpn_current_udp_dc3"
-SHOULD_PASS_4b=3D"yes"
-CLIENT_EXEC_4b=3D"${CLIENT_EXEC}"
-CLIENT_CONF_4b=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-128-CBC --data-ciphers AES-192-CBC"
+TEST_NAME_3a=3D"t_server_null_client.sh-openvpn_current_udp_dc3"
+SHOULD_PASS_3a=3D"yes"
+CLIENT_EXEC_3a=3D"${CLIENT_EXEC}"
+CLIENT_CONF_3a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-128-CBC --data-ciphers AES-192-CBC"

 # specific --data-cipher against server that doesn't support that cipher
 # --cipher ignored
-TEST_NAME_4c=3D"t_server_null_client.sh-openvpn_current_udp_dc3_fail"
+TEST_NAME_3b=3D"t_server_null_client.sh-openvpn_current_udp_dc3_fail"
+SHOULD_PASS_3b=3D"no"
+CLIENT_EXEC_3b=3D"${CLIENT_EXEC}"
+CLIENT_CONF_3b=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"
+
+TEST_NAME_4a=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv4_t=
cp"
+SHOULD_PASS_4a=3D"yes"
+CLIENT_EXEC_4a=3D"${CLIENT_EXEC}"
+CLIENT_CONF_4a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp"
+
+TEST_NAME_4b=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv6_u=
dp"
+SHOULD_PASS_4b=3D"yes"
+CLIENT_EXEC_4b=3D"${CLIENT_EXEC}"
+CLIENT_CONF_4b=3D"${CLIENT_CONF_BASE} --remote ::1 1197 udp"
+
+TEST_NAME_4c=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv6_t=
cp_fail"
 SHOULD_PASS_4c=3D"no"
 CLIENT_EXEC_4c=3D"${CLIENT_EXEC}"
-CLIENT_CONF_4c=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"
-
-TEST_NAME_5a=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv4_t=
cp"
-SHOULD_PASS_5a=3D"yes"
-CLIENT_EXEC_5a=3D"${CLIENT_EXEC}"
-CLIENT_CONF_5a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp"
-
-TEST_NAME_5b=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv6_u=
dp"
-SHOULD_PASS_5b=3D"yes"
-CLIENT_EXEC_5b=3D"${CLIENT_EXEC}"
-CLIENT_CONF_5b=3D"${CLIENT_CONF_BASE} --remote ::1 1197 udp"
-
-TEST_NAME_5c=3D"t_server_null_client.sh-openvpn_current_multisocket_ipv6_t=
cp_fail"
-SHOULD_PASS_5c=3D"no"
-CLIENT_EXEC_5c=3D"${CLIENT_EXEC}"
-CLIENT_CONF_5c=3D"${CLIENT_CONF_BASE} --remote ::1 1197 tcp"
+CLIENT_CONF_4c=3D"${CLIENT_CONF_BASE} --remote ::1 1197 tcp"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1086?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75
Gerrit-Change-Number: 1086
Gerrit-PatchSet: 3
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--k22Z2v+3twk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1086?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">t_server_null: match test numbers with server=
 numbers<br><br>This makes it obvious which server each test connects to<br=
><br>Change-Id: I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75<br>Signed-off-by:=
 Samuli Sepp=C3=A4nen &lt;sasepp@...2705...&gt;<br>Acked-by: Gert Doering &=
lt;gert@...1296...&gt;<br>Message-Id: &lt;20250716165656.18887-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg32194.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M tests/t_server_null_default.rc<br>1 file changed, 42 insertio=
ns(+), 42 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_defaul=
t.rc</span><br><span>index a1c68cd..900f189 100755</span><br><span>--- a/te=
sts/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_defa=
ult.rc</span><br><span>@@ -80,67 +80,67 @@</span><br><span> CLIENT_CIPHER_O=
PTS=3D&quot;&quot;</span><br><span> CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --c=
ert ${CLIENT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1&quot;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_RUN_LIST=
=3D&quot;1 1L 2 2L 3 4a 4b 4c 5a 5b 5c&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+TEST_RUN_LIST=3D&quot;1a 1b 1c 1L 2a 2L 3a 3b 4a 4=
b 4c&quot;</span><br><span> CLIENT_CONF_BASE=3D&quot;${CLIENT_NULL_OPTS} ${=
CLIENT_BASE_OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br=
><span> CLIENT_CONF_BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPT=
S} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_NAME_1=3D&quot;t_server=
_null_client.sh-openvpn_current_udp&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-SHOULD_PASS_1=3D&quot;yes&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-CLIENT_EXEC_1=3D&quot;${CLIENT_EXEC}&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_1=3D&quot;=
${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_1a=3D&quot;t_server=
_null_client.sh-openvpn_current_udp&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+SHOULD_PASS_1a=3D&quot;yes&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_1a=3D&quot;${CLIENT_EXEC}&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1a=
=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_1b=3D&quot;t_server_null_clie=
nt.sh-openvpn_current_udp_fail&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+SHOULD_PASS_1b=3D&quot;no&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+CLIENT_EXEC_1b=3D&quot;${CLIENT_EXEC}&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1b=3D&quot=
;${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto udp&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# --data-cipher list against server with defau=
lts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# --cipher ignor=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_1c=3D&q=
uot;t_server_null_client.sh-openvpn_current_udp_dc1&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_1c=3D&quot;yes&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_1c=3D&quot;$=
{CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
CLIENT_CONF_1c=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --pr=
oto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT&quot;</span=
><br><span> </span><br><span> TEST_NAME_1L=3D&quot;t_server_null_client.sh-=
openvpn_current_udp_lwip&quot;</span><br><span> SHOULD_PASS_1L=3D&quot;yes&=
quot;</span><br><span> CLIENT_EXEC_1L=3D&quot;${CLIENT_EXEC}&quot;</span><b=
r><span> CLIENT_CONF_1L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1=
 1194 udp --proto udp&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-TEST_NAME_2=3D&quot;t_server_null_client.sh-openvpn=
_current_tcp&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHO=
ULD_PASS_2=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-CLIENT_EXEC_2=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-CLIENT_CONF_2=3D&quot;${CLIENT_CONF_BASE} --rem=
ote 127.0.0.1 1195 tcp --proto tcp&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+TEST_NAME_2a=3D&quot;t_server_null_client.sh-openvpn_c=
urrent_tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHO=
ULD_PASS_2a=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CLIENT_EXEC_2a=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_2a=3D&quot;${CLIENT_CONF_BASE=
} --remote 127.0.0.1 1195 tcp --proto tcp&quot;</span><br><span> </span><br=
><span> TEST_NAME_2L=3D&quot;t_server_null_client.sh-openvpn_current_tcp_lw=
ip&quot;</span><br><span> SHOULD_PASS_2L=3D&quot;yes&quot;</span><br><span>=
 CLIENT_EXEC_2L=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF_2=
L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1195 tcp --proto tcp&=
quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-TEST_NAME_3=3D&quot;t_server_null_client.sh-openvpn_current_udp_fail&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PASS_3=3D&quo=
t;no&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_EXEC=
_3=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-CLIENT_CONF_3=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1119=
4 udp --proto udp&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# --data-cipher lis=
t against server with defaults</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# --cipher ignored</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-TEST_NAME_4a=3D&quot;t_server_null_client.sh-openvpn_current_udp_dc1&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PASS_4a=
=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLI=
ENT_EXEC_4a=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-CLIENT_CONF_4a=3D&quot;${CLIENT_CONF_BASE} --remote 127.=
0.0.1 1194 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:=
DEFAULT&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> # specific --data-cipher against server that supports that cipher=
</span><br><span> # --cipher ignored</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-TEST_NAME_4b=3D&quot;t_server_null_client.sh-openvpn_current=
_udp_dc3&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_=
PASS_4b=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-CLIENT_EXEC_4b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-CLIENT_CONF_4b=3D&quot;${CLIENT_CONF_BASE} --remo=
te 127.0.0.1 1196 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-1=
92-CBC&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NA=
ME_3a=3D&quot;t_server_null_client.sh-openvpn_current_udp_dc3&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_3a=3D&quot;yes&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_3a=
=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CLIENT_CONF_3a=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 119=
6 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC&quot;</sp=
an><br><span> </span><br><span> # specific --data-cipher against server tha=
t doesn&#39;t support that cipher</span><br><span> # --cipher ignored</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_NAME_4c=3D&quot;t_serv=
er_null_client.sh-openvpn_current_udp_dc3_fail&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_3b=3D&quot;t_server_null_client=
.sh-openvpn_current_udp_dc3_fail&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+SHOULD_PASS_3b=3D&quot;no&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_3b=3D&quot;${CLIENT_EXEC}&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_3b=3D&qu=
ot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES=
-192-CBC --data-ciphers AES-128-CBC&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+TEST_NAME_4a=3D&quot;t_server_null_client.sh-openvpn_current_multisocket=
_ipv4_tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOU=
LD_PASS_4a=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+CLIENT_EXEC_4a=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_4a=3D&quot;${CLIENT_CONF_BASE=
} --remote 127.0.0.1 1197 tcp&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TES=
T_NAME_4b=3D&quot;t_server_null_client.sh-openvpn_current_multisocket_ipv6_=
udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PAS=
S_4b=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+CLIENT_EXEC_4b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+CLIENT_CONF_4b=3D&quot;${CLIENT_CONF_BASE} --rem=
ote ::1 1197 udp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4c=3D&=
quot;t_server_null_client.sh-openvpn_current_multisocket_ipv6_tcp_fail&quot=
;</span><br><span> SHOULD_PASS_4c=3D&quot;no&quot;</span><br><span> CLIENT_=
EXEC_4c=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-CLIENT_CONF_4c=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.=
1 1196 udp --proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-TEST_NAME_5a=3D&quot;t_server_null_client=
.sh-openvpn_current_multisocket_ipv4_tcp&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-SHOULD_PASS_5a=3D&quot;yes&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-CLIENT_EXEC_5a=3D&quot;${CLIENT_EXEC}&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_5a=3D=
&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1197 tcp&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-TEST_NAME_5b=3D&quot;t_server_null_client.sh-openvpn_curre=
nt_multisocket_ipv6_udp&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-SHOULD_PASS_5b=3D&quot;yes&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-CLIENT_EXEC_5b=3D&quot;${CLIENT_EXEC}&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_5b=3D&quot;${CLIENT_CO=
NF_BASE} --remote ::1 1197 udp&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_N=
AME_5c=3D&quot;t_server_null_client.sh-openvpn_current_multisocket_ipv6_tcp=
_fail&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PAS=
S_5c=3D&quot;no&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
CLIENT_EXEC_5c=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-CLIENT_CONF_5c=3D&quot;${CLIENT_CONF_BASE} --remote :=
:1 1197 tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CL=
IENT_CONF_4c=3D&quot;${CLIENT_CONF_BASE} --remote ::1 1197 tcp&quot;</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1086?usp=3Demail">change 1086</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1086?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49c69144ab6dcf1d26c96c2eafc=
2346ad4e0ca75 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1086 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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


--k22Z2v+3twk=--

