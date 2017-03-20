References: <20170319193451.24289-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <38015ea2-0312-b6de-cafa-ba1125c964fc@...1227...>
Date: Mon, 20 Mar 2017 03:18:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170319193451.24289-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Document --proto udp6, tcp6, etc.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net



Am 19.03.17 um 20:34 schrieb Gert Doering:
> Trac #793
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/openvpn.8 | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 1086960..29577e1 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -419,6 +419,16 @@ can be
>  or
>  .B tcp-server.
>  
> +These will only try IPv4 to connect to the remote host.  To use IPv6,
> +add "6" to the protocol, as in
> +.B udp6,
> +.B tcp6-client,
> +or
> +.B tcp6-server.
> +OpenVPN 2.3 can not auto-determine whether to use IPv4 or IPv6 (or
typo:  cannot
> +automatically try whatever is available) - full dual-stack functionality
> +is available starting with OpenVPN 2.4.0
> +
>  The default protocol is
>  .B udp
>  when
Otherwise ACK.

Arne

