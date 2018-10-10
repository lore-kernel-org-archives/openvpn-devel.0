References: <20181008214923.11058-1-arne@...1227...>
 <20181010142527.27025-1-arne@...1227...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <304af9ee-f7b8-979e-4a5d-6f468392d0f0@...1435...>
Date: Wed, 10 Oct 2018 17:10:03 +0200
MIME-Version: 1.0
In-Reply-To: <20181010142527.27025-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] Remove MANAGMENT_EXTERNAL_KEY,
 MANAGMENT_IN_EXTRA, ENABLE_CLIENT_CR
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

Hi,

On 10-10-18 16:25, Arne Schwabe wrote:
> These defines are always defined when management is enabled.
> 
> We still have --disable-management as configure option, so we need
> to replace these with ENABLE_MANAGEMENT in some cases.
> 

Very nice, cleans up a lot of cruft.

> PATCH v3: Rebase directly on master
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/init.c        |  4 ++--
>  src/openvpn/manage.c      | 38 +++-----------------------------------
>  src/openvpn/manage.h      | 10 ----------
>  src/openvpn/misc.c        | 14 ++++++--------
>  src/openvpn/misc.h        |  6 +++---
>  src/openvpn/options.c     | 24 ++++++++++++------------
>  src/openvpn/options.h     |  2 +-
>  src/openvpn/push.c        |  2 +-
>  src/openvpn/ssl.c         | 16 ++++++++--------
>  src/openvpn/ssl.h         |  3 ++-
>  src/openvpn/ssl_backend.h |  4 ++--
>  src/openvpn/ssl_common.h  |  2 +-
>  src/openvpn/ssl_mbedtls.c |  4 ++--
>  src/openvpn/ssl_openssl.c |  4 ++--
>  src/openvpn/syshead.h     | 22 ----------------------
>  15 files changed, 45 insertions(+), 110 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 52c64da4..1b9f19d0 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -540,7 +540,7 @@ init_query_passwords(const struct context *c)
>      /* Auth user/pass input */
>      if (c->options.auth_user_pass_file)
>      {
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>          auth_user_pass_setup(c->options.auth_user_pass_file, &c->options.sc_info);
>  #else
>          auth_user_pass_setup(c->options.auth_user_pass_file, NULL);
> @@ -2800,7 +2800,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
>      to.x509_track = options->x509_track;
>  
>  #if P2MP
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>      to.sci = &options->sc_info;
>  #endif
>  #endif
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index ed981ab9..8b633f20 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -110,14 +110,12 @@ man_help(void)
>      msg(M_CLIENT, "client-pf CID          : Define packet filter for client CID (MULTILINE)");
>  #endif
>  #endif
> -#ifdef MANAGMENT_EXTERNAL_KEY
>      msg(M_CLIENT, "rsa-sig                : Enter a signature in response to >RSA_SIGN challenge");
>      msg(M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
>      msg(M_CLIENT, "pk-sig                 : Enter a signature in response to >PK_SIGN challenge");
>      msg(M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
>      msg(M_CLIENT, "certificate            : Enter a client certificate in response to >NEED-CERT challenge");
>      msg(M_CLIENT, "                         Enter certificate base64 on subsequent lines followed by END");
> -#endif
>      msg(M_CLIENT, "signal s               : Send signal s to daemon,");
>      msg(M_CLIENT, "                         s = SIGHUP|SIGTERM|SIGUSR1|SIGUSR2.");
>      msg(M_CLIENT, "state [on|off] [N|all] : Like log, but show state history.");
> @@ -847,8 +845,6 @@ man_hold(struct management *man, const char *cmd)
>      }
>  }
>  
> -#ifdef MANAGEMENT_IN_EXTRA
> -
>  #define IER_RESET      0
>  #define IER_NEW        1
>  
> @@ -936,7 +932,6 @@ in_extra_dispatch(struct management *man)
>              break;
>  
>  #endif /* ifdef MANAGEMENT_PF */
> -#ifdef MANAGMENT_EXTERNAL_KEY
>          case IEC_PK_SIGN:
>              man->connection.ext_key_state = EKS_READY;
>              buffer_list_free(man->connection.ext_key_input);
> @@ -950,13 +945,10 @@ in_extra_dispatch(struct management *man)
>              man->connection.ext_cert_input = man->connection.in_extra;
>              man->connection.in_extra = NULL;
>              return;
> -#endif
>      }
>      in_extra_reset(&man->connection, IER_RESET);
>  }
>  
> -#endif /* MANAGEMENT_IN_EXTRA */
> -
>  #ifdef MANAGEMENT_DEF_AUTH
>  
>  static bool
> @@ -1102,8 +1094,6 @@ man_client_pf(struct management *man, const char *cid_str)
>  #endif /* MANAGEMENT_PF */
>  #endif /* MANAGEMENT_DEF_AUTH */
>  
> -#ifdef MANAGMENT_EXTERNAL_KEY
> -
>  static void
>  man_pk_sig(struct management *man, const char *cmd_name)
>  {
> @@ -1136,8 +1126,6 @@ man_certificate(struct management *man)
>      }
>  }
>  
> -#endif /* ifdef MANAGMENT_EXTERNAL_KEY */
> -
>  static void
>  man_load_stats(struct management *man)
>  {
> @@ -1526,7 +1514,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
>      }
>  #endif
>  #endif /* ifdef MANAGEMENT_DEF_AUTH */
> -#ifdef MANAGMENT_EXTERNAL_KEY
>      else if (streq(p[0], "rsa-sig"))
>      {
>          man_pk_sig(man, "rsa-sig");
> @@ -1539,7 +1526,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
>      {
>          man_certificate(man);
>      }
> -#endif
>  #ifdef ENABLE_PKCS11
>      else if (streq(p[0], "pkcs11-id-count"))
>      {
> @@ -1928,9 +1914,7 @@ man_reset_client_socket(struct management *man, const bool exiting)
>          man->connection.state = MS_INITIAL;
>          command_line_reset(man->connection.in);
>          buffer_list_reset(man->connection.out);
> -#ifdef MANAGEMENT_IN_EXTRA
>          in_extra_reset(&man->connection, IER_RESET);
> -#endif
>          msg(D_MANAGEMENT, "MANAGEMENT: Client disconnected");
>      }
>      if (!exiting)
> @@ -1972,9 +1956,7 @@ man_process_command(struct management *man, const char *line)
>  
>      CLEAR(parms);
>      so = status_open(NULL, 0, -1, &man->persist.vout, 0);
> -#ifdef MANAGEMENT_IN_EXTRA
>      in_extra_reset(&man->connection, IER_RESET);
> -#endif
>  
>      if (man_password_needed(man))
>      {
> @@ -2212,7 +2194,6 @@ man_read(struct management *man)
>              const char *line;
>              while ((line = command_line_get(man->connection.in)))
>              {
> -#ifdef MANAGEMENT_IN_EXTRA
>                  if (man->connection.in_extra)
>                  {
>                      if (!strcmp(line, "END"))
> @@ -2225,8 +2206,9 @@ man_read(struct management *man)
>                      }
>                  }
>                  else
> -#endif
> -                man_process_command(man, (char *) line);
> +                {
> +                    man_process_command(man, (char *) line);
> +                }
>                  if (man->connection.halt)
>                  {
>                      break;
> @@ -2572,12 +2554,8 @@ man_connection_close(struct management *man)
>      {
>          buffer_list_free(mc->out);
>      }
> -#ifdef MANAGEMENT_IN_EXTRA
>      in_extra_reset(&man->connection, IER_RESET);
> -#endif
> -#ifdef MANAGMENT_EXTERNAL_KEY
>      buffer_list_free(mc->ext_key_input);
> -#endif
>      man_connection_clear(mc);
>  }
>  
> @@ -3412,9 +3390,7 @@ management_query_user_pass(struct management *man,
>          const char *alert_type = NULL;
>          const char *prefix = NULL;
>          unsigned int up_query_mode = 0;
> -#ifdef ENABLE_CLIENT_CR
>          const char *sc = NULL;
> -#endif
>          ret = true;
>          man->persist.standalone_disabled = false; /* This is so M_CLIENT messages will be correctly passed through msg() */
>          man->persist.special_state_msg = NULL;
> @@ -3444,12 +3420,10 @@ management_query_user_pass(struct management *man,
>              up_query_mode = UP_QUERY_USER_PASS;
>              prefix = "PASSWORD";
>              alert_type = "username/password";
> -#ifdef ENABLE_CLIENT_CR
>              if (static_challenge)
>              {
>                  sc = static_challenge;
>              }
> -#endif
>          }
>          buf_printf(&alert_msg, ">%s:Need '%s' %s",
>                     prefix,
> @@ -3461,14 +3435,12 @@ management_query_user_pass(struct management *man,
>              buf_printf(&alert_msg, " MSG:%s", up->username);
>          }
>  
> -#ifdef ENABLE_CLIENT_CR
>          if (sc)
>          {
>              buf_printf(&alert_msg, " SC:%d,%s",
>                         BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO),
>                         sc);
>          }
> -#endif
>  
>          man_wait_for_client_connection(man, &signal_received, 0, MWCC_PASSWORD_WAIT);
>          if (signal_received)
> @@ -3531,8 +3503,6 @@ management_query_user_pass(struct management *man,
>      return ret;
>  }
>  
> -#ifdef MANAGMENT_EXTERNAL_KEY
> -
>  static int
>  management_query_multiline(struct management *man,
>                             const char *b64_data, const char *prompt, const char *cmd, int *state, struct buffer_list **input)
> @@ -3699,8 +3669,6 @@ management_query_cert(struct management *man, const char *cert_name)
>      return result;
>  }
>  
> -#endif /* ifdef MANAGMENT_EXTERNAL_KEY */
> -
>  /*
>   * Return true if management_hold() would block
>   */
> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
> index ff143fc1..d24abe09 100644
> --- a/src/openvpn/manage.h
> +++ b/src/openvpn/manage.h
> @@ -275,7 +275,6 @@ struct man_connection {
>      struct command_line *in;
>      struct buffer_list *out;
>  
> -#ifdef MANAGEMENT_IN_EXTRA
>  #define IEC_UNDEF       0
>  #define IEC_CLIENT_AUTH 1
>  #define IEC_CLIENT_PF   2
> @@ -288,7 +287,6 @@ struct man_connection {
>      unsigned long in_extra_cid;
>      unsigned int in_extra_kid;
>  #endif
> -#ifdef MANAGMENT_EXTERNAL_KEY
>  #define EKS_UNDEF   0
>  #define EKS_SOLICIT 1
>  #define EKS_INPUT   2
> @@ -297,8 +295,6 @@ struct man_connection {
>      struct buffer_list *ext_key_input;
>      int ext_cert_state;
>      struct buffer_list *ext_cert_input;
> -#endif
> -#endif /* ifdef MANAGEMENT_IN_EXTRA */
>      struct event_set *es;
>      int env_filter_level;
>  
> @@ -346,9 +342,7 @@ struct management *management_init(void);
>  #define MF_CLIENT_PF         (1<<7)
>  #endif
>  #define MF_UNIX_SOCK       (1<<8)
> -#ifdef MANAGMENT_EXTERNAL_KEY
>  #define MF_EXTERNAL_KEY    (1<<9)
> -#endif
>  #define MF_UP_DOWN          (1<<10)
>  #define MF_QUERY_REMOTE     (1<<11)
>  #define MF_QUERY_PROXY      (1<<12)
> @@ -436,14 +430,10 @@ void management_learn_addr(struct management *management,
>  
>  #endif
>  
> -#ifdef MANAGMENT_EXTERNAL_KEY
> -
>  char *management_query_pk_sig(struct management *man, const char *b64_data);
>  
>  char *management_query_cert(struct management *man, const char *cert_name);
>  
> -#endif
> -
>  static inline bool
>  management_connected(const struct management *man)
>  {
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 2759d98d..d75b7685 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -157,12 +157,10 @@ get_user_pass_cr(struct user_pass *up,
>                  management_auth_failure(management, prefix, "previous auth credentials failed");
>              }
>  
> -#ifdef ENABLE_CLIENT_CR
>              if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
>              {
>                  sc = auth_challenge;
>              }
> -#endif
>              if (!management_query_user_pass(management, up, prefix, flags, sc))
>              {
>                  if ((flags & GET_USER_PASS_NOFATAL) != 0)
> @@ -272,7 +270,7 @@ get_user_pass_cr(struct user_pass *up,
>           */
>          if (username_from_stdin || password_from_stdin || response_from_stdin)
>          {
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>              if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE) && response_from_stdin)
>              {
>                  struct auth_challenge_info *ac = get_auth_challenge(auth_challenge, &gc);
> @@ -299,7 +297,7 @@ get_user_pass_cr(struct user_pass *up,
>                  }
>              }
>              else
> -#endif /* ifdef ENABLE_CLIENT_CR */
> +#endif /* ifdef ENABLE_MANAGEMENT */
>              {
>                  struct buffer user_prompt = alloc_buf_gc(128, &gc);
>                  struct buffer pass_prompt = alloc_buf_gc(128, &gc);
> @@ -333,7 +331,7 @@ get_user_pass_cr(struct user_pass *up,
>                      }
>                  }
>  
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>                  if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE) && response_from_stdin)
>                  {
>                      char *response = (char *) gc_malloc(USER_PASS_LEN, false, &gc);
> @@ -361,7 +359,7 @@ get_user_pass_cr(struct user_pass *up,
>                      string_clear(resp64);
>                      free(resp64);
>                  }
> -#endif /* ifdef ENABLE_CLIENT_CR */
> +#endif /* ifdef ENABLE_MANAGEMENT */
>              }
>          }
>  
> @@ -380,7 +378,7 @@ get_user_pass_cr(struct user_pass *up,
>      return true;
>  }
>  
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>  
>  /*
>   * See management/management-notes.txt for more info on the
> @@ -455,7 +453,7 @@ get_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
>      }
>  }
>  
> -#endif /* ifdef ENABLE_CLIENT_CR */
> +#endif /* ifdef ENABLE_MANAGEMENT */
>  
>  void
>  purge_user_pass(struct user_pass *up, const bool force)
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index b4d9d035..a54185f0 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -76,7 +76,7 @@ struct user_pass
>      char password[USER_PASS_LEN];
>  };
>  
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>  /*
>   * Challenge response info on client as pushed by server.
>   */
> @@ -102,10 +102,10 @@ struct static_challenge_info {
>      const char *challenge_text;
>  };
>  
> -#else  /* ifdef ENABLE_CLIENT_CR */
> +#else  /* ifdef ENABLE_MANAGEMENT */
>  struct auth_challenge_info {};
>  struct static_challenge_info {};
> -#endif /* ifdef ENABLE_CLIENT_CR */
> +#endif /* ifdef ENABLE_MANAGEMENT */
>  
>  /*
>   * Flags for get_user_pass and management_query_user_pass
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e42029c5..f0762f2e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1735,7 +1735,7 @@ show_settings(const struct options *o)
>      SHOW_STR(ca_file);
>      SHOW_STR(ca_path);
>      SHOW_STR(dh_file);
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>      if ((o->management_flags & MF_EXTERNAL_CERT))
>      {
>          SHOW_PARM("cert_file","EXTERNAL_CERT","%s");
> @@ -1745,7 +1745,7 @@ show_settings(const struct options *o)
>      SHOW_STR(cert_file);
>      SHOW_STR(extra_certs_file);
>  
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>      if ((o->management_flags & MF_EXTERNAL_KEY))
>      {
>          SHOW_PARM("priv_key_file","EXTERNAL_PRIVATE_KEY","%s");
> @@ -2567,7 +2567,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>              {
>                  msg(M_USAGE, "Parameter --key cannot be used when --pkcs11-provider is also specified.");
>              }
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>              if (options->management_flags & MF_EXTERNAL_KEY)
>              {
>                  msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs11-provider is also specified.");
> @@ -2590,7 +2590,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>          }
>          else
>  #endif /* ifdef ENABLE_PKCS11 */
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>          if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
>          {
>              msg(M_USAGE, "--key and --management-external-key are mutually exclusive");
> @@ -2627,7 +2627,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>              {
>                  msg(M_USAGE, "Parameter --pkcs12 cannot be used when --cryptoapicert is also specified.");
>              }
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>              if (options->management_flags & MF_EXTERNAL_KEY)
>              {
>                  msg(M_USAGE, "Parameter --management-external-key cannot be used when --cryptoapicert is also specified.");
> @@ -2657,7 +2657,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>              {
>                  msg(M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
>              }
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>              if (options->management_flags & MF_EXTERNAL_KEY)
>              {
>                  msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs12 is also specified.");
> @@ -2690,7 +2690,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>              {
>  
>                  const int sum =
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>                      ((options->cert_file != NULL) || (options->management_flags & MF_EXTERNAL_CERT))
>                      +((options->priv_key_file != NULL) || (options->management_flags & MF_EXTERNAL_KEY));
>  #else
> @@ -2714,11 +2714,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>              }
>              else
>              {
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>                  if (!(options->management_flags & MF_EXTERNAL_CERT))
>  #endif
>                  notnull(options->cert_file, "certificate file (--cert) or PKCS#12 file (--pkcs12)");
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>                  if (!(options->management_flags & MF_EXTERNAL_KEY))
>  #endif
>                  notnull(options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
> @@ -3308,7 +3308,7 @@ options_postprocess_filechecks(struct options *options)
>      errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
>      errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
>                                "--extra-certs");
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>      if (!(options->management_flags & MF_EXTERNAL_KEY))
>  #endif
>      {
> @@ -5155,7 +5155,7 @@ add_option(struct options *options,
>          options->management_flags |= MF_CONNECT_AS_CLIENT;
>          options->management_write_peer_info_file = p[1];
>      }
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>      else if (streq(p[0], "management-external-key") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> @@ -7023,7 +7023,7 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          auth_retry_set(msglevel, p[1]);
>      }
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>      else if (streq(p[0], "static-challenge") && p[1] && p[2] && !p[3])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index acbd1087..33aa71f7 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -469,7 +469,7 @@ struct options
>  
>      int scheduled_exit_interval;
>  
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>      struct static_challenge_info sc_info;
>  #endif
>  #endif /* if P2MP */
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index a7ec4dd6..72f09962 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -88,7 +88,7 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
>           * Save the dynamic-challenge text even when management is defined
>           */
>          {
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>              struct buffer buf = *buffer;
>              if (buf_string_match_head_str(&buf, "AUTH_FAILED,CRV1:") && BLEN(&buf))
>              {
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 455adfb7..58261e66 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -399,7 +399,7 @@ pem_password_callback(char *buf, int size, int rwflag, void *u)
>  static bool auth_user_pass_enabled;     /* GLOBAL */
>  static struct user_pass auth_user_pass; /* GLOBAL */
>  
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>  static char *auth_challenge; /* GLOBAL */
>  #endif
>  
> @@ -409,7 +409,7 @@ auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *
>      auth_user_pass_enabled = true;
>      if (!auth_user_pass.defined)
>      {
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>          if (auth_challenge) /* dynamic challenge/response */
>          {
>              get_user_pass_cr(&auth_user_pass,
> @@ -432,7 +432,7 @@ auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *
>                               sci->challenge_text);
>          }
>          else
> -#endif /* ifdef ENABLE_CLIENT_CR */
> +#endif /* ifdef ENABLE_MANAGEMENT */
>          get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT);
>      }
>  }
> @@ -480,12 +480,12 @@ ssl_purge_auth(const bool auth_user_pass_only)
>          purge_user_pass(&passbuf, true);
>      }
>      purge_user_pass(&auth_user_pass, true);
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>      ssl_purge_auth_challenge();
>  #endif
>  }
>  
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>  
>  void
>  ssl_purge_auth_challenge(void)
> @@ -652,7 +652,7 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
>          tls_ctx_load_cryptoapi(new_ctx, options->cryptoapi_cert);
>      }
>  #endif
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>      else if (options->management_flags & MF_EXTERNAL_CERT)
>      {
>          char *cert = management_query_cert(management,
> @@ -674,7 +674,7 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
>              goto err;
>          }
>      }
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>      else if (options->management_flags & MF_EXTERNAL_KEY)
>      {
>          if (tls_ctx_use_management_external_key(new_ctx))
> @@ -2364,7 +2364,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
>      /* write username/password if specified */
>      if (auth_user_pass_enabled)
>      {
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>          auth_user_pass_setup(session->opt->auth_user_pass_file, session->opt->sci);
>  #else
>          auth_user_pass_setup(session->opt->auth_user_pass_file, NULL);
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 72227d97..a1bd9bf0 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -428,7 +428,8 @@ void ssl_purge_auth(const bool auth_user_pass_only);
>  
>  void ssl_set_auth_token(const char *token);
>  
> -#ifdef ENABLE_CLIENT_CR
> +
> +#ifdef  ENABLE_MANAGEMENT

This inserts a superfluous newline and space.

>  /*
>   * ssl_get_auth_challenge will parse the server-pushed auth-failed
>   * reason string and return a dynamically allocated
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index 5023c02a..856e809f 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -272,7 +272,7 @@ void tls_ctx_load_cert_file(struct tls_root_ctx *ctx, const char *cert_file,
>  int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
>                             const char *priv_key_file_inline);
>  
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>  
>  /**
>   * Tell the management interface to load the given certificate and the external
> @@ -284,7 +284,7 @@ int tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
>   */
>  int tls_ctx_use_management_external_key(struct tls_root_ctx *ctx);
>  
> -#endif /* MANAGMENT_EXTERNAL_KEY */
> +#endif /* ENABLE_MANAGEMENT */
>  
>  /**
>   * Load certificate authority certificates from the given file or path.
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 08ef6ffa..919ec57c 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -332,7 +332,7 @@ struct tls_options
>  
>      const struct x509_track *x509_track;
>  
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>      const struct static_challenge_info *sci;
>  #endif
>  
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index e4850cb6..00e5d819 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -605,7 +605,7 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
>      return 0;
>  }
>  
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>  
>  /** Query the management interface for a signature, see external_sign_func. */
>  static bool
> @@ -645,7 +645,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
>      return tls_ctx_use_external_signing_func(ctx, management_sign_func, NULL);
>  }
>  
> -#endif /* ifdef MANAGMENT_EXTERNAL_KEY */
> +#endif /* ifdef ENABLE_MANAGEMENT */
>  
>  void
>  tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 1a66d178..0858d5eb 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -997,7 +997,7 @@ end:
>  }
>  
>  
> -#ifdef MANAGMENT_EXTERNAL_KEY
> +#ifdef ENABLE_MANAGEMENT
>  
>  /* encrypt */
>  static int
> @@ -1340,7 +1340,7 @@ cleanup:
>      return ret;
>  }
>  
> -#endif /* ifdef MANAGMENT_EXTERNAL_KEY */
> +#endif /* ifdef ENABLE_MANAGEMENT */
>  
>  static int
>  sk_x509_name_cmp(const X509_NAME *const *a, const X509_NAME *const *b)
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index 487b32a6..d2a50341 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -548,26 +548,11 @@ socket_defined(const socket_descriptor_t sd)
>  #undef ENABLE_DEF_AUTH
>  #endif
>  
> -/*
> - * Enable external private key
> - */
> -#if defined(ENABLE_MANAGEMENT)
> -#define MANAGMENT_EXTERNAL_KEY
> -#endif
> -
>  /* Enable mbed TLS RNG prediction resistance support */
>  #ifdef ENABLE_CRYPTO_MBEDTLS
>  #define ENABLE_PREDICTION_RESISTANCE
>  #endif /* ENABLE_CRYPTO_MBEDTLS */
>  
> -/*
> - * MANAGEMENT_IN_EXTRA allows the management interface to
> - * read multi-line inputs from clients.
> - */
> -#if defined(MANAGEMENT_DEF_AUTH) || defined(MANAGMENT_EXTERNAL_KEY)
> -#define MANAGEMENT_IN_EXTRA
> -#endif
> -
>  /*
>   * Enable packet filter?
>   */
> @@ -658,13 +643,6 @@ socket_defined(const socket_descriptor_t sd)
>  #define CONNECT_NONBLOCK
>  #endif
>  
> -/*
> - * Do we support challenge/response authentication as client?
> - */
> -#if defined(ENABLE_MANAGEMENT)
> -#define ENABLE_CLIENT_CR
> -#endif
> -
>  /*
>   * Compression support
>   */
> 

Apart from the single whitespace nit, this looks good, compiles fine
with and without --disable-management, and passes basic sanity checks.

Acked-by: Steffan Karger <steffan.karger@...1435...>

-Steffan

