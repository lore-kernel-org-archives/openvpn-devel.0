Date: Fri, 10 Jun 2011 14:03:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110610120304.GF8496@...1296...>
References: <4DF0FEC8.4040105@...1465...> <20110609174852.GZ8496@...1296...>
	<4DF1E1F8.6080701@...1465...> <20110610101141.GD8496@...1296...>
	<4DF205F8.4080601@...1465...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rl3sB5NOYHq5QV7O"
Content-Disposition: inline
In-Reply-To: <4DF205F8.4080601@...1465...>
Subject: Re: [Openvpn-devel] Why no ipv6 support for tap?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sergey Matveychuk <sem@...1465...>
Cc: openvpn-devel@lists.sourceforge.net

--rl3sB5NOYHq5QV7O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 10, 2011 at 03:54:32PM +0400, Sergey Matveychuk wrote:
> 10.06.2011 14:11, Gert Doering wrote:
> >>I'm telling about working with IPv6 addresses.
> >
> >It should do that nicely if you set --tun-ipv6.
>=20
> OK. Thanks for the explanation. I thought turning tun-ipv6 on makes=20
> openvpn treat my tap interface as a tun one some way.

I will update the documentation to clear up this misunderstanding :-)

> So I have it work but some troubles with ifconfig-ipv6-pool. I'll be=20
> test more later next week.

OK, looking forward to hear about it!

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--rl3sB5NOYHq5QV7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTfIH+KkuBuNlUUl1AQIKOgP/VxIO02HmBmmZJh+E5A7KkVjjXw5aiNoq
rVa4WJpE4GKCRw2p9vgwRC7MiEP8ujHBWuPKswEx6sbls6LGaPpNQFcRn22adGui
I+KmV5Oh2S5bzrHS7vnPwElQarlKndHwez6WzRPl8CeqOHTaly+QQPAMDCPebo8z
wvaTWZI0kpw=
=9MVj
-----END PGP SIGNATURE-----

--rl3sB5NOYHq5QV7O--

