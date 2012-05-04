Message-ID: <4FA4604A.5010400@...1147...>
Date: Sat, 05 May 2012 01:03:38 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1328627629-4675-1-git-send-email-janjust@...1147...>
	<4FA3A816.5040700@...1435...>
In-Reply-To: <4FA3A816.5040700@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Signed-off-by: Jan Just
	Keijser	<janjust@...1147...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Adriaan,

Adriaan de Jong wrote:
> Hi Janjust,
>
> I've finally had the time to take a look at this patch with a colleague
> who is more familiar with the subject at hand :).
>
> Hope this helps. Please see my comments inline.
>
> Adriaan
>
> On 02/07/2012 04:13 PM, Jan Just Keijser wrote:
>   
>> Added support for Elliptic curves (ECDSA) + SHA2 family signed
>> certificates.
>> ---
>>  init.c         |    7 ++++
>>  options.c      |   15 ++++++++++
>>  options.h      |    6 ++++
>>  ssl.c          |    3 ++
>>  ssl_backend.h  |   10 ++++++
>>  ssl_openssl.c  |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  ssl_polarssl.c |    9 ++++++
>>  7 files changed, 134 insertions(+), 0 deletions(-)
>>
>> diff --git a/init.c b/init.c
>> index 525f441..51b0d64 100644
>> --- a/init.c
>> +++ b/init.c
>> @@ -895,6 +895,9 @@ print_openssl_info (const struct options *options)
>>    if (options->show_ciphers || options->show_digests || options->show_engines
>>  #ifdef USE_SSL
>>        || options->show_tls_ciphers
>> +#ifdef USE_SSL_EC
>> +|| options->show_curves
>> +#endif
>>  #endif
>>      )
>>      {
>> @@ -907,6 +910,10 @@ print_openssl_info (const struct options *options)
>>  #ifdef USE_SSL
>>        if (options->show_tls_ciphers)
>>  	show_available_tls_ciphers ();
>> +#ifdef USE_SSL_EC
>> +      if (options->show_curves)
>> +    show_available_curves ();
>> +#endif
>>  #endif
>>        return true;
>>      }
>> diff --git a/options.c b/options.c
>> index 6b8ae22..ce23dbc 100644
>> --- a/options.c
>> +++ b/options.c
>> @@ -836,6 +836,9 @@ init_options (struct options *o, const bool init_gc)
>>  #ifdef ENABLE_X509ALTUSERNAME
>>    o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>>  #endif
>> +#ifdef USE_SSL_EC
>> +  o->curve_name = NULL;
>> +#endif
>>  #endif /* USE_SSL */
>>  #endif /* USE_CRYPTO */
>>  #ifdef ENABLE_PKCS11
>> @@ -6368,6 +6371,18 @@ add_option (struct options *options,
>>        VERIFY_PERMISSION (OPT_P_GENERAL);
>>        options->show_tls_ciphers = true;
>>      }
>> +#ifdef USE_SSL_EC
>> +  else if (streq (p[0], "show-curves"))
>> +    {
>> +      VERIFY_PERMISSION (OPT_P_GENERAL);
>> +      options->show_curves = true;
>> +    }
>> +  else if (streq (p[0], "ecdh") && p[1])
>> +    {
>> +      VERIFY_PERMISSION (OPT_P_CRYPTO);
>> +      options->curve_name= p[1];
>> +    }
>> +#endif
>>    else if (streq (p[0], "tls-server"))
>>      {
>>        VERIFY_PERMISSION (OPT_P_GENERAL);
>> diff --git a/options.h b/options.h
>> index 831d4f6..81e0757 100644
>> --- a/options.h
>> +++ b/options.h
>> @@ -200,6 +200,9 @@ struct options
>>    bool show_engines;
>>  #ifdef USE_SSL
>>    bool show_tls_ciphers;
>> +#ifdef USE_SSL_EC
>> +  bool show_curves;
>> +#endif
>>  #endif
>>    bool genkey;
>>  #endif
>> @@ -533,6 +536,9 @@ struct options
>>    const char *priv_key_file;
>>    const char *pkcs12_file;
>>    const char *cipher_list;
>> +#ifdef USE_SSL_EC
>> +  const char *curve_name;
>> +#endif
>>    const char *tls_verify;
>>    const char *tls_export_cert;
>>    const char *tls_remote;
>> diff --git a/ssl.c b/ssl.c
>> index c26756e..54efe2f 100644
>> --- a/ssl.c
>> +++ b/ssl.c
>> @@ -308,6 +308,9 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
>>      {
>>        tls_ctx_server_new(new_ctx);
>>        tls_ctx_load_dh_params(new_ctx, options->dh_file, options->dh_file_inline);
>> +#ifdef USE_SSL_EC
>> +      tls_ctx_load_ecdh_params(new_ctx, options->curve_name);
>> +#endif
>>      }
>>    else				/* if client */
>>      {
>> diff --git a/ssl_backend.h b/ssl_backend.h
>> index 243c9e3..ebf9f36 100644
>> --- a/ssl_backend.h
>> +++ b/ssl_backend.h
>> @@ -145,6 +145,16 @@ void tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file
>>      );
>>  
>>  /**
>> + * Load Elliptic Curve Parameters, and load them into the library-specific
>> + * TLS context.
>> + *
>> + * @param ctx			TLS context to use
>> + * @param curve_name	The name of the elliptic curve to load.
>> + */
>> +void tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
>> +    );
>> +
>> +/**
>>   * Load PKCS #12 file for key, cert and (optionally) CA certs, and add to
>>   * library-specific TLS context.
>>   *
>> diff --git a/ssl_openssl.c b/ssl_openssl.c
>> index b95944c..912dd8f 100644
>> --- a/ssl_openssl.c
>> +++ b/ssl_openssl.c
>> @@ -50,6 +50,9 @@
>>  #include <openssl/pkcs12.h>
>>  #include <openssl/x509.h>
>>  #include <openssl/crypto.h>
>> +#ifdef USE_SSL_EC
>> +#include <openssl/ec.h>
>> +#endif
>>  
>>  /*
>>   * Allocate space in SSL objects in which to store a struct tls_session
>> @@ -238,6 +241,46 @@ tls_ctx_load_dh_params (struct tls_root_ctx *ctx, const char *dh_file
>>    DH_free (dh);
>>  }
>>  
>> +void
>> +tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
>> +    )
>> +{
>> +#ifdef USE_SSL_EC
>> +  if (curve_name != NULL)
>> +  {
>> +    int nid;
>> +    EC_KEY   *ecdh  = NULL;
>> +  
>> +    nid = OBJ_sn2nid(curve_name);
>> +  
>> +    if (nid == 0)
>> +      msg(M_SSLERR, "unknown curve name (%s)", curve_name);
>> +    else
>> +    {
>> +      ecdh = EC_KEY_new_by_curve_name(nid);
>> +      if (ecdh == NULL)
>> +        msg (M_SSLERR, "Unable to create curve (%s)", curve_name);
>> +      else
>> +      {
>> +        const char *sname;
>> +  
>> +        if (!SSL_CTX_set_tmp_ecdh(ctx->ctx, ecdh))
>> +          msg (M_SSLERR, "SSL_CTX_set_tmp_ecdh: cannot add curve");
>> +  
>>     
>
> What is happening here exactly? Is the same key being reused for every
> connection, or is it magically regenerated by OpenSSL on every connection?
>
>   
the function SSL_CTX_set_tmp_ecdh is very similar to SSL_CTX_set_tmp 
(for DH keys).
It adds the curve to the SSL CTX (ConTeXt); this CTX is used only when 
negotiating the TLS channel - NOT the data channel. It is updated by the 
OpenSSL TLS code automagically.
>> +        /* Translate NID back to name , just for kicks */
>> +        sname   = OBJ_nid2sn(nid);
>> +        if (sname == NULL) sname = "(Unknown)";
>> +        msg (D_TLS_DEBUG_LOW, "ECDH curve %s added", sname);
>> +  
>> +        EC_KEY_free(ecdh);
>> +      }
>> +    }
>> +  }
>> +#else
>> +  msg(M_SSLERR, "Elliptic Curves not supported by this version of OpenSSL");
>> +#endif
>> +}
>> +
>>  int
>>  tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
>>  #if ENABLE_INLINE_FILES
>> @@ -1273,6 +1316,47 @@ show_available_tls_ciphers ()
>>    SSL_CTX_free (ctx);
>>  }
>>  
>> +/*
>> + *  * Show the Elliptic curves that are available for us to use
>> + *   * in the OpenSSL library.
>> + *    */
>> +#ifdef USE_SSL_EC
>> +void
>> +show_available_curves()
>> +{
>> +  EC_builtin_curve *curves = NULL;
>> +  size_t crv_len = 0;
>> +  size_t n = 0;
>> +
>> +  crv_len = EC_get_builtin_curves(NULL, 0);
>> +
>> +  curves = OPENSSL_malloc((int)(sizeof(EC_builtin_curve) * crv_len));
>> +
>> +  if (curves == NULL)
>> +    msg (M_SSLERR, "Cannot create EC_builtin_curve object");
>> +  else
>> +  {
>> +    if (EC_get_builtin_curves(curves, crv_len))
>> +    {
>> +      printf ("Available Elliptic curves:\n");
>> +      for (n = 0; n < crv_len; n++)
>> +      {
>> +        const char *sname;
>> +        sname   = OBJ_nid2sn(curves[n].nid);
>> +        if (sname == NULL) sname = "";
>> +
>> +        printf("%s\n", sname);
>> +      }
>> +    }
>> +    else
>> +    {
>> +      msg (M_SSLERR, "Cannot get list of builtin curves");
>> +    }
>> +    OPENSSL_free(curves);
>> +  }
>> +}
>> +#endif
>> +
>>  void
>>  get_highest_preference_tls_cipher (char *buf, int size)
>>  {
>> diff --git a/ssl_polarssl.c b/ssl_polarssl.c
>> index c50cf0a..a7a6d61 100644
>> --- a/ssl_polarssl.c
>> +++ b/ssl_polarssl.c
>> @@ -218,6 +218,15 @@ else
>>        (counter_type) 8 * mpi_size(&ctx->dhm_ctx->P));
>>  }
>>  
>> +#ifdef USE_SSL_EC
>> +void
>> +tls_ctx_load_ecdh_params (struct tls_root_ctx *ctx, const char *curve_name
>> +    )
>> +{
>> +    msg(M_WARN, "Elliptic Curves not yet supported by PolarSSL");
>> +}
>> +#endif
>> +
>>  int
>>  tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
>>  #if ENABLE_INLINE_FILES
>>     
>
> Codewise I don't have many comments. I do have a few questions
> surrounding the use of OpenSSL:
>
>  - How are curves for ECDSA set?
>
>  - Is the default curve used, or is the same curve reused?
>
>  - I don't quite understand how setting an ECDH curve relates to the
> ECDSA signature size. Is this an OpenSSL specific issue?
>
> These are partially based on a lack of knowledge of the OpenSSL
> implementation, so forgive me for any newbie questions there.
>
>   
as I said, the SSL_CTX_set_tmp_ecdh is used only for the TLS control 
channel connection. It does *NOT* add elliptic curve support on the data 
channel, as this requires quite a few more changes, some of which are 
not supported by the OpenSSL libs right now (e.g. the fact that openvpn 
calls the signing functions directly).

The main reason for adding this patch is to allow the use of 
certificates which are generated with ECDH keys and which are signed 
with a SHA2 family hash; without this patch , this is not allowed.

> Finally one more comment: to be accepted into the main branch, this
> needs manpage and command line documentation.
>
>   
very true... but that applies to more patches ;)

HTH,

JJK


