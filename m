From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Apr 2024 10:29:03 +0000
References: <gerrit.1712744941000.Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <87ab2e32786be872f9341611ac3445ab0796a358-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yCX/jdYqd0E="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix "binary or" vs
 "boolean or" related to server_bridge_proxy_dhcp
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yCX/jdYqd0E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/553?usp=3Demail

to review the following change.


Change subject: Fix "binary or" vs "boolean or" related to server_bridge_pr=
oxy_dhcp
......................................................................

Fix "binary or" vs "boolean or" related to server_bridge_proxy_dhcp

Both values are boolean so there is no reason to use "|"
and it just confuses the reader whether there is something
more going on here.

Change-Id: Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/helper.c
M src/openvpn/init.c
2 files changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/553/1

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 1bab84c..24dee97 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -427,7 +427,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--yCX/jdYqd0E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/553?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix &quot;binary or&quot; vs &quot;boolean or&quot; related t=
o server_bridge_proxy_dhcp<br><br>Both values are boolean so there is no re=
ason to use &quot;|&quot;<br>and it just confuses the reader whether there =
is something<br>more going on here.<br><br>Change-Id: Ie61fa6a78875ecbaa9d3=
d8e7a50603d77c9ce09e<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>---<br>M src/openvpn/helper.c<br>M src/openvpn/init.c<br>2 files =
changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/53/553/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/helper.c b/src/openvpn/helper.c</span><br><span>index 1bab84c..24dee97 =
100644</span><br><span>--- a/src/openvpn/helper.c</span><br><span>+++ b/src=
/openvpn/helper.c</span><br><span>@@ -427,7 +427,7 @@</span><br><span>     =
 * if !nogw:</span><br><span>      *   push &quot;route-gateway dhcp&quot;<=
/span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    else if (o-&gt;server_bridge_defined | o-&gt;server_bridge_proxy_dhc=
p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (o-&g=
t;server_bridge_defined || o-&gt;server_bridge_proxy_dhcp)</span><br><span>=
     {</span><br><span>         if (o-&gt;client)</span><br><span>         =
{</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</spa=
n><br><span>index 02205e7..e67f10e 100644</span><br><span>--- a/src/openvpn=
/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -3565,7=
 +3565,7 @@</span><br><span>         msg(M_WARN, &quot;WARNING: using --pul=
l/--client and --ifconfig together is probably not what you want&quot;);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (o-&gt;server_bridge_defined | o-&gt;server_bridge_=
proxy_dhcp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
o-&gt;server_bridge_defined || o-&gt;server_bridge_proxy_dhcp)</span><br><s=
pan>     {</span><br><span>         msg(M_WARN, &quot;NOTE: when bridging y=
our LAN adapter with the TAP adapter, note that the new bridge adapter will=
 often take on its own IP address that is different from what the LAN adapt=
er was previously set to&quot;);</span><br><span>     }</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/553?usp=3Demail">change 553</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/553?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie61fa6a78875ecbaa9d3d8e7a50=
603d77c9ce09e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 553 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--yCX/jdYqd0E=--

