From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 19 Feb 2024 12:46:00 +0000
In-Reply-To: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
References: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5e8608f0a84866168dc58c3a0f31465ee8de45d8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sObA0GxJEcM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sObA0GxJEcM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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

Fixes: Trac #1457
Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/route.c
1 file changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/522/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--sObA0GxJEcM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">Route: remove in=
correct routes on exit<br><br>Implemented a safeguard to verify the returne=
d value<br>from add_route3() when the default gateway is not a local<br>rem=
ote host.<br><br>Prior to this implementation, RT_DID_LOCAL flag was<br>err=
oneously set even in case of add_route3() failure.<br>This problem typicall=
y occurs when there&#39;s no default<br>route and the --redirect-gateway de=
f1 option is specified,<br>and in case of reconnection makes it impossible =
for the client<br>to reobtain the route to the server.<br>This fix ensures =
OpenVPN accurately deletes the appropriate<br>route on exit by properly han=
dling add_route3() return value.<br><br>Fixes: Trac #1457<br>Change-Id: I8a=
67b82eb4afdc8d82c5a879c18457b41e77cbe7<br>Signed-off-by: Gianmarco De Grego=
ri &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/route.c<br>1 file c=
hanged, 4 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/22/522/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/route.c b/src/openvpn/route.c</span><br><span>index 6c027d9..6ab4392 1006=
44</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/open=
vpn/route.c</span><br><span>@@ -1055,7 +1055,10 @@</span><br><span>        =
             ret =3D add_route3(rl-&gt;spec.remote_host, IPV4_NETMASK_HOST,=
</span><br><span>                                      rl-&gt;rgi.gateway.a=
ddr, tt, flags | ROUTE_REF_GW,</span><br><span>                            =
          &amp;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    rl-&gt;iflags |=3D RL_DID_LOCAL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (ret=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        rl-&gt;iflags |=3D RL_DID_LOCAL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    }</span><br><span>                =
 }</span><br><span>                 else</span><br><span>                 {=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/522?usp=3Demail">change 522</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/522?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a67b82eb4afdc8d82c5a879c18=
457b41e77cbe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 522 </div>
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


--sObA0GxJEcM=--

