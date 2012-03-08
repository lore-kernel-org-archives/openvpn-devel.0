Message-ID: <4F586E58.5080207@...515...>
Date: Thu, 08 Mar 2012 10:31:20 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-28-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-28-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 27/52] build: autoconf: remove
 OPENVPN_ADD_LIBS useless macro
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

Looks fairly straightforward: the OPENVPN_ADD_LIBS(LIB) macro[1] from
"acinclude.m4" is being phased out, e.g.

OPENVPN_ADD_LIBS(-ldmalloc)

becomes

LIBS=3D"${LIBS} -ldmalloc"

I don't think the macro does anything _that_ special it would be worth savi=
ng.

ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1]

dnl OPENVPN_ADD_LIBS(LIB)
AC_DEFUN([OPENVPN_ADD_LIBS], [
  LIBS=3D"$1 $LIBS"
])



> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac         |   26 ++++++++++----------------
>  m4/ax_openvpn_lib.m4 |    4 ----
>  2 files changed, 10 insertions(+), 20 deletions(-)
>  delete mode 100644 m4/ax_openvpn_lib.m4
>
> diff --git a/configure.ac b/configure.ac
> index 07b2e1a..81bf933 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -352,13 +352,7 @@ case "$host" in
>  		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
>  		CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=3D0x0501"
>  		WIN32=3Dyes
> -		OPENVPN_ADD_LIBS(-lgdi32)
> -		OPENVPN_ADD_LIBS(-lws2_32)
> -		OPENVPN_ADD_LIBS(-lwininet)
> -		OPENVPN_ADD_LIBS(-lcrypt32)
> -		OPENVPN_ADD_LIBS(-liphlpapi)
> -		OPENVPN_ADD_LIBS(-lwinmm)
> -		OPENVPN_ADD_LIBS(-lshell32)
> +		LIBS=3D"${LIBS} -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinm=
m -lshell32"
>  		;;
>  	*-*-dragonfly*)
>  		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
> @@ -640,7 +634,7 @@ case "${with_mem_check}" in
>  				[dmalloc],
>  				[malloc],
>  				[
> -					OPENVPN_ADD_LIBS(-ldmalloc)
> +					LIBS=3D"${LIBS} -ldmalloc"
>  					AC_DEFINE(
>  						[DMALLOC],
>  						[1],
> @@ -682,7 +676,7 @@ if test "${WIN32}" !=3D "yes" -a "${enable_plugins}" =
=3D "yes"; then
>  				[dl],
>  				[dlopen],
>  				[
> -					OPENVPN_ADD_LIBS(-ldl)
> +					LIBS=3D"${LIBS} -ldl"
>  					AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])
>  				],
>  				[AC_MSG_RESULT([libdl library not found.])]
> @@ -721,7 +715,7 @@ if test "${enable_lzo}" =3D "yes" && test "${enable_l=
zo_stub}" =3D "no"; then
>  	if test $havelzolib =3D 1 ; then break ; fi
>  	AC_CHECK_LIB($i, lzo1x_1_15_compress,
>            [
> -	    OPENVPN_ADD_LIBS(-l$i)
> +	    LIBS=3D"${LIBS} -l$i"
>  	    AC_DEFINE(USE_LZO, 1, [Use LZO compression library])
>  	    AC_DEFINE_UNQUOTED(LZO_VERSION_NUM, "$LZO_H", [LZO version number])
>  	    havelzolib=3D1
> @@ -752,7 +746,7 @@ if test "${enable_pkcs11}" =3D "yes"; then
>  	[AC_CHECK_LIB(pkcs11-helper, pkcs11h_initialize,
>  	    [
>  		   AC_DEFINE(USE_PKCS11, 1, [Enable PKCS11 capability])
> -		   OPENVPN_ADD_LIBS(-lpkcs11-helper)
> +		   LIBS=3D"${LIBS} -lpkcs11-helper"
>  	    ],
>  	    [AC_MSG_RESULT([pkcs11-helper library not found.])]
>  	)],
> @@ -773,7 +767,7 @@ if test "${enable_crypto}" =3D "yes"; then
>            AC_CHECK_LIB($lib, EVP_CIPHER_CTX_init,
>                  [
>              		cryptofound=3D1
> -            		OPENVPN_ADD_LIBS(-l$lib)
> +			LIBS=3D"${LIBS} -l$lib"
>      	        ]
>            )
>         done
> @@ -807,7 +801,7 @@ if test "${enable_crypto}" =3D "yes"; then
>          AC_CHECK_HEADER(polarssl/aes.h,
>              [AC_CHECK_LIB(polarssl, aes_crypt_cbc,
>                  [
> -                    OPENVPN_ADD_LIBS(-lpolarssl)
> +		    LIBS=3D"${LIBS} -lpolarssl"
>                      AC_DEFINE(USE_CRYPTO, 1, [Use crypto library])
>                      AC_DEFINE(USE_POLARSSL, 1, [Use PolarSSL library])
>                  ],
> @@ -831,7 +825,7 @@ if test "${enable_crypto}" =3D "yes"; then
>  	     AC_CHECK_LIB($lib, SSL_CTX_new,
>  		   [
>  			   sslfound=3D1
> -			   OPENVPN_ADD_LIBS(-l$lib)
> +			   LIBS=3D"${LIBS} -l$lib"
>  		   ]
>  	     )
>           done
> @@ -845,7 +839,7 @@ if test "${enable_crypto}" =3D "yes"; then
>           AC_CHECK_HEADER(polarssl/ssl.h,
>                [AC_CHECK_LIB(polarssl, ssl_init,
>                [
> -                  OPENVPN_ADD_LIBS(-lpolarssl)
> +		  LIBS=3D"${LIBS} -lpolarssl"
>                    AC_DEFINE(USE_SSL, 1, [Use SSL library])
>                    AC_DEFINE(USE_POLARSSL, 1, [Use PolarSSL library])
>                ],
> @@ -867,7 +861,7 @@ if test "${enable_selinux}" =3D "yes"; then
>  			[selinux],
>  			[setcon],
>  			[
> -				OPENVPN_ADD_LIBS(-lselinux)
> +				LIBS=3D"${LIBS} -lselinux"
>  				AC_DEFINE(HAVE_SETCON, 1, [SELinux support])
>  			],
>  			[AC_MSG_RESULT([SELinux library not found.])]
> diff --git a/m4/ax_openvpn_lib.m4 b/m4/ax_openvpn_lib.m4
> deleted file mode 100644
> index bcfe1ab..0000000
> --- a/m4/ax_openvpn_lib.m4
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -dnl OPENVPN_ADD_LIBS(LIB)
> -AC_DEFUN([OPENVPN_ADD_LIBS], [
> -  LIBS=3D"$1 $LIBS"
> -])



