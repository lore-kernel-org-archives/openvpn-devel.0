From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 13 Jan 2025 09:20:05 +0000
References: <gerrit.1736759998000.I1cac0f036504c87205a3c97589a94a662cf79b99@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ad3fcce6147639b5f29b2ea7bcc5e8cff4752454-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iXfvCIGgieE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi.c: add iroutes
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

--iXfvCIGgieE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail

to review the following change.


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
1 file changed, 24 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/856/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d1b2c8c..196174c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2441,6 +2441,30 @@
             ifconfig_constraint_network, ifconfig_constraint_netmask);
     }

+    /* set our client's VPN endpoint for status reporting purposes */
+    mi->reporting_addr =3D mi->context.c2.push_ifconfig_local;
+    mi->reporting_addr_ipv6 =3D mi->context.c2.push_ifconfig_ipv6_local;
+
+    /* set context-level authentication flag */
+    mi->context.c2.tls_multi->multi_state =3D CAS_CONNECT_DONE;
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
     /*
      * For routed tunnels, set up internal route to endpoint
      * plus add all iroute routes.
@@ -2488,30 +2512,6 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--iXfvCIGgieE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/856?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">multi.c: add iroutes after dco peer is added<br><br>This does=
n&#39;t matter for Linux and FreeBSD but matters<br>for dco-win, where irou=
te subnet is mapped to a peer<br>context, which means that peer has to be c=
reated before<br>iroute is added.<br><br>Change-Id: I1cac0f036504c87205a3c9=
7589a94a662cf79b99<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>=
---<br>M src/openvpn/multi.c<br>1 file changed, 24 insertions(+), 24 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/56/856/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<=
/span><br><span>index d1b2c8c..196174c 100644</span><br><span>--- a/src/ope=
nvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -=
2441,6 +2441,30 @@</span><br><span>             ifconfig_constraint_network=
, ifconfig_constraint_netmask);</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* set our client&=
#39;s VPN endpoint for status reporting purposes */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;reporting_addr =3D mi-&gt;cont=
ext.c2.push_ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context.c2.push_ifconfig_=
ipv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* set context-level au=
thentication flag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_CONNECT_DONE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* authentication complete, calculate=
 dynamic client specific options */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!multi_client_set_protocol_options(&amp;mi-&gt;cont=
ext))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context.c2.tl=
s_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* only continue if setting protocol options worked */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (!multi_client_set=
up_dco_initial(m, mi, &amp;gc))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Generate data channel keys only if=
 setting protocol options</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * and DCO initial setup has not failed */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (!multi_client_generate_tls_k=
eys(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * =
For routed tunnels, set up internal route to endpoint</span><br><span>     =
 * plus add all iroute routes.</span><br><span>@@ -2488,30 +2512,6 @@</span=
><br><span>             multi_instance_string(mi, false, &amp;gc));</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* set our client&#39;s VPN endpoint for status reporting p=
urposes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;=
reporting_addr =3D mi-&gt;context.c2.push_ifconfig_local;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;reporting_addr_ipv6 =3D mi-&=
gt;context.c2.push_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* set context-level authentication flag */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.tls_multi-&gt;multi_state =3D =
CAS_CONNECT_DONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* authentication com=
plete, calculate dynamic client specific options */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!multi_client_set_protocol_options(=
&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;c=
ontext.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* only continue if setting protocol options worked */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (!multi_cl=
ient_setup_dco_initial(m, mi, &amp;gc))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        mi-&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Generate data channel keys only if s=
etting protocol options</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * and DCO initial setup has not failed */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else if (!multi_client_generate_tls_keys(&am=
p;mi-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;cont=
ext.c2.tls_multi-&gt;multi_state =3D CAS_FAILED;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>     /* send push reply if ready */</span><br><=
span>     if (mi-&gt;context.c2.push_request_received)</span><br><span>    =
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/856?usp=3Demail">change 856</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/856?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1cac0f036504c87205a3c97589a=
94a662cf79b99 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 856 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--iXfvCIGgieE=--

