Message-ID: <8021c4ad-fca6-443c-9ce6-37c7e85bca81@...2181...>
Date: Fri, 16 Feb 2024 15:00:28 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
 <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
 <Zc45NJAyJyLoTRee@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Zc45NJAyJyLoTRee@...1296...>
Subject: Re: [Openvpn-devel] [S] Change in openvpn[master]: Minor fix to
 process_ip_header
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
To: Gert Doering <gert@...1296...>, gianmarco@...2726..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

Hi,

On 15/02/2024 17:17, Gert Doering wrote:
> Hi,
> 
> On Thu, Feb 15, 2024 at 03:59:02PM +0000, its_Giaan (Code Review) wrote:
>>       if (buf->len > 0)
>>       {
>> -        /*
>> -         * The --passtos and --mssfix options require
>> -         * us to examine the IPv4 header.
>> -         */
>> -
>> -        if (flags & (PIP_MSSFIX
>> -#if PASSTOS_CAPABILITY
>> -                     | PIPV4_PASSTOS
>> -#endif
>> -                     | PIPV4_CLIENT_NAT
>> -                     ))
>> +        if (flags & PIP_OPT_MASK)
> 
> NAK, as this is not the same thing.  PIP_OPT_MASK will also match on
> the IPv6 flags, which are not something we need to test for here (= if
> only an IPv6 flag is active, why should we enter this branch?).

We need to enter for either v4 or v6 flags, no?

The check on whether the packet is v4 or v6 happens *inside* this if 
block. Am I wrong?

Cheers,


-- 
Antonio Quartulli

