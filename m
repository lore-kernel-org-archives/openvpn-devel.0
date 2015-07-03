Date: Fri, 3 Jul 2015 15:15:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150703131545.GZ382@...1296...>
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...> <20150703115639.GC57772@...2041...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FZzRwqr391ll5WuA"
Content-Disposition: inline
In-Reply-To: <20150703115639.GC57772@...2041...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?B?SsFL0yBBbmRy4XM=?= <jako.andras@...2041...>
Cc: openvpn-devel@lists.sourceforge.net

--FZzRwqr391ll5WuA
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 03, 2015 at 01:56:39PM +0200, J=C1K=D3 Andr=E1s wrote:
> > yes this is possible; it's possible to push multiple gateways and=20
> > multiple (classless) routes (dhcp options 121 & 249).
> > If the metric on the tap-win adapter is set manually and is set low=20
> > enough the redirecting the gateway will also work.
> > However, changing the metric requires evelated access...
>=20
> Sorry for the noise if that has been discussed before: Instead of
> modifying the metric, how about pushing two /1 routes (0.0.0.0/1 and
> 128.0.0.0/1)?

Would work *if* windows supports the "classless routes" option (which
I'm not sure of) - and if it accepts DHCP on tap to provide a host
route for the VPN server to the original gateway on the normal LAN
interface.  Without that host route, routing would loop (we'd send
packets *to* the VPN server into the tunnel, encapsulate, send=20
to the VPN server, into the tunnel, encapsulate, ... *boom*)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FZzRwqr391ll5WuA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZaLAakuBuNlUUl1AQL1CgQAk2m9kV4OPM2+ZlBDkAziOHXqEI9nRTFk
Tw2b6VDqAlls0gqfeBAkeGP0p4SELSxmZ/UMVT6xcm0a9FVbLDFJWEUg+TKFchl9
RLcHaXU+BTA0PKxBrdfERLsKGlOxdscRKUwrNhvAYWq8VF/lIi2kfkFPiKAqM60s
1XcbmJzo7WY=
=lc/O
-----END PGP SIGNATURE-----

--FZzRwqr391ll5WuA--

