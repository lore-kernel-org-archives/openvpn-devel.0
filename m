From: "Daniel O'Connor" <doconnor@...351...>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4737500.oTarEa7rJ0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502101302.31213.doconnor@...351...>
Subject: [Openvpn-devel] OpenVPN patch to load tun/tap dynamically
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb  9 18:33:31 2005
To: openvpn-devel@lists.sourceforge.net
Cc: matthias.andree@...83...

--nextPart4737500.oTarEa7rJ0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I have a patch for OpenVPN to attempt to load if_tun.ko/if_tap.ko when the=
=20
first open attempt fails with either ENOENT or ENXIO. It's FreeBSD only at=
=20
the moment but I imagine it would work on (at least) NetBSD and OpenBSD too.

http://www.gsoft.com.au/~doconnor/openvpn-kldload.diff
MD5 (openvpn-kldload.diff) =3D d9c6da637d7f4079751c2f19b093408f

--=20
Daniel O'Connor software and network engineer
for Genesis Software - http://www.gsoft.com.au
"The nice thing about standards is that there
are so many of them to choose from."
  -- Andrew Tanenbaum
GPG Fingerprint - 5596 B766 97C0 0E94 4347 295E E593 DC20 7B3F CE8C

--nextPart4737500.oTarEa7rJ0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (FreeBSD)

iD8DBQBCCse/5ZPcIHs/zowRAsD7AJ9Jom0liL5CCsHZqcsiiUoFZuNHBwCdHBcm
jVj7ME2lS5S9QwHTpJfMrPI=
=YodU
-----END PGP SIGNATURE-----

--nextPart4737500.oTarEa7rJ0--

