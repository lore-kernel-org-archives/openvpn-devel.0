Message-ID: <5043B7F6.9070009@...1114...>
Date: Sun, 02 Sep 2012 21:48:06 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345197136-24708-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345197136-24708-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5A8897C9FA8F93216E013D92"
Subject: Re: [Openvpn-devel] [PATCH] remove stale _openssl_get_subject()
	prototype
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
--------------enig5A8897C9FA8F93216E013D92
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/08/12 11:52, Heiko Hund wrote:
> The _openssl_get_subject() function was removed in commit
> 00b973f8af85c3ea8fa3cef80eec55e8dc139b27. The functionality
> moved to x509_get_subject().
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/ssl_verify_openssl.h |    2 --
>  1 file changed, 2 deletions(-)

Applied to master.

commit c0cd314e9221eae827658ef8311dbd618bb138f8
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Fri Aug 17 11:52:16 2012 +0200

    remove stale _openssl_get_subject() prototype

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1345197136-24708-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6987
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig5A8897C9FA8F93216E013D92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBDt/YACgkQDC186MBRfroQMgCeJ9V9ZCXHNahWl32//Bn40csN
6ukAnidmbNzmTarFivLgjOA33DQrnASX
=h0ki
-----END PGP SIGNATURE-----

--------------enig5A8897C9FA8F93216E013D92--

