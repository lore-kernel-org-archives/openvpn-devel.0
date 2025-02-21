From: "ordex (Code Review)" <gerrit@...515...>
Date: Fri, 21 Feb 2025 11:05:54 +0000
In-Reply-To: <gerrit.1734109769000.I76e2e616c6ffe436a9627fa71aaace74030b2f4a@...2715...>
References: <gerrit.1734109769000.I76e2e616c6ffe436a9627fa71aaace74030b2f4a@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <0148007e1ca25e4c1bf77853dca89ac358c0069d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JlH+rzPsti8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JlH+rzPsti8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, stipa.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by stipa, Code-Review-1 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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
---
M src/openvpn/dco.c
1 file changed, 3 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/842/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--JlH+rzPsti8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, s=
tipa. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa, Code-Review-1 by flichtenheld</p><p>The change is n=
o longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisfi=
ed now.</p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">dco: pass remoteaddr only for UDP peers<br><br>TCP connected socket=
s do not need any remote addr<br>because the destination is fixed.<br>For t=
his reason we can avoid sending the remote addr<br>along the peer-new dco c=
all.<br><br>This change is important on Linux because the new &#39;ovpn&#39=
;<br>kernel module is stricter when it comes to accepting<br>netlink messag=
es and will reject calls with TCP sockets<br>if a remote address is specifi=
ed.<br><br>Change-Id: I76e2e616c6ffe436a9627fa71aaace74030b2f4a<br>Signed-o=
ff-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn=
/dco.c<br>1 file changed, 3 insertions(+), 2 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/842/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 02fae8=
1..973c848 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+=
++ b/src/openvpn/dco.c</span><br><span>@@ -515,8 +515,9 @@</span><br><span>=
         c-&gt;c2.tls_multi-&gt;dco_peer_id =3D -1;</span><br><span>     }<=
/span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;peer=
_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
          c-&gt;c2.link_sockets[0]-&gt;sd, NULL, remoteaddr, NULL, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_n=
ew_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
        proto_is_dgram(sock-&gt;info.proto) ? remoteaddr : NULL,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           NUL=
L, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span=
><br><span>         return ret;</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail">c=
hange 842</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/842?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76e2e616c6ffe436a9627fa71aa=
ace74030b2f4a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 842 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JlH+rzPsti8=--

