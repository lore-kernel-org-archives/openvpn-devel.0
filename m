Message-ID: <c62eff4b-b34d-4d27-891c-b9cb1b985958@...2181...>
Date: Tue, 1 Jul 2025 16:15:30 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: reset GSO metadata
 after decapsulation
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

Hi,

On 01/07/2025 15:51, Gert Doering wrote:
> Hi
> 
> On Tue, Jul 01, 2025 at 02:47:44PM +0200, Ralf Lici wrote:
>> By calling skb_gso_reset(skb) we ensure the inner packet is presented to
>> gro_cells_receive() with a clean slate, correctly indicating it is an
>> individual packet from the perspective of the local stack.
> 
> Amazing find.
> 
> I have tested this on my ubuntu 20.04 (backports) testbed that had the
> "large ping tcp instance -> udp instance fail", and now everything succeeds
> (this patch applied to "DCO version: ovpn-net-next/net-6.15.0-8f0bda6").
> 
> Tested-By: Gert Doering <gert@...1296...>

Thanks a lot for testing this out!
I slightly improved the commit message and added missing tags.

The patch has been queued for sending to net.

Regards,


-- 
Antonio Quartulli


