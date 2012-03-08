Message-ID: <4F58781A.2050905@...515...>
Date: Thu, 08 Mar 2012 11:12:58 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-29-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-29-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 28/52] build: remove awk and
 non-standard autoconf output processing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

This looks ok. If I understood it correctly, earlier the Makefile called co=
nfigure_h.awk to parse config.h to generate configure.h. This configure.h f=
ile contained only two defines:

#define CONFIGURE_DEFINES " ENABLE_CLIENT_SERVER ENABLE_DEBUG ENABLE_EUREPH=
IA ..."
#define CONFIGURE_CALL "  $ ./configure "

This patch removes configure_h.awk and thus phases out configure.h. After t=
his change CONFIGURE_DEFINES is generated using this method:

CONFIGURE_DEFINES=3D"`set | grep '^enable_.*=3D' ; set | grep '^with_.*=3D'=
`"

This should be safe if running "set" does not produce output that would mat=
ch the regexps without being related to the OpenVPN builds. Given that the =
regexps are very strictly defined, that doesn't sound likely.

I give this one an ACK. Please NACK if you disagree :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Replace with simpler environment solution.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  Makefile.am       |   12 ++----------
>  configure.ac      |    3 +++
>  configure_h.awk   |   39 ---------------------------------------
>  configure_log.awk |   33 ---------------------------------
>  options.c         |    4 ----
>  5 files changed, 5 insertions(+), 86 deletions(-)
>  delete mode 100644 configure_h.awk
>  delete mode 100644 configure_log.awk
>
> diff --git a/Makefile.am b/Makefile.am
> index 6c0b2b4..a8ff457 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -36,7 +36,7 @@ MAINTAINERCLEANFILES =3D \
>  	$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
>  	$(srcdir)/config.guess $(srcdir)/config.sub \
>  	$(srcdir)/openvpn.spec
> -CLEANFILES =3D openvpn.8.html configure.h
> +CLEANFILES =3D openvpn.8.html
>=20=20
>  EXTRA_DIST =3D \
>  	sample-config-files \
> @@ -57,8 +57,7 @@ dist_doc_DATA =3D \
>=20=20
>  dist_noinst_SCRIPTS =3D \
>  	$(TESTS) \
> -	t_cltsrv-down.sh \
> -	configure_h.awk configure_log.awk
> +	t_cltsrv-down.sh
>=20=20
>  dist_doc_DATA =3D \
>  	COPYRIGHT.GPL \
> @@ -156,13 +155,6 @@ openvpn_SOURCES =3D \
>  	win32.h win32.c \
>  	cryptoapi.h cryptoapi.c
>=20=20
> -nodist_openvpn_SOURCES =3D configure.h
> -options.$(OBJEXT): configure.h
> -
> -configure.h: Makefile
> -	awk -f $(srcdir)/configure_h.awk config.h > $@
> -	awk -f $(srcdir)/configure_log.awk config.log >> $@
> -
>  if WIN32
>  dist_noinst_DATA +=3D openvpn.8
>  nodist_html_DATA =3D openvpn.8.html
> diff --git a/configure.ac b/configure.ac
> index 81bf933..0b70325 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -913,6 +913,9 @@ if test "${enable_strict}" =3D "yes"; then
>  	CFLAGS=3D"${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
>  fi
>=20=20
> +CONFIGURE_DEFINES=3D"`set | grep '^enable_.*=3D' ; set | grep '^with_.*=
=3D'`"
> +AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"],=
 [Configuration settings])
> +
>  TAP_WIN_COMPONENT_ID=3D"PRODUCT_TAP_WIN_COMPONENT_ID"
>  TAP_WIN_MIN_MAJOR=3D"PRODUCT_TAP_WIN_MIN_MAJOR"
>  TAP_WIN_MIN_MINOR=3D"PRODUCT_TAP_WIN_MIN_MINOR"
> diff --git a/configure_h.awk b/configure_h.awk
> deleted file mode 100644
> index 672e745..0000000
> --- a/configure_h.awk
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -#
> -#  OpenVPN -- An application to securely tunnel IP networks
> -#             over a single UDP port, with support for SSL/TLS-based
> -#             session authentication and key exchange,
> -#             packet encryption, packet authentication, and
> -#             packet compression.
> -#
> -#  Copyright (C) 2010  David Sommerseth <dazo@...384...>
> -#
> -#  This program is free software; you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License version 2
> -#  as published by the Free Software Foundation.
> -#
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#  GNU General Public License for more details.
> -#
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program (see the file COPYING included with this
> -#  distribution); if not, write to the Free Software Foundation, Inc.,
> -#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> -#
> -#
> -#  This script will build up a line which can be included into a C progr=
am.
> -#  The line will contain all interesting #define statements from f.ex. .=
/config.h
> -#
> -
> -BEGIN {
> -	printf ("#define CONFIGURE_DEFINES \"")
> -}
> -
> -/^#define (ENABLE|DISABLE|DEPRECATED|USE)_/ {
> -	printf (" %s", $2)
> -}
> -
> -END {
> -	printf ("\"\n")
> -}
> diff --git a/configure_log.awk b/configure_log.awk
> deleted file mode 100644
> index 099e5c4..0000000
> --- a/configure_log.awk
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -#
> -#  OpenVPN -- An application to securely tunnel IP networks
> -#             over a single UDP port, with support for SSL/TLS-based
> -#             session authentication and key exchange,
> -#             packet encryption, packet authentication, and
> -#             packet compression.
> -#
> -#  Copyright (C) 2010  David Sommerseth <dazo@...384...>
> -#
> -#  This program is free software; you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License version 2
> -#  as published by the Free Software Foundation.
> -#
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#  GNU General Public License for more details.
> -#
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program (see the file COPYING included with this
> -#  distribution); if not, write to the Free Software Foundation, Inc.,
> -#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> -#
> -#
> -#  This script will build up a line which can be included into a C progr=
am.
> -#  The line will only contain the first entry of the ./configure line fr=
om
> -#  ./config.log.
> -#
> -
> -/\$ (.*)\/configure/ {
> -	printf ("#define CONFIGURE_CALL \"%s\"\n", $0)
> -	exit 0
> -}
> diff --git a/options.c b/options.c
> index b0ae7fd..d7f848e 100644
> --- a/options.c
> +++ b/options.c
> @@ -49,7 +49,6 @@
>  #include "helper.h"
>  #include "manage.h"
>  #include "forward.h"
> -#include "configure.h"
>  #include <ctype.h>
>=20=20
>  #include "memdbg.h"
> @@ -3403,9 +3402,6 @@ usage_version (void)
>    msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
>    msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2010 OpenVPN Technologies,=
 Inc. <sales@...515...>");
>  #ifndef ENABLE_SMALL
> -#ifdef CONFIGURE_CALL
> -  msg (M_INFO|M_NOPREFIX, "\n%s\n", CONFIGURE_CALL);
> -#endif
>  #ifdef CONFIGURE_DEFINES
>    msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
>  #endif



