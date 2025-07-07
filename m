From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 7 Jul 2025 15:04:45 +0000
In-Reply-To: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
References: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <69921454734f14153639bc4e7ecd6f8f0ca4018e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C14eM25G46s="; charset=UTF-8
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

--C14eM25G46s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


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
1 file changed, 13 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1078/2

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 93e65e0..f62e0a3 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -216,16 +216,20 @@

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
+                    *floated =3D !link_socket_actual_match(&mi->context.c2=
.from, &m->top.c2.from);
+
+                    if (*floated)
+                    {
+                        /* reset prefix, since here we are not sure peer i=
s the one it claims to be */
+                        ungenerate_prefix(mi);
+                        msg(D_MULTI_MEDIUM, "Float requested for peer %" P=
RIu32 " to %s", peer_id,
+                            mroute_addr_print(&real, &gc));
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
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--C14eM25G46s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Multi-socket: Fix assert triggered by stale peer=
-id reuse<br><br>Fixed a bug where clients using different transport<br>pro=
tocols (UDP, TCP) could interfere with each other<br>after a server restart=
.<br>The issue occurred when a client reused a previously<br>assigned peer-=
id that was now associated with a<br>different client using a different tra=
nsport protocol.<br><br>For example, a UDP client could send packets with a=
<br>peer-id now assigned to a TCP client, which lacks<br>a valid context-&g=
t;c2.from which is filled by the<br>recvfrom(), causing an assert to be tri=
ggered.<br><br>A protocol check has been added to prevent packets<br>from d=
ifferent protocols from hijacking active<br>connections.<br><br>Github: #77=
3<br><br>Change-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a<br>Signed-off=
-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/open=
vpn/mudp.c<br>1 file changed, 13 insertions(+), 9 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1078/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>inde=
x 93e65e0..f62e0a3 100644</span><br><span>--- a/src/openvpn/mudp.c</span><b=
r><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -216,16 +216,20 @@</spa=
n><br><span> </span><br><span>             if (!peer_id_disabled &amp;&amp;=
 (peer_id &lt; m-&gt;max_clients) &amp;&amp; (m-&gt;instances[peer_id]))</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                mi =3D m-&gt;instances[peer_id];</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                *floated =3D !link_socket_actual_match(&amp;mi=
-&gt;context.c2.from, &amp;m-&gt;top.c2.from);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                if (*floated)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                /* Ensure that clients from previous sessions=
 do not attempt to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                * hijack instances of newly connected clients in multi-prot=
ocol scenarios */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              if (m-&gt;instances[peer_id]-&gt;context.c2.link_sockets[0]-&=
gt;info.proto =3D=3D sock-&gt;info.proto)</span><br><span>                 =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
/* reset prefix, since here we are not sure peer is the one it claims to be=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  ungenerate_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    msg(D_MULTI_MEDIUM, &quot;Float requested for peer %=
&quot; PRIu32 &quot; to %s&quot;, peer_id,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        mroute_addr_print(&amp;real, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          mi =3D m-&gt;instances[peer_id];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    *floated =3D !link_socket_actual=
_match(&amp;mi-&gt;context.c2.from, &amp;m-&gt;top.c2.from);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    if (*floated)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        /* reset pref=
ix, since here we are not sure peer is the one it claims to be */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        ungen=
erate_prefix(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      msg(D_MULTI_MEDIUM, &quot;Float requested for peer %&=
quot; PRIu32 &quot; to %s&quot;, peer_id,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            mroute_addr_print(&amp;re=
al, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               }</span><br><span>                 }</span><br><span>       =
      }</span><br><span>         }</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demai=
l">change 1078</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecbbcf32c0059f2b16a05333b37=
94599060d7d6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1078 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--C14eM25G46s=--

