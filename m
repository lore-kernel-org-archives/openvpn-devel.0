Message-ID: <5043B7F1.7000005@...1114...>
Date: Sun, 02 Sep 2012 21:48:01 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345756860-2044-1-git-send-email-arne@...1227...>
In-Reply-To: <1345756860-2044-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17B55BB4E7A4F445E15516AB"
Subject: Re: [Openvpn-devel] [PATCH] Document the inlining of files in
 openvpn and document key-direction
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
--------------enig17B55BB4E7A4F445E15516AB
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 23/08/12 23:21, Arne Schwabe wrote:
> This patch documents the usage of inline files in OpenVPN. Hackish ways o=
f inline files are deliberately left out. For tls-auth and
> secret the key-direction option is right way of specifying the direction =
and not by using two tls-auth/secret lines where the first sets the directi=
on and has a dummy file name and the second sets the inline file data but d=
oes not reset the direction parameter.
>=20
> Also pkcs12 [[INLINE]] base64encoded_data works but is a quirk of how the=
 config parser works
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/openvpn.8 |   39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Applied to master.

commit 0979ec7e9109da95ad56e9365a89701fee11c72c
Author: Arne Schwabe <arne@...1227...>
Date:   Thu Aug 23 23:21:00 2012 +0200

    Document the inlining of files in openvpn and document key-direction

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1345756860-2044-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7006
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig17B55BB4E7A4F445E15516AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBDt/IACgkQDC186MBRfrpPXgCgr/zxo8Y0RYXUblQrqFFnUI9p
Mu4AnRwqTAeOPuAjvj3ahTpE5Egvte2z
=9/RZ
-----END PGP SIGNATURE-----

--------------enig17B55BB4E7A4F445E15516AB--

