Date: Mon, 7 Dec 2015 08:16:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151207071641.GR24952@...1296...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uaevfG5uZ9KhizUI"
Content-Disposition: inline
In-Reply-To: <1449446507-16654-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH master] Add an autoconf macro to check
 WINAPI functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--uaevfG5uZ9KhizUI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 06, 2015 at 07:01:46PM -0500, Selva Nair wrote:
> This adds a macro file with a permissive license. Its small so I don't
> mind inlining the macro into configure.ac if that is preferred.
> -------8<--------

This looks interesting, but I'm not convinced that this actually *works* -=
=20
the reason why I had to add an explicit compile test is that the standard
configure.ac test will claim "inet_pton is not there" because the way
the test program is built conflicts with the definitions in wstcpip.h

Which environments did you test this on?  It needs to work on mingw as
shipped with ubuntu 12.04 (no inet_pton), mingw as shipped with 14.04
(inet_pton, *and* the definition its using conflicts with our compat/
libraries, so a false negative will fail later) and cygwin.

It's not pretty, but it's the way it is for a reason :-)

> +          [AC_TRY_COMPILE([#include <$2>], [(void) $1;],

This is wrong on multiple levels, actually

 - it will only try compilation, not linking - so all we know is "we did
   not conflict with a header file", not "this function exists and this
   combination of header files and function calls will make us link the
   right stuff" (from the docs "This macro does not try to link; use=20
   AC_TRY_LINK if you need to do that")

 - it will build a test program that will not call the function searched
   correctly, just "(void) inet_pton()".  Which will actually make it
   *fail* on MinGW on ubuntu 14.04 - there *is* a prototype, so it must
   be called correctly.


There's a reason for commit f96baabc6cf10edddedda1819a27a6927f274d8e :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uaevfG5uZ9KhizUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmUyWKkuBuNlUUl1AQKTAAQAnwfikSHVQTNpd6izBoMsdoETtrCaOnHS
SyRqJ1++ibrKOBsX1dQZBo5CE2U/xGaMpeuVmww/xBwx3icobIUkvFg8xBV3g0bW
shj80Cssrslfn4jRRgn1g7077/V+aSY7LHMgb7tYVgcAWzM6tLu6nZkAP+Ys8nUt
R/rNskbgU0o=
=Ppp9
-----END PGP SIGNATURE-----

--uaevfG5uZ9KhizUI--

