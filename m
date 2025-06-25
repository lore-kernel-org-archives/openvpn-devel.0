From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 25 Jun 2025 12:43:25 +0000
References: <gerrit.1750855403000.I5d9535d46e5a5488f4a2b637a6fcb99aad668fee@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4b9ddbfcbc72cdbceb017dd4f346c6d831bdcf80-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FXfY4hrpvYI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco linux: avoid
 sending local port to ovpn
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

--FXfY4hrpvYI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1068?usp=3Demail

to review the following change.


Change subject: dco linux: avoid sending local port to ovpn
......................................................................

dco linux: avoid sending local port to ovpn

When sending an OVPN_CMD_NEW_PEER netlink message to ovpn, we currently
attempt to include the local port along with the local address. However,
`dco_multi_get_localaddr()` does not record the port, so we end up
sending a zero value. This zero is rejected by ovpn's netlink policy,
leading to an error and aborted connection.

Since openvpn does not actually need to send the local port because the
module retrieves it directly from the socket, this commit ensures that
only the local address is sent.

Change-Id: I5d9535d46e5a5488f4a2b637a6fcb99aad668fee
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_linux.c
1 file changed, 0 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/1068/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 0345413..22a445a 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -265,13 +265,11 @@
         {
             NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV4, sizeof(struct in_addr),
                     &((struct sockaddr_in *)localaddr)->sin_addr);
-            NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_=
in *)localaddr)->sin_port);
         }
         else if (localaddr->sa_family =3D=3D AF_INET6)
         {
             NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV6, sizeof(struct in6_addr=
),
                     &((struct sockaddr_in6 *)localaddr)->sin6_addr);
-            NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_=
in6 *)localaddr)->sin6_port);
         }
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1068?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5d9535d46e5a5488f4a2b637a6fcb99aad668fee
Gerrit-Change-Number: 1068
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--FXfY4hrpvYI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1068?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco linux: avoid sending local port to ovpn<br><br>When send=
ing an OVPN_CMD_NEW_PEER netlink message to ovpn, we currently<br>attempt t=
o include the local port along with the local address. However,<br>`dco_mul=
ti_get_localaddr()` does not record the port, so we end up<br>sending a zer=
o value. This zero is rejected by ovpn&#39;s netlink policy,<br>leading to =
an error and aborted connection.<br><br>Since openvpn does not actually nee=
d to send the local port because the<br>module retrieves it directly from t=
he socket, this commit ensures that<br>only the local address is sent.<br><=
br>Change-Id: I5d9535d46e5a5488f4a2b637a6fcb99aad668fee<br>Signed-off-by: R=
alf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 f=
ile changed, 0 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/68/1068/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 034541=
3..22a445a 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><=
span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -265,13 +265,11 @@</s=
pan><br><span>         {</span><br><span>             NLA_PUT(nl_msg, OVPN_=
A_PEER_LOCAL_IPV4, sizeof(struct in_addr),</span><br><span>                =
     &amp;((struct sockaddr_in *)localaddr)-&gt;sin_addr);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            NLA_PUT_U16(nl_msg, OVPN_A=
_PEER_LOCAL_PORT, ((struct sockaddr_in *)localaddr)-&gt;sin_port);</span><b=
r><span>         }</span><br><span>         else if (localaddr-&gt;sa_famil=
y =3D=3D AF_INET6)</span><br><span>         {</span><br><span>             =
NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV6, sizeof(struct in6_addr),</span><br>=
<span>                     &amp;((struct sockaddr_in6 *)localaddr)-&gt;sin6=
_addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            NL=
A_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sockaddr_in6 *)localaddr=
)-&gt;sin6_port);</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1068?usp=3Demail">change 1068</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1068?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d9535d46e5a5488f4a2b637a6f=
cb99aad668fee </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1068 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
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


--FXfY4hrpvYI=--

