From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 01:59:50 +0000
References: <gerrit.1731290343000.Id223612c7bcab91d49c013fb775024bd64ab0836@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1f3d1369ef5f4f20c559c21112f737d5dc72c22c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zaRe/kYpPOY="; charset=UTF-8
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

--zaRe/kYpPOY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/800/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index f0b60a3..44c226c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -892,6 +892,33 @@
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
+        ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
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
@@ -950,7 +977,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
                  OPENVPN_OP_ENCRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.out_key]);
 }

 void
@@ -965,7 +992,7 @@
     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
                  OPENVPN_OP_DECRYPT, log_prefix);
-
+    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.in_key]);
 }

 void
@@ -1000,6 +1027,7 @@
 {
     free_key_ctx(&ctx->encrypt);
     free_key_ctx(&ctx->decrypt);
+    ctx->initialized =3D false;
 }

 static bool
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2d6cf64..9eaf3ac 100644
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
@@ -1409,12 +1394,6 @@
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

@@ -1551,23 +1530,6 @@
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
-        ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--zaRe/kYpPOY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Move initialisation of implicit IVs to init_key_ctx_bi method=
s<br><br>This is really more a function of initialising the data cipher and=
 key<br>context and putting it into the init_key_ctx_bi makes more sense.<b=
r><br>It will allow calling init_key_ctx_bi to fully initialise a<br>data c=
hannel key without calling some extra functions after that<br>which will ma=
ke the (upcoming) epoch key implementation cleaner.<br><br>Also ensure that=
 free_ctx_bi actually also sets initialized to false.<br><br>Change-Id: Id2=
23612c7bcab91d49c013fb775024bd64ab0836<br>Signed-off-by: Arne Schwabe &lt;a=
rne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/ssl.c<=
br>M tests/unit_tests/openvpn/test_ssl.c<br>3 files changed, 30 insertions(=
+), 59 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/00/800/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/op=
envpn/crypto.c</span><br><span>index f0b60a3..44c226c 100644</span><br><spa=
n>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</sp=
an><br><span>@@ -892,6 +892,33 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Update the imp=
licit IV for a key_ctx_bi based on TLS session ids and cipher</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * used.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Note that the implicit IV is based on the HMAC key, but on=
ly in AEAD modes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
where the HMAC key is not used for an actual HMAC.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param ctx                   Encrypt/decrypt key context</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key        =
           key, hmac part used to calculate implicit IV</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct ke=
y *key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Only use implicit IV in=
 AEAD cipher mode, where HMAC key is not used */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (cipher_ctx_mode_aead(ctx-&gt;cipher))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        size_t impl_iv_len =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(ciphe=
r_ctx_iv_length(ctx-&gt;cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        impl_iv_len =3D ciphe=
r_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_id_type);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(impl_iv_len &lt;=3D OP=
ENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ASSERT(impl_iv_len &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(ctx-&gt;implicit_iv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The first=
 bytes of the IV are filled with the packet id */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        memcpy(ctx-&gt;implicit_iv + sizeof(p=
acket_id_type), key-&gt;hmac, impl_iv_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /* given a key and key_type, build a key_ctx */</span><br><span> =
void</span><br><span> init_key_ctx(struct key_ctx *ctx, const struct key *k=
ey,</span><br><span>@@ -950,7 +977,7 @@</span><br><span>     snprintf(log_p=
refix, sizeof(log_prefix), &quot;Outgoing %s&quot;, name);</span><br><span>=
     init_key_ctx(ctx, &amp;key2-&gt;keys[kds.out_key], kt,</span><br><span=
>                  OPENVPN_OP_ENCRYPT, log_prefix);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    key_ctx_update_implicit_iv(ctx, &amp;key2-&gt;keys[kds.out=
_key]);</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span>@@ -965,7 +992,7 @@</span><br><span>     snprintf(log_prefix, sizeo=
f(log_prefix), &quot;Incoming %s&quot;, name);</span><br><span>     init_ke=
y_ctx(ctx, &amp;key2-&gt;keys[kds.in_key], kt,</span><br><span>            =
      OPENVPN_OP_DECRYPT, log_prefix);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  key_ctx_update_implicit_iv(ctx, &amp;key2-&gt;keys[kds.in_key]);</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -1000=
,6 +1027,7 @@</span><br><span> {</span><br><span>     free_key_ctx(&amp;ctx=
-&gt;encrypt);</span><br><span>     free_key_ctx(&amp;ctx-&gt;decrypt);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;initialized=
 =3D false;</span><br><span> }</span><br><span> </span><br><span> static bo=
ol</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span=
><br><span>index 2d6cf64..9eaf3ac 100644</span><br><span>--- a/src/openvpn/=
ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -96,21 +96=
,6 @@</span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */</span=
><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * Update the implicit IV for a key_ctx_bi based on TLS session=
 ids and cipher</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * use=
d.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Note that the implicit IV is based =
on the HMAC key, but only in AEAD modes</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * where the HMAC key is not used for an actual HMAC.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param ctx                   Encrypt/dec=
rypt key context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram key                   HMAC key, used to calculate implicit IV</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param key_len             =
  HMAC key length</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-key_ctx_update_implicit_iv(struc=
t key_ctx *ctx, uint8_t *key, size_t key_len);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><sp=
an>  * Limit the reneg_bytes value when using a small-block (&lt;128 bytes)=
 cipher.</span><br><span>  *</span><br><span>  * @param cipher        The c=
urrent cipher (may be NULL).</span><br><span>@@ -1409,12 +1394,6 @@</span><=
br><span>     else</span><br><span>     {</span><br><span>         init_key=
_ctx_bi(key, key2, key_direction, key_type, &quot;Data Channel&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Initialize impl=
icit IVs */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ke=
y_ctx_update_implicit_iv(&amp;key-&gt;encrypt, key2-&gt;keys[(int)server].h=
mac,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                  MAX_HMAC_KEY_LENGTH);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        key_ctx_update_implicit_iv(&amp;key-&gt;decrypt,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
             key2-&gt;keys[1 - (int)server].hmac,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                   MAX_HMAC_KEY=
_LENGTH);</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span>@@ -1551,23 +1530,6 @@</span><br><span>     return ret;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key=
_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* Only use implicit IV in AEAD cipher=
 mode, where HMAC key is not used */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (cipher_ctx_mode_aead(ctx-&gt;cipher))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        size_t impl_iv_len =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_iv_length(ctx-=
&gt;cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        impl_iv_len =3D cipher_ctx_iv_length(ctx-&g=
t;cipher) - sizeof(packet_id_type);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        ASSERT(impl_iv_len &lt;=3D OPENVPN_MAX_IV_LENGTH);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(impl_iv_l=
en &lt;=3D key_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       CLEAR(ctx-&gt;implicit_iv);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* The first bytes of the IV are filled with the packe=
t id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy=
(ctx-&gt;implicit_iv + sizeof(packet_id_type), key, impl_iv_len);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> /**</span><br><span>  * Generate data channel key=
s for the supplied TLS session.</span><br><span>  *</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_s=
sl.c</span><br><span>index ae33cc6..caacd9e 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_ssl.c</span><br><span>@@ -277,24 +277,6 @@</span><br><span> #end=
if /* HAVE_OPENSSL_STORE */</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-init_implicit_iv(struct crypto_options *co=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    cipher_ctx_t *cipher =3D co-&gt;key_=
ctx_bi.encrypt.cipher;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (cipher_ctx_m=
ode_aead(cipher))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(ciphe=
r_ctx_iv_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_iv_length(ciphe=
r) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  /* Generate dummy implicit IV */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ASSERT(rand_bytes(co-&gt;key_ctx_bi.encrypt.implicit_i=
v,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
       OPENVPN_MAX_IV_LENGTH));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mem=
cpy(co-&gt;key_ctx_bi.decrypt.implicit_iv,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-               co-&gt;key_ctx_bi.encrypt.implicit_iv, =
OPENVPN_MAX_IV_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan> </span><br><span> static void</span><br><span> init_frame_parameters(s=
truct frame *frame)</span><br><span>@@ -346,7 +328,6 @@</span><br><span>   =
  /* init work */</span><br><span>     ASSERT(buf_init(&amp;work, frame.buf=
.headroom));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    init_implicit_iv(co);</span><br><span>     update_time();</spa=
n><br><span> </span><br><span>     /* Test encryption, decryption for all p=
acket sizes */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/800?usp=3Demail">change 800</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/800?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id223612c7bcab91d49c013fb775=
024bd64ab0836 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 800 </div>
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


--zaRe/kYpPOY=--

