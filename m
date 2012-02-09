Date: Thu, 9 Feb 2012 11:48:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120209104836.GK13929@...1296...>
References: <4F333427.70808@...1388...>
	<20120209082057.GG13929@...1296...>
	<4F33956F.9060707@...1388...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0786ZyFfTSxuegBe"
Content-Disposition: inline
In-Reply-To: <4F33956F.9060707@...1388...>
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

--0786ZyFfTSxuegBe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 09, 2012 at 10:44:15PM +1300, Michal Ludvig wrote:
> >On Thu, Feb 09, 2012 at 03:49:11PM +1300, Michal Ludvig wrote:
> >>I'm used to pushing route options to the clients with explicit metrics.
> >>That works good for IPv4 with e.g.:
> >>push "route 192.168.128.0 255.255.240.0 vpn_gateway 200"
> >>
> >>However route-ipv6 doesn't accept the 'vpn_gateway' keyword and
> >>therefore I can't easily set a metric. I could indeed put the actual
> >>server IP in there but that's less flexible, partly because I have this
> >>routes section in a separate file included in multiple configs on the
> >>same machine.
> >What are you trying to achieve?
>=20
> I'm trying to set a metric for IPv6 route pushed from the OpenVPN server.
>=20
> Long story, if you're asking why, is: we've got multiple OpenVPN=20
> gateways to our network, each in a different location. A VPN user can=20
> connect to any of them, or to more then one, and must have access to the=
=20
> whole network. Obviously I'm pushing the prefixes local for each=20
> location with a lower metric and the non-local prefixes with a higher=20
> metric. That way, even if a user has a tunnel up to two or more=20
> locations, the traffic to each location is always routed through the=20
> most direct tunnel with the lowest metric.

OK, this makes sense, and is a good argument for metric.

(And to make this extensible, it would need to understand a gateway
parameter, which it currently doesn't).

> To make things a little more complicated I have both UDP and TCP=20
> endpoints in each location (TCP is there for users behind HTTP proxies=20
> for example) and most of their configs are shared, therefore I use the=20
> "vpn_gateway" placeholder that gets replaced for the VPN IP of the=20
> actual server, which is different between UDP and TCP on the same=20
> gateway. Without that placeholder I can't share the config with "push=20
> route-ipv6" options between UDP and TCP instances.

It won't work anyway right now, because metric isn't handled in=20
IPv6 routing at all - classical case of "other things were more
pressing" (and all this stuff is "slightly" system-dependent, so
needs lots of testing...).

> So that's what I'm trying to achieve. Hope that makes sense :)

It does.  Thanks for explaining.

I'm not promising anything, but it just moved a bit further up on
my TODO list... ;-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0786ZyFfTSxuegBe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzOkhKkuBuNlUUl1AQLeXwP+LJTt7AdK0DP8KSkdC4dDJDYnL0GJiB+k
0BSS7wgHRjJTGA6DafSi1XZbERny2W0AF08/NgbrxoVkQOYQF5tqb+o5+Ein5nGM
y3aIRkwepJjCGlNxrjpHA5O9TNvfynFBXMT6NWIatOvglj00aAhaKtoNfBwXkOGN
SmZZhIiCfaA=
=Ejf4
-----END PGP SIGNATURE-----

--0786ZyFfTSxuegBe--

