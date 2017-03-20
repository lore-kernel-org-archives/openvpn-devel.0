References: <e0ce41fa-d0b7-a5af-d021-133239911898@...277...>
	<20170319184135.23548-1-gert@...1296...>
	<6f73cd46-c9fc-10fa-2538-f820998c610e@...1856...>
	<20170320182847.GJ93896@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <4ca7c71b-0858-9515-aea2-fa30f9aed333@...1856...>
Date: Mon, 20 Mar 2017 20:27:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170320182847.GJ93896@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Make ENABLE_OCC no longer depend on
 !ENABLE_SMALL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


On 20-03-17 19:28, Gert Doering wrote:
> On Mon, Mar 20, 2017 at 07:20:50PM +0100, Steffan Karger wrote:
>>> @@ -589,9 +589,7 @@ socket_defined(const socket_descriptor_t sd)
>>>  /*
>>>   * Should we include OCC (options consistency check) code?
>>>   */
>>> -#ifndef ENABLE_SMALL
>>>  #define ENABLE_OCC
>>> -#endif
>>>  
>>>  /*
>>>   * Should we include NTLM proxy functionality
>>>
>>
>> If we unconditionally enable OCC, should we not just rip out #ifdef
>> ENABLE_OCC everywhere?
> 
> We certainly could, but someone who still wants "no OCC! smaaall!" 
> still has the option to turn it off...
> 
> We might revisit that, though - there's "the option checking code",
> which indeed brings in quite a bit of code that might be considered
> optional, but there is also stuff in sig.c that makes --explicit-exit-notify
> depend on ENABLE_OCC, and I'd consider that as something quite 
> important...

Ok, let's revisit that later.  This patch doesn't hurt if we decide to
rip out more later, and would be good to get into 2.4.1, so ACK.

-Steffan

