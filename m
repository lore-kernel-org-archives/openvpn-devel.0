From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Dec 2024 11:53:49 +0000
In-Reply-To: <gerrit.1731290343000.If9e029bdac264dcc05b2d256c4d323315904a92b@...2715...>
References: <gerrit.1731290343000.If9e029bdac264dcc05b2d256c4d323315904a92b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <918288eec3c24d7a8c822871b991805d82be0c93-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S+46IDGFYrQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S+46IDGFYrQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/79=
9?usp=3Demail )

Change subject: Split init_key_ctx_bi into send/recv init
......................................................................

Split init_key_ctx_bi into send/recv init

This allows for only initialising one of the keys. This is needed
for epoch keys where key rotation of send/recv key can happen at
different time points.

Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241221223905.18820-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
151.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 38 insertions(+), 5 deletions(-)




diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index faf69fc..982fb01 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -938,8 +938,8 @@
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
@@ -947,13 +947,32 @@
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

@@ -971,6 +990,8 @@
         hmac_ctx_free(ctx->hmac);
         ctx->hmac =3D NULL;
     }
+    CLEAR(ctx->implicit_iv);
+    ctx->plaintext_blocks =3D 0;
 }

 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 4579b65..b3612fb 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -196,7 +196,9 @@
     int n;                      /**< The number of \c key objects stored
                                  *   in the \c key2.keys array. */
     struct key keys[2];         /**< Two unidirectional sets of %key
-                                 *   material. */
+                                 *   material. The first key is the client
+                                 *   (encrypts) to server (decrypts), the
+                                 *   second the server to client key. */
 };

 /**
@@ -349,6 +351,16 @@
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

 void init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b
Gerrit-Change-Number: 799
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--S+46IDGFYrQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/799?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Split init_key_ctx_bi into send/recv init<br><=
br>This allows for only initialising one of the keys. This is needed<br>for=
 epoch keys where key rotation of send/recv key can happen at<br>different =
time points.<br><br>Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b<br=
>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Message-Id: &lt;20241221223905.18820-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg30151.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>2 file=
s changed, 38 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span=
>index faf69fc..982fb01 100644</span><br><span>--- a/src/openvpn/crypto.c</=
span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -938,8 +938,8 =
@@</span><br><span> }</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-init_key_ctx_bi(struct key_ctx_bi *=
ctx, const struct key2 *key2,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                int key_direction, const struct key_type *kt, const=
 char *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_ke=
y_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     int key_direct=
ion, const struct key_type *kt, const char *name)</span><br><span> {</span>=
<br><span>     char log_prefix[128] =3D { 0 };</span><br><span>     struct =
key_direction_state kds;</span><br><span>@@ -947,13 +947,32 @@</span><br><s=
pan>     key_direction_state_init(&amp;kds, key_direction);</span><br><span=
> </span><br><span>     snprintf(log_prefix, sizeof(log_prefix), &quot;Outg=
oing %s&quot;, name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    init_key_ctx(&amp;ctx-&gt;encrypt, &amp;key2-&gt;keys[kds.out_key], kt,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_ctx(ct=
x, &amp;key2-&gt;keys[kds.out_key], kt,</span><br><span>                  O=
PENVPN_OP_ENCRYPT, log_prefix);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_recv(s=
truct key_ctx *ctx, const struct key2 *key2,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     int key_direction, const stru=
ct key_type *kt, const char *name)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char log_prefix[128] =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct key_direction_state kds;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    key_direction_state_init(&amp;kds, key_direction);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     snprintf=
(log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;, name);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    init_key_ctx(&amp;ctx-&gt;de=
crypt, &amp;key2-&gt;keys[kds.in_key], kt,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    init_key_ctx(ctx, &amp;key2-&gt;keys[kds.in_key]=
, kt,</span><br><span>                  OPENVPN_OP_DECRYPT, log_prefix);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key=
2 *key2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     int key_direction, const struct key_type *kt, const char *name)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    init_key_bi_ctx_send(&amp;ctx-&gt;encryp=
t, key2, key_direction, kt, name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    init_key_bi_ctx_recv(&amp;ctx-&gt;decrypt, key2, key_dir=
ection, kt, name);</span><br><span>     ctx-&gt;initialized =3D true;</span=
><br><span> }</span><br><span> </span><br><span>@@ -971,6 +990,8 @@</span><=
br><span>         hmac_ctx_free(ctx-&gt;hmac);</span><br><span>         ctx=
-&gt;hmac =3D NULL;</span><br><span>     }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    CLEAR(ctx-&gt;implicit_iv);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;plaintext_blocks =3D 0;</spa=
n><br><span> }</span><br><span> </span><br><span> void</span><br><span>diff=
 --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index =
4579b65..b3612fb 100644</span><br><span>--- a/src/openvpn/crypto.h</span><b=
r><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -196,7 +196,9 @@</spa=
n><br><span>     int n;                      /**&lt; The number of \c key o=
bjects stored</span><br><span>                                  *   in the =
\c key2.keys array. */</span><br><span>     struct key keys[2];         /**=
&lt; Two unidirectional sets of %key</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                 *   material. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
   *   material. The first key is the client</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 *   (encrypts) to=
 server (decrypts), the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                 *   second the server to client key. *=
/</span><br><span> };</span><br><span> </span><br><span> /**</span><br><spa=
n>@@ -349,6 +351,16 @@</span><br><span>                   const struct key_=
type *kt, int enc,</span><br><span>                   const char *prefix);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_s=
end(struct key_ctx *ctx, const struct key2 *key2,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                     int key_direction, const=
 struct key_type *kt,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     const char *name);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_=
ctx_recv(struct key_ctx *ctx, const struct key2 *key2,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     int key_direction, =
const struct key_type *kt,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     const char *name);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> void free_key_ctx(struct key_c=
tx *ctx);</span><br><span> </span><br><span> void init_key_ctx_bi(struct ke=
y_ctx_bi *ctx, const struct key2 *key2,</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/799?usp=3D=
email">change 799</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If9e029bdac264dcc05b2d256c4d=
323315904a92b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 799 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--S+46IDGFYrQ=--

