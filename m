Message-ID: <4F798D75.2010100@...1114...>
Date: Mon, 02 Apr 2012 13:28:53 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333012602-5419-2-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD8D6038C6F62820A7532166"
Subject: Re: [Openvpn-devel] [PATCH 1/4] cleanup: avoid using ~0 - generic
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
--------------enigBD8D6038C6F62820A7532166
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 29/03/12 11:16, Alon Bar-Lev wrote:
> Use limits.h for maximum value.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  config-msvc.h         |    1 +
>  configure.ac          |    2 +-
>  src/openvpn/route.c   |    2 +-
>  src/openvpn/syshead.h |    4 ++++
>  4 files changed, 7 insertions(+), 2 deletions(-)
>=20

Applied to master branches on -testing and -stable trees

commit 112731fcc39535ba425ac717cb0d5bd1a2a11c61
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Thu Mar 29 11:16:39 2012 +0200

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth



--------------enigBD8D6038C6F62820A7532166
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95jXUACgkQDC186MBRfrr2pwCgqLbDuC6fNpP2T4LEM2rQMMh/
2UoAoIURCL/US/mY/UbQXaHH4xML+Cae
=6pFE
-----END PGP SIGNATURE-----

--------------enigBD8D6038C6F62820A7532166--

