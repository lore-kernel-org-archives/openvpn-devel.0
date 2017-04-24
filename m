Date: Mon, 24 Apr 2017 19:14:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170424171415.GE30424@...1296...>
References: <CAGTTMwpo5XkFE5D0v=ah5SEywN1BRDQOa-=TVYukTN0ZYcwe9A@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gWRamliw218YCZO9"
Content-Disposition: inline
In-Reply-To: <CAGTTMwpo5XkFE5D0v=ah5SEywN1BRDQOa-=TVYukTN0ZYcwe9A@...278...>
Subject: Re: [Openvpn-devel] Is MSVC the only way to build the openVPN app
 on Windows platform?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Chong M <chongyang.man@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--gWRamliw218YCZO9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 24, 2017 at 11:44:37AM -0500, Chong M wrote:
> Is MSVC the only way to build the openVPN app on Windows platform? Thanks!

Supposedly using Cygwin and mingw also works.

The official binaries are installers for windows are built on Ubuntu using
a cross-compile environment (mingw).  Our trac has detailed instructions.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gWRamliw218YCZO9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY/jJmAAoJEB2Cnv7KVigSI9gL/0hNjqZmsChW0GbuOTaxFOel
SSFsZZ8xAdo/FsmfLADk4zfuQoCeyrPF3PrZz2End9CwHt+v24C7el2leOp6473+
7hkMb1xN9Ng5Fbu6x+MP1L7IoSlva2BxkHNTbDuLmJt9smW+rPiHRbLkt8YyOSQ+
1JItsSVifFHEPWFx9ijKI2MUrwJderY0VzRBCG6kVhliyl3fxQJrhq7VGGFquGOV
eXMP3NmHAE6/MqCwM79u5uU4TRyKY8BOFay2tkF7J7q431hR17bhZoVCfdNXryU8
OoiD9YEkVDoeFnm5mcEEDT1bEmZeRlLKGFM9djOSzSsB2A0n140H2Bv6/h8l6Xvj
k7TUSNY4ko2vGT3j8FrLbE2Nixwz7wGxDLtLuW5PCy+doaTDrdvyA2GwBcTTHE5g
UUjVy9i1KAfn9fbW2tT0dxU0GoaRofM1IiYIExfDUl5z6U5z1HMUs4kLYSFibpvP
4o5yGhtNvuUkBf77EHuUs1o0sou8cuYCFsK25hGGcQ==
=WmDk
-----END PGP SIGNATURE-----

--gWRamliw218YCZO9--

