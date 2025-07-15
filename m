From: "mattock (Code Review)" <gerrit@...515...>
Date: Tue, 15 Jul 2025 07:46:48 +0000
References: <gerrit.1752565606000.I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <588c7fb3de060aabf72c0409af371caac3ba22dc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WISMVVkvfIA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WISMVVkvfIA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1086?usp=3Demail

to review the following change.


Change subject: t_server_null: match test numbers with server numbers
......................................................................

t_server_null: match test numbers with server numbers

This makes it obvious which server each test connects to

Change-Id: I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75
Signed-off-by: Samuli Sepp=C3=A4nen <sasepp@...2705...>
---
M tests/t_server_null_default.rc
1 file changed, 42 insertions(+), 42 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1086/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--WISMVVkvfIA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1086?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">t_server_null: match test numbers with server numbers<br><br=
>This makes it obvious which server each test connects to<br><br>Change-Id:=
 I49c69144ab6dcf1d26c96c2eafc2346ad4e0ca75<br>Signed-off-by: Samuli Sepp=C3=
=A4nen &lt;sasepp@...2705...&gt;<br>---<br>M tests/t_server_null_default.rc=
<br>1 file changed, 42 insertions(+), 42 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/86/1086/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc</span=
><br><span>index a1c68cd..900f189 100755</span><br><span>--- a/tests/t_serv=
er_null_default.rc</span><br><span>+++ b/tests/t_server_null_default.rc</sp=
an><br><span>@@ -80,67 +80,67 @@</span><br><span> CLIENT_CIPHER_OPTS=3D&quo=
t;&quot;</span><br><span> CLIENT_CERT_OPTS=3D&quot;--ca ${CA} --cert ${CLIE=
NT_CERT} --key ${CLIENT_KEY} --tls-auth ${TA} 1&quot;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_RUN_LIST=3D&quot;1 1=
L 2 2L 3 4a 4b 4c 5a 5b 5c&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+TEST_RUN_LIST=3D&quot;1a 1b 1c 1L 2a 2L 3a 3b 4a 4b 4c&quot;</=
span><br><span> CLIENT_CONF_BASE=3D&quot;${CLIENT_NULL_OPTS} ${CLIENT_BASE_=
OPTS} ${CLIENT_CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> CLIE=
NT_CONF_BASE_LWIP=3D&quot;${CLIENT_LWIP_OPTS} ${CLIENT_BASE_OPTS} ${CLIENT_=
CIPHER_OPTS} ${CLIENT_CERT_OPTS}&quot;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-TEST_NAME_1=3D&quot;t_server_null_client=
.sh-openvpn_current_udp&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-SHOULD_PASS_1=3D&quot;yes&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-CLIENT_EXEC_1=3D&quot;${CLIENT_EXEC}&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_1=3D&quot;${CLIENT_CONF_=
BASE} --remote 127.0.0.1 1194 udp --proto udp&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_1a=3D&quot;t_server_null_client=
.sh-openvpn_current_udp&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+SHOULD_PASS_1a=3D&quot;yes&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+CLIENT_EXEC_1a=3D&quot;${CLIENT_EXEC}&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1a=3D&quot;${CLI=
ENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+TEST_NAME_1b=3D&quot;t_server_null_client.sh-openvpn_=
current_udp_fail&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+SHOULD_PASS_1b=3D&quot;no&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+CLIENT_EXEC_1b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1b=3D&quot;${CLIENT_CONF=
_BASE} --remote 127.0.0.1 11194 udp --proto udp&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# --data-cipher list against server with defaults</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# --cipher ignored</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_1c=3D&quot;t_server_n=
ull_client.sh-openvpn_current_udp_dc1&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+SHOULD_PASS_1c=3D&quot;yes&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_1c=3D&quot;${CLIENT_EXEC}&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_1c=
=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp --ciph=
er AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT&quot;</span><br><span> </=
span><br><span> TEST_NAME_1L=3D&quot;t_server_null_client.sh-openvpn_curren=
t_udp_lwip&quot;</span><br><span> SHOULD_PASS_1L=3D&quot;yes&quot;</span><b=
r><span> CLIENT_EXEC_1L=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIEN=
T_CONF_1L=3D&quot;${CLIENT_CONF_BASE_LWIP} --remote 127.0.0.1 1194 udp --pr=
oto udp&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-TEST_NAME_2=3D&quot;t_server_null_client.sh-openvpn_current_tcp&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PASS_2=3D&=
quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_=
EXEC_2=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-CLIENT_CONF_2=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 =
1195 tcp --proto tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+TEST_NAME_2a=3D&quot;t_server_null_client.sh-openvpn_current_tcp&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_2a=3D=
&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIE=
NT_EXEC_2a=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+CLIENT_CONF_2a=3D&quot;${CLIENT_CONF_BASE} --remote 127=
.0.0.1 1195 tcp --proto tcp&quot;</span><br><span> </span><br><span> TEST_N=
AME_2L=3D&quot;t_server_null_client.sh-openvpn_current_tcp_lwip&quot;</span=
><br><span> SHOULD_PASS_2L=3D&quot;yes&quot;</span><br><span> CLIENT_EXEC_2=
L=3D&quot;${CLIENT_EXEC}&quot;</span><br><span> CLIENT_CONF_2L=3D&quot;${CL=
IENT_CONF_BASE_LWIP} --remote 127.0.0.1 1195 tcp --proto tcp&quot;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_NAME_3=
=3D&quot;t_server_null_client.sh-openvpn_current_udp_fail&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PASS_3=3D&quot;no&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_EXEC_3=3D&quot;${=
CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLI=
ENT_CONF_3=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 11194 udp --proto=
 udp&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# --data-cipher list against ser=
ver with defaults</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# --=
cipher ignored</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_NA=
ME_4a=3D&quot;t_server_null_client.sh-openvpn_current_udp_dc1&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PASS_4a=3D&quot;yes&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_EXEC_4a=3D&=
quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-CLIENT_CONF_4a=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp =
--proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> # spe=
cific --data-cipher against server that supports that cipher</span><br><spa=
n> # --cipher ignored</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
TEST_NAME_4b=3D&quot;t_server_null_client.sh-openvpn_current_udp_dc3&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PASS_4b=3D&quot=
;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_EXEC=
_4b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-CLIENT_CONF_4b=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 11=
96 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_3a=3D&quot;t=
_server_null_client.sh-openvpn_current_udp_dc3&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_3a=3D&quot;yes&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_3a=3D&quot;${CLI=
ENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIE=
NT_CONF_3a=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --proto =
udp --cipher AES-128-CBC --data-ciphers AES-192-CBC&quot;</span><br><span> =
</span><br><span> # specific --data-cipher against server that doesn&#39;t =
support that cipher</span><br><span> # --cipher ignored</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-TEST_NAME_4c=3D&quot;t_server_null_client=
.sh-openvpn_current_udp_dc3_fail&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+TEST_NAME_3b=3D&quot;t_server_null_client.sh-openvpn_cur=
rent_udp_dc3_fail&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+SHOULD_PASS_3b=3D&quot;no&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+CLIENT_EXEC_3b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_3b=3D&quot;${CLIENT_CON=
F_BASE} --remote 127.0.0.1 1196 udp --proto udp --cipher AES-192-CBC --data=
-ciphers AES-128-CBC&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4a=
=3D&quot;t_server_null_client.sh-openvpn_current_multisocket_ipv4_tcp&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_4a=3D&q=
uot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT=
_EXEC_4a=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+CLIENT_CONF_4a=3D&quot;${CLIENT_CONF_BASE} --remote 127.0=
.0.1 1197 tcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4b=3D&quo=
t;t_server_null_client.sh-openvpn_current_multisocket_ipv6_udp&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+SHOULD_PASS_4b=3D&quot;yes=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_EXEC_4=
b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+CLIENT_CONF_4b=3D&quot;${CLIENT_CONF_BASE} --remote ::1 1197 udp=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+TEST_NAME_4c=3D&quot;t_server_nu=
ll_client.sh-openvpn_current_multisocket_ipv6_tcp_fail&quot;</span><br><spa=
n> SHOULD_PASS_4c=3D&quot;no&quot;</span><br><span> CLIENT_EXEC_4c=3D&quot;=
${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-C=
LIENT_CONF_4c=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --pro=
to udp --cipher AES-192-CBC --data-ciphers AES-128-CBC&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-TEST_NAME_5a=3D&quot;t_server_null_client.sh-openvpn_curr=
ent_multisocket_ipv4_tcp&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-SHOULD_PASS_5a=3D&quot;yes&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-CLIENT_EXEC_5a=3D&quot;${CLIENT_EXEC}&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_CONF_5a=3D&quot;${CLIENT_C=
ONF_BASE} --remote 127.0.0.1 1197 tcp&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-TEST_NAME_5b=3D&quot;t_server_null_client.sh-openvpn_current_multisocket_i=
pv6_udp&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_P=
ASS_5b=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-CLIENT_EXEC_5b=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-CLIENT_CONF_5b=3D&quot;${CLIENT_CONF_BASE} --remot=
e ::1 1197 udp&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_NAME_5c=3D&quot;t=
_server_null_client.sh-openvpn_current_multisocket_ipv6_tcp_fail&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-SHOULD_PASS_5c=3D&quot;no&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLIENT_EXEC_5c=
=3D&quot;${CLIENT_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-CLIENT_CONF_5c=3D&quot;${CLIENT_CONF_BASE} --remote ::1 1197 tcp&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CLIENT_CONF_4c=
=3D&quot;${CLIENT_CONF_BASE} --remote ::1 1197 tcp&quot;</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1086?usp=3Demail">change 1086</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1086?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49c69144ab6dcf1d26c96c2eafc=
2346ad4e0ca75 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1086 </div>
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


--WISMVVkvfIA=--

