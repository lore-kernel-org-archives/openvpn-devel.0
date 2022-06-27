Message-ID: <a75f6566-81ab-e4fe-9042-f9826245cdd8@...1227...>
Date: Mon, 27 Jun 2022 13:06:12 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-5-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220624083809.23487-5-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 04/25] dco: create DCO interface using
 SITNL
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 24.06.22 um 10:37 schrieb Antonio Quartulli:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>   src/openvpn/networking_sitnl.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
> index bffcb067..0944ad0a 100644
> --- a/src/openvpn/networking_sitnl.c
> +++ b/src/openvpn/networking_sitnl.c
> @@ -28,6 +28,7 @@
>   
>   #include "syshead.h"
>   
> +#include "dco.h"
>   #include "errlevel.h"
>   #include "buffer.h"
>   #include "misc.h"
> @@ -1344,6 +1345,16 @@ net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,
>   
>       struct rtattr *linkinfo = SITNL_NEST(&req.n, sizeof(req), IFLA_LINKINFO);
>       SITNL_ADDATTR(&req.n, sizeof(req), IFLA_INFO_KIND, type, strlen(type) + 1);
> +#if defined(ENABLE_DCO)
> +    if (arg && (strcmp(type, "ovpn-dco") == 0))
> +    {
> +        dco_context_t *dco = arg;
> +        struct rtattr *data = SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_DATA);
> +        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &dco->ifmode,
> +                      sizeof(uint8_t));
> +        SITNL_NEST_END(&req.n, data);
> +    }
> +#endif
>       SITNL_NEST_END(&req.n, linkinfo);
>   
>       req.i.ifi_family = AF_PACKET;

Acked-By: Arne Schwabe <arne@...1227...>

