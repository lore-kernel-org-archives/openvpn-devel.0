Message-ID: <4F7623B2.7040908@...1114...>
Date: Fri, 30 Mar 2012 23:20:50 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1332674822-10508-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332674822-10508-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9150C17B730E1CCA40DC9E6B"
Subject: Re: [Openvpn-devel] [PATCH] cleanup: flags should not be bool
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
--------------enig9150C17B730E1CCA40DC9E6B
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 25/03/12 13:27, Alon Bar-Lev wrote:
> Discussed at [1][2][3].
>=20
> [1] https://bugs.gentoo.org/show_bug.cgi?id=3D297854#c2
> [2] https://297854.bugs.gentoo.org/attachment.cgi?id=3D214304
> [3] http://sourceforge.net/mailarchive/forum.php?thread_name=3D2012032511=
1517.GI1359%40greenie.muc.de&forum_name=3Dopenvpn-devel
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/socket.c |    6 +++---
>  src/openvpn/socket.h |    6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20

Applied to master branches on -testing and -stable trees.

commit 5cfe3d4c1897785b32565dbb59c914fac62b0ed9
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Mar 25 13:27:02 2012 +0200

    cleanup: flags should not be bool

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth



--------------enig9150C17B730E1CCA40DC9E6B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk92I7IACgkQDC186MBRfrpC+ACfQib69GGSkYWx8Bema4l3PLP/
CTcAn1jOhbyMuxnM5TVu7fb7Ng/QibIw
=OnQX
-----END PGP SIGNATURE-----

--------------enig9150C17B730E1CCA40DC9E6B--

