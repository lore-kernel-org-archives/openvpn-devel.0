Date: Sun, 5 Feb 2012 14:16:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120205131601.GA26602@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
Subject: [Openvpn-devel] OpenBSD platform cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as promised :-) - it now passes all my t_client.rc tests, and smells
a lot less funny.  We now might even throw out all these weird
#ifdefs from tun.h...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTy6BEakuBuNlUUl1AQIMVQQAgKHzNXbumnvT5KGvcNdW/kADcjpuSIt9
LDKTYBST3K7hUxue/ltjSkVX/NDlnJpg0qoqFmI7da4p8s9wHQyXNRukEHeGWUql
3gFMEK8opqTvXS1rGNsr20Qv6koVkEbcjVange32F/f2dn3bQCYUkXZea50MN7cB
gKxclQF0HJc=
=gztE
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

