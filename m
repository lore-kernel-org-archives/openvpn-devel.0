Date: Tue, 6 Oct 2015 13:31:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151006113144.GX22054@...1296...>
References: <5605377D.9040401@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wr1Q/2bz0MCWWNYv"
Content-Disposition: inline
In-Reply-To: <5605377D.9040401@...515...>
Subject: Re: [Openvpn-devel] Help with build-testing a patched OpenVPN tree
 with Cygwin and Visual Studio?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--wr1Q/2bz0MCWWNYv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

jftr...

On Fri, Sep 25, 2015 at 03:01:01PM +0300, Samuli Sepp=E4nen wrote:
> We'd need some help build-testing a patched[*] OpenVPN version with=20
> Cygwin and Visual Studio:
>=20
> <http://build.openvpn.net/downloads/temp/openvpn-2.3_git.tar.gz>
>=20
> This tree already builds fine on mingw_w64 which is enough for doing the=
=20
> official builds.

Heiko tested on Cygwin, Lev made it work on MSVC2013 (and the necessary
changes for that have been merged).

So, now this needs people to actually run IPv6-over-IPv6 to *use* the
functionality and report whether it breaks in their setup.

What you need: IPv6 connectivity between OpenVPN client and server, and
IPv6 routing *into* the tunnel, with a route that overlaps the IPv6 address
of the server - either using "redirect-gateway ipv6", or pushing things
like "route-ipv6 2000::/3" with a server inside 2000::/3...  if you do
this, you should see something like this in the log:

Tue Oct  6 13:28:57 2015 GDG6: remote_host_ipv6=3D2607:fc50:1001:5200::4
Tue Oct  6 13:28:57 2015 ROUTE6_GATEWAY 2001:608:4::1 IFACE=3Deth0
Tue Oct  6 13:28:57 2015 ROUTE6: 2607:fc50:1001::/48 overlaps IPv6 remote 2=
607:fc50:1001:5200::4, adding host route to VPN endpoint
Tue Oct  6 13:28:57 2015 add_route_ipv6(2607:fc50:1001:5200::4/128 -> 2001:=
608:4::1 metric 1) dev eth0
Tue Oct  6 13:28:57 2015 /bin/route -A inet6 add 2607:fc50:1001:5200::4/128=
 dev eth0 gw 2001:608:4::1 metric 1

the first line is "this is the IPv6 address of the VPN server", the
"ROUTE6_GATEWAY" line is "this is the gateway and interface we have
discovered!".  The "overlap" notice means the feature will actually
kick in - it won't, if you have no overlapping routes into the tunnel,
or connect over IPv4 - and the last two lines are the installing of
the /128 host route, which better should work as well :-)

I tested this for 6 scenarios on 9 (!) platforms, so I'm reasonably sure
it works for the common case - but there will be unexpected cases...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--wr1Q/2bz0MCWWNYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhOxH6kuBuNlUUl1AQLeHgQAmz5DSzQxOUx+IvQ0steCOpkRaj0sJVdE
FsXVAMksFN/O+drHBlzBLI0OvI80xHM4end3xoKtZ0QF+zXfGFU9t0IMfPZuM6oD
C0D8R2g+cd/tdPknhwqGM1BRuLgb8d0YSPs7vfNsIpepMseO8sV0ADnXs8eGdIBg
j6UE+3HXwLI=
=tG+7
-----END PGP SIGNATURE-----

--wr1Q/2bz0MCWWNYv--

