From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 17:23:04 +0000
In-Reply-To: <gerrit.1762214128000.I2b5429841bcd46376241890ace50b82a291b7400@...2715...>
References: <gerrit.1762214128000.I2b5429841bcd46376241890ace50b82a291b7400@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <fbc824393b3f898982bd22d0d8f32deead0c5ba6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XhJZgv+dTa0="; charset=UTF-8
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

--XhJZgv+dTa0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1346/2

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
=20
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b5429841bcd46376241890ace50b82a291b7400
Gerrit-Change-Number: 1346
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XhJZgv+dTa0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ordex.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1346?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">init: make some functions st=
atic<br><br>A bunch of functions are defined and used within init.c only.<b=
r>We can therefore drop their declaration in init.h and make<br>them static=
.<br><br>Change-Id: I2b5429841bcd46376241890ace50b82a291b7400<br>Signed-off=
-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acked-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1346<br>Message-Id: &lt;20251104104448.98093-1-frank@...2641...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg34193.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br>2 files changed, 26 in=
sertions(+), 32 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/46/1346/2</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 1bdaf27..8d95d5=
c 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src=
/openvpn/init.c</span><br><span>@@ -71,13 +71,13 @@</span><br><span> </span=
><br><span> static bool do_deferred_p2p_ncp(struct context *c);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> c=
ontext_clear(struct context *c)</span><br><span> {</span><br><span>     CLE=
AR(*c);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span> context_clear_1(struct context *c)</sp=
an><br><span> {</span><br><span>     CLEAR(c-&gt;c1);</span><br><span>@@ -4=
430,32 +4430,9 @@</span><br><span> }</span><br><span> </span><br><span> /*<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Initialize a tunnel=
 instance, handle pre and post-init</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * signal settings.</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_instance_handle_si=
gnals(struct context *c, const struct env_set *env, const unsigned int flag=
s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    pre_init_signal_catch();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    init_instance(c, env, flags)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    post_init_signal=
_catch();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * This is done so that signals thrown durin=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * initializatio=
n can bring us back to</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * a management hold.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (I=
S_SIG(c))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        remap_signal(c);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        uninit_management=
_callback();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span>  * Initialize a tunnel instance.</span><br><=
span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
> init_instance(struct context *c, const struct env_set *env, const unsigne=
d int flags)</span><br><span> {</span><br><span>     const struct options *=
options =3D &amp;c-&gt;options;</span><br><span>@@ -4745,6 +4722,29 @@</spa=
n><br><span> }</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Initialize a tunnel instance, handle p=
re and post-init</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
signal settings.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+init_instance_handle_signals(struc=
t context *c, const struct env_set *env, const unsigned int flags)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    pre_init_signal_catch();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    init_instance(c, env, flags);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    post_init_signal_ca=
tch();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * This is done so that signals thrown du=
ring</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * initiali=
zation can bring us back to</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * a management hold.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (IS_SIG(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        remap=
_signal(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
uninit_management_callback();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Close a tunnel ins=
tance.</span><br><span>  */</span><br><span> void</span><br><span>diff --gi=
t a/src/openvpn/init.h b/src/openvpn/init.h</span><br><span>index e89615b..=
97318ec 100644</span><br><span>--- a/src/openvpn/init.h</span><br><span>+++=
 b/src/openvpn/init.h</span><br><span>@@ -31,10 +31,6 @@</span><br><span>  =
*/</span><br><span> #define BASE_N_EVENTS 5</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void context_clear(struct context *=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void context_clear_1(struct context *c)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> vo=
id context_clear_2(struct context *c);</span><br><span> </span><br><span> v=
oid context_init_1(struct context *c);</span><br><span>@@ -64,8 +60,6 @@</s=
pan><br><span> void init_instance_handle_signals(struct context *c, const s=
truct env_set *env,</span><br><span>                                   cons=
t unsigned int flags);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void init_instance(struct context *c, const struct env_s=
et *env, const unsigned int flags);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> /**</span><br><span>  * Query for private k=
ey and auth-user-pass username/passwords.</span><br><span>  */</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1346?usp=3Demail">change 1346</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1346?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--XhJZgv+dTa0=--

