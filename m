Date: Thu, 21 Jan 2016 23:02:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160121220227.GS24952@...1296...>
References: <1439311312-2682-1-git-send-email-openvpn.list@...1114...>
	<1439311312-2682-4-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/GKEQaP0opi1bGL"
Content-Disposition: inline
In-Reply-To: <1439311312-2682-4-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/4] autotools: Add support for
 extracting version information from pkg-config modules
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--b/GKEQaP0opi1bGL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 11, 2015 at 06:41:51PM +0200, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  m4/pkg.m4 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/m4/pkg.m4 b/m4/pkg.m4
> index 9a71878..f82496b 100644
> --- a/m4/pkg.m4
> +++ b/m4/pkg.m4
> @@ -107,16 +107,18 @@ AC_DEFUN([PKG_CHECK_MODULES],
>  [AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
>  AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding pkg-confi=
g])dnl
>  AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding pkg-config])dnl
> +AC_ARG_VAR([$1][_MODVERSION], [module version])dnl

Not commenting on these changes, as I have no idea what they do, and no
way to test...  (no system with systemd)

In doubt, buildbot will tell us if it breaks stuff somewhere... so not
opposing this, at seems needed for 4/4.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--b/GKEQaP0opi1bGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqFVc6kuBuNlUUl1AQLcTQQAqHRDCcHdy9FS23nAQI3T9hiWQlc/Yk03
XnjxNmpyDHjwc7pcYUN9kJkgBOhUmVUq4q1rlaBJ5tj+Yo1kwDj9AOrmHMTBmZkl
EFSVLcIb+AhDCQdYtwhLXcMFw5iGa81am+y8vjePSwoxkrhfkFhhcO0+B1Buq21m
owV+Z1aXGK8=
=93u7
-----END PGP SIGNATURE-----

--b/GKEQaP0opi1bGL--

