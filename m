From: "kallisti5 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 01:50:29 +0000
References: <gerrit.1738029022000.Ieca0f8aa07413682d39e73dd3ed21a0038d41f49@...2715...>
Reply-To: alex@...2837..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d1434392bdaf6b1dfe2f393ed5fd3b2d851d23e7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bD7A+58zXvQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bD7A+58zXvQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/690?usp=3Demail

to review the following change.


Change subject: Haiku: change del to delete in route command. del is undocu=
mented
......................................................................

Haiku: change del to delete in route command. del is undocumented

Change-Id: Ieca0f8aa07413682d39e73dd3ed21a0038d41f49
---
M src/openvpn/route.c
1 file changed, 4 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/690/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--bD7A+58zXvQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>kallisti5 would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/690?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Haiku: change del to delete in route command. del is undocume=
nted<br><br>Change-Id: Ieca0f8aa07413682d39e73dd3ed21a0038d41f49<br>---<br>=
M src/openvpn/route.c<br>1 file changed, 4 insertions(+), 4 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/690=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br=
><span>index d17b285..12d6c07 100644</span><br><span>--- a/src/openvpn/rout=
e.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -2359,8 +2=
359,8 @@</span><br><span> </span><br><span> #elif defined(TARGET_HAIKU)</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
ex: route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 2=
55.255.0.0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv=
_printf(&amp;argv, &quot;%s del %s inet %s gw %s netmask %s&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* ex: route delete /dev=
/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;arg=
v, &quot;%s delete %s inet %s gw %s netmask %s&quot;,</span><br><span>     =
            ROUTE_PATH,</span><br><span>                 rgi-&gt;iface,</sp=
an><br><span>                 network,</span><br><span>@@ -2551,8 +2551,8 @=
@</span><br><span>         &quot;on connect only and will clean up automati=
cally.&quot;);</span><br><span> #elif defined(TARGET_HAIKU)</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ex: route de=
l /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s =
del %s inet6 %s gw %s prefixlen %d&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* ex: route delete /dev/net/ipro1000/0 inet6 :: =
gw beef::cafe prefixlen 64 */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    argv_printf(&amp;argv, &quot;%s delete %s inet6 %s gw %s pref=
ixlen %d&quot;,</span><br><span>                 ROUTE_PATH,</span><br><spa=
n>                 r6-&gt;iface,</span><br><span>                 network,<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/690?usp=3Demail">change 690</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/690?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieca0f8aa07413682d39e73dd3ed=
21a0038d41f49 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 690 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
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


--bD7A+58zXvQ=--

