References: <20201225164214.22771-1-gert@...1296...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <1ba16004-9097-4c28-c5ec-9ceeb627d213@...277...>
Date: Fri, 25 Dec 2020 17:04:31 +0000
MIME-Version: 1.0
In-Reply-To: <20201225164214.22771-1-gert@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Clarify --block-ipv6 intent and
 direction.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 25/12/2020 16:42, Gert Doering wrote:
> --block-ipv6 is a fairly special-purpose option, and only blocks packet
> in the client->server option.  This is implied by not ever mentioning
> the other direction in the existing documentation, but not written down.
> 
> Make this explicit, avoid confusion.
> 
> Also, point why this option exist (avoid IPv6 leakage from dual-stacked
> clients around IPv4-only VPN offerings).
> 
> Trac: #1351
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   doc/man-sections/vpn-network-options.rst | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
> index 26682789..711dfcc8 100644
> --- a/doc/man-sections/vpn-network-options.rst
> +++ b/doc/man-sections/vpn-network-options.rst
> @@ -21,7 +21,8 @@ routing.
>     For this option to make sense you actually have to route traffic to the
>     tun interface. The following example config block would send all IPv6
>     traffic to OpenVPN and answer all requests with no route to host,
> -  effectively blocking IPv6.
> +  effectively blocking IPv6 (to avoid IPv6 connections from dual-stacked
> +  clients to leak around IPv4-only VPN services).
>   
>     **Client config**
>       ::
> @@ -38,6 +39,12 @@ routing.
>          --push "redirect-gateway ipv6"
>          --block-ipv6
>   
> +  Note: this option does not influence traffic sent from the server
> +  towards the client (neither on the server nor on the client side).
> +  This is not seen as necessary, as such traffic can be most easily
> +  avoided by not configuring IPv6 on the server tun, or setting up a
> +  server-side firewall rule.
> +
>   --dev device
>     TUN/TAP virtual network device which can be :code:`tunX`, :code:`tapX`,
>     :code:`null` or an arbitrary name string (:code:`X` can be omitted for
> 

LGTM

Acked-by: Richard Bonhomme <tincanteksup@...277...>

