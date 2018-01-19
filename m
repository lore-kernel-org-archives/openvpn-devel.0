MIME-Version: 1.0
In-Reply-To: <20180119212721.25177-1-steffan@...1856...>
References: <CAKuzo_gPWm6rdBYt+tcaxz+zSQ4M-A4UDu8ZEgWjtvrLZ54ipw@...278...>
 <20180119212721.25177-1-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Jan 2018 16:58:56 -0500
Message-ID: <CAKuzo_h0NVc8K_G-8CYd0iSc35nFEPjGpLSXQg3Lmk+fthMJLw@...278...>
Content-Type: multipart/alternative; boundary="001a114e89c0154ac6056328318e"
Subject: Re: [Openvpn-devel] [PATCH 1/3 v4] Fix --tls-version-min and
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

--001a114e89c0154ac6056328318e
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for last and final v4 :)

On Fri, Jan 19, 2018 at 4:27 PM, Steffan Karger <steffan@...1856...> wrote:

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
> v4: also update compat layer for v3 changes
>
>  src/openvpn/openssl_compat.h |  67 +++++++++++++++++++++++++++++
>  src/openvpn/ssl.c            |   5 ++-
>  src/openvpn/ssl_backend.h    |   4 +-
>  src/openvpn/ssl_mbedtls.c    |   3 +-
>  src/openvpn/ssl_openssl.c    | 100 +++++++++++++++++++++++++++---
> -------------
>  5 files changed, 140 insertions(+), 39 deletions(-)
>
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 05ec4e95..9f1e92a1 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -661,4 +661,71 @@ EC_GROUP_order_bits(const EC_GROUP *group)
>  #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT
>  RSA_F_RSA_EAY_PRIVATE_ENCRYPT
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
> +static inline int
> +SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
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
> +
> +    return 1;
> +}
> +#endif /* SSL_CTX_set_min_proto_version */
> +
> +#ifndef SSL_CTX_set_max_proto_version
> +/** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
> +static inline int
> +SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
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
> +
> +    return 1;
> +}
> +#endif /* SSL_CTX_set_max_proto_version */
> +
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 7b428455..6c27050f 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -622,7 +622,10 @@ init_ssl(const struct options *options, struct
> tls_root_ctx *new_ctx)
>       * cipher restrictions before loading certificates */
>      tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
>
> -    tls_ctx_set_options(new_ctx, options->ssl_flags);
> +    if (!tls_ctx_set_options(new_ctx, options->ssl_flags))
> +    {
> +        goto err;
> +    }
>
>      if (options->pkcs12_file)
>      {
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index 7cf5d830..444fb2f9 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -162,8 +162,10 @@ bool tls_ctx_initialised(struct tls_root_ctx *ctx);
>   *
>   * @param ctx           TLS context to set options on
>   * @param ssl_flags     SSL flags to set
> + *
> + * @return true on success, false otherwise.
>   */
> -void tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int
> ssl_flags);
> +bool tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int
> ssl_flags);
>
>  /**
>   * Restrict the list of ciphers that can be used within the TLS context.
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 8ac52d55..d503162a 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -206,9 +206,10 @@ key_state_export_keying_material(struct
> key_state_ssl *ssl,
>  {
>  }
>
> -void
> +bool
>  tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
>  {
> +    return true;
>  }
>
>  static const char *
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 86318d4c..50d68280 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -206,16 +206,65 @@ info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int
> where, int ret)
>  int
>  tls_version_max(void)
>  {
> -#if defined(SSL_OP_NO_TLSv1_2)
> +#if defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
>      return TLS_VER_1_2;
> -#elif defined(SSL_OP_NO_TLSv1_1)
> +#elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
>      return TLS_VER_1_1;
>  #else
>      return TLS_VER_1_0;
>  #endif
>  }
>
> -void
> +/** Convert internal version number to openssl version number */
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
> +
> +static bool
> +tls_ctx_set_tls_versions(struct tls_root_ctx *ctx, unsigned int
> ssl_flags)
> +{
> +    int tls_ver_min = openssl_tls_version(
> +        (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
> SSLF_TLS_VERSION_MIN_MASK);
> +    int tls_ver_max = openssl_tls_version(
> +        (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
> SSLF_TLS_VERSION_MAX_MASK);
> +
> +    if (!tls_ver_min)
> +    {
> +        /* Enforce at least TLS 1.0 */
> +        int cur_min = SSL_CTX_get_min_proto_version(ctx->ctx);
> +        tls_ver_min = cur_min < TLS1_VERSION ? TLS1_VERSION : cur_min;
> +    }
> +
> +    if (!SSL_CTX_set_min_proto_version(ctx->ctx, tls_ver_min))
> +    {
> +        msg(D_TLS_ERRORS, "%s: failed to set minimum TLS version",
> __func__);
> +        return false;
> +    }
> +
> +    if (tls_ver_max && !SSL_CTX_set_max_proto_version(ctx->ctx,
> tls_ver_max))
> +    {
> +        msg(D_TLS_ERRORS, "%s: failed to set maximum TLS version",
> __func__);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +bool
>  tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
>  {
>      ASSERT(NULL != ctx);
> @@ -223,41 +272,18 @@ tls_ctx_set_options(struct tls_root_ctx *ctx,
> unsigned int ssl_flags)
>      /* default certificate verification flags */
>      int flags = SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
>
> -    /* process SSL options including minimum TLS version we will accept
> from peer */
> -    {
> -        long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET |
> SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
> -        int tls_ver_max = TLS_VER_UNSPEC;
> -        const int tls_ver_min =
> -            (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) &
> SSLF_TLS_VERSION_MIN_MASK;
> -
> -        tls_ver_max =
> -            (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
> SSLF_TLS_VERSION_MAX_MASK;
> -        if (tls_ver_max <= TLS_VER_UNSPEC)
> -        {
> -            tls_ver_max = tls_version_max();
> -        }
> -
> -        if (tls_ver_min > TLS_VER_1_0 || tls_ver_max < TLS_VER_1_0)
> -        {
> -            sslopt |= SSL_OP_NO_TLSv1;
> -        }
> -#ifdef SSL_OP_NO_TLSv1_1
> -        if (tls_ver_min > TLS_VER_1_1 || tls_ver_max < TLS_VER_1_1)
> -        {
> -            sslopt |= SSL_OP_NO_TLSv1_1;
> -        }
> -#endif
> -#ifdef SSL_OP_NO_TLSv1_2
> -        if (tls_ver_min > TLS_VER_1_2 || tls_ver_max < TLS_VER_1_2)
> -        {
> -            sslopt |= SSL_OP_NO_TLSv1_2;
> -        }
> -#endif
> +    /* process SSL options */
> +    long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
>  #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
> -        sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
> +    sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
>  #endif
> -        sslopt |= SSL_OP_NO_COMPRESSION;
> -        SSL_CTX_set_options(ctx->ctx, sslopt);
> +    sslopt |= SSL_OP_NO_COMPRESSION;
> +
> +    SSL_CTX_set_options(ctx->ctx, sslopt);
> +
> +    if (!tls_ctx_set_tls_versions(ctx, ssl_flags))
> +    {
> +        return false;
>      }
>
>  #ifdef SSL_MODE_RELEASE_BUFFERS
> @@ -280,6 +306,8 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned
> int ssl_flags)
>      SSL_CTX_set_verify(ctx->ctx, flags, verify_callback);
>
>      SSL_CTX_set_info_callback(ctx->ctx, info_callback);
> +
> +    return true;
>  }
>

Now I can tease patchwork by

Acked-by: Selva Nair <selva.nair@...277...>
Reviewed-by: Selva Nair <selva.nair@...277...>
Tested-by: Selva Nair <selva.nair@...277...>

Selva

--001a114e89c0154ac6056328318e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div class=3D"gmail_extra">Thanks for la=
st and final v4 :)</div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Fri, Jan 19, 2018 at 4:27 PM, Steffan Karger <span dir=3D"ltr">&l=
t;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...2115...=
.</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><span class=3D"m_-3626978827928249090gmail-">As described in &lt;<a href=
=3D"mailto:80e6b449-c536-dc87-7215-3693872bce5a@...376..." target=3D"_blank=
">80e6b449-c536-dc87-7215-36938<wbr>72bce5a@...376...</a>&gt; on<br>
the openvpn-devel mailing list, --tls-version-min no longer works with<br>
OpenSSL 1.1.=C2=A0 Kurt Roeckx posted in a debian bug report:<br>
<br>
&quot;This is marked as important because if you switch to openssl 1.1.0<br>
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
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856..." tar=
get=3D"_blank">steffan@...1856...</a>&gt;<br>
---<br>
v2: fix define name, obey system lib default minimum version<br>
v3: add error handling, fix bug in setting default minimum<br>
</span>v4: also update compat layer for v3 changes<br>
<br>
=C2=A0src/openvpn/openssl_compat.h |=C2=A0 67 +++++++++++++++++++++++++++++=
<br>
<span class=3D"m_-3626978827928249090gmail-">=C2=A0src/openvpn/ssl.c=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 ++-<br>
=C2=A0src/openvpn/ssl_backend.h=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0src/openvpn/ssl_mbedtls.c=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0src/openvpn/ssl_openssl.c=C2=A0 =C2=A0 | 100 ++++++++++++++++++++++++=
+++---<wbr>-------------<br>
</span>=C2=A05 files changed, 140 insertions(+), 39 deletions(-)<br>
<br>
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h<br>
index 05ec4e95..9f1e92a1 100644<br>
--- a/src/openvpn/openssl_compat.h<br>
+++ b/src/openvpn/openssl_compat.h<br>
@@ -661,4 +661,71 @@ EC_GROUP_order_bits(const EC_GROUP *group)<br>
<span class=3D"m_-3626978827928249090gmail-">=C2=A0#define RSA_F_RSA_OSSL_P=
RIVATE_<wbr>ENCRYPT=C2=A0 =C2=A0 =C2=A0 =C2=A0RSA_F_RSA_EAY_PRIVATE_ENCRYPT=
<br>
=C2=A0#endif<br>
<br>
+#ifndef SSL_CTX_get_min_proto_version<br>
+/** Dummy SSL_CTX_get_min_proto_version for OpenSSL &lt; 1.1 (not really n=
eeded) */<br>
+static inline int<br>
+SSL_CTX_get_min_proto_version<wbr>(SSL_CTX *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+#endif /* SSL_CTX_get_min_proto_version */<br>
+<br>
+#ifndef SSL_CTX_set_min_proto_version<br>
+/** Mimics SSL_CTX_set_min_proto_version for OpenSSL &lt; 1.1 */<br>
</span>+static inline int<br>
+SSL_CTX_set_min_proto_version<wbr>(SSL_CTX *ctx, long tls_ver_min)<br>
<span class=3D"m_-3626978827928249090gmail-">+{<br>
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
+=C2=A0 =C2=A0 SSL_CTX_set_options(ctx, sslopt);<br>
</span>+<br>
+=C2=A0 =C2=A0 return 1;<br>
<span class=3D"m_-3626978827928249090gmail-">+}<br>
+#endif /* SSL_CTX_set_min_proto_version */<br>
+<br>
+#ifndef SSL_CTX_set_max_proto_version<br>
+/** Mimics SSL_CTX_set_max_proto_version for OpenSSL &lt; 1.1 */<br>
</span>+static inline int<br>
+SSL_CTX_set_max_proto_version<wbr>(SSL_CTX *ctx, long tls_ver_max)<br>
<span class=3D"m_-3626978827928249090gmail-">+{<br>
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
</span>+<br>
+=C2=A0 =C2=A0 return 1;<br>
<span class=3D"m_-3626978827928249090gmail-im m_-3626978827928249090gmail-H=
OEnZb">+}<br>
+#endif /* SSL_CTX_set_max_proto_version */<br>
+<br>
</span><div class=3D"m_-3626978827928249090gmail-HOEnZb"><div class=3D"m_-3=
626978827928249090gmail-h5">=C2=A0#endif /* OPENSSL_COMPAT_H_ */<br>
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<br>
index 7b428455..6c27050f 100644<br>
--- a/src/openvpn/ssl.c<br>
+++ b/src/openvpn/ssl.c<br>
@@ -622,7 +622,10 @@ init_ssl(const struct options *options, struct tls_roo=
t_ctx *new_ctx)<br>
=C2=A0 =C2=A0 =C2=A0 * cipher restrictions before loading certificates */<b=
r>
=C2=A0 =C2=A0 =C2=A0tls_ctx_restrict_ciphers(new_<wbr>ctx, options-&gt;ciph=
er_list);<br>
<br>
-=C2=A0 =C2=A0 tls_ctx_set_options(new_ctx, options-&gt;ssl_flags);<br>
+=C2=A0 =C2=A0 if (!tls_ctx_set_options(new_ctx, options-&gt;ssl_flags))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (options-&gt;pkcs12_file)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h<br>
index 7cf5d830..444fb2f9 100644<br>
--- a/src/openvpn/ssl_backend.h<br>
+++ b/src/openvpn/ssl_backend.h<br>
@@ -162,8 +162,10 @@ bool tls_ctx_initialised(struct tls_root_ctx *ctx);<br>
=C2=A0 *<br>
=C2=A0 * @param ctx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TLS context to =
set options on<br>
=C2=A0 * @param ssl_flags=C2=A0 =C2=A0 =C2=A0SSL flags to set<br>
+ *<br>
+ * @return true on success, false otherwise.<br>
=C2=A0 */<br>
-void tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)=
;<br>
+bool tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)=
;<br>
<br>
=C2=A0/**<br>
=C2=A0 * Restrict the list of ciphers that can be used within the TLS conte=
xt.<br>
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c<br>
index 8ac52d55..d503162a 100644<br>
--- a/src/openvpn/ssl_mbedtls.c<br>
+++ b/src/openvpn/ssl_mbedtls.c<br>
@@ -206,9 +206,10 @@ key_state_export_keying_materi<wbr>al(struct key_state=
_ssl *ssl,<br>
=C2=A0{<br>
=C2=A0}<br>
<br>
-void<br>
+bool<br>
=C2=A0tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)=
<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static const char *<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index 86318d4c..50d68280 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -206,16 +206,65 @@ info_callback(INFO_CALLBACK_SS<wbr>L_CONST SSL *s, in=
t where, int ret)<br>
=C2=A0int<br>
=C2=A0tls_version_max(void)<br>
=C2=A0{<br>
-#if defined(SSL_OP_NO_TLSv1_2)<br>
+#if defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)<br>
=C2=A0 =C2=A0 =C2=A0return TLS_VER_1_2;<br>
-#elif defined(SSL_OP_NO_TLSv1_1)<br>
+#elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)<br>
=C2=A0 =C2=A0 =C2=A0return TLS_VER_1_1;<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0return TLS_VER_1_0;<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
-void<br>
</div></div><span class=3D"m_-3626978827928249090gmail-im m_-36269788279282=
49090gmail-HOEnZb">+/** Convert internal version number to openssl version =
number */<br>
+static int<br>
+openssl_tls_version(int ver)<br>
+{<br>
+=C2=A0 =C2=A0 if (ver =3D=3D TLS_VER_1_0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS1_VERSION;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (ver =3D=3D TLS_VER_1_1)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS1_1_VERSION;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (ver =3D=3D TLS_VER_1_2)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return TLS1_2_VERSION;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
</span><div class=3D"m_-3626978827928249090gmail-HOEnZb"><div class=3D"m_-3=
626978827928249090gmail-h5">+<br>
+static bool<br>
+tls_ctx_set_tls_versions(stru<wbr>ct tls_root_ctx *ctx, unsigned int ssl_f=
lags)<br>
+{<br>
+=C2=A0 =C2=A0 int tls_ver_min =3D openssl_tls_version(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT=
) &amp; SSLF_TLS_VERSION_MIN_MASK);<br>
+=C2=A0 =C2=A0 int tls_ver_max =3D openssl_tls_version(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT=
) &amp; SSLF_TLS_VERSION_MAX_MASK);<br>
+<br>
+=C2=A0 =C2=A0 if (!tls_ver_min)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enforce at least TLS 1.0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int cur_min =3D SSL_CTX_get_min_proto_version(=
<wbr>ctx-&gt;ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tls_ver_min =3D cur_min &lt; TLS1_VERSION ? TL=
S1_VERSION : cur_min;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!SSL_CTX_set_min_proto_versio<wbr>n(ctx-&gt;ctx, tls_ver=
_min))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TLS_ERRORS, &quot;%s: failed to set mini=
mum TLS version&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (tls_ver_max &amp;&amp; !SSL_CTX_set_max_proto_version<wb=
r>(ctx-&gt;ctx, tls_ver_max))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TLS_ERRORS, &quot;%s: failed to set maxi=
mum TLS version&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+bool<br>
=C2=A0tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ASSERT(NULL !=3D ctx);<br>
@@ -223,41 +272,18 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigne=
d int ssl_flags)<br>
=C2=A0 =C2=A0 =C2=A0/* default certificate verification flags */<br>
=C2=A0 =C2=A0 =C2=A0int flags =3D SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_P=
EER_CER<wbr>T;<br>
<br>
-=C2=A0 =C2=A0 /* process SSL options including minimum TLS version we will=
 accept from peer */<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 long sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_=
NO_TICKET | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int tls_ver_max =3D TLS_VER_UNSPEC;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int tls_ver_min =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ssl_flags &gt;&gt; SSLF_TLS_VER=
SION_MIN_SHIFT) &amp; SSLF_TLS_VERSION_MIN_MASK;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tls_ver_max =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ssl_flags &gt;&gt; SSLF_TLS_VER=
SION_MAX_SHIFT) &amp; SSLF_TLS_VERSION_MAX_MASK;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tls_ver_max &lt;=3D TLS_VER_UNSPEC)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tls_ver_max =3D tls_version_max(=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tls_ver_min &gt; TLS_VER_1_0 || tls_ver_ma=
x &lt; TLS_VER_1_0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-#ifdef SSL_OP_NO_TLSv1_1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tls_ver_min &gt; TLS_VER_1_1 || tls_ver_ma=
x &lt; TLS_VER_1_1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1_1;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-#endif<br>
-#ifdef SSL_OP_NO_TLSv1_2<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tls_ver_min &gt; TLS_VER_1_2 || tls_ver_ma=
x &lt; TLS_VER_1_2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_TLSv1_2;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-#endif<br>
+=C2=A0 =C2=A0 /* process SSL options */<br>
+=C2=A0 =C2=A0 long sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;<br>
=C2=A0#ifdef SSL_OP_CIPHER_SERVER_PREFERENC<wbr>E<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENC<wbr=
>E;<br>
+=C2=A0 =C2=A0 sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENC<wbr>E;<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_COMPRESSION;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 SSL_CTX_set_options(ctx-&gt;ctx, sslopt);<br>
+=C2=A0 =C2=A0 sslopt |=3D SSL_OP_NO_COMPRESSION;<br>
+<br>
+=C2=A0 =C2=A0 SSL_CTX_set_options(ctx-&gt;ctx, sslopt);<br>
+<br>
+=C2=A0 =C2=A0 if (!tls_ctx_set_tls_versions(ctx<wbr>, ssl_flags))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0#ifdef SSL_MODE_RELEASE_BUFFERS<br>
@@ -280,6 +306,8 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned =
int ssl_flags)<br>
=C2=A0 =C2=A0 =C2=A0SSL_CTX_set_verify(ctx-&gt;ctx, flags, verify_callback)=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0SSL_CTX_set_info_callback(<wbr>ctx-&gt;ctx, info_callba=
ck);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br></div></div></blockquote><div><br></div><div>Now I can tease pat=
chwork by</div><div><br></div><div>Acked-by: Selva Nair &lt;<a href=3D"mail=
to:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br>=
Reviewed-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=
=3D"_blank">selva.nair@...277...</a>&gt;</div><div>Tested-by: Selva Nair &l=
t;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1665...=
77...</a>&gt;<br><br></div><div>Selva=C2=A0</div></div></div></div>

--001a114e89c0154ac6056328318e--

