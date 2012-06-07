Message-ID: <4FD09ACF.2060604@...1114...>
Date: Thu, 07 Jun 2012 14:13:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-6-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-6-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6E9BD101BC034DF6BD6F941"
Subject: Re: [Openvpn-devel] [PATCH 5/8] Add the name of the context where
 option is not allowed to the error message.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6E9BD101BC034DF6BD6F941
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/06/12 15:03, Arne Schwabe wrote:
> Changes
>=20
> Options error: option 'dhcp-option' cannot be used in this context
>=20
> to
>=20
> P:Options error: option 'dhcp-option' cannot be used in this context ([PU=
SH-OPTIONS])
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/options.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>=20

Applied to master.


commit e656b995b44fab0b8290c6c2a4a73079b3f9813b
Author: Arne Schwabe <arne@...1227...>
Date:   Sat Jun 2 15:03:40 2012 +0200

    Add the name of the context where option is not allowed to the error me=
ssage.

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1338642223-20324-6-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6646
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigD6E9BD101BC034DF6BD6F941
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/QmtIACgkQDC186MBRfrolqwCeMErZb8NvEIKo3wx57pAONzGk
1CMAn1TEnK4wrDfegnd+l0EgV4TyD45V
=1e3D
-----END PGP SIGNATURE-----

--------------enigD6E9BD101BC034DF6BD6F941--

