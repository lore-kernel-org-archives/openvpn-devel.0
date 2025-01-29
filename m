From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 09:57:03 +0000
In-Reply-To: <gerrit.1738070271000.I58735fb24bc4a94c803b7dfcd6de87af0f75522a@...2715...>
References: <gerrit.1738070271000.I58735fb24bc4a94c803b7dfcd6de87af0f75522a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <e54ad649c0c8e0c4e1f784a9ed3dc61e7eebe7f2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PYJY7eRNsV0="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PYJY7eRNsV0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/878?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: route.c: change the signature of get_default_gateway()
......................................................................

route.c: change the signature of get_default_gateway()

As a preparation of an upcoming refactoring of
get_default_gateway(), add `dest` parameter to
specify destination address to which we are looking
the best route.

Change-Id: I58735fb24bc4a94c803b7dfcd6de87af0f75522a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250129095038.19056-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
685.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/ssl.c
M src/openvpn/tun.c
5 files changed, 11 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/878/2

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
index 12d6c07..3501e35 100644
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
index 69b06b8..0bbedbb 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -335,6 +335,7 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--PYJY7eRNsV0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/878?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">route.c: change the signature of get_default_gateway=
()<br><br>As a preparation of an upcoming refactoring of<br>get_default_gat=
eway(), add `dest` parameter to<br>specify destination address to which we =
are looking<br>the best route.<br><br>Change-Id: I58735fb24bc4a94c803b7dfcd=
6de87af0f75522a<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Ack=
ed-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202501290950=
38.19056-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg30685.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/r=
oute.c<br>M src/openvpn/route.h<br>M src/openvpn/ssl.c<br>M src/openvpn/tun=
.c<br>5 files changed, 11 insertions(+), 10 deletions(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/878/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index=
 4510bea..5a80e6b 100644</span><br><span>--- a/src/openvpn/options.c</span>=
<br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5866,7 +5866,7 @@=
</span><br><span>             get_ipv6_addr(p[1], &amp;remote, NULL, M_WARN=
);</span><br><span>         }</span><br><span>         net_ctx_init(NULL, &=
amp;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
get_default_gateway(&amp;rgi, &amp;net_ctx);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        get_default_gateway(&amp;rgi, 0, &amp;net_=
ctx);</span><br><span>         get_default_gateway_ipv6(&amp;rgi6, &amp;rem=
ote, &amp;net_ctx);</span><br><span>         print_default_gateway(M_INFO, =
&amp;rgi, &amp;rgi6);</span><br><span>         openvpn_exit(OPENVPN_EXIT_ST=
ATUS_GOOD); /* exit point */</span><br><span>diff --git a/src/openvpn/route=
.c b/src/openvpn/route.c</span><br><span>index 12d6c07..3501e35 100644</spa=
n><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/rou=
te.c</span><br><span>@@ -655,7 +655,7 @@</span><br><span>         rl-&gt;sp=
ec.flags |=3D RTSA_DEFAULT_METRIC;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    get_default_gatew=
ay(&amp;rl-&gt;rgi, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    get_default_gateway(&amp;rl-&gt;rgi, remote_host, ctx);</span><br=
><span>     if (rl-&gt;rgi.flags &amp; RGI_ADDR_DEFINED)</span><br><span>  =
   {</span><br><span>         setenv_route_addr(es, &quot;net_gateway&quot;=
, rl-&gt;rgi.gateway.addr, -1);</span><br><span>@@ -2733,7 +2733,7 @@</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-get_default_gateway(struct route_gateway_in=
fo *rgi, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+get_default_gateway(struct route_gateway_info *rgi, in_addr_t =
dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -3282,7 +3=
282,7 @@</span><br><span> #elif defined(TARGET_ANDROID)</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-g=
et_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_default_gateway(=
struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</sp=
an><br><span> {</span><br><span>     /* Android, set some pseudo GW, addr i=
s in host byte order,</span><br><span>      * Determining the default GW on=
 Android 5.0+ is non trivial</span><br><span>@@ -3323,7 +3323,7 @@</span><b=
r><span> #elif defined(TARGET_LINUX)</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_default_gateway(=
struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+get_default_gateway(struct route_gatewa=
y_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</sp=
an><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     int=
 sd =3D -1;</span><br><span>@@ -3561,7 +3561,7 @@</span><br><span> #define =
max(a, b) ((a) &gt; (b) ? (a) : (b))</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_default_gateway(=
struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+get_default_gateway(struct route_gatewa=
y_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</sp=
an><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     str=
uct rtmsg m_rtmsg;</span><br><span>@@ -3943,7 +3943,7 @@</span><br><span> #=
elif defined(TARGET_HAIKU)</span><br><span> </span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-get_default_gateway(struct rou=
te_gateway_info *rgi, openvpn_net_ctx_t *ctx)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+get_default_gateway(struct route_gateway_info *rg=
i, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><sp=
an>     CLEAR(*rgi);</span><br><span> </span><br><span>@@ -4047,7 +4047,7 @=
@</span><br><span>  * may be disabled by missing items.</span><br><span>  *=
/</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ct=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_default_gatew=
ay(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)<=
/span><br><span> {</span><br><span>     CLEAR(*rgi);</span><br><span> }</sp=
an><br><span>diff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><=
br><span>index 69b06b8..0bbedbb 100644</span><br><span>--- a/src/openvpn/ro=
ute.h</span><br><span>+++ b/src/openvpn/route.h</span><br><span>@@ -335,6 +=
335,7 @@</span><br><span> bool is_special_addr(const char *addr_str);</span=
><br><span> </span><br><span> void get_default_gateway(struct route_gateway=
_info *rgi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                 in_addr_t dest,</span><br><span>                          =
openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span> void get_defaul=
t_gateway_ipv6(struct route_ipv6_gateway_info *rgi,</span><br><span>diff --=
git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index e4a7b57..=
6f78a76 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ =
b/src/openvpn/ssl.c</span><br><span>@@ -1990,7 +1990,7 @@</span><br><span> =
        {</span><br><span>             /* push mac addr */</span><br><span>=
             struct route_gateway_info rgi;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            get_default_gateway(&amp;rgi, session-&gt=
;opt-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           get_default_gateway(&amp;rgi, 0, session-&gt;opt-&gt;net_ctx);</=
span><br><span>             if (rgi.flags &amp; RGI_HWADDR_DEFINED)</span><=
br><span>             {</span><br><span>                 buf_printf(&amp;ou=
t, &quot;IV_HWADDR=3D%s\n&quot;, format_hex_ex(rgi.hwaddr, 6, 0, 1, &quot;:=
&quot;, &amp;gc));</span><br><span>diff --git a/src/openvpn/tun.c b/src/ope=
nvpn/tun.c</span><br><span>index 33830fc..80f5dff 100644</span><br><span>--=
- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><sp=
an>@@ -671,7 +671,7 @@</span><br><span>     struct route_gateway_info rgi;<=
/span><br><span>     const unsigned int needed =3D (RGI_ADDR_DEFINED|RGI_NE=
TMASK_DEFINED);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    get_default_gateway(&amp;rgi, ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    get_default_gateway(&amp;rgi, 0, ctx)=
;</span><br><span>     if ((rgi.flags &amp; needed) =3D=3D needed)</span><b=
r><span>     {</span><br><span>         const in_addr_t lan_network =3D rgi=
.gateway.addr &amp; rgi.gateway.netmask;</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/878?usp=
=3Demail">change 878</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/878?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I58735fb24bc4a94c803b7dfcd6d=
e87af0f75522a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 878 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--PYJY7eRNsV0=--

