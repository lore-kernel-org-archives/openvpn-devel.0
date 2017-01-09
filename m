Date: Mon, 9 Jan 2017 21:16:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170109201634.GA76307@...1296...>
References: <d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
	<c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
	<e93e0d67-963a-d677-7d67-323b46e6c3c7@...515...>
	<CAFHpkQFo-W_4_1_6vmBaDfLk8nTHE_=uCi7ZcGES+1iq0sTKxA@...278...>
	<ad02b1ab-1552-7108-e951-65daa05a6680@...2080...>
	<20161219154649.GG78624@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20161219154649.GG78624@...1296...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--rS8CxjVDS/+yyDmU
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 19, 2016 at 04:46:49PM +0100, Gert Doering wrote:
> *Or* just check for GNU ld, and disable cmocka testing if that's not
> available - we already have a check in there that talks about
> "checking for ld used by $CC", which seems to result in=20
>=20
>   "with_gnu_ld=3Dyes"=20
>=20
> if, well, GNU ld is used.  So the cmocka init part could just add a
> check=20
>=20
>    if [ yes !=3D "$with_gnu_ld" ] ...
>=20
> and set CMOCKA_INITIALIZED to "false".  Done.

Trying this avenue.  Configure.ac looks reasonable, the resulting
configure script is a nightmare on steroids, but that wasn't *my* doing
(AM_CONDITIONAL() does some really crazy stuff).

Arne or Ilya, could you test this on MacOS and/or Travis?  I do not
have a working OSX 10.11 build environment right now, so this is=20
"tested on linux" only - it's not breaking things here, but I can't=20
see if it fixes OSX breakage.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1yeeQ81UyVL57Vl7
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Skip-unit-testing-on-systems-without-GNU-ld.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 44f3536e13cbe2814406448d230d175aaac74226 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Mon, 9 Jan 2017 21:08:02 +0100
Subject: [PATCH] Skip unit-testing on systems without GNU ld.

Current unit-testing modules rely on using -Wl,wrap=3D to tell GNU ld
to wrap certain functions for easier mocking.  This fails (at least on)
MacOS X which is no longer using GNU ld.

So, treat GNU ld the same thing as cmake - if it's not there, cmocka
tests are not built and run.

Trac: #813

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 43487b0..265aa64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1266,7 +1266,7 @@ AC_SUBST([TEST_CFLAGS])
 # Check if cmake is available and cmocka git submodule is initialized,
 # needed for unit testing
 AC_CHECK_PROGS([CMAKE], [cmake])
-if test -n "${CMAKE}"; then
+if test -n "${CMAKE}" -a "$with_gnu_ld" =3D "yes"; then
    if test -f "${srcdir}/vendor/cmocka/CMakeLists.txt"; then
       AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
    else
@@ -1274,7 +1274,7 @@ if test -n "${CMAKE}"; then
       AC_MSG_RESULT([!! WARNING !! The cmoka git submodule has not been in=
itialized or updated.  Unit testing cannot be performed.])
    fi
 else
-   AC_MSG_RESULT([!! WARNING !! CMake is NOT available.  Unit testing cann=
ot be performed.])
+   AC_MSG_RESULT([!! WARNING !! CMake is NOT available or not using GNU ld=
=2E  Unit testing cannot be performed.])
    AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
 fi
=20
--=20
2.10.2


--1yeeQ81UyVL57Vl7--

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYc++hAAoJEB2Cnv7KVigS8Z0L/jMp8515BRxkEY9OyenzxAaM
LER+gjgWxyb0Wm6W69nHIjnLCOoP1qFy0R50xNl7ZmquWlaGzgaawmzr6NOGVXjK
+W3shPzvnlxvuhkAEPWdve7TY+LXhE0pwYtuL9GoM5B9jXTZSG5gQR5Ae1dppJK9
GwQuQufI0/w/hemAbbXSzzGNCdrHu8ORmjNvjVuRRNiMUqogk89UQptQYXSMoQWL
/Ms+Kg8q35uuzA3Nkq2gYZWzLDMXaOMKGPbyWJSMTdx2ayO2ZXSo599c8Kg+XQNn
rLEagwT+tI/vLhIijx3hdtfY/xtxh2kgCeiSexNKmV6lTxOSkRL86c7Bb4I3dQpx
fIG2tbUaXxLo7WJoUbrGmt+/Ur97OH3uZ6y2Vav6JTR7ptEPTcfs2+KOh5jrXiBv
QLd5KF4w8IUnKW1SmnPmz9xOIY11+lTa+hyM3KmWjjM3TqGrkin6x3dtONf/Rhza
B9X9Xz2VixuTjPmRJwIgCFcwmIJQqhbJCYnc+d/uHw==
=7uXA
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

