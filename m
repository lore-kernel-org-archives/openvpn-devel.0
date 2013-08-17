Date: Sat, 17 Aug 2013 20:08:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130817180830.GD16543@...1296...>
References: <20130817103007.GA16543@...1296...> <520F7801.7030705@...68...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0JXx0QNa4/JeB8y"
Content-Disposition: inline
In-Reply-To: <520F7801.7030705@...68...>
Subject: Re: [Openvpn-devel] RFD - block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--z0JXx0QNa4/JeB8y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 17, 2013 at 03:17:53PM +0200, Matthias Andree wrote:
> Am 17.08.2013 12:30, schrieb Gert Doering:
>=20
> > So, what I'm hoping to hear from you...
> >=20
> >  - should we include this in 2.3.3?
> >     - if yes, are changes needed?
>=20
> Well, it would take huge warning banners because it might disrupt
> existing setups (which would be insecure through the "connect around
> tunnel" behaviour), so I'd prefer "2.4" with a sooner 2.4 release.

Well, it would not happen "automatically", but only if block-ipv6 is
configured or pushed from the server (and if the server pushes it to
a 2.3.2 client, that one would not silently ignore it but abort) - so
I do not see much potential for breaking existing setups here, unless
the admin is intentionally turning it on...

> >  - should we try to implement something for 2.4/master that will work=20
> >    by pointing the IPv6 routes into the tunnel, and then synthesize the
> >    IPv6 ICMP errors inside OpenVPN?  That would work on Android and iOS
> >    as well, and remove the extra per-platform logic for the "reject" ro=
utes
>=20
> Absolutely, on both accounts, if technically feasible.  You may need to
> synthesize RST for stale TCP sockets, and ICMP for UDP, too.

I hear you and Arne, and will go out and start coding... :-)

> >  - any clever ideas how to achieve "full" IPv6 blocking (right now, it =
only
> >    kills the default route, but all more specific routes continue worki=
ng -
> >    this is by design to keep the implementation simple, and was conside=
red
> >    "good enough" by the end customer asking for it)
>=20
> End users may also have requirements to override certain more specific
> routes to bypass the tunnel.  I can fancy only few things that are
> worse than flipping global connection status "with/without VPN" every
> few minutes if you need host and "home" resources at the same time.

Indeed.  Besides the technical challenge, this would of course need to be
configurable ("block-ipv6 all" vs. "block-ipv6 default-route-only" or so).

The technical challenge of actually making this work in scenarios where
VPN policy requires "no other access" is even more interesting, given=20
that IPv6 routes/prefixes might change dynamically on a host with IPv6=20
autoconfig enabled...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--z0JXx0QNa4/JeB8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUg+8HqkuBuNlUUl1AQL8mwP/aMd6LEPiBjahEXy7rdzqwmtBfWmgxJim
al2s/dI1YkU0WBPrqZh0Qg2HqIpCOgtsmJQO2sbzWcdY2fbxa6NM/HTGk8mw0Tvo
/nh37cmyBYVI60JJHRH475HSi7x1GvlY1FnQWPWcaBblrhn7WWBFoJ8fzZ7TnAXI
CaJHnOaniHY=
=xaAE
-----END PGP SIGNATURE-----

--z0JXx0QNa4/JeB8y--

