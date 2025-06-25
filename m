From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 25 Jun 2025 16:49:48 +0000
In-Reply-To: <gerrit.1750855403000.I5d9535d46e5a5488f4a2b637a6fcb99aad668fee@...2715...>
References: <gerrit.1750855403000.I5d9535d46e5a5488f4a2b637a6fcb99aad668fee@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 antonio@...2726...
Message-ID: <f7c3a0bff97a6517a9484efd75f5be5c1c40b2d9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tGGdGlBRuCM="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tGGdGlBRuCM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1068?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


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
Acked-by: Antonio Quartulli <antonio@...2726...>
Message-Id: <20250625162638.7769-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
971.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 0 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/1068/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--tGGdGlBRuCM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by ralf_lici.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1068?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco linux: avoid sending local port to ovpn<br><br>W=
hen sending an OVPN_CMD_NEW_PEER netlink message to ovpn, we currently<br>a=
ttempt to include the local port along with the local address. However,<br>=
`dco_multi_get_localaddr()` does not record the port, so we end up<br>sendi=
ng a zero value. This zero is rejected by ovpn&#39;s netlink policy,<br>lea=
ding to an error and aborted connection.<br><br>Since openvpn does not actu=
ally need to send the local port because the<br>module retrieves it directl=
y from the socket, this commit ensures that<br>only the local address is se=
nt.<br><br>Change-Id: I5d9535d46e5a5488f4a2b637a6fcb99aad668fee<br>Signed-o=
ff-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked-by: Antonio Quartulli &lt=
;antonio@...2726...&gt;<br>Message-Id: &lt;20250625162638.7769-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg31971.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M src/openvpn/dco_linux.c<br>1 file changed, 0 insertions(+), 2=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/68/1068/2</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.c b/src/open=
vpn/dco_linux.c</span><br><span>index 0345413..22a445a 100644</span><br><sp=
an>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linu=
x.c</span><br><span>@@ -265,13 +265,11 @@</span><br><span>         {</span>=
<br><span>             NLA_PUT(nl_msg, OVPN_A_PEER_LOCAL_IPV4, sizeof(struc=
t in_addr),</span><br><span>                     &amp;((struct sockaddr_in =
*)localaddr)-&gt;sin_addr);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            NLA_PUT_U16(nl_msg, OVPN_A_PEER_LOCAL_PORT, ((struct sock=
addr_in *)localaddr)-&gt;sin_port);</span><br><span>         }</span><br><s=
pan>         else if (localaddr-&gt;sa_family =3D=3D AF_INET6)</span><br><s=
pan>         {</span><br><span>             NLA_PUT(nl_msg, OVPN_A_PEER_LOC=
AL_IPV6, sizeof(struct in6_addr),</span><br><span>                     &amp=
;((struct sockaddr_in6 *)localaddr)-&gt;sin6_addr);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            NLA_PUT_U16(nl_msg, OVPN_A_PEER=
_LOCAL_PORT, ((struct sockaddr_in6 *)localaddr)-&gt;sin6_port);</span><br><=
span>         }</span><br><span>     }</span><br><span> </span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1068?usp=3Demail">change 1068</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1068?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5d9535d46e5a5488f4a2b637a6f=
cb99aad668fee </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1068 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tGGdGlBRuCM=--

