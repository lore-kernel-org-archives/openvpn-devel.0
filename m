MIME-Version: 1.0
In-Reply-To: <1268323319-7161-1-git-send-email-dazo@...384...>
References: <4B8ADF36.3050201@...1114...>
	<1268323319-7161-1-git-send-email-dazo@...384...>
Date: Thu, 11 Mar 2010 18:08:33 +0200
Message-ID: <9e0cf0bf1003110808m50e523ecn3262918ba9904e10@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix autotools cross-compiling support
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
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

mingw should be *-mingw* and not *-*-mingw* as there are some notation
without full notation.

On Thu, Mar 11, 2010 at 6:01 PM, David Sommerseth
<dazo@...384...> wrote:
> This is a modified version of a patch sent to the sf.net
> patch tracker:
> <http://sourceforge.net/tracker/?func=3Ddetail&aid=3D2491190&group_id=3D4=
8978&atid=3D454721>
>
> After having disucssed this patch on IRC (#openvpn-discussions)
> March 4, 2010, it was decided to accept this patch when not modifying
> TARGET_* defines through out the code. =C2=A0Further, in a mail comment
> Alon Bar-Lev had some other comments of what would be needed to be done.
>
> Mail reference:
> <http://thread.gmane.org/gmane.network.openvpn.devel/3176>
>
> This patch has been tested by bootstrapping the code on a RHEL4.6 box.
> with the following autotools packages installed:
> autoconf-2.59-5
> automake-1.9.2-3
> libtool-1.5.6-4.EL4.2
>
> It builds cleanly and 'make check' passes.
>
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
> =C2=A0acinclude.m4 | =C2=A0 10 +++++-----
> =C2=A0configure.ac | =C2=A0 35 +++++++++++++++++------------------
> =C2=A02 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/acinclude.m4 b/acinclude.m4
> index f099de5..2d49020 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -224,8 +224,8 @@ acx_pthread_flags=3D"pthreads none -Kthread -kthread =
lthread -pthread -pthreads -m
> =C2=A0# pthread: Linux, etcetera
> =C2=A0# --thread-safe: KAI C++
>
> -case "$target" in
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*solaris*)
> +case "$host" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*-*-solaris*)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # On Solaris (at least, for some versions), l=
ibc contains stubbed
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # (non-functional) versions of the pthreads r=
outines, so link-based
> @@ -321,9 +321,9 @@ if test "x$acx_pthread_ok" =3D xyes; then
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_CHECKING([if more special flags are re=
quired for pthreads])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag=3Dno
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$target" in
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*-aix* | *-freeb=
sd*) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag=3D"-D_THREAD_SAF=
E";;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*solaris* | alph=
a*-osf* | *linux*) flag=3D"-D_REENTRANT";;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$host" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*-*-aix* | *-fre=
ebsd*) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag=3D"-D_THREAD_S=
AFE";;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*-*-solaris* | a=
lpha*-osf* | *linux*) flag=3D"-D_REENTRANT";;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_RESULT(${flag})
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test "x$flag" !=3D xno; then
> diff --git a/configure.ac b/configure.ac
> index 116ff7c..a829a7d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -32,7 +32,6 @@ AC_CONFIG_SRCDIR(syshead.h)
>
> =C2=A0dnl Guess host type.
> =C2=A0AC_CANONICAL_HOST
> -AC_CANONICAL_SYSTEM
> =C2=A0AM_INIT_AUTOMAKE(openvpn, [$PACKAGE_VERSION])
>
> =C2=A0AC_ARG_WITH(cygwin-native,
> @@ -44,11 +43,11 @@ AC_ARG_WITH(cygwin-native,
> =C2=A0WIN32=3D"no"
> =C2=A0CYGWIN=3D"no"
> =C2=A0case "${host}" in
> - =C2=A0 =C2=A0 =C2=A0 *-mingw*)
> + =C2=A0 =C2=A0 =C2=A0 *-*-mingw*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WIN32=3D"yes"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cross_compiling=3D=
"yes"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> - =C2=A0 =C2=A0 =C2=A0 *-cygwin*)
> + =C2=A0 =C2=A0 =C2=A0 *-*-cygwin*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_CHECKING([c=
ygwin mode to use])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "${CYGWIN_=
NATIVE}" =3D "yes"; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0AC_MSG_RESULT([Using native win32])
> @@ -275,38 +274,38 @@ AC_ARG_WITH(mem-check,
> =C2=A0dnl fix search path, to allow compilers to find syshead.h
> =C2=A0CPPFLAGS=3D"$CPPFLAGS -I${srcdir}"
>
> -dnl check target OS
> -openvpn_target=3D$target
> -if test $target_alias; then
> - =C2=A0openvpn_target=3D$target_alias
> +dnl check host OS
> +openvpn_host=3D$host
> +if test $host_alias; then
> + =C2=A0openvpn_host=3D$host_alias
> =C2=A0fi
> -AC_DEFINE_UNQUOTED(TARGET_ALIAS, "$openvpn_target", [A string representi=
ng our target])
> -case "$target" in
> -*linux*)
> +AC_DEFINE_UNQUOTED(TARGET_ALIAS, "$openvpn_host", [A string representing=
 our host])
> +case "$host" in
> +*-*-linux*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_LINUX, 1, [Are we running on =
Linux?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dnl RH9 SSL headers workaround
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test -z $CS_HDR_DIR && test "$CRYPTO" =3D =
"yes"; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPPFLAGS=3D"$CPPFLAGS $(pkg-conf=
ig --cflags openssl 2>/dev/null)"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> -*solaris*)
> +*-*-solaris*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_SOLARIS, 1, [Are we running o=
n Solaris?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> -*openbsd*)
> +*-*-openbsd*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_OPENBSD, 1, [Are we running o=
n OpenBSD?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> -*freebsd*)
> +*-*-freebsd*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_FREEBSD, 1, [Are we running o=
n FreeBSD?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> -*netbsd*)
> +*-*-netbsd*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_NETBSD, 1, [Are we running Ne=
tBSD?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> -*darwin*)
> +*-*-darwin*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dnl some Mac OS X tendering (we use vararg mac=
ros...)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_DARWIN, 1, [Are we running on=
 Mac OS X?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CPPFLAGS=3D"$CPPFLAGS -no-cpp-precomp"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> -*mingw*)
> +*-*-mingw*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_WIN32, 1, [Are we running WIN=
32?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPENVPN_ADD_LIBS(-lgdi32)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPENVPN_ADD_LIBS(-lws2_32)
> @@ -315,7 +314,7 @@ case "$target" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPENVPN_ADD_LIBS(-liphlpapi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPENVPN_ADD_LIBS(-lwinmm)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> -*dragonfly*)
> +*-*-dragonfly*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE(TARGET_DRAGONFLY, 1, [Are we running=
 on DragonFlyBSD?])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
>
> @@ -574,7 +573,7 @@ if test "$PTHREAD" =3D "yes"; then
> =C2=A0 AC_MSG_RESULT([********* WARNING: pthread support is experimental =
for OpenVPN 2.0])
> =C2=A0 ACX_PTHREAD(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$target" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$host" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*openbsd*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_RESULT([WAR=
NING: pthread support on OpenBSD is unstable!])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CFLAGS=3D"$CFLAGS =
-pthread"
> --
> 1.5.4.7
>
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

