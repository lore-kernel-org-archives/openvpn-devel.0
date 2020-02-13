References: <20200201135026.18074-1-chipitsine@...277...>
 <CAGyAFMX4hOKL1up6q9N6MLCzQYwVpVgnhd8CcgL7RucLPbWwgw@...278...>
 <CAFHpkQFszr8+iAmVy8P1D7b9WHuKATRnBtzU-x0vrrXdLAgNAA@...278...>
 <CAFHpkQEObnPX7duk8n2wmmCW9F_fj1RrPxKQX1HYarkLsedfNw@...278...>
 <CAFHpkQHd87Cjg2TbCSCygN4aonGNSas_02LjyC0+WjWYBkb_VQ@...278...>
 <E1iyYO4-0000Ho-MB@...2508...>
 <CAFHpkQHXELdZ8gi8jrzH64NA57ozBFS+Ey9eDU6eAN-qBZwHJw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3148d3e2-65b6-60ea-88b5-8d8bbf00909e@...1227...>
Date: Thu, 13 Feb 2020 10:07:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHXELdZ8gi8jrzH64NA57ozBFS+Ey9eDU6eAN-qBZwHJw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f82cAWBOUsOVhRJ9JupHtJwR4hEslW9I0"
Subject: Re: [Openvpn-devel] [PATCH v2] travis-ci: add arm64, s390x builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f82cAWBOUsOVhRJ9JupHtJwR4hEslW9I0
Content-Type: multipart/mixed; boundary="U4EKIS3WM7BYaNd8i1lbMCM0t0FsqncTo"

--U4EKIS3WM7BYaNd8i1lbMCM0t0FsqncTo
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 03.02.20 um 10:59 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD:
>=20
>=20
> =D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 14:51, Stef=
fan Karger
> <steffan.karger@...2507... <mailto:steffan.karger@...2507...>>:
>=20
>     On 03-02-2020 09:04, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD wrote:
>     > also, ARM64 builds are flaky. maybe we should add them as
>     allow_failures.
>=20
>     What is flaky about the ARM64 builds? Is it our build? Is it the trav=
is
>     infra?
>=20
>=20
> in travis-ci terms "our" failure means "build failed", travis-ci infra
> means "build errored"
>=20
> they run arm64 on linaro cloud, it fails (sometimes) on infra level (I
> guess cloud is overloaded or like that). I did not seen yet tests failure
> =C2=A0

Hm. If we ignore the failure then the test is almost worthless since I
think most people only look at the failures if there is an error. If we
build and ignore it, we can also ignore it completely.

Just my 2c.

Arne


--U4EKIS3WM7BYaNd8i1lbMCM0t0FsqncTo--

--f82cAWBOUsOVhRJ9JupHtJwR4hEslW9I0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5FEbkACgkQFRhsZwKx
RFQZXA/+MoBPfc3ZwWRm1rAvzpvdR7XWXw9+olcdq1l30OFzjNt23aspX9MPxDNv
uYPS/CWKh2e3YBLBMVOtwwK/yrEp67NdZkd+Sfvj/in5Z9PBS2Tck9bXIaF5pi5X
Y6wy6lbkMyCvzNaTn36Ij/XiGKsD/tEDIEF4K2kxCCdzuIYYEmrG0DsVj5wjT9Tp
DcziUafQC8jlSWh16/ktpaViMmAtLppX7pP8rHja0S8k3c8Vl/FG7K/ZqOI9RPB+
tk0R74INBxEndSagVKzi6H9msgysQZ6QgvVJrDYlZY93U9TLYhUmJhucblkZ9Gad
IIVeAasVsFh/HW9+lsR0JFLKR4jIRWDuGGz+LVI5o0knPVx7mRTIniYrCW2AmNcl
sPyyPeRKW/hcGP43RLQxN/KOXEX5pEysw5L0m0Y8ToCfVt+Bnz2dfInld7T5sv8Y
0NeAUX7r+Ej/Tun3iweU5klId/al8Mp7c+uOm6doRtGHxEU33UOCNyEfsbNJR88C
HaH63iOKpYgLlvNQhsaTddL9qMxwO4ClcJQrgec3427TTDuKiB6ZIctpatKck0FA
Pvk8+GhIsCVh7K9j4Ysbx6ucL4V/4azkZ9/2vCHetjX1WD3023Dy6kbPgdg1CCA5
jpEdENLAnrlgeNXOr05Av25oCP0NSFZjyL8oAK/y6S6p8HQfUoA=
=LU7r
-----END PGP SIGNATURE-----

--f82cAWBOUsOVhRJ9JupHtJwR4hEslW9I0--

