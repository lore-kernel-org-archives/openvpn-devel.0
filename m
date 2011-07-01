Date: Fri, 1 Jul 2011 22:49:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110701204928.GX8496@...1296...>
References: <4E0DD5E4.2040609@...515...>
	<201107011929.47404.hhund@...194...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fe9KwyZAx9D5K0S8"
Content-Disposition: inline
In-Reply-To: <201107011929.47404.hhund@...194...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (30th June 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

--Fe9KwyZAx9D5K0S8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 01, 2011 at 07:29:47PM +0200, Heiko Hund wrote:
> Have you guys considered autotools for building native WIN32 binaries in=
=20
> cygwin? We use it for building openvpn itself. With a little effort one c=
ould=20
> even build the driver, sign the binaries and create the installer using m=
ake=20
> targets.

I haven't considered it yet, mostly because I don't know my way around
windows.  So, if I understand you right, you can use cygwin as a build
platform, but the resulting openvpn.exe will run on machines without
cygwin installed ("as for mingw-built openvpn.exe")?

That would be interesting, given that there seems to doubt regarding the
(long-term) community support behind mingw, and cygwin is traditionally
supported quite well.

And indeed, having all nicely included in the main make file would make
windows building a lot easier.


> I'm not sure if that would be more convenient for the majority of the peo=
ple=20
> building openvpn for Windows, but it feels more like home to me. =3D)

I like msys/mingw - "bash.exe" :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Fe9KwyZAx9D5K0S8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTg4y2KkuBuNlUUl1AQJgpAP9H5QXK+kE1P06/z4Ad8pZM43KfVwb0VBA
ythFAcxJPUhdGVOh+7/HkW3ZQ7Qot4zV12EZb8ilWWKWakhDbdEHEZZ+sN0lYQsi
UGxrpd2z+W3jdO5hNZ6t1+uFEkMeSq+MH/82pIbi+0t0Q8nThPlCu+yYpngKCHRj
1IsKk5lko18=
=NXc9
-----END PGP SIGNATURE-----

--Fe9KwyZAx9D5K0S8--

