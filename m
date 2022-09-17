Date: Sat, 17 Sep 2022 14:27:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyW9KVe/pSLZDiTl@...1296...>
References: <20220915120349.239-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iy7+V6/+KRj7DhwU"
Content-Disposition: inline
In-Reply-To: <20220915120349.239-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] doc: add "ovpn-dco" to usage and man
 page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--iy7+V6/+KRj7DhwU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 15, 2022 at 03:03:49PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> While on it, remove redundant sentence
> and quotation from --windows-driver man
> description.

As Frank said, we should have a v2 of this, which moves the (default)
to "ovpn-dco" while at it.

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index d7954ebc..0eef3b3d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -749,6 +749,7 @@ static const char usage_message[] =3D
>      "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and=
 net adapter list\n"
>      "                  after TAP adapter is up and routes have been adde=
d.\n"
>      "--windows-driver   : Which tun driver to use?\n"
> +    "                     ovpn-dco\n"
>      "                     tap-windows6 (default)\n"

... in here, that is :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--iy7+V6/+KRj7DhwU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJb0pAAoJEB2Cnv7KVigSsM8L+wXYNAKDLWqFgbWaKI5lzIYL
kaK2YcAyOIG5RZq2D5sWg7lPHboWp1TxJDX4heiULbC31sJXfPLbHIT+C7S+vLvK
4yoJIV4VbfRmyJnmOtA3LGnBeRLFUXRwVX4HP5Sb1x8EXOo5aJxletPuHAk/NeTx
4NzU9oPI0pTy0vfJ0dKQyZ15BulBK/Mp4gCGd81r1uJYMFyh89AsvexE0/1KdFK8
dZLOsHGpKS4TuwzognrBC/qjDZtd6xUjqxZSuzCHgS23LlE+iR8xeip1g1wdiWoz
sSjnTut371+HyphN33UNKDeZk5OlWASUmC2z4GQTXeIqv6GzccR+Ijs1YOg+Yfda
r8rUzstpSTK2qkMFOT6FrrL9YiYvQHqXzaCxIU+zG49mSIKEJCdYswLElK7H/5BF
2cNVhW66yY0OFUXJ1Aqf8nb2UhLZcHhVPqq5e2DOBqA+otzOGYEwI+J0FEZZylza
3iMvLKpAEBtbJakUh6IHOCdmYhoitbHHCFfzyGWVLQ==
=j3GP
-----END PGP SIGNATURE-----

--iy7+V6/+KRj7DhwU--

