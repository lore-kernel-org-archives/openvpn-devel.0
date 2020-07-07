References: <20200707121615.15736-1-arne@...1227...>
 <20200707121615.15736-5-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7b7ac63f-eb06-2e02-e6ee-580c42da2cf7@...2181...>
Date: Tue, 7 Jul 2020 18:20:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200707121615.15736-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/3] Make key_state->authenticated more
 state machine like
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 07/07/2020 14:16, Arne Schwabe wrote:
> This order the states from unauthenticated to authenticated and also
> changes the comparison for KS_AUTH_FALSE from != to >
> 
> Also remove a now obsolete comment and two obsolete ifdefs. While
> keeping the ifdef in ssl_verify would save a few bytes of code,
> this is too minor to justify keeping the ifdef
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c        |  6 +++---
>  src/openvpn/ssl_common.h |  7 ++-----
>  src/openvpn/ssl_verify.c | 15 ++++-----------
>  3 files changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 71565dd3..c73b51c3 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2465,7 +2465,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
>       */
>      if (session->opt->server && !(session->opt->mode == MODE_SERVER && ks->key_id <= 0))
>      {
> -        if (ks->authenticated != KS_AUTH_FALSE)
> +        if (ks->authenticated > KS_AUTH_FALSE)
>          {
>              if (!tls_session_generate_data_channel_keys(session))
>              {
> @@ -2646,7 +2646,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>      secure_memzero(up, sizeof(*up));
>  
>      /* Perform final authentication checks */
> -    if (ks->authenticated != KS_AUTH_FALSE)
> +    if (ks->authenticated > KS_AUTH_FALSE)
>      {
>          verify_final_auth_checks(multi, session);
>      }
> @@ -2671,7 +2671,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
>       * Call OPENVPN_PLUGIN_TLS_FINAL plugin if defined, for final
>       * veto opportunity over authentication decision.
>       */
> -    if ((ks->authenticated != KS_AUTH_FALSE)
> +    if ((ks->authenticated > KS_AUTH_FALSE)
>          && plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
>      {
>          key_state_export_keying_material(&ks->ks_ssl, session);
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index fdf589b5..7d841ffb 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -129,8 +129,8 @@ struct key_source2 {
>  
>  enum ks_auth_state {
>    KS_AUTH_FALSE,

I suggest to add comments here describing how states work and how new
states should be added.

I.e. something like: "any state before or equal to KS_AUTH_FALSE is
considered unauthorized". Not sure the terminology is right, but
something like this would help introducing new states, like Steffan
reported before.

Maybe he has additional comments too.


Regards,

> -  KS_AUTH_TRUE,
> -  KS_AUTH_DEFERRED
> +  KS_AUTH_DEFERRED,
> +  KS_AUTH_TRUE
>  };
>  
>  /**
> @@ -194,8 +194,6 @@ struct key_state
>      enum ks_auth_state authenticated;
>      time_t auth_deferred_expire;
>  
> -#ifdef ENABLE_DEF_AUTH
> -    /* If auth_deferred is true, authentication is being deferred */
>  #ifdef MANAGEMENT_DEF_AUTH
>      unsigned int mda_key_id;
>      unsigned int mda_status;
> @@ -205,7 +203,6 @@ struct key_state
>      time_t acf_last_mod;
>      char *auth_control_file;
>  #endif
> -#endif
>  };
>  
>  /** Control channel wrapping (--tls-auth/--tls-crypt) context */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index e28f1f3a..6996d430 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -950,7 +950,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>              if (DECRYPT_KEY_ENABLED(multi, ks))
>              {
>                  active = true;
> -                if (ks->authenticated != KS_AUTH_FALSE)
> +                if (ks->authenticated > KS_AUTH_FALSE)
>                  {
>  #ifdef ENABLE_DEF_AUTH
>                      unsigned int s1 = ACF_DISABLED;
> @@ -1414,17 +1414,10 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
>               */
>              send_push_reply_auth_token(multi);
>          }
> -#ifdef ENABLE_DEF_AUTH
>          msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
>              (ks->authenticated == KS_AUTH_DEFERRED) ? "deferred" : "succeeded",
>              up->username,
>              (session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
> -#else
> -        msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
> -            "succeeded",
> -            up->username,
> -            (session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
> -#endif
>      }
>      else
>      {
> @@ -1445,7 +1438,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
>      }
>  
>      /* Don't allow the CN to change once it's been locked */
> -    if (ks->authenticated != KS_AUTH_FALSE && multi->locked_cn)
> +    if (ks->authenticated > KS_AUTH_FALSE && multi->locked_cn)
>      {
>          const char *cn = session->common_name;
>          if (cn && strcmp(cn, multi->locked_cn))
> @@ -1461,7 +1454,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
>      }
>  
>      /* Don't allow the cert hashes to change once they have been locked */
> -    if (ks->authenticated != KS_AUTH_FALSE && multi->locked_cert_hash_set)
> +    if (ks->authenticated > KS_AUTH_FALSE && multi->locked_cert_hash_set)
>      {
>          const struct cert_hash_set *chs = session->cert_hash_set;
>          if (chs && !cert_hash_compare(chs, multi->locked_cert_hash_set))
> @@ -1475,7 +1468,7 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
>      }
>  
>      /* verify --client-config-dir based authentication */
> -    if (ks->authenticated != KS_AUTH_FALSE && session->opt->client_config_dir_exclusive)
> +    if (ks->authenticated > KS_AUTH_FALSE && session->opt->client_config_dir_exclusive)
>      {
>          struct gc_arena gc = gc_new();
>  
> 

-- 
Antonio Quartulli

