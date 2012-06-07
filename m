Date: Thu, 7 Jun 2012 13:30:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120607113025.GS1059@...1296...>
References: <4FD0735C.7090902@...515...> <CBF6422A.24DA%brabander@...1435...>
	<1CED409804E2164C8104F9E623B08B9012D498A813@...1436...>
	<4FD078F5.7060903@...1543...>
	<20120607102517.GR1059@...1296...>
	<4FD08443.1060307@...1543...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <4FD08443.1060307@...1543...>
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paul Bakker <p.j.bakker@...1543...>
Cc: openvpn-devel@lists.sourceforge.net

--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 07, 2012 at 12:36:51PM +0200, Paul Bakker wrote:
> On 7-6-2012 12:25, Gert Doering wrote:
> > So what...? 1.1.4 or "1.1.0, and put the responsibility on the distro"?
> 1.1.0 and put the respsonsibility on the distro!

Ok - so I'll ACK the patch Alon has posted as well.  Thanks.

> > (How's the work on blowfish going? Only semi-joking, as I'd really like
> > to run cross-ssl-library client tests on the buildslaves, without forci=
ng
> > the OpenSSL servers to non-default crypto settings)
> WIP. Currently being worked on by one of my developers. So: Yes, we are
> actually coding for it now :)

Great news!  (Even if it means we might have to update that check again...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9CQ0akuBuNlUUl1AQIvOgP7BYqoVR54r250tDRjWf+0pXgdxJLUVIPV
VecSVhJdwRhI1OXUe72+rV0xd1r7l1oiW245KnBK5d6XmlKRLb6zaIC+JiXrvEfg
r/12EoHCc18+GkTjWX5cGEns5U+WhbFYWUgNqjy7oK2QlniC8PpGP2RD6IM1bWn8
cMrPS5MdaSA=
=bW3L
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--

