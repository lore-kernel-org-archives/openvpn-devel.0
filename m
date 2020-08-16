From: "Vladislav Grishenko" <themiron@...2010...>
References: <20200727221341.22544-1-themiron@...2010...>
 <3dcf2ac7-c2fd-c33a-4fbd-aa290260f93e@...1227...>
In-Reply-To: <3dcf2ac7-c2fd-c33a-4fbd-aa290260f93e@...1227...>
Date: Sun, 16 Aug 2020 05:23:28 +0500
Message-ID: <012001d67363$82063610$8612a230$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH 1/2] Support multiple x509 field list to
 be username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: 'Arne Schwabe' <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

>>  #ifdef ENABLE_X509ALTUSERNAME
>> -    to.x509_username_field =3D (char *) options->x509_username_field;
>> +    memmove(to.x509_username_field, options->x509_username_field, sizeo=
f(to.x509_username_field));
>>  #else
>> -    to.x509_username_field =3D X509_USERNAME_FIELD_DEFAULT;
>> +    to.x509_username_field[0] =3D X509_USERNAME_FIELD_DEFAULT;
>>  #endif
>
> Can't we use the same code in both cases? And why memmove instead memcpy?

Can't, options struct contains x509_username_field only with ENABLE_X509ALT=
USERNAME.
Memmove is used to be consistent with remote_cert_ku copying several lines =
above, although I think memcpy is enough for here and above - tls and optio=
ns mem regions can't be crossed.

>>  /* Default field in X509 to be username */
>>  #define X509_USERNAME_FIELD_DEFAULT "CN"
>> +#define X509_USERNAME_FIELD_DELIMITER '/'
>
> This seems to be used nowhere.

It's used down below as a field delimiter for possible easy change:
> +        {
> +            *buf =3D X509_USERNAME_FIELD_DELIMITER;
>          }
I'll drop it with just "/%s" in v3.

>> +#define TLS_USERNAME_LEN 128
>
> NAK on this one. The X509 CN name length is max 64 characeters. So you
> either have stick to that limit in your patch or have to untagle the CN
> name length vs the field you are using, which might end up in a seperate
> patch.
> ...
> Not really wrong but we normally do stuff like appending etc to a string
> with our buf method/ classes. I would prefer we do it the same here
> instead of doing it completely different (espeically the !! is nowhere
> else found in the code base).

Good point, 64 limit can be kept for each backend_x509_get_username() call,=
 subsequent appending will be done via buffer methods - this way buffer siz=
e will be untied from TLS_USERNAME_LEN.

> C89 style instead C99. The !!i feels weird. It is the same as max(i, 1)
> but less readable.
=20
Yes, sure.

--
Best Regards, Vladislav Grishenko

-----Original Message-----
From: Arne Schwabe <arne@...1227...>=20
Sent: Friday, August 14, 2020 6:56 PM
To: Vladislav Grishenko <themiron@...2010...>; openvpn-devel@...1357...=
rge.net
Subject: Re: [Openvpn-devel] [PATCH 1/2] Support multiple x509 field list t=
o be username

Am 28.07.20 um 00:13 schrieb Vladislav Grishenko:
> OpenVPN has the ability to choose different x509 field in case "CN"
> can't be use used to be unique connected username since commit
> 935c62be9c0c8a256112df818bfb8470586a23b6.
> Unfortunately it's not enough in case client has multiple and valid
> certificates from PKI for different devices (ex. laptop, mobile, etc)
> with the same CN/UID.
>=20
> Having --duplicate-cn as a workaround helps only partially - clients
> can be connected, but it breaks coexistance with --ifconfig-pool-persist,
> --client-config-dir and opens doors to DoS possibility since same client
> device (with the same cert) being reconnected doesn't replace previously
> connected session no more, so can exhaust server ressources (ex. address
> pool) and can prevent other clients to be connected.
>=20
> With this patch, multiple x509 fields incl. "serialNumber" can be chosen
> to be username as --x509-username-files space-separated parameters.
> Multiple fields will be joined into one username using '/' delimeter for
> consistency with CN/addr logging and preserving ability for hierarchical
> ccd. As long as resulting username is unique, --duplicate-cn will not
> be required. Default value is preserved as "CN" only.
>=20
> Openssl backend is the only supported at the moment, since so far MbedTLS
> has no alt user name support at all.
> ---
>  doc/man-sections/tls-options.rst |  9 ++++---
>  src/openvpn/init.c               |  4 +--
>  src/openvpn/options.c            | 46 ++++++++++++++++++--------------
>  src/openvpn/options.h            |  4 +--
>  src/openvpn/ssl.h                |  1 +
>  src/openvpn/ssl_common.h         |  8 +++++-
>  src/openvpn/ssl_verify.c         | 35 ++++++++++++++++--------
>  src/openvpn/ssl_verify_openssl.c | 15 +++++++++++
>  8 files changed, 83 insertions(+), 39 deletions(-)
>=20
> diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-opti=
ons.rst
> index 8c2db7cd..301f8be4 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -632,13 +632,13 @@ certificates and keys: https://github.com/OpenVPN/e=
asy-rsa
>    options can be defined to track multiple attributes.
>=20=20
>  --x509-username-field args
> -  Field in the X.509 certificate subject to be used as the username
> +  Field list in the X.509 certificate subject to be used as the username
>    (default :code:`CN`).
>=20=20
>    Valid syntax:
>    ::
>=20=20
> -     x509-username-field [ext:]fieldname
> +     x509-username-field [ext:]fieldname [[ext:]fieldname...]
>=20=20
>    Typically, this option is specified with **fieldname** as
>    either of the following:
> @@ -646,6 +646,7 @@ certificates and keys: https://github.com/OpenVPN/eas=
y-rsa
>=20=20
>       x509-username-field emailAddress
>       x509-username-field ext:subjectAltName
> +     x509-username-field CN serialNumber
>=20=20
>    The first example uses the value of the :code:`emailAddress` attribute
>    in the certificate's Subject field as the username. The second example
> @@ -653,7 +654,9 @@ certificates and keys: https://github.com/OpenVPN/eas=
y-rsa
>    ``fieldname`` :code:`subjectAltName` be searched for an rfc822Name
>    (email) field to be used as the username. In cases where there are
>    multiple email addresses in :code:`ext:fieldname`, the last occurrence
> -  is chosen.
> +  is chosen. The last example uses the value of :code:`CN` attribute in
> +  the Subject field and the hex representation of certificate's serial
> +  number delimited by slash symbol as the resulting username.
>=20=20
>    When this option is used, the ``--verify-x509-name`` option will match
>    against the chosen ``fieldname`` instead of the Common Name.
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 1ea4735d..11b417a8 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2912,9 +2912,9 @@ do_init_crypto_tls(struct context *c, const unsigne=
d int flags)
>      to.verify_hash =3D options->verify_hash;
>      to.verify_hash_algo =3D options->verify_hash_algo;
>  #ifdef ENABLE_X509ALTUSERNAME
> -    to.x509_username_field =3D (char *) options->x509_username_field;
> +    memmove(to.x509_username_field, options->x509_username_field, sizeof=
(to.x509_username_field));
>  #else
> -    to.x509_username_field =3D X509_USERNAME_FIELD_DEFAULT;
> +    to.x509_username_field[0] =3D X509_USERNAME_FIELD_DEFAULT;
>  #endif

Can't we use the same code in both cases? And why memmove instead memcpy?


>      to.es =3D c->c2.es;
>      to.net_ctx =3D &c->net_ctx;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index bc256b18..a51038dd 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -877,7 +877,7 @@ init_options(struct options *o, const bool init_gc)
>      o->tls_cert_profile =3D NULL;
>      o->ecdh_curve =3D NULL;
>  #ifdef ENABLE_X509ALTUSERNAME
> -    o->x509_username_field =3D X509_USERNAME_FIELD_DEFAULT;
> +    o->x509_username_field[0] =3D X509_USERNAME_FIELD_DEFAULT;
>  #endif
>  #ifdef ENABLE_PKCS11
>      o->pkcs11_pin_cache_period =3D -1;
> @@ -8434,7 +8434,7 @@ add_option(struct options *options,
>          x509_track_add(&options->x509_track, p[1], msglevel, &options->g=
c);
>      }
>  #ifdef ENABLE_X509ALTUSERNAME
> -    else if (streq(p[0], "x509-username-field") && p[1] && !p[2])
> +    else if (streq(p[0], "x509-username-field") && p[1])
>      {
>          /* This option used to automatically upcase the fieldname passed=
 as the
>           * option argument, e.g., "ou" became "OU". Now, this "helpfulne=
ss" is
> @@ -8443,32 +8443,38 @@ add_option(struct options *options,
>           * "emailAddress" are left as-is. An option parameter having the=
 "ext:"
>           * prefix for matching X.509v3 extended fields will also remain =
unchanged.
>           */
> -        char *s =3D p[1];
> +        size_t j;
>=20=20
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> -        if (strncmp("ext:", s, 4) !=3D 0)
> +
> +        for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
>          {
> -            size_t i =3D 0;
> -            while (s[i] && !isupper(s[i]))
> -            {
> -                i++;
> -            }
> -            if (strlen(s) =3D=3D i)
> +            char *s =3D p[j];
> +
> +            if (strncmp("ext:", s, 4) !=3D 0)
>              {
> -                while ((*s =3D toupper(*s)) !=3D '\0')
> +                size_t i =3D 0;
> +                while (s[i] && !isupper(s[i]))
> +                {
> +                    i++;
> +                }
> +                if (strlen(s) =3D=3D i)
>                  {
> -                    s++;
> +                    while ((*s =3D toupper(*s)) !=3D '\0')
> +                    {
> +                        s++;
> +                    }
> +                    msg(M_WARN, "DEPRECATED FEATURE: automatically upcas=
ed the "
> +                        "--x509-username-field parameter to '%s'; please=
 update your"
> +                        "configuration", p[j]);
>                  }
> -                msg(M_WARN, "DEPRECATED FEATURE: automatically upcased t=
he "
> -                    "--x509-username-field parameter to '%s'; please upd=
ate your"
> -                    "configuration", p[1]);
>              }
> +            else if (!x509_username_field_ext_supported(s+4))
> +            {
> +                msg(msglevel, "Unsupported x509-username-field extension=
: %s", s);
> +            }
> +            options->x509_username_field[j-1] =3D p[j];
>          }
> -        else if (!x509_username_field_ext_supported(s+4))
> -        {
> -            msg(msglevel, "Unsupported x509-username-field extension: %s=
", s);
> -        }
> -        options->x509_username_field =3D p[1];
>      }
>  #endif /* ENABLE_X509ALTUSERNAME */
>  #ifdef ENABLE_PKCS11
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index c5df2d18..e84aafec 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -582,8 +582,8 @@ struct options
>      int handshake_window;
>=20=20
>  #ifdef ENABLE_X509ALTUSERNAME
> -    /* Field used to be the username in X509 cert. */
> -    char *x509_username_field;
> +    /* Field list used to be the username in X509 cert. */
> +    char *x509_username_field[MAX_PARMS];
>  #endif
>=20=20
>      /* Old key allowed to live n seconds after new key goes active */
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 005628f6..51d6ab32 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -119,6 +119,7 @@
>=20=20
>  /* Default field in X509 to be username */
>  #define X509_USERNAME_FIELD_DEFAULT "CN"
> +#define X509_USERNAME_FIELD_DELIMITER '/'
>=20=20

This seems to be used nowhere.

>  #define KEY_METHOD_2  2
>=20=20
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 9f777750..a322b923 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -285,7 +285,13 @@ struct tls_options
>      const char *remote_cert_eku;
>      uint8_t *verify_hash;
>      hash_algo_type verify_hash_algo;
> -    char *x509_username_field;
> +
> +    /* Field list used to be the username in X509 cert. */
> +#ifdef ENABLE_X509ALTUSERNAME
> +    char *x509_username_field[MAX_PARMS];
> +#else
> +    char *x509_username_field[2];
> +#endif
>=20=20
>      /* allow openvpn config info to be
>       * passed over control channel */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 844bc57d..33ca58dc 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -48,7 +48,7 @@
>  #include "push.h"
>=20=20
>  /** Maximum length of common name */
> -#define TLS_USERNAME_LEN 64
> +#define TLS_USERNAME_LEN 128
>=20=20

NAK on this one. The X509 CN name length is max 64 characeters. So you
either have stick to that limit in your patch or have to untagle the CN
name length vs the field you are using, which might end up in a seperate
patch.



>  static void
>  string_mod_remap_name(char *str)
> @@ -640,6 +640,7 @@ verify_cert(struct tls_session *session, openvpn_x509=
_cert_t *cert, int cert_dep
>      char common_name[TLS_USERNAME_LEN+1] =3D {0}; /* null-terminated */
>      const struct tls_options *opt;
>      struct gc_arena gc =3D gc_new();
> +    size_t i, size;
>=20=20
>      opt =3D session->opt;
>      ASSERT(opt);
> @@ -660,19 +661,31 @@ verify_cert(struct tls_session *session, openvpn_x5=
09_cert_t *cert, int cert_dep
>      string_replace_leading(subject, '-', '_');
>=20=20
>      /* extract the username (default is CN) */
> -    if (SUCCESS !=3D backend_x509_get_username(common_name, sizeof(commo=
n_name),
> -                                             opt->x509_username_field, c=
ert))
> +    size =3D sizeof(common_name);
> +    for (i =3D 0; opt->x509_username_field[i] !=3D NULL && size > !!i; i=
++)
>      {

C89 style instead C99. The !!i feels weird. It is the same as max(i, 1)
but less readable.
> -        if (!cert_depth)
> +        char *buf =3D common_name + sizeof(common_name) - size;
> +
> +        if (SUCCESS !=3D backend_x509_get_username(buf + !!i, size - !!i,
> +                                                 opt->x509_username_fiel=
d[i], cert))
>          {
> -            msg(D_TLS_ERRORS, "VERIFY ERROR: could not extract %s from X=
509 "
> -                "subject string ('%s') -- note that the username length =
is "
> -                "limited to %d characters",
> -                opt->x509_username_field,
> -                subject,
> -                TLS_USERNAME_LEN);
> -            goto cleanup;
> +            break;
> +        }
> +        else if (i !=3D 0)
> +        {
> +            *buf =3D X509_USERNAME_FIELD_DELIMITER;
>          }
> +        size -=3D strlen(buf);
> +    }
> +    if (cert_depth =3D=3D 0 && opt->x509_username_field[i] !=3D NULL)
> +    {
> +        msg(D_TLS_ERRORS, "VERIFY ERROR: could not extract %s from X509 "
> +            "subject string ('%s') -- note that the username length is "
> +            "limited to %d characters",
> +            opt->x509_username_field[i],
> +            subject,
> +            TLS_USERNAME_LEN);
> +        goto cleanup;
>      }

Not really wrong but we normally do stuff like appending etc to a string
with our buf method/ classes. I would prefer we do it the same here
instead of doing it completely different (espeically the !! is nowhere
else found in the code base).


>=20=20
>      /* enforce character class restrictions in common name */
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index ff14db23..ebff0c92 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -268,6 +268,21 @@ backend_x509_get_username(char *common_name, int cn_=
len,
>              return FAILURE;
>          }
>      }
> +    else if (strcmp(LN_serialNumber,x509_username_field) =3D=3D 0)
> +    {
> +        ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(peer_cert);
> +        struct gc_arena gc =3D gc_new();
> +        char *serial;
> +
> +        serial =3D format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, NUL=
L, &gc);
> +        if (!serial || cn_len <=3D strlen(serial)+2)
> +        {
> +            gc_free(&gc);
> +            return FAILURE;
> +        }
> +        openvpn_snprintf(common_name, cn_len, "0x%s", serial);
> +        gc_free(&gc);
> +    }
>      else
>  #endif
>      if (FAILURE =3D=3D extract_x509_field_ssl(X509_get_subject_name(peer=
_cert),
>=20




