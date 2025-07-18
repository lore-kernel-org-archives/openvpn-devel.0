From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 19:07:23 +0000
In-Reply-To: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
References: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8ef61666058cb1204cdb6e75bd4ee40b62013f8c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+9O5ircaL9w="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+9O5ircaL9w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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

Github: OpenVPN/openvpn#773

Change-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250718185559.4515-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
220.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mudp.c
1 file changed, 13 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1078/4

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 93e65e0..ee8446a 100644
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
+                /* Floating on TCP will never be possible, so ensure we on=
ly process
+                 * UDP clients */
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
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--+9O5ircaL9w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1078?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Multi-socket: Fix assert triggered by stale peer-id =
reuse<br><br>Fixed a bug where clients using different transport<br>protoco=
ls (UDP, TCP) could interfere with each other<br>after a server restart.<br=
>The issue occurred when a client reused a previously<br>assigned peer-id t=
hat was now associated with a<br>different client using a different transpo=
rt protocol.<br><br>For example, a UDP client could send packets with a<br>=
peer-id now assigned to a TCP client, which lacks<br>a valid context-&gt;c2=
.from which is filled by the<br>recvfrom(), causing an assert to be trigger=
ed.<br><br>A protocol check has been added to prevent packets<br>from diffe=
rent protocols from hijacking active<br>connections.<br><br>Github: OpenVPN=
/openvpn#773<br><br>Change-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a<br=
>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-=
by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250718185559.=
4515-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-dev=
el@lists.sourceforge.net/msg32220.html<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M src/openvpn/mudp.c<br>1 file changed, 13 ins=
ertions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/78/1078/4</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp.c b/=
src/openvpn/mudp.c</span><br><span>index 93e65e0..ee8446a 100644</span><br>=
<span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</sp=
an><br><span>@@ -216,16 +216,20 @@</span><br><span> </span><br><span>      =
       if (!peer_id_disabled &amp;&amp; (peer_id &lt; m-&gt;max_clients) &a=
mp;&amp; (m-&gt;instances[peer_id]))</span><br><span>             {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                mi =3D m-&gt;=
instances[peer_id];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                *floate=
d =3D !link_socket_actual_match(&amp;mi-&gt;context.c2.from, &amp;m-&gt;top=
.c2.from);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                if (*floated)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Flo=
ating on TCP will never be possible, so ensure we only process</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                 * UDP clients *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if=
 (m-&gt;instances[peer_id]-&gt;context.c2.link_sockets[0]-&gt;info.proto =
=3D=3D sock-&gt;info.proto)</span><br><span>                 {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    /* reset prefi=
x, since here we are not sure peer is the one it claims to be */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    ungenerate_p=
refix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         msg(D_MULTI_MEDIUM, &quot;Float requested for peer %&quot; PRIu32 =
&quot; to %s&quot;, peer_id,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        mroute_addr_print(&amp;real, &amp;gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mi =
=3D m-&gt;instances[peer_id];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    *floated =3D !link_socket_actual_match(&amp;m=
i-&gt;context.c2.from, &amp;m-&gt;top.c2.from);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    if (*floated)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        /* reset prefix, since her=
e we are not sure peer is the one it claims to be */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        ungenerate_prefix=
(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          msg(D_MULTI_MEDIUM, &quot;Float requested for peer %&quot; PRIu32=
 &quot; to %s&quot;, peer_id,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            mroute_addr_print(&amp;real, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   }</span><br><span>                 }</span><br><span>             }</spa=
n><br><span>         }</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail">change 10=
78</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecbbcf32c0059f2b16a05333b37=
94599060d7d6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1078 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+9O5ircaL9w=--

