References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-8-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <587452aa-a5fe-4ce4-2cff-50ee9a471d5c@...1227...>
Date: Fri, 10 May 2019 14:25:12 +0200
MIME-Version: 1.0
In-Reply-To: <20181219050118.6568-8-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="au4MjBqu7pkvzpT48JhDU9DpyaZxlqKFZ"
Subject: Re: [Openvpn-devel] [PATCH v3 7/7] travis.yml: add test for
 iproute2 net implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--au4MjBqu7pkvzpT48JhDU9DpyaZxlqKFZ
Content-Type: multipart/mixed; boundary="QttC2yeRqaha4TjoiMqJaQZZ5UjGqIeBY";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <587452aa-a5fe-4ce4-2cff-50ee9a471d5c@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 7/7] travis.yml: add test for iproute2
 net implementation
References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-8-a@...2181...>
In-Reply-To: <20181219050118.6568-8-a@...2181...>

--QttC2yeRqaha4TjoiMqJaQZZ5UjGqIeBY
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.12.18 um 06:01 schrieb Antonio Quartulli:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  .travis.yml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index ede2aaa6..b8031fd8 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -33,6 +33,9 @@ matrix:
>      - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.0h"
>        os: linux
>        compiler: gcc
> +    - env: SSLLIB=3D"openssl" EXTRA_CONFIG=3D"--enable-iproute2"
> +      os: linux
> +      compiler: gcc
>      - env: SSLLIB=3D"openssl" CFLAGS=3D"-fsanitize=3Daddress"
>        os: linux
>        compiler: clang
>=20
Acked-By: Arne Schwabe <arne@...1227...>


--QttC2yeRqaha4TjoiMqJaQZZ5UjGqIeBY--

--au4MjBqu7pkvzpT48JhDU9DpyaZxlqKFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzVbagACgkQFRhsZwKx
RFS2Pg//ZXhqnf5RKRM4q+hI96XuqIzZmznlwj4Y+Zy9qOIDoaGxnj0qXVZcR0lz
6R2E3AEKhYhRSAl4fCD3eUDI6tBIImYMej3LeGxp8WayZtZ47tV9JGN6PqtGG/pK
H+tH0jlQmyutPBRoSePzWRT0Kg1UkWacEqL9uXHjAAzXJWRrUolOoNYPyq/MppMg
kUY2WkW6nARGiqRPrbkrEqj7zR/DblHgQt7644GaIzYJLdHLUDI39pW3C9dVDYdv
y9uF3qliTa0wAhzfMHiifJO9RT44Cf4rDjWHdQ0Ji3YaOX6zvkQ++Y4s2tIBNH4J
ISmjf+Bv0TF9g7LdywWAhrJip4gQRTttuOdtcEg5lRXNd16XpOo2JSPuASXLYVaO
kDBNpXNuBEogYsVzXKRQKkUDsfhOF5MAhovi0GmLI2bkN20oZeeQjSuElLr8Fo8l
KMK3YwvmBYBSBILotDmxdxcI5xVHODTe+pXXFohdXbg/HAK+uQnF9WzIImOJ3VwO
0e0Rxf5UCCek6+8GP6FZjVDmRsePP53PiQGEBPHTCd/eRz54LFiCXFA0ilNKGam4
DjLIb9t7LlJS2KXroXF9Om0kVGWzZ7zK7SCaG/56hJn3wYH8NmVCLSWInFxLfavt
TH/6+r4zO0mpEUnwgYnlf2UFems+JiXPs22yrm5IZ839yDJwjHs=
=8eXg
-----END PGP SIGNATURE-----

--au4MjBqu7pkvzpT48JhDU9DpyaZxlqKFZ--

