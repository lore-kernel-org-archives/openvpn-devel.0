From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Dec 2024 11:53:47 +0000
In-Reply-To: <gerrit.1731290343000.If9e029bdac264dcc05b2d256c4d323315904a92b@...2715...>
References: <gerrit.1731290343000.If9e029bdac264dcc05b2d256c4d323315904a92b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <918288eec3c24d7a8c822871b991805d82be0c93-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2+48z9gTNp0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2+48z9gTNp0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/799/9

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
Gerrit-MessageType: newpatchset

--2+48z9gTNp0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #9</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
799?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Split init_key_ctx_bi into send/recv init<br><br>Thi=
s allows for only initialising one of the keys. This is needed<br>for epoch=
 keys where key rotation of send/recv key can happen at<br>different time p=
oints.<br><br>Change-Id: If9e029bdac264dcc05b2d256c4d323315904a92b<br>Signe=
d-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &l=
t;gert@...1296...&gt;<br>Message-Id: &lt;20241221223905.18820-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg30151.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>2 files chan=
ged, 38 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/99/799/9</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/crypto.c b/src/openvpn/crypto.c</span><br><span>index faf69fc..982fb01 100=
644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/op=
envpn/crypto.c</span><br><span>@@ -938,8 +938,8 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key=
2,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                int=
 key_direction, const struct key_type *kt, const char *name)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_send(struct key_ct=
x *ctx, const struct key2 *key2,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                     int key_direction, const struct key_type =
*kt, const char *name)</span><br><span> {</span><br><span>     char log_pre=
fix[128] =3D { 0 };</span><br><span>     struct key_direction_state kds;</s=
pan><br><span>@@ -947,13 +947,32 @@</span><br><span>     key_direction_stat=
e_init(&amp;kds, key_direction);</span><br><span> </span><br><span>     snp=
rintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&quot;, name);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_ctx(&amp;ctx-&=
gt;encrypt, &amp;key2-&gt;keys[kds.out_key], kt,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    init_key_ctx(ctx, &amp;key2-&gt;keys[kds.o=
ut_key], kt,</span><br><span>                  OPENVPN_OP_ENCRYPT, log_pref=
ix);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+init_key_bi_ctx_recv(struct key_ctx *ctx, const s=
truct key2 *key2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   int key_direction, const struct key_type *kt, const char=
 *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char log_prefix[128] =3D {=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key=
_direction_state kds;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key_direction=
_state_init(&amp;kds, key_direction);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     snprintf(log_prefix, sizeof(log_pre=
fix), &quot;Incoming %s&quot;, name);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    init_key_ctx(&amp;ctx-&gt;decrypt, &amp;key2-&gt;keys[k=
ds.in_key], kt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
init_key_ctx(ctx, &amp;key2-&gt;keys[kds.in_key], kt,</span><br><span>     =
             OPENVPN_OP_DECRYPT, log_prefix);</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key=
_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                int key_direction, con=
st struct key_type *kt, const char *name)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    init_key_bi_ctx_send(&amp;ctx-&gt;encrypt, key2, key_direction, kt,=
 name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key=
_bi_ctx_recv(&amp;ctx-&gt;decrypt, key2, key_direction, kt, name);</span><b=
r><span>     ctx-&gt;initialized =3D true;</span><br><span> }</span><br><sp=
an> </span><br><span>@@ -971,6 +990,8 @@</span><br><span>         hmac_ctx_=
free(ctx-&gt;hmac);</span><br><span>         ctx-&gt;hmac =3D NULL;</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(ctx-&gt;implicit_iv);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ctx-&gt;plaintext_blocks =3D 0;</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span>diff --git a/src/openvpn/crypto=
.h b/src/openvpn/crypto.h</span><br><span>index 4579b65..b3612fb 100644</sp=
an><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/c=
rypto.h</span><br><span>@@ -196,7 +196,9 @@</span><br><span>     int n;    =
                  /**&lt; The number of \c key objects stored</span><br><sp=
an>                                  *   in the \c key2.keys array. */</spa=
n><br><span>     struct key keys[2];         /**&lt; Two unidirectional set=
s of %key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                     *   material. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                 *   material. The first =
key is the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               *   (encrypts) to server (decrypts), the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
          *   second the server to client key. */</span><br><span> };</span=
><br><span> </span><br><span> /**</span><br><span>@@ -349,6 +351,16 @@</spa=
n><br><span>                   const struct key_type *kt, int enc,</span><b=
r><span>                   const char *prefix);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_send(struct key_ctx *ctx, co=
nst struct key2 *key2,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     int key_direction, const struct key_type *kt,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                     cons=
t char *name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_recv(struct key_ctx *ct=
x, const struct key2 *key2,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                     int key_direction, const struct key_type *kt,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
 const char *name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> void free_key_ctx(struct key_ctx *ctx);</span><br><span> =
</span><br><span> void init_key_ctx_bi(struct key_ctx_bi *ctx, const struct=
 key2 *key2,</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/799?usp=3Demail">change 799</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/799?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--2+48z9gTNp0=--

