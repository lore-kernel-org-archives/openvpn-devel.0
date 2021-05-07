From: Antonio Quartulli <a@...2181...>
References: <20210422151724.2132573-1-arne@...1227...>
 <20210506141259.309741-1-arne@...1227...>
 <2eba0560-91a5-f44a-755b-797ada0043ee@...2181...>
Message-ID: <9f5911dd-15d9-41ed-10d8-141e10765399@...2181...>
Date: Fri, 7 May 2021 09:13:42 +0200
MIME-Version: 1.0
In-Reply-To: <2eba0560-91a5-f44a-755b-797ada0043ee@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Return cached result in
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

Hi Arne,

following your lead I recompiled with --enable-async-push and the
problem went away.

Some ifdef is messing up the code path?

Cheers,

On 06/05/2021 23:49, Antonio Quartulli wrote:
> Hi Arne,
> 
> after our discussion on IRC I understood you expected this patch to not
> change the server behaviour.
> 
> If something is suboptimal, it means it was suboptimal also before this
> patch.
> 
> However, with your patch I can clearly see a longer delay in returning
> the AUTH result to the client, in case of deferred auth.
> 
> Without your patch (initial lines are the output of my auth-verify script):
> 
> PASS=testno
> FILE=/tmp/openvpn_acf_662a1165ab3293aa3fb053050e1c2463.tmp
> FAIL
> 2021-05-06 23:40:28 10.10.10.2:1194 TLS: Username/Password
> authentication deferred for username 'test'
> 2021-05-06 23:40:28 10.10.10.2:1194 Control Channel: TLSv1.3, cipher
> TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bit EC, curve
> secp384r1, signature: ecdsa-with-SHA256
> 2021-05-06 23:40:28 10.10.10.2:1194 [client] Peer Connection Initiated
> with [AF_INET6]::ffff:10.10.10.2:1194
> 2021-05-06 23:40:29 10.10.10.2:1194 PUSH: Received control message:
> 'PUSH_REQUEST'
> 2021-05-06 23:40:29 10.10.10.2:1194 Delayed exit in 5 seconds
> 2021-05-06 23:40:29 10.10.10.2:1194 SENT CONTROL [client]: 'AUTH_FAILED'
> (status=1)
> 
> My script uses the deferred logic, but it is super fast (as you can see
> it fails before the server can even do anything else).
> 
> Later, as soon as the first PUSH_REQUEST is received, the server replies
> immediately with an AUTH_FAILED.
> 
> 
> With your patch (script and everything else stays the same):
> 
> PASS=testno
> FILE=/tmp/openvpn_acf_4cdab09a9640e8eb4cacadfc1734bb2c.tmp
> FAIL
> 2021-05-06 23:45:22 10.10.10.2:1194 TLS: Username/Password
> authentication deferred for username 'test'
> 2021-05-06 23:45:22 10.10.10.2:1194 Control Channel: TLSv1.3, cipher
> TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bit EC, curve
> secp384r1, signature: ecdsa-with-SHA256
> 2021-05-06 23:45:22 10.10.10.2:1194 [client] Peer Connection Initiated
> with [AF_INET6]::ffff:10.10.10.2:1194
> 2021-05-06 23:45:23 10.10.10.2:1194 PUSH: Received control message:
> 'PUSH_REQUEST'
> 2021-05-06 23:45:28 10.10.10.2:1194 PUSH: Received control message:
> 'PUSH_REQUEST'
> 2021-05-06 23:45:33 10.10.10.2:1194 Delayed exit in 5 seconds
> 2021-05-06 23:45:33 10.10.10.2:1194 SENT CONTROL [client]: 'AUTH_FAILED'
> (status=1)
> 
> As you can see the script does the deferred auth immediately, but the
> server send the AUTH_FAILED only after the PUSH_REQUEST being received
> *after some (10?) seconds since the failure of the script*.
> 
> To me this sounds like the server is caching the current status for some
> (10?) seconds and it is not updating it with the actual result.
> 
> However, this does not seem to happen without your patch as the server
> is probably forcing a reload of the result from file everytime a
> PUSH_REQUEST is received.
> 
> I believe this behaviour should stay the same.
> 
> Regards,
> 
> 
> 
> On 06/05/2021 16:12, Arne Schwabe wrote:
>> tls_authentication_status does caching to avoid file I/O more than
>> every TLS_MULTI_AUTH_STATUS_INTERVAL (10s) per connection. But
>> counter-intuitively it does not return the cached result but rather
>> TLS_AUTHENTICATION_UNDEFINED if the cache is not refreshed by the call.
>>
>> This is workarounded by forcing a refresh in some areas of the code
>> (latency = 0).
>>
>> This patch changes the behaviour by always returning the last known
>> status and only updating the file status when the i/o timeout for the
>> caches is reached.
>>
>> The old logic in send_auth_failed is fragile in the sense that if
>> it is called again while an exit is scheduled it will reset the timer
>> to 5s again. Since we now always report the status from
>> tls_authentication_status() instead only every 10s, this caused OpenVPN
>> to infinitively reset the timer. Fix this by only setting the status
>> if no exit is scheduled. The function is still called multiple times but
>> since it is with coarse timer frequency, the 4 extra calls (1 per second)
>> are better than to add more extra code to avoid these calls.
>>
>> The patch also changes the DEFINE enum into a real enum.
>>
>> Patch v2: only update tas_cache_last_udpate when actually updating the cache.
>> Patch v3: avoid rearming timer
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  src/openvpn/multi.c      |  2 +-
>>  src/openvpn/push.c       | 11 ++++++++-
>>  src/openvpn/ssl_common.h | 16 +++++++++---
>>  src/openvpn/ssl_verify.c | 53 ++++++++++++++++++++++------------------
>>  src/openvpn/ssl_verify.h |  3 +--
>>  5 files changed, 54 insertions(+), 31 deletions(-)
>>
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index 666456da9..ab2270a58 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -2596,7 +2596,7 @@ static const multi_client_connect_handler client_connect_handlers[] = {
>>  static void
>>  multi_connection_established(struct multi_context *m, struct multi_instance *mi)
>>  {
>> -    if (tls_authentication_status(mi->context.c2.tls_multi, 0)
>> +    if (tls_authentication_status(mi->context.c2.tls_multi, TLS_MULTI_AUTH_STATUS_INTERVAL)
>>          != TLS_AUTHENTICATION_SUCCEEDED)
>>      {
>>          return;
>> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
>> index fcafc5003..671220c3f 100644
>> --- a/src/openvpn/push.c
>> +++ b/src/openvpn/push.c
>> @@ -335,10 +335,18 @@ __attribute__ ((format(__printf__, 4, 5)))
>>  
>>  /*
>>   * Send auth failed message from server to client.
>> + *
>> + * Does nothing if an exit is already scheduled
>>   */
>>  void
>>  send_auth_failed(struct context *c, const char *client_reason)
>>  {
>> +    if (event_timeout_defined(&c->c2.scheduled_exit))
>> +    {
>> +        msg(D_TLS_DEBUG, "exit already scheduled for context");
>> +        return;
>> +    }
>> +
>>      struct gc_arena gc = gc_new();
>>      static const char auth_failed[] = "AUTH_FAILED";
>>      size_t len;
>> @@ -855,7 +863,8 @@ process_incoming_push_request(struct context *c)
>>  {
>>      int ret = PUSH_MSG_ERROR;
>>  
>> -    if (tls_authentication_status(c->c2.tls_multi, 0) == TLS_AUTHENTICATION_FAILED
>> +
>> +    if (tls_authentication_status(c->c2.tls_multi, TLS_MULTI_AUTH_STATUS_INTERVAL) == TLS_AUTHENTICATION_FAILED
>>          || c->c2.tls_multi->multi_state == CAS_FAILED)
>>      {
>>          const char *client_reason = tls_client_reason(c->c2.tls_multi);
>> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
>> index 9c923f2a6..52488a163 100644
>> --- a/src/openvpn/ssl_common.h
>> +++ b/src/openvpn/ssl_common.h
>> @@ -152,6 +152,15 @@ struct auth_deferred_status
>>      unsigned int auth_control_status;
>>  };
>>  
>> +/* key_state_test_auth_control_file return values, these specify the
>> + * current status of a deferred authentication */
>> +enum auth_deferred_result {
>> +    ACF_PENDING,      /**< deferred auth still pending */
>> +    ACF_SUCCEEDED,    /**< deferred auth has suceeded */
>> +    ACF_DISABLED,     /**< deferred auth is not used */
>> +    ACF_FAILED        /**< deferred auth has failed */
>> +};
>> +
>>  /**
>>   * Security parameter state of one TLS and data channel %key session.
>>   * @ingroup control_processor
>> @@ -219,7 +228,7 @@ struct key_state
>>  
>>  #ifdef ENABLE_MANAGEMENT
>>      unsigned int mda_key_id;
>> -    unsigned int mda_status;
>> +    enum auth_deferred_result mda_status;
>>  #endif
>>      time_t acf_last_mod;
>>  
>> @@ -561,8 +570,9 @@ struct tls_multi
>>      char *locked_username;
>>      struct cert_hash_set *locked_cert_hash_set;
>>  
>> -    /* Time of last call to tls_authentication_status */
>> -    time_t tas_last;
>> +    /* Time of last when we updated the cached state of
>> +     * tls_authentication_status deferred files */
>> +    time_t tas_cache_last_update;
>>  
>>      /*
>>       * An error message to send to client on AUTH_FAILED
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index 34ee19caf..b1b01f777 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -845,13 +845,6 @@ cleanup:
>>  * user/password authentication.
>>  *************************************************************************** */
>>  
>> -/* key_state_test_auth_control_file return values,
>> - * NOTE: acf_merge indexing depends on these values */
>> -#define ACF_UNDEFINED 0
>> -#define ACF_SUCCEEDED 1
>> -#define ACF_DISABLED  2
>> -#define ACF_FAILED    3
>> -
>>  void
>>  auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
>>  {
>> @@ -866,7 +859,7 @@ auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
>>  
>>  #ifdef ENABLE_MANAGEMENT
>>  
>> -static inline unsigned int
>> +static inline enum auth_deferred_result
>>  man_def_auth_test(const struct key_state *ks)
>>  {
>>      if (management_enable_def_auth(management))
>> @@ -1041,13 +1034,23 @@ key_state_gen_auth_control_files(struct auth_deferred_status *ads,
>>      return (acf && apf);
>>  }
>>  
>> -static unsigned int
>> -key_state_test_auth_control_file(struct auth_deferred_status *ads)
>> +/**
>> + * Checks the control status from a file. The function will try to read
>> + * and update the cached status if the status is still pending and the paramter
>> + * cached  is false. The function returns the
>> + *
>> + *
>> + * @param ads       deferred status control structure
>> + * @param cached    Return only cached status
>> + * @return
>> + */
>> +static enum auth_deferred_result
>> +key_state_test_auth_control_file(struct auth_deferred_status *ads, bool cached)
>>  {
>>      if (ads->auth_control_file)
>>      {
>>          unsigned int ret = ads->auth_control_status;
>> -        if (ret == ACF_UNDEFINED)
>> +        if (ret == ACF_PENDING && !cached)
>>          {
>>              FILE *fp = fopen(ads->auth_control_file, "r");
>>              if (fp)
>> @@ -1084,11 +1087,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>>      /* at least one key already failed authentication */
>>      bool failed_auth = false;
>>  
>> -    if (latency && multi->tas_last + latency >= now)
>> -    {
>> -        return TLS_AUTHENTICATION_UNDEFINED;
>> -    }
>> -    multi->tas_last = now;
>> +    bool cached = multi->tas_cache_last_update + latency >= now;
>>  
>>      for (int i = 0; i < KEY_SCAN_SIZE; ++i)
>>      {
>> @@ -1102,11 +1101,11 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>>              }
>>              else
>>              {
>> -                unsigned int auth_plugin = ACF_DISABLED;
>> -                unsigned int auth_script = ACF_DISABLED;
>> -                unsigned int auth_man = ACF_DISABLED;
>> -                auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth);
>> -                auth_script = key_state_test_auth_control_file(&ks->script_auth);
>> +                enum auth_deferred_result auth_plugin = ACF_DISABLED;
>> +                enum auth_deferred_result auth_script = ACF_DISABLED;
>> +                enum auth_deferred_result auth_man = ACF_DISABLED;
>> +                auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth, cached);
>> +                auth_script = key_state_test_auth_control_file(&ks->script_auth, cached);
>>  #ifdef ENABLE_MANAGEMENT
>>                  auth_man = man_def_auth_test(ks);
>>  #endif
>> @@ -1118,9 +1117,9 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>>                      ks->authenticated = KS_AUTH_FALSE;
>>                      failed_auth = true;
>>                  }
>> -                else if (auth_plugin == ACF_UNDEFINED
>> -                         || auth_script == ACF_UNDEFINED
>> -                         || auth_man == ACF_UNDEFINED)
>> +                else if (auth_plugin == ACF_PENDING
>> +                         || auth_script == ACF_PENDING
>> +                         || auth_man == ACF_PENDING)
>>                  {
>>                      if (now < ks->auth_deferred_expire)
>>                      {
>> @@ -1140,6 +1139,12 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
>>          }
>>      }
>>  
>> +    /* we did not rely on a cached result, remember the cache update time */
>> +    if (!cached)
>> +    {
>> +        multi->tas_cache_last_update = now;
>> +    }
>> +
>>  #if 0
>>      dmsg(D_TLS_ERRORS, "TAS: a=%d s=%d d=%d f=%d", active, success, deferred, failed_auth);
>>  #endif
>> diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
>> index 8358fb986..06b88b568 100644
>> --- a/src/openvpn/ssl_verify.h
>> +++ b/src/openvpn/ssl_verify.h
>> @@ -69,8 +69,7 @@ enum tls_auth_status
>>  {
>>      TLS_AUTHENTICATION_SUCCEEDED=0,
>>      TLS_AUTHENTICATION_FAILED=1,
>> -    TLS_AUTHENTICATION_DEFERRED=2,
>> -    TLS_AUTHENTICATION_UNDEFINED=3
>> +    TLS_AUTHENTICATION_DEFERRED=2
>>  };
>>  
>>  /**
>>
> 

-- 
Antonio Quartulli

