References: <20200727183436.6625-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ab6c6f71-af84-b96f-89e2-c477a7939af1@...1227...>
Date: Mon, 27 Jul 2020 22:54:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200727183436.6625-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LHKY1i2RaGW0PMCIQyt87AgxI2S3SHtua"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix sequence of events for async
 plugin v1 handler.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LHKY1i2RaGW0PMCIQyt87AgxI2S3SHtua
Content-Type: multipart/mixed; boundary="1l8an2fqSLvM3a5LYZxdBcyDmIWOIhwxf"

--1l8an2fqSLvM3a5LYZxdBcyDmIWOIhwxf
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.07.20 um 20:34 schrieb Gert Doering:
> If multi_client_connect_call_plugin_v1() goes to "deferred mode",
> *and* there is no OPENVPN_CLIENT_CONNECT_DEFER handler, we
> would read the "client specific options" file after every
> (succeeded-because-not-present) call to plugin_call().
>=20
> Move this to "after we have checked the deferred-cc file, and we
> know for sure that we have CC_RET_SUCCEEDED".
>=20

Not tested but the code change and explaination are sound.

Acked-By: Arne Schwabe <arne@...1227...>




--1l8an2fqSLvM3a5LYZxdBcyDmIWOIhwxf--

--LHKY1i2RaGW0PMCIQyt87AgxI2S3SHtua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8fPwwACgkQFRhsZwKx
RFS+cQ/7Bh582UxVcdalRHz0naVZ0MItwyZ5JSjVTnsj+ZAxq7lUVbZjq9BpDDEn
U7Q9KANCbrrMAZnSlfxE/3arDP7d35+UY2Q9OeQvfdKKwPqa2A5ffjfZfXGApk4J
g0RPJrJZlfwncccPF1r9Oq00YpBdRMgivmk8Qb9Xx/dtgwg2Cnr5OBH0lADRHDSR
8ld7xWvwa2sEKvwTHU6+3yhX4wheSNgvXcrkzX90G7OwtX4goiHAPqke4AiM7nvP
P1FA7VgfDKtG6ghcJWk27vvtHhBX2OnRmptFw5bTohSPHeeDXCe3+74VlM45Ro3Z
H6ivir6tnxQjFtZYdFut8ssQyxDyMsYpvuPMljXgK4nofQuGeLXshEjN910TBPvJ
wkaejZufde0xskwxzLb26BXNkOt37tXLDV4rBnnaEIbeimde/kb+p10Lvul+twLe
GWS8wNtNqQikoIX7eTjMjpw7tMOWM3C8u90D9j3jAdEt+LHwv5U+UEoRpNoCl8Eh
Lb8aixltA0dgxYOVw829pKhuAFhD+z6mEttVcsOGQRFRxp38ghzcukel9qtw1wyK
kX1ZvHsIGJdh4rZbvKIYahAyMx/QMj/p4+KZNydfH33PwUKZ5se3XncFYU4gj714
UKsx/q8mHT9t0hGOvBkuE5seWo0UGCmGQYg82M5BkvtkQFLoBik=
=NTZd
-----END PGP SIGNATURE-----

--LHKY1i2RaGW0PMCIQyt87AgxI2S3SHtua--

