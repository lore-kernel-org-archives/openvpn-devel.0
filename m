Message-ID: <76119efc-1dc4-ddfb-dce7-8cf90d61cc1c@...2181...>
Date: Tue, 13 Dec 2022 13:12:30 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20221205164103.9190-1-kprovost@...2661...>
 <20221205164103.9190-2-kprovost@...2661...>
 <b6c21ae8-536a-2c6f-07e6-d998102c646e@...2181...>
 <Y5gDkXBhDyqB+YZf@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Y5gDkXBhDyqB+YZf@...1296...>
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
Cc: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 13/12/2022 05:46, Gert Doering wrote:
> Hi,
> 
> On Mon, Dec 12, 2022 at 09:53:36PM +0100, Antonio Quartulli wrote:
>> On 05/12/2022 17:41, Kristof Provost via Openvpn-devel wrote:
>> [cut]
>>> +int
>>> +dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
>>> +{
>>> +
>>> +    struct ifdrv drv;
>>> +    uint8_t buf[4096];
>>> +    nvlist_t *nvl;
>>> +    const nvlist_t *const *nvpeers;
>>> +    size_t npeers;
>>> +    int ret;
>>> +
>>> +    if (!dco || !dco->open)
>>> +    {
>>> +        return 0;
>>> +    }
>>> +
>>> +    CLEAR(drv);
>>> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
>>> +    drv.ifd_cmd = OVPN_GET_PEER_STATS;
>>
>> What speaks against having a simple GET_PEER here which returns the full
>> peer object with all possible attributes?
>>
>> This way, if we want to retrieve another attribute in the future, this
>> attribute will already be delivered by the same API, without the need to
>> implement a new command each time.
> 
> One counter-argument would be "the statistics are polled more often than
> 'all information about a peer object', so it should be less costly"

It's a netlink/ioctl API: it's already costly and out of any fast-path, 
therefore I don't think this argument really plays an important role here.

What is more important is designing an API that can last long, without 
the need for extra cluttering when we decide to implement something new.

Ideally a GET_PEER command is pretty standard and can also be used for 
any kind of state inspection (i.e. even for 'debugging', although it's 
not the primary usage)

> (also, when do we ever poll 'all attributes'?  Since OpenVPN *sets*
> these, we should know, except for the counters...)

Like I said above, being this an API imho it is important to implement 
it in a way that can serve a reasonably broad set of use cases. (OpenVPN 
is the only user now, but may not be the case later)



Cheers,


-- 
Antonio Quartulli

