From: "ordex (Code Review)" <gerrit@...515...>
Date: Sat, 26 Jul 2025 00:08:34 +0000
In-Reply-To: <gerrit.1753487460000.Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547@...2715...>
References: <gerrit.1753487460000.Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <064107a0ea336a755d7faa31510695b9d517bb02-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eIF1xVSKD84="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: make some
 multi_*() functions static
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

--eIF1xVSKD84=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail

to look at the new patch set (#2).


Change subject: multi: make some multi_*() functions static
......................................................................

multi: make some multi_*() functions static

multi_process_float() and multi_print_status() are both invoked only
within multi.c, which is where they is defined.

For this reason we can make them static and drop their declaration
from multi.h.

Change-Id: Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/multi.c
M src/openvpn/multi.h
2 files changed, 10 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1115/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c5691ff..c90ed5b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -849,7 +849,7 @@
  * If status file is defined, write to file.
  * If status file is NULL, write to syslog.
  */
-void
+static void
 multi_print_status(struct multi_context *m, struct status_output *so, cons=
t int version)
 {
     if (m->hash)
@@ -3210,7 +3210,15 @@
     return ret;
 }

-void
+/**
+ * Handles peer floating.
+ *
+ * If peer is floated to a taken address, either drops packet
+ * (if peer that owns address has different CN) or disconnects
+ * existing peer. Updates multi_instance with new address,
+ * updates hashtables in multi_context.
+ */
+static void
 multi_process_float(struct multi_context *m, struct multi_instance *mi,
                     struct link_socket *sock)
 {
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 8b2704c..3c821d7 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -270,17 +270,6 @@

 bool multi_process_timeout(struct multi_context *m, const unsigned int mpp=
_flags);

-/**
- * Handles peer floating.
- *
- * If peer is floated to a taken address, either drops packet
- * (if peer that owns address has different CN) or disconnects
- * existing peer. Updates multi_instance with new address,
- * updates hashtables in multi_context.
- */
-void multi_process_float(struct multi_context *m, struct multi_instance *m=
i,
-                         struct link_socket *sock);
-
 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
 #define MPP_CLOSE_ON_SIGNAL        (1<<2)
@@ -370,8 +359,6 @@

 void multi_process_drop_outgoing_tun(struct multi_context *m, const unsign=
ed int mpp_flags);

-void multi_print_status(struct multi_context *m, struct status_output *so,=
 const int version);
-
 struct multi_instance *multi_get_queue(struct mbuf_set *ms);

 void multi_add_mbuf(struct multi_context *m,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547
Gerrit-Change-Number: 1115
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--eIF1xVSKD84=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">multi: make some multi_*() functions static<br><br>multi_process_float()=
 and multi_print_status() are both invoked only<br>within multi.c, which is=
 where they is defined.<br><br>For this reason we can make them static and =
drop their declaration<br>from multi.h.<br><br>Change-Id: Id5e06f0822a3e7e4=
ad1b6f93caaefdb6a8cfe547<br>Signed-off-by: Antonio Quartulli &lt;antonio@...1186...=
.2726...&gt;<br>---<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>2 =
files changed, 10 insertions(+), 15 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/15/1115/2</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index c5691ff..c=
90ed5b 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++=
 b/src/openvpn/multi.c</span><br><span>@@ -849,7 +849,7 @@</span><br><span>=
  * If status file is defined, write to file.</span><br><span>  * If status=
 file is NULL, write to syslog.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span> multi_print_status(struct mul=
ti_context *m, struct status_output *so, const int version)</span><br><span=
> {</span><br><span>     if (m-&gt;hash)</span><br><span>@@ -3210,7 +3210,1=
5 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Handles peer floating.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * If peer is floated to a taken address, either drops packet</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (if peer that owns =
address has different CN) or disconnects</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * existing peer. Updates multi_instance with new addr=
ess,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * updates hash=
tables in multi_context.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span> multi_process_float(struct multi_context *m, struct multi=
_instance *mi,</span><br><span>                     struct link_socket *soc=
k)</span><br><span> {</span><br><span>diff --git a/src/openvpn/multi.h b/sr=
c/openvpn/multi.h</span><br><span>index 8b2704c..3c821d7 100644</span><br><=
span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</s=
pan><br><span>@@ -270,17 +270,6 @@</span><br><span> </span><br><span> bool =
multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Handles peer flo=
ating.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * If peer is floated to a taken a=
ddress, either drops packet</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * (if peer that owns address has different CN) or disconnects</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * existing peer. Updates mu=
lti_instance with new address,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * updates hashtables in multi_context.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void multi_process_float(struct multi_context *m, struct multi_ins=
tance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
              struct link_socket *sock);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> #define MPP_PRE_SELECT             (1&=
lt;&lt;0)</span><br><span> #define MPP_CONDITIONAL_PRE_SELECT (1&lt;&lt;1)<=
/span><br><span> #define MPP_CLOSE_ON_SIGNAL        (1&lt;&lt;2)</span><br>=
<span>@@ -370,8 +359,6 @@</span><br><span> </span><br><span> void multi_pro=
cess_drop_outgoing_tun(struct multi_context *m, const unsigned int mpp_flag=
s);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void multi_print_status(struct multi_context *m, struct status_output *so, =
const int version);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> struct multi_instance *multi_get_queue(struct mbuf_set *ms)=
;</span><br><span> </span><br><span> void multi_add_mbuf(struct multi_conte=
xt *m,</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail">change 1115</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1115?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id5e06f0822a3e7e4ad1b6f93caa=
efdb6a8cfe547 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1115 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--eIF1xVSKD84=--

