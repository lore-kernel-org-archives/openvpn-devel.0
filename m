From: "ordex (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 23:55:32 +0000
References: <gerrit.1762214128000.I2b5429841bcd46376241890ace50b82a291b7400@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3632a56d5b4cfce071c939c85da1ae3702bb094c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IqGfVZOquFg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IqGfVZOquFg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail

to review the following change.


Change subject: init: make some functions static
......................................................................

init: make some functions static

A bunch of functions are defined and used within init.c only.
We can therefore drop their declaration in init.h and make
them static.

Change-Id: I2b5429841bcd46376241890ace50b82a291b7400
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/init.c
M src/openvpn/init.h
2 files changed, 26 insertions(+), 32 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1346/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b5429841bcd46376241890ace50b82a291b7400
Gerrit-Change-Number: 1346
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--IqGfVZOquFg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">init: make some functions static<br><br>A b=
unch of functions are defined and used within init.c only.<br>We can theref=
ore drop their declaration in init.h and make<br>them static.<br><br>Change=
-Id: I2b5429841bcd46376241890ace50b82a291b7400<br>Signed-off-by: Antonio Qu=
artulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/init.c<br>M src/=
openvpn/init.h<br>2 files changed, 26 insertions(+), 32 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/46/1346/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init=
.c</span><br><span>index 1bdaf27..8d95d5c 100644</span><br><span>--- a/src/=
openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ =
-71,13 +71,13 @@</span><br><span> </span><br><span> static bool do_deferred=
_p2p_ncp(struct context *c);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span> context_clear(struct context *c)</sp=
an><br><span> {</span><br><span>     CLEAR(*c);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
> context_clear_1(struct context *c)</span><br><span> {</span><br><span>   =
  CLEAR(c-&gt;c1);</span><br><span>@@ -4430,32 +4430,9 @@</span><br><span> =
}</span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Initialize a tunnel instance, handle pre and post-init=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * signal settings.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-init_instance_handle_signals(struct context *c, const stru=
ct env_set *env, const unsigned int flags)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    pre_init_signal_catch();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    init_instance(c, env, flags);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    post_init_signal_catch();</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * T=
his is done so that signals thrown during</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * initialization can bring us back to</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * a management hold.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (IS_SIG(c))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        remap_signal(c);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uninit_management_callback();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * In=
itialize a tunnel instance.</span><br><span>  */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span> init_instance(struct context *c, c=
onst struct env_set *env, const unsigned int flags)</span><br><span> {</spa=
n><br><span>     const struct options *options =3D &amp;c-&gt;options;</spa=
n><br><span>@@ -4745,6 +4722,29 @@</span><br><span> }</span><br><span> </sp=
an><br><span> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Initialize a tunnel instance, handle pre and post-init</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * signal settings.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+init_instance_handle_signals(struct context *c, const struct env_set *e=
nv, const unsigned int flags)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pre_=
init_signal_catch();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    init_instance(c, env, flags);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    post_init_signal_catch();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
This is done so that signals thrown during</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * initialization can bring us back to</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * a management hold.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (IS_SIG(c))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        remap_signal(c);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uninit_management_callback();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span>  * Close a tunnel instance.</span><br><span>  */</span><br=
><span> void</span><br><span>diff --git a/src/openvpn/init.h b/src/openvpn/=
init.h</span><br><span>index e89615b..97318ec 100644</span><br><span>--- a/=
src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><br><span=
>@@ -31,10 +31,6 @@</span><br><span>  */</span><br><span> #define BASE_N_EV=
ENTS 5</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void context_clear(struct context *c);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid context_clear_1(struct context *c);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> void context_clear_2(struct context *c)=
;</span><br><span> </span><br><span> void context_init_1(struct context *c)=
;</span><br><span>@@ -64,8 +60,6 @@</span><br><span> void init_instance_han=
dle_signals(struct context *c, const struct env_set *env,</span><br><span> =
                                  const unsigned int flags);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void init_instance=
(struct context *c, const struct env_set *env, const unsigned int flags);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</=
span><br><span>  * Query for private key and auth-user-pass username/passwo=
rds.</span><br><span>  */</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail">change=
 1346</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2b5429841bcd46376241890ace5=
0b82a291b7400 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1346 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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

</body></html>=

--IqGfVZOquFg=--

