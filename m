References: <20200629180405.17671-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3dc90234-900a-6e41-25fd-9bb17b79dc16@...1227...>
Date: Mon, 29 Jun 2020 22:39:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200629180405.17671-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LWYd2b2WCkszcTCjvrwwGxEQFp44w4PZ7"
Subject: Re: [Openvpn-devel] [PATCH] Linux: do not change --txqueuelen OS
 default if not configured.
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
--LWYd2b2WCkszcTCjvrwwGxEQFp44w4PZ7
Content-Type: multipart/mixed; boundary="IIXIt3rt99YZFC5erIYKPfGNUlvw9ZtSf"

--IIXIt3rt99YZFC5erIYKPfGNUlvw9ZtSf
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.06.20 um 20:04 schrieb Gert Doering:
> Remove default setting of "set txqueuelen to 100".  This default dates
> back to the "pre git" times (before 2005) and might have been beneficial
> back then - nowadays, the Linux default is 500, and thus reducing(!)
> txqueuelen by-default can cause TX packet drops on the tun interface,
> and that's bad for throughput.
>=20
> This is a similar change to commit f0b64e5dc (remove setting of the
> socket send/receive buffers by default) - similar vintage of the
> existing code, similar motivation.
>=20
> Note: buffer length can be checked with "ip link show" (qlen NNN)
>=20

Acked-By: Arne Schwabe <arne@...1227...>


--IIXIt3rt99YZFC5erIYKPfGNUlvw9ZtSf--

--LWYd2b2WCkszcTCjvrwwGxEQFp44w4PZ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl76UWQACgkQFRhsZwKx
RFQnzw/9EeTTlrSn93kk3Q0Zfj4d+UcX+v6Nd2agjwc3x1gF5itmW46d/u8cWnU9
JVNJ/REHCC0Gi86TjSmcvs7JEJgOT95M0MQQiC6bt/Qy+mhG6OVxT8UTIfC4LB6x
D4AVIN/IrW60pRwbWyUwxN1HrI3rl3m9GrOxRIfYlY7Z85IvZROHA9P+lGSxljH8
fbJk9Q4XkJ6VRdQ9eP4TvKpcONbkPvXwN8CmNghrWrpXpgYeQP5LpM6av+SYp1b8
LRd7izMbwfS7wRHPndhUhbROeswI2t2DgK3x4y4rPyxF/FaK3PUZn25BFn1yGpsx
vcKierZJ/d983H5sjA/9bixhDHWgO2THmugtsM0H3dpzmIm5rcIngyuqAuqDFC63
x3c30RZINlUx6NWhPZRK+QdFQ2t/0//5tUIRnSXwuzSAxUsNJU5lrAoEFkSTIEjW
4mDZsE1Vp77DiCrortEVJuNs5Ndcd0RLBs9/iY4mFyVoKkC2qXT/W2rgT4aDfOyr
KIu+cUrf0wI3K4ShiEsDrXFuC05Xz3bCQAnd/okcf1C5wX6nsAPOTlULn611me7E
qvFAhGpJ3d3+TfmBMsFDDhEfJ6A6bNgTBgNeys3kOJSb3ga4VU1ufaJofDTUK3x7
+PiQoMdv+UV3Nm4wXj77LISnzLI3AIJKs+xR/QuU7A1mG91USBg=
=pv0V
-----END PGP SIGNATURE-----

--LWYd2b2WCkszcTCjvrwwGxEQFp44w4PZ7--

