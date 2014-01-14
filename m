Message-ID: <52D5A4A6.2070101@...1227...>
Date: Tue, 14 Jan 2014 21:57:10 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20140113185822.GV226@...1296...>
	<1389650074-18455-1-git-send-email-gert@...1296...>
In-Reply-To: <1389650074-18455-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wjXfa0GDsfMvv5XFpfHMqPGSp3JIH1rKC"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Rename "struct route" to "struct
 route_ipv4"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wjXfa0GDsfMvv5XFpfHMqPGSp3JIH1rKC
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 13.01.14 22:54, schrieb Gert Doering:
> To fix trac #340, we need to rename our "struct route" to avoid a
> collision with "struct route" from <net/route.h> on *BSD.
>
>
>=20=20
ACK.

Arne


--wjXfa0GDsfMvv5XFpfHMqPGSp3JIH1rKC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLVpKYACgkQe8+cMNS4zRfbjACeL7G0EuUbWjc/gwog/b46b2Tp
uwEAnjVxBHRdgTKxWpuLBKdLw4Es9LNZ
=DnBG
-----END PGP SIGNATURE-----

--wjXfa0GDsfMvv5XFpfHMqPGSp3JIH1rKC--

