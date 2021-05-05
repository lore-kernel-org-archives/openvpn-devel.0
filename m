References: <20210422151724.2132573-1-arne@...1227...>
 <20210503125335.3918335-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0e4dfb6e-66fe-bfe4-a588-551c88043d54@...2181...>
Date: Thu, 6 May 2021 01:23:09 +0200
MIME-Version: 1.0
In-Reply-To: <20210503125335.3918335-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] Return cached result in
 tls_authentication_status
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

Something in this patch is not working as expected.

I tested with master + this patch.

When a client connects and inputs the wrong password, the server goes
into a loop:

2021-05-06 00:50:46 10.10.10.2:1194 Delayed exit in 5 seconds
2021-05-06 00:50:46 10.10.10.2:1194 SENT CONTROL [client]: 'AUTH_FAILED'
(status=1)
2021-05-06 00:50:46 10.10.10.2:1194 Delayed exit in 5 seconds
2021-05-06 00:50:46 10.10.10.2:1194 SENT CONTROL [client]: 'AUTH_FAILED'
(status=1)
2021-05-06 00:50:46 10.10.10.2:1194 Delayed exit in 5 seconds
2021-05-06 00:50:46 10.10.10.2:1194 SENT CONTROL [client]: 'AUTH_FAILED'
(status=1)

and goes on...

Without this patch I don't see this problem.

After adding some debug messages I saw that without this patch the
return value of tls_authentication_status() in tls_multi_process() is
*always* UNDEFINED, also after the auth failure.

This said I stopped digging there because the bed is calling...

Arne, maybe you can spot what's wrong?

Regards,

On 03/05/2021 14:53, Arne Schwabe wrote:
> tls_authentication_status does caching to avoid file I/O more than
> every TLS_MULTI_AUTH_STATUS_INTERVAL (10s) per connection. But
> counter-intuitively it does not return the cached result but rather
> TLS_AUTHENTICATION_UNDEFINED if the cache is not refreshed by the call.
> 
> This is workarounded by forcing a refresh in some areas of the code
> (latency = 0).
> 
> This patch changes the behaviour by always returning the last known
> status and only updating the file status when the i/o timeout for the
> caches is reached.
> 
> The patch also changes the DEFINE enum into a real enum.
> 
> Patch v2: only update tas_cache_last_udpate when actually updating the cache.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c      |  2 +-
>  src/openvpn/push.c       |  3 ++-
>  src/openvpn/ssl_common.h | 16 +++++++++---
>  src/openvpn/ssl_verify.c | 53 ++++++++++++++++++++++------------------
>  src/openvpn/ssl_verify.h |  3 +--
>  5 files changed, 46 insertions(+), 31 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 666456da9..ab2270a58 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2596,7 +2596,7 @@ static const multi_client_connect_handler client_connect_handlers[] = {
>  static void
>  multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>  {
> -    if (tls_authentication_status(mi->context.c2.tls_multi, 0)
> +    if (tls_authentication_status(mi->context.c2.tls_multi, TLS_MULTI_AUTH_STATUS_INTERVAL)
>          != TLS_AUTHENTICATION_SUCCEEDED)
>      {
>          return;
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index fcafc5003..428efb68e 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -855,7 +855,8 @@ process_incoming_push_request(struct context *c)
>  {
>      int ret = PUSH_MSG_ERROR;
>  
> -    if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED
> +
> +    if (tls_authentication_status(c->c2.tls_multi, TLS_MULTI_AUTH_STATUS_INTERVAL) == TLS_AUTHENTICATION_FAILED
>          || c->c2.tls_multi->multi_state == CAS_FAILED)
>      {
>          const char *client_reason = tls_client_reason(c->c2.tls_multi);
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 9c923f2a6..52488a163 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -152,6 +152,15 @@ struct auth_deferred_status
>      unsigned int auth_control_status;
>  };
>  
> +/* key_state_test_auth_control_file return values, these specify the
> + * current status of a deferred authentication */
> +enum auth_deferred_result {
> +    ACF_PENDING,      /**< deferred auth still pending */
> +    ACF_SUCCEEDED,    /**< deferred auth has suceeded */
> +    ACF_DISABLED,     /**< deferred auth is not used */
> +    ACF_FAILED        /**< deferred auth has failed */
> +};
> +
>  /**
>   * Security parameter state of one TLS and data channel %key session.
>   * @ingroup control_processor
> @@ -219,7 +228,7 @@ struct key_state
>  
>  #ifdef ENABLE_MANAGEMENT
>      unsigned int mda_key_id;
> -    unsigned int mda_status;
> +    enum auth_deferred_result mda_status;
>  #endif
>      time_t acf_last_mod;
>  
> @@ -561,8 +570,9 @@ struct tls_multi
>      char *locked_username;
>      struct cert_hash_set *locked_cert_hash_set;
>  
> -    /* Time of last call to tls_authentication_status */
> -    time_t tas_last;
> +    /* Time of last when we updated the cached state of
> +     * tls_authentication_status deferred files */
> +    time_t tas_cache_last_update;
>  
>      /*
>       * An error message to send to client on AUTH_FAILED
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 34ee19caf..b1b01f777 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -845,13 +845,6 @@ cleanup:
>  * user/password authentication.
>  *************************************************************************** */
>  
> -/* key_state_test_auth_control_file return values,
> - * NOTE: acf_merge indexing depends on these values */
> -#define ACF_UNDEFINED 0
> -#define ACF_SUCCEEDED 1
> -#define ACF_DISABLED  2
> -#define ACF_FAILED    3
> -
>  void
>  auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
>  {
> @@ -866,7 +859,7 @@ auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
>  
>  #ifdef ENABLE_MANAGEMENT
>  
> -static inline unsigned int
> +static inline enum auth_deferred_result
>  man_def_auth_test(const struct key_state *ks)
>  {
>      if (management_enable_def_auth(management))
> @@ -1041,13 +1034,23 @@ key_state_gen_auth_control_files(struct auth_deferred_status *ads,
>      return (acf && apf);
>  }
>  
> -static unsigned int
> -key_state_test_auth_control_file(struct auth_deferred_status *ads)
> +/**
> + * Checks the control status from a file. The function will try to read
> + * and update the cached status if the status is still pending and the paramter
> + * cached  is false. The function returns the
> + *
> + *
> + * @param ads       deferred status control structure
> + * @param cached    Return only cached status
> + * @return
> + */
> +static enum auth_deferred_result
> +key_state_test_auth_control_file(struct auth_deferred_status *ads, bool cached)
>  {
>      if (ads->auth_control_file)
>      {
>          unsigned int ret = ads->auth_control_status;
> -        if (ret == ACF_UNDEFINED)
> +        if (ret == ACF_PENDING && !cached)
>          {
>              FILE *fp = fopen(ads->auth_control_file, "r");
>              if (fp)
> @@ -1084,11 +1087,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>      /* at least one key already failed authentication */
>      bool failed_auth = false;
>  
> -    if (latency && multi->tas_last + latency >= now)
> -    {
> -        return TLS_AUTHENTICATION_UNDEFINED;
> -    }
> -    multi->tas_last = now;
> +    bool cached = multi->tas_cache_last_update + latency >= now;
>  
>      for (int i = 0; i < KEY_SCAN_SIZE; ++i)
>      {
> @@ -1102,11 +1101,11 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>              }
>              else
>              {
> -                unsigned int auth_plugin = ACF_DISABLED;
> -                unsigned int auth_script = ACF_DISABLED;
> -                unsigned int auth_man = ACF_DISABLED;
> -                auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth);
> -                auth_script = key_state_test_auth_control_file(&ks->script_auth);
> +                enum auth_deferred_result auth_plugin = ACF_DISABLED;
> +                enum auth_deferred_result auth_script = ACF_DISABLED;
> +                enum auth_deferred_result auth_man = ACF_DISABLED;
> +                auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth, cached);
> +                auth_script = key_state_test_auth_control_file(&ks->script_auth, cached);
>  #ifdef ENABLE_MANAGEMENT
>                  auth_man = man_def_auth_test(ks);
>  #endif
> @@ -1118,9 +1117,9 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>                      ks->authenticated = KS_AUTH_FALSE;
>                      failed_auth = true;
>                  }
> -                else if (auth_plugin == ACF_UNDEFINED
> -                         || auth_script == ACF_UNDEFINED
> -                         || auth_man == ACF_UNDEFINED)
> +                else if (auth_plugin == ACF_PENDING
> +                         || auth_script == ACF_PENDING
> +                         || auth_man == ACF_PENDING)
>                  {
>                      if (now < ks->auth_deferred_expire)
>                      {
> @@ -1140,6 +1139,12 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>          }
>      }
>  
> +    /* we did not rely on a cached result, remember the cache update time */
> +    if (!cached)
> +    {
> +        multi->tas_cache_last_update = now;
> +    }
> +
>  #if 0
>      dmsg(D_TLS_ERRORS, "TAS: a=%d s=%d d=%d f=%d", active, success, deferred, failed_auth);
>  #endif
> diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
> index 8358fb986..06b88b568 100644
> --- a/src/openvpn/ssl_verify.h
> +++ b/src/openvpn/ssl_verify.h
> @@ -69,8 +69,7 @@ enum tls_auth_status
>  {
>      TLS_AUTHENTICATION_SUCCEEDED=0,
>      TLS_AUTHENTICATION_FAILED=1,
> -    TLS_AUTHENTICATION_DEFERRED=2,
> -    TLS_AUTHENTICATION_UNDEFINED=3
> +    TLS_AUTHENTICATION_DEFERRED=2
>  };
>  
>  /**
> 

-- 
Antonio Quartulli

