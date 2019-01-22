References: <20190119103028.12497-1-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <69d79849-cd27-60f2-c98d-95ee1c09c91b@...1227...>
Date: Tue, 22 Jan 2019 16:31:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190119103028.12497-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Bfg4w2KQeBbcqwqjDJSlPH9BjcIlGTbpu"
Subject: Re: [Openvpn-devel] [PATCH] Fix tls-auth/crypt in connection blocks
 with --persist-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bfg4w2KQeBbcqwqjDJSlPH9BjcIlGTbpu
Content-Type: multipart/mixed; boundary="HNU7mmJLtJd06VbnYykBYDTbl5Ik9t2IE";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <69d79849-cd27-60f2-c98d-95ee1c09c91b@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix tls-auth/crypt in connection blocks
 with --persist-key
References: <20190119103028.12497-1-steffan@...1856...>
In-Reply-To: <20190119103028.12497-1-steffan@...1856...>

--HNU7mmJLtJd06VbnYykBYDTbl5Ik9t2IE
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.01.19 um 11:30 schrieb Steffan Karger:
> If --persist-key was used, we would always try to pre-load the 'global'
> tls-auth/crypt file. That would result in using the wrong key (leading
> to a failed connection) or en error is there was to 'global' key:
>=20
>   Sat Jan 19 11:09:01 2019 Cannot pre-load tls-auth keyfile ((null))
>   Sat Jan 19 11:09:01 2019 Exiting due to fatal error
>=20
> Fix that by loading loading the key from the current connection entry.

Acked-By: Arne Schabe <arne@...1227...>
This also changes the logic to be similar with the other logic used in
the function.

Arne


--HNU7mmJLtJd06VbnYykBYDTbl5Ik9t2IE--

--Bfg4w2KQeBbcqwqjDJSlPH9BjcIlGTbpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHN1IACgkQFRhsZwKx
RFTNzA//UsL0bUVDJkYW8usi9T7pdM5JwpJp6k0s6hhFSmygoK7Nc0SyBja4Xk1D
EmZ7RaGnx7tz2jjSZIZdJcArqG4Ge7S22qe52Xm/8v6rz/jq0UUJm9FHvDyt6wwW
BvbCN2fvOci+ZanLPn+FWQNj4aBWtEUN3oTZ4g1w98PwMNOiie6YKPzUzEjM2SbD
idAF2/FCCUsFHiWRwrke8PWnE+XqViKBfZ/riH3uicpq4mlnpcSSj6wBDUHVsVp3
xT5NuKqQrvS9f5CVgidTMgwWPiEim9CPTLUIepmwzMrfCSK5phjy0ZfrnSZddUdh
EiMNkeah7Ynh/bWRzv0KutpEFm61kHcHDWNR7wczGdJtDkHdUdvlUYbBJYpwdGac
dnn1GB4rs0m3DbNcEreiiSnUFhUzOVGTQjKI8qCviH6EhSu6nRkslY0ZQ3ly8NWH
1r2XO1CAxzTwnYa+6N82hht3lzt+ujgeZOcr5Kyb93qUZSeC1tAnYtV/QtY16XZe
KTENlXhMiU/2r754aWpo936TwWSmIMpRbt8za330xVYrnr5GJ+OliJolt/eALu/g
R4hlvqoUK+FGIr20dyz12R/eY+I6LGd+ir9QlcMyAMJ4nXnIzAzxL+H3n06F3TX0
rakBK4d+Ra3TLsMv5xycIVsahBybdd8WnIsSYyNna5fc3hS6BbA=
=3asO
-----END PGP SIGNATURE-----

--Bfg4w2KQeBbcqwqjDJSlPH9BjcIlGTbpu--

