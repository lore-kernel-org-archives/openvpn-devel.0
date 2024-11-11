From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 01:59:53 +0000
References: <gerrit.1731290343000.I4a981c5a70717e2276d89bf83a06c7fdbe6712d7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8225d8826baedeb4f58e8c6fa268d12bcfcce7d2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aOOTA5wJ0CI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change API of
 init_key_ctx to use struct key_paramters
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

--aOOTA5wJ0CI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail

to review the following change.


Change subject: Change API of init_key_ctx to use struct key_paramters
......................................................................

Change API of init_key_ctx to use struct key_paramters

This introduces a new structure key_paramters. The reason is that the
current struct serves both as an internal struct as well as an
on-wire/in-file format. Separate these two different usages to allow
extending the struct.

Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/auth_token.c
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/tls_crypt.c
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_tls_crypt.c
6 files changed, 85 insertions(+), 37 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/801/1

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 192c7c2..3cf55e8 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -152,7 +152,10 @@
     {
         msg(M_FATAL, "ERROR: not enough data in auth-token secret");
     }
-    init_key_ctx(key_ctx, &key, &kt, false, "auth-token secret");
+
+    struct key_parameters key_params;
+    key_parameters_from_key(&key_params, &key);
+    init_key_ctx(key_ctx, &key_params, &kt, false, "auth-token secret");

     free_buf(&server_secret_key);
 }
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 44c226c..f4453d8 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -903,7 +903,7 @@
  * @param key                   key, hmac part used to calculate implicit =
IV
  */
 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct key *key)
+key_ctx_update_implicit_iv(struct key_ctx *ctx, const struct key_parameter=
s *key)
 {
     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not use=
d */
     if (cipher_ctx_mode_aead(ctx->cipher))
@@ -913,6 +913,7 @@
         impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) - sizeof(packet_=
id_type);
         ASSERT(impl_iv_len <=3D OPENVPN_MAX_IV_LENGTH);
         ASSERT(impl_iv_len <=3D MAX_HMAC_KEY_LENGTH);
+        ASSERT(key->hmac_size >=3D impl_iv_len);
         CLEAR(ctx->implicit_iv);
         /* The first bytes of the IV are filled with the packet id */
         memcpy(ctx->implicit_iv + sizeof(packet_id_type), key->hmac, impl_=
iv_len);
@@ -921,7 +922,7 @@

 /* given a key and key_type, build a key_ctx */
 void
-init_key_ctx(struct key_ctx *ctx, const struct key *key,
+init_key_ctx(struct key_ctx *ctx, const struct key_parameters *key,
              const struct key_type *kt, int enc,
              const char *prefix)
 {
@@ -929,7 +930,7 @@
     CLEAR(*ctx);
     if (cipher_defined(kt->cipher))
     {
-
+        ASSERT(key->cipher_size >=3D cipher_kt_key_size(kt->cipher));
         ctx->cipher =3D cipher_ctx_new();
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher, enc);

@@ -944,8 +945,10 @@
              cipher_kt_iv_size(kt->cipher));
         warn_insecure_key_type(ciphername);
     }
+
     if (md_defined(kt->digest))
     {
+        ASSERT(key->hmac_size >=3D md_kt_size(kt->digest));
         ctx->hmac =3D hmac_ctx_new();
         hmac_ctx_init(ctx->hmac, key->hmac, kt->digest);

@@ -966,41 +969,43 @@
 }

 void
-init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt, const c=
har *name)
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key_parameters *key=
_params,
+                     const struct key_type *kt, const char *name)
 {
     char log_prefix[128] =3D { 0 };
-    struct key_direction_state kds;
-
-    key_direction_state_init(&kds, key_direction);

     snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
-    init_key_ctx(ctx, &key2->keys[kds.out_key], kt,
-                 OPENVPN_OP_ENCRYPT, log_prefix);
-    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.out_key]);
+    init_key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
+    key_ctx_update_implicit_iv(ctx, key_params);
 }

 void
-init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt, const c=
har *name)
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key_parameters *key=
_params,
+                     const struct key_type *kt, const char *name)
 {
     char log_prefix[128] =3D { 0 };
-    struct key_direction_state kds;
-
-    key_direction_state_init(&kds, key_direction);

     snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
-    init_key_ctx(ctx, &key2->keys[kds.in_key], kt,
-                 OPENVPN_OP_DECRYPT, log_prefix);
-    key_ctx_update_implicit_iv(ctx, &key2->keys[kds.in_key]);
+    init_key_ctx(ctx, key_params, kt, OPENVPN_OP_DECRYPT, log_prefix);
+    key_ctx_update_implicit_iv(ctx, key_params);
 }

 void
 init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
                 int key_direction, const struct key_type *kt, const char *=
name)
 {
-    init_key_bi_ctx_send(&ctx->encrypt, key2, key_direction, kt, name);
-    init_key_bi_ctx_recv(&ctx->decrypt, key2, key_direction, kt, name);
+    struct key_direction_state kds;
+
+    key_direction_state_init(&kds, key_direction);
+
+    struct key_parameters send_key;
+    struct key_parameters recv_key;
+
+    key_parameters_from_key(&send_key, &key2->keys[kds.out_key]);
+    key_parameters_from_key(&recv_key, &key2->keys[kds.in_key]);
+
+    init_key_bi_ctx_send(&ctx->encrypt, &send_key, kt, name);
+    init_key_bi_ctx_recv(&ctx->decrypt, &recv_key, kt, name);
     ctx->initialized =3D true;
 }

@@ -1117,6 +1122,16 @@
 }

 void
+key_parameters_from_key(struct key_parameters *key_params, const struct ke=
y *key)
+{
+    CLEAR(*key_params);
+    memcpy(key_params->cipher, key->cipher, MAX_CIPHER_KEY_LENGTH);
+    key_params->cipher_size =3D MAX_HMAC_KEY_LENGTH;
+    memcpy(key_params->hmac, key->hmac, MAX_CIPHER_KEY_LENGTH);
+    key_params->hmac_size =3D MAX_HMAC_KEY_LENGTH;
+}
+
+void
 test_crypto(struct crypto_options *co, struct frame *frame)
 {
     int i, j;
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3331672..ff24f87 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -144,7 +144,8 @@

 /**
  * Container for unidirectional cipher and HMAC %key material.
- * @ingroup control_processor
+ * @ingroup control_processor. This is used as a wire format/file format
+ * key, so it cannot be changed to add fields or change the length of fiel=
ds
  */
 struct key
 {
@@ -154,6 +155,30 @@
     /**< %Key material for HMAC operations. */
 };

+/** internal structure similar to struct key that hold key information
+ * but is not represented on wire and can be changed/extended
+ */
+struct key_parameters {
+    /** %Key material for cipher operations. */
+    uint8_t cipher[MAX_CIPHER_KEY_LENGTH];
+
+    /** Number of bytes set in the cipher key material */
+    int cipher_size;
+
+    /** %Key material for HMAC operations. */
+    uint8_t hmac[MAX_HMAC_KEY_LENGTH];
+
+    /** Number of bytes set in the HMac key material */
+    int hmac_size;
+};
+
+/**
+ * Converts a struct key representation into a struct key_params represent=
ation.
+ * @param key_params    destination for the converted struct
+ * @param key           source of the conversion
+ */
+void
+key_parameters_from_key(struct key_parameters *key_params, const struct ke=
y *key);

 /**
  * Container for one set of cipher and/or HMAC contexts.
@@ -340,19 +365,17 @@
  * Key context functions
  */

-void init_key_ctx(struct key_ctx *ctx, const struct key *key,
+void init_key_ctx(struct key_ctx *ctx, const struct key_parameters *key,
                   const struct key_type *kt, int enc,
                   const char *prefix);

 void
-init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt,
-                     const char *name);
+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key_parameters *key,
+                     const struct key_type *kt, const char *name);

 void
-init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,
-                     int key_direction, const struct key_type *kt,
-                     const char *name);
+init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key_parameters *key,
+                     const struct key_type *kt, const char *name);

 void free_key_ctx(struct key_ctx *ctx);

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index b8894db..76f06bc 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -377,7 +377,11 @@
     {
         msg(M_FATAL, "ERROR: --tls-crypt-v2 not supported");
     }
-    init_key_ctx(key_ctx, &srv_key, &kt, encrypt, "tls-crypt-v2 server key=
");
+    struct key_parameters srv_key_params;
+
+    key_parameters_from_key(&srv_key_params, &srv_key);
+
+    init_key_ctx(key_ctx, &srv_key_params, &kt, encrypt, "tls-crypt-v2 ser=
ver key");
     secure_memzero(&srv_key, sizeof(srv_key));
 }

diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index 8a0c16a..9a21abf 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -87,7 +87,8 @@
     struct test_context *ctx =3D calloc(1, sizeof(*ctx));
     *state =3D ctx;

-    struct key key =3D { 0 };
+    struct key_parameters key =3D { 0 };
+    key.hmac_size =3D 64;     /* 64 byte of 0 */

     ctx->kt =3D auth_token_kt();
     if (!ctx->kt.digest)
@@ -148,15 +149,17 @@
                      AUTH_TOKEN_HMAC_OK);

     /* Change auth-token key */
-    struct key key;
-    memset(&key, '1', sizeof(key));
+    struct key_parameters key;
+    memset(key.hmac, '1', sizeof(key.hmac));
+    key.hmac_size =3D MAX_HMAC_KEY_LENGTH;
+
     free_key_ctx(&ctx->multi.opt.auth_token_key);
     init_key_ctx(&ctx->multi.opt.auth_token_key, &key, &ctx->kt, false, "T=
EST");

     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), 0);

     /* Load original test key again */
-    memset(&key, 0, sizeof(key));
+    memset(&key.hmac, 0, sizeof(key.hmac));
     free_key_ctx(&ctx->multi.opt.auth_token_key);
     init_key_ctx(&ctx->multi.opt.auth_token_key, &key, &ctx->kt, false, "T=
EST");
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
),
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 4f12f88..f4b30b7 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -157,7 +157,7 @@
     struct test_tls_crypt_context *ctx =3D calloc(1, sizeof(*ctx));
     *state =3D ctx;

-    struct key key =3D { 0 };
+    struct key_parameters key =3D { .cipher =3D { 0 }, .hmac =3D { 0 }, .h=
mac_size =3D 64, .cipher_size =3D 64 };

     ctx->kt =3D tls_crypt_kt();
     if (!ctx->kt.cipher || !ctx->kt.digest)
@@ -367,7 +367,7 @@
     skip_if_tls_crypt_not_supported(ctx);

     /* Change decrypt key */
-    struct key key =3D { { 1 } };
+    struct key_parameters key =3D { .cipher =3D { 1 }, .hmac =3D { 1 }, .c=
ipher_size =3D 64, .hmac_size =3D 64 };
     free_key_ctx(&ctx->co.key_ctx_bi.decrypt);
     init_key_ctx(&ctx->co.key_ctx_bi.decrypt, &key, &ctx->kt, false, "TEST=
");


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7
Gerrit-Change-Number: 801
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--aOOTA5wJ0CI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/801?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Change API of init_key_ctx to use struct key_paramters<br><br=
>This introduces a new structure key_paramters. The reason is that the<br>c=
urrent struct serves both as an internal struct as well as an<br>on-wire/in=
-file format. Separate these two different usages to allow<br>extending the=
 struct.<br><br>Change-Id: I4a981c5a70717e2276d89bf83a06c7fdbe6712d7<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/au=
th_token.c<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/ope=
nvpn/tls_crypt.c<br>M tests/unit_tests/openvpn/test_auth_token.c<br>M tests=
/unit_tests/openvpn/test_tls_crypt.c<br>6 files changed, 85 insertions(+), =
37 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/01/801/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_token.c b/src/op=
envpn/auth_token.c</span><br><span>index 192c7c2..3cf55e8 100644</span><br>=
<span>--- a/src/openvpn/auth_token.c</span><br><span>+++ b/src/openvpn/auth=
_token.c</span><br><span>@@ -152,7 +152,10 @@</span><br><span>     {</span>=
<br><span>         msg(M_FATAL, &quot;ERROR: not enough data in auth-token =
secret&quot;);</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    init_key_ctx(key_ctx, &amp;key, &amp;kt, false, &quot;a=
uth-token secret&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key=
_parameters key_params;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    key_parameters_from_key(&amp;key_params, &amp;key);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    init_key_ctx(key_ctx, &amp;key_=
params, &amp;kt, false, &quot;auth-token secret&quot;);</span><br><span> </=
span><br><span>     free_buf(&amp;server_secret_key);</span><br><span> }</s=
pan><br><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</spa=
n><br><span>index 44c226c..f4453d8 100644</span><br><span>--- a/src/openvpn=
/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -90=
3,7 +903,7 @@</span><br><span>  * @param key                   key, hmac pa=
rt used to calculate implicit IV</span><br><span>  */</span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-key_ctx_update=
_implicit_iv(struct key_ctx *ctx, const struct key *key)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+key_ctx_update_implicit_iv(struct key_=
ctx *ctx, const struct key_parameters *key)</span><br><span> {</span><br><s=
pan>     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not=
 used */</span><br><span>     if (cipher_ctx_mode_aead(ctx-&gt;cipher))</sp=
an><br><span>@@ -913,6 +913,7 @@</span><br><span>         impl_iv_len =3D c=
ipher_ctx_iv_length(ctx-&gt;cipher) - sizeof(packet_id_type);</span><br><sp=
an>         ASSERT(impl_iv_len &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><s=
pan>         ASSERT(impl_iv_len &lt;=3D MAX_HMAC_KEY_LENGTH);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(key-&gt;hmac_size =
&gt;=3D impl_iv_len);</span><br><span>         CLEAR(ctx-&gt;implicit_iv);<=
/span><br><span>         /* The first bytes of the IV are filled with the p=
acket id */</span><br><span>         memcpy(ctx-&gt;implicit_iv + sizeof(pa=
cket_id_type), key-&gt;hmac, impl_iv_len);</span><br><span>@@ -921,7 +922,7=
 @@</span><br><span> </span><br><span> /* given a key and key_type, build a=
 key_ctx */</span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-init_key_ctx(struct key_ctx *ctx, const struct key *key,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_ctx(struct key_ct=
x *ctx, const struct key_parameters *key,</span><br><span>              con=
st struct key_type *kt, int enc,</span><br><span>              const char *=
prefix)</span><br><span> {</span><br><span>@@ -929,7 +930,7 @@</span><br><s=
pan>     CLEAR(*ctx);</span><br><span>     if (cipher_defined(kt-&gt;cipher=
))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(=
key-&gt;cipher_size &gt;=3D cipher_kt_key_size(kt-&gt;cipher));</span><br><=
span>         ctx-&gt;cipher =3D cipher_ctx_new();</span><br><span>        =
 cipher_ctx_init(ctx-&gt;cipher, key-&gt;cipher, kt-&gt;cipher, enc);</span=
><br><span> </span><br><span>@@ -944,8 +945,10 @@</span><br><span>         =
     cipher_kt_iv_size(kt-&gt;cipher));</span><br><span>         warn_insec=
ure_key_type(ciphername);</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     if (md_defined(kt-&gt;di=
gest))</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ASSERT(key-&gt;hmac_size &gt;=3D md_kt_size(kt-&gt;digest=
));</span><br><span>         ctx-&gt;hmac =3D hmac_ctx_new();</span><br><sp=
an>         hmac_ctx_init(ctx-&gt;hmac, key-&gt;hmac, kt-&gt;digest);</span=
><br><span> </span><br><span>@@ -966,41 +969,43 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-init_key_bi_ctx_send(struct key_ctx *ctx, const struct key2 *k=
ey2,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
    int key_direction, const struct key_type *kt, const char *name)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_send(struct=
 key_ctx *ctx, const struct key_parameters *key_params,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     const struct key_t=
ype *kt, const char *name)</span><br><span> {</span><br><span>     char log=
_prefix[128] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct key_direction_state kds;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    k=
ey_direction_state_init(&amp;kds, key_direction);</span><br><span> </span><=
br><span>     snprintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&qu=
ot;, name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_k=
ey_ctx(ctx, &amp;key2-&gt;keys[kds.out_key], kt,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                 OPENVPN_OP_ENCRYPT, log_prefix)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_ctx_update_i=
mplicit_iv(ctx, &amp;key2-&gt;keys[kds.out_key]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    init_key_ctx(ctx, key_params, kt, OPENVPN=
_OP_ENCRYPT, log_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    key_ctx_update_implicit_iv(ctx, key_params);</span><br><span> }</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key=
2 *key2,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
        int key_direction, const struct key_type *kt, const char *name)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_recv(st=
ruct key_ctx *ctx, const struct key_parameters *key_params,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     const struct k=
ey_type *kt, const char *name)</span><br><span> {</span><br><span>     char=
 log_prefix[128] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct key_direction_state kds;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   key_direction_state_init(&amp;kds, key_direction);</span><br><span> </sp=
an><br><span>     snprintf(log_prefix, sizeof(log_prefix), &quot;Incoming %=
s&quot;, name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
it_key_ctx(ctx, &amp;key2-&gt;keys[kds.in_key], kt,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 OPENVPN_OP_DECRYPT, log_pr=
efix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key_ctx_upd=
ate_implicit_iv(ctx, &amp;key2-&gt;keys[kds.in_key]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    init_key_ctx(ctx, key_params, kt, OPE=
NVPN_OP_DECRYPT, log_prefix);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    key_ctx_update_implicit_iv(ctx, key_params);</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span> init_key_ctx_bi=
(struct key_ctx_bi *ctx, const struct key2 *key2,</span><br><span>         =
        int key_direction, const struct key_type *kt, const char *name)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
it_key_bi_ctx_send(&amp;ctx-&gt;encrypt, key2, key_direction, kt, name);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_bi_ctx_recv=
(&amp;ctx-&gt;decrypt, key2, key_direction, kt, name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct key_direction_state kds;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    key_direction_state_init(&amp;kds, ke=
y_direction);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_parameters=
 send_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t key_parameters recv_key;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    key_para=
meters_from_key(&amp;send_key, &amp;key2-&gt;keys[kds.out_key]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    key_parameters_from_key(&a=
mp;recv_key, &amp;key2-&gt;keys[kds.in_key]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    init_key_bi_ctx_send(&amp;ctx-&gt;encrypt, &amp;send_key, kt, na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_bi=
_ctx_recv(&amp;ctx-&gt;decrypt, &amp;recv_key, kt, name);</span><br><span> =
    ctx-&gt;initialized =3D true;</span><br><span> }</span><br><span> </spa=
n><br><span>@@ -1117,6 +1122,16 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+k=
ey_parameters_from_key(struct key_parameters *key_params, const struct key =
*key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*key_params);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(key_params-&gt;ci=
pher, key-&gt;cipher, MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    key_params-&gt;cipher_size =3D MAX_HMAC_KEY_L=
ENGTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(ke=
y_params-&gt;hmac, key-&gt;hmac, MAX_CIPHER_KEY_LENGTH);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    key_params-&gt;hmac_size =3D MAX_H=
MAC_KEY_LENGTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> test_crypto(struct =
crypto_options *co, struct frame *frame)</span><br><span> {</span><br><span=
>     int i, j;</span><br><span>diff --git a/src/openvpn/crypto.h b/src/ope=
nvpn/crypto.h</span><br><span>index 3331672..ff24f87 100644</span><br><span=
>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</spa=
n><br><span>@@ -144,7 +144,8 @@</span><br><span> </span><br><span> /**</spa=
n><br><span>  * Container for unidirectional cipher and HMAC %key material.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup control_p=
rocessor</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ingroup=
 control_processor. This is used as a wire format/file format</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * key, so it cannot be changed t=
o add fields or change the length of fields</span><br><span>  */</span><br>=
<span> struct key</span><br><span> {</span><br><span>@@ -154,6 +155,30 @@</=
span><br><span>     /**&lt; %Key material for HMAC operations. */</span><br=
><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/** internal structure similar to struct key that hold key informa=
tion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * but is not r=
epresented on wire and can be changed/extended</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct key_parameters {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /** %Key material for cipher operations. */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint8_t cipher[MAX_CIPHER_KE=
Y_LENGTH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /** Number of bytes set =
in the cipher key material */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int cipher_size;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** =
%Key material for HMAC operations. */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint8_t hmac[MAX_HMAC_KEY_LENGTH];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /** Number of bytes set in the HMac key material */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int hmac_size;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Converts a struct key representation into a struct key_params represent=
ation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key=
_params    destination for the converted struct</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param key           source of the conversio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+key_parameters_from_key(struct key_parameters *ke=
y_params, const struct key *key);</span><br><span> </span><br><span> /**</s=
pan><br><span>  * Container for one set of cipher and/or HMAC contexts.</sp=
an><br><span>@@ -340,19 +365,17 @@</span><br><span>  * Key context function=
s</span><br><span>  */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void init_key_ctx(struct key_ctx *ctx, const struct key =
*key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void init_key_=
ctx(struct key_ctx *ctx, const struct key_parameters *key,</span><br><span>=
                   const struct key_type *kt, int enc,</span><br><span>    =
               const char *prefix);</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_key_bi_ctx_send(=
struct key_ctx *ctx, const struct key2 *key2,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                     int key_direction, const struc=
t key_type *kt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
               const char *name);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+init_key_bi_ctx_send(struct key_ctx *ctx, const struct key_pa=
rameters *key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                const struct key_type *kt, const char *name);</span><br><sp=
an> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-init_key_bi_ctx_recv(struct key_ctx *ctx, const struct key2 *key2,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                     int =
key_direction, const struct key_type *kt,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                     const char *name);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+init_key_bi_ctx_recv(struct key_ctx=
 *ctx, const struct key_parameters *key,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     const struct key_type *kt, const =
char *name);</span><br><span> </span><br><span> void free_key_ctx(struct ke=
y_ctx *ctx);</span><br><span> </span><br><span>diff --git a/src/openvpn/tls=
_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index b8894db..76f06bc 1=
00644</span><br><span>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/s=
rc/openvpn/tls_crypt.c</span><br><span>@@ -377,7 +377,11 @@</span><br><span=
>     {</span><br><span>         msg(M_FATAL, &quot;ERROR: --tls-crypt-v2 n=
ot supported&quot;);</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    init_key_ctx(key_ctx, &amp;srv_key, &amp;kt, encr=
ypt, &quot;tls-crypt-v2 server key&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct key_parameters srv_key_params;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    key_parameters_from_key(&amp;srv_key_params, =
&amp;srv_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_ctx(key_ctx=
, &amp;srv_key_params, &amp;kt, encrypt, &quot;tls-crypt-v2 server key&quot=
;);</span><br><span>     secure_memzero(&amp;srv_key, sizeof(srv_key));</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c=
</span><br><span>index 8a0c16a..9a21abf 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_auth_token.c</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_auth_token.c</span><br><span>@@ -87,7 +87,8 @@</span><br><spa=
n>     struct test_context *ctx =3D calloc(1, sizeof(*ctx));</span><br><spa=
n>     *state =3D ctx;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct key key =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct key_parameters key =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    key.hmac_size =3D 64;=
     /* 64 byte of 0 */</span><br><span> </span><br><span>     ctx-&gt;kt =
=3D auth_token_kt();</span><br><span>     if (!ctx-&gt;kt.digest)</span><br=
><span>@@ -148,15 +149,17 @@</span><br><span>                      AUTH_TOK=
EN_HMAC_OK);</span><br><span> </span><br><span>     /* Change auth-token ke=
y */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key ke=
y;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memset(&amp;key=
, &#39;1&#39;, sizeof(key));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct key_parameters key;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    memset(key.hmac, &#39;1&#39;, sizeof(key.hmac));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    key.hmac_size =3D =
MAX_HMAC_KEY_LENGTH;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     free_key_ctx(&amp;ctx-&gt;multi.opt.auth_token_key);=
</span><br><span>     init_key_ctx(&amp;ctx-&gt;multi.opt.auth_token_key, &=
amp;key, &amp;ctx-&gt;kt, false, &quot;TEST&quot;);</span><br><span> </span=
><br><span>     assert_int_equal(verify_auth_token(&amp;ctx-&gt;up, &amp;ct=
x-&gt;multi, ctx-&gt;session), 0);</span><br><span> </span><br><span>     /=
* Load original test key again */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    memset(&amp;key, 0, sizeof(key));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memset(&amp;key.hmac, 0, sizeof(key.hmac)=
);</span><br><span>     free_key_ctx(&amp;ctx-&gt;multi.opt.auth_token_key)=
;</span><br><span>     init_key_ctx(&amp;ctx-&gt;multi.opt.auth_token_key, =
&amp;key, &amp;ctx-&gt;kt, false, &quot;TEST&quot;);</span><br><span>     a=
ssert_int_equal(verify_auth_token(&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx-=
&gt;session),</span><br><span>diff --git a/tests/unit_tests/openvpn/test_tl=
s_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>index=
 4f12f88..f4b30b7 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt=
.c</span><br><span>@@ -157,7 +157,7 @@</span><br><span>     struct test_tls=
_crypt_context *ctx =3D calloc(1, sizeof(*ctx));</span><br><span>     *stat=
e =3D ctx;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct key key =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct key_parameters key =3D { .cipher =3D { 0 }, .hm=
ac =3D { 0 }, .hmac_size =3D 64, .cipher_size =3D 64 };</span><br><span> </=
span><br><span>     ctx-&gt;kt =3D tls_crypt_kt();</span><br><span>     if =
(!ctx-&gt;kt.cipher || !ctx-&gt;kt.digest)</span><br><span>@@ -367,7 +367,7=
 @@</span><br><span>     skip_if_tls_crypt_not_supported(ctx);</span><br><s=
pan> </span><br><span>     /* Change decrypt key */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct key key =3D { { 1 } };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_parameters key=
 =3D { .cipher =3D { 1 }, .hmac =3D { 1 }, .cipher_size =3D 64, .hmac_size =
=3D 64 };</span><br><span>     free_key_ctx(&amp;ctx-&gt;co.key_ctx_bi.decr=
ypt);</span><br><span>     init_key_ctx(&amp;ctx-&gt;co.key_ctx_bi.decrypt,=
 &amp;key, &amp;ctx-&gt;kt, false, &quot;TEST&quot;);</span><br><span> </sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/801?usp=3Demail">change 801</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/801?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a981c5a70717e2276d89bf83a0=
6c7fdbe6712d7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 801 </div>
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


--aOOTA5wJ0CI=--

