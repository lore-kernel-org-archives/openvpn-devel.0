References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-3-git-send-email-lstipakov@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <4b355202-a6b4-698f-2a15-1b72a5c5b11a@...1856...>
Date: Fri, 8 Nov 2019 15:36:17 +0100
MIME-Version: 1.0
In-Reply-To: <1573148729-27339-3-git-send-email-lstipakov@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/7] wintun: add --windows-driver
 config option
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
To: openvpn-devel@lists.sourceforge.net

Hi,

Thanks for looking into wintun support. Definitely feature-ack.

On 07-11-2019 18:45, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> This allows to specify which tun driver openvpn should use,
> tap-windows6 (default) or wintun.
> 
> Note than wintun support will be added in follow-up patches.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/init.c    |  7 +++++++
>  src/openvpn/options.c | 37 +++++++++++++++++++++++++++++++++++++
>  src/openvpn/options.h |  1 +
>  src/openvpn/tun.h     |  1 +
>  4 files changed, 46 insertions(+)

Should there not be a manpage entry in this commit too?

> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index ae7bd63..c6d4953 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1733,6 +1733,10 @@ do_init_tun(struct context *c)
>                              c->c2.es,
>                              &c->net_ctx);
>  
> +#ifdef _WIN32
> +    c->c1.tuntap->wintun = c->options.wintun;
> +#endif
> +
>      init_tun_post(c->c1.tuntap,
>                    &c->c2.frame,
>                    &c->options.tuntap_options);
> @@ -1775,6 +1779,9 @@ do_open_tun(struct context *c)
>      /* store (hide) interactive service handle in tuntap_options */
>      c->c1.tuntap->options.msg_channel = c->options.msg_channel;
>      msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
> +
> +    c->c1.tuntap->wintun = c->options.wintun;
> +

Why do we have to set c->c2.tuntap->wintun in both do_init_tun and
do_open_tun? Should one of them not suffice?

>  #endif
>  
>      /* allocate route list structure */
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 1838a69..5c5033e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -747,6 +747,9 @@ static const char usage_message[] =
>      "                       optional parameter controls the initial state of ex.\n"
>      "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
>      "                  after TAP adapter is up and routes have been added.\n"
> +    "--windows-driver   : Which tun driver to use?\n"
> +    "                     tap-windows6 (default)\n"
> +    "                     wintun\n"
>  #ifdef _WIN32

Should this --windows-driver option not be inside the #ifdef _WIN32 ?

>      "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
>  #endif
> @@ -851,6 +854,7 @@ init_options(struct options *o, const bool init_gc)
>      o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
>      o->route_method = ROUTE_METHOD_ADAPTIVE;
>      o->block_outside_dns = false;
> +    o->wintun = false;
>  #endif
>      o->vlan_accept = VLAN_ONLY_UNTAGGED_OR_PRIORITY;
>      o->vlan_pvid = 1;
> @@ -2994,6 +2998,12 @@ options_postprocess_mutate_invariant(struct options *options)
>          options->ifconfig_noexec = false;
>      }
>  
> +    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set IP address and netmask */
> +    if (options->wintun)
> +    {
> +        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
> +    }
> +
>      remap_redirect_gateway_flags(options);
>  #endif
>  
> @@ -4039,6 +4049,26 @@ foreign_option(struct options *o, char *argv[], int len, struct env_set *es)
>      }
>  }
>  
> +#ifdef _WIN32
> +bool
> +parse_windows_driver(const char *str, const int msglevel)

I think this should be a static function. Also a short (doxygen) comment
explaining what the return value means would be nice.

> +{
> +    if (streq(str, "tap-windows6"))
> +    {
> +        return false;
> +    }
> +    else if (streq(str, "wintun"))
> +    {
> +        return true;
> +    }
> +    else
> +    {
> +        msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
> +        return false;
> +    }
> +}
> +#endif
> +
>  /*
>   * parse/print topology coding
>   */
> @@ -5281,6 +5311,13 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->dev_type = p[1];
>      }
> +#ifdef _WIN32
> +    else if (streq(p[0], "windows-driver") && p[1] && !p[2])
> +    {
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        options->wintun = parse_windows_driver(p[1], M_FATAL);
> +    }
> +#endif
>      else if (streq(p[0], "dev-node") && p[1] && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index ff7a5bb..0a24e5e 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -632,6 +632,7 @@ struct options
>      bool show_net_up;
>      int route_method;
>      bool block_outside_dns;
> +    bool wintun;

Did you consider using an enum instead? I think it would make the code
easier to read. E.g. with

    typedef enum { WINDRV_TAP6, WINDRV_WINTUN } windrv_t;

in tun.h or so, we'd get

    options->windrv = WINDRV_TAP6

instead of

    options->wintun = false.

>  #endif
>  
>      bool use_peer_id;
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index 5a0a933..df935f6 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -175,6 +175,7 @@ struct tuntap
>       * ~0 if undefined */
>      DWORD adapter_index;
>  
> +    bool wintun; /* true if wintun is used instead of tap-windows6 */
>      int standby_iter;
>  #else  /* ifdef _WIN32 */
>      int fd; /* file descriptor for TUN/TAP dev */
> 

Thanks,
-Steffan

