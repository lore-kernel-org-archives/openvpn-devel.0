Date: Fri, 22 May 2015 09:43:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150522074348.GA382@...1296...>
References: <555BF270.3090706@...1147...> <20150521181409.GY382@...1296...>
	<555E21F7.4030002@...1147...> <20150521183108.GZ382@...1296...>
	<555E55B4.5080804@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enbeIAqa8YisR7TD"
Content-Disposition: inline
In-Reply-To: <555E55B4.5080804@...1147...>
Subject: Re: [Openvpn-devel] patch for bug #93: up-restart env vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--enbeIAqa8YisR7TD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 22, 2015 at 12:01:24AM +0200, Jan Just Keijser wrote:
> >I'm not sure what the best path forward is, TBH...
>=20
> --up-restart *is* different from --up in several ways:
>=20
> - runs as the user+group that is specified in the config file
> - the 'tun' device is persistent so it's not "fresh"
> - routes are not reset during a "persistent" restart, so are still present

  - IP addresses are not reset (as the tun device is pesistent)

so indeed, lots of differences here.

What about this:

 - take your patch as it is (because it's not very intrusive, provides
   variables people are asking for, and cleans up tun.c a bit :-) )
 - add a patch to openvpn.8 that explains the differences in --up-restart
   (so people will know that the lack of route env vars is not a bug)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--enbeIAqa8YisR7TD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVV7eNKkuBuNlUUl1AQJfBgP+MwiK8U1BlVx6xDL47so3UbMQHI3Ex4C/
Ys5DWIBX54a9NgiXq4+e3i8OdM2PnMjE6iY2Ohxiz5vs5UjCtdyMs1flNur978/d
5gZQ5tQ9EF0PDedAWYGy77lPPcxrAbM/xFLEElo5aJUucvO33vVqunEQTE+tynjp
Kwr5bv76IjI=
=CGv3
-----END PGP SIGNATURE-----

--enbeIAqa8YisR7TD--

