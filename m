Message-ID: <4F798D80.8000201@...1114...>
Date: Mon, 02 Apr 2012 13:29:04 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333012602-5419-4-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig867A708A50B960DA80E14CEC"
Subject: Re: [Openvpn-devel] [PATCH 3/4] cleanup: avoid using ~0 - netmask
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig867A708A50B960DA80E14CEC
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 29/03/12 11:16, Alon Bar-Lev wrote:
> Use IPV4_NETMASK_HOST constant.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/basic.h  |    2 ++
>  src/openvpn/mroute.c |    2 +-
>  src/openvpn/pf.c     |    2 +-
>  src/openvpn/route.c  |   12 ++++++------
>  src/openvpn/route.h  |    2 +-
>  src/openvpn/tun.c    |    2 +-
>  6 files changed, 12 insertions(+), 10 deletions(-)
>=20

Applied to master branches on -testing and -stable trees

commit 32e576d270834636e8e8667fcb7e91cdac03b4a4
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Thu Mar 29 11:16:41 2012 +0200

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth



--------------enig867A708A50B960DA80E14CEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95jYAACgkQDC186MBRfrr3/gCfWN1mmCK1aK44Cq8TwpHuoLO1
nQgAoJRUsygEtc1pfgc5hv4CHUW8lemA
=GG1W
-----END PGP SIGNATURE-----

--------------enig867A708A50B960DA80E14CEC--

