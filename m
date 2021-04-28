References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-2-arne@...1227...>
 <fbc426b7-66d0-451d-a306-df74644af09d@...2181...>
 <44b9012c-5884-f73a-7984-fe25668ef22a@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <415ef16c-c8bb-a85a-cc04-ff259b97f622@...2181...>
Date: Wed, 28 Apr 2021 08:54:19 +0200
MIME-Version: 1.0
In-Reply-To: <44b9012c-5884-f73a-7984-fe25668ef22a@...1227...>
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
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 27/04/2021 12:21, Arne Schwabe wrote:
> 
>>  
>>> @@ -369,7 +369,7 @@ bool
>>>  send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
>>>                             unsigned int timeout)
>>>  {
>>> -    struct key_state *ks = &tls_multi->session[TM_ACTIVE].key[KS_PRIMARY];
>>> +    struct key_state *ks = get_key_scan(tls_multi, 0);
>>
>> why not calling get_primary_key() here and in all other spots where we
>> ask for the 0th key in the scan?
>>
> 
> This function needs a non-const variant and get_primary_key returns a
> const struct.
> 
> 

Right, I missed that.

>>> +/**  gets an item  of \c key_state objects in the
>>> + *   order they should be scanned by data
>>> + *   channel modules. */
>>> +static inline const struct key_state *
>>> +get_primary_key(const struct tls_multi *multi)
>>> +{
>>> +        return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
>>> +}
>>
>> Why not implementing this as get_key_scan(multi, 0); ?
>>
> 
> That breaks the constness of the argument.

I have seen that there is only one place where we call get_primary_key()
with a const argument and that is tls_test_payload_len().

However, I think what you came up with is still the easiest
thing...unless somebody else comes up with a smarter idea.

Maybe in the future we'll be able to clean this up further.

For me the patch looks good as it is.
Compile rig is happy.
Basic connectivity test and renegotiation test with OpenSSL passed.

Acked-by: Antonio Quartulli <antonio@...515...>

Regards,


-- 
Antonio Quartulli

