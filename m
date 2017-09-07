Message-ID: <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
In-Reply-To: <20170907172004.22534-1-davids@...515...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
Date: Thu, 7 Sep 2017 22:40:21 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20170907224021_30193"
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

------=_20170907224021_30193
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

While we are at it, I found it useful to see the used LZ4 version at
runtime as it is done with LZO and other libraries.

I've patched my rpms with the patch attached.

Regards,
Simon

> We are using a deprecated function, LZ4_compress_limitedOutput(), which
> will be removed with time.  The correct function to use is
> LZ4_compress_default().
> Both function takes the same number of arguments and data types, so the
> change
> is minimal.
>
> This patch will also enforce the system LZ4 library to be at least v1.7.1.
>  If
> the system library is not found or it is older, it will be build using the
> bundled
> LZ4 library.  The version number requirement is based on the LZ4 version
> we ship.
>
> The changes in configure.ac for the version check is modelled around the
> same
> approach we use for OpenSSL.  Plus it does a few minor reformats and
> improvements
> to comply with more recommend autoconf coding style.
>
> This patch is a result of the discussions in this mail thread:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14135=
.html
>
> Signed-off-by: David Sommerseth <davids@...515...>
>
> ---
> v2 - Don't use LZ4 version based #ifdef wrapper function
>      Do the LZ4 version check in ./configure
> ---
>  configure.ac           | 72
> +++++++++++++++++++++++++++++++++++---------------
>  src/openvpn/comp-lz4.c |  3 ++-
>  2 files changed, 53 insertions(+), 22 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 6f1044e8..74443353 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1088,37 +1088,67 @@ dnl
>  AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
>  AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
>  if test "$enable_lz4" =3D "yes" && test "$enable_comp_stub" =3D "no"; th=
en
> -    AC_CHECKING([for LZ4 Library and Header files])
> -    havelz4lib=3D1
> -
> -    # if LZ4_LIBS is set, we assume it will work, otherwise test
> -    if test -z "${LZ4_LIBS}"; then
> -	AC_CHECK_LIB(lz4, LZ4_compress,
> -	    [ LZ4_LIBS=3D"-llz4" ],
> -	    [
> -	        AC_MSG_RESULT([LZ4 library not found.])
> -	        havelz4lib=3D0
> -	    ])
> +    if test -z "${LZ4_CFLAGS}" -a -z "${LZ4_LIBS}"; then
> +	# if the user did not explicitly specify flags, try to autodetect
> +	PKG_CHECK_MODULES([LZ4],
> +			  [liblz4 >=3D 1.7.1],
> +			  [have_lz4=3D"yes"],
> +			  [] # If this fails, we will do another test next
> +	)
>      fi
>
>      saved_CFLAGS=3D"${CFLAGS}"
> +    saved_LIBS=3D"${LIBS}"
>      CFLAGS=3D"${CFLAGS} ${LZ4_CFLAGS}"
> -    AC_CHECK_HEADERS(lz4.h,
> -       ,
> -       [
> -	   AC_MSG_RESULT([LZ4 headers not found.])
> -	   havelz4lib=3D0
> -       ])
> -
> -    if test $havelz4lib =3D 0 ; then
> -	AC_MSG_RESULT([LZ4 library or header not found, using version in
> src/compat/compat-lz4.*])
> +    LIBS=3D"${LIBS} ${LZ4_LIBS}"
> +
> +    # If pkgconfig check failed or LZ4_CFLAGS/LZ4_LIBS env vars
> +    # are used, check the version directly in the LZ4 include file
> +    if test "${have_lz4}" !=3D "yes"; then
> +	AC_CHECK_HEADERS([lz4.h],
> +			 [have_lz4h=3D"yes"],
> +			 [])
> +
> +	if test "${have_lz4h}" =3D "yes" ; then
> +	    AC_MSG_CHECKING([additionally if system LZ4 version >=3D 1.7.1])
> +	    AC_COMPILE_IFELSE(
> +		[AC_LANG_PROGRAM([[
> +#include <lz4.h>
> +				 ]],
> +				 [[
> +/* Version encoding: MMNNPP (Major miNor Patch) - see lz4.h for details
> */
> +#if LZ4_VERSION_NUMBER < 10701L
> +#error LZ4 is too old
> +#endif
> +				 ]]
> +				)],
> +		[
> +		    AC_MSG_RESULT([ok])
> +		    have_lz4=3D"yes"
> +		],
> +		[AC_MSG_RESULT([system LZ4 library is too old])]
> +	    )
> +	fi
> +    fi
> +
> +    # if LZ4_LIBS is set, we assume it will work, otherwise test
> +    if test -z "${LZ4_LIBS}"; then
> +	AC_CHECK_LIB([lz4],
> +		     [LZ4_compress],
> +		     [LZ4_LIBS=3D"-llz4"],
> +		     [have_lz4=3D"no"])
> +    fi
> +
> +    if test "${have_lz4}" !=3D "yes" ; then
> +	AC_MSG_RESULT([		usuable LZ4 library or header not found, using version
> in src/compat/compat-lz4.*])
>  	AC_DEFINE([NEED_COMPAT_LZ4], [1], [use copy of LZ4 source in compat/])
>  	LZ4_LIBS=3D""
>      fi
>      OPTIONAL_LZ4_CFLAGS=3D"${LZ4_CFLAGS}"
>      OPTIONAL_LZ4_LIBS=3D"${LZ4_LIBS}"
> -    AC_DEFINE(ENABLE_LZ4, 1, [Enable LZ4 compression library])
> +    AC_DEFINE(ENABLE_LZ4, [1], [Enable LZ4 compression library])
>      CFLAGS=3D"${saved_CFLAGS}"
> +    LIBS=3D"${saved_LIBS}"
>  fi
>
>
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index e056caa8..bdb3247d 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -43,6 +43,7 @@
>
>  #include "memdbg.h"
>
> +
>  static void
>  lz4_compress_init(struct compress_context *compctx)
>  {
> @@ -86,7 +87,7 @@ do_lz4_compress(struct buffer *buf,
>              return false;
>          }
>
> -        zlen =3D LZ4_compress_limitedOutput((const char *)BPTR(buf), (ch=
ar
> *)BPTR(work), BLEN(buf), zlen_max );
> +        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (char
> *)BPTR(work), BLEN(buf), zlen_max );
>
>          if (zlen <=3D 0)
>          {
> --
> 2.13.5
>
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

------=_20170907224021_30193
Content-Type: text/x-patch; name="openvpn-2.4.0-lz4_version_string.patch"
Content-Disposition: attachment;
 filename="openvpn-2.4.0-lz4_version_string.patch"
Content-Transfer-Encoding: quoted-printable

diff -Naur openvpn-2.4.0.orig/src/openvpn/comp-lz4.h openvpn-2.4.0/src/op=
envpn/comp-lz4.h
--- openvpn-2.4.0.orig/src/openvpn/comp-lz4.h	2016-12-26 12:51:00.0000000=
00 +0100
+++ openvpn-2.4.0/src/openvpn/comp-lz4.h	2017-01-17 09:11:12.000000000 +0=
100
@@ -28,6 +28,10 @@
=20
 #if defined(ENABLE_LZ4)
=20
+#if defined(HAVE_LZ4_H)
+#include "lz4.h"
+#endif
+
 #include "buffer.h"
=20
 extern const struct compress_alg lz4_alg;
diff -Naur openvpn-2.4.0.orig/src/openvpn/options.c openvpn-2.4.0/src/ope=
nvpn/options.c
--- openvpn-2.4.0.orig/src/openvpn/options.c	2016-12-26 12:51:00.00000000=
0 +0100
+++ openvpn-2.4.0/src/openvpn/options.c	2017-01-17 09:11:12.000000000 +01=
00
@@ -4121,11 +4121,17 @@
 #else
 #define LZO_LIB_VER_STR "", ""
 #endif
+#ifdef ENABLE_LZ4
+#define LZ4_LIB_VER_STR ", LZ4 ", LZ4_versionString()
+#else
+#define LZ4_LIB_VER_STR "", ""
+#endif
=20
-    msg(flags, "library versions: %s%s%s", SSL_LIB_VER_STR, LZO_LIB_VER_=
STR);
+    msg(flags, "library versions: %s%s%s%s%s", SSL_LIB_VER_STR, LZO_LIB_=
VER_STR, LZ4_LIB_VER_STR);
=20
 #undef SSL_LIB_VER_STR
 #undef LZO_LIB_VER_STR
+#undef LZ4_LIB_VER_STR
 }
=20
 static void
------=_20170907224021_30193--



