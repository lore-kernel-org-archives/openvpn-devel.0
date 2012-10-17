Message-ID: <507E85AE.3070102@...1114...>
Date: Wed, 17 Oct 2012 12:17:18 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1350466765-23301-1-git-send-email-dejong@...1435...>
In-Reply-To: <1350466765-23301-1-git-send-email-dejong@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C56A9E1C6D314FA53FE79DF"
Subject: Re: [Openvpn-devel] [PATCH] Fixed a bug where PolarSSL gave an
 error when using an inline file tag.
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
--------------enig6C56A9E1C6D314FA53FE79DF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/10/12 11:39, Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
>  src/openvpn/ssl_polarssl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

ACK.  Applied to master and beta/2.3.

commit 2ebbe4c0b4f0f0b15b4c32180e906a545446c376 (master)
commit a4b99628d19d6130a4f53e0ed84d9d0b2fd28dc0 (beta/2.3)
Author: Adriaan de Jong <dejong@...1435...>
Date:   Wed Oct 17 11:39:25 2012 +0200

    Fixed a bug where PolarSSL gave an error when using an inline file tag.
=20=20=20=20
    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1350466765-23301-1-git-send-email-dejong@...1435...
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig6C56A9E1C6D314FA53FE79DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlB+ha4ACgkQDC186MBRfrpxPQCfVIUZTmZBiArT5Y0ohCAN9Y3z
ra8An0nbrwbznwE9aMaAD1+a2ZSTcRxo
=7fcU
-----END PGP SIGNATURE-----

--------------enig6C56A9E1C6D314FA53FE79DF--

