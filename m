References: <1471028087-4781-1-git-send-email-davids@...515...>
	<20160812191348.GH78279@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <92c8a8bf-da08-6164-2807-12d8a2072f40@...2080...>
Date: Fri, 12 Aug 2016 21:28:26 +0200
MIME-Version: 1.0
In-Reply-To: <20160812191348.GH78279@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix warning appearing in newer
 autoconf/libtool version
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/08/16 21:13, Gert Doering wrote:
> Hi,
>=20
> On Fri, Aug 12, 2016 at 08:54:47PM +0200, David Sommerseth wrote:
>> The warning which appears with autoconf-2.69 with libtool-2.4.2
>> is:
>>=20
>> libtoolize: Remember to add 'LT_INIT' to configure.ac.
>>=20
>> Signed-off-by: David Sommerseth <davids@...515...> ---=20
>> configure.ac | 1 + 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/configure.ac b/configure.ac index 4f14ebd..69fdd99
>> 100644 --- a/configure.ac +++ b/configure.ac @@ -58,6 +58,7 @@
>> m4_define([serial_tests], [ AM_INIT_AUTOMAKE(foreign
>> serial_tests) dnl NB: Do not [quote] this parameter.=20
>> AC_CANONICAL_HOST AC_USE_SYSTEM_EXTENSIONS +LT_INIT
>=20
> What does that *do*?  I'm a bit wary of adding stuff to autoconf
> that just appears because a computer says so, especially if it
> smells like "more libtool", as we want *less* libtool for all but
> src/plugins/...

Basically a lot of basic initialization which doesn't seem to be that
intrusive ... from /usr/share/aclocal/libtool.m4:

- --------------------------------------------
# LT_INIT([OPTIONS])
# ------------------
AC_DEFUN([LT_INIT],
[AC_PREREQ([2.58])dnl We use AC_INCLUDES_DEFAULT
AC_REQUIRE([AC_CONFIG_AUX_DIR_DEFAULT])dnl
AC_BEFORE([$0], [LT_LANG])dnl
AC_BEFORE([$0], [LT_OUTPUT])dnl
AC_BEFORE([$0], [LTDL_INIT])dnl
m4_require([_LT_CHECK_BUILDDIR])dnl

dnl Autoconf doesn't catch unexpanded LT_ macros by default:
m4_pattern_forbid([^_?LT_[A-Z_]+$])dnl
m4_pattern_allow([^(_LT_EOF|LT_DLGLOBAL|LT_DLLAZY_OR_NOW|LT_MULTI_MODULE
)$])dnl
dnl aclocal doesn't pull ltoptions.m4, ltsugar.m4, or ltversion.m4
dnl unless we require an AC_DEFUNed macro:
AC_REQUIRE([LTOPTIONS_VERSION])dnl
AC_REQUIRE([LTSUGAR_VERSION])dnl
AC_REQUIRE([LTVERSION_VERSION])dnl
AC_REQUIRE([LTOBSOLETE_VERSION])dnl
m4_require([_LT_PROG_LTMAIN])dnl

_LT_SHELL_INIT([SHELL=3D${CONFIG_SHELL-/bin/sh}])

dnl Parse OPTIONS
_LT_SET_OPTIONS([$0], [$1])

# This can be used to rebuild libtool when needed
LIBTOOL_DEPS=3D"$ltmain"

# Always use our own libtool.
LIBTOOL=3D'$(SHELL) $(top_builddir)/libtool'
AC_SUBST(LIBTOOL)dnl

_LT_SETUP

# Only expand once:
m4_define([LT_INIT])
])# LT_INIT
- --------------------------------------------

Requiring autoconf-2.58 is okay (RHEL5 ships 2.59), otherwise it sets
some variables, some sanity checking and ensures other files with
macros gets loaded.

I'm not stressing this patch, so if anyone wants to test them on
various platforms, please do!  I've tested this on CentOS 5.11,
Scientific Linux 7.2 and Fedora 23.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAleuI1oACgkQDC186MBRfro1pgCgog1tQbATeFm6WxevXILqkLvK
U+8AoI+Xh1vNx3rVE39Ez+FJt8H7EEhG
=3DgwjT
-----END PGP SIGNATURE-----

