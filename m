From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 15 Feb 2024 08:48:55 +0000
References: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <06ebd3fab9ad0435f8b73ec15f89b60111da4228-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lpbM8W7Lnbs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Route: remove
 uncorrect routes on exit.
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

--lpbM8W7Lnbs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail

to review the following change.


Change subject: Route: remove uncorrect routes on exit.
......................................................................

Route: remove uncorrect routes on exit.

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

Fixes: Trac #1457
Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/route.c
1 file changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/522/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6c027d9..6ab4392 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1055,7 +1055,10 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--lpbM8W7Lnbs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Route: remove uncorrect routes on exit.<br><br>Implemented a =
safeguard to verify the returned value<br>from add_route3() when the defaul=
t gateway is not a local<br>remote host.<br><br>Prior to this implementatio=
n, RT_DID_LOCAL flag was<br>erroneously set even in case of add_route3() fa=
ilure.<br>This problem typically occurs when there&#39;s no default<br>rout=
e and the --redirect-gateway def1 option is specified,<br>and in case of re=
connection makes it impossible for the client<br>to reobtain the route to t=
he server.<br>This fix ensures OpenVPN accurately deletes the appropriate<b=
r>route on exit by properly handling add_route3() return value.<br><br>Fixe=
s: Trac #1457<br>Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7<br>Si=
gned-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M =
src/openvpn/route.c<br>1 file changed, 4 insertions(+), 1 deletion(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/522/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><s=
pan>index 6c027d9..6ab4392 100644</span><br><span>--- a/src/openvpn/route.c=
</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -1055,7 +1055=
,10 @@</span><br><span>                     ret =3D add_route3(rl-&gt;spec.=
remote_host, IPV4_NETMASK_HOST,</span><br><span>                           =
           rl-&gt;rgi.gateway.addr, tt, flags | ROUTE_REF_GW,</span><br><sp=
an>                                      &amp;rl-&gt;rgi, es, ctx);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    rl-&gt;if=
lags |=3D RL_DID_LOCAL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    if (ret)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        rl-&gt;iflags |=3D RL_DID_LOCAL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</=
span><br><span>                 }</span><br><span>                 else</sp=
an><br><span>                 {</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail">c=
hange 522</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a67b82eb4afdc8d82c5a879c18=
457b41e77cbe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 522 </div>
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


--lpbM8W7Lnbs=--

