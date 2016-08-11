MIME-Version: 1.0
In-Reply-To: <1470684488-21307-4-git-send-email-davids@...515...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
	<1470684488-21307-4-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Aug 2016 02:45:54 -0400
Message-ID: <CAKuzo_jZtCO1df5f3EWFPtEwgDsdOcB4jH9q=Co4Ye8WG5urcg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0764164859850539c61f1e
Subject: Re: [Openvpn-devel] [PATCH v4 3/4] autotools: Add support for
 extracting version information from pkg-config modules
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0764164859850539c61f1e
Content-Type: text/plain; charset=UTF-8

Hi,

I missed this patch -- must have deleted from the inbox by mistake. So that
explains my silly comment about pkg.m4 in a previous mail.

On Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <davids@...515...> wrote:

> This patch adds extracting the pkg-config --modversion output into a
> variable configure.ac can consume.  The extracted content is put
> into ${pkgname}_MODVERSION.  See config.log for details after
> ./configure have run.
>
> The patch also modifies slightly how the pkg-config result is
> processed.  Pkg-config can in some situations report more than one
> line of information if more pkg-config meta-data files are available
> for the same package.  This can cause automake to choke as certain
> variables may be split over more lines.  A simple fix was chosen,
> using 'tail' to ensure only one line is being processed.
>

Keeping aside the drawbacks of pkg-config, this is not optimal. First,
pkg.m4 macro works fine  without the piping to tail for --cflags and --libs
even with multiple modules by design: With those options pkg-config
explicitly does duplicate removal and merges the result onto a single line
suitable for setting the LIBS and CFLAGS variables. The option
--modversion, on the other hand, is not designed for such a use and is
documented to print the version for each module on a separate line. Thus
this 'tail hack' is necessitated by trying to use --modversion like
--cflags.

Secondly, customizing  a well known m4 macro (PKG_CHECK_MODULES) without
renaming it doesn't look ideal. Thirdly, the version checking needed to
find whether --echo is supported can be done without editing the macro at
all. Something like the following added after the PKG_CHECK_MODULES will do

PKG_CHECK_EXISTS( [libsystemd > 216],
                     [AC_DEFINE([SYSTEMD_ASKPASS_HAS_ECHO], [1],
                           [systemd-ask-password supports --echo option])]
                    )

Then add --echo only if SYSTEMD_ASKPASS_HAS_ECHO is defined.

Selva

--94eb2c0764164859850539c61f1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br></div>I missed this patch -- must have del=
eted from the inbox by mistake. So that explains my silly comment about pkg=
.m4 in a previous mail.<br><div><div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <span =
dir=3D"ltr">&lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">david=
s@...515...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">This patch adds extracting the pkg-config --modversion output i=
nto a<br>
variable <a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blan=
k">configure.ac</a> can consume.=C2=A0 The extracted content is put<br>
into ${pkgname}_MODVERSION.=C2=A0 See config.log for details after<br>
./configure have run.<br>
<br>
The patch also modifies slightly how the pkg-config result is<br>
processed.=C2=A0 Pkg-config can in some situations report more than one<br>
line of information if more pkg-config meta-data files are available<br>
for the same package.=C2=A0 This can cause automake to choke as certain<br>
variables may be split over more lines.=C2=A0 A simple fix was chosen,<br>
using &#39;tail&#39; to ensure only one line is being processed.<br></block=
quote><div><br>Keeping aside the drawbacks of pkg-config, this is not optim=
al. First, pkg.m4 macro works fine=C2=A0 without the piping to tail for --c=
flags and --libs even with multiple modules by design: With those options p=
kg-config explicitly does duplicate removal and merges the result onto a si=
ngle line suitable for setting the LIBS and CFLAGS variables. The option --=
modversion, on the other hand, is not designed for such a use and is docume=
nted to print the version for each module on a separate line. Thus=C2=A0 th=
is &#39;tail hack&#39; is necessitated by trying to use --modversion like -=
-cflags.<br><br></div><div>Secondly, customizing=C2=A0 a well known m4 macr=
o (PKG_CHECK_MODULES) without renaming it doesn&#39;t look ideal. Thirdly, =
the version checking needed to find whether --echo is supported can be done=
 without editing the macro at all. Something like the following added after=
 the PKG_CHECK_MODULES will do<br><br>PKG_CHECK_EXISTS( [libsystemd &gt; 21=
6],<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [AC_DEFINE([SYSTEMD_=
ASKPASS_<wbr>HAS_ECHO], [1],<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [systemd-ask-password supports --ec=
ho option])]<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )<br></div><div><=
br>Then add --echo only if SYSTEMD_ASKPASS_HAS_ECHO is defined.<br></div><d=
iv><br></div><div>Selva<br></div></div></div></div></div></div>

--94eb2c0764164859850539c61f1e--

