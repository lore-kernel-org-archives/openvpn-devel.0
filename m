Message-ID: <c490d496-f555-db7d-257e-ab1a9a6234e1@...2181...>
Date: Mon, 20 Feb 2023 21:09:33 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230220085640.1519-1-lstipakov@...277...>
 <20230220090601.983-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230220090601.983-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Disabe DCO if proxy is set via
 management
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

On 20/02/2023 10:06, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> DCO doesn't support proxy and we already disable DCO
> is proxy is set in profile.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   v2: use dco_enabled() helper function
> 
>   src/openvpn/init.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b500d354..622239f6 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -223,6 +223,12 @@ management_callback_proxy_cmd(void *arg, const char **p)
>       }
>       else if (p[2] && p[3])
>       {
> +        if (dco_enabled(&c->options))
> +        {
> +            msg(M_INFO, "Proxy set via management, disabling Data Channel Offload.");
> +            c->options.tuntap_options.disable_dco = true;
> +        }
> +
>           if (streq(p[1], "HTTP"))
>           {
>               struct http_proxy_options *ho;

-- 
Antonio Quartulli

