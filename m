From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 12:45:33 +0000
In-Reply-To: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
References: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <011b250e5360d43b83e517ea5e4610cc7747f265-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FWyGSs6b1U0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FWyGSs6b1U0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, stipa.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+1 by ordex


Change subject: multi.c: add iroutes after dco peer is added
......................................................................

multi.c: add iroutes after dco peer is added

This doesn't matter for Linux and FreeBSD but matters
for dco-win, where iroute subnet is mapped to a peer
context, which means that peer has to be created before
iroute is added.

Change-Id: I1cac0f036504c87205a3c97589a94a662cf79b99
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/multi.c
1 file changed, 29 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/856/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d1b2c8c..82fcf17 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2441,6 +2441,35 @@
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
@@ -2488,30 +2517,6 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--FWyGSs6b1U0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, stipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+1 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">multi.c: add iroutes after dco peer is added<br><br>=
This doesn&#39;t matter for Linux and FreeBSD but matters<br>for dco-win, w=
here iroute subnet is mapped to a peer<br>context, which means that peer ha=
s to be created before<br>iroute is added.<br><br>Change-Id: I1cac0f036504c=
87205a3c97589a94a662cf79b99<br>Signed-off-by: Lev Stipakov &lt;lev@...1699...=
.&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 29 insertions(+), =
24 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/56/856/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn=
/multi.c</span><br><span>index d1b2c8c..82fcf17 100644</span><br><span>--- =
a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><=
span>@@ -2441,6 +2441,35 @@</span><br><span>             ifconfig_constrain=
t_network, ifconfig_constraint_netmask);</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* set ou=
r client&#39;s VPN endpoint for status reporting purposes */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;reporting_addr =3D mi-&=
gt;context.c2.push_ifconfig_local;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context.c2.push_if=
config_ipv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* set context-l=
evel authentication flag */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_CONNECT_DON=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Since dco-win maintains irout=
e routing table (subnet -&gt; peer),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * peer must be added before iroutes. For other platfo=
rms it doesn&#39;t matter. */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* au=
thentication complete, calculate dynamic client specific options */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_client_set_p=
rotocol_options(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* only continue if setting proto=
col options worked */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (!multi_client_setup_dco_initial(m, mi, &amp;gc))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        mi-&gt;context.c2.tls_multi-&gt;multi=
_state =3D CAS_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Gene=
rate data channel keys only if setting protocol options</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * and DCO initial setup has not fa=
iled */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(!multi_client_generate_tls_keys(&amp;mi-&gt;context))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        mi-&gt;context.c2.tls_multi-&gt;multi_state =
=3D CAS_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* dco peer has been added, it is=
 now safe for Windows to add iroutes */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * For ro=
uted tunnels, set up internal route to endpoint</span><br><span>      * plu=
s add all iroute routes.</span><br><span>@@ -2488,30 +2517,6 @@</span><br><=
span>             multi_instance_string(mi, false, &amp;gc));</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* set our client&#39;s VPN endpoint for status reporting purpose=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;report=
ing_addr =3D mi-&gt;context.c2.push_ifconfig_local;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;reporting_addr_ipv6 =3D mi-&gt;c=
ontext.c2.push_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
set context-level authentication flag */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_=
CONNECT_DONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* authentication complet=
e, calculate dynamic client specific options */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!multi_client_set_protocol_options(&amp;m=
i-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=
.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* only continue if setting protocol options worked */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else if (!multi_client_set=
up_dco_initial(m, mi, &amp;gc))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Generate data channel keys only if setting p=
rotocol options</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 and DCO initial setup has not failed */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else if (!multi_client_generate_tls_keys(&amp;mi-&gt=
;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context.c2.t=
ls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     /* send push reply if ready */</span><br><span>   =
  if (mi-&gt;context.c2.push_request_received)</span><br><span>     {</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/856?usp=3Demail">change 856</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/856?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1cac0f036504c87205a3c97589a=
94a662cf79b99 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 856 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FWyGSs6b1U0=--

