MIME-Version: 1.0
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1573760407-20662-1-git-send-email-selva.nair@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 14 Nov 2019 21:16:10 +0100
Message-ID: <CAFHpkQF+5iwq-J60RwdDj2PhD4GEjJsxLZ2SfZ5qKrERVVfQOg@...278...>
Content-Type: multipart/alternative; boundary="000000000000b165a00597542796"
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b165a00597542796
Content-Type: text/plain; charset="UTF-8"

Thank you for your efforts.
As you are touching this, can you try "dist: bionic" ? It might bring newer
compilers

On Thu, Nov 14, 2019, 8:41 PM <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> Some compilers (e.g., clang) only issue a warning for
> unsupported options unless additional flags such
> as -Werror are used to convert the warning to an error.
>
> Add support for extra flags in ACL_CHECK_ADD_COMPILE_FLAGS.
>
> Note: a similar approach is used in AX_CHECK_COMPILE_FLAG
> in autoconf archives.
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>
> For successful travis build result see
> https://travis-ci.org/selvanair/openvpn/builds/612019849
>
> But this + https://patchwork.openvpn.net/patch/908/
> alone does not fix the travis build as clang is not
> happy with struct initializers: Like this
>
> crypto.c:1860:31: error: suggest braces around initialization of subobject
>       [-Werror,-Wmissing-braces]
>     struct key server_key = { 0 };
>
> I think clang wants {{0}} there.
>
> Darn compilers and darn -Werror :)
>
>  configure.ac | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 807804e5..e59bd91b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1275,18 +1275,21 @@ if test "${enable_pkcs11}" = "yes"; then
>         )
>  fi
>
> +# Usage: ACL_CHECK_ADD_COMPILE_FLAGS(flag, [extra-flags])
> +# Some compilers require extra flags to trigger an error on
> +# unsupported options. E.g., clang requires -Werror.
>  AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
>      old_cflags="$CFLAGS"
> -    CFLAGS="$1 $CFLAGS"
> -    AC_MSG_CHECKING([whether the compiler acceppts $1])
> -    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])],
> +    CFLAGS="$2 $1 $CFLAGS"
> +    AC_MSG_CHECKING([whether the compiler accepts $1])
> +    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])];
> CFLAGS="$1 $old_cflags",
>          [AC_MSG_RESULT([no]); CFLAGS="$old_cflags"])]
>  )
>
> -ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
> -ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function])
> -ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter])
> -ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
> +ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation], [-Werror])
> +ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function], [-Werror])
> +ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter], [-Werror])
> +ACL_CHECK_ADD_COMPILE_FLAGS([-Wall], [-Werror])
>
>  if test "${enable_pedantic}" = "yes"; then
>         enable_strict="yes"
> --
> 2.20.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000b165a00597542796
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you for your efforts.<div dir=3D"auto">As you are t=
ouching this, can you try &quot;dist: bionic&quot; ? It might bring newer c=
ompilers</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Nov 14, 2019, 8:41 PM  &lt;<a href=3D"mailto:selva.=
nair@...277...">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...1663...=
." target=3D"_blank" rel=3D"noreferrer">selva.nair@...277...</a>&gt;<br>
<br>
Some compilers (e.g., clang) only issue a warning for<br>
unsupported options unless additional flags such<br>
as -Werror are used to convert the warning to an error.<br>
<br>
Add support for extra flags in ACL_CHECK_ADD_COMPILE_FLAGS.<br>
<br>
Note: a similar approach is used in AX_CHECK_COMPILE_FLAG<br>
in autoconf archives.<br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank" rel=3D"noreferrer">selva.nair@...277...</a>&gt;<br>
---<br>
<br>
For successful travis build result see<br>
<a href=3D"https://travis-ci.org/selvanair/openvpn/builds/612019849" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://travis-ci.org/selvanair/o=
penvpn/builds/612019849</a><br>
<br>
But this + <a href=3D"https://patchwork.openvpn.net/patch/908/" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">https://patchwork.openvpn.net/patch/90=
8/</a><br>
alone does not fix the travis build as clang is not<br>
happy with struct initializers: Like this<br>
<br>
crypto.c:1860:31: error: suggest braces around initialization of subobject<=
br>
=C2=A0 =C2=A0 =C2=A0 [-Werror,-Wmissing-braces]<br>
=C2=A0 =C2=A0 struct key server_key =3D { 0 };<br>
<br>
I think clang wants {{0}} there.<br>
<br>
Darn compilers and darn -Werror :)<br>
<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer noreferrer" target=
=3D"_blank">configure.ac</a> | 17 ++++++++++-------<br>
=C2=A01 file changed, 10 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer noreferrer" =
target=3D"_blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D=
"noreferrer noreferrer" target=3D"_blank">configure.ac</a><br>
index 807804e5..e59bd91b 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer noreferrer" target=
=3D"_blank">configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer noreferrer" target=
=3D"_blank">configure.ac</a><br>
@@ -1275,18 +1275,21 @@ if test &quot;${enable_pkcs11}&quot; =3D &quot;yes&=
quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0fi<br>
<br>
+# Usage: ACL_CHECK_ADD_COMPILE_FLAGS(flag, [extra-flags])<br>
+# Some compilers require extra flags to trigger an error on<br>
+# unsupported options. E.g., clang requires -Werror.<br>
=C2=A0AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [<br>
=C2=A0 =C2=A0 =C2=A0old_cflags=3D&quot;$CFLAGS&quot;<br>
-=C2=A0 =C2=A0 CFLAGS=3D&quot;$1 $CFLAGS&quot;<br>
-=C2=A0 =C2=A0 AC_MSG_CHECKING([whether the compiler acceppts $1])<br>
-=C2=A0 =C2=A0 AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])=
],<br>
+=C2=A0 =C2=A0 CFLAGS=3D&quot;$2 $1 $CFLAGS&quot;<br>
+=C2=A0 =C2=A0 AC_MSG_CHECKING([whether the compiler accepts $1])<br>
+=C2=A0 =C2=A0 AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])=
]; CFLAGS=3D&quot;$1 $old_cflags&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[AC_MSG_RESULT([no]); CFLAGS=3D&quot;$old=
_cflags&quot;])]<br>
=C2=A0)<br>
<br>
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])<br>
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function])<br>
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter])<br>
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])<br>
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation], [-Werror])<br>
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function], [-Werror])<br>
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter], [-Werror])<br>
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wall], [-Werror])<br>
<br>
=C2=A0if test &quot;${enable_pedantic}&quot; =3D &quot;yes&quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_strict=3D&quot;yes&quot;<br>
-- <br>
2.20.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank" re=
l=3D"noreferrer">Openvpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000b165a00597542796--

