Message-ID: <101221c8-8e47-4fc1-9791-2ef3a0ae8312@...2181...>
Date: Mon, 27 Apr 2026 11:45:56 +0200
MIME-Version: 1.0
References: <20260427040011.2107748-1-qingfang.deng@...3026...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20260427040011.2107748-1-qingfang.deng@...3026...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Qingfang Deng <qingfang.deng@...3026...>, openvpn-devel@lists.sourceforge.net
Cc: Minqiang Chen <ptpt52@...277...>, Sabrina Dubroca <sd@...2891...>

Hi Qingfang,

thanks for the patch!

On 27/04/2026 06:00, Qingfang Deng wrote:
> After decapsulating a packet, the skb->mac_header still points to the
> outer transport header. Call skb_reset_mac_header() in
> ovpn_netdev_write() to ensure the MAC header points to the beginning of
> the inner IP packet.

May you elaborate on what this is exactly fixing?
Did you encounter a bug triggered by this missing line?

I am asking because I wonder what is "expected" as MAC header for a 
packet not having one at all (packets delivered to the ovpn interface 
are L3 only, as per the interface type itself).

Thanks!

Regards,

> 
> Reported-by: Minqiang Chen <ptpt52@...277...>
> Fixes: 8534731dbf2d ("ovpn: implement packet processing")
> Signed-off-by: Qingfang Deng <qingfang.deng@...3026...>
> ---
>   drivers/net/ovpn/io.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index db43a1f8a07a..d92bb87be2b2 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -85,6 +85,7 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>   	skb_scrub_packet(skb, true);
>   
>   	/* network header reset in ovpn_decrypt_post() */
> +	skb_reset_mac_header(skb);
>   	skb_reset_transport_header(skb);
>   	skb_reset_inner_headers(skb);
>   

-- 
Antonio Quartulli


