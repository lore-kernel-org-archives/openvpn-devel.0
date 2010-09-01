Date: Wed, 1 Sep 2010 15:58:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100901135851.GW10703@...1296...>
References: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1PHmS26pdpOR3Xc0"
Content-Disposition: inline
In-Reply-To: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Allan Swanepoel <allanice001@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--1PHmS26pdpOR3Xc0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 01, 2010 at 02:58:59PM +0200, Allan Swanepoel wrote:
> Hi All, I'm fairly new to building openvpn for windows (have been
> building on Linux since 2.0),
> I have a small customization that I make to the openvpn sourcecode to
> call external software on initialization, and would like to build a
> Windows build with this in.

You can do two things - cross-build with mingw under linux (producing
openvpn.exe binaries for windows), or build with mingw+msys under
windows.

If you want to do the latter, read the file "domake-win" in the OpenVPN
source tree - it's the script that does the windows building, and it
contains the instructions as well.

If you use the pre-compiled tun/tap driver from the 2.1.3 windows
bundle, you don't need the MS DDK/WDK, just msys+mingw and the NSIS
installer-builder.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1PHmS26pdpOR3Xc0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTH5cGqkuBuNlUUl1AQIkAQP/aBf7mDE8xJ1uuU5mQHkcN9nSAmp+3Kwx
pqC3YR7ywiyQptgwE12Gfl6yJOnHJi0yPM89pmZwCl8UH9wCYcipsd14O/W9+HFU
E/lpDyGIbKXk2Cqi4C1S35q+P3Aw0MlR35fxEPkP5ULtDdndpAV1/p5bVtB/Bci7
VjpVK2UBHJQ=
=8oOC
-----END PGP SIGNATURE-----

--1PHmS26pdpOR3Xc0--

