From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 2 Jun 2025 14:58:31 +0000
References: <gerrit.1748876308000.I480442a55025bfcce7cb68ec7564ff33b0b780e2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6c48f9118096436c793ffcac1bce23f922f8f2db-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/f0gyJCway0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null: Test
 different permutations of --dh
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

--/f0gyJCway0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1038?usp=3Demail

to review the following change.


Change subject: t_server_null: Test different permutations of --dh
......................................................................

t_server_null: Test different permutations of --dh

Change-Id: I480442a55025bfcce7cb68ec7564ff33b0b780e2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/t_server_null_default.rc
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1038/1

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index ca8004a..9350fcc 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -40,7 +40,7 @@
 SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
 SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
 SERVER_CIPHER_OPTS=3D""
-SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
+SERVER_CERT_OPTS=3D"--ca ${CA} --cert ${SERVER_CERT} --key ${SERVER_KEY} -=
-tls-auth ${TA} 0"
 SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"

 TEST_SERVER_LIST=3D"1 2 3"
@@ -61,7 +61,7 @@
 SERVER_SERVER_3=3D"--server 10.29.43.0 255.255.255.0"
 SERVER_MGMT_PORT_3=3D"11196"
 SERVER_EXEC_3=3D"${SERVER_EXEC}"
-SERVER_CONF_3=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC --=
data-ciphers DEFAULT:AES-192-CBC"
+SERVER_CONF_3=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --dh none --cipher AES-=
192-CBC --data-ciphers DEFAULT:AES-192-CBC"

 # Test client configurations
 CLIENT_EXEC=3D"${top_builddir}/src/openvpn/openvpn"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1038?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I480442a55025bfcce7cb68ec7564ff33b0b780e2
Gerrit-Change-Number: 1038
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--/f0gyJCway0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1038?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">t_server_null: Test different permutations of --dh<br><br>Ch=
ange-Id: I480442a55025bfcce7cb68ec7564ff33b0b780e2<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/t_server_null_defaul=
t.rc<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1038/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc</sp=
an><br><span>index ca8004a..9350fcc 100755</span><br><span>--- a/tests/t_se=
rver_null_default.rc</span><br><span>+++ b/tests/t_server_null_default.rc</=
span><br><span>@@ -40,7 +40,7 @@</span><br><span> SERVER_EXEC=3D&quot;${top=
_builddir}/src/openvpn/openvpn&quot;</span><br><span> SERVER_BASE_OPTS=3D&q=
uot;--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clients $M=
AX_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;</span><br><span> SER=
VER_CIPHER_OPTS=3D&quot;&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-SERVER_CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${SERVER_CER=
T} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+SERVER_CERT_OPTS=3D&quot;--ca ${CA} --cert ${SE=
RVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span> SE=
RVER_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_C=
ERT_OPTS}&quot;</span><br><span> </span><br><span> TEST_SERVER_LIST=3D&quot=
;1 2 3&quot;</span><br><span>@@ -61,7 +61,7 @@</span><br><span> SERVER_SERV=
ER_3=3D&quot;--server 10.29.43.0 255.255.255.0&quot;</span><br><span> SERVE=
R_MGMT_PORT_3=3D&quot;11196&quot;</span><br><span> SERVER_EXEC_3=3D&quot;${=
SERVER_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SER=
VER_CONF_3=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --pr=
oto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --cipher AES-192-CBC -=
-data-ciphers DEFAULT:AES-192-CBC&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+SERVER_CONF_3=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERV=
ER_3} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3}=
 --dh none --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC&quot;</s=
pan><br><span> </span><br><span> # Test client configurations</span><br><sp=
an> CLIENT_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1038?usp=3Demail">change 1038</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1038?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I480442a55025bfcce7cb68ec756=
4ff33b0b780e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1038 </div>
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


--/f0gyJCway0=--

