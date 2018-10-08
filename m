MIME-Version: 1.0
References: <20181008100323.11308-1-simon@...2293...>
In-Reply-To: <20181008100323.11308-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 8 Oct 2018 14:33:57 +0300
Message-ID: <CAGyAFMUyxQoRdYPE82Quu5i0b6_CRmk2nB3XTQuGnhz9o5hC6g@...278...>
Content-Type: multipart/alternative; boundary="000000000000be6ff50577b5ff77"
Subject: Re: [Openvpn-devel] [PATCH] Reference msvc-generate from compat to
 assure correct build order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: simon@...2293...
Cc: openvpn-devel@lists.sourceforge.net

--000000000000be6ff50577b5ff77
Content-Type: text/plain; charset="UTF-8"

Acked-by: Lev Stipakov <lev@...515...>

ma 8. lokak. 2018 klo 13.05 Simon Rozman (simon@...2293...) kirjoitti:

> Single-process builds start building compat project first and they fail,
> since the referenced config-msvc-version.h is not available yet. Multi-
> process rebuilds also tends to fail if the compat project is built
> faster than msvc-generate is able to produce the required output files.
>
> Adding a reference to msvc-generate project assures correct build order.
> ---
>  src/compat/compat.vcxproj | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
> index 07d6baf1..d6473581 100644
> --- a/src/compat/compat.vcxproj
> +++ b/src/compat/compat.vcxproj
> @@ -143,6 +143,12 @@
>    <ItemGroup>
>      <ClInclude Include="compat.h" />
>    </ItemGroup>
> +  <ItemGroup>
> +    <ProjectReference
> Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
> +      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
> +      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
> +    </ProjectReference>
> +  </ItemGroup>
>    <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
>    <ImportGroup Label="ExtensionTargets">
>    </ImportGroup>
> --
> 2.19.0.windows.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


-- 
-Lev

--000000000000be6ff50577b5ff77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515...=
">lev@...515...</a>&gt;</div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
">ma 8. lokak. 2018 klo 13.05 Simon Rozman (<a href=3D"mailto:simon@...2462...=
...">simon@...2293...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Single-process builds start building compat project first and they fail,=
<br>
since the referenced config-msvc-version.h is not available yet. Multi-<br>
process rebuilds also tends to fail if the compat project is built<br>
faster than msvc-generate is able to produce the required output files.<br>
<br>
Adding a reference to msvc-generate project assures correct build order.<br>
---<br>
=C2=A0src/compat/compat.vcxproj | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj<br>
index 07d6baf1..d6473581 100644<br>
--- a/src/compat/compat.vcxproj<br>
+++ b/src/compat/compat.vcxproj<br>
@@ -143,6 +143,12 @@<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;compat.h&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
+=C2=A0 &lt;ItemGroup&gt;<br>
+=C2=A0 =C2=A0 &lt;ProjectReference Include=3D&quot;..\..\build\msvc\msvc-g=
enerate\msvc-generate.vcxproj&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Project&gt;{8598c2c8-34c4-47a1-99b0-7c295a890615}=
&lt;/Project&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;ReferenceOutputAssembly&gt;false&lt;/ReferenceOut=
putAssembly&gt;<br>
+=C2=A0 =C2=A0 &lt;/ProjectReference&gt;<br>
+=C2=A0 &lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-- <br>
2.19.0.windows.1<br>
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
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature">-Lev</div>

--000000000000be6ff50577b5ff77--

