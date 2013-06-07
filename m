Message-ID: <51B1E3BF.3090201@...1114...>
Date: Fri, 07 Jun 2013 15:44:31 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <51B1DBEF.1090705@...1435...>
In-Reply-To: <51B1DBEF.1090705@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2COXCUVPTIMVNKQGTQVDD"
Subject: Re: [Openvpn-devel] [PATCH] Do not pass struct tls_session* as void*
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2COXCUVPTIMVNKQGTQVDD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 07/06/13 15:11, Steffan Karger wrote:
> Hi,
>=20
> The attached patch changes the key_state_ssl_init() function to take the
> TLS session as a 'struct tls_session *', instead of a 'void *' that has
> to be cast back later. This patch prepares for a patch from Tamas Tevesz
> that actually uses the TLS session inside key_state_ssl_init().
>=20
> -Steffan

From fcae4846ed642386be8ae985f0b8ff29d3b738ba Mon Sep 17 00:00:00 2001
> From: Steffan Karger <steffan.karger@...1435...>
> Date: Sun, 19 May 2013 10:01:29 +0200
> Subject: [PATCH 1/2] Do not pass struct tls_session* as void* in
>  key_state_ssl_init().
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/ssl_backend.h  |    6 +++++-
>  src/openvpn/ssl_openssl.c  |    2 +-
>  src/openvpn/ssl_polarssl.c |    2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)

ACK!


--=20
kind regards,

David Sommerseth


------enig2COXCUVPTIMVNKQGTQVDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGx478ACgkQDC186MBRfrqX8QCfUnNiu+oGWnYo8cpHSBj2TSFK
P5kAn2t8eBo0OFK/CtBVYMuNP/Et3x1C
=dZwE
-----END PGP SIGNATURE-----

------enig2COXCUVPTIMVNKQGTQVDD--

