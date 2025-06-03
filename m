From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 3 Jun 2025 14:26:36 +0000
In-Reply-To: <gerrit.1748876308000.I480442a55025bfcce7cb68ec7564ff33b0b780e2@...2715...>
References: <gerrit.1748876308000.I480442a55025bfcce7cb68ec7564ff33b0b780e2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4bb68209f58fcbe51b724c01b01f76eaa3b1b803-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hHiDUz3xeuw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hHiDUz3xeuw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1038?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1038/3

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
Gerrit-MessageType: newpatchset

--hHiDUz3xeuw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1038?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">t_server_null: Test different permutations of --dh<b=
r><br>Do not include --dh by default, since we do not actually<br>need it. =
Use the different servers for different ways<br>of specifying it.<br><br>Ch=
ange-Id: I480442a55025bfcce7cb68ec7564ff33b0b780e2<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>Message-Id: &lt;20250603142035.13685-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
31868.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M tests/t_server_null_default.rc<br>1 file changed, 3 insertions(+), 3 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/38/1038/3</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/tests/t_server_null_default.rc b/tests=
/t_server_null_default.rc</span><br><span>index ca8004a..365b5a8 100755</sp=
an><br><span>--- a/tests/t_server_null_default.rc</span><br><span>+++ b/tes=
ts/t_server_null_default.rc</span><br><span>@@ -40,7 +40,7 @@</span><br><sp=
an> SERVER_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br=
><span> SERVER_BASE_OPTS=3D&quot;--daemon --local 127.0.0.1 --dev tun --top=
ology subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-=
cn&quot;</span><br><span> SERVER_CIPHER_OPTS=3D&quot;&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-SERVER_CERT_OPTS=3D&quot;--ca ${CA} -=
-dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_CERT_OPTS=
=3D&quot;--ca ${CA} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-auth ${=
TA} 0&quot;</span><br><span> SERVER_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} $=
{SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&quot;</span><br><span> </span><br>=
<span> TEST_SERVER_LIST=3D&quot;1 2 3&quot;</span><br><span>@@ -55,13 +55,1=
3 @@</span><br><span> SERVER_SERVER_2=3D&quot;--server 10.29.42.0 255.255.2=
55.0&quot;</span><br><span> SERVER_MGMT_PORT_2=3D&quot;11195&quot;</span><b=
r><span> SERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-SERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} $=
{SERVER_SERVER_2} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_=
MGMT_PORT_2}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+S=
ERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --=
proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2} --dh ${DH}&quot;</sp=
an><br><span> </span><br><span> SERVER_NAME_3=3D&quot;t_server_null_server-=
1196_udp&quot;</span><br><span> SERVER_SERVER_3=3D&quot;--server 10.29.43.0=
 255.255.255.0&quot;</span><br><span> SERVER_MGMT_PORT_3=3D&quot;11196&quot=
;</span><br><span> SERVER_EXEC_3=3D&quot;${SERVER_EXEC}&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-SERVER_CONF_3=3D&quot;${SERVER_CONF=
_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp --management 127.0.0.1 $=
{SERVER_MGMT_PORT_3} --cipher AES-192-CBC --data-ciphers DEFAULT:AES-192-CB=
C&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_=
3=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_3} --lport 1196 --proto udp -=
-management 127.0.0.1 ${SERVER_MGMT_PORT_3} --dh none --cipher AES-192-CBC =
--data-ciphers DEFAULT:AES-192-CBC&quot;</span><br><span> </span><br><span>=
 # Test client configurations</span><br><span> CLIENT_EXEC=3D&quot;${top_bu=
ilddir}/src/openvpn/openvpn&quot;</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1038?usp=3Demail=
">change 1038</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1038?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--hHiDUz3xeuw=--

