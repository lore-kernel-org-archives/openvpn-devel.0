MIME-Version: 1.0
References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
In-Reply-To: <20181031165954.6139-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Nov 2018 17:44:42 -0500
Message-ID: <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

My comments below has grown too long so first a summary for those
who TLDR;

My suggestion:
- Leave management-external-key as is (there is not much gained by
adding a parameter to it)
- Append a fairly flexible signature algorithm specifier to PK_SIGN
request to management
 (nopadding or pkcs1 is not good enough in the long run)
 Do not take cue from OpenSSL's design of RSA_private_encrypt() and rsa_sign()
 both of which fall short for historic reasons.
- require version 3 clients to support at least certain algorithms

Some of the comments below were written assuming --management-external-key
will get a new optional parameter and some are based on my suggestion not to
do so. So the rest is sometimes a bit of flux and/or repetitive. But I
spent some
time on this so here goes:

On Wed, Oct 31, 2018 at 1:00 PM Arne Schwabe <arne@...1227...> wrote:
>
> For TLS 1.0 to 1.2 and OpenSSL 1.1.0 calls us and requires a PKCS1
> padded response. As TLS 1.3 mandates RSA-PSS padding support and also
> requires an TLS 1.3 implementation to support RSA-PSS for older TLS
> version, OpenSSL will query us to sign an already RSA-PSS padded
> string.
>
> This patch adds an 'unpadded' and 'pkcs1' parameter to the
>
> management-external-key option to signal that the client is
> able to support pkcs1 as well as unpadded signature requests.


"unpadded" in past tense is confusing -- I suggest "nopadding" or "raw" or
"rsa-raw" to indicate that what it expects to do is a raw signature
(or no padding will be added) which means the caller should do the padding.
In  such cases the input will be invariably of the same size as the modulus
and there is no room for padding anyway.

(NB: in the code proper, you do use "nopadding" and not "unpadded"
which is better -- but also see below)

That said, I still fail to warm up to the idea of adding a parameter to
management-external-key. First, even with this precaution, signing can
fail in two cases:

(i) the config file has "--management-external-key nopadding" but the
client version is <= 2. In such cases no warning will be printed but
management will get prepadded data with no ALG indicator which the
external signer will definitely fail to treat as PKCS1. Either signing will fail
(not sure how an existing  client would handle that) or connection
will restart with verification error.

(ii) Taking a long view, the real problem is not just "padding" but
"signature algorithm" in general. That is, PK_SIGN (or RSA_SIGN)
does not provide enough details for generating a signature. In good
old days when we supported only TLS 1.1 or older and RSA keys, there
was only one kind of signature. Today one needs to know the hash
algorithm and the padding scheme to generate a signature. We get
away without the hash algorithm as the digestinfo header is
prepended to the hash by the time rsa_priv_enc is called (not so in
mbedTLS so we add it in that handler). But that will not work for
PSS if we were to support external PSS padding -- which we should
do in the long term.

Part of the reason for this is we have been playing along with OpenSSL
which has been trying hard to preserve a dated API. Now with 1.1.1,
they have broken it for good and the rsa_sign() callback does not even
get called anymore as padding cannot be assumend to be PKCS1.

So we have to stop taking cue from OpenSSL especially since the purpose
of external key is to support arbitrary external signing agents/libraries.

So, in short,  I suggest to just leave the management-external-key option alone
and only add a new parameter to PK_SIGN (more on that below) and make sure
the external sign dispatcher does not error out when padding is not PKCS1
(ie. support at least RSA_PADDING_NONE and RSA_PADDING_PKCS1  in
rsa_priv_enc() for now)

The early erroring out is only marginally useful as it does not catch
all cases as argued above. Also a user may try to deal with the error by setting
tls version max to 1.2 but that will also fail when openssl 1.1.1 is use -- this
time without triggering the early error-out. So we gain little by
mutilating this
option and all the complications it brings.

The patch will be considerably simple once this change is taken out.

In any case, both here (if we retain this) and in PK_SIGN a more generic
signalling is required. Else we wont be able to support external PSS
padding later -- just padding = PSS is not enough to do that, the hash
algorithm is
also required. The same is true for PKCS1 too but currently we do not support
external signer to add digest info for PKCS1 signatures. But going forward,
some external signers would need that option.

I would suggest: PKS_SIGN <base64data>,ALG

where
ALG = RSA_NONE_PKCS1 (current default),
          RSA_RAW (or RSA_NONE_NOPADDING)
         RSA_<hash-alg>_PKCS1
         ECDSA (current default if key is EC)
with ALG missing to be interpreted as current defaults (PKCS1
with digest info already prepended for RSA and ECDSA for EC).

Here <hash_lag> could be SHA256, SHA1 etc. and indicates
that the data is just the hash and the signer should add digestinfo
header to the signature. We do not have to support this
as yet but will come handy to have a way to do a complete signature
algorithm specifier in ALG.

And require that version 3 clients are expected to support at least
RSA_NONE_PKCS1, RSA_RAW and ECDSA.

Anyway, I did review the code considering both options -- not all
comments below are relevant if we decide not to modify
--management-external-key. That would be my preference.

>
> Since clients that implement the management-external-key interface
> are usually rather tightly integrated solutions (OpenVPN Connect in the
> past, OpenVPN for Android), it is reasonable to expect that
> upgrading the OpenSSL library can be done together with
> management interface changes. Therefore we provide no backwards
> compatbility for mangement-interface clients not supporting
> OpenSSL 1.1.1.


Looks perfectly acceptable to me..

>
>
> Using the management api client version instead might seem like the
> more logical way but since we only now that version very late,
> it would extra logic and complexity to deal with this asynchronous
> behaviour. Instead just give an error early if OpenSSL 1.1.1 and
> management-external-key without nopadding is detected.
>
> The interface is prepared for signalling PCKS1 and RSA-PSS support
> instead of signalling unpadded support.

"instead of" --> "in addition to" ?
unpadded support --> "signature algorithm to use"

>
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
>       algorithm. Drop adding PKCS1 ourselves.

The code below adds ",ALG" to PK_SIGN, not padding=ALG to pk-sig.
Better make the above consistent with that.

>
>
> Patch v5: Send the right version of the patch
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt  | 13 ++++++++++-
>  doc/openvpn.8             |  7 ++++--
>  src/openvpn/manage.c      | 18 +++++++++++---
>  src/openvpn/manage.h      | 23 +++++++++++-------
>  src/openvpn/options.c     | 45 +++++++++++++++++++++++++++++++++--
>  src/openvpn/ssl_mbedtls.c |  7 ++++--
>  src/openvpn/ssl_openssl.c | 49 +++++++++++++++++++++++++++++++--------
>  7 files changed, 134 insertions(+), 28 deletions(-)
>
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 17645c1d..f685af28 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -816,6 +816,7 @@ actual private key. When the SSL protocol needs to perform a sign
>  operation, the data to be signed will be sent to the management interface
>  via a notification as follows:
>
> +>PK_SIGN:[BASE64_DATA],[ALG] (if client announces support for management version > 2)
>  >PK_SIGN:[BASE64_DATA] (if client announces support for management version > 1)
>  >RSA_SIGN:[BASE64_DATA] (only older clients will be prompted like this)

List values of ALG that a version 3 client should support. And add that if ALG
is missing it should be interpreted as ECDSA for EC keys and
RSA_NONE_PKCS1 for RSA keys. That nicely covers the two possible
forms of PK_SIGN directive.

>
>
> @@ -823,7 +824,7 @@ The management interface client should then create an appropriate signature of
>  the (decoded) BASE64_DATA using the private key and return the SSL signature as
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
>
> +
> +The padding field is only present when pk-sig is used and
> +currently the following values can be requested PCKS1 and NOPADDING for RSA
> +certificates and NOPADDING for EC certificates.

This is totally confusing. There is no reason to distinguish between
rsa-sig and pk-sig as used by the client although we should encourage all new
clients to use pk-sig only. These added lines may be replaced by:

"For RSA keys, if signature algorithm is "RSA_NONE_PKCS1" or
unspecified, the data to sign contains the hash with digest info
header added. If
the algorithm is RSA_RAW, a raw RSA sign operation should be performed. Base 64
encoded output of OpenSSL function RSA_private_encrypt() with
padding=RSA_PADDING_PKCS1 for the first case and
padding=RSA_PADDING_NONE in the second case creates the correct signature.
In case of EC keys Base 64 encoded output of ECDSA_sign() provides the correct
signature."

And remove those references to ECDSA_sign() and RSA_private_encrypt() earlier.

>
>
>  This capability is intended to allow the use of arbitrary cryptographic
>  service providers with OpenVPN via the management interface.
> @@ -840,6 +847,10 @@ service providers with OpenVPN via the management interface.
>  New and updated clients are expected to use the version command to announce
>  a version > 1 and handle '>PK_SIGN' prompt and respond with 'pk-sig'.
>
> +The older rsa-sig and pk-sig interfaces hav no capability to indidicate the
> +requested padding algorithm. When the 'nopadding' using version >= 2 is required.
> +To support TLS 1.3 with OpenSSL 1.1.1 supporting unpadded signatures is required.
> +


Again, confusing. If you want to reiterate this what about:
"The signature algorithm is indicated in the PK_SIGN request only if the
or management client-version is > 2.  In particular, to support TLS1.3 and
TLS1.2 using OpenSSL 1.1.1, non-pkcs1 padded signature support is required
and this can be indicated in the signing request only if the client
version is > 2."

>  COMMAND -- certificate (OpenVPN 2.4 or higher)
>  ----------------------------------------------
>  Provides support for external storage of the certificate. Requires the
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index e80d4696..3cd5d944 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2739,10 +2739,13 @@ Allow management interface to override
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
> index 8b633f20..62d4bc7b 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -3639,18 +3639,30 @@ management_query_multiline_flatten(struct management *man,
>
>  char *
>  /* returns allocated base64 signature */
> -management_query_pk_sig(struct management *man,
> -                         const char *b64_data)
> +management_query_pk_sig(struct management *man, const char *b64_data,
> +                        const char *padding)


Suggest to change padding -> sign_alg

>
>  {
>      const char *prompt = "PK_SIGN";
>      const char *desc = "pk-sign";
> +    struct buffer buf_data = alloc_buf(strlen(b64_data) + strlen(padding) + 20);
> +
>      if (man->connection.client_version <= 1)
>      {
>          prompt = "RSA_SIGN";
>          desc = "rsa-sign";
>      }
> -    return management_query_multiline_flatten(man, b64_data, prompt, desc,
> +
> +    buf_write(&buf_data, b64_data, (int) strlen(b64_data));
> +    if (man->connection.client_version > 2)
>
> +    {
> +        buf_write(&buf_data, ",", (int) strlen(","));
> +        buf_write(&buf_data, padding, (int) strlen(padding));
> +    }
> +    char* ret = management_query_multiline_flatten(man,
> +            (char *)buf_bptr(&buf_data), prompt, desc,
>              &man->connection.ext_key_state, &man->connection.ext_key_input);
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
> +


These extra defines and associated code  can go if --management-external-key
is not changed.

>
>
>  bool management_open(struct management *man,
>                       const char *addr,
> @@ -430,7 +436,8 @@ void management_learn_addr(struct management *management,
>
>  #endif
>
> -char *management_query_pk_sig(struct management *man, const char *b64_data);
> +char *management_query_pk_sig(struct management *man, const char *b64_data,
> +                              const char* pading);


pading -> padding for consistency..
But padding -> sign_alg is my preference.

>
>
>  char *management_query_cert(struct management *man, const char *cert_name);
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 406669a3..2291dd9d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2141,6 +2141,23 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>
>  #endif
>
> +#if defined(ENABLE_CRYPTOAPI)
> +    if (o->cryptoapi_cert && (tls_version_max() >= TLS_VER_1_3))
> +    {
> +        msg(M_ERR, "Cryptoapi support currently is incompatible "
> +                   "with OpenSSL 1.1.1/TLS 1.3");
> +    }


TLS1.2 is also affected but for now ok like this.
I have a fix to support PSS in cryptoapi, just have to find some time to test it
thoroughly. Sigh..

> +#endif
> +#if  defined(ENABLE_MANAGEMENT)
> +    if ((tls_version_max() >= TLS_VER_1_3) &&
>
> +        (options->management_flags & MF_EXTERNAL_KEY) &&
> +        !(options->management_flags & (MF_EXTERNAL_KEY_NOPADDING))
>
> +        )
> +    {
> +        msg(M_ERR, "management-external-key with OpenSSL 1.1.1 requires "
> +                   "the nopadding argument/support");
> +    }


Same as above but I think this check is not that useful..

>
> +#endif
>      /*
>       * Windows-specific options.
>       */
> @@ -5151,9 +5168,33 @@ add_option(struct options *options,
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
> +            else if (p[1] && streq(p[1], "pkcs1"))


That should be
               else if (streq(p[j], "pkcs1"))
Note the [j]

But the whole chunk could be removed..

>
> +            {
> +                options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
> +            }
> +            else
> +            {
> +                msg(msglevel, "Unknown management-external-key flag: %s" , p[j]);
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


As we will anyway prompt for PKCS1 signatures even if the client does
not announce it, we can always set that flag unconditionally and
assume/require that all clients support PKCS1. Then the above is a simple

options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD

Again the above is irrelevant if we go with my suggestion to not touch
this option.

>          options->management_flags |= MF_EXTERNAL_KEY;
>      }
>      else if (streq(p[0], "management-external-cert") && p[1] && !p[2])
> @@ -8456,4 +8497,4 @@ add_option(struct options *options,
>      }
>  err:
>      gc_free(&gc);
> -}
> \ No newline at end of file
> +}
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index f7e8c2d0..09b1a8fa 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -626,7 +626,6 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
>  }
>
>  #ifdef ENABLE_MANAGEMENT
> -
>  /** Query the management interface for a signature, see external_sign_func. */
>  static bool
>  management_sign_func(void *sign_ctx, const void *src, size_t src_len,
> @@ -641,7 +640,11 @@ management_sign_func(void *sign_ctx, const void *src, size_t src_len,
>          goto cleanup;
>      }
>
> -    if (!(dst_b64 = management_query_pk_sig(management, src_b64)))
> +    /*
> +     * We only use PKCS1 signatures at the moment in mbed TLS,
> +     * there the signature parameter is hardcoded
> +     */
> +    if (!(dst_b64 = management_query_pk_sig(management, src_b64, "PKCS1")))

PKCS1 --> RSA_NONE_PKCS1  :)

>      {
>          goto cleanup;
>      }
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index c2c8fdc0..237c2b55 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1079,24 +1079,46 @@ openvpn_extkey_rsa_finish(RSA *rsa)
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

Change the above to sign_alg_name instead of padding_name

> +
> +/*
> + * Pass the input hash in 'dgst' to management and get the signature back.
>   * On input siglen contains the capacity of the buffer 'sig'.
>   * On return signature is in sig.
> + * pkcs1 controls if pkcs1 padding is required


That should be "The parameter padding controls the type of padding to use."

But I suggest sign_alg controls the signature algorithm to use.

The caller need only translate  padding (not hash algorithm) to
signature algorithm
as the hash_alg is currently not available in rsa_priv_enc() callback.
So for now
hash-alg will be always indicated as none. However,  we want the management
interface protocol be more flexible and hence we indicate the
signature algorithm
using more descriptive mnemonics like RSA_NONE_PKCS1 etc in PK_SIGN.

>   * Return value is signature length or -1 on error.
>   */
>  static int
>  get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
> -                 unsigned char *sig, unsigned int siglen)
> +                 unsigned char *sig, unsigned int siglen,
> +                 int padding)


I suggest replace that "int padding" by "const char *padding"
and pass in the translated name --- see below for a rationale.

Actually "const char *sign_alg" is my preference.

>
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


Then that would be just padding or sign_alg

>
>      }
>      if (out_b64)
>      {
> @@ -1110,18 +1132,19 @@ get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
>
>  /* sign arbitrary data */
>  static int
> -rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
> +rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
> +             int padding)
>  {
>      unsigned int len = RSA_size(rsa);
>      int ret = -1;
>
> -    if (padding != RSA_PKCS1_PADDING)
> +    if (padding != RSA_PKCS1_PADDING && padding != RSA_NO_PADDING)
>      {
>          RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
>          return -1;
>      }
>
> -    ret = get_sig_from_man(from, flen, to, len);
> +    ret = get_sig_from_man(from, flen, to, len, padding);


And use  "get_sig_padding_name(padding)" or preferably
"get_sign_alg_name(padding)" here.

>
>      return (ret == len)? ret : -1;
>  }
> @@ -1215,7 +1238,13 @@ ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
>             unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
>  {
>      int capacity = ECDSA_size(ec);
> -    int len = get_sig_from_man(dgst, dgstlen, sig, capacity);
> +    /*
> +     * ECDSA does not seem to have proper constants for paddings since
> +     * there are only signatures without padding at the moment, reuse
> +     * RSA_NO_PADDING for now as it will trigger querying for "NOPADDING" in the
> +     * management interface
> +     */
>
> +    int len = get_sig_from_man(dgst, dgstlen, sig, capacity, RSA_NO_PADDING);


That comment reads like a hack. As suggested above, passing the padding or
sign_alg name avoids it. And one could instead say:

/* ECDSA signature involves no padding */
int len = get_sig_from_man(dgst, dgstlen, sig, capacity, "ECDSA");

Just as "PKCS1"  (or "RSA_NONE_PKCS1") is hard coded in the request
when using mbedTLS.

>
>
>      if (len > 0)
>      {
> --
> 2.19.1


Selva

