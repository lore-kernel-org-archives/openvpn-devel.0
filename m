Message-ID: <8f4f2e11-6418-58ac-0fd5-f9a19450102a@...2181...>
Date: Sat, 22 Oct 2022 09:01:43 +0200
MIME-Version: 1.0
References: <20221022061619.3923529-1-git@...2701...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221022061619.3923529-1-git@...2701...>
Subject: Re: [Openvpn-devel] [PATCH] ovpn-dco: fix kernel 6.1 compile issue
 in ovpn_peer_create
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
To: John Thomson <git@...2701...>, openvpn-devel@lists.sourceforge.net

Hi John,

Thanks a lot for your contribution!

However, we can't have #ifs like that in the middle of the code, as this 
code is expected to go upstream (and #ifs on the kernel version are not 
allowed).

The code should always work with the latest kernel version, while any 
magic compatibility trick should be hidden in compat.h (i.e. implement 
netif_napi_add_tx() so that it calls netif_tx_napi_add(..., 
NAPI_POLL_WEIGHT)).

Cheers,

On 22/10/2022 08:16, John Thomson wrote:
> Linux 5.19 replaces netif_tx_napi_add, but maintains a definition to the
> new function in: 58caed3dacb4 ("netdev: reshuffle netif_napi_add() APIs
> to allow dropping weigh") [0]
> 
> Linux 6.1 removes netif_tx_napi_add in c3f760ef1287 ("net: remove
> netif_tx_napi_add()") [1]
> 
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58caed3dacb4354a25a1aa8d2febc3e9648ba1f4
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c3f760ef128789252e7c4f10d3c1721422dceba9
> 
> Signed-off-by: John Thomson <git@...2701...>
> ---
> compile test only, on kernel 6.1rc1
> ---
>   drivers/net/ovpn-dco/peer.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ovpn-dco/peer.c b/drivers/net/ovpn-dco/peer.c
> index 5838286..c460976 100644
> --- a/drivers/net/ovpn-dco/peer.c
> +++ b/drivers/net/ovpn-dco/peer.c
> @@ -88,8 +88,12 @@ static struct ovpn_peer *ovpn_peer_create(struct ovpn_struct *ovpn, u32 id)
>   	}
>   
>   	/* configure and start NAPI */
> +#if(LINUX_VERSION_CODE < KERNEL_VERSION(5,19,0))
>   	netif_tx_napi_add(ovpn->dev, &peer->napi, ovpn_napi_poll,
>   			  NAPI_POLL_WEIGHT);
> +#else
> +	netif_napi_add_tx(ovpn->dev, &peer->napi, ovpn_napi_poll);
> +#endif
>   	napi_enable(&peer->napi);
>   
>   	dev_hold(ovpn->dev);

-- 
Antonio Quartulli

