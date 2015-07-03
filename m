Date: Fri, 3 Jul 2015 13:55:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150703115557.GX382@...1296...>
References: <55966BE0.5090400@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+X7K3ZbSRJxCtaUy"
Content-Disposition: inline
In-Reply-To: <55966BE0.5090400@...1147...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
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

--+X7K3ZbSRJxCtaUy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 03, 2015 at 01:02:56PM +0200, Jan Just Keijser wrote:
> It's even possible to run openvpn without admin privileges and set=20
> routes this way!

singular route, unfortunlatey - while there is an option to advertise
specific routes ("192.168.0.0/24") in DHCP, as far as I understand, nobody
supports this - so all you can do is a default route...

> Before you get too excited: it does not seem to be possible to replace=20
> an existing default GW this way. the new 0.0.0.0 route has the metric of=
=20
> the tap-win32 adapter , which is better than that of a wifi adapter but=20
> worse (30 =3D=3D higher) than that of a regular LAN Adapter (metric=3D10).
>=20
> Before I go any deeper into this: what does the rest think about setting=
=20
> routes on Windows this way? It could be a nice way to circumvent all=20
> kinds of "route add" problems.

Won't do IPv6, won't help us installing the /32 needed for "redirect-gatewa=
y",
and (if my assumption above is true) won't give us more specific routes.

So: nice finding, but not useful enough...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+X7K3ZbSRJxCtaUy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZZ4TakuBuNlUUl1AQLzNwP/aIJmzt2YlANhZKfK3KqAluH6+cMY8qq7
VfONK3Q7oYrSRzdlJDRo+ZFRiCngBvuzpLAUBm3+wt92JQfVuMCXCJaTOXP2s7eE
N/Gl7tNiUeMRBJWq4E7ojhXOduYSyuJzQa2UvkD55/NVBPrI9Y4jP1wRp4cCfljv
qCk2/M98WaA=
=/A4G
-----END PGP SIGNATURE-----

--+X7K3ZbSRJxCtaUy--

