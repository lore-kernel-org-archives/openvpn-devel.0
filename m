From: "mattock (Code Review)" <gerrit@...515...>
Date: Thu, 21 Aug 2025 06:39:28 +0000
References: <gerrit.1755758366000.I27a7519ab3ae629d3dc634ad3e9e2120e524e669@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c3571fcd591143f67ac0341759f0ca1bf181968e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5CY71Xn4J8M="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null:
 remove the --dh parameter altogether
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

--5CY71Xn4J8M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1146?usp=3Demail

to review the following change.


Change subject: t_server_null: remove the --dh parameter altogether
......................................................................

t_server_null: remove the --dh parameter altogether

Change-Id: I27a7519ab3ae629d3dc634ad3e9e2120e524e669
Signed-off-by: Samuli Sepp=C3=A4nen <sasepp@...2705...>
---
M tests/t_server_null_default.rc
1 file changed, 2 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1146/1

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 900f189..51c21c9 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -13,7 +13,6 @@
 top_builddir=3D"${top_builddir:-..}"
 sample_keys=3D"${srcdir}/../sample/sample-keys"

-DH=3D"${sample_keys}/dh2048.pem"
 CA=3D"${sample_keys}/ca.crt"
 CLIENT_CERT=3D"${sample_keys}/client.crt"
 CLIENT_KEY=3D"${sample_keys}/client.key"
@@ -57,13 +56,13 @@
 SERVER_SERVER_2=3D"--server 10.29.42.0 255.255.255.0"
 SERVER_MGMT_PORT_2=3D"11195"
 SERVER_EXEC_2=3D"${SERVER_EXEC}"
-SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}"
+SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"

 SERVER_NAME_3=3D"t_server_null_server-1196_udp"
 SERVER_SERVER_3=3D"--server 10.29.43.0 255.255.255.0"
 SERVER_MGMT_PORT_3=3D"11196"
 SERVER_EXEC_3=3D"${SERVER_EXEC}"
-SERVER_CONF_3=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --dh none --cipher AES-=
192-CBC --data-ciphers DEFAULT:AES-192-CBC"
+SERVER_CONF_3=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --=
data-ciphers DEFAULT:AES-192-CBC"

 SERVER_NAME_4=3D"t_server_null_server-1197_multisocket_ipv4_ipv6"
 SERVER_SERVER_4=3D"--server 10.29.44.0 255.255.255.0"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1146?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I27a7519ab3ae629d3dc634ad3e9e2120e524e669
Gerrit-Change-Number: 1146
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--5CY71Xn4J8M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1146?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">t_server_null: remove the --dh parameter altogether<br><br>C=
hange-Id: I27a7519ab3ae629d3dc634ad3e9e2120e524e669<br>Signed-off-by: Samul=
i Sepp=C3=A4nen &lt;sasepp@...2705...&gt;<br>---<br>M tests/t_server_null_d=
efault.rc<br>1 file changed, 2 insertions(+), 3 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1146/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.r=
c</span><br><span>index 900f189..51c21c9 100755</span><br><span>--- a/tests=
/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_default=
.rc</span><br><span>@@ -13,7 +13,6 @@</span><br><span> top_builddir=3D&quot=
;${top_builddir:-..}&quot;</span><br><span> sample_keys=3D&quot;${srcdir}/.=
./sample/sample-keys&quot;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-DH=3D&quot;${sample_keys}/dh2048.pem&quot;</span><br=
><span> CA=3D&quot;${sample_keys}/ca.crt&quot;</span><br><span> CLIENT_CERT=
=3D&quot;${sample_keys}/client.crt&quot;</span><br><span> CLIENT_KEY=3D&quo=
t;${sample_keys}/client.key&quot;</span><br><span>@@ -57,13 +56,13 @@</span=
><br><span> SERVER_SERVER_2=3D&quot;--server 10.29.42.0 255.255.255.0&quot;=
</span><br><span> SERVER_MGMT_PORT_2=3D&quot;11195&quot;</span><br><span> S=
ERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-SERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERV=
ER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}=
 --dh ${DH}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SE=
RVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --p=
roto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}&quot;</span><br><span=
> </span><br><span> SERVER_NAME_3=3D&quot;t_server_null_server-1196_udp&quo=
t;</span><br><span> SERVER_SERVER_3=3D&quot;--server 10.29.43.0 255.255.255=
.0&quot;</span><br><span> SERVER_MGMT_PORT_3=3D&quot;11196&quot;</span><br>=
<span> SERVER_EXEC_3=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-SERVER_CONF_3=3D&quot;${SERVER_CONF_BASE} ${SER=
VER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT=
_PORT_3} --dh none --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_3=
=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --=
management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --data-ciph=
ers DEFAULT:AES-192-CBC&quot;</span><br><span> </span><br><span> SERVER_NAM=
E_4=3D&quot;t_server_null_server-1197_multisocket_ipv4_ipv6&quot;</span><br=
><span> SERVER_SERVER_4=3D&quot;--server 10.29.44.0 255.255.255.0&quot;</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1146?usp=3Demail">change 1146</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1146?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27a7519ab3ae629d3dc634ad3e9=
e2120e524e669 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1146 </div>
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


--5CY71Xn4J8M=--

