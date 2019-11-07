MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-2-git-send-email-lstipakov@...277...>
 <CAFHpkQEhR0w_BPbhAiudQO8AfN0yAdSx5cdtAXa1BB+vGqwsCg@...278...>
In-Reply-To: <CAFHpkQEhR0w_BPbhAiudQO8AfN0yAdSx5cdtAXa1BB+vGqwsCg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 7 Nov 2019 19:28:36 +0100
Message-ID: <CAGyAFMU0G3ucCYXv6SmSx8A0=SbzuQ-6bwws+eT2Nq-rsawFKw@...278...>
Content-Type: multipart/alternative; boundary="00000000000087f1fd0596c5d6af"
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] Visual Studio: upgrade project
 files to VS2019
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000087f1fd0596c5d6af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With VS2019 you cannot build for XP,  you would need to install build tools
from VS2017 for that.

On the other hand, we do not build releases with VS, so it should not be an
issue.


to 7. marrask. 2019 klo 18.52 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> kirjoitti:

>
>
> =D1=87=D1=82, 7 =D0=BD=D0=BE=D1=8F=D0=B1. 2019 =D0=B3. =D0=B2 22:49, Lev =
Stipakov <lstipakov@...277...>:
>
>> From: Lev Stipakov <lev@...515...>
>>
>> Signed-off-by: Lev Stipakov <lev@...515...>
>> ---
>>  src/compat/compat.vcxproj             | 12 ++++++------
>>  src/openvpn/openvpn.vcxproj           | 12 ++++++------
>>  src/openvpnmsica/openvpnmsica.vcxproj | 14 +++++++-------
>>  src/openvpnserv/openvpnserv.vcxproj   | 12 ++++++------
>>  src/tapctl/tapctl.vcxproj             | 14 +++++++-------
>>  5 files changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
>> index 111dacd..e388008 100644
>> --- a/src/compat/compat.vcxproj
>> +++ b/src/compat/compat.vcxproj
>> @@ -22,30 +22,30 @@
>>      <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
>>      <RootNamespace>compat</RootNamespace>
>>      <Keyword>Win32Proj</Keyword>
>> -
>> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
>> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>StaticLibrary</ConfigurationType>
>>      <CharacterSet>MultiByte</CharacterSet>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>StaticLibrary</ConfigurationType>
>>      <CharacterSet>MultiByte</CharacterSet>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>
>
>
> does it limit target platform ?
> can we build for Vista ? XP ? 7 ? does this setting affect that ?
>
>
>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>StaticLibrary</ConfigurationType>
>>      <CharacterSet>MultiByte</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debu=
g|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>StaticLibrary</ConfigurationType>
>>      <CharacterSet>MultiByte</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
>>    <ImportGroup Label=3D"ExtensionSettings">
>> @@ -115,4 +115,4 @@
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
>>    <ImportGroup Label=3D"ExtensionTargets">
>>    </ImportGroup>
>> -</Project>
>> +</Project>
>> \ No newline at end of file
>> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
>> index 4ffff2b..e77f026 100644
>> --- a/src/openvpn/openvpn.vcxproj
>> +++ b/src/openvpn/openvpn.vcxproj
>> @@ -22,30 +22,30 @@
>>      <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
>>      <RootNamespace>openvpn</RootNamespace>
>>      <Keyword>Win32Proj</Keyword>
>> -
>> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
>> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <CharacterSet>Unicode</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debu=
g|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <CharacterSet>Unicode</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
>>    <ImportGroup Label=3D"ExtensionSettings">
>> @@ -301,4 +301,4 @@
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
>>    <ImportGroup Label=3D"ExtensionTargets">
>>    </ImportGroup>
>> -</Project>
>> +</Project>
>> \ No newline at end of file
>> diff --git a/src/openvpnmsica/openvpnmsica.vcxproj
>> b/src/openvpnmsica/openvpnmsica.vcxproj
>> index 5f1d699..afa4fae 100644
>> --- a/src/openvpnmsica/openvpnmsica.vcxproj
>> +++ b/src/openvpnmsica/openvpnmsica.vcxproj
>> @@ -31,32 +31,32 @@
>>      <ProjectGuid>{D41AA9D6-B818-476E-992E-0E16EB86BEE2}</ProjectGuid>
>>      <Keyword>Win32Proj</Keyword>
>>      <RootNamespace>openvpnmsica</RootNamespace>
>> -
>> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
>> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>>      <UseDebugLibraries>true</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <CharacterSet>Unicode</CharacterSet>
>>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>>      <UseDebugLibraries>true</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debu=
g|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>>      <UseDebugLibraries>true</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>>      <UseDebugLibraries>false</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
>> @@ -64,14 +64,14 @@
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>>      <UseDebugLibraries>false</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>DynamicLibrary</ConfigurationType>
>>      <UseDebugLibraries>false</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>> diff --git a/src/openvpnserv/openvpnserv.vcxproj
>> b/src/openvpnserv/openvpnserv.vcxproj
>> index 7407757..7061b7b 100644
>> --- a/src/openvpnserv/openvpnserv.vcxproj
>> +++ b/src/openvpnserv/openvpnserv.vcxproj
>> @@ -22,30 +22,30 @@
>>      <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
>>      <RootNamespace>openvpnserv</RootNamespace>
>>      <Keyword>Win32Proj</Keyword>
>> -
>> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
>> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <CharacterSet>Unicode</CharacterSet>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <CharacterSet>Unicode</CharacterSet>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <CharacterSet>Unicode</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debu=
g|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <CharacterSet>Unicode</CharacterSet>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
>>    <ImportGroup Label=3D"ExtensionSettings">
>> @@ -139,4 +139,4 @@
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
>>    <ImportGroup Label=3D"ExtensionTargets">
>>    </ImportGroup>
>> -</Project>
>> +</Project>
>> \ No newline at end of file
>> diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
>> index 5c1983b..1d593fc 100644
>> --- a/src/tapctl/tapctl.vcxproj
>> +++ b/src/tapctl/tapctl.vcxproj
>> @@ -31,32 +31,32 @@
>>      <ProjectGuid>{A06436E7-D576-490D-8BA0-0751D920334A}</ProjectGuid>
>>      <Keyword>Win32Proj</Keyword>
>>      <RootNamespace>tapctl</RootNamespace>
>> -
>> <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
>> +    <WindowsTargetPlatformVersion>10.0</WindowsTargetPlatformVersion>
>>    </PropertyGroup>
>>    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <UseDebugLibraries>true</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <CharacterSet>Unicode</CharacterSet>
>>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <UseDebugLibraries>true</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>>    <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debu=
g|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <UseDebugLibraries>true</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <UseDebugLibraries>false</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>>      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
>> @@ -64,14 +64,14 @@
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <UseDebugLibraries>false</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>>    <PropertyGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
>> Label=3D"Configuration">
>>      <ConfigurationType>Application</ConfigurationType>
>>      <UseDebugLibraries>false</UseDebugLibraries>
>> -    <PlatformToolset>v141</PlatformToolset>
>> +    <PlatformToolset>v142</PlatformToolset>
>>      <WholeProgramOptimization>true</WholeProgramOptimization>
>>      <CharacterSet>Unicode</CharacterSet>
>>    </PropertyGroup>
>> --
>> 2.7.4
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>

--00000000000087f1fd0596c5d6af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">With VS2019 you cannot build for XP,=C2=
=A0 you would need to install build tools from VS2017 for that.=C2=A0</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">On the other hand, we do not =
build releases with VS, so it should not be an issue.=C2=A0<br></div><div d=
ir=3D"auto"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">to 7. marrask. 2019 klo 18.52 =D0=98=D0=BB=D1=8C=D1=
=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipit=
sine@...277...">chipitsine@...277...</a>&gt; kirjoitti:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 7 =
=D0=BD=D0=BE=D1=8F=D0=B1. 2019 =D0=B3. =D0=B2 22:49, Lev Stipakov &lt;<a hr=
ef=3D"mailto:lstipakov@...277..." target=3D"_blank" rel=3D"noreferrer">lsti=
pakov@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=
=3D"_blank" rel=3D"noreferrer">lev@...515...</a>&gt;<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank" rel=3D"noreferrer">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/compat/compat.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 12 ++++++------<br>
=C2=A0src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 12 ++++++------<br>
=C2=A0src/openvpnmsica/openvpnmsica.vcxproj | 14 +++++++-------<br>
=C2=A0src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0| 12 ++++++------<br>
=C2=A0src/tapctl/tapctl.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 14 +++++++-------<br>
=C2=A05 files changed, 32 insertions(+), 32 deletions(-)<br>
<br>
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj<br>
index 111dacd..e388008 100644<br>
--- a/src/compat/compat.vcxproj<br>
+++ b/src/compat/compat.vcxproj<br>
@@ -22,30 +22,30 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{4B2E2719-E661-45D7-9203-F6F456B22F1=
9}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;compat&lt;/RootNamespace&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br></blo=
ckquote><div><br></div><div><br></div><div>does it limit target platform ?<=
/div><div>can we build for Vista ? XP ? 7 ? does this setting affect that ?=
<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;StaticLibrary&lt;/Configuratio=
nType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.prop=
s&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;<br>
@@ -115,4 +115,4 @@<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-&lt;/Project&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj<br>
index 4ffff2b..e77f026 100644<br>
--- a/src/openvpn/openvpn.vcxproj<br>
+++ b/src/openvpn/openvpn.vcxproj<br>
@@ -22,30 +22,30 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{29DF226E-4D4E-440F-ADAF-5829CFD4CA9=
4}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;openvpn&lt;/RootNamespace&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.prop=
s&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;<br>
@@ -301,4 +301,4 @@<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-&lt;/Project&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openv=
pnmsica.vcxproj<br>
index 5f1d699..afa4fae 100644<br>
--- a/src/openvpnmsica/openvpnmsica.vcxproj<br>
+++ b/src/openvpnmsica/openvpnmsica.vcxproj<br>
@@ -31,32 +31,32 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{D41AA9D6-B818-476E-992E-0E16EB86BEE=
2}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;openvpnmsica&lt;/RootNamespace&gt;=
<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
@@ -64,14 +64,14 @@<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;DynamicLibrary&lt;/Configurati=
onType&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj<br>
index 7407757..7061b7b 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj<br>
@@ -22,30 +22,30 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{9C91EE0B-817D-420A-A1E6-15A5A9D98BA=
D}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;openvpnserv&lt;/RootNamespace&gt;<=
br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.prop=
s&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;<br>
@@ -139,4 +139,4 @@<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.targ=
ets&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Label=3D&quot;ExtensionTargets&quot;&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
-&lt;/Project&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj<br>
index 5c1983b..1d593fc 100644<br>
--- a/src/tapctl/tapctl.vcxproj<br>
+++ b/src/tapctl/tapctl.vcxproj<br>
@@ -31,32 +31,32 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ProjectGuid&gt;{A06436E7-D576-490D-8BA0-0751D920334=
A}&lt;/ProjectGuid&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Keyword&gt;Win32Proj&lt;/Keyword&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;RootNamespace&gt;tapctl&lt;/RootNamespace&gt;<br>
-=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0.17134.0&lt;/Windows=
TargetPlatformVersion&gt;<br>
+=C2=A0 =C2=A0 &lt;WindowsTargetPlatformVersion&gt;10.0&lt;/WindowsTargetPl=
atformVersion&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp.Defa=
ult.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuration&quo=
t;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;true&lt;/UseDebugLibraries&gt;=
<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WindowsSDKDesktopARM64Support&gt;true&lt;/WindowsSD=
KDesktopARM64Support&gt;<br>
@@ -64,14 +64,14 @@<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configuration=
&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)|$(Pl=
atform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configuration&q=
uot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ConfigurationType&gt;Application&lt;/ConfigurationT=
ype&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;UseDebugLibraries&gt;false&lt;/UseDebugLibraries&gt=
;<br>
-=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v141&lt;/PlatformToolset&gt;<br>
+=C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;WholeProgramOptimization&gt;true&lt;/WholeProgramOp=
timization&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
-- <br>
2.7.4<br>
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
</blockquote></div></div>
</blockquote></div>

--00000000000087f1fd0596c5d6af--

