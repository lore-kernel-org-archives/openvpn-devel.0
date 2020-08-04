Date: Tue, 4 Aug 2020 21:39:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200804193943.GU75094@...1296...>
References: <20200731100629.24611-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pE2VAHO2njSJCslu"
Content-Disposition: inline
In-Reply-To: <20200731100629.24611-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Skip existing interfaces on opening the
 first available utun on macOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--pE2VAHO2njSJCslu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 31, 2020 at 12:06:29PM +0200, Arne Schwabe wrote:
> This avoids the error messages trying to open already used utuns.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

I think the code looks good, but I have no time right now to test it
(I can build MacOS binaries but have no test environment set up
"just now").

Jonathan, do you have time?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pE2VAHO2njSJCslu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfKbl+AAoJEB2Cnv7KVigSS/MMAJOyAHfTvgmGtWly2ptezkfL
3QvIHOcEb8pJrBAvqaXP9QKPvIH+6BuCnq6ODyTV7Tmxpo6YYxFqrgFdE82b1C2A
OZGd+12eyYyJXCFyr9AN4rH91K5Qvy7oeo0Q+U2K9LfS1qU3DgY8uLP6+LaDjcCR
Of2dOr3udIzKOuwPa5X6I2SxKf6V4T0vvpsSOk1pVs5ptdGC6cUyain3iBFKGm/l
S9O5fLF1j3zQACVuK0MlVQmIyoxoxoTjXNrgoHjMet+bYiAa4NopkkPfiigb6vMA
mBmEoG0Yj2DClHRYRsYDRijrlPlaeMtVMA1EYEb2R6OQP1deDZggG/G4yShRTawv
zHOyV8O1Lyh3fn5QQWpHU0gvflsJTfgtfN723E4+8lvpQawEw0Rf1rekdgBpOrUm
rPMQtWSWhbbcurJaucJPp/hmNgrPDYE7h+lv5Q3chDhK48QR6ca6frhWrhb1ZASo
6VQ4tXHxZGHcpV6L/2hCBXToCjw/OGcAfLje5KUAvg==
=ZDmE
-----END PGP SIGNATURE-----

--pE2VAHO2njSJCslu--

