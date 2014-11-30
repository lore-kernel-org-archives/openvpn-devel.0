MIME-Version: 1.0
In-Reply-To: <1417366536-27057-1-git-send-email-steffan@...1856...>
References: <1417366536-27057-1-git-send-email-steffan@...1856...>
Date: Sun, 30 Nov 2014 16:08:12 -0700
Message-ID: <CAAA5faGYtBcupVxqNznNomMiwstEJm1BVskiccVSX=RWsD4GbA@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Remove ENABLE_SSL define (and
 --disable-ssl configure option)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Steffan,

Will this change be in 2.3.6 that'll be released tomorrow?
Thanks,

Reinoud.

On Sun, Nov 30, 2014 at 9:55 AM, Steffan Karger <steffan@...1856...> wrote:
> Remove the --disable-ssl configure option and accompanying ENABLE_SSL
> defines in the master/2.4 branch, to reduce the code and testing
> complexity a bit.
>
> This does not remove to runtime option to run without SSL, just the compile
> time option to not include any SSL-related code.
>
> During the community meeting in November 2014 there were no objections
> amongst he developers present. Also, this has been announced on the -users
> and -devel mailing lists two weeks ago, without any response whatsoever.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  config-msvc.h                      |  1 -
>  configure.ac                       | 21 ++-----------
>  doc/doxygen/doc_data_crypto.h      | 12 +++----
>  doc/doxygen/openvpn.doxyfile       |  2 +-
>  include/openvpn-plugin.h           |  8 ++---
>  sample/sample-plugins/log/log_v3.c |  2 +-
>  src/openvpn/crypto.c               | 20 ------------
>  src/openvpn/crypto.h               |  9 ------
>  src/openvpn/crypto_openssl.c       | 16 ----------
>  src/openvpn/forward-inline.h       |  4 +--
>  src/openvpn/forward.c              | 18 +++--------
>  src/openvpn/init.c                 | 45 ++++++---------------------
>  src/openvpn/manage.c               |  4 +--
>  src/openvpn/openvpn.h              |  9 +-----
>  src/openvpn/options.c              | 64 ++++++--------------------------------
>  src/openvpn/options.h              |  4 ---
>  src/openvpn/plugin.c               |  8 ++---
>  src/openvpn/plugin.h               |  6 ++--
>  src/openvpn/reliable.c             |  4 +--
>  src/openvpn/reliable.h             |  4 +--
>  src/openvpn/session_id.c           |  4 +--
>  src/openvpn/session_id.h           |  4 +--
>  src/openvpn/ssl.c                  |  4 +--
>  src/openvpn/ssl.h                  |  4 +--
>  src/openvpn/ssl_openssl.c          |  4 +--
>  src/openvpn/ssl_polarssl.c         |  4 +--
>  src/openvpn/ssl_verify.c           |  4 +--
>  src/openvpn/ssl_verify.h           |  4 +--
>  src/openvpn/ssl_verify_openssl.c   |  4 +--
>  src/openvpn/ssl_verify_polarssl.c  |  4 +--
>  src/openvpn/syshead.h              | 10 +++---
>  31 files changed, 79 insertions(+), 232 deletions(-)
>
> diff --git a/config-msvc.h b/config-msvc.h
> index fa99384..8294c2c 100644
> --- a/config-msvc.h
> +++ b/config-msvc.h
> @@ -18,7 +18,6 @@
>  #define ENABLE_PLUGIN 1
>  #define ENABLE_PORT_SHARE 1
>  #define ENABLE_SOCKS 1
> -#define ENABLE_SSL 1
>
>  #define HAVE_ERRNO_H 1
>  #define HAVE_FCNTL_H 1
> diff --git a/configure.ac b/configure.ac
> index 608ab6d..319e05a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -79,13 +79,6 @@ AC_ARG_ENABLE(
>  )
>
>  AC_ARG_ENABLE(
> -       [ssl],
> -       [AS_HELP_STRING([--disable-ssl], [disable SSL support for TLS-based key exchange @<:@default=yes@:>@])],
> -       ,
> -       [enable_ssl="yes"]
> -)
> -
> -AC_ARG_ENABLE(
>         [x509-alt-username],
>         [AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username-field feature @<:@default=no@:>@])],
>         ,
> @@ -1080,19 +1073,11 @@ case "${with_crypto_library}" in
>                 ;;
>  esac
>
> -if test "${enable_ssl}" = "yes"; then
> -       test "${enable_crypto}" != "yes" && AC_MSG_ERROR([crypto must be enabled for ssl])
> -       test "${have_crypto_ssl}" != "yes" && AC_MSG_ERROR([${with_ssl_library} ssl is required but missing])
> -       OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_SSL_CFLAGS}"
> -       OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_SSL_LIBS}"
> -       AC_DEFINE([ENABLE_SSL], [1], [Enable ssl library])
> -fi
> -
>  if test "${enable_crypto}" = "yes"; then
>         test "${have_crypto_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crypto is required but missing])
>         test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
> -       OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CRYPTO_CFLAGS}"
> -       OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_CRYPTO_LIBS}"
> +       OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CRYPTO_CFLAGS} ${CRYPTO_SSL_CFLAGS}"
> +       OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_CRYPTO_LIBS} ${CRYPTO_SSL_LIBS}"
>         AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
>  fi
>
> @@ -1135,7 +1120,7 @@ fi
>
>  if test "${enable_pkcs11}" = "yes"; then
>         test "${have_pkcs11_helper}" != "yes" && AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])
> -       test "${enable_ssl}" != "yes" && AC_MSG_ERROR([PKCS11 can be enabled only if SSL is enabled])
> +       test "${enable_crypto}" != "yes" && AC_MSG_ERROR([PKCS11 can be enabled only if crypto is enabled])
>         OPTIONAL_PKCS11_HELPER_CFLAGS="${PKCS11_HELPER_CFLAGS}"
>         OPTIONAL_PKCS11_HELPER_LIBS="${PKCS11_HELPER_LIBS}"
>         AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
> diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
> index ee72b8c..8dcc15a 100644
> --- a/doc/doxygen/doc_data_crypto.h
> +++ b/doc/doxygen/doc_data_crypto.h
> @@ -60,12 +60,12 @@
>   *
>   * @par Settings that control this module's activity
>   * Whether or not the Data Channel Crypto module is active depends on the
> - * compile-time \c ENABLE_CRYPTO and \c ENABLE_SSL preprocessor macros.  How it
> - * processes packets received from the \link data_control Data Channel
> - * Control module\endlink at runtime depends on the associated \c
> - * crypto_options structure.  To perform cryptographic operations, the \c
> - * crypto_options.key_ctx_bi must contain the correct cipher and HMAC
> - * security parameters for the direction the packet is traveling in.
> + * compile-time \c ENABLE_CRYPTO preprocessor macro.  How it processes packets
> + * received from the \link data_control Data Channel Control module\endlink at
> + * runtime depends on the associated \c crypto_options structure.  To perform
> + * cryptographic operations, the \c crypto_options.key_ctx_bi must contain the
> + * correct cipher and HMAC security parameters for the direction the packet is
> + * traveling in.
>   *
>   * @par Crypto algorithms
>   * This module uses the crypto algorithm implementations of the external
> diff --git a/doc/doxygen/openvpn.doxyfile b/doc/doxygen/openvpn.doxyfile
> index cf26c42..7a02028 100644
> --- a/doc/doxygen/openvpn.doxyfile
> +++ b/doc/doxygen/openvpn.doxyfile
> @@ -235,7 +235,7 @@ EXPAND_ONLY_PREDEF     = NO
>  SEARCH_INCLUDES        = YES
>  INCLUDE_PATH           =
>  INCLUDE_FILE_PATTERNS  =
> -PREDEFINED             = WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_SSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
> +PREDEFINED             = WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
>  EXPAND_AS_DEFINED      =
>  SKIP_FUNCTION_MACROS   = YES
>  #---------------------------------------------------------------------------
> diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
> index 5f2d407..080ffff 100644
> --- a/include/openvpn-plugin.h
> +++ b/include/openvpn-plugin.h
> @@ -27,7 +27,7 @@
>
>  #define OPENVPN_PLUGIN_VERSION 3
>
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>  #ifdef ENABLE_CRYPTO_POLARSSL
>  #include <polarssl/x509_crt.h>
>  #ifndef __OPENVPN_X509_CERT_T_DECLARED
> @@ -358,9 +358,9 @@ struct openvpn_plugin_args_open_return
>   * *per_client_context : the per-client context pointer which was returned by
>   *        openvpn_plugin_client_constructor_v1, if defined.
>   *
> - * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with ENABLE_SSL defined)
> + * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with ENABLE_CRYPTO defined)
>   *
> - * *current_cert : X509 Certificate object received from the client (only if compiled with ENABLE_SSL defined)
> + * *current_cert : X509 Certificate object received from the client (only if compiled with ENABLE_CRYPTO defined)
>   *
>   */
>  struct openvpn_plugin_args_func_in
> @@ -370,7 +370,7 @@ struct openvpn_plugin_args_func_in
>    const char ** const envp;
>    openvpn_plugin_handle_t handle;
>    void *per_client_context;
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>    int current_cert_depth;
>    openvpn_x509_cert_t *current_cert;
>  #else
> diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
> index 4d3af91..bf1a15c 100644
> --- a/sample/sample-plugins/log/log_v3.c
> +++ b/sample/sample-plugins/log/log_v3.c
> @@ -36,7 +36,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>
> -#define ENABLE_SSL
> +#define ENABLE_CRYPTO
>
>  #include "openvpn-plugin.h"
>
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index ef2bde1..b6276bd 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -726,8 +726,6 @@ test_crypto (const struct crypto_options *co, struct frame* frame)
>    gc_free (&gc);
>  }
>
> -#ifdef ENABLE_SSL
> -
>  void
>  get_tls_handshake_key (const struct key_type *key_type,
>                        struct key_ctx_bi *ctx,
> @@ -808,7 +806,6 @@ get_tls_handshake_key (const struct key_type *key_type,
>        CLEAR (*ctx);
>      }
>  }
> -#endif
>
>  /* header and footer for static key file */
>  static const char static_key_head[] = "-----BEGIN OpenVPN Static key V1-----";
> @@ -1379,23 +1376,6 @@ get_random()
>    return l;
>  }
>
> -#ifndef ENABLE_SSL
> -
> -void
> -init_ssl_lib (void)
> -{
> -  crypto_init_lib ();
> -}
> -
> -void
> -free_ssl_lib (void)
> -{
> -  crypto_uninit_lib ();
> -  prng_uninit();
> -}
> -
> -#endif /* ENABLE_SSL */
> -
>  /*
>   * md5 functions
>   */
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index bf2f802..618b92c 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -343,8 +343,6 @@ void key2_print (const struct key2* k,
>                  const char* prefix0,
>                  const char* prefix1);
>
> -#ifdef ENABLE_SSL
> -
>  #define GHK_INLINE  (1<<0)
>  void get_tls_handshake_key (const struct key_type *key_type,
>                             struct key_ctx_bi *ctx,
> @@ -352,13 +350,6 @@ void get_tls_handshake_key (const struct key_type *key_type,
>                             const int key_direction,
>                             const unsigned int flags);
>
> -#else
> -
> -void init_ssl_lib (void);
> -void free_ssl_lib (void);
> -
> -#endif /* ENABLE_SSL */
> -
>  /*
>   * md5 functions
>   */
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index f7a491d..f1a72de 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -142,14 +142,6 @@ crypto_init_lib_engine (const char *engine_name)
>  void
>  crypto_init_lib (void)
>  {
> -#ifndef ENABLE_SSL
> -  /* If SSL is enabled init is taken care of in ssl_openssl.c */
> -#ifndef ENABLE_SMALL
> -  ERR_load_crypto_strings ();
> -#endif
> -  OpenSSL_add_all_algorithms ();
> -#endif
> -
>    /*
>     * If you build the OpenSSL library and OpenVPN with
>     * CRYPTO_MDEBUG, you will get a listing of OpenSSL
> @@ -164,14 +156,6 @@ crypto_init_lib (void)
>  void
>  crypto_uninit_lib (void)
>  {
> -#ifndef ENABLE_SSL
> -  /* If SSL is enabled cleanup is taken care of in ssl_openssl.c */
> -  EVP_cleanup ();
> -#ifndef ENABLE_SMALL
> -  ERR_free_strings ();
> -#endif
> -#endif
> -
>  #ifdef CRYPTO_MDEBUG
>    FILE* fp = fopen ("sdlog", "w");
>    ASSERT (fp);
> diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
> index 5853ce2..0ca6692 100644
> --- a/src/openvpn/forward-inline.h
> +++ b/src/openvpn/forward-inline.h
> @@ -35,7 +35,7 @@
>  static inline void
>  check_tls (struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#if defined(ENABLE_CRYPTO)
>    void check_tls_dowork (struct context *c);
>    if (c->c2.tls_multi)
>      check_tls_dowork (c);
> @@ -49,7 +49,7 @@ check_tls (struct context *c)
>  static inline void
>  check_tls_errors (struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#if defined(ENABLE_CRYPTO)
>    void check_tls_errors_co (struct context *c);
>    void check_tls_errors_nco (struct context *c);
>    if (c->c2.tls_multi && c->c2.tls_exit_signal)
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 91c4711..a3323e9 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -88,7 +88,7 @@ show_wait_status (struct context *c)
>   * traffic on the control-channel.
>   *
>   */
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>  void
>  check_tls_dowork (struct context *c)
>  {
> @@ -117,9 +117,6 @@ check_tls_dowork (struct context *c)
>    if (wakeup)
>      context_reschedule_sec (c, wakeup);
>  }
> -#endif
> -
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
>
>  void
>  check_tls_errors_co (struct context *c)
> @@ -133,8 +130,7 @@ check_tls_errors_nco (struct context *c)
>  {
>    register_signal (c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
>  }
> -
> -#endif
> +#endif /* ENABLE_CRYPTO */
>
>  #if P2MP
>
> @@ -239,7 +235,7 @@ check_connection_established_dowork (struct context *c)
>  bool
>  send_control_channel_string (struct context *c, const char *str, int msglevel)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    if (c->c2.tls_multi) {
>      struct gc_arena gc = gc_new ();
>      bool stat;
> @@ -264,7 +260,7 @@ send_control_channel_string (struct context *c, const char *str, int msglevel)
>      gc_free (&gc);
>      return stat;
>    }
> -#endif
> +#endif /* ENABLE_CRYPTO */
>    return true;
>  }
>
> @@ -457,7 +453,6 @@ encrypt_sign (struct context *c, bool comp_frag)
>      }
>
>  #ifdef ENABLE_CRYPTO
> -#ifdef ENABLE_SSL
>    /*
>     * If TLS mode, get the key we will use to encrypt
>     * the packet.
> @@ -466,7 +461,6 @@ encrypt_sign (struct context *c, bool comp_frag)
>      {
>        tls_pre_encrypt (c->c2.tls_multi, &c->c2.buf, &c->c2.crypto_options);
>      }
> -#endif
>
>    /*
>     * Encrypt the packet and write an optional
> @@ -480,7 +474,6 @@ encrypt_sign (struct context *c, bool comp_frag)
>    link_socket_get_outgoing_addr (&c->c2.buf, get_link_socket_info (c),
>                                  &c->c2.to_link_addr);
>  #ifdef ENABLE_CRYPTO
> -#ifdef ENABLE_SSL
>    /*
>     * In TLS mode, prepend the appropriate one-byte opcode
>     * to the packet which identifies it as a data channel
> @@ -493,7 +486,6 @@ encrypt_sign (struct context *c, bool comp_frag)
>        tls_post_encrypt (c->c2.tls_multi, &c->c2.buf);
>      }
>  #endif
> -#endif
>
>    /* if null encryption, copy result to read_tun_buf */
>    buffer_turnover (orig_buf, &c->c2.to_link, &c->c2.buf, &b->read_tun_buf);
> @@ -783,7 +775,6 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
>         link_socket_bad_incoming_addr (&c->c2.buf, lsi, &c->c2.from);
>
>  #ifdef ENABLE_CRYPTO
> -#ifdef ENABLE_SSL
>        if (c->c2.tls_multi)
>         {
>           /*
> @@ -813,7 +804,6 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
>        if (c->c2.context_auth != CAS_SUCCEEDED)
>         c->c2.buf.len = 0;
>  #endif
> -#endif /* ENABLE_SSL */
>
>        /* authenticate and decrypt the incoming packet */
>        decrypt_status = openvpn_decrypt (&c->c2.buf, c->c2.buffers->decrypt_buf, &c->c2.crypto_options, &c->c2.frame);
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a135aa5..706d07c 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -410,7 +410,7 @@ next_connection_entry (struct context *c)
>  static void
>  init_query_passwords (struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    /* Certificate password input */
>    if (c->options.key_pass_file)
>      pem_password_setup (c->options.key_pass_file);
> @@ -792,7 +792,7 @@ uninit_static (void)
>    close_port_share ();
>  #endif
>
> -#if defined(MEASURE_TLS_HANDSHAKE_STATS) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#if defined(MEASURE_TLS_HANDSHAKE_STATS) && defined(ENABLE_CRYPTO)
>    show_tls_performance_stats ();
>  #endif
>  }
> @@ -835,10 +835,7 @@ print_openssl_info (const struct options *options)
>     */
>  #ifdef ENABLE_CRYPTO
>    if (options->show_ciphers || options->show_digests || options->show_engines
> -#ifdef ENABLE_SSL
> -      || options->show_tls_ciphers || options->show_curves
> -#endif
> -    )
> +      || options->show_tls_ciphers || options->show_curves)
>      {
>        if (options->show_ciphers)
>         show_available_ciphers ();
> @@ -846,12 +843,10 @@ print_openssl_info (const struct options *options)
>         show_available_digests ();
>        if (options->show_engines)
>         show_available_engines ();
> -#ifdef ENABLE_SSL
>        if (options->show_tls_ciphers)
>         show_available_tls_ciphers (options->cipher_list);
>        if (options->show_curves)
>         show_available_curves();
> -#endif
>        return true;
>      }
>  #endif
> @@ -901,10 +896,8 @@ do_persist_tuntap (const struct options *options)
>           || options->ifconfig_remote_netmask
>  #ifdef ENABLE_CRYPTO
>           || options->shared_secret_file
> -#ifdef ENABLE_SSL
>           || options->tls_server || options->tls_client
>  #endif
> -#endif
>         )
>         msg (M_FATAL|M_OPTERR,
>              "options --mktun or --rmtun should only be used together with --dev");
> @@ -1012,7 +1005,7 @@ const char *
>  format_common_name (struct context *c, struct gc_arena *gc)
>  {
>    struct buffer out = alloc_buf_gc (256, gc);
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    if (c->c2.tls_multi)
>      {
>        buf_printf (&out, "[%s] ", tls_common_name (c->c2.tls_multi, false));
> @@ -1102,9 +1095,7 @@ do_init_timers (struct context *c, bool deferred)
>  #ifdef ENABLE_CRYPTO
>        if (c->options.packet_id_file)
>         event_timeout_init (&c->c2.packet_id_persist_interval, 60, now);
> -#endif
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
>        /* initialize tmp_int optimization that limits the number of times we call
>          tls_multi_process in the main event loop */
>        interval_init (&c->c2.tmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);
> @@ -1797,7 +1788,7 @@ do_deferred_options (struct context *c, const unsigned int found)
>    if (found & OPT_P_SETENV)
>      msg (D_PUSH, "OPTIONS IMPORT: environment modified");
>
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>    if (found & OPT_P_PEER_ID)
>      {
>        msg (D_PUSH, "OPTIONS IMPORT: peer-id set");
> @@ -1928,13 +1919,11 @@ key_schedule_free (struct key_schedule *ks, bool free_ssl_ctx)
>  {
>  #ifdef ENABLE_CRYPTO
>    free_key_ctx_bi (&ks->static_key);
> -#ifdef ENABLE_SSL
>    if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
>      {
>        tls_ctx_free (&ks->ssl_ctx);
>        free_key_ctx_bi (&ks->tls_auth_key);
>      }
> -#endif /* ENABLE_SSL */
>  #endif /* ENABLE_CRYPTO */
>    CLEAR (*ks);
>  }
> @@ -2054,8 +2043,6 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
>                                options->use_iv);
>  }
>
> -#ifdef ENABLE_SSL
> -
>  /*
>   * Initialize the persistent component of OpenVPN's TLS mode,
>   * which is preserved across SIGUSR1 resets.
> @@ -2303,10 +2290,6 @@ do_init_finalize_tls_frame (struct context *c)
>      }
>  }
>
> -#endif /* ENABLE_SSL */
> -#endif /* ENABLE_CRYPTO */
> -
> -#ifdef ENABLE_CRYPTO
>  /*
>   * No encryption or authentication.
>   */
> @@ -2325,16 +2308,14 @@ do_init_crypto (struct context *c, const unsigned int flags)
>  #ifdef ENABLE_CRYPTO
>    if (c->options.shared_secret_file)
>      do_init_crypto_static (c, flags);
> -#ifdef ENABLE_SSL
>    else if (c->options.tls_server || c->options.tls_client)
>      do_init_crypto_tls (c, flags);
> -#endif
>    else                         /* no encryption or authentication. */
>      do_init_crypto_none (c);
>  #else /* ENABLE_CRYPTO */
>    msg (M_WARN,
>         "******* WARNING *******: " PACKAGE_NAME
> -       " built without OpenSSL -- encryption and authentication features disabled -- all data will be tunnelled as cleartext");
> +       " built without crypto library -- encryption and authentication features disabled -- all data will be tunnelled as cleartext");
>  #endif /* ENABLE_CRYPTO */
>  }
>
> @@ -2503,7 +2484,6 @@ do_option_warnings (struct context *c)
>    if (!o->use_iv)
>      msg (M_WARN, "WARNING: You have disabled Crypto IVs (--no-iv) which may make " PACKAGE_NAME " less secure");
>
> -#ifdef ENABLE_SSL
>    if (o->tls_server)
>      warn_on_use_of_common_subnets ();
>    if (o->tls_client
> @@ -2513,7 +2493,6 @@ do_option_warnings (struct context *c)
>        && !o->remote_cert_eku)
>      msg (M_WARN, "WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
>  #endif
> -#endif
>
>  #ifndef CONNECT_NONBLOCK
>    if (o->ce.connect_timeout_defined)
> @@ -2535,7 +2514,7 @@ do_option_warnings (struct context *c)
>  static void
>  do_init_frame_tls (struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    do_init_finalize_tls_frame (c);
>  #endif
>  }
> @@ -2733,9 +2712,7 @@ do_compute_occ_strings (struct context *c)
>         options_string_version (c->c2.options_string_remote, &gc),
>         md5sum ((uint8_t*)c->c2.options_string_remote,
>                strlen (c->c2.options_string_remote), 9, &gc));
> -#endif
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
>    if (c->c2.tls_multi)
>      tls_multi_init_set_options (c->c2.tls_multi,
>                                 c->c2.options_string_local,
> @@ -2821,7 +2798,7 @@ do_close_free_buf (struct context *c)
>  static void
>  do_close_tls (struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    if (c->c2.tls_multi)
>      {
>        tls_multi_free (c->c2.tls_multi, true);
> @@ -3072,7 +3049,7 @@ do_setup_fast_io (struct context *c)
>  static void
>  do_signal_on_tls_errors (struct context *c)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    if (c->options.tls_exit)
>      c->c2.tls_exit_signal = SIGTERM;
>    else
> @@ -3624,12 +3601,10 @@ inherit_context_child (struct context *dest,
>
>  #ifdef ENABLE_CRYPTO
>    dest->c1.ks.key_type = src->c1.ks.key_type;
> -#ifdef ENABLE_SSL
>    /* inherit SSL context */
>    dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
>    dest->c1.ks.tls_auth_key = src->c1.ks.tls_auth_key;
>  #endif
> -#endif
>
>    /* options */
>    dest->options = src->options;
> @@ -3701,7 +3676,7 @@ inherit_context_top (struct context *dest,
>    /* detach plugins */
>    dest->plugins_owned = false;
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    dest->c2.tls_multi = NULL;
>  #endif
>
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 9f44cd9..e59776d 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -701,7 +701,7 @@ man_query_need_str (struct management *man, const char *type, const char *action
>  static void
>  man_forget_passwords (struct management *man)
>  {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    ssl_purge_auth (false);
>    msg (M_CLIENT, "SUCCESS: Passwords were forgotten");
>  #endif
> @@ -1695,7 +1695,7 @@ man_reset_client_socket (struct management *man, const bool exiting)
>      }
>    if (!exiting)
>      {
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>        if (man->settings.flags & MF_FORGET_DISCONNECT)
>         ssl_purge_auth (false);
>  #endif
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 24df3bb..fb532a2 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -62,14 +62,11 @@ struct key_schedule
>    /* pre-shared static key, read from a file */
>    struct key_ctx_bi static_key;
>
> -#ifdef ENABLE_SSL
>    /* our global SSL context */
>    struct tls_root_ctx ssl_ctx;
>
>    /* optional authentication HMAC key for TLS control channel */
>    struct key_ctx_bi tls_auth_key;
> -
> -#endif                         /* ENABLE_SSL */
>  #else                          /* ENABLE_CRYPTO */
>    int dummy;
>  #endif                         /* ENABLE_CRYPTO */
> @@ -335,8 +332,6 @@ struct context_2
>    /*
>     * TLS-mode crypto objects.
>     */
> -#ifdef ENABLE_SSL
> -
>    struct tls_multi *tls_multi;  /**< TLS state structure for this VPN
>                                   *   tunnel. */
>
> @@ -357,8 +352,6 @@ struct context_2
>    /* throw this signal on TLS errors */
>    int tls_exit_signal;
>
> -#endif /* ENABLE_SSL */
> -
>    struct crypto_options crypto_options;
>                                  /**< Security parameters and crypto state
>                                   *   used by the \link data_crypto Data
> @@ -566,7 +559,7 @@ struct context
>   * have been compiled in.
>   */
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>  #define TLS_MODE(c) ((c)->c2.tls_multi != NULL)
>  #define PROTO_DUMP_FLAGS (check_debug_level (D_LINK_RW_VERBOSE) ? (PD_SHOW_DATA|PD_VERBOSE) : 0)
>  #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 721b42e..24c7ae5 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -68,7 +68,6 @@ const char title_string[] =
>  #endif
>    " " TARGET_ALIAS
>  #ifdef ENABLE_CRYPTO
> -#ifdef ENABLE_SSL
>  #if defined(ENABLE_CRYPTO_POLARSSL)
>    " [SSL (PolarSSL)]"
>  #elif defined(ENABLE_CRYPTO_OPENSSL)
> @@ -76,15 +75,6 @@ const char title_string[] =
>  #else
>    " [SSL]"
>  #endif /* defined(ENABLE_CRYPTO_POLARSSL) */
> -#else /* ! ENABLE_SSL */
> -#if defined(ENABLE_CRYPTO_POLARSSL)
> -  " [CRYPTO (PolarSSL)]"
> -#elif defined(ENABLE_CRYPTO_OPENSSL)
> -  " [CRYPTO (OpenSSL)]"
> -#else
> -  " [CRYPTO]"
> -#endif /* defined(ENABLE_CRYPTO_POLARSSL) */
> -#endif /* ENABLE_SSL */
>  #endif /* ENABLE_CRYPTO */
>  #ifdef USE_COMP
>  #ifdef ENABLE_LZO
> @@ -548,7 +538,6 @@ static const char usage_message[] =
>    "--use-prediction-resistance: Enable prediction resistance on the random\n"
>    "                             number generator.\n"
>  #endif
> -#ifdef ENABLE_SSL
>    "\n"
>    "TLS Key Negotiation Options:\n"
>    "(These options are meaningful only for TLS-mode)\n"
> @@ -633,7 +622,6 @@ static const char usage_message[] =
>    "--remote-cert-tls t: Require that peer certificate was signed with explicit\n"
>    "                  key usage and extended key usage based on RFC3280 TLS rules.\n"
>    "                  t = 'client' | 'server'.\n"
> -#endif                         /* ENABLE_SSL */
>  #ifdef ENABLE_PKCS11
>    "\n"
>    "PKCS#11 Options:\n"
> @@ -658,9 +646,7 @@ static const char usage_message[] =
>    "--show-ciphers  : Show cipher algorithms to use with --cipher option.\n"
>    "--show-digests  : Show message digest algorithms to use with --auth option.\n"
>    "--show-engines  : Show hardware crypto accelerator engines (if available).\n"
> -#ifdef ENABLE_SSL
>    "--show-tls      : Show all TLS ciphers (TLS used only as a control channel).\n"
> -#endif
>  #ifdef WIN32
>    "\n"
>    "Windows Specific:\n"
> @@ -842,7 +828,6 @@ init_options (struct options *o, const bool init_gc)
>  #ifdef ENABLE_PREDICTION_RESISTANCE
>    o->use_prediction_resistance = false;
>  #endif
> -#ifdef ENABLE_SSL
>    o->key_method = 2;
>    o->tls_timeout = 2;
>    o->renegotiate_seconds = 3600;
> @@ -852,7 +837,6 @@ init_options (struct options *o, const bool init_gc)
>  #ifdef ENABLE_X509ALTUSERNAME
>    o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>  #endif
> -#endif /* ENABLE_SSL */
>  #endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_PKCS11
>    o->pkcs11_pin_cache_period = -1;
> @@ -1043,7 +1027,7 @@ string_substitute (const char *src, int from, int to, struct gc_arena *gc)
>    return ret;
>  }
>
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>  static uint8_t *
>  parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
>  {
> @@ -1426,11 +1410,9 @@ show_settings (const struct options *o)
>    SHOW_BOOL (show_digests);
>    SHOW_BOOL (show_engines);
>    SHOW_BOOL (genkey);
> -#ifdef ENABLE_SSL
>    SHOW_STR (key_pass_file);
>    SHOW_BOOL (show_tls_ciphers);
>  #endif
> -#endif
>
>    SHOW_INT (connect_retry_max);
>    show_connection_entries (o);
> @@ -1584,7 +1566,6 @@ show_settings (const struct options *o)
>    SHOW_BOOL (use_prediction_resistance);
>  #endif
>
> -#ifdef ENABLE_SSL
>    SHOW_BOOL (tls_server);
>    SHOW_BOOL (tls_client);
>    SHOW_INT (key_method);
> @@ -1636,8 +1617,7 @@ show_settings (const struct options *o)
>    SHOW_BOOL (tls_exit);
>
>    SHOW_STR (tls_auth_file);
> -#endif
> -#endif
> +#endif /* ENABLE_CRYPTO */
>
>  #ifdef ENABLE_PKCS11
>    {
> @@ -1853,7 +1833,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>      msg (M_USAGE, "--inetd nowait can only be used with --proto tcp-server");
>
>    if (options->inetd == INETD_NOWAIT
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>        && !(options->tls_server || options->tls_client)
>  #endif
>        )
> @@ -2144,8 +2124,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>    /*
>     * SSL/TLS mode sanity checks.
>     */
> -
> -#ifdef ENABLE_SSL
>    if (options->tls_server + options->tls_client +
>        (options->shared_secret_file != NULL) > 1)
>      msg (M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
> @@ -2322,7 +2300,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
>      }
>  #undef MUST_BE_UNDEF
>  #endif /* ENABLE_CRYPTO */
> -#endif /* ENABLE_SSL */
>
>  #if P2MP
>    if (options->auth_user_pass_file && !options->pull)
> @@ -2674,8 +2651,8 @@ options_postprocess_filechecks (struct options *options)
>  {
>    bool errs = false;
>
> +#ifdef ENABLE_CRYPTO
>    /* ** SSL/TLS/crypto related files ** */
> -#ifdef ENABLE_SSL
>    errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
>    errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
>    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
> @@ -2699,20 +2676,15 @@ options_postprocess_filechecks (struct options *options)
>
>    errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
>                               "--tls-auth");
> -#endif /* ENABLE_SSL */
> -#ifdef ENABLE_CRYPTO
>    errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->shared_secret_file, R_OK,
>                               "--secret");
>    errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
>                               options->packet_id_file, R_OK|W_OK, "--replay-persist");
> -#endif /* ENABLE_CRYPTO */
> -
>
>    /* ** Password files ** */
> -#ifdef ENABLE_SSL
>    errs |= check_file_access (CHKACC_FILE, options->key_pass_file, R_OK,
>                               "--askpass");
> -#endif /* ENABLE_SSL */
> +#endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_MANAGEMENT
>    errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
>                               options->management_user_pass, R_OK,
> @@ -2735,10 +2707,10 @@ options_postprocess_filechecks (struct options *options)
>                               R_OK|W_OK, "--status");
>
>    /* ** Config related ** */
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->tls_export_cert,
>                               R_OK|W_OK|X_OK, "--tls-export-cert");
> -#endif /* ENABLE_SSL */
> +#endif /* ENABLE_CRYPTO */
>  #if P2MP_SERVER
>    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->client_config_dir,
>                               R_OK|X_OK, "--client-config-dir");
> @@ -2967,13 +2939,8 @@ options_string (const struct options *o,
>
>  #ifdef ENABLE_CRYPTO
>
> -#ifdef ENABLE_SSL
>  #define TLS_CLIENT (o->tls_client)
>  #define TLS_SERVER (o->tls_server)
> -#else
> -#define TLS_CLIENT (false)
> -#define TLS_SERVER (false)
> -#endif
>
>    /*
>     * Key direction
> @@ -3016,7 +2983,6 @@ options_string (const struct options *o,
>  #endif
>        }
>
> -#ifdef ENABLE_SSL
>    /*
>     * SSL Options
>     */
> @@ -3045,7 +3011,6 @@ options_string (const struct options *o,
>           buf_printf (&out, ",tls-server");
>        }
>    }
> -#endif /* ENABLE_SSL */
>
>  #undef TLS_CLIENT
>  #undef TLS_SERVER
> @@ -3368,7 +3333,7 @@ usage (void)
>    struct options o;
>    init_options (&o, true);
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>    fprintf (fp, usage_message,
>            title_string,
>            o.ce.connect_retry_seconds,
> @@ -3379,15 +3344,6 @@ usage (void)
>             o.replay_window, o.replay_time,
>            o.tls_timeout, o.renegotiate_seconds,
>            o.handshake_window, o.transition_window);
> -#elif defined(ENABLE_CRYPTO)
> -  fprintf (fp, usage_message,
> -          title_string,
> -          o.ce.connect_retry_seconds,
> -          o.ce.local_port, o.ce.remote_port,
> -          TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
> -          o.verbosity,
> -          o.authname, o.ciphername,
> -           o.replay_window, o.replay_time);
>  #else
>    fprintf (fp, usage_message,
>            title_string,
> @@ -3413,7 +3369,7 @@ usage_small (void)
>  void
>  show_library_versions(const unsigned int flags)
>  {
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>  #define SSL_LIB_VER_STR get_ssl_library_version()
>  #else
>  #define SSL_LIB_VER_STR ""
> @@ -6484,7 +6440,6 @@ add_option (struct options *options,
>        options->use_prediction_resistance = true;
>      }
>  #endif
> -#ifdef ENABLE_SSL
>    else if (streq (p[0], "show-tls"))
>      {
>        VERIFY_PERMISSION (OPT_P_GENERAL);
> @@ -6921,7 +6876,6 @@ add_option (struct options *options,
>        options->x509_username_field = p[1];
>      }
>  #endif /* ENABLE_X509ALTUSERNAME */
> -#endif /* ENABLE_SSL */
>  #endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_PKCS11
>    else if (streq (p[0], "show-pkcs11-ids") && p[1])
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 9d188f8..7a8b21e 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -195,10 +195,8 @@ struct options
>    bool show_ciphers;
>    bool show_digests;
>    bool show_engines;
> -#ifdef ENABLE_SSL
>    bool show_tls_ciphers;
>    bool show_curves;
> -#endif
>    bool genkey;
>  #endif
>
> @@ -500,7 +498,6 @@ struct options
>    bool use_prediction_resistance;
>  #endif
>
> -#ifdef ENABLE_SSL
>    /* TLS (control channel) parms */
>    bool tls_server;
>    bool tls_client;
> @@ -582,7 +579,6 @@ struct options
>
>    bool tls_exit;
>
> -#endif /* ENABLE_SSL */
>  #endif /* ENABLE_CRYPTO */
>
>  #ifdef ENABLE_X509_TRACK
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 54c5b52..60dd2ee 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -420,7 +420,7 @@ plugin_call_item (const struct plugin *p,
>                   const struct argv *av,
>                   struct openvpn_plugin_string_list **retlist,
>                   const char **envp
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>                   , int certdepth,
>                   openvpn_x509_cert_t *current_cert
>  #endif
> @@ -449,7 +449,7 @@ plugin_call_item (const struct plugin *p,
>                                                      (const char ** const) envp,
>                                                      p->plugin_handle,
>                                                      per_client_context,
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>                                                     (current_cert ? certdepth : -1),
>                                                     current_cert
>  #else
> @@ -659,7 +659,7 @@ plugin_call_ssl (const struct plugin_list *pl,
>              const struct argv *av,
>              struct plugin_return *pr,
>              struct env_set *es
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>               , int certdepth,
>              openvpn_x509_cert_t *current_cert
>  #endif
> @@ -689,7 +689,7 @@ plugin_call_ssl (const struct plugin_list *pl,
>                                                av,
>                                                pr ? &pr->list[i] : NULL,
>                                                envp
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>                                                ,certdepth,
>                                                current_cert
>  #endif
> diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
> index 2f8416b..77b6e81 100644
> --- a/src/openvpn/plugin.h
> +++ b/src/openvpn/plugin.h
> @@ -127,7 +127,7 @@ int plugin_call_ssl (const struct plugin_list *pl,
>                  const struct argv *av,
>                  struct plugin_return *pr,
>                  struct env_set *es
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>                  , int current_cert_depth,
>                  openvpn_x509_cert_t *current_cert
>  #endif
> @@ -183,7 +183,7 @@ plugin_call_ssl (const struct plugin_list *pl,
>              const struct argv *av,
>              struct plugin_return *pr,
>              struct env_set *es
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>              , int current_cert_depth,
>              openvpn_x509_cert_t *current_cert
>  #endif
> @@ -202,7 +202,7 @@ plugin_call(const struct plugin_list *pl,
>         struct env_set *es)
>  {
>    return plugin_call_ssl(pl, type, av, pr, es
> -#ifdef ENABLE_SSL
> +#ifdef ENABLE_CRYPTO
>        , -1, NULL
>  #endif
>        );
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index 763169e..22883a7 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -35,7 +35,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>
>  #include "buffer.h"
>  #include "error.h"
> @@ -754,4 +754,4 @@ reliable_debug_print (const struct reliable *rel, char *desc)
>
>  #else
>  static void dummy(void) {}
> -#endif /* ENABLE_CRYPTO && ENABLE_SSL*/
> +#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index 594ab82..828dcd3 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
> @@ -29,7 +29,7 @@
>   */
>
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>
>  #ifndef RELIABLE_H
>  #define RELIABLE_H
> @@ -477,4 +477,4 @@ void reliable_ack_debug_print (const struct reliable_ack *ack, char *desc);
>
>
>  #endif /* RELIABLE_H */
> -#endif /* ENABLE_CRYPTO && ENABLE_SSL */
> +#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
> index 2e07b54..0ebff65 100644
> --- a/src/openvpn/session_id.c
> +++ b/src/openvpn/session_id.c
> @@ -39,7 +39,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>
>  #include "error.h"
>  #include "common.h"
> @@ -64,4 +64,4 @@ session_id_print (const struct session_id *sid, struct gc_arena *gc)
>
>  #else
>  static void dummy(void) {}
> -#endif /* ENABLE_CRYPTO && ENABLE_SSL*/
> +#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
> index 33909dd..2a1f41f 100644
> --- a/src/openvpn/session_id.h
> +++ b/src/openvpn/session_id.h
> @@ -30,7 +30,7 @@
>   * negotiated).
>   */
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>
>  #ifndef SESSION_ID_H
>  #define SESSION_ID_H
> @@ -83,4 +83,4 @@ void session_id_random (struct session_id *sid);
>  const char *session_id_print (const struct session_id *sid, struct gc_arena *gc);
>
>  #endif /* SESSION_ID_H */
> -#endif /* ENABLE_CRYPTO && ENABLE_SSL */
> +#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 2adfa26..ca1ad13 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -43,7 +43,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#if defined(ENABLE_CRYPTO)
>
>  #include "error.h"
>  #include "common.h"
> @@ -3621,4 +3621,4 @@ done:
>
>  #else
>  static void dummy(void) {}
> -#endif /* ENABLE_CRYPTO && ENABLE_SSL*/
> +#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 7e5a203..797c3e5 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -30,7 +30,7 @@
>  #ifndef OPENVPN_SSL_H
>  #define OPENVPN_SSL_H
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#if defined(ENABLE_CRYPTO)
>
>  #include "basic.h"
>  #include "common.h"
> @@ -512,6 +512,6 @@ void show_tls_performance_stats(void);
>  /*#define EXTRACT_X509_FIELD_TEST*/
>  void extract_x509_field_test (void);
>
> -#endif /* ENABLE_CRYPTO && ENABLE_SSL */
> +#endif /* ENABLE_CRYPTO */
>
>  #endif
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 6782a95..57fcadb 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -35,7 +35,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
>
>  #include "errlevel.h"
>  #include "buffer.h"
> @@ -1457,4 +1457,4 @@ get_ssl_library_version(void)
>      return SSLeay_version(SSLEAY_VERSION);
>  }
>
> -#endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL) */
> +#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index 2036885..8cb328e 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
> @@ -36,7 +36,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
> +#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL)
>
>  #include "errlevel.h"
>  #include "ssl_backend.h"
> @@ -1171,4 +1171,4 @@ get_ssl_library_version(void)
>      return polar_version;
>  }
>
> -#endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL) */
> +#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL) */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 2d10d15..cec5f02 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -35,7 +35,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>
>  #include "misc.h"
>  #include "manage.h"
> @@ -1268,4 +1268,4 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
>        gc_free (&gc);
>      }
>  }
> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) */
> +#endif /* ENABLE_CRYPTO */
> diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
> index 84554f8..5f23431 100644
> --- a/src/openvpn/ssl_verify.h
> +++ b/src/openvpn/ssl_verify.h
> @@ -30,7 +30,7 @@
>  #ifndef SSL_VERIFY_H_
>  #define SSL_VERIFY_H_
>
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#ifdef ENABLE_CRYPTO
>
>  #include "syshead.h"
>  #include "misc.h"
> @@ -236,6 +236,6 @@ tls_client_reason (struct tls_multi *multi)
>  #endif
>  }
>
> -#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) */
> +#endif /* ENABLE_CRYPTO */
>
>  #endif /* SSL_VERIFY_H_ */
> diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
> index 33cd757..0348e98 100644
> --- a/src/openvpn/ssl_verify_openssl.c
> +++ b/src/openvpn/ssl_verify_openssl.c
> @@ -35,7 +35,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
>
>  #include "ssl_verify_openssl.h"
>
> @@ -625,4 +625,4 @@ end:
>    return retval;
>  }
>
> -#endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL) */
> +#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL) */
> diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
> index 2b7c214..e21301d 100644
> --- a/src/openvpn/ssl_verify_polarssl.c
> +++ b/src/openvpn/ssl_verify_polarssl.c
> @@ -35,7 +35,7 @@
>
>  #include "syshead.h"
>
> -#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
> +#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL)
>
>  #include "ssl_verify.h"
>  #include <polarssl/error.h>
> @@ -403,4 +403,4 @@ end:
>    return retval;
>  }
>
> -#endif /* #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL) */
> +#endif /* #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL) */
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index 8b6d284..b898bf2 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -517,7 +517,7 @@ socket_defined (const socket_descriptor_t sd)
>   * Do we have point-to-multipoint capability?
>   */
>
> -#if defined(ENABLE_CLIENT_SERVER) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
> +#if defined(ENABLE_CLIENT_SERVER) && defined(ENABLE_CRYPTO) && defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
>  #define P2MP 1
>  #else
>  #define P2MP 0
> @@ -554,7 +554,7 @@ socket_defined (const socket_descriptor_t sd)
>  /*
>   * Enable external private key
>   */
> -#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_SSL)
> +#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_CRYPTO)
>  #define MANAGMENT_EXTERNAL_KEY
>  #endif
>
> @@ -621,14 +621,14 @@ socket_defined (const socket_descriptor_t sd)
>  /*
>   * Do we have CryptoAPI capability?
>   */
> -#if defined(WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
> +#if defined(WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
>  #define ENABLE_CRYPTOAPI
>  #endif
>
>  /*
>   * Enable x509-track feature?
>   */
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined (ENABLE_CRYPTO_OPENSSL)
> +#if defined(ENABLE_CRYPTO) && defined (ENABLE_CRYPTO_OPENSSL)
>  #define ENABLE_X509_TRACK
>  #endif
>
> @@ -697,7 +697,7 @@ socket_defined (const socket_descriptor_t sd)
>  /*
>   * Do we support pushing peer info?
>   */
> -#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
> +#if defined(ENABLE_CRYPTO)
>  #define ENABLE_PUSH_PEER_INFO
>  #endif
>
> --
> 1.9.1
>
>
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

