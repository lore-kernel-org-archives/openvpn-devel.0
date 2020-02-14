References: <20191117181243.28919-3-arne@...1227...>
 <20200213135126.9131-1-arne@...1227...>
 <CAGyAFMUUqvVoioxidB0utxQUQ+YsbgNUO+Zhj9SHkvNNH1q+qQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c54791fe-3697-5591-52dd-ea589f565bd4@...1227...>
Date: Fri, 14 Feb 2020 15:35:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAGyAFMUUqvVoioxidB0utxQUQ+YsbgNUO+Zhj9SHkvNNH1q+qQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FIqXD1gN495Mwpg7z7PNsN2zJqceqEfUD"
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] Move NCP related function into a
 seperate file and add unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FIqXD1gN495Mwpg7z7PNsN2zJqceqEfUD
Content-Type: multipart/mixed; boundary="xFBye2b1z1HYL5UeNtClfpgc3sgtErbrn"

--xFBye2b1z1HYL5UeNtClfpgc3sgtErbrn
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.02.20 um 14:08 schrieb Lev Stipakov:
> Hi,
>=20
> <skip>
>=20
> I was planning to send a separate patch, but since you=C2=A0moved
> this code, maybe you could fix it here.
>=20
>> +bool
>> +tls_item_in_cipher_list(const char *item, const char *list)
>> +{
>> + =C2=A0 =C2=A0char *tmp_ciphers =3D string_alloc(list, NULL);
>> + =C2=A0 =C2=A0char *tmp_ciphers_orig =3D tmp_ciphers;
>=20
> This is redundant. strtok() manipulates string, but doesn't modify pointe=
r,
> unlike strsep. So it should be safe to to call
>=20

This patch is just moving code that it does not touch. The original code
is from Steffan. If we fix it, that should go into a different patch I
think.

But yes you are correct. But the compiler will optimise that away I think :)

Arne


--xFBye2b1z1HYL5UeNtClfpgc3sgtErbrn--

--FIqXD1gN495Mwpg7z7PNsN2zJqceqEfUD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5GsCsACgkQFRhsZwKx
RFSUZw//bljBCMmyxgeid4LkrKj7i01si8VuPgZd+T1x4FKPyuzFxl+kXkLsUzDF
JcTqgJeZI7LMdditRxQRxRYgebBNt1nc2joKBEXicZmjo5eB6VP3rHYfTh8JmWGz
5SOSgZTyM74D8FVVptYvkYLeL6IUCAQt0rWEKyIklgpZNAgRp33dt6oNhtOc4dPk
SI85wxGtry0yydSijzVU90qfDPe2QZTok78AdlMTvvJqNVy/l5yyEnsxipIbFB/L
x4nPn0Win+bLR3Zo1vbJWYAoX9o2lwHWTzCPx8MARKAkI+31NR07ITMahhJFzI3R
zVaPtE3sYG/bTCCWATTNm0ZDD9ZYfHyQ6ujGG7YVJkwUzHRRPMR7iFACFRAbqt7H
xXuILvjBamApakQMkMisB8z/31hIfw67EPQVWVpVT59gSrB0Vr6uPss7WKTnOykH
h1ZQ6aE4OmC7NHNeiJ0Wmgr+Hs8V9CmGiYiXrKvEDMqKusMkwGf2dOfgBCHctnLI
djks0ibSeKVZQtlqSGCnDeyr7Fvo60O82p1oFF4gQwj4quT3X0ZdxDW1XE6Paa2G
IMx/jHUBo4Gv7hFpjHBbwMBK/KtS0hTxWZ68khD0e5ipciZzewcKvYM2nOtjnqgu
N2Isj402ht3uFGTKyq8yOTdF4Ubj+nj6gghMZFIDAQ5xUT6k0Y4=
=cMEX
-----END PGP SIGNATURE-----

--FIqXD1gN495Mwpg7z7PNsN2zJqceqEfUD--

