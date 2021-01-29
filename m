References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-9-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <40f64e23-b2e2-89bd-6b08-e37ae74f4445@...2080...>
Date: Sat, 30 Jan 2021 00:16:49 +0100
MIME-Version: 1.0
In-Reply-To: <20210125125628.30364-9-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9OhmjJgLA2zwr7Icz11OaAUzOThqGzlk8"
Subject: Re: [Openvpn-devel] [PATCH v2 08/11] Allow pending auth to be send
 from a auth plugin
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
--9OhmjJgLA2zwr7Icz11OaAUzOThqGzlk8
Content-Type: multipart/mixed; boundary="zCsg8dd8TLxqlXNBBzlRQpp6J0CCBaetZ";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <40f64e23-b2e2-89bd-6b08-e37ae74f4445@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 08/11] Allow pending auth to be send
 from a auth plugin
References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-9-arne@...1227...>
In-Reply-To: <20210125125628.30364-9-arne@...1227...>

--zCsg8dd8TLxqlXNBBzlRQpp6J0CCBaetZ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 25/01/2021 13:56, Arne Schwabe wrote:
> Patch v2: removed change that slipped into this patch and belongs
>            into the next
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   doc/man-sections/generic-options.rst |   3 +-
>   include/openvpn-plugin.h.in          |   8 ++
>   src/openvpn/ssl.c                    |   2 +-
>   src/openvpn/ssl_common.h             |   1 +
>   src/openvpn/ssl_verify.c             | 161 +++++++++++++++++++++++++--
>   src/openvpn/ssl_verify.h             |   2 +-
>   6 files changed, 162 insertions(+), 15 deletions(-)
>=20

Glared at the code, run some simple tests and it looks good.  I ended up=20
patching sample/sample-plugins/defer/simple.c to do an openurl call.=20
This worked fine.

I'll send a patch updating the sample-plugin after this patchset has=20
been reviewed.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--zCsg8dd8TLxqlXNBBzlRQpp6J0CCBaetZ--

--9OhmjJgLA2zwr7Icz11OaAUzOThqGzlk8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmAUl2EACgkQhs+UTJZx
/fK9TRAAl3zEupXIpQXcDfn3t+Q9uW8wzjx+FePfmTNQ/oIuTw9S/Gjlq7A/F48C
r6I9hPel1w9RLbgP0ChB5prSVHaz+rT19v4RUUou7aZO8PGPneXqI3thf3u4Yf8k
dtwKjJN6PlSPGBSpcngvdhktUekXBhTS8gs0zpIUiH6m7zofvmpRiD9hQgAzGT1y
EeVo2GFHySn7fqbwUHEl4ZaQbE+lECwq7J1BtOE6dqnwgquXsrCYFVao+VbNiY1/
XRl9zuz9Sh1RKrfDSkNbI12gvTUVcaUSG34K7Pq8HHAONyel8xshGxGe7cNT2sUZ
debpNwOZmIPuNz3pDX2fuvU1lAQjssSR9SDngG1Kx6XO5Us6FRMWPWgCyOTzUi77
vI6BMrE8uveoElvD4my1YcN4gsRAUI9iiNrscWdlkcGpAt/0APvico05pW+m7HcK
18xWqh2vTbt3GuzI0MBUZy4L/z+V1lkyAxIq9JPYP9h/tlShOddek7a+1MEqIbJ6
4xejaQF86v+6h5VATOsDMkimI531ydOwTwqLoNxetq5/cZRpoA0fv9RLAuDkl2Yd
s/IadNSFrmLFlEFRi6yNaS6cFo7wjkhd5g7YgNCe+0KKQOEnE2qQG5QaI+10nJ5P
RglxZZ2lMuPuSmAlleArTr8muCXVAc1mcv2gDDGa9i5mR9bg/Bg=
=XqxH
-----END PGP SIGNATURE-----

--9OhmjJgLA2zwr7Icz11OaAUzOThqGzlk8--

