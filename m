Date: Fri, 30 Dec 2011 20:12:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111230191255.GF5060@...1296...>
References: <4ECC6EE6.5050709@...1388...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H14uD12u8nekTETJ"
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

--H14uD12u8nekTETJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

sorry for this to take so long, but other stuff got in my way.

On Wed, Nov 23, 2011 at 04:56:22PM +1300, Michal Ludvig wrote:
> I'm using the latest openvpn from GIT on OpenSUSE 11.4 and am=20
> experiencing a problem with IPv6 payload setup. It works but openvpn=20
> seems to be somewhat confused when setting up the v6 route.

It took me a bit, but I can now reproduce this, with today's git
snapshot (no change in the ipv6 code since May, so it's not unexpected
for this to still be there).

[..]
> However every 2 minutes OpenVPN for some reason triggers a restart=20

This is caused by --ping-restart being set to the default (2 minutes)
on your end, but no corresponding --ping being set on the server side
(--ping is asymmetric, it needs to be enabled on the *other* side to
make --ping-restart not, uh, restart unduly).

> and=20
> then it tries to call add_route_ipv6() more then once. In fact it calls=20
> it 2x on the first restrat, 3x on the 2nd restart, etc. Here you go=20
> after a couple of minutes:
>=20
> 16:42:16 [xyz.logix.net.nz] Inactivity timeout (--ping-restart), restarti=
ng
> 16:42:16 /bin/ip route del 172.31.173.129/32
> 16:42:16 /bin/ip route del 172.31.172.0/24
> 16:42:16 delete_route_ipv6(2001:e20:abcd:400::/56)
> 16:42:16 /bin/ip -6 route del 2001:e20:abcd:400::/56 dev tunHome
> 16:42:16 Closing TUN/TAP interface
> 16:42:16 /bin/ip addr del dev tunHome local 172.31.173.134 peer=20
> 172.31.173.133
> 16:42:16 SIGUSR1[soft,ping-restart] received, process restarting
> 16:42:16 Restart pause, 2 second(s)

... one of the possible workarounds here would be to use --persist-tun,
which makes it "not close and reopen the tun device", so no extra route
adding is happening.

Now, this is still a bug - and without --persist-tun, I can reproduce
it perfectly:

Fri Dec 30 20:10:19 2011 us=3D642033 /sbin/ip -6 route add 2001:608:4:a000:=
:/56 dev tun0
Fri Dec 30 20:10:19 2011 us=3D644224 /sbin/ip -6 route add 2001:608:4:a000:=
:/56 dev tun0
RTNETLINK answers: File exists
Fri Dec 30 20:10:19 2011 us=3D646183 ERROR: Linux route -6/-A inet6 add com=
mand failed: external program exited with error status: 2
Fri Dec 30 20:10:19 2011 us=3D646334 /sbin/ip -6 route add 2001:608:4:a000:=
:/56 dev tun0
RTNETLINK answers: File exists

> Is there anything wrong with my setup or is it an OpenVPN bug?

Bug.  For workarounds, see above :-) and a patch will follow as soon as
I have cornered the bug (or have understood why this is not happening for
IPv4).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H14uD12u8nekTETJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTv4NN6kuBuNlUUl1AQIm+AQAmUyYnTBPiRQnMk+d0YRYgoVoqM8gXBTK
wg9NQOSctWJX7jALN0/fY9lhheJPgk+k+UjiwqMHSkIWYFjachm4rIL/tEEd4RKj
tyun9QfqbZP+DleLGoGtlu3lLJiKjL9Bqelaj7HRkmyGQw6Lg4+Ztc4hr0QyZYEB
9+DN/pvSvrM=
=DB83
-----END PGP SIGNATURE-----

--H14uD12u8nekTETJ--

