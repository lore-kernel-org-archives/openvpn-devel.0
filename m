From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 10:40:44 +0000
In-Reply-To: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
References: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <4cc89578cc616a5526fab920e0872fddae02549d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x4wtGYqZRyU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Route: remove
 incorrect routes on exit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x4wtGYqZRyU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/52=
2?usp=3Demail )

Change subject: Route: remove incorrect routes on exit
......................................................................

Route: remove incorrect routes on exit

Implemented a safeguard to verify the returned value
from add_route3() when the default gateway is not a local
remote host.

Prior to this implementation, RT_DID_LOCAL flag was
erroneously set even in case of add_route3() failure.
This problem typically occurs when there's no default
route and the --redirect-gateway def1 option is specified,
and in case of reconnection makes it impossible for the client
to reobtain the route to the server.
This fix ensures OpenVPN accurately deletes the appropriate
route on exit by properly handling add_route3() return value.

Trac: #1457
Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240221111814.942965-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
290.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 4 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 91f2032..2e584c7 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1060,7 +1060,10 @@
                     ret =3D add_route3(rl->spec.remote_host, IPV4_NETMASK_=
HOST,
                                      rl->rgi.gateway.addr, tt, flags | ROU=
TE_REF_GW,
                                      &rl->rgi, es, ctx);
-                    rl->iflags |=3D RL_DID_LOCAL;
+                    if (ret)
+                    {
+                        rl->iflags |=3D RL_DID_LOCAL;
+                    }
                 }
                 else
                 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7
Gerrit-Change-Number: 522
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--x4wtGYqZRyU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/522?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Route: remove incorrect routes on exit<br><br>=
Implemented a safeguard to verify the returned value<br>from add_route3() w=
hen the default gateway is not a local<br>remote host.<br><br>Prior to this=
 implementation, RT_DID_LOCAL flag was<br>erroneously set even in case of a=
dd_route3() failure.<br>This problem typically occurs when there&#39;s no d=
efault<br>route and the --redirect-gateway def1 option is specified,<br>and=
 in case of reconnection makes it impossible for the client<br>to reobtain =
the route to the server.<br>This fix ensures OpenVPN accurately deletes the=
 appropriate<br>route on exit by properly handling add_route3() return valu=
e.<br><br>Trac: #1457<br>Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77cb=
e7<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>A=
cked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;2024=
0221111814.942965-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg28290.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file =
changed, 4 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex 91f2032..2e584c7 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -1060,7 +1060,10 @=
@</span><br><span>                     ret =3D add_route3(rl-&gt;spec.remot=
e_host, IPV4_NETMASK_HOST,</span><br><span>                                =
      rl-&gt;rgi.gateway.addr, tt, flags | ROUTE_REF_GW,</span><br><span>  =
                                    &amp;rl-&gt;rgi, es, ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    rl-&gt;iflags =
|=3D RL_DID_LOCAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   if (ret)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        rl-&gt;iflags |=3D RL_DID_LOCAL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    }</span>=
<br><span>                 }</span><br><span>                 else</span><b=
r><span>                 {</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail">change=
 522</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a67b82eb4afdc8d82c5a879c18=
457b41e77cbe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 522 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--x4wtGYqZRyU=--

