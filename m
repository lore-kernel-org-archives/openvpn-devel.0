MIME-Version: 1.0
References: <20210915122534.355-1-chipitsine@...277...>
 <CAGyAFMWjnD8xY0J6wS1p3M14tau1tdCT0ot6cB=6ZU-NPKLiZQ@...278...>
In-Reply-To: <CAGyAFMWjnD8xY0J6wS1p3M14tau1tdCT0ot6cB=6ZU-NPKLiZQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 21 Sep 2021 17:04:07 +0500
Message-ID: <CAFHpkQEzhxeJgbzXuDbZMvuR9fXCpjijaTs8esRODmM1vtxejA@...278...>
Content-Type: multipart/alternative; boundary="0000000000007d041105cc8032dc"
Subject: Re: [Openvpn-devel] [PATCH] BUILD: enable CFG and Spectre
 mitigation for MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007d041105cc8032dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks,

I'll recheck and will send v2 soon

=D0=B2=D1=82, 21 =D1=81=D0=B5=D0=BD=D1=82. 2021 =D0=B3. =D0=B2 16:49, Lev S=
tipakov <lstipakov@...277...>:

> Hi,
>
> Sorry for the delay.
>
> I got "command line error D8016: '/ZI' and '/guard:cf' command-line
> options are incompatible" errors for Debug configuration,
> Release works fine. Looks like "Debug Information Format: Program
> Database for Edit and Continue" is not compatible with Control Flow
> Guard:
>
>
> https://docs.microsoft.com/en-us/cpp/build/reference/guard-enable-control=
-flow-guard?view=3Dmsvc-160
>
> Let's apply those changes to Release configurations only.
>
> ke 15. syysk. 2021 klo 15.27 Ilya Shipitsin (chipitsine@...277...)
> kirjoitti:
> >
> > found by BinSkim
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> >  src/compat/Debug.props                |  1 +
> >  src/compat/Release.props              |  1 +
> >  src/compat/compat.vcxproj             |  6 ++++++
> >  src/openvpn/openvpn.vcxproj           | 12 ++++++++++++
> >  src/openvpnmsica/openvpnmsica.props   |  1 +
> >  src/openvpnmsica/openvpnmsica.vcxproj |  6 ++++++
> >  src/openvpnserv/openvpnserv.vcxproj   |  6 ++++++
> >  src/tapctl/tapctl.vcxproj             |  6 ++++++
> >  8 files changed, 39 insertions(+)
> >
> > diff --git a/src/compat/Debug.props b/src/compat/Debug.props
> > index 31bb9d91..810609bf 100644
> > --- a/src/compat/Debug.props
> > +++ b/src/compat/Debug.props
> > @@ -15,6 +15,7 @@
> >
> <PreprocessorDefinitions>_DEBUG;%(PreprocessorDefinitions)</PreprocessorD=
efinitions>
> >        <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> >        <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >    </ItemDefinitionGroup>
> >    <ItemGroup />
> > diff --git a/src/compat/Release.props b/src/compat/Release.props
> > index 63828b79..50eaa8de 100644
> > --- a/src/compat/Release.props
> > +++ b/src/compat/Release.props
> > @@ -15,6 +15,7 @@
> >        <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> >        <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> >
> <PreprocessorDefinitions>NDEBUG;%(PreprocessorDefinitions)</PreprocessorD=
efinitions>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <Link>
> >        <EnableCOMDATFolding>true</EnableCOMDATFolding>
> > diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
> > index 49824783..fe03a51a 100644
> > --- a/src/compat/compat.vcxproj
> > +++ b/src/compat/compat.vcxproj
> > @@ -38,33 +38,39 @@
> >      <CharacterSet>MultiByte</CharacterSet>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>StaticLibrary</ConfigurationType>
> >      <CharacterSet>MultiByte</CharacterSet>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>StaticLibrary</ConfigurationType>
> >      <CharacterSet>MultiByte</CharacterSet>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
> >      <ConfigurationType>StaticLibrary</ConfigurationType>
> >      <CharacterSet>MultiByte</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>StaticLibrary</ConfigurationType>
> >      <CharacterSet>MultiByte</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>StaticLibrary</ConfigurationType>
> >      <CharacterSet>MultiByte</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> >    <ImportGroup Label=3D"ExtensionSettings">
> > diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> > index 5b3e0c6c..8d27f9c6 100644
> > --- a/src/openvpn/openvpn.vcxproj
> > +++ b/src/openvpn/openvpn.vcxproj
> > @@ -38,33 +38,39 @@
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>NotSet</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>NotSet</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>NotSet</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>NotSet</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>NotSet</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>NotSet</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> >    <ImportGroup Label=3D"ExtensionSettings">
> > @@ -146,6 +152,7 @@
> >        <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -161,6 +168,7 @@
> >        <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir)include;$(SolutionD=
ir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -176,6 +184,7 @@
> >        <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -191,6 +200,7 @@
> >        <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -206,6 +216,7 @@
> >        <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -221,6 +232,7 @@
> >        <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > diff --git a/src/openvpnmsica/openvpnmsica.props
> b/src/openvpnmsica/openvpnmsica.props
> > index 074635d0..9e934a73 100644
> > --- a/src/openvpnmsica/openvpnmsica.props
> > +++ b/src/openvpnmsica/openvpnmsica.props
> > @@ -9,6 +9,7 @@
> >      <ClCompile>
> >
> <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(Add=
itionalIncludeDirectories)</AdditionalIncludeDirectories>
> >
> <PreprocessorDefinitions>_WIN32_WINNT=3D_WIN32_WINNT_VISTA;%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> > +      <ControlFlowGuard>Guard</ControlFlowGuard>
> >      </ClCompile>
> >      <Link>
> >        <SubSystem>Windows</SubSystem>
> > diff --git a/src/openvpnmsica/openvpnmsica.vcxproj
> b/src/openvpnmsica/openvpnmsica.vcxproj
> > index c39b1240..11aa78bb 100644
> > --- a/src/openvpnmsica/openvpnmsica.vcxproj
> > +++ b/src/openvpnmsica/openvpnmsica.vcxproj
> > @@ -40,18 +40,21 @@
> >      <PlatformToolset>v142</PlatformToolset>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
> >      <ConfigurationType>DynamicLibrary</ConfigurationType>
> >      <UseDebugLibraries>true</UseDebugLibraries>
> >      <PlatformToolset>v142</PlatformToolset>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>DynamicLibrary</ConfigurationType>
> >      <UseDebugLibraries>true</UseDebugLibraries>
> >      <PlatformToolset>v142</PlatformToolset>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>DynamicLibrary</ConfigurationType>
> > @@ -60,6 +63,7 @@
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"Configuration">
> >      <ConfigurationType>DynamicLibrary</ConfigurationType>
> > @@ -67,6 +71,7 @@
> >      <PlatformToolset>v142</PlatformToolset>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>DynamicLibrary</ConfigurationType>
> > @@ -74,6 +79,7 @@
> >      <PlatformToolset>v142</PlatformToolset>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> >    <ImportGroup Label=3D"ExtensionSettings">
> > diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> > index 8009ab3d..5fd7d60b 100644
> > --- a/src/openvpnserv/openvpnserv.vcxproj
> > +++ b/src/openvpnserv/openvpnserv.vcxproj
> > @@ -38,33 +38,39 @@
> >      <CharacterSet>Unicode</CharacterSet>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <PlatformToolset>v142</PlatformToolset>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> >    <ImportGroup Label=3D"ExtensionSettings">
> > diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
> > index ad96f02c..79da9d33 100644
> > --- a/src/tapctl/tapctl.vcxproj
> > +++ b/src/tapctl/tapctl.vcxproj
> > @@ -40,18 +40,21 @@
> >      <PlatformToolset>v142</PlatformToolset>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <UseDebugLibraries>true</UseDebugLibraries>
> >      <PlatformToolset>v142</PlatformToolset>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> >      <UseDebugLibraries>true</UseDebugLibraries>
> >      <PlatformToolset>v142</PlatformToolset>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> > @@ -60,6 +63,7 @@
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>Unicode</CharacterSet>
> >      <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> > @@ -67,6 +71,7 @@
> >      <PlatformToolset>v142</PlatformToolset>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <PropertyGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'"
> Label=3D"Configuration">
> >      <ConfigurationType>Application</ConfigurationType>
> > @@ -74,6 +79,7 @@
> >      <PlatformToolset>v142</PlatformToolset>
> >      <WholeProgramOptimization>true</WholeProgramOptimization>
> >      <CharacterSet>Unicode</CharacterSet>
> > +    <SpectreMitigation>Spectre</SpectreMitigation>
> >    </PropertyGroup>
> >    <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> >    <ImportGroup Label=3D"ExtensionSettings">
> > --
> > 2.29.2.windows.2
> >
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>
> --
> -Lev
>

--0000000000007d041105cc8032dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>thanks,</div><div><br></div><div>I&#39;ll recheck and=
 will send v2 soon<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 21 =D1=81=D0=B5=D0=BD=D1=82. 20=
21 =D0=B3. =D0=B2 16:49, Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1664...=
7...">lstipakov@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi,<br>
<br>
Sorry for the delay.<br>
<br>
I got &quot;command line error D8016: &#39;/ZI&#39; and &#39;/guard:cf&#39;=
 command-line<br>
options are incompatible&quot; errors for Debug configuration,<br>
Release works fine. Looks like &quot;Debug Information Format: Program<br>
Database for Edit and Continue&quot; is not compatible with Control Flow<br>
Guard:<br>
<br>
<a href=3D"https://docs.microsoft.com/en-us/cpp/build/reference/guard-enabl=
e-control-flow-guard?view=3Dmsvc-160" rel=3D"noreferrer" target=3D"_blank">=
https://docs.microsoft.com/en-us/cpp/build/reference/guard-enable-control-f=
low-guard?view=3Dmsvc-160</a><br>
<br>
Let&#39;s apply those changes to Release configurations only.<br>
<br>
ke 15. syysk. 2021 klo 15.27 Ilya Shipitsin (<a href=3D"mailto:chipitsine@...220...=
..277..." target=3D"_blank">chipitsine@...277...</a>) kirjoitti:<br>
&gt;<br>
&gt; found by BinSkim<br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
.." target=3D"_blank">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/compat/Debug.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 src/compat/Release.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 src/compat/compat.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 ++++++<br>
&gt;=C2=A0 src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 12 ++++++++++++<br>
&gt;=C2=A0 src/openvpnmsica/openvpnmsica.props=C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 src/openvpnmsica/openvpnmsica.vcxproj |=C2=A0 6 ++++++<br>
&gt;=C2=A0 src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0|=C2=A0 6 ++++++=
<br>
&gt;=C2=A0 src/tapctl/tapctl.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 ++++++<br>
&gt;=C2=A0 8 files changed, 39 insertions(+)<br>
&gt;<br>
&gt; diff --git a/src/compat/Debug.props b/src/compat/Debug.props<br>
&gt; index 31bb9d91..810609bf 100644<br>
&gt; --- a/src/compat/Debug.props<br>
&gt; +++ b/src/compat/Debug.props<br>
&gt; @@ -15,6 +15,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_DEBUG;%(Pre=
processorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL=
&lt;/RuntimeLibrary&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;EditAndContin=
ue&lt;/DebugInformationFormat&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemGroup /&gt;<br>
&gt; diff --git a/src/compat/Release.props b/src/compat/Release.props<br>
&gt; index 63828b79..50eaa8de 100644<br>
&gt; --- a/src/compat/Release.props<br>
&gt; +++ b/src/compat/Release.props<br>
&gt; @@ -15,6 +15,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/=
RuntimeLibrary&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDataba=
se&lt;/DebugInformationFormat&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;NDEBUG;%(Pre=
processorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;EnableCOMDATFolding&gt;true&lt;/EnableC=
OMDATFolding&gt;<br>
&gt; diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj<br>
&gt; index 49824783..fe03a51a 100644<br>
&gt; --- a/src/compat/compat.vcxproj<br>
&gt; +++ b/src/compat/compat.vcxproj<br>
&gt; @@ -38,33 +38,39 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;StaticLibrary&lt;/Configu=
rationType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configur=
ation&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;StaticLibrary&lt;/Configu=
rationType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;StaticLibrary&lt;/Configu=
rationType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuratio=
n&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;StaticLibrary&lt;/Configu=
rationType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;StaticLibrary&lt;/Configu=
rationType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;MultiByte&lt;/CharacterSet&gt;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp=
.props&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;=
<br>
&gt; diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj=
<br>
&gt; index 5b3e0c6c..8d27f9c6 100644<br>
&gt; --- a/src/openvpn/openvpn.vcxproj<br>
&gt; +++ b/src/openvpn/openvpn.vcxproj<br>
&gt; @@ -38,33 +38,39 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configur=
ation&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuratio=
n&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;NotSet&lt;/CharacterSet&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp=
.props&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;=
<br>
&gt; @@ -146,6 +152,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel=
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -161,6 +168,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel=
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir)include;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;=
/AdditionalIncludeDirectories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -176,6 +184,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel=
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -191,6 +200,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel=
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -206,6 +216,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel=
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -221,6 +232,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel=
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/op=
envpnmsica.props<br>
&gt; index 074635d0..9e934a73 100644<br>
&gt; --- a/src/openvpnmsica/openvpnmsica.props<br>
&gt; +++ b/src/openvpnmsica/openvpnmsica.props<br>
&gt; @@ -9,6 +9,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)&lt;/Addition=
alIncludeDirectories&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_WIN32_WINNT=
=3D_WIN32_WINNT_VISTA;%(PreprocessorDefinitions)&lt;/PreprocessorDefinition=
s&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Windows&lt;/SubSystem&gt;<=
br>
&gt; diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/=
openvpnmsica.vcxproj<br>
&gt; index c39b1240..11aa78bb 100644<br>
&gt; --- a/src/openvpnmsica/openvpnmsica.vcxproj<br>
&gt; +++ b/src/openvpnmsica/openvpnmsica.vcxproj<br>
&gt; @@ -40,18 +40,21 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WindowsSDKDesktopARM64Support&gt;true&lt;/Wind=
owsSDKDesktopARM64Support&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;DynamicLibrary&lt;/Config=
urationType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;UseDebugLibraries&gt;true&lt;/UseDebugLibrarie=
s&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuratio=
n&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;DynamicLibrary&lt;/Config=
urationType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;UseDebugLibraries&gt;true&lt;/UseDebugLibrarie=
s&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configur=
ation&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;DynamicLibrary&lt;/Config=
urationType&gt;<br>
&gt; @@ -60,6 +63,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WindowsSDKDesktopARM64Support&gt;true&lt;/Wind=
owsSDKDesktopARM64Support&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configur=
ation&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;DynamicLibrary&lt;/Config=
urationType&gt;<br>
&gt; @@ -67,6 +71,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;DynamicLibrary&lt;/Config=
urationType&gt;<br>
&gt; @@ -74,6 +79,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp=
.props&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;=
<br>
&gt; diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/ope=
nvpnserv.vcxproj<br>
&gt; index 8009ab3d..5fd7d60b 100644<br>
&gt; --- a/src/openvpnserv/openvpnserv.vcxproj<br>
&gt; +++ b/src/openvpnserv/openvpnserv.vcxproj<br>
&gt; @@ -38,33 +38,39 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configur=
ation&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuratio=
n&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp=
.props&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;=
<br>
&gt; diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj<br>
&gt; index ad96f02c..79da9d33 100644<br>
&gt; --- a/src/tapctl/tapctl.vcxproj<br>
&gt; +++ b/src/tapctl/tapctl.vcxproj<br>
&gt; @@ -40,18 +40,21 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WindowsSDKDesktopARM64Support&gt;true&lt;/Wind=
owsSDKDesktopARM64Support&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;UseDebugLibraries&gt;true&lt;/UseDebugLibrarie=
s&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;Configuratio=
n&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;UseDebugLibraries&gt;true&lt;/UseDebugLibrarie=
s&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; Label=3D&quot;Configur=
ation&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt; @@ -60,6 +63,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WindowsSDKDesktopARM64Support&gt;true&lt;/Wind=
owsSDKDesktopARM64Support&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;Configur=
ation&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt; @@ -67,6 +71,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Condition=3D&quot;&#39;$(Configuration)=
|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;Configurat=
ion&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ConfigurationType&gt;Application&lt;/Configura=
tionType&gt;<br>
&gt; @@ -74,6 +79,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;PlatformToolset&gt;v142&lt;/PlatformToolset&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;WholeProgramOptimization&gt;true&lt;/WholeProg=
ramOptimization&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;CharacterSet&gt;Unicode&lt;/CharacterSet&gt;<b=
r>
&gt; +=C2=A0 =C2=A0 &lt;SpectreMitigation&gt;Spectre&lt;/SpectreMitigation&=
gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;Import Project=3D&quot;$(VCTargetsPath)\Microsoft.Cpp=
.props&quot; /&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ImportGroup Label=3D&quot;ExtensionSettings&quot;&gt;=
<br>
&gt; --<br>
&gt; 2.29.2.windows.2<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</a><br>
<br>
<br>
<br>
-- <br>
-Lev<br>
</blockquote></div>

--0000000000007d041105cc8032dc--

