From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 10:40:42 +0000
In-Reply-To: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
References: <gerrit.1707986932000.I8a67b82eb4afdc8d82c5a879c18457b41e77cbe7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <4cc89578cc616a5526fab920e0872fddae02549d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q2aXRdypZHc="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q2aXRdypZHc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/522?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/522/3

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
Gerrit-MessageType: newpatchset

--q2aXRdypZHc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
522?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Route: remove incorrect routes on exit<br><br=
>Implemented a safeguard to verify the returned value<br>from add_route3() =
when the default gateway is not a local<br>remote host.<br><br>Prior to thi=
s implementation, RT_DID_LOCAL flag was<br>erroneously set even in case of =
add_route3() failure.<br>This problem typically occurs when there&#39;s no =
default<br>route and the --redirect-gateway def1 option is specified,<br>an=
d in case of reconnection makes it impossible for the client<br>to reobtain=
 the route to the server.<br>This fix ensures OpenVPN accurately deletes th=
e appropriate<br>route on exit by properly handling add_route3() return val=
ue.<br><br>Trac: #1457<br>Change-Id: I8a67b82eb4afdc8d82c5a879c18457b41e77c=
be7<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>=
Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202=
40221111814.942965-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg28290.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file=
 changed, 4 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/22/522/3</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/route.c b/src/openvpn/route.c</span><br><span>index 91f2032..2e584c7 10=
0644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/op=
envpn/route.c</span><br><span>@@ -1060,7 +1060,10 @@</span><br><span>      =
               ret =3D add_route3(rl-&gt;spec.remote_host, IPV4_NETMASK_HOS=
T,</span><br><span>                                      rl-&gt;rgi.gateway=
.addr, tt, flags | ROUTE_REF_GW,</span><br><span>                          =
            &amp;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    rl-&gt;iflags |=3D RL_DID_LOCAL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (r=
et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          rl-&gt;iflags |=3D RL_DID_LOCAL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    }</span><br><span>              =
   }</span><br><span>                 else</span><br><span>                =
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/522?usp=3Demail">change 522</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/522?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--q2aXRdypZHc=--

