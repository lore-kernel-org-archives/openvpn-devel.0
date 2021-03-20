References: <20210319153129.8734-1-arne@...1227...>
 <20210319153129.8734-2-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <08c1d3c8-d5d1-f329-57a6-a2d07ec39430@...2080...>
Date: Sat, 20 Mar 2021 14:20:14 +0100
MIME-Version: 1.0
In-Reply-To: <20210319153129.8734-2-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7dh60zORlgutPnbpZfdJAv2xdJrO9keZy"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement '--compress migrate' to
 migrate to non-compression setup
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
--7dh60zORlgutPnbpZfdJAv2xdJrO9keZy
Content-Type: multipart/mixed; boundary="OqYOrctaptZkf46szcufzEvxO6OZHLeSO";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <08c1d3c8-d5d1-f329-57a6-a2d07ec39430@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement '--compress migrate' to
 migrate to non-compression setup
References: <20210319153129.8734-1-arne@...1227...>
 <20210319153129.8734-2-arne@...1227...>
In-Reply-To: <20210319153129.8734-2-arne@...1227...>

--OqYOrctaptZkf46szcufzEvxO6OZHLeSO
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 19/03/2021 16:31, Arne Schwabe wrote:
> This option allow migration to a non compression server config while
> still retraining compatibility with client that have a compression
> setting in their config.
>=20
> For existing setups that used to have comp-lzo no or another
> compression setting in their configs it is a difficult to migrate to
> a setup without compression without replacing all client configs at
> once especially if OpenVPN 2.3 or earlier clients are in the mix that
> do not support pushing stub-v2. Even with OpenVPN 2.4 and later clients
> that support pushing this is not a satisfying solution as the clients
> log occ mismatches and the "push stub-v2" needs to be in the server
> config "forever".
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   doc/man-sections/protocol-options.rst | 12 +++-
>   src/openvpn/comp.h                    |  1 +
>   src/openvpn/multi.c                   | 41 +++++++++++++
>   src/openvpn/options.c                 |  6 ++
>   src/openvpn/ssl.c                     | 34 ++++++++++-
>   src/openvpn/ssl_common.h              |  1 +
>   src/openvpn/ssl_util.c                | 43 ++++++++++++++
>   src/openvpn/ssl_util.h                | 15 +++++
>   tests/unit_tests/openvpn/Makefile.am  | 14 ++++-
>   tests/unit_tests/openvpn/test_misc.c  | 83 +++++++++++++++++++++++++++
>   10 files changed, 245 insertions(+), 5 deletions(-)
>   create mode 100644 tests/unit_tests/openvpn/test_misc.c
>=20

This fails compiling:

../../../src/openvpn/ssl.c: In function =E2=80=98key_method_2_write=E2=80=
=99:
../../../src/openvpn/ssl.c:2280:13: error: =E2=80=98multi=E2=80=99 undeclar=
ed (first use in this function)
          if (multi->remote_usescomp && session->opt->mode =3D=3D MODE_SERV=
ER
              ^~~~~
../../../src/openvpn/ssl.c:2280:13: note: each undeclared identifier is rep=
orted only once for each function it appears in
make[3]: *** [Makefile:742: ssl.o] Error 1



--=20
kind regards,

David Sommerseth
OpenVPN Inc



--OqYOrctaptZkf46szcufzEvxO6OZHLeSO--

--7dh60zORlgutPnbpZfdJAv2xdJrO9keZy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBV9o4ACgkQhs+UTJZx
/fL1fxAAtUsljoJTCRID0XOtm8ElwDGkeFWsJ/94mremunEEDQgg+qPJlSKi2Gg5
VfPmGYojMIEsA6yegE759h8inpzd2BBh7dtgTS2vTBjERP2CFxrXaDdEV+KkI920
g9A2cRt4H8dI5xBPXcZsrqHP3T942rXKf0JxYWaoXoKJxEWIl491PsmdqICb4Qje
L/nEBe2ReQUWLI6/P45vGZcQ8IO3FBF7eWrOdTgkJ3Jr7sqVJWzUhNeUKLwakxft
oy5ecLWfTHlFbT3/phj+vgqz8VhQ2BFzZ4rIvxRZReAubkJ7vyzreLBtJwR/bZrt
DR98HL/Kg3eagoeJHfvenUGoByh1gVAGtEwsod+4bwQmTurcC8qm15WmHXLbU4EP
hDEkTbNWZ2mVRTp+PsadKTZqa+Kp2RMFULl0uVuAQfzk6ZRy5xt9b+0arCfVrTsZ
QM6urdyEBvcA0oCi4/dZwvW0Npc+cAxa3II/lEbGuF/AceuofQGSJDLomCr5N7gA
ZgKUS3IxavbMghFdhEg/Omib2znsxw+PJ2URJyGDAAzTJ54gxlRoximppvpRTsc5
XJVFz9dDNipuoCZTGtJ840gQtFU+ER4BpQ7VpK+k6UfZNVP09m+f3MReq46krmgT
yVehd8sQgrWZUXHZliE/JUtxIvb/w0/3ydM9yR9MCrd38pLCSbY=
=c63q
-----END PGP SIGNATURE-----

--7dh60zORlgutPnbpZfdJAv2xdJrO9keZy--

