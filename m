Date: Sat, 16 Jul 2011 19:16:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110716171656.GY8496@...1296...>
References: <1312f1908b4.-8162753897021314559.8311264442879771774@...1486...>
	<1313210dc57.-2479533967587045360.2173550128923027198@...1486...>
	<13132141bbe.-6554633753716236145.-6995683147743455020@...1486...>
	<20110716100908.GX8496@...1296...>
	<131329a1c4e.-7251372065913038672.6406239187025865679@...1486...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="09NQ3WWIOaov9Ws2"
Content-Disposition: inline
In-Reply-To: <131329a1c4e.-7251372065913038672.6406239187025865679@...1486...>
Subject: Re: [Openvpn-devel] Fwd: Re: OpenVPN on OpenWrt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: lancebaynes87 <lancebaynes87@...1486...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

--09NQ3WWIOaov9Ws2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 16, 2011 at 03:59:45AM -0700, lancebaynes87 wrote:
> yes, really sorry for posting to the devel-list, I already posted on the =
users+forum.
>=20
> So the problem is at:
>=20
> /etc/openvpn/server.conf
>=20
> in the:=20
>=20
> server 192.168.80.0 255.255.255.0
>=20
> line! wow! :) thx. ehhh.... what should I write to get it work? :O

Find a network number that is not in use at the client or the server side.

server 192.168.81.0 255.255.255.0

might just work - we don't know your network setup.


How do you access the Internet?  Is there another router for "Internet"
(if yes, it needs to know that it should route the 192.168.81.0/24 to
the OpenVPN router)?  If the VPN and the Internet access is on the same
box, you need to make sure that 192.168.81.0/24 is properly NATted
(which *should* be automatic on the WRT, but check with=20
"iptables -t nat -n -L")

There's lots of doku in the secure-computing wiki on this, like:

http://www.secure-computing.net/wiki/index.php/OpenVPN/Routing

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--09NQ3WWIOaov9Ws2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTiHHiKkuBuNlUUl1AQIGYgP/WZOI3IWwz3KJtLOGM+mHlfAwlGXxSo7b
WY9/yrxO4TOIzJbnuIccb+/4hwkeBJsjd4GLUiL6mZQEheNaHf3bZutq5rRNx0Vy
kMpc7MPU2mAxUMaKTWJdwsMmuMObwLPBJJBlSSv24UOTuI0ECPirLwRculjqX6bB
nAOD4v+xUnM=
=jxLQ
-----END PGP SIGNATURE-----

--09NQ3WWIOaov9Ws2--

