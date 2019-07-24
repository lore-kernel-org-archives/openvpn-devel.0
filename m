MIME-Version: 1.0
References: <CAKuzo_jTwnNZ_5QtFo8YqUyWWhEJWBCYgnO_xAqEaNkumGPgrw@...278...>
 <1563873663-25785-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1563873663-25785-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Jul 2019 10:43:39 -0400
Message-ID: <CAKuzo_j7SxL_6Aerh9vnBDOgU20VteOCvH=da1yxK73Y1a-xLg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6] openvpnserv: enable interactive
 service to open tun
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Looks good now and works as expected.

On Tue, Jul 23, 2019 at 5:22 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> This patch enables interactive service to open tun device.
> This is mostly needed by Wintun, which could be opened
> only by privileged process.
>
> When interactive service is used, instead of calling
> CreateFile() directly by openvpn process we pass tun device path
> into service process. There we open device, duplicate handle
> and pass it back to openvpn process.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v6:
>   - simplify and strengthen guid check with wcsspn()
>   - fix doxygen comment
>
>  v5:
>   - further strengthen security by passing only device guid from client process
>   to service, validating guid and constructing device path on service side
>
>  v4:
>   - strengthen security by adding basic validation to device path
>   - reorder fields in msg_open_tun_device_result for backward compatibility
>
>  v3:
>   - ensure that device path passed by client is null-terminated
>   - support for multiple openvpn processes
>   - return proper error code when device handle is invalid
>
>  v2:
>   - introduce send_msg_iservice_ex() instead of changing
>   signature of existing send_msg_iservice()
>   - use wchar_t strings in interactive service code
>
>  include/openvpn-msg.h         | 12 +++++++
>  src/openvpn/tun.c             | 83 ++++++++++++++++++++++++++++++++++---------
>  src/openvpn/win32.c           |  9 ++++-
>  src/openvpn/win32.h           | 30 +++++++++++++---
>  src/openvpnserv/interactive.c | 78 ++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 188 insertions(+), 24 deletions(-)

...

> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 623c3ff..1b4a5e2 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -58,7 +58,6 @@ static settings_t settings;
>  static HANDLE rdns_semaphore = NULL;
>  #define RDNS_TIMEOUT 600  /* seconds to wait for the semaphore */
>
> -
>  openvpn_service_t interactive_service = {
>      interactive,
>      TEXT(PACKAGE_NAME "ServiceInteractive"),
> @@ -1198,8 +1197,62 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
>      return err;
>  }
>
> +static DWORD
> +HandleOpenTunDeviceMessage(const open_tun_device_message_t *open_tun, HANDLE ovpn_proc, HANDLE *remote_handle)
> +{
> +    DWORD err = ERROR_SUCCESS;
> +    HANDLE local_handle;
> +    LPWSTR wguid = NULL;
> +    WCHAR device_path[256] = {0};
> +    const WCHAR prefix[] = L"\\\\.\\Global\\";
> +    const WCHAR tap_suffix[] = L".tap";
> +
> +    *remote_handle = INVALID_HANDLE_VALUE;
> +
> +    wguid = utf8to16(open_tun->device_guid);
> +    if (!wguid)
> +    {
> +        err = ERROR_OUTOFMEMORY;
> +        goto out;
> +    }
> +
> +    /* validate device guid */
> +    const size_t guid_len = wcslen(wguid);
> +    if (guid_len != 38 || wcsspn(wguid, L"0123456789ABCDEFabcdef-{}") != guid_len)
> +    {
> +        err = ERROR_MESSAGE_DATA;
> +        MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Invalid device guild (%s)"), wguid);

guild -> guid  (as pointed out by tincanteksup)

> +        goto out;
> +    }
> +

whitespace in line above.

These could be fixed at commit time.

Acked-by: Selva Nair <selva.nair@...277...>

Selva




Selva

