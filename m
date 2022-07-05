Message-ID: <43fa922a-6f03-934e-413e-0f817cb1a666@...2181...>
Date: Tue, 5 Jul 2022 14:40:59 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-23-a@...2181...> <5469674.Wqm9v67MU2@...2664...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <5469674.Wqm9v67MU2@...2664...>
Subject: Re: [Openvpn-devel] [PATCH 22/25] dco-win: introduce low-level code
 for handling ovpn-dco-win in Windows
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
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net

Hi,

On 05/07/2022 14:32, Heiko Hund wrote:
> On Freitag, 24. Juni 2022 10:38:06 CEST Antonio Quartulli wrote:
>> +int
>> +dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
>> +{
>> +    msg(D_DCO, "%s: peer-id %d, slot %d called but ignored", __func__,
>> peerid, +        slot);
>> +    /* FIXME: Implement in driver first */
> 
> Suppose this is not critical and the driver gets rid of keys itself?

Yeah, the dco-win driver does not offer the same API granularity because 
it does not want/need to cover all the usecases that linux does.

So yeah, this simply happens in kernel directly upon disconnection.

Cheers,

> 
> 
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

