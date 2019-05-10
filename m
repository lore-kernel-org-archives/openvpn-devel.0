References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-6-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8d4d0f1a-e9dc-8f3a-43a4-7c8d48d909c6@...1227...>
Date: Fri, 10 May 2019 14:23:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181219050118.6568-6-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ARMAXYM9xu7v13uLY6wbvcNuZ8lycyMA1"
Subject: Re: [Openvpn-devel] [PATCH v3 5/7] route.c: use sitnl to implement
 get_default_gateway_ipv6()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARMAXYM9xu7v13uLY6wbvcNuZ8lycyMA1
Content-Type: multipart/mixed; boundary="ceZ2TdlIt6IlYCu6GcKhz6w8X1njGdP19";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <8d4d0f1a-e9dc-8f3a-43a4-7c8d48d909c6@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 5/7] route.c: use sitnl to implement
 get_default_gateway_ipv6()
References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-6-a@...2181...>
In-Reply-To: <20181219050118.6568-6-a@...2181...>

--ceZ2TdlIt6IlYCu6GcKhz6w8X1njGdP19
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.12.18 um 06:01 schrieb Antonio Quartulli:
> get_default_gateway_ipv6() has always been implemented using
> netlink, however, now that we have sitnl, we can re-use the
> latter and get rid of the netlink code from route.c.
>=20

Acked-By: Arne Schwabe <arne@...1227...>


--ceZ2TdlIt6IlYCu6GcKhz6w8X1njGdP19--

--ARMAXYM9xu7v13uLY6wbvcNuZ8lycyMA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzVbT8ACgkQFRhsZwKx
RFRwYg//WwDVhzM8yBROICMO7EovLpjXsfh27HXBuquQWEkq2Pmt0f70I8GPRmNl
cMpaEDbTu5q9rftXWLuxU3hZ3osqlANe133U46AYmMc0+awVJh8OhxAHSZGlaHV+
45bC/Jmlullun1tNbZPbyc9juijJgDpbo/MG2ZwCBGklZv4OYweaT75UPMcnTwA9
K1TrA2WXQk6MMPVRpj/ltEVOBJRnSn9Medu1Wkt0hNoX4iDzyurFhyh0CI0sDdXv
EJJY8WXNwDFd+/1HIlyPvE/UMKvJzsIu59xadOvGl++zbBYHxLs/n+XBJ0+hsznA
M6DerdPWF6L5XRdsZJ0VpHSj5sHHBl9TcC+JnhZoyFs4w27K0vUw4Q+tUklNqFnd
p5dcALkEz/iTpOoud+p6NFydQI57UPC4rgcpicR5pESSD3DvRxlNdoATK1kubP2l
NSpOkTO/77PECUrIQb8dpMS/YUSm8tXzwRKfz9dMA6BjFtQ4pRDfDUjLJR0v1kS9
BTgCk5fcmZHmCcKeUFUnU5KowNHI6p6N5KJm3mAf3enZbZajbqXzgxK/+iA9Q2y5
UnNRzBTelERCWERIHKLGE+lrZdMRZs/aJRnEq0NA5VKGQB94hvEN3CI1gyIW9Exl
3vHEP/cYYXOITqGCwW/Epo2MIXPdUT/X5eDC6e/2GVx0wevdl7c=
=S1ms
-----END PGP SIGNATURE-----

--ARMAXYM9xu7v13uLY6wbvcNuZ8lycyMA1--

