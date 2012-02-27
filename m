Message-ID: <4F4B4495.3040805@...1114...>
Date: Mon, 27 Feb 2012 09:53:41 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-4-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 03/35] cleanup: tun.c: fix incorrect
 option in message (ip-win32)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 21/02/12 02:22, Alon Bar-Lev wrote:
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  tun.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tun.c b/tun.c
> index c92c0d7..81b66fb 100644
> --- a/tun.c
> +++ b/tun.c
> @@ -4492,7 +4492,7 @@ dhcp_masq_addr (const in_addr_t local, const in_addr_t netmask, const int offset
>      msg (M_FATAL, "ERROR: There is a clash between the --ifconfig local address and the internal DHCP server address -- both are set to %s -- please use the --ip-win32 dynamic option to choose a different free address from the --ifconfig subnet for the internal DHCP server", print_in_addr_t (dsa, 0, &gc));
>  
>    if ((local & netmask) != (dsa & netmask))
> -    msg (M_FATAL, "ERROR: --tap-win32 dynamic [offset] : offset is outside of --ifconfig subnet");
> +    msg (M_FATAL, "ERROR: --ip-win32 dynamic [offset] : offset is outside of --ifconfig subnet");
>  
>    gc_free (&gc);
>    return htonl(dsa);

ACK.


Kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9LRJEACgkQDC186MBRfrpufwCaApTJnlpQQJ9iWW3PBh+sJCxo
0TIAn1j4gSvEM7GiwuVhep7q/yELWcuf
=F7DR
-----END PGP SIGNATURE-----

