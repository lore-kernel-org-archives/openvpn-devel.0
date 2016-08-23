Date: Tue, 23 Aug 2016 21:39:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160823193940.GG78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<20160822191828.GT78279@...1296...>
	<20160823134336.GE78279@...1296...>
	<20160823134955.GF78279@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XxErtE42FmiGaS4u"
Content-Disposition: inline
In-Reply-To: <20160823134955.GF78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--XxErtE42FmiGaS4u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 23, 2016 at 03:49:55PM +0200, Gert Doering wrote:
> David, please revert both release/2.3 and master, and we'll need to=20
> rethink this, not using "is_ipv4()"...

Ow, ow, this patch is not good...

Turns out it also breaks p2p mode...

Tue Aug 23 21:28:07 2016 us=3D528530 UDP link local (bound): [AF_INET][unde=
f]:51198
Tue Aug 23 21:28:07 2016 us=3D528539 UDP link remote: [AF_INET][undef]:51198
Tue Aug 23 21:28:07 2016 us=3D528612 TIMER: coarse timer wakeup 1 seconds
Tue Aug 23 21:28:07 2016 us=3D529094 RANDOM USEC=3D205433
Tue Aug 23 21:28:07 2016 us=3D529128 PO_CTL rwflags=3D0x0001 ev=3D5 arg=3D0=
x006a5ee8
Tue Aug 23 21:28:07 2016 us=3D529137 PO_CTL rwflags=3D0x0001 ev=3D4 arg=3D0=
x006a5824
Tue Aug 23 21:28:07 2016 us=3D529147 I/O WAIT TR|Tw|SR|Sw [1/205433]
Tue Aug 23 21:28:07 2016 us=3D529958 PO_WAIT[1,0] fd=3D4 rev=3D0x00000001 r=
wflags=3D0x0001 arg=3D0x006a5824=20
Tue Aug 23 21:28:07 2016 us=3D529976  event_wait returned 1
Tue Aug 23 21:28:07 2016 us=3D529984 I/O WAIT status=3D0x0004
Tue Aug 23 21:28:07 2016 us=3D530017  read from TUN/TAP returned 76
Tue Aug 23 21:28:07 2016 us=3D530028 TUN READ [76]
Memory fault


... because it unconditionally checks

1005    drop_if_recursive_routing (struct context *c, struct buffer *buf)
1006    {
1007      bool drop =3D false;
1008      struct openvpn_sockaddr tun_sa =3D c->c2.to_link_addr->dest;

... which is a NULL ptr dereference here...

(gdb) print  c->c2.to_link_addr=20=20=20=20=20=20
$7 =3D (struct link_socket_actual *) 0x0

(tun interface comes up, operating system wants to send something, most
likely IPv6 DAD or the likes, which won't go out due to "no remote yet",
but still enters here, and *blam*)

Needs more thorough testing...  I'll put the next version into my treadmill
of "all possible weird ways to hook stuff together" (p2p, --inetd, ...)
and that will hopefully find all issues before pushing it out.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--XxErtE42FmiGaS4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7yme6kuBuNlUUl1AQJxjwP7B3x06d8dMzgC35e4iy2S7xa58tSQhZoY
xXR92l33mFcDiaKRqZ9xIEZnnsuVKxNrplOn53u8B0MQkM5lL7yHwUw4dlPruhWX
cMwu8GFkhi0mILfqF1hj0J7Udyqfx1yDMBPJXgzkHgpK0SaB+16e6EY1/V0oi0oq
U/Vb/Ghe/LY=
=X5ak
-----END PGP SIGNATURE-----

--XxErtE42FmiGaS4u--

