MIME-Version: 1.0
References: <20220107145359.311-1-lstipakov@...277...>
 <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
 <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
In-Reply-To: <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 17 Feb 2022 09:10:21 +0500
Message-ID: <CAFHpkQE-LBkt-Lyz97vLdgQFt7VPLmedw8ogNojVy2p3GsdaiQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000088a70105d82ef2d9"
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

--00000000000088a70105d82ef2d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

original patch does not apply

C:\i\openvpn-chipitsine-2.5>"C:\Program Files\Git\usr\bin\patch.exe" -p1 <
c:\users\ilia\Downloads\Openvpn-devel-2.5-msvc-adjust-build-options-to-hard=
en-binaries.diff
patching file src/openvpn/openvpn.vcxproj
Hunk #1 FAILED at 147.
Hunk #2 FAILED at 162.
Hunk #3 FAILED at 177.
Hunk #4 FAILED at 192.
4 out of 4 hunks FAILED -- saving rejects to file
src/openvpn/openvpn.vcxproj.rej
patching file src/openvpnmsica/openvpnmsica.vcxproj
patching file src/openvpnserv/openvpnserv.vcxproj
patching file src/tapctl/tapctl.vcxproj


I tried to apply manually: test =C2=B7 chipitsine/openvpn@...2652... (githu=
b.com)
<https://github.com/chipitsine/openvpn/commit/eeff76551238b0194e72953b916c4=
481aab5f303>

minor build issues still there: test =C2=B7 chipitsine/openvpn@...2652...
(github.com)
<https://github.com/chipitsine/openvpn/runs/5226889392?check_suite_focus=3D=
true>


also, I have a question on <SDLCheck>true</SDLCheck>, in your patch it is
not applied to all configurations, but to few of them. is it on purpose ?



=D1=81=D1=80, 9 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 15:16, =D0=98=
=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...220...=
..277...>:

> Sorry, I did not catch that you have been waiting for me.
> I'll have a look in couple of days
>
> =D1=81=D1=80, 9 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 15:07, Lev =
Stipakov <lstipakov@...277...>:
>
>> Hi Ilja,
>>
>> Is there any chance you could have a look at this patch?
>>
>>
>> pe 7. tammik. 2022 klo 16.54 Lev Stipakov (lstipakov@...277...)
>> kirjoitti:
>> >
>> > From: Lev Stipakov <lev@...515...>
>> >
>> >  - enable hardware-enforced stack protection on
>> > compatible hardware/software (/CETCOMPAT linker option)
>> >
>> >  - hash object files with SHA256 (/ZH:SHA_256 compiler option)
>> >
>> >  - enable SDL. The required to add
>> >
>> >     _CRT_NONSTDC_NO_DEPRECATE
>> >     _CRT_SECURE_NO_WARNINGS
>> >     _WINSOCK_DEPRECATED_NO_WARNINGS
>> >
>> > preprocessor definitions. I don't feel like replacing strdup (which is
>> > correct POSIX function) and inet_ntoa (we always pass IPv4 address to
>> > it, inet_ntop will make code more complex)
>> >
>> > Above issues were discovered by bitskim.
>> >
>> > Signed-off-by: Lev Stipakov <lev@...515...>
>> > ---
>> >
>> >  Note that one needs to cherry-pick commit
>> >
>> >      "e5e9a07" (tapctl: Resolve MSVC C4996 warnings)
>> >
>> >  before applying this patch.
>> >
>> >  src/openvpn/openvpn.vcxproj           | 35 +++++++++++------
>> >  src/openvpnmsica/openvpnmsica.vcxproj | 43 +++++++++++++++++++++
>> >  src/openvpnserv/openvpnserv.vcxproj   | 26 ++++++++++---
>> >  src/tapctl/tapctl.vcxproj             | 54 ++++++++++++++++++++++++---
>> >  4 files changed, 134 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
>> > index 33b8f19a..a540ec22 100644
>> > --- a/src/openvpn/openvpn.vcxproj
>> > +++ b/src/openvpn/openvpn.vcxproj
>> > @@ -147,11 +147,12 @@
>> >    </PropertyGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>> >      <ClCompile>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNIN=
GS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Pre=
processorDefinitions>
>> >
>> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
>> > -      <WarningLevel>Level2</WarningLevel>
>> >        <TreatWarningAsError>true</TreatWarningAsError>
>> >
>> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
>> > +      <WarningLevel>Level2</WarningLevel>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > @@ -162,11 +163,12 @@
>> >    </ItemDefinitionGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> >      <ClCompile>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNIN=
GS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Pre=
processorDefinitions>
>> >
>> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
>> > -      <WarningLevel>Level2</WarningLevel>
>> >        <TreatWarningAsError>true</TreatWarningAsError>
>> >
>> <AdditionalIncludeDirectories>..\compat;$(SolutionDir)include;$(Solution=
Dir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
>> > +      <WarningLevel>Level2</WarningLevel>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > @@ -177,11 +179,12 @@
>> >    </ItemDefinitionGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>> >      <ClCompile>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNIN=
GS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Pre=
processorDefinitions>
>> >
>> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
>> > -      <WarningLevel>Level2</WarningLevel>
>> >        <TreatWarningAsError>true</TreatWarningAsError>
>> >
>> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
>> > +      <WarningLevel>Level2</WarningLevel>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > @@ -192,44 +195,52 @@
>> >    </ItemDefinitionGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>> >      <ClCompile>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNIN=
GS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Pre=
processorDefinitions>
>> >
>> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
>> > -      <WarningLevel>Level2</WarningLevel>
>> >        <TreatWarningAsError>true</TreatWarningAsError>
>> >
>> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
>> >        <ControlFlowGuard>Guard</ControlFlowGuard>
>> > +      <WarningLevel>Level2</WarningLevel>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +      <SDLCheck>true</SDLCheck>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> >
>> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>> >
>> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>> >        <SubSystem>Console</SubSystem>
>> > +      <CETCompat>true</CETCompat>
>> >      </Link>
>> >    </ItemDefinitionGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >      <ClCompile>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNIN=
GS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Pre=
processorDefinitions>
>> >
>> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
>> > -      <WarningLevel>Level2</WarningLevel>
>> >        <TreatWarningAsError>true</TreatWarningAsError>
>> >
>> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
>> >        <ControlFlowGuard>Guard</ControlFlowGuard>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <WarningLevel>Level2</WarningLevel>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> >
>> <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;cryp=
t32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi3=
2.lib</AdditionalDependencies>
>> >
>> <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
>> >        <SubSystem>Console</SubSystem>
>> > +      <CETCompat>true</CETCompat>
>> >      </Link>
>> >    </ItemDefinitionGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
>> >      <ClCompile>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNIN=
GS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Pre=
processorDefinitions>
>> >
>> <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
>> > -      <WarningLevel>Level2</WarningLevel>
>> >        <TreatWarningAsError>true</TreatWarningAsError>
>> >
>> <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalInclu=
deDirectories)</AdditionalIncludeDirectories>
>> >        <ControlFlowGuard>Guard</ControlFlowGuard>
>> > +      <WarningLevel>Level2</WarningLevel>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +      <SDLCheck>true</SDLCheck>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > diff --git a/src/openvpnmsica/openvpnmsica.vcxproj
>> b/src/openvpnmsica/openvpnmsica.vcxproj
>> > index 11aa78bb..5e774430 100644
>> > --- a/src/openvpnmsica/openvpnmsica.vcxproj
>> > +++ b/src/openvpnmsica/openvpnmsica.vcxproj
>> > @@ -135,6 +135,49 @@
>> >    <PropertyGroup Label=3D"Vcpkg"
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >      <VcpkgEnabled>true</VcpkgEnabled>
>> >    </PropertyGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> > +    <Link>
>> > +      <CETCompat>true</CETCompat>
>> > +    </Link>
>> > +    <ClCompile>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>> > +    <Link>
>> > +      <CETCompat>true</CETCompat>
>> > +    </Link>
>> > +    <ClCompile>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +      <SDLCheck>true</SDLCheck>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>> > +    <ClCompile>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
>> > +    <ClCompile>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>> > +    <ClCompile>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> > +    <ClCompile>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> >    <ItemGroup>
>> >      <ClCompile Include=3D"..\tapctl\error.c" />
>> >      <ClCompile Include=3D"..\tapctl\tap.c" />
>> > diff --git a/src/openvpnserv/openvpnserv.vcxproj
>> b/src/openvpnserv/openvpnserv.vcxproj
>> > index 520242f4..c70db229 100644
>> > --- a/src/openvpnserv/openvpnserv.vcxproj
>> > +++ b/src/openvpnserv/openvpnserv.vcxproj
>> > @@ -124,7 +124,9 @@
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>> >      <ClCompile>
>> >
>> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNING=
S;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > @@ -135,7 +137,9 @@
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> >      <ClCompile>
>> >
>> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNING=
S;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > @@ -146,7 +150,9 @@
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>> >      <ClCompile>
>> >
>> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNING=
S;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > @@ -157,29 +163,37 @@
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>> >      <ClCompile>
>> >
>> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNING=
S;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> >
>> <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;=
Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
>> >        <SubSystem>Console</SubSystem>
>> > +      <CETCompat>true</CETCompat>
>> >      </Link>
>> >    </ItemDefinitionGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >      <ClCompile>
>> >
>> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNING=
S;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> >
>> <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpap=
i.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenc=
ies)</AdditionalDependencies>
>> >        <SubSystem>Console</SubSystem>
>> > +      <CETCompat>true</CETCompat>
>> >      </Link>
>> >    </ItemDefinitionGroup>
>> >    <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
>> >      <ClCompile>
>> >
>> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
>> > -
>> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocess=
orDefinitions>
>> > +
>> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNING=
S;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> >      </ClCompile>
>> >      <ResourceCompile />
>> >      <Link>
>> > diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
>> > index 79da9d33..f439dc4f 100644
>> > --- a/src/tapctl/tapctl.vcxproj
>> > +++ b/src/tapctl/tapctl.vcxproj
>> > @@ -135,12 +135,54 @@
>> >    <PropertyGroup Label=3D"Vcpkg"
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> >      <VcpkgEnabled>true</VcpkgEnabled>
>> >    </PropertyGroup>
>> > -  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'" />
>> > -  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'" />
>> > -  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'" />
>> > -  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'" />
>> > -  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'" />
>> > -  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'" />
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>> > +    <ClCompile>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
>> > +    <ClCompile>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>> > +    <ClCompile>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>> > +    <ClCompile>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +    <Link>
>> > +      <CETCompat>true</CETCompat>
>> > +    </Link>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>> > +    <ClCompile>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> > +  <ItemDefinitionGroup
>> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>> > +    <Link>
>> > +      <CETCompat>true</CETCompat>
>> > +    </Link>
>> > +    <ClCompile>
>> > +      <SDLCheck>true</SDLCheck>
>> > +      <AdditionalOptions>/ZH:SHA_256
>> %(AdditionalOptions)</AdditionalOptions>
>> > +
>> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefinit=
ions>
>> > +    </ClCompile>
>> > +  </ItemDefinitionGroup>
>> >    <ItemGroup>
>> >      <ClCompile Include=3D"error.c" />
>> >      <ClCompile Include=3D"tap.c" />
>> > --
>> > 2.23.0.windows.1
>> >
>>
>>
>> --
>> -Lev
>>
>

--00000000000088a70105d82ef2d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr">original patch does not apply<div><br></div><div><div>C:\i\openvp=
n-chipitsine-2.5&gt;&quot;C:\Program Files\Git\usr\bin\patch.exe&quot; -p1 =
&lt; c:\users\ilia\Downloads\Openvpn-devel-2.5-msvc-adjust-build-options-to=
-harden-binaries.diff</div><div>patching file src/openvpn/openvpn.vcxproj</=
div><div>Hunk #1 FAILED at 147.</div><div>Hunk #2 FAILED at 162.</div><div>=
Hunk #3 FAILED at 177.</div><div>Hunk #4 FAILED at 192.</div><div>4 out of =
4 hunks FAILED -- saving rejects to file src/openvpn/openvpn.vcxproj.rej</d=
iv><div>patching file src/openvpnmsica/openvpnmsica.vcxproj</div><div>patch=
ing file src/openvpnserv/openvpnserv.vcxproj</div><div>patching file src/ta=
pctl/tapctl.vcxproj</div></div><div><br></div><div><br></div><div>I tried t=
o apply manually:=C2=A0<a href=3D"https://github.com/chipitsine/openvpn/com=
mit/eeff76551238b0194e72953b916c4481aab5f303">test =C2=B7 chipitsine/openvp=
n@...2652... (github.com)</a></div><div><br></div><div>minor build issues s=
till there:=C2=A0<a href=3D"https://github.com/chipitsine/openvpn/runs/5226=
889392?check_suite_focus=3Dtrue">test =C2=B7 chipitsine/openvpn@...2652... =
(github.com)</a></div><div><br></div><div><br></div><div>also, I have a que=
stion on=C2=A0&lt;SDLCheck&gt;true&lt;/SDLCheck&gt;, in your patch it is no=
t applied to all configurations, but to few of them. is it on purpose ?</di=
v><div><br></div><div><br></div></div></div></div></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 9 =D1=
=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 15:16, =D0=98=D0=BB=D1=8C=D1=8F =
=D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine=
@...277...">chipitsine@...277...</a>&gt;:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr">Sorry, I did not catch that you=
=C2=A0have been waiting for me.=C2=A0<div>I&#39;ll have a look in couple of=
 days</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">=D1=81=D1=80, 9 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 15=
:07, Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_bla=
nk">lstipakov@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi Ilja,<br>
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
</blockquote></div>

--00000000000088a70105d82ef2d9--

