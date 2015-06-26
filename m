Date: Fri, 26 Jun 2015 13:24:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150626112401.GU382@...1296...>
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
	<20150626073544.GT382@...1296...> <558D2D98.70905@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2v+FQhmMLXZjIgq"
Content-Disposition: inline
In-Reply-To: <558D2D98.70905@...1516...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--y2v+FQhmMLXZjIgq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 26, 2015 at 12:46:48PM +0200, Holger Kummert wrote:
> >So - help me understand the scenario.  Why are you using persistant tun
> >interfaces but want dynamically added and removed addresses?
>=20
> well, I pass the device name on the command line of the call of openvpn
> because I need explicit named tun-devices for firewalling purposes
> (the firewall on the system also needs to know the name of the device in=
=20
> use).
> So it's created on start of openvpn.
> After exiting openvpn the device will be brought down.
>=20
> There are no additional services depending on the tun device except
> the firewall which is in charge for the device only if the tunnel
> is established.
>=20
> So the tun device is merely used like a dynamic one, but with a fixed nam=
e.

Mmmh.  Now I am even more confused.=20=20

I assumed you were using persistant tuns because "just" using a named=20
tunnel ("--dev tun3") should not cause this issue - as the addresses=20
should nicely go away when the tun3 device is closed and the system=20
destroys it...

And I actually *do* test for this in one of my t_client test runs... :-)

openvpn --client ... --nobind --comp-lzo --verb 3 --dev tun3 --proto tcp6-c=
lient --remote conn-test-server.openvpn.org --port 51194 --server-poll-time=
out 10

... and it "just works" - "ip -6 addr add ... dev tun3" on connect, nothing
special on disconnect, and "no problems" (on Gentoo Linux, but "ip" should
be sufficiently standard):

Fri Jun 26 13:18:05 2015 /bin/ip -6 addr add fd00:abcd:194:1::100c/64 dev t=
un3
Fri Jun 26 13:18:05 2015 /bin/ip -6 route add fd00:abcd:194::/48 dev tun3
...
Fri Jun 26 13:18:46 2015 event_wait : Interrupted system call (code=3D4)
Fri Jun 26 13:18:46 2015 /bin/ip route del 10.194.0.0/16
Fri Jun 26 13:18:46 2015 /bin/ip route del 10.194.1.1/32
Fri Jun 26 13:18:46 2015 delete_route_ipv6(fd00:abcd:194::/48)
Fri Jun 26 13:18:46 2015 /bin/ip -6 route del fd00:abcd:194::/48 dev tun3
Fri Jun 26 13:18:46 2015 Closing TUN/TAP interface
Fri Jun 26 13:18:46 2015 /bin/ip addr del dev tun3 local 10.194.1.54 peer 1=
0.194.1.53

So, what is different on your end?  Why is the tun<x> keeping its address?


> >(I can see that OpenVPN misbehaves but I'm not sure I understand what
> >"the best" solution should be - maybe go for "if that address is already
> >there, do not touch it, otherwise, remove existing address and add
> >new one" instead?)
>=20
> Your proposal would probably also do the job. I didn't dive deeply into
> the dependencies
> but just adjusted the behavior of handling ipv6 addresses to the handling=
 of
> ipv4 addresses on the device.
>=20
> With the provided patch the handling is at least symmetric for ipv4 and=20
> ipv6 and works in the described
> case (and would also work for the setup as described in trac #141).

Yes, your patch will make it nicely symmetric and solve the issue at
hand (while my approach would need infrastructure that is totally not=20
there today to find out "what IPv6 addresses are already configured on=20
interface tun<X>?").

This is more wondering about what we *should* do for persistant tun=20
interfaces...  (and, now, why your tun ifs behave that way even if they
are not actually persistant :) ).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--y2v+FQhmMLXZjIgq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVY02UakuBuNlUUl1AQJ4jAP+IfdDTIJ+p9K0jEg6FsMJMv7xmS0/4LE+
4CF2eZ+01tR9o2zBYIT37Wgn/PnxZpB/EU5aTxfv4/wcz/r+AnhcjXzq69EWIzs1
SZtvvPZKXGSLc8ET6Yqgqzah6FyTZm8OkbT04CznK81TzSJ5i1lsRvp9BlVRB4WP
zet2tAFAYg0=
=w4Om
-----END PGP SIGNATURE-----

--y2v+FQhmMLXZjIgq--

