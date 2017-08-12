Date: Sat, 12 Aug 2017 18:43:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170812164338.GG70062@...1296...>
References: <20170812170700.31a0868b@...1661...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ilsi/0vOxQ+fn9lZ"
Content-Disposition: inline
In-Reply-To: <20170812170700.31a0868b@...1661...>
Subject: Re: [Openvpn-devel] In P2P and IPv6 only mode: do_ifconfig() does
 not set up tun interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Kress <m-kress@...1660...>
Cc: openvpn-devel@lists.sourceforge.net

--Ilsi/0vOxQ+fn9lZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 12, 2017 at 05:07:00PM +0200, Michael Kress wrote:
> it seems that OpenVPN in P2P mode (static keys) doesn't configure and
> start the tun interface when there are no configured IPv4 addresses:
>=20
> OpenVPN 2.4.3
> In "void do_ifconfig()" of tun.c line 881: if (tt->did_ifconfig_setup)
>=20
> The flag tt->did_ifconfig_ipv6_setup is not considered at all. Is there
> a reason to not start an IPv6 only tun device? Maybe this has simply
> been overseen?

IPv6-only is currently not supported (it works if you do not use any
ifconfig at all inside OpenVPN, but not with --ifconfig/ifconfig-ipv6).

The reason is fairly simple - there's lots of assumptions inside OpenVPN
about "IPv4 will be there" and nobody has checked everything to make
sure nothing will blow up (or the blowups are fixed) in case IPv4 is
not.

No hard technical reason, just a matter of available time.

(The routing layer *nowadays* actually happily deals with "no IPv4=20
routes" - initially, the scenario "IPv6 routes, no IPv4 routes" caused a=20
segfault...)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ilsi/0vOxQ+fn9lZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZjzA6AAoJEB2Cnv7KVigSyUcL/2cqJV8ikthnkt7LsonHN9eh
XCGKoIwkIRGLUDdVDsH3M+d+CWo08ubhbJbH94KjUN6lJMR2Wn5whAcdirCGY58H
zPm4UF4Doscr2llQa86szVrwfOCJUFD3dmKShsNDeVT8Bf1SSjlQ2uQgsC1XsTuZ
9uqR5VnSvQxWJIHPncL0iaiBCRluGDiR2zyVDveOVOmE4X1cIcVYRmTp0jutzLcu
qRbY0t+3u+KqK2WCg8KvYwEKonw22PGgsRk4lcpN9c64T4M6ePKjPyronfldjbv0
3bT7pZOyyzXFs+Fk86PeFSgVEjy0THHfpJeWQiHgaXqJGpc7izjWAxC/jDDRvF7l
vhcfi2+TydK0v2OGEj0sSjSJIIB4uEBxoFpVWYdH6ncKsplEuLG022JXqCod4e6I
/2UOtd8lGpMQaKUr1dYDocs6HbWcVHGJt7DRDKhQOMuvaLWXOzL9401Qq2DqFnBm
/MYK96B5HFO+IzLzGebsxTIzR13dHE/owZH3LVJIDQ==
=md5f
-----END PGP SIGNATURE-----

--Ilsi/0vOxQ+fn9lZ--

