From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 13:17:55 +0000
References: <gerrit.1738070271000.I58735fb24bc4a94c803b7dfcd6de87af0f75522a@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6222a0f11e804a0dfba1dec768b2c0864dc5ea71-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yFTpFCl8c4E="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route.c: change the
 signature of get_default_gateway()
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

--yFTpFCl8c4E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/878?usp=3Demail

to review the following change.


Change subject: route.c: change the signature of get_default_gateway()
......................................................................

route.c: change the signature of get_default_gateway()

As a preparation of an upcoming refactoring of
get_default_gateway(), add `dest` parameter to
specify destination address to which we are looking
the best route.

Change-Id: I58735fb24bc4a94c803b7dfcd6de87af0f75522a
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/ssl.c
M src/openvpn/tun.c
5 files changed, 11 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/878/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4510bea..5a80e6b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5866,7 +5866,7 @@
             get_ipv6_addr(p[1], &remote, NULL, M_WARN);
         }
         net_ctx_init(NULL, &net_ctx);
-        get_default_gateway(&rgi, &net_ctx);
+        get_default_gateway(&rgi, 0, &net_ctx);
         get_default_gateway_ipv6(&rgi6, &remote, &net_ctx);
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d17b285..640b0dc 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -655,7 +655,7 @@
         rl->spec.flags |=3D RTSA_DEFAULT_METRIC;
     }

-    get_default_gateway(&rl->rgi, ctx);
+    get_default_gateway(&rl->rgi, remote_host, ctx);
     if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);
@@ -2733,7 +2733,7 @@
 }

 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
     struct gc_arena gc =3D gc_new();

@@ -3282,7 +3282,7 @@
 #elif defined(TARGET_ANDROID)

 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
     /* Android, set some pseudo GW, addr is in host byte order,
      * Determining the default GW on Android 5.0+ is non trivial
@@ -3323,7 +3323,7 @@
 #elif defined(TARGET_LINUX)

 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
     struct gc_arena gc =3D gc_new();
     int sd =3D -1;
@@ -3561,7 +3561,7 @@
 #define max(a, b) ((a) > (b) ? (a) : (b))

 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
     struct gc_arena gc =3D gc_new();
     struct rtmsg m_rtmsg;
@@ -3943,7 +3943,7 @@
 #elif defined(TARGET_HAIKU)

 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
     CLEAR(*rgi);

@@ -4047,7 +4047,7 @@
  * may be disabled by missing items.
  */
 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
 {
     CLEAR(*rgi);
 }
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..23603bc 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -328,6 +328,7 @@
 bool is_special_addr(const char *addr_str);

 void get_default_gateway(struct route_gateway_info *rgi,
+                         in_addr_t dest,
                          openvpn_net_ctx_t *ctx);

 void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e4a7b57..6f78a76 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1990,7 +1990,7 @@
         {
             /* push mac addr */
             struct route_gateway_info rgi;
-            get_default_gateway(&rgi, session->opt->net_ctx);
+            get_default_gateway(&rgi, 0, session->opt->net_ctx);
             if (rgi.flags & RGI_HWADDR_DEFINED)
             {
                 buf_printf(&out, "IV_HWADDR=3D%s\n", format_hex_ex(rgi.hwa=
ddr, 6, 0, 1, ":", &gc));
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 33830fc..80f5dff 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -671,7 +671,7 @@
     struct route_gateway_info rgi;
     const unsigned int needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);

-    get_default_gateway(&rgi, ctx);
+    get_default_gateway(&rgi, 0, ctx);
     if ((rgi.flags & needed) =3D=3D needed)
     {
         const in_addr_t lan_network =3D rgi.gateway.addr & rgi.gateway.net=
mask;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/878?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I58735fb24bc4a94c803b7dfcd6de87af0f75522a
Gerrit-Change-Number: 878
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--yFTpFCl8c4E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/878?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">route.c: change the signature of get_default_gateway()<br><br=
>As a preparation of an upcoming refactoring of<br>get_default_gateway(), a=
dd `dest` parameter to<br>specify destination address to which we are looki=
ng<br>the best route.<br><br>Change-Id: I58735fb24bc4a94c803b7dfcd6de87af0f=
75522a<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src=
/openvpn/options.c<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>M s=
rc/openvpn/ssl.c<br>M src/openvpn/tun.c<br>5 files changed, 11 insertions(+=
), 10 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/78/878/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index 4510bea..5a80e6b 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -5866,7 +5866,7 @@</span><br><span>             get_ipv6=
_addr(p[1], &amp;remote, NULL, M_WARN);</span><br><span>         }</span><b=
r><span>         net_ctx_init(NULL, &amp;net_ctx);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        get_default_gateway(&amp;rgi, &amp;net=
_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        get_d=
efault_gateway(&amp;rgi, 0, &amp;net_ctx);</span><br><span>         get_def=
ault_gateway_ipv6(&amp;rgi6, &amp;remote, &amp;net_ctx);</span><br><span>  =
       print_default_gateway(M_INFO, &amp;rgi, &amp;rgi6);</span><br><span>=
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */</span><br=
><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><sp=
an>index d17b285..640b0dc 100644</span><br><span>--- a/src/openvpn/route.c<=
/span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -655,7 +655,7 =
@@</span><br><span>         rl-&gt;spec.flags |=3D RTSA_DEFAULT_METRIC;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    get_default_gateway(&amp;rl-&gt;rgi, ctx);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway(&amp;rl-=
&gt;rgi, remote_host, ctx);</span><br><span>     if (rl-&gt;rgi.flags &amp;=
 RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span>         setenv_r=
oute_addr(es, &quot;net_gateway&quot;, rl-&gt;rgi.gateway.addr, -1);</span>=
<br><span>@@ -2733,7 +2733,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_de=
fault_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+get_default_gateway(struc=
t route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><b=
r><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span> </span><br><span>@@ -3282,7 +3282,7 @@</span><br><span> #elif define=
d(TARGET_ANDROID)</span><br><span> </span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-get_default_gateway(struct route_gatewa=
y_info *rgi, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+get_default_gateway(struct route_gateway_info *rgi, in_add=
r_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     /=
* Android, set some pseudo GW, addr is in host byte order,</span><br><span>=
      * Determining the default GW on Android 5.0+ is non trivial</span><br=
><span>@@ -3323,7 +3323,7 @@</span><br><span> #elif defined(TARGET_LINUX)</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-get_default_gateway(struct route_gateway_info *rgi, openvp=
n_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ge=
t_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_n=
et_ctx_t *ctx)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     int sd =3D -1;</span><br><span>@@ -3561,=
7 +3561,7 @@</span><br><span> #define max(a, b) ((a) &gt; (b) ? (a) : (b))<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-get_default_gateway(struct route_gateway_info *rgi, openv=
pn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+g=
et_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_=
net_ctx_t *ctx)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     struct rtmsg m_rtmsg;</span><br><span>@@=
 -3943,7 +3943,7 @@</span><br><span> #elif defined(TARGET_HAIKU)</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx=
_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_default=
_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t =
*ctx)</span><br><span> {</span><br><span>     CLEAR(*rgi);</span><br><span>=
 </span><br><span>@@ -4047,7 +4047,7 @@</span><br><span>  * may be disabled=
 by missing items.</span><br><span>  */</span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-get_default_gateway(struct route_ga=
teway_info *rgi, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+get_default_gateway(struct route_gateway_info *rgi, in=
_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>  =
   CLEAR(*rgi);</span><br><span> }</span><br><span>diff --git a/src/openvpn=
/route.h b/src/openvpn/route.h</span><br><span>index 421e7d2..23603bc 10064=
4</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/openv=
pn/route.h</span><br><span>@@ -328,6 +328,7 @@</span><br><span> bool is_spe=
cial_addr(const char *addr_str);</span><br><span> </span><br><span> void ge=
t_default_gateway(struct route_gateway_info *rgi,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         in_addr_t dest,</spa=
n><br><span>                          openvpn_net_ctx_t *ctx);</span><br><s=
pan> </span><br><span> void get_default_gateway_ipv6(struct route_ipv6_gate=
way_info *rgi,</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn=
/ssl.c</span><br><span>index e4a7b57..6f78a76 100644</span><br><span>--- a/=
src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@=
@ -1990,7 +1990,7 @@</span><br><span>         {</span><br><span>           =
  /* push mac addr */</span><br><span>             struct route_gateway_inf=
o rgi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            get=
_default_gateway(&amp;rgi, session-&gt;opt-&gt;net_ctx);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            get_default_gateway(&amp;r=
gi, 0, session-&gt;opt-&gt;net_ctx);</span><br><span>             if (rgi.f=
lags &amp; RGI_HWADDR_DEFINED)</span><br><span>             {</span><br><sp=
an>                 buf_printf(&amp;out, &quot;IV_HWADDR=3D%s\n&quot;, form=
at_hex_ex(rgi.hwaddr, 6, 0, 1, &quot;:&quot;, &amp;gc));</span><br><span>di=
ff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 3383=
0fc..80f5dff 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span=
>+++ b/src/openvpn/tun.c</span><br><span>@@ -671,7 +671,7 @@</span><br><spa=
n>     struct route_gateway_info rgi;</span><br><span>     const unsigned i=
nt needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_default_gateway(&=
amp;rgi, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
et_default_gateway(&amp;rgi, 0, ctx);</span><br><span>     if ((rgi.flags &=
amp; needed) =3D=3D needed)</span><br><span>     {</span><br><span>        =
 const in_addr_t lan_network =3D rgi.gateway.addr &amp; rgi.gateway.netmask=
;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/878?usp=3Demail">change 878</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/878?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I58735fb24bc4a94c803b7dfcd6d=
e87af0f75522a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 878 </div>
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


--yFTpFCl8c4E=--

