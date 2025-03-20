From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 20 Mar 2025 00:19:58 +0000
References: <gerrit.1742429994000.I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <88c3647a0f6bec03af01467ec1c2a41b59f11280-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m7SMUb5UKCw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket: use remote
 proto when creating client sockets
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

--m7SMUb5UKCw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/911?usp=3Demail

to review the following change.


Change subject: socket: use remote proto when creating client sockets
......................................................................

socket: use remote proto when creating client sockets

When creating a socket to connect to a remote (this happens
in client mode) always use the protocol specified for the
remote.

The listening protocol in this case is just ignored as it
does not make any sense.

Change-Id: I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/socket.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/911/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..ad97830 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1886,6 +1886,11 @@
     const char *remote_host =3D o->ce.remote;
     const char *remote_port =3D o->ce.remote_port;
=20
+    if (remote_host)
+    {
+        proto =3D o->ce.proto;
+    }
+
     if (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM_CHILD_UDP)
     {
         struct link_socket *tmp_sock =3D NULL;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/911?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9
Gerrit-Change-Number: 911
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--m7SMUb5UKCw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/911?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">socket: use remote proto when creating client sockets<br><br>=
When creating a socket to connect to a remote (this happens<br>in client mo=
de) always use the protocol specified for the<br>remote.<br><br>The listeni=
ng protocol in this case is just ignored as it<br>does not make any sense.<=
br><br>Change-Id: I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9<br>Signed-off-b=
y: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/soc=
ket.c<br>1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/11/911/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 6=
b32e30..ad97830 100644</span><br><span>--- a/src/openvpn/socket.c</span><br=
><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -1886,6 +1886,11 @@</s=
pan><br><span>     const char *remote_host =3D o-&gt;ce.remote;</span><br><=
span>     const char *remote_port =3D o-&gt;ce.remote_port;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (remote_ho=
st)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        proto =3D o-&gt;ce.pro=
to;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (c-&g=
t;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><sp=
an>     {</span><br><span>         struct link_socket *tmp_sock =3D NULL;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/911?usp=3Demail">change 911</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/911?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6d2ec69ac7a9ef5900d8f1d8541=
d6a19c9cb7df9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 911 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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


--m7SMUb5UKCw=--

