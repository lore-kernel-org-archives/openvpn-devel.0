MIME-Version: 1.0
In-Reply-To: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
References: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Jan 2018 13:45:26 -0500
Message-ID: <CAKuzo_hN5A=LB7sp7m3REEpMsePSm-8dpXQUNtbQJz6y8w7zOw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: Set interface IPv6 prefix
 length when configuring address
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
To: Eyal Birger <eyal.birger@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I'm on a reviewing spree (doing my penance), so here goes..

Thanks for the patch

On Tue, Jan 9, 2018 at 2:16 AM, Eyal Birger <eyal.birger@...277...> wrote:
> Address prefix length defaults to /64 on Windows. This change allows using
> Windows clients in setups that use a different prefix length.
>
> Note: the ability to set the prefix length is documented in the netsh
> 'add address' command, but works on the 'set address' command as well.

Aside:
If interactive service is in use, the ip helper API is used and setting
prefix already works.  Ideally I would like to see openvpn on Windows
used only with the interactive service, but we are not there yet --
instances started by the automatic service does not use it and there
are some users still running the GUI as admin for some inexplicable
reasons.

So we need to continue supporting these code paths.

>
> Signed-off-by: Eyal Birger <eyal.birger@...277...>
> ---
>  src/openvpn/tun.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 25831ce..b2b4795 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1561,15 +1561,16 @@ do_ifconfig(struct tuntap *tt,
>              }
>              else
>              {
> -                /* example: netsh interface ipv6 set address interface=42 2001:608:8003::d store=active */
> +                /* example: netsh interface ipv6 set address interface=42 2001:608:8003::d/64 store=active */
>                  char iface[64];
>                  openvpn_snprintf(iface, sizeof(iface), "interface=%lu", tt->adapter_index );
>                  argv_printf(&argv,
> -                            "%s%sc interface ipv6 set address %s %s store=active",
> +                            "%s%sc interface ipv6 set address %s %s/%d store=active",
>                              get_win_sys_path(),
>                              NETSH_PATH_SUFFIX,
>                              iface,
> -                            ifconfig_ipv6_local );
> +                            ifconfig_ipv6_local,
> +                            tt->netbits_ipv6);
>                  netsh_command(&argv, 4, M_FATAL);
>                  /* set ipv6 dns servers if any are specified */
>                  netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, actual);

Works as expected and the code is good.

Currently, on setting the address, a default route gets set with
prefix /64 with gateway as OnLink (does not happen when iphelper api
is used). Although our explicit route to fe80::8 may override it, it
looks better to set the correct prefix in the address. So:

Acked-by: Selva Nair <selva.nair@...277...>

Selva

P.S. While going through this I noticed a bug in our route deletion code
for ipv6: only when using netsh (not the interactiveservice), so gone
unnoticed. Will report separately.

