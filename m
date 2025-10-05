From: "mrbff (Code Review)" <gerrit@...515...>
Date: Sun, 5 Oct 2025 18:59:40 +0000
In-Reply-To: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
References: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <e7a94a504e12b778f8785044d05a601ae0c0a646-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cGvo7gKtUXw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: redirect-gateway:
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

--cGvo7gKtUXw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail

to look at the new patch set (#2).


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
2 files changed, 13 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1210/2

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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f35738d..185233f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5470,6 +5470,18 @@
     const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;
     unsigned int update_options_found =3D 0;

+    /* When receiving a PUSH_REPLY, reset the ifconfig options to prevent
+     * stale data conflicts. This could be necessary when the new address =
has a
+     * different address family than the previous one. */
+    if (!is_update)
+    {
+        options->ifconfig_local =3D NULL;
+        options->ifconfig_remote_netmask =3D NULL;
+        options->ifconfig_ipv6_local =3D NULL;
+        options->ifconfig_ipv6_netbits =3D 0;
+        options->ifconfig_ipv6_remote =3D NULL;
+    }
+
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
         char *p[MAX_PARMS + 1];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Gerrit-Change-Number: 1210
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--cGvo7gKtUXw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">redirect-gateway: Only redirect traffic through TUN if =
address families match<br><br>Fixes an ifconfig push-reply bug where, if th=
e remote is switched and the new<br>TUN has a different address family, the=
 previous ifconfig options remain<br>assigned to the new TUN.<br><br>Adds a=
 check in do_init_route_ipv6_list() to add default routes toward the TUN<br=
>only if the TUN has IPv6 addresses.<br><br>Change-Id: Ib3458a9ed2eb38e0018=
4c4a92659b83b97fe476c<br>---<br>M src/openvpn/init.c<br>M src/openvpn/optio=
ns.c<br>2 files changed, 13 insertions(+), 1 deletion(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/12=
10/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br=
><span>index f8a0fee..aaa0573 100644</span><br><span>--- a/src/openvpn/init=
.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1523,7 +152=
3,7 @@</span><br><span> </span><br><span>     /* redirect (IPv6) gateway to=
 VPN?  if yes, add a few more specifics</span><br><span>      */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;routes_ipv6-=
&gt;flags &amp; RG_REROUTE_GW)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (options-&gt;routes_ipv6-&gt;flags &amp; RG_REROUTE_GW &a=
mp;&amp; options-&gt;ifconfig_ipv6_local)</span><br><span>     {</span><br>=
<span>         char *opt_list[] =3D { &quot;::/3&quot;, &quot;2000::/4&quot=
;, &quot;3000::/4&quot;, &quot;fc00::/7&quot;, NULL };</span><br><span>    =
     int i;</span><br><span>diff --git a/src/openvpn/options.c b/src/openvp=
n/options.c</span><br><span>index f35738d..185233f 100644</span><br><span>-=
-- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</spa=
n><br><span>@@ -5470,6 +5470,18 @@</span><br><span>     const msglvl_t msgl=
evel =3D D_PUSH_ERRORS | M_OPTERR;</span><br><span>     unsigned int update=
_options_found =3D 0;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* When receiving a PUSH_REPLY, reset the ifconfig =
options to prevent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * stale data conflicts. This could be necessary when the new address ha=
s a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * different=
 address family than the previous one. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!is_update)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        options-&gt;ifconfig_local =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ifconfig_remote_netma=
sk =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 options-&gt;ifconfig_ipv6_local =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        options-&gt;ifconfig_ipv6_netbits =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ifc=
onfig_ipv6_remote =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))</sp=
an><br><span>     {</span><br><span>         char *p[MAX_PARMS + 1];</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1210?usp=3Demail">change 1210</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1210?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a9265=
9b83b97fe476c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--cGvo7gKtUXw=--

