From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 28 Feb 2026 10:00:33 +0000
In-Reply-To: <gerrit.1771283598000.I633d8cbf75ab4da85e16df44684aef60523811c5@...2715...>
References: <gerrit.1771283598000.I633d8cbf75ab4da85e16df44684aef60523811c5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <16f2e6c57e6001b9b29ad54be552a342de90b5fd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XFPu5BkwwQw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: drop
 useless init_gc param for init_options()
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

--XFPu5BkwwQw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1536?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: options: drop useless init_gc param for init_options()
......................................................................

options: drop useless init_gc param for init_options()

The init_option() function is always invoked with the second
param "init_gc" set to "true".
This makes the parameter useless and it can therefore be removed
while always taking the "true" branch in the related logic.

This way we can also drop the options->gc_owned member as it
would also be always set to true.

Change-Id: I633d8cbf75ab4da85e16df44684aef60523811c5
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1536
Message-Id: <20260217135605.154129-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
695.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/openvpn.c
M src/openvpn/options.c
M src/openvpn/options.h
M tests/unit_tests/openvpn/test_options_parse.c
4 files changed, 12 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1536/3

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b7eca19..f38660f 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -202,7 +202,7 @@
 #endif

             /* initialize options to default state */
-            init_options(&c.options, true);
+            init_options(&c.options);

             /* parse command line options, and read configuration file */
             parse_argv(&c.options, argc, argv, M_USAGE, OPT_P_DEFAULT, NUL=
L, c.es);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ea05ef0..fdbc678 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -792,15 +792,12 @@
  * will be set to 0.
  */
 void
-init_options(struct options *o, const bool init_gc)
+init_options(struct options *o)
 {
     CLEAR(*o);
-    if (init_gc)
-    {
-        gc_init(&o->gc);
-        gc_init(&o->dns_options.gc);
-        o->gc_owned =3D true;
-    }
+    gc_init(&o->gc);
+    gc_init(&o->dns_options.gc);
+
     o->mode =3D MODE_POINT_TO_POINT;
     o->topology =3D TOP_UNDEF;
     o->ce.proto =3D PROTO_UDP;
@@ -925,11 +922,9 @@
     {
         CLEAR(*o->remote_list);
     }
-    if (o->gc_owned)
-    {
-        gc_free(&o->gc);
-        gc_free(&o->dns_options.gc);
-    }
+
+    gc_free(&o->gc);
+    gc_free(&o->dns_options.gc);
 }

 #ifndef ENABLE_SMALL
@@ -2256,7 +2251,7 @@
     int dev =3D DEV_TYPE_UNDEF;
     bool pull =3D false;

-    init_options(&defaults, true);
+    init_options(&defaults);

     if (!options->test_crypto)
     {
@@ -4824,7 +4819,7 @@
 #else

     struct options o;
-    init_options(&o, true);
+    init_options(&o);

     fprintf(fp, usage_message, title_string, o.ce.connect_retry_seconds,
             o.ce.connect_retry_seconds_max, o.ce.local_port, o.ce.remote_p=
ort, TUN_MTU_DEFAULT,
@@ -5979,7 +5974,7 @@
             struct options sub;
             struct connection_entry *e;

-            init_options(&sub, true);
+            init_options(&sub);
             sub.ce =3D options->ce;
             read_config_string("[CONNECTION-OPTIONS]", &sub, p[1], msgleve=
l, OPT_P_CONNECTION,
                                option_types_found, es);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cf9936b..3d8b505 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -254,7 +254,6 @@
 struct options
 {
     struct gc_arena gc;
-    bool gc_owned;

     /* first config file */
     const char *config;
@@ -890,7 +889,7 @@

 void show_dco_version(const unsigned int flags);

-void init_options(struct options *o, const bool init_gc);
+void init_options(struct options *o);

 void uninit_options(struct options *o);

diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index bb34f01..0b3d7fe 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -248,7 +248,6 @@
     CLEAR(o); /* NB: avoiding init_options to limit dependencies */
     gc_init(&o.gc);
     gc_init(&o.dns_options.gc);
-    o.gc_owned =3D true;

     char *p_expect_someopt[MAX_PARMS];
     char *p_expect_otheropt[MAX_PARMS];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1536?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I633d8cbf75ab4da85e16df44684aef60523811c5
Gerrit-Change-Number: 1536
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XFPu5BkwwQw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by ordex.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1536?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">options: drop useless init_g=
c param for init_options()<br><br>The init_option() function is always invo=
ked with the second<br>param &quot;init_gc&quot; set to &quot;true&quot;.<b=
r>This makes the parameter useless and it can therefore be removed<br>while=
 always taking the &quot;true&quot; branch in the related logic.<br><br>Thi=
s way we can also drop the options-&gt;gc_owned member as it<br>would also =
be always set to true.<br><br>Change-Id: I633d8cbf75ab4da85e16df44684aef605=
23811c5<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>A=
cked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1536<br>Message-Id: &lt;20260217135605.15412=
9-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg35695.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/openvpn.c<br>M src/openvpn/options=
.c<br>M src/openvpn/options.h<br>M tests/unit_tests/openvpn/test_options_pa=
rse.c<br>4 files changed, 12 insertions(+), 19 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36=
/1536/3</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c<=
/span><br><span>index b7eca19..f38660f 100644</span><br><span>--- a/src/ope=
nvpn/openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span>=
@@ -202,7 +202,7 @@</span><br><span> #endif</span><br><span> </span><br><sp=
an>             /* initialize options to default state */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            init_options(&amp;c.options=
, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 init_options(&amp;c.options);</span><br><span> </span><br><span>          =
   /* parse command line options, and read configuration file */</span><br>=
<span>             parse_argv(&amp;c.options, argc, argv, M_USAGE, OPT_P_DE=
FAULT, NULL, c.es);</span><br><span>diff --git a/src/openvpn/options.c b/sr=
c/openvpn/options.c</span><br><span>index ea05ef0..fdbc678 100644</span><br=
><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/option=
s.c</span><br><span>@@ -792,15 +792,12 @@</span><br><span>  * will be set t=
o 0.</span><br><span>  */</span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-init_options(struct options *o, const bool init_g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_options(stru=
ct options *o)</span><br><span> {</span><br><span>     CLEAR(*o);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (init_gc)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        gc_init(&amp;o-&gt;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        gc_init(&amp;o-&gt;dns_options.gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;gc_own=
ed =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_init(&amp;o-&gt;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_init(&am=
p;o-&gt;dns_options.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     o-&gt;mode =3D MODE_POINT_TO_POINT;</span><br><s=
pan>     o-&gt;topology =3D TOP_UNDEF;</span><br><span>     o-&gt;ce.proto =
=3D PROTO_UDP;</span><br><span>@@ -925,11 +922,9 @@</span><br><span>     {<=
/span><br><span>         CLEAR(*o-&gt;remote_list);</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;gc_owned=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;o-&gt;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;o-&gt=
;dns_options.gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;o-&gt;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;o-&gt;dns_op=
tions.gc);</span><br><span> }</span><br><span> </span><br><span> #ifndef EN=
ABLE_SMALL</span><br><span>@@ -2256,7 +2251,7 @@</span><br><span>     int d=
ev =3D DEV_TYPE_UNDEF;</span><br><span>     bool pull =3D false;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_optio=
ns(&amp;defaults, true);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    init_options(&amp;defaults);</span><br><span> </span><br><span>   =
  if (!options-&gt;test_crypto)</span><br><span>     {</span><br><span>@@ -=
4824,7 +4819,7 @@</span><br><span> #else</span><br><span> </span><br><span>=
     struct options o;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    init_options(&amp;o, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    init_options(&amp;o);</span><br><span> </span><br><span>  =
   fprintf(fp, usage_message, title_string, o.ce.connect_retry_seconds,</sp=
an><br><span>             o.ce.connect_retry_seconds_max, o.ce.local_port, =
o.ce.remote_port, TUN_MTU_DEFAULT,</span><br><span>@@ -5979,7 +5974,7 @@</s=
pan><br><span>             struct options sub;</span><br><span>            =
 struct connection_entry *e;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            init_options(&amp;sub, true);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            init_options(&am=
p;sub);</span><br><span>             sub.ce =3D options-&gt;ce;</span><br><=
span>             read_config_string(&quot;[CONNECTION-OPTIONS]&quot;, &amp=
;sub, p[1], msglevel, OPT_P_CONNECTION,</span><br><span>                   =
             option_types_found, es);</span><br><span>diff --git a/src/open=
vpn/options.h b/src/openvpn/options.h</span><br><span>index cf9936b..3d8b50=
5 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/=
src/openvpn/options.h</span><br><span>@@ -254,7 +254,6 @@</span><br><span> =
struct options</span><br><span> {</span><br><span>     struct gc_arena gc;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool gc_owned;</sp=
an><br><span> </span><br><span>     /* first config file */</span><br><span=
>     const char *config;</span><br><span>@@ -890,7 +889,7 @@</span><br><sp=
an> </span><br><span> void show_dco_version(const unsigned int flags);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void ini=
t_options(struct options *o, const bool init_gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void init_options(struct options *o);</span><=
br><span> </span><br><span> void uninit_options(struct options *o);</span><=
br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_optio=
ns_parse.c b/tests/unit_tests/openvpn/test_options_parse.c</span><br><span>=
index bb34f01..0b3d7fe 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_options_parse.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
options_parse.c</span><br><span>@@ -248,7 +248,6 @@</span><br><span>     CL=
EAR(o); /* NB: avoiding init_options to limit dependencies */</span><br><sp=
an>     gc_init(&amp;o.gc);</span><br><span>     gc_init(&amp;o.dns_options=
.gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o.gc_owned =
=3D true;</span><br><span> </span><br><span>     char *p_expect_someopt[MAX=
_PARMS];</span><br><span>     char *p_expect_otheropt[MAX_PARMS];</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1536?usp=3Demail">change 1536</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1536?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I633d8cbf75ab4da85e16df44684=
aef60523811c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1536 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--XFPu5BkwwQw=--

