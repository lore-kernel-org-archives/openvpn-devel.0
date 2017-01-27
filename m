Date: Fri, 27 Jan 2017 10:55:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170127095502.GZ940@...1296...>
References: <20170126080519.GN940@...1296...>
	<20170127084927.21040-1-list@...1798...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HywJcj55HbA57jnN"
Content-Disposition: inline
In-Reply-To: <20170127084927.21040-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] remove GNUism and fix out-of-tree
	build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>

--HywJcj55HbA57jnN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 27, 2017 at 09:49:27AM +0100, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> The plugin path handling cleanup (4590c383) introduced GNUism and broke
> out-of-tree builds.
>=20
> Revert back to let configure generate the header file. Instead let make
> add an extra CFLAG that defines PLUGIN_LIBDIR.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>

ACK.  Gets the job done and fixes the fallout :-)

Tested on FreeBSD 10.3, OpenBSD 6.0 and OpenSolaris 11 - so I blatantly
assume it will also work on all the rest of the zoo.

For a v7 of this... we might consider whether to print out the plugin
search path at "--help" or "--version" time (we already print the whole
autoconf sermon)...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HywJcj55HbA57jnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYixj1AAoJEB2Cnv7KVigSiEsL/0hBdvh/0CgWVQPbCeakJ4ZH
b+oLEciZT5adRI8qD/g5Gk8ILdGs8nkQK0PYGy54WOuqlLT8rNS1tvzzHvLqYkIG
sxDp3OJGuCE6nr+Rc4ASvvJAtQ04W9m3S5achGe967xn28xgF/fm9bhF6n3vfOLW
/FVRRtDLAAki2h5/MY/nW7zJJ7K3hFXXFMboA4K20IZHHt9gdYy8egwFlprSo4Mk
qYTHpVZEY5uhO4WkQfeDU18+MYFqcMKguelqBk//gacfmhGHkERd9uLSieOIgUIy
/XcM04ueO/1mqTShF6ok4R8tFiE5Et0ZazhpADuupACN23rB4xMmNFgqmqEN8E1g
cycBcPWWELTHJpu76MlvJ1B3cDjM/Owet8tMJ5q3CMROtFH6o2Ix5G8xu7DSZZYL
XsXfagox4NBOqFI2nwnSri0RlldezWOI3hBla4WPH5D42ZWCRSSO/sMxort08YWz
l3ufcciZrJQdFedC8zM8hv5Mx0KQuJiS/Busq8nbzw==
=Z2+5
-----END PGP SIGNATURE-----

--HywJcj55HbA57jnN--

