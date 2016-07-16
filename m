Date: Sat, 16 Jul 2016 20:17:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160716181726.GQ78279@...1296...>
References: <1468691103.727067.3678.7414@...2154...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuBTcNUPe5zwk2q6"
Content-Disposition: inline
In-Reply-To: <1468691103.727067.3678.7414@...2154...>
Subject: Re: [Openvpn-devel] net6_gateway feature request
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: streampp <streampp@...2153...>
Cc: openvpn-devel@lists.sourceforge.net

--VuBTcNUPe5zwk2q6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 16, 2016 at 08:45:03PM +0300, streampp wrote:
> I'm connecting to my remote OpenVPN server via IPv4. On openvpn-server.co=
nf I have something like:
>=20
> push "route 10.0.0.0 255.0.0.0 net_gateway"
> push "route 172.16.0.0 255.240.0.0 net_gateway"
> push "route 192.168.0.0 255.255.0.0 net_gateway"
>=20
> with works perfect and my IPv4 gateway replaces "net_gateway" parameter, =
so with IPv4 everything is fine.

"why"?

> But... I want same thing for IPv6:
>=20
> push "route-ipv6 fc00::/64 net_gateway" and that is not working, because =
net_gateway represents IPv4 gateway...
>=20
> Can you do something like "net6_gateway" variable for such cases?=20

By excluding that range (push "route-ipv6 2000::/3" instead of ::/0)
you can achieve the same effect - fc00:: will go to your existing=20
net_gateway.

But it still doesn't make very much sense to me why you want to exclude
private ranges from the tunnel - why not just route everything?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VuBTcNUPe5zwk2q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV4p6NakuBuNlUUl1AQKRQAP+Ks/Lf9AwT+8XLZ2ZSIy6a7WQ+e7SW0bP
wzlkC4MWYI//oNIy9nIQX3rrmTiAuV/0Ih8gT8+/te3/MA0nfst5h6P/uZKmHbSY
iRf+80ypf9CV7W2cvO4g9BYcIg5C9DW2PwBzzcwg1Mp3QLIhuNwjEGQpWl2ttn/a
Lg0XttrQvrY=
=/92D
-----END PGP SIGNATURE-----

--VuBTcNUPe5zwk2q6--

