From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 14:08:34 +0000
In-Reply-To: <gerrit.1742429994000.I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9@...2715...>
References: <gerrit.1742429994000.I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <f6216d2d184ac1bd1b63051977796e9620500bbb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FHDjcrYwAf8="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FHDjcrYwAf8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/91=
1?usp=3Demail )

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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250325105724.1285-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
234.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 5 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 09de1b0..4fb6fe6 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1903,6 +1903,11 @@
     const char *remote_host =3D o->ce.remote;
     const char *remote_port =3D o->ce.remote_port;

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
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--FHDjcrYwAf8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/911?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">socket: use remote proto when creating client =
sockets<br><br>When creating a socket to connect to a remote (this happens<=
br>in client mode) always use the protocol specified for the<br>remote.<br>=
<br>The listening protocol in this case is just ignored as it<br>does not m=
ake any sense.<br><br>Change-Id: I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9<=
br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acked-by:=
 Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;2025032510=
5724.1285-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg31234.html<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file changed,=
 5 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 09de1b0..4fb6fe6 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -1903,6 +1903,=
11 @@</span><br><span>     const char *remote_host =3D o-&gt;ce.remote;</sp=
an><br><span>     const char *remote_port =3D o-&gt;ce.remote_port;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r=
emote_host)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        proto =3D o-&g=
t;ce.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
if (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP)</span=
><br><span>     {</span><br><span>         struct link_socket *tmp_sock =3D=
 NULL;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/911?usp=3Demail">change 911</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/911?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6d2ec69ac7a9ef5900d8f1d8541=
d6a19c9cb7df9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 911 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--FHDjcrYwAf8=--

