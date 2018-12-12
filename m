References: <20181130135641.11533-1-gert@...1296...>
 <20181130135641.11533-3-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5e07f322-7d84-7758-8f46-f579579bd45d@...2181...>
Date: Wed, 12 Dec 2018 21:33:39 +1000
MIME-Version: 1.0
In-Reply-To: <20181130135641.11533-3-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9SxTQtNyzX7SyOw0s2Vyvet4Tds6msnOU"
Subject: Re: [Openvpn-devel] [PATCH 3/3] uncrustify openvpn/ sources
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9SxTQtNyzX7SyOw0s2Vyvet4Tds6msnOU
Content-Type: multipart/mixed; boundary="ACZ5IyHetSwEcSix3y5FCC5S3ipSWNuPm";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <5e07f322-7d84-7758-8f46-f579579bd45d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] uncrustify openvpn/ sources
References: <20181130135641.11533-1-gert@...1296...>
 <20181130135641.11533-3-gert@...1296...>
In-Reply-To: <20181130135641.11533-3-gert@...1296...>

--ACZ5IyHetSwEcSix3y5FCC5S3ipSWNuPm
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 30/11/2018 23:56, Gert Doering wrote:

[cut]

> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index fa057cb2..9687d8c2 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -159,7 +159,8 @@ ms_error_text(DWORD ms_err)
>          /* trim to the left */
>          if (rv)
>          {
> -            for (p =3D rv + strlen(rv) - 1; p >=3D rv; p--) {
> +            for (p =3D rv + strlen(rv) - 1; p >=3D rv; p--)
> +            {
>                  if (isspace(*p))
>                  {
>                      *p =3D '\0';
> @@ -198,7 +199,8 @@ err_put_ms_error(DWORD ms_err, int func, const char *=
file, int line)
>      }
>      /* since MS error codes are 32 bit, and the ones in the ERR_... syst=
em is
>       * only 12, we must have a mapping table between them.  */
> -    for (i =3D 0; i < ERR_MAP_SZ; i++) {
> +    for (i =3D 0; i < ERR_MAP_SZ; i++)
> +    {
>          if (err_map[i].ms_err =3D=3D ms_err)
>          {
>              ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file,=
 line);
> @@ -267,8 +269,8 @@ priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash=
_algo, const unsigned char
>      BCRYPT_PKCS1_PADDING_INFO padinfo =3D {hash_algo};
>      DWORD status;
>=20=20
> -    status =3D NCryptSignHash(hkey, padding? &padinfo : NULL, (BYTE*) fr=
om, flen,
> -                            to, tlen, &len, padding? BCRYPT_PAD_PKCS1 : =
0);
> +    status =3D NCryptSignHash(hkey, padding ? &padinfo : NULL, (BYTE *) =
from, flen,
> +                            to, tlen, &len, padding ? BCRYPT_PAD_PKCS1 :=
 0);
>      if (status !=3D ERROR_SUCCESS)
>      {
>          SetLastError(status);
> @@ -375,7 +377,7 @@ rsa_priv_enc(int flen, const unsigned char *from, uns=
igned char *to, RSA *rsa, i
>   */
>  static int
>  rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
> -              unsigned char *sig, unsigned int *siglen, const RSA *rsa)
> +             unsigned char *sig, unsigned int *siglen, const RSA *rsa)
>  {
>      CAPI_DATA *cd =3D (CAPI_DATA *) RSA_meth_get0_app_data(RSA_get_metho=
d(rsa));
>      const wchar_t *alg =3D NULL;
> @@ -419,6 +421,7 @@ rsa_sign_CNG(int type, const unsigned char *m, unsign=
ed int m_len,
>              /* No DigestInfo header is required -- set alg-name to NULL =
*/
>              alg =3D NULL;
>              break;
> +
>          default:
>              msg(M_WARN, "cryptoapicert: Unknown hash type NID=3D0x%x", t=
ype);
>              RSAerr(RSA_F_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
> @@ -459,7 +462,7 @@ finish(RSA *rsa)
>          return 0;
>      }
>      CAPI_DATA_free(cd);
> -    RSA_meth_free((RSA_METHOD*) rsa_meth);
> +    RSA_meth_free((RSA_METHOD *) rsa_meth);
>      return 1;
>  }
>=20=20
> @@ -586,7 +589,7 @@ ssl_ctx_set_eckey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EV=
P_PKEY *pkey)
>      if (cd->key_spec !=3D CERT_NCRYPT_KEY_SPEC)
>      {
>          msg(M_NONFATAL, "ERROR: cryptoapicert with only legacy private k=
ey handle available."
> -                    " EC certificate not supported.");
> +            " EC certificate not supported.");
>          goto err;
>      }
>      /* create a method struct with default callbacks filled in */
> @@ -686,7 +689,8 @@ find_certificate_in_store(const char *cert_prop, HCER=
TSTORE cert_store)
>=20=20
>          /* skip the tag */
>          cert_prop +=3D 6;
> -        for (p =3D (char *) cert_prop, i =3D 0; *p && i < sizeof(hash); =
i++) {
> +        for (p =3D (char *) cert_prop, i =3D 0; *p && i < sizeof(hash); =
i++)
> +        {
>              if (*p >=3D '0' && *p <=3D '9')
>              {
>                  x =3D (*p - '0') << 4;
> @@ -739,7 +743,7 @@ ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, E=
VP_PKEY *pkey)
>      bool rsa_method_set =3D false;
>=20=20
>      my_rsa_method =3D RSA_meth_new("Microsoft Cryptography API RSA Metho=
d",
> -                                  RSA_METHOD_FLAG_NO_CHECK);
> +                                 RSA_METHOD_FLAG_NO_CHECK);
>      check_malloc_return(my_rsa_method);
>      RSA_meth_set_pub_enc(my_rsa_method, rsa_pub_enc);
>      RSA_meth_set_pub_dec(my_rsa_method, rsa_pub_dec);
> @@ -797,7 +801,7 @@ ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, E=
VP_PKEY *pkey)
>          goto err;
>      }
>      /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa=
', so
> -     * we decrease it here with RSA_free(), or it will never be cleaned =
up. */
> +    * we decrease it here with RSA_free(), or it will never be cleaned u=
p. */

Is the above change right? Maybe it would make more sense to move the */
to the new line too, but regardless, this change is clearly breaking the
alignment of the *s.

>      RSA_free(rsa);
>      return 1;
>=20=20
> @@ -867,7 +871,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, c=
onst char *cert_prop)
>      DWORD flags =3D CRYPT_ACQUIRE_COMPARE_KEY_FLAG
>                    | CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG;
>      if (!CryptAcquireCertificatePrivateKey(cd->cert_context, flags, NULL,
> -                    &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov=
))
> +                                           &cd->crypt_prov, &cd->key_spe=
c, &cd->free_crypt_prov))
>      {
>          /* if we don't have a smart card reader here, and we try to acce=
ss a
>           * smart card certificate, we get:

[cut]


> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -757,7 +757,7 @@ static void
>  process_coarse_timers(struct context *c)
>  {
>      /* flush current packet-id to file once per 60
> -     * seconds if --replay-persist was specified */
> +    * seconds if --replay-persist was specified */

same here

>      check_packet_id_persist_flush(c);
>=20=20
>      /* should we update status file? */
> @@ -836,7 +836,7 @@ check_coarse_timers_dowork(struct context *c)
>      process_coarse_timers(c);
>      c->c2.coarse_timer_wakeup =3D now + c->c2.timeval.tv_sec;
>=20=20
> -    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %"PRIi64" seconds", (in=
t64_t)c->c2.timeval.tv_sec);
> +    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %" PRIi64 " seconds", (=
int64_t)c->c2.timeval.tv_sec);
>=20=20
>      /* Is the coarse timeout NOT the earliest one? */
>      if (c->c2.timeval.tv_sec > save.tv_sec)

[cut]

> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -314,8 +314,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const c=
har *phase_2,
>           * byte order on the wire for the NTLM header is LE.
>           */
>          const size_t hoff =3D 0x14;
> -        unsigned long flags =3D buf2[hoff] | (buf2[hoff + 1] << 8) |
> -                              (buf2[hoff + 2] << 16) | (buf2[hoff + 3] <=
< 24);
> +        unsigned long flags =3D buf2[hoff] | (buf2[hoff + 1] << 8)
> +                              |(buf2[hoff + 2] << 16) | (buf2[hoff + 3] =
<< 24);

shouldn't there be a space between | and the opening ( ?

>          if ((flags & 0x00800000) =3D=3D 0x00800000)
>          {
>              tib_len =3D buf2[0x28];            /* Get Target Information=
 block size */
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index 9560b29f..a4072b9a 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -193,8 +193,8 @@ X509_get0_pubkey(const X509 *x)
>   * @param store              X509 object store
>   * @return                   the X509 object stack
>   */
> -static inline STACK_OF(X509_OBJECT) *
> -X509_STORE_get0_objects(X509_STORE *store)
> +static inline STACK_OF(X509_OBJECT)
> +*X509_STORE_get0_objects(X509_STORE *store)

This is kind of wierd, isn't it? normally the * is kept on the same line
as the type, exactly because it is part of the return type. no?

>  {
>      return store ? store->objs : NULL;
>  }
> @@ -369,7 +369,7 @@ RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *=
d)
>=20=20
>      return 1;
>  }
> -#endif
> +#endif /* if !defined(HAVE_RSA_SET0_KEY) */
>=20=20
>  #if !defined(HAVE_RSA_BITS)
>  /**
> @@ -483,9 +483,9 @@ RSA_meth_free(RSA_METHOD *meth)
>   */
>  static inline int
>  RSA_meth_set_pub_enc(RSA_METHOD *meth,
> -                     int (*pub_enc) (int flen, const unsigned char *from,
> -                                     unsigned char *to, RSA *rsa,
> -                                     int padding))
> +                     int (*pub_enc)(int flen, const unsigned char *from,
> +                                    unsigned char *to, RSA *rsa,
> +                                    int padding))
>  {
>      if (meth)
>      {
> @@ -506,9 +506,9 @@ RSA_meth_set_pub_enc(RSA_METHOD *meth,
>   */
>  static inline int
>  RSA_meth_set_pub_dec(RSA_METHOD *meth,
> -                     int (*pub_dec) (int flen, const unsigned char *from,
> -                                     unsigned char *to, RSA *rsa,
> -                                     int padding))
> +                     int (*pub_dec)(int flen, const unsigned char *from,
> +                                    unsigned char *to, RSA *rsa,
> +                                    int padding))
>  {
>      if (meth)
>      {
> @@ -529,9 +529,9 @@ RSA_meth_set_pub_dec(RSA_METHOD *meth,
>   */
>  static inline int
>  RSA_meth_set_priv_enc(RSA_METHOD *meth,
> -                      int (*priv_enc) (int flen, const unsigned char *fr=
om,
> -                                       unsigned char *to, RSA *rsa,
> -                                       int padding))
> +                      int (*priv_enc)(int flen, const unsigned char *fro=
m,
> +                                      unsigned char *to, RSA *rsa,
> +                                      int padding))
>  {
>      if (meth)
>      {
> @@ -552,9 +552,9 @@ RSA_meth_set_priv_enc(RSA_METHOD *meth,
>   */
>  static inline int
>  RSA_meth_set_priv_dec(RSA_METHOD *meth,
> -                      int (*priv_dec) (int flen, const unsigned char *fr=
om,
> -                                       unsigned char *to, RSA *rsa,
> -                                       int padding))
> +                      int (*priv_dec)(int flen, const unsigned char *fro=
m,
> +                                      unsigned char *to, RSA *rsa,
> +                                      int padding))
>  {
>      if (meth)
>      {
> @@ -574,7 +574,7 @@ RSA_meth_set_priv_dec(RSA_METHOD *meth,
>   * @return                   1 on success, 0 on error
>   */
>  static inline int
> -RSA_meth_set_init(RSA_METHOD *meth, int (*init) (RSA *rsa))
> +RSA_meth_set_init(RSA_METHOD *meth, int (*init)(RSA *rsa))
>  {
>      if (meth)
>      {
> @@ -594,11 +594,12 @@ RSA_meth_set_init(RSA_METHOD *meth, int (*init) (RS=
A *rsa))
>   * @return                   1 on success, 0 on error
>   */
>  static inline
> -int RSA_meth_set_sign(RSA_METHOD *meth,
> -                      int (*sign) (int type, const unsigned char *m,
> -                                   unsigned int m_length,
> -                                   unsigned char *sigret, unsigned int *=
siglen,
> -                                   const RSA *rsa))
> +int

shouldn't int go on the same line as 'static inline' ?

> +RSA_meth_set_sign(RSA_METHOD *meth,
> +                  int (*sign)(int type, const unsigned char *m,
> +                              unsigned int m_length,
> +                              unsigned char *sigret, unsigned int *sigle=
n,
> +                              const RSA *rsa))
>  {
>      meth->rsa_sign =3D sign;
>      return 1;
> @@ -614,7 +615,7 @@ int RSA_meth_set_sign(RSA_METHOD *meth,
>   * @return                   1 on success, 0 on error
>   */
>  static inline int
> -RSA_meth_set_finish(RSA_METHOD *meth, int (*finish) (RSA *rsa))
> +RSA_meth_set_finish(RSA_METHOD *meth, int (*finish)(RSA *rsa))
>  {
>      if (meth)
>      {
> @@ -669,7 +670,7 @@ RSA_meth_get0_app_data(const RSA_METHOD *meth)
>  static inline int
>  EC_GROUP_order_bits(const EC_GROUP *group)
>  {
> -    BIGNUM* order =3D BN_new();
> +    BIGNUM *order =3D BN_new();
>      EC_GROUP_get_order(group, order, NULL);
>      int bits =3D BN_num_bits(order);
>      BN_free(order);
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 9ee1836b..6d53dea5 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2134,7 +2134,7 @@ options_postprocess_verify_ce(const struct options =
*options, const struct connec
>              "passwords is STRONGLY discouraged and considered insecure");
>      }
>=20=20
> -#endif
> +#endif /* ifdef ENABLE_MANAGEMENT */
>=20=20
>      /*
>       * Windows-specific options.
> @@ -2859,8 +2859,10 @@ options_postprocess_mutate_ce(struct options *o, s=
truct connection_entry *ce)
>          {
>              struct buffer in =3D buffer_read_from_file(o->tls_auth_file,=
 &o->gc);
>              if (!buf_valid(&in))
> +            {
>                  msg(M_FATAL, "Cannot pre-load tls-auth keyfile (%s)",
>                      o->tls_auth_file);
> +            }
>=20=20
>              ce->tls_auth_file =3D INLINE_FILE_TAG;
>              ce->tls_auth_file_inline =3D (char *)in.data;
> @@ -2870,8 +2872,10 @@ options_postprocess_mutate_ce(struct options *o, s=
truct connection_entry *ce)
>          {
>              struct buffer in =3D buffer_read_from_file(o->tls_crypt_file=
, &o->gc);
>              if (!buf_valid(&in))
> +            {
>                  msg(M_FATAL, "Cannot pre-load tls-crypt keyfile (%s)",
>                      o->tls_auth_file);
> +            }
>=20=20
>              ce->tls_crypt_file =3D INLINE_FILE_TAG;
>              ce->tls_crypt_inline =3D (char *)in.data;
> @@ -3040,7 +3044,7 @@ options_postprocess_mutate(struct options *o)
>      {
>          /* DH file is only meaningful in a tls-server context. */
>          msg(M_WARN, "WARNING: Ignoring option 'dh' in tls-client mode, p=
lease only "
> -                    "include this in your server configuration");
> +            "include this in your server configuration");
>          o->dh_file =3D NULL;
>      }
>=20=20
> @@ -7146,7 +7150,7 @@ add_option(struct options *options,
>          {
>              if (strstr(p[2], ":"))
>              {
> -                ipv6dns=3Dtrue;
> +                ipv6dns =3D true;
>                  foreign_option(options, p, 3, es);
>                  dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msgl=
evel);
>              }
> diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
> index e0b1b0ee..759a7fb5 100644
> --- a/src/openvpn/otime.c
> +++ b/src/openvpn/otime.c
> @@ -88,7 +88,7 @@ const char *
>  tv_string(const struct timeval *tv, struct gc_arena *gc)
>  {
>      struct buffer out =3D alloc_buf_gc(64, gc);
> -    buf_printf(&out, "[%"PRIi64"/%ld]",
> +    buf_printf(&out, "[%" PRIi64 "/%ld]",
>                 (int64_t)tv->tv_sec,
>                 (long)tv->tv_usec);
>      return BSTR(&out);
> @@ -198,7 +198,7 @@ time_test(void)
>          t =3D time(NULL);
>          gettimeofday(&tv, NULL);
>  #if 1
> -        msg(M_INFO, "t=3D%"PRIi64" s=3D%"PRIi64" us=3D%ld",
> +        msg(M_INFO, "t=3D%" PRIi64 " s=3D%" PRIi64 " us=3D%ld",
>              (int64_t)t,
>              (int64_t)tv.tv_sec,
>              (long)tv.tv_usec);
> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
> index dc44f36b..0c744875 100644
> --- a/src/openvpn/packet_id.c
> +++ b/src/openvpn/packet_id.c
> @@ -347,7 +347,7 @@ packet_id_send_update(struct packet_id_send *p, bool =
long_form)
>=20=20
>  bool
>  packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_=
form,
> -        bool prepend)
> +                bool prepend)
>  {
>      if (!packet_id_send_update(p, long_form))
>      {
> @@ -606,13 +606,13 @@ packet_id_debug_print(int msglevel,
>          }
>          buf_printf(&out, "%c", c);
>      }
> -    buf_printf(&out, "] %"PRIi64":" packet_id_format, (int64_t)p->time, =
(packet_id_print_type)p->id);
> +    buf_printf(&out, "] %" PRIi64 ":" packet_id_format, (int64_t)p->time=
, (packet_id_print_type)p->id);
>      if (pin)
>      {
> -        buf_printf(&out, " %"PRIi64":" packet_id_format, (int64_t)pin->t=
ime, (packet_id_print_type)pin->id);
> +        buf_printf(&out, " %" PRIi64 ":" packet_id_format, (int64_t)pin-=
>time, (packet_id_print_type)pin->id);
>      }
>=20=20
> -    buf_printf(&out, " t=3D%"PRIi64"[%d]",
> +    buf_printf(&out, " t=3D%" PRIi64 "[%d]",
>                 (int64_t)prev_now,
>                 (int)(prev_now - tv.tv_sec));
>=20=20
> @@ -666,7 +666,7 @@ packet_id_interactive_test(void)
>          {
>              packet_id_reap_test(&pid.rec);
>              test =3D packet_id_test(&pid.rec, &pin);
> -            printf("packet_id_test (%"PRIi64", " packet_id_format ") ret=
urned %d\n",
> +            printf("packet_id_test (%" PRIi64 ", " packet_id_format ") r=
eturned %d\n",
>                     (int64_t)pin.time,
>                     (packet_id_print_type)pin.id,
>                     test);
> @@ -679,7 +679,7 @@ packet_id_interactive_test(void)
>          {
>              long_form =3D (count < 20);
>              packet_id_alloc_outgoing(&pid.send, &pin, long_form);
> -            printf("(%"PRIi64"(" packet_id_format "), %d)\n",
> +            printf("(%" PRIi64 "(" packet_id_format "), %d)\n",
>                     (int64_t)pin.time,
>                     (packet_id_print_type)pin.id,
>                     long_form);
> diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
> index ec03e348..26b07975 100644
> --- a/src/openvpn/packet_id.h
> +++ b/src/openvpn/packet_id.h
> @@ -263,7 +263,7 @@ bool packet_id_read(struct packet_id_net *pin, struct=
 buffer *buf, bool long_for
>   * @return true if successful, false otherwise.
>   */
>  bool packet_id_write(struct packet_id_send *p, struct buffer *buf,
> -        bool long_form, bool prepend);
> +                     bool long_form, bool prepend);
>=20=20
>  /*
>   * Inline functions.
> diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
> index a196b32b..b51f082a 100644
> --- a/src/openvpn/ping.h
> +++ b/src/openvpn/ping.h
> @@ -84,4 +84,4 @@ check_ping_send(struct context *c)
>      }
>  }
>=20=20
> -#endif
> +#endif /* ifndef PING_H */
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 4d17c821..33687d44 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -552,8 +552,7 @@ plugin_call_item(const struct plugin *p,
>                                                          p->plugin_handle,
>                                                          per_client_conte=
xt,
>                                                          (current_cert ? =
certdepth : -1),
> -                                                        current_cert
> -            };
> +                                                        current_cert};

why does the closing bracket go on the same line of the last field ? I
think in general we wanted to keep it aligned to where the opening line
starts, no?

>=20=20
>              struct openvpn_plugin_args_func_return retargs;
>=20=20
> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index fdad3ed5..c8bd86dd 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -884,10 +884,10 @@ establish_http_proxy_passthru(struct http_proxy_inf=
o *p,
>                  const char *algor =3D get_pa_var("algorithm", pa, &gc);
>                  const char *opaque =3D get_pa_var("opaque", pa, &gc);
>=20=20
> -                if ( !realm || !nonce )
> +                if (!realm || !nonce)
>                  {
>                      msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, =
malformed response "
> -                            "from server: realm=3D or nonce=3D missing" =
);
> +                        "from server: realm=3D or nonce=3D missing" );
>                      goto error;
>                  }
>=20=20
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index a7f4ed96..eae1e0cb 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -762,14 +762,14 @@ reliable_debug_print(const struct reliable *rel, ch=
ar *desc)
>      printf("********* struct reliable %s\n", desc);
>      printf("  initial_timeout=3D%d\n", (int)rel->initial_timeout);
>      printf("  packet_id=3D" packet_id_format "\n", rel->packet_id);
> -    printf("  now=3D%"PRIi64"\n", (int64_t)now);
> +    printf("  now=3D%" PRIi64 "\n", (int64_t)now);
>      for (i =3D 0; i < rel->size; ++i)
>      {
>          const struct reliable_entry *e =3D &rel->array[i];
>          if (e->active)
>          {
>              printf("  %d: packet_id=3D" packet_id_format " len=3D%d", i,=
 e->packet_id, e->buf.len);
> -            printf(" next_try=3D%"PRIi64, (int64_t)e->next_try);
> +            printf(" next_try=3D%" PRIi64, (int64_t)e->next_try);
>              printf("\n");
>          }
>      }
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index d97e8dba..346f08e2 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -3074,7 +3074,7 @@ do_route_ipv6_service(const bool add, const struct =
route_ipv6 *r, const struct t
>       * (only do this for routes actually using the tun/tap device)
>       */
>      if (tt->type =3D=3D DEV_TYPE_TUN
> -	 && msg.iface.index =3D=3D tt->adapter_index )
> +        && msg.iface.index =3D=3D tt->adapter_index)
>      {
>          inet_pton(AF_INET6, "fe80::8", &msg.gateway.ipv6);
>      }
> @@ -3298,7 +3298,7 @@ get_default_gateway(struct route_gateway_info *rgi)
>                  if (rgi->flags & RGI_ON_LINK)
>                  {
>                      /* check that interface name of current interface
> -                     * matches interface name of best default route */
> +                    * matches interface name of best default route */

same in previous patterns.

>                      if (strcmp(ifreq.ifr_name, best_name))
>                      {
>                          continue;
> diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
> index 4e198676..04ad2312 100644
> --- a/src/openvpn/run_command.c
> +++ b/src/openvpn/run_command.c
> @@ -41,12 +41,14 @@
>  /* contains an SSEC_x value defined in platform.h */
>  static int script_security_level =3D SSEC_BUILT_IN; /* GLOBAL */
>=20=20
> -int script_security(void)
> +int
> +script_security(void)
>  {
>      return script_security_level;
>  }
>=20=20
> -void script_security_set(int level)
> +void
> +script_security_set(int level)
>  {
>      script_security_level =3D level;
>  }
> diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
> index 92364f29..62579840 100644
> --- a/src/openvpn/shaper.c
> +++ b/src/openvpn/shaper.c
> @@ -76,7 +76,7 @@ shaper_soonest_event(struct timeval *tv, int delay)
>          }
>      }
>  #ifdef SHAPER_DEBUG
> -    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=3D%"PRIi64" us=
ec=3D%ld ret=3D%d",
> +    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=3D%" PRIi64 " =
usec=3D%ld ret=3D%d",
>           (int64_t)tv->tv_sec, (long)tv->tv_usec, (int)ret);
>  #endif
>      return ret;
> diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
> index 4efe398a..bcdb5e36 100644
> --- a/src/openvpn/shaper.h
> +++ b/src/openvpn/shaper.h
> @@ -147,7 +147,7 @@ shaper_wrote_bytes(struct shaper *s, int nbytes)
>          tv_add(&s->wakeup, &tv);
>=20=20
>  #ifdef SHAPER_DEBUG
> -        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=3D%d delay=
=3D%ld sec=3D%"PRIi64" usec=3D%ld",
> +        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=3D%d delay=
=3D%ld sec=3D%" PRIi64 " usec=3D%ld",
>               nbytes,
>               (long)tv.tv_usec,
>               (int64_t)s->wakeup.tv_sec,
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 3f2b97e4..db944245 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -100,10 +100,12 @@ get_addr_generic(sa_family_t af, unsigned int flags=
, const char *hostname,
>              bits =3D 0;
>              max_bits =3D sizeof(in_addr_t) * 8;
>              break;
> +
>          case AF_INET6:
>              bits =3D 64;
>              max_bits =3D sizeof(struct in6_addr) * 8;
>              break;
> +
>          default:
>              msg(M_WARN,
>                  "Unsupported AF family passed to getaddrinfo for %s (%d)=
",
> @@ -125,7 +127,7 @@ get_addr_generic(sa_family_t af, unsigned int flags, =
const char *hostname,
>      }
>=20=20
>      /* check if this hostname has a /bits suffix */
> -    sep =3D strchr(var_host , '/');
> +    sep =3D strchr(var_host, '/');
>      if (sep)
>      {
>          bits =3D strtoul(sep + 1, &endp, 10);
> @@ -156,10 +158,12 @@ get_addr_generic(sa_family_t af, unsigned int flags=
, const char *hostname,
>                      *ip4 =3D ntohl(*ip4);
>                  }
>                  break;
> +
>              case AF_INET6:
>                  ip6 =3D network;
>                  *ip6 =3D ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
>                  break;
> +
>              default:
>                  /* can't get here because 'af' was previously checked */
>                  msg(M_WARN,
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index 0f22d479..17801418 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -138,7 +138,7 @@ struct stream_buf
>      int len;   /* -1 if not yet known */
>=20=20
>      bool error; /* if true, fatal TCP error has occurred,
> -                *  requiring that connection be restarted */
> +                 *  requiring that connection be restarted */
>  #if PORT_SHARE
>  #define PS_DISABLED 0
>  #define PS_ENABLED  1
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 74b88ce6..d783c598 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -680,7 +680,7 @@ init_ssl(const struct options *options, struct tls_ro=
ot_ctx *new_ctx)
>      {
>          if (tls_ctx_use_management_external_key(new_ctx))
>          {
> -            msg (M_WARN, "Cannot initialize mamagement-external-key");
> +            msg(M_WARN, "Cannot initialize mamagement-external-key");
>              goto err;
>          }
>      }
> @@ -1099,7 +1099,7 @@ tls_session_init(struct tls_multi *multi, struct tl=
s_session *session)
>          else
>          {
>              session->initial_opcode =3D session->opt->tls_crypt_v2 ?
> -                    P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESE=
T_CLIENT_V2;
> +                                      P_CONTROL_HARD_RESET_CLIENT_V3 : P=
_CONTROL_HARD_RESET_CLIENT_V2;
>          }
>      }
>=20=20
> @@ -1527,9 +1527,9 @@ read_control_auth(struct buffer *buf,
>      if (opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
>          && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
>      {
> -        msg (D_TLS_ERRORS,
> -             "TLS Error: can not extract tls-crypt-v2 client key from %s=
",
> -             print_link_socket_actual(from, &gc));
> +        msg(D_TLS_ERRORS,
> +            "TLS Error: can not extract tls-crypt-v2 client key from %s",
> +            print_link_socket_actual(from, &gc));
>          goto cleanup;
>      }
>=20=20
> @@ -3781,7 +3781,7 @@ tls_pre_decrypt(struct tls_multi *multi,
>                                  /* Save incoming ciphertext packet to re=
liable buffer */
>                                  struct buffer *in =3D reliable_get_buf(k=
s->rec_reliable);
>                                  ASSERT(in);
> -                                if(!buf_copy(in, buf))
> +                                if (!buf_copy(in, buf))
>                                  {
>                                      msg(D_MULTI_DROPPED,
>                                          "Incoming control channel packet=
 too big, dropping.");
> @@ -4182,10 +4182,10 @@ show_available_tls_ciphers(const char *cipher_lis=
t,
>      show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false=
);
>=20=20
>      printf("\n"
> -    "Be aware that that whether a cipher suite in this list can actually=
 work\n"
> -    "depends on the specific setup of both peers. See the man page entri=
es of\n"
> -    "--tls-cipher and --show-tls for more details.\n\n"
> -    );
> +           "Be aware that that whether a cipher suite in this list can a=
ctually work\n"
> +           "depends on the specific setup of both peers. See the man pag=
e entries of\n"
> +           "--tls-cipher and --show-tls for more details.\n\n"
> +           );

since you are there you could move the closing parenthesis to the line
before :)

>  }
>=20=20
>  /*
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 7bf82b3a..410b2163 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -215,10 +215,10 @@ struct tls_wrap_ctx
>      struct buffer work;         /**< Work buffer (only for --tls-crypt) =
*/
>      struct key_ctx tls_crypt_v2_server_key;  /**< Decrypts client keys */
>      const struct buffer *tls_crypt_v2_wkc;   /**< Wrapped client key,
> -                                                  sent to server */
> +                                              *   sent to server */
>      struct buffer tls_crypt_v2_metadata;     /**< Received from client */
>      bool cleanup_key_ctx;                    /**< opt.key_ctx_bi is owne=
d by
> -                                                  this context */
> +                                              *   this context */
>  };
>=20=20
>  /*
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index f7e8c2d0..a4197cba 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -65,12 +65,12 @@
>  static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =3D
>  {
>      /* Hashes from SHA-1 and above */
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),

space missing?

>      0xFFFFFFF, /* Any PK alg    */
>      0xFFFFFFF, /* Any curve     */
>      1024,      /* RSA-1024 and larger */
> @@ -79,10 +79,10 @@ static const mbedtls_x509_crt_profile openvpn_x509_cr=
t_profile_legacy =3D
>  static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_preferred=
 =3D
>  {
>      /* SHA-2 and above */
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
> -    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
> +    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
> +    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),

space missing?

>      0xFFFFFFF, /* Any PK alg    */
>      0xFFFFFFF, /* Any curve     */
>      2048,      /* RSA-2048 and larger */
> @@ -232,7 +232,7 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *c=
tx, const char *ciphers)
>      }
>=20=20
>      msg(M_WARN, "mbed TLS does not support setting tls-ciphersuites. "
> -                "Ignoring TLS 1.3 cipher list: %s", ciphers);
> +        "Ignoring TLS 1.3 cipher list: %s", ciphers);
>  }
>=20=20
>  void
> @@ -299,7 +299,7 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, co=
nst char *profile)
>      }
>      else
>      {
> -        msg (M_FATAL, "ERROR: Invalid cert profile: %s", profile);
> +        msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
>      }
>  }
>=20=20
> @@ -600,14 +600,14 @@ tls_ctx_use_external_signing_func(struct tls_root_c=
tx *ctx,
>=20=20
>      if (ctx->crt_chain =3D=3D NULL)
>      {
> -        msg (M_WARN, "ERROR: external key requires a certificate.");
> +        msg(M_WARN, "ERROR: external key requires a certificate.");
>          return 1;
>      }
>=20=20
>      if (mbedtls_pk_get_type(&ctx->crt_chain->pk) !=3D MBEDTLS_PK_RSA)
>      {
>          msg(M_WARN, "ERROR: external key with mbed TLS requires a "
> -                     "certificate with an RSA key.");
> +            "certificate with an RSA key.");
>          return 1;
>      }
>=20=20
> @@ -653,8 +653,8 @@ management_sign_func(void *sign_ctx, const void *src,=
 size_t src_len,
>=20=20
>      ret =3D true;
>  cleanup:
> -    free (src_b64);
> -    free (dst_b64);
> +    free(src_b64);
> +    free(dst_b64);
>=20=20
>      return ret;
>  }
> diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
> index 998d6f2f..1328ceb7 100644
> --- a/src/openvpn/ssl_mbedtls.h
> +++ b/src/openvpn/ssl_mbedtls.h
> @@ -71,8 +71,8 @@ typedef struct {
>   * @return true if signing succeeded, false otherwise.
>   */
>  typedef bool (*external_sign_func)(
> -        void *sign_ctx, const void *src, size_t src_size,
> -        void *dst, size_t dst_size);
> +    void *sign_ctx, const void *src, size_t src_size,
> +    void *dst, size_t dst_size);
>=20=20
>  /** Context used by external_pkcs1_sign() */
>  struct external_context {
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index da573cfa..ddb78da7 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -217,7 +217,7 @@ tls_version_max(void)
>      return TLS_VER_1_2;
>  #elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
>      return TLS_VER_1_1;
> -#else
> +#else  /* if defined(TLS1_3_VERSION) */
>      return TLS_VER_1_0;
>  #endif
>  }
> @@ -322,7 +322,7 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigne=
d int ssl_flags)
>  }
>=20=20
>  void
> -convert_tls_list_to_openssl(char* openssl_ciphers, size_t len,const char=
 *ciphers)
> +convert_tls_list_to_openssl(char *openssl_ciphers, size_t len,const char=
 *ciphers)
>  {
>      /* Parse supplied cipher list and pass on to OpenSSL */
>      size_t begin_of_cipher, end_of_cipher;
> @@ -466,9 +466,9 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *c=
tx, const char *ciphers)
>      }
>=20=20
>  #if (OPENSSL_VERSION_NUMBER < 0x1010100fL)
> -        crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
> -                       "Ignoring TLS 1.3 only tls-ciphersuites '%s' sett=
ing.",
> -                        ciphers);
> +    crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
> +               "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
> +               ciphers);
>  #else
>      ASSERT(NULL !=3D ctx);
>=20=20
> @@ -509,13 +509,13 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, =
const char *profile)
>      {
>          msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
>      }
> -#else
> +#else  /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
>      if (profile)
>      {
>          msg(M_WARN, "WARNING: OpenSSL 1.0.1 does not support --tls-cert-=
profile"
>              ", ignoring user-set profile: '%s'", profile);
>      }
> -#endif
> +#endif /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
>  }
>=20=20
>  void
> @@ -658,7 +658,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, co=
nst char *curve_name
>          {
>              nid =3D EC_GROUP_get_curve_name(ecgrp);
>          }
> -#endif
> +#endif /* if OPENSSL_VERSION_NUMBER >=3D 0x10002000L */
>      }
>=20=20
>      /* Translate NID back to name , just for kicks */
> @@ -1137,7 +1137,7 @@ rsa_priv_enc(int flen, const unsigned char *from, u=
nsigned char *to, RSA *rsa, i
>=20=20
>      ret =3D get_sig_from_man(from, flen, to, len);
>=20=20
> -    return (ret =3D=3D len)? ret : -1;
> +    return (ret =3D=3D len) ? ret : -1;
>  }
>=20=20
>  static int
> @@ -1325,7 +1325,7 @@ err:
>      {
>          EVP_PKEY_free(privkey);
>      }
> -    if(ec)
> +    if (ec)
>      {
>          EC_KEY_free(ec);
>      }
> @@ -1375,7 +1375,7 @@ tls_ctx_use_management_external_key(struct tls_root=
_ctx *ctx)
>          crypto_msg(M_WARN, "management-external-key requires an RSA or E=
C certificate");
>          goto cleanup;
>      }
> -#else
> +#else  /* if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO=
_EC) && !defined(LIBRESSL_VERSION_NUMBER) */
>      else
>      {
>          crypto_msg(M_WARN, "management-external-key requires an RSA cert=
ificate");
> @@ -1644,7 +1644,7 @@ bio_debug_data(const char *mode, BIO *bio, const ui=
nt8_t *buf, int len, const ch
>      if (len > 0)
>      {
>          open_biofp();
> -        fprintf(biofp, "BIO_%s %s time=3D%"PRIi64" bio=3D" ptr_format " =
len=3D%d data=3D%s\n",
> +        fprintf(biofp, "BIO_%s %s time=3D%" PRIi64 " bio=3D" ptr_format =
" len=3D%d data=3D%s\n",
>                  mode, desc, (int64_t)time(NULL), (ptr_type)bio, len, for=
mat_hex(buf, len, 0, &gc));
>          fflush(biofp);
>      }
> @@ -1655,7 +1655,7 @@ static void
>  bio_debug_oc(const char *mode, BIO *bio)
>  {
>      open_biofp();
> -    fprintf(biofp, "BIO %s time=3D%"PRIi64" bio=3D" ptr_format "\n",
> +    fprintf(biofp, "BIO %s time=3D%" PRIi64 " bio=3D" ptr_format "\n",
>              mode, (int64_t)time(NULL), (ptr_type)bio);
>      fflush(biofp);
>  }
> @@ -1963,7 +1963,7 @@ print_details(struct key_state_ssl *ks_ssl, const c=
har *prefix)
>              {
>                  EC_KEY *ec =3D EVP_PKEY_get0_EC_KEY(pkey);
>                  const EC_GROUP *group =3D EC_KEY_get0_group(ec);
> -                const char* curve;
> +                const char *curve;
>=20=20
>                  int nid =3D EC_GROUP_get_curve_name(group);
>                  if (nid =3D=3D 0 || (curve =3D OBJ_nid2sn(nid)) =3D=3D N=
ULL)
> @@ -2024,7 +2024,7 @@ show_available_tls_ciphers_list(const char *cipher_=
list,
>  #else
>      STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);
>  #endif
> -    for (int i=3D0;i < sk_SSL_CIPHER_num(sk);i++)
> +    for (int i =3D 0; i < sk_SSL_CIPHER_num(sk); i++)
>      {
>          const SSL_CIPHER *c =3D sk_SSL_CIPHER_value(sk, i);
>=20=20
> @@ -2035,7 +2035,7 @@ show_available_tls_ciphers_list(const char *cipher_=
list,
>=20=20
>          if (tls13)
>          {
> -              printf("%s\n", cipher_name);
> +            printf("%s\n", cipher_name);
>          }
>          else if (NULL =3D=3D pair)
>          {
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 03c0b661..a7f51751 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -72,7 +72,7 @@ setenv_untrusted(struct tls_session *session)
>  static void
>  wipe_auth_token(struct tls_multi *multi)
>  {
> -    if(multi)
> +    if (multi)
>      {
>          if (multi->auth_token)
>          {
> @@ -712,24 +712,24 @@ verify_cert(struct tls_session *session, openvpn_x5=
09_cert_t *cert, int cert_dep
>=20=20
>          switch (opt->verify_hash_algo)
>          {
> -        case MD_SHA1:
> -            ca_hash =3D x509_get_sha1_fingerprint(cert, &gc);
> -            break;
> -
> -        case MD_SHA256:
> -            ca_hash =3D x509_get_sha256_fingerprint(cert, &gc);
> -            break;
> -
> -        default:
> -            /* This should normally not happen at all; the algorithm used
> -             * is parsed by add_option() [options.c] and set to a predef=
ined
> -             * value in an enumerated type.  So if this unlikely scenario
> -             * happens, consider this a failure
> -             */
> -            msg(M_WARN, "Unexpected invalid algorithm used with "
> -                "--verify-hash (%i)", opt->verify_hash_algo);
> -            ret =3D FAILURE;
> -            goto cleanup;
> +            case MD_SHA1:
> +                ca_hash =3D x509_get_sha1_fingerprint(cert, &gc);
> +                break;
> +
> +            case MD_SHA256:
> +                ca_hash =3D x509_get_sha256_fingerprint(cert, &gc);
> +                break;
> +
> +            default:
> +                /* This should normally not happen at all; the algorithm=
 used
> +                 * is parsed by add_option() [options.c] and set to a pr=
edefined
> +                 * value in an enumerated type.  So if this unlikely sce=
nario
> +                 * happens, consider this a failure
> +                 */
> +                msg(M_WARN, "Unexpected invalid algorithm used with "
> +                    "--verify-hash (%i)", opt->verify_hash_algo);
> +                ret =3D FAILURE;
> +                goto cleanup;
>          }
>=20=20
>          if (memcmp(BPTR(&ca_hash), opt->verify_hash, BLEN(&ca_hash)))
> @@ -1178,8 +1178,8 @@ verify_user_pass_plugin(struct tls_session *session=
, const struct user_pass *up)
>          /* generate filename for deferred auth control file */
>          if (!key_state_gen_auth_control_file(ks, session->opt))
>          {
> -            msg (D_TLS_ERRORS, "TLS Auth Error (%s): "
> -                 "could not create deferred auth control file", __func__=
);
> +            msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
> +                "could not create deferred auth control file", __func__);
>              goto cleanup;
>          }
>  #endif
> diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_ba=
ckend.h
> index 2a9e8bb7..f4cc2c54 100644
> --- a/src/openvpn/ssl_verify_backend.h
> +++ b/src/openvpn/ssl_verify_backend.h
> @@ -130,6 +130,7 @@ result_t backend_x509_get_username(char *common_name,=
 int cn_len,
>   * --x509-username-field option.
>   */
>  bool x509_username_field_ext_supported(const char *extname);
> +
>  #endif
>=20=20
>  /*
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_op=
enssl.c
> index 10085b29..ff14db23 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -114,7 +114,8 @@ cleanup:
>  }
>=20=20
>  #ifdef ENABLE_X509ALTUSERNAME
> -bool x509_username_field_ext_supported(const char *fieldname)
> +bool
> +x509_username_field_ext_supported(const char *fieldname)
>  {
>      int nid =3D OBJ_txt2nid(fieldname);
>      return nid =3D=3D NID_subject_alt_name || nid =3D=3D NID_issuer_alt_=
name;
> @@ -587,7 +588,7 @@ x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_ce=
rt, const int usage)
>           * prevent it to take a const argument
>           */
>          result_t result =3D X509_check_purpose(peer_cert, X509_PURPOSE_S=
SL_CLIENT, 0) ?
> -	       SUCCESS : FAILURE;
> +                          SUCCESS : FAILURE;
>=20=20
>          /*
>           * old versions of OpenSSL allow us to make the less strict chec=
k we used to
> @@ -615,7 +616,7 @@ x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_ce=
rt, const int usage)
>           * prevent it to take a const argument
>           */
>          result_t result =3D X509_check_purpose(peer_cert, X509_PURPOSE_S=
SL_SERVER, 0) ?
> -	       SUCCESS : FAILURE;
> +                          SUCCESS : FAILURE;
>=20=20
>          /*
>           * old versions of OpenSSL allow us to make the less strict chec=
k we used to
> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
> index c3ed2b93..85495d7f 100644
> --- a/src/openvpn/tls_crypt.c
> +++ b/src/openvpn/tls_crypt.c
> @@ -86,7 +86,7 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char *=
key_file,
>      struct key_type kt =3D tls_crypt_kt();
>      if (!kt.cipher || !kt.digest)
>      {
> -        msg (M_FATAL, "ERROR: --tls-crypt not supported");
> +        msg(M_FATAL, "ERROR: --tls-crypt not supported");
>      }
>      crypto_read_openvpn_key(&kt, key, key_file, key_inline, key_directio=
n,
>                              "Control Channel Encryption", "tls-crypt");
> @@ -530,7 +530,7 @@ tls_crypt_v2_unwrap_client_key(struct key2 *client_ke=
y, struct buffer *metadata,
>      memcpy(&client_key->keys, BPTR(&plaintext), sizeof(client_key->keys)=
);
>      ASSERT(buf_advance(&plaintext, sizeof(client_key->keys)));
>=20=20
> -    if(!buf_copy(metadata, &plaintext))
> +    if (!buf_copy(metadata, &plaintext))
>      {
>          CRYPT_ERROR("metadata too large for supplied buffer");
>      }
> @@ -613,7 +613,7 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
>      if (!ctx->tls_crypt_v2_server_key.cipher)
>      {
>          msg(D_TLS_ERRORS,
> -             "Client wants tls-crypt-v2, but no server key present.");
> +            "Client wants tls-crypt-v2, but no server key present.");
>          return false;
>      }
>=20=20
> diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
> index 9b5ea971..43bf8122 100644
> --- a/src/openvpn/tls_crypt.h
> +++ b/src/openvpn/tls_crypt.h
> @@ -99,10 +99,10 @@
>  #define TLS_CRYPT_V2_SERVER_KEY_LEN (sizeof(struct key))
>  #define TLS_CRYPT_V2_TAG_SIZE (TLS_CRYPT_TAG_SIZE)
>  #define TLS_CRYPT_V2_MAX_METADATA_LEN (unsigned)(TLS_CRYPT_V2_MAX_WKC_LE=
N \
> -         - (TLS_CRYPT_V2_CLIENT_KEY_LEN + TLS_CRYPT_V2_TAG_SIZE \
> -            + sizeof(uint16_t)))
> +                                                 - (TLS_CRYPT_V2_CLIENT_=
KEY_LEN + TLS_CRYPT_V2_TAG_SIZE \
> +                                                    + sizeof(uint16_t)))
>  #define TLS_CRYPT_V2_MAX_B64_METADATA_LEN \
> -        OPENVPN_BASE64_LENGTH(TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
> +    OPENVPN_BASE64_LENGTH(TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
>=20=20
>  /**
>   * Initialize a key_ctx_bi structure for use with --tls-crypt.
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index c091401f..12e6eb00 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -553,8 +553,8 @@ is_tun_p2p(const struct tuntap *tt)
>      bool tun =3D false;
>=20=20
>      if (tt->type =3D=3D DEV_TYPE_TAP
> -          || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
> -          || tt->type =3D=3D DEV_TYPE_NULL )
> +        || (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBN=
ET)
> +        || tt->type =3D=3D DEV_TYPE_NULL)
>      {
>          tun =3D false;
>      }
> @@ -893,7 +893,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifnam=
e, int tun_mtu,
>                  ifconfig_ipv6_local, tt->netbits_ipv6, ifname);
>      argv_msg(M_INFO, &argv);
>      openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add faile=
d");
> -#else
> +#else  /* ifdef ENABLE_IPROUTE */
>      argv_printf(&argv, "%s %s add %s/%d mtu %d up", IFCONFIG_PATH, ifnam=
e,
>                  ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
>      argv_msg(M_INFO, &argv);
> @@ -1387,6 +1387,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifn=
ame, int tun_mtu,
>                      ifname, ifconfig_local,
>                      print_in_addr_t(tt->adapter_netmask, 0, &gc));
>                  break;
> +
>              case IPW32_SET_NETSH:
>                  netsh_ifconfig(&tt->options, ifname, tt->local,
>                                 tt->adapter_netmask, NI_IP_NETMASK|NI_OPT=
IONS);
> @@ -2442,7 +2443,7 @@ close_tun(struct tuntap *tt)
>      struct argv argv =3D argv_new();
>=20=20
>      /* setup command, close tun dev (clears tt->actual_name!), run comma=
nd
> -    */
> +     */
>=20=20
>      argv_printf(&argv, "%s %s destroy",
>                  IFCONFIG_PATH, tt->actual_name);
> @@ -2528,7 +2529,7 @@ close_tun(struct tuntap *tt)
>      struct argv argv =3D argv_new();
>=20=20
>      /* setup command, close tun dev (clears tt->actual_name!), run comma=
nd
> -    */
> +     */
>=20=20
>      argv_printf(&argv, "%s %s destroy",
>                  IFCONFIG_PATH, tt->actual_name);
> @@ -2668,7 +2669,7 @@ close_tun(struct tuntap *tt)
>      struct argv argv =3D argv_new();
>=20=20
>      /* setup command, close tun dev (clears tt->actual_name!), run comma=
nd
> -    */
> +     */
>=20=20
>      argv_printf(&argv, "%s %s destroy",
>                  IFCONFIG_PATH, tt->actual_name);
> @@ -5923,7 +5924,7 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun
>                  };
>=20=20
>                  if (send_msg_iservice(tt->options.msg_channel, &msg, siz=
eof(msg),
> -                    &ack, "TUN"))
> +                                      &ack, "TUN"))
>                  {
>                      status =3D ack.error_number;
>                  }
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index e43296eb..be526945 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -1481,7 +1481,7 @@ send_msg_iservice(HANDLE pipe, const void *data, si=
ze_t size,
>          || !ReadFile(pipe, ack, sizeof(*ack), &len, NULL))
>      {
>          msg(M_WARN, "%s: could not talk to service: %s [%lu]",
> -            context? context : "Unknown",
> +            context ? context : "Unknown",
>              strerror_win32(GetLastError(), &gc), GetLastError());
>          ret =3D false;
>      }
>=20

I know we want to get "uncrustity-clean", but maybe we can tweak some
options to comply with my remarks above? if not...well...uncrustify will
decide for our codestyle ;P


Cheers,


--=20
Antonio Quartulli


--ACZ5IyHetSwEcSix3y5FCC5S3ipSWNuPm--

--9SxTQtNyzX7SyOw0s2Vyvet4Tds6msnOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlwQ8hMACgkQ9FVsWUWD
Dm3rkhAAkbIFyUfRI2fkFHGDRBC/F91K7ukSl4sFMeIy6XyPB7I/SQqLqn/wor3z
1Zk3CRu3UxUShAHXMmDfmpcBlzUvq3dYphkqvHE67E2bP0PZAdp6vlZ9msrKDxA6
y0Wk9xnocKywNAhIf38c5LUWNnEiYwosvPBd46kB44lYFcb1V0F3eCvAjsG6UPwJ
gqi1eaPwTzRVWLvWIp0ITcoazd52PJNKPE7jgMe6U/dUWzuSp2y6jiETT27ypunN
FyBczgTcHScYhDFFSz5wzBvr5bJ0Z+1xHeBIGKgNjK8BjfSmm0YFwQgXCzLoUAHW
WaC2cIz10VyLTyRhnALD6HwSYpz0ZAn+zdhRpuBcg9/7v6sJJek2D64Lpev/QiuC
6kApzJHt0lqK9qroFBBKePoNThM+omqXLB+n3p1uguiv2Q859M3nvj9mhybO9VUk
5uNU9G1HW3E2hzm9nSY+OecA0lx4sM7vlI777pVt4NRDnuoKFQd0DCe/kpBHdsTe
Hw0U/nw5gZ+xzMuHme4pqpiDiCx1G93KXbDYGKHef7sxjjLhDFJh4FUirxYfy0bm
qk1VLlnRbQCpgyExknJJxe2lXPvd1J/cZXGZQXz8sLaDhvET34yrJLcn1tzJoT3i
UP7mAeYtttEvFhWVpC29JzeSjWnLjp0xZ/QmwbP+ciTsvW5L+mw=
=VNbH
-----END PGP SIGNATURE-----

--9SxTQtNyzX7SyOw0s2Vyvet4Tds6msnOU--

