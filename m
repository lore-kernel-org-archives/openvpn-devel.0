References: <f57a2e41-3243-b6ee-aebc-3be050e4e660@...1856...>
 <1548101094-4449-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ac02a60e-d3a5-8833-9adb-ca02f2d0c711@...1227...>
Date: Wed, 8 May 2019 16:19:21 +0200
MIME-Version: 1.0
In-Reply-To: <1548101094-4449-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v6UlufF9Ys71SBIRXgstlG8iBPs7TedIO"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix broken fragment/mssfix with NCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v6UlufF9Ys71SBIRXgstlG8iBPs7TedIO
Content-Type: multipart/mixed; boundary="DTW9K7BnBQ6msSwfPKWtOTnpCCwXth2IU";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ac02a60e-d3a5-8833-9adb-ca02f2d0c711@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix broken fragment/mssfix with NCP
References: <f57a2e41-3243-b6ee-aebc-3be050e4e660@...1856...>
 <1548101094-4449-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1548101094-4449-1-git-send-email-lstipakov@...277...>

--DTW9K7BnBQ6msSwfPKWtOTnpCCwXth2IU
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 21.01.19 um 21:04 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> NCP negotiation replaces worst cast crypto overhead
> with actual one in data channel frame. That frame
> params are used by mssfix.
>=20
> Fragment frame still contains worst case overhead.
> Because of that TCP packets are fragmented, since
> MSS value exceeds max fragment size.
>=20
> Fix by replacing worst case crypto overhead with
> actual one for fragment frame, as it is done for data
> channel frame.

The change looks good and is tested.

Acked-By: Arne Schwabe <arne@...515...>




--DTW9K7BnBQ6msSwfPKWtOTnpCCwXth2IU--

--v6UlufF9Ys71SBIRXgstlG8iBPs7TedIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzS5WkACgkQFRhsZwKx
RFRBeRAAox2OB3mXTjLz9UyPDIY60ZZRfr89B6aDnUeqnJFqm0QGkcELoO98arQc
vNTsBtIx4vIQ/YbnQuqzYN1AZ5waTLJ84L1cWFEJxXywUpz3F1WyoHw5gL66Jrfk
6a2K+LDvS4cFjWyvekjbpc7qGGHKTHcuWWZlWCu8BfZx11jL1AC/rYkzQfNh3oFF
/NH6Mo1eDIvb4PtUraGU0JAeXAZ6QnykPh5TliXxgPytLY0IS3ujha0ksxZbwNKW
7yHlyc5OFDs0YKKzXHnkAouy2ZvOA3Kp7LbfbA+GA/JIxoEEIDNPc+LaMThDmSb6
xeDwv0zhvKe6jZMPqInQXa2aS4Y0WQ2nuZh85dCap3XC/TLPoW+HP56/YII2Rd4X
LF0UoFnQJCrNptPlLFUTq1vOTIUV9bRPyI9HpVWsU3l9op/YlDX0lhIdcpq+3j5B
rEIFM9KABS3yDYyz70voraqliUgdVeeSDqyxXSPWXaotUrgQ8tzzQFxKVzRq5I/O
TIYeHzE0Z+LhKhf27zYhPGdXq5RkbcSV6MkYNNcWrnpexdzTcYQYOs9s/6fDzyPL
gla5w01tRrouE3ea4d+FbIDiIuzGcqh5EjjlZQofjH16YdvGay8NKA0sAS47rxCK
HyoCm7N2Ft+aMGjaHuPR7IejhzAK4GejcO1xdOg8k+c/DzxGGBI=
=Q5VU
-----END PGP SIGNATURE-----

--v6UlufF9Ys71SBIRXgstlG8iBPs7TedIO--

