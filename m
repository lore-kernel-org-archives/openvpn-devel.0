Message-ID: <53450887.5060703@...1227...>
Date: Wed, 09 Apr 2014 10:44:55 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <5343BCAB.3040102@...1790...>	<0LikyX-1X9YfO48dR-00d2sy@...1825...>	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>	<5343E392.1010803@...1800...>	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>	<5343FF41.3080406@...1879...>	<5344111D.3080408@...515...>	<5344145F.3010702@...515...>	<53442B8A.2030105@...515...>	<CAFHpkQE-6kqi+RT4oF_F+4YULRd=NtJ3rCNK-YR+JrGM47s-sw@...278...>	<53450525.4010704@...1227...>
	<CAFHpkQEuf35w0CuEDvYrRARZR2-vmcZQAh6eA=8q=XkdertD-w@...278...>
In-Reply-To: <CAFHpkQEuf35w0CuEDvYrRARZR2-vmcZQAh6eA=8q=XkdertD-w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cn4keCpVUfJV9RcoERLw6DrplHRXBrJuf"
Subject: Re: [Openvpn-devel] Heartbleed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cn4keCpVUfJV9RcoERLw6DrplHRXBrJuf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am 09.04.14 10:32, schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD:
> I used to think that client without "nobind" option binds to 1194/udp
> (we encountered that issue with multiple openvpn connection on the
> same machine), so, "nobind" tells openvpn instance not to bind to
> udp/1194, and so, only openvpn server can exploit heartbleed
> vulnerability, but not any attacker.
>
Yes the server can attack you. Or any man in the middle attack including
ARP spoofing/DNS spoofing etc.

If you see nobind that as protection basically you don't need a VPN.

Arne


--cn4keCpVUfJV9RcoERLw6DrplHRXBrJuf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNFCIcACgkQe8+cMNS4zRdphgCgrx5YpiaQlYl+0n9xOvWvRrWY
dcoAnRkecePaGKOcbLfacgqC5YnRrWpb
=Lz9m
-----END PGP SIGNATURE-----

--cn4keCpVUfJV9RcoERLw6DrplHRXBrJuf--

