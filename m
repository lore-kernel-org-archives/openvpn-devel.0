References: <20190409143438.25348-1-soltys@...2503...>
 <20190409143438.25348-2-soltys@...2503...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e6c17503-b1b4-7bba-e03e-3a8c8b6565e6@...1227...>
Date: Wed, 10 Apr 2019 10:24:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190409143438.25348-2-soltys@...2503...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BkiwJTkAFigkblxBSoNB5l5qZXLYgeGnC"
Subject: Re: [Openvpn-devel] [PATCH 1/1] man: correct the description of
 --capath and --crl-verify regarding CRLs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michal Soltys <soltys@...2503...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BkiwJTkAFigkblxBSoNB5l5qZXLYgeGnC
Content-Type: multipart/mixed; boundary="IPzj4Z1kmuu4I5yoceBLTh8jLksYXzBzT";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Michal Soltys <soltys@...2503...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e6c17503-b1b4-7bba-e03e-3a8c8b6565e6@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] man: correct the description of
 --capath and --crl-verify regarding CRLs
References: <20190409143438.25348-1-soltys@...2503...>
 <20190409143438.25348-2-soltys@...2503...>
In-Reply-To: <20190409143438.25348-2-soltys@...2503...>

--IPzj4Z1kmuu4I5yoceBLTh8jLksYXzBzT
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.04.19 um 16:34 schrieb Michal Soltys:
> The man page states that when using --capath, the user is required to
> provide CRLs for CAs. This is not true and providing CRLs is optional -
> both in case of --capath as well as --crl-verify options. When relevant
> CRL is not found OpenVPN simply logs the warning in the logs while
> allowing the connection, e.g.:
>=20

On my server the connection used to fail without CRLs. I just retested
this and with OpenSSL 1.1.1 there is not even a warning, so I am really
confused now.

Arne


--IPzj4Z1kmuu4I5yoceBLTh8jLksYXzBzT--

--BkiwJTkAFigkblxBSoNB5l5qZXLYgeGnC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlytqEIACgkQFRhsZwKx
RFR0Eg//b4FT234Kt7X7/jAej3mlkrJPleD5unAQvnIsiFNW7jsp2KqdEKdMek1W
vqWY9FzDtY2cmM8ad6GiR0n9zuZvRPagweBljQ5NziS5ZguHNKtUFqnkAKJ548HD
lfAJSvA8HJA4CDwKPZ4mZdS2BijEAuhc2+qvjGHzIziAwLo5BxRjNCvVFR71TI7M
7791DjP5ka/dAKB1vgCOPCli9bju5RH5qclz1+Oif36KwJy07Ya4uFO29fxVpvlN
uaykALId/6u5Yn6aAeCiIOL3vZPk3OtRwUsMgUmHqvShyWFcmbQXFeDUwdjt+0bk
PKGptQN1KFaoAjccAMednNMz46u27qC0QG0QqIAKE702SvSw4Vxv1zt74VdpNXe1
lQLgp6bwA5+Y4xGEPH9yK7J0N+wyZVsQY0qJcX5ICavu96/TU5YP/GXIYuFwzHK8
3mWj23PM8J82BxzpxF0wi8n1gwLrK2ubAWoHilqIfTRN0VjUUQPS2emcTxPOPoT6
IdCr1I5Ihl2GOYUJdfJurVW3eVMBf4UyoJ7OsEK4ZfUO6bt8IA+YqavBjXE9YNIC
ZV8QCmIu9fp7eJoGOrJLJXd58pkjmiZRggJrIDK6EimE+Sq2EZXpJ2vJcof+0ae8
5ze6gb9TbKVQcTg96qunk5K2pNhpxAMQ3UQcwNTspWfvj3ZSpsM=
=Mk2D
-----END PGP SIGNATURE-----

--BkiwJTkAFigkblxBSoNB5l5qZXLYgeGnC--

