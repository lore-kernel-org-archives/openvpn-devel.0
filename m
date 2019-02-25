References: <20190223180241.18374-1-stefan.strogin@...277...>
 <4b330b38-6408-c148-d1a7-d025021503df@...1227...>
 <13090aae-9e74-6a24-4b1e-1b7b8ad18a88@...277...>
 <8ad35f89-7e2a-f780-d0a9-efabc85ad97f@...1227...>
From: Stefan Strogin <stefan.strogin@...277...>
Message-ID: <85a0584e-e607-4e11-dc66-7f5ce090d356@...277...>
Date: Mon, 25 Feb 2019 14:04:05 +0200
MIME-Version: 1.0
In-Reply-To: <8ad35f89-7e2a-f780-d0a9-efabc85ad97f@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IJV3N99YoeJPafko1gLy0G0IAMylHQh3j"
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation with LibreSSL
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
--IJV3N99YoeJPafko1gLy0G0IAMylHQh3j
Content-Type: multipart/mixed; boundary="WtO2eceqScimZq03VIS9pAGzs2sA6pHXI";
 protected-headers="v1"
From: Stefan Strogin <stefan.strogin@...277...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <85a0584e-e607-4e11-dc66-7f5ce090d356@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix compilation with LibreSSL
References: <20190223180241.18374-1-stefan.strogin@...277...>
 <4b330b38-6408-c148-d1a7-d025021503df@...1227...>
 <13090aae-9e74-6a24-4b1e-1b7b8ad18a88@...277...>
 <8ad35f89-7e2a-f780-d0a9-efabc85ad97f@...1227...>
In-Reply-To: <8ad35f89-7e2a-f780-d0a9-efabc85ad97f@...1227...>

--WtO2eceqScimZq03VIS9pAGzs2sA6pHXI
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 25/02/2019 13:10, Arne Schwabe wrote:
> Am 25.02.19 um 07:29 schrieb Stefan Strogin:
> Hm, both have advantages. But if we can fix the rare corner case of
> OpenSSL 1.1.1 without TLS_13 then lets go for the TLS1_3_VERSION variant.

Thanks, I'll use this one then.

> Are there really Libressl versions that do not define
> LIBRESSL_VERSION_NUMBER that are worth supporting? Otherwise I would
> prefer to have only the LIBRESSL_VERSION_NUMBER < 0x2090100fL or
> inverted and >,. Need to double check what is true for undefined things.

"After all replacements due to macro expansion and the defined unary operat=
or have been performed, all remaining identifiers (including those lexicall=
y identical to keywords) are replaced with the pp-number 0" - C99, 6.10.1.
So "#if (LIBRESSL_VERSION_NUMBER < 0x2090100fL)" will be true with undefined
LIBRESSL_VERSION_NUMBER.

--
Stefan


--WtO2eceqScimZq03VIS9pAGzs2sA6pHXI--

--IJV3N99YoeJPafko1gLy0G0IAMylHQh3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkfUG6Y1yNm+33DMMHWzUMpXJe34FAlxz2bwACgkQHWzUMpXJ
e36M0w/+L5As00ctbWNHklfRNPE5qEi1/gqKQ0p2R6f3IwdFVUaZzARyJVsJGub3
B6/jSNqd3bCnFIaFctUKBMTt2GW3kOr58hDizqsZtmy/XdHFifyT5PUuehxmtoDb
kJ80gbbzNdZjfIGd0TvSeVVRuI+Y/inmzOn0jELL/ENwwn4ShQINmKHpZdcIsger
8jDhHztr58SVDCKr+ur7BhIE+P8tuTZ5PRpBm+qSm94TQ2coAlU0TPtM3U3RkIrk
Jg8Z7n9lDge5HJDo0XYR6b4Re1yjWex5oGRv98wvBQS7xedTR7LAfOlCvRk68YKs
PBydZevWtdR/j0kU0s9wYnNep+eaAt510K5Ao/t13MaHuNr/GjANkI+/QM+6OB6z
vr6ms3a5DKURFwVnndH7d3J/FqSQ29Haxl8B0ytk+937b116SDLs+KQ8ZuknFxjf
niWwI3pof6xln3Yv//2MuSJREbb0/TWJMBi+K8EXp9/dCv4IfHtTbrWieX/h3b+3
BtGB2yS0ambPr0wK7VvyYm6hJhtRztgHO9Wa5P62Fu0XVffMJxCSbn5261nt3sKb
oy0KKbK7aNNDtMqfLgUETVIogepy1mBbrgMRB2d9O5m2DnXOcNFNktnESM8taZQ3
QFFGfNI1rOnbM1YEz76wQQ+/SCJyW/sHOwr+z2xGfu/S7OgNbPg=
=B9V+
-----END PGP SIGNATURE-----

--IJV3N99YoeJPafko1gLy0G0IAMylHQh3j--

