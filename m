From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 2 Feb 2025 09:49:11 +0000
In-Reply-To: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
References: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <00b9a432e2dde534781867b8a59aa51e87380c23-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c2NrTzDaM6E="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--c2NrTzDaM6E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/856/8

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
Gerrit-MessageType: newpatchset

--c2NrTzDaM6E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #8</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/856?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">multi.c: add iroutes after dco peer is added<br><br>=
This doesn&#39;t matter for Linux and FreeBSD but matters<br>for dco-win, w=
here iroute subnet is mapped to a peer<br>context, which means that peer ha=
s to be created before<br>iroute is added.<br><br>Change-Id: I1cac0f036504c=
87205a3c97589a94a662cf79b99<br>Signed-off-by: Lev Stipakov &lt;lev@...1699...=
.&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;=
20250201121102.27395-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg30780.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>1 fil=
e changed, 29 insertions(+), 24 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/56/856/8</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index b0e1941..96fa6c=
d 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/sr=
c/openvpn/multi.c</span><br><span>@@ -2442,6 +2442,35 @@</span><br><span>  =
           ifconfig_constraint_network, ifconfig_constraint_netmask);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* set our client&#39;s VPN endpoint for status reporti=
ng purposes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
i-&gt;reporting_addr =3D mi-&gt;context.c2.push_ifconfig_local;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;reporting_addr_ipv6 =
=3D mi-&gt;context.c2.push_ifconfig_ipv6_local;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* set context-level authentication flag */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.tls_multi-&gt;mu=
lti_state =3D CAS_CONNECT_DONE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Since dco-win maintains iroute routing table (subnet -&gt; peer),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * peer must be added bef=
ore iroutes. For other platforms it doesn&#39;t matter. */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* authentication complete, calculate dynamic clien=
t specific options */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!multi_client_set_protocol_options(&amp;mi-&gt;context))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context.c2.tls_multi-&gt;m=
ulti_state =3D CAS_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
only continue if setting protocol options worked */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (!multi_client_setup_dco_init=
ial(m, mi, &amp;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&g=
t;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Generate data channel keys only if setting prot=
ocol options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
and DCO initial setup has not failed */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (!multi_client_generate_tls_keys(&amp;mi-&g=
t;context))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=
.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
dco peer has been added, it is now safe for Windows to add iroutes */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*<=
/span><br><span>      * For routed tunnels, set up internal route to endpoi=
nt</span><br><span>      * plus add all iroute routes.</span><br><span>@@ -=
2489,30 +2518,6 @@</span><br><span>             multi_instance_string(mi, f=
alse, &amp;gc));</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* set our client&#39;s VPN endpoin=
t for status reporting purposes */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    mi-&gt;reporting_addr =3D mi-&gt;context.c2.push_ifconfig_=
local;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;repo=
rting_addr_ipv6 =3D mi-&gt;context.c2.push_ifconfig_ipv6_local;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* set context-level authentication flag */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.tls_mu=
lti-&gt;multi_state =3D CAS_CONNECT_DONE;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* authentication complete, calculate dynamic client specific options */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!multi_client=
_set_protocol_options(&amp;mi-&gt;context))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* only continue if setting protoco=
l options worked */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  else if (!multi_client_setup_dco_initial(m, mi, &amp;gc))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        mi-&gt;context.c2.tls_multi-&gt;multi_state =
=3D CAS_FAILED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Generate data c=
hannel keys only if setting protocol options</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * and DCO initial setup has not failed */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (!multi_client_=
generate_tls_keys(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* send push reply if=
 ready */</span><br><span>     if (mi-&gt;context.c2.push_request_received)=
</span><br><span>     {</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail">change 85=
6</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--c2NrTzDaM6E=--

