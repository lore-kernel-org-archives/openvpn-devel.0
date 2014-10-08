MIME-Version: 1.0
In-Reply-To: <54347A1E.20705@...1114...>
References: <1412688204-29265-1-git-send-email-openvpn.list@...1114...>
	<CAE4D3A7A=c0gjg6rDvO8D1eKiP045XvKTx2RNbD8ReTr7wB17Q@...278...>
	<54342558.3070208@...1114...>
	<CAE4D3A5FVdVFa8Tzc9Pfan2TSJHqgWttJ59DDAUyJVAe0tiqNw@...278...>
	<54347A1E.20705@...1114...>
Date: Wed, 8 Oct 2014 05:08:31 -0500
Message-ID: <CAE4D3A6wE4fngjqSbrTJTKhSW=gcuJ39X+qqixF1m5ozQ5eKaw@...278...>
From: Jon Ciesla <limburgher@...277...>
Content-Type: multipart/alternative; boundary=001a11c366607e40e30504e67fdb
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
To: openvpn-devel@lists.sourceforge.net

--001a11c366607e40e30504e67fdb
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 7, 2014 at 6:41 PM, David Sommerseth <
openvpn.list@...1114...> wrote:

> On 07/10/14 19:57, Jon Ciesla wrote:
> >
> >
> > On Tue, Oct 7, 2014 at 12:39 PM, David Sommerseth
> > <openvpn.list@...1114... <mailto:openvpn.list@...1114...>>
> > wrote:
> >
> >     Sorry, could you do that to openvpn-devel@lists.sourceforge.net
> >     <mailto:openvpn-devel@lists.sourceforge.net> ?
> >
> >     David S.
> >
> >
> >
> >     On 07/10/14 19:37, Jon Ciesla wrote:
> >     >
> >     >
> >     > On Tue, Oct 7, 2014 at 8:23 AM, David Sommerseth
> >     > <openvpn.list@...1114...
> >     <mailto:openvpn.list@...1114...>
> >     <mailto:openvpn.list@...1114...
> >     <mailto:openvpn.list@...1114...>>>
> >     > wrote:
> >     >
> >     >     From: David Sommerseth <davids@...1347...
> >     <mailto:davids@...1347...> <mailto:davids@...1347...
> >     <mailto:davids@...1347...>>>
> >     >
> >     >     Signed-off-by: David Sommerseth <davids@...1347...
> >     <mailto:davids@...1347...>
> >     >     <mailto:davids@...1347... <mailto:davids@...1347...>>>
> >     >     ---
> >     >      m4/pkg.m4 | 7 +++++--
> >     >      1 file changed, 5 insertions(+), 2 deletions(-)
> >     >
> >     >     diff --git a/m4/pkg.m4 b/m4/pkg.m4
> >     >     index 9a71878..f82496b 100644
> >     >     --- a/m4/pkg.m4
> >     >     +++ b/m4/pkg.m4
> >     >     @@ -107,16 +107,18 @@ AC_DEFUN([PKG_CHECK_MODULES],
> >     >      [AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
> >     >      AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding
> >     >     pkg-config])dnl
> >     >      AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding
> >     >     pkg-config])dnl
> >     >     +AC_ARG_VAR([$1][_MODVERSION], [module version])dnl
> >     >
> >     >      pkg_failed=no
> >     >      AC_MSG_CHECKING([for $1])
> >     >
> >     >      _PKG_CONFIG([$1][_CFLAGS], [cflags], [$2])
> >     >      _PKG_CONFIG([$1][_LIBS], [libs], [$2])
> >     >     +_PKG_CONFIG([$1][_MODVERSION], [modversion], [$2])
> >     >
> >     >      m4_define([_PKG_TEXT], [Alternatively, you may set the
> >     environment
> >     >     variables $1[]_CFLAGS
> >     >     -and $1[]_LIBS to avoid the need to call pkg-config.
> >     >     -See the pkg-config man page for more details.])
> >     >     +and $1[]_LIBS to avoid the need to call pkg-config.  The
> >     >     $1[]_MODVERSION provides version
> >     >     +information.  See the pkg-config man page for more details.])
> >     >
> >     >      if test $pkg_failed = yes; then
> >     >             AC_MSG_RESULT([no])
> >     >     @@ -153,6 +155,7 @@ To get pkg-config, see
> >     >     <http://pkg-config.freedesktop.org/>.])[]dnl
> >     >      else
> >     >             $1[]_CFLAGS=$pkg_cv_[]$1[]_CFLAGS
> >     >             $1[]_LIBS=$pkg_cv_[]$1[]_LIBS
> >     >     +       $1[]_MODVERSION=$pkg_cv_[]$1[]_MODVERSION
> >     >              AC_MSG_RESULT([yes])
> >     >             $3
> >     >      fi[]dnl
> >     >     --
> >     >     1.8.3.1
> >     >
> >     >
> >     >
> >
> ------------------------------------------------------------------------------
> >     >     Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
> >     >     Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI
> >     DSS Reports
> >     >     Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White
> >     paper
> >     >     Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog
> >     Analyzer
> >     >
> >
> http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
> >     >     _______________________________________________
> >     >     Openvpn-devel mailing list
> >     >     Openvpn-devel@lists.sourceforge.net
> >     <mailto:Openvpn-devel@lists.sourceforge.net>
> >     >     <mailto:Openvpn-devel@lists.sourceforge.net
> >     <mailto:Openvpn-devel@lists.sourceforge.net>>
> >     >     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >     >
> >     >
> >     > ACK.
> >     >
> >     > --
> >     > http://cecinestpasunefromage.wordpress.com/
> >     > ------------------------------------------------
> >     > in your fear, seek only peace
> >     > in your fear, seek only love
> >     >
> >     > -d. bowie
> >
> >
> >     --
> >     kind regards,
> >
> >     David Sommerseth
> >
> >
> > Done.  <facepalm>
>
> Thanks!  Seems we might have a flamefest on openvpn-devel again ...
> well, don't worry!  Thanks a lot for your ACK.  It did spark a reaction
> I did expect.
>
>
> --
> kind regards,
>
> David Sommerseth
>
>
So goes open source development.  Anytime!

-me

-- 
http://cecinestpasunefromage.wordpress.com/
------------------------------------------------
in your fear, seek only peace
in your fear, seek only love

-d. bowie

--001a11c366607e40e30504e67fdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Oct 7, 2014 at 6:41 PM, David Sommerseth <span dir=3D"ltr">&lt;=
<a href=3D"mailto:openvpn.list@...1114..." target=3D"_blank">openvpn.list@...220...=
..1114...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 07/10=
/14 19:57, Jon Ciesla wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Oct 7, 2014 at 12:39 PM, David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn.list@...1114...">openvpn.list@...1114...=
</a> &lt;mailto:<a href=3D"mailto:openvpn.list@...1114...">openvpn.list@...493...=
1114...</a>&gt;&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Sorry, could you do that to <a href=3D"mailto:openv=
pn-devel@lists.sourceforge.net">openvpn-devel@lists.sourceforge.net</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:openvpn-devel@...1466...=
urceforge.net">openvpn-devel@lists.sourceforge.net</a>&gt; ?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0David S.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 07/10/14 19:37, Jon Ciesla wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Tue, Oct 7, 2014 at 8:23 AM, David Sommerse=
th<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;<a href=3D"mailto:openvpn.list@...1114..."=
>openvpn.list@...1114...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:openvpn.list@...1332...=
.">openvpn.list@...1114...</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:openvpn.list@...1332...=
.">openvpn.list@...1114...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:openvpn.list@...1332...=
.">openvpn.list@...1114...</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0From: David Sommerseth &lt;=
<a href=3D"mailto:davids@...1347...">davids@...1347...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:davids@...1347...">dav=
ids@...1347...</a>&gt; &lt;mailto:<a href=3D"mailto:davids@...1347...">davi=
ds@...1347...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:davids@...1347...">dav=
ids@...1347...</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: David Sommer=
seth &lt;<a href=3D"mailto:davids@...1347...">davids@...1347...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:davids@...1347...">dav=
ids@...1347...</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:davids@...1347...">davids@...1347...</a> &lt;mailto:<a href=3D"mailto:dav=
ids@...1347...">davids@...1347...</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 m4/pkg.m4 | 7 +++++--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 1 file changed, 5 insertio=
ns(+), 2 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/m4/pkg.m4 b/m4=
/pkg.m4<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0index 9a71878..f82496b 1006=
44<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--- a/m4/pkg.m4<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+++ b/m4/pkg.m4<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -107,16 +107,18 @@ AC_DE=
FUN([PKG_CHECK_MODULES],<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 [AC_REQUIRE([PKG_PROG_PKG_=
CONFIG])dnl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 AC_ARG_VAR([$1][_CFLAGS], =
[C compiler flags for $1, overriding<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0pkg-config])dnl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 AC_ARG_VAR([$1][_LIBS], [l=
inker flags for $1, overriding<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0pkg-config])dnl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+AC_ARG_VAR([$1][_MODVERSIO=
N], [module version])dnl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 pkg_failed=3Dno<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 AC_MSG_CHECKING([for $1])<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 _PKG_CONFIG([$1][_CFLAGS],=
 [cflags], [$2])<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 _PKG_CONFIG([$1][_LIBS], [=
libs], [$2])<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+_PKG_CONFIG([$1][_MODVERSI=
ON], [modversion], [$2])<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 m4_define([_PKG_TEXT], [Al=
ternatively, you may set the<br>
&gt;=C2=A0 =C2=A0 =C2=A0environment<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0variables $1[]_CFLAGS<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-and $1[]_LIBS to avoid the=
 need to call pkg-config.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0-See the pkg-config man pag=
e for more details.])<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+and $1[]_LIBS to avoid the=
 need to call pkg-config.=C2=A0 The<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0$1[]_MODVERSION provides ve=
rsion<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+information.=C2=A0 See the=
 pkg-config man page for more details.])<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 if test $pkg_failed =3D ye=
s; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0AC_MSG_RESULT([no])<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0@@ -153,6 +155,7 @@ To get =
pkg-config, see<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://pkg-c=
onfig.freedesktop.org/" target=3D"_blank">http://pkg-config.freedesktop.org=
/</a>&gt;.])[]dnl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$1[]_CFLAGS=3D$pkg_cv_[]$1[]_CFLAGS<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$1[]_LIBS=3D$pkg_cv_[]$1[]_LIBS<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0$1[]_MODVERSION=3D$pkg_cv_[]$1[]_MODVERSION<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AC_MSG_RESULT([yes])<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0$3<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 fi[]dnl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A01.8.3.1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 --------------------------------------------------=
----------------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Meet PCI DSS 3.0 Compliance=
 Requirements with EventLog Analyzer<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Achieve PCI DSS 3.0 Complia=
nt Status with Out-of-the-box PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0DSS Reports<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Are you Audit-Ready for PCI=
 DSS 3.0 Compliance? Download White<br>
&gt;=C2=A0 =C2=A0 =C2=A0paper<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Comply to PCI DSS 3.0 Requi=
rement 10 and 11.5 with EventLog<br>
&gt;=C2=A0 =C2=A0 =C2=A0Analyzer<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 <a href=3D"http://pubads.g.doubleclick.net/gampad/=
clk?id=3D154622311&amp;iu=3D/4140/ostg.clktrk" target=3D"_blank">http://pub=
ads.g.doubleclick.net/gampad/clk?id=3D154622311&amp;iu=3D/4140/ostg.clktrk<=
/a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0___________________________=
____________________<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Openvpn-devel mailing list<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:Openvpn-d=
evel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailt=
o:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net<=
/a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.so=
urceforge.net/lists/listinfo/openvpn-devel" target=3D"_blank">https://lists=
.sourceforge.net/lists/listinfo/openvpn-devel</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ACK.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"http://cecinestpasunefromage.wordpr=
ess.com/" target=3D"_blank">http://cecinestpasunefromage.wordpress.com/</a>=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ----------------------------------------------=
--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; in your fear, seek only peace<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; in your fear, seek only love<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -d. bowie<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0kind regards,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0David Sommerseth<br>
&gt;<br>
&gt;<br>
&gt; Done.=C2=A0 &lt;facepalm&gt;<br>
<br>
Thanks!=C2=A0 Seems we might have a flamefest on openvpn-devel again ...<br>
well, don&#39;t worry!=C2=A0 Thanks a lot for your ACK.=C2=A0 It did spark =
a reaction<br>
I did expect.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">So go=
es open source development.=C2=A0 Anytime!<br><br></div><div class=3D"gmail=
_extra">-me<br clear=3D"all"></div><div class=3D"gmail_extra"><br>-- <br><a=
 href=3D"http://cecinestpasunefromage.wordpress.com/" target=3D"_blank">htt=
p://cecinestpasunefromage.wordpress.com/</a><br>---------------------------=
---------------------<br>in your fear, seek only peace<br>in your fear, see=
k only love<br><br>-d. bowie
</div></div>

--001a11c366607e40e30504e67fdb--

