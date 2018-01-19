MIME-Version: 1.0
In-Reply-To: <20180119192252.6229-1-steffan@...1856...>
References: <CAKuzo_jx+ZudY-dzkqPro1Xqzj+djT4+Qhs+cQHzchjwpSsOHg@...278...>
 <20180119192252.6229-1-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Jan 2018 15:56:18 -0500
Message-ID: <CAKuzo_gPWm6rdBYt+tcaxz+zSQ4M-A4UDu8ZEgWjtvrLZ54ipw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c082db21c48160563275191"
Subject: Re: [Openvpn-devel] [PATCH 1/3 v3] Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--94eb2c082db21c48160563275191
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the v3.

All good except (sorry to say that :)

The compat versions of SSL_CTX_get_max_proto_version and its min counterpart
should return a long or int not void. Assuming we want to continue
supporting
openssl 1.0.

This was not an issue earlier when return value was not checked. Anyway,
the correct
signature of the 1.1 functions (well macros) it replaces is long.

I should have pointed this out earlier...

There is one more thing that I'm not sure of. See below.

On Fri, Jan 19, 2018 at 2:22 PM, Steffan Karger <steffan@...1856...> wrote:

> As described in <80e6b449-c536-dc87-7215-3693872bce5a@...376...> on
> the openvpn-devel mailing list, --tls-version-min no longer works with
> OpenSSL 1.1.  Kurt Roeckx posted in a debian bug report:
>
> "This is marked as important because if you switch to openssl 1.1.0
> the defaults minimum version in Debian is currently TLS 1.2 and
> you can't override it with the options that you're currently using
> (and are deprecated)."
>
> This patch is loosely based on the original patch by Kurt, but solves the
> issue by adding functions to openssl-compat.h, like we also did for all
> other openssl 1.1. breakage.  This results in not having to add more ifdefs
> in ssl_openssl.c and thus cleaner code.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: fix define name, obey system lib default minimum version
> v3: add error handling, fix bug in setting default minimum
>
>  src/openvpn/openssl_compat.h |  63 +++++++++++++++++++++++++++
>  src/openvpn/ssl.c            |   5 ++-
>  src/openvpn/ssl_backend.h    |   4 +-
>  src/openvpn/ssl_mbedtls.c    |   3 +-
>  src/openvpn/ssl_openssl.c    | 100 +++++++++++++++++++++++++++---
> -------------
>  5 files changed, 136 insertions(+), 39 deletions(-)
>
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 05ec4e95..4931fad3 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -661,4 +661,67 @@ EC_GROUP_order_bits(const EC_GROUP *group)
>  #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
>  #endif
>
> +#ifndef SSL_CTX_get_min_proto_version
> +/** Dummy SSL_CTX_get_min_proto_version for OpenSSL < 1.1 (not really
> needed) */
> +static inline int
> +SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
> +{
> +    return 0;
> +}
> +#endif /* SSL_CTX_get_min_proto_version */
> +
> +#ifndef SSL_CTX_set_min_proto_version
> +/** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
> +static inline void
> +SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
>

static inline long (or int)
...


> +{
> +    long sslopt = SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never do < TLS
> 1.0 */
> +
> +    if (tls_ver_min > TLS1_VERSION)
> +    {
> +        sslopt |= SSL_OP_NO_TLSv1;
> +    }
> +#ifdef SSL_OP_NO_TLSv1_1
> +    if (tls_ver_min > TLS1_1_VERSION)
> +    {
> +        sslopt |= SSL_OP_NO_TLSv1_1;
> +    }
> +#endif
> +#ifdef SSL_OP_NO_TLSv1_2
> +    if (tls_ver_min > TLS1_2_VERSION)
> +    {
> +        sslopt |= SSL_OP_NO_TLSv1_2;
> +    }
> +#endif
> +    SSL_CTX_set_options(ctx, sslopt);
>

return 1;


> +}
> +#endif /* SSL_CTX_set_min_proto_version */
> +
> +#ifndef SSL_CTX_set_max_proto_version
> +/** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
> +static inline void
> +SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
>

static inline long (or int)
...


> +{
> +    long sslopt = 0;
> +
> +    if (tls_ver_max < TLS1_VERSION)
> +    {
> +        sslopt |= SSL_OP_NO_TLSv1;
> +    }
> +#ifdef SSL_OP_NO_TLSv1_1
> +    if (tls_ver_max < TLS1_1_VERSION)
> +    {
> +        sslopt |= SSL_OP_NO_TLSv1_1;
> +    }
> +#endif
> +#ifdef SSL_OP_NO_TLSv1_2
> +    if (tls_ver_max < TLS1_2_VERSION)
> +    {
> +        sslopt |= SSL_OP_NO_TLSv1_2;
> +    }
> +#endif
> +    SSL_CTX_set_options(ctx, sslopt);
>

return 1;


> +}
> +#endif /* SSL_CTX_set_max_proto_version */
> +
>

...

+/** Convert internal version number to openssl version number */
> +static int
> +openssl_tls_version(int ver)
> +{
> +    if (ver == TLS_VER_1_0)
> +    {
> +        return TLS1_VERSION;
> +    }
> +    else if (ver == TLS_VER_1_1)
> +    {
> +        return TLS1_1_VERSION;
> +    }
> +    else if (ver == TLS_VER_1_2)
> +    {
> +        return TLS1_2_VERSION;
> +    }
> +    return 0;
> +}


TLS1_2_VERSION may not be defined in openssl prior to 1.0.1, would it?
Is that a problem? Do we still support 0.9.8 etc? I'm lazy to check this
myself.

The rest is good.

Selva

--94eb2c082db21c48160563275191
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Thanks for the v3.</div><div><br></=
div><div>All good except (sorry to say that :)</div><div><br></div><div>The=
 compat versions of SSL_CTX_get_max_proto_version and its min counterpart</=
div><div class=3D"gmail_extra">should return a long or int not void. Assumi=
ng we want to continue supporting=C2=A0</div><div class=3D"gmail_extra">ope=
nssl 1.0.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ext=
ra">This was not an issue earlier when return value was not checked. Anyway=
, the correct</div><div class=3D"gmail_extra">signature of the 1.1 function=
s (well macros) it replaces is long.</div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">I should have pointed this out earlier...</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">There is=
 one more thing that I&#39;m not sure of. See below.</div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Fri, Jan 19, 2018 at 2:22 PM, S=
teffan Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." t=
arget=3D"_blank">steffan@...1856...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">As described in =
&lt;<a href=3D"mailto:80e6b449-c536-dc87-7215-3693872bce5a@...376...">80e6b=
449-c536-dc87-7215-<wbr>3693872bce5a@...376...</a>&gt; on<br>
the openvpn-devel mailing list, --tls-version-min no longer works with<br>
OpenSSL 1.1.=C2=A0 Kurt Roeckx posted in a debian bug report:<br>
<br>
</span><span class=3D"gmail-">&quot;This is marked as important because if =
you switch to openssl 1.1.0<br>
the defaults minimum version in Debian is currently TLS 1.2 and<br>
you can&#39;t override it with the options that you&#39;re currently using<=
br>
(and are deprecated).&quot;<br>
<br>
This patch is loosely based on the original patch by Kurt, but solves the<b=
r>
issue by adding functions to openssl-compat.h, like we also did for all<br>
other openssl 1.1. breakage.=C2=A0 This results in not having to add more i=
fdefs<br>
in ssl_openssl.c and thus cleaner code.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856...">ste=
ffan@...1856...</a>&gt;<br>
---<br>
v2: fix define name, obey system lib default minimum version<br>
</span>v3: add error handling, fix bug in setting default minimum<br>
<br>
=C2=A0src/openvpn/openssl_compat.h |=C2=A0 63 +++++++++++++++++++++++++++<b=
r>
=C2=A0src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A05 ++-<br>
=C2=A0src/openvpn/ssl_backend.h=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0src/openvpn/ssl_mbedtls.c=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0src/openvpn/ssl_openssl.c=C2=A0 =C2=A0 | 100 ++++++++++++++++++++++++=
+++---<wbr>-------------<br>
=C2=A05 files changed, 136 insertions(+), 39 deletions(-)<br>
<br>
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h<br>
index 05ec4e95..4931fad3 100644<br>
--- a/src/openvpn/openssl_compat.h<br>
+++ b/src/openvpn/openssl_compat.h<br>
@@ -661,4 +661,67 @@ EC_GROUP_order_bits(const EC_GROUP *group)<br>
<div><div class=3D"gmail-h5">=C2=A0#define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT=
=C2=A0 =C2=A0 =C2=A0 =C2=A0RSA_F_RSA_EAY_PRIVATE_ENCRYPT<br>
=C2=A0#endif<br>
<br>
+#ifndef SSL_CTX_get_min_proto_version<br>
+/** Dummy SSL_CTX_get_min_proto_version for OpenSSL &lt; 1.1 (not really n=
eeded) */<br>
+static inline int<br>
+SSL_CTX_get_min_proto_<wbr>version(SSL_CTX *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+#endif /* SSL_CTX_get_min_proto_version */<br>
+<br>
+#ifndef SSL_CTX_set_min_proto_version<br>
+/** Mimics SSL_CTX_set_min_proto_version for OpenSSL &lt; 1.1 */<br>
+static inline void<br>
+SSL_CTX_set_min_proto_<wbr>version(SSL_CTX *ctx, long tls_ver_min)<br></di=
v></div></blockquote><div><br></div><div>static inline long (or int)</div><=
div>...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div><div class=3D"gmail-h5">
+{<br>
+=C2=A0 =C2=A0 long sslopt =3D SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never =
do &lt; TLS 1.0 */<br>
+<br>
+=C2=A0 =C2=A0 if (tls_ver_min &gt; TLS1_VERSION)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1;<br>
+=C2=A0 =C2=A0 }<br>
+#ifdef SSL_OP_NO_TLSv1_1<br>
+=C2=A0 =C2=A0 if (tls_ver_min &gt; TLS1_1_VERSION)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1_1;<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+#ifdef SSL_OP_NO_TLSv1_2<br>
+=C2=A0 =C2=A0 if (tls_ver_min &gt; TLS1_2_VERSION)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1_2;<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+=C2=A0 =C2=A0 SSL_CTX_set_options(ctx, sslopt);<br></div></div></blockquot=
e><div><br></div><div>return 1;</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div><div class=3D"gmail-h5">
+}<br>
+#endif /* SSL_CTX_set_min_proto_version */<br>
+<br>
+#ifndef SSL_CTX_set_max_proto_version<br>
+/** Mimics SSL_CTX_set_max_proto_version for OpenSSL &lt; 1.1 */<br>
+static inline void<br>
+SSL_CTX_set_max_proto_<wbr>version(SSL_CTX *ctx, long tls_ver_max)<br></di=
v></div></blockquote><div><br></div><div>static inline long (or int)</div><=
div>...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div><div class=3D"gmail-h5">
+{<br>
+=C2=A0 =C2=A0 long sslopt =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (tls_ver_max &lt; TLS1_VERSION)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1;<br>
+=C2=A0 =C2=A0 }<br>
+#ifdef SSL_OP_NO_TLSv1_1<br>
+=C2=A0 =C2=A0 if (tls_ver_max &lt; TLS1_1_VERSION)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1_1;<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+#ifdef SSL_OP_NO_TLSv1_2<br>
+=C2=A0 =C2=A0 if (tls_ver_max &lt; TLS1_2_VERSION)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1_2;<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+=C2=A0 =C2=A0 SSL_CTX_set_options(ctx, sslopt);<br>
</div></div></blockquote><div><br></div><div>return 1;</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div class=3D"gmai=
l-h5">+}<br>
+#endif /* SSL_CTX_set_max_proto_version */<br>
+</div></div></blockquote><div><br></div><div>...</div><div><br></div><div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">+/** Convert internal ver=
sion number to openssl version number */<br>+static int<br>+openssl_tls_ver=
sion(int ver)<br>+{<br>+=C2=A0 =C2=A0 if (ver =3D=3D TLS_VER_1_0)<br>+=C2=
=A0 =C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS1_VERSION;<br>+=C2=
=A0 =C2=A0 }<br>+=C2=A0 =C2=A0 else if (ver =3D=3D TLS_VER_1_1)<br>+=C2=A0 =
=C2=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS1_1_VERSION;<br>+=C2=A0 =
=C2=A0 }<br>+=C2=A0 =C2=A0 else if (ver =3D=3D TLS_VER_1_2)<br>+=C2=A0 =C2=
=A0 {<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS1_2_VERSION;<br>+=C2=A0 =C2=
=A0 }<br>+=C2=A0 =C2=A0 return 0;<br>+}</blockquote></div><div><br></div><d=
iv>TLS1_2_VERSION may not be defined in openssl prior to 1.0.1, would it?<b=
r></div><div>Is that a problem? Do we still support 0.9.8 etc? I&#39;m lazy=
 to check this myself.</div><div><br></div><div>The rest is good.</div><div=
><br></div><div>Selva=C2=A0</div></div></div></div>

--94eb2c082db21c48160563275191--

