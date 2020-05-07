References: <20200429145132.28424-1-juliusz@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7b6925d4-eb82-5163-03a9-19477ccce821@...1227...>
Date: Thu, 7 May 2020 11:46:27 +0200
MIME-Version: 1.0
In-Reply-To: <20200429145132.28424-1-juliusz@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lU2V2Q6n977EeYwFvmReB7mXMk2TP3YXs"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lU2V2Q6n977EeYwFvmReB7mXMk2TP3YXs
Content-Type: multipart/mixed; boundary="PnmTkaKp3b4uYxTDfwiZFN6Wk1jC1yfSP"

--PnmTkaKp3b4uYxTDfwiZFN6Wk1jC1yfSP
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.04.20 um 16:51 schrieb Juliusz Sosinowicz:
> This patch adds support for wolfSSL in OpenVPN. Support is added by using=
 wolfSSL's OpenSSL compatibility layer. Function calls are left unchanged a=
nd instead the OpenSSL includes point to wolfSSL headers and OpenVPN is lin=
ked against the wolfSSL library.
>=20
> As requested by OpenVPN maintainers, this patch does not include wolfssl/=
options.h on its own. By defining the macro EXTERNAL_OPTS_OPENVPN in the co=
nfigure script wolfSSL will include wolfssl/options.h on its own (change ad=
ded in https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an opt=
ion `--disable-wolfssl-options-h` in case the user would like to supply the=
ir own settings file for wolfSSL.
>=20


Not tested by myself but the code changes are okay.

Acked-By: Arne Schwabe <arne@...1227...>




--PnmTkaKp3b4uYxTDfwiZFN6Wk1jC1yfSP--

--lU2V2Q6n977EeYwFvmReB7mXMk2TP3YXs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6z2PQACgkQFRhsZwKx
RFRv5w//d1qZTzHU2kIKNo+0WFIeA7E4Eh7hmFfgujvnrYHtLfKRo8W2XYKmo6Cl
M6SidNtnowzGntwXtxe0RuvPL2dODauC83hGG4242aduPeytVplCyHM4HV00cxp0
2O1t8X6/ZzkSHW9rD2XHlH0spw2U3pmK/yt+RI0J/mC0vgAAtSm+n2XoKo7tS33P
KeWyZ7F9nzIdHXvSQ1T1n4HBQ1iTZh5h4o6pLcoKUWqq+dXVtoFIWcZCKETsnKn1
RbVg8yCa7j+FzstHILYMDfjL1iGPdY2TGdQqrqRjdO+uLzHt1t5/0p0vea//l2d6
oqzHfAsCg5wiEw8XTuWG5QYT7XiECvZYz1LRq8LIDl06jxMnAq9pcUEDO2kHFX+p
Hm4TBYffi9rTpdlSRa6TEkEj96JK/1e3lZ1JK1HnMI4VX2DpIHAcBcZhkVI+44pr
6bgMIYG3If2ChTDCOkN/leIuTwq99CUW8tyNvcWD00j6pjsFYn5v+J6tx7BFtxEB
SGeHzcxTywBU8sCNY0GQAel/DVkQfjCamdcE0iPz4a4uRaXYGEn99Vvz7rlN7VL0
VqeiH/D/+GrxZxdAQ5DKLs+1IsVmfAmFK0b5VsPDJpWTp7prkfFw0RlG7a80giqd
fz/kwVlG2vWva03Xi/ab8UfNbjWpsgtak3tTOa3PpyHevgRl6NM=
=gOs/
-----END PGP SIGNATURE-----

--lU2V2Q6n977EeYwFvmReB7mXMk2TP3YXs--

