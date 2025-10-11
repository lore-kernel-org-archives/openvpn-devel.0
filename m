From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Oct 2025 11:49:11 +0000
In-Reply-To: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
References: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <97b81865ea07c259b56a051cad5e1d20318ffdd4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qbip6arGs3E="; charset=UTF-8
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
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qbip6arGs3E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
10?usp=3Demail )

Change subject: redirect-gateway: only redirect traffic through TUN if addr=
ess families match
......................................................................

redirect-gateway: only redirect traffic through TUN if address families mat=
ch

Adds a check in do_init_route_ipv6_list() to add default routes toward the =
TUN
only if the TUN has IPv6 addresses.

Github: fixes OpenVPN/openvpn#850
Github: see also OpenVPN/openvpn#863

Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Signed-off-by: mrbff <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1210
Message-Id: <20251011111417.11802-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59245295/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
1 file changed, 1 insertion(+), 1 deletion(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Gerrit-Change-Number: 1210
Gerrit-PatchSet: 5
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qbip6arGs3E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1210?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">redirect-gateway: only redirect traffic through =
TUN if address families match<br><br>Adds a check in do_init_route_ipv6_lis=
t() to add default routes toward the TUN<br>only if the TUN has IPv6 addres=
ses.<br><br>Github: fixes OpenVPN/openvpn#850<br>Github: see also OpenVPN/o=
penvpn#863<br><br>Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c<br>S=
igned-off-by: mrbff &lt;marco@...2726...&gt;<br>Acked-by: Gert Doering &lt;=
gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1=
210<br>Message-Id: &lt;20251011111417.11802-1-gert@...1296...&gt;<br>URL: h=
ttps://sourceforge.net/p/openvpn/mailman/message/59245295/<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/init.c<br>1 =
file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex f8a0fee..aaa0573 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1523,7 +1523,7 @@</sp=
an><br><span> </span><br><span>     /* redirect (IPv6) gateway to VPN?  if =
yes, add a few more specifics</span><br><span>      */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;routes_ipv6-&gt;flags =
&amp; RG_REROUTE_GW)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (options-&gt;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW &amp;&amp; o=
ptions-&gt;ifconfig_ipv6_local)</span><br><span>     {</span><br><span>    =
     char *opt_list[] =3D { &quot;::/3&quot;, &quot;2000::/4&quot;, &quot;3=
000::/4&quot;, &quot;fc00::/7&quot;, NULL };</span><br><span>         int i=
;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1210?usp=3Demail">change 1210</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1210?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a9265=
9b83b97fe476c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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

</body></html>=

--qbip6arGs3E=--

