MIME-Version: 1.0
In-Reply-To: <4F632BEB.80504@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-31-git-send-email-alon.barlev@...277...>
	<4F632BEB.80504@...515...>
Date: Fri, 16 Mar 2012 14:08:28 +0200
Message-ID: <CAOazyz2n_DnBjzWixioxZjPOeO+NjZNhhMRf2hDgMAF_HC49eA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

I left the OpenVPN.net not to cause copyright discussion :)
But here we are...
"The OpenVPN Project" is good for me.

2012/3/16 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi,
>
> This patch was ACKed in the IRC meeting on 15th Mar 2012:
>
> <http://thread.gmane.org/gmane.network.openvpn.devel/5992>
>
> However some of the lines in "src/openvpn/openvpn_win32_resources.rc"
> may need to be fixed:
>
> VALUE "CompanyName", "OpenVPN.net"
> VALUE "LegalCopyright", "Copyright =EF=BF=BD OpenVPN Project"
>
> Quoting
> http://msdn.microsoft.com/en-us/library/windows/desktop/aa381058%28v=3Dvs=
.85%29.aspx
>
> "CompanyName =C2=A0 =C2=A0Company that produced the file, for example, "M=
icrosoft
> Corporation" or "Standard Microsystems Corporation, Inc." This string is
> required."
>
> "LegalCopyright =C2=A0 =C2=A0Copyright notices that apply to the file. Th=
is should
> include the full text of all notices, legal symbols, copyright dates,
> and so on. This string is optional."
>
> I think we could use the same entity name (e.g. "OpenVPN project") in
> both fields. I also think that the choice of wording revolves around
> copyright ownership... in 2.1.x series James Yonan/OpenVPN Technologies,
> Inc. owned _most_ of the copyrights to the codebase. However, in this
> post-2.3-alpha1 age, copyrights to very large parts of the codebase
> belong to community developers. So, attributing copyright to "OpenVPN
> Technologies, Inc. and contributors" would probably not be proper.
>
> So, what should we call this "entity" that owns the copyrights to the
> codebase?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> PS. I'll try to apply some =C2=A0Git magic to produce concrete numbers
> regarding the copyright ownership in the OpenVPN codebase.
>
>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0.gitignore =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 ++++
>> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 +++-
>> =C2=A0build/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 15 +++++++++++
>> =C2=A0build/ltrc.inc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 23 ++++++++++++++++
>> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 20 ++++++++++++++-
>> =C2=A0src/openvpn/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 ++++
>> =C2=A0src/openvpn/openvpn_win32_resources.rc =C2=A0 | =C2=A0 41 ++++++++=
++++++++++++++++++++++
>> =C2=A0src/openvpnserv/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A05 +++-
>> =C2=A0src/openvpnserv/openvpnserv_resources.rc | =C2=A0 41 +++++++++++++=
+++++++++++++++++
>> =C2=A0version.m4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A010 files changed, 160 insertions(+), 3 deletions(-)
>> =C2=A0create mode 100644 build/Makefile.am
>> =C2=A0create mode 100644 build/ltrc.inc
>> =C2=A0create mode 100644 src/openvpn/openvpn_win32_resources.rc
>> =C2=A0create mode 100644 src/openvpnserv/openvpnserv_resources.rc
>>
>> diff --git a/.gitignore b/.gitignore
>> index 46cd4c8..156b2c2 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -26,6 +26,12 @@ depcomp
>> =C2=A0stamp-h1
>> =C2=A0install-sh
>> =C2=A0missing
>> +ltmain.sh
>> +m4/libtool.m4
>> +m4/ltoptions.m4
>> +m4/ltsugar.m4
>> +m4/ltversion.m4
>> +m4/lt~obsolete.m4
>>
>> =C2=A0doc/openvpn.8.html
>> =C2=A0distro/rpm/openvpn.spec
>> diff --git a/Makefile.am b/Makefile.am
>> index 850074b..ebc2252 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -34,6 +34,9 @@ MAINTAINERCLEANFILES =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(srcdir)/Makefile.in \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(srcdir)/config.h.in $(srcdir)/config.h.in~=
 $(srcdir)/configure \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(srcdir)/install-sh $(srcdir)/ltmain.sh $(s=
rcdir)/missing \
>> + =C2=A0 =C2=A0 =C2=A0 $(srcdir)/m4/libtool.m4 $(srcdir)/m4/lt~obsolete.=
m4 \
>> + =C2=A0 =C2=A0 =C2=A0 $(srcdir)/m4/ltoptions.m4 $(srcdir)/m4/ltsugar.m4=
 \
>> + =C2=A0 =C2=A0 =C2=A0 $(srcdir)/m4/ltversion.m4 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(srcdir)/depcomp $(srcdir)/aclocal.m4 \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(srcdir)/config.guess $(srcdir)/config.sub
>>
>> @@ -41,7 +44,7 @@ EXTRA_DIST =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 contrib \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug
>>
>> -SUBDIRS =3D distro include src sample doc tests
>> +SUBDIRS =3D build distro include src sample doc tests
>>
>> =C2=A0dist_doc_DATA =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 COPYRIGHT.GPL \
>> diff --git a/build/Makefile.am b/build/Makefile.am
>> new file mode 100644
>> index 0000000..a993b20
>> --- /dev/null
>> +++ b/build/Makefile.am
>> @@ -0,0 +1,15 @@
>> +#
>> +# =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single UDP port, wit=
h support for SSL/TLS-based
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and =
key exchange,
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet a=
uthentication, and
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> +#
>> +# =C2=A0Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...1387...=
5...>
>> +#
>> +
>> +MAINTAINERCLEANFILES =3D \
>> + =C2=A0 =C2=A0 =C2=A0 $(srcdir)/Makefile.in
>> +
>> +EXTRA_DIST =3D \
>> + =C2=A0 =C2=A0 =C2=A0 ltrc.inc
>> diff --git a/build/ltrc.inc b/build/ltrc.inc
>> new file mode 100644
>> index 0000000..701f200
>> --- /dev/null
>> +++ b/build/ltrc.inc
>> @@ -0,0 +1,23 @@
>> +#
>> +# =C2=A0OpenVPN -- An application to securely tunnel IP networks
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 over a single UDP port, wit=
h support for SSL/TLS-based
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 session authentication and =
key exchange,
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet encryption, packet a=
uthentication, and
>> +# =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet compression.
>> +#
>> +# =C2=A0Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
>> +#
>> +# Required to build Windows resource file
>> +
>> +RCCOMPILE =3D $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
>> + =C2=A0 =C2=A0 =C2=A0 $(AM_CPPFLAGS) $(CPPFLAGS)
>> +LTRCCOMPILE =3D $(LIBTOOL) --mode=3Dcompile --tag=3DRC $(RCCOMPILE)
>> +
>> +.rc.lo:
>> + =C2=A0 =C2=A0 =C2=A0 $(LTRCCOMPILE) -i "$<" -o "$@"
>> +
>> +.rc.o:
>> + =C2=A0 =C2=A0 =C2=A0 $(RCCOMPILE) -i "$<" -o "$@"
>> +
>> +.mc.rc:
>> + =C2=A0 =C2=A0 =C2=A0 $(WINDMC) "$<"
>> diff --git a/configure.ac b/configure.ac
>> index fe0fbab..6b5cf71 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -29,6 +29,8 @@ AC_PREREQ(2.59)
>> =C2=A0m4_include(version.m4)
>> =C2=A0AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [P=
RODUCT_TARNAME])
>> =C2=A0m4_include(compat.m4)
>> +AC_DEFINE([OPENVPN_VERSION_RESOURCE], [PRODUCT_VERSION_RESOURCE], [Vers=
ion in windows resource format])
>> +
>> =C2=A0AC_CONFIG_AUX_DIR([.])
>> =C2=A0AM_CONFIG_HEADER([config.h])
>> =C2=A0AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
>> @@ -352,7 +354,6 @@ case "$host" in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE_UNQUOT=
ED([TARGET_PREFIX], ["W"], [Target prefix])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPPFLAGS=3D"${CP=
PFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x0501"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WIN32=3Dyes
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBS=3D"${LIBS} -lgdi=
32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 *-*-dragonfly*)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE([TARGE=
T_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
>> @@ -369,6 +370,22 @@ AC_PROG_INSTALL
>> =C2=A0AC_PROG_LN_S
>> =C2=A0AC_PROG_MAKE_SET
>>
>> +#
>> +# Libtool
>> +#
>> +ifdef(
>> + =C2=A0 =C2=A0 =C2=A0 [LT_INIT],
>> + =C2=A0 =C2=A0 =C2=A0 [
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LT_INIT([win32-dll])
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LT_LANG([Windows Reso=
urce])
>> + =C2=A0 =C2=A0 =C2=A0 ],
>> + =C2=A0 =C2=A0 =C2=A0 [
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_LIBTOOL_WIN32_DLL
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_LIBTOOL_RC
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_PROG_LIBTOOL
>> + =C2=A0 =C2=A0 =C2=A0 ]
>> +)
>> +
>> =C2=A0if test "${WIN32}" =3D "yes"; then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_ARG_VAR([MAN2HTML], [man2html utility])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_CHECK_PROGS([MAN2HTML], [man2html])
>> @@ -930,6 +947,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>>
>> =C2=A0AC_CONFIG_FILES([
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Makefile
>> + =C2=A0 =C2=A0 =C2=A0 build/Makefile
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 distro/Makefile
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 distro/rpm/Makefile
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 distro/rpm/openvpn.spec
>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>> index 4a6b497..a509bba 100644
>> --- a/src/openvpn/Makefile.am
>> +++ b/src/openvpn/Makefile.am
>> @@ -9,6 +9,8 @@
>> =C2=A0# =C2=A0Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...1663...=
.>
>> =C2=A0#
>>
>> +include $(top_srcdir)/build/ltrc.inc
>> +
>> =C2=A0MAINTAINERCLEANFILES =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(srcdir)/Makefile.in
>>
>> @@ -93,3 +95,7 @@ openvpn_SOURCES =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 tun.c tun.h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 win32.h win32.c \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 cryptoapi.h cryptoapi.c
>> +if WIN32
>> +openvpn_SOURCES +=3D openvpn_win32_resources.rc
>> +openvpn_LDADD =3D -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwin=
mm -lshell32
>> +endif
>> diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvp=
n_win32_resources.rc
>> new file mode 100644
>> index 0000000..e91bfa1
>> --- /dev/null
>> +++ b/src/openvpn/openvpn_win32_resources.rc
>> @@ -0,0 +1,41 @@
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#else
>> +#include <config-msc-version.h>
>> +#endif
>> +#include <winresrc.h>
>> +
>> +LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
>> +
>> +VS_VERSION_INFO VERSIONINFO
>> + FILEVERSION OPENVPN_VERSION_RESOURCE
>> + PRODUCTVERSION OPENVPN_VERSION_RESOURCE
>> + FILEFLAGSMASK 0x3fL
>> +#ifdef _DEBUG
>> + FILEFLAGS 0x1L
>> +#else
>> + FILEFLAGS 0x0L
>> +#endif
>> + FILEOS 0x40004L
>> + FILETYPE 0x2L
>> + FILESUBTYPE 0x0L
>> +BEGIN
>> + =C2=A0 =C2=A0BLOCK "StringFileInfo"
>> + =C2=A0 =C2=A0BEGIN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0BLOCK "040904b0"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0BEGIN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "CompanyName", "OpenVPN=
.net"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "FileDescription", "Ope=
nVPN"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "FileVersion", PACKAGE_=
VERSION ".0"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "InternalName", "OpenVP=
N"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "LegalCopyright", "Copy=
right =EF=BF=BD OpenVPN Project"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "OriginalFilename", "op=
envpn.exe"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "ProductName", "OpenVPN"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "ProductVersion", PACKA=
GE_VERSION ".0"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0END
>> + =C2=A0 =C2=A0END
>> + =C2=A0 =C2=A0BLOCK "VarFileInfo"
>> + =C2=A0 =C2=A0BEGIN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "Translation", 0x409, 1200
>> + =C2=A0 =C2=A0END
>> +END
>> diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
>> index 7ce3375..58005c0 100644
>> --- a/src/openvpnserv/Makefile.am
>> +++ b/src/openvpnserv/Makefile.am
>> @@ -9,6 +9,8 @@
>> =C2=A0# =C2=A0Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...1663...=
.>
>> =C2=A0#
>>
>> +include $(top_srcdir)/build/ltrc.inc
>> +
>> =C2=A0MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in
>>
>> =C2=A0if WIN32
>> @@ -17,4 +19,5 @@ endif
>>
>> =C2=A0openvpnserv_SOURCES =3D \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpnserv.c \
>> - =C2=A0 =C2=A0 =C2=A0 service.h service.c
>> + =C2=A0 =C2=A0 =C2=A0 service.h service.c \
>> + =C2=A0 =C2=A0 =C2=A0 openvpnserv_resources.rc
>> diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/=
openvpnserv_resources.rc
>> new file mode 100644
>> index 0000000..b87f4a3
>> --- /dev/null
>> +++ b/src/openvpnserv/openvpnserv_resources.rc
>> @@ -0,0 +1,41 @@
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#else
>> +#include <config-msc-version.h>
>> +#endif
>> +#include <winresrc.h>
>> +
>> +LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
>> +
>> +VS_VERSION_INFO VERSIONINFO
>> + FILEVERSION OPENVPN_VERSION_RESOURCE
>> + PRODUCTVERSION OPENVPN_VERSION_RESOURCE
>> + FILEFLAGSMASK 0x3fL
>> +#ifdef _DEBUG
>> + FILEFLAGS 0x1L
>> +#else
>> + FILEFLAGS 0x0L
>> +#endif
>> + FILEOS 0x40004L
>> + FILETYPE 0x2L
>> + FILESUBTYPE 0x0L
>> +BEGIN
>> + =C2=A0 =C2=A0BLOCK "StringFileInfo"
>> + =C2=A0 =C2=A0BEGIN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0BLOCK "040904b0"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0BEGIN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "CompanyName", "OpenVPN=
.net"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "FileDescription", "Ope=
nVPN Service"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "FileVersion", PACKAGE_=
VERSION ".0"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "InternalName", "OpenVP=
N"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "LegalCopyright", "Copy=
right =EF=BF=BD OpenVPN Project"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "OriginalFilename", "op=
envpnserv.exe"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "ProductName", "OpenVPN"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "ProductVersion", PACKA=
GE_VERSION ".0"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0END
>> + =C2=A0 =C2=A0END
>> + =C2=A0 =C2=A0BLOCK "VarFileInfo"
>> + =C2=A0 =C2=A0BEGIN
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "Translation", 0x409, 1200
>> + =C2=A0 =C2=A0END
>> +END
>> diff --git a/version.m4 b/version.m4
>> index 29ec047..2bd1401 100644
>> --- a/version.m4
>> +++ b/version.m4
>> @@ -3,6 +3,7 @@ define([PRODUCT_NAME], [OpenVPN])
>> =C2=A0define([PRODUCT_TARNAME], [openvpn])
>> =C2=A0define([PRODUCT_VERSION], [2.3_alpha1])
>> =C2=A0define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
>> +define([PRODUCT_VERSION_RESOURCE], [2,3,0,0])
>> =C2=A0dnl define the TAP version
>> =C2=A0define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
>> =C2=A0define([PRODUCT_TAP_WIN_MIN_MAJOR], [9])
>> --
>> 1.7.3.4
>>
>>
>

