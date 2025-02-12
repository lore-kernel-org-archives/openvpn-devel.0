From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 13:04:02 +0000
In-Reply-To: <gerrit.1739361204000.If6a636b2099d948e249cf92ed2ba91d1698ee42f@...2715...>
References: <gerrit.1739361204000.If6a636b2099d948e249cf92ed2ba91d1698ee42f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <83ef1503279a14525d2b984b25ea2f748df10d79-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dJzQJbfbf30="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix oversight of
 link socket code change in Android code path
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

--dJzQJbfbf30=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/888?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix oversight of link socket code change in Android code pa=
th
......................................................................

Fix oversight of link socket code change in Android code path

Commit 94b391d7ef5 changed context->link_socket to context->link_sockets
but did not change the Android code path.

Change-Id: If6a636b2099d948e249cf92ed2ba91d1698ee42f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250212123820.19099-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
833.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/888/2

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4014517..a7f7db4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4381,16 +4381,16 @@

     int socketfd =3D -1;
     struct context *c =3D (struct context *) arg;
-    if (!c->c2.link_socket)
+    if (!c->c2.link_sockets || !c->c2.link_sockets[0])
     {
         return -1;
     }
-    if (c->c2.link_socket->sd =3D=3D SOCKET_UNDEFINED)
+    if (c->c2.link_sockets[0]->sd =3D=3D SOCKET_UNDEFINED)
     {
         return -1;
     }

-    socketfd =3D c->c2.link_socket->sd;
+    socketfd =3D c->c2.link_sockets[0]->sd;
     if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
     {
         return socketfd;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/888?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If6a636b2099d948e249cf92ed2ba91d1698ee42f
Gerrit-Change-Number: 888
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--dJzQJbfbf30=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
888?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix oversight of link socket code change in Android =
code path<br><br>Commit 94b391d7ef5 changed context-&gt;link_socket to cont=
ext-&gt;link_sockets<br>but did not change the Android code path.<br><br>Ch=
ange-Id: If6a636b2099d948e249cf92ed2ba91d1698ee42f<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>Message-Id: &lt;20250212123820.19099-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30833.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src=
/openvpn/init.c<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/888/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>i=
ndex 4014517..a7f7db4 100644</span><br><span>--- a/src/openvpn/init.c</span=
><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -4381,16 +4381,16 @@=
</span><br><span> </span><br><span>     int socketfd =3D -1;</span><br><spa=
n>     struct context *c =3D (struct context *) arg;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!c-&gt;c2.link_socket)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;c2.link_sockets |=
| !c-&gt;c2.link_sockets[0])</span><br><span>     {</span><br><span>       =
  return -1;</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (c-&gt;c2.link_socket-&gt;sd =3D=3D SOCKET_UNDEFINED)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.lin=
k_sockets[0]-&gt;sd =3D=3D SOCKET_UNDEFINED)</span><br><span>     {</span><=
br><span>         return -1;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    socketfd =3D c-&gt;c2.l=
ink_socket-&gt;sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   socketfd =3D c-&gt;c2.link_sockets[0]-&gt;sd;</span><br><span>     if (!=
c-&gt;options.pull || c-&gt;c2.tls_multi-&gt;use_peer_id || samenetwork)</s=
pan><br><span>     {</span><br><span>         return socketfd;</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/888?usp=3Demail">change 888</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/888?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If6a636b2099d948e249cf92ed2b=
a91d1698ee42f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 888 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--dJzQJbfbf30=--

