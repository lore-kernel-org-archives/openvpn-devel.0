Message-ID: <530259CD.4030104@...1227...>
Date: Mon, 17 Feb 2014 19:49:49 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1391000624-15092-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1391000624-15092-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="F2iwC0DSmGFsLgnfXMDor1Ke2CejBRqpm"
Subject: Re: [Openvpn-devel] [PATCH] grow route lists dynamically
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F2iwC0DSmGFsLgnfXMDor1Ke2CejBRqpm
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 29.01.14 14:03, schrieb Heiko Hund:
> This removes the need for the --max-routes option. Instead of
> allocating a fixed size array for the route(-option)s they are
> managed in linked lists instead.
>
>
ACK but with two changes

- adding a comment to the copy method that this does a shallow copy with
two lists with the same tail
- struct route* next should be struct route_ipv4 *next in the route_ipv4
struct.

Arne


--F2iwC0DSmGFsLgnfXMDor1Ke2CejBRqpm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMCWdMACgkQe8+cMNS4zRdisgCgsidXdqwOBRKxIupgAw3TSyfv
50EAmwb3mIL9AHQhCU1Sa5M7XvBrRudt
=c8A+
-----END PGP SIGNATURE-----

--F2iwC0DSmGFsLgnfXMDor1Ke2CejBRqpm--

