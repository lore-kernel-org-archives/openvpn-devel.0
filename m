Message-ID: <f4d5e99d-cbcd-4c8f-b6f3-8bf7617f1518@...2181...>
Date: Thu, 12 Feb 2026 15:07:58 +0100
MIME-Version: 1.0
References: <20260205151036.743792-1-ralf@...2726...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20260205151036.743792-1-ralf@...2726...>
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
To: Sabrina Dubroca <sd@...2891...>, openvpn-devel@lists.sourceforge.net

On 05/02/2026 16:10, Ralf Lici wrote:
> When processing TCP stream data in ovpn_tcp_recv, we receive large
> cloned skbs from __strp_rcv that may contain multiple coalesced packets.
> The current implementation has two bugs:
> 
> 1. Header offset overflow: Using pskb_pull with large offsets on
>     coalesced skbs causes skb->data - skb->head to exceed the u16 storage
>     of skb->network_header. This causes skb_reset_network_header to fail
>     on the inner decapsulated packet, resulting in packet drops.
> 
> 2. Unaligned protocol headers: Extracting packets from arbitrary
>     positions within the coalesced TCP stream provides no alignment
>     guarantees for the packet data causing performance penalties on
>     architectures without efficient unaligned access. Additionally,
>     openvpn's 2-byte length prefix on TCP packets causes the subsequent
>     4-byte opcode and packet ID fields to be inherently misaligned.
> 
> Fix both issues by allocating a new skb for each openvpn packet and
> using skb_copy_bits to extract only the packet content into the new
> buffer, skipping the 2-byte length prefix. Also, check the length before
> invoking the function that performs the allocation to avoid creating an
> invalid skb.
> 
> If the packet has to be forwarded to userspace the 2-byte prefix can be
> pushed to the head safely, without misalignment.
> 
> As a side effect, this approach also avoids the expensive linearization
> that pskb_pull triggers on cloned skbs with page fragments. In testing,
> this resulted in TCP throughput improvements of up to 74%.
> 
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Ralf Lici <ralf@...2726...>

Sabrina, isn't this something that may be interesting to espintcp too?
Given the speed boost, it should be easy to convince people to accept 
the change :)


Regards,


-- 
Antonio Quartulli


