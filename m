MIME-Version: 1.0
In-Reply-To: <1470684488-21307-5-git-send-email-davids@...515...>
References: <1470684488-21307-1-git-send-email-davids@...515...>
	<1470684488-21307-5-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 Aug 2016 15:26:03 -0400
Message-ID: <CAKuzo_hJ+2xHnFr63627C+HXdYYWb3xrfwasGrhjAvtAVQ+TEw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05602e055d6e0539bca088
Subject: Re: [Openvpn-devel] [PATCH v4 4/4] systemd: Do not mask usernames
 when querying for it via systemd-ask-password
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

--94eb2c05602e055d6e0539bca088
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <davids@...515...> wrote:

> In systemd after version 216, systemd-ask-password will support --echo
> which
> will avoid masking the user input.  As OpenVPN uses this mechanism
> collecting
> usernames when systemd is available, this will avoid the input of
> usernames to
> be masked.
>

Good to see support for --echo.


>
> diff --git a/configure.ac b/configure.ac
> index c3088fd..a44e1df 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1023,6 +1023,7 @@ if test "$enable_systemd" = "yes" ; then
>      AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd library is
> missing sd_booted()])])
>      OPTIONAL_SYSTEMD_LIBS="${libsystemd_LIBS}"
>      AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
> +    AC_DEFINE_UNQUOTED(SYSTEMD_VERSION, [`echo
> ${libsystemd_MODVERSION}`], [systemd version installed])
>

PKG_CHECK_MODULES() only defines prefix_LIBS and prefix_CFLAGS not
prefix_MODVERSION. So how does libsystemd_MODVERSION get defined? Is there
a new version of pkg.m4 that does this?

With undefined libsystemd_MODVERSION, SYSTEMD_VERSION will get defined with
no value causing SYSTEMD_VERSION > 216 check during compile to error.

By the way, `echo ${libsystemd_MODVERSION}` is very convoluted -- why not
write it simply as

AC_DEFINE_UNQUOTED(SYSTEMD_VERSION, [${libsystemd_MODVERSION}], [systemd
version installed])

Selva

--94eb2c05602e055d6e0539bca088
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Aug 8, 2016 at 3:28 PM, David Sommerseth <span dir=3D"ltr">&=
lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">davids@...515...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);b=
order-left-style:solid;padding-left:1ex">In systemd after version 216, syst=
emd-ask-password will support --echo which<br>
will avoid masking the user input.=C2=A0 As OpenVPN uses this mechanism col=
lecting<br>
usernames when systemd is available, this will avoid the input of usernames=
 to<br>
be masked.<br></blockquote><div><br></div><div>Good to see support for --ec=
ho.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex"><br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index c3088fd..a44e1df 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -1023,6 +1023,7 @@ if test &quot;$enable_systemd&quot; =3D &quot;yes&quo=
t; ; then<br>
=C2=A0 =C2=A0 =C2=A0AC_CHECK_FUNCS([sd_booted], [], [AC_MSG_ERROR([systemd =
library is missing sd_booted()])])<br>
=C2=A0 =C2=A0 =C2=A0OPTIONAL_SYSTEMD_LIBS=3D&quot;${libs<wbr>ystemd_LIBS}&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integratio=
n])<br>
+=C2=A0 =C2=A0 AC_DEFINE_UNQUOTED(SYSTEMD_VER<wbr>SION, [`echo ${libsystemd=
_MODVERSION}`], [systemd version installed])<br></blockquote><div><br></div=
><div>PKG_CHECK_MODULES() only defines prefix_LIBS and prefix_CFLAGS not pr=
efix_MODVERSION. So how does libsystemd_MODVERSION get defined? Is there a =
new version of pkg.m4 that does this?<br></div><div><br></div><div>With und=
efined libsystemd_MODVERSION,=C2=A0SYSTEMD<wbr>_VERSION will get defined wi=
th no value causing SYSTEMD_VERSION &gt; 216 check during compile to error.=
</div><div><br></div><div>By the way, `echo ${libsystemd_MODVERSION}` is ve=
ry convoluted -- why not write it simply as</div><div><br></div><div>AC_DEF=
INE_UNQUOTED(SYSTEMD_VER<wbr>SION, [${libsystemd_MODVERSION}], [systemd ver=
sion installed])</div><div><br></div><div>Selva</div></div></div></div>

--94eb2c05602e055d6e0539bca088--

