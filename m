Date: Mon, 31 Aug 2015 14:54:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150831125402.GX34798@...1296...>
References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
	<55E432F8.5040204@...1147...>
	<CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re7H+V5lQR2Zv/pu"
Content-Disposition: inline
In-Reply-To: <CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
Subject: Re: [Openvpn-devel] Disable TLS for mode server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Valentin Sawadski <valentin@...2062...>
Cc: openvpn-devel@lists.sourceforge.net

--Re7H+V5lQR2Zv/pu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 31, 2015 at 01:17:52PM +0200, Valentin Sawadski wrote:
> thanks for your quick response. I know about --cipher none options in
> P2P mode, but for testing with multiple clients I need --mode server.

"--cipher none" works in "--mode server" mode as well - that is for data
packets, while --tls-cipher covers control packets.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Re7H+V5lQR2Zv/pu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVeROaqkuBuNlUUl1AQIxuwP9HmkYvJGGHM/3K3XFO41zaMNmXquiuW/v
I5zXthK0WVkCs2nosu/PxpsvKEX6bp3wYOPjGYo/l+mNdWnaVHnFksOm2Ow8j2MC
seUiNyuQjuYDCBC9lzD9AVqaLBIy3pHr44zE/TVy61DbUj515fm18TedvGObXLWm
SrA0Fzbx/4Q=
=Cy7Q
-----END PGP SIGNATURE-----

--Re7H+V5lQR2Zv/pu--

