References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <518ceb3d-e060-f777-f19f-4998b8d27170@...1227...>
Date: Sun, 12 Jul 2020 02:05:25 +0200
MIME-Version: 1.0
In-Reply-To: <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rc6YRgulzg3WTxevLfxmH4CrXv8EJb2Tv"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rc6YRgulzg3WTxevLfxmH4CrXv8EJb2Tv
Content-Type: multipart/mixed; boundary="DQqRqKmMnPpD7YiZoVpsDeCe2uf6NtEgt"

--DQqRqKmMnPpD7YiZoVpsDeCe2uf6NtEgt
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.06.20 um 11:12 schrieb Dmitry Melekhov:
> 23.06.2020 13:02, Gert Doering =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>>
>> That patch is from Steffan, and review has been sitting in my lap for
>> way too long.=C2=A0 Need to see if it still applies.
>>
>=20
> Unfortunately it is not compatible with 2.4.9, because of introduced
> change...

Can you test with current openvpn master if that works for you? That has
now allows you set the --cipher in ccd/connect-client scripts.

Arne


--DQqRqKmMnPpD7YiZoVpsDeCe2uf6NtEgt--

--rc6YRgulzg3WTxevLfxmH4CrXv8EJb2Tv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8KU8YACgkQFRhsZwKx
RFQS/g/+OYBRzR0vdu03Bx996CSbIKaEWD+XbedvKEUoDkRKz8FNh6+RAHgQg+Tv
eWvmg4y62J2MLohG8lFTj+yHS3GZFEbVPddnKaJ8eJpcxRVAvIgZ2Q2iZRUDJpGl
oRhSAS0weYkjqxIcX8/NzW0hBHMPRV+ZBfFL0iAyBJGOyR/QN+QaeiKpzlV4USeC
0oPSuVX17IXZI3EosASoF5+gNU03j4vM7nZ89K3FLm0WRBPAOlpZ2bjCi1+Fx4l+
aAyxwlQ73JDvSxkEJjNEMe8RM64EFYyF0KIPs2svNV0zZNZK2OFpP2OfsXgjn9fs
4UPr9tBgoqWtYSsNSq2Xj2btDCsp17ESnSl9XtjRiswfepAz6BtOVvPuKuP8u2nq
gF/KCydIJDLvNNGZW/Ea1oR69DmcsVijqCUJSEuZ5kXfOfTUbSqE43CFrwvKh7cG
JWLOIsZ58jOw92z7MMb9xOHiuBLn/6J3kZbbfN3jvH4PsuEsh5Ixv9VcK0t+/bqp
zjtFc/3oEsvp9wPDHHqtxkDwwJJG1ClJWmsrrBYYqSSu0a76BXvru+8b2eHciuW9
D8WbIcT1kHfoyoqdaTPO9lqADZx6ZvgNNafnPzzMujkdF2M4hU30CQzhUkugRKzi
ESRKHVxhAznu+oXixfS8tptH4Z/J7jdguvMbXX4DOyZya8u+lrg=
=B9Xx
-----END PGP SIGNATURE-----

--rc6YRgulzg3WTxevLfxmH4CrXv8EJb2Tv--

