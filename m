From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 14:05:10 +0000
In-Reply-To: <gerrit.1721311407000.Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1@...2715...>
References: <gerrit.1721311407000.Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <506961227184184e72aebdcc3f729f1fccfe9ba7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5Te1HHLAjdc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: copied
 'gateway_needed' logic from add_route_ipv6 to add_route
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

--5Te1HHLAjdc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail

to look at the new patch set (#12).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


Change subject: route: copied 'gateway_needed' logic from add_route_ipv6 to=
 add_route
......................................................................

route: copied 'gateway_needed' logic from add_route_ipv6 to add_route

Under certain circumstances it may not be necessary to pass the
gateway when adding a new route via net_route_v4_add() API function.
add_route_ipv6() already accounts for some of these cases and
therefore this patch copies the same logic to add_route().

Change-Id: Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1
Signed-off-by: Marco Baffo <marco@...2726...>
---
M Changes.rst
M src/openvpn/route.c
2 files changed, 51 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/677/12

diff --git a/Changes.rst b/Changes.rst
index 4feacad2..a3e00c2 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -170,6 +170,13 @@
 COPYING: license details only relevant to our Windows installers have
    been updated and moved to the openvpn-build repo

+The route gateway is now only added for IPv4 when strictly necessary.
+  The gateway-needed logic previously applied to IPv6 only has been copied
+  and extended to IPv4 route handling.  Route additions now omit the
+  gateway unless required after checking device type, special routes,
+  on-link gateways, and whether the gateway lies inside the VPN subnet,
+  optimizing route configuration and potentially reducing redundant route
+  entries.

 Deprecated features
 -------------------
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7d988da..c249b38 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1479,6 +1479,7 @@
 {
     int status =3D 0;
     int is_local_route;
+    bool gateway_needed =3D false;

     if (!(r->flags & RT_DEFINED))
     {
@@ -1488,8 +1489,8 @@
     struct argv argv =3D argv_new();
     struct gc_arena gc =3D gc_new();

-#if !defined(TARGET_LINUX)
     const char *network =3D print_in_addr_t(r->network, 0, &gc);
+#if !defined(TARGET_LINUX)
 #if !defined(TARGET_AIX)
     const char *netmask =3D print_in_addr_t(r->netmask, 0, &gc);
 #endif
@@ -1502,8 +1503,47 @@
         goto done;
     }
=20
+#ifndef _WIN32
+    /* server told us which interface to use; pass gateway if it gave one =
*/
+    if (rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi->iface[0] !=3D 0)
+    {
+        if (rgi->flags & RGI_ADDR_DEFINED && r->gateway !=3D 0)
+        {
+            gateway_needed =3D true;
+        }
+    }
+#endif
+
+    /* TAP is an L2 device, so for destinations that are not explicitly
+     * on-link the kernel needs a gateway so it can ARP/ND for the
+     * MAC address. We make an exception only when the user explicitly sets
+     * metric 0, which is taken as a request for an on-link =E2=80=9Croute=
 to
+     * interface=E2=80=9D (no gateway). This keeps parity with the IPv6 co=
de.
+     */
+    if (tt->type =3D=3D DEV_TYPE_TAP
+        && !((r->flags & RT_METRIC_DEFINED) && r->metric =3D=3D 0))
+    {
+        gateway_needed =3D true;
+    }
+
+    if (gateway_needed && r->gateway =3D=3D 0)
+    {
+        msg(M_WARN, "ROUTE WARNING: " PACKAGE_NAME " needs a gateway "
+                    "parameter for a --route option and no default was set=
 via "
+                    "--route-gateway or --ifconfig option. Not installing "
+                    "IPv4 route to %s/%d.",
+            network, netmask_to_netbits2(r->netmask));
+        status =3D 0;
+        goto done;
+    }
+
 #if defined(TARGET_LINUX)
-    const char *iface =3D NULL;
+    const char *iface =3D tt->actual_name;
+    if (!gateway_needed && rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi-=
>iface[0] !=3D 0) /* vpn server special route */
+    {
+        iface =3D rgi->iface;
+    }
+
     int metric =3D -1;

     if (is_on_link(is_local_route, flags, rgi))
@@ -1518,7 +1558,8 @@


     status =3D RTA_SUCCESS;
-    int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask), &r->gateway,
+    int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask),
+                               gateway_needed ? &r->gateway : NULL,
                                iface, r->table_id, metric);
     if (ret =3D=3D -EEXIST)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1
Gerrit-Change-Number: 677
Gerrit-PatchSet: 12
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>

--5Te1HHLAjdc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, mrbff, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #12</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">route: copied &#39;gateway_need=
ed&#39; logic from add_route_ipv6 to add_route<br><br>Under certain circums=
tances it may not be necessary to pass the<br>gateway when adding a new rou=
te via net_route_v4_add() API function.<br>add_route_ipv6() already account=
s for some of these cases and<br>therefore this patch copies the same logic=
 to add_route().<br><br>Change-Id: Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d=
1<br>Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M Change=
s.rst<br>M src/openvpn/route.c<br>2 files changed, 51 insertions(+), 3 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/77/677/12</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.=
rst</span><br><span>index 4feacad2..a3e00c2 100644</span><br><span>--- a/Ch=
anges.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -170,6 +170,=
13 @@</span><br><span> COPYING: license details only relevant to our Window=
s installers have</span><br><span>    been updated and moved to the openvpn=
-build repo</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+The route gateway is now only added for IPv4 when strictly necess=
ary.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The gateway-n=
eeded logic previously applied to IPv6 only has been copied</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  and extended to IPv4 route handli=
ng.  Route additions now omit the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  gateway unless required after checking device type, special=
 routes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  on-link g=
ateways, and whether the gateway lies inside the VPN subnet,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  optimizing route configuration a=
nd potentially reducing redundant route</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  entries.</span><br><span> </span><br><span> Deprecate=
d features</span><br><span> -------------------</span><br><span>diff --git =
a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 7d988da..=
c249b38 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>++=
+ b/src/openvpn/route.c</span><br><span>@@ -1479,6 +1479,7 @@</span><br><sp=
an> {</span><br><span>     int status =3D 0;</span><br><span>     int is_lo=
cal_route;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
gateway_needed =3D false;</span><br><span> </span><br><span>     if (!(r-&g=
t;flags &amp; RT_DEFINED))</span><br><span>     {</span><br><span>@@ -1488,=
8 +1489,8 @@</span><br><span>     struct argv argv =3D argv_new();</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span>=
<br><span>     const char *network =3D print_in_addr_t(r-&gt;network, 0, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined=
(TARGET_LINUX)</span><br><span> #if !defined(TARGET_AIX)</span><br><span>  =
   const char *netmask =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</spa=
n><br><span> #endif</span><br><span>@@ -1502,8 +1503,47 @@</span><br><span>=
         goto done;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* server told us which interface t=
o use; pass gateway if it gave one */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEF=
INED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (rgi-&gt;flags &amp; RGI_ADDR_DEFINED &amp;&amp; r-&gt;g=
ateway !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gat=
eway_needed =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* TAP is an L2 device, so for destinations that a=
re not explicitly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * on-link the kernel needs a gateway so it can ARP/ND for the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * MAC address. We make an=
 exception only when the user explicitly sets</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * metric 0, which is taken as a request for =
an on-link =E2=80=9Croute to</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * interface=E2=80=9D (no gateway). This keeps parity with the=
 IPv6 code.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;type =
=3D=3D DEV_TYPE_TAP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &amp;&amp; !((r-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r-&gt=
;metric =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gateway=
_needed =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (gateway_needed &amp;&amp; r=
-&gt;gateway =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_WARN, &quot;ROUTE WARNING: &quot; PACKAGE_NAME &quot; needs a gateway &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     &quot;parameter for a --route option and no default was set via &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 &quot;--route-gateway or --ifconfig option. Not installing &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;IP=
v4 route to %s/%d.&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            network, netmask_to_netbits2(r-&gt;netmask));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        status =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_LINUX)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *iface =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *iface =3D tt-&gt;actual_name;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!gateway_needed &amp;&amp; rgi &amp;&amp; (rgi-&gt;=
flags &amp; RGI_IFACE_DEFINED) &amp;&amp; rgi-&gt;iface[0] !=3D 0) /* vpn s=
erver special route */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifa=
ce =3D rgi-&gt;iface;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     int metric =3D -1;</span><br><span> </span><br><span>     if (is_=
on_link(is_local_route, flags, rgi))</span><br><span>@@ -1518,7 +1558,8 @@<=
/span><br><span> </span><br><span> </span><br><span>     status =3D RTA_SUC=
CESS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D =
net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask=
), &amp;r-&gt;gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_net=
bits2(r-&gt;netmask),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                               gateway_needed ? &amp;r-&gt;gateway : NULL=
,</span><br><span>                                iface, r-&gt;table_id, me=
tric);</span><br><span>     if (ret =3D=3D -EEXIST)</span><br><span>     {<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/677?usp=3Demail">change 677</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/677?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id1ec0c6e4c391604ec5dbb8b712=
2f2e47ad186d1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 677 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>

</body></html>=

--5Te1HHLAjdc=--

