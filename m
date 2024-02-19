Message-ID: <6d8657f9-738f-44be-acbb-7e044d89e0f3@...2181...>
Date: Mon, 19 Feb 2024 14:08:56 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
 <a91d834e2d9f284b0278cf9940f50dd0a539f057-HTML@...2715...>
 <Zc45NJAyJyLoTRee@...1296...>
 <8021c4ad-fca6-443c-9ce6-37c7e85bca81@...2181...>
In-Reply-To: <8021c4ad-fca6-443c-9ce6-37c7e85bca81@...2181...>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: gianmarco@...2726..., frank@...2641..., openvpn-devel@lists.sourceforge.net, arne-openvpn@...1227...

Hi,

On 16/02/2024 15:00, Antonio Quartulli wrote:
> Hi,
> 
> On 15/02/2024 17:17, Gert Doering wrote:
>> Hi,
>>
>> On Thu, Feb 15, 2024 at 03:59:02PM +0000, its_Giaan (Code Review) wrote:
>>>       if (buf->len > 0)
>>>       {
>>> -        /*
>>> -         * The --passtos and --mssfix options require
>>> -         * us to examine the IPv4 header.
>>> -         */
>>> -
>>> -        if (flags & (PIP_MSSFIX
>>> -#if PASSTOS_CAPABILITY
>>> -                     | PIPV4_PASSTOS
>>> -#endif
>>> -                     | PIPV4_CLIENT_NAT
>>> -                     ))
>>> +        if (flags & PIP_OPT_MASK)
>>
>> NAK, as this is not the same thing.  PIP_OPT_MASK will also match on
>> the IPv6 flags, which are not something we need to test for here (= if
>> only an IPv6 flag is active, why should we enter this branch?).
> 
> We need to enter for either v4 or v6 flags, no?
> 
> The check on whether the packet is v4 or v6 happens *inside* this if 
> block. Am I wrong?

I double checked the code once again and I think there is a bug in this 
check.

Right now we check for some flags (say A and B) before entering the 
if-block.

Once inside we take action on flag A, B, but also C, D and E.
Now, if C, D and E are set, but A and B are not, we will never enter the 
if-block and execute the related code.

Among this we have:
* IPv6 flags (they are checked inside, but not on the outer guard)
* PIPV4_EXTRACT_DHCP_ROUTER
* PIPV6_IMCP_NOHOST_CLIENT
* PIPV6_IMCP_NOHOST_SERVER

(we also got an interesting typ0 in the last two).


This said, I do believe this patch fixes these issues in one go as the 
new PIP_OPT_MASK will match all the flags mentioned above.

It'd be interesting to test any behaviour expected to be triggered by 
PIPV4_EXTRACT_DHCP_ROUTER to confirm the theory.

Cheers,


-- 
Antonio Quartulli

