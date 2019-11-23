MIME-Version: 1.0
References: <20191122143315.8564-1-arne@...1227...>
In-Reply-To: <20191122143315.8564-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Nov 2019 21:04:37 -0500
Message-ID: <CAKuzo_hU7K-vaP7mcyu8kTkKQrg0rwacwxayi-qi69Ez81Vt=A@...278...>
Content-Type: multipart/alternative; boundary="000000000000d41df90597f9f4bd"
Subject: Re: [Openvpn-devel] [PATCH v7 1/2] Make tls_version_max return the
 actual maximum version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d41df90597f9f4bd
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Nov 22, 2019 at 9:34 AM Arne Schwabe <arne@...1227...> wrote:

> Before OpenSSL 1.1.1 there could be no mismatch between
> compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need
> runtime detection to detect the actual best TLS version supported.
>
> Allowing this runtime detection also allows removing some of the
> TLS 1.3/OpenSSL 1.1.1 #ifdefs
>
> Without this patch tls-min-version 1.3 or-highest will actually
> downgrade to TLS 1.3


I think that should read "TLS 1.2" not "TLS 1.3"


> in the "compiled with 1.1.0 and linked against
> 1.1.1" scenario.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c         | 11 +++++------
>  src/openvpn/ssl_openssl.c | 39 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 41 insertions(+), 9 deletions(-)
>
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 4455ebb8..e708fc93 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -4194,12 +4194,11 @@ show_available_tls_ciphers(const char *cipher_list,
>  {
>      printf("Available TLS Ciphers, listed in order of preference:\n");
>
> -#if (ENABLE_CRYPTO_OPENSSL && OPENSSL_VERSION_NUMBER >= 0x1010100fL)
> -    printf("\nFor TLS 1.3 and newer (--tls-ciphersuites):\n\n");
> -    show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_profile,
> true);
> -#else
> -    (void) cipher_list_tls13;  /* Avoid unused warning */
> -#endif
> +    if (tls_version_max() >= TLS_VER_1_3)
> +    {
> +        printf("\nFor TLS 1.3 and newer (--tls-ciphersuites):\n\n");
> +        show_available_tls_ciphers_list(cipher_list_tls13,
> tls_cert_profile, true);
> +    }
>
>      printf("\nFor TLS 1.2 and older (--tls-cipher):\n\n");
>      show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false);
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 07916c3c..a080338e 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -215,7 +215,26 @@ int
>  tls_version_max(void)
>  {
>  #if defined(TLS1_3_VERSION)
> +    /* If this is defined we can safely assume TLS 1.3 support */
>      return TLS_VER_1_3;
> +#elif OPENSSL_VERSION_NUMBER >= 0x10100000L
> +    /*
> +     * If TLS_VER_1_3 is not defined, we were compiled against a version
> that
> +     * did not support TLS 1.3.
> +     *
> +     * However, the library we are *linked* against might be OpenSSL 1.1.1
> +     * and therefore supports TLS 1.3. This needs to be checked at runtime
> +     * since we can be compiled against 1.1.0 and then the library can be
> +     * upgraded to 1.1.1
> +     */
> +    if (OpenSSL_version_num() >= 0x1010100fL)
> +    {
> +        return TLS_VER_1_3;
> +    }
> +    else
> +    {
> +        return TLS_VER_1_2;
> +    }
>  #elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
>      return TLS_VER_1_2;
>  #elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
> @@ -241,12 +260,25 @@ openssl_tls_version(int ver)
>      {
>          return TLS1_2_VERSION;
>      }
> -#if defined(TLS1_3_VERSION)
>      else if (ver == TLS_VER_1_3)
>      {
> +        /*
> +         * Supporting the library upgraded to TLS1.3 without recompile
> +         * is enough to support here with a simple constant that the same
> +         * as in the TLS 1.3, so spec it is very unlikely that OpenSSL
> +         * will change this constant
>

I have no idea what that comment means, but I get the idea and will pass :)


> +         */
> +#ifndef TLS1_3_VERSION
> +        /*
> +         * We do not want to define TLS_VER_1_3 if not defined
> +         * since other parts of the code use the existance of this macro
> +         * as proxy for TLS 1.3 support
> +         */
> +        return 0x0304;
> +#else
>          return TLS1_3_VERSION;
> -    }
>  #endif
> +    }
>      return 0;
>  }
>
> @@ -2015,7 +2047,8 @@ show_available_tls_ciphers_list(const char
> *cipher_list,
>  #if defined(TLS1_3_VERSION)
>      if (tls13)
>      {
> -        SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
> +        SSL_CTX_set_min_proto_version(tls_ctx.ctx,
> +                                      openssl_tls_version(TLS_VER_1_3));
>          tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
>      }
>      else
> --
>

Tested using OpenSSL 1.1.0 based build with OpenSSL 1.1.1 at
runtime.

Acked-by: selva.nair@...277...

--000000000000d41df90597f9f4bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Nov 22, 2019 at 9:34 AM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Before OpenSSL 1.1.1 there=
 could be no mismatch between<br>
compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need<br>
runtime detection to detect the actual best TLS version supported.<br>
<br>
Allowing this runtime detection also allows removing some of the<br>
TLS 1.3/OpenSSL 1.1.1 #ifdefs<br>
<br>
Without this patch tls-min-version 1.3 or-highest will actually<br>
downgrade to TLS 1.3 </blockquote><div><br></div><div>I think that should r=
ead &quot;TLS 1.2&quot; not &quot;TLS 1.3&quot;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">in the &quot;compiled with 1.1=
.0 and linked against<br>
1.1.1&quot; scenario.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++++------<b=
r>
=C2=A0src/openvpn/ssl_openssl.c | 39 ++++++++++++++++++++++++++++++++++++--=
-<br>
=C2=A02 files changed, 41 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<br>
index 4455ebb8..e708fc93 100644<br>
--- a/src/openvpn/ssl.c<br>
+++ b/src/openvpn/ssl.c<br>
@@ -4194,12 +4194,11 @@ show_available_tls_ciphers(const char *cipher_list,=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0printf(&quot;Available TLS Ciphers, listed in order of =
preference:\n&quot;);<br>
<br>
-#if (ENABLE_CRYPTO_OPENSSL &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x101=
0100fL)<br>
-=C2=A0 =C2=A0 printf(&quot;\nFor TLS 1.3 and newer (--tls-ciphersuites):\n=
\n&quot;);<br>
-=C2=A0 =C2=A0 show_available_tls_ciphers_list(cipher_list_tls13, tls_cert_=
profile, true);<br>
-#else<br>
-=C2=A0 =C2=A0 (void) cipher_list_tls13;=C2=A0 /* Avoid unused warning */<b=
r>
-#endif<br>
+=C2=A0 =C2=A0 if (tls_version_max() &gt;=3D TLS_VER_1_3)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;\nFor TLS 1.3 and newer (--tls-ci=
phersuites):\n\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 show_available_tls_ciphers_list(cipher_list_tl=
s13, tls_cert_profile, true);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0printf(&quot;\nFor TLS 1.2 and older (--tls-cipher):\n\=
n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0show_available_tls_ciphers_list(cipher_list, tls_cert_p=
rofile, false);<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index 07916c3c..a080338e 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -215,7 +215,26 @@ int<br>
=C2=A0tls_version_max(void)<br>
=C2=A0{<br>
=C2=A0#if defined(TLS1_3_VERSION)<br>
+=C2=A0 =C2=A0 /* If this is defined we can safely assume TLS 1.3 support *=
/<br>
=C2=A0 =C2=A0 =C2=A0return TLS_VER_1_3;<br>
+#elif OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If TLS_VER_1_3 is not defined, we were compiled agai=
nst a version that<br>
+=C2=A0 =C2=A0 =C2=A0* did not support TLS 1.3.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* However, the library we are *linked* against might b=
e OpenSSL 1.1.1<br>
+=C2=A0 =C2=A0 =C2=A0* and therefore supports TLS 1.3. This needs to be che=
cked at runtime<br>
+=C2=A0 =C2=A0 =C2=A0* since we can be compiled against 1.1.0 and then the =
library can be<br>
+=C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (OpenSSL_version_num() &gt;=3D 0x1010100fL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS_VER_1_3;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS_VER_1_2;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)<br>
=C2=A0 =C2=A0 =C2=A0return TLS_VER_1_2;<br>
=C2=A0#elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)<br>
@@ -241,12 +260,25 @@ openssl_tls_version(int ver)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TLS1_2_VERSION;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-#if defined(TLS1_3_VERSION)<br>
=C2=A0 =C2=A0 =C2=A0else if (ver =3D=3D TLS_VER_1_3)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Supporting the library upgraded to TLS=
1.3 without recompile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is enough to support here with a simpl=
e constant that the same<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* as in the TLS 1.3, so spec it is very =
unlikely that OpenSSL<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will change this constant<br></blockqu=
ote><div><br></div><div>I have no idea what that comment means, but I get t=
he idea and will pass :)</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+#ifndef TLS1_3_VERSION<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We do not want to define TLS_VER_1_3 i=
f not defined<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* since other parts of the code use the =
existance of this macro<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* as proxy for TLS 1.3 support<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0x0304;<br>
+#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TLS1_3_VERSION;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -2015,7 +2047,8 @@ show_available_tls_ciphers_list(const char *cipher_li=
st,<br>
=C2=A0#if defined(TLS1_3_VERSION)<br>
=C2=A0 =C2=A0 =C2=A0if (tls13)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS=
1_3_VERSION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL_CTX_set_min_proto_version(tls_ctx.ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openssl_tls_ver=
sion(TLS_VER_1_3));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tls_ctx_restrict_ciphers_tls13(&amp;tls_c=
tx, cipher_list);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
-- <br></blockquote><div><br></div><div>Tested using OpenSSL 1.1.0 based bu=
ild with OpenSSL 1.1.1 at</div><div>runtime.</div><div><br></div><div>Acked=
-by: <a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a></div>=
</div></div>

--000000000000d41df90597f9f4bd--

