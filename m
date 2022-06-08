MIME-Version: 1.0
References: <20220607163049.10056-1-facboy@...277...>
 <20220607163049.10056-2-facboy@...277...>
In-Reply-To: <20220607163049.10056-2-facboy@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 8 Jun 2022 09:37:56 +0300
Message-ID: <CAGyAFMVvUsGC_MQFT6x51LUyXE1Dk7grYnJAiuMW5NjDhhOLBQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000c8759005e0e9f232"
Subject: Re: [Openvpn-devel] [PATCH OpenVPN3 2/2] omi: add support for
 ovpn-dco-win
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christopher Ng <facboy@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c8759005e0e9f232
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As discussed at https://github.com/OpenVPN/openvpn3/pull/218

Acked-by: Lev Stipakov <lstipakov@...277...>

ti 7. kes=C3=A4k. 2022 klo 20.26 Christopher Ng (facboy@...277...) kirjoitt=
i:

> Signed-off-by: Christopher Ng <facboy@...277...>
> ---
>  openvpn/omi/CMakeLists.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/openvpn/omi/CMakeLists.txt b/openvpn/omi/CMakeLists.txt
> index d773da39..cd7cb8fd 100644
> --- a/openvpn/omi/CMakeLists.txt
> +++ b/openvpn/omi/CMakeLists.txt
> @@ -1,3 +1,5 @@
> +option(CLI_OVPNDCOWIN "Build ovpncli with ovpn-dco-win driver support"
> OFF)
> +
>  add_executable(omicliagent openvpn.cpp)
>  add_core_dependencies(omicliagent)
>  add_json_library(omicliagent)
> @@ -5,3 +7,10 @@ target_compile_definitions(omicliagent PRIVATE
> -DOPENVPN_COMMAND_AGENT -DOVPNAGE
>
>  add_executable(omicli openvpn.cpp)
>  add_core_dependencies(omicli)
> +
> +if (WIN32 AND ${CLI_OVPNDCOWIN})
> +    target_compile_definitions(omicliagent PRIVATE ENABLE_OVPNDCOWIN)
> +    target_compile_definitions(omicli PRIVATE ENABLE_OVPNDCOWIN)
> +    target_link_libraries(omicliagent "bcrypt.lib")
> +    target_link_libraries(omicli "bcrypt.lib")
> +endif ()
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


--=20
-Lev

--000000000000c8759005e0e9f232
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As discussed at=C2=A0<a href=3D"https://github.com/OpenVPN=
/openvpn3/pull/218">https://github.com/OpenVPN/openvpn3/pull/218</a><div><b=
r></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1354...=
..">lstipakov@...277...</a>&gt;<br></div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">ti 7. kes=C3=A4k. 2022 klo 20.26 C=
hristopher Ng (<a href=3D"mailto:facboy@...277...">facboy@...277...</a>) ki=
rjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-=
off-by: Christopher Ng &lt;<a href=3D"mailto:facboy@...277..." target=3D"_b=
lank">facboy@...277...</a>&gt;<br>
---<br>
=C2=A0openvpn/omi/CMakeLists.txt | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/openvpn/omi/CMakeLists.txt b/openvpn/omi/CMakeLists.txt<br>
index d773da39..cd7cb8fd 100644<br>
--- a/openvpn/omi/CMakeLists.txt<br>
+++ b/openvpn/omi/CMakeLists.txt<br>
@@ -1,3 +1,5 @@<br>
+option(CLI_OVPNDCOWIN &quot;Build ovpncli with ovpn-dco-win driver support=
&quot; OFF)<br>
+<br>
=C2=A0add_executable(omicliagent openvpn.cpp)<br>
=C2=A0add_core_dependencies(omicliagent)<br>
=C2=A0add_json_library(omicliagent)<br>
@@ -5,3 +7,10 @@ target_compile_definitions(omicliagent PRIVATE -DOPENVPN_C=
OMMAND_AGENT -DOVPNAGE<br>
<br>
=C2=A0add_executable(omicli openvpn.cpp)<br>
=C2=A0add_core_dependencies(omicli)<br>
+<br>
+if (WIN32 AND ${CLI_OVPNDCOWIN})<br>
+=C2=A0 =C2=A0 target_compile_definitions(omicliagent PRIVATE ENABLE_OVPNDC=
OWIN)<br>
+=C2=A0 =C2=A0 target_compile_definitions(omicli PRIVATE ENABLE_OVPNDCOWIN)=
<br>
+=C2=A0 =C2=A0 target_link_libraries(omicliagent &quot;bcrypt.lib&quot;)<br>
+=C2=A0 =C2=A0 target_link_libraries(omicli &quot;bcrypt.lib&quot;)<br>
+endif ()<br>
-- <br>
2.34.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000c8759005e0e9f232--

