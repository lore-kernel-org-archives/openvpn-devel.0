Message-ID: <55415C5F.5060506@...1856...>
Date: Thu, 30 Apr 2015 00:34:07 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1430216419-11943-1-git-send-email-gert@...1296...>
In-Reply-To: <1430216419-11943-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] explain effect of --topology subnet on
 --ifconfig
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


On 28-04-15 12:20, Gert Doering wrote:
> The fact that the second parameter of --ifconfig is no longer
> a "remote address" but a "netmask" when using --dev tun and
> --topology subnet was not documented clearly enough.
>
> Trac #370
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   doc/openvpn.8 | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 8b3e1a2..587b769 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -798,6 +798,12 @@ driver supports an
>   command which sets a subnet instead of a remote endpoint IP address.
>
>   This option exists in OpenVPN 2.1 or higher.
> +
> +Note: Using
> +.B \-\-topology subnet
> +changes the interpretation of the arguments of
> +.B \-\-ifconfig
> +to mean "address netmask", no longer "local remote".
>   .\"*********************************************************
>   .TP
>   .B \-\-tun-ipv6
> @@ -861,16 +867,21 @@ May be used in order to execute OpenVPN in unprivileged environment.
>   Set TUN/TAP adapter parameters.
>   .B l
>   is the IP address of the local VPN endpoint.
> -For TUN devices,
> +For TUN devices in point-to-point mode,
>   .B rn
>   is the IP address of the remote VPN endpoint.
> -For TAP devices,
> +For TAP devices, or TUN devices used with
> +.B \-\-topology subnet,
>   .B rn
> -is the subnet mask of the virtual ethernet segment
> +is the subnet mask of the virtual network segment
>   which is being created or connected to.
>
>   For TUN devices, which facilitate virtual
> -point-to-point IP connections,
> +point-to-point IP connections (when used in
> +.B \-\-topology net30
> +or
> +.B p2p
> +mode),
>   the proper usage of
>   .B \-\-ifconfig
>   is to use two private IP addresses
> @@ -885,7 +896,9 @@ you will be pinging across the VPN.
>
>   For TAP devices, which provide
>   the ability to create virtual
> -ethernet segments,
> +ethernet segments, or TUN devices in
> +.B --topology subnet
> +mode (which create virtual "multipoint networks"),
>   .B \-\-ifconfig
>   is used to set an IP address and
>   subnet mask just as a physical
>

ACK

-Steffan

