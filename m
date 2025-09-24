From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 09:30:20 +0000
References: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <72500ceaa163b4e9eef41a98c08683b33879f62a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+H7X6nZZ0Rw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: redirect-gateway:
 Only redirect traffic through TUN if address famili...
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

--+H7X6nZZ0Rw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail

to review the following change.


Change subject: redirect-gateway: Only redirect traffic through TUN if addr=
ess families match
......................................................................

redirect-gateway: Only redirect traffic through TUN if address families mat=
ch

Fixes an ifconfig push-reply bug where, if the remote is switched and the n=
ew
TUN has a different address family, the previous ifconfig options remain
assigned to the new TUN.

Adds a check in do_init_route_ipv6_list() to add default routes toward the =
TUN
only if the TUN has IPv6 addresses.

Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
---
M src/openvpn/init.c
M src/openvpn/options.c
2 files changed, 6 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1210/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0d7a2ec..a5be243 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1518,7 +1518,7 @@

     /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
      */
-    if (options->routes_ipv6->flags & RG_REROUTE_GW)
+    if (options->routes_ipv6->flags & RG_REROUTE_GW && options->ifconfig_i=
pv6_local)
     {
         char *opt_list[] =3D { "::/3", "2000::/4", "3000::/4", "fc00::/7",=
 NULL };
         int i;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 151a016..5972cb9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5464,6 +5464,11 @@
     const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;
     unsigned int update_options_found =3D 0;

+    options->ifconfig_local =3D NULL;
+    options->ifconfig_remote_netmask =3D NULL;
+    options->ifconfig_ipv6_local =3D NULL;
+    options->ifconfig_ipv6_netbits =3D 0;
+    options->ifconfig_ipv6_remote =3D NULL;
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
         char *p[MAX_PARMS + 1];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Gerrit-Change-Number: 1210
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--+H7X6nZZ0Rw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">redirect-gateway: Only redirect traffic through TUN if addre=
ss families match<br><br>Fixes an ifconfig push-reply bug where, if the rem=
ote is switched and the new<br>TUN has a different address family, the prev=
ious ifconfig options remain<br>assigned to the new TUN.<br><br>Adds a chec=
k in do_init_route_ipv6_list() to add default routes toward the TUN<br>only=
 if the TUN has IPv6 addresses.<br><br>Change-Id: Ib3458a9ed2eb38e00184c4a9=
2659b83b97fe476c<br>---<br>M src/openvpn/init.c<br>M src/openvpn/options.c<=
br>2 files changed, 6 insertions(+), 1 deletion(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/10/1210/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 0d7a2ec=
..a5be243 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+=
++ b/src/openvpn/init.c</span><br><span>@@ -1518,7 +1518,7 @@</span><br><sp=
an> </span><br><span>     /* redirect (IPv6) gateway to VPN?  if yes, add a=
 few more specifics</span><br><span>      */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (options-&gt;routes_ipv6-&gt;flags &amp; RG_R=
EROUTE_GW)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o=
ptions-&gt;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW &amp;&amp; options-&gt=
;ifconfig_ipv6_local)</span><br><span>     {</span><br><span>         char =
*opt_list[] =3D { &quot;::/3&quot;, &quot;2000::/4&quot;, &quot;3000::/4&qu=
ot;, &quot;fc00::/7&quot;, NULL };</span><br><span>         int i;</span><b=
r><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><b=
r><span>index 151a016..5972cb9 100644</span><br><span>--- a/src/openvpn/opt=
ions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5464=
,6 +5464,11 @@</span><br><span>     const msglvl_t msglevel =3D D_PUSH_ERRO=
RS | M_OPTERR;</span><br><span>     unsigned int update_options_found =3D 0=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    options-&gt;ifconfig_local =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    options-&gt;ifconfig_remote_netmask =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    options-&gt;ifconfig=
_ipv6_local =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    options-&gt;ifconfig_ipv6_netbits =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    options-&gt;ifconfig_ipv6_remote =3D NULL;</=
span><br><span>     while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))=
</span><br><span>     {</span><br><span>         char *p[MAX_PARMS + 1];</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1210?usp=3Demail">change 1210</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1210?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a9265=
9b83b97fe476c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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


--+H7X6nZZ0Rw=--

