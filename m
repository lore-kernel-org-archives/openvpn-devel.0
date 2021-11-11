MIME-Version: 1.0
References: <20210520151148.2565578-7-arne@...1227...>
 <20211111192051.3706965-1-arne@...1227...>
In-Reply-To: <20211111192051.3706965-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Nov 2021 14:46:35 -0500
Message-ID: <CAKuzo_jgxyD-Ji_7cZ2NvupAz3jbb5WrFZr_Nqx3-+X+Ctc3Sg@...278...>
Content-Type: multipart/alternative; boundary="0000000000008ac86005d0889afa"
Subject: Re: [Openvpn-devel] [PATCH v5] [OSSL 3.0] Allow loading of non
 default providers
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

--0000000000008ac86005d0889afa
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Nov 11, 2021 at 2:21 PM Arne Schwabe <arne@...1227...> wrote:

> This allows OpenVPN to load non-default providers. This is mainly
> useful for loading the legacy provider with --providers legacy default
>
> Patch v4: use spaces to seperate providers, unload providers.
> Patch v5: General cleanup, rename option to --providers, add
>           option to usage() and add an entry to Changes.rst
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                          |  7 +++++++
>  doc/man-sections/generic-options.rst | 12 +++++++++++
>  src/openvpn/crypto_backend.h         | 15 ++++++++++++++
>  src/openvpn/crypto_mbedtls.c         | 13 ++++++++++++
>  src/openvpn/crypto_mbedtls.h         |  3 +++
>  src/openvpn/crypto_openssl.c         | 30 ++++++++++++++++++++++++++++
>  src/openvpn/crypto_openssl.h         |  9 +++++++++
>  src/openvpn/openvpn.c                | 13 ++++++++++++
>  src/openvpn/options.c                |  8 ++++++++
>  src/openvpn/options.h                |  9 +++++++++
>  10 files changed, 119 insertions(+)
>
> diff --git a/Changes.rst b/Changes.rst
> index 6f04e59ac..0ce39a839 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -50,6 +50,13 @@ Compatibility mode (``--compat-mode``)
>      with older peers. The options ``--compat-mode`` allows UIs to provide
> users
>      with an easy way to still connect to older servers.
>
> +OpenSSL 3.0 support
> +    OpenSSL 3.0 has been added. Most of OpenSSL 3.0 changes are not user
> visible but
> +    improve general compatibility with OpenSSL 3.0. ``--tls-cert-profile
> insecure``
> +    has been added to allow selecting the lowest OpenSSL security level
> (not
> +    recommended, use only if you must). OpenSSL 3.0 no longer supports
> the Blowfish
> +    (and other deprecated) algorithm by default and the new option
> ``--provider``
> +    allows loading the legacy provider to renable these algorithms.
>
>  Deprecated features
>  -------------------
> diff --git a/doc/man-sections/generic-options.rst
> b/doc/man-sections/generic-options.rst
> index e6c1fe455..a8f049f20 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -280,6 +280,18 @@ which mode OpenVPN is configured as.
>    This option solves the problem by persisting keys across :code:`SIGUSR1`
>    resets, so they don't need to be re-read.
>
> +--providers providers
> +  Load the list of (OpenSSL) providers. This is mainly useful for using an
> +  external provider for key management like tpm2-openssl or to load the
> +  legacy provider with
> +
> +  ::
> +
> +      --providers legacy default
> +
> +  Behaviour of changing this option between SIGHUP might not be well
> behaving.
> +  If you need to change/add/remove this option, fully restart OpenVPN.
> +
>  --remap-usr1 signal
>    Control whether internally or externally generated :code:`SIGUSR1`
> signals
>    are remapped to :code:`SIGHUP` (restart without persisting state) or
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 5aab3e1b7..c16837619 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -78,6 +78,21 @@ void crypto_clear_error(void);
>   */
>  void crypto_init_lib_engine(const char *engine_name);
>
> +
> +/**
> + * Load the given (OpenSSL) providers
> + * @param provider name of providers to load
> + * @return reference to the loaded provider
> + */
> +provider_t *crypto_load_provider(const char *provider);
> +
> +/**
> + * Unloads the given (OpenSSL) provider
> + * @param provname  name of the provider to unload
> + * @param provider  pointer to the provider to unload
> + */
> +void crypto_unload_provider(const char* provname, provider_t *provider);
> +
>  #ifdef DMALLOC
>  /*
>   * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 08b9e004f..39dbf38a5 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -69,6 +69,19 @@ crypto_init_lib_engine(const char *engine_name)
>          "available");
>  }
>
> +provider_t *crypto_load_provider(const char *provider)
> +{
> +    if (provider)
> +    {
> +        msg(M_WARN, "Note: mbed TLS provider functionality is not
> available");
> +    }
> +    return NULL;
> +}
> +
> +void crypto_unload_provider(const char* provname, provider_t *provider)
> +{
> +}
> +
>  /*
>   *
>   * Functions related to the core crypto library
> diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
> index 019de01d1..758ab1b40 100644
> --- a/src/openvpn/crypto_mbedtls.h
> +++ b/src/openvpn/crypto_mbedtls.h
> @@ -48,6 +48,9 @@ typedef mbedtls_md_context_t md_ctx_t;
>  /** Generic HMAC %context. */
>  typedef mbedtls_md_context_t hmac_ctx_t;
>
> +/* Use a dummy type for the provider */
> +typedef void provider_t;
> +
>  /** Maximum length of an IV */
>  #define OPENVPN_MAX_IV_LENGTH   MBEDTLS_MAX_IV_LENGTH
>
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index cc1d62210..c9731adb3 100644
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
>  #if defined(_WIN32) && defined(OPENSSL_NO_EC)
>  #error Windows build with OPENSSL_NO_EC: disabling EC key is not
> supported.
> @@ -149,6 +152,33 @@ crypto_init_lib_engine(const char *engine_name)
>  #endif
>  }
>
> +provider_t *
> +crypto_load_provider(const char *provider)
> +{
> +#if OPENSSL_VERSION_NUMBER >= 0x30000000L
> +    /* Load providers into the default (NULL) library context */
> +    OSSL_PROVIDER* prov = OSSL_PROVIDER_load(NULL, provider);
> +    if (!prov)
> +    {
> +        crypto_msg(M_FATAL, "failed to load provider '%s'", provider);
> +    }
> +    return prov;
> +#else  /* OPENSSL_VERSION_NUMBER >= 0x30000000L */
> +    msg(M_WARN, "Note: OpenSSL provider functionality is not available");
> +    return NULL;
> +#endif
> +}
> +
> +void crypto_unload_provider(const char* provname, provider_t *provider)
> +{
> +#if OPENSSL_VERSION_NUMBER >= 0x30000000L
> +    if (!OSSL_PROVIDER_unload(provider))
> +    {
> +        crypto_msg(M_FATAL, "failed to unload provider '%s'", provname);
> +    }
> +#endif
> +}
> +
>  /*
>   *
>   * Functions related to the core crypto library
> diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
> index e540a76b9..446f08508 100644
> --- a/src/openvpn/crypto_openssl.h
> +++ b/src/openvpn/crypto_openssl.h
> @@ -33,6 +33,10 @@
>  #include <openssl/hmac.h>
>  #include <openssl/md5.h>
>  #include <openssl/sha.h>
> +#if OPENSSL_VERSION_NUMBER >= 0x30000000L
> +#include <openssl/provider.h>
> +#endif
> +
>
>  /** Generic cipher key type %context. */
>  typedef EVP_CIPHER cipher_kt_t;
> @@ -49,12 +53,17 @@ typedef EVP_MD_CTX md_ctx_t;
>  /** Generic HMAC %context. */
>  #if OPENSSL_VERSION_NUMBER < 0x30000000L
>  typedef HMAC_CTX hmac_ctx_t;
> +
> +/* Use a dummy type for the provider */
> +typedef void provider_t;
>  #else
>  typedef struct {
>      OSSL_PARAM params[3];
>      uint8_t key[EVP_MAX_KEY_LENGTH];
>      EVP_MAC_CTX *ctx;
>  } hmac_ctx_t;
> +
> +typedef OSSL_PROVIDER provider_t;
>  #endif
>
>  /** Maximum length of an IV */
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index da06f59c2..a18a4dd43 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -112,10 +112,23 @@ void init_early(struct context *c)
>      /* init verbosity and mute levels */
>      init_verb_mute(c, IVM_LEVEL_1);
>
> +    /* Initialise OpenSSL provider, this needs to be initialised this
> +    * early since option post-processing and also openssl info
> +    * printing depends on it */
> +    for (int j=1; j < MAX_PARMS && c->options.providers.names[j]; j++)
> +    {
> +        c->options.providers.providers[j] =
> +            crypto_load_provider(c->options.providers.names[j]);
> +    }
>  }
>
>  static void uninit_early(struct context *c)
>  {
> +    for (int j=1; j < MAX_PARMS && c->options.providers.providers[j]; j++)
> +    {
> +        crypto_unload_provider(c->options.providers.names[j],
> +                               c->options.providers.providers[j]);
> +    }
>      net_ctx_free(&c->net_ctx);
>  }
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b5d65d293..b1f9473dc 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -581,6 +581,7 @@ static const char usage_message[] =
>      "                : Use --show-tls to see a list of supported TLS
> ciphers (suites).\n"
>      "--tls-cert-profile p : Set the allowed certificate crypto algorithm
> profile\n"
>      "                  (default=legacy).\n"
> +    "--providers l   : A list l of OpenSSL providers to load.\n"
>      "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
>      "                  if no ACK from remote within n seconds
> (default=%d).\n"
>      "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and
> recvd.\n"
> @@ -8157,6 +8158,13 @@ add_option(struct options *options,
>              options->engine = "auto";
>          }
>      }
> +    else if (streq(p[0], "providers") && p[1])
> +    {
> +        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL;j++)
> +        {
> +            options->providers.names[j] = p[j];
> +        }
> +    }
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
>  #ifdef ENABLE_PREDICTION_RESISTANCE
>      else if (streq(p[0], "use-prediction-resistance") && !p[1])
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 20b34ed4e..d4f41cd71 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -179,6 +179,14 @@ struct remote_list
>      struct remote_entry *array[CONNECTION_LIST_SIZE];
>  };
>
> +struct provider_list
> +{
> +    /* Names of the providers */
> +    const char *names[MAX_PARMS];
> +    /* Pointers to the loaded providers to unload them */
> +    provider_t *providers[MAX_PARMS];
> +};
> +
>  enum vlan_acceptable_frames
>  {
>      VLAN_ONLY_TAGGED,
> @@ -519,6 +527,7 @@ struct options
>      const char *ncp_ciphers;
>      const char *authname;
>      const char *engine;
> +    struct provider_list providers;
>      bool replay;
>      bool mute_replay_warnings;
>      int replay_window;
> --
> 2.33.0
>

Acked-by: Selva Nair <selva.nair@...277...>

Request for nit-fix during commit:
In the newly added paragraph in Changes.rst please change
``--provider`` to ``--providers``

Selva

--0000000000008ac86005d0889afa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Nov 11, 2021 at 2:21 PM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">This allows OpenVPN to loa=
d non-default providers. This is mainly<br>
useful for loading the legacy provider with --providers legacy default<br>
<br>
Patch v4: use spaces to seperate providers, unload providers.<br>
Patch v5: General cleanup, rename option to --providers, add<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 option to usage() and add an entry to Ch=
anges.rst<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0Changes.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +++++++<br>
=C2=A0doc/man-sections/generic-options.rst | 12 +++++++++++<br>
=C2=A0src/openvpn/crypto_backend.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ++=
++++++++++++<br>
=C2=A0src/openvpn/crypto_mbedtls.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 ++=
++++++++++<br>
=C2=A0src/openvpn/crypto_mbedtls.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 3 +++<br>
=C2=A0src/openvpn/crypto_openssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++=
++++++++++++++++++++++++++<br>
=C2=A0src/openvpn/crypto_openssl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 9 +++++++++<br>
=C2=A0src/openvpn/openvpn.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 13 ++++++++++++<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 8 ++++++++<br>
=C2=A0src/openvpn/options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 9 +++++++++<br>
=C2=A010 files changed, 119 insertions(+)<br>
<br>
diff --git a/Changes.rst b/Changes.rst<br>
index 6f04e59ac..0ce39a839 100644<br>
--- a/Changes.rst<br>
+++ b/Changes.rst<br>
@@ -50,6 +50,13 @@ Compatibility mode (``--compat-mode``)<br>
=C2=A0 =C2=A0 =C2=A0with older peers. The options ``--compat-mode`` allows =
UIs to provide users<br>
=C2=A0 =C2=A0 =C2=A0with an easy way to still connect to older servers.<br>
<br>
+OpenSSL 3.0 support<br>
+=C2=A0 =C2=A0 OpenSSL 3.0 has been added. Most of OpenSSL 3.0 changes are =
not user visible but<br>
+=C2=A0 =C2=A0 improve general compatibility with OpenSSL 3.0. ``--tls-cert=
-profile insecure``<br>
+=C2=A0 =C2=A0 has been added to allow selecting the lowest OpenSSL securit=
y level (not<br>
+=C2=A0 =C2=A0 recommended, use only if you must). OpenSSL 3.0 no longer su=
pports the Blowfish<br>
+=C2=A0 =C2=A0 (and other deprecated) algorithm by default and the new opti=
on ``--provider``<br>
+=C2=A0 =C2=A0 allows loading the legacy provider to renable these algorith=
ms.<br>
<br>
=C2=A0Deprecated features<br>
=C2=A0-------------------<br>
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst<br>
index e6c1fe455..a8f049f20 100644<br>
--- a/doc/man-sections/generic-options.rst<br>
+++ b/doc/man-sections/generic-options.rst<br>
@@ -280,6 +280,18 @@ which mode OpenVPN is configured as.<br>
=C2=A0 =C2=A0This option solves the problem by persisting keys across :code=
:`SIGUSR1`<br>
=C2=A0 =C2=A0resets, so they don&#39;t need to be re-read.<br>
<br>
+--providers providers<br>
+=C2=A0 Load the list of (OpenSSL) providers. This is mainly useful for usi=
ng an<br>
+=C2=A0 external provider for key management like tpm2-openssl or to load t=
he<br>
+=C2=A0 legacy provider with<br>
+<br>
+=C2=A0 ::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 --providers legacy default<br>
+<br>
+=C2=A0 Behaviour of changing this option between SIGHUP might not be well =
behaving.<br>
+=C2=A0 If you need to change/add/remove this option, fully restart OpenVPN=
.<br>
+<br>
=C2=A0--remap-usr1 signal<br>
=C2=A0 =C2=A0Control whether internally or externally generated :code:`SIGU=
SR1` signals<br>
=C2=A0 =C2=A0are remapped to :code:`SIGHUP` (restart without persisting sta=
te) or<br>
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h<br>
index 5aab3e1b7..c16837619 100644<br>
--- a/src/openvpn/crypto_backend.h<br>
+++ b/src/openvpn/crypto_backend.h<br>
@@ -78,6 +78,21 @@ void crypto_clear_error(void);<br>
=C2=A0 */<br>
=C2=A0void crypto_init_lib_engine(const char *engine_name);<br>
<br>
+<br>
+/**<br>
+ * Load the given (OpenSSL) providers<br>
+ * @param provider name of providers to load<br>
+ * @return reference to the loaded provider<br>
+ */<br>
+provider_t *crypto_load_provider(const char *provider);<br>
+<br>
+/**<br>
+ * Unloads the given (OpenSSL) provider<br>
+ * @param provname=C2=A0 name of the provider to unload<br>
+ * @param provider=C2=A0 pointer to the provider to unload<br>
+ */<br>
+void crypto_unload_provider(const char* provname, provider_t *provider);<b=
r>
+<br>
=C2=A0#ifdef DMALLOC<br>
=C2=A0/*<br>
=C2=A0 * OpenSSL memory debugging.=C2=A0 If dmalloc debugging is enabled, t=
ell<br>
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c<br>
index 08b9e004f..39dbf38a5 100644<br>
--- a/src/openvpn/crypto_mbedtls.c<br>
+++ b/src/openvpn/crypto_mbedtls.c<br>
@@ -69,6 +69,19 @@ crypto_init_lib_engine(const char *engine_name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;available&quot;);<br>
=C2=A0}<br>
<br>
+provider_t *crypto_load_provider(const char *provider)<br>
+{<br>
+=C2=A0 =C2=A0 if (provider)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Note: mbed TLS provider func=
tionality is not available&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+void crypto_unload_provider(const char* provname, provider_t *provider)<br>
+{<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 *<br>
=C2=A0 * Functions related to the core crypto library<br>
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h<br>
index 019de01d1..758ab1b40 100644<br>
--- a/src/openvpn/crypto_mbedtls.h<br>
+++ b/src/openvpn/crypto_mbedtls.h<br>
@@ -48,6 +48,9 @@ typedef mbedtls_md_context_t md_ctx_t;<br>
=C2=A0/** Generic HMAC %context. */<br>
=C2=A0typedef mbedtls_md_context_t hmac_ctx_t;<br>
<br>
+/* Use a dummy type for the provider */<br>
+typedef void provider_t;<br>
+<br>
=C2=A0/** Maximum length of an IV */<br>
=C2=A0#define OPENVPN_MAX_IV_LENGTH=C2=A0 =C2=A0MBEDTLS_MAX_IV_LENGTH<br>
<br>
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c<br>
index cc1d62210..c9731adb3 100644<br>
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
=C2=A0#if defined(_WIN32) &amp;&amp; defined(OPENSSL_NO_EC)<br>
=C2=A0#error Windows build with OPENSSL_NO_EC: disabling EC key is not supp=
orted.<br>
@@ -149,6 +152,33 @@ crypto_init_lib_engine(const char *engine_name)<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
+provider_t *<br>
+crypto_load_provider(const char *provider)<br>
+{<br>
+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L<br>
+=C2=A0 =C2=A0 /* Load providers into the default (NULL) library context */=
<br>
+=C2=A0 =C2=A0 OSSL_PROVIDER* prov =3D OSSL_PROVIDER_load(NULL, provider);<=
br>
+=C2=A0 =C2=A0 if (!prov)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_msg(M_FATAL, &quot;failed to load provi=
der &#39;%s&#39;&quot;, provider);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return prov;<br>
+#else=C2=A0 /* OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L */<br>
+=C2=A0 =C2=A0 msg(M_WARN, &quot;Note: OpenSSL provider functionality is no=
t available&quot;);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+#endif<br>
+}<br>
+<br>
+void crypto_unload_provider(const char* provname, provider_t *provider)<br>
+{<br>
+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L<br>
+=C2=A0 =C2=A0 if (!OSSL_PROVIDER_unload(provider))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_msg(M_FATAL, &quot;failed to unload pro=
vider &#39;%s&#39;&quot;, provname);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 *<br>
=C2=A0 * Functions related to the core crypto library<br>
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h<br>
index e540a76b9..446f08508 100644<br>
--- a/src/openvpn/crypto_openssl.h<br>
+++ b/src/openvpn/crypto_openssl.h<br>
@@ -33,6 +33,10 @@<br>
=C2=A0#include &lt;openssl/hmac.h&gt;<br>
=C2=A0#include &lt;openssl/md5.h&gt;<br>
=C2=A0#include &lt;openssl/sha.h&gt;<br>
+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L<br>
+#include &lt;openssl/provider.h&gt;<br>
+#endif<br>
+<br>
<br>
=C2=A0/** Generic cipher key type %context. */<br>
=C2=A0typedef EVP_CIPHER cipher_kt_t;<br>
@@ -49,12 +53,17 @@ typedef EVP_MD_CTX md_ctx_t;<br>
=C2=A0/** Generic HMAC %context. */<br>
=C2=A0#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L<br>
=C2=A0typedef HMAC_CTX hmac_ctx_t;<br>
+<br>
+/* Use a dummy type for the provider */<br>
+typedef void provider_t;<br>
=C2=A0#else<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0OSSL_PARAM params[3];<br>
=C2=A0 =C2=A0 =C2=A0uint8_t key[EVP_MAX_KEY_LENGTH];<br>
=C2=A0 =C2=A0 =C2=A0EVP_MAC_CTX *ctx;<br>
=C2=A0} hmac_ctx_t;<br>
+<br>
+typedef OSSL_PROVIDER provider_t;<br>
=C2=A0#endif<br>
<br>
=C2=A0/** Maximum length of an IV */<br>
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c<br>
index da06f59c2..a18a4dd43 100644<br>
--- a/src/openvpn/openvpn.c<br>
+++ b/src/openvpn/openvpn.c<br>
@@ -112,10 +112,23 @@ void init_early(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0/* init verbosity and mute levels */<br>
=C2=A0 =C2=A0 =C2=A0init_verb_mute(c, IVM_LEVEL_1);<br>
<br>
+=C2=A0 =C2=A0 /* Initialise OpenSSL provider, this needs to be initialised=
 this<br>
+=C2=A0 =C2=A0 * early since option post-processing and also openssl info<b=
r>
+=C2=A0 =C2=A0 * printing depends on it */<br>
+=C2=A0 =C2=A0 for (int j=3D1; j &lt; MAX_PARMS &amp;&amp; c-&gt;options.pr=
oviders.names[j]; j++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;options.providers.providers[j] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_load_provider(c-&gt;optio=
ns.providers.names[j]);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void uninit_early(struct context *c)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 for (int j=3D1; j &lt; MAX_PARMS &amp;&amp; c-&gt;options.pr=
oviders.providers[j]; j++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 crypto_unload_provider(c-&gt;options.providers=
.names[j],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;options.providers.providers[j])=
;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0net_ctx_free(&amp;c-&gt;net_ctx);<br>
=C2=A0}<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index b5d65d293..b1f9473dc 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -581,6 +581,7 @@ static const char usage_message[] =3D<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 : Use --show-tls to see a list of supported TLS ciphers (suites).\n&=
quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;--tls-cert-profile p : Set the allowed certificat=
e crypto algorithm profile\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (default=3Dlegacy).\n&quot;<br>
+=C2=A0 =C2=A0 &quot;--providers l=C2=A0 =C2=A0: A list l of OpenSSL provid=
ers to load.\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;--tls-timeout n : Packet retransmit timeout on TL=
S control channel\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if no ACK from remote within n seconds (default=3D%d).\n&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0&quot;--reneg-bytes n : Renegotiate data chan. key afte=
r n bytes sent and recvd.\n&quot;<br>
@@ -8157,6 +8158,13 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;engine =3D &quo=
t;auto&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 else if (streq(p[0], &quot;providers&quot;) &amp;&amp; p[1])=
<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t j =3D 1; j &lt; MAX_PARMS &amp;&am=
p; p[j] !=3D NULL;j++)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;providers.names[j] =
=3D p[j];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0#endif /* ENABLE_CRYPTO_MBEDTLS */<br>
=C2=A0#ifdef ENABLE_PREDICTION_RESISTANCE<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;use-prediction-resistance&qu=
ot;) &amp;&amp; !p[1])<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index 20b34ed4e..d4f41cd71 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -179,6 +179,14 @@ struct remote_list<br>
=C2=A0 =C2=A0 =C2=A0struct remote_entry *array[CONNECTION_LIST_SIZE];<br>
=C2=A0};<br>
<br>
+struct provider_list<br>
+{<br>
+=C2=A0 =C2=A0 /* Names of the providers */<br>
+=C2=A0 =C2=A0 const char *names[MAX_PARMS];<br>
+=C2=A0 =C2=A0 /* Pointers to the loaded providers to unload them */<br>
+=C2=A0 =C2=A0 provider_t *providers[MAX_PARMS];<br>
+};<br>
+<br>
=C2=A0enum vlan_acceptable_frames<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VLAN_ONLY_TAGGED,<br>
@@ -519,6 +527,7 @@ struct options<br>
=C2=A0 =C2=A0 =C2=A0const char *ncp_ciphers;<br>
=C2=A0 =C2=A0 =C2=A0const char *authname;<br>
=C2=A0 =C2=A0 =C2=A0const char *engine;<br>
+=C2=A0 =C2=A0 struct provider_list providers;<br>
=C2=A0 =C2=A0 =C2=A0bool replay;<br>
=C2=A0 =C2=A0 =C2=A0bool mute_replay_warnings;<br>
=C2=A0 =C2=A0 =C2=A0int replay_window;<br>
-- <br>
2.33.0<br></blockquote><div><br></div><div>Acked-by: Selva Nair &lt;<a href=
=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt;</div><div><br=
></div><div>Request for nit-fix during commit:=C2=A0</div><div>In the newly=
 added paragraph in Changes.rst please change</div><div>``--provider`` to `=
`--providers``</div><div><br></div><div>Selva</div></div></div>

--0000000000008ac86005d0889afa--

