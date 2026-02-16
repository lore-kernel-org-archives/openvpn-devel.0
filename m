From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 23:13:21 +0000
References: <gerrit.1771283598000.I633d8cbf75ab4da85e16df44684aef60523811c5@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <379b10303b5641f3f002d2a550e67bb558cba9cd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="apqdCczSIWo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--apqdCczSIWo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1536?usp=3Demail

to review the following change.


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
---
M src/openvpn/openvpn.c
M src/openvpn/options.c
M src/openvpn/options.h
3 files changed, 12 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1536/1

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
index cdb02e9..4e1e32a 100644
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


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1536?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I633d8cbf75ab4da85e16df44684aef60523811c5
Gerrit-Change-Number: 1536
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--apqdCczSIWo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ordex would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1536?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">options: drop useless init_gc param for ini=
t_options()<br><br>The init_option() function is always invoked with the se=
cond<br>param &quot;init_gc&quot; set to &quot;true&quot;.<br>This makes th=
e parameter useless and it can therefore be removed<br>while always taking =
the &quot;true&quot; branch in the related logic.<br><br>This way we can al=
so drop the options-&gt;gc_owned member as it<br>would also be always set t=
o true.<br><br>Change-Id: I633d8cbf75ab4da85e16df44684aef60523811c5<br>Sign=
ed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/ope=
nvpn/openvpn.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>3 f=
iles changed, 12 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1536/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><s=
pan>index b7eca19..f38660f 100644</span><br><span>--- a/src/openvpn/openvpn=
.c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -202,7 +2=
02,7 @@</span><br><span> #endif</span><br><span> </span><br><span>         =
    /* initialize options to default state */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            init_options(&amp;c.options, true);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            init_option=
s(&amp;c.options);</span><br><span> </span><br><span>             /* parse =
command line options, and read configuration file */</span><br><span>      =
       parse_argv(&amp;c.options, argc, argv, M_USAGE, OPT_P_DEFAULT, NULL,=
 c.es);</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/op=
tions.c</span><br><span>index cdb02e9..4e1e32a 100644</span><br><span>--- a=
/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><b=
r><span>@@ -792,15 +792,12 @@</span><br><span>  * will be set to 0.</span><=
br><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-init_options(struct options *o, const bool init_gc)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+init_options(struct options *=
o)</span><br><span> {</span><br><span>     CLEAR(*o);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (init_gc)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        gc_init(&amp;o-&gt;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        gc_init(&amp;o-&gt;dns_options.gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;gc_owned =3D true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_init(&amp;o-&gt;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_init(&amp;o-&gt;dns_=
options.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     o-&gt;mode =3D MODE_POINT_TO_POINT;</span><br><span>     o-&=
gt;topology =3D TOP_UNDEF;</span><br><span>     o-&gt;ce.proto =3D PROTO_UD=
P;</span><br><span>@@ -925,11 +922,9 @@</span><br><span>     {</span><br><s=
pan>         CLEAR(*o-&gt;remote_list);</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;gc_owned)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        gc_free(&amp;o-&gt;gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;o-&gt;dns_options=
.gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;o-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;o-&gt;dns_options.gc);</=
span><br><span> }</span><br><span> </span><br><span> #ifndef ENABLE_SMALL</=
span><br><span>@@ -2256,7 +2251,7 @@</span><br><span>     int dev =3D DEV_T=
YPE_UNDEF;</span><br><span>     bool pull =3D false;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_options(&amp;defa=
ults, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_options(&amp;defaults);</span><br><span> </span><br><span>     if (!optio=
ns-&gt;test_crypto)</span><br><span>     {</span><br><span>@@ -4824,7 +4819=
,7 @@</span><br><span> #else</span><br><span> </span><br><span>     struct =
options o;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_op=
tions(&amp;o, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    init_options(&amp;o);</span><br><span> </span><br><span>     fprintf(f=
p, usage_message, title_string, o.ce.connect_retry_seconds,</span><br><span=
>             o.ce.connect_retry_seconds_max, o.ce.local_port, o.ce.remote_=
port, TUN_MTU_DEFAULT,</span><br><span>@@ -5979,7 +5974,7 @@</span><br><spa=
n>             struct options sub;</span><br><span>             struct conn=
ection_entry *e;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            init_options(&amp;sub, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            init_options(&amp;sub);</spa=
n><br><span>             sub.ce =3D options-&gt;ce;</span><br><span>       =
      read_config_string(&quot;[CONNECTION-OPTIONS]&quot;, &amp;sub, p[1], =
msglevel, OPT_P_CONNECTION,</span><br><span>                               =
 option_types_found, es);</span><br><span>diff --git a/src/openvpn/options.=
h b/src/openvpn/options.h</span><br><span>index cf9936b..3d8b505 100644</sp=
an><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/=
options.h</span><br><span>@@ -254,7 +254,6 @@</span><br><span> struct optio=
ns</span><br><span> {</span><br><span>     struct gc_arena gc;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool gc_owned;</span><br><span=
> </span><br><span>     /* first config file */</span><br><span>     const =
char *config;</span><br><span>@@ -890,7 +889,7 @@</span><br><span> </span><=
br><span> void show_dco_version(const unsigned int flags);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void init_options(st=
ruct options *o, const bool init_gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void init_options(struct options *o);</span><br><span> </=
span><br><span> void uninit_options(struct options *o);</span><br><span> </=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1536?usp=3Demail">change 1536</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1536?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I633d8cbf75ab4da85e16df44684=
aef60523811c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1536 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--apqdCczSIWo=--

