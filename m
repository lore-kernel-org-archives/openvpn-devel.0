References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3ccd33cb-5d3f-f736-aa53-849dd358d568@...1227...>
Date: Wed, 10 Oct 2018 14:41:22 +0200
MIME-Version: 1.0
In-Reply-To: <1539174377-2678-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J8qeLE8S0OfOyHK8yYK88UUWw6BmoN6nL"
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J8qeLE8S0OfOyHK8yYK88UUWw6BmoN6nL
Content-Type: multipart/mixed; boundary="0o7fgZlYc3D7rVkohI6RXJtQ6y7F7S3D1";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <3ccd33cb-5d3f-f736-aa53-849dd358d568@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1539174377-2678-1-git-send-email-lstipakov@...277...>

--0o7fgZlYc3D7rVkohI6RXJtQ6y7F7S3D1
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.10.18 um 14:26 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> In Visual Studio when unary minus is applied to unsigned,
> result is still unsigned. This means that when we use result
> as function formal parameter, we pass incorrect value.
>=20
> Fix by introducing frame_remove_from_extra_frame function,
> which makes code semantically more clear and eliminates
> the need in negative value and cast.


ACK. Looks much cleaner.

Acked-By: Arne Schwabe <arne@...1227...>


--0o7fgZlYc3D7rVkohI6RXJtQ6y7F7S3D1--

--J8qeLE8S0OfOyHK8yYK88UUWw6BmoN6nL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlu983oACgkQFRhsZwKx
RFSYNhAAkxYcEQEWQFB2kBonth688x+g0O/IyQe6MzJ+fYVGacdAvp7s3yJKhsCc
E+X2VIblx8OYr1RNHgNlnp+NbCbnBGS2hPMJfZSeouPqR5GbCf68COC9yjWLcRMx
GdhakQfbtnQaPSjQrpBxyPB+tUqWPFnTsmDT23BpIdWyux+keKSbZt2vK/ulvPE1
cV3q+e33pEauz04kWBVBJ32XiYVMmK1shT/FkFBzt2d7QbhFmAAZzlcOVXDjl/mY
cXMR+Gnngkzjpo+OwaWDlKYgShGDm1V7jLJOqalhCbDIrMetCLH2qHWH+ggemnus
ijZQ8LVNFdvkk7sx476p8M14S0UnWyMtoOaR44lNvYLj4nJoHvm2cjoeE7sW475v
Th6xLcQAd9/eE2K4V5Ry0z4Ae6gM4EoIltVrcxo8JFG5RoCI6N1KQ76IEVSQdHrS
3M9ZYB+XHGgbPkm+Bw4k2MFSvD2E4O6g82KFVbRkaKsBde8bOx0qYqY/cgVJouaH
kvIRAh+FDNc8nzOtW0PdA7plQkIgCmHvVOTesmnF2vzylN9n04cW35R1Kzd4NIwG
AFnS2LmgrVwmmNfpDt+wrlugaMEpkWHAjccO/bS00v9p4nxfEwySe5x4Nu2rzizy
eDX8FDv0H4bd7qNxmVstF7q9g1qM40JzNnQf7yiFENTNj95r2aM=
=84HW
-----END PGP SIGNATURE-----

--J8qeLE8S0OfOyHK8yYK88UUWw6BmoN6nL--

