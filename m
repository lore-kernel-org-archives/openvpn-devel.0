Message-ID: <e7d6cc1d-2c74-93c4-03eb-f1cb76d56d2a@...2181...>
Date: Wed, 13 Jul 2022 14:05:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220706142907.3962-1-a@...2181...>
 <20220711081019.29511-1-a@...2181...> <Ys6kEeGapGS5xxDj@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Ys6kEeGapGS5xxDj@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2 pre-05/25] networking: add
 net_iface_type API
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
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 13/07/2022 12:53, Gert Doering wrote:
> Hi,
> 
> close, but NAK, due to...
> 
> On Mon, Jul 11, 2022 at 10:10:19AM +0200, Antonio Quartulli wrote:
>> This new API can be used to retrieve the type of a specific interface.
>> It's mostly platform dependant, but right now expected values are
>> "ovpn-dco", "tun" or "tap".
>>
>> Other values are possible too, but they are not of interest to us.
>>
>> This commit also extends the networking unit-test by using the newly
>> introduced API in conjunction with iface_new and iface_del.
>>
>> The t_next.sh script has been slightly adapted to allow running these
>> tests in standalone (as they don't require any iproute2 counterpart).
> 
> Typo: t_net.sh (but this is not the crucial bit).
> 
>> +int
>> +net_iface_type(openvpn_net_ctx_t *ctx, const char *iface,
>> +               char type[IFACE_TYPE_LEN_MAX])
>> +{
>> +    struct sitnl_link_req req = { };
>> +    int ifindex = if_nametoindex(iface);
>> +
>> +    if (!ifindex)
>> +    {
>> +        return errno;
>> +    }
> 
> I think this violates the "errors are returned as negative errno" function
> contract (and this is a code change, I won't "fix this on the fly").

you're right. I thought I had fixed this...but I must have forgotten to 
add it to the commit.

> 
>> +for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
> 
> Does $(( $A + 1 )) work in POSIX shells?
> 
> t_net.sh currenty requires bash, but I wonder if this is really needed,
> and a POSIX /bin/sh would do the job.

I think there are other bashism in this script (check arrays and stuff 
like that). Back then we concluded that "since this script runs only on 
linux, it's ok like this".

> 
> 
> Also, while at it - maybe add a unit test for "this interface does not exist"
> (as we need that functionality for the "--dev tun3" test)?
> 

yap yap, can do!

> gert


Thanks!

-- 
Antonio Quartulli

