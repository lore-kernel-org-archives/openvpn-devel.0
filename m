References: <777939F9-A753-4A66-B40E-1346AFD588DE@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c296d03a-fdac-a8a2-2050-57748cb95cb1@...1227...>
Date: Wed, 10 Oct 2018 14:59:36 +0200
MIME-Version: 1.0
In-Reply-To: <777939F9-A753-4A66-B40E-1346AFD588DE@...1918...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Adds support for setting the default
 IPv6 gateway for routes using the route-ipv6-gateway option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: James Bekkema <james@...1918...>, openvpn-devel@lists.sourceforge.net

Am 23.07.18 um 05:45 schrieb James Bekkema:
> This patch adds support for setting the default IPv6 gateway for routes using the "route-ipv6-gateway” option.
> 
> Currently if users try to use the "redirect-gateway ipv6” option, or a IPv6 route without a gateway, without using "ifconfig-ipv6" they’ll receive the message "OpenVPN ROUTE6: OpenVPN needs a gateway parameter for a --route-ipv6 option and no default was specified by either --route-ipv6-gateway or --ifconfig-ipv6 options”.
> 
> However, the "route-ipv6-gateway” option doesn’t actually exist, and it is required for bridged/TAP setups relying on IPv6 auto-configuration for IP assignment. This patch adds the "route-ipv6-gateway” option. The gateway specified must be an IPv6 address, FQDNs are not supported (to match the behaviour of the other IPv6 related options).
> 
> Currently in production use in Viscosity for macOS and Windows, no reported issues.
> 
> Signed-off-by: James Bekkema <james@...1918...>
> 

Looks good and looks like Gert wanted to implment to it and never got to
it. But I will let Gert have the last word on it.

Acked-By: Arne Schwabe <arne@...1227...>


Arne

