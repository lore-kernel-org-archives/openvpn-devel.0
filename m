From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 2 May 2024 15:15:39 +0000
In-Reply-To: <gerrit.1712744941000.Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e@...2715...>
References: <gerrit.1712744941000.Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7368d89226cd255fdb11f5c78e054f1e655bc6dd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JSa5JBHJKkI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix 'binary or' vs
 'boolean or' related to server_bridge_proxy_dhcp
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JSa5JBHJKkI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/55=
3?usp=3Demail )

Change subject: Fix 'binary or' vs 'boolean or' related to server_bridge_pr=
oxy_dhcp
......................................................................

Fix 'binary or' vs 'boolean or' related to server_bridge_proxy_dhcp

Both values are boolean so there is no reason to use "|"
and it just confuses the reader whether there is something
more going on here.

Change-Id: Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240502095322.9433-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
601.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/helper.c
M src/openvpn/init.c
2 files changed, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 5681718..bbdbc04 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -454,7 +454,7 @@
      * if !nogw:
      *   push "route-gateway dhcp"
      */
-    else if (o->server_bridge_defined | o->server_bridge_proxy_dhcp)
+    else if (o->server_bridge_defined || o->server_bridge_proxy_dhcp)
     {
         if (o->client)
         {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 02205e7..e67f10e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3565,7 +3565,7 @@
         msg(M_WARN, "WARNING: using --pull/--client and --ifconfig togethe=
r is probably not what you want");
     }

-    if (o->server_bridge_defined | o->server_bridge_proxy_dhcp)
+    if (o->server_bridge_defined || o->server_bridge_proxy_dhcp)
     {
         msg(M_WARN, "NOTE: when bridging your LAN adapter with the TAP ada=
pter, note that the new bridge adapter will often take on its own IP addres=
s that is different from what the LAN adapter was previously set to");
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/553?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e
Gerrit-Change-Number: 553
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--JSa5JBHJKkI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/553?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix &#39;binary or&#39; vs &#39;boolean or&#39=
; related to server_bridge_proxy_dhcp<br><br>Both values are boolean so the=
re is no reason to use &quot;|&quot;<br>and it just confuses the reader whe=
ther there is something<br>more going on here.<br><br>Change-Id: Ie61fa6a78=
875ecbaa9d3d8e7a50603d77c9ce09e<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mess=
age-Id: &lt;20240502095322.9433-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg28601.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/helpe=
r.c<br>M src/openvpn/init.c<br>2 files changed, 2 insertions(+), 2 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c</span><br><span=
>index 5681718..bbdbc04 100644</span><br><span>--- a/src/openvpn/helper.c</=
span><br><span>+++ b/src/openvpn/helper.c</span><br><span>@@ -454,7 +454,7 =
@@</span><br><span>      * if !nogw:</span><br><span>      *   push &quot;r=
oute-gateway dhcp&quot;</span><br><span>      */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else if (o-&gt;server_bridge_defined | o-&gt=
;server_bridge_proxy_dhcp)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (o-&gt;server_bridge_defined || o-&gt;server_bridge_prox=
y_dhcp)</span><br><span>     {</span><br><span>         if (o-&gt;client)</=
span><br><span>         {</span><br><span>diff --git a/src/openvpn/init.c b=
/src/openvpn/init.c</span><br><span>index 02205e7..e67f10e 100644</span><br=
><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</s=
pan><br><span>@@ -3565,7 +3565,7 @@</span><br><span>         msg(M_WARN, &q=
uot;WARNING: using --pull/--client and --ifconfig together is probably not =
what you want&quot;);</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;server_bridge_define=
d | o-&gt;server_bridge_proxy_dhcp)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (o-&gt;server_bridge_defined || o-&gt;server_bridge_=
proxy_dhcp)</span><br><span>     {</span><br><span>         msg(M_WARN, &qu=
ot;NOTE: when bridging your LAN adapter with the TAP adapter, note that the=
 new bridge adapter will often take on its own IP address that is different=
 from what the LAN adapter was previously set to&quot;);</span><br><span>  =
   }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/553?usp=3Demail">change 553</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/553?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie61fa6a78875ecbaa9d3d8e7a50=
603d77c9ce09e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 553 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--JSa5JBHJKkI=--

