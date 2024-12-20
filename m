From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 20 Dec 2024 14:49:42 +0000
In-Reply-To: <gerrit.1731290343000.Id223612c7bcab91d49c013fb775024bd64ab0836@...2715...>
References: <gerrit.1731290343000.Id223612c7bcab91d49c013fb775024bd64ab0836@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <cb5fe479f99af0291367ffc955cab7e076483596-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qdjkdxcC9Ic="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move initialisation
 of implicit IVs to init_key_ctx_bi methods
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

--qdjkdxcC9Ic=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail

to look at the new patch set (#8).


Change subject: Move initialisation of implicit IVs to init_key_ctx_bi meth=
ods
......................................................................

Move initialisation of implicit IVs to init_key_ctx_bi methods

This is really more a function of initialising the data cipher and key
context and putting it into the init_key_ctx_bi makes more sense.

It will allow calling init_key_ctx_bi to fully initialise a
data channel key without calling some extra functions after that
which will make the (upcoming) epoch key implementation cleaner.

Also ensure that free_ctx_bi actually also sets initialized to false.

Change-Id: Id223612c7bcab91d49c013fb775024bd64ab0836
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto.c
M src/openvpn/ssl.c
M tests/unit_tests/openvpn/test_ssl.c
3 files changed, 30 insertions(+), 59 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/800/8

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 53f50de..67c4d3b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -900,6 +900,33 @@
     }
 }

+/**
+ * Update the implicit IV for a key_ctx_bi based on TLS session ids and ci=
pher
+ * used.
+ *
+ * Note that the implicit IV is based on the HMAC key, but only in AEAD mo=
des
+ * where the HMAC key is not used for an actual HMAC.
+ *
+ * @param ctx                   Encrypt/decrypt key context
+ * @param key                   key, hmac part used to calculate implicit =
IV
+ */
+static void
+key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct key *key)
+{
+    /* Only use implicit IV in AEAD cipher mode, where HMAC key is not use=
d */
+    if (cipher_ctx_mode_aead(ctx->cipher))
+    {
+        size_t impl_iv_len =3D 0;
+        ASSERT(cipher_ctx_iv_length(ctx->cipher) >=3D OPENVPN_AEAD_MIN_IV_=
LEN);
+        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
+        ASSERT(impl_iv_len + sizeof(packet_id_type) <=3D OPENVPN_MAX_IV_LE=
NGTH);
+        ASSERT(impl_iv_len <=3D MAX_HMAC_KEY_LENGTH);
+        CLEAR(ctx->implicit_iv);
+        /* The first bytes of the IV are filled with the packet id */
+        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key->hmac, impl_=
iv_len);
+    }
+}
+
 /* given a key and key_type, build a key_ctx */
 void
 init_key_ctx(struct key_ctx *ctx, const struct key *key,
@@ -958,7 +985,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
                  OPENVPN_OP_ENCRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.out_key]);
 }

 void
@@ -973,7 +1000,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
                  OPENVPN_OP_DECRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.in_key]);
 }

 void
@@ -1008,6 +1035,7 @@
 {
     free_key_ctx(&ctx->encrypt);
     free_key_ctx(&ctx->decrypt);
+    ctx->initialized =3D false;
 }

 static bool
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 73201ef..5adc6b1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -96,21 +96,6 @@
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */

 /**
- * Update the implicit IV for a key_ctx_bi based on TLS session ids and ci=
pher
- * used.
- *
- * Note that the implicit IV is based on the HMAC key, but only in AEAD mo=
des
- * where the HMAC key is not used for an actual HMAC.
- *
- * @param ctx                   Encrypt/decrypt key context
- * @param key                   HMAC key, used to calculate implicit IV
- * @param key_len               HMAC key length
- */
-static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en);
-
-
-/**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) ciphe=
r.
  *
  * @param cipher        The current cipher (may be NULL).
@@ -1411,12 +1396,6 @@
     else
     {
         init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel"=
);
-        /* Initialize implicit IVs */
-        key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].=
hmac,
-                                   MAX_HMAC_KEY_LENGTH);
-        key_ctx_update_implicit_iv(&key->decrypt,
-                                   key2->keys[1 - (int)server].hmac,
-                                   MAX_HMAC_KEY_LENGTH);
     }
 }

@@ -1553,23 +1532,6 @@
     return ret;
 }

-static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en)
-{
-    /* Only use implicit IV in AEAD cipher mode, where HMAC key is not use=
d */
-    if (cipher_ctx_mode_aead(ctx->cipher))
-    {
-        size_t impl_iv_len =3D 0;
-        ASSERT(cipher_ctx_iv_length(ctx->cipher) >=3D OPENVPN_AEAD_MIN_IV_=
LEN);
-        impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
-        ASSERT(impl_iv_len + sizeof(packet_id_type) <=3D OPENVPN_MAX_IV_LE=
NGTH);
-        ASSERT(impl_iv_len <=3D key_len);
-        CLEAR(ctx->implicit_iv);
-        /* The first bytes of the IV are filled with the packet id */
-        memcpy(ctx->implicit_iv + sizeof(packet_id_type), key, impl_iv_len=
);
-    }
-}
-
 /**
  * Generate data channel keys for the supplied TLS session.
  *
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index ae33cc6..caacd9e 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -277,24 +277,6 @@
 #endif /* HAVE_OPENSSL_STORE */
 }

-static void
-init_implicit_iv(struct crypto_options *co)
-{
-    cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;
-
-    if (cipher_ctx_mode_aead(cipher))
-    {
-        ASSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
-        ASSERT(cipher_ctx_iv_length(cipher) >=3D OPENVPN_AEAD_MIN_IV_LEN);
-
-        /* Generate dummy implicit IV */
-        ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
-                          OPENVPN_MAX_IV_LENGTH));
-
-        memcpy(co->key_ctx_bi.decrypt.implicit_iv,
-               co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
-    }
-}

 static void
 init_frame_parameters(struct frame *frame)
@@ -346,7 +328,6 @@
     /* init work */
     ASSERT(buf_init(&work, frame.buf.headroom));

-    init_implicit_iv(co);
     update_time();

     /* Test encryption, decryption for all packet sizes */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id223612c7bcab91d49c013fb775024bd64ab0836
Gerrit-Change-Number: 800
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--qdjkdxcC9Ic=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #8</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Move initialisation of implicit IVs to init_key_ctx_bi methods<br><br=
>This is really more a function of initialising the data cipher and key<br>=
context and putting it into the init_key_ctx_bi makes more sense.<br><br>It=
 will allow calling init_key_ctx_bi to fully initialise a<br>data channel k=
ey without calling some extra functions after that<br>which will make the (=
upcoming) epoch key implementation cleaner.<br><br>Also ensure that free_ct=
x_bi actually also sets initialized to false.<br><br>Change-Id: Id223612c7b=
cab91d49c013fb775024bd64ab0836<br>Signed-off-by: Arne Schwabe &lt;arne@...1386...=
227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/ssl.c<br>M tes=
ts/unit_tests/openvpn/test_ssl.c<br>3 files changed, 30 insertions(+), 59 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/00/800/8</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/cr=
ypto.c</span><br><span>index 53f50de..67c4d3b 100644</span><br><span>--- a/=
src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><=
span>@@ -900,6 +900,33 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Update the implicit IV=
 for a key_ctx_bi based on TLS session ids and cipher</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * used.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Note that the implicit IV is based on the HMAC key, but only in AE=
AD modes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * where th=
e HMAC key is not used for an actual HMAC.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param ctx                   Encrypt/decrypt key context</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key                =
   key, hmac part used to calculate implicit IV</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct key *key)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Only use implicit IV in AEAD ci=
pher mode, where HMAC key is not used */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (cipher_ctx_mode_aead(ctx-&gt;cipher))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        size_t impl_iv_len =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(cipher_ctx_i=
v_length(ctx-&gt;cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        impl_iv_len =3D cipher_ctx_i=
v_length(ctx-&gt;cipher) - sizeof(packet_id_type);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ASSERT(impl_iv_len + sizeof(packet_i=
d_type) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ASSERT(impl_iv_len &lt;=3D MAX_HMAC_KEY_LENGTH)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(ctx-=
&gt;implicit_iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* The first bytes of the IV are filled with the packet id */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(ctx-&gt;impl=
icit_iv + sizeof(packet_id_type), key-&gt;hmac, impl_iv_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /* given a key and key_type, build a key_ctx */=
</span><br><span> void</span><br><span> init_key_ctx(struct key_ctx *ctx, c=
onst struct key *key,</span><br><span>@@ -958,7 +985,7 @@</span><br><span> =
    snprintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&quot;, name)=
;</span><br><span>     init_key_ctx(ctx, &amp;key2-&gt;keys[kds.out_key], k=
t,</span><br><span>                  OPENVPN_OP_ENCRYPT, log_prefix);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    key_ctx_update_implicit_iv(ctx, &amp;key2-=
&gt;keys[kds.out_key]);</span><br><span> }</span><br><span> </span><br><spa=
n> void</span><br><span>@@ -973,7 +1000,7 @@</span><br><span>     snprintf(=
log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;, name);</span><br><=
span>     init_key_ctx(ctx, &amp;key2-&gt;keys[kds.in_key], kt,</span><br><=
span>                  OPENVPN_OP_DECRYPT, log_prefix);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    key_ctx_update_implicit_iv(ctx, &amp;key2-&gt;keys[kds.i=
n_key]);</span><br><span> }</span><br><span> </span><br><span> void</span><=
br><span>@@ -1008,6 +1035,7 @@</span><br><span> {</span><br><span>     free=
_key_ctx(&amp;ctx-&gt;encrypt);</span><br><span>     free_key_ctx(&amp;ctx-=
&gt;decrypt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ct=
x-&gt;initialized =3D false;</span><br><span> }</span><br><span> </span><br=
><span> static bool</span><br><span>diff --git a/src/openvpn/ssl.c b/src/op=
envpn/ssl.c</span><br><span>index 73201ef..5adc6b1 100644</span><br><span>-=
-- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><s=
pan>@@ -96,21 +96,6 @@</span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHA=
KE_STATS */</span><br><span> </span><br><span> /**</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Update the implicit IV for a key_ctx_bi bas=
ed on TLS session ids and cipher</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * used.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Note that the impl=
icit IV is based on the HMAC key, but only in AEAD modes</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * where the HMAC key is not used for an=
 actual HMAC.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ctx              =
     Encrypt/decrypt key context</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param key                   HMAC key, used to calculate impl=
icit IV</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param key_=
len               HMAC key length</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_ctx_update_i=
mplicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
**</span><br><span>  * Limit the reneg_bytes value when using a small-block=
 (&lt;128 bytes) cipher.</span><br><span>  *</span><br><span>  * @param cip=
her        The current cipher (may be NULL).</span><br><span>@@ -1411,12 +1=
396,6 @@</span><br><span>     else</span><br><span>     {</span><br><span> =
        init_key_ctx_bi(key, key2, key_direction, key_type, &quot;Data Chan=
nel&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 Initialize implicit IVs */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        key_ctx_update_implicit_iv(&amp;key-&gt;encrypt, key2-&gt;key=
s[(int)server].hmac,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                  MAX_HMAC_KEY_LENGTH);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        key_ctx_update_implicit_iv(&amp;k=
ey-&gt;decrypt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                             key2-&gt;keys[1 - (int)server].hmac,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
    MAX_HMAC_KEY_LENGTH);</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span>@@ -1553,23 +1532,6 @@</span><br><span>     retu=
rn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, =
size_t key_len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Only use implicit I=
V in AEAD cipher mode, where HMAC key is not used */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (cipher_ctx_mode_aead(ctx-&gt;cipher=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        size_t impl_iv_len =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_c=
tx_iv_length(ctx-&gt;cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        impl_iv_len =3D cipher_ctx=
_iv_length(ctx-&gt;cipher) - sizeof(packet_id_type);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(impl_iv_len + sizeof(packet_=
id_type) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        ASSERT(impl_iv_len &lt;=3D key_len);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(ctx-&gt;implicit_iv=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* The firs=
t bytes of the IV are filled with the packet id */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        memcpy(ctx-&gt;implicit_iv + sizeof(pa=
cket_id_type), key, impl_iv_len);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</s=
pan><br><span>  * Generate data channel keys for the supplied TLS session.<=
/span><br><span>  *</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index ae33c=
c6..caacd9e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span=
>@@ -277,24 +277,6 @@</span><br><span> #endif /* HAVE_OPENSSL_STORE */</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-init_implicit_iv(struct crypto_options *co)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi.encrypt.cipher;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (cipher_ctx_mode_aead(cipher))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_iv_length(cipher) &lt;=3D =
OPENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ASSERT(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_L=
EN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        /* Generate dummy implicit IV =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand=
_bytes(co-&gt;key_ctx_bi.encrypt.implicit_iv,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                          OPENVPN_MAX_IV_LENGTH));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        memcpy(co-&gt;key_ctx_bi.decrypt.im=
plicit_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
    co-&gt;key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span> </span><br><span> static vo=
id</span><br><span> init_frame_parameters(struct frame *frame)</span><br><s=
pan>@@ -346,7 +328,6 @@</span><br><span>     /* init work */</span><br><spa=
n>     ASSERT(buf_init(&amp;work, frame.buf.headroom));</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_implicit_iv(co=
);</span><br><span>     update_time();</span><br><span> </span><br><span>  =
   /* Test encryption, decryption for all packet sizes */</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/800?usp=3Demail">change 800</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/800?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id223612c7bcab91d49c013fb775=
024bd64ab0836 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 800 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qdjkdxcC9Ic=--

