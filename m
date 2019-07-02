MIME-Version: 1.0
References: <CAGyAFMUgS+WaDf5Xx8S-jX3MbAu4QT7_Ln86JDtmZEaV2PPLcA@...278...>
 <1561637226-18464-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1561637226-18464-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 2 Jul 2019 08:22:53 -0400
Message-ID: <CAKuzo_jqHYt-xbwkTG59DEbEpNKT7GPtWE8T6t-Jiwv0CiyhOQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] openvpnserv: enable interactive
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

On Thu, Jun 27, 2019 at 8:08 AM Lev Stipakov <lstipakov@...277...> wrote:
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
>  v3:
>   - ensure that device path passed by client is null-terminated
>   - support for multiple openvpn processes
>   - return proper error code when device handle is invalid

This works but there are two general concerns:

(i) The new message is named message_open_tun, but it allows opening
any file using the service. This is not secure. We need to restrict it
to open tun/tap device nodes only.

(ii) Should we allow all users to open tap6 adapters irrespective of
any other access restrictions that may be present? I'm conflicted
about this as, on closer look, access control in tap-windows6 appears
broken.

> @@ -117,4 +119,14 @@ typedef struct {
>      interface_t iface;
>  } enable_dhcp_message_t;
> +typedef struct {
> +    message_header_t header;
> +    char device_path[256];
> +} open_tun_device_message_t;
> +
> +typedef struct {
> +    message_header_t header;
> +    HANDLE handle;
> +    int error_number;
> +} open_tun_device_result_message_t;

Defining this struct with error_number followed by handle would be
better (makes its head match in memory with ack_message_t). That makes
it possible to read a normal ack into it and resolve the error number.
Can happen if openvpn.exe is upgraded but service stays at an old
version -- such a service will respond with ack and
error_number=ERROR_MESSAGE_TYPE.

Selva

