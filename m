Date: Tue, 4 Mar 2014 20:56:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140304195628.GL16637@...1296...>
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nx+rBAYAOiVz+Rkd"
Content-Disposition: inline
In-Reply-To: <1393929449-423915-1-git-send-email-vvk@...1868...>
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Vladimir V. Kamarzin" <vvk@...1868...>
Cc: openvpn-devel@lists.sourceforge.net

--Nx+rBAYAOiVz+Rkd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 04, 2014 at 04:37:29PM +0600, Vladimir V. Kamarzin wrote:
> From: "Vladimir V. Kamarzin" <vvk@...1868...>
>=20
> When working in TAP mode, openvpn at server side maintains mapping table
> "MAC" -> "client". It needs to know what MAC belongs to what client to
> be able to forward traffic.
>=20
> Before this change extraction of MAC addresses was performed only from
> ethernet headers of packets, coming from the client. This patch
> introduces extraction from ARP packets.

Feature-NAK from me.  If you want to play ARP tricks on the client side,
do it right - keep the ethernet source, or change ethernet source and ARP
source, not change the ethernet source but forward ARP packet unchanged.

There is too much special case code already that nobody is able to=20
maintain and properly test(!) for future builds, wo do not want to add more.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Nx+rBAYAOiVz+Rkd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUxYv7KkuBuNlUUl1AQJgMAQAqrtBud0I8ORwQOdelzz1Udrd03af+emc
mcfagP2rRjgzTD9+4AtoFfjM+hbVJEFeemKh0RuNnal8tdWP8OfgeSnzRQ8XYhjQ
sEnAYZA82/9RpMYcXleJV5KEbit++lQXqeXo0ciOpSlTFlVt6CcWg56YHYqOecgf
WVhs2uhDPVo=
=im82
-----END PGP SIGNATURE-----

--Nx+rBAYAOiVz+Rkd--

