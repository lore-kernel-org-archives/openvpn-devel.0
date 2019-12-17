MIME-Version: 1.0
References: <99D61A626FDA8A4B90A270669121BE10BDA4BD82@...2294...>
 <20191112144400.1359-1-lstipakov@...277...>
In-Reply-To: <20191112144400.1359-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 17 Dec 2019 18:44:05 -0500
Message-ID: <CAKuzo_jRGox=anW=OyTJdhBW9fcOMOfHnPT8V1-vWTy7xKPyZg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 7/7] wintun: clear adapter settings
 on tun close
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

Probably this is the only one in the series without an ACK.

v2 was reviewed by Simon and suggested changes are in here.
This looks good to me.

On Tue, Nov 12, 2019 at 9:44 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> With tap-windows6 we clear adapter settings with DHCP,
> but since wintun doesn't do DHCP we do it with netsh.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>
>  v3:
>   - simplify convoluted "if" statement
>
>  v2:
>   - rebase on top of master
>
>  src/openvpn/tun.c | 92 +++++++++++++++++++++++++++++------------------
>  1 file changed, 57 insertions(+), 35 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 8b16cd6a..a9036a6e 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6388,6 +6388,50 @@ tun_show_debug(struct tuntap *tt)
>      }
>  }
>
> +static void
> +netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc)
> +{
> +    const char* ifconfig_ip_local;

A minor nit: char *foo is our recommended style, I think.

> +    struct argv argv = argv_new();
> +
> +    /* "store=active" is needed in Windows 8(.1) to delete the
> +     * address we added (pointed out by Cedric Tabary).
> +     */
> +
> +     /* netsh interface ipvX delete address \"%s\" %s */
> +    if (ipv6)
> +    {
> +        ifconfig_ip_local = print_in6_addr(tt->local_ipv6, 0, gc);
> +    }
> +    else
> +    {
> +        ifconfig_ip_local = print_in_addr_t(tt->local, 0, gc);
> +    }
> +    argv_printf(&argv,
> +                "%s%sc interface %s delete address %s %s store=active",
> +                get_win_sys_path(),
> +                NETSH_PATH_SUFFIX,
> +                ipv6 ? "ipv6" : "ipv4",
> +                tt->actual_name,
> +                ifconfig_ip_local);
> +
> +    netsh_command(&argv, 1, M_WARN);
> +
> +    /* delete ipvX dns servers if any were set */
> +    int len = ipv6 ? tt->options.dns6_len : tt->options.dns_len;
> +    if (len > 0)
> +    {
> +        argv_printf(&argv,
> +                    "%s%sc interface %s delete dns %s all",
> +                    get_win_sys_path(),
> +                    NETSH_PATH_SUFFIX,
> +                    ipv6 ? "ipv6" : "ipv4",
> +                    tt->actual_name);
> +        netsh_command(&argv, 1, M_WARN);
> +    }
> +    argv_reset(&argv);
> +}
> +
>  void
>  close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
>  {
> @@ -6410,46 +6454,24 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
>          }
>          else
>          {
> -            const char *ifconfig_ipv6_local;
> -            struct argv argv = argv_new();
> -
> -            /* "store=active" is needed in Windows 8(.1) to delete the
> -             * address we added (pointed out by Cedric Tabary).
> -             */
> -
> -            /* netsh interface ipv6 delete address \"%s\" %s */
> -            ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0,  &gc);
> -            argv_printf(&argv,
> -                        "%s%sc interface ipv6 delete address %s %s store=active",
> -                        get_win_sys_path(),
> -                        NETSH_PATH_SUFFIX,
> -                        tt->actual_name,
> -                        ifconfig_ipv6_local);
> -
> -            netsh_command(&argv, 1, M_WARN);
> -
> -            /* delete ipv6 dns servers if any were set */
> -            if (tt->options.dns6_len > 0)
> -            {
> -                argv_printf(&argv,
> -                            "%s%sc interface ipv6 delete dns %s all",
> -                            get_win_sys_path(),
> -                            NETSH_PATH_SUFFIX,
> -                            tt->actual_name);
> -                netsh_command(&argv, 1, M_WARN);
> -            }
> -            argv_reset(&argv);
> +            netsh_delete_address_dns(tt, true, &gc);
>          }
>      }
>  #if 1
> -    if (tt->wintun && tt->options.msg_channel)
> +    if (tt->wintun)
>      {
> -        do_route_ipv4_service_tun(false, tt);
> -        do_address_service(false, AF_INET, tt);
> -        do_dns_service(false, AF_INET, tt);
> +        if (tt->options.msg_channel)
> +        {
> +            do_route_ipv4_service_tun(false, tt);
> +            do_address_service(false, AF_INET, tt);
> +            do_dns_service(false, AF_INET, tt);
> +        }
> +        else
> +        {
> +            netsh_delete_address_dns(tt, false, &gc);
> +        }
>      }
> -    else
> -    if (tt->ipapi_context_defined)
> +    else if (tt->ipapi_context_defined)
>      {
>          DWORD status;
>          if ((status = DeleteIPAddress(tt->ipapi_context)) != NO_ERROR)

Acked by: selva.nair@...277...

Selva

