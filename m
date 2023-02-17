MIME-Version: 1.0
References: <20230216160129.994-1-lstipakov@...277...>
In-Reply-To: <20230216160129.994-1-lstipakov@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 17 Feb 2023 16:18:18 +0200
Message-ID: <CAGyAFMVsz-T2z9a+LYac7LbKVotUpnGsQe_raC6i=JrRyDm13A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add logging for windows driver
 selection process
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
To: openvpn-devel@lists.sourceforge.net

I should have added to commit message that this additional logging is
useful for debugging problems like
https://github.com/OpenVPN/ovpn-dco-win/issues/38 and output looks
like:

Fri Feb 17 15:46:20 2023 Enumerate drivers in registy:
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{E64EA53B-41FA-4F37-8658-A68DE59272CF}, Driver: tap-windows6
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{97440710-931B-4719-ACEA-83AEB0430011}, Driver: ovpn-dco
Fri Feb 17 15:46:20 2023 Enumerate device interface lists:
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{D62160BF-ADA5-4582-B3BB-1362F5C77DCD}, Device Interface:
\\?\PCI#VEN_17CB&DEV_1103&SUBSYS_010817CB&REV_01#4&135c537a&0&0000#{cac88484-7515-4c03-82e6-71a87abac361}\{D62160BF-ADA5-4582-B3BB-1362F5C77DCD}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{D62160BF-ADA5-4582-B3BB-1362F5C77DCD}, Device Interface:
\\?\PCI#VEN_17CB&DEV_1103&SUBSYS_010817CB&REV_01#4&135c537a&0&0000#{cac88484-7515-4c03-82e6-71a87abac361}\{AD486582-50DD-4CF7-B6F0-826F1EE09FA1}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{D62160BF-ADA5-4582-B3BB-1362F5C77DCD}, Device Interface:
\\?\PCI#VEN_17CB&DEV_1103&SUBSYS_010817CB&REV_01#4&135c537a&0&0000#{cac88484-7515-4c03-82e6-71a87abac361}\{2AEA60AB-B619-4C5D-969E-F1736AB124B2}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{D62160BF-ADA5-4582-B3BB-1362F5C77DCD}, Device Interface:
\\?\PCI#VEN_17CB&DEV_1103&SUBSYS_010817CB&REV_01#4&135c537a&0&0000#{cac88484-7515-4c03-82e6-71a87abac361}\{4069B54A-BDF7-434E-822E-383B91DCF765}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{A2D2196D-0F52-41B9-A15A-266B02FC0FBB}, Device Interface:
\\?\BTH#MS_BTHPAN#4&2159fb6f&0&2#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{2E303C7D-E67D-4357-841E-5B9B2F850F7D}, Device Interface:
\\?\SWD#MSRRAS#MS_PPPOEMINIPORT#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{AE47B04F-E5B0-4ABC-875B-61E04322BC34}, Device Interface:
\\?\SWD#MSRRAS#MS_PPTPMINIPORT#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{5974F814-121E-4227-84D8-0AFE420DD336}, Device Interface:
\\?\SWD#MSRRAS#MS_AGILEVPNMINIPORT#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{D9D95527-796B-49E9-877F-27E0E2234EF8}, Device Interface:
\\?\SWD#MSRRAS#MS_NDISWANBH#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{BA115711-7296-451E-9680-4BD109D45848}, Device Interface:
\\?\SWD#MSRRAS#MS_NDISWANIP#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{5C971ACD-0644-4551-B501-6EDB2326C99D}, Device Interface:
\\?\SWD#MSRRAS#MS_SSTPMINIPORT#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{20478BC0-BB6F-4CFD-ADE4-BC3A1B715361}, Device Interface:
\\?\USB#VID_045E&PID_0C5E#000000000000#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{20478BC0-BB6F-4CFD-ADE4-BC3A1B715361}, Device Interface:
\\?\USB#VID_045E&PID_0C5E#000000000000#{cac88484-7515-4c03-82e6-71a87abac361}\{20478BC0-BB6F-4CFD-ADE4-BC3A1B715361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{1C57D9BE-AD49-44A6-B457-458D260D73CF}, Device Interface:
\\?\SWD#MSRRAS#MS_NDISWANIPV6#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{BC6209CD-7521-413D-96DE-5A2492BCD64C}, Device Interface:
\\?\SWD#MSRRAS#MS_L2TPMINIPORT#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{E64EA53B-41FA-4F37-8658-A68DE59272CF}, Device Interface:
\\?\ROOT#NET#0000#{cac88484-7515-4c03-82e6-71a87abac361}
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{97440710-931B-4719-ACEA-83AEB0430011}, Device Interface:
\\?\ROOT#NET#0001#{cac88484-7515-4c03-82e6-71a87abac361}\ovpn-dco
Fri Feb 17 15:46:20 2023 NetCfgInstanceId:
{97440710-931B-4719-ACEA-83AEB0430011}, Device Interface:
\\?\ROOT#NET#0001#{cac88484-7515-4c03-82e6-71a87abac361}\{97440710-931B-4719-ACEA-83AEB0430011}
Fri Feb 17 15:46:20 2023 Using device interface:
\\?\ROOT#NET#0001#{cac88484-7515-4c03-82e6-71a87abac361}\ovpn-dco
Fri Feb 17 15:46:20 2023 ovpn-dco device [OpenVPN Data Channel Offload] opened

The log level is 6, so normally this is not visible for the users.

to 16. helmik. 2023 klo 18.01 Lev Stipakov (lstipakov@...277...) kirjoitti:
>
> From: Lev Stipakov <lev@...515...>
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/tun.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 20f80798..a1414d23 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -3705,6 +3705,7 @@ get_device_instance_id_interface(struct gc_arena *gc)
>          msg(M_FATAL, "Error [%u] opening device information set key: %s", (unsigned int)err, strerror_win32(err, gc));
>      }
>
> +    msg(D_TAP_WIN_DEBUG, "Enumerate device interface lists:");
>      for (DWORD i = 0;; ++i)
>      {
>          SP_DEVINFO_DATA device_info_data;
> @@ -3790,6 +3791,10 @@ get_device_instance_id_interface(struct gc_arena *gc)
>              dev_iif->net_cfg_instance_id = (unsigned char *)string_alloc((char *)net_cfg_instance_id, gc);
>              dev_iif->device_interface = string_alloc(dev_if, gc);
>
> +            msg(D_TAP_WIN_DEBUG, "NetCfgInstanceId: %s, Device Interface: %s",
> +                dev_iif->net_cfg_instance_id,
> +                dev_iif->device_interface);
> +
>              /* link into return list */
>              if (!first)
>              {
> @@ -3835,6 +3840,7 @@ get_tap_reg(struct gc_arena *gc)
>          msg(M_FATAL, "Error opening registry key: %s", ADAPTER_KEY);
>      }
>
> +    msg(D_TAP_WIN_DEBUG, "Enumerate drivers in registy: ");
>      while (true)
>      {
>          char enum_name[256];
> @@ -3942,6 +3948,9 @@ get_tap_reg(struct gc_arena *gc)
>                              last->next = reg;
>                          }
>                          last = reg;
> +
> +                        msg(D_TAP_WIN_DEBUG, "NetCfgInstanceId: %s, Driver: %s",
> +                            reg->guid, print_windows_driver(reg->windows_driver));
>                      }
>                  }
>              }
> @@ -6520,6 +6529,8 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
>          path = tuntap_device_path;
>      }
>
> +    msg(D_TAP_WIN_DEBUG, "Using device interface: %s", path);
> +
>      tt->hand = CreateFile(path,
>                            GENERIC_READ | GENERIC_WRITE,
>                            0,         /* was: FILE_SHARE_READ */
> @@ -6529,7 +6540,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
>                            0);
>      if (tt->hand == INVALID_HANDLE_VALUE)
>      {
> -        msg(D_TUNTAP_INFO, "CreateFile failed on %s device: %s", print_windows_driver(tt->windows_driver), path);
> +        msg(D_TUNTAP_INFO | M_ERRNO, "CreateFile failed on %s device: %s", print_windows_driver(tt->windows_driver), path);
>          return false;
>      }
>
> --
> 2.23.0.windows.1
>


-- 
-Lev

