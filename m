References: <20210403172403.9452-1-selva.nair@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <44f046fa-e1fd-6bb4-df4c-5de3d107dd0f@...2181...>
Date: Sun, 4 Apr 2021 09:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <20210403172403.9452-1-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] tun.c on WIN32: remove more unused
 variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Hi,

On 03/04/2021 19:24, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> Fixes:
>   tun.c: In function ‘do_ifconfig_ipv4’:
>   tun.c:1217:17: warning: variable ‘ifconfig_remote_netmask’ set but not
>   used [-Wunused-but-set-variable]
>      const char *ifconfig_remote_netmask = NULL;
> 
>   tun.c:1213:10: warning: unused variable ‘tun’ [-Wunused-variable]
>      bool tun = is_tun_p2p(tt);
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 6b7c8ef1..8ff825f4 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1207,10 +1207,12 @@ static void
>  do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
>                   const struct env_set *es, openvpn_net_ctx_t *ctx)

this function....it's an ifdef trap.

>  {
> +#if !defined(_WIN32) && !defined(TARGET_ANDROID)
>      /*
>       * We only handle TUN/TAP devices here, not --dev null devices.
>       */
>      bool tun = is_tun_p2p(tt);
> +#endif
>  
>  #if !defined(TARGET_LINUX)
>      const char *ifconfig_local = NULL;
> @@ -1534,7 +1536,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
>          msg(M_INFO,
>              "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
>              ifname, ifconfig_local,
> -            print_in_addr_t(tt->adapter_netmask, 0, &gc));
> +            ifconfig_remote_netmask);

I think this should just go on the line above?
It will still fit our 80 chars limit.


>      }
>      else if (tt->options.ip_win32_type == IPW32_SET_DHCP_MASQ || tt->options.ip_win32_type == IPW32_SET_ADAPTIVE)
>      {
> 

Rest looks good.

Compile tested on linux and windows, but couldn't test android. Still I
visually verified that this variable is indeed not used in windows and
android blocks only (used in all other cases).

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

