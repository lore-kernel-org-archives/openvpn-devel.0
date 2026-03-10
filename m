From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 16:19:28 +0000
In-Reply-To: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
References: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <495a63af129f2c411e210e082d975faecafefcfc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="npQggtYr1jE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket: restore
 per-connection lport override over global default
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

--npQggtYr1jE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

Hello ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by ordex


Change subject: socket: restore per-connection lport override over global d=
efault
......................................................................

socket: restore per-connection lport override over global default

OpenVPN 2.7.x introduced a regression where --lport specified
inside a <connection> block did not override a globally defined
local port. As a result, the socket was bound to the global
default port instead of the per-connection value.

Adjust the socket local_port selection logic to honour
local_port_defined when set for the active connection profile.

This change restores the documented and previously working
behaviour from 2.6.x, where connection-level lport takes
precedence over global defaults.

Github: #995

Change-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/socket.c
1 file changed, 7 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1555/2

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8d2d110..3c1d734 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1357,6 +1357,13 @@
         proto =3D o->ce.proto;
     }

+    /* If --lport is specified in a client connection block,
+     * it takes precedence over the global setting. */
+    if (o->mode =3D=3D MODE_POINT_TO_POINT && o->ce.local_port_defined)
+    {
+        port =3D o->ce.local_port;
+    }
+
     if (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM_CHILD_UDP)
     {
         struct link_socket *tmp_sock =3D NULL;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b
Gerrit-Change-Number: 1555
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <antonio@...2726...>

--npQggtYr1jE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, ordex, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">socket: restore per-connection lpor=
t override over global default<br><br>OpenVPN 2.7.x introduced a regression=
 where --lport specified<br>inside a &lt;connection&gt; block did not overr=
ide a globally defined<br>local port. As a result, the socket was bound to =
the global<br>default port instead of the per-connection value.<br><br>Adju=
st the socket local_port selection logic to honour<br>local_port_defined wh=
en set for the active connection profile.<br><br>This change restores the d=
ocumented and previously working<br>behaviour from 2.6.x, where connection-=
level lport takes<br>precedence over global defaults.<br><br>Github: #995<b=
r><br>Change-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b<br>Signed-off-by=
: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn=
/socket.c<br>1 file changed, 7 insertions(+), 0 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/5=
5/1555/2</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</=
span><br><span>index 8d2d110..3c1d734 100644</span><br><span>--- a/src/open=
vpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ =
-1357,6 +1357,13 @@</span><br><span>         proto =3D o-&gt;ce.proto;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* If --lport is specified in a client connection bloc=
k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * it takes p=
recedence over the global setting. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; =
o-&gt;ce.local_port_defined)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   port =3D o-&gt;ce.local_port;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     if (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=
=3D CM_CHILD_UDP)</span><br><span>     {</span><br><span>         struct li=
nk_socket *tmp_sock =3D NULL;</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail">ch=
ange 1555</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7cf5d5ef7e2531f397ad97baf46=
63e3763072f6b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--npQggtYr1jE=--

