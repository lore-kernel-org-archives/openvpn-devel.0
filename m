References: <20210714162533.10098-1-david@...2627...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7b1e2246-8375-0369-1d27-6100cc03b872@...2181...>
Date: Thu, 15 Jul 2021 08:47:13 +0200
MIME-Version: 1.0
In-Reply-To: <20210714162533.10098-1-david@...2627...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix leaks in route.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: David Korczynski <david@...2627...>, openvpn-devel@lists.sourceforge.net

Hi,

On 14/07/2021 18:25, David Korczynski wrote:
> Signed-off-by: David Korczynski <david@...2627...>

Some commit message is always good - just to give context to the reader
without the need to look at the rest of the code.

But if Gert is fine without it, I am fine too.

> ---
>  src/openvpn/route.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 56fa7717..e429e8c0 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1584,6 +1584,7 @@ add_route(struct route_ipv4 *r,
> 
>      if (!(r->flags & RT_DEFINED))
>      {
> +        argv_free(&argv);
>          return;
>      }
> 
> @@ -1891,6 +1892,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
> 
>      if (!(r6->flags & RT_DEFINED) )
>      {
> +        argv_free(&argv);
>          return;
>      }
> 

I agree with Gert that not having RT_DEFINED is indeed impossible with
the current code, because that flag is always set when creating a route.
However, this function does not know about it and it is correct to keep
this check.

Since we keep this check, we indeed need to properly bail out and do not
leak.

Thanks for noticing and fixing this!

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

