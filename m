MIME-Version: 1.0
References: <20191109120335.1552-1-arne@...1227...>
 <20191109120335.1552-2-arne@...1227...>
In-Reply-To: <20191109120335.1552-2-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 9 Nov 2019 12:51:12 -0500
Message-ID: <CAKuzo_jumtJSuAoJP+URdehrpTSSaBeFOX73dXymGKO16tf3Yg@...278...>
Content-Type: multipart/alternative; boundary="00000000000051a0530596ed8c23"
Subject: Re: [Openvpn-devel] [PATCH v6 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
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

--00000000000051a0530596ed8c23
Content-Type: text/plain; charset="UTF-8"

Hi,

This started exactly a year ago, so let's get over with it :)

By any chance is this an older version rebased to master? Saying this
because
most of the comments below are also in my previous remarks and were agreed
to
in your response...

See https://patchwork.openvpn.net/patch/587/#1157 and response

On Sat, Nov 9, 2019 at 7:31 AM Arne Schwabe <arne@...1227...> wrote:

> For TLS 1.0 to 1.2 and OpenSSL 1.1.0 calls us and requires a PKCS1
> padded response. As TLS 1.3 mandates RSA-PSS padding support and also
> requires an TLS 1.3 implementation to support RSA-PSS for older TLS
> version, OpenSSL will query us to sign an already RSA-PSS padded
> string.
>
> This patch adds an 'unpadded' and 'pkcs1' parameter to the
> management-external-key option to signal that the client is
> able to support pkcs1 as well as unpadded signature requests.
>
> Since clients that implement the management-external-key interface
> are usually rather tightly integrated solutions (OpenVPN Connect in the
> past, OpenVPN for Android), it is reasonable to expect that
> upgrading the OpenSSL library can be done together with
> management interface changes. Therefore we provide no backwards
> compatbility for mangement-interface clients not supporting
> OpenSSL 1.1.1.
>
> Using the management api client version instead might seem like the
> more logical way but since we only now that version very late,
> it would extra logic and complexity to deal with this asynchronous
> behaviour. Instead just give an error early if OpenSSL 1.1.1 and
> management-external-key without nopadding is detected.
>
> The interface is prepared for signalling PCKS1 and RSA-PSS support
> instead of signalling unpadded support.
>
> Patch v3: fix overlong lines and few other style patches. Note
>       two overlong lines concerning mbedtls are not fixed as they
>       are removed/shortend by the mbed tls patch to avoid conflicts
>
> Patch v4: Setting minimum TLS version proved to be not enough and
>       instead of implementing a whole compability layer we require
>       mangement-clients to implement the new feature when they want
>       to use OpenSSL 1.1.1
>
>       Add a padding=ALGORITHM argument to pk-sig to indicate the


The code below adds ",ALG" to PK_SIGN, not padding=ALG to pk-sig.

      algorithm. Drop adding PKCS1 ourselves.
>
> Patch v5: Send the right version of the patch
>
> Patch v6: Send version rebased on master
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt  | 13 +++++++++-
>  doc/openvpn.8             |  7 ++++--
>  src/openvpn/manage.c      | 20 ++++++++++++---
>  src/openvpn/manage.h      | 23 +++++++++++------
>  src/openvpn/options.c     | 36 +++++++++++++++++++++++++-
>  src/openvpn/ssl_mbedtls.c |  7 ++++--
>  src/openvpn/ssl_openssl.c | 53 +++++++++++++++++++++++++++++++--------
>  7 files changed, 130 insertions(+), 29 deletions(-)
>
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 17645c1d..f685af28 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -816,6 +816,7 @@ actual private key. When the SSL protocol needs to
> perform a sign
>  operation, the data to be signed will be sent to the management interface
>  via a notification as follows:
>
> +>PK_SIGN:[BASE64_DATA],[ALG] (if client announces support for management
> version > 2)
>  >PK_SIGN:[BASE64_DATA] (if client announces support for management
> version > 1)
>  >RSA_SIGN:[BASE64_DATA] (only older clients will be prompted like this)
>
> @@ -823,7 +824,7 @@ The management interface client should then create an
> appropriate signature of
>  the (decoded) BASE64_DATA using the private key and return the SSL
> signature as
>  follows:
>
> -pk-sig   (or rsa-sig)
> +pk-sig (or rsa-sig)
>  [BASE64_SIG_LINE]
>  .
>  .
> @@ -833,6 +834,12 @@ END
>  Base 64 encoded output of RSA_private_encrypt for RSA or ECDSA_sign()
>  for EC using OpenSSL or mbedtls_pk_sign() using mbed TLS will provide a
>  correct signature.
> +The rsa-sig interfaces expects PKCS1 padded signatures for RSA keys
> +(RSA_PKCS1_PADDING). EC signatures are always unpadded.
> +
> +The padding field is only present when pk-sig is used and
> +currently the following values can be requested PCKS1 and NOPADDING for
> RSA
> +certificates and NOPADDING for EC certificates.
>
>  This capability is intended to allow the use of arbitrary cryptographic

 service providers with OpenVPN via the management interface.
> @@ -840,6 +847,10 @@ service providers with OpenVPN via the management
> interface.
>  New and updated clients are expected to use the version command to
> announce
>  a version > 1 and handle '>PK_SIGN' prompt and respond with 'pk-sig'.
>
> +The older rsa-sig and pk-sig interfaces hav no capability to indidicate
> the
>

hav -> have
indidicate -> indicate


> +requested padding algorithm. When the 'nopadding' using version >= 2 is
> required.
>

That would be version > 2 isn't it ? Anyway, the meaning of this sentence
is totally unclear..


> +To support TLS 1.3 with OpenSSL 1.1.1 supporting unpadded signatures is
> required.
> +
>

I thought we already agreed to reword  this paragraph as

"The signature algorithm is indicated in the PK_SIGN request only if the
management client-version is >= 2.  In particular, to support TLS1.3 and
TLS1.2 using OpenSSL 1.1.1, nonpadded signature support is required
and this can be indicated in the signing request only if the client
version is > 2"

See https://patchwork.openvpn.net/patch/587/#1157 and response to it.

 COMMAND -- certificate (OpenVPN 2.4 or higher)
>  ----------------------------------------------
>  Provides support for external storage of the certificate. Requires the
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index f58a3ccc..99e01252 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2708,10 +2708,13 @@ Allow management interface to override
>  directives (client\-only).
>  .\"*********************************************************
>  .TP
> -.B \-\-management\-external\-key
> +.B \-\-management\-external\-key [nopadding] [pkcs1]
>  Allows usage for external private key file instead of
>  .B \-\-key
> -option (client\-only).
> +option (client\-only). The optional parameters nopadding and
> +pkcs1 signal support for different padding algorithms. See
> +doc/mangement-notes.txt for a complete description of this
> +feature.
>  .\"*********************************************************
>  .TP
>  .B \-\-management\-external\-cert certificate\-hint
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 1d97c2b6..bcfff664 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -3641,18 +3641,30 @@ management_query_multiline_flatten(struct
> management *man,
>
>  char *
>  /* returns allocated base64 signature */
> -management_query_pk_sig(struct management *man,
> -                        const char *b64_data)
> +management_query_pk_sig(struct management *man, const char *b64_data,
> +                        const char *padding)
>  {
>      const char *prompt = "PK_SIGN";
>      const char *desc = "pk-sign";
> +    struct buffer buf_data = alloc_buf(strlen(b64_data) + strlen(padding)
> + 20);
> +
>      if (man->connection.client_version <= 1)
>      {
>          prompt = "RSA_SIGN";
>          desc = "rsa-sign";
>      }
> -    return management_query_multiline_flatten(man, b64_data, prompt, desc,
> -
> &man->connection.ext_key_state, &man->connection.ext_key_input);
> +
> +    buf_write(&buf_data, b64_data, (int) strlen(b64_data));
> +    if (man->connection.client_version > 2)
> +    {
> +        buf_write(&buf_data, ",", (int) strlen(","));
> +        buf_write(&buf_data, padding, (int) strlen(padding));
> +    }
> +    char* ret = management_query_multiline_flatten(man,
> +            (char *)buf_bptr(&buf_data), prompt, desc,
> +            &man->connection.ext_key_state,
> &man->connection.ext_key_input);
> +    free_buf(&buf_data);
> +    return ret;
>  }
>
>  char *
> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
> index d24abe09..4bfcfdbe 100644
> --- a/src/openvpn/manage.h
> +++ b/src/openvpn/manage.h
> @@ -31,7 +31,7 @@
>  #include "socket.h"
>  #include "mroute.h"
>
> -#define MANAGEMENT_VERSION                      2
> +#define MANAGEMENT_VERSION                      3
>  #define MANAGEMENT_N_PASSWORD_RETRIES           3
>  #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE   100
>  #define MANAGEMENT_ECHO_BUFFER_SIZE           100
> @@ -341,12 +341,18 @@ struct management *management_init(void);
>  #ifdef MANAGEMENT_PF
>  #define MF_CLIENT_PF         (1<<7)
>  #endif
> -#define MF_UNIX_SOCK       (1<<8)
> -#define MF_EXTERNAL_KEY    (1<<9)
> -#define MF_UP_DOWN          (1<<10)
> -#define MF_QUERY_REMOTE     (1<<11)
> -#define MF_QUERY_PROXY      (1<<12)
> -#define MF_EXTERNAL_CERT    (1<<13)
> +#define MF_UNIX_SOCK                (1<<8)
> +#define MF_EXTERNAL_KEY             (1<<9)
> +#define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
> +#define MF_EXTERNAL_KEY_PKCS1PAD    (1<<11)
> +#define MF_UP_DOWN                  (1<<12)
> +#define MF_QUERY_REMOTE             (1<<13)
> +#define MF_QUERY_PROXY              (1<<14)
> +#define MF_EXTERNAL_CERT            (1<<15)
> +
> +#define MF_RSA_PKCS1_PADDING       1
> +#define MF_RSA_NO_PADDING          2
>

Looks like these two defines are unused and not needed.


> +


>  bool management_open(struct management *man,
>                       const char *addr,
> @@ -430,7 +436,8 @@ void management_learn_addr(struct management
> *management,
>
>  #endif
>
> -char *management_query_pk_sig(struct management *man, const char
> *b64_data);
> +char *management_query_pk_sig(struct management *man, const char
> *b64_data,
> +                              const char* pading);
>

pading -> padding


>
>  char *management_query_cert(struct management *man, const char
> *cert_name);
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index d9e8257d..ec426410 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2169,6 +2169,16 @@ options_postprocess_verify_ce(const struct options
> *options, const struct connec
>
>  #endif /* ifdef ENABLE_MANAGEMENT */
>
> +#if  defined(ENABLE_MANAGEMENT)
> +    if ((tls_version_max() >= TLS_VER_1_3) &&
> +        (options->management_flags & MF_EXTERNAL_KEY) &&
> +        !(options->management_flags & (MF_EXTERNAL_KEY_NOPADDING))
> +        )
> +    {
> +        msg(M_ERR, "management-external-key with OpenSSL 1.1.1 requires "
> +                   "the nopadding argument/support");
> +    }
> +#endif
>      /*
>       * Windows-specific options.
>       */
> @@ -5206,9 +5216,33 @@ add_option(struct options *options,
>          options->management_write_peer_info_file = p[1];
>      }
>  #ifdef ENABLE_MANAGEMENT
> -    else if (streq(p[0], "management-external-key") && !p[1])
> +    else if (streq(p[0], "management-external-key"))
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> +        for (int j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
> +        {
> +            if (streq(p[j], "nopadding"))

+            {
> +                options->management_flags |= MF_EXTERNAL_KEY_NOPADDING;
> +            }
> +            else if (p[1] && streq(p[1], "pkcs1"))
>

Again copying from previous review:
That should be
               else if (streq(p[j], "pkcs1"))
(i.e 1 --> j)


> +            {
> +                options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
> +            }
> +            else
> +            {
> +                msg(msglevel, "Unknown management-external-key flag: %s"
> , p[j]);
> +            }
> +        }
> +        /*
> +         * When no option is present, assume that only PKCS1
> +         * padding is supported
> +         */
> +        if (! (options->management_flags &
> +            (MF_EXTERNAL_KEY_NOPADDING | MF_EXTERNAL_KEY_PKCS1PAD)))
> +        {
> +            options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
> +        }
>          options->management_flags |= MF_EXTERNAL_KEY;
>      }
>      else if (streq(p[0], "management-external-cert") && p[1] && !p[2])
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index a4197cba..d7ceb341 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -626,7 +626,6 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx
> *ctx,
>  }
>
>  #ifdef ENABLE_MANAGEMENT
> -
>  /** Query the management interface for a signature, see
> external_sign_func. */
>  static bool
>  management_sign_func(void *sign_ctx, const void *src, size_t src_len,
> @@ -641,7 +640,11 @@ management_sign_func(void *sign_ctx, const void *src,
> size_t src_len,
>          goto cleanup;
>      }
>
> -    if (!(dst_b64 = management_query_pk_sig(management, src_b64)))
> +    /*
> +     * We only use PKCS1 signatures at the moment in mbed TLS,
> +     * there the signature parameter is hardcoded
> +     */
> +    if (!(dst_b64 = management_query_pk_sig(management, src_b64,
> "PKCS1")))
>      {
>          goto cleanup;
>      }
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index e07d6e74..5722ca1a 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -222,7 +222,9 @@ tls_version_max(void)
>       * The library we are *linked* against is OpenSSL 1.1.1
>       * and therefore supports TLS 1.3. This needs to be checked at runtime
>       * since we can be compiled against 1.1.0 and then the library can be
> -     * upgraded to 1.1.1
> +     * upgraded to 1.1.1.
> +     * We only need need to this check for OpenSSL versions that can be
> +     * upgraded to 1.1.1 without recompile (>= 1.1.0)
>       */
>      if (OpenSSL_version_num() >= 0x1010100fL)
>      {
> @@ -1125,24 +1127,46 @@ openvpn_extkey_rsa_finish(RSA *rsa)
>      return 1;
>  }
>
> -/* Pass the input hash in 'dgst' to management and get the signature back.
> +/*
> + * Convert OpenSSL's constant to the strings used in the management
> + * interface query
> + */
> +const char*
> +get_sig_padding_name(const int padding)
> +{
> +    switch(padding)
> +    {
> +        case RSA_PKCS1_PADDING:
> +            return "PKCS1";
> +        case RSA_NO_PADDING:
> +            return "NOPADDING";
> +        default:
> +            return "UNKNOWN";
> +    }
> +}
> +
> +/*
> + * Pass the input hash in 'dgst' to management and get the signature back.
>   * On input siglen contains the capacity of the buffer 'sig'.
>   * On return signature is in sig.
> + * pkcs1 controls if pkcs1 padding is required
>   * Return value is signature length or -1 on error.
>   */
>  static int
>  get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
> -                 unsigned char *sig, unsigned int siglen)
> +                 unsigned char *sig, unsigned int siglen,
> +                 int padding)
>  {
>      char *in_b64 = NULL;
>      char *out_b64 = NULL;
>      int len = -1;
>
> -    /* convert 'dgst' to base64 */
> -    if (management
> -        && openvpn_base64_encode(dgst, dgstlen, &in_b64) > 0)
> +    int bencret = openvpn_base64_encode(dgst, dgstlen, &in_b64);
> +
> +    if (management && bencret > 0)
>      {
> -        out_b64 = management_query_pk_sig(management, in_b64);
> +        out_b64 = management_query_pk_sig(management, in_b64,
> +                                          get_sig_padding_name(padding));
>      }
>      if (out_b64)
>      {
> @@ -1156,18 +1180,19 @@ get_sig_from_man(const unsigned char *dgst,
> unsigned int dgstlen,
>
>  /* sign arbitrary data */
>  static int
> -rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA
> *rsa, int padding)
> +rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA
> *rsa,
> +             int padding)
>  {
>      unsigned int len = RSA_size(rsa);
>      int ret = -1;
>
> -    if (padding != RSA_PKCS1_PADDING)
> +    if (padding != RSA_PKCS1_PADDING && padding != RSA_NO_PADDING)
>      {
>          RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT,
> RSA_R_UNKNOWN_PADDING_TYPE);
>          return -1;
>      }
>
> -    ret = get_sig_from_man(from, flen, to, len);
> +    ret = get_sig_from_man(from, flen, to, len, padding);
>
>      return (ret == len) ? ret : -1;
>  }
> @@ -1263,7 +1288,13 @@ ecdsa_sign(int type, const unsigned char *dgst, int
> dgstlen, unsigned char *sig,
>             unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r,
> EC_KEY *ec)
>  {
>      int capacity = ECDSA_size(ec);
> -    int len = get_sig_from_man(dgst, dgstlen, sig, capacity);
> +    /*
> +     * ECDSA does not seem to have proper constants for paddings since
> +     * there are only signatures without padding at the moment, reuse
> +     * RSA_NO_PADDING for now as it will trigger querying for "NOPADDING"
> in the
> +     * management interface
> +     */
> +    int len = get_sig_from_man(dgst, dgstlen, sig, capacity,
> RSA_NO_PADDING);
>
>      if (len > 0)
>      {
> --
>

Thanks,

Selva

--00000000000051a0530596ed8c23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>This started exact=
ly a year ago, so let&#39;s get over with it :)</div><div><br></div><div>By=
 any chance is this an older version rebased to master? Saying this because=
</div><div>most of the comments below are also in my previous remarks and=
=C2=A0were agreed to</div><div>in your response...</div><div><br></div><div=
>See=C2=A0<a href=3D"https://patchwork.openvpn.net/patch/587/#1157">https:/=
/patchwork.openvpn.net/patch/587/#1157</a> and response</div></div><div><br=
></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Sat, Nov 9, 2019 at 7:31 AM Arne Schwabe &lt;<a href=3D"mailto:arne@...1830...=
...">arne@...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">For TLS 1.0 to 1.2 and OpenSSL 1.1.0 calls us and requi=
res a PKCS1<br>
padded response. As TLS 1.3 mandates RSA-PSS padding support and also<br>
requires an TLS 1.3 implementation to support RSA-PSS for older TLS<br>
version, OpenSSL will query us to sign an already RSA-PSS padded<br>
string.<br>
<br>
This patch adds an &#39;unpadded&#39; and &#39;pkcs1&#39; parameter to the<=
br>
management-external-key option to signal that the client is<br>
able to support pkcs1 as well as unpadded signature requests.<br>
<br>
Since clients that implement the management-external-key interface<br>
are usually rather tightly integrated solutions (OpenVPN Connect in the<br>
past, OpenVPN for Android), it is reasonable to expect that<br>
upgrading the OpenSSL library can be done together with<br>
management interface changes. Therefore we provide no backwards<br>
compatbility for mangement-interface clients not supporting<br>
OpenSSL 1.1.1.<br>
<br>
Using the management api client version instead might seem like the<br>
more logical way but since we only now that version very late,<br>
it would extra logic and complexity to deal with this asynchronous<br>
behaviour. Instead just give an error early if OpenSSL 1.1.1 and<br>
management-external-key without nopadding is detected.<br>
<br>
The interface is prepared for signalling PCKS1 and RSA-PSS support<br>
instead of signalling unpadded support.<br>
<br>
Patch v3: fix overlong lines and few other style patches. Note<br>
=C2=A0 =C2=A0 =C2=A0 two overlong lines concerning mbedtls are not fixed as=
 they<br>
=C2=A0 =C2=A0 =C2=A0 are removed/shortend by the mbed tls patch to avoid co=
nflicts<br>
<br>
Patch v4: Setting minimum TLS version proved to be not enough and<br>
=C2=A0 =C2=A0 =C2=A0 instead of implementing a whole compability layer we r=
equire<br>
=C2=A0 =C2=A0 =C2=A0 mangement-clients to implement the new feature when th=
ey want<br>
=C2=A0 =C2=A0 =C2=A0 to use OpenSSL 1.1.1<br><br>
=C2=A0 =C2=A0 =C2=A0 Add a padding=3DALGORITHM argument to pk-sig to indica=
te the=C2=A0</blockquote><div><br></div><div>The code below adds &quot;,ALG=
&quot; to PK_SIGN, not padding=3DALG to pk-sig.</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 algorithm. Drop adding PKCS1 ourselves.<br>
<br>
Patch v5: Send the right version of the patch<br>
<br>
Patch v6: Send version rebased on master<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0doc/management-notes.txt=C2=A0 | 13 +++++++++-<br>
=C2=A0doc/openvpn.8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
7 ++++--<br>
=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0 =C2=A0 | 20 ++++++++++++---<br>
=C2=A0src/openvpn/manage.h=C2=A0 =C2=A0 =C2=A0 | 23 +++++++++++------<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0| 36 +++++++++++++++++++++++=
++-<br>
=C2=A0src/openvpn/ssl_mbedtls.c |=C2=A0 7 ++++--<br>
=C2=A0src/openvpn/ssl_openssl.c | 53 +++++++++++++++++++++++++++++++-------=
-<br>
=C2=A07 files changed, 130 insertions(+), 29 deletions(-)<br>
<br>
diff --git a/doc/management-notes.txt b/doc/management-notes.txt<br>
index 17645c1d..f685af28 100644<br>
--- a/doc/management-notes.txt<br>
+++ b/doc/management-notes.txt<br>
@@ -816,6 +816,7 @@ actual private key. When the SSL protocol needs to perf=
orm a sign<br>
=C2=A0operation, the data to be signed will be sent to the management inter=
face<br>
=C2=A0via a notification as follows:<br>
<br>
+&gt;PK_SIGN:[BASE64_DATA],[ALG] (if client announces support for managemen=
t version &gt; 2)<br>
=C2=A0&gt;PK_SIGN:[BASE64_DATA] (if client announces support for management=
 version &gt; 1)<br>
=C2=A0&gt;RSA_SIGN:[BASE64_DATA] (only older clients will be prompted like =
this)<br>
<br>
@@ -823,7 +824,7 @@ The management interface client should then create an a=
ppropriate signature of<br>
=C2=A0the (decoded) BASE64_DATA using the private key and return the SSL si=
gnature as<br>
=C2=A0follows:<br>
<br>
-pk-sig=C2=A0 =C2=A0(or rsa-sig)<br>
+pk-sig (or rsa-sig)<br>
=C2=A0[BASE64_SIG_LINE]<br>
=C2=A0.<br>
=C2=A0.<br>
@@ -833,6 +834,12 @@ END<br>
=C2=A0Base 64 encoded output of RSA_private_encrypt for RSA or ECDSA_sign()=
<br>
=C2=A0for EC using OpenSSL or mbedtls_pk_sign() using mbed TLS will provide=
 a<br>
=C2=A0correct signature.<br>
+The rsa-sig interfaces expects PKCS1 padded signatures for RSA keys<br>
+(RSA_PKCS1_PADDING). EC signatures are always unpadded.<br>
+<br>
+The padding field is only present when pk-sig is used and<br>
+currently the following values can be requested PCKS1 and NOPADDING for RS=
A<br>
+certificates and NOPADDING for EC certificates.<br>
<br>
=C2=A0This capability is intended to allow the use of arbitrary cryptograph=
ic=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0service providers with OpenVPN via the management interface.<br>
@@ -840,6 +847,10 @@ service providers with OpenVPN via the management inte=
rface.<br>
=C2=A0New and updated clients are expected to use the version command to an=
nounce<br>
=C2=A0a version &gt; 1 and handle &#39;&gt;PK_SIGN&#39; prompt and respond =
with &#39;pk-sig&#39;.<br>
<br>
+The older rsa-sig and pk-sig interfaces hav no capability to indidicate th=
e<br></blockquote><div><br></div><div>hav -&gt; have</div><div>indidicate -=
&gt; indicate</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+requested padding algorithm. When the &#39;nopadding&#39; using version &g=
t;=3D 2 is required.<br></blockquote><div><br></div><div>That would be vers=
ion &gt; 2 isn&#39;t it ? Anyway, the meaning of this sentence is totally u=
nclear..</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
+To support TLS 1.3 with OpenSSL 1.1.1 supporting unpadded signatures is re=
quired.<br>
+<br></blockquote><div><br></div><div>I thought we already agreed to reword=
=C2=A0 this paragraph as</div><div><br></div><div>&quot;The signature algor=
ithm is indicated in the PK_SIGN request only if the<br>management client-v=
ersion is &gt;=3D 2.=C2=A0 In particular, to support TLS1.3 and<br>TLS1.2 u=
sing OpenSSL 1.1.1, nonpadded signature support is required<br>and this can=
 be indicated in the signing request only if the client<br>version is &gt; =
2&quot;<br></div><div><br></div><div>See=C2=A0<a href=3D"https://patchwork.=
openvpn.net/patch/587/#1157">https://patchwork.openvpn.net/patch/587/#1157<=
/a> and response to it.</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
=C2=A0COMMAND -- certificate (OpenVPN 2.4 or higher)<br>
=C2=A0----------------------------------------------<br>
=C2=A0Provides support for external storage of the certificate. Requires th=
e<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
index f58a3ccc..99e01252 100644<br>
--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -2708,10 +2708,13 @@ Allow management interface to override<br>
=C2=A0directives (client\-only).<br>
=C2=A0.\&quot;*********************************************************<br>
=C2=A0.TP<br>
-.B \-\-management\-external\-key<br>
+.B \-\-management\-external\-key [nopadding] [pkcs1]<br>
=C2=A0Allows usage for external private key file instead of<br>
=C2=A0.B \-\-key<br>
-option (client\-only).<br>
+option (client\-only). The optional parameters nopadding and<br>
+pkcs1 signal support for different padding algorithms. See<br>
+doc/mangement-notes.txt for a complete description of this<br>
+feature.<br>
=C2=A0.\&quot;*********************************************************<br>
=C2=A0.TP<br>
=C2=A0.B \-\-management\-external\-cert certificate\-hint<br>
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c<br>
index 1d97c2b6..bcfff664 100644<br>
--- a/src/openvpn/manage.c<br>
+++ b/src/openvpn/manage.c<br>
@@ -3641,18 +3641,30 @@ management_query_multiline_flatten(struct managemen=
t *man,<br>
<br>
=C2=A0char *<br>
=C2=A0/* returns allocated base64 signature */<br>
-management_query_pk_sig(struct management *man,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *b64_data)<br>
+management_query_pk_sig(struct management *man, const char *b64_data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *padding)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *prompt =3D &quot;PK_SIGN&quot;;<br>
=C2=A0 =C2=A0 =C2=A0const char *desc =3D &quot;pk-sign&quot;;<br>
+=C2=A0 =C2=A0 struct buffer buf_data =3D alloc_buf(strlen(b64_data) + strl=
en(padding) + 20);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (man-&gt;connection.client_version &lt;=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prompt =3D &quot;RSA_SIGN&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc =3D &quot;rsa-sign&quot;;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 return management_query_multiline_flatten(man, b64_data, pro=
mpt, desc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;man-&gt;connection.ext_key_state, &amp;man-&gt;connectio=
n.ext_key_input);<br>
+<br>
+=C2=A0 =C2=A0 buf_write(&amp;buf_data, b64_data, (int) strlen(b64_data));<=
br>
+=C2=A0 =C2=A0 if (man-&gt;connection.client_version &gt; 2)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_write(&amp;buf_data, &quot;,&quot;, (int) =
strlen(&quot;,&quot;));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_write(&amp;buf_data, padding, (int) strlen=
(padding));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 char* ret =3D management_query_multiline_flatten(man,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (char *)buf_bptr(&amp;buf_data),=
 prompt, desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;man-&gt;connection.ext_key_=
state, &amp;man-&gt;connection.ext_key_input);<br>
+=C2=A0 =C2=A0 free_buf(&amp;buf_data);<br>
+=C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
=C2=A0char *<br>
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h<br>
index d24abe09..4bfcfdbe 100644<br>
--- a/src/openvpn/manage.h<br>
+++ b/src/openvpn/manage.h<br>
@@ -31,7 +31,7 @@<br>
=C2=A0#include &quot;socket.h&quot;<br>
=C2=A0#include &quot;mroute.h&quot;<br>
<br>
-#define MANAGEMENT_VERSION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
+#define MANAGEMENT_VERSION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
=C2=A0#define MANAGEMENT_N_PASSWORD_RETRIES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03<br>
=C2=A0#define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE=C2=A0 =C2=A0100<br>
=C2=A0#define MANAGEMENT_ECHO_BUFFER_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0100<br>
@@ -341,12 +341,18 @@ struct management *management_init(void);<br>
=C2=A0#ifdef MANAGEMENT_PF<br>
=C2=A0#define MF_CLIENT_PF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;7)<br>
=C2=A0#endif<br>
-#define MF_UNIX_SOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;8)<br>
-#define MF_EXTERNAL_KEY=C2=A0 =C2=A0 (1&lt;&lt;9)<br>
-#define MF_UP_DOWN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;10)<br>
-#define MF_QUERY_REMOTE=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;11)<br>
-#define MF_QUERY_PROXY=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;12)<br>
-#define MF_EXTERNAL_CERT=C2=A0 =C2=A0 (1&lt;&lt;13)<br>
+#define MF_UNIX_SOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1&lt;&lt;8)<br>
+#define MF_EXTERNAL_KEY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&=
lt;&lt;9)<br>
+#define MF_EXTERNAL_KEY_NOPADDING=C2=A0 =C2=A0(1&lt;&lt;10)<br>
+#define MF_EXTERNAL_KEY_PKCS1PAD=C2=A0 =C2=A0 (1&lt;&lt;11)<br>
+#define MF_UP_DOWN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (1&lt;&lt;12)<br>
+#define MF_QUERY_REMOTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&=
lt;&lt;13)<br>
+#define MF_QUERY_PROXY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&=
lt;&lt;14)<br>
+#define MF_EXTERNAL_CERT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&l=
t;15)<br>
+<br>
+#define MF_RSA_PKCS1_PADDING=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
+#define MF_RSA_NO_PADDING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br></blockqu=
ote><div><br></div><div>Looks like these two defines are unused and not nee=
ded.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0bool management_open(struct management *man,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *addr,<br>
@@ -430,7 +436,8 @@ void management_learn_addr(struct management *managemen=
t,<br>
<br>
=C2=A0#endif<br>
<br>
-char *management_query_pk_sig(struct management *man, const char *b64_data=
);<br>
+char *management_query_pk_sig(struct management *man, const char *b64_data=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char* pading);<br></blockquote><div><=
br></div><div>pading -&gt; padding</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
=C2=A0char *management_query_cert(struct management *man, const char *cert_=
name);<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index d9e8257d..ec426410 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -2169,6 +2169,16 @@ options_postprocess_verify_ce(const struct options *=
options, const struct connec<br>
<br>
=C2=A0#endif /* ifdef ENABLE_MANAGEMENT */<br>
<br>
+#if=C2=A0 defined(ENABLE_MANAGEMENT)<br>
+=C2=A0 =C2=A0 if ((tls_version_max() &gt;=3D TLS_VER_1_3) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (options-&gt;management_flags &amp; MF_EXTERNA=
L_KEY) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !(options-&gt;management_flags &amp; (MF_EXTER=
NAL_KEY_NOPADDING))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;management-external-key with =
OpenSSL 1.1.1 requires &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the nopadding argument/support&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Windows-specific options.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
@@ -5206,9 +5216,33 @@ add_option(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;management_write_peer_info_fi=
le =3D p[1];<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#ifdef ENABLE_MANAGEMENT<br>
-=C2=A0 =C2=A0 else if (streq(p[0], &quot;management-external-key&quot;) &a=
mp;&amp; !p[1])<br>
+=C2=A0 =C2=A0 else if (streq(p[0], &quot;management-external-key&quot;))<b=
r>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION(OPT_P_GENERAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int j =3D 1; j &lt; MAX_PARMS &amp;&amp; =
p[j] !=3D NULL; ++j)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (streq(p[j], &quot;nopadding&=
quot;))=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;manage=
ment_flags |=3D MF_EXTERNAL_KEY_NOPADDING;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (p[1] &amp;&amp; streq(p=
[1], &quot;pkcs1&quot;))<br>
</blockquote><div><br></div><div>Again copying from previous review:=C2=A0<=
/div><div>That should be<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else if (streq(p[j], &quot;pkcs1&quot;))<br></div><div>(i.e 1 --&=
gt; j)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;manage=
ment_flags |=3D MF_EXTERNAL_KEY_PKCS1PAD;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quo=
t;Unknown management-external-key flag: %s&quot; , p[j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* When no option is present, assume that=
 only PKCS1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* padding is supported<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (! (options-&gt;management_flags &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (MF_EXTERNAL_KEY_NOPADDING | MF_=
EXTERNAL_KEY_PKCS1PAD)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;management_flags |=
=3D MF_EXTERNAL_KEY_PKCS1PAD;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;management_flags |=3D MF_EXTE=
RNAL_KEY;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (streq(p[0], &quot;management-external-cert&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[2])<br>
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c<br>
index a4197cba..d7ceb341 100644<br>
--- a/src/openvpn/ssl_mbedtls.c<br>
+++ b/src/openvpn/ssl_mbedtls.c<br>
@@ -626,7 +626,6 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *=
ctx,<br>
=C2=A0}<br>
<br>
=C2=A0#ifdef ENABLE_MANAGEMENT<br>
-<br>
=C2=A0/** Query the management interface for a signature, see external_sign=
_func. */<br>
=C2=A0static bool<br>
=C2=A0management_sign_func(void *sign_ctx, const void *src, size_t src_len,=
<br>
@@ -641,7 +640,11 @@ management_sign_func(void *sign_ctx, const void *src, =
size_t src_len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!(dst_b64 =3D management_query_pk_sig(management, src_b6=
4)))<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We only use PKCS1 signatures at the moment in mbed T=
LS,<br>
+=C2=A0 =C2=A0 =C2=A0* there the signature parameter is hardcoded<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!(dst_b64 =3D management_query_pk_sig(management, src_b6=
4, &quot;PKCS1&quot;)))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index e07d6e74..5722ca1a 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -222,7 +222,9 @@ tls_version_max(void)<br>
=C2=A0 =C2=A0 =C2=A0 * The library we are *linked* against is OpenSSL 1.1.1=
<br>
=C2=A0 =C2=A0 =C2=A0 * and therefore supports TLS 1.3. This needs to be che=
cked at runtime<br>
=C2=A0 =C2=A0 =C2=A0 * since we can be compiled against 1.1.0 and then the =
library can be<br>
-=C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1<br>
+=C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1.<br>
+=C2=A0 =C2=A0 =C2=A0* We only need need to this check for OpenSSL versions=
 that can be<br>
+=C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1 without recompile (&gt;=3D 1.1.0)<=
br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (OpenSSL_version_num() &gt;=3D 0x1010100fL)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1125,24 +1127,46 @@ openvpn_extkey_rsa_finish(RSA *rsa)<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
-/* Pass the input hash in &#39;dgst&#39; to management and get the signatu=
re back.<br>
+/*<br>
+ * Convert OpenSSL&#39;s constant to the strings used in the management<br>
+ * interface query<br>
+ */<br>
+const char*<br>
+get_sig_padding_name(const int padding)<br>
+{<br>
+=C2=A0 =C2=A0 switch(padding)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RSA_PKCS1_PADDING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;PKCS1&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RSA_NO_PADDING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;NOPADDING&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;UNKNOWN&quot;;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/*<br>
+ * Pass the input hash in &#39;dgst&#39; to management and get the signatu=
re back.<br>
=C2=A0 * On input siglen contains the capacity of the buffer &#39;sig&#39;.=
<br>
=C2=A0 * On return signature is in sig.<br>
+ * pkcs1 controls if pkcs1 padding is required<br>
=C2=A0 * Return value is signature length or -1 on error.<br>
=C2=A0 */<br>
=C2=A0static int<br>
=C2=A0get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned cha=
r *sig, unsigned int siglen)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned cha=
r *sig, unsigned int siglen,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int padding)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char *in_b64 =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char *out_b64 =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int len =3D -1;<br>
<br>
-=C2=A0 =C2=A0 /* convert &#39;dgst&#39; to base64 */<br>
-=C2=A0 =C2=A0 if (management<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; openvpn_base64_encode(dgst, dgstlen=
, &amp;in_b64) &gt; 0)<br>
+=C2=A0 =C2=A0 int bencret =3D openvpn_base64_encode(dgst, dgstlen, &amp;in=
_b64);<br>
+<br>
+=C2=A0 =C2=A0 if (management &amp;&amp; bencret &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_b64 =3D management_query_pk_sig(management=
, in_b64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_b64 =3D management_query_pk_sig(management=
, in_b64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g=
et_sig_padding_name(padding));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (out_b64)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1156,18 +1180,19 @@ get_sig_from_man(const unsigned char *dgst, unsigne=
d int dgstlen,<br>
<br>
=C2=A0/* sign arbitrary data */<br>
=C2=A0static int<br>
-rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *=
rsa, int padding)<br>
+rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *=
rsa,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int padding)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int len =3D RSA_size(rsa);<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D -1;<br>
<br>
-=C2=A0 =C2=A0 if (padding !=3D RSA_PKCS1_PADDING)<br>
+=C2=A0 =C2=A0 if (padding !=3D RSA_PKCS1_PADDING &amp;&amp; padding !=3D R=
SA_NO_PADDING)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RS=
A_R_UNKNOWN_PADDING_TYPE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D get_sig_from_man(from, flen, to, len);<br>
+=C2=A0 =C2=A0 ret =3D get_sig_from_man(from, flen, to, len, padding);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return (ret =3D=3D len) ? ret : -1;<br>
=C2=A0}<br>
@@ -1263,7 +1288,13 @@ ecdsa_sign(int type, const unsigned char *dgst, int =
dgstlen, unsigned char *sig,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *siglen, const BIGNU=
M *kinv, const BIGNUM *r, EC_KEY *ec)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int capacity =3D ECDSA_size(ec);<br>
-=C2=A0 =C2=A0 int len =3D get_sig_from_man(dgst, dgstlen, sig, capacity);<=
br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* ECDSA does not seem to have proper constants for pad=
dings since<br>
+=C2=A0 =C2=A0 =C2=A0* there are only signatures without padding at the mom=
ent, reuse<br>
+=C2=A0 =C2=A0 =C2=A0* RSA_NO_PADDING for now as it will trigger querying f=
or &quot;NOPADDING&quot; in the<br>
+=C2=A0 =C2=A0 =C2=A0* management interface<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int len =3D get_sig_from_man(dgst, dgstlen, sig, capacity, R=
SA_NO_PADDING);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (len &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
--<br></blockquote><div><br></div><div>Thanks,</div><div><br></div><div>Sel=
va</div><div>=C2=A0</div></div></div>

--00000000000051a0530596ed8c23--

