Date: Mon, 17 Dec 2012 10:50:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121217095056.GH22465@...1296...>
References: <1355733093.65651.YahooMailNeo@...1779...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3McLx17X1dD5aQEg"
Content-Disposition: inline
In-Reply-To: <1355733093.65651.YahooMailNeo@...1779...>
Subject: Re: [Openvpn-devel] multiple OpenVPN instances on a single tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ehsan enayati <ehsan_en85@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3McLx17X1dD5aQEg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 17, 2012 at 12:31:33AM -0800, ehsan enayati wrote:
> I need to run multiple instances of OpenVPN server on just one tun device=
 driver (say tun0) all on same subnets. I tried editing the open_tun functi=
on in tun.c file, first instance goes well and creates tun0 but when the se=
cond one comes along it cannot use tun0 and I get the error "ioctl(TUNSETIF=
F):
> Device or resource busy ". I really need this functionality. Please give =
me some hints.

There is no way to do this, as the tun device is exclusive-open - only
a single process can open it (in theory, you might be able to open() it
and then fork, sharing the file descriptor between all childs, but then
you have the problem of ensuring that the "right" process gets the packets
sent from the kernel to tun0, and there is no way to influence that).

Maybe you can explain to us what you want to achieve, and then we can=20
see how it can be done (if at all).

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3McLx17X1dD5aQEg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUM7rAKkuBuNlUUl1AQIuEwP+LSAuTDaIDlqwWxPyoLWievpNQL2Z3zxA
HWnACyUXhUEvBNVM3vf1sSwZKMJkXgE6CUg1A/LOcyNCOHRt9BtuZT6/RhJuZlQ9
ktD/uhtUuMnKjpJ24fwgTJbZGrcC/r4n4FQVAJ5rhXk24SSWHMNhKU+O4yy5Rpdx
6paLlMSMqjk=
=7Rmw
-----END PGP SIGNATURE-----

--3McLx17X1dD5aQEg--

