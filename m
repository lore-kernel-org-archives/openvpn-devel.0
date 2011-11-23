Date: Wed, 23 Nov 2011 09:34:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111123083437.GZ8496@...1296...>
References: <4ECC6EE6.5050709@...1388...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yin1XIsa6qgNGXVp"
Content-Disposition: inline
In-Reply-To: <4ECC6EE6.5050709@...1388...>
Subject: Re: [Openvpn-devel] Problems with add_route_ipv6()
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

--yin1XIsa6qgNGXVp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 23, 2011 at 04:56:22PM +1300, Michal Ludvig wrote:
> I'm using the latest openvpn from GIT on OpenSUSE 11.4 and am=20
> experiencing a problem with IPv6 payload setup. It works but openvpn=20
> seems to be somewhat confused when setting up the v6 route.

There's two interesting things in here...

> However every 2 minutes OpenVPN for some reason triggers a restart and=20
> then it tries to call add_route_ipv6() more then once. In fact it calls=20
> it 2x on the first restrat, 3x on the 2nd restart, etc. Here you go=20
> after a couple of minutes:
>=20
> 16:42:16 [xyz.logix.net.nz] Inactivity timeout (--ping-restart), restarti=
ng

... first, the restart, due to --ping timeout.  This normally shouldn't
happen in the first place - but it's not "the bug", it's just the trigger.

> 16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1=20
> metric 0) dev tunHome
> 16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
> 16:42:21 add_route_ipv6(2001:e20:abcd:400::/56 -> 2001:e20:abcd:403::1=20
> metric 0) dev tunHome
> 16:42:21 /bin/ip -6 route add 2001:e20:abcd:400::/56 dev tunHome
> RTNETLINK answers: File exists

... and *that* is quite obviously a bug.  It seems as if the pushed
route list isn't properly flushed upon disconnect, and then the routes=20
are just added again on top of it.

I'll go and investigate.  Thanks for bringing this up.

> Is there anything wrong with my setup or is it an OpenVPN bug?

The "ping restart" could be missing --ping* options on the server, but
that's just triggering the real bug - so it's good that you found it,=20
and we can fix it in time for 2.3.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yin1XIsa6qgNGXVp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTsywHakuBuNlUUl1AQKjMgP/QHG0bXoCQzBNf+YFD7+hnpsanIYFMzfr
zpO7xASFr80PcX02t9IrHc5P/o9KILKZol25WN11zWRiT1D8hjvj9K55VvIKQXEO
1hv9R/+JlMeeBKEVSwIuTmWG5dg4+xKx/oSiHCIRk/BPR++7QfJR2R4Ci5IATWJF
kfNdt7zhIhM=
=h8nb
-----END PGP SIGNATURE-----

--yin1XIsa6qgNGXVp--

