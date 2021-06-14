From: Antonio Quartulli <a@...2181...>
References: <20210520151148.2565578-1-arne@...1227...>
 <20210520151148.2565578-5-arne@...1227...>
 <4ff59d1b-55bf-8b1f-ff87-26ef0c15ac8b@...2181...>
Message-ID: <7d8f953e-52b9-0550-fcfc-4cad2643b635@...2181...>
Date: Mon, 14 Jun 2021 03:23:06 +0200
MIME-Version: 1.0
In-Reply-To: <4ff59d1b-55bf-8b1f-ff87-26ef0c15ac8b@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 5/9] Extracting key_state deferred
 auth status update into function
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

On 14/06/2021 03:06, Antonio Quartulli wrote:
> Hi,
> 
> On 20/05/2021 17:11, Arne Schwabe wrote:
>> This extract the update of a deferred key status into into own
>> function.
>>
>> Patch v2: Do not ignore auth_deferred_expire. Minor format changes.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  src/openvpn/ssl_verify.c | 96 ++++++++++++++++++++++++++--------------
>>  1 file changed, 62 insertions(+), 34 deletions(-)
>>
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index 7992a6eb9..455a5cd1b 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -1073,6 +1073,60 @@ key_state_test_auth_control_file(struct auth_deferred_status *ads, bool cached)
>>      return ACF_DISABLED;
>>  }
>>  
>> +/**
>> + * This method takes a key_state and if updates the state
>> + * of the key if it is deferred.
>> + * @param cached    If auth control files should be tried to be opened or th
>> + *                  cached results should be used
>> + * @param ks        The key_state to update
>> + */
>> +static void
>> +update_key_auth_status(bool cached, struct key_state *ks)
>> +{
>> +    if (ks->authenticated == KS_AUTH_FALSE)
>> +    {
>> +        return;
>> +    }
>> +    else
>> +    {
>> +        enum auth_deferred_result auth_plugin = ACF_DISABLED;
>> +        enum auth_deferred_result auth_script = ACF_DISABLED;
>> +        enum auth_deferred_result auth_man = ACF_DISABLED;
>> +        auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth, cached);
>> +        auth_script = key_state_test_auth_control_file(&ks->script_auth, cached);
>> +#ifdef ENABLE_MANAGEMENT
>> +        auth_man = man_def_auth_test(ks);
>> +#endif
>> +        ASSERT(auth_plugin < 4 && auth_script < 4 && auth_man < 4);
>> +
>> +        if (auth_plugin == ACF_FAILED || auth_script == ACF_FAILED
>> +           || auth_man == ACF_FAILED)
>> +        {
>> +            ks->authenticated = KS_AUTH_FALSE;
>> +            return;
>> +        }
>> +        else if (auth_plugin == ACF_PENDING || auth_script == ACF_PENDING
>> +                 || auth_man == ACF_PENDING)
>> +        {
>> +            if (now > ks->auth_deferred_expire)
> 
> To be 100% semantically the same of the code we have now this comparison
> should be '>=' - just for consistency I'd change it.
> 
>> +            {
>> +                /* Window to authenticate the key has expired, mark
>> +                 * the key as unauthenticated */
>> +                ks->authenticated = KS_AUTH_FALSE;
>> +            }
> 
> If the if-condition above is false, we assume that authenticated is
> KS_AUTH_DEFERRED. Can we safely rely on this assumption?
> I could not find anywhere in the code an explicit link between
> KS_AUTH_DEFERRED and ACF_PENDING (actually I could not find anywhere
> setting the value ACF_PENDING).

self-answer: when ks is initialized it is zero'd. ACF_PENDING is zero so
it's implicitly assigned until further change.

For this reason the assumption here is correct.


@Gert: could you apply the '>' -> '>=' ont he fly?


For me the rest looks good.

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

