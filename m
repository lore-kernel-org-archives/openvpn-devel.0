From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 09:40:05 +0000
In-Reply-To: <gerrit.1753215725000.Ibf64c681e02ac572d339d4d98e75ceb0cd417c45@...2715...>
References: <gerrit.1753215725000.Ibf64c681e02ac572d339d4d98e75ceb0cd417c45@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <c8974281eacf4f908be4b920099a6108b62d433a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c4JYJ5XFFeQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: store
 multi_context address inside top instance
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--c4JYJ5XFFeQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
93?usp=3Demail )

Change subject: multi: store multi_context address inside top instance
......................................................................

multi: store multi_context address inside top instance

Future modifications to DCO require accessing the
server multi_context object.

Since it is currently a stack variable that is pointed
by no one, we'd need to pass it to all kind of functions
to ensure it can reach the DCO code.

To make the implementation simpler, it is preferable to
simply assign its address to a struct context's field.

While at it, make some multi_* functions static as they
used only inside multi.c, where they are defined.

Change-Id: Ibf64c681e02ac572d339d4d98e75ceb0cd417c45
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250723061034.20240-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
266.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/openvpn.h
3 files changed, 15 insertions(+), 18 deletions(-)




diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4696686..ec260a2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -290,9 +290,10 @@
 /*
  * Main initialization function, init multi_context object.
  */
-void
-multi_init(struct multi_context *m, struct context *t)
+static void
+multi_init(struct context *t)
 {
+    struct multi_context *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;

     msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d",
@@ -706,7 +707,7 @@
 /*
  * Called on shutdown or restart.
  */
-void
+static void
 multi_uninit(struct multi_context *m)
 {
     if (m->hash)
@@ -3922,14 +3923,14 @@
     }
 }

-void
-multi_top_init(struct multi_context *m, struct context *top)
+static void
+multi_top_init(struct context *top)
 {
-    inherit_context_top(&m->top, top);
-    m->top.c2.buffers =3D init_context_buffers(&top->c2.frame);
+    inherit_context_top(&top->multi->top, top);
+    top->multi->top.c2.buffers =3D init_context_buffers(&top->c2.frame);
 }

-void
+static void
 multi_top_free(struct multi_context *m)
 {
     close_context(&m->top, -1, CC_GC_FREE);
@@ -4324,6 +4325,7 @@
     struct multi_context multi;

     top->mode =3D CM_TOP;
+    top->multi =3D &multi;
     context_clear_2(top);

     /* initialize top-tunnel instance */
@@ -4334,10 +4336,10 @@
     }

     /* initialize global multi_context object */
-    multi_init(&multi, top);
+    multi_init(top);

     /* initialize our cloned top object */
-    multi_top_init(&multi, top);
+    multi_top_init(top);

     /* initialize management interface */
     init_management_callback_multi(&multi);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index fe9e847..8b2704c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -263,14 +263,6 @@
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */

-void multi_init(struct multi_context *m, struct context *t);
-
-void multi_uninit(struct multi_context *m);
-
-void multi_top_init(struct multi_context *m, struct context *top);
-
-void multi_top_free(struct multi_context *m);
-
 struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,
                                              struct link_socket *sock);

diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3c8ce39..7d48888 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -491,6 +491,9 @@
                                  *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
                                  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP.=
 */

+    struct multi_context *multi; /**< Pointer to the main P2MP context.
+                                  *   Non-NULL only when mode =3D=3D CM_TO=
P. */
+
     struct gc_arena gc;         /**< Garbage collection arena for
                                  *   allocations done in the scope of this
                                  *   context structure. */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1093?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibf64c681e02ac572d339d4d98e75ceb0cd417c45
Gerrit-Change-Number: 1093
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--c4JYJ5XFFeQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1093?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">multi: store multi_context address inside top=
 instance<br><br>Future modifications to DCO require accessing the<br>serve=
r multi_context object.<br><br>Since it is currently a stack variable that =
is pointed<br>by no one, we&#39;d need to pass it to all kind of functions<=
br>to ensure it can reach the DCO code.<br><br>To make the implementation s=
impler, it is preferable to<br>simply assign its address to a struct contex=
t&#39;s field.<br><br>While at it, make some multi_* functions static as th=
ey<br>used only inside multi.c, where they are defined.<br><br>Change-Id: I=
bf64c681e02ac572d339d4d98e75ceb0cd417c45<br>Signed-off-by: Antonio Quartull=
i &lt;antonio@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Message-Id: &lt;20250723061034.20240-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32266.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/openvpn.h<br>3 fil=
es changed, 15 insertions(+), 18 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex 4696686..ec260a2 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -290,9 +290,10 @@<=
/span><br><span> /*</span><br><span>  * Main initialization function, init =
multi_context object.</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-multi_init(struct multi_context *m, struct context *t)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+multi_init(struct context *t)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mult=
i_context *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UND=
EF;</span><br><span> </span><br><span>     msg(D_MULTI_LOW, &quot;MULTI: mu=
lti_init called, r=3D%d v=3D%d&quot;,</span><br><span>@@ -706,7 +707,7 @@</=
span><br><span> /*</span><br><span>  * Called on shutdown or restart.</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span> multi_uninit(struct multi_context *m)</span><br><span> {</span><br>=
<span>     if (m-&gt;hash)</span><br><span>@@ -3922,14 +3923,14 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_top_init(struct multi_context *m, struct context *top)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_top_init(struct conte=
xt *top)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    inherit_context_top(&amp;m-&gt;top, top);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    m-&gt;top.c2.buffers =3D init_context_b=
uffers(&amp;top-&gt;c2.frame);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    inherit_context_top(&amp;top-&gt;multi-&gt;top, top);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    top-&gt;multi-&gt;top.=
c2.buffers =3D init_context_buffers(&amp;top-&gt;c2.frame);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span> multi_top_free(struct multi_context *m)</span><br><span> {</s=
pan><br><span>     close_context(&amp;m-&gt;top, -1, CC_GC_FREE);</span><br=
><span>@@ -4324,6 +4325,7 @@</span><br><span>     struct multi_context mult=
i;</span><br><span> </span><br><span>     top-&gt;mode =3D CM_TOP;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    top-&gt;multi =3D &amp;m=
ulti;</span><br><span>     context_clear_2(top);</span><br><span> </span><b=
r><span>     /* initialize top-tunnel instance */</span><br><span>@@ -4334,=
10 +4336,10 @@</span><br><span>     }</span><br><span> </span><br><span>   =
  /* initialize global multi_context object */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    multi_init(top);</span><br><span>=
 </span><br><span>     /* initialize our cloned top object */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    multi_top_init(&amp;multi, top)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_top_init=
(top);</span><br><span> </span><br><span>     /* initialize management inte=
rface */</span><br><span>     init_management_callback_multi(&amp;multi);</=
span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span=
><br><span>index fe9e847..8b2704c 100644</span><br><span>--- a/src/openvpn/=
multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -263,1=
4 +263,6 @@</span><br><span>  * Called by mtcp.c, mudp.c, or other (to be w=
ritten) protocol drivers</span><br><span>  */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void multi_init(struct multi_cont=
ext *m, struct context *t);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_unin=
it(struct multi_context *m);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_top=
_init(struct multi_context *m, struct context *top);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void multi_top_free(struct multi_context *m);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct multi_instance =
*multi_create_instance(struct multi_context *m, const struct mroute_addr *r=
eal,</span><br><span>                                              struct l=
ink_socket *sock);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/openvpn.h b/src/openvpn/openvpn.h</span><br><span>index 3c8ce39..7d48888=
 100644</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/s=
rc/openvpn/openvpn.h</span><br><span>@@ -491,6 +491,9 @@</span><br><span>  =
                                *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,</sp=
an><br><span>                                  *   \c CM_CHILD_UDP, and \c =
CM_CHILD_TCP. */</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct multi_context *multi; /**&lt; Pointer to the main=
 P2MP context.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                             *   Non-NULL only when mode =3D=3D CM_TOP. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  struct gc_arena gc;         /**&lt; Garbage collection arena for</span><b=
r><span>                                  *   allocations done in the scope=
 of this</span><br><span>                                  *   context stru=
cture. */</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1093?usp=3Demail">change 1093</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1093?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibf64c681e02ac572d339d4d98e7=
5ceb0cd417c45 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1093 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--c4JYJ5XFFeQ=--

