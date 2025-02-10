Message-ID: <5a08ede3-49d6-40bc-8044-70e5b7747fe3@...2181...>
Date: Mon, 10 Feb 2025 10:19:30 +0100
MIME-Version: 1.0
References: <20250201062437.4059652-1-dqfext@...277...>
 <Z53TP7qTBJSc8tca@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Z53TP7qTBJSc8tca@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] dco: fix source IP selection
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
To: Gert Doering <gert@...1296...>, Qingfang Deng <dqfext@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Thanks a lot for bringing this problem to our attention.

On 01/02/2025 08:54, Gert Doering wrote:
>> @@ -616,10 +621,15 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
>>           vpn_addr6 = &c->c2.push_ifconfig_ipv6_local;
>>       }
>>   
>> +    struct link_socket *ls = c->c2.link_sockets[0];
>>       if (dco_multi_get_localaddr(m, mi, &local))
>>       {
>>           localaddr = (struct sockaddr *)&local;
>>       }
>> +    else if (ls->bind_local && ls->info.lsa->bind_local)
>> +    {
>> +        localaddr = ls->info.lsa->bind_local->ai_addr;
>> +    }
> 
> Not sure about that.  If the socket is bound, the kernel knows about
> the binding (because we pass the socket to the kernel).  You're sure this
> is needed?

As already questioned by Gert, I can confirm that this is not expected, 
because DCO should automatically pick any source address that was bound 
to the socket.

This said, DCO seems to not be doing this and therefore the bound source 
address is not respected.

Therefore this is a bug that needs fixing in DCO and should not be 
worked-around by userspace.

Hence, I'd suggest to drop the hunk about and rather fix the issue in DCO.
while looking at this patch, I have already identified where DCO needs 
adjustments, therefore it's likely that the next DCO revision will have 
this fixed.

Regards,

> 
> gert
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli


