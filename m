From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 15:46:17 +0000
In-Reply-To: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
References: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <e8dc795d7db01897963f7cd408799f44e033234f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sv507lMPY3E="; charset=UTF-8
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
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Sv507lMPY3E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail

to look at the new patch set (#6).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Automatically enable ifconfig-exec/route-exec behaviour for=
 afunix tun/tap
......................................................................

Automatically enable ifconfig-exec/route-exec behaviour for afunix tun/tap

Change-Id: I0a2957699757665d70514ba7cafe833443018ad6
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
1 file changed, 29 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/750/6

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5b2228c..05ae641 100644
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a2957699757665d70514ba7cafe833443018ad6
Gerrit-Change-Number: 750
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--Sv507lMPY3E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail">View Chang=
e</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is=
 unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">Automatically enable ifconfig-exec/route-exec behaviour f=
or afunix tun/tap<br><br>Change-Id: I0a2957699757665d70514ba7cafe833443018a=
d6<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/o=
penvpn/init.c<br>1 file changed, 29 insertions(+), 4 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/750/6</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>in=
dex 5b2228c..05ae641 100644</span><br><span>--- a/src/openvpn/init.c</span>=
<br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1679,6 +1679,18 @@</=
span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Determine if exter=
nal route commands should be executed based on</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * configured options and backend driver</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+route_noexec_enabled(const struct options *o, con=
st struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return o-&gt=
;route_noexec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
     || (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+           || (tt &amp;&amp;=
 tt-&gt;backend_driver =3D=3D DRIVER_NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /*</span><br><span>  * Possibly add routes and/or c=
all route-up script</span><br><span>  * based on options.</span><br><span>@=
@ -1693,7 +1705,7 @@</span><br><span>          openvpn_net_ctx_t *ctx)</spa=
n><br><span> {</span><br><span>     bool ret =3D true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;route_noexec &amp;&am=
p; ( route_list || route_ipv6_list ) )</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!route_noexec_enabled(options, tt) &amp;&amp; ( =
route_list || route_ipv6_list ) )</span><br><span>     {</span><br><span>  =
       ret =3D add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLA=
GS(options),</span><br><span>                          es, ctx);</span><br>=
<span>@@ -1858,6 +1870,19 @@</span><br><span> #endif</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Determines if ifco=
nfig execution should be disabled because of a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param c</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_noexe=
c_enabled(const struct context *c)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return c-&gt;options.ifconfig_noexec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+           || (c-&gt;c1.tuntap &amp;&amp; c-&gt;c1.tuntap=
-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+           || (c-&gt;c1.tuntap &amp;&amp; c-&gt;c1.tu=
ntap-&gt;backend_driver =3D=3D DRIVER_NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> static void</span><br><span> open_tun_backend(stru=
ct context *c)</span><br><span> {</span><br><span>@@ -1937,7 +1962,7 @@</sp=
an><br><span>         }</span><br><span> </span><br><span>         /* do if=
config */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!c-&gt;options.ifconfig_noexec</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!ifconfig_noexec_enabled(c)</span><br><span>        =
     &amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_BEFORE_TUN_=
OPEN)</span><br><span>         {</span><br><span>             /* guess actu=
al tun/tap unit number that will be returned</span><br><span>@@ -1978,7 +20=
03,7 @@</span><br><span>         }</span><br><span> </span><br><span>      =
   /* do ifconfig */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (!c-&gt;options.ifconfig_noexec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!ifconfig_noexec_enabled(c)</span><br><sp=
an>             &amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_=
AFTER_TUN_OPEN)</span><br><span>         {</span><br><span>             do_=
ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_name,</span><br><span>=
@@ -2061,7 +2086,7 @@</span><br><span> </span><br><span>     if (c-&gt;c1.t=
untap)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (!c-&gt;options.ifconfig_noexec)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!ifconfig_noexec_enabled(c))<=
/span><br><span>         {</span><br><span>             undo_ifconfig(c-&gt=
;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/750?usp=3Demail">change 750</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/750?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a2957699757665d70514ba7caf=
e833443018ad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Sv507lMPY3E=--

