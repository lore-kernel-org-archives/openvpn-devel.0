Message-ID: <59f71c40-2e41-3d15-9013-244b681a9628@...2181...>
Date: Wed, 22 Mar 2023 09:35:53 +0100
MIME-Version: 1.0
References: <20230321231003.3582-1-a@...2181...>
 <ZBqqwXLhDCN9RCfH@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <ZBqqwXLhDCN9RCfH@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] dco_freebsd: use m->instances[] instead
 of m->hash
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
Cc: openvpn-devel@lists.sourceforge.net, Kristof Provost <kp@...1249...>

Hi,

On 22/03/2023 08:14, Gert Doering wrote:
> Hi,
> 
> On Wed, Mar 22, 2023 at 12:10:03AM +0100, Antonio Quartulli wrote:
>> +    struct multi_instance *mi = m->instances[peer_id];
>> +    if (!mi)
>>       {
> 
> This (and undoubtedly the same code in dco_linux.c) is trusting the
> kernel to never return peer_id values that are outside the array
> boundaries.

very good catch.

> 
> Is this what we want?

no. we should not trust an external source.

Will send v2 for this and v3 for dco-linux

> 
> I'd strongly prefer to have a check like this here
> 
>      if ((peer_id < m->max_clients) && (m->instances[peer_id]))
>      {
> ...
>      }
> 
> (which is what we do in multi_process_incoming_dco(), for example)
> 
> 
> Note: in p2p mode, peer-id is something random, usually much bigger
> than max_clients - now this *should* never be called in p2p mode, but
> I still do not have a good feeling without the bounds check.
> 
> gert

-- 
Antonio Quartulli

