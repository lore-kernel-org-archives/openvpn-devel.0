Message-ID: <4F632BEB.80504@...515...>
Date: Fri, 16 Mar 2012 14:02:51 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-31-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-31-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 30/52] build: add libtool + windows
 resources for executables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi,

This patch was ACKed in the IRC meeting on 15th Mar 2012:

<http://thread.gmane.org/gmane.network.openvpn.devel/5992>

However some of the lines in "src/openvpn/openvpn_win32_resources.rc"
may need to be fixed:

VALUE "CompanyName", "OpenVPN.net"
VALUE "LegalCopyright", "Copyright =EF=BF=BD OpenVPN Project"

Quoting
http://msdn.microsoft.com/en-us/library/windows/desktop/aa381058%28v=3Dvs.8=
5%29.aspx

"CompanyName    Company that produced the file, for example, "Microsoft
Corporation" or "Standard Microsystems Corporation, Inc." This string is
required."

"LegalCopyright    Copyright notices that apply to the file. This should
include the full text of all notices, legal symbols, copyright dates,
and so on. This string is optional."

I think we could use the same entity name (e.g. "OpenVPN project") in
both fields. I also think that the choice of wording revolves around
copyright ownership... in 2.1.x series James Yonan/OpenVPN Technologies,
Inc. owned _most_ of the copyrights to the codebase. However, in this
post-2.3-alpha1 age, copyrights to very large parts of the codebase
belong to community developers. So, attributing copyright to "OpenVPN
Technologies, Inc. and contributors" would probably not be proper.

So, what should we call this "entity" that owns the copyrights to the
codebase?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


PS. I'll try to apply some  Git magic to produce concrete numbers
regarding the copyright ownership in the OpenVPN codebase.


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  .gitignore                               |    6 ++++
>  Makefile.am                              |    5 +++-
>  build/Makefile.am                        |   15 +++++++++++
>  build/ltrc.inc                           |   23 ++++++++++++++++
>  configure.ac                             |   20 ++++++++++++++-
>  src/openvpn/Makefile.am                  |    6 ++++
>  src/openvpn/openvpn_win32_resources.rc   |   41 ++++++++++++++++++++++++=
++++++
>  src/openvpnserv/Makefile.am              |    5 +++-
>  src/openvpnserv/openvpnserv_resources.rc |   41 ++++++++++++++++++++++++=
++++++
>  version.m4                               |    1 +
>  10 files changed, 160 insertions(+), 3 deletions(-)
>  create mode 100644 build/Makefile.am
>  create mode 100644 build/ltrc.inc
>  create mode 100644 src/openvpn/openvpn_win32_resources.rc
>  create mode 100644 src/openvpnserv/openvpnserv_resources.rc
>
> diff --git a/.gitignore b/.gitignore
> index 46cd4c8..156b2c2 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -26,6 +26,12 @@ depcomp
>  stamp-h1
>  install-sh
>  missing
> +ltmain.sh
> +m4/libtool.m4
> +m4/ltoptions.m4
> +m4/ltsugar.m4
> +m4/ltversion.m4
> +m4/lt~obsolete.m4
>
>  doc/openvpn.8.html
>  distro/rpm/openvpn.spec
> diff --git a/Makefile.am b/Makefile.am
> index 850074b..ebc2252 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -34,6 +34,9 @@ MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in \
>         $(srcdir)/config.h.in $(srcdir)/config.h.in~ $(srcdir)/configure \
>         $(srcdir)/install-sh $(srcdir)/ltmain.sh $(srcdir)/missing \
> +       $(srcdir)/m4/libtool.m4 $(srcdir)/m4/lt~obsolete.m4 \
> +       $(srcdir)/m4/ltoptions.m4 $(srcdir)/m4/ltsugar.m4 \
> +       $(srcdir)/m4/ltversion.m4 \
>         $(srcdir)/depcomp $(srcdir)/aclocal.m4 \
>         $(srcdir)/config.guess $(srcdir)/config.sub
>
> @@ -41,7 +44,7 @@ EXTRA_DIST =3D \
>         contrib \
>         debug
>
> -SUBDIRS =3D distro include src sample doc tests
> +SUBDIRS =3D build distro include src sample doc tests
>
>  dist_doc_DATA =3D \
>         COPYRIGHT.GPL \
> diff --git a/build/Makefile.am b/build/Makefile.am
> new file mode 100644
> index 0000000..a993b20
> --- /dev/null
> +++ b/build/Makefile.am
> @@ -0,0 +1,15 @@
> +#
> +#  OpenVPN -- An application to securely tunnel IP networks
> +#             over a single UDP port, with support for SSL/TLS-based
> +#             session authentication and key exchange,
> +#             packet encryption, packet authentication, and
> +#             packet compression.
> +#
> +#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#
> +
> +MAINTAINERCLEANFILES =3D \
> +       $(srcdir)/Makefile.in
> +
> +EXTRA_DIST =3D \
> +       ltrc.inc
> diff --git a/build/ltrc.inc b/build/ltrc.inc
> new file mode 100644
> index 0000000..701f200
> --- /dev/null
> +++ b/build/ltrc.inc
> @@ -0,0 +1,23 @@
> +#
> +#  OpenVPN -- An application to securely tunnel IP networks
> +#             over a single UDP port, with support for SSL/TLS-based
> +#             session authentication and key exchange,
> +#             packet encryption, packet authentication, and
> +#             packet compression.
> +#
> +#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
> +#
> +# Required to build Windows resource file
> +
> +RCCOMPILE =3D $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
> +       $(AM_CPPFLAGS) $(CPPFLAGS)
> +LTRCCOMPILE =3D $(LIBTOOL) --mode=3Dcompile --tag=3DRC $(RCCOMPILE)
> +
> +.rc.lo:
> +       $(LTRCCOMPILE) -i "$<" -o "$@"
> +
> +.rc.o:
> +       $(RCCOMPILE) -i "$<" -o "$@"
> +
> +.mc.rc:
> +       $(WINDMC) "$<"
> diff --git a/configure.ac b/configure.ac
> index fe0fbab..6b5cf71 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -29,6 +29,8 @@ AC_PREREQ(2.59)
>  m4_include(version.m4)
>  AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRODUCT=
_TARNAME])
>  m4_include(compat.m4)
> +AC_DEFINE([OPENVPN_VERSION_RESOURCE], [PRODUCT_VERSION_RESOURCE], [Versi=
on in windows resource format])
> +
>  AC_CONFIG_AUX_DIR([.])
>  AM_CONFIG_HEADER([config.h])
>  AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
> @@ -352,7 +354,6 @@ case "$host" in
>                 AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix=
])
>                 CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=3D=
0x0501"
>                 WIN32=3Dyes
> -               LIBS=3D"${LIBS} -lgdi32 -lws2_32 -lwininet -lcrypt32 -lip=
hlpapi -lwinmm -lshell32"
>                 ;;
>         *-*-dragonfly*)
>                 AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on Dra=
gonFlyBSD?])
> @@ -369,6 +370,22 @@ AC_PROG_INSTALL
>  AC_PROG_LN_S
>  AC_PROG_MAKE_SET
>
> +#
> +# Libtool
> +#
> +ifdef(
> +       [LT_INIT],
> +       [
> +               LT_INIT([win32-dll])
> +               LT_LANG([Windows Resource])
> +       ],
> +       [
> +               AC_LIBTOOL_WIN32_DLL
> +               AC_LIBTOOL_RC
> +               AC_PROG_LIBTOOL
> +       ]
> +)
> +
>  if test "${WIN32}" =3D "yes"; then
>         AC_ARG_VAR([MAN2HTML], [man2html utility])
>         AC_CHECK_PROGS([MAN2HTML], [man2html])
> @@ -930,6 +947,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>
>  AC_CONFIG_FILES([
>         Makefile
> +       build/Makefile
>         distro/Makefile
>         distro/rpm/Makefile
>         distro/rpm/openvpn.spec
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 4a6b497..a509bba 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -9,6 +9,8 @@
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>
> +include $(top_srcdir)/build/ltrc.inc
> +
>  MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in
>
> @@ -93,3 +95,7 @@ openvpn_SOURCES =3D \
>         tun.c tun.h \
>         win32.h win32.c \
>         cryptoapi.h cryptoapi.c
> +if WIN32
> +openvpn_SOURCES +=3D openvpn_win32_resources.rc
> +openvpn_LDADD =3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinm=
m -lshell32
> +endif
> diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn=
_win32_resources.rc
> new file mode 100644
> index 0000000..e91bfa1
> --- /dev/null
> +++ b/src/openvpn/openvpn_win32_resources.rc
> @@ -0,0 +1,41 @@
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#else
> +#include <config-msc-version.h>
> +#endif
> +#include <winresrc.h>
> +
> +LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
> +
> +VS_VERSION_INFO VERSIONINFO
> + FILEVERSION OPENVPN_VERSION_RESOURCE
> + PRODUCTVERSION OPENVPN_VERSION_RESOURCE
> + FILEFLAGSMASK 0x3fL
> +#ifdef _DEBUG
> + FILEFLAGS 0x1L
> +#else
> + FILEFLAGS 0x0L
> +#endif
> + FILEOS 0x40004L
> + FILETYPE 0x2L
> + FILESUBTYPE 0x0L
> +BEGIN
> +    BLOCK "StringFileInfo"
> +    BEGIN
> +        BLOCK "040904b0"
> +        BEGIN
> +            VALUE "CompanyName", "OpenVPN.net"
> +            VALUE "FileDescription", "OpenVPN"
> +            VALUE "FileVersion", PACKAGE_VERSION ".0"
> +            VALUE "InternalName", "OpenVPN"
> +            VALUE "LegalCopyright", "Copyright =EF=BF=BD OpenVPN Project"
> +            VALUE "OriginalFilename", "openvpn.exe"
> +            VALUE "ProductName", "OpenVPN"
> +            VALUE "ProductVersion", PACKAGE_VERSION ".0"
> +        END
> +    END
> +    BLOCK "VarFileInfo"
> +    BEGIN
> +        VALUE "Translation", 0x409, 1200
> +    END
> +END
> diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
> index 7ce3375..58005c0 100644
> --- a/src/openvpnserv/Makefile.am
> +++ b/src/openvpnserv/Makefile.am
> @@ -9,6 +9,8 @@
>  #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
>  #
>
> +include $(top_srcdir)/build/ltrc.inc
> +
>  MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in
>
>  if WIN32
> @@ -17,4 +19,5 @@ endif
>
>  openvpnserv_SOURCES =3D \
>         openvpnserv.c \
> -       service.h service.c
> +       service.h service.c \
> +       openvpnserv_resources.rc
> diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/o=
penvpnserv_resources.rc
> new file mode 100644
> index 0000000..b87f4a3
> --- /dev/null
> +++ b/src/openvpnserv/openvpnserv_resources.rc
> @@ -0,0 +1,41 @@
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#else
> +#include <config-msc-version.h>
> +#endif
> +#include <winresrc.h>
> +
> +LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
> +
> +VS_VERSION_INFO VERSIONINFO
> + FILEVERSION OPENVPN_VERSION_RESOURCE
> + PRODUCTVERSION OPENVPN_VERSION_RESOURCE
> + FILEFLAGSMASK 0x3fL
> +#ifdef _DEBUG
> + FILEFLAGS 0x1L
> +#else
> + FILEFLAGS 0x0L
> +#endif
> + FILEOS 0x40004L
> + FILETYPE 0x2L
> + FILESUBTYPE 0x0L
> +BEGIN
> +    BLOCK "StringFileInfo"
> +    BEGIN
> +        BLOCK "040904b0"
> +        BEGIN
> +            VALUE "CompanyName", "OpenVPN.net"
> +            VALUE "FileDescription", "OpenVPN Service"
> +            VALUE "FileVersion", PACKAGE_VERSION ".0"
> +            VALUE "InternalName", "OpenVPN"
> +            VALUE "LegalCopyright", "Copyright =EF=BF=BD OpenVPN Project"
> +            VALUE "OriginalFilename", "openvpnserv.exe"
> +            VALUE "ProductName", "OpenVPN"
> +            VALUE "ProductVersion", PACKAGE_VERSION ".0"
> +        END
> +    END
> +    BLOCK "VarFileInfo"
> +    BEGIN
> +        VALUE "Translation", 0x409, 1200
> +    END
> +END
> diff --git a/version.m4 b/version.m4
> index 29ec047..2bd1401 100644
> --- a/version.m4
> +++ b/version.m4
> @@ -3,6 +3,7 @@ define([PRODUCT_NAME], [OpenVPN])
>  define([PRODUCT_TARNAME], [openvpn])
>  define([PRODUCT_VERSION], [2.3_alpha1])
>  define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
> +define([PRODUCT_VERSION_RESOURCE], [2,3,0,0])
>  dnl define the TAP version
>  define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
>  define([PRODUCT_TAP_WIN_MIN_MAJOR], [9])
> --
> 1.7.3.4
>
>


