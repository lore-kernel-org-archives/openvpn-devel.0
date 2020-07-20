References: <20200720103822.26088-1-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7d48b5fd-aaf1-5989-6fb9-fbc3b3e740ec@...1227...>
Date: Mon, 20 Jul 2020 13:19:01 +0200
MIME-Version: 1.0
In-Reply-To: <20200720103822.26088-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9dEah2Am7e9JiDvtHRQNfFJNWbCfI97qZ"
Subject: Re: [Openvpn-devel] [PATCH] travis: Fix make distcheck failure
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
--9dEah2Am7e9JiDvtHRQNfFJNWbCfI97qZ
Content-Type: multipart/mixed; boundary="Hl4rhrfAyfO8KpZ21D7p41i5ZlBTBt758"

--Hl4rhrfAyfO8KpZ21D7p41i5ZlBTBt758
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.07.20 um 12:38 schrieb David Sommerseth:
> Since commit f500c49c8e0, the man page and html documentation need to be
> generated when building out of the git repository, as both openvpn.8 and
> openvpn.8.html will be shipped pregenerated inside the tarball generated
> by 'make dist'.
>=20
> Travis was lacking the python-docutils package, which made the
> 'make distcheck' build test fail.
>

Acked-By: Arne Schwabe <arne@...1227...>

Tested on my own repo and Travis runs fine now.



--Hl4rhrfAyfO8KpZ21D7p41i5ZlBTBt758--

--9dEah2Am7e9JiDvtHRQNfFJNWbCfI97qZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8VfaUACgkQFRhsZwKx
RFTE2Q//XvF2SZT76jzIZTMYBZl1s/fgbA8XNsh+Hh30vLA/TaMmNx6x2MNGfdeo
438hj/4j8bwwQRpZuOuL677Cp9QgHF0IBJ4kwYDsvKjzXrB7adCzIxM51sPX+fSZ
duadqdzOFZH/2YxCA1Z1ZcqW2XV2SgS78otjgg3KKfckH9LVpkam8QZy5FcHcHJ5
jlO1SOIHuVRn2cDznzo0QuAqyirBc89mesI1T1iTe3GiuYDG5vJKtg4Pr4foKs1B
eMGXRzGn2JUxqXttBhTyHU4F0iT1uY7iEyDVpkHr6ncJ9nm4QqlVVIKjdwS92/Kl
ZLwlyviiZ5lkJr5VqsGVugn1EeEblhOXgjnjASjNjvHukO+UndkP0RXnm4j6/30h
RHsB5OsCvesS7v6RvzvE0aAeKt9/scIyRda6p5ODeoZObKunNAGh3YsrG24kVLLH
vKN+ZdzhJ4214KdVjLzZ2T0uq6ueg6oaIRTXzGpiAO46ImG1LxoL2uMuDYzzLwDO
Ox5l9znjQHZ0hF9Lf2P+Ck2Pl3FXCtUEm5xAlPgSUTabjoCZKT88lsA+GMNGds5W
0LrQZ3vElylXutaU4jj7Lfc9PPrfUQKA38DUGIaEN8Pbsmj2fN2LooPK+dagk+aJ
yCpjLc/27OfbSRgfv9rNVibo4KZjzlSpB3mGJW2Wt3DrWvzcqzU=
=k3SM
-----END PGP SIGNATURE-----

--9dEah2Am7e9JiDvtHRQNfFJNWbCfI97qZ--

