MIME-Version: 1.0
References: <20191107122743.GQ40538@...1296...>
 <20191107132901.1280-1-simon@...2293...>
In-Reply-To: <20191107132901.1280-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 7 Nov 2019 15:33:14 +0200
Message-ID: <CAGyAFMVSMz_xkkosN+cfNLGpJ+m4ts=eYWjMpvqAJVqNLBScWQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000de502a0596c1b525"
Subject: Re: [Openvpn-devel] [PATCH] msvc: Add vlan.c/h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000de502a0596c1b525
Content-Type: text/plain; charset="UTF-8"

Acked-by: Lev Stipakov <lev@...515...>

to 7. marrask. 2019 klo 15.30 Simon Rozman (simon@...2293...) kirjoitti:

> This upgrades 99f28081477ca325a14b13c38abec2c9b619eb01 to support MSVC
> building.
>
> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/openvpn/openvpn.vcxproj         | 2 ++
>  src/openvpn/openvpn.vcxproj.filters | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index 85af466f..48e8e140 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -196,6 +196,7 @@
>      <ClCompile Include="status.c" />
>      <ClCompile Include="tls_crypt.c" />
>      <ClCompile Include="tun.c" />
> +    <ClCompile Include="vlan.c" />
>      <ClCompile Include="win32.c" />
>    </ItemGroup>
>    <ItemGroup>
> @@ -283,6 +284,7 @@
>      <ClInclude Include="syshead.h" />
>      <ClInclude Include="tls_crypt.h" />
>      <ClInclude Include="tun.h" />
> +    <ClInclude Include="vlan.h" />
>      <ClInclude Include="win32.h" />
>    </ItemGroup>
>    <ItemGroup>
> diff --git a/src/openvpn/openvpn.vcxproj.filters
> b/src/openvpn/openvpn.vcxproj.filters
> index e6068aff..653e892c 100644
> --- a/src/openvpn/openvpn.vcxproj.filters
> +++ b/src/openvpn/openvpn.vcxproj.filters
> @@ -237,6 +237,9 @@
>      <ClCompile Include="auth_token.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> +    <ClCompile Include="vlan.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
>    </ItemGroup>
>    <ItemGroup>
>      <ClInclude Include="base64.h">
> @@ -494,6 +497,9 @@
>      <ClInclude Include="auth_token.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> +    <ClInclude Include="vlan.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
>    </ItemGroup>
>    <ItemGroup>
>      <ResourceCompile Include="openvpn_win32_resources.rc">
> --
> 2.23.0.windows.1
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

--000000000000de502a0596c1b525
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515...=
">lev@...515...</a>&gt;</div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">to 7. marrask. 2019 klo 15.30 Simon Rozman (<a href=
=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>) kirjoi=
tti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This upgrad=
es 99f28081477ca325a14b13c38abec2c9b619eb01 to support MSVC<br>
building.<br>
<br>
Signed-off-by: Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." target=
=3D"_blank">simon@...2293...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<b=
r>
=C2=A0src/openvpn/openvpn.vcxproj.filters | 6 ++++++<br>
=C2=A02 files changed, 8 insertions(+)<br>
<br>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj<br>
index 85af466f..48e8e140 100644<br>
--- a/src/openvpn/openvpn.vcxproj<br>
+++ b/src/openvpn/openvpn.vcxproj<br>
@@ -196,6 +196,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;status.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;tls_crypt.c&quot; /&gt;<b=
r>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;tun.c&quot; /&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;vlan.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;win32.c&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
@@ -283,6 +284,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;syshead.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;tls_crypt.h&quot; /&gt;<b=
r>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;tun.h&quot; /&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;vlan.h&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;win32.h&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxp=
roj.filters<br>
index e6068aff..653e892c 100644<br>
--- a/src/openvpn/openvpn.vcxproj.filters<br>
+++ b/src/openvpn/openvpn.vcxproj.filters<br>
@@ -237,6 +237,9 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;auth_token.c&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;vlan.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;base64.h&quot;&gt;<br>
@@ -494,6 +497,9 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;auth_token.h&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;vlan.h&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClInclude&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile Include=3D&quot;openvpn_win32_resou=
rces.rc&quot;&gt;<br>
-- <br>
2.23.0.windows.1<br>
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
>-Lev</div>

--000000000000de502a0596c1b525--

