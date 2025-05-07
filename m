Message-ID: <e3191a53-a530-428d-b67d-4d4bb02bd1d2@...2181...>
Date: Wed, 7 May 2025 21:39:23 +0200
MIME-Version: 1.0
References: <20250507085632.15329-1-a@...2181...>
 <aBsjqjXwhr4TxTWb@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <aBsjqjXwhr4TxTWb@...1296...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: don't drop skb's
 dst when xmitting packet
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

On 07/05/2025 11:11, Gert Doering wrote:
> Hi,
> 
> On Wed, May 07, 2025 at 10:56:32AM +0200, Antonio Quartulli wrote:
>> Clear the IFF_XMIT_DST_RELEASE flag during interface setup to allow
>> the route entry (skb's dst) to survive and thus be inspected
>> by the routing logic.
> 
> Tested, fixes the problem I reported in
> 
>    https://github.com/OpenVPN/ovpn-net-next/issues/2
> 
> ... and is also the arguably correct thing to do - packet forwarding
> resolves a next-hop for us, so we should ensure we see & use it :-)
> 
> Tested-by: Gert Doering <gert@...1296...>
> Acked-by: Gert Doering <gert@...1296...>
> 

Merged to main branch, commit id 7618f9707173

Thanks!

-- 
Antonio Quartulli


