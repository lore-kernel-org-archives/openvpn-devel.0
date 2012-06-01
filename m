Message-ID: <4FC8B7B5.90403@...1114...>
Date: Fri, 01 Jun 2012 14:38:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1337598254-32641-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1337598254-32641-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2870B3E0C48AD9685EFDE85"
Subject: Re: [Openvpn-devel] [PATCH] build: check minimum polarssl version
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
--------------enigA2870B3E0C48AD9685EFDE85
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 21/05/12 13:04, Alon Bar-Lev wrote:
> Pre 1.1 is unsupported, API was changed.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>=20

Applied to master branch.


commit 13b38eb0a3e609a5f0f4f12e2578e68ff2ac0a22
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Mon May 21 14:04:14 2012 +0300

    build: check minimum polarssl version
=20=20=20=20
    Pre 1.1 is unsupported, API was changed.
=20=20=20=20
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Reviewed-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1337598254-32641-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6613
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigA2870B3E0C48AD9685EFDE85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/It7UACgkQDC186MBRfrouhwCfbpu0xPVTjX+Mrl7GiAqW61JN
E9MAn1+XLctzCYRz7ELAnpgW5ChQ8VI7
=9Enp
-----END PGP SIGNATURE-----

--------------enigA2870B3E0C48AD9685EFDE85--

