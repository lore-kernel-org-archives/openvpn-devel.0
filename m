Date: Sat, 7 Jan 2023 17:12:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7maAC4v1yUpbeYV@...1296...>
References: <20230105022718.1641751-1-selva.nair@...277...>
 <CAGyAFMVpquzshk7k9TfBTwTFKRNxBVkunn79TnBd2gpaoZSQwQ@...278...>
 <Y7iCSAacZKc++0bW@...1296...>
 <CAKuzo_ik_xukXb9q+PNd_7wC6X4YPv+J9i2+wTX4488XvepStA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="78+pamQ+1IJeysR8"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ik_xukXb9q+PNd_7wC6X4YPv+J9i2+wTX4488XvepStA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Use IPAPI for setting ipv6 routes
 when iservice not available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--78+pamQ+1IJeysR8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 06, 2023 at 04:46:17PM -0500, Selva Nair wrote:
> > On Fri, Jan 06, 2023 at 03:44:24PM +0200, Lev Stipakov wrote:
> > > Compiled and slightly tested - pinged server's tunnel IPv6 address.
> >
> > Do we call "route" for connect networks on Windows?  We do on some
> > of the platforms, but for those where we do not, this is not a good
> > test for "route add" functionality - as tunnel IP + subnet gets
> > setup via the "ifconfig-ipv6" part (implicit route for connected net).
>=20
> Yes we do call add_route_connected_v6_net() on windows, so add_route_ipv6=
()
> should always get exercised.

Thanks for reminding me :-)

> Though I vaguely understand why we set the address with /128 and then set
> the route for the vpn subnet with fe80::8 as the gateway for tap-windows6,
> wonder why we do this for dco as well.

Let me recap why we do this for tap-windows - for windows, this is always
an Ethernet adapter, so it wants to always do neighbour discovery (ND),
IPv6's equivalent of ARP for all "on this interface" addresses.

For "--dev tun" setups, OpenVPN does not want to deal with "Ethernet things=
",
so the TAP driver replies to ARP requests for "special addresses" - for
net30, OpenVPN ioctl()'s the "peer" address (which is also the gateway
address) into the TAP driver, and only this address is replied to -=20
admittedly, I do not know how "topology subnet" works wrt virtual ARP,
need to read up on this again.

For IPv6, I decided that having to deal with ND is easier if I could just
look at a magic number, namely fe80::8, in the tap driver code - so, we
use /128 for the ifconfig bit ("no network here, everything is behind the
gateway") and point all routing to "on this interface, fe80::8" - so for
whatever IPv6 destination, windows will only do ND for fe80::8, and the
TAP driver will reply to it, without any further help (ioctl()) from=20
OpenVPN.


This said, I have no idea why we do it that way for wintun and DCO -=20
most likely because it avoids having to add even more windows-driver-
specific special case handling in places where we are nicely generic
today.

We are not really losing anything this way, though - even though we
pretend "the interface is a multiaccess interface", it is really only
point-to-point from the OS view, including win-dco.  So whatever
helps to convince windows "send the packet down this pipe" with the
least amount of code and debugging is good :-)

On a "real" multiaccess network, different neighbours would have different
MAC addresses, and more ND activity would happen - but "--dev tun" mode
never is (--dev tap on a --server would be).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--78+pamQ+1IJeysR8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjuZoAAAoJEB2Cnv7KVigSgdgMAKN6M5bn7YS0zWMSl9d1n5lu
sVqYkDI8vgH4Ky7m56EgO57Jt4Ukx5hYQ6OQmkNeVYWmbyfOfn110DcXINAbNE1+
Cc0YhQp+SBPyuzWnPD4RypWnYs8tS83jm/LZ9zJkn73M2YVmIYeX8zfvMKKyJzP9
xXMVN3Hainwtu/B0QQXlJPD78ljhyABkBckJlgmWAL7/BIXOpTUIZpO227/2aUfH
wdtH8bBiiFeFVeqTqeAB0eryTcJeEOIaA5HPEXuv9qXzsSOylqnIBcxpPDLL51Yu
vwXW8RW3BQwZ1IDsKhShv+TLqCmwMX2Ka83xwpqKdUmB8ElW1Su7EzgQTEnkDU8P
L7E1x0eXIbJzeAM7dMkCaEfQFtTK/ljllW6gXflkU/kfO77qyOA9FPmXi/77DoPh
lj+H3I0F3rc6Nk/zfMSjfpCwWigIidUehQN1L3SwQr4xi8yvEsDXq3Nx+GeoGNSw
9zR1gi+4GNArJZITUOx2RJUNiYXuoBf+o93EuJQ6eg==
=k54+
-----END PGP SIGNATURE-----

--78+pamQ+1IJeysR8--

