Message-ID: <384e846b-e49d-fa3f-2941-27b8bff004a6@...2181...>
Date: Tue, 4 Oct 2022 17:16:00 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221004145318.98467-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20221004145318.98467-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] un-break undo_ifconfig_ipv4()/_ipv6()
 on all non-linux/non-win32 platforms
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

On 04/10/2022 16:53, Gert Doering wrote:
>   src/openvpn/tun.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 5ea460a6..3cecff4f 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1635,17 +1635,20 @@ undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
>                   tt->actual_name);
>           }
>       }
> -#elif !defined(_WIN32)  /* if !defined(TARGET_LINUX) && !defined(_WIN32) */
> +#elif TARGET_FREEBSD

I think this needs to be *defined*(TARGET_FREEBSD)

Same below.

Cheers,

> +    struct gc_arena gc = gc_new();
> +    const char *ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
>       struct argv argv = argv_new();
>   
> -    argv_printf(&argv, "%s %s 0.0.0.0", IFCONFIG_PATH, tt->actual_name);
> -
> +    argv_printf(&argv, "%s %s %s -alias", IFCONFIG_PATH,
> +                tt->actual_name, ifconfig_local);
>       argv_msg(M_INFO, &argv);
> -    openvpn_execve_check(&argv, NULL, 0, "Generic ip addr del failed");
> +    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip addr del failed");
>   
>       argv_free(&argv);
> +    gc_free(&gc);
>   #endif /* if defined(TARGET_LINUX) */
> -       /* Empty for _WIN32. */
> +       /* Empty for _WIN32 and all other unixoid platforms */
>   }
>   
>   static void
> @@ -1657,21 +1660,21 @@ undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
>       {
>           msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->actual_name);
>       }
> -#elif !defined(_WIN32)  /* if !defined(TARGET_LINUX) && !defined(_WIN32) */
> +#elif TARGET_FREEBSD
>       struct gc_arena gc = gc_new();
>       const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
>       struct argv argv = argv_new();
>   
> -    argv_printf(&argv, "%s %s del %s/%d", IFCONFIG_PATH, tt->actual_name,
> -                ifconfig_ipv6_local, tt->netbits_ipv6);
> +    argv_printf(&argv, "%s %s inet6 %s/%d -alias", IFCONFIG_PATH,
> +                tt->actual_name, ifconfig_ipv6_local, tt->netbits_ipv6);
>   
>       argv_msg(M_INFO, &argv);
> -    openvpn_execve_check(&argv, NULL, 0, "Generic ip -6 addr del failed");
> +    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip -6 addr del failed");
>   
>       argv_free(&argv);
>       gc_free(&gc);
>   #endif /* if defined(TARGET_LINUX) */
> -       /* Empty for _WIN32. */
> +       /* Empty for _WIN32 and all other unixoid platforms */
>   }
>   
>   void

-- 
Antonio Quartulli

