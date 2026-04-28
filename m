Message-ID: <d2074fd5-9e15-461a-8c1b-61c60879854d@...2181...>
Date: Tue, 28 Apr 2026 11:36:25 +0200
MIME-Version: 1.0
References: <20260427040011.2107748-1-qingfang.deng@...3026...>
 <101221c8-8e47-4fc1-9791-2ef3a0ae8312@...2181...>
 <501fb5d6-3247-40aa-aaa5-ce9dacb17255@...3026...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <501fb5d6-3247-40aa-aaa5-ce9dacb17255@...3026...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: reset MAC header
 before passing skb up
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
To: Qingfang Deng <qingfang.deng@...3026...>, openvpn-devel@lists.sourceforge.net
Cc: Minqiang Chen <ptpt52@...277...>, Sabrina Dubroca <sd@...2891...>, netdev@...2909..., antonio@...515...

Hi,

On 28/04/2026 04:08, Qingfang Deng wrote:
> Hi,
> 
> On 2026/4/27 17:45, Antonio Quartulli wrote:
>> Hi Qingfang,
>>
>> thanks for the patch!
>>
>> On 27/04/2026 06:00, Qingfang Deng wrote:
>>> After decapsulating a packet, the skb->mac_header still points to the
>>> outer transport header. Call skb_reset_mac_header() in
>>> ovpn_netdev_write() to ensure the MAC header points to the beginning of
>>> the inner IP packet.
>>
>> May you elaborate on what this is exactly fixing?
>> Did you encounter a bug triggered by this missing line?
>>
>> I am asking because I wonder what is "expected" as MAC header for a 
>> packet not having one at all (packets delivered to the ovpn interface 
>> are L3 only, as per the interface type itself).
> 
> For L3-only devices, the net core expects skb->mac_header == skb- 
>  >network_header.
> 
> For example, in __netif_receive_skb_core(), skb_reset_mac_len() sets 
> skb->mac_len to (skb->network_header - skb->mac_header).
> If skb->mac_header still has a stale value, this will incorrectly assign 
> a non-zero value to skb->mac_len.
> 
> Also, if generic XDP or SOCK_PACKET is used, either will do
>    skb_push(skb, skb->data - skb_mac_header(skb));

Thanks a lot! This makes sense!

I'm applying the patch to my tree.

Regards,


-- 
Antonio Quartulli


