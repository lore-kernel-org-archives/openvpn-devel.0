From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 3 Jun 2025 14:26:38 +0000
In-Reply-To: <gerrit.1748876308000.I480442a55025bfcce7cb68ec7564ff33b0b780e2@...2715...>
References: <gerrit.1748876308000.I480442a55025bfcce7cb68ec7564ff33b0b780e2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4bb68209f58fcbe51b724c01b01f76eaa3b1b803-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S9Jn8lG1UFg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S9Jn8lG1UFg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
38?usp=3Demail )

Change subject: t_server_null: Test different permutations of --dh
......................................................................

t_server_null: Test different permutations of --dh

Do not include --dh by default, since we do not actually
need it. Use the different servers for different ways
of specifying it.

Change-Id: I480442a55025bfcce7cb68ec7564ff33b0b780e2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250603142035.13685-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
868.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null_default.rc
1 file changed, 3 insertions(+), 3 deletions(-)




diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index ca8004a..365b5a8 100755
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
@@ -55,13 +55,13 @@
 SERVER_SERVER_2=3D"--server 10.29.42.0 255.255.255.0"
 SERVER_MGMT_PORT_2=3D"11195"
 SERVER_EXEC_2=3D"${SERVER_EXEC}"
-SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"
+SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}"

 SERVER_NAME_3=3D"t_server_null_server-1196_udp"
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--S9Jn8lG1UFg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1038?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">t_server_null: Test different permutations of=
 --dh<br><br>Do not include --dh by default, since we do not actually<br>ne=
ed it. Use the different servers for different ways<br>of specifying it.<br=
><br>Change-Id: I480442a55025bfcce7cb68ec7564ff33b0b780e2<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>Message-Id: &lt;20250603142035.13685-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg31868.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M tests/t_server_null_default.rc<br>1 file changed, 3 insertions(+)=
, 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_defaul=
t.rc</span><br><span>index ca8004a..365b5a8 100755</span><br><span>--- a/te=
sts/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_defa=
ult.rc</span><br><span>@@ -40,7 +40,7 @@</span><br><span> SERVER_EXEC=3D&qu=
ot;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span> SERVER_BASE_O=
PTS=3D&quot;--daemon --local 127.0.0.1 --dev tun --topology subnet --max-cl=
ients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;</span><br><s=
pan> SERVER_CIPHER_OPTS=3D&quot;&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-SERVER_CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${SE=
RVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+SERVER_CERT_OPTS=3D&quot;--ca ${CA} --c=
ert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><=
span> SERVER_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${=
SERVER_CERT_OPTS}&quot;</span><br><span> </span><br><span> TEST_SERVER_LIST=
=3D&quot;1 2 3&quot;</span><br><span>@@ -55,13 +55,13 @@</span><br><span> S=
ERVER_SERVER_2=3D&quot;--server 10.29.42.0 255.255.255.0&quot;</span><br><s=
pan> SERVER_MGMT_PORT_2=3D&quot;11195&quot;</span><br><span> SERVER_EXEC_2=
=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-SERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lpor=
t 1195 --proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_2=3D&quot;${S=
ERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --proto tcp --management 1=
27.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}&quot;</span><br><span> </span><br=
><span> SERVER_NAME_3=3D&quot;t_server_null_server-1196_udp&quot;</span><br=
><span> SERVER_SERVER_3=3D&quot;--server 10.29.43.0 255.255.255.0&quot;</sp=
an><br><span> SERVER_MGMT_PORT_3=3D&quot;11196&quot;</span><br><span> SERVE=
R_EXEC_3=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-SERVER_CONF_3=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_3=
} --lport 1196 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_3} --c=
ipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CBC&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_3=3D&quot;${SERVER_CONF_=
BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 ${=
SERVER_MGMT_PORT_3} --dh none --cipher AES-192-CBC --data-ciphers DEFAULT:A=
ES-192-CBC&quot;</span><br><span> </span><br><span> # Test client configura=
tions</span><br><span> CLIENT_EXEC=3D&quot;${top_builddir}/src/openvpn/open=
vpn&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1038?usp=3Demail">change 1038</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1038?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I480442a55025bfcce7cb68ec756=
4ff33b0b780e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1038 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--S9Jn8lG1UFg=--

