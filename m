Message-ID: <73aaa55e-0b2f-a3f1-180c-6cbc2abc3ca6@...2181...>
Date: Thu, 28 Jul 2022 15:01:15 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220720123249.909-1-a@...2181...>
 <6b98d160-b483-f49d-fd9d-ac769acb74a0@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <6b98d160-b483-f49d-fd9d-ac769acb74a0@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 09/25] dco: configure keys in DCO
 right after generating them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 28/07/2022 14:56, Arne Schwabe wrote:
> 
>> index 87d6fc31..dba9d02c 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -3194,6 +3194,16 @@ options_postprocess_mutate_ce(struct options 
>> *o, struct connection_entry *ce)
>>           ce->explicit_exit_notification = 0;
>>       }
>> +    /* when DCO is in use we can't send data channel packets.
>> +     * EEN needs to be re-implemented over the control channel in order
>> +     * to work.
>> +     */
>> +    if (dco_enabled(o) && ce->explicit_exit_notification)
>> +    {
>> +        msg(M_WARN, "NOTICE: --explicit-exit-notify ignored when "
>> +            "data channel offload is in use");
>> +        ce->explicit_exit_notification = 0;
>> +    }
> 
> I don't like this. There is already the patch from me that allows this 
> on the control channel. So we need a better solution than disabling it 
> when dco is enabled. Did you check what happens if data packets are 
> tried being sent when DCO is enabled? Maybe that just has a warning now 
> that no key is active.

Haven't tried, but by looking at the code it seems OpenVPN will assert 
out because it checks for the key context being not-null.

So, since it cannot work the way it is right now, I wanted to at least 
disable it.

Once implemented on the control channel it could then be re-enabled again.

Cheers,


-- 
Antonio Quartulli

