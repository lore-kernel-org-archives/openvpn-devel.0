From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 7 Jul 2025 12:57:02 +0000
References: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <55bfa3dd6dfbbc01a29c8bb424751c64224056d8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2VJ9MFUKzQQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Multi-socket: Fix
 assert triggered by stale peer-id reuse
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

--2VJ9MFUKzQQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail

to review the following change.


Change subject: Multi-socket: Fix assert triggered by stale peer-id reuse
......................................................................

Multi-socket: Fix assert triggered by stale peer-id reuse

Fixed a bug where clients using different transport
protocols (UDP, TCP) could interfere with each other
after a server restart.
The issue occurred when a client reused a previously
assigned peer-id that was now associated with a
different client using a different transport protocol.

For example, a UDP client could send packets with a
peer-id now assigned to a TCP client, which lacks
a valid context->c2.from which is filled by the
recvfrom(), causing an assert to be triggered.

A protocol check has been added to prevent packets
from different protocols from hijacking active
connections.

Github: #773

Change-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/mudp.c
1 file changed, 17 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1078/1

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 93e65e0..c47ed16 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -216,16 +216,24 @@

             if (!peer_id_disabled && (peer_id < m->max_clients) && (m->ins=
tances[peer_id]))
             {
-                mi =3D m->instances[peer_id];
-
-                *floated =3D !link_socket_actual_match(&mi->context.c2.fro=
m, &m->top.c2.from);
-
-                if (*floated)
+                /* Ensure that clients from previous sessions do not attem=
pt to
+                 * hijack instances of newly connected clients in multi-pr=
otocol scenarios */
+                if (m->instances[peer_id]->context.c2.link_sockets[0]->inf=
o.proto =3D=3D sock->info.proto)
                 {
-                    /* reset prefix, since here we are not sure peer is th=
e one it claims to be */
-                    ungenerate_prefix(mi);
-                    msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu3=
2 " to %s", peer_id,
-                        mroute_addr_print(&real, &gc));
+                    mi =3D m->instances[peer_id];
+
+                    if (mi)
+                    {
+                        *floated =3D !link_socket_actual_match(&mi->contex=
t.c2.from, &m->top.c2.from);
+
+                        if (*floated)
+                        {
+                            /* reset prefix, since here we are not sure pe=
er is the one it claims to be */
+                            ungenerate_prefix(mi);
+                            msg(D_MULTI_MEDIUM, "Float requested for peer =
%" PRIu32 " to %s", peer_id,
+                                mroute_addr_print(&real, &gc));
+                        }
+                    }
                 }
             }
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a
Gerrit-Change-Number: 1078
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--2VJ9MFUKzQQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Multi-socket: Fix assert triggered by stale peer-id reuse<br=
><br>Fixed a bug where clients using different transport<br>protocols (UDP,=
 TCP) could interfere with each other<br>after a server restart.<br>The iss=
ue occurred when a client reused a previously<br>assigned peer-id that was =
now associated with a<br>different client using a different transport proto=
col.<br><br>For example, a UDP client could send packets with a<br>peer-id =
now assigned to a TCP client, which lacks<br>a valid context-&gt;c2.from wh=
ich is filled by the<br>recvfrom(), causing an assert to be triggered.<br><=
br>A protocol check has been added to prevent packets<br>from different pro=
tocols from hijacking active<br>connections.<br><br>Github: #773<br><br>Cha=
nge-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a<br>Signed-off-by: Gianmar=
co De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/mudp.c<b=
r>1 file changed, 17 insertions(+), 9 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/78/1078/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 93e65e0=
..c47ed16 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+=
++ b/src/openvpn/mudp.c</span><br><span>@@ -216,16 +216,24 @@</span><br><sp=
an> </span><br><span>             if (!peer_id_disabled &amp;&amp; (peer_id=
 &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</span><br><=
span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              mi =3D m-&gt;instances[peer_id];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                *floated =3D !link_socket_actual_match(&amp;mi-&gt;cont=
ext.c2.from, &amp;m-&gt;top.c2.from);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           if (*floated)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                /* Ensure that clients from previous sessions do not a=
ttempt to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
       * hijack instances of newly connected clients in multi-protocol scen=
arios */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     if (m-&gt;instances[peer_id]-&gt;context.c2.link_sockets[0]-&gt;info.p=
roto =3D=3D sock-&gt;info.proto)</span><br><span>                 {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* reset =
prefix, since here we are not sure peer is the one it claims to be */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ungener=
ate_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              msg(D_MULTI_MEDIUM, &quot;Float requested for peer %&quot; PR=
Iu32 &quot; to %s&quot;, peer_id,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        mroute_addr_print(&amp;real, &amp;gc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 mi =3D m-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        *floated =3D !link_socket_actual_match(&amp;mi=
-&gt;context.c2.from, &amp;m-&gt;top.c2.from);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        if (*floated)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            /* reset pref=
ix, since here we are not sure peer is the one it claims to be */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                            u=
ngenerate_prefix(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            msg(D_MULTI_MEDIUM, &quot;Float requested for=
 peer %&quot; PRIu32 &quot; to %s&quot;, peer_id,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                mroute_addr_p=
rint(&amp;real, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    }</span><br><span>                 }</span=
><br><span>             }</span><br><span>         }</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1078?usp=3Demail">change 1078</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecbbcf32c0059f2b16a05333b37=
94599060d7d6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1078 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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


--2VJ9MFUKzQQ=--

