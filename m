MIME-Version: 1.0
References: <20211108135314.148-1-lstipakov@...277...>
In-Reply-To: <20211108135314.148-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 10 Nov 2021 13:02:55 +0200
Message-ID: <CAGyAFMXNkPr2mdFu=MbWF97HAbboKPReb4hRuOQ9Ui9m3qdR1A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun: improve DHCP server address
 calculation for small subnets
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This can be considered as a bugfix ("Cannot use openvpn2 as OpenVPN
Cloud connector") so could go into release/2.5 too.

ke 10. marrask. 2021 klo 12.59 Lev Stipakov (lstipakov@...277...) kirjoitti:
>
> From: Lev Stipakov <lev@...515...>
>
> When /30 subnet is pushed (like in the case of OpenVPN Cloud),
> DHCP server address is calculated to be the same as local address,
> which causes collision and therefore connection is not established.
>
> To fix that, use openvpn3 approach, which sets DHCP server
> address to a network address for small subnets
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 28f803ec..994e3751 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -6363,7 +6363,9 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char *device_guid)
>              }
>              else
>              {
> -                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, -1);
> +                int prefix_len = netmask_to_netbits2(tt->adapter_netmask);
> +                /* use network address as DHCP server for small subnets, otherwise last address before broadcast */
> +                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, prefix_len < 28 ? -1 : 0);
>              }
>          }
>          else
> --
> 2.23.0.windows.1
>


-- 
-Lev

