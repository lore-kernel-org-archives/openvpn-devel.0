MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-13-arne@...1227...>
In-Reply-To: <20211019183127.614175-13-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 23 Oct 2021 13:24:49 -0400
Message-ID: <CAKuzo_hKfjbU2WhcTmerbq4qRU=rftc4y++TQ0piMzW-3Hg3CA@...278...>
Content-Type: multipart/alternative; boundary="000000000000aff5b305cf0868f4"
Subject: Re: [Openvpn-devel] [PATCH v3 12/21] [OSSL 3.0] Allow loading of
 non default providers
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

--000000000000aff5b305cf0868f4
Content-Type: text/plain; charset="UTF-8"

Hi,

Some very minor nits and a couple of points that would require a v4:

On Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe <arne@...1227...> wrote:

> This allows OpenVPN to load non-default providers. This is mainly
> useful for loading the legacy provider with --provider legacy:default
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/man-sections/generic-options.rst | 10 ++++++++++
>  src/openvpn/crypto_backend.h         |  7 +++++++
>  src/openvpn/crypto_mbedtls.c         |  8 ++++++++
>  src/openvpn/crypto_openssl.c         | 29 ++++++++++++++++++++++++++++
>  src/openvpn/openvpn.c                |  4 ++++
>  src/openvpn/options.c                |  4 ++++
>  src/openvpn/options.h                |  1 +
>  7 files changed, 63 insertions(+)
>
> diff --git a/doc/man-sections/generic-options.rst
> b/doc/man-sections/generic-options.rst
> index e6c1fe455..f5b8a9135 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -280,6 +280,16 @@ which mode OpenVPN is configured as.
>    This option solves the problem by persisting keys across :code:`SIGUSR1`
>    resets, so they don't need to be re-read.
>
> +--provider providers

+  Load the : separated list of (OpenSSL) providers. This is mainly useful
> for
> +  using an external provider for key management like tpm2-openssl or to
> load
> +  the legacy provider with
> +
> +  ::
> +
> +      --provider "legacy:default"


Please consider renaming the option as "--providers" in plural.


> +

+
>  --remap-usr1 signal
>    Control whether internally or externally generated :code:`SIGUSR1`
> signals
>    are remapped to :code:`SIGHUP` (restart without persisting state) or
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index cc897acf4..fa265e6c2 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -78,6 +78,13 @@ void crypto_clear_error(void);
>   */
>  void crypto_init_lib_engine(const char *engine_name);
>
> +
> +/**
> + * Load the given (OpenSSL) providers
> + * @param providers list of providers to load, seperated by :
> + */
> +void crypto_init_lib_provider(const char *providers);
> +
>  #ifdef DMALLOC
>  /*
>   * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 2f7f00d19..e6ed1ae99 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -70,6 +70,14 @@ crypto_init_lib_engine(const char *engine_name)
>          "available");
>  }
>
> +void crypto_init_lib_provider(const char *providers)
> +{
> +    if (providers)
> +    {
> +        msg(M_WARN, "Note: mbed TLS provider functionality is not
> available");
> +    }
> +}
> +
>  /*
>   *
>   * Functions related to the core crypto library
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 407ea4a7c..1900ccc1b 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -54,6 +54,9 @@
>  #if (OPENSSL_VERSION_NUMBER >= 0x10100000L) &&
> !defined(LIBRESSL_VERSION_NUMBER)
>  #include <openssl/kdf.h>
>  #endif
> +#if OPENSSL_VERSION_NUMBER >= 0x30000000L
> +#include <openssl/provider.h>
> +#endif
>
>  /*
>   * Check for key size creepage.
> @@ -145,6 +148,32 @@ crypto_init_lib_engine(const char *engine_name)
>  #endif
>  }
>
> +void
> +crypto_init_lib_provider(const char *providers)
> +{
> +    if (!providers)
> +    {
> +        return;
> +    }
> +#if OPENSSL_VERSION_NUMBER >= 0x30000000L
> +    struct gc_arena gc = gc_new();
> +    char *tmp_providers = string_alloc(providers, &gc);

+
> +    const char *provname;
> +    while ((provname = strsep(&tmp_providers, ":")))
> +    {
> +        /* Load providers into the default (NULL) library context */
> +        OSSL_PROVIDER* provider = OSSL_PROVIDER_load(NULL, provname);
> +        if (!provider)
> +        {
> +            crypto_msg(M_FATAL, "failed to load provider '%s'", provname);
> +        }
>

The gc has to be freed here.


> +    }
> +#else  /* OPENSSL_VERSION_NUMBER >= 0x30000000L */
> +    msg(M_WARN, "Note: OpenSSL hardware crypto engine functionality is
> not available");
>

"hardware crypto engine" --> "provider"

+#endif
> +}
> +
>  /*
>   *
>   * Functions related to the core crypto library
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index f8e94509f..3c9bcf885 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -112,6 +112,10 @@ void init_early(struct context *c)
>      /* init verbosity and mute levels */
>      init_verb_mute(c, IVM_LEVEL_1);
>
> +    /* Initialise OpenVPN provider, this needs to be intialised this
> +    * early since option post processing and also openssl info
> +    * printing depends on it */
> +    crypto_init_lib_provider((*c).options.providers);


c->options.providers


>  }
>
>  static void uninit_early(struct context *c)
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index ed2dcd53d..ab7b00783 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -8178,6 +8178,10 @@ add_option(struct options *options,
>              options->engine = "auto";
>          }
>      }
> +    else if (streq(p[0], "provider") && p[1] && !p[2])
> +    {
> +        options->providers = p[1];
> +    }
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
>  #ifdef ENABLE_PREDICTION_RESISTANCE
>      else if (streq(p[0], "use-prediction-resistance") && !p[1])
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 98c21a2a8..6759f1950 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -521,6 +521,7 @@ struct options
>      const char *prng_hash;
>      int prng_nonce_secret_len;
>      const char *engine;
> +    const char *providers;
>      bool replay;
>      bool mute_replay_warnings;
>      int replay_window;

--


We should not repeatedly load providers in each SIGHUP loop without
unloading them in some uninit() call. That would require saving pointers to
these explicitly loaded providers, unfortunately...

Selva

--000000000000aff5b305cf0868f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div><br></div><div>Some very mi=
nor nits and a couple of points that would require a v4:</div><div><br></di=
v><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, Oct 19, 2021 at 2:32 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...2068...=
7..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">This allows OpenVPN to load non-defa=
ult providers. This is mainly<br>
useful for loading the legacy provider with --provider legacy:default<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0doc/man-sections/generic-options.rst | 10 ++++++++++<br>
=C2=A0src/openvpn/crypto_backend.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 7 +++++++<br>
=C2=A0src/openvpn/crypto_mbedtls.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 8 ++++++++<br>
=C2=A0src/openvpn/crypto_openssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 29 ++=
++++++++++++++++++++++++++<br>
=C2=A0src/openvpn/openvpn.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 4 ++++<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 4 ++++<br>
=C2=A0src/openvpn/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 1 +<br>
=C2=A07 files changed, 63 insertions(+)<br>
<br>
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst<br>
index e6c1fe455..f5b8a9135 100644<br>
--- a/doc/man-sections/generic-options.rst<br>
+++ b/doc/man-sections/generic-options.rst<br>
@@ -280,6 +280,16 @@ which mode OpenVPN is configured as.<br>
=C2=A0 =C2=A0This option solves the problem by persisting keys across :code=
:`SIGUSR1`<br>
=C2=A0 =C2=A0resets, so they don&#39;t need to be re-read.<br>
<br>
+--provider providers=C2=A0</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+=C2=A0 Load the : separated list of (OpenSSL) providers. This is mainly us=
eful for<br>
+=C2=A0 using an external provider for key management like tpm2-openssl or =
to load<br>
+=C2=A0 the legacy provider with<br>
+<br>
+=C2=A0 ::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 --provider &quot;legacy:default&quot;=C2=A0</blockquo=
te><div><br></div><div>Please consider renaming the option as &quot;--provi=
ders&quot; in plural.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
+=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0--remap-usr1 signal<br>
=C2=A0 =C2=A0Control whether internally or externally generated :code:`SIGU=
SR1` signals<br>
=C2=A0 =C2=A0are remapped to :code:`SIGHUP` (restart without persisting sta=
te) or<br>
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h<br>
index cc897acf4..fa265e6c2 100644<br>
--- a/src/openvpn/crypto_backend.h<br>
+++ b/src/openvpn/crypto_backend.h<br>
@@ -78,6 +78,13 @@ void crypto_clear_error(void);<br>
=C2=A0 */<br>
=C2=A0void crypto_init_lib_engine(const char *engine_name);<br>
<br>
+<br>
+/**<br>
+ * Load the given (OpenSSL) providers<br>
+ * @param providers list of providers to load, seperated by :<br>
+ */<br>
+void crypto_init_lib_provider(const char *providers);<br>
+<br>
=C2=A0#ifdef DMALLOC<br>
=C2=A0/*<br>
=C2=A0 * OpenSSL memory debugging.=C2=A0 If dmalloc debugging is enabled, t=
ell<br>
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c<br>
index 2f7f00d19..e6ed1ae99 100644<br>
--- a/src/openvpn/crypto_mbedtls.c<br>
+++ b/src/openvpn/crypto_mbedtls.c<br>
@@ -70,6 +70,14 @@ crypto_init_lib_engine(const char *engine_name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;available&quot;);<br>
=C2=A0}<br>
<br>
+void crypto_init_lib_provider(const char *providers)<br>
+{<br>
+=C2=A0 =C2=A0 if (providers)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Note: mbed TLS provider func=
tionality is not available&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 *<br>
=C2=A0 * Functions related to the core crypto library<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index 407ea4a7c..1900ccc1b 100644<br>
--- a/src/openvpn/crypto_openssl.c<br>
+++ b/src/openvpn/crypto_openssl.c<br>
@@ -54,6 +54,9 @@<br>
=C2=A0#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L) &amp;&amp; !defined(=
LIBRESSL_VERSION_NUMBER)<br>
=C2=A0#include &lt;openssl/kdf.h&gt;<br>
=C2=A0#endif<br>
+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L<br>
+#include &lt;openssl/provider.h&gt;<br>
+#endif<br>
<br>
=C2=A0/*<br>
=C2=A0 * Check for key size creepage.<br>
@@ -145,6 +148,32 @@ crypto_init_lib_engine(const char *engine_name)<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
+void<br>
+crypto_init_lib_provider(const char *providers)<br>
+{<br>
+=C2=A0 =C2=A0 if (!providers)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L<br>
+=C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
+=C2=A0 =C2=A0 char *tmp_providers =3D string_alloc(providers, &amp;gc);=C2=
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 const char *provname;<br>
+=C2=A0 =C2=A0 while ((provname =3D strsep(&amp;tmp_providers, &quot;:&quot=
;)))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Load providers into the default (NULL) libr=
ary context */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 OSSL_PROVIDER* provider =3D OSSL_PROVIDER_load=
(NULL, provname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!provider)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_msg(M_FATAL, &quot;failed=
 to load provider &#39;%s&#39;&quot;, provname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>The gc h=
as to be freed here.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+#else=C2=A0 /* OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L */<br>
+=C2=A0 =C2=A0 msg(M_WARN, &quot;Note: OpenSSL hardware crypto engine funct=
ionality is not available&quot;);<br></blockquote><div><br></div><div>&quot=
;hardware crypto engine&quot; --&gt; &quot;provider&quot;</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
+#endif<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 *<br>
=C2=A0 * Functions related to the core crypto library<br>
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c<br>
index f8e94509f..3c9bcf885 100644<br>
--- a/src/openvpn/openvpn.c<br>
+++ b/src/openvpn/openvpn.c<br>
@@ -112,6 +112,10 @@ void init_early(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0/* init verbosity and mute levels */<br>
=C2=A0 =C2=A0 =C2=A0init_verb_mute(c, IVM_LEVEL_1);<br>
<br>
+=C2=A0 =C2=A0 /* Initialise OpenVPN provider, this needs to be intialised =
this<br>
+=C2=A0 =C2=A0 * early since option post processing and also openssl info<b=
r>
+=C2=A0 =C2=A0 * printing depends on it */<br>
+=C2=A0 =C2=A0 crypto_init_lib_provider((*c).options.providers);</blockquot=
e><div><br></div><div>c-&gt;options.providers<br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0static void uninit_early(struct context *c)<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index ed2dcd53d..ab7b00783 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -8178,6 +8178,10 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;engine =3D &quo=
t;auto&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 else if (streq(p[0], &quot;provider&quot;) &amp;&amp; p[1] &=
amp;&amp; !p[2])<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;providers =3D p[1];<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#endif /* ENABLE_CRYPTO_MBEDTLS */<br>
=C2=A0#ifdef ENABLE_PREDICTION_RESISTANCE<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;use-prediction-resistance&qu=
ot;) &amp;&amp; !p[1])<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index 98c21a2a8..6759f1950 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -521,6 +521,7 @@ struct options<br>
=C2=A0 =C2=A0 =C2=A0const char *prng_hash;<br>
=C2=A0 =C2=A0 =C2=A0int prng_nonce_secret_len;<br>
=C2=A0 =C2=A0 =C2=A0const char *engine;<br>
+=C2=A0 =C2=A0 const char *providers;<br>
=C2=A0 =C2=A0 =C2=A0bool replay;<br>
=C2=A0 =C2=A0 =C2=A0bool mute_replay_warnings;<br>
=C2=A0 =C2=A0 =C2=A0int replay_window;=C2=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
--</blockquote><div><br></div><div>We should not repeatedly load providers =
in each SIGHUP loop without unloading them in some uninit() call. That woul=
d require saving pointers to these explicitly loaded providers, unfortunate=
ly...</div><div><br></div><div>Selva=C2=A0</div></div></div></div>

--000000000000aff5b305cf0868f4--

