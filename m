Message-ID: <4F55EAF5.8090804@...515...>
Date: Tue, 06 Mar 2012 12:46:13 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-12-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-12-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 11/52] build: correct place to alter
 WINVER is at build system
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

Il 29.02.2012 22:11, Alon Bar-Lev ha scritto:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac    |    2 +-
>  syshead.h       |    4 ----
>  win/msvc.mak.in |    2 +-
>  3 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 1c4d66c..aa1d509 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -342,7 +342,7 @@ case "$host" in
>  	;;
>  *-mingw*)
>  	AC_DEFINE(TARGET_WIN32, 1, [Are we running WIN32?])
> -	CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
> +	CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x0501"
>  	OPENVPN_ADD_LIBS(-lgdi32)
>  	OPENVPN_ADD_LIBS(-lws2_32)
>  	OPENVPN_ADD_LIBS(-lwininet)
> diff --git a/syshead.h b/syshead.h
> index 0235abd..e8e70d2 100644
> --- a/syshead.h
> +++ b/syshead.h
> @@ -28,10 +28,6 @@
>  /*
>   * Only include if not during configure
>   */
> -#ifdef WIN32
> -/* PF_INET6: win32 ipv6 exists only after 0x0501 (XP) */
> -#define WINVER 0x0501
> -#endif
>  #ifndef PACKAGE_NAME
>  #include "config.h"
>  #include "compat.h"
> diff --git a/win/msvc.mak.in b/win/msvc.mak.in
> index 191f370..43c3335 100644
> --- a/win/msvc.mak.in
> +++ b/win/msvc.mak.in
> @@ -38,7 +38,7 @@ LIB_DIRS =3D -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSS=
L)\build\library -LIBPATH:$
>  EXE =3D openvpn.exe
>=20=20
>  CPP=3Dcl.exe
> -CPP_ARG_COMMON=3D/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D=
_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_WARNINGS -D_CRT_SECURE_N=
O_WARNINGS $(INCLUDE_DIRS) /FD /c
> +CPP_ARG_COMMON=3D/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x=
0501 -D_CONSOLE -D_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_WARNIN=
GS -D_CRT_SECURE_NO_WARNINGS $(INCLUDE_DIRS) /FD /c
>=20=20
>  LINK32=3Dlink.exe
>=20=20

Makes sense. WINVER defines the minimum supported Windows version[1]. In
this case (0x501) we support WIndows XP and later. Making this a
buildsystem option makes perfect sense to me - editing the header files
to determine which Windows version will be supported seems silly.

ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1]
<http://blogs.msdn.com/b/dsvc/archive/2009/06/19/troubleshooting-not-a-vali=
d-win32-application-error-at-the-startup.aspx>

