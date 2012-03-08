Message-ID: <4F588A46.5060106@...515...>
Date: Thu, 08 Mar 2012 12:30:30 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-38-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-38-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 37/52] build: proper pkcs11-helper
 detection and usage
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

These changes follow the same style as earlier patches, e.g. the selinux
patch. Pkg-config is now being used to detect pkcs11-helper afaics.
Also, pkcs11-helper now disabled by default, which I think makes sense.

I don't see why this shouldn't be included, so it's an ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac               |   49 ++++++++++++++++----------------------=
-----
>  distro/rpm/openvpn.spec.in |    5 ++-
>  src/openvpn/Makefile.am    |    4 +++
>  src/openvpn/ssl.c          |    2 +-
>  src/openvpn/syshead.h      |    7 ------
>  5 files changed, 26 insertions(+), 41 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 2388f17..baa66b2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -111,9 +111,9 @@ AC_ARG_ENABLE(
>=20=20
>  AC_ARG_ENABLE(
>  	[pkcs11],
> -	[AS_HELP_STRING([--disable-pkcs11], [disable pkcs11 support])],
> +	[AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support])],
>  	,
> -	[enable_pkcs11=3D"yes"]
> +	[enable_pkcs11=3D"no"]
>  )
>=20=20
>  AC_ARG_ENABLE(
> @@ -254,19 +254,6 @@ AC_ARG_WITH(
>  )
>=20=20
>  AC_ARG_WITH(
> -	[pkcs11-helper-headers],
> -	[AS_HELP_STRING([--with-pkcs11-helper-headers=3DDIR], [pkcs11-helper In=
clude files location])],
> -	[PKCS11_HELPER_HDR_DIR=3D"$withval"]
> -	[CPPFLAGS=3D"$CPPFLAGS -I$withval"]=20
> -)
> -
> -AC_ARG_WITH(
> -	[pkcs11-helper-lib],
> -	[AS_HELP_STRING([--with-pkcs11-helper-lib=3DDIR], [pkcs11-helper Librar=
y location])],
> -	[LDFLAGS=3D"$LDFLAGS -L$withval"]=20
> -)
> -
> -AC_ARG_WITH(
>  	[mem-check],
>  	[AS_HELP_STRING([--with-mem-check=3DTYPE], [build with debug memory che=
cking, TYPE=3Ddmalloc|valgrind|ssl])],
>  	[
> @@ -719,22 +706,12 @@ if test "${enable_lzo_stub}" =3D "yes"; then
>  	AC_DEFINE([LZO_STUB], [1], [Enable LZO stub capability])
>  fi
>=20=20
> -dnl
> -dnl enable pkcs11 capability
> -dnl
> -if test "${enable_pkcs11}" =3D "yes"; then
> -   AC_CHECKING([for pkcs11-helper Library and Header files])
> -   AC_CHECK_HEADER(pkcs11-helper-1.0/pkcs11h-core.h,
> -	[AC_CHECK_LIB(pkcs11-helper, pkcs11h_initialize,
> -	    [
> -		   AC_DEFINE(USE_PKCS11, 1, [Enable PKCS11 capability])
> -		   LIBS=3D"${LIBS} -lpkcs11-helper"
> -	    ],
> -	    [AC_MSG_RESULT([pkcs11-helper library not found.])]
> -	)],
> -	[AC_MSG_RESULT([pkcs11-helper headers not found.])]
> -   )
> -fi
> +PKG_CHECK_MODULES(
> +	[PKCS11_HELPER],
> +	[libpkcs11-helper-1 >=3D 1.02],
> +	[have_pkcs11_helper=3D"yes"],
> +	[]
> +)
>=20=20
>  dnl
>  dnl check for SSL-crypto library
> @@ -890,6 +867,14 @@ if test "${enable_selinux}" =3D "yes"; then
>  	AC_DEFINE([ENABLE_SELINUX], [1], [SELinux support])
>  fi
>=20=20
> +if test "${enable_pkcs11}" =3D "yes"; then
> +	test "${have_pkcs11_helper}" !=3D "yes" && AC_MSG_ERROR([PKCS11 enabled=
 but libpkcs11-helper is missing])
> +	test "${enable_ssl}" !=3D "yes" && AC_MSG_ERROR([PKCS11 can be enabled =
only if SSL is enabled])
> +	OPTIONAL_PKCS11_HELPER_CFLAGS=3D"${PKCS11_HELPER_CFLAGS}"
> +	OPTIONAL_PKCS11_HELPER_LIBS=3D"${PKCS11_HELPER_LIBS}"
> +	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
> +fi
> +
>  if test "${enable_pedantic}" =3D "yes"; then
>  	enable_strict=3D"yes"
>  	CFLAGS=3D"${CFLAGS} -ansi -pedantic"
> @@ -917,6 +902,8 @@ AC_SUBST([TAP_WIN_MIN_MINOR])
>=20=20
>  AC_SUBST([OPTIONAL_DL_LIBS])
>  AC_SUBST([OPTIONAL_SELINUX_LIBS])
> +AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
> +AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
>=20=20
>  AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>=20=20
> diff --git a/distro/rpm/openvpn.spec.in b/distro/rpm/openvpn.spec.in
> index 455f739..8db5172 100644
> --- a/distro/rpm/openvpn.spec.in
> +++ b/distro/rpm/openvpn.spec.in
> @@ -52,8 +52,8 @@ Requires:      openssl       >=3D 0.9.6
>  %{!?without_pam:BuildRequires: pam-devel}
>  %{!?without_pam:Requires:      pam}
>=20=20
> -%{!?with_pkcs11:BuildRequires: pkcs11-helper-devel}
> -%{!?with_pkcs11:Requires:      pkcs11-helper}
> +%{?with_pkcs11:BuildRequires: pkcs11-helper-devel}
> +%{?with_pkcs11:Requires:      pkcs11-helper}
>=20=20
>  #
>  # Description
> @@ -111,6 +111,7 @@ Development support for OpenVPN.
>  	--docdir=3D"%{_docdir}/%{name}-%{version}" \
>  	%{?with_password_save:--enable-password-save} \
>  	%{?without_lzo:--disable-lzo} \
> +	%{?with_pkcs11:--enable-pkcs11} \
>  	%{?with_kerberos:--with-ssl-headers=3D/usr/kerberos/include}
>  %__make
>=20=20
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index a3f8b3a..fd92225 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -16,6 +16,9 @@ MAINTAINERCLEANFILES =3D \
>=20=20
>  INCLUDES =3D -I$(top_srcdir)/include
>=20=20
> +AM_CFLAGS =3D \
> +	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
> +
>  sbin_PROGRAMS =3D openvpn
>=20=20
>  openvpn_SOURCES =3D \
> @@ -97,6 +100,7 @@ openvpn_SOURCES =3D \
>  	cryptoapi.h cryptoapi.c
>  openvpn_LDADD =3D \
>  	$(SOCKETS_LIBS) \
> +	$(OPTIONAL_PKCS11_HELPER_LIBS) \
>  	$(OPTIONAL_SELINUX_LIBS) \
>  	$(OPTIONAL_DL_LIBS)
>  if WIN32
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index c26756e..e260718 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -264,7 +264,7 @@ ssl_purge_auth (const bool auth_user_pass_only)
>  {
>    if (!auth_user_pass_only)
>      {
> -#ifdef USE_PKCS11
> +#ifdef ENABLE_PKCS11
>        pkcs11_logout ();
>  #endif
>        purge_user_pass (&passbuf, true);
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index cac4757..53b7580 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -590,13 +590,6 @@ socket_defined (const socket_descriptor_t sd)
>  #endif
>=20=20
>  /*
> - * Do we have PKCS11 capability?
> - */
> -#if defined(USE_PKCS11) && defined(USE_CRYPTO) && defined(USE_SSL)
> -#define ENABLE_PKCS11
> -#endif
> -
> -/*
>   * Do we have CryptoAPI capability?
>   */
>  #if defined(WIN32) && defined(USE_CRYPTO) && defined(USE_SSL) && defined=
(USE_OPENSSL)



