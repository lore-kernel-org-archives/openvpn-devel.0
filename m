References: <20200328040858.16505-1-arne@...1227...>
 <20200401102159.29157-1-arne@...1227...>
 <8e4f27a6-5046-379a-8a50-56db0627c9be@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4cf61bd5-3942-858a-6312-8932fb555326@...1227...>
Date: Thu, 16 Apr 2020 16:46:14 +0200
MIME-Version: 1.0
In-Reply-To: <8e4f27a6-5046-379a-8a50-56db0627c9be@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zY1TUfbcqpGkuzRfzcQqa7TWDadj1hWu0"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Refactor counting number of element
 in a : delimited list into function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zY1TUfbcqpGkuzRfzcQqa7TWDadj1hWu0
Content-Type: multipart/mixed; boundary="El2sQVfr5weUV0lE1InGDUhPkVYjdqPqU"

--El2sQVfr5weUV0lE1InGDUhPkVYjdqPqU
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>>
>=20
> Other than my little nitpicks above, the patch looks good.
> However, I have a question.
>=20
> Since you are refactoring this code and this is going to master/2.5, why
> not reimplementing the get_num_elements() function using strtok() ?
>

strsep/strok have the disadvantage of modifying the passed string,
requring copying the string. strok in addition breaks on recursive calls.

Also the for loop is very to understand and from playing with godbolt
(https://godbolt.org/z/RVtjVL) it looks that the compilers will
optimise/vectorise this function so using C string function will
probably be even slower. So the simple and easy to understand function
is the best choice here IMHO.

Will send a V2 with the formatting/description fixed.

Arne


--El2sQVfr5weUV0lE1InGDUhPkVYjdqPqU--

--zY1TUfbcqpGkuzRfzcQqa7TWDadj1hWu0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6Yb7YACgkQFRhsZwKx
RFQeaxAAm9NlBDSxCEOHhrZROwI8Hmw6V3/D3QEHvtz/eUlARZO8WoRbPwJvaHy+
/eong3jM1vU2CqLPprcGaerDHsM9Rg3AiGZCxlTGdkwfAcTTSiVZPbYElXL+KqEw
cUJt8qwZyTPGwTw+3bV8QGh+JSUcITkvyzbWBHEUCopCcdAYuKG1UPqeBmRo07Mp
cac9Lvgkb/3pfbWbBOiMoa/dkR6q3kLdqAkww+JXnk28EjdjQs/WtRdldlMgbu/P
3GmLvVNbWskVi0/bcKEtG/KZSTR4CIlAvPGpQ/ova1q8OoLBrXpuAjehJ3InziEJ
yzYN1aForzEh6L/83VEo5OlCl2jJJalmBEKwdmaEf2I1SJb5I9lV8QCfCSHjUvG5
qtijcdnDOdZhtBHhhqe1YK1DFwjmQGVbePQKSvuQpqMp/tpeT/LvI65ezXCw07QJ
0gLy4EIIRDflOd2hdhWAEq4MGieDT58h3Blm/6nmL5a17IhuRnmZHiU/wI9zROzY
RB4uDFUKV38iZ+QDljIs2+BsDb39sRkF+GtZc4UYBHkLEtIWxUHwNo+rrMN6HYms
uo2vITKQwUEER9hLCUw7IsW9mkG0IJEvmkkMag9Gyy88wssSG2q8fwg4RkFoomXy
G3JXvx0f7aADZBOsKMqDwMJuXV9TB3pX5538mIHfqQbF21N8CCU=
=SjTT
-----END PGP SIGNATURE-----

--zY1TUfbcqpGkuzRfzcQqa7TWDadj1hWu0--

