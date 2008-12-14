From: Bernhard Fischer <bf@...1168...>
Date: Sun, 14 Dec 2008 21:41:11 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1837827.q4624PlBbr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200812142141.17156.bf@...1168...>
Subject: [Openvpn-devel] TUN/TAP Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--nextPart1837827.q4624PlBbr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm working on a project (www.abenteuerland.at/onioncat) that needs a TUN=20
device. I'm now trying to port the software to Windows (Cygwin). There's=20
no /dev/tun but I know that Openvpn has a Windows-TAP driver.

Since hours am I trying to build openvpn on Cygwin to get this tap-driver=20
working but I don't get it.
I found out that it seems to be necessary to install the Windows XP DDK and=
 I=20
installed it but I still don't know how to build this TAP driver.

How do I compile and install the TUN/TAP driver?

Thanks in advance,
Bernhard

--nextPart1837827.q4624PlBbr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEcBAABAgAGBQJJRW9oAAoJEB2of8NcX/1HvbMH/iuwGGonPGcNXZ8p1Y51PnPU
V0ifvwA++hc8MvI3QiC9A9ynVxGG+8w7mDsI4QKteba5oknxeIhBt0kZmMFXsD7r
8ikq3Ni+iw5ypoYZpH7sfLpoJ2Rq6gzbyXF7PF7V0kyHzU1J403G9znXwGjAQzOk
/0eyQ3+sg/tkbzuOtYJpylXib4S7/BiKyE7xC56hyuOi4unHjDFx45Io3veRyzNu
Yas6YChcy9nqjfaPpJnythNWmApmUgs4O2QYKj3iqw0CQBU2pYsMP9kembdKCz6Y
3HpGa0D7WiFSwssm2K4Wur6goNU7zZV3BeX318A0s6C7wHlGabI1VTGi1Lr4Aqw=
=aOyu
-----END PGP SIGNATURE-----

--nextPart1837827.q4624PlBbr--

