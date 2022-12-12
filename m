Message-ID: <1c4ed45e-e767-1811-7055-ed3de9211829@...1227...>
Date: Mon, 12 Dec 2022 14:50:38 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
 <CAGyAFMW_pYqUKXttVQFzeRD-PAapHznauqbgfnettcwerkNyhQ@...278...>
 <bfa5c96e-3478-5150-0066-ee05643be9f8@...1227...>
 <Y5ctCJ1r0oHFG2Qw@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Y5ctCJ1r0oHFG2Qw@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] Read DCO traffic stats from the
 kernel
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
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 12.12.22 um 14:30 schrieb Gert Doering:
> Hi,
> 
> On Mon, Dec 12, 2022 at 01:50:51PM +0100, Arne Schwabe wrote:
>>> I am not too much into FreeBSD parts, but
>>>
>>>> +    hash_iterator_init(m->hash, &hi);
>>>> +
>>>> +    while ((he = hash_iterator_next(&hi)))
>>>> +    {
>>>> +        struct multi_instance *mi = (struct multi_instance *) he->value;
>>>> +
>>>> +        if (mi->context.c2.tls_multi->peer_id != peerid)
>>>> +            continue;
>>>
>>> Shouldn't we use m->instances[peerid] instead of iterating over m->hash?
>>
>> Yes and a check that kernel does not give something > max_peer
> 
> I agree, doing the iterator here for every single active peer when we
> already have the array.  But then, of course, p2p peer-id will be
> "something random", not constrained by max-clients.

on p2mp code, it will be contrainst by max-clients. The random peerid 
only happens in p2p mode where do not have multi_instance anyway.

> 
> Anyway, we have a procedural problem here - kp@ is on vacation for a
> few weeks now, so we won't see a v2 of this patch any time soon.
> 
> Do you think the patch is ready to be merged, "as is", with not-so-good
> efficiency?  One of you could then send a followup patch changing this
> to use the array accessor.

Fine by me.

Arne

