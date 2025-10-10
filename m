From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 15:44:13 +0000
In-Reply-To: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
References: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <612d5a2eb903b7d8821d363d419a7caf91639c24-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z4a8V5WtYME="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: redirect-gateway:
 only redirect traffic through TUN if address famili...
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

--Z4a8V5WtYME=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail

to look at the new patch set (#4).


Change subject: redirect-gateway: only redirect traffic through TUN if addr=
ess families match
......................................................................

redirect-gateway: only redirect traffic through TUN if address families mat=
ch

Adds a check in do_init_route_ipv6_list() to add default routes toward the =
TUN
only if the TUN has IPv6 addresses.

Github: fixes OpenVPN/openvpn#850
github.com/OpenVPN/openvpn/issues/850

Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
---
M src/openvpn/init.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1210/4

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8a0fee..aaa0573 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1523,7 +1523,7 @@

     /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
      */
-    if (options->routes_ipv6->flags & RG_REROUTE_GW)
+    if (options->routes_ipv6->flags & RG_REROUTE_GW && options->ifconfig_i=
pv6_local)
     {
         char *opt_list[] =3D { "::/3", "2000::/4", "3000::/4", "fc00::/7",=
 NULL };
         int i;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Gerrit-Change-Number: 1210
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>

--Z4a8V5WtYME=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">redirect-gateway: only redirect traffic through TUN if =
address families match<br><br>Adds a check in do_init_route_ipv6_list() to =
add default routes toward the TUN<br>only if the TUN has IPv6 addresses.<br=
><br>Github: fixes OpenVPN/openvpn#850<br>github.com/OpenVPN/openvpn/issues=
/850<br><br>Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c<br>---<br>=
M src/openvpn/init.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/10/1210/4</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/ini=
t.c</span><br><span>index f8a0fee..aaa0573 100644</span><br><span>--- a/src=
/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@=
 -1523,7 +1523,7 @@</span><br><span> </span><br><span>     /* redirect (IPv=
6) gateway to VPN?  if yes, add a few more specifics</span><br><span>      =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt=
;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (options-&gt;routes_ipv6-&gt;flags &amp; RG_=
REROUTE_GW &amp;&amp; options-&gt;ifconfig_ipv6_local)</span><br><span>    =
 {</span><br><span>         char *opt_list[] =3D { &quot;::/3&quot;, &quot;=
2000::/4&quot;, &quot;3000::/4&quot;, &quot;fc00::/7&quot;, NULL };</span><=
br><span>         int i;</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail">change =
1210</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a9265=
9b83b97fe476c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--Z4a8V5WtYME=--

