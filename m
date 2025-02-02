From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 2 Feb 2025 09:49:17 +0000
In-Reply-To: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
References: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <00b9a432e2dde534781867b8a59aa51e87380c23-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GnzfMuRSHdQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi.c: add iroutes
 after dco peer is added
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GnzfMuRSHdQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/85=
6?usp=3Demail )

Change subject: multi.c: add iroutes after dco peer is added
......................................................................

multi.c: add iroutes after dco peer is added

This doesn't matter for Linux and FreeBSD but matters
for dco-win, where iroute subnet is mapped to a peer
context, which means that peer has to be created before
iroute is added.

Change-Id: I1cac0f036504c87205a3c97589a94a662cf79b99
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250201121102.27395-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
780.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 29 insertions(+), 24 deletions(-)




diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b0e1941..96fa6cd 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2442,6 +2442,35 @@
             ifconfig_constraint_network, ifconfig_constraint_netmask);
     }

+    /* set our client's VPN endpoint for status reporting purposes */
+    mi->reporting_addr =3D mi->context.c2.push_ifconfig_local;
+    mi->reporting_addr_ipv6 =3D mi->context.c2.push_ifconfig_ipv6_local;
+
+    /* set context-level authentication flag */
+    mi->context.c2.tls_multi->multi_state =3D CAS_CONNECT_DONE;
+
+    /* Since dco-win maintains iroute routing table (subnet -> peer),
+     * peer must be added before iroutes. For other platforms it doesn't m=
atter. */
+
+    /* authentication complete, calculate dynamic client specific options =
*/
+    if (!multi_client_set_protocol_options(&mi->context))
+    {
+        mi->context.c2.tls_multi->multi_state =3D CAS_FAILED;
+    }
+    /* only continue if setting protocol options worked */
+    else if (!multi_client_setup_dco_initial(m, mi, &gc))
+    {
+        mi->context.c2.tls_multi->multi_state =3D CAS_FAILED;
+    }
+    /* Generate data channel keys only if setting protocol options
+     * and DCO initial setup has not failed */
+    else if (!multi_client_generate_tls_keys(&mi->context))
+    {
+        mi->context.c2.tls_multi->multi_state =3D CAS_FAILED;
+    }
+
+    /* dco peer has been added, it is now safe for Windows to add iroutes =
*/
+
     /*
      * For routed tunnels, set up internal route to endpoint
      * plus add all iroute routes.
@@ -2489,30 +2518,6 @@
             multi_instance_string(mi, false, &gc));
     }

-    /* set our client's VPN endpoint for status reporting purposes */
-    mi->reporting_addr =3D mi->context.c2.push_ifconfig_local;
-    mi->reporting_addr_ipv6 =3D mi->context.c2.push_ifconfig_ipv6_local;
-
-    /* set context-level authentication flag */
-    mi->context.c2.tls_multi->multi_state =3D CAS_CONNECT_DONE;
-
-    /* authentication complete, calculate dynamic client specific options =
*/
-    if (!multi_client_set_protocol_options(&mi->context))
-    {
-        mi->context.c2.tls_multi->multi_state =3D CAS_FAILED;
-    }
-    /* only continue if setting protocol options worked */
-    else if (!multi_client_setup_dco_initial(m, mi, &gc))
-    {
-        mi->context.c2.tls_multi->multi_state =3D CAS_FAILED;
-    }
-    /* Generate data channel keys only if setting protocol options
-     * and DCO initial setup has not failed */
-    else if (!multi_client_generate_tls_keys(&mi->context))
-    {
-        mi->context.c2.tls_multi->multi_state =3D CAS_FAILED;
-    }
-
     /* send push reply if ready */
     if (mi->context.c2.push_request_received)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1cac0f036504c87205a3c97589a94a662cf79b99
Gerrit-Change-Number: 856
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--GnzfMuRSHdQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/856?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">multi.c: add iroutes after dco peer is added<b=
r><br>This doesn&#39;t matter for Linux and FreeBSD but matters<br>for dco-=
win, where iroute subnet is mapped to a peer<br>context, which means that p=
eer has to be created before<br>iroute is added.<br><br>Change-Id: I1cac0f0=
36504c87205a3c97589a94a662cf79b99<br>Signed-off-by: Lev Stipakov &lt;lev@...1186...=
.515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id=
: &lt;20250201121102.27395-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg30780.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br=
>1 file changed, 29 insertions(+), 24 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex b0e1941..96fa6cd 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -2442,6 +2442,35 @=
@</span><br><span>             ifconfig_constraint_network, ifconfig_constr=
aint_netmask);</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* set our client&#39;s VPN endpoin=
t for status reporting purposes */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mi-&gt;reporting_addr =3D mi-&gt;context.c2.push_ifconfi=
g_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;=
reporting_addr_ipv6 =3D mi-&gt;context.c2.push_ifconfig_ipv6_local;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* set context-level authentication flag *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context=
.c2.tls_multi-&gt;multi_state =3D CAS_CONNECT_DONE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Since dco-win maintains iroute routing table (subnet =
-&gt; peer),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
peer must be added before iroutes. For other platforms it doesn&#39;t matte=
r. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* authentication complete, c=
alculate dynamic client specific options */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!multi_client_set_protocol_options(&amp;mi-=
&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;conte=
xt.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* only continue if setting protocol options worked */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (!multi_cl=
ient_setup_dco_initial(m, mi, &amp;gc))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Generate data channel keys o=
nly if setting protocol options</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * and DCO initial setup has not failed */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (!multi_client_generate_=
tls_keys(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* dco peer has been added, it is now safe for Windows to a=
dd iroutes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     /*</span><br><span>      * For routed tunnels, set up inter=
nal route to endpoint</span><br><span>      * plus add all iroute routes.</=
span><br><span>@@ -2489,30 +2518,6 @@</span><br><span>             multi_in=
stance_string(mi, false, &amp;gc));</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* set our clien=
t&#39;s VPN endpoint for status reporting purposes */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;reporting_addr =3D mi-&gt;contex=
t.c2.push_ifconfig_local;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context.c2.push_ifconfig_ipv6=
_local;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* set context-level authentica=
tion flag */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&g=
t;context.c2.tls_multi-&gt;multi_state =3D CAS_CONNECT_DONE;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* authentication complete, calculate dynamic client =
specific options */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!multi_client_set_protocol_options(&amp;mi-&gt;context))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        mi-&gt;context.c2.tls_multi-&gt;multi_stat=
e =3D CAS_FAILED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* only continue=
 if setting protocol options worked */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else if (!multi_client_setup_dco_initial(m, mi, &amp;g=
c))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context.c2.tls_mult=
i-&gt;multi_state =3D CAS_FAILED;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* Generate data channel keys only if setting protocol options</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * and DCO initial setup has n=
ot failed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else =
if (!multi_client_generate_tls_keys(&amp;mi-&gt;context))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        mi-&gt;context.c2.tls_multi-&gt;multi_state =3D=
 CAS_FAILED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* =
send push reply if ready */</span><br><span>     if (mi-&gt;context.c2.push=
_request_received)</span><br><span>     {</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/856?usp=
=3Demail">change 856</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1cac0f036504c87205a3c97589a=
94a662cf79b99 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 856 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--GnzfMuRSHdQ=--

