From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 09:40:02 +0000
In-Reply-To: <gerrit.1753215725000.Ibf64c681e02ac572d339d4d98e75ceb0cd417c45@...2715...>
References: <gerrit.1753215725000.Ibf64c681e02ac572d339d4d98e75ceb0cd417c45@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <c8974281eacf4f908be4b920099a6108b62d433a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZjP++Ci1alE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZjP++Ci1alE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1093?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1093/2

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
Gerrit-MessageType: newpatchset

--ZjP++Ci1alE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1093=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">multi: store multi_context address inside top instan=
ce<br><br>Future modifications to DCO require accessing the<br>server multi=
_context object.<br><br>Since it is currently a stack variable that is poin=
ted<br>by no one, we&#39;d need to pass it to all kind of functions<br>to e=
nsure it can reach the DCO code.<br><br>To make the implementation simpler,=
 it is preferable to<br>simply assign its address to a struct context&#39;s=
 field.<br><br>While at it, make some multi_* functions static as they<br>u=
sed only inside multi.c, where they are defined.<br><br>Change-Id: Ibf64c68=
1e02ac572d339d4d98e75ceb0cd417c45<br>Signed-off-by: Antonio Quartulli &lt;a=
ntonio@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>=
Message-Id: &lt;20250723061034.20240-1-gert@...1296...&gt;<br>URL: https://=
www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32266.html<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/=
multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/openvpn.h<br>3 files chan=
ged, 15 insertions(+), 18 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/93/1093/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/multi.c b/src/openvpn/multi.c</span><br><span>index 4696686..ec260a2 100=
644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/ope=
nvpn/multi.c</span><br><span>@@ -290,9 +290,10 @@</span><br><span> /*</span=
><br><span>  * Main initialization function, init multi_context object.</sp=
an><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_init(struct mul=
ti_context *m, struct context *t)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+multi_init(struct context *t)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D t-&gt;mu=
lti;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</span><br><span> </sp=
an><br><span>     msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=
=3D%d&quot;,</span><br><span>@@ -706,7 +707,7 @@</span><br><span> /*</span>=
<br><span>  * Called on shutdown or restart.</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span> multi_uninit(stru=
ct multi_context *m)</span><br><span> {</span><br><span>     if (m-&gt;hash=
)</span><br><span>@@ -3922,14 +3923,14 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_top_in=
it(struct multi_context *m, struct context *top)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_top_init(struct context *top)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    inherit_context_t=
op(&amp;m-&gt;top, top);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    m-&gt;top.c2.buffers =3D init_context_buffers(&amp;top-&gt;c2.frame)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inherit_contex=
t_top(&amp;top-&gt;multi-&gt;top, top);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    top-&gt;multi-&gt;top.c2.buffers =3D init_context_b=
uffers(&amp;top-&gt;c2.frame);</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span> multi_top_free(=
struct multi_context *m)</span><br><span> {</span><br><span>     close_cont=
ext(&amp;m-&gt;top, -1, CC_GC_FREE);</span><br><span>@@ -4324,6 +4325,7 @@<=
/span><br><span>     struct multi_context multi;</span><br><span> </span><b=
r><span>     top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    top-&gt;multi =3D &amp;multi;</span><br><span>     co=
ntext_clear_2(top);</span><br><span> </span><br><span>     /* initialize to=
p-tunnel instance */</span><br><span>@@ -4334,10 +4336,10 @@</span><br><spa=
n>     }</span><br><span> </span><br><span>     /* initialize global multi_=
context object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
multi_init(&amp;multi, top);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    multi_init(top);</span><br><span> </span><br><span>     /* ini=
tialize our cloned top object */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    multi_top_init(&amp;multi, top);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    multi_top_init(top);</span><br><span> </spa=
n><br><span>     /* initialize management interface */</span><br><span>    =
 init_management_callback_multi(&amp;multi);</span><br><span>diff --git a/s=
rc/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index fe9e847..8b2=
704c 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b=
/src/openvpn/multi.h</span><br><span>@@ -263,14 +263,6 @@</span><br><span> =
 * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers</spa=
n><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void multi_init(struct multi_context *m, struct context *t);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void multi_uninit(struct multi_context *m);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void multi_top_init(struct multi_context *=
m, struct context *top);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_top_fre=
e(struct multi_context *m);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> struct multi_instance *multi_create_instance(struct=
 multi_context *m, const struct mroute_addr *real,</span><br><span>        =
                                      struct link_socket *sock);</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn/op=
envpn.h</span><br><span>index 3c8ce39..7d48888 100644</span><br><span>--- a=
/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><b=
r><span>@@ -491,6 +491,9 @@</span><br><span>                               =
   *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,</span><br><span>                =
                  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP. */</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mul=
ti_context *multi; /**&lt; Pointer to the main P2MP context.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
*   Non-NULL only when mode =3D=3D CM_TOP. */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     struct gc_arena gc;        =
 /**&lt; Garbage collection arena for</span><br><span>                     =
             *   allocations done in the scope of this</span><br><span>    =
                              *   context structure. */</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1093?usp=3Demail">change 1093</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1093?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ZjP++Ci1alE=--

