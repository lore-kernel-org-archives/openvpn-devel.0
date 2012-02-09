Date: Thu, 9 Feb 2012 09:20:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120209082057.GG13929@...1296...>
References: <4F333427.70808@...1388...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulNsWUvGrZAj8PMr"
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

--ulNsWUvGrZAj8PMr
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
> therefore I can't easily set a metric. I could indeed put the actual=20
> server IP in there but that's less flexible, partly because I have this=20
> routes section in a separate file included in multiple configs on the=20
> same machine.

What are you trying to achieve?

> Can we have 'route-ipv6' accepting the same keywords as 'route' for=20
> consistency? Please :)

Someone needs to do the work.  It's somewhere on my TODO list, but I
haven't seen a strong need yet, so other bits have been done earlier.

> BTW ideally, for even more consistency, modify 'route' (v4) to also=20
> accept "net/prefix" as well as the old-fashioned "net netmask". OpenVPN=20
> is one of the last programs where I still have to use netmasks instead=20
> of the more convenient prefixes. That'd be truly awesome :) (but not as=20
> important as the vpn_gateway support for route-ipv6 of course).

Someone would need to implement that, in a backwards-compatible fashion.

I'm not, as I don't work on legacy IP support anymore.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ulNsWUvGrZAj8PMr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzOB6akuBuNlUUl1AQIvDQP+OYAP5MGxnMvcoj+YWdSKdx4xyNSHsW0q
2H1Bg3sn+c54LzjknDOumuQxQ8KHXGxWsmV5+9cQ/libqLes84yPlB6WGS3voDEr
mh97RZLp5Bm2JaYMI4lp/M9+DPcnvz6y6pS++zWWsU2ifHq3izMTsq2ogAE33m/C
Ppm8AOLwWC4=
=TNVh
-----END PGP SIGNATURE-----

--ulNsWUvGrZAj8PMr--

