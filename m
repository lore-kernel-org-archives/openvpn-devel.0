References: <20200724181324.19037-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <96532966-36e0-420e-92aa-8948a94d6876@...1227...>
Date: Fri, 24 Jul 2020 23:58:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200724181324.19037-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MPxTR4P75puMUAMZP0HgA2KgvTvDaep4p"
Subject: Re: [Openvpn-devel] [PATCH] Repair --inetd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MPxTR4P75puMUAMZP0HgA2KgvTvDaep4p
Content-Type: multipart/mixed; boundary="RidZ0gCCPULmV5TXkfBYmSttYo3FmV52g"

--RidZ0gCCPULmV5TXkfBYmSttYo3FmV52g
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 24.07.20 um 20:13 schrieb Gert Doering:
> commit 25a422cc60 deprecated --inetd, which is still something we want.
>=20
> Unlike all "usual" deprecated option warnings, we cannot print this at
> option parsing time, because we need logging to be set up first - otherwi=
se
> the deprecation warning is sent via the socket (on stdin/stdout)
> towards the connecting client, totally breaking this mode.
>=20
> (Which is why we want to deprecate it: too special even for us)


Acked-By: Arne Schwabe <arne@...1227...>




--RidZ0gCCPULmV5TXkfBYmSttYo3FmV52g--

--MPxTR4P75puMUAMZP0HgA2KgvTvDaep4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8bWW4ACgkQFRhsZwKx
RFRR+RAAlvwgyCuupibvywyI+Zkw9/iPYGMYOqPdLPuSSbxo3Lhv06JStt0gvH//
w0DnD3XsJNctUn7OhXxgWa36FsUx1gLMklNE61WBaZTGcn2inG9a2xJtnD/V+hQa
xhcPJZHUDu5jrKKKlGAz/nS6KfGsIihBoeqBE+bjOuxPsAbPbYf5zSneDP6mQ0Sg
t8wkb82h0jw4XXjz7kFyvT112UrEMEvi9SyDH6KCg6sArsiYNPBY3UVJ3FQWWJ9c
La7UHa+yWU0eNwApCKTUSwmbbHM4ckacVCGddM7lRcx1E6T+fktrJGO5Zgprvtt3
DlIHp6uwejTeFpUrx9UnG7h++r7KUDttZS0PIXxbTFRScwOWXn45JoY+S6VV7oOF
DA0tuse/UpKrKCTlWROZZJb+iQa/TGgEbPHZrZycVEXcUuaYC+Ho2pp2fhyb14CN
RGAgGKiqW10bGvhCyEnhoNyzz0vuVdrlMb4SUeU77GIIRUlyJ67AvfeIf/sZsJcR
wzXxglIjyB8cidhsnLQrU8ZQfeJKLUwjtDm6VXGDqGCK5Va54ihi9rs8MwWN46b7
tO15kVVQkXU+t+JriDHPBgssRAbkZu1gEHgtgxzI2BDHc230OkBQzrIfpF0NeoyL
3VkiLE8hYbCNB4jbhTeegSYTKbtKwm2IF8FjYwYcWHzFwXminLg=
=wPqD
-----END PGP SIGNATURE-----

--MPxTR4P75puMUAMZP0HgA2KgvTvDaep4p--

