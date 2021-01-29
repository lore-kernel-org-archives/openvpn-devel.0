References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-11-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <689c6f22-c0e6-e901-0e71-48e93680799d@...2080...>
Date: Sat, 30 Jan 2021 00:16:55 +0100
MIME-Version: 1.0
In-Reply-To: <20210125125628.30364-11-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rYKifUiFrOlOYa9h64oBGsVrihTOiqiby"
Subject: Re: [Openvpn-devel] [PATCH v2 10/11] Implement --client-crresponse
 script options and plugin interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rYKifUiFrOlOYa9h64oBGsVrihTOiqiby
Content-Type: multipart/mixed; boundary="ADbYM7EpumMJ2MsSr6XgaX1EybpKPNHKX";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <689c6f22-c0e6-e901-0e71-48e93680799d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 10/11] Implement --client-crresponse
 script options and plugin interface
References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-11-arne@...1227...>
In-Reply-To: <20210125125628.30364-11-arne@...1227...>

--ADbYM7EpumMJ2MsSr6XgaX1EybpKPNHKX
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 25/01/2021 13:56, Arne Schwabe wrote:
> This is allows scripts and pluginsto parse/react to a
> CR_RESPONSE message
>=20
> Patch V2: doc fixes, do not put script under ENABLE_PLUGIN
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   doc/man-sections/script-options.rst | 28 ++++++++++++-
>   include/openvpn-plugin.h.in         |  7 +++-
>   src/openvpn/init.c                  |  1 +
>   src/openvpn/options.c               | 15 +++++++
>   src/openvpn/options.h               |  1 +
>   src/openvpn/push.c                  |  4 ++
>   src/openvpn/ssl_common.h            |  1 +
>   src/openvpn/ssl_verify.c            | 65 ++++++++++++++++++++++++++++-
>   src/openvpn/ssl_verify.h            | 23 ++++++++++
>   9 files changed, 141 insertions(+), 4 deletions(-)

Tested using the totpauth.py script in patch 11/11.  Worked fine (after=20
some tweaking, see review response to patch 9 and 11 for details).  Code=20
looks reasonable, so this is good enough for me.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--ADbYM7EpumMJ2MsSr6XgaX1EybpKPNHKX--

--rYKifUiFrOlOYa9h64oBGsVrihTOiqiby
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmAUl2cACgkQhs+UTJZx
/fJBzw//SmnlVEgkwxVfVp9ge25hj2f2LkvxsYg7SluZXFJcfs9vSIRGL8X6qrGk
1Ec0DDm7CZqKNHcoXxlXQ6sRBzmYS0V3dqzLs1hNtE9aRgrqeuxnZgdAzXFl4k2G
YCovb59hYkZ8SZTY/Cj99kNWBqh2SvPNgqROdTtvqQ2Qlw+gSX2J7zBkJMmTcX+8
CLTAKQNPHW/n48zkskzYR2vprcujgx6BC3hctXA1M0EFsn47UZUS/slWQlev17/h
oJanb3+06qYKxGcskSVjUgEymawPexPeew9+iPHGHlftgZes1yaVI2EpCuuCEwW4
TRfXXnJYgwRy8ZsmvxW/g/t+bnLW2R3Y4H8ucimWt4kVjeLpegOPelG82e9JmZC5
itIg8Hp229d7pxHHN/N6mXSUeMkzKYG6oC5rz5meR+lxmTO+PATnZw3kpxgyWElR
BbvJhWUtKhtWIi3yQkhaM0QxPpRomPfoXmDrIffsUofU9yYSrTAz9KJSySaFGTm7
ljnmoJpa+AGtbFroD3R3Vx1qIfL+IPMMRWo1DJv6oLMmAMGAMSlxOaqsLt4qoiJa
u1FE4kR1VfYNoqGTNvzxpEBaLtN0d8lKSX0mQG9Wf152UiCVE41tIeUM1Z8jLb1d
hsVd/9+VvT58uU/k6s/Sv71tu/6+3dw1GqMqWm9u4/nN8YBJqZg=
=HUOw
-----END PGP SIGNATURE-----

--rYKifUiFrOlOYa9h64oBGsVrihTOiqiby--

