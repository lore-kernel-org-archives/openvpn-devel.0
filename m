Message-ID: <4F58B7C7.3030405@...515...>
Date: Thu, 08 Mar 2012 15:44:39 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-51-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-51-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 50/52] build: windows: install
 version.sh to allow installer read version
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

Is this meant to allow using these variables[1] in the NSIS script(s)?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1]

OPENVPN_PACKAGE_NAME=3D"@PACKAGE_NAME@"
OPENVPN_PACKAGE_TARNAME=3D"@PACKAGE_TARNAME@"
OPENVPN_PACKAGE_VERSION=3D"@PACKAGE_VERSION@"
OPENVPN_PACKAGE_HOST=3D"@host@"


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  .gitignore    |    1 +
>  Makefile.am   |    5 +++++
>  configure.ac  |    1 +
>  version.sh.in |    4 ++++
>  4 files changed, 11 insertions(+), 0 deletions(-)
>  create mode 100644 version.sh.in
>
> diff --git a/.gitignore b/.gitignore
> index e7232cf..2f72ed8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -39,6 +39,7 @@ m4/ltsugar.m4
>  m4/ltversion.m4
>  m4/lt~obsolete.m4
>=20=20
> +version.sh
>  msvc-env-local.bat
>  config-msvc-local.h
>  config-msvc-version.h
> diff --git a/Makefile.am b/Makefile.am
> index 5293518..68aa0a8 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -69,3 +69,8 @@ endif
>  dist_noinst_HEADERS =3D \
>  	config-msvc.h \
>  	config-msvc-version.h.in
> +
> +if WIN32
> +rootdir=3D$(prefix)
> +root_DATA =3D version.sh
> +endif
> diff --git a/configure.ac b/configure.ac
> index d53a74a..0f2a62e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -904,6 +904,7 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
>  AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>=20=20
>  AC_CONFIG_FILES([
> +	version.sh
>  	Makefile
>  	build/Makefile
>  	build/msvc/Makefile
> diff --git a/version.sh.in b/version.sh.in
> new file mode 100644
> index 0000000..2af5a36
> --- /dev/null
> +++ b/version.sh.in
> @@ -0,0 +1,4 @@
> +OPENVPN_PACKAGE_NAME=3D"@PACKAGE_NAME@"
> +OPENVPN_PACKAGE_TARNAME=3D"@PACKAGE_TARNAME@"
> +OPENVPN_PACKAGE_VERSION=3D"@PACKAGE_VERSION@"
> +OPENVPN_PACKAGE_HOST=3D"@host@"



