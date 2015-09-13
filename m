References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-7-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55F54134.1010902@...1227...>
Date: Sun, 13 Sep 2015 11:26:12 +0200
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-7-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 06/10] Implement handling of overlapping
 IPv6 routes with IPv6 remote VPN server address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 11.09.15 um 17:33 schrieb Gert Doering:
> - socket.[ch]: add link_socket_current_remote_ipv6() helper to extract
>    current address of remote VPN server (if IPv6, NULL otherwise), IPv6
>    equivalent to link_socket_current_remote()
> 
> - init.c: pass remote VPN server address to init_route_ipv6_list()
>    (link_socket_current_remote_ipv6())
> 
> - route.h: add route_ipv6_gateway_info to route_ipv6_list, and reorder
>    structures so that this actually compiles.  Add iface/adapter_index
>    to struct route_ipv6 (for non-tun/tap routes).
> 
> - route.[ch]: add "const" to *dest argument to get_default_gateway_ipv6()
> 
> - route.c: add route_ipv6_match_host() helper to check whether an IPv6
>    address is matched by a given "route_ipv6" IPv6 route)
> 
> - route.c: init_route_ipv6_list()
>    - call get_default_gateway_ipv6()
>    - check to-be-installed IPv6 routes against VPN server address (if IPv6)
>    - if an overlap is seen, add a host route for the VPN server address
>      via the just-discovered gateway to the list of IPv6 routes to be
>      installed (rl6->routes_ipv6)
>    - warn if overlap is detected but platform code has not been able to
>      discover IPv6 default gateway
> 
> - route.c: add_route_ipv6() / delete_route_ipv6(): set "device" to
>    "external default gateway interface" (r6->iface) instead of TUN/TAP
>    device (if set), which nicely enables arbitrary gateway/interface
>    combinations for Linux
> 
> - ssl.c: add "IV_RGI6=1" to push-peer-info data to let server know we can
>   handle pushed IPv6 routes that overlap with server IPv6 address
> 
> - tun.c: when adding/removing on-link routes, CLEAR(r6) first to
>   ensure new struct route_ipv6 members are cleared
> 
> Tested on Linux with iproute2 and /bin/route, on eth and tun routes.
> 

I think we may need an (explicit) opt out of the mechanism. Currently
the code that inserts the IPv6 host route will always run.

Arne


