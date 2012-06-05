Date: Tue, 5 Jun 2012 19:57:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120605175702.GG1059@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
Subject: [Openvpn-devel] discussion: TAP, IPv6 routes and IPv6 gateways
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

IPv6 payload in OpenVPN "master" is working mostly well, but it has one
important missing piece: pushed routes for "tap" interfaces are not working
yet - and I plan to implement that "really soon now".

The missing bit is "gateway handling".


For tun devices, we currently install IPv6 routes pointing to the interface
itself ("tun3"), and not to the IPv6 address of the other end.  This works
perfectly, because the tun device is (from the kernel point of view) always
a point-to-point device, so setting a gateway doesn't add value - and with
the tun interface used, everybody can see right away "ah, vpn tunnel".

Now, a tap device is always a multiacess device with neighbor discovery
going on - so if you point a route to the device itself, the kernel will
assume it can ND ("arp") for it *on* the LAN, and not send it *across* the
LAN to the gateway on the other side.  This is messy, only works if the
other end does proxy ND, and eats up needless resources - so we need to
specify a gateway address when installing the route.


The currently-implemented code has two ways to specify a gateway (which
is currently just stored for later perusal):

 - ifconfig-ipv6 takes a "this is the address of the server" parameter,
   which will install a "if we need a gateway, you can use *this*" value

 - route-ipv6 takes an (optional) second parameter that specifies the
   gateway to be used for *this* route.

IPv4 in OpenVPN additionally has the "--route-gateway" parameter, which=20
basically does the same thing as the extra argument of "--ifconfig-ipv6",
but it has a special flag "dhcp" which means "use the gateway that the=20
TAP server provided via DHCP".


Now my questions :-)

 - I think we do not need "--route-gateway-ipv6" for IPv6, as all it does
   can be achieved by either using what "ifconfig-ipv6" installed, or=20
   specifying the next hop in "route-ipv6" (especially if pushed from
   the server).  But if you see value in implementing this, I'll do...

   (There is no "dhcp" in IPv6 right now, so it might eventually be=20
   taught to listen to bridged-in route advertisement from the server's
   LAN router, but that's 2.4 music - so for now, it would just specify=20
   a value to be inserted for routes that have no explicit gateway=20
   specification)

 - on a related note, there is "--route-metric n" which does not
   currently exist in a "--route-ipv6-metric" variant.  I do not think
   this would be useful to have, as a) currently, most platforms don't=20
   use the metric value anyway, and b) even if, the chance that the=20
   metric will be different for IPv4 and IPv6, *and* you can't just=20
   specify the metric as last parameter for "--route" / "--route-ipv6"=20
   is low...


 - do we need to support off-interface routes?

   Right now, in IPv4, you can have, say, 10.1.1.0/24 on the tun/tap
   interface, and install an IPv4 route that points to a gateway address
   of 192.168.1.1 - somewhere which is *not* on the interface to OpenVPN.

   I'm not sure I see use cases for this, but it would complicate the
   implementation - because I would need to check "is the specified=20
   next-hop on the tun/tap interface?  if yes, point the route to tun,
   or to tap+gateway - and if no, point the route to the next-hop, without
   specifying an interface".  I can do that, of course, if there are
   use cases that cannot be implemented otherwise - tell me, so I can
   learn :-)

=20=20
 - is there violent opposition to the approach "point route to interface,
   if possible"?  *I* think that this is a useful way to do things, and
   has been implemented and extensively tested on all platforms - but if=20
   there are strong reasons to do it the IPv4 way (don't specify interfaces=
,=20
   just specify gateway addresses) I could be convinced to do it that way.=
=20=20
   I will fight for my code, though :-)


(I'm happy to answer questions if what I wrote was unclear and confusing -
you'll find me in #openvpn-devel)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT85IbqkuBuNlUUl1AQJ8iAP9EFWQYqqa52yIhLDOpSS/sjomz/BIIWya
PttcfHpB4irz7wToI6+zlwkMQsOa8gwRCwR3xSoVWuSGOO8rjm/USdeWCQ31GCdv
sNvbLQj0NTxlD2kMOsOnRqM0OrrvK59r3AtIcfGX0Z+6zFY0PtfPSmyjBjBTl7Hh
Qe8e4kUd8j8=
=9dBW
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

