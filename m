Date: Tue, 16 Feb 2016 15:11:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160216141118.GB24952@...1296...>
References: <56C3205A.6050408@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0i9UvN4f6MWot87p"
Content-Disposition: inline
In-Reply-To: <56C3205A.6050408@...515...>
Subject: Re: [Openvpn-devel] Always including tap-windows6,
 openvpn-gui and easy-rsa in openvpn-build -generated Windows
 installers?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0i9UvN4f6MWot87p
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 16, 2016 at 03:12:58PM +0200, Samuli Sepp=E4nen wrote:
> Currently openvpn-build allows producing installers which do not=20
> _contain_ tap-windows6, openvpn-gui or easy-rsa at all. On top of this=20
> one can - at install time - select which of the contained components are=
=20
> intalled.
>=20
> Let me know if you have good arguments on why we should have the option=20
> to generate installers without the said components. If nobody speaks up,=
=20
> I'll remove the conditional code from openvpn.nsi while preparing for=20
> the OpenVPN 2.4 release.

I do not think maintaining these options makes much sense - at install
time, yes!, but at build-time - this stuff should have what we want=20
*our* installers to contain.  The rest could go to comments in the
code maybe ("if you want to make this optional, remove the following
lines") or so.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0i9UvN4f6MWot87p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsMuBqkuBuNlUUl1AQJOXwP+K47O590oxCWkY1WU2XBE5+T/zMo4IC3e
+ylSHMHTE3O97XWvFoqjQFgPJ1TWUZRUnZM+uvhcI9f3371SAIi7CJJkPYrIsbih
GbPTHj8URBAc5sl4VyNtNHsiYlxG/QXt35GcPr4A5NSwuWA7mO87/eZtsJHdyGP9
sw67QelT9vs=
=3fG5
-----END PGP SIGNATURE-----

--0i9UvN4f6MWot87p--

