From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 11:56:43 +0000
In-Reply-To: <gerrit.1769789455000.I2b2a931e13670d753aa9570efe498647ba1a4a7f@...2715...>
References: <gerrit.1769789455000.I2b2a931e13670d753aa9570efe498647ba1a4a7f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <7561493e6c8063a2ae7ab1c42fcaa07269f17255-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CPVNIEgbA5U="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CPVNIEgbA5U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1505?usp=3Demail

to look at the new patch set (#6).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: route: Fix type of rgi_needed variables
......................................................................

route: Fix type of rgi_needed variables

To avoid unneccesary sign-compare warnings.

Change-Id: I2b2a931e13670d753aa9570efe498647ba1a4a7f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.c
1 file changed, 2 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1505/6

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b2a931e13670d753aa9570efe498647ba1a4a7f
Gerrit-Change-Number: 1505
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--CPVNIEgbA5U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #6</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1505?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">route: Fix type of rgi_needed variab=
les<br><br>To avoid unneccesary sign-compare warnings.<br><br>Change-Id: I2=
b2a931e13670d753aa9570efe498647ba1a4a7f<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed=
, 2 insertions(+), 20 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/05/1505/6</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 329f3=
b0..b196713 100644</span><br><span>--- a/src/openvpn/route.c</span><br><spa=
n>+++ b/src/openvpn/route.c</span><br><span>@@ -570,11 +570,6 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> static void</span><br><span> add_block_local_routes(str=
uct route_list *rl)</span><br><span> {</span><br><span>@@ -602,15 +597,11 @=
@</span><br><span> bool</span><br><span> block_local_needed(const struct ro=
ute_list *rl)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEF=
INED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uns=
igned int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);</span><b=
r><span>     return (rl-&gt;flags &amp; RG_BLOCK_LOCAL) &amp;&amp; (rl-&gt;=
rgi.flags &amp; rgi_needed) =3D=3D rgi_needed</span><br><span>            &=
amp;&amp; (rl-&gt;spec.flags &amp; RTSA_REMOTE_ENDPOINT) &amp;&amp; rl-&gt;=
spec.remote_host_local !=3D TLA_LOCAL;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> bool</span><br><span> init_route_list(struct route_list *rl, const=
 struct route_option_list *opt,</span><br><span>                 const char=
 *remote_endpoint, int default_metric, in_addr_t remote_host,</span><br><sp=
an>@@ -1445,17 +1436,12 @@</span><br><span> #define LR_MATCH   1 /* route i=
s local */</span><br><span> #define LR_ERROR   2 /* caller should abort add=
ing route */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static int</span><br><span> local_route(in_addr_t network, in_addr_t netm=
ask, in_addr_t gateway,</span><br><span>             const struct route_gat=
eway_info *rgi)</span><br><span> {</span><br><span>     /* set LR_MATCH on =
local host routes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | RGI_I=
FACE_DEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst unsigned int rgi_needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | =
RGI_IFACE_DEFINED);</span><br><span>     if (rgi &amp;&amp; (rgi-&gt;flags =
&amp; rgi_needed) =3D=3D rgi_needed &amp;&amp; gateway =3D=3D rgi-&gt;gatew=
ay.addr</span><br><span>         &amp;&amp; netmask =3D=3D 0xFFFFFFFF)</spa=
n><br><span>     {</span><br><span>@@ -1479,10 +1465,6 @@</span><br><span> =
    return LR_NOMATCH;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Retu=
rn true if the &quot;on-link&quot; form of the route should be used.  This =
is when the gateway for</span><br><span>  * a route is specified as an inte=
rface rather than an address. */</span><br><span> #if defined(TARGET_LINUX)=
 || defined(_WIN32) || defined(TARGET_DARWIN)</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1505=
?usp=3Demail">change 1505</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1505?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2b2a931e13670d753aa9570efe4=
98647ba1a4a7f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1505 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--CPVNIEgbA5U=--

