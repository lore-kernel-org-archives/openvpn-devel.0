References: <20191122143315.8564-1-arne@...1227...>
 <CAKuzo_hU7K-vaP7mcyu8kTkKQrg0rwacwxayi-qi69Ez81Vt=A@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ffe7f978-7123-d715-128e-c3a517029ee9@...1227...>
Date: Wed, 4 Dec 2019 11:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hU7K-vaP7mcyu8kTkKQrg0rwacwxayi-qi69Ez81Vt=A@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gyzQYqHJkw0nrHCgAW6xelURLJwRH2oFn"
Subject: Re: [Openvpn-devel] [PATCH v7 1/2] Make tls_version_max return the
 actual maximum version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gyzQYqHJkw0nrHCgAW6xelURLJwRH2oFn
Content-Type: multipart/mixed; boundary="r69ULAfH1tIJRxokze0kNPx2k6fzLOwEP"

--r69ULAfH1tIJRxokze0kNPx2k6fzLOwEP
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.11.19 um 03:04 schrieb Selva Nair:
> Hi,
>=20
> On Fri, Nov 22, 2019 at 9:34 AM Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
>=20
>     Before OpenSSL 1.1.1 there could be no mismatch between
>     compiled and actual OpenSSL version. With OpenSSL 1.1.1 we need
>     runtime detection to detect the actual best TLS version supported.
>=20
>     Allowing this runtime detection also allows removing some of the
>     TLS 1.3/OpenSSL 1.1.1 #ifdefs
>=20
>     Without this patch tls-min-version 1.3 or-highest will actually
>     downgrade to TLS 1.3=20
>=20
>=20
> I think that should read "TLS 1.2" not "TLS 1.3"

Yes, you are correct. @David, Gert, can you fix this one on the commit
message or do you want a new version for that?

Arne



--r69ULAfH1tIJRxokze0kNPx2k6fzLOwEP--

--gyzQYqHJkw0nrHCgAW6xelURLJwRH2oFn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3nj3kACgkQFRhsZwKx
RFQbnA/+KEvRTQ3y1yb4hpEDtGKTiWUg3j0LWZ9EpniV+uG6E7ahuJBUJDeYnk5/
0HmRMDN44SPGjFchRHE1DlGN8DL3l0jNxXA2p3Ep9q4HwA8ZjqrNYg4Z7ne6HuUB
ZITKkZNzpM2quhX3Si9CxaFnaiJ19Tg79eONrhJ1zyRBcpvKEavF80ijwtM7hgvO
7bv0S/tCWmz14ttc+iU/icDmSik9f62JSGJtdtk1p/pKePtjOHvqW0pk3KjO28DY
7ZMUovIJgy0igDCp1v8CAMsZ1//U0LIv/eh2Z79Bs2plJ6gFH2X26t2cPcgJWJx8
TbMdCuwIPDltSr+5MJh9rWHunrh4WcD8T91opw1eveveUw829dbNPpJXx7OvmLOn
d6vKbOrIGY1OMHw9379kj2D4YGnmaUMeoRrJrEzia1Jg+YcicMaR1hb0wVod+zuJ
kXBEh8YADa33CAHNmIqnKde5TMrjTgXvlRLR3ZFs9wWo+ScQvUsntpowgontC50T
W12oeUYINVMEWFMnJhco+CUdiBKESbNdEGv3ucMM8/Ig1e3In8qQ3q84s8yGYEr0
+F+1p7kHCRew7zdjzM7OqWLZMyLY0gw3wDcd3jQmUX4rqUAKpuyzn6gYviD3fsj8
zl22iUNmgVRF4lWB0ydGTv4aa1TkLny6jqqVrDbMAictu9EOHlc=
=J+Go
-----END PGP SIGNATURE-----

--gyzQYqHJkw0nrHCgAW6xelURLJwRH2oFn--

