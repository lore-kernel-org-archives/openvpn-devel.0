References: <20200206132103.15977-1-davids@...515...>
 <20200206132103.15977-2-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0711bc60-8187-c96a-d7d8-e3ec6ec29c89@...1227...>
Date: Wed, 12 Feb 2020 12:40:47 +0100
MIME-Version: 1.0
In-Reply-To: <20200206132103.15977-2-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qZq0RGtpsg0MS975OaMsDHR9oySaxMANv"
Subject: Re: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qZq0RGtpsg0MS975OaMsDHR9oySaxMANv
Content-Type: multipart/mixed; boundary="r7ZCN7Sx18ENqtDMllrQSoZ8haQgVHtpA"

--r7ZCN7Sx18ENqtDMllrQSoZ8haQgVHtpA
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 06.02.20 um 14:21 schrieb David Sommerseth:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> The previous implementation had the problem that it was not fully
> compatible with printf() and could only detect % format directives
> following a space character (0x20).
>=20
> It modifies the format string and inserts marks to separate groups
> before passing it to the regular printf in libc. The marks are
> later used to separate the output string into individual command
> line arguments.
>=20
> The choice of 0x1D as the argument delimiter is based on the
> assumption that no "regular" string passed to argv_printf_*() will
> ever have to contain that byte (and the fact that it actually is
> the ASCII "group separator" control character, which fits its
> purpose).
>=20
> This commit has been updated by David Sommerseth based on Arne
> Schwabe and his own feedback on the mailing list.
>=20

Acked-By: Arne Schwabe <arne@...1227...>


--r7ZCN7Sx18ENqtDMllrQSoZ8haQgVHtpA--

--qZq0RGtpsg0MS975OaMsDHR9oySaxMANv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5D5EAACgkQFRhsZwKx
RFSJCA/+ORF383GoCxW+FiuJEN65qA5+iQ6cAjOSLPvOeaGtcEyoPz0ik8i8VSRf
EHZzPz+ExNTu7gFsxBL9+pdcN9PflmnwNGSNIAQSXdM2/KGREsW4xxZrcp7QWHpu
rSqkoyg06xhTluwzBILFv1AEtL09/I8kfWts4v//PKzbSpV4QN2jXpt034K+AJt8
swBq6ZcgyeYUBZNsTk0Ov3DR2xef4Xz9cF41Fqa8d1aRzpd7oFdXLY6GpZhP16cB
3BPEcNcCgjYd3IdsKwt3Kwp3jSTd9kGr2y+b38FcXtp4QojoKy+/U+n4/FSdBgBc
HyYcDS4LNjBXmgcX5d6PqjOK1GurNghXd4GNvKfpT/ho2Sg3p9kURRQnIWZWivvw
myWPb/GjrM/sQ6LeJxch9saKnHqyUxBEvDHcPVHutkLiqeM015XHktcHy1x1lIN6
wwH/T3M4Z/bixU4Vs7X06Iuk7DQlvq4qUCovaoftzB+cKnpABng98gAY/J0QoJjO
wTxT2gjoubh3OZSgb7+xG+Tdtoy7HQgMlPNZFF/73zXlgPhx5+wD1UMmajLawgOQ
AbCbec5lHF13vP1xYn4r3XpU6OEMyOoFlH9Jp+h3g2Nd8x24gZCrh2Oi6I2VaFV8
lCnTlmE+nlRjZ20EVXyaosk3YvRWAOxKPjM00pYklA5ri1jRCMs=
=ZMJ4
-----END PGP SIGNATURE-----

--qZq0RGtpsg0MS975OaMsDHR9oySaxMANv--

