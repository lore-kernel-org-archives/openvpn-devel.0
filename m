References: <20190812134513.20758-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a1b2525b-fb00-4d8d-d877-797305c6ec2f@...2181...>
Date: Tue, 13 Aug 2019 11:03:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190812134513.20758-1-arne@...1227...>
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
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

On 12/08/2019 15:45, Arne Schwabe wrote:
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

Thanks for fixing this!

However you're missing the signed off line.


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

how about adding a "> 0"? I know it's basically the same here, but I
think that's the style we use everywhere.

Cheers,

>          {
>              rgi6->flags |= RGI_IFACE_DEFINED;
>          }
> 

-- 
Antonio Quartulli

