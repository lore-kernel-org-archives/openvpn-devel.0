Message-ID: <55ed2890-1100-41a1-140d-b97b3b323981@...2181...>
Date: Mon, 8 Aug 2022 11:08:39 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220807193535.15377-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220807193535.15377-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Cleanup: get rid of 'dynamic' argument
 of open_tun_generic()
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 07/08/2022 21:35, Gert Doering wrote:
> All callers of open_tun_generic() always set dynamic=true - so just
> get rid of it.  While at it, move "int i" into the for() loop.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Patch does what it says and it is easy to verify that all invocations of 
open_tun_generic() were simply passing "true" as dynamic argument.

> ---
>   src/openvpn/tun.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 659bd245..6e7c0197 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1736,7 +1736,7 @@ tun_dco_enabled(struct tuntap *tt)
>   #if !(defined(_WIN32) || defined(TARGET_LINUX))
>   static void
>   open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
> -                 bool dynamic, struct tuntap *tt)
> +                 struct tuntap *tt)
>   {
>       char tunname[256];
>       char dynamic_name[256];
> @@ -1767,7 +1767,7 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
>                * opening /dev/tap and then querying the system about the
>                * actual device name (tap0, tap1, ...) assigned
>                */
> -            if (dynamic && strcmp( dev, "tap" ) == 0)
> +            if (strcmp( dev, "tap" ) == 0)

While at it you could have removed the spaces next to the parenthesis... :)

>               {
>                   struct ifreq ifr;
>                   if ((tt->fd = open( "/dev/tap", O_RDWR)) < 0)
> @@ -1786,10 +1786,9 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
>               else
>   #endif
>   
> -            if (dynamic && !tun_name_is_fixed(dev))
> +            if (!tun_name_is_fixed(dev))
>               {
> -                int i;
> -                for (i = 0; i < 256; ++i)
> +                for (int i = 0; i < 256; ++i)
>                   {
>                       openvpn_snprintf(tunname, sizeof(tunname),
>                                        "/dev/%s%d", dev, i);
> @@ -2682,7 +2681,7 @@ void
>   open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
>            openvpn_net_ctx_t *ctx)
>   {
> -    open_tun_generic(dev, dev_type, dev_node, true, tt);
> +    open_tun_generic(dev, dev_type, dev_node, tt);
>   
>       /* Enable multicast on the interface */
>       if (tt->fd >= 0)
> @@ -2777,7 +2776,7 @@ void
>   open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
>            openvpn_net_ctx_t *ctx)
>   {
> -    open_tun_generic(dev, dev_type, dev_node, true, tt);
> +    open_tun_generic(dev, dev_type, dev_node, tt);
>   
>       if (tt->fd >= 0)
>       {
> @@ -2918,7 +2917,7 @@ void
>   open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
>            openvpn_net_ctx_t *ctx)
>   {
> -    open_tun_generic(dev, dev_type, dev_node, true, tt);
> +    open_tun_generic(dev, dev_type, dev_node, tt);
>   
>       if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
>       {
> @@ -3047,7 +3046,7 @@ void
>   open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
>            openvpn_net_ctx_t *ctx)
>   {
> -    open_tun_generic(dev, dev_type, dev_node, true, tt);
> +    open_tun_generic(dev, dev_type, dev_node, tt);
>   
>       if (tt->fd >= 0)
>       {
> @@ -3300,7 +3299,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>               {
>                   /* No explicit utun and utun failed, try the generic way) */
>                   msg(M_INFO, "Failed to open utun device. Falling back to /dev/tun device");
> -                open_tun_generic(dev, dev_type, NULL, true, tt);
> +                open_tun_generic(dev, dev_type, NULL, tt);
>               }
>               else
>               {
> @@ -3323,7 +3322,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>               dev_node = NULL;
>           }
>   
> -        open_tun_generic(dev, dev_type, dev_node, true, tt);
> +        open_tun_generic(dev, dev_type, dev_node, tt);
>       }
>   }
>   
> @@ -7004,7 +7003,7 @@ void
>   open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
>            openvpn_net_ctx_t *ctx)
>   {
> -    open_tun_generic(dev, dev_type, dev_node, true, tt);
> +    open_tun_generic(dev, dev_type, dev_node, tt);
>   }
>   
>   void

other than my nitpick above,

Acked-by: Antonio Quartulli <a@...2181...>

Cheers,


-- 
Antonio Quartulli

