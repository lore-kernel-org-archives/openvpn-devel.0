Message-ID: <abf165f5-ee06-71ec-bfd8-182e1294d5bf@...2181...>
Date: Sun, 18 Sep 2022 21:47:56 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220917213154.29285-1-a@...2181...>
 <Yybu8YT8PGGUvDTx@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <Yybu8YT8PGGUvDTx@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] is_ipv_X: improve packet consistency
 checks
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

On 18/09/2022 12:12, Gert Doering wrote:
> Hi,
> 
> On Sat, Sep 17, 2022 at 11:31:54PM +0200, Antonio Quartulli wrote:
>> This patch brings the following improvements:
>> * check that ETH proto and version in IP header are consistent;
>> * check that length of the packet is enough to store the expected IP
>>    header (it may be an IPv4 or an IPv6 header)
> 
> Since this is in the fast path - what is the motivation behind adding
> all these extra checks?

These extra checks are meant to avoid bogus packets to sneak in (i.e. a 
ETH packet saying IPv4, but then having an IPv6 header on top).

Additionally we accept IPv6 packets without really checking if the 
packet has enough room for an entire IPv6 header.

This said, I did not consider that this function is along the fast path, 
therefore I'll check if we can reduce the number of jumps.

In the worst case I will only address the second point of the list above 
(as we may later access an IPv6 header that is not fully allocated).

Cheers,

> 
> gert

-- 
Antonio Quartulli

