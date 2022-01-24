MIME-Version: 1.0
References: <20220120212243.306-1-lstipakov@...277...>
In-Reply-To: <20220120212243.306-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 24 Jan 2022 11:36:47 -0500
Message-ID: <CAKuzo_gK2s3uvnu7RPRTJK6YcDOuP+GhUTsv8b2x_9yJ+-cJ_g@...278...>
Content-Type: multipart/alternative; boundary="0000000000001f162f05d656948b"
Subject: Re: [Openvpn-devel] [PATCH] msvc: switch to openssl3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000001f162f05d656948b
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Jan 24, 2022 at 4:47 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
>  - add openssl3 port from
> https://github.com/microsoft/vcpkg/pull/20428/files
> with small changes:
>
> --- portfile.cmake.orig 2022-01-24 11:04:44.914467900 +0200
> +++ portfile.cmake      2022-01-24 11:02:46.066088800 +0200
> @@ -5,8 +5,8 @@
>  vcpkg_from_github(
>      OUT_SOURCE_PATH SOURCE_PATH
>      REPO openssl/openssl
> -    REF openssl-3.0.0
> -    SHA512
>
> 50b4fefa3e5a3359e7b06bfbc4ecc525ef9d76e13d087aa8e2d29880f08f74cc9d0c76b9bf1895c118def2bb0e4db0095e799a752b64b60721a423bd2cf989da
> +    REF openssl-3.0.1
> +    SHA512
>
> 7f303769a3a796b88478399d42aa2a9a70dc74f62c975bbb93e8903e3bb8e25f16ecfc436186c2d4aa7383302c73ad1dd8ac4fccaa589062bbce6059d6073f18
>  )
>
>  if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
> @@ -114,13 +114,13 @@
>  if(VCPKG_TARGET_IS_UWP OR VCPKG_TARGET_IS_WINDOWS)
>      message(STATUS "Building ${TARGET_TRIPLET}-dbg")
>      vcpkg_execute_required_process(
> -        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
> install_dev
> +        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
> install_dev install_runtime
>          WORKING_DIRECTORY
> "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
>          LOGNAME install-${TARGET_TRIPLET}-dbg
>      )
>      message(STATUS "Building ${TARGET_TRIPLET}-rel")
>      vcpkg_execute_required_process(
> -        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
> install_dev
> +        COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F makefile
> install_dev install_runtime
>          WORKING_DIRECTORY
> "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
>          LOGNAME install-${TARGET_TRIPLET}-rel
>      )
> @@ -129,13 +129,13 @@
>  else()
>      message(STATUS "Building ${TARGET_TRIPLET}-dbg")
>      vcpkg_execute_required_process(
> -        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
> +        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
> install_runtime
>          WORKING_DIRECTORY
> "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg"
>          LOGNAME install-${TARGET_TRIPLET}-dbg
>      )
>      message(STATUS "Building ${TARGET_TRIPLET}-rel")
>      vcpkg_execute_required_process(
> -        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
> +        COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} install_dev
> install_runtime
>          WORKING_DIRECTORY
> "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel"
>          LOGNAME install-${TARGET_TRIPLET}-rel
>      )
> @@ -161,6 +161,17 @@
>
>  endif()
>
> +if(VCPKG_TARGET_IS_WINDOWS)
> +    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/openssl/")
> +    file(RENAME "${CURRENT_PACKAGES_DIR}/bin/openssl.exe"
> "${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.exe")
> +
> +    file(REMOVE
> +        "${CURRENT_PACKAGES_DIR}/debug/bin/openssl.exe"
> +    )
> +endif()
> +
> +vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/openssl")
> +
>  if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
>      file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/libcrypto.a"
>                  "${CURRENT_PACKAGES_DIR}/debug/lib/libssl.a"
> @@ -184,4 +195,4 @@
>  )
>  file(INSTALL     "${CURRENT_PORT_DIR}/usage"
>       DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
> -)
> \ No newline at end of file
> +)
>

A whole patch in the commit message is not very helpful and makes it hard
to read. Why not include this patch + the original, and apply the patch
during build?

Or just add a pointer to the original file in the changed file so that it
could be diff-ed against if need be,


>  - use sizeof(void *) since msvc doesn't support sizeof of function ptr


>  - use XKEY_PROV_PROPS macro instead of props since msvc
>   requires constant expression in aggregate initializers
>

These changes look sane though I think this should be a separate commit.

Selva

--0000000000001f162f05d656948b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Jan 24, 2022 at 4:47 AM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stipakov =
&lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt=
;<br>
<br>
=C2=A0- add openssl3 port from <a href=3D"https://github.com/microsoft/vcpk=
g/pull/20428/files" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/microsoft/vcpkg/pull/20428/files</a><br>
with small changes:<br>
<br>
--- portfile.cmake.orig 2022-01-24 11:04:44.914467900 +0200<br>
+++ portfile.cmake=C2=A0 =C2=A0 =C2=A0 2022-01-24 11:02:46.066088800 +0200<=
br>
@@ -5,8 +5,8 @@<br>
=C2=A0vcpkg_from_github(<br>
=C2=A0 =C2=A0 =C2=A0OUT_SOURCE_PATH SOURCE_PATH<br>
=C2=A0 =C2=A0 =C2=A0REPO openssl/openssl<br>
-=C2=A0 =C2=A0 REF openssl-3.0.0<br>
-=C2=A0 =C2=A0 SHA512<br>
50b4fefa3e5a3359e7b06bfbc4ecc525ef9d76e13d087aa8e2d29880f08f74cc9d0c76b9bf1=
895c118def2bb0e4db0095e799a752b64b60721a423bd2cf989da<br>
+=C2=A0 =C2=A0 REF openssl-3.0.1<br>
+=C2=A0 =C2=A0 SHA512<br>
7f303769a3a796b88478399d42aa2a9a70dc74f62c975bbb93e8903e3bb8e25f16ecfc43618=
6c2d4aa7383302c73ad1dd8ac4fccaa589062bbce6059d6073f18<br>
=C2=A0)<br>
<br>
=C2=A0if(VCPKG_LIBRARY_LINKAGE STREQUAL &quot;dynamic&quot;)<br>
@@ -114,13 +114,13 @@<br>
=C2=A0if(VCPKG_TARGET_IS_UWP OR VCPKG_TARGET_IS_WINDOWS)<br>
=C2=A0 =C2=A0 =C2=A0message(STATUS &quot;Building ${TARGET_TRIPLET}-dbg&quo=
t;)<br>
=C2=A0 =C2=A0 =C2=A0vcpkg_execute_required_process(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F m=
akefile<br>
install_dev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F m=
akefile<br>
install_dev install_runtime<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKING_DIRECTORY<br>
&quot;${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOGNAME install-${TARGET_TRIPLET}-dbg<br>
=C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0message(STATUS &quot;Building ${TARGET_TRIPLET}-rel&quo=
t;)<br>
=C2=A0 =C2=A0 =C2=A0vcpkg_execute_required_process(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F m=
akefile<br>
install_dev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${JOM} /K /J ${VCPKG_CONCURRENCY} /F m=
akefile<br>
install_dev install_runtime<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKING_DIRECTORY<br>
&quot;${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOGNAME install-${TARGET_TRIPLET}-rel<br>
=C2=A0 =C2=A0 =C2=A0)<br>
@@ -129,13 +129,13 @@<br>
=C2=A0else()<br>
=C2=A0 =C2=A0 =C2=A0message(STATUS &quot;Building ${TARGET_TRIPLET}-dbg&quo=
t;)<br>
=C2=A0 =C2=A0 =C2=A0vcpkg_execute_required_process(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} instal=
l_dev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} instal=
l_dev<br>
install_runtime<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKING_DIRECTORY<br>
&quot;${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOGNAME install-${TARGET_TRIPLET}-dbg<br>
=C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0message(STATUS &quot;Building ${TARGET_TRIPLET}-rel&quo=
t;)<br>
=C2=A0 =C2=A0 =C2=A0vcpkg_execute_required_process(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} instal=
l_dev<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMAND ${MAKE} -j ${VCPKG_CONCURRENCY} instal=
l_dev<br>
install_runtime<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKING_DIRECTORY<br>
&quot;${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LOGNAME install-${TARGET_TRIPLET}-rel<br>
=C2=A0 =C2=A0 =C2=A0)<br>
@@ -161,6 +161,17 @@<br>
<br>
=C2=A0endif()<br>
<br>
+if(VCPKG_TARGET_IS_WINDOWS)<br>
+=C2=A0 =C2=A0 file(MAKE_DIRECTORY &quot;${CURRENT_PACKAGES_DIR}/tools/open=
ssl/&quot;)<br>
+=C2=A0 =C2=A0 file(RENAME &quot;${CURRENT_PACKAGES_DIR}/bin/openssl.exe&qu=
ot;<br>
&quot;${CURRENT_PACKAGES_DIR}/tools/openssl/openssl.exe&quot;)<br>
+<br>
+=C2=A0 =C2=A0 file(REMOVE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${CURRENT_PACKAGES_DIR}/debug/bin/openss=
l.exe&quot;<br>
+=C2=A0 =C2=A0 )<br>
+endif()<br>
+<br>
+vcpkg_copy_tool_dependencies(&quot;${CURRENT_PACKAGES_DIR}/tools/openssl&q=
uot;)<br>
+<br>
=C2=A0if(VCPKG_LIBRARY_LINKAGE STREQUAL &quot;dynamic&quot;)<br>
=C2=A0 =C2=A0 =C2=A0file(REMOVE &quot;${CURRENT_PACKAGES_DIR}/debug/lib/lib=
crypto.a&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;${CURRE=
NT_PACKAGES_DIR}/debug/lib/libssl.a&quot;<br>
@@ -184,4 +195,4 @@<br>
=C2=A0)<br>
=C2=A0file(INSTALL=C2=A0 =C2=A0 =C2=A0&quot;${CURRENT_PORT_DIR}/usage&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0 DESTINATION &quot;${CURRENT_PACKAGES_DIR}/share/${PORT=
}&quot;<br>
-)<br>
\ No newline at end of file<br>
+)<br></blockquote><div><br></div><div>A whole patch in the commit message =
is not very helpful and makes it hard to read. Why not include this patch=
=C2=A0+ the original, and apply the patch during build?<br></div><div><br><=
/div><div>Or just add a pointer to the original file in the changed file so=
 that it could be diff-ed against if need be,</div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0- use sizeof(void *) since msvc doesn&#39;t support sizeof of functio=
n ptr=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0- use XKEY_PROV_PROPS macro instead of props since msvc<br>
=C2=A0 requires constant expression in aggregate initializers<br></blockquo=
te><div><br></div><div>These changes look sane though I think this should b=
e a separate commit.</div><div><br></div><div>Selva</div></div></div>

--0000000000001f162f05d656948b--

