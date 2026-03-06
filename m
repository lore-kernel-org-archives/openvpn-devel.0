From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 16:20:39 +0000
In-Reply-To: <gerrit.1769789455000.I2b2a931e13670d753aa9570efe498647ba1a4a7f@...2715...>
References: <gerrit.1769789455000.I2b2a931e13670d753aa9570efe498647ba1a4a7f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <decda21f60c9f5687b060e0fdb36e14b911d3036-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L/RHBt5mNB0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: Fix type of
 rgi_needed variables
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

--L/RHBt5mNB0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
05?usp=3Demail )

Change subject: route: Fix type of rgi_needed variables
......................................................................

route: Fix type of rgi_needed variables

To avoid unneccesary sign-compare warnings.

Change-Id: I2b2a931e13670d753aa9570efe498647ba1a4a7f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1505
Message-Id: <20260305084914.1327-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
926.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 2 insertions(+), 20 deletions(-)




diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 329f3b0..b196713 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -570,11 +570,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static void
 add_block_local_routes(struct route_list *rl)
 {
@@ -602,15 +597,11 @@
 bool
 block_local_needed(const struct route_list *rl)
 {
-    const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
+    const unsigned int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFI=
NED);
     return (rl->flags & RG_BLOCK_LOCAL) && (rl->rgi.flags & rgi_needed) =
=3D=3D rgi_needed
            && (rl->spec.flags & RTSA_REMOTE_ENDPOINT) && rl->spec.remote_h=
ost_local !=3D TLA_LOCAL;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 init_route_list(struct route_list *rl, const struct route_option_list *opt,
                 const char *remote_endpoint, int default_metric, in_addr_t=
 remote_host,
@@ -1445,17 +1436,12 @@
 #define LR_MATCH   1 /* route is local */
 #define LR_ERROR   2 /* caller should abort adding route */

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static int
 local_route(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
             const struct route_gateway_info *rgi)
 {
     /* set LR_MATCH on local host routes */
-    const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | RGI=
_IFACE_DEFINED);
+    const unsigned int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFI=
NED | RGI_IFACE_DEFINED);
     if (rgi && (rgi->flags & rgi_needed) =3D=3D rgi_needed && gateway =3D=
=3D rgi->gateway.addr
         && netmask =3D=3D 0xFFFFFFFF)
     {
@@ -1479,10 +1465,6 @@
     return LR_NOMATCH;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* Return true if the "on-link" form of the route should be used.  This is=
 when the gateway for
  * a route is specified as an interface rather than an address. */
 #if defined(TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1505?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b2a931e13670d753aa9570efe498647ba1a4a7f
Gerrit-Change-Number: 1505
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L/RHBt5mNB0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1505?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">route: Fix type of rgi_needed variables<br><br>T=
o avoid unneccesary sign-compare warnings.<br><br>Change-Id: I2b2a931e13670=
d753aa9570efe498647ba1a4a7f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1505<br>Message-Id: &lt;20260305=
084914.1327-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg35926.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed=
, 2 insertions(+), 20 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex 329f3b0..b196713 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -570,11 +570,6 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static void</span><br><span> add_block_local_=
routes(struct route_list *rl)</span><br><span> {</span><br><span>@@ -602,15=
 +597,11 @@</span><br><span> bool</span><br><span> block_local_needed(const=
 struct route_list *rl)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_N=
ETMASK_DEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const unsigned int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED)=
;</span><br><span>     return (rl-&gt;flags &amp; RG_BLOCK_LOCAL) &amp;&amp=
; (rl-&gt;rgi.flags &amp; rgi_needed) =3D=3D rgi_needed</span><br><span>   =
         &amp;&amp; (rl-&gt;spec.flags &amp; RTSA_REMOTE_ENDPOINT) &amp;&am=
p; rl-&gt;spec.remote_host_local !=3D TLA_LOCAL;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> bool</span><br><span> init_route_list(struct route_list =
*rl, const struct route_option_list *opt,</span><br><span>                 =
const char *remote_endpoint, int default_metric, in_addr_t remote_host,</sp=
an><br><span>@@ -1445,17 +1436,12 @@</span><br><span> #define LR_MATCH   1 =
/* route is local */</span><br><span> #define LR_ERROR   2 /* caller should=
 abort adding route */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignor=
ed &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> static int</span><br><span> local_route(in_addr_t network, in_ad=
dr_t netmask, in_addr_t gateway,</span><br><span>             const struct =
route_gateway_info *rgi)</span><br><span> {</span><br><span>     /* set LR_=
MATCH on local host routes */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINE=
D | RGI_IFACE_DEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const unsigned int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_D=
EFINED | RGI_IFACE_DEFINED);</span><br><span>     if (rgi &amp;&amp; (rgi-&=
gt;flags &amp; rgi_needed) =3D=3D rgi_needed &amp;&amp; gateway =3D=3D rgi-=
&gt;gateway.addr</span><br><span>         &amp;&amp; netmask =3D=3D 0xFFFFF=
FFF)</span><br><span>     {</span><br><span>@@ -1479,10 +1465,6 @@</span><b=
r><span>     return LR_NOMATCH;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /* Return true if the &quot;on-link&quot; form of the route should be use=
d.  This is when the gateway for</span><br><span>  * a route is specified a=
s an interface rather than an address. */</span><br><span> #if defined(TARG=
ET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1505?usp=3Demail">change 1505</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1505?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2b2a931e13670d753aa9570efe4=
98647ba1a4a7f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1505 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--L/RHBt5mNB0=--

