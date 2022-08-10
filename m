Message-ID: <11241e28-c90e-daf2-321e-3bda92850669@...2181...>
Date: Wed, 10 Aug 2022 14:54:51 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220810094605.123072-1-frank@...2641...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220810094605.123072-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] dco_p2p_add_new_peer: do not warn about
 missing default gw
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Hi,

On 10/08/2022 11:46, Frank Lichtenheld wrote:
> Currently we issue a message when using --ifconfig but
> not specifying a default gateway. This seems to be misleading,
> the setup will still work fine since in P2P we now send
> all traffic to the peer anyway. Or it might be irrelevant
> if all route specifications include a gateway anyway.
> 
> Since it is probably better to have no message than a
> misleading one, remove it.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>

Acked-by: Antonio Quartulli <a@...2181...>

Regards,

> ---
>   src/openvpn/dco.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index 4f40255e..8aa7e896 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -438,10 +438,6 @@ dco_p2p_add_new_peer(struct context *c)
>           }
>           remote_addr4 = &remote_ip4;
>       }
> -    else if (c->options.ifconfig_local)
> -    {
> -        msg(M_INFO, "DCO peer init: Need a peer VPN addresss to setup IPv4 (set --route-gateway)");
> -    }
>   
>       struct sockaddr *remoteaddr = &ls->info.lsa->actual.dest.addr.sa;
>   

-- 
Antonio Quartulli

