References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <fbc426b7-66d0-451d-a306-df74644af09d@...2181...>
Date: Tue, 27 Apr 2021 11:57:56 +0200
MIME-Version: 1.0
In-Reply-To: <20210422151724.2132573-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/7] Use functions to access key_state
 instead direct member access
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

On 22/04/2021 17:17, Arne Schwabe wrote:
> This uses get_key_scan and get_primary key instead the directly
> accessing the members of the struct to improve readiability of
> the code.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c      |  3 +--
>  src/openvpn/push.c       |  9 ++++-----
>  src/openvpn/ssl.c        | 11 +++--------
>  src/openvpn/ssl.h        |  2 +-
>  src/openvpn/ssl_common.h |  9 +++++++++
>  5 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index d51316de2..666456da9 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1800,8 +1800,7 @@ multi_client_set_protocol_options(struct context *c)
>       * cipher -> so log the fact and push the "what we have now" cipher
>       * (so the client is always told what we expect it to use)
>       */
> -    const struct tls_session *session = &tls_multi->session[TM_ACTIVE];
> -    if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
> +    if (get_primary_key(tls_multi)->crypto_options.key_ctx_bi.initialized)
>      {
>          msg(M_INFO, "PUSH: client wants to negotiate cipher (NCP), but "
>              "server has already generated data channel keys, "
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index bba555fa1..fcafc5003 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -222,7 +222,7 @@ receive_cr_response(struct context *c, const struct buffer *buffer)
>      struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
>      struct man_def_auth_context *mda = session->opt->mda_context;
>      struct env_set *es = session->opt->es;
> -    int key_id = session->key[KS_PRIMARY].key_id;
> +    int key_id = get_primary_key(c->c2.tls_multi)->key_id;
>  
>  
>      management_notify_client_cr_response(key_id, mda, es, m);
> @@ -304,7 +304,7 @@ receive_auth_pending(struct context *c, const struct buffer *buffer)
>                  "to %us", c->options.handshake_window,
>                  min_uint(max_timeout, server_timeout));
>  
> -    struct key_state *ks = &c->c2.tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
> +    const struct key_state *ks = get_primary_key(c->c2.tls_multi);
>      c->c2.push_request_timeout = ks->established + min_uint(max_timeout, server_timeout);
>  }
>  
> @@ -369,7 +369,7 @@ bool
>  send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
>                             unsigned int timeout)
>  {
> -    struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
> +    struct key_state *ks = get_key_scan(tls_multi, 0);

why not calling get_primary_key() here and in all other spots where we
ask for the 0th key in the scan?

>  
>      static const char info_pre[] = "INFO_PRE,";
>  
> @@ -476,8 +476,7 @@ cleanup:
>  bool
>  send_push_request(struct context *c)
>  {
> -    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
> -    struct key_state *ks = &session->key[KS_PRIMARY];
> +    const struct key_state *ks = get_primary_key(c->c2.tls_multi);
>  
>      /* We timeout here under two conditions:
>       * a) we reached the hard limit of push_request_timeout
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 3bc84e02c..7d66cf565 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -3448,7 +3448,7 @@ tls_pre_decrypt(struct tls_multi *multi,
>      if (i == TM_SIZE && is_hard_reset_method2(op))
>      {
>          struct tls_session *session = &multi->session[TM_ACTIVE];
> -        struct key_state *ks = &session->key[KS_PRIMARY];
> +        const struct key_state *ks = get_primary_key(multi);
>  
>          /*
>           * If we have no session currently in progress, the initial packet will
> @@ -3933,7 +3933,6 @@ tls_send_payload(struct tls_multi *multi,
>                   const uint8_t *data,
>                   int size)
>  {
> -    struct tls_session *session;
>      struct key_state *ks;
>      bool ret = false;
>  
> @@ -3941,8 +3940,7 @@ tls_send_payload(struct tls_multi *multi,
>  
>      ASSERT(multi);
>  
> -    session = &multi->session[TM_ACTIVE];
> -    ks = &session->key[KS_PRIMARY];
> +    ks = get_key_scan(multi, 0);
>  
>      if (ks->state >= S_ACTIVE)
>      {
> @@ -3971,16 +3969,13 @@ bool
>  tls_rec_payload(struct tls_multi *multi,
>                  struct buffer *buf)
>  {
> -    struct tls_session *session;
> -    struct key_state *ks;
>      bool ret = false;
>  
>      tls_clear_error();
>  
>      ASSERT(multi);
>  
> -    session = &multi->session[TM_ACTIVE];
> -    ks = &session->key[KS_PRIMARY];
> +    struct key_state *ks = get_key_scan(multi, 0);
>  
>      if (ks->state >= S_ACTIVE && BLEN(&ks->plaintext_read_buf))
>      {
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 135c60732..2791143f6 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -547,7 +547,7 @@ tls_test_payload_len(const struct tls_multi *multi)
>  {
>      if (multi)
>      {
> -        const struct key_state *ks = &multi->session[TM_ACTIVE].key[KS_PRIMARY];
> +        const struct key_state *ks = get_primary_key(multi);
>          if (ks->state >= S_ACTIVE)
>          {
>              return BLEN(&ks->plaintext_read_buf);
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 514cdd964..9c923f2a6 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -631,4 +631,13 @@ get_key_scan(struct tls_multi *multi, int index)
>      }
>  }
>  
> +/**  gets an item  of \c key_state objects in the
> + *   order they should be scanned by data
> + *   channel modules. */
> +static inline const struct key_state *
> +get_primary_key(const struct tls_multi *multi)
> +{
> +        return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
> +}

Why not implementing this as get_key_scan(multi, 0); ?

> +
>  #endif /* SSL_COMMON_H_ */
> 


Regards,

-- 
Antonio Quartulli

