References: <20190119103028.12497-1-steffan@...1856...>
 <20190119103400.12887-1-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c71f7c3a-461c-5d1b-2894-b13e3e05da3e@...1227...>
Date: Tue, 22 Jan 2019 16:32:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190119103400.12887-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HWgXWRJMrYjMplvoUzvpQ13HlAVeRhJPd"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix tls-auth/crypt in connection
 blocks with --persist-key
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
--HWgXWRJMrYjMplvoUzvpQ13HlAVeRhJPd
Content-Type: multipart/mixed; boundary="CYbrezgDrJmr5XcMjhPkqfcpIxoEH8oFN";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <c71f7c3a-461c-5d1b-2894-b13e3e05da3e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix tls-auth/crypt in connection
 blocks with --persist-key
References: <20190119103028.12497-1-steffan@...1856...>
 <20190119103400.12887-1-steffan@...1856...>
In-Reply-To: <20190119103400.12887-1-steffan@...1856...>

--CYbrezgDrJmr5XcMjhPkqfcpIxoEH8oFN
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.01.19 um 11:34 schrieb Steffan Karger:
> If --persist-key was used, we would always try to pre-load the 'global'
> tls-auth/crypt file. That would result in using the wrong key (leading
> to a failed connection) or en error is there was to 'global' key:
>=20
>   Sat Jan 19 11:09:01 2019 Cannot pre-load tls-auth keyfile ((null))
>   Sat Jan 19 11:09:01 2019 Exiting due to fatal error
>=20
> Fix that by loading loading the key from the current connection entry.
>=20

Acked-By: Arne Schabe <arne@...1227...>

This also changes the logic to be similar with the other logic used in
the function. The bug is pretty obvious by just looking at the code.

Arne


--CYbrezgDrJmr5XcMjhPkqfcpIxoEH8oFN--

--HWgXWRJMrYjMplvoUzvpQ13HlAVeRhJPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHN3gACgkQFRhsZwKx
RFQfRw/7BcM25mwf6RLdTjKM6g2YEWTjlZRVVkZIs9VS1F1t+GJM7VSBQmEV9YY9
omZB5UAWqo5DlsbVWpiRzH+7t6v+QZYsWllVQTUA3oxjeTOprZKwKMk21e6zP1sV
1HFmRqJmkrBirsMlZNJsWoxxEwyrgoIuH806NgckuR7zenUB6sXhEusF2FlDR27l
y6L1MytKWHljHGKMn2V1+Uvyoa4qRSteTnJ4K3C4XF34OW3U7FWPSFC5hqSKtmQ0
aYNIyEnNi5xaLY+eOrSfw5hZJxKqKetmsKcEaTrU3qIx5e2K20FkY2fbF35TdDv+
0A967jNfWVgPbxQXGFVo1/irtAF2xsO84kwl4tLcLqpZSwiqPuhpHFCzQ+QyFZke
husGYl9ZEBWHJkaHnqfgU3vZwO6/d/8ut7kCJN7JoAcxkXuLABMqllHXNB119Lvc
qUxgHK3oIO5e7SNuEUIYO1hU/nLGW1JSMRL9NETVaKVSjwAPKnjL3/87GYmlBEDx
j0nqCPFAVqbJAHuOXhVtztkwHWDJNzX3NnRJBm8kYrMGKh1+s4ILxfesh1nSWNaS
OlNFeGW5e+gWrbmfyNIkl6K4mFvuqOtSwzJRteMFDoTj4UF3KXU33Ie8jtu7+p6+
gR/QWJeuN4iftP/oiSWEuZDsn81pqdVFxsmDc/E/4M8dUKaAwyg=
=aEMk
-----END PGP SIGNATURE-----

--HWgXWRJMrYjMplvoUzvpQ13HlAVeRhJPd--

