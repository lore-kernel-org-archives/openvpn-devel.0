From: Arne Schwabe <arne@...1227...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-9-git-send-email-gert@...1296...>
Message-ID: <55FA8799.6000205@...1227...>
Date: Thu, 17 Sep 2015 10:27:53 +0100
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-9-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 08/10] get_default_gateway_ipv6(): *BSD
 / MacOS / Solaris PF_ROUTE implementation
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
> As for IPv4, a common implementation for all (supported) BSD families
> and Solaris.  Supporting the latter requires separate implementations
> for IPv4 and IPv6, unfortunately, so it's quite a bit of duplicate
> code.
>
> Further, extend add_route_ipv6() and delete_route_ipv6() to handle
> link-local gateway addresses that require "gateway + interface" in
> scoped notation ("fe80::1%em0").
>
> Tested on FreeBSD 7.4/amd64, 9.3/sparc64, 10.0/amd64, NetBSD 5.1/amd64,
> OpenBSD 4.9/i386, MacOS X 10.5/32 and 10.10/64 and OpenSolaris 10.11/i386.
>
Code looks good and tested on OS X 10.10.5

Arne

