Date: Fri, 20 Aug 2010 17:48:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100820154817.GC23371@...1296...>
References: <4C6E73E4.6060300@...515...>
	<20100820153536.14097.qmail@...1287...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20100820153536.14097.qmail@...1287...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (19th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 20, 2010 at 05:35:36PM +0200, Peter Stuge wrote:
> Samuli Sepp=E4nen wrote:
> > converting the OpenVPN build system (on Windows) to depend only on
> > python, Visual Studio Professional and DDK. The original build
> > system required bash and various other UNIX tools.
>=20
> James' mentioned argument for prefering Visual Studio, namely that
> MinGW may not have all the most recent functions in .h files, is not
> so good IMO. Since James also seems to prefer working outside Windows
> I would rather try to make OpenVPN for Windows crosscompileable, both
> driver and app.

The app is cross-compileable today - but to make that work requires that=20
all relevant Windows APIs are exported in mingw headers *and libraries*.

Windows APIs have the nasty habit of changing over time, so if mingw
stops updating their libraries etc., OpenVPN would be sort of stuck
to the old APIs - which might turn into a problem.  Or might not.  We
don't know...


> libusb-win32 can already compile their driver using MinGW.

To be able to cross-compile the driver would certainly be nice.  Need to
check how libusb-win32 does this...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTG6jwakuBuNlUUl1AQIGcAP/Z7aNOXsKZPruESEU6i6bbkHqaSPGLgPl
87hUY8YOghxtGRxdpTwFOsUpk+6sgTbu3wP8Cou1RVu1sj/LKyYVih7CAqRS7eAo
Og9EG7A5yq3Qh6j3w+a5IMK/5LWSkmF+Qx9GXQgv/glKrPHA9ih1mX/VN9/H7YaJ
DwsDR4e+2+s=
=yPFr
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

