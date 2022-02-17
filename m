MIME-Version: 1.0
References: <20220107145359.311-1-lstipakov@...277...>
 <20220217090153.394-1-lstipakov@...277...>
In-Reply-To: <20220217090153.394-1-lstipakov@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 17 Feb 2022 15:07:48 +0500
Message-ID: <CAFHpkQG4u4YfosoD1X2uPeFSeXvP59aFn5wtjp5t6q2=5+q01Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000dfc74005d833f046"
Subject: Re: [Openvpn-devel] [PATCH v2 release/2.5] msvc: adjust build
 options to harden binaries
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

--000000000000dfc74005d833f046
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've missed that patch [Openvpn-devel] [PATCH v2 4/5] tapctl: Resolve MSVC
C4996 warnings (mail-archive.com)
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21774.=
html>

I'll test updated patch soon.

=D1=87=D1=82, 17 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 14:03, Lev S=
tipakov <lstipakov@...277...>:

> From: Lev Stipakov <lev@...515...>
>
>  - enable hardware-enforced stack protection on
> compatible hardware/software (/CETCOMPAT linker option)
>
>  - hash object files with SHA256 (/ZH:SHA_256 compiler option)
>
>  - enable SDL. The required to add
>
>     _CRT_NONSTDC_NO_DEPRECATE
>     _CRT_SECURE_NO_WARNINGS
>     _WINSOCK_DEPRECATED_NO_WARNINGS
>
> preprocessor definitions. I don't feel like replacing strdup (which is
> correct POSIX function) and inet_ntoa (we always pass IPv4 address to
> it, inet_ntop will make code more complex)
>
> Above issues were discovered by bitskim.
>
> Before applying this patch, this one must be applied from master:
>
>
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21774=
.html
>
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  v2:
>    - rebase on top of latest release/2.5
>    - add SDL checks to all configurations
>
>  src/openvpn/auth_token.c              |  1 +
>  src/openvpn/openvpn.vcxproj           | 38 +++++++++++++------
>  src/openvpnmsica/openvpnmsica.vcxproj | 48 ++++++++++++++++++++++++
>  src/openvpnserv/openvpnserv.vcxproj   | 26 ++++++++++---
>  src/tapctl/tapctl.vcxproj             | 54 ++++++++++++++++++++++++---
>  5 files changed, 143 insertions(+), 24 deletions(-)
>
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index ca7e5a4d..37af6605 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -87,6 +87,7 @@ add_session_token_env(struct tls_session *session,
> struct tls_multi *multi,
>
>              default:
>                  /* Silence compiler warning, all four possible
> combinations are covered */
> +                state =3D NULL;
>                  ASSERT(0);
>          }
>      }
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index 91d5ebbe..05c63b03 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -147,11 +147,13 @@
>    </PropertyGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>      <ClCompile>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
>
>  <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
> -      <WarningLevel>Level2</WarningLevel>
>        <TreatWarningAsError>true</TreatWarningAsError>
>
>  <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)<=
/AdditionalIncludeDirectories>
> +      <WarningLevel>Level2</WarningLevel>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +      <SDLCheck>true</SDLCheck>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> @@ -162,11 +164,13 @@
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>      <ClCompile>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
>
>  <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
> -      <WarningLevel>Level2</WarningLevel>
>        <TreatWarningAsError>true</TreatWarningAsError>
>
>  <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)<=
/AdditionalIncludeDirectories>
> +      <WarningLevel>Level2</WarningLevel>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +      <SDLCheck>true</SDLCheck>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> @@ -177,11 +181,13 @@
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>      <ClCompile>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
>
>  <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
> -      <WarningLevel>Level2</WarningLevel>
>        <TreatWarningAsError>true</TreatWarningAsError>
>
>  <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)<=
/AdditionalIncludeDirectories>
> +      <WarningLevel>Level2</WarningLevel>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +      <SDLCheck>true</SDLCheck>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> @@ -192,44 +198,52 @@
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>      <ClCompile>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
>
>  <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
> -      <WarningLevel>Level2</WarningLevel>
>        <TreatWarningAsError>true</TreatWarningAsError>
>
>  <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)<=
/AdditionalIncludeDirectories>
>        <ControlFlowGuard>Guard</ControlFlowGuard>
> +      <WarningLevel>Level2</WarningLevel>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +      <SDLCheck>true</SDLCheck>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
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
>      <ClCompile>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
>
>  <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
> -      <WarningLevel>Level2</WarningLevel>
>        <TreatWarningAsError>true</TreatWarningAsError>
>
>  <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)<=
/AdditionalIncludeDirectories>
>        <ControlFlowGuard>Guard</ControlFlowGuard>
> +      <SDLCheck>true</SDLCheck>
> +      <WarningLevel>Level2</WarningLevel>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
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
>      <ClCompile>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_NONSTDC_NO_DEPRECATE;_CRT_SECURE_NO_WARNING=
S;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)</Prep=
rocessorDefinitions>
>
>  <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</Und=
efinePreprocessorDefinitions>
> -      <WarningLevel>Level2</WarningLevel>
>        <TreatWarningAsError>true</TreatWarningAsError>
>
>  <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)<=
/AdditionalIncludeDirectories>
>        <ControlFlowGuard>Guard</ControlFlowGuard>
> +      <WarningLevel>Level2</WarningLevel>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +      <SDLCheck>true</SDLCheck>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> diff --git a/src/openvpnmsica/openvpnmsica.vcxproj
> b/src/openvpnmsica/openvpnmsica.vcxproj
> index 11aa78bb..3a9f0c97 100644
> --- a/src/openvpnmsica/openvpnmsica.vcxproj
> +++ b/src/openvpnmsica/openvpnmsica.vcxproj
> @@ -135,6 +135,54 @@
>    <PropertyGroup Label=3D"Vcpkg"
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>      <VcpkgEnabled>true</VcpkgEnabled>
>    </PropertyGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +    <ClCompile>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +      <SDLCheck>true</SDLCheck>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +    <ClCompile>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +      <SDLCheck>true</SDLCheck>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> +    <ClCompile>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +      <SDLCheck>true</SDLCheck>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> +    <ClCompile>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +      <SDLCheck>true</SDLCheck>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> +    <ClCompile>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +      <SDLCheck>true</SDLCheck>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> +    <ClCompile>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +      <SDLCheck>true</SDLCheck>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
>    <ItemGroup>
>      <ClCompile Include=3D"..\tapctl\error.c" />
>      <ClCompile Include=3D"..\tapctl\tap.c" />
> diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> index 520242f4..c70db229 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj
> +++ b/src/openvpnserv/openvpnserv.vcxproj
> @@ -124,7 +124,9 @@
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>      <ClCompile>
>
>  <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> @@ -135,7 +137,9 @@
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>      <ClCompile>
>
>  <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> @@ -146,7 +150,9 @@
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
>      <ClCompile>
>
>  <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> @@ -157,29 +163,37 @@
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>      <ClCompile>
>
>  <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
>      </ClCompile>
>      <ResourceCompile />
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
>      <ClCompile>
>
>  <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
>      </ClCompile>
>      <ResourceCompile />
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
>      <ClCompile>
>
>  <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDi=
rectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <PreprocessorDefinitions>_CRT_SECURE_NO_WARNINGS;_CRT_NONSTDC_NO_WARNINGS=
;_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
>      </ClCompile>
>      <ResourceCompile />
>      <Link>
> diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
> index 79da9d33..f439dc4f 100644
> --- a/src/tapctl/tapctl.vcxproj
> +++ b/src/tapctl/tapctl.vcxproj
> @@ -135,12 +135,54 @@
>    <PropertyGroup Label=3D"Vcpkg"
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>      <VcpkgEnabled>true</VcpkgEnabled>
>    </PropertyGroup>
> -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'" />
> -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'" />
> -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'" />
> -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'" />
> -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'" />
> -  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'" />
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|ARM64'">
> +    <ClCompile>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|ARM64'">
> +    <ClCompile>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
> +    <ClCompile>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
> +    <ClCompile>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +    </ClCompile>
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
> +    <ClCompile>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
> +    <Link>
> +      <CETCompat>true</CETCompat>
> +    </Link>
> +    <ClCompile>
> +      <SDLCheck>true</SDLCheck>
> +      <AdditionalOptions>/ZH:SHA_256
> %(AdditionalOptions)</AdditionalOptions>
> +
> <PreprocessorDefinitions>%(PreprocessorDefinitions)</PreprocessorDefiniti=
ons>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
>    <ItemGroup>
>      <ClCompile Include=3D"error.c" />
>      <ClCompile Include=3D"tap.c" />
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

--000000000000dfc74005d833f046
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">I&#39;ve missed that patch=C2=A0<a href=
=3D"https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg217=
74.html">[Openvpn-devel] [PATCH v2 4/5] tapctl: Resolve MSVC C4996 warnings=
 (mail-archive.com)</a></div><div dir=3D"ltr"><br></div><div>I&#39;ll test =
updated patch soon.</div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">=D1=87=D1=82, 17 =D1=84=D0=B5=D0=B2=D1=80. 2022 =
=D0=B3. =D0=B2 14:03, Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1663...=
.">lstipakov@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." tar=
get=3D"_blank">lev@...515...</a>&gt;<br>
<br>
=C2=A0- enable hardware-enforced stack protection on<br>
compatible hardware/software (/CETCOMPAT linker option)<br>
<br>
=C2=A0- hash object files with SHA256 (/ZH:SHA_256 compiler option)<br>
<br>
=C2=A0- enable SDL. The required to add<br>
<br>
=C2=A0 =C2=A0 _CRT_NONSTDC_NO_DEPRECATE<br>
=C2=A0 =C2=A0 _CRT_SECURE_NO_WARNINGS<br>
=C2=A0 =C2=A0 _WINSOCK_DEPRECATED_NO_WARNINGS<br>
<br>
preprocessor definitions. I don&#39;t feel like replacing strdup (which is<=
br>
correct POSIX function) and inet_ntoa (we always pass IPv4 address to<br>
it, inet_ntop will make code more complex)<br>
<br>
Above issues were discovered by bitskim.<br>
<br>
Before applying this patch, this one must be applied from master:<br>
<br>
<a href=3D"https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg21774.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg21774.html</a><br>
<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0v2:<br>
=C2=A0 =C2=A0- rebase on top of latest release/2.5<br>
=C2=A0 =C2=A0- add SDL checks to all configurations<br>
<br>
=C2=A0src/openvpn/auth_token.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
=C2=A0src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 38 +++++++++++++------<br>
=C2=A0src/openvpnmsica/openvpnmsica.vcxproj | 48 ++++++++++++++++++++++++<b=
r>
=C2=A0src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0| 26 ++++++++++---<br>
=C2=A0src/tapctl/tapctl.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 54 ++++++++++++++++++++++++---<br>
=C2=A05 files changed, 143 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c<br>
index ca7e5a4d..37af6605 100644<br>
--- a/src/openvpn/auth_token.c<br>
+++ b/src/openvpn/auth_token.c<br>
@@ -87,6 +87,7 @@ add_session_token_env(struct tls_session *session, struct=
 tls_multi *multi,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Silence co=
mpiler warning, all four possible combinations are covered */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj<br>
index 91d5ebbe..05c63b03 100644<br>
--- a/src/openvpn/openvpn.vcxproj<br>
+++ b/src/openvpn/openvpn.vcxproj<br>
@@ -147,11 +147,13 @@<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPREC=
ATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prep=
rocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;UndefinePreprocessorDefinitions&gt;%(Undefin=
ePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TreatWarningAsError&gt;true&lt;/TreatWarning=
AsError&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\compat;%(=
AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
@@ -162,11 +164,13 @@<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPREC=
ATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prep=
rocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;UndefinePreprocessorDefinitions&gt;%(Undefin=
ePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TreatWarningAsError&gt;true&lt;/TreatWarning=
AsError&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\compat;%(=
AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
@@ -177,11 +181,13 @@<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPREC=
ATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prep=
rocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;UndefinePreprocessorDefinitions&gt;%(Undefin=
ePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TreatWarningAsError&gt;true&lt;/TreatWarning=
AsError&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\compat;%(=
AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
@@ -192,44 +198,52 @@<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPREC=
ATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prep=
rocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;UndefinePreprocessorDefinitions&gt;%(Undefin=
ePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TreatWarningAsError&gt;true&lt;/TreatWarning=
AsError&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\compat;%(=
AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
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
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPREC=
ATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prep=
rocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;UndefinePreprocessorDefinitions&gt;%(Undefin=
ePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TreatWarningAsError&gt;true&lt;/TreatWarning=
AsError&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\compat;%(=
AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
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
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_NONSTDC_NO_DEPREC=
ATE;_CRT_SECURE_NO_WARNINGS;_WINSOCK_DEPRECATED_NO_WARNINGS;_CONSOLE;%(Prep=
rocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;UndefinePreprocessorDefinitions&gt;%(Undefin=
ePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;TreatWarningAsError&gt;true&lt;/TreatWarning=
AsError&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\compat;%(=
AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;ControlFlowGuard&gt;Guard&lt;/ControlFlowGua=
rd&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level2&lt;/WarningLevel&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openv=
pnmsica.vcxproj<br>
index 11aa78bb..3a9f0c97 100644<br>
--- a/src/openvpnmsica/openvpnmsica.vcxproj<br>
+++ b/src/openvpnmsica/openvpnmsica.vcxproj<br>
@@ -135,6 +135,54 @@<br>
=C2=A0 =C2=A0&lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;=
&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0&lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;..\tapctl\error.c&quot; /=
&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;..\tapctl\tap.c&quot; /&g=
t;<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj<br>
index 520242f4..c70db229 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj<br>
@@ -124,7 +124,9 @@<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\openvpn;.=
.\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&g=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WARNING=
S;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Preproce=
ssorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
@@ -135,7 +137,9 @@<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\openvpn;.=
.\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&g=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WARNING=
S;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Preproce=
ssorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
@@ -146,7 +150,9 @@<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\openvpn;.=
.\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&g=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WARNING=
S;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Preproce=
ssorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
@@ -157,29 +163,37 @@<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\openvpn;.=
.\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&g=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WARNING=
S;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Preproce=
ssorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
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
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\openvpn;.=
.\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&g=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WARNING=
S;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Preproce=
ssorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
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
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalIncludeDirectories&gt;..\openvpn;.=
.\compat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&g=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CRT_SECURE_NO_WARNING=
S;_CRT_NONSTDC_NO_WARNINGS;_CONSOLE;%(PreprocessorDefinitions)&lt;/Preproce=
ssorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj<br>
index 79da9d33..f439dc4f 100644<br>
--- a/src/tapctl/tapctl.vcxproj<br>
+++ b/src/tapctl/tapctl.vcxproj<br>
@@ -135,12 +135,54 @@<br>
=C2=A0 =C2=A0&lt;PropertyGroup Label=3D&quot;Vcpkg&quot; Condition=3D&quot;=
&#39;$(Configuration)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0&lt;VcpkgEnabled&gt;true&lt;/VcpkgEnabled&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
-=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot; /&gt;<br>
-=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot; /&gt;<br>
-=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; /&gt;<br>
-=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|Win32&#39;&quot; /&gt;<br>
-=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|x64&#39;&quot; /&gt;<br>
-=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|x64&#39;&quot; /&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|ARM64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|ARM64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration)|$(P=
latform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;CETCompat&gt;true&lt;/CETCompat&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalOptions&gt;/ZH:SHA_256 %(AdditionalOpti=
ons)&lt;/AdditionalOptions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;%(PreprocessorDefiniti=
ons)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;error.c&quot; /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;tap.c&quot; /&gt;<br>
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
</blockquote></div>

--000000000000dfc74005d833f046--

