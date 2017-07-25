Date: Tue, 25 Jul 2017 21:05:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170725190524.GD70062@...1296...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
 <b6adb528-5d31-fa7b-cd0c-e87b69e0854c@...515...>
 <CAFHpkQH-vpQJb043xsdy4BmD0khxCD1dPrJ=KZ2OQoiLvDxS3Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aziWXe2aaRGlkyg3"
Content-Disposition: inline
In-Reply-To: <CAFHpkQH-vpQJb043xsdy4BmD0khxCD1dPrJ=KZ2OQoiLvDxS3Q@...278...>
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@...1866...>

--aziWXe2aaRGlkyg3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 25, 2017 at 10:18:53PM +0500, ???????? ?????????????? wrote:
> that said, I think such build events should go to openvpn's Makefile.

NAK.  OpenVPN's Makefile does not care where pkcs11-helper is coming=20
from - it expects something proper to be installed in the build=20
environment.  It's not OpenVPN's job to figure out where to get stuff
from - this is why we have openvpn-build for "complicated" cases.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--aziWXe2aaRGlkyg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZd5Z0AAoJEB2Cnv7KVigSkgAL/0G/OY0RpvbbdNLCxIFX1H6R
hqyc/0RzM4h9kmaNLEqJ9Pbx+APHPHg2qzYmrniDCR7/8+/V1Y+VQVWqBaPpexwo
GC1U28zWMT6a/Dvr556ztyuw7RDePJ2D+N6RgWeiR5+yxpfS0EyAmYiERWVP16XV
allWjqUktrC/l7a8oVEcpYDscWG6tsGSVtMZmH06k6H0kJrXtEllaZM+i+5aDtVn
+O8h6wwaQphOATzl7p4GdaBm2vtt+hFGsq6dXcwyYwF8hXPcMgmsG1Ke1d722Q1s
vv6DSlkjBNIF0TytUinVfYKZ8CBEwxZmmqJfXHlr6+qBy58FKKz1/w1Amcymn+7f
ggwtvXrFovefIUwDEoRP5Skh8nLyjDtiR4P1B8MeZAa6fOMSLbN1563JyUr7FWpw
Nmz2NzMCrSasWPfnA0o1q9r0t6MJ9mlShuQLC6vJCPUrOR1Zll7nxisTLffb0ptn
VTM9msFJEZc2IlMlU7K+DRC4agpq0a8AFdBcY7c6WA==
=hMyw
-----END PGP SIGNATURE-----

--aziWXe2aaRGlkyg3--

