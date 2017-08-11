References: <20170811090744.31750-1-a@...2181...>
 <20170811090744.31750-2-a@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <d87f03dd-e6af-1e5a-fa9f-799887621e55@...1435...>
Date: Fri, 11 Aug 2017 11:45:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170811090744.31750-2-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/5] make function declarations C99
 compliant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 11-08-17 11:07, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
> 
> In the attempt of adhering to the C99 standard as much as possible,
> ensure that all the function declarations with no parameter contain
> the "void" keyword[1].
> 
> Defects identified with sparse[2].
> 
> [1] ISO/IEC 9899:1999 spec, TC3 - section 6.7.5.3
> [1] https://sparse.wiki.kernel.org/index.php/Main_Page
> 
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  src/openvpn/buffer.c          |  2 +-
>  src/openvpn/console.c         |  2 +-
>  src/openvpn/console.h         |  8 ++++----
>  src/openvpn/console_builtin.c |  2 +-
>  src/openvpn/console_systemd.c |  4 ++--
>  src/openvpn/crypto.c          |  4 ++--
>  src/openvpn/crypto.h          |  2 +-
>  src/openvpn/crypto_mbedtls.c  | 10 +++++-----
>  src/openvpn/crypto_mbedtls.h  |  4 ++--
>  src/openvpn/crypto_openssl.c  |  6 +++---
>  src/openvpn/error.c           |  6 +++---
>  src/openvpn/error.h           |  2 +-
>  src/openvpn/init.c            |  2 +-
>  src/openvpn/interval.h        |  2 +-
>  src/openvpn/manage.c          |  2 +-
>  src/openvpn/occ-inline.h      |  2 +-
>  src/openvpn/packet_id.c       |  2 +-
>  src/openvpn/packet_id.h       |  2 +-
>  src/openvpn/pkcs11.c          |  6 +++---
>  src/openvpn/platform.c        |  2 +-
>  src/openvpn/ps.c              |  2 +-
>  src/openvpn/ssl.c             |  4 ++--
>  src/openvpn/ssl_backend.h     |  6 +++---
>  src/openvpn/ssl_mbedtls.c     |  6 +++---
>  src/openvpn/ssl_openssl.c     | 12 ++++++------
>  src/openvpn/win32.c           |  6 +++---
>  src/openvpn/win32.h           |  4 ++--
>  27 files changed, 56 insertions(+), 56 deletions(-)
> 
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 87e27ec0..a63ce14a 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -180,7 +180,7 @@ buf_assign(struct buffer *dest, const struct buffer *src)
>  }
>  
>  struct buffer
> -clear_buf()
> +clear_buf(void)
>  {
>      struct buffer buf;
>      CLEAR(buf);
> diff --git a/src/openvpn/console.c b/src/openvpn/console.c
> index eb6944d0..7e170241 100644
> --- a/src/openvpn/console.c
> +++ b/src/openvpn/console.c
> @@ -44,7 +44,7 @@ struct _query_user query_user[QUERY_USER_NUMSLOTS];  /* GLOBAL */
>  
>  
>  void
> -query_user_clear()
> +query_user_clear(void)
>  {
>      int i;
>  
> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
> index aa51e6f6..3f74e77e 100644
> --- a/src/openvpn/console.h
> +++ b/src/openvpn/console.h
> @@ -46,7 +46,7 @@ extern struct _query_user query_user[];  /**< Global variable, declared in conso
>   * Wipes all data put into all of the query_user structs
>   *
>   */
> -void query_user_clear();
> +void query_user_clear(void);
>  
>  
>  /**
> @@ -72,7 +72,7 @@ void query_user_add(char *prompt, size_t prompt_len,
>   *
>   * @return True if executing all the defined steps completed successfully
>   */
> -bool query_user_exec_builtin();
> +bool query_user_exec_builtin(void);
>  
>  
>  #if defined(ENABLE_SYSTEMD)
> @@ -83,7 +83,7 @@ bool query_user_exec_builtin();
>   *
>   * @return True if executing all the defined steps completed successfully
>   */
> -bool query_user_exec();
> +bool query_user_exec(void);
>  
>  #else  /* ENABLE_SYSTEMD not defined*/
>  /**
> @@ -92,7 +92,7 @@ bool query_user_exec();
>   *
>   */
>  static bool
> -query_user_exec()
> +query_user_exec(void)
>  {
>      return query_user_exec_builtin();
>  }
> diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
> index 7b95da9d..f005ed74 100644
> --- a/src/openvpn/console_builtin.c
> +++ b/src/openvpn/console_builtin.c
> @@ -267,7 +267,7 @@ get_console_input(const char *prompt, const bool echo, char *input, const int ca
>   *
>   */
>  bool
> -query_user_exec_builtin()
> +query_user_exec_builtin(void)
>  {
>      bool ret = true; /* Presume everything goes okay */
>      int i;
> diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
> index 8cee8c8e..e7a72ae3 100644
> --- a/src/openvpn/console_systemd.c
> +++ b/src/openvpn/console_systemd.c
> @@ -41,7 +41,7 @@
>   */
>  
>  static bool
> -check_systemd_running()
> +check_systemd_running(void)
>  {
>      struct stat c;
>  
> @@ -95,7 +95,7 @@ get_console_input_systemd(const char *prompt, const bool echo, char *input, cons
>   *
>   */
>  bool
> -query_user_exec()
> +query_user_exec(void)
>  {
>      bool ret = true;  /* Presume everything goes okay */
>      int i;
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 909e901f..692501d2 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1715,7 +1715,7 @@ static int nonce_secret_len = 0; /* GLOBAL */
>  
>  /* Reset the nonce value, also done periodically to refresh entropy */
>  static void
> -prng_reset_nonce()
> +prng_reset_nonce(void)
>  {
>      const int size = md_kt_size(nonce_md) + nonce_secret_len;
>  #if 1 /* Must be 1 for real usage */
> @@ -1799,7 +1799,7 @@ prng_bytes(uint8_t *output, int len)
>  
>  /* an analogue to the random() function, but use prng_bytes */
>  long int
> -get_random()
> +get_random(void)
>  {
>      long int l;
>      prng_bytes((unsigned char *)&l, sizeof(l));
> diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
> index f00a6d8f..f1b6c20a 100644
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -465,7 +465,7 @@ void prng_init(const char *md_name, const int nonce_secret_len_parm);
>   */
>  void prng_bytes(uint8_t *output, int len);
>  
> -void prng_uninit();
> +void prng_uninit(void);
>  
>  void test_crypto(struct crypto_options *co, struct frame *f);
>  
> diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
> index 7bd69695..a387a7e9 100644
> --- a/src/openvpn/crypto_mbedtls.c
> +++ b/src/openvpn/crypto_mbedtls.c
> @@ -160,7 +160,7 @@ print_cipher(const cipher_kt_t *info)
>  }
>  
>  void
> -show_available_ciphers()
> +show_available_ciphers(void)
>  {
>      const int *ciphers = mbedtls_cipher_list();
>  
> @@ -197,7 +197,7 @@ show_available_ciphers()
>  }
>  
>  void
> -show_available_digests()
> +show_available_digests(void)
>  {
>      const int *digests = mbedtls_md_list();
>  
> @@ -224,7 +224,7 @@ show_available_digests()
>  }
>  
>  void
> -show_available_engines()
> +show_available_engines(void)
>  {
>      printf("mbed TLS hardware crypto engine functionality is not available\n");
>  }
> @@ -243,7 +243,7 @@ show_available_engines()
>   * entropy gathering function.
>   */
>  mbedtls_ctr_drbg_context *
> -rand_ctx_get()
> +rand_ctx_get(void)
>  {
>      static mbedtls_entropy_context ec = {0};
>      static mbedtls_ctr_drbg_context cd_ctx = {0};
> @@ -282,7 +282,7 @@ rand_ctx_get()
>  
>  #ifdef ENABLE_PREDICTION_RESISTANCE
>  void
> -rand_ctx_enable_prediction_resistance()
> +rand_ctx_enable_prediction_resistance(void)
>  {
>      mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
>  
> diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
> index e457f3a9..18723856 100644
> --- a/src/openvpn/crypto_mbedtls.h
> +++ b/src/openvpn/crypto_mbedtls.h
> @@ -85,13 +85,13 @@ typedef mbedtls_md_context_t hmac_ctx_t;
>   * added. During initialisation, a personalisation string will be added based
>   * on the time, the PID, and a pointer to the random context.
>   */
> -mbedtls_ctr_drbg_context *rand_ctx_get();
> +mbedtls_ctr_drbg_context *rand_ctx_get(void);
>  
>  #ifdef ENABLE_PREDICTION_RESISTANCE
>  /**
>   * Enable prediction resistance on the random number generator.
>   */
> -void rand_ctx_enable_prediction_resistance();
> +void rand_ctx_enable_prediction_resistance(void);
>  
>  #endif
>  
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 1bbdfe47..8a043a68 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -286,7 +286,7 @@ print_cipher(const EVP_CIPHER *cipher)
>  }
>  
>  void
> -show_available_ciphers()
> +show_available_ciphers(void)
>  {
>      int nid;
>      size_t i;
> @@ -347,7 +347,7 @@ show_available_ciphers()
>  }
>  
>  void
> -show_available_digests()
> +show_available_digests(void)
>  {
>      int nid;
>  
> @@ -372,7 +372,7 @@ show_available_digests()
>  }
>  
>  void
> -show_available_engines()
> +show_available_engines(void)
>  {
>  #if HAVE_OPENSSL_ENGINE /* Only defined for OpenSSL */
>      ENGINE *e;
> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
> index 3817666b..04bf0da5 100644
> --- a/src/openvpn/error.c
> +++ b/src/openvpn/error.c
> @@ -159,7 +159,7 @@ set_machine_readable_output(bool parsable)
>  }
>  
>  void
> -error_reset()
> +error_reset(void)
>  {
>      use_syslog = std_redir = false;
>      suppress_timestamps = false;
> @@ -480,7 +480,7 @@ open_syslog(const char *pgmname, bool stdio_to_null)
>  }
>  
>  void
> -close_syslog()
> +close_syslog(void)
>  {
>  #if SYSLOG_CAPABILITY
>      if (use_syslog)
> @@ -635,7 +635,7 @@ unsigned int x_cs_verbose_level; /* GLOBAL */
>  unsigned int x_cs_err_delay_ms;  /* GLOBAL */
>  
>  void
> -reset_check_status()
> +reset_check_status(void)
>  {
>      x_cs_info_level = 0;
>      x_cs_verbose_level = 0;
> diff --git a/src/openvpn/error.h b/src/openvpn/error.h
> index 14ef7e65..023cec46 100644
> --- a/src/openvpn/error.h
> +++ b/src/openvpn/error.h
> @@ -261,7 +261,7 @@ void msg_forked(void);
>  
>  void open_syslog(const char *pgmname, bool stdio_to_null);
>  
> -void close_syslog();
> +void close_syslog(void);
>  
>  /* log file output */
>  void redirect_stdout_stderr(const char *file, bool append);
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index bc3b81e3..627da510 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1904,7 +1904,7 @@ do_close_tun(struct context *c, bool force)
>  }
>  
>  void
> -tun_abort()
> +tun_abort(void)
>  {
>      struct context *c = static_context;
>      if (c)
> diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
> index 8095c0b9..dd5dfbc8 100644
> --- a/src/openvpn/interval.h
> +++ b/src/openvpn/interval.h
> @@ -155,7 +155,7 @@ event_timeout_clear(struct event_timeout *et)
>  }
>  
>  static inline struct event_timeout
> -event_timeout_clear_ret()
> +event_timeout_clear_ret(void)
>  {
>      struct event_timeout ret;
>      event_timeout_clear(&ret);
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index ff948240..3bbe972e 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -68,7 +68,7 @@ static void man_output_standalone(struct management *man, volatile int *signal_r
>  static void man_reset_client_socket(struct management *man, const bool exiting);
>  
>  static void
> -man_help()
> +man_help(void)
>  {
>      msg(M_CLIENT, "Management Interface for %s", title_string);
>      msg(M_CLIENT, "Commands:");
> diff --git a/src/openvpn/occ-inline.h b/src/openvpn/occ-inline.h
> index 68e9098f..0fa8e5ba 100644
> --- a/src/openvpn/occ-inline.h
> +++ b/src/openvpn/occ-inline.h
> @@ -31,7 +31,7 @@
>   */
>  
>  static inline int
> -occ_reset_op()
> +occ_reset_op(void)
>  {
>      return -1;
>  }
> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
> index 30ae8fbc..a3ff5722 100644
> --- a/src/openvpn/packet_id.c
> +++ b/src/openvpn/packet_id.c
> @@ -643,7 +643,7 @@ packet_id_debug_print(int msglevel,
>  #ifdef PID_TEST
>  
>  void
> -packet_id_interactive_test()
> +packet_id_interactive_test(void)
>  {
>      struct packet_id pid;
>      struct packet_id_net pin;
> diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
> index a370936c..8509e590 100644
> --- a/src/openvpn/packet_id.h
> +++ b/src/openvpn/packet_id.h
> @@ -299,7 +299,7 @@ packet_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id *
>  const char *packet_id_net_print(const struct packet_id_net *pin, bool print_timestamp, struct gc_arena *gc);
>  
>  #ifdef PID_TEST
> -void packet_id_interactive_test();
> +void packet_id_interactive_test(void);
>  
>  #endif
>  
> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
> index 60418280..a0d0906a 100644
> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -356,7 +356,7 @@ cleanup:
>  }
>  
>  void
> -pkcs11_terminate()
> +pkcs11_terminate(void)
>  {
>      dmsg(
>          D_PKCS11_DEBUG,
> @@ -422,13 +422,13 @@ pkcs11_addProvider(
>  }
>  
>  int
> -pkcs11_logout()
> +pkcs11_logout(void)
>  {
>      return pkcs11h_logout() == CKR_OK;
>  }
>  
>  int
> -pkcs11_management_id_count()
> +pkcs11_management_id_count(void)
>  {
>      pkcs11h_certificate_id_list_t id_list = NULL;
>      pkcs11h_certificate_id_list_t t = NULL;
> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
> index d936890e..e942ba94 100644
> --- a/src/openvpn/platform.c
> +++ b/src/openvpn/platform.c
> @@ -173,7 +173,7 @@ platform_nice(int niceval)
>  
>  /* Get current PID */
>  unsigned int
> -platform_getpid()
> +platform_getpid(void)
>  {
>  #ifdef _WIN32
>      return (unsigned int) GetCurrentProcessId();
> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
> index c2b05cd9..45e24ded 100644
> --- a/src/openvpn/ps.c
> +++ b/src/openvpn/ps.c
> @@ -172,7 +172,7 @@ send_control(const socket_descriptor_t fd, int code)
>  }
>  
>  static int
> -cmsg_size()
> +cmsg_size(void)
>  {
>      return CMSG_SPACE(sizeof(socket_descriptor_t));
>  }
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 44a5ee0a..f5c59b77 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -347,7 +347,7 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
>  }
>  
>  void
> -init_ssl_lib()
> +init_ssl_lib(void)
>  {
>      tls_init_lib();
>  
> @@ -355,7 +355,7 @@ init_ssl_lib()
>  }
>  
>  void
> -free_ssl_lib()
> +free_ssl_lib(void)
>  {
>      crypto_uninit_lib();
>      prng_uninit();
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index 0b822ae3..02f64057 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -88,17 +88,17 @@ int pem_password_callback(char *buf, int size, int rwflag, void *u);
>   * Perform any static initialisation necessary by the library.
>   * Called on OpenVPN initialisation
>   */
> -void tls_init_lib();
> +void tls_init_lib(void);
>  
>  /**
>   * Free any global SSL library-specific data structures.
>   */
> -void tls_free_lib();
> +void tls_free_lib(void);
>  
>  /**
>   * Clear the underlying SSL library's error state.
>   */
> -void tls_clear_error();
> +void tls_clear_error(void);
>  
>  /**
>   * Parse a TLS version specifier
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 86d65e17..dd5b9854 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -63,17 +63,17 @@
>  #include <mbedtls/sha256.h>
>  
>  void
> -tls_init_lib()
> +tls_init_lib(void)
>  {
>  }
>  
>  void
> -tls_free_lib()
> +tls_free_lib(void)
>  {
>  }
>  
>  void
> -tls_clear_error()
> +tls_clear_error(void)
>  {
>  }
>  
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index dbaeb803..7ad6414e 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -69,7 +69,7 @@
>  int mydata_index; /* GLOBAL */
>  
>  void
> -tls_init_lib()
> +tls_init_lib(void)
>  {
>      SSL_library_init();
>  #ifndef ENABLE_SMALL
> @@ -82,7 +82,7 @@ tls_init_lib()
>  }
>  
>  void
> -tls_free_lib()
> +tls_free_lib(void)
>  {
>      EVP_cleanup();
>  #ifndef ENABLE_SMALL
> @@ -91,7 +91,7 @@ tls_free_lib()
>  }
>  
>  void
> -tls_clear_error()
> +tls_clear_error(void)
>  {
>      ERR_clear_error();
>  }
> @@ -1320,7 +1320,7 @@ static time_t biofp_last_open;                 /* GLOBAL */
>  static const int biofp_reopen_interval = 600;  /* GLOBAL */
>  
>  static void
> -close_biofp()
> +close_biofp(void)
>  {
>      if (biofp)
>      {
> @@ -1330,7 +1330,7 @@ close_biofp()
>  }
>  
>  static void
> -open_biofp()
> +open_biofp(void)
>  {
>      const time_t current = time(NULL);
>      const pid_t pid = getpid();
> @@ -1748,7 +1748,7 @@ show_available_tls_ciphers(const char *cipher_list)
>   * in the OpenSSL library.
>   */
>  void
> -show_available_curves()
> +show_available_curves(void)
>  {
>  #ifndef OPENSSL_NO_EC
>      EC_builtin_curve *curves = NULL;
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index d0b10bad..95fea5df 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -1235,7 +1235,7 @@ set_win_sys_path_via_env(struct env_set *es)
>  
>  
>  const char *
> -win_get_tempdir()
> +win_get_tempdir(void)
>  {
>      static char tmpdir[MAX_PATH];
>      WCHAR wtmpdir[MAX_PATH];
> @@ -1398,7 +1398,7 @@ win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel)
>  }
>  
>  int
> -win32_version_info()
> +win32_version_info(void)
>  {
>      if (!IsWindowsXPOrGreater())
>      {
> @@ -1426,7 +1426,7 @@ win32_version_info()
>  }
>  
>  bool
> -win32_is_64bit()
> +win32_is_64bit(void)
>  {
>  #if defined(_WIN64)
>      return true;  /* 64-bit programs run only on Win64 */
> diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
> index 21a1021a..7fc57ccc 100644
> --- a/src/openvpn/win32.h
> +++ b/src/openvpn/win32.h
> @@ -285,7 +285,7 @@ char *get_win_sys_path(void);
>  void fork_to_self(const char *cmdline);
>  
>  /* Find temporary directory */
> -const char *win_get_tempdir();
> +const char *win_get_tempdir(void);
>  
>  /* Convert a string from UTF-8 to UCS-2 */
>  WCHAR *wide_string(const char *utf8, struct gc_arena *gc);
> @@ -299,7 +299,7 @@ bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);
>  #define WIN_7 2
>  #define WIN_8 3
>  
> -int win32_version_info();
> +int win32_version_info(void);
>  
>  /*
>   * String representation of Windows version number and name, see
> 

ACK

-Steffan

