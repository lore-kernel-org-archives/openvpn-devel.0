MIME-Version: 1.0
References: <20191122143315.8564-1-arne@...1227...>
 <20191122143315.8564-2-arne@...1227...>
In-Reply-To: <20191122143315.8564-2-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Nov 2019 21:07:43 -0500
Message-ID: <CAKuzo_iqvxpOQ4Gdo6WpLxoXUTzR6tC3kW-2y0AP1hr35jo5tA@...278...>
Content-Type: multipart/alternative; boundary="000000000000e6dbe60597f9ffad"
Subject: Re: [Openvpn-devel] [PATCH v7 2/2] Add support for OpenSSL TLS 1.3
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

--000000000000e6dbe60597f9ffad
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for the updates.

In spite of several nits below, I'm ACKing this.

All remarks are typos or grammar, important only for docs
and some comments. I suggest to handle these as a minor follow
up patch.

I'm also ignoring most typos in commit message except a few that
could be corrected during merge to add clarity.

On Fri, Nov 22, 2019 at 9:34 AM Arne Schwabe <arne@...1227...> wrote:

> For TLS 1.0 to 1.2 and OpenSSL 1.1.0 calls us and requires a PKCS1

padded response. As TLS 1.3 mandates RSA-PSS padding support and also
> requires an TLS 1.3 implementation to support RSA-PSS for older TLS

version, OpenSSL will query us to sign an already RSA-PSS padded

string.
>
> This patch adds an 'unpadded' and 'pkcs1' parameter to the

management-external-key option to signal that the client is
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
>

now --> know

it would extra logic and complexity to deal with this asynchronous
>

would --> would require

behaviour. Instead just give an error early if OpenSSL 1.1.1 and
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

      mangement-clients to implement the new feature when they want
>       to use OpenSSL 1.1.1
>
>       Add a padding=ALGORITHM argument to pk-sig to indicate the
>       algorithm. Drop adding PKCS1 ourselves.




> Patch v5: Send the right version of the patch
> Patch v6: rebase on master
> Patch v7: change style and reword documentation. Make thing more consistent


> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt  | 21 ++++++++++++-
>  doc/openvpn.8             |  7 +++--
>  src/openvpn/manage.c      | 20 +++++++++---
>  src/openvpn/manage.h      | 19 +++++++-----
>  src/openvpn/options.c     | 36 +++++++++++++++++++++-
>  src/openvpn/ssl_mbedtls.c |  8 +++--
>  src/openvpn/ssl_openssl.c | 64 ++++++++++++++++++++++++++++++---------
>  7 files changed, 143 insertions(+), 32 deletions(-)
>
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 17645c1d..c64e594d 100644
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
>

"interface expects" or" interfaces expect"

+(RSA_PKCS1_PADDING). EC signatures are always unpadded.
> +
> +The padding field is only present when pk-sig is used and
> +currently the following values can be requested PCKS1 and NOPADDING for
> RSA
>
+certificates and NOPADDING for EC certificates.
>

Remove this statement. Its no longer correct after the latest
changes. Anyway this info is repeated below with correct keywords.


>  This capability is intended to allow the use of arbitrary cryptographic
>  service providers with OpenVPN via the management interface.
> @@ -840,6 +847,18 @@ service providers with OpenVPN via the management
> interface.
>  New and updated clients are expected to use the version command to
> announce
>  a version > 1 and handle '>PK_SIGN' prompt and respond with 'pk-sig'.
>
> +The signature algorithm is indicated in the PK_SIGN request only if the
> +management client-version is >= 2.  In particular, to support TLS1.3 and
>

I think that should be "is > 2", not "is >= 2"

+TLS1.2 using OpenSSL 1.1.1, not padded signature support is required  and
> this
>

"not padded" --> "unpadded"  or "nonpadded"  (former is more consistent
with the rest)


> +can be indicated in the signing request only if the client version is > 2"
> +
> +The currently defined padding algorithm are:
>

algorithm --> algorithms

+
> + - RSA_PKCS1_PADDING  -  PKCS1 padding and RSA signature
> + - RSA_NO_PADDING     -  No padding may be added for the signature
>
+ - ECDSA              -  EC signature.
> +
> +
>  COMMAND -- certificate (OpenVPN 2.4 or higher)
>  ----------------------------------------------
>  Provides support for external storage of the certificate. Requires the
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 457c2667..28d4516a 100644
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
>

format that as

The optional parameters
.B nopadding
and
.B pkcs1
signal support for ....

+doc/mangement-notes.txt for a complete description of this
> +feature.
>  .\"*********************************************************
>  .TP
>  .B \-\-management\-external\-cert certificate\-hint
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 1d97c2b6..49864c0a 100644
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
> +                        const char *algorithm)
>  {
>      const char *prompt = "PK_SIGN";
>      const char *desc = "pk-sign";
> +    struct buffer buf_data = alloc_buf(strlen(b64_data) +
> strlen(algorithm) + 20);
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
> +        buf_write(&buf_data, algorithm, (int) strlen(algorithm));
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
> index d24abe09..6f5f34c1 100644
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
> @@ -341,12 +341,14 @@ struct management *management_init(void);
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
>
>  bool management_open(struct management *man,
>                       const char *addr,
> @@ -430,7 +432,8 @@ void management_learn_addr(struct management
> *management,
>
>  #endif
>
> -char *management_query_pk_sig(struct management *man, const char
> *b64_data);
> +char *management_query_pk_sig(struct management *man, const char
> *b64_data,
> +                              const char *algorithm);
>
>  char *management_query_cert(struct management *man, const char
> *cert_name);
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index c282b582..ebe553af 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2171,6 +2171,16 @@ options_postprocess_verify_ce(const struct options
> *options, const struct connec
>
>  #endif /* ifdef ENABLE_MANAGEMENT */
>
> +#if  defined(ENABLE_MANAGEMENT)
> +    if ((tls_version_max() >= TLS_VER_1_3)
> +        && (options->management_flags & MF_EXTERNAL_KEY)
> +        && !(options->management_flags & (MF_EXTERNAL_KEY_NOPADDING))
> +        )
> +    {
> +        msg(M_ERR, "management-external-key with OpenSSL 1.1.1 requires "
> +            "the nopadding argument/support");
> +    }
> +#endif
>      /*
>       * Windows-specific options.
>       */
> @@ -5241,9 +5251,33 @@ add_option(struct options *options,
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
> +            {
> +                options->management_flags |= MF_EXTERNAL_KEY_NOPADDING;
> +            }
> +            else if (streq(p[j], "pkcs1"))
> +            {
> +                options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
> +            }
> +            else
> +            {
> +                msg(msglevel, "Unknown management-external-key flag: %s",
> p[j]);
> +            }
> +        }
> +        /*
> +         * When no option is present, assume that only PKCS1
> +         * padding is supported
> +         */
> +        if (!(options->management_flags
> +              &(MF_EXTERNAL_KEY_NOPADDING | MF_EXTERNAL_KEY_PKCS1PAD)))
> +        {
> +            options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
> +        }
>          options->management_flags |= MF_EXTERNAL_KEY;
>      }
>      else if (streq(p[0], "management-external-cert") && p[1] && !p[2])
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index a4197cba..6fdef406 100644
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
> @@ -641,7 +640,12 @@ management_sign_func(void *sign_ctx, const void *src,
> size_t src_len,
>          goto cleanup;
>      }
>
> -    if (!(dst_b64 = management_query_pk_sig(management, src_b64)))
> +    /*
> +     * We only support RSA external keys and PKCS1 signatures at the
> moment
> +     * in mbed TLS, so the signature parameter is hardcoded to this
> encoding
> +     */
> +    if (!(dst_b64 = management_query_pk_sig(management, src_b64,
> +                                            "RSA_PKCS1_PADDING")))
>      {
>          goto cleanup;
>      }
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index a080338e..b7cfc77a 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -225,7 +225,9 @@ tls_version_max(void)
>       * However, the library we are *linked* against might be OpenSSL 1.1.1
>       * and therefore supports TLS 1.3. This needs to be checked at runtime
>       * since we can be compiled against 1.1.0 and then the library can be
> -     * upgraded to 1.1.1
> +     * upgraded to 1.1.1.
> +     * We only need need to this check for OpenSSL versions that can be
>

need need to this check -> need to check this

+     * upgraded to 1.1.1 without recompile (>= 1.1.0)
>       */
>      if (OpenSSL_version_num() >= 0x1010100fL)
>      {
> @@ -1133,24 +1135,52 @@ openvpn_extkey_rsa_finish(RSA *rsa)
>      return 1;
>  }
>
> -/* Pass the input hash in 'dgst' to management and get the signature back.
> - * On input siglen contains the capacity of the buffer 'sig'.
> - * On return signature is in sig.
> - * Return value is signature length or -1 on error.
> +/*
> + * Convert OpenSSL's constant to the strings used in the management
> + * interface query
> + */
> +const char *
> +get_rsa_padding_name (const int padding)
> +{
> +    switch (padding)
> +    {
> +        case RSA_PKCS1_PADDING:
> +            return "RSA_PKCS1_PADDING";
> +
> +        case RSA_NO_PADDING:
> +            return "RSA_NO_PADDING";
> +
> +        default:
> +            return "UNKNOWN";
> +    }
> +}
> +
> +/**
> + * Pass the input hash in 'dgst' to management and get the signature back.
> +  *
> + * @param dgst         hash to be signed
> + * @param dgstlen      len of data in dgst
> + * @param sig          On successful return signature is in sig.
> + * @param siglen       length of buffer sig
> + * @param algorithm    padding/hasing algorithm for the signature
>

hasing -> hashing

+ *
> + * @return             signature length or -1 on error.
>   */
>  static int
>  get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
> -                 unsigned char *sig, unsigned int siglen)
> +                 unsigned char *sig, unsigned int siglen,
> +                 const char *algorithm)
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
> +        out_b64 = management_query_pk_sig(management, in_b64, algorithm);
> +
>      }
>      if (out_b64)
>      {
> @@ -1164,18 +1194,19 @@ get_sig_from_man(const unsigned char *dgst,
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
> +    ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name
> (padding));
>
>      return (ret == len) ? ret : -1;
>  }
> @@ -1271,7 +1302,12 @@ ecdsa_sign(int type, const unsigned char *dgst, int
> dgstlen, unsigned char *sig,
>             unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r,
> EC_KEY *ec)
>  {
>      int capacity = ECDSA_size(ec);
> -    int len = get_sig_from_man(dgst, dgstlen, sig, capacity);
> +    /*
> +     * ECDSA does not seem to have proper constants for paddings since
> +     * there are only signatures without padding at the moment, use
> +     * a generic ECDSA for the moment
> +     */
> +    int len = get_sig_from_man(dgst, dgstlen, sig, capacity, "ECDSA");
>
>      if (len > 0)
>      {
>
>
Tested for RSA and EC signatures using
(i) an OpenSSL 1.1.1 build
(ii) an OpenSSL 1.1.0 build upgraded to 1.1.1 at run time.

Acked-by: selva.nair@...277...

--000000000000e6dbe60597f9ffad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Thanks =
for the updates.<br></div><div><br></div><div>In spite of several nits belo=
w, I&#39;m ACKing this. <br></div><div><br></div><div>All remarks are typos=
 or grammar, important only for docs</div><div>and some comments. I suggest=
 to handle these as a minor follow</div><div>up patch.=C2=A0</div></div><di=
v dir=3D"ltr"><div><br></div><div>I&#39;m also ignoring most typos in commi=
t message except a few that</div><div>could be corrected during merge to ad=
d clarity.</div><div><br></div></div><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Fri, Nov 22, 2019 at 9:34 AM Arne Schwabe &lt=
;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">For TL=
S 1.0 to 1.2 and OpenSSL 1.1.0 calls us and requires a PKCS1=C2=A0</blockqu=
ote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
padded response. As TLS 1.3 mandates RSA-PSS padding support and also<br>
requires an TLS 1.3 implementation to support RSA-PSS for older TLS=C2=A0</=
blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
version, OpenSSL will query us to sign an already RSA-PSS padded</blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
string.<br>
<br>
This patch adds an &#39;unpadded&#39; and &#39;pkcs1&#39; parameter to the<=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
more logical way but since we only now that version very late,<br></blockqu=
ote><div><br></div><div>now --&gt; know</div><div> <br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
it would extra logic and complexity to deal with this asynchronous<br></blo=
ckquote><div><br></div><div>would --&gt; would require</div><div> <br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
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
equire=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 mangement-clients to implement the new feature when th=
ey want<br>
=C2=A0 =C2=A0 =C2=A0 to use OpenSSL 1.1.1<br>
<br>
=C2=A0 =C2=A0 =C2=A0 Add a padding=3DALGORITHM argument to pk-sig to indica=
te the<br>
=C2=A0 =C2=A0 =C2=A0 algorithm. Drop adding PKCS1 ourselves.</blockquote><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
Patch v5: Send the right version of the patch<br>
Patch v6: rebase on master<br>
Patch v7: change style and reword documentation. Make thing more consistent=
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0doc/management-notes.txt=C2=A0 | 21 ++++++++++++-<br>
=C2=A0doc/openvpn.8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
7 +++--<br>
=C2=A0src/openvpn/manage.c=C2=A0 =C2=A0 =C2=A0 | 20 +++++++++---<br>
=C2=A0src/openvpn/manage.h=C2=A0 =C2=A0 =C2=A0 | 19 +++++++-----<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0| 36 +++++++++++++++++++++-<=
br>
=C2=A0src/openvpn/ssl_mbedtls.c |=C2=A0 8 +++--<br>
=C2=A0src/openvpn/ssl_openssl.c | 64 ++++++++++++++++++++++++++++++--------=
-<br>
=C2=A07 files changed, 143 insertions(+), 32 deletions(-)<br>
<br>
diff --git a/doc/management-notes.txt b/doc/management-notes.txt<br>
index 17645c1d..c64e594d 100644<br>
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
+The rsa-sig interfaces expects PKCS1 padded signatures for RSA keys<br></b=
lockquote><div><br></div><div>&quot;interface expects&quot; or&quot; interf=
aces expect&quot;<br></div><div> <br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+(RSA_PKCS1_PADDING). EC signatures are always unpadded.<br>
+<br>
+The padding field is only present when pk-sig is used and<br>
+currently the following values can be requested PCKS1 and NOPADDING for RS=
A<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+certificates and NOPADDING for EC certificates.<br></blockquote><div><br><=
/div><div>Remove this statement. Its no longer correct after the latest</di=
v><div>changes. Anyway this info is repeated below with correct keywords.</=
div><div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0This capability is intended to allow the use of arbitrary cryptograph=
ic<br>
=C2=A0service providers with OpenVPN via the management interface.<br>
@@ -840,6 +847,18 @@ service providers with OpenVPN via the management inte=
rface.<br>
=C2=A0New and updated clients are expected to use the version command to an=
nounce<br>
=C2=A0a version &gt; 1 and handle &#39;&gt;PK_SIGN&#39; prompt and respond =
with &#39;pk-sig&#39;.<br>
<br>
+The signature algorithm is indicated in the PK_SIGN request only if the<br>
+management client-version is &gt;=3D 2.=C2=A0 In particular, to support TL=
S1.3 and<br></blockquote><div><br></div><div>I think that should be &quot;i=
s &gt; 2&quot;, not &quot;is &gt;=3D 2&quot;<br></div><div> <br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+TLS1.2 using OpenSSL 1.1.1, not padded signature support is required=C2=A0=
 and this<br></blockquote><div><br></div><div>&quot;not padded&quot; --&gt;=
 &quot;unpadded&quot;=C2=A0 or &quot;nonpadded&quot;=C2=A0 (former is more =
consistent with the rest)<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+can be indicated in the signing request only if the client version is &gt;=
 2&quot;<br>
+<br>
+The currently defined padding algorithm are:<br></blockquote><div><br></di=
v><div>algorithm --&gt; algorithms</div><div> <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+<br>
+ - RSA_PKCS1_PADDING=C2=A0 -=C2=A0 PKCS1 padding and RSA signature<br>
+ - RSA_NO_PADDING=C2=A0 =C2=A0 =C2=A0-=C2=A0 No padding may be added for t=
he signature <br></blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
+ - ECDSA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=C2=A0 EC signat=
ure.<br>
+<br>
+<br>
=C2=A0COMMAND -- certificate (OpenVPN 2.4 or higher)<br>
=C2=A0----------------------------------------------<br>
=C2=A0Provides support for external storage of the certificate. Requires th=
e<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
index 457c2667..28d4516a 100644<br>
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
+pkcs1 signal support for different padding algorithms. See<br></blockquote=
><div><br></div><div>format that as</div><div><br></div><div>The optional p=
arameters<br></div><div>.B nopadding</div><div>and<br></div><div>.B pkcs1<b=
r></div><div>signal support for ....<br></div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
+doc/mangement-notes.txt for a complete description of this<br>
+feature.<br>
=C2=A0.\&quot;*********************************************************<br>
=C2=A0.TP<br>
=C2=A0.B \-\-management\-external\-cert certificate\-hint<br>
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c<br>
index 1d97c2b6..49864c0a 100644<br>
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
=A0 =C2=A0 const char *algorithm)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *prompt =3D &quot;PK_SIGN&quot;;<br>
=C2=A0 =C2=A0 =C2=A0const char *desc =3D &quot;pk-sign&quot;;<br>
+=C2=A0 =C2=A0 struct buffer buf_data =3D alloc_buf(strlen(b64_data) + strl=
en(algorithm) + 20);<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_write(&amp;buf_data, algorithm, (int) strl=
en(algorithm));<br>
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
index d24abe09..6f5f34c1 100644<br>
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
@@ -341,12 +341,14 @@ struct management *management_init(void);<br>
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
<br>
=C2=A0bool management_open(struct management *man,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *addr,<br>
@@ -430,7 +432,8 @@ void management_learn_addr(struct management *managemen=
t,<br>
<br>
=C2=A0#endif<br>
<br>
-char *management_query_pk_sig(struct management *man, const char *b64_data=
);<br>
+char *management_query_pk_sig(struct management *man, const char *b64_data=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *algorithm);<br>
<br>
=C2=A0char *management_query_cert(struct management *man, const char *cert_=
name);<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index c282b582..ebe553af 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -2171,6 +2171,16 @@ options_postprocess_verify_ce(const struct options *=
options, const struct connec<br>
<br>
=C2=A0#endif /* ifdef ENABLE_MANAGEMENT */<br>
<br>
+#if=C2=A0 defined(ENABLE_MANAGEMENT)<br>
+=C2=A0 =C2=A0 if ((tls_version_max() &gt;=3D TLS_VER_1_3)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (options-&gt;management_flags &amp;=
 MF_EXTERNAL_KEY)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; !(options-&gt;management_flags &amp=
; (MF_EXTERNAL_KEY_NOPADDING))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;management-external-key with =
OpenSSL 1.1.1 requires &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;the nopadding argument/sup=
port&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Windows-specific options.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
@@ -5241,9 +5251,33 @@ add_option(struct options *options,<br>
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
quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;manage=
ment_flags |=3D MF_EXTERNAL_KEY_NOPADDING;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (streq(p[j], &quot;pkcs1=
&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;manage=
ment_flags |=3D MF_EXTERNAL_KEY_PKCS1PAD;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quo=
t;Unknown management-external-key flag: %s&quot;, p[j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* When no option is present, assume that=
 only PKCS1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* padding is supported<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(options-&gt;management_flags<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;(MF_EXTERNAL_KEY_NOP=
ADDING | MF_EXTERNAL_KEY_PKCS1PAD)))<br>
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
index a4197cba..6fdef406 100644<br>
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
@@ -641,7 +640,12 @@ management_sign_func(void *sign_ctx, const void *src, =
size_t src_len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!(dst_b64 =3D management_query_pk_sig(management, src_b6=
4)))<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We only support RSA external keys and PKCS1 signatur=
es at the moment<br>
+=C2=A0 =C2=A0 =C2=A0* in mbed TLS, so the signature parameter is hardcoded=
 to this encoding<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!(dst_b64 =3D management_query_pk_sig(management, src_b6=
4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;RSA_PKCS1_PADDING&quot;)))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index a080338e..b7cfc77a 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -225,7 +225,9 @@ tls_version_max(void)<br>
=C2=A0 =C2=A0 =C2=A0 * However, the library we are *linked* against might b=
e OpenSSL 1.1.1<br>
=C2=A0 =C2=A0 =C2=A0 * and therefore supports TLS 1.3. This needs to be che=
cked at runtime<br>
=C2=A0 =C2=A0 =C2=A0 * since we can be compiled against 1.1.0 and then the =
library can be<br>
-=C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1<br>
+=C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1.<br>
+=C2=A0 =C2=A0 =C2=A0* We only need need to this check for OpenSSL versions=
 that can be<br></blockquote><div><br></div><div>need need to this check -&=
gt; need to check this</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0* upgraded to 1.1.1 without recompile (&gt;=3D 1.1.0)<=
br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (OpenSSL_version_num() &gt;=3D 0x1010100fL)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1133,24 +1135,52 @@ openvpn_extkey_rsa_finish(RSA *rsa)<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
-/* Pass the input hash in &#39;dgst&#39; to management and get the signatu=
re back.<br>
- * On input siglen contains the capacity of the buffer &#39;sig&#39;.<br>
- * On return signature is in sig.<br>
- * Return value is signature length or -1 on error.<br>
+/*<br>
+ * Convert OpenSSL&#39;s constant to the strings used in the management<br>
+ * interface query<br>
+ */<br>
+const char *<br>
+get_rsa_padding_name (const int padding)<br>
+{<br>
+=C2=A0 =C2=A0 switch (padding)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RSA_PKCS1_PADDING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;RSA_PKCS1_PADDING&q=
uot;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RSA_NO_PADDING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;RSA_NO_PADDING&quot=
;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;UNKNOWN&quot;;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/**<br>
+ * Pass the input hash in &#39;dgst&#39; to management and get the signatu=
re back.<br>
+=C2=A0 *<br>
+ * @param dgst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hash to be signed<br>
+ * @param dgstlen=C2=A0 =C2=A0 =C2=A0 len of data in dgst<br>
+ * @param sig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 On successful return signa=
ture is in sig.<br>
+ * @param siglen=C2=A0 =C2=A0 =C2=A0 =C2=A0length of buffer sig<br>
+ * @param algorithm=C2=A0 =C2=A0 padding/hasing algorithm for the signatur=
e<br></blockquote><div><br></div><div>hasing -&gt; hashing</div><div> <br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+ *<br>
+ * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0signature length=
 or -1 on error.<br>
=C2=A0 */<br>
=C2=A0static int<br>
=C2=A0get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned cha=
r *sig, unsigned int siglen)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned cha=
r *sig, unsigned int siglen,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *=
algorithm)<br>
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
, in_b64, algorithm);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (out_b64)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -1164,18 +1194,19 @@ get_sig_from_man(const unsigned char *dgst, unsigne=
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
+=C2=A0 =C2=A0 ret =3D get_sig_from_man(from, flen, to, len, get_rsa_paddin=
g_name (padding));<br>
<br>
=C2=A0 =C2=A0 =C2=A0return (ret =3D=3D len) ? ret : -1;<br>
=C2=A0}<br>
@@ -1271,7 +1302,12 @@ ecdsa_sign(int type, const unsigned char *dgst, int =
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
ent, use<br>
+=C2=A0 =C2=A0 =C2=A0* a generic ECDSA for the moment<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 int len =3D get_sig_from_man(dgst, dgstlen, sig, capacity, &=
quot;ECDSA&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (len &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0{<br><br></blockquote><div><br></div><div>Tested for RS=
A and EC signatures using=C2=A0</div><div>(i) an OpenSSL 1.1.1 build</div><=
div>(ii) an OpenSSL 1.1.0 build upgraded to 1.1.1 at run time.</div><div><b=
r></div><div>Acked-by: <a href=3D"mailto:selva.nair@...277..." target=3D"_b=
lank">selva.nair@...277...</a> <br></div></div></div>

--000000000000e6dbe60597f9ffad--

