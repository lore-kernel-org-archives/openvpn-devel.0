From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 09:40:58 +0000
In-Reply-To: <gerrit.1738260795000.I6f17140109106b37e6b0e690df1d87720ccf6f91@...2715...>
References: <gerrit.1738260795000.I6f17140109106b37e6b0e690df1d87720ccf6f91@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <c2e7a1effdf527cf12ebc04b99fd2ec90da1818f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ezyHXQrBqr0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 get_default_gateway(): implement platform support for Linux/IPROUTE2
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

--ezyHXQrBqr0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/884?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by ordex


Change subject: get_default_gateway(): implement platform support for Linux=
/IPROUTE2
......................................................................

get_default_gateway(): implement platform support for Linux/IPROUTE2

Remove the old "read /proc/net/route and try to parse it" implementation
and always use the sitnl/netlink implementation of net_route_v4_best_gw().

This was kept "because we had it and it was working" but does not really
provide any benefit - netlink for route queries is there for v6 anyway,
and the main argument for keeping --enable-iproute2 is "some users want
to run non-standard 'ip' binaries to do things" - which is not affected
by this change.

Change-Id: I6f17140109106b37e6b0e690df1d87720ccf6f91
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <a@...2181...>
Message-Id: <20250131084707.24905-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
748.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/networking_iproute2.c
M src/openvpn/networking_sitnl.c
2 files changed, 8 insertions(+), 55 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/884/3

diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_ipr=
oute2.c
index 975282c..6f13ef5 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -394,63 +394,15 @@
     return ret;
 }

-int
-net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
-                     in_addr_t *best_gw, char *best_iface)
-{
-    best_iface[0] =3D '\0';
-
-    FILE *fp =3D fopen("/proc/net/route", "r");
-    if (!fp)
-    {
-        return -1;
-    }
-
-    char line[256];
-    int count =3D 0;
-    unsigned int lowest_metric =3D UINT_MAX;
-    while (fgets(line, sizeof(line), fp) !=3D NULL)
-    {
-        if (count)
-        {
-            unsigned int net_x =3D 0;
-            unsigned int mask_x =3D 0;
-            unsigned int gw_x =3D 0;
-            unsigned int metric =3D 0;
-            unsigned int flags =3D 0;
-            char name[16];
-            name[0] =3D '\0';
-
-            const int np =3D sscanf(line, "%15s\t%x\t%x\t%x\t%*s\t%*s\t%d\=
t%x",
-                                  name, &net_x, &gw_x, &flags, &metric,
-                                  &mask_x);
-
-            if (np =3D=3D 6 && (flags & IFF_UP))
-            {
-                const in_addr_t net =3D ntohl(net_x);
-                const in_addr_t mask =3D ntohl(mask_x);
-                const in_addr_t gw =3D ntohl(gw_x);
-
-                if (!net && !mask && metric < lowest_metric)
-                {
-                    *best_gw =3D gw;
-                    strcpy(best_iface, name);
-                    lowest_metric =3D metric;
-                }
-            }
-        }
-        ++count;
-    }
-    fclose(fp);
-
-    return 0;
-}
-
 /*
- * The following function is not implemented in the iproute backend as it
+ * The following functions are not implemented in the iproute backend as it
  * uses the sitnl implementation from networking_sitnl.c.
  *
  * int
+ * net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
+ *                     in_addr_t *best_gw, char *best_iface)
+ *
+ * int
  * net_route_v6_best_gw(const struct in6_addr *dst,
  *                      struct in6_addr *best_gw, char *best_iface)
  */
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 6b750e8..9de8912 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -619,8 +619,7 @@

 }

-#ifdef ENABLE_SITNL
-
+/* used by iproute2 implementation too */
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
                      in_addr_t *best_gw, char *best_iface)
@@ -652,6 +651,8 @@
     return ret;
 }

+#ifdef ENABLE_SITNL
+
 int
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/884?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6f17140109106b37e6b0e690df1d87720ccf6f91
Gerrit-Change-Number: 884
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--ezyHXQrBqr0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/884?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">get_default_gateway(): implement platform support fo=
r Linux/IPROUTE2<br><br>Remove the old &quot;read /proc/net/route and try t=
o parse it&quot; implementation<br>and always use the sitnl/netlink impleme=
ntation of net_route_v4_best_gw().<br><br>This was kept &quot;because we ha=
d it and it was working&quot; but does not really<br>provide any benefit - =
netlink for route queries is there for v6 anyway,<br>and the main argument =
for keeping --enable-iproute2 is &quot;some users want<br>to run non-standa=
rd &#39;ip&#39; binaries to do things&quot; - which is not affected<br>by t=
his change.<br><br>Change-Id: I6f17140109106b37e6b0e690df1d87720ccf6f91<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Antonio Qu=
artulli &lt;a@...2181...&gt;<br>Message-Id: &lt;20250131084707.24905-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg30748.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/networking_iproute2.c<br>M src/openvpn/netw=
orking_sitnl.c<br>2 files changed, 8 insertions(+), 55 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/884/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networki=
ng_iproute2.c</span><br><span>index 975282c..6f13ef5 100644</span><br><span=
>--- a/src/openvpn/networking_iproute2.c</span><br><span>+++ b/src/openvpn/=
networking_iproute2.c</span><br><span>@@ -394,63 +394,15 @@</span><br><span=
>     return ret;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t=
 *dst,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
      in_addr_t *best_gw, char *best_iface)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    best_iface[0] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    F=
ILE *fp =3D fopen(&quot;/proc/net/route&quot;, &quot;r&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!fp)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return -1;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    char line[256];</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int count =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int lowest_met=
ric =3D UINT_MAX;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
while (fgets(line, sizeof(line), fp) !=3D NULL)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (count)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       unsigned int net_x =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            unsigned int mask_x =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            unsigned int gw_x =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            unsigned int metric =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uns=
igned int flags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            char name[16];</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            name[0] =3D &#39;\0&#39;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            const int np =3D sscanf(line, &quot;%15s\t%x\t%x\t%x\t%*s\t%*s=
\t%d\t%x&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                            name, &amp;net_x, &amp;gw_x, &amp;flags, &amp;m=
etric,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                   &amp;mask_x);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (np =3D=3D 6 &amp;&amp; (flags &amp; IFF_UP))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                const in_addr_t net =3D ntohl(net_x);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                const =
in_addr_t mask =3D ntohl(mask_x);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                const in_addr_t gw =3D ntohl(gw_x);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (!net &amp;&amp; !mask &amp;&amp; m=
etric &lt; lowest_metric)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    *best_gw =3D gw;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    strcpy(best_iface, name);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    lowest_metric =
=3D metric;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        ++count;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    fclose(fp);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * The following function is not imp=
lemented in the iproute backend as it</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * The following functions are not implemented in the ipr=
oute backend as it</span><br><span>  * uses the sitnl implementation from n=
etworking_sitnl.c.</span><br><span>  *</span><br><span>  * int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * net_route_v4_best_gw(openvpn_=
net_ctx_t *ctx, const in_addr_t *dst,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *                     in_addr_t *best_gw, char *best_ifa=
ce)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * int</span><br><span>  * net_ro=
ute_v6_best_gw(const struct in6_addr *dst,</span><br><span>  *             =
         struct in6_addr *best_gw, char *best_iface)</span><br><span>  */</=
span><br><span>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/ne=
tworking_sitnl.c</span><br><span>index 6b750e8..9de8912 100644</span><br><s=
pan>--- a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/=
networking_sitnl.c</span><br><span>@@ -619,8 +619,7 @@</span><br><span> </s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifdef ENABLE_SITNL</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* used =
by iproute2 implementation too */</span><br><span> int</span><br><span> net=
_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,</span><br><=
span>                      in_addr_t *best_gw, char *best_iface)</span><br>=
<span>@@ -652,6 +651,8 @@</span><br><span>     return ret;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> int</span><br><span> net_iface_up(openvpn_net_ctx_t *ctx=
, const char *iface, bool up)</span><br><span> {</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
84?usp=3Demail">change 884</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/884?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6f17140109106b37e6b0e690df1=
d87720ccf6f91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 884 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ezyHXQrBqr0=--

