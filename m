MIME-Version: 1.0
References: <20211016141519.1928-1-chipitsine@...277...>
In-Reply-To: <20211016141519.1928-1-chipitsine@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 27 Dec 2021 14:07:45 +0500
Message-ID: <CAFHpkQE__1fKsM3fo=1p0u+oNxFcg2YDsxqAXPaRT6nKw__jxQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000006a659e05d41d0a76"
Subject: Re: [Openvpn-devel] [PATCH] BUILD: MSVC: enable the Control-flow
 Enforcement Technology (CET) Shadow Stack mitigation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000006a659e05d41d0a76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

gentle ping


=D1=81=D0=B1, 16 =D0=BE=D0=BA=D1=82. 2021 =D0=B3. =D0=B2 19:15, Ilya Shipit=
sin <chipitsine@...277...>:

> found by BinSkim, more details:
>
> https://docs.microsoft.com/en-us/cpp/build/reference/cetcompat?view=3Dmsv=
c-160
>
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  src/compat/Debug.props                      | 10 ++++++++++
>  src/compat/Release.props                    | 10 ++++++++++
>  src/openvpn/openvpn.vcxproj                 |  4 ++++
>  src/openvpnmsica/openvpnmsica-Debug.props   | 10 ++++++++++
>  src/openvpnmsica/openvpnmsica-Release.props | 10 ++++++++++
>  src/openvpnserv/openvpnserv.vcxproj         |  4 ++++
>  6 files changed, 48 insertions(+)
>
> diff --git a/src/compat/Debug.props b/src/compat/Debug.props
> index 31bb9d91..14d7a1f7 100644
> --- a/src/compat/Debug.props
> +++ b/src/compat/Debug.props
> @@ -17,5 +17,15 @@
>        <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
>      </ClCompile>
>    </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
>    <ItemGroup />
>  </Project>
> \ No newline at end of file
> diff --git a/src/compat/Release.props b/src/compat/Release.props
> index 50eaa8de..df04ddf2 100644
> --- a/src/compat/Release.props
> +++ b/src/compat/Release.props
> @@ -22,5 +22,15 @@
>        <OptimizeReferences>true</OptimizeReferences>
>      </Link>
>    </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
>    <ItemGroup />
>  </Project>
> \ No newline at end of file
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index 65ee6839..38dd22de 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -158,6 +158,7 @@
>
>  <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> @@ -173,6 +174,7 @@
>
>  <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> @@ -204,6 +206,7 @@
>
>  <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> @@ -220,6 +223,7 @@
>
>  <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> diff --git a/src/openvpnmsica/openvpnmsica-Debug.props
> b/src/openvpnmsica/openvpnmsica-Debug.props
> index 43532cfe..c99346af 100644
> --- a/src/openvpnmsica/openvpnmsica-Debug.props
> +++ b/src/openvpnmsica/openvpnmsica-Debug.props
> @@ -10,5 +10,15 @@
>        <RuntimeLibrary>MultiThreadedDebug</RuntimeLibrary>
>      </ClCompile>
>    </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
>    <ItemGroup />
>  </Project>
> \ No newline at end of file
> diff --git a/src/openvpnmsica/openvpnmsica-Release.props
> b/src/openvpnmsica/openvpnmsica-Release.props
> index 47727b35..70f82713 100644
> --- a/src/openvpnmsica/openvpnmsica-Release.props
> +++ b/src/openvpnmsica/openvpnmsica-Release.props
> @@ -11,5 +11,15 @@
>        <ControlFlowGuard>Guard</ControlFlowGuard>
>      </ClCompile>
>    </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
>    <ItemGroup />
>  </Project>
> \ No newline at end of file
> diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> index 5fd7d60b..65d03e3b 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj
> +++ b/src/openvpnserv/openvpnserv.vcxproj
> @@ -130,6 +130,7 @@
>      <Link>
>
>  <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;=
Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> @@ -141,6 +142,7 @@
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpap=
i.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenc=
ies)</AdditionalDependencies>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> @@ -163,6 +165,7 @@
>      <Link>
>
>  <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;=
Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> @@ -174,6 +177,7 @@
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpap=
i.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenc=
ies)</AdditionalDependencies>
>        <SubSystem>Console</SubSystem>
> +      <CETCompat>true</CETCompat>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> --
> 2.29.2.windows.2
>
>

--0000000000006a659e05d41d0a76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><pre style=3D"box-sizing=
:border-box;font-family:ui-monospace,SFMono-Regular,&quot;SF Mono&quot;,Men=
lo,Consolas,&quot;Liberation Mono&quot;,monospace;font-size:13px;margin-top=
:10px;margin-bottom:0px;max-width:100%;line-height:1.45;color:rgb(36,41,47)=
;white-space:pre-wrap;overflow:visible;background-color:rgba(234,238,242,0.=
5)">gentle ping</pre></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">=D1=81=D0=B1, 16 =D0=BE=D0=BA=D1=82. 2021 =D0=B3=
. =D0=B2 19:15, Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...277...">=
chipitsine@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">found by BinSkim, more details:<br>
<a href=3D"https://docs.microsoft.com/en-us/cpp/build/reference/cetcompat?v=
iew=3Dmsvc-160" rel=3D"noreferrer" target=3D"_blank">https://docs.microsoft=
.com/en-us/cpp/build/reference/cetcompat?view=3Dmsvc-160</a><br>
<br>
Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...277..." t=
arget=3D"_blank">chipitsine@...277...</a>&gt;<br>
---<br>
=C2=A0src/compat/Debug.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
=C2=A0src/compat/Release.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
=C2=A0src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<br>
=C2=A0src/openvpnmsica/openvpnmsica-Debug.props=C2=A0 =C2=A0| 10 ++++++++++=
<br>
=C2=A0src/openvpnmsica/openvpnmsica-Release.props | 10 ++++++++++<br>
=C2=A0src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 4 ++++<br>
=C2=A06 files changed, 48 insertions(+)<br>
<br>
diff --git a/src/compat/Debug.props b/src/compat/Debug.props<br>
index 31bb9d91..14d7a1f7 100644<br>
--- a/src/compat/Debug.props<br>
+++ b/src/compat/Debug.props<br>
@@ -17,5 +17,15 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;DebugInformationFormat&gt;EditAndContinue&lt=
;/DebugInformationFormat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup /&gt;<br>
=C2=A0&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/compat/Release.props b/src/compat/Release.props<br>
index 50eaa8de..df04ddf2 100644<br>
--- a/src/compat/Release.props<br>
+++ b/src/compat/Release.props<br>
@@ -22,5 +22,15 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;OptimizeReferences&gt;true&lt;/OptimizeRefer=
ences&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup /&gt;<br>
=C2=A0&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj<br>
index 65ee6839..38dd22de 100644<br>
--- a/src/openvpn/openvpn.vcxproj<br>
+++ b/src/openvpn/openvpn.vcxproj<br>
@@ -158,6 +158,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Ncrypt.lib;gdi32.l=
ib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;R=
pcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
@@ -173,6 +174,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Ncrypt.lib;gdi32.l=
ib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;R=
pcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
@@ -204,6 +206,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Ncrypt.lib;gdi32.l=
ib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;R=
pcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
@@ -220,6 +223,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Ncrypt.lib;gdi32.l=
ib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;R=
pcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
diff --git a/src/openvpnmsica/openvpnmsica-Debug.props b/src/openvpnmsica/o=
penvpnmsica-Debug.props<br>
index 43532cfe..c99346af 100644<br>
--- a/src/openvpnmsica/openvpnmsica-Debug.props<br>
+++ b/src/openvpnmsica/openvpnmsica-Debug.props<br>
@@ -10,5 +10,15 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;RuntimeLibrary&gt;MultiThreadedDebug&lt;/Run=
timeLibrary&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup /&gt;<br>
=C2=A0&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpnmsica/openvpnmsica-Release.props b/src/openvpnmsica=
/openvpnmsica-Release.props<br>
index 47727b35..70f82713 100644<br>
--- a/src/openvpnmsica/openvpnmsica-Release.props<br>
+++ b/src/openvpnmsica/openvpnmsica-Release.props<br>
@@ -11,5 +11,15 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup /&gt;<br>
=C2=A0&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj<br>
index 5fd7d60b..65d03e3b 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj<br>
@@ -130,6 +130,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Userenv.lib;Iphlpa=
pi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependen=
cies)&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
@@ -141,6 +142,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shl=
wapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
@@ -163,6 +165,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Userenv.lib;Iphlpa=
pi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependen=
cies)&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
@@ -174,6 +177,7 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shl=
wapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
-- <br>
2.29.2.windows.2<br>
<br>
</blockquote></div></div>

--0000000000006a659e05d41d0a76--

