References: <20200626142947.12776-1-tincanteksup@...277...>
 <edef7a28-bbd5-3db5-3229-0d3a525bb577@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f4ac5551-a5ad-4a1a-bd3f-e8c7e9f37cd3@...1227...>
Date: Fri, 26 Jun 2020 16:41:04 +0200
MIME-Version: 1.0
In-Reply-To: <edef7a28-bbd5-3db5-3229-0d3a525bb577@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3RR9XN29u8EfgSd4R9TefeAJDV4i1KYXT"
Subject: Re: [Openvpn-devel] [PATCH] New man page corrections -
 encryption-options.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3RR9XN29u8EfgSd4R9TefeAJDV4i1KYXT
Content-Type: multipart/mixed; boundary="E9WwbfRUFrmlJjkLrPUB7uyIlWpAomuF2"

--E9WwbfRUFrmlJjkLrPUB7uyIlWpAomuF2
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.06.20 um 16:34 schrieb tincanteksup:
> Comment inline:
>=20
> On 26/06/2020 15:29, Richard Bonhomme wrote:
>> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
>> ---
>> =C2=A0 doc/man-sections/encryption-options.rst | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/man-sections/encryption-options.rst
>> b/doc/man-sections/encryption-options.rst
>> index 42c80eb8..076b5fd3 100644
>> --- a/doc/man-sections/encryption-options.rst
>> +++ b/doc/man-sections/encryption-options.rst
>> @@ -86,5 +86,5 @@ Generating key material
>> =C2=A0 =C2=A0=C2=A0=C2=A0 * Generating *TLS Crypt v2 Server key*
>> -=C2=A0=C2=A0=C2=A0 Generate a ``--tls-crypt-v2`` key tp be used by an O=
penVPN server.
>> +=C2=A0=C2=A0=C2=A0 Generate a ``--tls-crypt-v2`` key to be used by an O=
penVPN server.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The key is stored in ``keyfile``.
>> =C2=A0 @@ -127,7 +127,7 @@ Generating key material
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *Note:*
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This file should be kept secret to=
 the server as anyone that
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 access to this file will be to gen=
erate auth tokens that the
>> OpenVPN
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 server will accept as valid.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This file should be kept secret to=
 the server as anyone that has
>=20
> I don't know if this is correct or if it should read:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This file should be kept secret from=
 the server ..

No, it is correct but maybe not correct English. Basically I wanted to
say that the file should be only kept on the server and not anywhere
else like a private server key.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 access to this file will be able t=
o generate auth tokens that the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OpenVPN server will accept as vali=
d.
>> =C2=A0 =C2=A0 .. include:: renegotiation.rst
>>
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--E9WwbfRUFrmlJjkLrPUB7uyIlWpAomuF2--

--3RR9XN29u8EfgSd4R9TefeAJDV4i1KYXT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl72CQAACgkQFRhsZwKx
RFS8GA//cxwMKKvVMZ3z22Jccz294CwzWBtFr+ccrb8EsX1jE47gbUt/lyn9Q1jG
nPsSUEALWNA8gd3xiC/OdvNiY472d4gZK6Cy1SGV251renE/rMSdf8XrnAdTjyB5
S9TDU6kNjQJm5VSufz0OiGhn/ZvkRSJZ98PfQ9cQO8mYHLfPhtJT5Xp12qRuWPEs
2kIaMckWYPt/6qgSfYjd4Ab5fbDarI61ujVIbkYehc9C6lBAkA4EBoGF/Kpr2SjC
00FVUj4gltaUXzZUtAXQ8CTmcz9yUa3/eY5lKVkZuSQNOlr9UDWxADxACKOtBY2h
+lu4bz5d0BVCRKnHTZoOGUvqkQn2uRQ9yfk9m0pvW334CnvBNlt9AR7+6+6gJnmk
toHo6+Q4L6+yMvAA/6h8e0aTdem1QJ/4dD/yC32WkM8D58Sbj+cMCuzPxBmFG1EN
eV4J4RWsQ3gHRr+cFbFUXmDjHVd5xW++KPO8fZKPvdfz1N8luCBmCjqM0yOXKwGn
ikMZr2Pi586QURns1iuVNnkPi0mnr1J+wTFWINzB3sh1k5cy2MoQjAfBkyWlU6AJ
vNWwCxQzEycJ1lLzv0R2bGpDUQSgZbDLZhf55UgCjEnVldqGJ2EazqwklNMbtHa3
6OX9zUz5aTOTOKr5nZhc32M9k6OaEb9Ltv8H9ApjOZ00gaNOszM=
=j1za
-----END PGP SIGNATURE-----

--3RR9XN29u8EfgSd4R9TefeAJDV4i1KYXT--

