Message-ID: <4FD86BAD.1030900@...1114...>
Date: Wed, 13 Jun 2012 12:30:05 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1336199983-9916-2-git-send-email-alon.barlev@...277...>
	<1336204877-3564-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336204877-3564-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F727315375921549A27A88A"
Subject: Re: [Openvpn-devel] [PATCH] build: add --with-special-build to
 provide special build string
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
--------------enig7F727315375921549A27A88A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 05/05/12 10:01, Alon Bar-Lev wrote:
> Special build string is printed when --version is specified.
>=20
> Empty =3D no special build.
>=20
> This is handy when building a snapshot or if not git repository.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac          |    6 ++++++
>  src/openvpn/options.c |    3 +++
>  2 files changed, 9 insertions(+), 0 deletions(-)
>=20

ACK.  Applied to master.

commit 10b4b65e0318ce305e05cdec4b44b8f6bcd3915f
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat May 5 11:01:17 2012 +0300

    build: add --with-special-build to provide special build string
=20=20=20=20
    Special build string is printed when --version is specified.
=20=20=20=20
    Empty =3D no special build.
=20=20=20=20
    This is handy when building a snapshot or if not git repository.
=20=20=20=20
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1336204877-3564-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6435
    Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth


--------------enig7F727315375921549A27A88A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Ya60ACgkQDC186MBRfrpsZACbB8ULYosH86u+CkloxllaSW28
82QAoKZU3kNYnpyLszPnXHUNDG+MFP5D
=9z2U
-----END PGP SIGNATURE-----

--------------enig7F727315375921549A27A88A--

