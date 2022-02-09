MIME-Version: 1.0
References: <20220107145359.311-1-lstipakov@...277...>
 <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
In-Reply-To: <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 9 Feb 2022 15:16:23 +0500
Message-ID: <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000ee32ee05d7932068"
Subject: Re: [Openvpn-devel] [PATCH 2.5] msvc: adjust build options to
 harden binaries
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

--000000000000ee32ee05d7932068
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I did not catch that you have been waiting for me.
I'll have a look in couple of days

=D1=81=D1=80, 9 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 15:07, Lev St=
ipakov <lstipakov@...277...>:

> Hi Ilja,
>
> Is there any chance you could have a look at this patch?
>
>
> pe 7. tammik. 2022 klo 16.54 Lev Stipakov (lstipakov@...277...) kirjoitti:
> >
> > From: Lev Stipakov <lev@...515...>
> >
> >  - enable hardware-enforced stack protection on
> > compatible hardware/software (/CETCOMPAT linker option)
> >
> >  - hash object files with SHA256 (/ZH:SHA_256 compiler option)
> >
> >  - enable SDL. The required to add
> >
> >     _CRT_NONSTDC_NO_DEPRECATE
> >     _CRT_SECURE_NO_WARNINGS
> >     _WINSOCK_DEPRECATED_NO_WARNINGS
> >
> > preprocessor definitions. I don't feel like replacing strdup (which is
> > correct POSIX function) and inet_ntoa (we always pass IPv4 address to
> > it, inet_ntop will make code more complex)
> >
> > Above issues were discovered by bitskim.
> >
> > Signed-off-by: Lev Stipakov <lev@...515...>
> > ---
> >
> >  Note that one needs to cherry-pick commit
> >
> >      "e5e9a07" (tapctl: Resolve MSVC C4996 warnings)
> >
> >  before applying this patch.
> >
> >  src/openvpn/openvpn.vcxproj           | 35 +++++++++++------
> >  src/openvpnmsica/openvpnmsica.vcxproj | 43 +++++++++++++++++++++
> >  src/openvpnserv/openvpnserv.vcxproj   | 26 ++++++++++---
> >  src/tapctl/tapctl.vcxproj             | 54 ++++++++++++++++++++++++---
> >  4 files changed, 134 insertions(+), 24 deletions(-)
> >
> > diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> > index 33b8f19a..a540ec22 100644
> > --- a/src/openvpn/openvpn.vcxproj
> > +++ b/src/openvpn/openvpn.vcxproj
> > @@ -147,11 +147,12 @@
> >    </PropertyGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> >      <ClCompile>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
> >
> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Unde=
finePreprocessorDefinitions>
> > -      <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> > +      <WarningLevel>Level2</WarningLevel>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -162,11 +163,12 @@
> >    </ItemDefinitionGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> >      <ClCompile>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
> >
> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Unde=
finePreprocessorDefinitions>
> > -      <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir)include;$(SolutionD=
ir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> > +      <WarningLevel>Level2</WarningLevel>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -177,11 +179,12 @@
> >    </ItemDefinitionGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> >      <ClCompile>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
> >
> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Unde=
finePreprocessorDefinitions>
> > -      <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> > +      <WarningLevel>Level2</WarningLevel>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -192,44 +195,52 @@
> >    </ItemDefinitionGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> >      <ClCompile>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
> >
> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Unde=
finePreprocessorDefinitions>
> > -      <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> >        <ControlFlowGuard>Guard</ControlFlowGuard>
> > +      <WarningLevel>Level2</WarningLevel>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +      <SDLCheck>true</SDLCheck>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> >
> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt=
32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32=
.lib</AdditionalDependencies>
> >
> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS1=
1H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
> >        <SubSystem>Console</SubSystem>
> > +      <CETCompat>true</CETCompat>
> >      </Link>
> >    </ItemDefinitionGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> >      <ClCompile>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
> >
> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Unde=
finePreprocessorDefinitions>
> > -      <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> >        <ControlFlowGuard>Guard</ControlFlowGuard>
> > +      <SDLCheck>true</SDLCheck>
> > +      <WarningLevel>Level2</WarningLevel>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> >
> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt=
32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32=
.lib</AdditionalDependencies>
> >
> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS1=
1H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
> >        <SubSystem>Console</SubSystem>
> > +      <CETCompat>true</CETCompat>
> >      </Link>
> >    </ItemDefinitionGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> >      <ClCompile>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
> >
> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Unde=
finePreprocessorDefinitions>
> > -      <WarningLevel>Level2</WarningLevel>
> >        <TreatWarningAsError>true</TreatWarningAsError>
> >
> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclud=
eDirectories)</AdditionalIncludeDirectories>
> >        <ControlFlowGuard>Guard</ControlFlowGuard>
> > +      <WarningLevel>Level2</WarningLevel>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +      <SDLCheck>true</SDLCheck>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > diff --git a/src/openvpnmsica/openvpnmsica.vcxproj
> b/src/openvpnmsica/openvpnmsica.vcxproj
> > index 11aa78bb..5e774430 100644
> > --- a/src/openvpnmsica/openvpnmsica.vcxproj
> > +++ b/src/openvpnmsica/openvpnmsica.vcxproj
> > @@ -135,6 +135,49 @@
> >    <PropertyGroup Label=3D"Vcpkg"
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> >      <VcpkgEnabled>true</VcpkgEnabled>
> >    </PropertyGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> > +    <Link>
> > +      <CETCompat>true</CETCompat>
> > +    </Link>
> > +    <ClCompile>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> > +    <Link>
> > +      <CETCompat>true</CETCompat>
> > +    </Link>
> > +    <ClCompile>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +      <SDLCheck>true</SDLCheck>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> > +    <ClCompile>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> > +    <ClCompile>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> > +    <ClCompile>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> > +    <ClCompile>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> >    <ItemGroup>
> >      <ClCompile Include=3D"..\tapctl\error.c" />
> >      <ClCompile Include=3D"..\tapctl\tap.c" />
> > diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> > index 520242f4..c70db229 100644
> > --- a/src/openvpnserv/openvpnserv.vcxproj
> > +++ b/src/openvpnserv/openvpnserv.vcxproj
> > @@ -124,7 +124,9 @@
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> >      <ClCompile>
> >
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -135,7 +137,9 @@
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> >      <ClCompile>
> >
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -146,7 +150,9 @@
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> >      <ClCompile>
> >
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > @@ -157,29 +163,37 @@
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> >      <ClCompile>
> >
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> >
> <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;N=
etapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
> >        <SubSystem>Console</SubSystem>
> > +      <CETCompat>true</CETCompat>
> >      </Link>
> >    </ItemDefinitionGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> >      <ClCompile>
> >
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> >
> <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi=
.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenci=
es)</AdditionalDependencies>
> >        <SubSystem>Console</SubSystem>
> > +      <CETCompat>true</CETCompat>
> >      </Link>
> >    </ItemDefinitionGroup>
> >    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> >      <ClCompile>
> >
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> > -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> > +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> >      </ClCompile>
> >      <ResourceCompile />
> >      <Link>
> > diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
> > index 79da9d33..f439dc4f 100644
> > --- a/src/tapctl/tapctl.vcxproj
> > +++ b/src/tapctl/tapctl.vcxproj
> > @@ -135,12 +135,54 @@
> >    <PropertyGroup Label=3D"Vcpkg"
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> >      <VcpkgEnabled>true</VcpkgEnabled>
> >    </PropertyGroup>
> > -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'" />
> > -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'" />
> > -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'" />
> > -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'" />
> > -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'" />
> > -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'" />
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> > +    <ClCompile>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> > +    <ClCompile>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> > +    <ClCompile>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> > +    <ClCompile>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +    <Link>
> > +      <CETCompat>true</CETCompat>
> > +    </Link>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> > +    <ClCompile>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> > +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> > +    <Link>
> > +      <CETCompat>true</CETCompat>
> > +    </Link>
> > +    <ClCompile>
> > +      <SDLCheck>true</SDLCheck>
> > +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> > +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> > +    </ClCompile>
> > +  </ItemDefinitionGroup>
> >    <ItemGroup>
> >      <ClCompile Include=3D"error.c" />
> >      <ClCompile Include=3D"tap.c" />
> > --
> > 2.23.0.windows.1
> >
>
>
> --
> -Lev
>

--000000000000ee32ee05d7932068
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, I did not catch that you=C2=A0have been waiting for=
 me.=C2=A0<div>I&#39;ll have a look in couple of days</div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 9 =
=D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 15:07, Lev Stipakov &lt;<a hr=
ef=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi Ilja,<br>
<br>
Is there any chance you could have a look at this patch?<br>
<br>
<br>
pe 7. tammik. 2022 klo 16.54 Lev Stipakov (<a href=3D"mailto:lstipakov@...1665...=
77..." target=3D"_blank">lstipakov@...277...</a>) kirjoitti:<br>
&gt;<br>
&gt; From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bla=
nk">lev@...515...</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 - enable hardware-enforced stack protection on<br>
&gt; compatible hardware/software (/CETCOMPAT linker option)<br>
&gt;<br>
&gt;=C2=A0 - hash object files with SHA256 (/ZH:SHA_256 compiler option)<br>
&gt;<br>
&gt;=C2=A0 - enable SDL. The required to add<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0_CRT_NONSTDC_NO_DEPRECATE<br>
&gt;=C2=A0 =C2=A0 =C2=A0_CRT_SECURE_NO_WARNINGS<br>
&gt;=C2=A0 =C2=A0 =C2=A0_WINSOCK_DEPRECATED_NO_WARNINGS<br>
&gt;<br>
&gt; preprocessor definitions. I don&#39;t feel like replacing strdup (whic=
h is<br>
&gt; correct POSIX function) and inet_ntoa (we always pass IPv4 address to<=
br>
&gt; it, inet_ntop will make code more complex)<br>
&gt;<br>
&gt; Above issues were discovered by bitskim.<br>
&gt;<br>
&gt; Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." targe=
t=3D"_blank">lev@...515...</a>&gt;<br>
&gt; ---<br>
&gt;<br>
&gt;=C2=A0 Note that one needs to cherry-pick commit<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;e5e9a07&quot; (tapctl: Resolve MSVC C4996 wa=
rnings)<br>
&gt;<br>
&gt;=C2=A0 before applying this patch.<br>
&gt;<br>
&gt;=C2=A0 src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 35 +++++++++++------<br>
&gt;=C2=A0 src/openvpnmsica/openvpnmsica.vcxproj | 43 +++++++++++++++++++++=
<br>
&gt;=C2=A0 src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0| 26 ++++++++++-=
--<br>
&gt;=C2=A0 src/tapctl/tapctl.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 54 ++++++++++++++++++++++++---<br>
&gt;=C2=A0 4 files changed, 134 insertions(+), 24 deletions(-)<br>
&gt;<br>
&gt; diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj=
<br>
&gt; index 33b8f19a..a540ec22 100644<br>
&gt; --- a/src/openvpn/openvpn.vcxproj<br>
&gt; +++ b/src/openvpn/openvpn.vcxproj<br>
&gt; @@ -147,11 +147,12 @@<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_D=
EPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%=
(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;%(Un=
definePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -162,11 +163,12 @@<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_D=
EPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%=
(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;%(Un=
definePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir)include;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;=
/AdditionalIncludeDirectories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -177,11 +179,12 @@<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_D=
EPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%=
(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;%(Un=
definePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -192,44 +195,52 @@<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_D=
EPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%=
(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;%(Un=
definePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFl=
owGuard&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Ncrypt.lib;gd=
i32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.=
lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalLibraryDirectories&gt;$(OPENS=
SL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirecto=
ries)&lt;/AdditionalLibraryDirectories&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_D=
EPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%=
(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;%(Un=
definePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFl=
owGuard&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Ncrypt.lib;gd=
i32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.=
lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib&lt;/AdditionalDependencies&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalLibraryDirectories&gt;$(OPENS=
SL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirecto=
ries)&lt;/AdditionalLibraryDirectories&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_D=
EPRECATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%=
(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;%(Un=
definePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;TreatWarningAsError&gt;true&lt;/TreatWa=
rningAsError&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\comp=
at;$(SolutionDir);%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDire=
ctories&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;ControlFlowGuard&gt;Guard&lt;/ControlFl=
owGuard&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/=
openvpnmsica.vcxproj<br>
&gt; index 11aa78bb..5e774430 100644<br>
&gt; --- a/src/openvpnmsica/openvpnmsica.vcxproj<br>
&gt; +++ b/src/openvpnmsica/openvpnmsica.vcxproj<br>
&gt; @@ -135,6 +135,49 @@<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&=
quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot=
;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemGroup&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;..\tapctl\error.c&qu=
ot; /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;..\tapctl\tap.c&quot=
; /&gt;<br>
&gt; diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/ope=
nvpnserv.vcxproj<br>
&gt; index 520242f4..c70db229 100644<br>
&gt; --- a/src/openvpnserv/openvpnserv.vcxproj<br>
&gt; +++ b/src/openvpnserv/openvpnserv.vcxproj<br>
&gt; @@ -124,7 +124,9 @@<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\open=
vpn;..\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WA=
RNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Pre=
processorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -135,7 +137,9 @@<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\open=
vpn;..\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WA=
RNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Pre=
processorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -146,7 +150,9 @@<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\open=
vpn;..\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WA=
RNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Pre=
processorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; @@ -157,29 +163,37 @@<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\open=
vpn;..\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WA=
RNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Pre=
processorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;Userenv.lib;I=
phlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDep=
endencies)&lt;/AdditionalDependencies&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\open=
vpn;..\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WA=
RNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Pre=
processorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalDependencies&gt;legacy_stdio_=
definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.li=
b;Shlwapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;SubSystem&gt;Console&lt;/SubSystem&gt;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configur=
ation)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\open=
vpn;..\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Prepro=
cessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WA=
RNINGS;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Pre=
processorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj<br>
&gt; index 79da9d33..f439dc4f 100644<br>
&gt; --- a/src/tapctl/tapctl.vcxproj<br>
&gt; +++ b/src/tapctl/tapctl.vcxproj<br>
&gt; @@ -135,12 +135,54 @@<br>
&gt;=C2=A0 =C2=A0 &lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&=
quot;&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot=
;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;/PropertyGroup&gt;<br>
&gt; -=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; /&gt;<br>
&gt; -=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; /&gt;<br>
&gt; -=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; /&gt;<br>
&gt; -=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; /&gt;<br>
&gt; -=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; /&gt;<br>
&gt; -=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot; /&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt; +=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;Link&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/Link&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(Additiona=
lOptions)&lt;/AdditionalOptions&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
&gt; +=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
&gt; +=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;ItemGroup&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;error.c&quot; /&gt;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;tap.c&quot; /&gt;<br>
&gt; --<br>
&gt; 2.23.0.windows.1<br>
&gt;<br>
<br>
<br>
--<br>
-Lev<br>
</blockquote></div>

--000000000000ee32ee05d7932068--

