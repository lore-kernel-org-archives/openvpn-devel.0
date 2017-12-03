References: <20171202134541.7688-1-a@...2181...>
 <20171203124922.14220-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <07b23d8b-6421-c271-74b3-a00a0eeb4039@...1856...>
Date: Sun, 3 Dec 2017 15:12:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171203124922.14220-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] Remove ENABLE_CRYPTO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

Thanks for v2.  Some things went wrong with the s/CRYPTO_/ENABLE_CRYPTO/
though:

On 03-12-17 13:49, Antonio Quartulli wrote:
> The crypto engine cannot be disabled anymore, therefore get
> rid of all the related ifdefs in the code.
> 
> This change makes the code simpler and reduces our the
> number of config combinations we have to test after a new
> change is applied.
> 
> [re-enable unit-tests that were previously disabled]
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> v2:
> - rename CRYPTO_MBEDTLS/OPENSSL back to ENABLE_CRYPTO_MBEDTLS/OPENSSL
> - move to first patch in the set to avoid having a point in the tree where
>   encryption is disabled
> 
>  doc/doxygen/doc_data_crypto.h             | 12 +++---
>  include/openvpn-plugin.h.in               | 11 +-----
>  src/openvpn/crypto.c                      |  4 --
>  src/openvpn/crypto.h                      |  4 --
>  src/openvpn/crypto_mbedtls.c              |  4 +-
>  src/openvpn/crypto_mbedtls.h              |  6 +--
>  src/openvpn/crypto_openssl.c              |  4 +-
>  src/openvpn/crypto_openssl.h              |  6 +--
>  src/openvpn/forward-inline.h              |  6 ---
>  src/openvpn/forward.c                     | 15 --------
>  src/openvpn/init.c                        | 64 ++-----------------------------
>  src/openvpn/manage.c                      |  5 +--
>  src/openvpn/misc.c                        | 13 -------
>  src/openvpn/misc.h                        |  7 +---
>  src/openvpn/openvpn.h                     | 24 ------------
>  src/openvpn/options.c                     | 55 +++-----------------------
>  src/openvpn/options.h                     |  9 +----
>  src/openvpn/packet_id.c                   |  4 --
>  src/openvpn/packet_id.h                   |  3 --
>  src/openvpn/plugin.c                      | 23 +++--------
>  src/openvpn/plugin.h                      | 18 +++------
>  src/openvpn/reliable.c                    |  9 -----
>  src/openvpn/reliable.h                    |  3 --
>  src/openvpn/session_id.c                  |  9 -----
>  src/openvpn/session_id.h                  |  3 --
>  src/openvpn/ssl.c                         |  9 -----
>  src/openvpn/ssl.h                         |  4 --
>  src/openvpn/ssl_backend.h                 |  3 --
>  src/openvpn/ssl_mbedtls.c                 |  4 +-
>  src/openvpn/ssl_openssl.c                 |  4 +-
>  src/openvpn/ssl_verify.c                  |  4 --
>  src/openvpn/ssl_verify.h                  |  4 --
>  src/openvpn/ssl_verify_mbedtls.c          |  4 +-
>  src/openvpn/ssl_verify_openssl.c          |  4 +-
>  src/openvpn/syshead.h                     | 16 ++------
>  src/openvpn/tls_crypt.c                   |  3 --
>  src/openvpn/tls_crypt.h                   |  4 --
>  tests/unit_tests/openvpn/Makefile.am      |  2 -
>  tests/unit_tests/openvpn/test_tls_crypt.c |  4 --
>  39 files changed, 50 insertions(+), 340 deletions(-)
> 
> diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
> index c2b1866c..a8cf8d3b 100644
> --- a/doc/doxygen/doc_data_crypto.h
> +++ b/doc/doxygen/doc_data_crypto.h
> @@ -58,13 +58,11 @@
>   *     - \c openvpn_decrypt()
>   *
>   * @par Settings that control this module's activity
> - * Whether or not the Data Channel Crypto module is active depends on the
> - * compile-time \c ENABLE_CRYPTO preprocessor macro.  How it processes packets
> - * received from the \link data_control Data Channel Control module\endlink at
> - * runtime depends on the associated \c crypto_options structure.  To perform
> - * cryptographic operations, the \c crypto_options.key_ctx_bi must contain the
> - * correct cipher and HMAC security parameters for the direction the packet is
> - * traveling in.
> + * How the data channel processes packets received from the \link data_control
> + * Data Channel Control module\endlink at runtime depends on the associated
> + * \c crypto_options structure.  To perform cryptographic operations, the
> + * \c crypto_options.key_ctx_bi must contain the correct cipher and HMAC
> + * security parameters for the direction the packet is traveling in.
>   *
>   * @par Crypto algorithms
>   * This module uses the crypto algorithm implementations of the external
> diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
> index f29b3a0b..f43f74b1 100644
> --- a/include/openvpn-plugin.h.in
> +++ b/include/openvpn-plugin.h.in
> @@ -26,7 +26,6 @@
>  
>  #define OPENVPN_PLUGIN_VERSION 3
>  
> -#ifdef ENABLE_CRYPTO
>  #ifdef ENABLE_CRYPTO_MBEDTLS
>  #include <mbedtls/x509_crt.h>
>  #ifndef __OPENVPN_X509_CERT_T_DECLARED
> @@ -40,7 +39,6 @@ typedef mbedtls_x509_crt openvpn_x509_cert_t;
>  typedef X509 openvpn_x509_cert_t;
>  #endif
>  #endif
> -#endif
>  
>  #include <stdarg.h>
>  #include <stddef.h>
> @@ -391,9 +389,9 @@ struct openvpn_plugin_args_open_return
>   * *per_client_context : the per-client context pointer which was returned by
>   *        openvpn_plugin_client_constructor_v1, if defined.
>   *
> - * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with ENABLE_CRYPTO defined)
> + * current_cert_depth : Certificate depth of the certificate being passed over
>   *
> - * *current_cert : X509 Certificate object received from the client (only if compiled with ENABLE_CRYPTO defined)
> + * *current_cert : X509 Certificate object received from the client
>   *
>   */
>  struct openvpn_plugin_args_func_in
> @@ -403,13 +401,8 @@ struct openvpn_plugin_args_func_in
>      const char **const envp;
>      openvpn_plugin_handle_t handle;
>      void *per_client_context;
> -#ifdef ENABLE_CRYPTO
>      int current_cert_depth;
>      openvpn_x509_cert_t *current_cert;
> -#else
> -    int __current_cert_depth_disabled; /* Unused, for compatibility purposes only */
> -    void *__current_cert_disabled; /* Unused, for compatibility purposes only */
> -#endif
>  };
>  
>  
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 3f3caa1c..3096f3b0 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -30,8 +30,6 @@
>  
>  #include "syshead.h"
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "crypto.h"
>  #include "error.h"
>  #include "integer.h"
> @@ -1842,5 +1840,3 @@ translate_cipher_name_to_openvpn(const char *cipher_name)
>  
>      return pair->openvpn_name;
>  }
> -
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index 6d60ef8c..8e8ee8f5 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -122,8 +122,6 @@
>  #ifndef CRYPTO_H
>  #define CRYPTO_H
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "crypto_backend.h"
>  #include "basic.h"
>  #include "buffer.h"
> @@ -513,6 +511,4 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
>      return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cipher || key->decrypt.hmac;
>  }
>  
> -
> -#endif /* ENABLE_CRYPTO */
>  #endif /* CRYPTO_H */
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index f4d239bc..8fa03da5 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -34,7 +34,7 @@
>  
>  #include "syshead.h"
>  
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
> +#if defined(ENABLE_CRYPTO_MBEDTLS)
>  
>  #include "errlevel.h"
>  #include "basic.h"
> @@ -903,4 +903,4 @@ hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
>      ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
>  }
>  
> -#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_MBEDTLS */
> +#endif /* ENABLE_CRYPTO_MBEDTLS */
> diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
> index 4417b924..c3ec5695 100644
> --- a/src/openvpn/crypto_mbedtls.h
> +++ b/src/openvpn/crypto_mbedtls.h
> @@ -26,8 +26,8 @@
>   * @file Data Channel Cryptography mbed TLS-specific backend interface
>   */
>  
> -#ifndef CRYPTO_MBEDTLS_H_
> -#define CRYPTO_MBEDTLS_H_
> +#ifndef ENABLE_CRYPTO_MBEDTLS_H_
> +#define ENABLE_CRYPTO_MBEDTLS_H_

I think these are changed accidentally?

>  #include <mbedtls/cipher.h>
>  #include <mbedtls/md.h>
> @@ -147,4 +147,4 @@ mbed_log_func_line_lite(unsigned int flags, int errval,
>      mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
>  
>  
> -#endif /* CRYPTO_MBEDTLS_H_ */
> +#endif /* ENABLE_CRYPTO_MBEDTLS_H_ */

As above.

> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 0134e55d..20a519ec 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -34,7 +34,7 @@
>  
>  #include "syshead.h"
>  
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(ENABLE_CRYPTO_OPENSSL)
>  
>  #include "basic.h"
>  #include "buffer.h"
> @@ -969,4 +969,4 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
>      HMAC_Final(ctx, dst, &in_hmac_len);
>  }
>  
> -#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_OPENSSL */
> +#endif /* ENABLE_CRYPTO_OPENSSL */
> diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
> index 60a28123..8fad023a 100644
> --- a/src/openvpn/crypto_openssl.h
> +++ b/src/openvpn/crypto_openssl.h
> @@ -26,8 +26,8 @@
>   * @file Data Channel Cryptography OpenSSL-specific backend interface
>   */
>  
> -#ifndef CRYPTO_OPENSSL_H_
> -#define CRYPTO_OPENSSL_H_
> +#ifndef ENABLE_CRYPTO_OPENSSL_H_
> +#define ENABLE_CRYPTO_OPENSSL_H_

Same here,

>  #include <openssl/evp.h>
>  #include <openssl/hmac.h>
> @@ -102,4 +102,4 @@ void crypto_print_openssl_errors(const unsigned int flags);
>      } while (false)
>  
>  
> -#endif /* CRYPTO_OPENSSL_H_ */
> +#endif /* ENABLE_CRYPTO_OPENSSL_H_ */

and here.

> diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
> index ab83ea40..c977120e 100644
> --- a/src/openvpn/forward-inline.h
> +++ b/src/openvpn/forward-inline.h
> @@ -34,14 +34,12 @@
>  static inline void
>  check_tls(struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO)
>      void check_tls_dowork(struct context *c);
>  
>      if (c->c2.tls_multi)
>      {
>          check_tls_dowork(c);
>      }
> -#endif
>  }
>  
>  /*
> @@ -51,7 +49,6 @@ check_tls(struct context *c)
>  static inline void
>  check_tls_errors(struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO)
>      void check_tls_errors_co(struct context *c);
>  
>      void check_tls_errors_nco(struct context *c);
> @@ -73,7 +70,6 @@ check_tls_errors(struct context *c)
>              }
>          }
>      }
> -#endif /* if defined(ENABLE_CRYPTO) */
>  }
>  
>  /*
> @@ -220,7 +216,6 @@ check_push_request(struct context *c)
>  
>  #endif
>  
> -#ifdef ENABLE_CRYPTO
>  /*
>   * Should we persist our anti-replay packet ID state to disk?
>   */
> @@ -233,7 +228,6 @@ check_packet_id_persist_flush(struct context *c)
>          packet_id_persist_save(&c->c1.pid_persist);
>      }
>  }
> -#endif
>  
>  /*
>   * Set our wakeup to 0 seconds, so we will be rescheduled
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index a868a8ff..9bf9483e 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -87,7 +87,6 @@ show_wait_status(struct context *c)
>   * traffic on the control-channel.
>   *
>   */
> -#ifdef ENABLE_CRYPTO
>  void
>  check_tls_dowork(struct context *c)
>  {
> @@ -131,7 +130,6 @@ check_tls_errors_nco(struct context *c)
>  {
>      register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
>  }
> -#endif /* ENABLE_CRYPTO */
>  
>  #if P2MP
>  
> @@ -248,7 +246,6 @@ check_connection_established_dowork(struct context *c)
>  bool
>  send_control_channel_string(struct context *c, const char *str, int msglevel)
>  {
> -#ifdef ENABLE_CRYPTO
>      if (c->c2.tls_multi)
>      {
>          struct gc_arena gc = gc_new();
> @@ -274,7 +271,6 @@ send_control_channel_string(struct context *c, const char *str, int msglevel)
>          gc_free(&gc);
>          return stat;
>      }
> -#endif /* ENABLE_CRYPTO */
>      return true;
>  }
>  
> @@ -485,7 +481,6 @@ encrypt_sign(struct context *c, bool comp_frag)
>  #endif
>      }
>  
> -#ifdef ENABLE_CRYPTO
>      /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
>      ASSERT(buf_init(&b->encrypt_buf, FRAME_HEADROOM(&c->c2.frame)));
>  
> @@ -518,7 +513,6 @@ encrypt_sign(struct context *c, bool comp_frag)
>          }
>          tls_post_encrypt(c->c2.tls_multi, &c->c2.buf);
>      }
> -#endif /* ifdef ENABLE_CRYPTO */
>  
>      /*
>       * Get the address we will be sending the packet to.
> @@ -536,11 +530,9 @@ encrypt_sign(struct context *c, bool comp_frag)
>  static void
>  process_coarse_timers(struct context *c)
>  {
> -#ifdef ENABLE_CRYPTO
>      /* flush current packet-id to file once per 60
>       * seconds if --replay-persist was specified */
>      check_packet_id_persist_flush(c);
> -#endif
>  
>      /* should we update status file? */
>      check_status_file(c);
> @@ -852,7 +844,6 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
>              link_socket_bad_incoming_addr(&c->c2.buf, lsi, &c->c2.from);
>          }
>  
> -#ifdef ENABLE_CRYPTO
>          if (c->c2.tls_multi)
>          {
>              /*
> @@ -909,9 +900,6 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
>              register_signal(c, SIGUSR1, "decryption-error"); /* SOFT-SIGUSR1 -- decryption error in TCP mode */
>              msg(D_STREAM_ERRORS, "Fatal decryption error (process_incoming_link), restarting");
>          }
> -#else /* ENABLE_CRYPTO */
> -        decrypt_status = true;
> -#endif /* ENABLE_CRYPTO */
>      }
>      else
>      {
> @@ -1426,8 +1414,6 @@ process_outgoing_link(struct context *c)
>              register_activity(c, size);
>          }
>  
> -
> -#ifdef ENABLE_CRYPTO
>          /* for unreachable network and "connecting" state switch to the next host */
>          if (size < 0 && ENETUNREACH == error_code && c->c2.tls_multi
>              && !tls_initial_packet_received(c->c2.tls_multi) && c->options.mode == MODE_POINT_TO_POINT)
> @@ -1435,7 +1421,6 @@ process_outgoing_link(struct context *c)
>              msg(M_INFO, "Network unreachable, restarting");
>              register_signal(c, SIGUSR1, "network-unreachable");
>          }
> -#endif
>      }
>      else
>      {
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 408daf13..f90b6ffe 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -529,13 +529,11 @@ next_connection_entry(struct context *c)
>  void
>  init_query_passwords(const struct context *c)
>  {
> -#ifdef ENABLE_CRYPTO
>      /* Certificate password input */
>      if (c->options.key_pass_file)
>      {
>          pem_password_setup(c->options.key_pass_file);
>      }
> -#endif
>  
>  #if P2MP
>      /* Auth user/pass input */
> @@ -704,7 +702,7 @@ init_static(void)
>  {
>      /* configure_path (); */
>  
> -#if defined(ENABLE_CRYPTO) && defined(DMALLOC)
> +#if defined(DMALLOC)
>      crypto_init_dmalloc();
>  #endif
>  
> @@ -741,14 +739,12 @@ init_static(void)
>  
>      update_time();
>  
> -#ifdef ENABLE_CRYPTO
>      init_ssl_lib();
>  
>      /* init PRNG used for IV generation */
>      /* When forking, copy this to more places in the code to avoid fork
>       * random-state predictability */
>      prng_init(NULL, 0);
> -#endif
>  
>  #ifdef PID_TEST
>      packet_id_interactive_test();       /* test the sequence number code */
> @@ -942,9 +938,7 @@ init_static(void)
>  void
>  uninit_static(void)
>  {
> -#ifdef ENABLE_CRYPTO
>      free_ssl_lib();
> -#endif
>  
>  #ifdef ENABLE_PKCS11
>      pkcs11_terminate();
> @@ -954,7 +948,7 @@ uninit_static(void)
>      close_port_share();
>  #endif
>  
> -#if defined(MEASURE_TLS_HANDSHAKE_STATS) && defined(ENABLE_CRYPTO)
> +#if defined(MEASURE_TLS_HANDSHAKE_STATS)
>      show_tls_performance_stats();
>  #endif
>  }
> @@ -998,7 +992,6 @@ print_openssl_info(const struct options *options)
>      /*
>       * OpenSSL info print mode?
>       */
> -#ifdef ENABLE_CRYPTO
>      if (options->show_ciphers || options->show_digests || options->show_engines
>          || options->show_tls_ciphers || options->show_curves)
>      {
> @@ -1025,7 +1018,6 @@ print_openssl_info(const struct options *options)
>          }
>          return true;
>      }
> -#endif /* ifdef ENABLE_CRYPTO */
>      return false;
>  }
>  
> @@ -1035,7 +1027,6 @@ print_openssl_info(const struct options *options)
>  bool
>  do_genkey(const struct options *options)
>  {
> -#ifdef ENABLE_CRYPTO
>      if (options->genkey)
>      {
>          int nbits_written;
> @@ -1055,7 +1046,6 @@ do_genkey(const struct options *options)
>              options->shared_secret_file);
>          return true;
>      }
> -#endif
>      return false;
>  }
>  
> @@ -1071,10 +1061,8 @@ do_persist_tuntap(const struct options *options)
>          notnull(options->dev, "TUN/TAP device (--dev)");
>          if (options->ce.remote || options->ifconfig_local
>              || options->ifconfig_remote_netmask
> -#ifdef ENABLE_CRYPTO
>              || options->shared_secret_file
>              || options->tls_server || options->tls_client
> -#endif
>              )
>          {
>              msg(M_FATAL|M_OPTERR,
> @@ -1226,12 +1214,10 @@ const char *
>  format_common_name(struct context *c, struct gc_arena *gc)
>  {
>      struct buffer out = alloc_buf_gc(256, gc);
> -#ifdef ENABLE_CRYPTO
>      if (c->c2.tls_multi)
>      {
>          buf_printf(&out, "[%s] ", tls_common_name(c->c2.tls_multi, false));
>      }
> -#endif
>      return BSTR(&out);
>  }
>  
> @@ -1333,7 +1319,6 @@ do_init_timers(struct context *c, bool deferred)
>  #endif
>  
>          /* initialize packet_id persistence timer */
> -#ifdef ENABLE_CRYPTO
>          if (c->options.packet_id_file)
>          {
>              event_timeout_init(&c->c2.packet_id_persist_interval, 60, now);
> @@ -1342,7 +1327,6 @@ do_init_timers(struct context *c, bool deferred)
>          /* initialize tmp_int optimization that limits the number of times we call
>           * tls_multi_process in the main event loop */
>          interval_init(&c->c2.tmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);
> -#endif
>      }
>  }
>  
> @@ -1485,7 +1469,6 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
>      do_uid_gid_chroot(c, true);
>  
>  
> -#ifdef ENABLE_CRYPTO
>      /*
>       * In some cases (i.e. when receiving auth-token via
>       * push-reply) the auth-nocache option configured on the
> @@ -1497,7 +1480,6 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
>      {
>          delayed_auth_pass_purge();
>      }
> -#endif /* ENABLE_CRYPTO */
>  
>      /* Test if errors */
>      if (flags & ISC_ERRORS)
> @@ -2136,12 +2118,10 @@ pull_permission_mask(const struct context *c)
>          flags |= (OPT_P_ROUTE | OPT_P_IPWIN32);
>      }
>  
> -#ifdef ENABLE_CRYPTO
>      if (c->options.ncp_enabled)
>      {
>          flags |= OPT_P_NCP;
>      }
> -#endif
>  
>      return flags;
>  }
> @@ -2230,7 +2210,6 @@ do_deferred_options(struct context *c, const unsigned int found)
>          msg(D_PUSH, "OPTIONS IMPORT: environment modified");
>      }
>  
> -#ifdef ENABLE_CRYPTO
>      if (found & OPT_P_PEER_ID)
>      {
>          msg(D_PUSH, "OPTIONS IMPORT: peer-id set");
> @@ -2271,7 +2250,7 @@ do_deferred_options(struct context *c, const unsigned int found)
>              return false;
>          }
>      }
> -#endif /* ifdef ENABLE_CRYPTO */
> +
>      return true;
>  }
>  
> @@ -2423,19 +2402,15 @@ frame_finalize_options(struct context *c, const struct options *o)
>  static void
>  key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
>  {
> -#ifdef ENABLE_CRYPTO
>      free_key_ctx_bi(&ks->static_key);
>      if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
>      {
>          tls_ctx_free(&ks->ssl_ctx);
>          free_key_ctx_bi(&ks->tls_wrap_key);
>      }
> -#endif /* ENABLE_CRYPTO */
>      CLEAR(*ks);
>  }
>  
> -#ifdef ENABLE_CRYPTO
> -
>  static void
>  init_crypto_pre(struct context *c, const unsigned int flags)
>  {
> @@ -2880,12 +2855,10 @@ do_init_crypto_none(const struct context *c)
>          "protected against man-in-the-middle changes. "
>          "PLEASE DO RECONSIDER THIS CONFIGURATION!");
>  }
> -#endif /* ifdef ENABLE_CRYPTO */
>  
>  static void
>  do_init_crypto(struct context *c, const unsigned int flags)
>  {
> -#ifdef ENABLE_CRYPTO
>      if (c->options.shared_secret_file)
>      {
>          do_init_crypto_static(c, flags);
> @@ -2898,11 +2871,6 @@ do_init_crypto(struct context *c, const unsigned int flags)
>      {
>          do_init_crypto_none(c);
>      }
> -#else /* ENABLE_CRYPTO */
> -    msg(M_WARN,
> -        "******* WARNING *******: " PACKAGE_NAME
> -        " built without crypto library -- encryption and authentication features disabled -- all data will be tunnelled as cleartext");
> -#endif /* ENABLE_CRYPTO */
>  }
>  
>  static void
> @@ -3101,7 +3069,6 @@ do_option_warnings(struct context *c)
>  #endif /* if P2MP_SERVER */
>  #endif /* if P2MP */
>  
> -#ifdef ENABLE_CRYPTO
>      if (!o->replay)
>      {
>          msg(M_WARN, "WARNING: You have disabled Replay Protection (--no-replay) which may make " PACKAGE_NAME " less secure");
> @@ -3123,7 +3090,6 @@ do_option_warnings(struct context *c)
>      {
>          msg(M_WARN, "WARNING: --ns-cert-type is DEPRECATED.  Use --remote-cert-tls instead.");
>      }
> -#endif /* ifdef ENABLE_CRYPTO */
>  
>      /* If a script is used, print appropiate warnings */
>      if (o->user_script_used)
> @@ -3146,9 +3112,7 @@ do_option_warnings(struct context *c)
>  static void
>  do_init_frame_tls(struct context *c)
>  {
> -#ifdef ENABLE_CRYPTO
>      do_init_finalize_tls_frame(c);
> -#endif
>  }
>  
>  struct context_buffers *
> @@ -3163,10 +3127,8 @@ init_context_buffers(const struct frame *frame)
>  
>      b->aux_buf = alloc_buf(BUF_SIZE(frame));
>  
> -#ifdef ENABLE_CRYPTO
>      b->encrypt_buf = alloc_buf(BUF_SIZE(frame));
>      b->decrypt_buf = alloc_buf(BUF_SIZE(frame));
> -#endif
>  
>  #ifdef USE_COMP
>      b->compress_buf = alloc_buf(BUF_SIZE(frame));
> @@ -3190,10 +3152,8 @@ free_context_buffers(struct context_buffers *b)
>          free_buf(&b->decompress_buf);
>  #endif
>  
> -#ifdef ENABLE_CRYPTO
>          free_buf(&b->encrypt_buf);
>          free_buf(&b->decrypt_buf);
> -#endif
>  
>          free(b);
>      }
> @@ -3329,14 +3289,12 @@ do_compute_occ_strings(struct context *c)
>          options_string_version(c->c2.options_string_remote, &gc),
>          c->c2.options_string_remote);
>  
> -#ifdef ENABLE_CRYPTO
>      if (c->c2.tls_multi)
>      {
>          tls_multi_init_set_options(c->c2.tls_multi,
>                                     c->c2.options_string_local,
>                                     c->c2.options_string_remote);
>      }
> -#endif
>  
>      gc_free(&gc);
>  }
> @@ -3410,7 +3368,6 @@ do_close_free_buf(struct context *c)
>  static void
>  do_close_tls(struct context *c)
>  {
> -#ifdef ENABLE_CRYPTO
>      if (c->c2.tls_multi)
>      {
>          tls_multi_free(c->c2.tls_multi, true);
> @@ -3429,7 +3386,6 @@ do_close_tls(struct context *c)
>      }
>      c->c2.options_string_local = c->c2.options_string_remote = NULL;
>  #endif
> -#endif
>  }
>  
>  /*
> @@ -3494,14 +3450,12 @@ do_close_link_socket(struct context *c)
>  static void
>  do_close_packet_id(struct context *c)
>  {
> -#ifdef ENABLE_CRYPTO
>      packet_id_free(&c->c2.crypto_options.packet_id);
>      packet_id_persist_save(&c->c1.pid_persist);
>      if (!(c->sig->signal_received == SIGUSR1))
>      {
>          packet_id_persist_close(&c->c1.pid_persist);
>      }
> -#endif
>  }
>  
>  #ifdef ENABLE_FRAGMENT
> @@ -3680,7 +3634,6 @@ do_setup_fast_io(struct context *c)
>  static void
>  do_signal_on_tls_errors(struct context *c)
>  {
> -#ifdef ENABLE_CRYPTO
>      if (c->options.tls_exit)
>      {
>          c->c2.tls_exit_signal = SIGTERM;
> @@ -3689,7 +3642,6 @@ do_signal_on_tls_errors(struct context *c)
>      {
>          c->c2.tls_exit_signal = SIGUSR1;
>      }
> -#endif
>  }
>  
>  #ifdef ENABLE_PLUGIN
> @@ -4369,7 +4321,6 @@ inherit_context_child(struct context *dest,
>      /* c1 init */
>      packet_id_persist_init(&dest->c1.pid_persist);
>  
> -#ifdef ENABLE_CRYPTO
>      dest->c1.ks.key_type = src->c1.ks.key_type;
>      /* inherit SSL context */
>      dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
> @@ -4379,7 +4330,6 @@ inherit_context_child(struct context *dest,
>      dest->c1.ciphername = src->c1.ciphername;
>      dest->c1.authname = src->c1.authname;
>      dest->c1.keysize = src->c1.keysize;
> -#endif
>  
>      /* options */
>      dest->options = src->options;
> @@ -4453,9 +4403,7 @@ inherit_context_top(struct context *dest,
>      /* detach plugins */
>      dest->plugins_owned = false;
>  
> -#ifdef ENABLE_CRYPTO
>      dest->c2.tls_multi = NULL;
> -#endif
>  
>      /* detach c1 ownership */
>      dest->c1.tuntap_owned = false;
> @@ -4513,8 +4461,6 @@ close_context(struct context *c, int sig, unsigned int flags)
>      }
>  }
>  
> -#ifdef ENABLE_CRYPTO
> -
>  /*
>   * Do a loopback test
>   * on the crypto subsystem.
> @@ -4542,12 +4488,9 @@ test_crypto_thread(void *arg)
>      return NULL;
>  }
>  
> -#endif /* ENABLE_CRYPTO */
> -
>  bool
>  do_test_crypto(const struct options *o)
>  {
> -#ifdef ENABLE_CRYPTO
>      if (o->test_crypto)
>      {
>          struct context c;
> @@ -4562,6 +4505,5 @@ do_test_crypto(const struct options *o)
>          test_crypto_thread((void *) &c);
>          return true;
>      }
> -#endif
>      return false;
>  }
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 88121a38..55b106cd 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -762,10 +762,8 @@ man_query_need_str(struct management *man, const char *type, const char *action)
>  static void
>  man_forget_passwords(struct management *man)
>  {
> -#ifdef ENABLE_CRYPTO
>      ssl_purge_auth(false);
>      msg(M_CLIENT, "SUCCESS: Passwords were forgotten");
> -#endif
>  }
>  
>  static void
> @@ -1918,12 +1916,11 @@ man_reset_client_socket(struct management *man, const bool exiting)
>      }
>      if (!exiting)
>      {
> -#ifdef ENABLE_CRYPTO
>          if (man->settings.flags & MF_FORGET_DISCONNECT)
>          {
>              ssl_purge_auth(false);
>          }
> -#endif
> +
>          if (man->settings.flags & MF_SIGNAL)
>          {
>              int mysig = man_mod_signal(man, SIGUSR1);
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 6d53cbfb..76b592f8 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -770,8 +770,6 @@ create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
>      return NULL;
>  }
>  
> -#ifdef ENABLE_CRYPTO
> -
>  /*
>   * Prepend a random string to hostname to prevent DNS caching.
>   * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
> @@ -793,17 +791,6 @@ hostname_randomize(const char *hostname, struct gc_arena *gc)
>  #undef n_rnd_bytes
>  }
>  
> -#else  /* ifdef ENABLE_CRYPTO */
> -
> -const char *
> -hostname_randomize(const char *hostname, struct gc_arena *gc)
> -{
> -    msg(M_WARN, "WARNING: hostname randomization disabled when crypto support is not compiled");
> -    return hostname;
> -}
> -
> -#endif /* ifdef ENABLE_CRYPTO */
> -
>  /*
>   * Put a directory and filename together.
>   */
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index f6c810a2..ec20ee7e 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -143,13 +143,8 @@ const char **make_arg_array(const char *first, const char *parms, struct gc_aren
>  const char **make_extended_arg_array(char **p, struct gc_arena *gc);
>  
>  /* an analogue to the random() function, but use OpenSSL functions if available */
> -#ifdef ENABLE_CRYPTO
>  long int get_random(void);
>  
> -#else
> -#define get_random random
> -#endif
> -
>  /* return true if filename can be opened for read */
>  bool test_file(const char *filename);
>  
> @@ -162,7 +157,7 @@ const char *gen_path(const char *directory, const char *filename, struct gc_aren
>  /* return true if pathname is absolute */
>  bool absolute_pathname(const char *pathname);
>  
> -/* prepend a random prefix to hostname (need ENABLE_CRYPTO) */
> +/* prepend a random prefix to hostname */
>  const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
>  
>  /*
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 9262e68b..fb8ff1a4 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -54,7 +54,6 @@
>  
>  struct key_schedule
>  {
> -#ifdef ENABLE_CRYPTO
>      /* which cipher, HMAC digest, and key sizes are we using? */
>      struct key_type key_type;
>  
> @@ -67,9 +66,6 @@ struct key_schedule
>      /* optional TLS control channel wrapping */
>      struct key_type tls_auth_key_type;
>      struct key_ctx_bi tls_wrap_key;
> -#else                           /* ENABLE_CRYPTO */
> -    int dummy;
> -#endif                          /* ENABLE_CRYPTO */
>  };
>  
>  /*
> @@ -96,10 +92,8 @@ struct context_buffers
>      struct buffer aux_buf;
>  
>      /* workspace buffers used by crypto routines */
> -#ifdef ENABLE_CRYPTO
>      struct buffer encrypt_buf;
>      struct buffer decrypt_buf;
> -#endif
>  
>      /* workspace buffers for compression */
>  #ifdef USE_COMP
> @@ -334,8 +328,6 @@ struct context_2
>      int occ_mtu_load_n_tries;
>  #endif
>  
> -#ifdef ENABLE_CRYPTO
> -
>      /*
>       * TLS-mode crypto objects.
>       */
> @@ -367,8 +359,6 @@ struct context_2
>  
>      struct event_timeout packet_id_persist_interval;
>  
> -#endif /* ENABLE_CRYPTO */
> -
>  #ifdef USE_COMP
>      struct compress_context *comp_context;
>      /**< Compression context used by the
> @@ -566,7 +556,6 @@ struct context
>   * have been compiled in.
>   */
>  
> -#ifdef ENABLE_CRYPTO
>  #define TLS_MODE(c) ((c)->c2.tls_multi != NULL)
>  #define PROTO_DUMP_FLAGS (check_debug_level(D_LINK_RW_VERBOSE) ? (PD_SHOW_DATA|PD_VERBOSE) : 0)
>  #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
> @@ -574,22 +563,9 @@ struct context
>                                            |(c->c2.tls_multi ? PD_TLS : 0)   \
>                                            |(c->options.tls_auth_file ? c->c1.ks.key_type.hmac_length : 0), \
>                                            gc)
> -#else  /* ifdef ENABLE_CRYPTO */
> -#define TLS_MODE(c) (false)
> -#define PROTO_DUMP(buf, gc) format_hex(BPTR(buf), BLEN(buf), 80, gc)
> -#endif
> -
> -#ifdef ENABLE_CRYPTO
>  #define MD5SUM(buf, len, gc) md5sum((buf), (len), 0, (gc))
> -#else
> -#define MD5SUM(buf, len, gc) "[unavailable]"
> -#endif
>  
> -#ifdef ENABLE_CRYPTO
>  #define CIPHER_ENABLED(c) (c->c1.ks.key_type.cipher != NULL)
> -#else
> -#define CIPHER_ENABLED(c) (false)
> -#endif
>  
>  /* this represents "disabled peer-id" */
>  #define MAX_PEER_ID 0xFFFFFF
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8e5cdf7f..d8853f58 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -67,7 +67,6 @@ const char title_string[] =
>      " [git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_FLAGS "]"
>  #endif
>      " " TARGET_ALIAS
> -#ifdef ENABLE_CRYPTO
>  #if defined(ENABLE_CRYPTO_MBEDTLS)
>      " [SSL (mbed TLS)]"
>  #elif defined(ENABLE_CRYPTO_OPENSSL)
> @@ -75,7 +74,6 @@ const char title_string[] =
>  #else
>      " [SSL]"
>  #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
> -#endif /* ENABLE_CRYPTO */
>  #ifdef USE_COMP
>  #ifdef ENABLE_LZO
>      " [LZO]"
> @@ -518,7 +516,6 @@ static const char usage_message[] =
>      "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
>      "                  server/remote. n = # of retries, default=1.\n"
>  #endif
> -#ifdef ENABLE_CRYPTO
>      "\n"
>      "Data Channel Encryption Options (must be compatible between peers):\n"
>      "(These options are meaningful for both Static Key & TLS-mode)\n"
> @@ -748,7 +745,6 @@ static const char usage_message[] =
>      "--genkey        : Generate a random key to be used as a shared secret,\n"
>      "                  for use with the --secret option.\n"
>      "--secret file   : Write key to file.\n"
> -#endif                          /* ENABLE_CRYPTO */
>  #ifdef ENABLE_FEATURE_TUN_PERSIST
>      "\n"
>      "Tun/tap config mode (available with linux 2.4+):\n"
> @@ -852,7 +848,6 @@ init_options(struct options *o, const bool init_gc)
>  #if P2MP
>      o->scheduled_exit_interval = 5;
>  #endif
> -#ifdef ENABLE_CRYPTO
>      o->ciphername = "BF-CBC";
>  #ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=2 requires GCM support */
>      o->ncp_enabled = true;
> @@ -882,7 +877,6 @@ init_options(struct options *o, const bool init_gc)
>  #ifdef ENABLE_X509ALTUSERNAME
>      o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>  #endif
> -#endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_PKCS11
>      o->pkcs11_pin_cache_period = -1;
>  #endif                  /* ENABLE_PKCS11 */
> @@ -1146,7 +1140,6 @@ string_substitute(const char *src, int from, int to, struct gc_arena *gc)
>      return ret;
>  }
>  
> -#ifdef ENABLE_CRYPTO
>  static uint8_t *
>  parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
>  {
> @@ -1188,7 +1181,6 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
>      }
>      return ret;
>  }
> -#endif /* ifdef ENABLE_CRYPTO */
>  
>  #ifdef _WIN32
>  
> @@ -1560,14 +1552,12 @@ show_settings(const struct options *o)
>      SHOW_INT(persist_mode);
>  #endif
>  
> -#ifdef ENABLE_CRYPTO
>      SHOW_BOOL(show_ciphers);
>      SHOW_BOOL(show_digests);
>      SHOW_BOOL(show_engines);
>      SHOW_BOOL(genkey);
>      SHOW_STR(key_pass_file);
>      SHOW_BOOL(show_tls_ciphers);
> -#endif
>  
>      SHOW_INT(connect_retry_max);
>      show_connection_entries(o);
> @@ -1702,7 +1692,6 @@ show_settings(const struct options *o)
>      }
>  #endif
>  
> -#ifdef ENABLE_CRYPTO
>      SHOW_STR(shared_secret_file);
>      SHOW_INT(key_direction);
>      SHOW_STR(ciphername);
> @@ -1790,7 +1779,6 @@ show_settings(const struct options *o)
>  
>      SHOW_STR(tls_auth_file);
>      SHOW_STR(tls_crypt_file);
> -#endif /* ENABLE_CRYPTO */
>  
>  #ifdef ENABLE_PKCS11
>      {
> @@ -2024,14 +2012,14 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>  
>      init_options(&defaults, true);
>  
> -#ifdef ENABLE_CRYPTO
>      if (options->test_crypto)
>      {
>          notnull(options->shared_secret_file, "key file (--secret)");
>      }
>      else
> -#endif
> -    notnull(options->dev, "TUN/TAP device (--dev)");
> +    {
> +        notnull(options->dev, "TUN/TAP device (--dev)");
> +    }
>  
>      /*
>       * Get tun/tap/null device type
> @@ -2072,10 +2060,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>      }
>  
>      if (options->inetd == INETD_NOWAIT
> -#ifdef ENABLE_CRYPTO
> -        && !(options->tls_server || options->tls_client)
> -#endif
> -        )
> +        && !(options->tls_server || options->tls_client))
>      {
>          msg(M_USAGE, "--inetd nowait can only be used in TLS mode");
>      }
> @@ -2485,8 +2470,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>      }
>  #endif /* P2MP_SERVER */
>  
> -#ifdef ENABLE_CRYPTO
> -
>      if (options->ncp_enabled && !tls_check_ncp_cipher_list(options->ncp_ciphers))
>      {
>          msg(M_USAGE, "NCP cipher list contains unsupported ciphers.");
> @@ -2771,7 +2754,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>          }
>      }
>  #undef MUST_BE_UNDEF
> -#endif /* ENABLE_CRYPTO */
>  
>  #if P2MP
>      if (options->auth_user_pass_file && !options->pull)
> @@ -3009,7 +2991,6 @@ options_postprocess_mutate(struct options *o)
>          options_postprocess_mutate_ce(o, o->connection_list->array[i]);
>      }
>  
> -#ifdef ENABLE_CRYPTO
>      if (o->tls_server)
>      {
>          /* Check that DH file is specified, or explicitly disabled */
> @@ -3035,7 +3016,6 @@ options_postprocess_mutate(struct options *o)
>               "in P2MP client or server mode" );
>          o->ncp_enabled = false;
>      }
> -#endif
>  
>  #if ENABLE_MANAGEMENT
>      if (o->http_proxy_override)
> @@ -3267,7 +3247,6 @@ options_postprocess_filechecks(struct options *options)
>  {
>      bool errs = false;
>  
> -#ifdef ENABLE_CRYPTO
>      /* ** SSL/TLS/crypto related files ** */
>      errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
>      errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
> @@ -3308,7 +3287,6 @@ options_postprocess_filechecks(struct options *options)
>      /* ** Password files ** */
>      errs |= check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
>                                options->key_pass_file, R_OK, "--askpass");
> -#endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_MANAGEMENT
>      errs |= check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
>                                options->management_user_pass, R_OK,
> @@ -3331,10 +3309,8 @@ options_postprocess_filechecks(struct options *options)
>                                R_OK|W_OK, "--status");
>  
>      /* ** Config related ** */
> -#ifdef ENABLE_CRYPTO
>      errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tls_export_cert,
>                                       R_OK|W_OK|X_OK, "--tls-export-cert");
> -#endif /* ENABLE_CRYPTO */
>  #if P2MP_SERVER
>      errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
>                                       R_OK|X_OK, "--client-config-dir");
> @@ -3462,7 +3438,7 @@ static size_t
>  calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
>  {
>      size_t link_mtu = EXPANDED_SIZE(frame);
> -#ifdef ENABLE_CRYPTO
> +
>      if (o->pull || o->mode == MODE_SERVER)
>      {
>          struct frame fake_frame = *frame;
> @@ -3478,7 +3454,6 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
>              EXPANDED_SIZE(&fake_frame));
>          link_mtu = EXPANDED_SIZE(&fake_frame);
>      }
> -#endif
>      return link_mtu;
>  }
>  
> @@ -3606,8 +3581,6 @@ options_string(const struct options *o,
>      }
>  #endif
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #define TLS_CLIENT (o->tls_client)
>  #define TLS_SERVER (o->tls_server)
>  
> @@ -3705,8 +3678,6 @@ options_string(const struct options *o,
>  #undef TLS_CLIENT
>  #undef TLS_SERVER
>  
> -#endif /* ENABLE_CRYPTO */
> -
>      return BSTR(&out);
>  }
>  
> @@ -4084,7 +4055,6 @@ usage(void)
>      struct options o;
>      init_options(&o, true);
>  
> -#ifdef ENABLE_CRYPTO
>      fprintf(fp, usage_message,
>              title_string,
>              o.ce.connect_retry_seconds,
> @@ -4096,15 +4066,6 @@ usage(void)
>              o.replay_window, o.replay_time,
>              o.tls_timeout, o.renegotiate_seconds,
>              o.handshake_window, o.transition_window);
> -#else  /* ifdef ENABLE_CRYPTO */
> -    fprintf(fp, usage_message,
> -            title_string,
> -            o.ce.connect_retry_seconds,
> -            o.ce.connect_retry_seconds_max,
> -            o.ce.local_port, o.ce.remote_port,
> -            TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
> -            o.verbosity);
> -#endif
>      fflush(fp);
>  
>  #endif /* ENABLE_SMALL */
> @@ -4132,11 +4093,7 @@ show_windows_version(const unsigned int flags)
>  void
>  show_library_versions(const unsigned int flags)
>  {
> -#ifdef ENABLE_CRYPTO
>  #define SSL_LIB_VER_STR get_ssl_library_version()
> -#else
> -#define SSL_LIB_VER_STR ""
> -#endif
>  #ifdef ENABLE_LZO
>  #define LZO_LIB_VER_STR ", LZO ", lzo_version_string()
>  #else
> @@ -7441,7 +7398,6 @@ add_option(struct options *options,
>          }
>      }
>  #endif /* USE_COMP */
> -#ifdef ENABLE_CRYPTO
>      else if (streq(p[0], "show-ciphers") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> @@ -8124,7 +8080,6 @@ add_option(struct options *options,
>          options->x509_username_field = p[1];
>      }
>  #endif /* ENABLE_X509ALTUSERNAME */
> -#endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_PKCS11
>      else if (streq(p[0], "show-pkcs11-ids") && !p[3])
>      {
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 035c6d15..08e53f85 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -41,9 +41,7 @@
>  #include "comp.h"
>  #include "pushlist.h"
>  #include "clinat.h"
> -#ifdef ENABLE_CRYPTO
>  #include "crypto_backend.h"
> -#endif
>  
>  
>  /*
> @@ -81,7 +79,7 @@ struct options_pre_pull
>  };
>  
>  #endif
> -#if defined(ENABLE_CRYPTO) && !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
> +#if !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
>  #error "At least one of OpenSSL or mbed TLS needs to be defined."
>  #endif
>  
> @@ -188,7 +186,6 @@ struct options
>      bool persist_config;
>      int persist_mode;
>  
> -#ifdef ENABLE_CRYPTO
>      const char *key_pass_file;
>      bool show_ciphers;
>      bool show_digests;
> @@ -196,7 +193,6 @@ struct options
>      bool show_tls_ciphers;
>      bool show_curves;
>      bool genkey;
> -#endif
>  
>      /* Networking parms */
>      int connect_retry_max;
> @@ -468,7 +464,6 @@ struct options
>  #endif
>  #endif /* if P2MP */
>  
> -#ifdef ENABLE_CRYPTO
>      /* Cipher parms */
>      const char *shared_secret_file;
>      const char *shared_secret_file_inline;
> @@ -580,8 +575,6 @@ struct options
>  
>      bool tls_exit;
>  
> -#endif /* ENABLE_CRYPTO */
> -
>      const struct x509_track *x509_track;
>  
>      /* special state parms */
> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
> index 4e0e9868..4c3696de 100644
> --- a/src/openvpn/packet_id.c
> +++ b/src/openvpn/packet_id.c
> @@ -38,8 +38,6 @@
>  
>  #include "syshead.h"
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "packet_id.h"
>  #include "misc.h"
>  #include "integer.h"
> @@ -695,5 +693,3 @@ packet_id_interactive_test(void)
>      packet_id_free(&pid);
>  }
>  #endif /* ifdef PID_TEST */
> -
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
> index 8509e590..cde76483 100644
> --- a/src/openvpn/packet_id.h
> +++ b/src/openvpn/packet_id.h
> @@ -27,8 +27,6 @@
>   * attempts to replay them back later.
>   */
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #ifndef PACKET_ID_H
>  #define PACKET_ID_H
>  
> @@ -342,4 +340,3 @@ packet_id_reap_test(struct packet_id_rec *p)
>  }
>  
>  #endif /* PACKET_ID_H */
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 557b6bc7..7387f8be 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -517,11 +517,9 @@ plugin_call_item(const struct plugin *p,
>                   const int type,
>                   const struct argv *av,
>                   struct openvpn_plugin_string_list **retlist,
> -                 const char **envp
> -#ifdef ENABLE_CRYPTO
> -                 , int certdepth,
> +                 const char **envp,
> +                 int certdepth,
>                   openvpn_x509_cert_t *current_cert
> -#endif
>                   )
>  {
>      int status = OPENVPN_PLUGIN_FUNC_SUCCESS;
> @@ -550,13 +548,8 @@ plugin_call_item(const struct plugin *p,
>                                                          (const char **const) envp,
>                                                          p->plugin_handle,
>                                                          per_client_context,
> -#ifdef ENABLE_CRYPTO
>                                                          (current_cert ? certdepth : -1),
>                                                          current_cert
> -#else
> -                                                        -1,
> -                                                        NULL
> -#endif
>              };
>  
>              struct openvpn_plugin_args_func_return retargs;
> @@ -786,11 +779,9 @@ plugin_call_ssl(const struct plugin_list *pl,
>                  const int type,
>                  const struct argv *av,
>                  struct plugin_return *pr,
> -                struct env_set *es
> -#ifdef ENABLE_CRYPTO
> -                , int certdepth,
> +                struct env_set *es,
> +                int certdepth,
>                  openvpn_x509_cert_t *current_cert
> -#endif
>                  )
>  {
>      if (pr)
> @@ -818,11 +809,9 @@ plugin_call_ssl(const struct plugin_list *pl,
>                                                  type,
>                                                  av,
>                                                  pr ? &pr->list[i] : NULL,
> -                                                envp
> -#ifdef ENABLE_CRYPTO
> -                                                ,certdepth,
> +                                                envp,
> +                                                certdepth,
>                                                  current_cert
> -#endif
>                                                  );
>              switch (status)
>              {
> diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
> index 0cffee0f..c9bf03bc 100644
> --- a/src/openvpn/plugin.h
> +++ b/src/openvpn/plugin.h
> @@ -127,11 +127,9 @@ int plugin_call_ssl(const struct plugin_list *pl,
>                      const int type,
>                      const struct argv *av,
>                      struct plugin_return *pr,
> -                    struct env_set *es
> -#ifdef ENABLE_CRYPTO
> -                    , int current_cert_depth,
> +                    struct env_set *es,
> +                    int current_cert_depth,
>                      openvpn_x509_cert_t *current_cert
> -#endif
>                      );
>  
>  void plugin_list_close(struct plugin_list *pl);
> @@ -189,11 +187,9 @@ plugin_call_ssl(const struct plugin_list *pl,
>                  const int type,
>                  const struct argv *av,
>                  struct plugin_return *pr,
> -                struct env_set *es
> -#ifdef ENABLE_CRYPTO
> -                , int current_cert_depth,
> +                struct env_set *es,
> +                int current_cert_depth,
>                  openvpn_x509_cert_t *current_cert
> -#endif
>                  )
>  {
>      return 0;
> @@ -208,11 +204,7 @@ plugin_call(const struct plugin_list *pl,
>              struct plugin_return *pr,
>              struct env_set *es)
>  {
> -    return plugin_call_ssl(pl, type, av, pr, es
> -#ifdef ENABLE_CRYPTO
> -                           , -1, NULL
> -#endif
> -                           );
> +    return plugin_call_ssl(pl, type, av, pr, es, -1, NULL);
>  }
>  
>  #endif /* OPENVPN_PLUGIN_H */
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index bfd8c247..972af618 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -34,8 +34,6 @@
>  
>  #include "syshead.h"
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "buffer.h"
>  #include "error.h"
>  #include "common.h"
> @@ -802,10 +800,3 @@ reliable_debug_print(const struct reliable *rel, char *desc)
>  }
>  
>  #endif /* if 0 */
> -
> -#else  /* ifdef ENABLE_CRYPTO */
> -static void
> -dummy(void)
> -{
> -}
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index aa34b022..0585d8b7 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
> @@ -28,8 +28,6 @@
>   */
>  
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #ifndef RELIABLE_H
>  #define RELIABLE_H
>  
> @@ -476,4 +474,3 @@ void reliable_ack_debug_print(const struct reliable_ack *ack, char *desc);
>  
>  
>  #endif /* RELIABLE_H */
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
> index dce42e7f..bc3c42af 100644
> --- a/src/openvpn/session_id.c
> +++ b/src/openvpn/session_id.c
> @@ -38,8 +38,6 @@
>  
>  #include "syshead.h"
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "error.h"
>  #include "common.h"
>  #include "crypto.h"
> @@ -60,10 +58,3 @@ session_id_print(const struct session_id *sid, struct gc_arena *gc)
>  {
>      return format_hex(sid->id, SID_SIZE, 0, gc);
>  }
> -
> -#else  /* ifdef ENABLE_CRYPTO */
> -static void
> -dummy(void)
> -{
> -}
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
> index 6611a3cb..df9167c3 100644
> --- a/src/openvpn/session_id.h
> +++ b/src/openvpn/session_id.h
> @@ -29,8 +29,6 @@
>   * negotiated).
>   */
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #ifndef SESSION_ID_H
>  #define SESSION_ID_H
>  
> @@ -82,4 +80,3 @@ void session_id_random(struct session_id *sid);
>  const char *session_id_print(const struct session_id *sid, struct gc_arena *gc);
>  
>  #endif /* SESSION_ID_H */
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 843bc393..919a4b40 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -43,8 +43,6 @@
>  #include "syshead.h"
>  #include "win32.h"
>  
> -#if defined(ENABLE_CRYPTO)
> -
>  #include "error.h"
>  #include "common.h"
>  #include "socket.h"
> @@ -4245,10 +4243,3 @@ delayed_auth_pass_purge(void)
>      auth_user_pass.wait_for_push = false;
>      purge_user_pass(&auth_user_pass, false);
>  }
> -
> -#else  /* if defined(ENABLE_CRYPTO) */
> -static void
> -dummy(void)
> -{
> -}
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 0e0f68fa..dd1ab0fd 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -29,8 +29,6 @@
>  #ifndef OPENVPN_SSL_H
>  #define OPENVPN_SSL_H
>  
> -#if defined(ENABLE_CRYPTO)
> -
>  #include "basic.h"
>  #include "common.h"
>  #include "crypto.h"
> @@ -600,6 +598,4 @@ bool is_hard_reset(int op, int key_method);
>  
>  void delayed_auth_pass_purge(void);
>  
> -#endif /* ENABLE_CRYPTO */
> -
>  #endif /* ifndef OPENVPN_SSL_H */
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index f588110c..7cf5d830 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -124,8 +124,6 @@ int tls_version_parse(const char *vstr, const char *extra);
>   */
>  int tls_version_max(void);
>  
> -#ifdef ENABLE_CRYPTO
> -
>  /**
>   * Initialise a library-specific TLS context for a server.
>   *
> @@ -539,5 +537,4 @@ void get_highest_preference_tls_cipher(char *buf, int size);
>   */
>  const char *get_ssl_library_version(void);
>  
> -#endif /* ENABLE_CRYPTO */
>  #endif /* SSL_BACKEND_H_ */
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 09829ebb..8ac52d55 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -35,7 +35,7 @@
>  
>  #include "syshead.h"
>  
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
> +#if defined(ENABLE_CRYPTO_MBEDTLS)
>  
>  #include "errlevel.h"
>  #include "ssl_backend.h"
> @@ -1395,4 +1395,4 @@ get_ssl_library_version(void)
>      return mbedtls_version;
>  }
>  
> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
> +#endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index b782946e..34c31b9d 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -34,7 +34,7 @@
>  
>  #include "syshead.h"
>  
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(ENABLE_CRYPTO_OPENSSL)
>  
>  #include "errlevel.h"
>  #include "buffer.h"
> @@ -1874,4 +1874,4 @@ get_ssl_library_version(void)
>      return SSLeay_version(SSLEAY_VERSION);
>  }
>  
> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
> +#endif /* defined(ENABLE_CRYPTO_OPENSSL) */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index de54fb74..ebb1da20 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -34,8 +34,6 @@
>  
>  #include "syshead.h"
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "misc.h"
>  #include "manage.h"
>  #include "otime.h"
> @@ -1541,5 +1539,3 @@ tls_x509_clear_env(struct env_set *es)
>          item = next;
>      }
>  }
> -
> -#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
> index f2d0d6ca..b17402b0 100644
> --- a/src/openvpn/ssl_verify.h
> +++ b/src/openvpn/ssl_verify.h
> @@ -29,8 +29,6 @@
>  #ifndef SSL_VERIFY_H_
>  #define SSL_VERIFY_H_
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "syshead.h"
>  #include "misc.h"
>  #include "ssl_common.h"
> @@ -243,6 +241,4 @@ tls_client_reason(struct tls_multi *multi)
>  /** Remove any X509_ env variables from env_set es */
>  void tls_x509_clear_env(struct env_set *es);
>  
> -#endif /* ENABLE_CRYPTO */
> -
>  #endif /* SSL_VERIFY_H_ */
> diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
> index 838c2176..5c4ad19e 100644
> --- a/src/openvpn/ssl_verify_mbedtls.c
> +++ b/src/openvpn/ssl_verify_mbedtls.c
> @@ -34,7 +34,7 @@
>  
>  #include "syshead.h"
>  
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS)
> +#if defined(ENABLE_CRYPTO_MBEDTLS)
>  
>  #include "crypto_mbedtls.h"
>  #include "ssl_verify.h"
> @@ -550,4 +550,4 @@ tls_verify_crl_missing(const struct tls_options *opt)
>      return false;
>  }
>  
> -#endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_MBEDTLS) */
> +#endif /* #if defined(ENABLE_CRYPTO_MBEDTLS) */
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
> index 2f3b10b9..02850fcb 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -34,7 +34,7 @@
>  
>  #include "syshead.h"
>  
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(ENABLE_CRYPTO_OPENSSL)
>  
>  #include "ssl_verify_openssl.h"
>  
> @@ -800,4 +800,4 @@ tls_verify_crl_missing(const struct tls_options *opt)
>      return true;
>  }
>  
> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
> +#endif /* defined(ENABLE_CRYPTO_OPENSSL) */
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index d9f5a34d..0c17ded3 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -513,7 +513,7 @@ socket_defined(const socket_descriptor_t sd)
>   * Do we have point-to-multipoint capability?
>   */
>  
> -#if defined(ENABLE_CRYPTO) && defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
> +#if defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
>  #define P2MP 1
>  #else
>  #define P2MP 0
> @@ -550,7 +550,7 @@ socket_defined(const socket_descriptor_t sd)
>  /*
>   * Enable external private key
>   */
> -#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_CRYPTO)
> +#if defined(ENABLE_MANAGEMENT)
>  #define MANAGMENT_EXTERNAL_KEY
>  #endif
>  
> @@ -597,25 +597,17 @@ socket_defined(const socket_descriptor_t sd)
>  /*
>   * Should we include NTLM proxy functionality
>   */
> -#if defined(ENABLE_CRYPTO)
>  #define NTLM 1
> -#else
> -#define NTLM 0
> -#endif
>  
>  /*
>   * Should we include proxy digest auth functionality
>   */
> -#if defined(ENABLE_CRYPTO)
>  #define PROXY_DIGEST_AUTH 1
> -#else
> -#define PROXY_DIGEST_AUTH 0
> -#endif
>  
>  /*
>   * Do we have CryptoAPI capability?
>   */
> -#if defined(_WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(_WIN32) && defined(ENABLE_CRYPTO_OPENSSL)
>  #define ENABLE_CRYPTOAPI
>  #endif
>  
> @@ -684,9 +676,7 @@ socket_defined(const socket_descriptor_t sd)
>  /*
>   * Do we support pushing peer info?
>   */
> -#if defined(ENABLE_CRYPTO)
>  #define ENABLE_PUSH_PEER_INFO
> -#endif
>  
>  /*
>   * Compression support
> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
> index 403060de..d9c67c38 100644
> --- a/src/openvpn/tls_crypt.c
> +++ b/src/openvpn/tls_crypt.c
> @@ -29,7 +29,6 @@
>  
>  #include "syshead.h"
>  
> -#ifdef ENABLE_CRYPTO
>  #include "crypto.h"
>  #include "session_id.h"
>  
> @@ -265,5 +264,3 @@ error_exit:
>      gc_free(&gc);
>      return false;
>  }
> -
> -#endif /* EMABLE_CRYPTO */
> diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
> index 4071ac94..e8080df9 100644
> --- a/src/openvpn/tls_crypt.h
> +++ b/src/openvpn/tls_crypt.h
> @@ -74,8 +74,6 @@
>  #ifndef TLSCRYPT_H
>  #define TLSCRYPT_H
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "buffer.h"
>  #include "crypto.h"
>  #include "session_id.h"
> @@ -142,6 +140,4 @@ bool tls_crypt_unwrap(const struct buffer *src, struct buffer *dst,
>  
>  /** @} */
>  
> -#endif /* ENABLE_CRYPTO */
> -
>  #endif /* TLSCRYPT_H */
> diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
> index 7b44f42e..23d758b7 100644
> --- a/tests/unit_tests/openvpn/Makefile.am
> +++ b/tests/unit_tests/openvpn/Makefile.am
> @@ -6,9 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
>  check_PROGRAMS += argv_testdriver buffer_testdriver
>  endif
>  
> -if ENABLE_CRYPTO
>  check_PROGRAMS += packet_id_testdriver tls_crypt_testdriver
> -endif
>  
>  TESTS = $(check_PROGRAMS)
>  
> diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
> index 0a6a08fa..cf40e4b6 100644
> --- a/tests/unit_tests/openvpn/test_tls_crypt.c
> +++ b/tests/unit_tests/openvpn/test_tls_crypt.c
> @@ -27,8 +27,6 @@
>  #include "config-msvc.h"
>  #endif
>  
> -#ifdef ENABLE_CRYPTO
> -
>  #include "syshead.h"
>  
>  #include <stdio.h>
> @@ -268,5 +266,3 @@ main(void) {
>  
>      return ret;
>  }
> -
> -#endif /* ENABLE_CRYPTO */
> 

Otherwise this looks good.  So, provided that the above accidental
changes are removed:

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

