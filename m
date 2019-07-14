Date: Sun, 14 Jul 2019 22:02:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190714200227.GG1097@...1296...>
References: <201906051034.x55AYdRT080096@...2054...>
 <20190708224806.19887-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s7CsBtDqQs5UqHUm"
Content-Disposition: inline
In-Reply-To: <20190708224806.19887-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] route.c: use sitnl to implement
 get_default_gateway_ipv6()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--s7CsBtDqQs5UqHUm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 09, 2019 at 12:48:06AM +0200, Antonio Quartulli wrote:
>=20
> Changes from v1:
> - use IN6_IS_ADDR_UNSPECIFIED to check if GW address is specified. This f=
ixes
>   the issue of never setting the ON_LINK flag for IPv6 routes

Something is still not working correctly.

It *must not* set the ON_LINK flag for routes that are behind a gatway
("route to gateway" vs. "route to interface"), but it still does.

Here's what I tested:

 - my home network has 2001:608:4:0::/64 on link
 - I have set up a route fd00:eeee:200::/48 -> tun0  (no gateway)
 - default gateway is either statically configured (FreeBSD) or learned
   from RA (linux)
 - I asked openvpn the following question:

	openvpn --show-gateway
	openvpn --show-gateway 2001:608::2
	openvpn --show-gateway 2001:608:4::123
	openvpn --show-gateway fd00:eeee:200::1

    the first is "find me the way to reach ::", which is via default=20
    gateway (and the target is not ON_LINK), the second is "find me the
    way to this particular IPv6 address" - which is also via default
    gateway (here), and not ON_LINK.

    The third is "find me the way to reach 2001:608:4::123", which is
    another host on the LAN, so packets for this IPv6 address must be=20
    sent "towards the LAN" not "to a gateway" -> this is ON_LINK.

    The fourth is something of an oddball, point to point interfaces
    do not have neighbour discovery - so all routes to a gateway *behind*
    a p2p interface are also "ON_LINK", as there is no gateway we could
    put into a route.


Now, this is what OpenVPN 2.4.7 prints here (or master "with no patch")
(leaving off IPv4):

$ openvpn247 --show-gateway
Sun Jul 14 21:51:09 2019 ROUTE6_GATEWAY fe80::250:43ff:fe01:dc37 IFACE=3Den=
p0s25
$ openvpn247 --show-gateway 2001:608::2
Sun Jul 14 21:51:22 2019 ROUTE6_GATEWAY fe80::250:43ff:fe01:dc37 IFACE=3Den=
p0s25
$ openvpn247 --show-gateway 2001:608:4::123
Sun Jul 14 21:51:33 2019 ROUTE6_GATEWAY 2001:608:4::123 ON_LINK IFACE=3Denp=
0s25
$ openvpn247 --show-gateway  fd00:eeee:200::1
Sun Jul 14 21:52:14 2019 ROUTE6_GATEWAY fd00:eeee:200::1 ON_LINK IFACE=3Dtu=
n0

and this is what OpenVPN master + your patch prints

$ src/openvpn/openvpn --show-gateway
Sun Jul 14 21:42:25 2019 ROUTE6_GATEWAY fe80::250:43ff:fe01:dc37 ON_LINK IF=
ACE=3Denp0s25 HWADDR=3D00:00:00:00:54:97
$ src/openvpn/openvpn --show-gateway 2001:608::2=20=20=20=20=20
Sun Jul 14 21:46:02 2019 ROUTE6_GATEWAY fe80::250:43ff:fe01:dc37 ON_LINK IF=
ACE=3Denp0s25 HWADDR=3D00:00:00:00:54:b7
$ src/openvpn/openvpn --show-gateway 2001:608:4::123
Sun Jul 14 21:42:51 2019 ROUTE6_GATEWAY 2001:608:4::123 ON_LINK IFACE=3Denp=
0s25
$ src/openvpn/openvpn --show-gateway fd00:eeee:200::1
Sun Jul 14 21:42:59 2019 ROUTE6_GATEWAY fd00:eeee:200::1 ON_LINK IFACE=3Dtu=
n0 HWADDR=3D00:00:00:00:54:87

as you can see, it now insists on "everything is ON_LINK".


Now... I think the issue might be just that you removed the

-    CLEAR(*rgi6);

bit, so "there is cruft in that structure, and it is flagged as=20
'the ON_LINK bit is set'" - but it's too late for me to do a full
code review, so can't say for sure.  If I just add it back, it
behaves correctly, but it would be good to give this function another
long and hard stare...

However - as it is today, I need to NAK this.  Sorry.  (And I should
have been much quicker)

gert

(PS: FreeBSD is, as expected, showing the same things before/after, with
ON_LINK only for test 3+4 - but that's a totally different code path, so
no surprises here)
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--s7CsBtDqQs5UqHUm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdK4pLAAoJEB2Cnv7KVigSgdUL/jHP4yk+rahUpTIxntwLPj7d
TR0cpMDhdxudz4R5S0+n6XUSdu+775AAocI7YykvmKy+lpXcx2WqswNvWikIZg0Y
GGlUGFVpvIOgawY4VG6LjUupkjj+dAWW71j5WvlWcBGLBnGBtoXG/8sc4qk86PyI
0fuey1RJDppvtjCgPlrsqhpT+oZy7SqAEMR2A9ag+vZSa8oJYIY+SrpuoMrKAGtp
Jw5Y/l+2X5Ip0Goh0C2rFlHwa6aP1WyiQroFbAXbgiDWG8WPNIaMbWWg2tFwNfjT
i/etoGOegoIHITA1XNCwylV3CYyPeK0FOPpK2XYomj22wFqNz1YV07YU+w7IShSW
wLbzK9Via/cyKX0XELJyulEZzvdP2LHEKq+A6eESsH7PN6J9/9zxvSEs8cXc1q9s
51qNX6+c/WHcSaF7HGClXIpCNAjI9rbxPmvXIKLSAbmFLBCT+mGgF3PD7zcmOnfj
lsC0D/pdmZLN0RqTa6plY27a4Ph2iRGGHVlz9zS3VQ==
=/f2q
-----END PGP SIGNATURE-----

--s7CsBtDqQs5UqHUm--

