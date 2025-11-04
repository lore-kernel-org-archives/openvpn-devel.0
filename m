From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 17:23:07 +0000
In-Reply-To: <gerrit.1762214128000.I2b5429841bcd46376241890ace50b82a291b7400@...2715...>
References: <gerrit.1762214128000.I2b5429841bcd46376241890ace50b82a291b7400@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <fbc824393b3f898982bd22d0d8f32deead0c5ba6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3aCJgxg2pAc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: init: make some
 functions static
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3aCJgxg2pAc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
46?usp=3Demail )

Change subject: init: make some functions static
......................................................................

init: make some functions static

A bunch of functions are defined and used within init.c only.
We can therefore drop their declaration in init.h and make
them static.

Change-Id: I2b5429841bcd46376241890ace50b82a291b7400
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1346
Message-Id: <20251104104448.98093-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
193.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/init.h
2 files changed, 26 insertions(+), 32 deletions(-)




diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1bdaf27..8d95d5c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -71,13 +71,13 @@

 static bool do_deferred_p2p_ncp(struct context *c);

-void
+static void
 context_clear(struct context *c)
 {
     CLEAR(*c);
 }

-void
+static void
 context_clear_1(struct context *c)
 {
     CLEAR(c->c1);
@@ -4430,32 +4430,9 @@
 }

 /*
- * Initialize a tunnel instance, handle pre and post-init
- * signal settings.
- */
-void
-init_instance_handle_signals(struct context *c, const struct env_set *env,=
 const unsigned int flags)
-{
-    pre_init_signal_catch();
-    init_instance(c, env, flags);
-    post_init_signal_catch();
-
-    /*
-     * This is done so that signals thrown during
-     * initialization can bring us back to
-     * a management hold.
-     */
-    if (IS_SIG(c))
-    {
-        remap_signal(c);
-        uninit_management_callback();
-    }
-}
-
-/*
  * Initialize a tunnel instance.
  */
-void
+static void
 init_instance(struct context *c, const struct env_set *env, const unsigned=
 int flags)
 {
     const struct options *options =3D &c->options;
@@ -4745,6 +4722,29 @@
 }

 /*
+ * Initialize a tunnel instance, handle pre and post-init
+ * signal settings.
+ */
+void
+init_instance_handle_signals(struct context *c, const struct env_set *env,=
 const unsigned int flags)
+{
+    pre_init_signal_catch();
+    init_instance(c, env, flags);
+    post_init_signal_catch();
+
+    /*
+     * This is done so that signals thrown during
+     * initialization can bring us back to
+     * a management hold.
+     */
+    if (IS_SIG(c))
+    {
+        remap_signal(c);
+        uninit_management_callback();
+    }
+}
+
+/*
  * Close a tunnel instance.
  */
 void
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index e89615b..97318ec 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -31,10 +31,6 @@
  */
 #define BASE_N_EVENTS 5

-void context_clear(struct context *c);
-
-void context_clear_1(struct context *c);
-
 void context_clear_2(struct context *c);

 void context_init_1(struct context *c);
@@ -64,8 +60,6 @@
 void init_instance_handle_signals(struct context *c, const struct env_set =
*env,
                                   const unsigned int flags);

-void init_instance(struct context *c, const struct env_set *env, const uns=
igned int flags);
-
 /**
  * Query for private key and auth-user-pass username/passwords.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b5429841bcd46376241890ace50b82a291b7400
Gerrit-Change-Number: 1346
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3aCJgxg2pAc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1346?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">init: make some functions static<br><br>A bunch =
of functions are defined and used within init.c only.<br>We can therefore d=
rop their declaration in init.h and make<br>them static.<br><br>Change-Id: =
I2b5429841bcd46376241890ace50b82a291b7400<br>Signed-off-by: Antonio Quartul=
li &lt;antonio@...2726...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1346<br>Me=
ssage-Id: &lt;20251104104448.98093-1-frank@...2641...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34193.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/i=
nit.c<br>M src/openvpn/init.h<br>2 files changed, 26 insertions(+), 32 dele=
tions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex 1bdaf27..8d95d5c 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -71,13 +71,13 @@</span=
><br><span> </span><br><span> static bool do_deferred_p2p_ncp(struct contex=
t *c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span> context_clear(struct context *c)</span><br><span> {</span>=
<br><span>     CLEAR(*c);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span> context_clear_1(stru=
ct context *c)</span><br><span> {</span><br><span>     CLEAR(c-&gt;c1);</sp=
an><br><span>@@ -4430,32 +4430,9 @@</span><br><span> }</span><br><span> </s=
pan><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * I=
nitialize a tunnel instance, handle pre and post-init</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * signal settings.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ini=
t_instance_handle_signals(struct context *c, const struct env_set *env, con=
st unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pre_init_signal=
_catch();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_ins=
tance(c, env, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    post_init_signal_catch();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * This is done so that =
signals thrown during</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * initialization can bring us back to</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * a management hold.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (IS_SIG(c))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
remap_signal(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   uninit_management_callback();</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Initialize a tunnel ins=
tance.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span> init_instance(struct context *c, const struct env_set *=
env, const unsigned int flags)</span><br><span> {</span><br><span>     cons=
t struct options *options =3D &amp;c-&gt;options;</span><br><span>@@ -4745,=
6 +4722,29 @@</span><br><span> }</span><br><span> </span><br><span> /*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialize a tunnel i=
nstance, handle pre and post-init</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * signal settings.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_instance_han=
dle_signals(struct context *c, const struct env_set *env, const unsigned in=
t flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    pre_init_signal_catch();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_instance(c,=
 env, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    po=
st_init_signal_catch();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * This is done so that =
signals thrown during</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * initialization can bring us back to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * a management hold.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (IS_SIG(c))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        remap_signal(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        uninit_management_callback();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * C=
lose a tunnel instance.</span><br><span>  */</span><br><span> void</span><b=
r><span>diff --git a/src/openvpn/init.h b/src/openvpn/init.h</span><br><spa=
n>index e89615b..97318ec 100644</span><br><span>--- a/src/openvpn/init.h</s=
pan><br><span>+++ b/src/openvpn/init.h</span><br><span>@@ -31,10 +31,6 @@</=
span><br><span>  */</span><br><span> #define BASE_N_EVENTS 5</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void context_clear=
(struct context *c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void context_clear_1(s=
truct context *c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> void context_clear_2(struct context *c);</span><br><span> </=
span><br><span> void context_init_1(struct context *c);</span><br><span>@@ =
-64,8 +60,6 @@</span><br><span> void init_instance_handle_signals(struct co=
ntext *c, const struct env_set *env,</span><br><span>                      =
             const unsigned int flags);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void init_instance(struct context *c, c=
onst struct env_set *env, const unsigned int flags);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Q=
uery for private key and auth-user-pass username/passwords.</span><br><span=
>  */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail">change 1346</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1346?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2b5429841bcd46376241890ace5=
0b82a291b7400 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1346 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--3aCJgxg2pAc=--

