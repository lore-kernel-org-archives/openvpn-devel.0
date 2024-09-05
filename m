From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 5 Sep 2024 13:18:42 +0000
In-Reply-To: <gerrit.1721311407000.Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1@...2715...>
References: <gerrit.1721311407000.Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <23e55ac7226785333942ba5ac35448bdb1e8ea65-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cGbhOdG/ENc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: copied
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

--cGbhOdG/ENc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail

to look at the new patch set (#6).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
M src/openvpn/route.c
1 file changed, 40 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/677/6

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 91f2032..2033433 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1571,6 +1571,7 @@
 {
     int status =3D 0;
     int is_local_route;
+    bool gateway_needed =3D false;

     if (!(r->flags & RT_DEFINED))
     {
@@ -1580,8 +1581,8 @@
     struct argv argv =3D argv_new();
     struct gc_arena gc =3D gc_new();

-#if !defined(TARGET_LINUX)
     const char *network =3D print_in_addr_t(r->network, 0, &gc);
+#if !defined(TARGET_LINUX)
 #if !defined(TARGET_AIX)
     const char *netmask =3D print_in_addr_t(r->netmask, 0, &gc);
 #endif
@@ -1594,8 +1595,43 @@
         goto done;
     }

+#ifndef _WIN32
+
+    if (rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi->iface[0] !=3D 0)  =
/* vpn server special route */
+    {
+        if (rgi->flags & RGI_ADDR_DEFINED && r->gateway !=3D 0)
+        {
+            gateway_needed =3D true;
+        }
+    }
+
+#endif
+
+    if (tt->type =3D=3D DEV_TYPE_TAP
+        && !( (r->flags & RT_METRIC_DEFINED) && r->metric =3D=3D 0 ) )
+    {
+        gateway_needed =3D true;
+    }
+
+    if (gateway_needed && r->gateway =3D=3D 0)
+    {
+        msg(M_WARN, "ROUTE WARNING: " PACKAGE_NAME " needs a gateway "
+            "parameter for a --route option and no default was set via "
+            "--route-gateway or --ifconfig option. Not installing "
+            "IPv4 route to %s/%d.", network, netmask_to_netbits2(r->netmas=
k));
+        status =3D 0;
+        goto done;
+    }
+
 #if defined(TARGET_LINUX)
-    const char *iface =3D NULL;
+    const char *iface =3D tt->actual_name;
+    if (!gateway_needed && rgi && (rgi->flags & RGI_IFACE_DEFINED) && rgi-=
>iface[0] !=3D 0)  /* vpn server special route */
+    {
+        iface =3D rgi->iface;
+    }
+#endif
+
+#if defined(TARGET_LINUX)
     int metric =3D -1;

     if (is_on_link(is_local_route, flags, rgi))
@@ -1610,7 +1646,8 @@

     status =3D RTA_SUCCESS;
     int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask),
-                               &r->gateway, iface, 0, metric);
+                               gateway_needed ? &r->gateway : NULL,
+                               iface, 0, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command failed because route e=
xists");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1
Gerrit-Change-Number: 677
Gerrit-PatchSet: 6
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--cGbhOdG/ENc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #6</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">route: copied &#39;gateway_needed&#39; logic =
from add_route_ipv6 to add_route<br><br>Under certain circumstances it may =
not be necessary to pass the<br>gateway when adding a new route via net_rou=
te_v4_add() API function.<br>add_route_ipv6() already accounts for some of =
these cases and<br>therefore this patch copies the same logic to add_route(=
).<br><br>Change-Id: Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1<br>Signed-of=
f-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/route.c<=
br>1 file changed, 40 insertions(+), 3 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/77/677/6</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 91f2032.=
.2033433 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+=
++ b/src/openvpn/route.c</span><br><span>@@ -1571,6 +1571,7 @@</span><br><s=
pan> {</span><br><span>     int status =3D 0;</span><br><span>     int is_l=
ocal_route;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 gateway_needed =3D false;</span><br><span> </span><br><span>     if (!(r-&=
gt;flags &amp; RT_DEFINED))</span><br><span>     {</span><br><span>@@ -1580=
,8 +1581,8 @@</span><br><span>     struct argv argv =3D argv_new();</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(TARGET_LINUX)</span=
><br><span>     const char *network =3D print_in_addr_t(r-&gt;network, 0, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !define=
d(TARGET_LINUX)</span><br><span> #if !defined(TARGET_AIX)</span><br><span> =
    const char *netmask =3D print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</sp=
an><br><span> #endif</span><br><span>@@ -1594,8 +1595,43 @@</span><br><span=
>         goto done;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEF=
INED) &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server special route */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (rgi-&gt;flags &amp; RGI=
_ADDR_DEFINED &amp;&amp; r-&gt;gateway !=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            gateway_needed =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;type =3D=3D DEV_TYPE_TAP</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !(=
 (r-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r-&gt;metric =3D=3D 0 ) )=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        gateway_needed =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (gateway_needed &amp;&amp; r-&gt;gateway =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;R=
OUTE WARNING: &quot; PACKAGE_NAME &quot; needs a gateway &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &quot;parameter for=
 a --route option and no default was set via &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;--route-gateway or --if=
config option. Not installing &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;IPv4 route to %s/%d.&quot;, network, net=
mask_to_netbits2(r-&gt;netmask));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        status =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> #if defined(TARGET_LINUX)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const char *iface =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *iface =3D tt-&gt;actual_=
name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!gatew=
ay_needed &amp;&amp; rgi &amp;&amp; (rgi-&gt;flags &amp; RGI_IFACE_DEFINED)=
 &amp;&amp; rgi-&gt;iface[0] !=3D 0)  /* vpn server special route */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        iface =3D rgi-&gt;iface;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(TARGET_LINUX)</span><br><span>     int metric =3D -1;</span><=
br><span> </span><br><span>     if (is_on_link(is_local_route, flags, rgi))=
</span><br><span>@@ -1610,7 +1646,8 @@</span><br><span> </span><br><span>  =
   status =3D RTA_SUCCESS;</span><br><span>     int ret =3D net_route_v4_ad=
d(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask),</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                               &am=
p;r-&gt;gateway, iface, 0, metric);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                               gateway_needed ? &amp;r-&gt;=
gateway : NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                           iface, 0, metric);</span><br><span>     if (ret =
=3D=3D -EEXIST)</span><br><span>     {</span><br><span>         msg(D_ROUTE=
, &quot;NOTE: Linux route add command failed because route exists&quot;);</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/677?usp=3Demail">change 677</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/677?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id1ec0c6e4c391604ec5dbb8b712=
2f2e47ad186d1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 677 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--cGbhOdG/ENc=--

