MIME-Version: 1.0
References: <20211016141519.1928-1-chipitsine@...277...>
 <CAFHpkQE__1fKsM3fo=1p0u+oNxFcg2YDsxqAXPaRT6nKw__jxQ@...278...>
 <CAGyAFMXhZo7m5CuAu4NxuPC5JWOY+ZbZvD_vOiisomdYenz7Zg@...278...>
 <CAFHpkQGvtDXET-6Ja8cTyY5Ok=uO6S-DTtGPGsSMfvZQpVUEjg@...278...>
In-Reply-To: <CAFHpkQGvtDXET-6Ja8cTyY5Ok=uO6S-DTtGPGsSMfvZQpVUEjg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 31 Dec 2021 20:37:34 +0300
Message-ID: <CAFHpkQFwUh6tHLQjjTs02H9qTZc2iwLKG2xcq==JDYdD_+aQwg@...278...>
Content-Type: multipart/alternative; boundary="000000000000e7cdb005d474a08a"
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000e7cdb005d474a08a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the record
https://github.com/microsoft/binskim/issues/508

On Fri, Dec 31, 2021, 8:35 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> CETCOMPAT is not supported for ARM.
> Regarding other arch I do not have particular opinion, I'm fine with
> either props or vcxproj approach
>
> On Fri, Dec 31, 2021, 5:09 PM Lev Stipakov <lstipakov@...277...> wrote:
>
>> Hi,
>>
>> Sorry for the delay.
>>
>>  1) Was it really necessary to modify .props? I enabled this via
>> Linker->Advanced->CET Shadow Stack Compatible and only .vcxproj files
>> got modified.
>>
>>  2) I think we could enable it for all binaries
>> (openvpn/openvpnmsica/openvpnserv/tapctl) for ARM64/WIn32/x64 Release
>> configurations.
>>
>> -Lev
>>
>> ma 27. jouluk. 2021 klo 11.09 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD (chipitsine@...277...)
>> kirjoitti:
>> >
>> > gentle ping
>> >
>> >
>> > =D1=81=D0=B1, 16 =D0=BE=D0=BA=D1=82. 2021 =D0=B3. =D0=B2 19:15, Ilya S=
hipitsin <chipitsine@...277...>:
>> >>
>> >> found by BinSkim, more details:
>> >>
>> https://docs.microsoft.com/en-us/cpp/build/reference/cetcompat?view=3Dms=
vc-160
>> >>
>> >> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
>> >> ---
>> >>  src/compat/Debug.props                      | 10 ++++++++++
>> >>  src/compat/Release.props                    | 10 ++++++++++
>> >>  src/openvpn/openvpn.vcxproj                 |  4 ++++
>> >>  src/openvpnmsica/openvpnmsica-Debug.props   | 10 ++++++++++
>> >>  src/openvpnmsica/openvpnmsica-Release.props | 10 ++++++++++
>> >>  src/openvpnserv/openvpnserv.vcxproj         |  4 ++++
>> >>  6 files changed, 48 insertions(+)
>> >>
>> >> diff --git a/src/compat/Debug.props b/src/compat/Debug.props
>> >> index 31bb9d91..14d7a1f7 100644
>> >> --- a/src/compat/Debug.props
>> >> +++ b/src/compat/Debug.props
>> >> @@ -17,5 +17,15 @@
>> >>        <DebugInformationFormat>EditAndContinue</DebugInformationForma=
t>
>> >>      </ClCompile>
>> >>    </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >>    <ItemGroup />
>> >>  </Project>
>> >> \ No newline at end of file
>> >> diff --git a/src/compat/Release.props b/src/compat/Release.props
>> >> index 50eaa8de..df04ddf2 100644
>> >> --- a/src/compat/Release.props
>> >> +++ b/src/compat/Release.props
>> >> @@ -22,5 +22,15 @@
>> >>        <OptimizeReferences>true</OptimizeReferences>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >>    <ItemGroup />
>> >>  </Project>
>> >> \ No newline at end of file
>> >> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
>> >> index 65ee6839..38dd22de 100644
>> >> --- a/src/openvpn/openvpn.vcxproj
>> >> +++ b/src/openvpn/openvpn.vcxproj
>> >> @@ -158,6 +158,7 @@
>> >>
>> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>> >>
>> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> >> @@ -173,6 +174,7 @@
>> >>
>> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>> >>
>> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>> >> @@ -204,6 +206,7 @@
>> >>
>> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>> >>
>> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >> @@ -220,6 +223,7 @@
>> >>
>> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>> >>
>> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
>> >> diff --git a/src/openvpnmsica/openvpnmsica-Debug.props
>> b/src/openvpnmsica/openvpnmsica-Debug.props
>> >> index 43532cfe..c99346af 100644
>> >> --- a/src/openvpnmsica/openvpnmsica-Debug.props
>> >> +++ b/src/openvpnmsica/openvpnmsica-Debug.props
>> >> @@ -10,5 +10,15 @@
>> >>        <RuntimeLibrary>MultiThreadedDebug</RuntimeLibrary>
>> >>      </ClCompile>
>> >>    </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >>    <ItemGroup />
>> >>  </Project>
>> >> \ No newline at end of file
>> >> diff --git a/src/openvpnmsica/openvpnmsica-Release.props
>> b/src/openvpnmsica/openvpnmsica-Release.props
>> >> index 47727b35..70f82713 100644
>> >> --- a/src/openvpnmsica/openvpnmsica-Release.props
>> >> +++ b/src/openvpnmsica/openvpnmsica-Release.props
>> >> @@ -11,5 +11,15 @@
>> >>        <ControlFlowGuard>Guard</ControlFlowGuard>
>> >>      </ClCompile>
>> >>    </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >> +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >> +    <Link>
>> >> +      <CETCompat>true</CETCompat>
>> >> +    </Link>
>> >> +  </ItemDefinitionGroup>
>> >>    <ItemGroup />
>> >>  </Project>
>> >> \ No newline at end of file
>> >> diff --git a/src/openvpnserv/openvpnserv.vcxproj
>> b/src/openvpnserv/openvpnserv.vcxproj
>> >> index 5fd7d60b..65d03e3b 100644
>> >> --- a/src/openvpnserv/openvpnserv.vcxproj
>> >> +++ b/src/openvpnserv/openvpnserv.vcxproj
>> >> @@ -130,6 +130,7 @@
>> >>      <Link>
>> >>
>> <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;=
Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> >> @@ -141,6 +142,7 @@
>> >>      <Link>
>> >>
>> <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpap=
i.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenc=
ies)</AdditionalDependencies>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>> >> @@ -163,6 +165,7 @@
>> >>      <Link>
>> >>
>> <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;=
Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >> @@ -174,6 +177,7 @@
>> >>      <Link>
>> >>
>> <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpap=
i.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenc=
ies)</AdditionalDependencies>
>> >>        <SubSystem>Console</SubSystem>
>> >> +      <CETCompat>true</CETCompat>
>> >>      </Link>
>> >>    </ItemDefinitionGroup>
>> >>    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
>> >> --
>> >> 2.29.2.windows.2
>> >>
>> > _______________________________________________
>> > Openvpn-devel mailing list
>> > Openvpn-devel@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
>>
>> --
>> -Lev
>>
>

--000000000000e7cdb005d474a08a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">For the record<div dir=3D"auto"><a href=3D"https://github=
.com/microsoft/binskim/issues/508">https://github.com/microsoft/binskim/iss=
ues/508</a><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Dec 31, 2021, 8:35 PM =D0=98=D0=BB=D1=8C=D1=8F=
 =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsin=
e@...277...">chipitsine@...277...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"auto">CETCOMPAT is not supported for ARM.<div dir=
=3D"auto">Regarding other arch I do not have particular opinion, I&#39;m fi=
ne with either props or vcxproj approach</div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 31, 2021, 5:09 PM=
 Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank" =
rel=3D"noreferrer">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">Hi,<br>
<br>
Sorry for the delay.<br>
<br>
=C2=A01) Was it really necessary to modify .props? I enabled this via<br>
Linker-&gt;Advanced-&gt;CET Shadow Stack Compatible and only .vcxproj files=
<br>
got modified.<br>
<br>
=C2=A02) I think we could enable it for all binaries<br>
(openvpn/openvpnmsica/openvpnserv/tapctl) for ARM64/WIn32/x64 Release<br>
configurations.<br>
<br>
-Lev<br>
<br>
ma 27. jouluk. 2021 klo 11.09 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD (<a href=3D"mailto:chipitsine@...277..." rel=3D"no=
referrer noreferrer" target=3D"_blank">chipitsine@...277...</a>) kirjoitti:=
<br>
&gt;<br>
&gt; gentle ping<br>
&gt;<br>
&gt;<br>
&gt; =D1=81=D0=B1, 16 =D0=BE=D0=BA=D1=82. 2021 =D0=B3. =D0=B2 19:15, Ilya S=
hipitsin &lt;<a href=3D"mailto:chipitsine@...277..." rel=3D"noreferrer nore=
ferrer" target=3D"_blank">chipitsine@...277...</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt; found by BinSkim, more details:<br>
&gt;&gt; <a href=3D"https://docs.microsoft.com/en-us/cpp/build/reference/ce=
tcompat?view=3Dmsvc-160" rel=3D"noreferrer noreferrer noreferrer" target=3D=
"_blank">https://docs.microsoft.com/en-us/cpp/build/reference/cetcompat?vie=
w=3Dmsvc-160</a><br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...493...=
277..." rel=3D"noreferrer noreferrer" target=3D"_blank">chipitsine@...1663...=
.</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 src/compat/Debug.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
&gt;&gt;=C2=A0 src/compat/Release.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br>
&gt;&gt;=C2=A0 src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++<br>
&gt;&gt;=C2=A0 src/openvpnmsica/openvpnmsica-Debug.props=C2=A0 =C2=A0| 10 +=
+++++++++<br>
&gt;&gt;=C2=A0 src/openvpnmsica/openvpnmsica-Release.props | 10 ++++++++++<=
br>
&gt;&gt;=C2=A0 src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 4 ++++<br>
&gt;&gt;=C2=A0 6 files changed, 48 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/src/compat/Debug.props b/src/compat/Debug.props<br>
&gt;&gt; index 31bb9d91..14d7a1f7 100644<br>
&gt;&gt; --- a/src/compat/Debug.props<br>
&gt;&gt; +++ b/src/compat/Debug.props<br>
&gt;&gt; @@ -17,5 +17,15 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;EditAndCo=
ntinue&lt;/DebugInformationFormat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemGroup /&gt;<br>
&gt;&gt;=C2=A0 &lt;/Project&gt;<br>
&gt;&gt; \ No newline at end of file<br>
&gt;&gt; diff --git a/src/compat/Release.props b/src/compat/Release.props<b=
r>
&gt;&gt; index 50eaa8de..df04ddf2 100644<br>
&gt;&gt; --- a/src/compat/Release.props<br>
&gt;&gt; +++ b/src/compat/Release.props<br>
&gt;&gt; @@ -22,5 +22,15 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;OptimizeReferences&gt;true&lt;/Opti=
mizeReferences&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemGroup /&gt;<br>
&gt;&gt;=C2=A0 &lt;/Project&gt;<br>
&gt;&gt; \ No newline at end of file<br>
&gt;&gt; diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcx=
proj<br>
&gt;&gt; index 65ee6839..38dd22de 100644<br>
&gt;&gt; --- a/src/openvpn/openvpn.vcxproj<br>
&gt;&gt; +++ b/src/openvpn/openvpn.vcxproj<br>
&gt;&gt; @@ -158,6 +158,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Ncrypt.li=
b;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuc=
lnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalLibraryDirectories&gt;$(O=
PENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDir=
ectories)&lt;/AdditionalLibraryDirectories&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt;&gt; @@ -173,6 +174,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Ncrypt.li=
b;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuc=
lnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalLibraryDirectories&gt;$(O=
PENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDir=
ectories)&lt;/AdditionalLibraryDirectories&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
&gt;&gt; @@ -204,6 +206,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Ncrypt.li=
b;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuc=
lnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalLibraryDirectories&gt;$(O=
PENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDir=
ectories)&lt;/AdditionalLibraryDirectories&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt;&gt; @@ -220,6 +223,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Ncrypt.li=
b;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuc=
lnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalLibraryDirectories&gt;$(O=
PENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDir=
ectories)&lt;/AdditionalLibraryDirectories&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
&gt;&gt; diff --git a/src/openvpnmsica/openvpnmsica-Debug.props b/src/openv=
pnmsica/openvpnmsica-Debug.props<br>
&gt;&gt; index 43532cfe..c99346af 100644<br>
&gt;&gt; --- a/src/openvpnmsica/openvpnmsica-Debug.props<br>
&gt;&gt; +++ b/src/openvpnmsica/openvpnmsica-Debug.props<br>
&gt;&gt; @@ -10,5 +10,15 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebu=
g&lt;/RuntimeLibrary&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemGroup /&gt;<br>
&gt;&gt;=C2=A0 &lt;/Project&gt;<br>
&gt;&gt; \ No newline at end of file<br>
&gt;&gt; diff --git a/src/openvpnmsica/openvpnmsica-Release.props b/src/ope=
nvpnmsica/openvpnmsica-Release.props<br>
&gt;&gt; index 47727b35..70f82713 100644<br>
&gt;&gt; --- a/src/openvpnmsica/openvpnmsica-Release.props<br>
&gt;&gt; +++ b/src/openvpnmsica/openvpnmsica-Release.props<br>
&gt;&gt; @@ -11,5 +11,15 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/Contr=
olFlowGuard&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configura=
tion)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemGroup /&gt;<br>
&gt;&gt;=C2=A0 &lt;/Project&gt;<br>
&gt;&gt; \ No newline at end of file<br>
&gt;&gt; diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv=
/openvpnserv.vcxproj<br>
&gt;&gt; index 5fd7d60b..65d03e3b 100644<br>
&gt;&gt; --- a/src/openvpnserv/openvpnserv.vcxproj<br>
&gt;&gt; +++ b/src/openvpnserv/openvpnserv.vcxproj<br>
&gt;&gt; @@ -130,6 +130,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Userenv.l=
ib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(Additiona=
lDependencies)&lt;/AdditionalDependencies&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt;&gt; @@ -141,6 +142,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;legacy_st=
dio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi3=
2.lib;Shlwapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
&gt;&gt; @@ -163,6 +165,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Userenv.l=
ib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(Additiona=
lDependencies)&lt;/AdditionalDependencies&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt;&gt; @@ -174,6 +177,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;legacy_st=
dio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi3=
2.lib;Shlwapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&=
gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Conf=
iguration)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.29.2.windows.2<br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" rel=3D"noreferr=
er noreferrer" target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lists.s=
ourceforge.net/lists/listinfo/openvpn-devel</a><br>
<br>
<br>
<br>
-- <br>
-Lev<br>
</blockquote></div>
</blockquote></div>

--000000000000e7cdb005d474a08a--

