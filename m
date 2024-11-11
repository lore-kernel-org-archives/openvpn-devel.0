From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 01:59:48 +0000
References: <gerrit.1731290343000.If9e029bdac264dcc05b2d256c4d323315904a92b@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a93ba4ed256c4d8ac55d3798af9643bda876d23f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AlyZ8apNdx0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Split
 init_key_ctx_bi into send/recv init
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

--AlyZ8apNdx0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail

to review the following change.


Change subject: Split init_key_ctx_bi into send/recv init
......................................................................

Split init_key_ctx_bi into send/recv init

This allows for only initialising one of the keys. This is needed
for epoch keys where key rotation of send/recv key can happen at
different time points.

Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 38 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/799/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a366474..f0b60a3 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -939,8 +939,8 @@
 }

 void
-init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
-                int key_direction, const struct key_type *kt, const char *=
name)
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt, const c=
har *name)
 {
     char log_prefix[128] =3D { 0 };
     struct key_direction_state kds;
@@ -948,13 +948,32 @@
     key_direction_state_init(&kds, key_direction);

     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
-    init_key_ctx(&ctx->encrypt, &key2->keys[kds.out_key], kt,
+    init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
                  OPENVPN_OP_ENCRYPT, log_prefix);

+}
+
+void
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt, const c=
har *name)
+{
+    char log_prefix[128] =3D { 0 };
+    struct key_direction_state kds;
+
+    key_direction_state_init(&kds, key_direction);
+
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
-    init_key_ctx(&ctx->decrypt, &key2->keys[kds.in_key], kt,
+    init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
                  OPENVPN_OP_DECRYPT, log_prefix);

+}
+
+void
+init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
+                int key_direction, const struct key_type *kt, const char *=
name)
+{
+    init_key_bi_ctx_send(&ctx->encrypt, key2, key_direction, kt, name);
+    init_key_bi_ctx_recv(&ctx->decrypt, key2, key_direction, kt, name);
     ctx->initialized =3D true;
 }

@@ -972,6 +991,8 @@
         hmac_ctx_free(ctx->hmac);
         ctx->hmac =3D NULL;
     }
+    CLEAR(ctx->implicit_iv);
+    ctx->plaintext_blocks =3D 0;
 }

 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 0ae86f4..3331672 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -189,7 +189,9 @@
     int n;                      /**< The number of \c key objects stored
                                  *   in the \c key2.keys array. */
     struct key keys[2];         /**< Two unidirectional sets of %key
-                                 *   material. */
+                                 *   material. The first key is the client
+                                 *   (encrypts) to server (decrypts), the
+                                 *   second the server to client key. */
 };

 /**
@@ -342,6 +344,16 @@
                   const struct key_type *kt, int enc,
                   const char *prefix);

+void
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt,
+                     const char *name);
+
+void
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
+                     int key_direction, const struct key_type *kt,
+                     const char *name);
+
 void free_key_ctx(struct key_ctx *ctx);
=20
 void init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b
Gerrit-Change-Number: 799
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--AlyZ8apNdx0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Split init_key_ctx_bi into send/recv init<br><br>This allows =
for only initialising one of the keys. This is needed<br>for epoch keys whe=
re key rotation of send/recv key can happen at<br>different time points.<br=
><br>Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b<br>Signed-off-by:=
 Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M=
 src/openvpn/crypto.h<br>2 files changed, 38 insertions(+), 5 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/7=
99/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span=
><br><span>index a366474..f0b60a3 100644</span><br><span>--- a/src/openvpn/=
crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -939=
,8 +939,8 @@</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-init_key_ctx_bi(struct ke=
y_ctx_bi *ctx, const struct key2 *key2,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                int key_direction, const struct key_type =
*kt, const char *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                     int =
key_direction, const struct key_type *kt, const char *name)</span><br><span=
> {</span><br><span>     char log_prefix[128] =3D { 0 };</span><br><span>  =
   struct key_direction_state kds;</span><br><span>@@ -948,13 +948,32 @@</s=
pan><br><span>     key_direction_state_init(&amp;kds, key_direction);</span=
><br><span> </span><br><span>     snprintf(log_prefix, sizeof(log_prefix), =
&quot;Outgoing %s&quot;, name);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    init_key_ctx(&amp;ctx-&gt;encrypt, &amp;key2-&gt;keys[kds.out=
_key], kt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_=
key_ctx(ctx, &amp;key2-&gt;keys[kds.out_key], kt,</span><br><span>         =
         OPENVPN_OP_ENCRYPT, log_prefix);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_=
ctx_recv(struct key_ctx *ctx, const struct key2 *key2,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     int key_direction, =
const struct key_type *kt, const char *name)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char log_prefix[128] =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct key_direction_state kds;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    key_direction_state_init(&amp;kds, key_direction);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  snprintf(log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;, name);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_ctx(&amp;=
ctx-&gt;decrypt, &amp;key2-&gt;keys[kds.in_key], kt,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    init_key_ctx(ctx, &amp;key2-&gt;keys[=
kds.in_key], kt,</span><br><span>                  OPENVPN_OP_DECRYPT, log_=
prefix);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+init_key_ctx_bi(struct key_ctx_bi *ctx, const=
 struct key2 *key2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                int key_direction, const struct key_type *kt, const char *n=
ame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    init_key_bi_ctx_send(&amp;ctx=
-&gt;encrypt, key2, key_direction, kt, name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    init_key_bi_ctx_recv(&amp;ctx-&gt;decrypt, ke=
y2, key_direction, kt, name);</span><br><span>     ctx-&gt;initialized =3D =
true;</span><br><span> }</span><br><span> </span><br><span>@@ -972,6 +991,8=
 @@</span><br><span>         hmac_ctx_free(ctx-&gt;hmac);</span><br><span> =
        ctx-&gt;hmac =3D NULL;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(ctx-&gt;implicit_iv);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;plaintext_blocks =
=3D 0;</span><br><span> }</span><br><span> </span><br><span> void</span><br=
><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><=
span>index 0ae86f4..3331672 100644</span><br><span>--- a/src/openvpn/crypto=
.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -189,7 +18=
9,9 @@</span><br><span>     int n;                      /**&lt; The number =
of \c key objects stored</span><br><span>                                  =
*   in the \c key2.keys array. */</span><br><span>     struct key keys[2]; =
        /**&lt; Two unidirectional sets of %key</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                 *   material. */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
              *   material. The first key is the client</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                 *   (e=
ncrypts) to server (decrypts), the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                 *   second the server to cl=
ient key. */</span><br><span> };</span><br><span> </span><br><span> /**</sp=
an><br><span>@@ -342,6 +344,16 @@</span><br><span>                   const =
struct key_type *kt, int enc,</span><br><span>                   const char=
 *prefix);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_k=
ey_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     int key_direc=
tion, const struct key_type *kt,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                     const char *name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                     int key=
_direction, const struct key_type *kt,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     const char *name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void free_key_ctx(=
struct key_ctx *ctx);</span><br><span> </span><br><span> void init_key_ctx_=
bi(struct key_ctx_bi *ctx, const struct key2 *key2,</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/799?usp=3Demail">change 799</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If9e029bdac264dcc05b2d256c4d=
323315904a92b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 799 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--AlyZ8apNdx0=--

