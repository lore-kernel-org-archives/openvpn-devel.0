From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 13:27:17 +0000
In-Reply-To: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
References: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b751e2934e45e9df01d2dfcdfd91fe3459d408f6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kBKEPvU3wj4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Automatically enable
 ifconfig-exec/route-exec behaviour for afunix tu...
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

--kBKEPvU3wj4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#12) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Automatically enable ifconfig-exec/route-exec behaviour for=
 afunix tun/tap
......................................................................

Automatically enable ifconfig-exec/route-exec behaviour for afunix tun/tap

Change-Id: I0a2957699757665d70514ba7cafe833443018ad6
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240924131437.22294-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20240924131437.22294-1=
-gert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/tun.c
2 files changed, 30 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/750/12

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd9203a..876edad 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1679,6 +1679,18 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 }

+/**
+ * Determine if external route commands should be executed based on
+ * configured options and backend driver
+ */
+static bool
+route_noexec_enabled(const struct options *o, const struct tuntap *tt)
+{
+    return o->route_noexec
+           || (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
+           || (tt && tt->backend_driver =3D=3D DRIVER_NULL);
+}
+
 /*
  * Possibly add routes and/or call route-up script
  * based on options.
@@ -1693,7 +1705,7 @@
          openvpn_net_ctx_t *ctx)
 {
     bool ret =3D true;
-    if (!options->route_noexec && ( route_list || route_ipv6_list ) )
+    if (!route_noexec_enabled(options, tt) && ( route_list || route_ipv6_l=
ist ) )
     {
         ret =3D add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_F=
LAGS(options),
                          es, ctx);
@@ -1858,6 +1870,19 @@
 #endif
 }

+/**
+ * Determines if ifconfig execution should be disabled because of a
+ * @param c
+ * @return
+ */
+static bool
+ifconfig_noexec_enabled(const struct context *c)
+{
+    return c->options.ifconfig_noexec
+           || (c->c1.tuntap && c->c1.tuntap->backend_driver =3D=3D DRIVER_=
AFUNIX)
+           || (c->c1.tuntap && c->c1.tuntap->backend_driver =3D=3D DRIVER_=
NULL);
+}
+
 static void
 open_tun_backend(struct context *c)
 {
@@ -1937,7 +1962,7 @@
         }

         /* do ifconfig */
-        if (!c->options.ifconfig_noexec
+        if (!ifconfig_noexec_enabled(c)
             && ifconfig_order(c->c1.tuntap) =3D=3D IFCONFIG_BEFORE_TUN_OPE=
N)
         {
             /* guess actual tun/tap unit number that will be returned
@@ -1978,7 +2003,7 @@
         }

         /* do ifconfig */
-        if (!c->options.ifconfig_noexec
+        if (!ifconfig_noexec_enabled(c)
             && ifconfig_order(c->c1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_OPEN)
         {
             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
@@ -2061,7 +2086,7 @@

     if (c->c1.tuntap)
     {
-        if (!c->options.ifconfig_noexec)
+        if (!ifconfig_noexec_enabled(c))
         {
             undo_ifconfig(c->c1.tuntap, &c->net_ctx);
         }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 206ddc0..85fe01a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1744,7 +1744,7 @@
 void
 undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    if (tt->backend_driver !=3D DRIVER_NULL)
+    if (tt->backend_driver !=3D DRIVER_NULL && tt->backend_driver !=3D DRI=
VER_AFUNIX)
     {
         if (tt->did_ifconfig_setup)
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a2957699757665d70514ba7cafe833443018ad6
Gerrit-Change-Number: 750
Gerrit-PatchSet: 12
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--kBKEPvU3wj4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #12</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/750?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Automatically enable ifconfig-exec/route-exec behavi=
our for afunix tun/tap<br><br>Change-Id: I0a2957699757665d70514ba7cafe83344=
3018ad6<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240924131437.222=
94-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/search?l=3Dmi=
d&amp;q=3D20240924131437.22294-1-gert@...1296...<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/init.c<br>M src/openvp=
n/tun.c<br>2 files changed, 30 insertions(+), 5 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/750/12</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index =
cd9203a..876edad 100644</span><br><span>--- a/src/openvpn/init.c</span><br>=
<span>+++ b/src/openvpn/init.c</span><br><span>@@ -1679,6 +1679,18 @@</span=
><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Determine if external =
route commands should be executed based on</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * configured options and backend driver</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+route_noexec_enabled(const struct options *o, const str=
uct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return o-&gt;route=
_noexec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           |=
| (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+           || (tt &amp;&amp; tt-&g=
t;backend_driver =3D=3D DRIVER_NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /*</span><br><span>  * Possibly add routes and/or call ro=
ute-up script</span><br><span>  * based on options.</span><br><span>@@ -169=
3,7 +1705,7 @@</span><br><span>          openvpn_net_ctx_t *ctx)</span><br>=
<span> {</span><br><span>     bool ret =3D true;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!options-&gt;route_noexec &amp;&amp; ( r=
oute_list || route_ipv6_list ) )</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!route_noexec_enabled(options, tt) &amp;&amp; ( route_=
list || route_ipv6_list ) )</span><br><span>     {</span><br><span>        =
 ret =3D add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS(opt=
ions),</span><br><span>                          es, ctx);</span><br><span>=
@@ -1858,6 +1870,19 @@</span><br><span> #endif</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Determines if ifconfig e=
xecution should be disabled because of a</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param c</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_noexec_enab=
led(const struct context *c)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n c-&gt;options.ifconfig_noexec</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+           || (c-&gt;c1.tuntap &amp;&amp; c-&gt;c1.tuntap-&gt;b=
ackend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           || (c-&gt;c1.tuntap &amp;&amp; c-&gt;c1.tuntap-&=
gt;backend_driver =3D=3D DRIVER_NULL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static void</span><br><span> open_tun_backend(struct con=
text *c)</span><br><span> {</span><br><span>@@ -1937,7 +1962,7 @@</span><br=
><span>         }</span><br><span> </span><br><span>         /* do ifconfig=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!c-&gt=
;options.ifconfig_noexec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!ifconfig_noexec_enabled(c)</span><br><span>             &=
amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_BEFORE_TUN_OPEN)<=
/span><br><span>         {</span><br><span>             /* guess actual tun=
/tap unit number that will be returned</span><br><span>@@ -1978,7 +2003,7 @=
@</span><br><span>         }</span><br><span> </span><br><span>         /* =
do ifconfig */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!c-&gt;options.ifconfig_noexec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!ifconfig_noexec_enabled(c)</span><br><span>   =
          &amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_AFTER_=
TUN_OPEN)</span><br><span>         {</span><br><span>             do_ifconf=
ig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_name,</span><br><span>@@ -20=
61,7 +2086,7 @@</span><br><span> </span><br><span>     if (c-&gt;c1.tuntap)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (!c-&gt;options.ifconfig_noexec)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!ifconfig_noexec_enabled(c))</span><b=
r><span>         {</span><br><span>             undo_ifconfig(c-&gt;c1.tunt=
ap, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span>diff --=
git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 206ddc0..=
85fe01a 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ =
b/src/openvpn/tun.c</span><br><span>@@ -1744,7 +1744,7 @@</span><br><span> =
void</span><br><span> undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *c=
tx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (tt-&gt;backend_driver !=3D DRIVER_NULL)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (tt-&gt;backend_driver !=3D DRIVER_NULL=
 &amp;&amp; tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span><br><span>     =
{</span><br><span>         if (tt-&gt;did_ifconfig_setup)</span><br><span> =
        {</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail">change 750</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/750?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a2957699757665d70514ba7caf=
e833443018ad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--kBKEPvU3wj4=--

