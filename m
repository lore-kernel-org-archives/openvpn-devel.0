MIME-Version: 1.0
In-Reply-To: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>
References: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>
Date: Tue, 7 Oct 2014 12:56:44 -0500
Message-ID: <CAE4D3A57hQWcpXtndkZswkSjP-1nywaet6PuuxRSYy5bUW0uNQ@...278...>
From: Jon Ciesla <limburgher@...277...>
Content-Type: multipart/alternative; boundary=001a11c24c442240550504d8ecf1
Subject: Re: [Openvpn-devel] [PATCH 1/2] autotools: Add support for
 extracting version information from pkg-config modules
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--001a11c24c442240550504d8ecf1
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 7, 2014 at 8:23 AM, David Sommerseth <
openvpn.list@...1114...> wrote:

> From: David Sommerseth <davids@...1347...>
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  m4/pkg.m4 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/m4/pkg.m4 b/m4/pkg.m4
> index 9a71878..f82496b 100644
> --- a/m4/pkg.m4
> +++ b/m4/pkg.m4
> @@ -107,16 +107,18 @@ AC_DEFUN([PKG_CHECK_MODULES],
>  [AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
>  AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding
> pkg-config])dnl
>  AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding pkg-config])dnl
> +AC_ARG_VAR([$1][_MODVERSION], [module version])dnl
>
>  pkg_failed=no
>  AC_MSG_CHECKING([for $1])
>
>  _PKG_CONFIG([$1][_CFLAGS], [cflags], [$2])
>  _PKG_CONFIG([$1][_LIBS], [libs], [$2])
> +_PKG_CONFIG([$1][_MODVERSION], [modversion], [$2])
>
>  m4_define([_PKG_TEXT], [Alternatively, you may set the environment
> variables $1[]_CFLAGS
> -and $1[]_LIBS to avoid the need to call pkg-config.
> -See the pkg-config man page for more details.])
> +and $1[]_LIBS to avoid the need to call pkg-config.  The $1[]_MODVERSION
> provides version
> +information.  See the pkg-config man page for more details.])
>
>  if test $pkg_failed = yes; then
>         AC_MSG_RESULT([no])
> @@ -153,6 +155,7 @@ To get pkg-config, see <
> http://pkg-config.freedesktop.org/>.])[]dnl
>  else
>         $1[]_CFLAGS=$pkg_cv_[]$1[]_CFLAGS
>         $1[]_LIBS=$pkg_cv_[]$1[]_LIBS
> +       $1[]_MODVERSION=$pkg_cv_[]$1[]_MODVERSION
>          AC_MSG_RESULT([yes])
>         $3
>  fi[]dnl
> --
> 1.8.3.1
>
>
>
> ------------------------------------------------------------------------------
> Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
> Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
> Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
> Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
>
> http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

ACK.

-- 
http://cecinestpasunefromage.wordpress.com/
------------------------------------------------
in your fear, seek only peace
in your fear, seek only love

-d. bowie

--001a11c24c442240550504d8ecf1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 7, 2014 at 8:23 AM, David Sommerseth <span dir=3D"ltr">&lt;=
<a href=3D"mailto:openvpn.list@...1114..." target=3D"_blank">openvpn.list@...220...=
..1114...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Da=
vid Sommerseth &lt;<a href=3D"mailto:davids@...1347...">davids@...1347...</=
a>&gt;<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...1347...">da=
vids@...1347...</a>&gt;<br>
---<br>
=C2=A0m4/pkg.m4 | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/m4/pkg.m4 b/m4/pkg.m4<br>
index 9a71878..f82496b 100644<br>
--- a/m4/pkg.m4<br>
+++ b/m4/pkg.m4<br>
@@ -107,16 +107,18 @@ AC_DEFUN([PKG_CHECK_MODULES],<br>
=C2=A0[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl<br>
=C2=A0AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding pkg-co=
nfig])dnl<br>
=C2=A0AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding pkg-config])=
dnl<br>
+AC_ARG_VAR([$1][_MODVERSION], [module version])dnl<br>
<br>
=C2=A0pkg_failed=3Dno<br>
=C2=A0AC_MSG_CHECKING([for $1])<br>
<br>
=C2=A0_PKG_CONFIG([$1][_CFLAGS], [cflags], [$2])<br>
=C2=A0_PKG_CONFIG([$1][_LIBS], [libs], [$2])<br>
+_PKG_CONFIG([$1][_MODVERSION], [modversion], [$2])<br>
<br>
=C2=A0m4_define([_PKG_TEXT], [Alternatively, you may set the environment va=
riables $1[]_CFLAGS<br>
-and $1[]_LIBS to avoid the need to call pkg-config.<br>
-See the pkg-config man page for more details.])<br>
+and $1[]_LIBS to avoid the need to call pkg-config.=C2=A0 The $1[]_MODVERS=
ION provides version<br>
+information.=C2=A0 See the pkg-config man page for more details.])<br>
<br>
=C2=A0if test $pkg_failed =3D yes; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_MSG_RESULT([no])<br>
@@ -153,6 +155,7 @@ To get pkg-config, see &lt;<a href=3D"http://pkg-config=
.freedesktop.org/" target=3D"_blank">http://pkg-config.freedesktop.org/</a>=
&gt;.])[]dnl<br>
=C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $1[]_CFLAGS=3D$pkg_cv_[]$1[]_CFLAGS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $1[]_LIBS=3D$pkg_cv_[]$1[]_LIBS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$1[]_MODVERSION=3D$pkg_cv_[]$1[]_MODVERSION<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_RESULT([yes])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $3<br>
=C2=A0fi[]dnl<br>
--<br>
1.8.3.1<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer<br>
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports<br>
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper<br>
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D154622311&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D154622311&amp;iu=3D/4140/ostg.clktrk</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br></div><div class=3D"gmail_extra">ACK.<br clear=3D"al=
l"></div><div class=3D"gmail_extra"><br>-- <br><a href=3D"http://cecinestpa=
sunefromage.wordpress.com/" target=3D"_blank">http://cecinestpasunefromage.=
wordpress.com/</a><br>------------------------------------------------<br>i=
n your fear, seek only peace<br>in your fear, seek only love<br><br>-d. bow=
ie
</div></div>

--001a11c24c442240550504d8ecf1--

