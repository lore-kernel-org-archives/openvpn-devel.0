Date: Tue, 12 Jun 2012 15:29:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120612132923.GD1059@...1296...>
References: <4F333427.70808@...1388...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
Content-Disposition: inline
In-Reply-To: <4F333427.70808@...1388...>
Subject: Re: [Openvpn-devel] route-ipv6 parameters & route prefixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michal Ludvig <mludvig@...1388...>
Cc: openvpn-devel@lists.sourceforge.net

--uWbmMdDzzl2TXAgx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 09, 2012 at 03:49:11PM +1300, Michal Ludvig wrote:
> I'm used to pushing route options to the clients with explicit metrics.=20
> That works good for IPv4 with e.g.:
> push "route 192.168.128.0 255.255.240.0 vpn_gateway 200"
>=20
> However route-ipv6 doesn't accept the 'vpn_gateway' keyword and=20
> therefore I can't easily set a metric.=20

If all your clients are Linux or Windows, you can "sort of" do that=20
today already with 'push "route-ipv6"', specifying an arbitrary (but=20
valid) IPv6 address as gateway address:

  push "route-ipv6 2001:db8::/48 2001::1 200"

This is a side effect of the way we currently install IPv6 routes on
platforms that can do "route to interface" - the route always points
to the "tun" interface, and the gateway spec is not used.

"metric" for IPv6 routes is currently implemented and tested on Linux,
but not on any other platform yet.

What client platforms do you need this for?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9dEM6kuBuNlUUl1AQLROwP/cNJ7t3xkQqrtILiGixSgdZ+ok51+BzTS
VrjMEeIn+w20kOpkHoB71Iu+b/QqmRjnY+AEg+IeJkePjNrMY7J66UxVu8lbi9Ly
wbVV+zZQWuQef9OvHZmzuS4fpPKLXsbLDEusoqfP9JSFUMy+7WtzBEpfRLz2QEuo
O9MF32DTjew=
=d7Bz
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--

