Message-ID: <4F55E44D.5020207@...515...>
Date: Tue, 06 Mar 2012 12:17:49 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-9-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-9-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 08/52] cleanup: tun.c: fix incorrect
 option in message (ip-win32)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  tun.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/tun.c b/tun.c
> index c92c0d7..81b66fb 100644
> --- a/tun.c
> +++ b/tun.c
> @@ -4492,7 +4492,7 @@ dhcp_masq_addr (const in_addr_t local, const in_add=
r_t netmask, const int offset
>      msg (M_FATAL, "ERROR: There is a clash between the --ifconfig local =
address and the internal DHCP server address -- both are set to %s -- pleas=
e use the --ip-win32 dynamic option to choose a different free address from=
 the --ifconfig subnet for the internal DHCP server", print_in_addr_t (dsa,=
 0, &gc));
>=20=20
>    if ((local & netmask) !=3D (dsa & netmask))
> -    msg (M_FATAL, "ERROR: --tap-win32 dynamic [offset] : offset is outsi=
de of --ifconfig subnet");
> +    msg (M_FATAL, "ERROR: --ip-win32 dynamic [offset] : offset is outsid=
e of --ifconfig subnet");
>=20=20
>    gc_free (&gc);
>    return htonl(dsa);

ACK. There is indeed no --tap-win32 option.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


