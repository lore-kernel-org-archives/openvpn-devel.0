Message-ID: <501fb5d6-3247-40aa-aaa5-ce9dacb17255@...3026...>
Date: Tue, 28 Apr 2026 10:08:00 +0800
MIME-Version: 1.0
References: <20260427040011.2107748-1-qingfang.deng@...3026...>
 <101221c8-8e47-4fc1-9791-2ef3a0ae8312@...2181...>
From: Qingfang Deng <qingfang.deng@...3026...>
In-Reply-To: <101221c8-8e47-4fc1-9791-2ef3a0ae8312@...2181...>
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Minqiang Chen <ptpt52@...277...>, Sabrina Dubroca <sd@...2891...>, netdev@...2909...

Hi,

On 2026/4/27 17:45, Antonio Quartulli wrote:
> Hi Qingfang,
>
> thanks for the patch!
>
> On 27/04/2026 06:00, Qingfang Deng wrote:
>> After decapsulating a packet, the skb->mac_header still points to the
>> outer transport header. Call skb_reset_mac_header() in
>> ovpn_netdev_write() to ensure the MAC header points to the beginning of
>> the inner IP packet.
>
> May you elaborate on what this is exactly fixing?
> Did you encounter a bug triggered by this missing line?
>
> I am asking because I wonder what is "expected" as MAC header for a 
> packet not having one at all (packets delivered to the ovpn interface 
> are L3 only, as per the interface type itself).

For L3-only devices, the net core expects skb->mac_header == 
skb->network_header.

For example, in __netif_receive_skb_core(), skb_reset_mac_len() sets 
skb->mac_len to (skb->network_header - skb->mac_header).
If skb->mac_header still has a stale value, this will incorrectly assign 
a non-zero value to skb->mac_len.

Also, if generic XDP or SOCK_PACKET is used, either will do
   skb_push(skb, skb->data - skb_mac_header(skb));

>
> Thanks!
>
> Regards,
>
>>
>> Reported-by: Minqiang Chen <ptpt52@...277...>
>> Fixes: 8534731dbf2d ("ovpn: implement packet processing")
>> Signed-off-by: Qingfang Deng <qingfang.deng@...3026...>
>> ---
>>   drivers/net/ovpn/io.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index db43a1f8a07a..d92bb87be2b2 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -85,6 +85,7 @@ static void ovpn_netdev_write(struct ovpn_peer 
>> *peer, struct sk_buff *skb)
>>       skb_scrub_packet(skb, true);
>>         /* network header reset in ovpn_decrypt_post() */
>> +    skb_reset_mac_header(skb);
>>       skb_reset_transport_header(skb);
>>       skb_reset_inner_headers(skb);
>
+Cc: netdev

Regards,

Qingfang


