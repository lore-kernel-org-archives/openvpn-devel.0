From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 12:00:37 +0000
References: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2396945518b4d380a696bf4a389f77957a1d2b87-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="brL1jjKG2fo="; charset=UTF-8
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

--brL1jjKG2fo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail

to review the following change.


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
1 file changed, 3 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1555/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 1df1001..32e2a65 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1347,7 +1347,9 @@
     ASSERT(sock);

     const char *host =3D o->ce.local_list->array[sock_index]->local;
-    const char *port =3D o->ce.local_list->array[sock_index]->port;
+    const char *port =3D (o->mode =3D=3D MODE_POINT_TO_POINT && o->ce.loca=
l_port_defined)
+                           ? o->ce.local_port
+                           : o->ce.local_list->array[sock_index]->port;
     int proto =3D o->ce.local_list->array[sock_index]->proto;
     const char *remote_host =3D o->ce.remote;
     const char *remote_port =3D o->ce.remote_port;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b
Gerrit-Change-Number: 1555
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--brL1jjKG2fo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>its_Giaan would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socket: restore per-connection lport overri=
de over global default<br><br>OpenVPN 2.7.x introduced a regression where -=
-lport specified<br>inside a &lt;connection&gt; block did not override a gl=
obally defined<br>local port. As a result, the socket was bound to the glob=
al<br>default port instead of the per-connection value.<br><br>Adjust the s=
ocket local_port selection logic to honour<br>local_port_defined when set f=
or the active connection profile.<br><br>This change restores the documente=
d and previously working<br>behaviour from 2.6.x, where connection-level lp=
ort takes<br>precedence over global defaults.<br><br>Github: #995<br><br>Ch=
ange-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b<br>Signed-off-by: Gianma=
rco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/socket.=
c<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/1555/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br>=
<span>index 1df1001..32e2a65 100644</span><br><span>--- a/src/openvpn/socke=
t.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -1347,7 +=
1347,9 @@</span><br><span>     ASSERT(sock);</span><br><span> </span><br><s=
pan>     const char *host =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt=
;local;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char=
 *port =3D o-&gt;ce.local_list-&gt;array[sock_index]-&gt;port;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *port =3D (o-&gt;=
mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; o-&gt;ce.local_port_defined)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
    ? o-&gt;ce.local_port</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                           : o-&gt;ce.local_list-&gt;array[sock_index=
]-&gt;port;</span><br><span>     int proto =3D o-&gt;ce.local_list-&gt;arra=
y[sock_index]-&gt;proto;</span><br><span>     const char *remote_host =3D o=
-&gt;ce.remote;</span><br><span>     const char *remote_port =3D o-&gt;ce.r=
emote_port;</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail">change 1555</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1555?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7cf5d5ef7e2531f397ad97baf46=
63e3763072f6b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--brL1jjKG2fo=--

