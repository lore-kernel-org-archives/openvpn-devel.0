Date: Mon, 23 Jun 2014 13:33:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140623113325.GG1118@...1296...>
References: <1401176665-1838-1-git-send-email-aleksandar.kanchev@...277...>
	<1403521958.15555.20.camel@...1865...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QQyEkJ+v1X6lF3FS"
Content-Disposition: inline
In-Reply-To: <1403521958.15555.20.camel@...1865...>
Subject: Re: [Openvpn-devel] [PATCH] cstp: Add workaround for
	255.255.255.255 netmask on windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openconnect-devel@...1906..., openvpn-devel@lists.sourceforge.net, Aleksandar Kanchev <aleksandar.kanchev@...277...>

--QQyEkJ+v1X6lF3FS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 23, 2014 at 12:12:38PM +0100, David Woodhouse wrote:
> > Another side effect is that if the TAP Windows driver is being
> > initialized with 255.255.255.255 netmask then there's no way
> > to convince windows to route packets through that interface.
>=20
> If this isn't considered a bug in the Windows tap driver, (and I suspect
> it isn't, because they're working around some true horridness in the
> Windows network stack),=20

Well, for Windows, a tap interface is an ethernet interface in good
standing - and not a point-to-point thing like a tun on other platforms
where there really is no "subnet" but "my IP, and what's on the other side".

So, as you can't put 255.255.255.255 on normal ethernet interfaces, you
can't do that on the tap driver either.  I'm not sure whether .254 would
work - which is why OpenVPN's net30 always wasted a /30 in the old
days, or uses a larger subnet now.

There is not very much we can do to "fix" that in the tap driver,=20
especially as the ifconfig is done outside the driver in the generic
IP part of the stack...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QQyEkJ+v1X6lF3FS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU6gQhakuBuNlUUl1AQLT1AP/Wb9ixoUNMcSV8khSfsYZKim+IfQOoLYQ
m91nhu/FJ1/SZRueYnMDv6QE0jB3qhrt6p8TnwI8AkjNEIolibOdanoKRkHWNuvW
8uKS9aB/BGhHc3SSgs86VOkpstCEZqjFnBqjUHfZEL8Xug/M6/M5dj3ho1e/QZZG
ZLLLTTYEi54=
=3S7l
-----END PGP SIGNATURE-----

--QQyEkJ+v1X6lF3FS--

