Message-ID: <4FC8B79D.2090103@...1114...>
Date: Fri, 01 Jun 2012 14:37:49 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1336849433-23066-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336849433-23066-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig649E7342D025A3B97BB71083"
Subject: Re: [Openvpn-devel] [PATCH] build: insall README* document using
 build system
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
--------------enig649E7342D025A3B97BB71083
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 12/05/12 21:03, Alon Bar-Lev wrote:
> Purpose: make distro packager task simpler, more flexible to provide
> more documentation without changing the packaging script.
>=20
> Remove installation related documents from rpm as package already
> installed when viewed.
>=20
> +Workaround rpm bug[1].
>=20
> [1] http://rpm.org/ticket/836
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  Makefile.am                |    3 +++
>  distro/rpm/openvpn.spec.in |   11 +++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20

Applied to master branch.

commit 46977f29077521802f0cb6ab3cd4c894b9d4f5f6
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat May 12 22:03:53 2012 +0300

    build: insall README* document using build system

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1336849433-23066-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6536
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig649E7342D025A3B97BB71083
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/It50ACgkQDC186MBRfro2kACaA65TpueBzW8l8BKH8p1qyIJV
DfwAoKvhweet3qb3WYG2AkAaU8/tjOeK
=5bS0
-----END PGP SIGNATURE-----

--------------enig649E7342D025A3B97BB71083--

