From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 18:01:58 +0000
In-Reply-To: <gerrit.1738029022000.Ieca0f8aa07413682d39e73dd3ed21a0038d41f49@...2715...>
References: <gerrit.1738029022000.Ieca0f8aa07413682d39e73dd3ed21a0038d41f49@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., alex@...2837...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9910cfdb09b9741d90cccb91e0a2636bfa7b7df9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eptzrxgtzoE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Haiku: change del
 to delete in route command. del is undocumented
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kallisti5 <alex@...2837...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eptzrxgtzoE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/69=
0?usp=3Demail )

Change subject: Haiku: change del to delete in route command. del is undocu=
mented
......................................................................

Haiku: change del to delete in route command. del is undocumented

Change-Id: Ieca0f8aa07413682d39e73dd3ed21a0038d41f49
Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250128124129.109647-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
655.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 4 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d17b285..12d6c07 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2359,8 +2359,8 @@

 #elif defined(TARGET_HAIKU)

-    /* ex: route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 n=
etmask 255.255.0.0 */
-    argv_printf(&argv, "%s del %s inet %s gw %s netmask %s",
+    /* ex: route delete /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.=
1 netmask 255.255.0.0 */
+    argv_printf(&argv, "%s delete %s inet %s gw %s netmask %s",
                 ROUTE_PATH,
                 rgi->iface,
                 network,
@@ -2551,8 +2551,8 @@
         "on connect only and will clean up automatically.");
 #elif defined(TARGET_HAIKU)

-    /* ex: route del /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen =
64 */
-    argv_printf(&argv, "%s del %s inet6 %s gw %s prefixlen %d",
+    /* ex: route delete /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixl=
en 64 */
+    argv_printf(&argv, "%s delete %s inet6 %s gw %s prefixlen %d",
                 ROUTE_PATH,
                 r6->iface,
                 network,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/690?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieca0f8aa07413682d39e73dd3ed21a0038d41f49
Gerrit-Change-Number: 690
Gerrit-PatchSet: 2
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--eptzrxgtzoE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/690?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Haiku: change del to delete in route command. =
del is undocumented<br><br>Change-Id: Ieca0f8aa07413682d39e73dd3ed21a0038d4=
1f49<br>Signed-off-by: Alexander von Gluck &lt;alex@...2837...&gt;<br>Acked=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250128=
124129.109647-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg30655.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file chan=
ged, 4 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex d17b285..12d6c07 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -2359,8 +2359,8 @@=
</span><br><span> </span><br><span> #elif defined(TARGET_HAIKU)</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ex: rout=
e del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0=
.0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(=
&amp;argv, &quot;%s del %s inet %s gw %s netmask %s&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* ex: route delete /dev/net/ipr=
o1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0 */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot=
;%s delete %s inet %s gw %s netmask %s&quot;,</span><br><span>             =
    ROUTE_PATH,</span><br><span>                 rgi-&gt;iface,</span><br><=
span>                 network,</span><br><span>@@ -2551,8 +2551,8 @@</span>=
<br><span>         &quot;on connect only and will clean up automatically.&q=
uot;);</span><br><span> #elif defined(TARGET_HAIKU)</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ex: route del /dev/n=
et/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s del %s =
inet6 %s gw %s prefixlen %d&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* ex: route delete /dev/net/ipro1000/0 inet6 :: gw beef=
::cafe prefixlen 64 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    argv_printf(&amp;argv, &quot;%s delete %s inet6 %s gw %s prefixlen %=
d&quot;,</span><br><span>                 ROUTE_PATH,</span><br><span>     =
            r6-&gt;iface,</span><br><span>                 network,</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/690?usp=3Demail">change 690</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/690?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieca0f8aa07413682d39e73dd3ed=
21a0038d41f49 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 690 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--eptzrxgtzoE=--

