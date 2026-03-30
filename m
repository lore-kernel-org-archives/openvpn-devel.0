From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Mar 2026 11:28:19 +0000
In-Reply-To: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
References: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 antonio@...2726...
Message-ID: <fa2d4f99a1711da4ba326f7fc5f946e23018b18d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E9tJXQe4gzQ="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--E9tJXQe4gzQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


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

Github: closes OpenVPN/openvpn#995

Change-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1555
Message-Id: <20260316134841.28362-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
164.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 7 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1555/3

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 5df0792..624ce4f 100644
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
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--E9tJXQe4gzQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by its_Giaan.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">socket: restore per-connection lpor=
t override over global default<br><br>OpenVPN 2.7.x introduced a regression=
 where --lport specified<br>inside a &lt;connection&gt; block did not overr=
ide a globally defined<br>local port. As a result, the socket was bound to =
the global<br>default port instead of the per-connection value.<br><br>Adju=
st the socket local_port selection logic to honour<br>local_port_defined wh=
en set for the active connection profile.<br><br>This change restores the d=
ocumented and previously working<br>behaviour from 2.6.x, where connection-=
level lport takes<br>precedence over global defaults.<br><br>Github: closes=
 OpenVPN/openvpn#995<br><br>Change-Id: I7cf5d5ef7e2531f397ad97baf4663e37630=
72f6b<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<b=
r>Acked-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Gerrit URL: htt=
ps://gerrit.openvpn.net/c/openvpn/+/1555<br>Message-Id: &lt;20260316134841.=
28362-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg36164.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed, 7 i=
nsertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/55/1555/3</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 5df0792..62=
4ce4f 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++=
 b/src/openvpn/socket.c</span><br><span>@@ -1357,6 +1357,13 @@</span><br><s=
pan>         proto =3D o-&gt;ce.proto;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If --lpo=
rt is specified in a client connection block,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * it takes precedence over the global settin=
g. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;=
mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; o-&gt;ce.local_port_defined)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        port =3D o-&gt;ce.local_port;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (c-&gt;m=
ode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span>=
     {</span><br><span>         struct link_socket *tmp_sock =3D NULL;</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1555?usp=3Demail">change 1555</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1555?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7cf5d5ef7e2531f397ad97baf46=
63e3763072f6b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--E9tJXQe4gzQ=--

