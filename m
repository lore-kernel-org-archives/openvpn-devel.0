References: <20200414185214.1863-1-juliusz@...2525...>
 <c33a84b3-b10a-a8c2-d46a-3ee2d296f7f1@...1227...>
 <8b1d14d6-9ca4-46f3-b038-0fbc5af568ff@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e63c8973-e8f2-bdd2-8925-a89df7ad4339@...1227...>
Date: Thu, 16 Apr 2020 13:11:20 +0200
MIME-Version: 1.0
In-Reply-To: <8b1d14d6-9ca4-46f3-b038-0fbc5af568ff@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qb7PTgbwFdMou3a2QstTiBQ382Mk1p6Fs"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qb7PTgbwFdMou3a2QstTiBQ382Mk1p6Fs
Content-Type: multipart/mixed; boundary="Qton24JvyFGRbQG1Ve3NkIppOpj6OTbKR"

--Qton24JvyFGRbQG1Ve3NkIppOpj6OTbKR
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 16.04.20 um 12:42 schrieb Juliusz Sosinowicz:
> Hi Arne,
>=20
> On 15/04/2020 11:31, Arne Schwabe wrote:
>> Am 14.04.20 um 20:52 schrieb Juliusz Sosinowicz:
>>> This patch adds support for wolfSSL in OpenVPN. Support is added by
>>> using wolfSSL's OpenSSL compatibility layer. Function calls are left
>>> unchanged and instead the OpenSSL includes point to wolfSSL headers
>>> and OpenVPN is linked against the wolfSSL library.
>>>
>>> As requested by OpenVPN maintainers, this patch does not include
>>> wolfssl/options.h on its own. By defining the macro
>>> EXTERNAL_OPTS_OPENVPN in the configure script wolfSSL will include
>>> wolfssl/options.h on its own (change added in
>>> https://github.com/wolfSSL/wolfssl/pull/2825). The patch adds an
>>> option '--disable-wolfssl-options-h' in case the user would like to
>>> supply their own settings file for wolfSSL.
>>>
>> Thanks the patch is lot less intrusive then the last version. We will
>> have to discuss in our meeting under what condition we want to include
>> the patch. We might add a note or statement that the WolfSSL support in
>> OpenVPN is mainly developed and tested by WolfSSL itself or something
>> along these lines.
> This is understandable since we will be maintaining wolfSSL within OpenVP=
N.


Could you take a look if this is an acceptable text for a README.wolfssl?

Support for WolfSSL is implemented and maintained by WolfSSL Inc. The
support is implemented using WolfSSL's compatiblity layer. The WolfSSL
support in OpenVPN receives very limited testing/support from the
OpenVPN community itself.

If bugs in OpenVPN when using WolfSSL are encountered, the user should
try to also compile OpenVPN with OpenSSL to determinate if these are
bugs in the WolfSSL TLS implemenation or OpenVPN itself.

To Build and Install,

	./configure --with-crypto-library=3Dwolfssl
	make
	make install

*************************************************************************
Due to limitations in the wolfSSL TLS library or its compability layer, the
following features are missing

 * blowfish support (BF-CBC), you must use something like
   cipher AES-128-CBC to avoid trying to use BF-CBC
 * Windows CryptoAPI support


--Qton24JvyFGRbQG1Ve3NkIppOpj6OTbKR--

--Qb7PTgbwFdMou3a2QstTiBQ382Mk1p6Fs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6YPVgACgkQFRhsZwKx
RFSSGw/+JEyPlUgcdD8yePznWXr8AFEFeV/kNQysxlxYUjmcMk7pTsyhAIclNnu1
eGSyvCrqSeQpFB4dHKdJBrGaW3EAsND4FRNJNTqh7T8EZpDLAZnO1GQmmdygAaC+
ituGIj9+/TgZARDGRxhEjZe6ngZjWKLVpmtYsM/IABAc2+QWLjf/9kao9vxjxa5X
FJHNVqJrwfEEEWlbGKFhuo8bQt3f0iVXET1v/0z39LGHtxtGSwMBd8rEWjun2GuV
CSkckcaJx8UbX2n2CiGP8NRJbVNedFLyJiWHwfEreD2ni/rER66Zgk3+QWJfHcUO
9r62X00NKnq8gM6Lb1EQq09tqqEthtBGpTnuqrF90e5GPzcLw8wsZOLP2mGnXZ+f
CIn7VxejmzmjgYeSxDFr6X08Tdr0JRLeeBJ3pNd15bUBvDS2N+A1TZEs3PM+XWJY
yBEXSwgK5bSpEVMxyoOiDFpyr9eeF4YV0zvptAY99T2+CBEmpzhmiWTe55ucIfRi
wfKVPc9Bw8JcU9h4uWydsqX48qQg/t0gJ1B7IKPI4LLIu9kAtibZ5CaKkBipOETI
xIRXsUACda0oLiDGcSVy1o4qBGdizjUZkZccU8oJbU+nGTb1r/E06p04llBbAxKy
P1luUDuUk85l80auC1SNzPtKbw47mavc+vDrixg7toQSRFFaRwg=
=M+Xj
-----END PGP SIGNATURE-----

--Qb7PTgbwFdMou3a2QstTiBQ382Mk1p6Fs--

