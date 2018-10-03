Reply-To: openvpn-devel@lists.sourceforge.net
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
 <8ddfa02f-4003-4a20-5cce-6bb5d8e70e89@...2080...>
 <CAKuzo_iNhAf1yVG2qP0mfZpKWDukhJdcH6nGsJnHQ7=Rz60QuQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0fe28e01-9612-b313-08c9-32275077cf19@...2080...>
Date: Wed, 3 Oct 2018 23:05:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iNhAf1yVG2qP0mfZpKWDukhJdcH6nGsJnHQ7=Rz60QuQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="STxQtlL5JpeHKVub8g8YpZfic3gEoP5ba"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--STxQtlL5JpeHKVub8g8YpZfic3gEoP5ba
Content-Type: multipart/mixed; boundary="79M7xphVPgsCVEgEmY4kyHJQasleTr2dy";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <0fe28e01-9612-b313-08c9-32275077cf19@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
 <8ddfa02f-4003-4a20-5cce-6bb5d8e70e89@...2080...>
 <CAKuzo_iNhAf1yVG2qP0mfZpKWDukhJdcH6nGsJnHQ7=Rz60QuQ@...278...>
In-Reply-To: <CAKuzo_iNhAf1yVG2qP0mfZpKWDukhJdcH6nGsJnHQ7=Rz60QuQ@...278...>

--79M7xphVPgsCVEgEmY4kyHJQasleTr2dy
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/10/18 18:31, Selva Nair wrote:
>=20
>     But ... are you saying Windows C compilers we use/support does not su=
pport
>     stdbool.h?=C2=A0 Even with -std=3Dc99?
>=20
>=20
> It does, but we cannot avoid using the Windows-specific BOOL (which I
> believe is a typedef to int pulled in through windows.h)=C2=A0 as Windows=
 API is
> replete with it. In fact stdbool's bool may be internally an int and thus=
 same
> as BOOL but we can't assume that.

Fair point, and I was not aware of this detail.  In this case I have no iss=
ues
with keeping BOOL when it is tied to Windows APIs expecting BOOL.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--79M7xphVPgsCVEgEmY4kyHJQasleTr2dy--

--STxQtlL5JpeHKVub8g8YpZfic3gEoP5ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbtS83AAoJEIbPlEyWcf3yMk0P/iGvldZV2fORfPMQLbVaG/QV
Oo7zF5nbi2gZEmRJubD66VSgDfTBZgg6RGVZEtJXUzIm282YDui3ZFqbjTZ+Pxi2
imCqTTrRo6gkqc4caJ+4Sq2DI3633X0VGFehAGf+75BgsX6h3HiTixdOSZcGCMWp
GC9x/qUFXq5ONcxxaPh4EAHMF0sMN2O4SSxJHIkPedhR8oBqIK1SNkk+eT3W2yqV
CHXRvSA+VR4oF56u8Ir6Ods1KU/EgNSpB5p4d5Z5jLXS57BmZRblxx6732zt/uHj
TYY3/xExsSnna67gtCb6E4vdDkp+lQmZOSqirp7UBFF6DqEbkiX1vngJkAxbDoYy
FMw+pzkxUu8tYj6nm6ZPeLj8laZdofinHQmaLHyI4W9DPP9s8fLJb/uZovujipZv
rANLzrn696n3i+MQPOW3amBJxdUa6S9xdDv7SrOUnR9I9p3oDSdolBIMr1Dab64f
CnaR49LZcx9RS0ufYeeXAJ/kyvJakq+YXo1JZ7QrcevEh4hbYqL5xn3MMVT8VaUL
pIr7Obortll7Xmw7ViBsFhIGKgqrwjAaK5j1KYTuuA4Z+SLGeiK/ndB1197PFoHr
gNoC3mPEPEhbPiABebk75rWQV1HjOaHGYrjdyY10PJ80D0l2VB7KaGgjwx18yRkn
aNKAVVMOqcaCyswnBT9S
=cnAv
-----END PGP SIGNATURE-----

--STxQtlL5JpeHKVub8g8YpZfic3gEoP5ba--

