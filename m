References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <41065455-7d6d-6b0e-007e-ef6d1391621f@...2181...>
Date: Sat, 1 May 2021 15:33:14 +0200
MIME-Version: 1.0
In-Reply-To: <20210422151724.2132573-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/7] Return cached result in
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
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/04/2021 17:17, Arne Schwabe wrote:
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
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c      |  2 +-
>  src/openvpn/push.c       |  3 ++-
>  src/openvpn/ssl_common.h | 11 +++++++++-
>  src/openvpn/ssl_verify.c | 46 ++++++++++++++++++++--------------------
>  src/openvpn/ssl_verify.h |  3 +--
>  5 files changed, 37 insertions(+), 28 deletions(-)
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
> index 9c923f2a6..026da3578 100644
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
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index fffcd83c6..e000f75f7 100644
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
> @@ -1084,10 +1087,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>      /* at least one key already failed authentication */
>      bool failed_auth = false;
>  
> -    if (latency && multi->tas_last + latency >= now)
> -    {
> -        return TLS_AUTHENTICATION_UNDEFINED;
> -    }
> +    bool cached  = multi->tas_last + latency >= now;
There is an extra space before the '='.


>      multi->tas_last = now;

I think keeping this line here is wrong.

Now that the logic has been changed, the code is setting tas_last to now
every time this function is called (it wasn't the case before this patch).

For this reason "cached" will always be true and the ACF will never be
checked.

A fix would be to add a condition above this line, like:

if (!cached)
    multi->tas_last = now;

Does it make sense?
In my tests this fixes the problem and deferred auth works again.


[I wonder why it worked for your tests - maybe a later patch is touching
this code again]


Cheers,


-- 
Antonio Quartulli

