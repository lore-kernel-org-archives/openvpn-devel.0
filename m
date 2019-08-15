References: <20190812134513.20758-1-arne@...1227...>
 <20190815115203.15467-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ef625237-89df-cae8-9821-8c36f436dd63@...2181...>
Date: Thu, 15 Aug 2019 13:58:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190815115203.15467-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix check if iface name is set
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

better mark the patches with v2.
They are also both missing the signed-off-by line.

how about git format-patch -v2 -s -2 ? :)

Cheers,

On 15/08/2019 13:52, Arne Schwabe wrote:
> Clang/Android complained
> 
>  warning: address of array 'rgi6->iface' will always evaluate to 'true' [-Wpointer-bool-conversion]
>           if (rgi6->iface)
> 
> iface is a char[16]; So its pointer is always true.
> 
> we do a CLEAR(rgi6) always before setting this struct and strcpy the
> name into iface. So using strlen instead of checking for the pointer
> should be the right fix.
> ---
>  src/openvpn/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 5f63fd34..a302746e 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -3349,7 +3349,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
>              rgi6->flags |= RGI_ADDR_DEFINED;
>          }
>  
> -        if (rgi6->iface)
> +        if (strlen(rgi6->iface))
>          {
>              rgi6->flags |= RGI_IFACE_DEFINED;
>          }
> 

-- 
Antonio Quartulli

