Message-ID: <121c1161-262b-46a8-841b-a83e38290881@...2181...>
Date: Wed, 7 May 2025 21:40:10 +0200
MIME-Version: 1.0
References: <20250507124439.28161-1-a@...2181...>
 <aBtoDrb9Fjflq52y@...1296...> <aBtv6BBzznLqhGU0@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <aBtv6BBzznLqhGU0@...1296...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: fix ndo_start_xmit
 return value on error
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

On 07/05/2025 16:36, Gert Doering wrote:
> Hi,
> 
> On Wed, May 07, 2025 at 04:02:54PM +0200, Gert Doering wrote:
>> Tested, works :-) - so the previous behaviour was "oping was hanging
>> due to 'out of buffer space' error not being counted as 'packet sent'"
>> and now it's behaving as any regular network interface when there
>> is no ARP/IPv6 ND for that neighbour.  Explanation makes sense, too :-)
>>
>> So
>>
>> Acked-By: Gert Doering <gert@...1296...>
> 
> Antonio says if I test this, I should state so...
> 
> Tested-By: Gert Doering <gert@...1296...>
> Acked-By: Gert Doering <gert@...1296...>
> 
> here we go :-)

Merged to main branch, commit id 2176a2102216

Thanks!

-- 
Antonio Quartulli


