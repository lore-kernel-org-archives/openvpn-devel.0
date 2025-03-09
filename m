From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 9 Mar 2025 16:42:28 +0000
In-Reply-To: <gerrit.1734109769000.I76e2e616c6ffe436a9627fa71aaace74030b2f4a@...2715...>
References: <gerrit.1734109769000.I76e2e616c6ffe436a9627fa71aaace74030b2f4a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <4c25c624a10fa3bd219bad1e4ebe0a5fab627e75-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6rOJNdxScqw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: pass
 remoteaddr only for UDP peers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6rOJNdxScqw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/84=
2?usp=3Demail )

Change subject: dco: pass remoteaddr only for UDP peers
......................................................................

dco: pass remoteaddr only for UDP peers

TCP connected sockets do not need any remote addr
because the destination is fixed.
For this reason we can avoid sending the remote addr
along the peer-new dco call.

This change is important on Linux because the new 'ovpn'
kernel module is stricter when it comes to accepting
netlink messages and will reject calls with TCP sockets
if a remote address is specified.

Change-Id: I76e2e616c6ffe436a9627fa71aaace74030b2f4a
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250309153017.5163-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
078.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
1 file changed, 3 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 02fae81..973c848 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -515,8 +515,9 @@
         c->c2.tls_multi->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
-                           c->c2.link_sockets[0]->sd, NULL, remoteaddr, NU=
LL, NULL);
+    int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->peer_id, sock->sd,=
 NULL,
+                           proto_is_dgram(sock->info.proto) ? remoteaddr :=
 NULL,
+                           NULL, NULL);
     if (ret < 0)
     {
         return ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76e2e616c6ffe436a9627fa71aaace74030b2f4a
Gerrit-Change-Number: 842
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--6rOJNdxScqw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/842?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco: pass remoteaddr only for UDP peers<br><br=
>TCP connected sockets do not need any remote addr<br>because the destinati=
on is fixed.<br>For this reason we can avoid sending the remote addr<br>alo=
ng the peer-new dco call.<br><br>This change is important on Linux because =
the new &#39;ovpn&#39;<br>kernel module is stricter when it comes to accept=
ing<br>netlink messages and will reject calls with TCP sockets<br>if a remo=
te address is specified.<br><br>Change-Id: I76e2e616c6ffe436a9627fa71aaace7=
4030b2f4a<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250309=
153017.5163-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg31078.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.c<br>1 file changed, =
3 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 02fae81..973c848 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -515,8 +515,9 @@</span><br=
><span>         c-&gt;c2.tls_multi-&gt;dco_peer_id =3D -1;</span><br><span>=
     }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&=
gt;peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                 c-&gt;c2.link_sockets[0]-&gt;sd, NULL, remoteaddr, NULL, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;=
sd, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                 proto_is_dgram(sock-&gt;info.proto) ? remoteaddr : NULL,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
      NULL, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>   =
  {</span><br><span>         return ret;</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=
=3Demail">change 842</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76e2e616c6ffe436a9627fa71aa=
ace74030b2f4a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 842 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--6rOJNdxScqw=--

