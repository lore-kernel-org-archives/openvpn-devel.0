Message-ID: <666df1a7-d071-454c-90a6-6bbfe0f7f014@...2181...>
Date: Mon, 16 Feb 2026 23:12:46 +0100
MIME-Version: 1.0
References: <20260205151036.743792-1-ralf@...2726...>
 <aZNCExYQTSKM0HhW@...2915...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <aZNCExYQTSKM0HhW@...2915...>
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2] ovpn: tcp - fix packet
 extraction from stream
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
To: Sabrina Dubroca <sd@...2891...>, Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

On 16/02/2026 17:13, Sabrina Dubroca wrote:
> 2026-02-05, 16:10:36 +0100, Ralf Lici wrote:
>> When processing TCP stream data in ovpn_tcp_recv, we receive large
>> cloned skbs from __strp_rcv that may contain multiple coalesced packets.
>> The current implementation has two bugs:
>>
>> 1. Header offset overflow: Using pskb_pull with large offsets on
>>     coalesced skbs causes skb->data - skb->head to exceed the u16 storage
>>     of skb->network_header. This causes skb_reset_network_header to fail
>>     on the inner decapsulated packet, resulting in packet drops.
>>
>> 2. Unaligned protocol headers: Extracting packets from arbitrary
>>     positions within the coalesced TCP stream provides no alignment
>>     guarantees for the packet data causing performance penalties on
>>     architectures without efficient unaligned access. Additionally,
>>     openvpn's 2-byte length prefix on TCP packets causes the subsequent
>>     4-byte opcode and packet ID fields to be inherently misaligned.
>>
>> Fix both issues by allocating a new skb for each openvpn packet and
>> using skb_copy_bits to extract only the packet content into the new
>> buffer, skipping the 2-byte length prefix. Also, check the length before
>> invoking the function that performs the allocation to avoid creating an
>> invalid skb.
>>
>> If the packet has to be forwarded to userspace the 2-byte prefix can be
>> pushed to the head safely, without misalignment.
>>
>> As a side effect, this approach also avoids the expensive linearization
>> that pskb_pull triggers on cloned skbs with page fragments. In testing,
>> this resulted in TCP throughput improvements of up to 74%.
>>
>> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
>> Signed-off-by: Ralf Lici <ralf@...2726...>
>> ---
>> Changes since v1:
>> - updated the __skb_push usage for consistency with similar operations,
>>    such as in ovpn_tcp_send_skb
> 
> Reviewed-by: Sabrina Dubroca <sd@...2891...>

Thanks a lot, Sabrina!
I was particularly excited for this patch due to the speed boost given 
to TCP.

> 
> Sorry for the delay.

No worries - it seems Jakub et al are still busy with the merge window - 
the other patches are still waiting in the line too.

Will submit this as well ASAP!

Regards,

> 

-- 
Antonio Quartulli


