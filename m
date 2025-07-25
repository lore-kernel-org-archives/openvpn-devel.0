From: "ordex (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 23:51:02 +0000
References: <gerrit.1753487460000.Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8cb692211253898a82e58e579914ce0457d24797-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="z2qB25MTQh4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: make
 multi_process_float() static
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

--z2qB25MTQh4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail

to review the following change.


Change subject: multi: make multi_process_float() static
......................................................................

multi: make multi_process_float() static

multi_process_float() is invoked only within multi.c, which
is where it is defined.

For this reason we can make it static and drop its declaration
in multi.h.

Change-Id: Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/multi.c
M src/openvpn/multi.h
2 files changed, 9 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1115/1

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c5691ff..d23aee7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
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
index 8b2704c..eb5bf86 100644
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547
Gerrit-Change-Number: 1115
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--z2qB25MTQh4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">multi: make multi_process_float() static<br><br>multi_proces=
s_float() is invoked only within multi.c, which<br>is where it is defined.<=
br><br>For this reason we can make it static and drop its declaration<br>in=
 multi.h.<br><br>Change-Id: Id5e06f0822a3e7e4ad1b6f93caaefdb6a8cfe547<br>Si=
gned-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/o=
penvpn/multi.c<br>M src/openvpn/multi.h<br>2 files changed, 9 insertions(+)=
, 12 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/15/1115/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index c5691ff..d23aee7 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -3210,7 +3210,15 @@</span><br><span>     return ret;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Handles peer floating.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * If peer is floated to a taken addre=
ss, either drops packet</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * (if peer that owns address has different CN) or disconnects</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * existing peer. Updates mu=
lti_instance with new address,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * updates hashtables in multi_context.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span> multi_process_float(struct mult=
i_context *m, struct multi_instance *mi,</span><br><span>                  =
   struct link_socket *sock)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index 8b2704c..=
eb5bf86 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><span>++=
+ b/src/openvpn/multi.h</span><br><span>@@ -270,17 +270,6 @@</span><br><spa=
n> </span><br><span> bool multi_process_timeout(struct multi_context *m, co=
nst unsigned int mpp_flags);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Handles peer floating.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If pe=
er is floated to a taken address, either drops packet</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * (if peer that owns address has different=
 CN) or disconnects</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 existing peer. Updates multi_instance with new address,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * updates hashtables in multi_context.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void multi_process_float(struct multi_co=
ntext *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                         struct link_socket *sock);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define MPP_=
PRE_SELECT             (1&lt;&lt;0)</span><br><span> #define MPP_CONDITIONA=
L_PRE_SELECT (1&lt;&lt;1)</span><br><span> #define MPP_CLOSE_ON_SIGNAL     =
   (1&lt;&lt;2)</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1115?usp=3Demail">change 1115</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1115?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id5e06f0822a3e7e4ad1b6f93caa=
efdb6a8cfe547 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1115 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--z2qB25MTQh4=--

