Message-ID: <278bcbd4-816c-dbbc-a77e-3101ce5caeba@...2181...>
Date: Tue, 9 Aug 2022 09:37:44 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220809072220.255-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220809072220.255-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] tun.c: remove unused gc_arena from
 init_tun()
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 09/08/2022 09:22, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Signed-off-by: Lev Stipakov <lev@...515...>

This gc thing is indeed unused and can go.

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/tun.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 54f7d72c..f3152a52 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -745,7 +745,6 @@ init_tun(const char *dev,        /* --dev option */
>            struct env_set *es,
>            openvpn_net_ctx_t *ctx)
>   {
> -    struct gc_arena gc = gc_new();
>       struct tuntap *tt;
>   
>       ALLOC_OBJ(tt, struct tuntap);
> @@ -878,7 +877,6 @@ init_tun(const char *dev,        /* --dev option */
>           do_ifconfig_setenv(tt, es);
>       }
>   
> -    gc_free(&gc);
>       return tt;
>   }
>   

-- 
Antonio Quartulli

