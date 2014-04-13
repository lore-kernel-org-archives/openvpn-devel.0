Message-ID: <534A72C8.1020203@...1227...>
Date: Sun, 13 Apr 2014 13:19:36 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20140413111500.GM16637@...1296...>
In-Reply-To: <20140413111500.GM16637@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kEDHTAlNNiFn76B4Doh6D7fSap3Enf5Qb"
Subject: Re: [Openvpn-devel] github pull 15 / Fix typo in build script to
 use LDFLAGS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kEDHTAlNNiFn76B4Doh6D7fSap3Enf5Qb
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 13.04.14 13:15, schrieb Gert Doering:
> From 553ca06af9e9c2daa8acfa36988aac0b8ed5dab4 Mon Sep 17 00:00:00 2001
> From: kangsterizer <kang@...1896...>
> Date: Thu, 10 Apr 2014 11:23:24 -0700
> Subject: [PATCH] Fix typo in build script to use LDFLAGS
>
> ---
>  sample/sample-plugins/defer/build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sample/sample-plugins/defer/build b/sample/sample-plugins/de=
fer/build
> index 0612c08..ba41a39 100755
> --- a/sample/sample-plugins/defer/build
> +++ b/sample/sample-plugins/defer/build
> @@ -12,4 +12,4 @@ CC=3D"${CC:-gcc}"
>  CFLAGS=3D"${CFLAGS:--O2 -Wall -g}"
>=20=20
>  $CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
> -$CC $CFLAGS -fPIC -shared ${LDFLAS} -Wl,-soname,$1.so -o $1.so $1.o -lc
> +$CC $CFLAGS -fPIC -shared ${LDFLAGS} -Wl,-soname,$1.so -o $1.so $1.o -lc

ACK it is very simple typo.

Arne


--kEDHTAlNNiFn76B4Doh6D7fSap3Enf5Qb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNKcs4ACgkQe8+cMNS4zRdXpACghTam0WvV70sF4bLC564FVALS
FRAAoLhlBrmYxvS+qSUdDc5HZ2eXJ95u
=8PTo
-----END PGP SIGNATURE-----

--kEDHTAlNNiFn76B4Doh6D7fSap3Enf5Qb--

