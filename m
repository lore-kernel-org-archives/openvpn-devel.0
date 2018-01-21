MIME-Version: 1.0
In-Reply-To: <20171205121952.13008-1-EngyCZ@...277...>
References: <20171205121952.13008-1-EngyCZ@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Jan 2018 17:21:39 -0500
Message-ID: <CAKuzo_g6YTkx+-3i=TEFn9b2yPjx9rBweTz=4H7uuOT8VokEdg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add a warning for disabled DHCP media
 sense on Window
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?SmnFmcOtIEVuZ2VsdGhhbGVy?= <EngyCZ@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I haven't tested this, but looks like a useful thing to do. The code
looks good too. Some minor comments below:

On Tue, Dec 5, 2017 at 7:19 AM, Ji=C5=99=C3=AD Engelthaler <EngyCZ@...1663...=
.> wrote:
> When DHCP media sense configuration is disabled, network applications
> including DHCP client will not receive information about link status
> changes and the link seems to be always connected. This lead to the
> non-renewal DHCP address on OpenVPN connect.
>
> DHCP media sense status can by shown with command
> "netsh interface ipv4 show global"
>
> There are several reports of problems with DHCP address renewal.
> https://community.openvpn.net/openvpn/ticket/665
> https://community.openvpn.net/openvpn/ticket/807
>
> Added checking of disabled DHCP media sense and print a warning with
> forced dhcp-renew option and suggestion to enable DHCP media sense.

Typo in commit header: "Window" should be "Windows"

>
> Signed-off-by: Ji=C5=99=C3=AD Engelthaler <EngyCZ@...277...>
> ---
>  src/openvpn/tun.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 25831ce3..35811975 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -62,6 +62,8 @@
>  #define NI_IP_NETMASK  (1<<1)
>  #define NI_OPTIONS     (1<<2)
>
> +#define TCPIP_PARAMS "SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parame=
ters"
> +

This is only used inside get_dhcp_media_sense. Better move it there as
a const char *. Less macros, the better.

>  static void netsh_ifconfig(const struct tuntap_options *to,
>                             const char *flex_name,
>                             const in_addr_t ip,
> @@ -3827,6 +3829,56 @@ get_panel_reg(struct gc_arena *gc)
>      return first;
>  }
>
> +/*
> + * Return DhcpMediaSense enabled value
> + */
> +static bool
> +get_dhcp_media_sense(void)
> +{
> +    HKEY tcpip_params;
> +    LONG status;
> +    DWORD len;
> +    char  disable_dhcp_media_sense_string[] =3D "DisableDHCPMediaSense";

This would benefit from a const.

> +    DWORD disable_dhcp_media_sense;
> +    DWORD data_type;
> +    bool ret_value =3D true;
> +
> +    status =3D RegOpenKeyEx(
> +        HKEY_LOCAL_MACHINE,
> +        TCPIP_PARAMS,
> +        0,
> +        KEY_READ,
> +        &tcpip_params);

I'm not sure whether its specified in the newly adopted style, but
please avoid writing one argument per line.  Original has many such,
but not preferred in new code.

> +
> +    if (status !=3D ERROR_SUCCESS)
> +    {
> +        msg(M_WARN, "Error opening registry key: %s", TCPIP_PARAMS);
> +    }
> +    else
> +    {
> +        len =3D sizeof(disable_dhcp_media_sense);
> +        status =3D RegQueryValueEx(
> +            tcpip_params,
> +            disable_dhcp_media_sense_string,
> +            NULL,
> +            &data_type,
> +            (PBYTE)&disable_dhcp_media_sense,
> +            &len);

Same here.

> +
> +        if (status =3D=3D ERROR_SUCCESS && data_type =3D=3D REG_DWORD)
> +        {
> +            if (disable_dhcp_media_sense !=3D 0)
> +            {
> +                ret_value =3D false;
> +            }
> +        }
> +
> +        RegCloseKey(tcpip_params);
> +    }
> +
> +    return ret_value;
> +}
> +
>  /*
>   * Check that two addresses are part of the same 255.255.255.252 subnet.
>   */
> @@ -5901,6 +5953,13 @@ open_tun(const char *dev, const char *dev_type, co=
nst char *dev_node, struct tun
>      {
>          uint32_t ep[4];
>
> +        /* Check DHCP media sense value */
> +        if (!tt->options.dhcp_renew && !get_dhcp_media_sense())
> +        {
> +            msg(M_WARN, "WARNING: DHCP media sense disabled, dhcp_renew =
option forced. You can enable media sense with \"netsh interface ipv4 set g=
lobal dhcpmediasense=3Denabled\" shell command");
> +            tt->options.dhcp_renew =3D true;
> +        }
> +
>          /* We will answer DHCP requests with a reply to set IP/subnet to=
 these values */
>          ep[0] =3D htonl(tt->local);
>          ep[1] =3D htonl(tt->adapter_netmask);

Thanks,

Selva

