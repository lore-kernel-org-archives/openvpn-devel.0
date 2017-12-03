References: <20171202134541.7688-1-a@...2181...>
 <20171203124922.14220-1-a@...2181...>
 <07b23d8b-6421-c271-74b3-a00a0eeb4039@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b83db814-0eb1-c784-4264-ac6f704359e0@...2181...>
Date: Mon, 4 Dec 2017 00:15:18 +0800
MIME-Version: 1.0
In-Reply-To: <07b23d8b-6421-c271-74b3-a00a0eeb4039@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DTQA6W1BoLGp1apgXdD1SHEJpg2aGwoNw"
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] Remove ENABLE_CRYPTO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DTQA6W1BoLGp1apgXdD1SHEJpg2aGwoNw
Content-Type: multipart/mixed; boundary="jwXsHj215gOvaJ9Sh13fWwCdarJU30TqO";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b83db814-0eb1-c784-4264-ac6f704359e0@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] Remove ENABLE_CRYPTO
References: <20171202134541.7688-1-a@...2181...>
 <20171203124922.14220-1-a@...2181...>
 <07b23d8b-6421-c271-74b3-a00a0eeb4039@...1856...>
In-Reply-To: <07b23d8b-6421-c271-74b3-a00a0eeb4039@...1856...>

--jwXsHj215gOvaJ9Sh13fWwCdarJU30TqO
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/12/17 22:12, Steffan Karger wrote:
> Hi,
>=20
> Thanks for v2.  Some things went wrong with the s/CRYPTO_/ENABLE_CRYPTO/
> though:
>=20
> On 03-12-17 13:49, Antonio Quartulli wrote:
>> The crypto engine cannot be disabled anymore, therefore get
>> rid of all the related ifdefs in the code.
>>
>> This change makes the code simpler and reduces our the
>> number of config combinations we have to test after a new
>> change is applied.
>>
>> [re-enable unit-tests that were previously disabled]
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>
>> v2:
>> - rename CRYPTO_MBEDTLS/OPENSSL back to ENABLE_CRYPTO_MBEDTLS/OPENSSL
>> - move to first patch in the set to avoid having a point in the tree whe=
re
>>   encryption is disabled
>>
>>  doc/doxygen/doc_data_crypto.h             | 12 +++---
>>  include/openvpn-plugin.h.in               | 11 +-----
>>  src/openvpn/crypto.c                      |  4 --
>>  src/openvpn/crypto.h                      |  4 --
>>  src/openvpn/crypto_mbedtls.c              |  4 +-
>>  src/openvpn/crypto_mbedtls.h              |  6 +--
>>  src/openvpn/crypto_openssl.c              |  4 +-
>>  src/openvpn/crypto_openssl.h              |  6 +--
>>  src/openvpn/forward-inline.h              |  6 ---
>>  src/openvpn/forward.c                     | 15 --------
>>  src/openvpn/init.c                        | 64 ++----------------------=
-------
>>  src/openvpn/manage.c                      |  5 +--
>>  src/openvpn/misc.c                        | 13 -------
>>  src/openvpn/misc.h                        |  7 +---
>>  src/openvpn/openvpn.h                     | 24 ------------
>>  src/openvpn/options.c                     | 55 +++---------------------=
--
>>  src/openvpn/options.h                     |  9 +----
>>  src/openvpn/packet_id.c                   |  4 --
>>  src/openvpn/packet_id.h                   |  3 --
>>  src/openvpn/plugin.c                      | 23 +++--------
>>  src/openvpn/plugin.h                      | 18 +++------
>>  src/openvpn/reliable.c                    |  9 -----
>>  src/openvpn/reliable.h                    |  3 --
>>  src/openvpn/session_id.c                  |  9 -----
>>  src/openvpn/session_id.h                  |  3 --
>>  src/openvpn/ssl.c                         |  9 -----
>>  src/openvpn/ssl.h                         |  4 --
>>  src/openvpn/ssl_backend.h                 |  3 --
>>  src/openvpn/ssl_mbedtls.c                 |  4 +-
>>  src/openvpn/ssl_openssl.c                 |  4 +-
>>  src/openvpn/ssl_verify.c                  |  4 --
>>  src/openvpn/ssl_verify.h                  |  4 --
>>  src/openvpn/ssl_verify_mbedtls.c          |  4 +-
>>  src/openvpn/ssl_verify_openssl.c          |  4 +-
>>  src/openvpn/syshead.h                     | 16 ++------
>>  src/openvpn/tls_crypt.c                   |  3 --
>>  src/openvpn/tls_crypt.h                   |  4 --
>>  tests/unit_tests/openvpn/Makefile.am      |  2 -
>>  tests/unit_tests/openvpn/test_tls_crypt.c |  4 --
>>  39 files changed, 50 insertions(+), 340 deletions(-)
>>
>> diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto=
.h
>> index c2b1866c..a8cf8d3b 100644
>> --- a/doc/doxygen/doc_data_crypto.h
>> +++ b/doc/doxygen/doc_data_crypto.h
>> @@ -58,13 +58,11 @@
>>   *     - \c openvpn_decrypt()
>>   *
>>   * @par Settings that control this module's activity
>> - * Whether or not the Data Channel Crypto module is active depends on t=
he
>> - * compile-time \c ENABLE_CRYPTO preprocessor macro.  How it processes =
packets
>> - * received from the \link data_control Data Channel Control module\end=
link at
>> - * runtime depends on the associated \c crypto_options structure.  To p=
erform
>> - * cryptographic operations, the \c crypto_options.key_ctx_bi must cont=
ain the
>> - * correct cipher and HMAC security parameters for the direction the pa=
cket is
>> - * traveling in.
>> + * How the data channel processes packets received from the \link data_=
control
>> + * Data Channel Control module\endlink at runtime depends on the associ=
ated
>> + * \c crypto_options structure.  To perform cryptographic operations, t=
he
>> + * \c crypto_options.key_ctx_bi must contain the correct cipher and HMAC
>> + * security parameters for the direction the packet is traveling in.
>>   *
>>   * @par Crypto algorithms
>>   * This module uses the crypto algorithm implementations of the external
>> diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
>> index f29b3a0b..f43f74b1 100644
>> --- a/include/openvpn-plugin.h.in
>> +++ b/include/openvpn-plugin.h.in
>> @@ -26,7 +26,6 @@
>>=20=20
>>  #define OPENVPN_PLUGIN_VERSION 3
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>  #ifdef ENABLE_CRYPTO_MBEDTLS
>>  #include <mbedtls/x509_crt.h>
>>  #ifndef __OPENVPN_X509_CERT_T_DECLARED
>> @@ -40,7 +39,6 @@ typedef mbedtls_x509_crt openvpn_x509_cert_t;
>>  typedef X509 openvpn_x509_cert_t;
>>  #endif
>>  #endif
>> -#endif
>>=20=20
>>  #include <stdarg.h>
>>  #include <stddef.h>
>> @@ -391,9 +389,9 @@ struct openvpn_plugin_args_open_return
>>   * *per_client_context : the per-client context pointer which was retur=
ned by
>>   *        openvpn_plugin_client_constructor_v1, if defined.
>>   *
>> - * current_cert_depth : Certificate depth of the certificate being pass=
ed over (only if compiled with ENABLE_CRYPTO defined)
>> + * current_cert_depth : Certificate depth of the certificate being pass=
ed over
>>   *
>> - * *current_cert : X509 Certificate object received from the client (on=
ly if compiled with ENABLE_CRYPTO defined)
>> + * *current_cert : X509 Certificate object received from the client
>>   *
>>   */
>>  struct openvpn_plugin_args_func_in
>> @@ -403,13 +401,8 @@ struct openvpn_plugin_args_func_in
>>      const char **const envp;
>>      openvpn_plugin_handle_t handle;
>>      void *per_client_context;
>> -#ifdef ENABLE_CRYPTO
>>      int current_cert_depth;
>>      openvpn_x509_cert_t *current_cert;
>> -#else
>> -    int __current_cert_depth_disabled; /* Unused, for compatibility pur=
poses only */
>> -    void *__current_cert_disabled; /* Unused, for compatibility purpose=
s only */
>> -#endif
>>  };
>>=20=20
>>=20=20
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 3f3caa1c..3096f3b0 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -30,8 +30,6 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "crypto.h"
>>  #include "error.h"
>>  #include "integer.h"
>> @@ -1842,5 +1840,3 @@ translate_cipher_name_to_openvpn(const char *ciphe=
r_name)
>>=20=20
>>      return pair->openvpn_name;
>>  }
>> -
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
>> index 6d60ef8c..8e8ee8f5 100644
>> --- a/src/openvpn/crypto.h
>> +++ b/src/openvpn/crypto.h
>> @@ -122,8 +122,6 @@
>>  #ifndef CRYPTO_H
>>  #define CRYPTO_H
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "crypto_backend.h"
>>  #include "basic.h"
>>  #include "buffer.h"
>> @@ -513,6 +511,4 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
>>      return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cip=
her || key->decrypt.hmac;
>>  }
>>=20=20
>> -
>> -#endif /* ENABLE_CRYPTO */
>>  #endif /* CRYPTO_H */
>> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
>> index f4d239bc..8fa03da5 100644
>> --- a/src/openvpn/crypto_mbedtls.c
>> +++ b/src/openvpn/crypto_mbedtls.c
>> @@ -34,7 +34,7 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
>> +#if defined(ENABLE_CRYPTO_MBEDTLS)
>>=20=20
>>  #include "errlevel.h"
>>  #include "basic.h"
>> @@ -903,4 +903,4 @@ hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *d=
st)
>>      ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));
>>  }
>>=20=20
>> -#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_MBEDTLS */
>> +#endif /* ENABLE_CRYPTO_MBEDTLS */
>> diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
>> index 4417b924..c3ec5695 100644
>> --- a/src/openvpn/crypto_mbedtls.h
>> +++ b/src/openvpn/crypto_mbedtls.h
>> @@ -26,8 +26,8 @@
>>   * @file Data Channel Cryptography mbed TLS-specific backend interface
>>   */
>>=20=20
>> -#ifndef CRYPTO_MBEDTLS_H_
>> -#define CRYPTO_MBEDTLS_H_
>> +#ifndef ENABLE_CRYPTO_MBEDTLS_H_
>> +#define ENABLE_CRYPTO_MBEDTLS_H_
>=20
> I think these are changed accidentally?

Yes, you are right! Sorry about that, but I didn't see them while
checking the patch before sending it.

>=20
>>  #include <mbedtls/cipher.h>
>>  #include <mbedtls/md.h>
>> @@ -147,4 +147,4 @@ mbed_log_func_line_lite(unsigned int flags, int errv=
al,
>>      mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
>>=20=20
>>=20=20
>> -#endif /* CRYPTO_MBEDTLS_H_ */
>> +#endif /* ENABLE_CRYPTO_MBEDTLS_H_ */
>=20
> As above.

yes

>=20
>> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>> index 0134e55d..20a519ec 100644
>> --- a/src/openvpn/crypto_openssl.c
>> +++ b/src/openvpn/crypto_openssl.c
>> @@ -34,7 +34,7 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
>> +#if defined(ENABLE_CRYPTO_OPENSSL)
>>=20=20
>>  #include "basic.h"
>>  #include "buffer.h"
>> @@ -969,4 +969,4 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
>>      HMAC_Final(ctx, dst, &in_hmac_len);
>>  }
>>=20=20
>> -#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_OPENSSL */
>> +#endif /* ENABLE_CRYPTO_OPENSSL */
>> diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
>> index 60a28123..8fad023a 100644
>> --- a/src/openvpn/crypto_openssl.h
>> +++ b/src/openvpn/crypto_openssl.h
>> @@ -26,8 +26,8 @@
>>   * @file Data Channel Cryptography OpenSSL-specific backend interface
>>   */
>>=20=20
>> -#ifndef CRYPTO_OPENSSL_H_
>> -#define CRYPTO_OPENSSL_H_
>> +#ifndef ENABLE_CRYPTO_OPENSSL_H_
>> +#define ENABLE_CRYPTO_OPENSSL_H_
>=20
> Same here,

yes

>=20
>>  #include <openssl/evp.h>
>>  #include <openssl/hmac.h>
>> @@ -102,4 +102,4 @@ void crypto_print_openssl_errors(const unsigned int =
flags);
>>      } while (false)
>>=20=20
>>=20=20
>> -#endif /* CRYPTO_OPENSSL_H_ */
>> +#endif /* ENABLE_CRYPTO_OPENSSL_H_ */
>=20
> and here.

yes

>=20
>> diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
>> index ab83ea40..c977120e 100644
>> --- a/src/openvpn/forward-inline.h
>> +++ b/src/openvpn/forward-inline.h
>> @@ -34,14 +34,12 @@
>>  static inline void
>>  check_tls(struct context *c)
>>  {
>> -#if defined(ENABLE_CRYPTO)
>>      void check_tls_dowork(struct context *c);
>>=20=20
>>      if (c->c2.tls_multi)
>>      {
>>          check_tls_dowork(c);
>>      }
>> -#endif
>>  }
>>=20=20
>>  /*
>> @@ -51,7 +49,6 @@ check_tls(struct context *c)
>>  static inline void
>>  check_tls_errors(struct context *c)
>>  {
>> -#if defined(ENABLE_CRYPTO)
>>      void check_tls_errors_co(struct context *c);
>>=20=20
>>      void check_tls_errors_nco(struct context *c);
>> @@ -73,7 +70,6 @@ check_tls_errors(struct context *c)
>>              }
>>          }
>>      }
>> -#endif /* if defined(ENABLE_CRYPTO) */
>>  }
>>=20=20
>>  /*
>> @@ -220,7 +216,6 @@ check_push_request(struct context *c)
>>=20=20
>>  #endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>  /*
>>   * Should we persist our anti-replay packet ID state to disk?
>>   */
>> @@ -233,7 +228,6 @@ check_packet_id_persist_flush(struct context *c)
>>          packet_id_persist_save(&c->c1.pid_persist);
>>      }
>>  }
>> -#endif
>>=20=20
>>  /*
>>   * Set our wakeup to 0 seconds, so we will be rescheduled
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index a868a8ff..9bf9483e 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -87,7 +87,6 @@ show_wait_status(struct context *c)
>>   * traffic on the control-channel.
>>   *
>>   */
>> -#ifdef ENABLE_CRYPTO
>>  void
>>  check_tls_dowork(struct context *c)
>>  {
>> @@ -131,7 +130,6 @@ check_tls_errors_nco(struct context *c)
>>  {
>>      register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIG=
USR1 -- TLS error */
>>  }
>> -#endif /* ENABLE_CRYPTO */
>>=20=20
>>  #if P2MP
>>=20=20
>> @@ -248,7 +246,6 @@ check_connection_established_dowork(struct context *=
c)
>>  bool
>>  send_control_channel_string(struct context *c, const char *str, int msg=
level)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      if (c->c2.tls_multi)
>>      {
>>          struct gc_arena gc =3D gc_new();
>> @@ -274,7 +271,6 @@ send_control_channel_string(struct context *c, const=
 char *str, int msglevel)
>>          gc_free(&gc);
>>          return stat;
>>      }
>> -#endif /* ENABLE_CRYPTO */
>>      return true;
>>  }
>>=20=20
>> @@ -485,7 +481,6 @@ encrypt_sign(struct context *c, bool comp_frag)
>>  #endif
>>      }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      /* initialize work buffer with FRAME_HEADROOM bytes of prepend capa=
city */
>>      ASSERT(buf_init(&b->encrypt_buf, FRAME_HEADROOM(&c->c2.frame)));
>>=20=20
>> @@ -518,7 +513,6 @@ encrypt_sign(struct context *c, bool comp_frag)
>>          }
>>          tls_post_encrypt(c->c2.tls_multi, &c->c2.buf);
>>      }
>> -#endif /* ifdef ENABLE_CRYPTO */
>>=20=20
>>      /*
>>       * Get the address we will be sending the packet to.
>> @@ -536,11 +530,9 @@ encrypt_sign(struct context *c, bool comp_frag)
>>  static void
>>  process_coarse_timers(struct context *c)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      /* flush current packet-id to file once per 60
>>       * seconds if --replay-persist was specified */
>>      check_packet_id_persist_flush(c);
>> -#endif
>>=20=20
>>      /* should we update status file? */
>>      check_status_file(c);
>> @@ -852,7 +844,6 @@ process_incoming_link_part1(struct context *c, struc=
t link_socket_info *lsi, boo
>>              link_socket_bad_incoming_addr(&c->c2.buf, lsi, &c->c2.from);
>>          }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>          if (c->c2.tls_multi)
>>          {
>>              /*
>> @@ -909,9 +900,6 @@ process_incoming_link_part1(struct context *c, struc=
t link_socket_info *lsi, boo
>>              register_signal(c, SIGUSR1, "decryption-error"); /* SOFT-SI=
GUSR1 -- decryption error in TCP mode */
>>              msg(D_STREAM_ERRORS, "Fatal decryption error (process_incom=
ing_link), restarting");
>>          }
>> -#else /* ENABLE_CRYPTO */
>> -        decrypt_status =3D true;
>> -#endif /* ENABLE_CRYPTO */
>>      }
>>      else
>>      {
>> @@ -1426,8 +1414,6 @@ process_outgoing_link(struct context *c)
>>              register_activity(c, size);
>>          }
>>=20=20
>> -
>> -#ifdef ENABLE_CRYPTO
>>          /* for unreachable network and "connecting" state switch to the=
 next host */
>>          if (size < 0 && ENETUNREACH =3D=3D error_code && c->c2.tls_multi
>>              && !tls_initial_packet_received(c->c2.tls_multi) && c->opti=
ons.mode =3D=3D MODE_POINT_TO_POINT)
>> @@ -1435,7 +1421,6 @@ process_outgoing_link(struct context *c)
>>              msg(M_INFO, "Network unreachable, restarting");
>>              register_signal(c, SIGUSR1, "network-unreachable");
>>          }
>> -#endif
>>      }
>>      else
>>      {
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index 408daf13..f90b6ffe 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -529,13 +529,11 @@ next_connection_entry(struct context *c)
>>  void
>>  init_query_passwords(const struct context *c)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      /* Certificate password input */
>>      if (c->options.key_pass_file)
>>      {
>>          pem_password_setup(c->options.key_pass_file);
>>      }
>> -#endif
>>=20=20
>>  #if P2MP
>>      /* Auth user/pass input */
>> @@ -704,7 +702,7 @@ init_static(void)
>>  {
>>      /* configure_path (); */
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(DMALLOC)
>> +#if defined(DMALLOC)
>>      crypto_init_dmalloc();
>>  #endif
>>=20=20
>> @@ -741,14 +739,12 @@ init_static(void)
>>=20=20
>>      update_time();
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      init_ssl_lib();
>>=20=20
>>      /* init PRNG used for IV generation */
>>      /* When forking, copy this to more places in the code to avoid fork
>>       * random-state predictability */
>>      prng_init(NULL, 0);
>> -#endif
>>=20=20
>>  #ifdef PID_TEST
>>      packet_id_interactive_test();       /* test the sequence number cod=
e */
>> @@ -942,9 +938,7 @@ init_static(void)
>>  void
>>  uninit_static(void)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      free_ssl_lib();
>> -#endif
>>=20=20
>>  #ifdef ENABLE_PKCS11
>>      pkcs11_terminate();
>> @@ -954,7 +948,7 @@ uninit_static(void)
>>      close_port_share();
>>  #endif
>>=20=20
>> -#if defined(MEASURE_TLS_HANDSHAKE_STATS) && defined(ENABLE_CRYPTO)
>> +#if defined(MEASURE_TLS_HANDSHAKE_STATS)
>>      show_tls_performance_stats();
>>  #endif
>>  }
>> @@ -998,7 +992,6 @@ print_openssl_info(const struct options *options)
>>      /*
>>       * OpenSSL info print mode?
>>       */
>> -#ifdef ENABLE_CRYPTO
>>      if (options->show_ciphers || options->show_digests || options->show=
_engines
>>          || options->show_tls_ciphers || options->show_curves)
>>      {
>> @@ -1025,7 +1018,6 @@ print_openssl_info(const struct options *options)
>>          }
>>          return true;
>>      }
>> -#endif /* ifdef ENABLE_CRYPTO */
>>      return false;
>>  }
>>=20=20
>> @@ -1035,7 +1027,6 @@ print_openssl_info(const struct options *options)
>>  bool
>>  do_genkey(const struct options *options)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      if (options->genkey)
>>      {
>>          int nbits_written;
>> @@ -1055,7 +1046,6 @@ do_genkey(const struct options *options)
>>              options->shared_secret_file);
>>          return true;
>>      }
>> -#endif
>>      return false;
>>  }
>>=20=20
>> @@ -1071,10 +1061,8 @@ do_persist_tuntap(const struct options *options)
>>          notnull(options->dev, "TUN/TAP device (--dev)");
>>          if (options->ce.remote || options->ifconfig_local
>>              || options->ifconfig_remote_netmask
>> -#ifdef ENABLE_CRYPTO
>>              || options->shared_secret_file
>>              || options->tls_server || options->tls_client
>> -#endif
>>              )
>>          {
>>              msg(M_FATAL|M_OPTERR,
>> @@ -1226,12 +1214,10 @@ const char *
>>  format_common_name(struct context *c, struct gc_arena *gc)
>>  {
>>      struct buffer out =3D alloc_buf_gc(256, gc);
>> -#ifdef ENABLE_CRYPTO
>>      if (c->c2.tls_multi)
>>      {
>>          buf_printf(&out, "[%s] ", tls_common_name(c->c2.tls_multi, fals=
e));
>>      }
>> -#endif
>>      return BSTR(&out);
>>  }
>>=20=20
>> @@ -1333,7 +1319,6 @@ do_init_timers(struct context *c, bool deferred)
>>  #endif
>>=20=20
>>          /* initialize packet_id persistence timer */
>> -#ifdef ENABLE_CRYPTO
>>          if (c->options.packet_id_file)
>>          {
>>              event_timeout_init(&c->c2.packet_id_persist_interval, 60, n=
ow);
>> @@ -1342,7 +1327,6 @@ do_init_timers(struct context *c, bool deferred)
>>          /* initialize tmp_int optimization that limits the number of ti=
mes we call
>>           * tls_multi_process in the main event loop */
>>          interval_init(&c->c2.tmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFR=
ESH);
>> -#endif
>>      }
>>  }
>>=20=20
>> @@ -1485,7 +1469,6 @@ initialization_sequence_completed(struct context *=
c, const unsigned int flags)
>>      do_uid_gid_chroot(c, true);
>>=20=20
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      /*
>>       * In some cases (i.e. when receiving auth-token via
>>       * push-reply) the auth-nocache option configured on the
>> @@ -1497,7 +1480,6 @@ initialization_sequence_completed(struct context *=
c, const unsigned int flags)
>>      {
>>          delayed_auth_pass_purge();
>>      }
>> -#endif /* ENABLE_CRYPTO */
>>=20=20
>>      /* Test if errors */
>>      if (flags & ISC_ERRORS)
>> @@ -2136,12 +2118,10 @@ pull_permission_mask(const struct context *c)
>>          flags |=3D (OPT_P_ROUTE | OPT_P_IPWIN32);
>>      }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      if (c->options.ncp_enabled)
>>      {
>>          flags |=3D OPT_P_NCP;
>>      }
>> -#endif
>>=20=20
>>      return flags;
>>  }
>> @@ -2230,7 +2210,6 @@ do_deferred_options(struct context *c, const unsig=
ned int found)
>>          msg(D_PUSH, "OPTIONS IMPORT: environment modified");
>>      }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      if (found & OPT_P_PEER_ID)
>>      {
>>          msg(D_PUSH, "OPTIONS IMPORT: peer-id set");
>> @@ -2271,7 +2250,7 @@ do_deferred_options(struct context *c, const unsig=
ned int found)
>>              return false;
>>          }
>>      }
>> -#endif /* ifdef ENABLE_CRYPTO */
>> +
>>      return true;
>>  }
>>=20=20
>> @@ -2423,19 +2402,15 @@ frame_finalize_options(struct context *c, const =
struct options *o)
>>  static void
>>  key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      free_key_ctx_bi(&ks->static_key);
>>      if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
>>      {
>>          tls_ctx_free(&ks->ssl_ctx);
>>          free_key_ctx_bi(&ks->tls_wrap_key);
>>      }
>> -#endif /* ENABLE_CRYPTO */
>>      CLEAR(*ks);
>>  }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  static void
>>  init_crypto_pre(struct context *c, const unsigned int flags)
>>  {
>> @@ -2880,12 +2855,10 @@ do_init_crypto_none(const struct context *c)
>>          "protected against man-in-the-middle changes. "
>>          "PLEASE DO RECONSIDER THIS CONFIGURATION!");
>>  }
>> -#endif /* ifdef ENABLE_CRYPTO */
>>=20=20
>>  static void
>>  do_init_crypto(struct context *c, const unsigned int flags)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      if (c->options.shared_secret_file)
>>      {
>>          do_init_crypto_static(c, flags);
>> @@ -2898,11 +2871,6 @@ do_init_crypto(struct context *c, const unsigned =
int flags)
>>      {
>>          do_init_crypto_none(c);
>>      }
>> -#else /* ENABLE_CRYPTO */
>> -    msg(M_WARN,
>> -        "******* WARNING *******: " PACKAGE_NAME
>> -        " built without crypto library -- encryption and authentication=
 features disabled -- all data will be tunnelled as cleartext");
>> -#endif /* ENABLE_CRYPTO */
>>  }
>>=20=20
>>  static void
>> @@ -3101,7 +3069,6 @@ do_option_warnings(struct context *c)
>>  #endif /* if P2MP_SERVER */
>>  #endif /* if P2MP */
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      if (!o->replay)
>>      {
>>          msg(M_WARN, "WARNING: You have disabled Replay Protection (--no=
-replay) which may make " PACKAGE_NAME " less secure");
>> @@ -3123,7 +3090,6 @@ do_option_warnings(struct context *c)
>>      {
>>          msg(M_WARN, "WARNING: --ns-cert-type is DEPRECATED.  Use --remo=
te-cert-tls instead.");
>>      }
>> -#endif /* ifdef ENABLE_CRYPTO */
>>=20=20
>>      /* If a script is used, print appropiate warnings */
>>      if (o->user_script_used)
>> @@ -3146,9 +3112,7 @@ do_option_warnings(struct context *c)
>>  static void
>>  do_init_frame_tls(struct context *c)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      do_init_finalize_tls_frame(c);
>> -#endif
>>  }
>>=20=20
>>  struct context_buffers *
>> @@ -3163,10 +3127,8 @@ init_context_buffers(const struct frame *frame)
>>=20=20
>>      b->aux_buf =3D alloc_buf(BUF_SIZE(frame));
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      b->encrypt_buf =3D alloc_buf(BUF_SIZE(frame));
>>      b->decrypt_buf =3D alloc_buf(BUF_SIZE(frame));
>> -#endif
>>=20=20
>>  #ifdef USE_COMP
>>      b->compress_buf =3D alloc_buf(BUF_SIZE(frame));
>> @@ -3190,10 +3152,8 @@ free_context_buffers(struct context_buffers *b)
>>          free_buf(&b->decompress_buf);
>>  #endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>          free_buf(&b->encrypt_buf);
>>          free_buf(&b->decrypt_buf);
>> -#endif
>>=20=20
>>          free(b);
>>      }
>> @@ -3329,14 +3289,12 @@ do_compute_occ_strings(struct context *c)
>>          options_string_version(c->c2.options_string_remote, &gc),
>>          c->c2.options_string_remote);
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      if (c->c2.tls_multi)
>>      {
>>          tls_multi_init_set_options(c->c2.tls_multi,
>>                                     c->c2.options_string_local,
>>                                     c->c2.options_string_remote);
>>      }
>> -#endif
>>=20=20
>>      gc_free(&gc);
>>  }
>> @@ -3410,7 +3368,6 @@ do_close_free_buf(struct context *c)
>>  static void
>>  do_close_tls(struct context *c)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      if (c->c2.tls_multi)
>>      {
>>          tls_multi_free(c->c2.tls_multi, true);
>> @@ -3429,7 +3386,6 @@ do_close_tls(struct context *c)
>>      }
>>      c->c2.options_string_local =3D c->c2.options_string_remote =3D NULL;
>>  #endif
>> -#endif
>>  }
>>=20=20
>>  /*
>> @@ -3494,14 +3450,12 @@ do_close_link_socket(struct context *c)
>>  static void
>>  do_close_packet_id(struct context *c)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      packet_id_free(&c->c2.crypto_options.packet_id);
>>      packet_id_persist_save(&c->c1.pid_persist);
>>      if (!(c->sig->signal_received =3D=3D SIGUSR1))
>>      {
>>          packet_id_persist_close(&c->c1.pid_persist);
>>      }
>> -#endif
>>  }
>>=20=20
>>  #ifdef ENABLE_FRAGMENT
>> @@ -3680,7 +3634,6 @@ do_setup_fast_io(struct context *c)
>>  static void
>>  do_signal_on_tls_errors(struct context *c)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      if (c->options.tls_exit)
>>      {
>>          c->c2.tls_exit_signal =3D SIGTERM;
>> @@ -3689,7 +3642,6 @@ do_signal_on_tls_errors(struct context *c)
>>      {
>>          c->c2.tls_exit_signal =3D SIGUSR1;
>>      }
>> -#endif
>>  }
>>=20=20
>>  #ifdef ENABLE_PLUGIN
>> @@ -4369,7 +4321,6 @@ inherit_context_child(struct context *dest,
>>      /* c1 init */
>>      packet_id_persist_init(&dest->c1.pid_persist);
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      dest->c1.ks.key_type =3D src->c1.ks.key_type;
>>      /* inherit SSL context */
>>      dest->c1.ks.ssl_ctx =3D src->c1.ks.ssl_ctx;
>> @@ -4379,7 +4330,6 @@ inherit_context_child(struct context *dest,
>>      dest->c1.ciphername =3D src->c1.ciphername;
>>      dest->c1.authname =3D src->c1.authname;
>>      dest->c1.keysize =3D src->c1.keysize;
>> -#endif
>>=20=20
>>      /* options */
>>      dest->options =3D src->options;
>> @@ -4453,9 +4403,7 @@ inherit_context_top(struct context *dest,
>>      /* detach plugins */
>>      dest->plugins_owned =3D false;
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      dest->c2.tls_multi =3D NULL;
>> -#endif
>>=20=20
>>      /* detach c1 ownership */
>>      dest->c1.tuntap_owned =3D false;
>> @@ -4513,8 +4461,6 @@ close_context(struct context *c, int sig, unsigned=
 int flags)
>>      }
>>  }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  /*
>>   * Do a loopback test
>>   * on the crypto subsystem.
>> @@ -4542,12 +4488,9 @@ test_crypto_thread(void *arg)
>>      return NULL;
>>  }
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>> -
>>  bool
>>  do_test_crypto(const struct options *o)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      if (o->test_crypto)
>>      {
>>          struct context c;
>> @@ -4562,6 +4505,5 @@ do_test_crypto(const struct options *o)
>>          test_crypto_thread((void *) &c);
>>          return true;
>>      }
>> -#endif
>>      return false;
>>  }
>> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
>> index 88121a38..55b106cd 100644
>> --- a/src/openvpn/manage.c
>> +++ b/src/openvpn/manage.c
>> @@ -762,10 +762,8 @@ man_query_need_str(struct management *man, const ch=
ar *type, const char *action)
>>  static void
>>  man_forget_passwords(struct management *man)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      ssl_purge_auth(false);
>>      msg(M_CLIENT, "SUCCESS: Passwords were forgotten");
>> -#endif
>>  }
>>=20=20
>>  static void
>> @@ -1918,12 +1916,11 @@ man_reset_client_socket(struct management *man, =
const bool exiting)
>>      }
>>      if (!exiting)
>>      {
>> -#ifdef ENABLE_CRYPTO
>>          if (man->settings.flags & MF_FORGET_DISCONNECT)
>>          {
>>              ssl_purge_auth(false);
>>          }
>> -#endif
>> +
>>          if (man->settings.flags & MF_SIGNAL)
>>          {
>>              int mysig =3D man_mod_signal(man, SIGUSR1);
>> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
>> index 6d53cbfb..76b592f8 100644
>> --- a/src/openvpn/misc.c
>> +++ b/src/openvpn/misc.c
>> @@ -770,8 +770,6 @@ create_temp_file(const char *directory, const char *=
prefix, struct gc_arena *gc)
>>      return NULL;
>>  }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  /*
>>   * Prepend a random string to hostname to prevent DNS caching.
>>   * For example, foo.bar.gov would be modified to <random-chars>.foo.bar=
.gov.
>> @@ -793,17 +791,6 @@ hostname_randomize(const char *hostname, struct gc_=
arena *gc)
>>  #undef n_rnd_bytes
>>  }
>>=20=20
>> -#else  /* ifdef ENABLE_CRYPTO */
>> -
>> -const char *
>> -hostname_randomize(const char *hostname, struct gc_arena *gc)
>> -{
>> -    msg(M_WARN, "WARNING: hostname randomization disabled when crypto s=
upport is not compiled");
>> -    return hostname;
>> -}
>> -
>> -#endif /* ifdef ENABLE_CRYPTO */
>> -
>>  /*
>>   * Put a directory and filename together.
>>   */
>> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
>> index f6c810a2..ec20ee7e 100644
>> --- a/src/openvpn/misc.h
>> +++ b/src/openvpn/misc.h
>> @@ -143,13 +143,8 @@ const char **make_arg_array(const char *first, cons=
t char *parms, struct gc_aren
>>  const char **make_extended_arg_array(char **p, struct gc_arena *gc);
>>=20=20
>>  /* an analogue to the random() function, but use OpenSSL functions if a=
vailable */
>> -#ifdef ENABLE_CRYPTO
>>  long int get_random(void);
>>=20=20
>> -#else
>> -#define get_random random
>> -#endif
>> -
>>  /* return true if filename can be opened for read */
>>  bool test_file(const char *filename);
>>=20=20
>> @@ -162,7 +157,7 @@ const char *gen_path(const char *directory, const ch=
ar *filename, struct gc_aren
>>  /* return true if pathname is absolute */
>>  bool absolute_pathname(const char *pathname);
>>=20=20
>> -/* prepend a random prefix to hostname (need ENABLE_CRYPTO) */
>> +/* prepend a random prefix to hostname */
>>  const char *hostname_randomize(const char *hostname, struct gc_arena *g=
c);
>>=20=20
>>  /*
>> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
>> index 9262e68b..fb8ff1a4 100644
>> --- a/src/openvpn/openvpn.h
>> +++ b/src/openvpn/openvpn.h
>> @@ -54,7 +54,6 @@
>>=20=20
>>  struct key_schedule
>>  {
>> -#ifdef ENABLE_CRYPTO
>>      /* which cipher, HMAC digest, and key sizes are we using? */
>>      struct key_type key_type;
>>=20=20
>> @@ -67,9 +66,6 @@ struct key_schedule
>>      /* optional TLS control channel wrapping */
>>      struct key_type tls_auth_key_type;
>>      struct key_ctx_bi tls_wrap_key;
>> -#else                           /* ENABLE_CRYPTO */
>> -    int dummy;
>> -#endif                          /* ENABLE_CRYPTO */
>>  };
>>=20=20
>>  /*
>> @@ -96,10 +92,8 @@ struct context_buffers
>>      struct buffer aux_buf;
>>=20=20
>>      /* workspace buffers used by crypto routines */
>> -#ifdef ENABLE_CRYPTO
>>      struct buffer encrypt_buf;
>>      struct buffer decrypt_buf;
>> -#endif
>>=20=20
>>      /* workspace buffers for compression */
>>  #ifdef USE_COMP
>> @@ -334,8 +328,6 @@ struct context_2
>>      int occ_mtu_load_n_tries;
>>  #endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>      /*
>>       * TLS-mode crypto objects.
>>       */
>> @@ -367,8 +359,6 @@ struct context_2
>>=20=20
>>      struct event_timeout packet_id_persist_interval;
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>> -
>>  #ifdef USE_COMP
>>      struct compress_context *comp_context;
>>      /**< Compression context used by the
>> @@ -566,7 +556,6 @@ struct context
>>   * have been compiled in.
>>   */
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>  #define TLS_MODE(c) ((c)->c2.tls_multi !=3D NULL)
>>  #define PROTO_DUMP_FLAGS (check_debug_level(D_LINK_RW_VERBOSE) ? (PD_SH=
OW_DATA|PD_VERBOSE) : 0)
>>  #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
>> @@ -574,22 +563,9 @@ struct context
>>                                            |(c->c2.tls_multi ? PD_TLS : =
0)   \
>>                                            |(c->options.tls_auth_file ? =
c->c1.ks.key_type.hmac_length : 0), \
>>                                            gc)
>> -#else  /* ifdef ENABLE_CRYPTO */
>> -#define TLS_MODE(c) (false)
>> -#define PROTO_DUMP(buf, gc) format_hex(BPTR(buf), BLEN(buf), 80, gc)
>> -#endif
>> -
>> -#ifdef ENABLE_CRYPTO
>>  #define MD5SUM(buf, len, gc) md5sum((buf), (len), 0, (gc))
>> -#else
>> -#define MD5SUM(buf, len, gc) "[unavailable]"
>> -#endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>  #define CIPHER_ENABLED(c) (c->c1.ks.key_type.cipher !=3D NULL)
>> -#else
>> -#define CIPHER_ENABLED(c) (false)
>> -#endif
>>=20=20
>>  /* this represents "disabled peer-id" */
>>  #define MAX_PEER_ID 0xFFFFFF
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 8e5cdf7f..d8853f58 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -67,7 +67,6 @@ const char title_string[] =3D
>>      " [git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_FLAGS "]"
>>  #endif
>>      " " TARGET_ALIAS
>> -#ifdef ENABLE_CRYPTO
>>  #if defined(ENABLE_CRYPTO_MBEDTLS)
>>      " [SSL (mbed TLS)]"
>>  #elif defined(ENABLE_CRYPTO_OPENSSL)
>> @@ -75,7 +74,6 @@ const char title_string[] =3D
>>  #else
>>      " [SSL]"
>>  #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
>> -#endif /* ENABLE_CRYPTO */
>>  #ifdef USE_COMP
>>  #ifdef ENABLE_LZO
>>      " [LZO]"
>> @@ -518,7 +516,6 @@ static const char usage_message[] =3D
>>      "--explicit-exit-notify [n] : On exit/restart, send exit signal to\=
n"
>>      "                  server/remote. n =3D # of retries, default=3D1.\=
n"
>>  #endif
>> -#ifdef ENABLE_CRYPTO
>>      "\n"
>>      "Data Channel Encryption Options (must be compatible between peers)=
:\n"
>>      "(These options are meaningful for both Static Key & TLS-mode)\n"
>> @@ -748,7 +745,6 @@ static const char usage_message[] =3D
>>      "--genkey        : Generate a random key to be used as a shared sec=
ret,\n"
>>      "                  for use with the --secret option.\n"
>>      "--secret file   : Write key to file.\n"
>> -#endif                          /* ENABLE_CRYPTO */
>>  #ifdef ENABLE_FEATURE_TUN_PERSIST
>>      "\n"
>>      "Tun/tap config mode (available with linux 2.4+):\n"
>> @@ -852,7 +848,6 @@ init_options(struct options *o, const bool init_gc)
>>  #if P2MP
>>      o->scheduled_exit_interval =3D 5;
>>  #endif
>> -#ifdef ENABLE_CRYPTO
>>      o->ciphername =3D "BF-CBC";
>>  #ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=3D2 requires GCM support */
>>      o->ncp_enabled =3D true;
>> @@ -882,7 +877,6 @@ init_options(struct options *o, const bool init_gc)
>>  #ifdef ENABLE_X509ALTUSERNAME
>>      o->x509_username_field =3D X509_USERNAME_FIELD_DEFAULT;
>>  #endif
>> -#endif /* ENABLE_CRYPTO */
>>  #ifdef ENABLE_PKCS11
>>      o->pkcs11_pin_cache_period =3D -1;
>>  #endif                  /* ENABLE_PKCS11 */
>> @@ -1146,7 +1140,6 @@ string_substitute(const char *src, int from, int t=
o, struct gc_arena *gc)
>>      return ret;
>>  }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>  static uint8_t *
>>  parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struc=
t gc_arena *gc)
>>  {
>> @@ -1188,7 +1181,6 @@ parse_hash_fingerprint(const char *str, int nbytes=
, int msglevel, struct gc_aren
>>      }
>>      return ret;
>>  }
>> -#endif /* ifdef ENABLE_CRYPTO */
>>=20=20
>>  #ifdef _WIN32
>>=20=20
>> @@ -1560,14 +1552,12 @@ show_settings(const struct options *o)
>>      SHOW_INT(persist_mode);
>>  #endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      SHOW_BOOL(show_ciphers);
>>      SHOW_BOOL(show_digests);
>>      SHOW_BOOL(show_engines);
>>      SHOW_BOOL(genkey);
>>      SHOW_STR(key_pass_file);
>>      SHOW_BOOL(show_tls_ciphers);
>> -#endif
>>=20=20
>>      SHOW_INT(connect_retry_max);
>>      show_connection_entries(o);
>> @@ -1702,7 +1692,6 @@ show_settings(const struct options *o)
>>      }
>>  #endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      SHOW_STR(shared_secret_file);
>>      SHOW_INT(key_direction);
>>      SHOW_STR(ciphername);
>> @@ -1790,7 +1779,6 @@ show_settings(const struct options *o)
>>=20=20
>>      SHOW_STR(tls_auth_file);
>>      SHOW_STR(tls_crypt_file);
>> -#endif /* ENABLE_CRYPTO */
>>=20=20
>>  #ifdef ENABLE_PKCS11
>>      {
>> @@ -2024,14 +2012,14 @@ options_postprocess_verify_ce(const struct optio=
ns *options, const struct connec
>>=20=20
>>      init_options(&defaults, true);
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      if (options->test_crypto)
>>      {
>>          notnull(options->shared_secret_file, "key file (--secret)");
>>      }
>>      else
>> -#endif
>> -    notnull(options->dev, "TUN/TAP device (--dev)");
>> +    {
>> +        notnull(options->dev, "TUN/TAP device (--dev)");
>> +    }
>>=20=20
>>      /*
>>       * Get tun/tap/null device type
>> @@ -2072,10 +2060,7 @@ options_postprocess_verify_ce(const struct option=
s *options, const struct connec
>>      }
>>=20=20
>>      if (options->inetd =3D=3D INETD_NOWAIT
>> -#ifdef ENABLE_CRYPTO
>> -        && !(options->tls_server || options->tls_client)
>> -#endif
>> -        )
>> +        && !(options->tls_server || options->tls_client))
>>      {
>>          msg(M_USAGE, "--inetd nowait can only be used in TLS mode");
>>      }
>> @@ -2485,8 +2470,6 @@ options_postprocess_verify_ce(const struct options=
 *options, const struct connec
>>      }
>>  #endif /* P2MP_SERVER */
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>      if (options->ncp_enabled && !tls_check_ncp_cipher_list(options->ncp=
_ciphers))
>>      {
>>          msg(M_USAGE, "NCP cipher list contains unsupported ciphers.");
>> @@ -2771,7 +2754,6 @@ options_postprocess_verify_ce(const struct options=
 *options, const struct connec
>>          }
>>      }
>>  #undef MUST_BE_UNDEF
>> -#endif /* ENABLE_CRYPTO */
>>=20=20
>>  #if P2MP
>>      if (options->auth_user_pass_file && !options->pull)
>> @@ -3009,7 +2991,6 @@ options_postprocess_mutate(struct options *o)
>>          options_postprocess_mutate_ce(o, o->connection_list->array[i]);
>>      }
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      if (o->tls_server)
>>      {
>>          /* Check that DH file is specified, or explicitly disabled */
>> @@ -3035,7 +3016,6 @@ options_postprocess_mutate(struct options *o)
>>               "in P2MP client or server mode" );
>>          o->ncp_enabled =3D false;
>>      }
>> -#endif
>>=20=20
>>  #if ENABLE_MANAGEMENT
>>      if (o->http_proxy_override)
>> @@ -3267,7 +3247,6 @@ options_postprocess_filechecks(struct options *opt=
ions)
>>  {
>>      bool errs =3D false;
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      /* ** SSL/TLS/crypto related files ** */
>>      errs |=3D check_file_access(CHKACC_FILE|CHKACC_INLINE, options->dh_=
file, R_OK, "--dh");
>>      errs |=3D check_file_access(CHKACC_FILE|CHKACC_INLINE, options->ca_=
file, R_OK, "--ca");
>> @@ -3308,7 +3287,6 @@ options_postprocess_filechecks(struct options *opt=
ions)
>>      /* ** Password files ** */
>>      errs |=3D check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRI=
VATE,
>>                                options->key_pass_file, R_OK, "--askpass"=
);
>> -#endif /* ENABLE_CRYPTO */
>>  #ifdef ENABLE_MANAGEMENT
>>      errs |=3D check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRI=
VATE,
>>                                options->management_user_pass, R_OK,
>> @@ -3331,10 +3309,8 @@ options_postprocess_filechecks(struct options *op=
tions)
>>                                R_OK|W_OK, "--status");
>>=20=20
>>      /* ** Config related ** */
>> -#ifdef ENABLE_CRYPTO
>>      errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE=
, options->tls_export_cert,
>>                                       R_OK|W_OK|X_OK, "--tls-export-cert=
");
>> -#endif /* ENABLE_CRYPTO */
>>  #if P2MP_SERVER
>>      errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE=
, options->client_config_dir,
>>                                       R_OK|X_OK, "--client-config-dir");
>> @@ -3462,7 +3438,7 @@ static size_t
>>  calc_options_string_link_mtu(const struct options *o, const struct fram=
e *frame)
>>  {
>>      size_t link_mtu =3D EXPANDED_SIZE(frame);
>> -#ifdef ENABLE_CRYPTO
>> +
>>      if (o->pull || o->mode =3D=3D MODE_SERVER)
>>      {
>>          struct frame fake_frame =3D *frame;
>> @@ -3478,7 +3454,6 @@ calc_options_string_link_mtu(const struct options =
*o, const struct frame *frame)
>>              EXPANDED_SIZE(&fake_frame));
>>          link_mtu =3D EXPANDED_SIZE(&fake_frame);
>>      }
>> -#endif
>>      return link_mtu;
>>  }
>>=20=20
>> @@ -3606,8 +3581,6 @@ options_string(const struct options *o,
>>      }
>>  #endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #define TLS_CLIENT (o->tls_client)
>>  #define TLS_SERVER (o->tls_server)
>>=20=20
>> @@ -3705,8 +3678,6 @@ options_string(const struct options *o,
>>  #undef TLS_CLIENT
>>  #undef TLS_SERVER
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>> -
>>      return BSTR(&out);
>>  }
>>=20=20
>> @@ -4084,7 +4055,6 @@ usage(void)
>>      struct options o;
>>      init_options(&o, true);
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      fprintf(fp, usage_message,
>>              title_string,
>>              o.ce.connect_retry_seconds,
>> @@ -4096,15 +4066,6 @@ usage(void)
>>              o.replay_window, o.replay_time,
>>              o.tls_timeout, o.renegotiate_seconds,
>>              o.handshake_window, o.transition_window);
>> -#else  /* ifdef ENABLE_CRYPTO */
>> -    fprintf(fp, usage_message,
>> -            title_string,
>> -            o.ce.connect_retry_seconds,
>> -            o.ce.connect_retry_seconds_max,
>> -            o.ce.local_port, o.ce.remote_port,
>> -            TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
>> -            o.verbosity);
>> -#endif
>>      fflush(fp);
>>=20=20
>>  #endif /* ENABLE_SMALL */
>> @@ -4132,11 +4093,7 @@ show_windows_version(const unsigned int flags)
>>  void
>>  show_library_versions(const unsigned int flags)
>>  {
>> -#ifdef ENABLE_CRYPTO
>>  #define SSL_LIB_VER_STR get_ssl_library_version()
>> -#else
>> -#define SSL_LIB_VER_STR ""
>> -#endif
>>  #ifdef ENABLE_LZO
>>  #define LZO_LIB_VER_STR ", LZO ", lzo_version_string()
>>  #else
>> @@ -7441,7 +7398,6 @@ add_option(struct options *options,
>>          }
>>      }
>>  #endif /* USE_COMP */
>> -#ifdef ENABLE_CRYPTO
>>      else if (streq(p[0], "show-ciphers") && !p[1])
>>      {
>>          VERIFY_PERMISSION(OPT_P_GENERAL);
>> @@ -8124,7 +8080,6 @@ add_option(struct options *options,
>>          options->x509_username_field =3D p[1];
>>      }
>>  #endif /* ENABLE_X509ALTUSERNAME */
>> -#endif /* ENABLE_CRYPTO */
>>  #ifdef ENABLE_PKCS11
>>      else if (streq(p[0], "show-pkcs11-ids") && !p[3])
>>      {
>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>> index 035c6d15..08e53f85 100644
>> --- a/src/openvpn/options.h
>> +++ b/src/openvpn/options.h
>> @@ -41,9 +41,7 @@
>>  #include "comp.h"
>>  #include "pushlist.h"
>>  #include "clinat.h"
>> -#ifdef ENABLE_CRYPTO
>>  #include "crypto_backend.h"
>> -#endif
>>=20=20
>>=20=20
>>  /*
>> @@ -81,7 +79,7 @@ struct options_pre_pull
>>  };
>>=20=20
>>  #endif
>> -#if defined(ENABLE_CRYPTO) && !defined(ENABLE_CRYPTO_OPENSSL) && !defin=
ed(ENABLE_CRYPTO_MBEDTLS)
>> +#if !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
>>  #error "At least one of OpenSSL or mbed TLS needs to be defined."
>>  #endif
>>=20=20
>> @@ -188,7 +186,6 @@ struct options
>>      bool persist_config;
>>      int persist_mode;
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      const char *key_pass_file;
>>      bool show_ciphers;
>>      bool show_digests;
>> @@ -196,7 +193,6 @@ struct options
>>      bool show_tls_ciphers;
>>      bool show_curves;
>>      bool genkey;
>> -#endif
>>=20=20
>>      /* Networking parms */
>>      int connect_retry_max;
>> @@ -468,7 +464,6 @@ struct options
>>  #endif
>>  #endif /* if P2MP */
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>      /* Cipher parms */
>>      const char *shared_secret_file;
>>      const char *shared_secret_file_inline;
>> @@ -580,8 +575,6 @@ struct options
>>=20=20
>>      bool tls_exit;
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>> -
>>      const struct x509_track *x509_track;
>>=20=20
>>      /* special state parms */
>> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
>> index 4e0e9868..4c3696de 100644
>> --- a/src/openvpn/packet_id.c
>> +++ b/src/openvpn/packet_id.c
>> @@ -38,8 +38,6 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "packet_id.h"
>>  #include "misc.h"
>>  #include "integer.h"
>> @@ -695,5 +693,3 @@ packet_id_interactive_test(void)
>>      packet_id_free(&pid);
>>  }
>>  #endif /* ifdef PID_TEST */
>> -
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
>> index 8509e590..cde76483 100644
>> --- a/src/openvpn/packet_id.h
>> +++ b/src/openvpn/packet_id.h
>> @@ -27,8 +27,6 @@
>>   * attempts to replay them back later.
>>   */
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #ifndef PACKET_ID_H
>>  #define PACKET_ID_H
>>=20=20
>> @@ -342,4 +340,3 @@ packet_id_reap_test(struct packet_id_rec *p)
>>  }
>>=20=20
>>  #endif /* PACKET_ID_H */
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
>> index 557b6bc7..7387f8be 100644
>> --- a/src/openvpn/plugin.c
>> +++ b/src/openvpn/plugin.c
>> @@ -517,11 +517,9 @@ plugin_call_item(const struct plugin *p,
>>                   const int type,
>>                   const struct argv *av,
>>                   struct openvpn_plugin_string_list **retlist,
>> -                 const char **envp
>> -#ifdef ENABLE_CRYPTO
>> -                 , int certdepth,
>> +                 const char **envp,
>> +                 int certdepth,
>>                   openvpn_x509_cert_t *current_cert
>> -#endif
>>                   )
>>  {
>>      int status =3D OPENVPN_PLUGIN_FUNC_SUCCESS;
>> @@ -550,13 +548,8 @@ plugin_call_item(const struct plugin *p,
>>                                                          (const char **c=
onst) envp,
>>                                                          p->plugin_handl=
e,
>>                                                          per_client_cont=
ext,
>> -#ifdef ENABLE_CRYPTO
>>                                                          (current_cert ?=
 certdepth : -1),
>>                                                          current_cert
>> -#else
>> -                                                        -1,
>> -                                                        NULL
>> -#endif
>>              };
>>=20=20
>>              struct openvpn_plugin_args_func_return retargs;
>> @@ -786,11 +779,9 @@ plugin_call_ssl(const struct plugin_list *pl,
>>                  const int type,
>>                  const struct argv *av,
>>                  struct plugin_return *pr,
>> -                struct env_set *es
>> -#ifdef ENABLE_CRYPTO
>> -                , int certdepth,
>> +                struct env_set *es,
>> +                int certdepth,
>>                  openvpn_x509_cert_t *current_cert
>> -#endif
>>                  )
>>  {
>>      if (pr)
>> @@ -818,11 +809,9 @@ plugin_call_ssl(const struct plugin_list *pl,
>>                                                  type,
>>                                                  av,
>>                                                  pr ? &pr->list[i] : NUL=
L,
>> -                                                envp
>> -#ifdef ENABLE_CRYPTO
>> -                                                ,certdepth,
>> +                                                envp,
>> +                                                certdepth,
>>                                                  current_cert
>> -#endif
>>                                                  );
>>              switch (status)
>>              {
>> diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
>> index 0cffee0f..c9bf03bc 100644
>> --- a/src/openvpn/plugin.h
>> +++ b/src/openvpn/plugin.h
>> @@ -127,11 +127,9 @@ int plugin_call_ssl(const struct plugin_list *pl,
>>                      const int type,
>>                      const struct argv *av,
>>                      struct plugin_return *pr,
>> -                    struct env_set *es
>> -#ifdef ENABLE_CRYPTO
>> -                    , int current_cert_depth,
>> +                    struct env_set *es,
>> +                    int current_cert_depth,
>>                      openvpn_x509_cert_t *current_cert
>> -#endif
>>                      );
>>=20=20
>>  void plugin_list_close(struct plugin_list *pl);
>> @@ -189,11 +187,9 @@ plugin_call_ssl(const struct plugin_list *pl,
>>                  const int type,
>>                  const struct argv *av,
>>                  struct plugin_return *pr,
>> -                struct env_set *es
>> -#ifdef ENABLE_CRYPTO
>> -                , int current_cert_depth,
>> +                struct env_set *es,
>> +                int current_cert_depth,
>>                  openvpn_x509_cert_t *current_cert
>> -#endif
>>                  )
>>  {
>>      return 0;
>> @@ -208,11 +204,7 @@ plugin_call(const struct plugin_list *pl,
>>              struct plugin_return *pr,
>>              struct env_set *es)
>>  {
>> -    return plugin_call_ssl(pl, type, av, pr, es
>> -#ifdef ENABLE_CRYPTO
>> -                           , -1, NULL
>> -#endif
>> -                           );
>> +    return plugin_call_ssl(pl, type, av, pr, es, -1, NULL);
>>  }
>>=20=20
>>  #endif /* OPENVPN_PLUGIN_H */
>> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
>> index bfd8c247..972af618 100644
>> --- a/src/openvpn/reliable.c
>> +++ b/src/openvpn/reliable.c
>> @@ -34,8 +34,6 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "buffer.h"
>>  #include "error.h"
>>  #include "common.h"
>> @@ -802,10 +800,3 @@ reliable_debug_print(const struct reliable *rel, ch=
ar *desc)
>>  }
>>=20=20
>>  #endif /* if 0 */
>> -
>> -#else  /* ifdef ENABLE_CRYPTO */
>> -static void
>> -dummy(void)
>> -{
>> -}
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
>> index aa34b022..0585d8b7 100644
>> --- a/src/openvpn/reliable.h
>> +++ b/src/openvpn/reliable.h
>> @@ -28,8 +28,6 @@
>>   */
>>=20=20
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #ifndef RELIABLE_H
>>  #define RELIABLE_H
>>=20=20
>> @@ -476,4 +474,3 @@ void reliable_ack_debug_print(const struct reliable_=
ack *ack, char *desc);
>>=20=20
>>=20=20
>>  #endif /* RELIABLE_H */
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
>> index dce42e7f..bc3c42af 100644
>> --- a/src/openvpn/session_id.c
>> +++ b/src/openvpn/session_id.c
>> @@ -38,8 +38,6 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "error.h"
>>  #include "common.h"
>>  #include "crypto.h"
>> @@ -60,10 +58,3 @@ session_id_print(const struct session_id *sid, struct=
 gc_arena *gc)
>>  {
>>      return format_hex(sid->id, SID_SIZE, 0, gc);
>>  }
>> -
>> -#else  /* ifdef ENABLE_CRYPTO */
>> -static void
>> -dummy(void)
>> -{
>> -}
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
>> index 6611a3cb..df9167c3 100644
>> --- a/src/openvpn/session_id.h
>> +++ b/src/openvpn/session_id.h
>> @@ -29,8 +29,6 @@
>>   * negotiated).
>>   */
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #ifndef SESSION_ID_H
>>  #define SESSION_ID_H
>>=20=20
>> @@ -82,4 +80,3 @@ void session_id_random(struct session_id *sid);
>>  const char *session_id_print(const struct session_id *sid, struct gc_ar=
ena *gc);
>>=20=20
>>  #endif /* SESSION_ID_H */
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 843bc393..919a4b40 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -43,8 +43,6 @@
>>  #include "syshead.h"
>>  #include "win32.h"
>>=20=20
>> -#if defined(ENABLE_CRYPTO)
>> -
>>  #include "error.h"
>>  #include "common.h"
>>  #include "socket.h"
>> @@ -4245,10 +4243,3 @@ delayed_auth_pass_purge(void)
>>      auth_user_pass.wait_for_push =3D false;
>>      purge_user_pass(&auth_user_pass, false);
>>  }
>> -
>> -#else  /* if defined(ENABLE_CRYPTO) */
>> -static void
>> -dummy(void)
>> -{
>> -}
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
>> index 0e0f68fa..dd1ab0fd 100644
>> --- a/src/openvpn/ssl.h
>> +++ b/src/openvpn/ssl.h
>> @@ -29,8 +29,6 @@
>>  #ifndef OPENVPN_SSL_H
>>  #define OPENVPN_SSL_H
>>=20=20
>> -#if defined(ENABLE_CRYPTO)
>> -
>>  #include "basic.h"
>>  #include "common.h"
>>  #include "crypto.h"
>> @@ -600,6 +598,4 @@ bool is_hard_reset(int op, int key_method);
>>=20=20
>>  void delayed_auth_pass_purge(void);
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>> -
>>  #endif /* ifndef OPENVPN_SSL_H */
>> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
>> index f588110c..7cf5d830 100644
>> --- a/src/openvpn/ssl_backend.h
>> +++ b/src/openvpn/ssl_backend.h
>> @@ -124,8 +124,6 @@ int tls_version_parse(const char *vstr, const char *=
extra);
>>   */
>>  int tls_version_max(void);
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  /**
>>   * Initialise a library-specific TLS context for a server.
>>   *
>> @@ -539,5 +537,4 @@ void get_highest_preference_tls_cipher(char *buf, in=
t size);
>>   */
>>  const char *get_ssl_library_version(void);
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>>  #endif /* SSL_BACKEND_H_ */
>> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
>> index 09829ebb..8ac52d55 100644
>> --- a/src/openvpn/ssl_mbedtls.c
>> +++ b/src/openvpn/ssl_mbedtls.c
>> @@ -35,7 +35,7 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
>> +#if defined(ENABLE_CRYPTO_MBEDTLS)
>>=20=20
>>  #include "errlevel.h"
>>  #include "ssl_backend.h"
>> @@ -1395,4 +1395,4 @@ get_ssl_library_version(void)
>>      return mbedtls_version;
>>  }
>>=20=20
>> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
>> +#endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>> index b782946e..34c31b9d 100644
>> --- a/src/openvpn/ssl_openssl.c
>> +++ b/src/openvpn/ssl_openssl.c
>> @@ -34,7 +34,7 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
>> +#if defined(ENABLE_CRYPTO_OPENSSL)
>>=20=20
>>  #include "errlevel.h"
>>  #include "buffer.h"
>> @@ -1874,4 +1874,4 @@ get_ssl_library_version(void)
>>      return SSLeay_version(SSLEAY_VERSION);
>>  }
>>=20=20
>> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
>> +#endif /* defined(ENABLE_CRYPTO_OPENSSL) */
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index de54fb74..ebb1da20 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -34,8 +34,6 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "misc.h"
>>  #include "manage.h"
>>  #include "otime.h"
>> @@ -1541,5 +1539,3 @@ tls_x509_clear_env(struct env_set *es)
>>          item =3D next;
>>      }
>>  }
>> -
>> -#endif /* ENABLE_CRYPTO */
>> diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
>> index f2d0d6ca..b17402b0 100644
>> --- a/src/openvpn/ssl_verify.h
>> +++ b/src/openvpn/ssl_verify.h
>> @@ -29,8 +29,6 @@
>>  #ifndef SSL_VERIFY_H_
>>  #define SSL_VERIFY_H_
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "syshead.h"
>>  #include "misc.h"
>>  #include "ssl_common.h"
>> @@ -243,6 +241,4 @@ tls_client_reason(struct tls_multi *multi)
>>  /** Remove any X509_ env variables from env_set es */
>>  void tls_x509_clear_env(struct env_set *es);
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>> -
>>  #endif /* SSL_VERIFY_H_ */
>> diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_m=
bedtls.c
>> index 838c2176..5c4ad19e 100644
>> --- a/src/openvpn/ssl_verify_mbedtls.c
>> +++ b/src/openvpn/ssl_verify_mbedtls.c
>> @@ -34,7 +34,7 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
>> +#if defined(ENABLE_CRYPTO_MBEDTLS)
>>=20=20
>>  #include "crypto_mbedtls.h"
>>  #include "ssl_verify.h"
>> @@ -550,4 +550,4 @@ tls_verify_crl_missing(const struct tls_options *opt)
>>      return false;
>>  }
>>=20=20
>> -#endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) =
*/
>> +#endif /* #if defined(ENABLE_CRYPTO_MBEDTLS) */
>> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_o=
penssl.c
>> index 2f3b10b9..02850fcb 100644
>> --- a/src/openvpn/ssl_verify_openssl.c
>> +++ b/src/openvpn/ssl_verify_openssl.c
>> @@ -34,7 +34,7 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
>> +#if defined(ENABLE_CRYPTO_OPENSSL)
>>=20=20
>>  #include "ssl_verify_openssl.h"
>>=20=20
>> @@ -800,4 +800,4 @@ tls_verify_crl_missing(const struct tls_options *opt)
>>      return true;
>>  }
>>=20=20
>> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
>> +#endif /* defined(ENABLE_CRYPTO_OPENSSL) */
>> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
>> index d9f5a34d..0c17ded3 100644
>> --- a/src/openvpn/syshead.h
>> +++ b/src/openvpn/syshead.h
>> @@ -513,7 +513,7 @@ socket_defined(const socket_descriptor_t sd)
>>   * Do we have point-to-multipoint capability?
>>   */
>>=20=20
>> -#if defined(ENABLE_CRYPTO) && defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
>> +#if defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
>>  #define P2MP 1
>>  #else
>>  #define P2MP 0
>> @@ -550,7 +550,7 @@ socket_defined(const socket_descriptor_t sd)
>>  /*
>>   * Enable external private key
>>   */
>> -#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_CRYPTO)
>> +#if defined(ENABLE_MANAGEMENT)
>>  #define MANAGMENT_EXTERNAL_KEY
>>  #endif
>>=20=20
>> @@ -597,25 +597,17 @@ socket_defined(const socket_descriptor_t sd)
>>  /*
>>   * Should we include NTLM proxy functionality
>>   */
>> -#if defined(ENABLE_CRYPTO)
>>  #define NTLM 1
>> -#else
>> -#define NTLM 0
>> -#endif
>>=20=20
>>  /*
>>   * Should we include proxy digest auth functionality
>>   */
>> -#if defined(ENABLE_CRYPTO)
>>  #define PROXY_DIGEST_AUTH 1
>> -#else
>> -#define PROXY_DIGEST_AUTH 0
>> -#endif
>>=20=20
>>  /*
>>   * Do we have CryptoAPI capability?
>>   */
>> -#if defined(_WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_=
OPENSSL)
>> +#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL)
>>  #define ENABLE_CRYPTOAPI
>>  #endif
>>=20=20
>> @@ -684,9 +676,7 @@ socket_defined(const socket_descriptor_t sd)
>>  /*
>>   * Do we support pushing peer info?
>>   */
>> -#if defined(ENABLE_CRYPTO)
>>  #define ENABLE_PUSH_PEER_INFO
>> -#endif
>>=20=20
>>  /*
>>   * Compression support
>> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
>> index 403060de..d9c67c38 100644
>> --- a/src/openvpn/tls_crypt.c
>> +++ b/src/openvpn/tls_crypt.c
>> @@ -29,7 +29,6 @@
>>=20=20
>>  #include "syshead.h"
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>>  #include "crypto.h"
>>  #include "session_id.h"
>>=20=20
>> @@ -265,5 +264,3 @@ error_exit:
>>      gc_free(&gc);
>>      return false;
>>  }
>> -
>> -#endif /* EMABLE_CRYPTO */
>> diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
>> index 4071ac94..e8080df9 100644
>> --- a/src/openvpn/tls_crypt.h
>> +++ b/src/openvpn/tls_crypt.h
>> @@ -74,8 +74,6 @@
>>  #ifndef TLSCRYPT_H
>>  #define TLSCRYPT_H
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "buffer.h"
>>  #include "crypto.h"
>>  #include "session_id.h"
>> @@ -142,6 +140,4 @@ bool tls_crypt_unwrap(const struct buffer *src, stru=
ct buffer *dst,
>>=20=20
>>  /** @} */
>>=20=20
>> -#endif /* ENABLE_CRYPTO */
>> -
>>  #endif /* TLSCRYPT_H */
>> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/ope=
nvpn/Makefile.am
>> index 7b44f42e..23d758b7 100644
>> --- a/tests/unit_tests/openvpn/Makefile.am
>> +++ b/tests/unit_tests/openvpn/Makefile.am
>> @@ -6,9 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
>>  check_PROGRAMS +=3D argv_testdriver buffer_testdriver
>>  endif
>>=20=20
>> -if ENABLE_CRYPTO
>>  check_PROGRAMS +=3D packet_id_testdriver tls_crypt_testdriver
>> -endif
>>=20=20
>>  TESTS =3D $(check_PROGRAMS)
>>=20=20
>> diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_test=
s/openvpn/test_tls_crypt.c
>> index 0a6a08fa..cf40e4b6 100644
>> --- a/tests/unit_tests/openvpn/test_tls_crypt.c
>> +++ b/tests/unit_tests/openvpn/test_tls_crypt.c
>> @@ -27,8 +27,6 @@
>>  #include "config-msvc.h"
>>  #endif
>>=20=20
>> -#ifdef ENABLE_CRYPTO
>> -
>>  #include "syshead.h"
>>=20=20
>>  #include <stdio.h>
>> @@ -268,5 +266,3 @@ main(void) {
>>=20=20
>>      return ret;
>>  }
>> -
>> -#endif /* ENABLE_CRYPTO */
>>
>=20
> Otherwise this looks good.  So, provided that the above accidental
> changes are removed:
>=20
> Acked-by: Steffan Karger <steffan@...1856...>
>=20

will send v3 with these fixed.

Cheers,


> -Steffan
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--jwXsHj215gOvaJ9Sh13fWwCdarJU30TqO--

--DTQA6W1BoLGp1apgXdD1SHEJpg2aGwoNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlokIxYACgkQB6U8WA7y
zXRWgxAAjuN9EiPkxIiG+Z+/NQquvRWR2GyQxuXEIbblHPSgYWpOotB1Pczr1RXR
xHTK2BwkX1u3ACYEXKHzkfEzETnNna2czEQ0eHah9WZfibMVGGPd0H+TCNV1PR9e
rrd/QrwjAPIcPEMuf1GvomM41iGP366ToZnJHTFa9CwwAbyl7luO8v7jXUOsgF3G
6el9EdqKJ32Rok1bRAed+Zlds9MZo9xVNz/X48FI6sVjRMq9uGig0CGGpRWbOObz
He6lRsMh8mhv7N15xoKoh2L5ND0Plb6IesTvsRVIJUc4ZUlKu3jPhSZ/3CgGpsF9
hx4RpernN9NkwSv2ahUxisMT5InQ8/+dlk0sryPhpAsGiYbzQN5NKp4EKS2faUXa
a8JOALmBjJVfg9FZGlm96Svn1qt3wXoFihAMmYJeDTKS8ODjSrnxLc8k9MyUzwQk
FPBCtG51RoA+CA4rgnf15MOHdBjc6D7DjFs2kffwGSjcY4l1CxeMEN0BrgQry467
SZaV6e8QW63HlWhB1eF1jjzj0dmBb2hoyp7Z6P8r8gYI7LWfrDIqRPJjJ5RyO4R9
TLxnL1xILsMOg6jKC50ucp8opE7Z9hGwAR5y6XKA8yEpO4QjlKfU2+CE+SlbeomV
RItBJqeEMxr/XkeUiQrEADEVv9E/J3yY32jR4XIR+68B3j3cufM=
=9HfZ
-----END PGP SIGNATURE-----

--DTQA6W1BoLGp1apgXdD1SHEJpg2aGwoNw--

