Message-ID: <bfa5c96e-3478-5150-0066-ee05643be9f8@...1227...>
Date: Mon, 12 Dec 2022 13:50:51 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
 <CAGyAFMW_pYqUKXttVQFzeRD-PAapHznauqbgfnettcwerkNyhQ@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAGyAFMW_pYqUKXttVQFzeRD-PAapHznauqbgfnettcwerkNyhQ@...278...>
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
To: Lev Stipakov <lstipakov@...277...>, Kristof Provost <kprovost@...2661...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 12.12.22 um 13:34 schrieb Lev Stipakov:
> Hi,
> 
> This is good - I need an API to get stats to make openvpn-gui show
> those (via the management interface).
> 
> I am not too much into FreeBSD parts, but
> 
>> +    hash_iterator_init(m->hash, &hi);
>> +
>> +    while ((he = hash_iterator_next(&hi)))
>> +    {
>> +        struct multi_instance *mi = (struct multi_instance *) he->value;
>> +
>> +        if (mi->context.c2.tls_multi->peer_id != peerid)
>> +            continue;
> 
> Shouldn't we use m->instances[peerid] instead of iterating over m->hash?
> 

Yes and a check that kernel does not give something > max_peer

Arne


