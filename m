Message-ID: <8471a130-ee9a-08cb-c675-8a541f7ac835@...2181...>
Date: Tue, 2 Aug 2022 10:07:11 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-11-a@...2181...>
 <20220728193542.14801-1-a@...2181...>
 <Yuf04ZGDC7oGrjbe@...2685...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Yuf04ZGDC7oGrjbe@...2685...>
Subject: Re: [Openvpn-devel] [PATCH v2 10/25] dco: periodically check and
 possibly rotate/delete keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Hi,

On 01/08/2022 17:44, Frank Lichtenheld wrote:
> On Thu, Jul 28, 2022 at 09:35:42PM +0200, Antonio Quartulli wrote:
>> Data channel keys are periodically regenarated and installed in
>> ovpn-dco.
>> However, there is a certain moment when keys are rotated in order
>> to elect the new primary one.
>>
>> Check the key status in userspace so that kernelspace can be informed as
>> well when rotations happen.
> 
> Thinking about the actual code now.
> 
> [...]
>> +void
>> +dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
>> +{
>> +    msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->peer_id);
>> +
>> +    /* this function checks if keys have to be swapped or erased, therefore it
>> +     * can't do much if we don't have any key installed
>> +     */
>> +    if (multi->dco_keys_installed == 0)
>> +    {
>> +        return;
>> +    }
>> +
>> +    struct key_state *primary = tls_select_encryption_key(multi);
>> +    /* either we have no primary key at all or, if we do, it must have been
>> +     * installed already (keys are installed upon generation in the TLS code)
>> +     */
>> +    ASSERT(!primary || primary->dco_status != DCO_NOT_INSTALLED);
>> +
>> +    /* no primary key available -> no usable key exists, therefore we should
>> +     * tell DCO to simply wipe all keys
>> +     */
>> +    if (!primary)
>> +    {
>> +        msg(D_DCO, "No encryption key found. Purging data channel keys");
>> +
>> +        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_PRIMARY);
>> +        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
>> +        multi->dco_keys_installed = 0;
>> +        return;
>> +    }
>> +
>> +    struct key_state *secondary = dco_get_secondary_key(multi, primary);
>> +    /* same reason as the primary key above */
>> +    ASSERT(!secondary || secondary->dco_status != DCO_NOT_INSTALLED);
>> +
>> +    /* the current primary key was installed as secondary in DCO, this means
>> +     * that userspace has promoted it and we should tell DCO to swap keys
>> +     */
>> +    if (primary->dco_status == DCO_INSTALLED_SECONDARY)
>> +    {
>> +        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=%d id2=%d",
>> +            primary->key_id, secondary ? secondary->key_id : -1);
>> +
>> +        dco_swap_keys(dco, multi->peer_id);
>> +        primary->dco_status = DCO_INSTALLED_PRIMARY;
>> +        if (secondary)
>> +        {
>> +            secondary->dco_status = DCO_INSTALLED_SECONDARY;
>> +        }
> 
> Why do we have no error handling? We just assume that DCO swapped the keys
> but if dco_swap_keys returns an error that is probably not true?

Right - the call may fail for various reasons and in that case we should 
assume that no swap happened.

However, I am not sure what OpenVPN should do at this point. Trigger 
SIGUSR1 for this instance? The other end won't notice anything anyway.

> 
> Also can we really be sure that the kernel state is correct? I.e. we
> have determined we have swapped the keys, but can we be sure that
> the kernel actually has the two same keys and so a swap will replicate
> our state?

We have no way to confirm that, because we have no way to identify the 
keys that have been installed. We can only trust that we injected the 
right key at the right place.

> 
>> +    }
>> +
>> +    /* if we have no secondary key anymore, inform DCO about it */
>> +    if (!secondary && multi->dco_keys_installed == 2)
>> +    {
>> +        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
> 
> Would error handling make sense here? It is clearly not as critical
> as for dco_swap_keys because a delete is idempotent.

The question again is "what do we do?" Maybe in this case we simply 
print a message but we continue as if it was successful?

> 
>> +        multi->dco_keys_installed = 1;
>> +    }
>> +
>> +    /* all keys that are not installed are set to NOT installed */
>> +    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
>> +    {
>> +        struct key_state *ks = get_key_scan(multi, i);
>> +        if (ks != primary && ks != secondary)
>> +        {
>> +            ks->dco_status = DCO_NOT_INSTALLED;
>> +        }
>> +    }
>> +}
>> +
>>   static bool
>>   dco_check_option_conflict_platform(int msglevel, const struct options *o)
>>   {
> 
> 
> Regards,
>    Frank
> 
> 

Thanks!

> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

