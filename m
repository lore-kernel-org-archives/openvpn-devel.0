Date: Wed, 22 Feb 2012 09:26:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120222082619.GJ7024@...1296...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<4F44A1A3.8050007@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HwY7O+GdaLKMYOv"
Content-Disposition: inline
In-Reply-To: <4F44A1A3.8050007@...515...>
Subject: Re: [Openvpn-devel] [build] Windows build test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--+HwY7O+GdaLKMYOv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 22, 2012 at 10:04:51AM +0200, Samuli Sepp=E4nen wrote:
> > While you at it, please try to explain me why we need Visual Studio bui=
ld... :)
> I guess for building the TAP-driver.=20

No, that one builds fine with the msys build environment and the
windows ddk.

We have Visual Studio because James was afraid that mingw would stop
being supported, leaving us without a viable build environment.  Which
turns out to be not a real problem (yet), given that mingw64 seems to=20
be supported quite well.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+HwY7O+GdaLKMYOv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0Smq6kuBuNlUUl1AQKjFgP/Yoon6/EQayENI4WYzNJM5lSnlGfJmYzF
BR0g1GybQ4zbDPni591k5Pl3uqvqD/19KFC1i7sHoofKvZB3a1FAL9ijJs0YnoWI
W6SCtEI9S4jiUu9fTCrQ3AgJ1OYSnT6i5KHkI4WPLJeiMCE34NhxAfX2pDbYNI0z
hoHehpMCX8c=
=zl5z
-----END PGP SIGNATURE-----

--+HwY7O+GdaLKMYOv--

