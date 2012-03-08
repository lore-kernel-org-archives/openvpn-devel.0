Message-ID: <4F587F1A.2050905@...515...>
Date: Thu, 08 Mar 2012 11:42:50 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-32-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-32-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 31/52] build: autoconf: commands as
	environment
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

So, this patch replaces (removes?) the "--with-<executable>-path" configure=
 options with environment variables, right?  For example, if one has "ifcon=
fig" in a non-standard place, he can set the IFCONFIG environment variable =
and the build will find it. Did I understand this correctly?

I don't know autotools well enough to give this one an ACK at this point. T=
hat said, the patch does clean up configure.ac a lot, and cleanups are alwa=
ys nice :).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |   66 ++++++++++++++++++++++++----------------------------=
-----
>  1 files changed, 28 insertions(+), 38 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 6b5cf71..ed98464 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -267,37 +267,6 @@ AC_ARG_WITH(
>  )
>=20=20
>  AC_ARG_WITH(
> -	[ifconfig-path],
> -	[AS_HELP_STRING([--with-ifconfig-path=3DPATH], [Path to ifconfig tool])=
],
> -	[IFCONFIG=3D"$withval"],
> -	[AC_PATH_PROG([IFCONFIG], [ifconfig], [ifconfig], [$PATH:/usr/local/sbi=
n:/usr/sbin:/sbin])]
> -)
> -AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig too=
l])
> -
> -AC_ARG_WITH(
> -	[iproute-path],
> -	[AS_HELP_STRING([--with-iproute-path=3DPATH], [Path to iproute tool])],
> -	[IPROUTE=3D"$withval"],
> -	[AC_PATH_PROG([IPROUTE], [ip], [ip], [$PATH:/usr/local/sbin:/usr/sbin:/=
sbin])]
> -)
> -AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
> -
> -AC_ARG_WITH([route-path],
> -   [AS_HELP_STRING([--with-route-path=3DPATH], [Path to route tool])],
> -   [ROUTE=3D"$withval"],
> -   [AC_PATH_PROG([ROUTE], [route], [route], [$PATH:/usr/local/sbin:/usr/=
sbin:/sbin])]
> -)
> -AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
> -
> -AC_ARG_WITH(
> -	[netstat-path],
> -	[AS_HELP_STRING([--with-netstat-path=3DPATH], [Path to netstat tool])],
> -	[NETSTAT=3D"$withval"],
> -	[AC_PATH_PROG([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/=
usr/sbin:/sbin:/etc])]
> -)
> -AC_DEFINE_UNQUOTED([NETSTAT_PATH], ["$NETSTAT"], [Path to netstat tool])
> -
> -AC_ARG_WITH(
>  	[mem-check],
>  	[AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memory che=
cking, TYPE=3Ddmalloc|valgrind|ssl])],
>  	[
> @@ -370,6 +339,20 @@ AC_PROG_INSTALL
>  AC_PROG_LN_S
>  AC_PROG_MAKE_SET
>=20=20
> +AC_ARG_VAR([IFCONFIG], [full path to ipconfig utility])
> +AC_ARG_VAR([ROUTE], [full path to route utility])
> +AC_ARG_VAR([IPROUTE], [full path to ip utility])
> +AC_ARG_VAR([NETSTAT], [path to netstat utility]) # tests
> +AC_ARG_VAR([MAN2HTML], [path to man2html utility])
> +AC_PATH_PROGS([IFCONFIG], [ifconfig],, [$PATH:/usr/local/sbin:/usr/sbin:=
/sbin])
> +AC_PATH_PROGS([ROUTE], [route],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
> +AC_PATH_PROGS([IPROUTE], [ip],, [$PATH:/usr/local/sbin:/usr/sbin:/sbin])
> +AC_CHECK_PROGS([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/=
usr/sbin:/sbin:/etc]) # tests
> +AC_CHECK_PROGS([MAN2HTML], [man2html])
> +AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig too=
l])
> +AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
> +AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
> +
>  #
>  # Libtool
>  #
> @@ -386,12 +369,6 @@ ifdef(
>  	]
>  )
>=20=20
> -if test "${WIN32}" =3D "yes"; then
> -	AC_ARG_VAR([MAN2HTML], [man2html utility])
> -	AC_CHECK_PROGS([MAN2HTML], [man2html])
> -	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
> -fi
> -
>  AC_C_CONST
>  AC_C_INLINE
>  AC_C_VOLATILE
> @@ -920,7 +897,16 @@ test "${enable_pf}" =3D "yes" && AC_DEFINE([ENABLE_P=
F], [1], [Enable internal pack
>  test "${enable_strict_options}" =3D "yes" && AC_DEFINE([ENABLE_STRICT_OP=
TIONS_CHECK], [1], [Enable strict options check between peers])
>  test "${enable_password_save}" =3D "yes" && AC_DEFINE([ENABLE_PASSWORD_S=
AVE], [1], [Allow --askpass and --auth-user-pass passwords to be read from =
a file])
>  test "${enable_systemd}" =3D "yes" && AC_DEFINE([ENABLE_SYSTEMD], [1], [=
Enable systemd support])
> -test "${enable_iproute2}" =3D "yes" && AC_DEFINE([ENABLE_IPROUTE], [1], =
[enable iproute2 support])
> +
> +if test "${enable_iproute2}" =3D "yes"; then
> +	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missin=
g])
> +	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
> +else
> +	if test "${WIN32}" !=3D "yes"; then
> +		test -z "${ROUTE}" && AC_MSG_ERROR([route utility is required but miss=
ing])
> +		test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is required bu=
t missing])
> +	fi
> +fi
>=20=20
>  if test "${enable_pedantic}" =3D "yes"; then
>  	enable_strict=3D"yes"
> @@ -930,6 +916,10 @@ if test "${enable_strict}" =3D "yes"; then
>  	CFLAGS=3D"${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
>  fi
>=20=20
> +if test "${WIN32}" =3D "yes"; then
> +	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
> +fi
> +
>  CONFIGURE_DEFINES=3D"`set | grep '^enable_.*=3D' ; set | grep '^with_.*=
=3D'`"
>  AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"],=
 [Configuration settings])
>=20=20


