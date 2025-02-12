From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 11:53:31 +0000
References: <gerrit.1739361204000.If6a636b2099d948e249cf92ed2ba91d1698ee42f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <3a6e6ed3a581bffe449839f6954a7a0c0494b23b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Iff+z9BM+0w="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Iff+z9BM+0w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/888?usp=3Demail

to review the following change.


Change subject: Fix oversight of link socket code change in Android code pa=
th
......................................................................

Fix oversight of link socket code change in Android code path

Commit 94b391d7ef5 changed context->link_socket to context->link_sockets
but did not change the Android code path.

Change-Id: If6a636b2099d948e249cf92ed2ba91d1698ee42f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
1 file changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/888/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Iff+z9BM+0w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/888?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix oversight of link socket code change in Android code path=
<br><br>Commit 94b391d7ef5 changed context-&gt;link_socket to context-&gt;l=
ink_sockets<br>but did not change the Android code path.<br><br>Change-Id: =
If6a636b2099d948e249cf92ed2ba91d1698ee42f<br>Signed-off-by: Arne Schwabe &l=
t;arne@...1227...&gt;<br>---<br>M src/openvpn/init.c<br>1 file changed, 3 i=
nsertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/88/888/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b=
/src/openvpn/init.c</span><br><span>index 4014517..a7f7db4 100644</span><br=
><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</s=
pan><br><span>@@ -4381,16 +4381,16 @@</span><br><span> </span><br><span>   =
  int socketfd =3D -1;</span><br><span>     struct context *c =3D (struct c=
ontext *) arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!c-&gt;c2.link_socket)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!c-&gt;c2.link_sockets || !c-&gt;c2.link_sockets[0])</span><br>=
<span>     {</span><br><span>         return -1;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.link_soc=
ket-&gt;sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (c-&gt;c2.link_sockets[0]-&gt;sd =3D=3D SOCKET_UNDEF=
INED)</span><br><span>     {</span><br><span>         return -1;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    socketfd =3D c-&gt;c2.link_socket-&gt;sd;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    socketfd =3D c-&gt;c2.link_sockets[0=
]-&gt;sd;</span><br><span>     if (!c-&gt;options.pull || c-&gt;c2.tls_mult=
i-&gt;use_peer_id || samenetwork)</span><br><span>     {</span><br><span>  =
       return socketfd;</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/888?usp=3Demail">change 88=
8</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/888?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If6a636b2099d948e249cf92ed2b=
a91d1698ee42f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 888 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Iff+z9BM+0w=--

