From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 21 Jan 2014 14:48:01 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9015519E5889@...1436...>
References: <1389803764-5879-1-git-send-email-davids@...1347...>
In-Reply-To: <1389803764-5879-1-git-send-email-davids@...1347...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Adjusted autotools files to build
	more	cleanly on newer autoconf/automake versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "davids@...1347..." <davids@...1347...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

ACK

-Steffan

> -----Original Message-----
> From: davids@...1347... [mailto:davids@...1347...]
> Sent: woensdag 15 januari 2014 17:36
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] [PATCH] Adjusted autotools files to build more
> cleanly on newer autoconf/automake versions
>=20
> From: David Sommerseth <davids@...1347...>
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  configure.ac            | 8 ++++----
>  src/openvpn/Makefile.am | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac index 636d4e2..ec8b96b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -680,7 +680,7 @@ fi
>=20
>  case "${with_mem_check}" in
>  	valgrind)
> -		AC_CHECK_HEADER(
> +		AC_CHECK_HEADERS(
>  			[valgrind/memcheck.h],
>  			[
>  				CFLAGS=3D"${CFLAGS} -g -fno-inline"
> @@ -694,7 +694,7 @@ case "${with_mem_check}" in
>  		)
>  		;;
>  	dmalloc)
> -		AC_CHECK_HEADER(
> +		AC_CHECK_HEADERS(
>  			[dmalloc.h],
>  			[AC_CHECK_LIB(
>  				[dmalloc],
> @@ -923,7 +923,7 @@ if test "$enable_snappy" =3D "yes" && test
> "$enable_comp_stub" =3D "no"; then
>=20
>      saved_CFLAGS=3D"${CFLAGS}"
>      CFLAGS=3D"${CFLAGS} ${SNAPPY_CFLAGS}"
> -    AC_CHECK_HEADER(snappy-c.h,
> +    AC_CHECK_HEADERS(snappy-c.h,
>         ,
>         [
>  	   AC_MSG_RESULT([Snappy headers not found.]) @@ -962,7 +962,7 @@
> if test "$enable_lz4" =3D "yes" && test "$enable_comp_stub" =3D "no"; then
>=20
>      saved_CFLAGS=3D"${CFLAGS}"
>      CFLAGS=3D"${CFLAGS} ${LZ4_CFLAGS}"
> -    AC_CHECK_HEADER(lz4.h,
> +    AC_CHECK_HEADERS(lz4.h,
>         ,
>         [
>  	   AC_MSG_RESULT([LZ4 headers not found.]) diff --git
> a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am index
> 0b79e10..fd593c5 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -18,7 +18,7 @@ EXTRA_DIST =3D \
>  	openvpn.vcxproj \
>  	openvpn.vcxproj.filters
>=20
> -INCLUDES =3D \
> +AM_CPPFLAGS =3D \
>  	-I$(top_srcdir)/include \
>  	-I$(top_srcdir)/src/compat
>=20
> --
> 1.8.5.2
>=20
>=20
> -----------------------------------------------------------------------
> -------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
> http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&iu=3D/4140/ostg=
.c
> lktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

