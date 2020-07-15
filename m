References: <20200715113132.22754-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3fe215e5-f747-34bf-9268-b70a3a54bc00@...1227...>
Date: Wed, 15 Jul 2020 14:00:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200715113132.22754-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2Lsmsex1Htz1FP7P8f6JAdAWjSfnNhG2B"
Subject: Re: [Openvpn-devel] [PATCH] Fix environment variables for
 p2mp-assigned IPv6 addresses.
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
--2Lsmsex1Htz1FP7P8f6JAdAWjSfnNhG2B
Content-Type: multipart/mixed; boundary="jSMZH3mddWXyZgv8fi9Ls2aZbNcSPug5I"

--jSMZH3mddWXyZgv8fi9Ls2aZbNcSPug5I
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 15.07.20 um 13:31 schrieb Gert Doering:
> commit a8f8b926718 introduces $ENV{ifconfig_pool_local_ip6} and
> $ENV{ifconfig_pool_remote_ip6}, but instead of properly setting them,
> the code overwrites the IPv4 variables, $ENV{ifconfig_pool_remote}
> and $ENV{ifconfig_pool_local}.
>=20
> Trivial fix.
>

Acked-By: Arne Schwabe <arne@...1227...>


--jSMZH3mddWXyZgv8fi9Ls2aZbNcSPug5I--

--2Lsmsex1Htz1FP7P8f6JAdAWjSfnNhG2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8O79wACgkQFRhsZwKx
RFS4bhAAlgLP14G9qzSp1N/v58jh24rHfzrbO0jIjob/1zvTSatMp/7uEivBXvgG
hBwQWAZ0c11Dby71kdDPgpU2OGBk0iD4xpAy0X75jJ1lt72uKWTdzjCpd4xuHN5u
jGRiuyIuJi4ytiSPV108FuX192Dm9x8hAC2Oxi4nxmSfVKx+95RXj+0jrPqzDwpO
YL8WCW1cjccjZ7bkE5PERYy/lps6tMbC+GTlhM5eecRDQXrhV7mrp+nj/6KjEez9
nm8cvJ7rKYTQwAF9+djZeetR0uGSo0KSJlPc0OW89OxV1EvoSdK29XojB5c6iPQf
Q9OFohwk3dyZUObbG7PGC/jXkYEh9t+Lqpv4A2hrsUOPnYCc/ATrqmPEM0hJg79z
fpg3umtVvmJ/1Xx6h3xZ66DSHMVgMJGk5bBZCqZnIPHZEWlQGhApvtGNFb3OXfc2
q9gWJqoD5+tkyM4JK2vdiXlhY7t2rDVLGuG6Hvh6vFotH6EhsaoUu0S17YtRipWP
1iqG2YGFV+uridCdLna1SY+7l/sqB+9rRlBC0LDjgRrV6DhoOFmyEUSd1lc+dxIA
NP1bkxzzclbmvFZ1gJqwOpmUW66mR51CA8AGiiH6nIyzGwwhba3u5xzUVcSn6toJ
qrhaVowluIv6N+vL9G1M/hrRs0AZeT93Mw68Fv3LMoqZAmGHfSM=
=hvjz
-----END PGP SIGNATURE-----

--2Lsmsex1Htz1FP7P8f6JAdAWjSfnNhG2B--

