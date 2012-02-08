Message-ID: <4F3263D7.6080806@...1147...>
Date: Wed, 08 Feb 2012 13:00:23 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1328627629-4675-1-git-send-email-janjust@...1147...>
	<CAOazyz0GzciSNCnDAaqGQVdUbGLyAgKuUuJp-urR3EPazGa1hg@...278...>
In-Reply-To: <CAOazyz0GzciSNCnDAaqGQVdUbGLyAgKuUuJp-urR3EPazGa1hg@...278...>
Content-Type: multipart/alternative;
	boundary="------------060708020308030904070206"
Subject: Re: [Openvpn-devel] [PATCH] Signed-off-by: Jan Just Keijser
	<janjust@...1147...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060708020308030904070206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alon Bar-Lev wrote:
> This is nice!
>
> Some questions:
>
> 1. Why not enable this automatically if openssl is sufficient version?
> There is no point in not using this if available.
>
some distro's (notably RedHat) disable EC support by default; so it's
not possible to check the OpenSSL version number. There is a '#define
OPENSSL_NO_EC'  that could be used, so the configure.ac script should
check for that. As other SSL implementations might use a different
#define to state that ECs are supported (or are NOT supported), I figure
the decision whether to support ECs should be made by the configure.ac
script, not by the openvpn code itself.
> 2. I would have liked to see this in negotiation as well, so server
> will use EC if supported by the client and fallback if not... This way
> migration path can take place.
>
The client won't even enter the negotiation phase without this patch: if
the client and server are configured to use ECDSA+SHA512 certs and the
'ecdh' parameters are NOT set on the server then the initial TLS
handshake fails.

cheers,

JJK



> On Tue, Feb 7, 2012 at 5:13 PM, Jan Just Keijser <janjust@...1147...
> <mailto:janjust@...1147...>> wrote:
>
>     Added support for Elliptic curves (ECDSA) + SHA2 family signed
>     certificates.
>     ---
>      init.c         |    7 ++++
>      options.c      |   15 ++++++++++
>      options.h      |    6 ++++
>      ssl.c          |    3 ++
>      ssl_backend.h  |   10 ++++++
>      ssl_openssl.c  |   84
>     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>      ssl_polarssl.c |    9 ++++++
>      7 files changed, 134 insertions(+), 0 deletions(-)
>
>     diff --git a/init.c b/init.c
>     index 525f441..51b0d64 100644
>     --- a/init.c
>     +++ b/init.c
>     @@ -895,6 +895,9 @@ print_openssl_info (const struct options *options)
>       if (options->show_ciphers || options->show_digests ||
>     options->show_engines
>      #ifdef USE_SSL
>           || options->show_tls_ciphers
>     +#ifdef USE_SSL_EC
>     +|| options->show_curves
>     +#endif
>      #endif
>         )
>         {
>     @@ -907,6 +910,10 @@ print_openssl_info (const struct options
>     *options)
>      #ifdef USE_SSL
>           if (options->show_tls_ciphers)
>            show_available_tls_ciphers ();
>     +#ifdef USE_SSL_EC
>     +      if (options->show_curves)
>     +    show_available_curves ();
>     +#endif
>      #endif
>           return true;
>         }
>     diff --git a/options.c b/options.c
>     index 6b8ae22..ce23dbc 100644
>     --- a/options.c
>     +++ b/options.c
>     @@ -836,6 +836,9 @@ init_options (struct options *o, const bool
>     init_gc)
>      #ifdef ENABLE_X509ALTUSERNAME
>       o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>      #endif
>     +#ifdef USE_SSL_EC
>     +  o->curve_name = NULL;
>     +#endif
>      #endif /* USE_SSL */
>      #endif /* USE_CRYPTO */
>      #ifdef ENABLE_PKCS11
>     @@ -6368,6 +6371,18 @@ add_option (struct options *options,
>           VERIFY_PERMISSION (OPT_P_GENERAL);
>           options->show_tls_ciphers = true;
>         }
>     +#ifdef USE_SSL_EC
>     +  else if (streq (p[0], "show-curves"))
>     +    {
>     +      VERIFY_PERMISSION (OPT_P_GENERAL);
>     +      options->show_curves = true;
>     +    }
>     +  else if (streq (p[0], "ecdh") && p[1])
>     +    {
>     +      VERIFY_PERMISSION (OPT_P_CRYPTO);
>     +      options->curve_name= p[1];
>     +    }
>     +#endif
>       else if (streq (p[0], "tls-server"))
>         {
>           VERIFY_PERMISSION (OPT_P_GENERAL);
>     diff --git a/options.h b/options.h
>     index 831d4f6..81e0757 100644
>     --- a/options.h
>     +++ b/options.h
>     @@ -200,6 +200,9 @@ struct options
>       bool show_engines;
>      #ifdef USE_SSL
>       bool show_tls_ciphers;
>     +#ifdef USE_SSL_EC
>     +  bool show_curves;
>     +#endif
>      #endif
>       bool genkey;
>      #endif
>     @@ -533,6 +536,9 @@ struct options
>       const char *priv_key_file;
>       const char *pkcs12_file;
>       const char *cipher_list;
>     +#ifdef USE_SSL_EC
>     +  const char *curve_name;
>     +#endif
>       const char *tls_verify;
>       const char *tls_export_cert;
>       const char *tls_remote;
>     diff --git a/ssl.c b/ssl.c
>     index c26756e..54efe2f 100644
>     --- a/ssl.c
>     +++ b/ssl.c
>     @@ -308,6 +308,9 @@ init_ssl (const struct options *options,
>     struct tls_root_ctx *new_ctx)
>         {
>           tls_ctx_server_new(new_ctx);
>           tls_ctx_load_dh_params(new_ctx, options->dh_file,
>     options->dh_file_inline);
>     +#ifdef USE_SSL_EC
>     +      tls_ctx_load_ecdh_params(new_ctx, options->curve_name);
>     +#endif
>         }
>       else                         /* if client */
>         {
>     diff --git a/ssl_backend.h b/ssl_backend.h
>     index 243c9e3..ebf9f36 100644
>     --- a/ssl_backend.h
>     +++ b/ssl_backend.h
>     @@ -145,6 +145,16 @@ void tls_ctx_load_dh_params(struct
>     tls_root_ctx *ctx, const char *dh_file
>         );
>
>      /**
>     + * Load Elliptic Curve Parameters, and load them into the
>     library-specific
>     + * TLS context.
>     + *
>     + * @param ctx                  TLS context to use
>     + * @param curve_name   The name of the elliptic curve to load.
>     + */
>     +void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const
>     char *curve_name
>     +    );
>     +
>     +/**
>      * Load PKCS #12 file for key, cert and (optionally) CA certs, and
>     add to
>      * library-specific TLS context.
>      *
>     diff --git a/ssl_openssl.c b/ssl_openssl.c
>     index b95944c..912dd8f 100644
>     --- a/ssl_openssl.c
>     +++ b/ssl_openssl.c
>     @@ -50,6 +50,9 @@
>      #include <openssl/pkcs12.h>
>      #include <openssl/x509.h>
>      #include <openssl/crypto.h>
>     +#ifdef USE_SSL_EC
>     +#include <openssl/ec.h>
>     +#endif
>
>      /*
>      * Allocate space in SSL objects in which to store a struct
>     tls_session
>     @@ -238,6 +241,46 @@ tls_ctx_load_dh_params (struct tls_root_ctx
>     *ctx, const char *dh_file
>       DH_free (dh);
>      }
>
>     +void
>     +tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char
>     *curve_name
>     +    )
>     +{
>     +#ifdef USE_SSL_EC
>     +  if (curve_name != NULL)
>     +  {
>     +    int nid;
>     +    EC_KEY   *ecdh  = NULL;
>     +
>     +    nid = OBJ_sn2nid(curve_name);
>     +
>     +    if (nid == 0)
>     +      msg(M_SSLERR, "unknown curve name (%s)", curve_name);
>     +    else
>     +    {
>     +      ecdh = EC_KEY_new_by_curve_name(nid);
>     +      if (ecdh == NULL)
>     +        msg (M_SSLERR, "Unable to create curve (%s)", curve_name);
>     +      else
>     +      {
>     +        const char *sname;
>     +
>     +        if (!SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh))
>     +          msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh: cannot add curve");
>     +
>     +        /* Translate NID back to name , just for kicks */
>     +        sname   = OBJ_nid2sn(nid);
>     +        if (sname == NULL) sname = "(Unknown)";
>     +        msg (D_TLS_DEBUG_LOW, "ECDH curve %s added", sname);
>     +
>     +        EC_KEY_free(ecdh);
>     +      }
>     +    }
>     +  }
>     +#else
>     +  msg(M_SSLERR, "Elliptic Curves not supported by this version of
>     OpenSSL");
>     +#endif
>     +}
>     +
>      int
>      tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char
>     *pkcs12_file,
>      #if ENABLE_INLINE_FILES
>     @@ -1273,6 +1316,47 @@ show_available_tls_ciphers ()
>       SSL_CTX_free (ctx);
>      }
>
>     +/*
>     + *  * Show the Elliptic curves that are available for us to use
>     + *   * in the OpenSSL library.
>     + *    */
>     +#ifdef USE_SSL_EC
>     +void
>     +show_available_curves()
>     +{
>     +  EC_builtin_curve *curves = NULL;
>     +  size_t crv_len = 0;
>     +  size_t n = 0;
>     +
>     +  crv_len = EC_get_builtin_curves(NULL, 0);
>     +
>     +  curves = OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len));
>     +
>     +  if (curves == NULL)
>     +    msg (M_SSLERR, "Cannot create EC_builtin_curve object");
>     +  else
>     +  {
>     +    if (EC_get_builtin_curves(curves, crv_len))
>     +    {
>     +      printf ("Available Elliptic curves:\n");
>     +      for (n = 0; n < crv_len; n++)
>     +      {
>     +        const char *sname;
>     +        sname   = OBJ_nid2sn(curves[n].nid);
>     +        if (sname == NULL) sname = "";
>     +
>     +        printf("%s\n", sname);
>     +      }
>     +    }
>     +    else
>     +    {
>     +      msg (M_SSLERR, "Cannot get list of builtin curves");
>     +    }
>     +    OPENSSL_free(curves);
>     +  }
>     +}
>     +#endif
>     +
>      void
>      get_highest_preference_tls_cipher (char *buf, int size)
>      {
>     diff --git a/ssl_polarssl.c b/ssl_polarssl.c
>     index c50cf0a..a7a6d61 100644
>     --- a/ssl_polarssl.c
>     +++ b/ssl_polarssl.c
>     @@ -218,6 +218,15 @@ else
>           (counter_type) 8 * mpi_size(&ctx->dhm_ctx->P));
>      }
>
>     +#ifdef USE_SSL_EC
>     +void
>     +tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char
>     *curve_name
>     +    )
>     +{
>     +    msg(M_WARN, "Elliptic Curves not yet supported by PolarSSL");
>     +}
>     +#endif
>     +
>      int
>      tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char
>     *pkcs12_file,
>      #if ENABLE_INLINE_FILES
>     --
>     1.7.4.4
>



--------------060708020308030904070206
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Alon Bar-Lev wrote:
<blockquote
 cite=3D"mid:CAOazyz0GzciSNCnDAaqGQVdUbGLyAgKuUuJp-urR3EPazGa1hg@...278..."
 type=3D"cite">
  <div dir=3D"ltr">This is nice!<br>
  <br>
Some questions:<br>
  <br>
1. Why not enable this automatically if openssl is sufficient version?
There is no point in not using this if available.<br>
  <br>
  </div>
</blockquote>
some distro's (notably RedHat) disable EC support by default; so it's
not possible to check the OpenSSL version number. There is a '#define
OPENSSL_NO_EC'=C2=A0 that could be used, so the configure.ac script should
check for that. As other SSL implementations might use a different
#define to state that ECs are supported (or are NOT supported), I
figure the decision whether to support ECs should be made by the
configure.ac script, not by the openvpn code itself.<br>
<blockquote
 cite=3D"mid:CAOazyz0GzciSNCnDAaqGQVdUbGLyAgKuUuJp-urR3EPazGa1hg@...278..."
 type=3D"cite">
  <div dir=3D"ltr">2. I would have liked to see this in negotiation as
well, so server will use EC if supported by the client and fallback if
not... This way migration path can take place.<br>
  <br>
  </div>
</blockquote>
The client won't even enter the negotiation phase without this patch:
if the client and server are configured to use ECDSA+SHA512 certs and
the 'ecdh' parameters are NOT set on the server then the initial TLS
handshake fails. <br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
<br>
<br>
<blockquote
 cite=3D"mid:CAOazyz0GzciSNCnDAaqGQVdUbGLyAgKuUuJp-urR3EPazGa1hg@...278..."
 type=3D"cite">
  <div dir=3D"ltr">
  <div class=3D"gmail_quote">On Tue, Feb 7, 2012 at 5:13 PM, Jan Just
Keijser <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
 href=3D"mailto:janjust@...1147...">janjust@...1147...</a>&gt;</span> wrote=
:<br>
  <blockquote class=3D"gmail_quote"
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">Added
support for Elliptic curves (ECDSA) + SHA2 family signed<br>
certificates.<br>
---<br>
=C2=A0init.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 ++++<br>
=C2=A0options.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 15 ++++++++++<br>
=C2=A0options.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 ++++<br>
=C2=A0ssl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A03 ++<br>
=C2=A0ssl_backend.h =C2=A0| =C2=A0 10 ++++++<br>
=C2=A0ssl_openssl.c =C2=A0| =C2=A0 84
++++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>
=C2=A0ssl_polarssl.c | =C2=A0 =C2=A09 ++++++<br>
=C2=A07 files changed, 134 insertions(+), 0 deletions(-)<br>
    <br>
diff --git a/init.c b/init.c<br>
index 525f441..51b0d64 100644<br>
--- a/init.c<br>
+++ b/init.c<br>
@@ -895,6 +895,9 @@ print_openssl_info (const struct options *options)<br>
=C2=A0 if (options-&gt;show_ciphers || options-&gt;show_digests ||
options-&gt;show_engines<br>
=C2=A0#ifdef USE_SSL<br>
=C2=A0 =C2=A0 =C2=A0 || options-&gt;show_tls_ciphers<br>
+#ifdef USE_SSL_EC<br>
+|| options-&gt;show_curves<br>
+#endif<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 {<br>
@@ -907,6 +910,10 @@ print_openssl_info (const struct options *options)<br>
=C2=A0#ifdef USE_SSL<br>
=C2=A0 =C2=A0 =C2=A0 if (options-&gt;show_tls_ciphers)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0show_available_tls_ciphers ();<br>
+#ifdef USE_SSL_EC<br>
+ =C2=A0 =C2=A0 =C2=A0if (options-&gt;show_curves)<br>
+ =C2=A0 =C2=A0show_available_curves ();<br>
+#endif<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 }<br>
diff --git a/options.c b/options.c<br>
index 6b8ae22..ce23dbc 100644<br>
--- a/options.c<br>
+++ b/options.c<br>
@@ -836,6 +836,9 @@ init_options (struct options *o, const bool init_gc)<br>
=C2=A0#ifdef ENABLE_X509ALTUSERNAME<br>
=C2=A0 o-&gt;x509_username_field =3D X509_USERNAME_FIELD_DEFAULT;<br>
=C2=A0#endif<br>
+#ifdef USE_SSL_EC<br>
+ =C2=A0o-&gt;curve_name =3D NULL;<br>
+#endif<br>
=C2=A0#endif /* USE_SSL */<br>
=C2=A0#endif /* USE_CRYPTO */<br>
=C2=A0#ifdef ENABLE_PKCS11<br>
@@ -6368,6 +6371,18 @@ add_option (struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_GENERAL);<br>
=C2=A0 =C2=A0 =C2=A0 options-&gt;show_tls_ciphers =3D true;<br>
=C2=A0 =C2=A0 }<br>
+#ifdef USE_SSL_EC<br>
+ =C2=A0else if (streq (p[0], "show-curves"))<br>
+ =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_GENERAL);<br>
+ =C2=A0 =C2=A0 =C2=A0options-&gt;show_curves =3D true;<br>
+ =C2=A0 =C2=A0}<br>
+ =C2=A0else if (streq (p[0], "ecdh") &amp;&amp; p[1])<br>
+ =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_CRYPTO);<br>
+ =C2=A0 =C2=A0 =C2=A0options-&gt;curve_name=3D p[1];<br>
+ =C2=A0 =C2=A0}<br>
+#endif<br>
=C2=A0 else if (streq (p[0], "tls-server"))<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_GENERAL);<br>
diff --git a/options.h b/options.h<br>
index 831d4f6..81e0757 100644<br>
--- a/options.h<br>
+++ b/options.h<br>
@@ -200,6 +200,9 @@ struct options<br>
=C2=A0 bool show_engines;<br>
=C2=A0#ifdef USE_SSL<br>
=C2=A0 bool show_tls_ciphers;<br>
+#ifdef USE_SSL_EC<br>
+ =C2=A0bool show_curves;<br>
+#endif<br>
=C2=A0#endif<br>
=C2=A0 bool genkey;<br>
=C2=A0#endif<br>
@@ -533,6 +536,9 @@ struct options<br>
=C2=A0 const char *priv_key_file;<br>
=C2=A0 const char *pkcs12_file;<br>
=C2=A0 const char *cipher_list;<br>
+#ifdef USE_SSL_EC<br>
+ =C2=A0const char *curve_name;<br>
+#endif<br>
=C2=A0 const char *tls_verify;<br>
=C2=A0 const char *tls_export_cert;<br>
=C2=A0 const char *tls_remote;<br>
diff --git a/ssl.c b/ssl.c<br>
index c26756e..54efe2f 100644<br>
--- a/ssl.c<br>
+++ b/ssl.c<br>
@@ -308,6 +308,9 @@ init_ssl (const struct options *options, struct
tls_root_ctx *new_ctx)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 tls_ctx_server_new(new_ctx);<br>
=C2=A0 =C2=A0 =C2=A0 tls_ctx_load_dh_params(new_ctx, options-&gt;dh_file,
options-&gt;dh_file_inline);<br>
+#ifdef USE_SSL_EC<br>
+ =C2=A0 =C2=A0 =C2=A0tls_ctx_load_ecdh_params(new_ctx, options-&gt;curve_n=
ame);<br>
+#endif<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 else =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* if client */<br>
=C2=A0 =C2=A0 {<br>
diff --git a/ssl_backend.h b/ssl_backend.h<br>
index 243c9e3..ebf9f36 100644<br>
--- a/ssl_backend.h<br>
+++ b/ssl_backend.h<br>
@@ -145,6 +145,16 @@ void tls_ctx_load_dh_params(struct tls_root_ctx
*ctx, const char *dh_file<br>
=C2=A0 =C2=A0 );<br>
    <br>
=C2=A0/**<br>
+ * Load Elliptic Curve Parameters, and load them into the
library-specific<br>
+ * TLS context.<br>
+ *<br>
+ * @param ctx =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TLS context to use<br>
+ * @param curve_name =C2=A0 The name of the elliptic curve to load.<br>
+ */<br>
+void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char
*curve_name<br>
+ =C2=A0 =C2=A0);<br>
+<br>
+/**<br>
=C2=A0* Load PKCS #12 file for key, cert and (optionally) CA certs, and add
to<br>
=C2=A0* library-specific TLS context.<br>
=C2=A0*<br>
diff --git a/ssl_openssl.c b/ssl_openssl.c<br>
index b95944c..912dd8f 100644<br>
--- a/ssl_openssl.c<br>
+++ b/ssl_openssl.c<br>
@@ -50,6 +50,9 @@<br>
=C2=A0#include &lt;openssl/pkcs12.h&gt;<br>
=C2=A0#include &lt;openssl/x509.h&gt;<br>
=C2=A0#include &lt;openssl/crypto.h&gt;<br>
+#ifdef USE_SSL_EC<br>
+#include &lt;openssl/ec.h&gt;<br>
+#endif<br>
    <br>
=C2=A0/*<br>
=C2=A0* Allocate space in SSL objects in which to store a struct tls_sessio=
n<br>
@@ -238,6 +241,46 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx,
const char *dh_file<br>
=C2=A0 DH_free (dh);<br>
=C2=A0}<br>
    <br>
+void<br>
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char
*curve_name<br>
+ =C2=A0 =C2=A0)<br>
+{<br>
+#ifdef USE_SSL_EC<br>
+ =C2=A0if (curve_name !=3D NULL)<br>
+ =C2=A0{<br>
+ =C2=A0 =C2=A0int nid;<br>
+ =C2=A0 =C2=A0EC_KEY =C2=A0 *ecdh =C2=A0=3D NULL;<br>
+<br>
+ =C2=A0 =C2=A0nid =3D OBJ_sn2nid(curve_name);<br>
+<br>
+ =C2=A0 =C2=A0if (nid =3D=3D 0)<br>
+ =C2=A0 =C2=A0 =C2=A0msg(M_SSLERR, "unknown curve name (%s)", curve_name);=
<br>
+ =C2=A0 =C2=A0else<br>
+ =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0ecdh =3D EC_KEY_new_by_curve_name(nid);<br>
+ =C2=A0 =C2=A0 =C2=A0if (ecdh =3D=3D NULL)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_SSLERR, "Unable to create curve (%s)", =
curve_name);<br>
+ =C2=A0 =C2=A0 =C2=A0else<br>
+ =C2=A0 =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *sname;<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!SSL_CTX_set_tmp_ecdh(ctx-&gt;ctx, ecdh))<=
br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh: c=
annot add curve");<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Translate NID back to name , just for kicks=
 */<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0sname =C2=A0 =3D OBJ_nid2sn(nid);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sname =3D=3D NULL) sname =3D "(Unknown)";<=
br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (D_TLS_DEBUG_LOW, "ECDH curve %s added", s=
name);<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0EC_KEY_free(ecdh);<br>
+ =C2=A0 =C2=A0 =C2=A0}<br>
+ =C2=A0 =C2=A0}<br>
+ =C2=A0}<br>
+#else<br>
+ =C2=A0msg(M_SSLERR, "Elliptic Curves not supported by this version of
OpenSSL");<br>
+#endif<br>
+}<br>
+<br>
=C2=A0int<br>
=C2=A0tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file=
,<br>
=C2=A0#if ENABLE_INLINE_FILES<br>
@@ -1273,6 +1316,47 @@ show_available_tls_ciphers ()<br>
=C2=A0 SSL_CTX_free (ctx);<br>
=C2=A0}<br>
    <br>
+/*<br>
+ * =C2=A0* Show the Elliptic curves that are available for us to use<br>
+ * =C2=A0 * in the OpenSSL library.<br>
+ * =C2=A0 =C2=A0*/<br>
+#ifdef USE_SSL_EC<br>
+void<br>
+show_available_curves()<br>
+{<br>
+ =C2=A0EC_builtin_curve *curves =3D NULL;<br>
+ =C2=A0size_t crv_len =3D 0;<br>
+ =C2=A0size_t n =3D 0;<br>
+<br>
+ =C2=A0crv_len =3D EC_get_builtin_curves(NULL, 0);<br>
+<br>
+ =C2=A0curves =3D OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len)=
);<br>
+<br>
+ =C2=A0if (curves =3D=3D NULL)<br>
+ =C2=A0 =C2=A0msg (M_SSLERR, "Cannot create EC_builtin_curve object");<br>
+ =C2=A0else<br>
+ =C2=A0{<br>
+ =C2=A0 =C2=A0if (EC_get_builtin_curves(curves, crv_len))<br>
+ =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0printf ("Available Elliptic curves:\n");<br>
+ =C2=A0 =C2=A0 =C2=A0for (n =3D 0; n &lt; crv_len; n++)<br>
+ =C2=A0 =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *sname;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0sname =C2=A0 =3D OBJ_nid2sn(curves[n].nid);<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sname =3D=3D NULL) sname =3D "";<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("%s\n", sname);<br>
+ =C2=A0 =C2=A0 =C2=A0}<br>
+ =C2=A0 =C2=A0}<br>
+ =C2=A0 =C2=A0else<br>
+ =C2=A0 =C2=A0{<br>
+ =C2=A0 =C2=A0 =C2=A0msg (M_SSLERR, "Cannot get list of builtin curves");<=
br>
+ =C2=A0 =C2=A0}<br>
+ =C2=A0 =C2=A0OPENSSL_free(curves);<br>
+ =C2=A0}<br>
+}<br>
+#endif<br>
+<br>
=C2=A0void<br>
=C2=A0get_highest_preference_tls_cipher (char *buf, int size)<br>
=C2=A0{<br>
diff --git a/ssl_polarssl.c b/ssl_polarssl.c<br>
index c50cf0a..a7a6d61 100644<br>
--- a/ssl_polarssl.c<br>
+++ b/ssl_polarssl.c<br>
@@ -218,6 +218,15 @@ else<br>
=C2=A0 =C2=A0 =C2=A0 (counter_type) 8 * mpi_size(&amp;ctx-&gt;dhm_ctx-&gt;P=
));<br>
=C2=A0}<br>
    <br>
+#ifdef USE_SSL_EC<br>
+void<br>
+tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char
*curve_name<br>
+ =C2=A0 =C2=A0)<br>
+{<br>
+ =C2=A0 =C2=A0msg(M_WARN, "Elliptic Curves not yet supported by PolarSSL")=
;<br>
+}<br>
+#endif<br>
+<br>
=C2=A0int<br>
=C2=A0tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file=
,<br>
=C2=A0#if ENABLE_INLINE_FILES<br>
--<br>
1.7.4.4<br>
  </blockquote>
  </div>
  </div>
</blockquote>
<br>
<br>
</body>
</html>

--------------060708020308030904070206--

