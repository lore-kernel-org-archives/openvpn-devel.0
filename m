References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-5-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55F54320.5070206@...1227...>
Date: Sun, 13 Sep 2015 11:34:24 +0200
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-5-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 04/10] Create basic infrastructure for
 IPv6 default gateway handling / redirection.
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

Am 11.09.15 um 17:33 schrieb Gert Doering:
> - introduce get_default_gateway_ipv6() and add stub functions with the
>   implementation plan to the 4 major code blocks here (Windows,
>   Linux/Android, *BSD and Solaris, "others")
> 
> - add &rgi6 to print_default_gateway(), and teach it to print v4, v6
>   or both, depending on the calling environment
> 
> - unlike IPv4 (today), get_default_gateway_ipv6() is passed the actual
>   target IPv6 address of the server we're looking for, so we can handle
>   more complicated routing setups ("default to eth0, vpn server to ppp0")
>   correctly
> 
> - consequently, --get-default-gateway has an optional parameter now, the
>   IPv6 address to look up (for debugging)

We should document this.

ACK.


