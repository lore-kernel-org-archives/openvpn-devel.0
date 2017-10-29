MIME-Version: 1.0
In-Reply-To: <1509192205.3021.7.camel@...2316...>
References: <1509192147.3021.6.camel@...2316...>
 <1509192205.3021.7.camel@...2316...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 29 Oct 2017 17:34:48 +0500
Message-ID: <CAFHpkQHXWrXn42B1xr0YuPvQUrOSvUqQU6h8RkP_EgP_iBP5Qw@...278...>
Content-Type: multipart/alternative; boundary="001a114acd8c7161cb055caebfef"
Subject: Re: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114acd8c7161cb055caebfef
Content-Type: text/plain; charset="UTF-8"

2017-10-28 17:03 GMT+05:00 James Bottomley <
James.Bottomley@...2317...>:

> As well as doing crypto acceleration, engines can also be used to load
> key files.  If the engine is set, and the private key loading fails
> for bio methods, this patch makes openvpn try to get the engine to
> load the key.  If that succeeds, we end up using an engine based key.
> This can be used with the openssl tpm engines to make openvpn use a
> TPM wrapped key file.
>


it fails on mbedtls and openssl-1.1.0

https://travis-ci.org/chipitsine/openvpn/builds/294429659


>
> Signed-off-by: James Bottomley <James.Bottomley@...2316...>
> ---
>  src/openvpn/crypto_backend.h | 13 ++++++++++++
>  src/openvpn/crypto_openssl.c | 49 ++++++++++++++++++++++++++++++
> ++++++++++++++
>  src/openvpn/ssl_openssl.c    |  6 +++++-
>  3 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 567fd9b2..0b4a9ce9 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -669,4 +669,17 @@ const char *translate_cipher_name_from_openvpn(const
> char *cipher_name);
>   */
>  const char *translate_cipher_name_to_openvpn(const char *cipher_name);
>
> +/**
> + * Load a key file from an engine
> + *
> + * @param file The engine file to load
> + * @param ui   The UI method for the password prompt
> + * @param data The data to pass to the UI method
> + *
> + * @return     The private key if successful or NULL if not
> + */
> +EVP_PKEY *
> +engine_load_key(const char *file, SSL_CTX *ctx);
> +
> +
>  #endif /* CRYPTO_BACKEND_H_ */
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 0134e55d..ee16a496 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -969,4 +969,53 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
>      HMAC_Final(ctx, dst, &in_hmac_len);
>  }
>
> +static int
> +ui_read(UI *ui, UI_STRING *uis)
> +{
> +    SSL_CTX *ctx = UI_get0_user_data(ui);
> +
> +    if (UI_get_string_type(uis) == UIT_PROMPT) {
> +        pem_password_cb *cb = SSL_CTX_get_default_passwd_cb(ctx);
> +        void *d = SSL_CTX_get_default_passwd_cb_userdata(ctx);
> +        char password[64];
> +
> +        cb(password, sizeof(password), 0, d);
> +        UI_set_result(ui, uis, password);
> +
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +EVP_PKEY *
> +engine_load_key(const char *file, SSL_CTX *ctx)
> +{
> +    UI_METHOD *ui;
> +    EVP_PKEY *pkey;
> +
> +    if (!engine_persist)
> +        return NULL;
> +
> +    ui = UI_create_method("openvpn");
> +
> +    if (!ui)
> +        return NULL;
> +
> +    UI_method_set_reader(ui, ui_read);
> +
> +    ERR_clear_error();         /* BIO read failure */
> +    if (!ENGINE_init(engine_persist)) {
> +       ERR_print_errors_fp(stderr);
> +       pkey = NULL;
> +       goto out;
> +    }
> +    pkey = ENGINE_load_private_key(engine_persist, file, ui, ctx);
> +    ENGINE_finish(engine_persist);
> +    if (!pkey)
> +       ERR_print_errors_fp(stderr);
> + out:
> +    UI_destroy_method(ui);
> +    return pkey;
> +}
> +
>  #endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_OPENSSL */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 92a662b5..52e9a869 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -839,7 +839,11 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx,
> const char *priv_key_file,
>                                     SSL_CTX_get_default_passwd_cb_
> userdata(ctx->ctx));
>      if (!pkey)
>      {
> -        goto end;
> +        pkey = engine_load_key(priv_key_file, ctx->ctx);
> +        if (!pkey)
> +        {
> +            goto end;
> +        }
>      }
>
>      if (!SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
> --
> 2.12.3
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114acd8c7161cb055caebfef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-10-28 17:03 GMT+05:00 James Bottomley <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:James.Bottomley@...2317..." target=3D"_blank">James.Bottomley@...220...=
..2317...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">As well as doing crypto acceleration, engines can also be used to load<=
br>
key files.=C2=A0 If the engine is set, and the private key loading fails<br>
for bio methods, this patch makes openvpn try to get the engine to<br>
load the key.=C2=A0 If that succeeds, we end up using an engine based key.<=
br>
This can be used with the openssl tpm engines to make openvpn use a<br>
TPM wrapped key file.<br></blockquote><div><br><br></div><div>it fails on m=
bedtls and openssl-1.1.0<br><br><a href=3D"https://travis-ci.org/chipitsine=
/openvpn/builds/294429659">https://travis-ci.org/chipitsine/openvpn/builds/=
294429659</a><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Signed-off-by: James Bottomley &lt;James.Bottomley@<wbr>HansenPartnership.c=
om&gt;<br>
---<br>
=C2=A0src/openvpn/crypto_backend.h | 13 ++++++++++++<br>
=C2=A0src/openvpn/crypto_openssl.c | 49 ++++++++++++++++++++++++++++++<wbr>=
++++++++++++++<br>
=C2=A0src/openvpn/ssl_openssl.c=C2=A0 =C2=A0 |=C2=A0 6 +++++-<br>
=C2=A03 files changed, 67 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h<br>
index 567fd9b2..0b4a9ce9 100644<br>
--- a/src/openvpn/crypto_backend.h<br>
+++ b/src/openvpn/crypto_backend.h<br>
@@ -669,4 +669,17 @@ const char *translate_cipher_name_from_<wbr>openvpn(co=
nst char *cipher_name);<br>
=C2=A0 */<br>
=C2=A0const char *translate_cipher_name_to_<wbr>openvpn(const char *cipher_=
name);<br>
<br>
+/**<br>
+ * Load a key file from an engine<br>
+ *<br>
+ * @param file The engine file to load<br>
+ * @param ui=C2=A0 =C2=A0The UI method for the password prompt<br>
+ * @param data The data to pass to the UI method<br>
+ *<br>
+ * @return=C2=A0 =C2=A0 =C2=A0The private key if successful or NULL if not=
<br>
+ */<br>
+EVP_PKEY *<br>
+engine_load_key(const char *file, SSL_CTX *ctx);<br>
+<br>
+<br>
=C2=A0#endif /* CRYPTO_BACKEND_H_ */<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index 0134e55d..ee16a496 100644<br>
--- a/src/openvpn/crypto_openssl.c<br>
+++ b/src/openvpn/crypto_openssl.c<br>
@@ -969,4 +969,53 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)<br>
=C2=A0 =C2=A0 =C2=A0HMAC_Final(ctx, dst, &amp;in_hmac_len);<br>
=C2=A0}<br>
<br>
+static int<br>
+ui_read(UI *ui, UI_STRING *uis)<br>
+{<br>
+=C2=A0 =C2=A0 SSL_CTX *ctx =3D UI_get0_user_data(ui);<br>
+<br>
+=C2=A0 =C2=A0 if (UI_get_string_type(uis) =3D=3D UIT_PROMPT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pem_password_cb *cb =3D SSL_CTX_get_default_pa=
sswd_cb(<wbr>ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *d =3D SSL_CTX_get_default_passwd_cb_<wbr=
>userdata(ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char password[64];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(password, sizeof(password), 0, d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 UI_set_result(ui, uis, password);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+EVP_PKEY *<br>
+engine_load_key(const char *file, SSL_CTX *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 UI_METHOD *ui;<br>
+=C2=A0 =C2=A0 EVP_PKEY *pkey;<br>
+<br>
+=C2=A0 =C2=A0 if (!engine_persist)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+<br>
+=C2=A0 =C2=A0 ui =3D UI_create_method(&quot;openvpn&quot;);<br>
+<br>
+=C2=A0 =C2=A0 if (!ui)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+<br>
+=C2=A0 =C2=A0 UI_method_set_reader(ui, ui_read);<br>
+<br>
+=C2=A0 =C2=A0 ERR_clear_error();=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* BIO r=
ead failure */<br>
+=C2=A0 =C2=A0 if (!ENGINE_init(engine_persist)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ERR_print_errors_fp(stderr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pkey =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 pkey =3D ENGINE_load_private_key(<wbr>engine_persist, file, =
ui, ctx);<br>
+=C2=A0 =C2=A0 ENGINE_finish(engine_persist);<br>
+=C2=A0 =C2=A0 if (!pkey)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ERR_print_errors_fp(stderr);<br>
+ out:<br>
+=C2=A0 =C2=A0 UI_destroy_method(ui);<br>
+=C2=A0 =C2=A0 return pkey;<br>
+}<br>
+<br>
=C2=A0#endif /* ENABLE_CRYPTO &amp;&amp; ENABLE_CRYPTO_OPENSSL */<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index 92a662b5..52e9a869 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -839,7 +839,11 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const=
 char *priv_key_file,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL_CTX_get_default_pa=
sswd_cb_<wbr>userdata(ctx-&gt;ctx));<br>
=C2=A0 =C2=A0 =C2=A0if (!pkey)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkey =3D engine_load_key(priv_key_file, ctx-&g=
t;ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pkey)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!SSL_CTX_use_PrivateKey(ssl_<wbr>ctx, pkey))<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888">--<br>
2.12.3<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div></div>

--001a114acd8c7161cb055caebfef--

