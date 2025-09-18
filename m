Message-ID: <cd8193c9-1af8-4182-8e6a-a769acfde340@...109...>
Date: Thu, 18 Sep 2025 18:29:08 +0200
MIME-Version: 1.0
References: <20250912112420.4394-1-mmietus97@...109...>
 <20250912112420.4394-4-mmietus97@...109...> <aMlApjuzBJsHVMjN@...2915...>
Content-Language: en-US
From: Marek Mietus <mmietus97@...109...>
In-Reply-To: <aMlApjuzBJsHVMjN@...2915...>
Subject: Re: [Openvpn-devel] [PATCH net-next v2 3/3] net: ovpn: use new
 noref xmit flow in ovpn_udp4_output
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sabrina Dubroca <sd@...2891...>
Cc: netdev@...2909..., antonio@...515..., kuba@...2912..., openvpn-devel@lists.sourceforge.net

W dniu 9/16/25 o 12:49, Sabrina Dubroca pisze:
> 2025-09-12, 13:24:20 +0200, Marek Mietus wrote:
>> ovpn_udp4_output unnecessarily references the dst_entry from the
>> dst_cache.
> 
> This should probably include a description of why it's safe to skip
> the reference in this context.
> 

Noted, will do.

>> Reduce this overhead by using the newly implemented
>> udp_tunnel_xmit_skb_noref function and dst_cache helpers.
>>
>> Signed-off-by: Marek Mietus <mmietus97@...109...>
>> ---
>>  drivers/net/ovpn/udp.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index d6a0f7a0b75d..c5d289c23d2b 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>>  	int ret;
>>  
>>  	local_bh_disable();
>> -	rt = dst_cache_get_ip4(cache, &fl.saddr);
>> +	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
>>  	if (rt)
>>  		goto transmit;
>>  
>> @@ -194,12 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>>  				    ret);
>>  		goto err;
>>  	}
>> -	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
>> +	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
>>  
>>  transmit:
>> -	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
>> -			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
>> -			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
>> +	udp_tunnel_xmit_skb_noref(rt, sk, skb, fl.saddr, fl.daddr, 0,
>> +				  ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
>> +				  fl.fl4_dport, false, sk->sk_no_check_tx, 0);
>>  	ret = 0;
>>  err:
>>  	local_bh_enable();
>> @@ -269,7 +269,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>>  	 * fragment packets if needed.
>>  	 *
>>  	 * NOTE: this is not needed for IPv4 because we pass df=0 to
>> -	 * udp_tunnel_xmit_skb()
>> +	 * udp_tunnel_xmit_skb_noref()
>>  	 */
>>  	skb->ignore_df = 1;
>>  	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
> 
> Why are you changing only ipv4? Is there something in the ipv6 code
> that prevents this?
> 

I'm not sure. I'm not as acquainted with IPv6 as I am with IPv4. (and thought I'd hold off
until I got a positive response about the series)
IPv4 already has some noref xmit optimizations, so it just felt like the right place to start.

