Message-ID: <50AE0394.3080504@...1114...>
Date: Thu, 22 Nov 2012 11:51:00 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1442E0668D91B25B7BEF0571"
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
Reply-To: openvpn-devel@lists.sourceforge.net
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
--------------enig1442E0668D91B25B7BEF0571
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 14/11/12 10:03, Adriaan de Jong wrote:
> [PATCH] Fix --show-pkcs11-ids (Bug #239)
>=20
> Broken by 75b49e406430299b187964744f82e50a9035a0d3.
>=20
> Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
> ---
>  src/openvpn/pkcs11.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

ACK.  Applied to master and beta/2.3 branches.


commit 5fd3e56430678bee3e6e3a3cf8dfd6db7e105676 (master)
commit fd02ae905df21e1119fb63521e7ff773d6f812dc (beta/2.3)
Author: Adriaan de Jong <dejong@...1435...>
Date:   Wed Nov 14 10:03:12 2012 +0100

    Fix --show-pkcs11-ids (Bug #239)
=20=20=20=20=20=20=20=20
    Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Trac-ticket: 239
    Message-Id: 1CED409804E2164C8104F9E623B08B901323A48384@...1436...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7129
    Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


--------------enig1442E0668D91B25B7BEF0571
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCuA5gACgkQDC186MBRfrpUAgCePrqxYLh2EnO3l8FuUo8vR2XG
0iIAniwQzrDmDuB+l8s2QFt4AjX0ZH3P
=LVum
-----END PGP SIGNATURE-----

--------------enig1442E0668D91B25B7BEF0571--

