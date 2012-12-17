Message-ID: <50CEDEA3.7040408@...1114...>
Date: Mon, 17 Dec 2012 09:58:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1355733093.65651.YahooMailNeo@...1779...>
In-Reply-To: <1355733093.65651.YahooMailNeo@...1779...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig807D9B09FE81C7144FE706E8"
Subject: Re: [Openvpn-devel] multiple OpenVPN instances on a single tun
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig807D9B09FE81C7144FE706E8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/12/12 09:31, ehsan enayati wrote:
> Hi,
> I need to run multiple instances of OpenVPN server on just one tun
> device driver (say tun0) all on same subnets. I tried editing the
> open_tun function in tun.c file, first instance goes well and creates
> tun0 but when the second one comes along it cannot use tun0 and I get
> the error "ioctl(TUNSETIFF): Device or resource busy". I really need
> this functionality. Please give me some hints.

It is not possible to do what you try to do.  Only one application can
bind to a tun or tap socket.  It's basically the same issue if you try
to have more applications bind and listen to, say port 80, at the same
time.  It's impossible.  And it's restricted by the OS.

If you need OpenVPN instances to be on the same subnet, you can use TAP
and bridge tap0 and tap1 together.  *But* I 'd rather recommend to use
tun devices, have them on separate subnets and do the rest with routing.
 Using tun + routing is by far the cleanest and easiest configuration
setups.  It also gives the lowest traffic overhead and least headache
while debugging the configuration when it fails.


--=20
kind regards,

David Sommerseth


--------------enig807D9B09FE81C7144FE706E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDO3qYACgkQDC186MBRfrpZFQCgsU5lkriVIJZK3ilBlOzu9GrH
JFIAoIVWxPaZhSWQsRBvQzdG6CaXiYTq
=60Mj
-----END PGP SIGNATURE-----

--------------enig807D9B09FE81C7144FE706E8--

