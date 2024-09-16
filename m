From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 22:42:33 +0000
In-Reply-To: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
References: <gerrit.1726491830000.I0a2957699757665d70514ba7cafe833443018ad6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b2dbd1fcdd09d59d92ce517580f94c7b40f412fe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7j9DFMWmKjc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7j9DFMWmKjc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail

to look at the new patch set (#3).


Change subject: Automatically enable ifconfig-exec/route-exec behaviour for=
 afunix tun/tap
......................................................................

Automatically enable ifconfig-exec/route-exec behaviour for afunix tun/tap

Change-Id: I0a2957699757665d70514ba7cafe833443018ad6
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
1 file changed, 29 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/750/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--7j9DFMWmKjc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Automatically enable ifconfig-exec/route-exec behaviour for afunix tu=
n/tap<br><br>Change-Id: I0a2957699757665d70514ba7cafe833443018ad6<br>Signed=
-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/init.=
c<br>1 file changed, 29 insertions(+), 4 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/50/750/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 5b2228c=
..05ae641 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+=
++ b/src/openvpn/init.c</span><br><span>@@ -1679,6 +1679,18 @@</span><br><s=
pan> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Determine if external route c=
ommands should be executed based on</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * configured options and backend driver</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+route_noexec_enabled(const struct options *o, const struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return o-&gt;route_noexec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           || (tt &=
amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           || (tt &amp;&amp; tt-&gt;backe=
nd_driver =3D=3D DRIVER_NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> /*</span><br><span>  * Possibly add routes and/or call route-up =
script</span><br><span>  * based on options.</span><br><span>@@ -1693,7 +17=
05,7 @@</span><br><span>          openvpn_net_ctx_t *ctx)</span><br><span> =
{</span><br><span>     bool ret =3D true;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (!options-&gt;route_noexec &amp;&amp; ( route_li=
st || route_ipv6_list ) )</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!route_noexec_enabled(options, tt) &amp;&amp; ( route_list ||=
 route_ipv6_list ) )</span><br><span>     {</span><br><span>         ret =
=3D add_routes(route_list, route_ipv6_list, tt, ROUTE_OPTION_FLAGS(options)=
,</span><br><span>                          es, ctx);</span><br><span>@@ -1=
858,6 +1870,19 @@</span><br><span> #endif</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Determines if ifconfig execut=
ion should be disabled because of a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param c</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_noexec_enabled(c=
onst struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return c-&=
gt;options.ifconfig_noexec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+           || (c-&gt;c1.tuntap &amp;&amp; c-&gt;c1.tuntap-&gt;backen=
d_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           || (c-&gt;c1.tuntap &amp;&amp; c-&gt;c1.tuntap-&gt;ba=
ckend_driver =3D=3D DRIVER_NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> static void</span><br><span> open_tun_backend(struct context =
*c)</span><br><span> {</span><br><span>@@ -1937,7 +1962,7 @@</span><br><spa=
n>         }</span><br><span> </span><br><span>         /* do ifconfig */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!c-&gt;opti=
ons.ifconfig_noexec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!ifconfig_noexec_enabled(c)</span><br><span>             &amp;&=
amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_BEFORE_TUN_OPEN)</span=
><br><span>         {</span><br><span>             /* guess actual tun/tap =
unit number that will be returned</span><br><span>@@ -1978,7 +2003,7 @@</sp=
an><br><span>         }</span><br><span> </span><br><span>         /* do if=
config */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!c-&gt;options.ifconfig_noexec</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!ifconfig_noexec_enabled(c)</span><br><span>        =
     &amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_O=
PEN)</span><br><span>         {</span><br><span>             do_ifconfig(c-=
&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_name,</span><br><span>@@ -2061,7 =
+2086,7 @@</span><br><span> </span><br><span>     if (c-&gt;c1.tuntap)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (!c-&gt;options.ifconfig_noexec)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!ifconfig_noexec_enabled(c))</span><br><sp=
an>         {</span><br><span>             undo_ifconfig(c-&gt;c1.tuntap, &=
amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/750=
?usp=3Demail">change 750</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/750?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a2957699757665d70514ba7caf=
e833443018ad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--7j9DFMWmKjc=--

