MIME-Version: 1.0
In-Reply-To: <20170709144646.10352-1-chipitsine@...277...>
References: <20170709144646.10352-1-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 12 Jul 2017 13:46:37 +0500
Message-ID: <CAFHpkQEPAzvnkRAZLPgLwt8i8LjJrVcKwTp6H32v7Dxz4Jb0Lg@...278...>
Content-Type: multipart/alternative; boundary="001a11442fceae2a9a05541ada21"
Subject: Re: [Openvpn-devel] [PATCH] win32 build: check for ENETUNREACH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a11442fceae2a9a05541ada21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No interest ?

9 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 19:46 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Ilya Shipitsin" <chipitsine@...1482...=
...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> Currently, we do not check for mingw-gcc version. For example,
> Debian 7 is shipped with 4.6.3, which does not know about ENETUNREACH
> ---
>
> this is for 2.4 and HEAD branches
>
>  configure.ac | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 60bb465..80b26ff 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -708,6 +708,20 @@ m4_define(
>         [setsockopt getsockopt getsockname poll]dnl
>  )
>  if test "${WIN32}" =3D "yes"; then
> +
> +#
> +# check for ENETUNREACH
> +# at least Debian 7 is shipped with gcc-mingw-w64-4.6.3, which is too old
> +#
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM(
> +[[#include <errno.h>
> +#if !defined (ENETUNREACH)
> +# error ENETUNREACH not defined
> +#endif
> +]])],
> +                   ,
> +                   [AC_MSG_ERROR([gcc-mingw is too old, please update])])
> +
>  # normal autoconf function checking does not find inet_ntop/inet_pton
>  # because they need to include the actual header file and link ws2_32.dll
>         LIBS=3D"${LIBS} -lws2_32"
> --
> 2.9.4
>
>

--001a11442fceae2a9a05541ada21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">No interest ?</div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">9 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 19:46 =D0=BF=D0=BE=
=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Ilya Shi=
pitsin&quot; &lt;<a href=3D"mailto:chipitsine@...277...">chipitsine@...1354...=
..</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attributi=
on"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Currently, we do not check for mingw-gcc=
 version. For example,<br>
Debian 7 is shipped with 4.6.3, which does not know about ENETUNREACH<br>
---<br>
<br>
this is for 2.4 and HEAD branches<br>
<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a> | 14 ++++++++++++++<br>
=C2=A01 file changed, 14 insertions(+)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 60bb465..80b26ff 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -708,6 +708,20 @@ m4_define(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [setsockopt getsockopt getsockname poll]dnl<br>
=C2=A0)<br>
=C2=A0if test &quot;${WIN32}&quot; =3D &quot;yes&quot;; then<br>
+<br>
+#<br>
+# check for ENETUNREACH<br>
+# at least Debian 7 is shipped with gcc-mingw-w64-4.6.3, which is too old<=
br>
+#<br>
+AC_COMPILE_IFELSE([AC_LANG_<wbr>PROGRAM(<br>
+[[#include &lt;errno.h&gt;<br>
+#if !defined (ENETUNREACH)<br>
+# error ENETUNREACH not defined<br>
+#endif<br>
+]])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[AC_M=
SG_ERROR([gcc-mingw is too old, please update])])<br>
+<br>
=C2=A0# normal autoconf function checking does not find inet_ntop/inet_pton=
<br>
=C2=A0# because they need to include the actual header file and link ws2_32=
.dll<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBS=3D&quot;${LIBS} -lws2_32&quot;<br>
--<br>
2.9.4<br>
<br>
</blockquote></div></div>

--001a11442fceae2a9a05541ada21--

