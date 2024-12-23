From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 23 Dec 2024 09:28:35 +0000
In-Reply-To: <gerrit.1731290343000.Id223612c7bcab91d49c013fb775024bd64ab0836@...2715...>
References: <gerrit.1731290343000.Id223612c7bcab91d49c013fb775024bd64ab0836@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <25370394eee36ac26712499971b436ac6fa7ef37-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8HSGQfpAXX8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8HSGQfpAXX8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241222214541.11021-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
170.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/ssl.c
M tests/unit_tests/openvpn/test_ssl.c
3 files changed, 30 insertions(+), 59 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/800/9

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 982fb01..da503b3 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -891,6 +891,33 @@
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
@@ -949,7 +976,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
                  OPENVPN_OP_ENCRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.out_key]);
 }

 void
@@ -964,7 +991,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
                  OPENVPN_OP_DECRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.in_key]);
 }

 void
@@ -999,6 +1026,7 @@
 {
     free_key_ctx(&ctx->encrypt);
     free_key_ctx(&ctx->decrypt);
+    ctx->initialized =3D false;
 }

 static bool
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c77c4ed..a222d5b 100644
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
=20
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
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--8HSGQfpAXX8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #9</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
800?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Move initialisation of implicit IVs to init_key_ctx_=
bi methods<br><br>This is really more a function of initialising the data c=
ipher and key<br>context and putting it into the init_key_ctx_bi makes more=
 sense.<br><br>It will allow calling init_key_ctx_bi to fully initialise a<=
br>data channel key without calling some extra functions after that<br>whic=
h will make the (upcoming) epoch key implementation cleaner.<br><br>Also en=
sure that free_ctx_bi actually also sets initialized to false.<br><br>Chang=
e-Id: Id223612c7bcab91d49c013fb775024bd64ab0836<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&g=
t;<br>Message-Id: &lt;20241222214541.11021-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30170.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/crypto.c<br>M src/openvpn/ssl.c<br>M tests/unit_tests/openvpn/test_ss=
l.c<br>3 files changed, 30 insertions(+), 59 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/800/9</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index =
982fb01..da503b3 100644</span><br><span>--- a/src/openvpn/crypto.c</span><b=
r><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -891,6 +891,33 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Update the implicit IV for a key_ctx_bi based on TL=
S session ids and cipher</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * used.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Note that the implic=
it IV is based on the HMAC key, but only in AEAD modes</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * where the HMAC key is not used for an=
 actual HMAC.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx          =
         Encrypt/decrypt key context</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param key                   key, hmac part used to cal=
culate implicit IV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+key_ctx_update_implicit_i=
v(struct key_ctx *ctx, const struct key *key)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Only use implicit IV in AEAD cipher mode, where HMAC key is =
not used */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
cipher_ctx_mode_aead(ctx-&gt;cipher))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        size_t impl_iv_len =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ASSERT(cipher_ctx_iv_length(ctx-&gt;cipher) &gt;=
=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - si=
zeof(packet_id_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ASSERT(impl_iv_len + sizeof(packet_id_type) &lt;=3D OPENVPN_MAX_I=
V_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A=
SSERT(impl_iv_len &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        CLEAR(ctx-&gt;implicit_iv);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* The first bytes of t=
he IV are filled with the packet id */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + sizeof(packet_id_ty=
pe), key-&gt;hmac, impl_iv_len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
* given a key and key_type, build a key_ctx */</span><br><span> void</span>=
<br><span> init_key_ctx(struct key_ctx *ctx, const struct key *key,</span><=
br><span>@@ -949,7 +976,7 @@</span><br><span>     snprintf(log_prefix, size=
of(log_prefix), &quot;Outgoing %s&quot;, name);</span><br><span>     init_k=
ey_ctx(ctx, &amp;key2-&gt;keys[kds.out_key], kt,</span><br><span>          =
        OPENVPN_OP_ENCRYPT, log_prefix);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    key_ctx_update_implicit_iv(ctx, &amp;key2-&gt;keys[kds.out_key]);</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -9=
64,7 +991,7 @@</span><br><span>     snprintf(log_prefix, sizeof(log_prefix)=
, &quot;Incoming %s&quot;, name);</span><br><span>     init_key_ctx(ctx, &a=
mp;key2-&gt;keys[kds.in_key], kt,</span><br><span>                  OPENVPN=
_OP_DECRYPT, log_prefix);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key_ctx_upd=
ate_implicit_iv(ctx, &amp;key2-&gt;keys[kds.in_key]);</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span>@@ -999,6 +1026,7 @@<=
/span><br><span> {</span><br><span>     free_key_ctx(&amp;ctx-&gt;encrypt);=
</span><br><span>     free_key_ctx(&amp;ctx-&gt;decrypt);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;initialized =3D false;</s=
pan><br><span> }</span><br><span> </span><br><span> static bool</span><br><=
span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>ind=
ex c77c4ed..a222d5b 100644</span><br><span>--- a/src/openvpn/ssl.c</span><b=
r><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -96,21 +96,6 @@</span><b=
r><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span><br><span> </=
span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Update the implicit IV for a key_ctx_bi based on TLS session ids and ciphe=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * used.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * Note that the implicit IV is based on the HMAC ke=
y, but only in AEAD modes</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * where the HMAC key is not used for an actual HMAC.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param ctx                   Encrypt/decrypt key contex=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param key       =
            HMAC key, used to calculate implicit IV</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param key_len               HMAC key le=
ngth</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-key_ctx_update_implicit_iv(struct key_ctx *=
ctx, uint8_t *key, size_t key_len);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span>  * Limi=
t the reneg_bytes value when using a small-block (&lt;128 bytes) cipher.</s=
pan><br><span>  *</span><br><span>  * @param cipher        The current ciph=
er (may be NULL).</span><br><span>@@ -1411,12 +1396,6 @@</span><br><span>  =
   else</span><br><span>     {</span><br><span>         init_key_ctx_bi(key=
, key2, key_direction, key_type, &quot;Data Channel&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* Initialize implicit IVs */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        key_ctx_updat=
e_implicit_iv(&amp;key-&gt;encrypt, key2-&gt;keys[(int)server].hmac,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
       MAX_HMAC_KEY_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        key_ctx_update_implicit_iv(&amp;key-&gt;decrypt,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
  key2-&gt;keys[1 - (int)server].hmac,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                   MAX_HMAC_KEY_LENGTH);</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span>=
@@ -1553,23 +1532,6 @@</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_ctx_update=
_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* Only use implicit IV in AEAD cipher mode, wher=
e HMAC key is not used */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (cipher_ctx_mode_aead(ctx-&gt;cipher))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        size_t impl_iv_len =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_iv_length(ctx-&gt;cipher)=
 &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) -=
 sizeof(packet_id_type);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ASSERT(impl_iv_len + sizeof(packet_id_type) &lt;=3D OPENVPN_MAX_=
IV_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        AS=
SERT(impl_iv_len &lt;=3D key_len);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        CLEAR(ctx-&gt;implicit_iv);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* The first bytes of the IV are filled =
with the packet id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        memcpy(ctx-&gt;implicit_iv + sizeof(packet_id_type), key, impl_iv_l=
en);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Generate da=
ta channel keys for the supplied TLS session.</span><br><span>  *</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/=
openvpn/test_ssl.c</span><br><span>index ae33cc6..caacd9e 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -277,24 +277,6 @@</span><=
br><span> #endif /* HAVE_OPENSSL_STORE */</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-init_implicit_iv(struct cryp=
to_options *co)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    cipher_ctx_t *cipher =
=3D co-&gt;key_ctx_bi.encrypt.cipher;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (cipher_ctx_mode_aead(cipher))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   ASSERT(cipher_ctx_iv_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_=
iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* Generate dummy implicit IV */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(co-&gt;key_ctx_bi=
.encrypt.implicit_iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                          OPENVPN_MAX_IV_LENGTH));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        memcpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-               co-&gt;key_ctx_bi.en=
crypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span> </span><br><span> static void</span><br><span> init=
_frame_parameters(struct frame *frame)</span><br><span>@@ -346,7 +328,6 @@<=
/span><br><span>     /* init work */</span><br><span>     ASSERT(buf_init(&=
amp;work, frame.buf.headroom));</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    init_implicit_iv(co);</span><br><span>     =
update_time();</span><br><span> </span><br><span>     /* Test encryption, d=
ecryption for all packet sizes */</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail"=
>change 800</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id223612c7bcab91d49c013fb775=
024bd64ab0836 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 800 </div>
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


--8HSGQfpAXX8=--

