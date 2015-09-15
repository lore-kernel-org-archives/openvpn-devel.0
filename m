References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-8-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55F7FC94.6060708@...1227...>
Date: Tue, 15 Sep 2015 12:10:12 +0100
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-8-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 07/10] Implement '--redirect-gateway
	ipv6'
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



Am 11.09.15 um 16:33 schrieb Gert Doering:
> Add "ipv6" and "!ipv4" sub-options to "--redirect-gateway" option.
>
> This is done in the same way as in the OpenVPN 3 code base, so
> "--redirect-gateway ipv6" will redirect both IPv4 and IPv6 - if you
> want v6-only, use "--redirect-gateway ipv6 !ipv4".
>
> The actual implementation is much simpler than for IPv4 - we just
> add a few extra routes to the route_ipv6_option_list and leave it to
> init_route_ipv6_list() to figure out whether there is an overlap with
> IPv6 transport, and if yes, insert a host route to the VPN server
> via the current IPv6 default gateway.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/openvpn.8         | 11 +++++++++++
>  src/openvpn/init.c    | 15 +++++++++++++++
>  src/openvpn/options.c |  7 +++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 0692a80..98378aa 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -1240,6 +1240,17 @@ on non-Windows clients).
>  Block access to local LAN when the tunnel is active, except for
>  the LAN gateway itself.  This is accomplished by routing the local
>  LAN (except for the LAN gateway address) into the tunnel.
> +
> +.B ipv6 --
> +Redirect IPv6 routing into the tunnel.  This works similar to the
> +.B def1
> +flag, that is, more specific IPv6 routes are added (2000::/4, 3000::/4),
> +covering the whole IPv6 unicast space.
> +
> +.B !ipv4 --
> +Do not redirect IPv4 traffic - typically used in the flag pair
> +.B "ipv6 !ipv4"
> +to redirect IPv6-only.
>  .\"*********************************************************
>  .TP
>  .B \-\-link\-mtu n
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 0416e35..c47f4a8 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1195,6 +1195,21 @@ do_init_route_ipv6_list (const struct options *options,
>    if (options->route_default_metric)
>      metric = options->route_default_metric;
>  
> +  /* redirect (IPv6) gateway to VPN?  if yes, add a few more specifics
> +   */
> +  if ( options->routes_ipv6->flags & RG_REROUTE_GW )
> +    {
> +      char *opt_list[] = { "::/3", "2000::/4", "3000::/4", "fc00::/7", NULL };
> +      int i;
> +
>
I cannot judge how good or bad this default list is. I usually have don
the the ::/1 and 8000::/1 stuff.

Otherwise the patch is fine, so ACK.

Arne

