MIME-Version: 1.0
References: <20181008094600.10164-1-simon@...2293...>
 <20181008094600.10164-2-simon@...2293...>
In-Reply-To: <20181008094600.10164-2-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 8 Oct 2018 14:24:29 +0300
Message-ID: <CAGyAFMWrm=hWo9nXsBH9Tq_AWD-xx3qTSjmFGMrNXWmMAEJ2qg@...278...>
Content-Type: multipart/alternative; boundary="000000000000eb1adc0577b5dd2b"
Subject: Re: [Openvpn-devel] [PATCH 2/2] msvc: Move common project settings
 to reusable property sheets
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

--000000000000eb1adc0577b5dd2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Looks good, removed lots of duplicates. Tested on VS2017.

Acked-by: Lev Stipakov <lev@...515...>

ma 8. lokak. 2018 klo 12.47 Simon Rozman (simon@...2293...) kirjoitti:

> The Visual Studio 2017 project files were refactored by migrating all
> repeating common settings into three property sheets: Debug.props,
> Release.props and the existing PropertySheet.props.
> This simplifies configuration management while providing uniformity
> across projects, configurations and platforms.
> ---
>  src/compat/Debug.props                      | 22 +++++
>  src/compat/PropertySheet.props              | 19 +++-
>  src/compat/Release.props                    | 25 ++++++
>  src/compat/compat.vcxproj                   | 61 +++----------
>  src/openvpn/openvpn.vcxproj                 | 99 +++++----------------
>  src/openvpn/openvpn.vcxproj.filters         | 12 +++
>  src/openvpnserv/openvpnserv.vcxproj         | 90 ++++---------------
>  src/openvpnserv/openvpnserv.vcxproj.filters | 22 ++++-
>  8 files changed, 144 insertions(+), 206 deletions(-)
>  create mode 100644 src/compat/Debug.props
>  create mode 100644 src/compat/Release.props
>
> diff --git a/src/compat/Debug.props b/src/compat/Debug.props
> new file mode 100644
> index 00000000..e5e9f681
> --- /dev/null
> +++ b/src/compat/Debug.props
> @@ -0,0 +1,22 @@
> +<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project ToolsVersion=3D"4.0" xmlns=3D"
> http://schemas.microsoft.com/developer/msbuild/2003">
> +  <ImportGroup Label=3D"PropertySheets">
> +    <Import Project=3D"PropertySheet.props" />
> +  </ImportGroup>
> +  <PropertyGroup Label=3D"UserMacros" />
> +  <PropertyGroup>
> +    <_PropertySheetDisplayName>compat-Debug</_PropertySheetDisplayName>
> +    <LinkIncremental>true</LinkIncremental>
> +  </PropertyGroup>
> +  <ItemDefinitionGroup>
> +    <ClCompile>
> +      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> +      <Optimization>Disabled</Optimization>
> +
> <PreprocessorDefinitions>_DEBUG;%(PreprocessorDefinitions)</PreprocessorD=
efinitions>
> +      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> +      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> +      <MinimalRebuild>true</MinimalRebuild>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemGroup />
> +</Project>
> \ No newline at end of file
> diff --git a/src/compat/PropertySheet.props
> b/src/compat/PropertySheet.props
> index 1e5c2f96..4cad994b 100644
> --- a/src/compat/PropertySheet.props
> +++ b/src/compat/PropertySheet.props
> @@ -9,8 +9,23 @@
>      <LZO_HOME>$(OPENVPN_DEPROOT)</LZO_HOME>
>      <PKCS11H_HOME>$(OPENVPN_DEPROOT)</PKCS11H_HOME>
>    </PropertyGroup>
> -  <PropertyGroup />
> -  <ItemDefinitionGroup />
> +  <PropertyGroup>
> +    <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> +    <_PropertySheetDisplayName>compat</_PropertySheetDisplayName>
> +  </PropertyGroup>
> +  <ItemDefinitionGroup>
> +    <ClCompile>
> +      <WarningLevel>Level3</WarningLevel>
> +
> <PreprocessorDefinitions>WIN32;$(CPPFLAGS);%(PreprocessorDefinitions)</Pr=
eprocessorDefinitions>
> +
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;%(Addit=
ionalIncludeDirectories)</AdditionalIncludeDirectories>
> +    </ClCompile>
> +    <Link>
> +      <GenerateDebugInformation>true</GenerateDebugInformation>
> +    </Link>
> +    <ResourceCompile>
> +
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> +    </ResourceCompile>
> +  </ItemDefinitionGroup>
>    <ItemGroup>
>      <BuildMacro Include=3D"SOURCEBASE">
>        <Value>$(SOURCEBASE)</Value>
> diff --git a/src/compat/Release.props b/src/compat/Release.props
> new file mode 100644
> index 00000000..63828b79
> --- /dev/null
> +++ b/src/compat/Release.props
> @@ -0,0 +1,25 @@
> +<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project ToolsVersion=3D"4.0" xmlns=3D"
> http://schemas.microsoft.com/developer/msbuild/2003">
> +  <ImportGroup Label=3D"PropertySheets">
> +    <Import Project=3D"PropertySheet.props" />
> +  </ImportGroup>
> +  <PropertyGroup Label=3D"UserMacros" />
> +  <PropertyGroup>
> +    <_PropertySheetDisplayName>compat-Release</_PropertySheetDisplayName>
> +    <LinkIncremental>false</LinkIncremental>
> +  </PropertyGroup>
> +  <ItemDefinitionGroup>
> +    <ClCompile>
> +      <IntrinsicFunctions>true</IntrinsicFunctions>
> +      <FunctionLevelLinking>true</FunctionLevelLinking>
> +      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> +      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +
> <PreprocessorDefinitions>NDEBUG;%(PreprocessorDefinitions)</PreprocessorD=
efinitions>
> +    </ClCompile>
> +    <Link>
> +      <EnableCOMDATFolding>true</EnableCOMDATFolding>
> +      <OptimizeReferences>true</OptimizeReferences>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemGroup />
> +</Project>
> \ No newline at end of file
> diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
> index d6473581..111dacdd 100644
> --- a/src/compat/compat.vcxproj
> +++ b/src/compat/compat.vcxproj
> @@ -52,83 +52,46 @@
>    </ImportGroup>
>    <ImportGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"PropertySheet.props" />
> +    <Import Project=3D"Release.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"PropertySheet.props" />
> +    <Import Project=3D"Release.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"PropertySheet.props" />
> +    <Import Project=3D"Debug.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"PropertySheet.props" />
> +    <Import Project=3D"Debug.props" />
>    </ImportGroup>
>    <PropertyGroup Label=3D"UserMacros" />
>    <PropertyGroup>
>      <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">$(Solutio=
nDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">$(SolutionD=
ir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <IntDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">$(Configu=
ration)\</IntDir>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">$(Solut=
ionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">$(Solutio=
nDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <IntDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">$(Confi=
guration)\</IntDir>
>    </PropertyGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>      <ClCompile>
> -      <Optimization>Disabled</Optimization>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENS=
SL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIn=
cludeDirectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefi=
nitions)</PreprocessorDefinitions>
> -      <MinimalRebuild>true</MinimalRebuild>
> -      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> -      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include=
;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalInclude=
Directories>
> +
> <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDef=
initions>
>      </ClCompile>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>      <ClCompile>
> -      <Optimization>Disabled</Optimization>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENS=
SL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIn=
cludeDirectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefi=
nitions)</PreprocessorDefinitions>
> -      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> -      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include=
;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalInclude=
Directories>
> +
> <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDef=
initions>
>      </ClCompile>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>      <ClCompile>
> -      <Optimization>MaxSpeed</Optimization>
> -      <IntrinsicFunctions>true</IntrinsicFunctions>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENS=
SL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIn=
cludeDirectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefi=
nitions)</PreprocessorDefinitions>
> -      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> -      <FunctionLevelLinking>true</FunctionLevelLinking>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include=
;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalInclude=
Directories>
> +
> <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDef=
initions>
>      </ClCompile>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>      <ClCompile>
> -      <Optimization>MaxSpeed</Optimization>
> -      <IntrinsicFunctions>true</IntrinsicFunctions>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENS=
SL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIn=
cludeDirectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefi=
nitions)</PreprocessorDefinitions>
> -      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> -      <FunctionLevelLinking>true</FunctionLevelLinking>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>$(OPENSSL_HOME)/include;$(LZO_HOME)/include=
;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalInclude=
Directories>
> +
> <PreprocessorDefinitions>_LIB;%(PreprocessorDefinitions)</PreprocessorDef=
initions>
>      </ClCompile>
>    </ItemDefinitionGroup>
>    <ItemGroup>
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> index 8fb7bee8..92d7e32e 100644
> --- a/src/openvpn/openvpn.vcxproj
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -52,133 +52,74 @@
>    </ImportGroup>
>    <ImportGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Release.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Release.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Debug.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Debug.props" />
>    </ImportGroup>
>    <PropertyGroup Label=3D"UserMacros" />
>    <PropertyGroup>
>      <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">$(Solutio=
nDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">$(SolutionD=
ir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <IntDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">$(Configu=
ration)\</IntDir>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">true</Lin=
kIncremental>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">true</LinkI=
ncremental>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">$(Solut=
ionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">$(Solutio=
nDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <IntDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">$(Confi=
guration)\</IntDir>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">false</=
LinkIncremental>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">false</Li=
nkIncremental>
>    </PropertyGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>      <ClCompile>
> -      <Optimization>Disabled</Optimization>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SO=
URCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO=
_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</Add=
itionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> -      <MinimalRebuild>true</MinimalRebuild>
> -      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> -      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> -
> <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
> +
> <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPE=
NSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Additional=
IncludeDirectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinition=
s)</UndefinePreprocessorDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32=
.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;winin=
et.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(Additio=
nalDependencies)</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> -      <TargetMachine>MachineX86</TargetMachine>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>      <ClCompile>
> -      <Optimization>Disabled</Optimization>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SO=
URCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO=
_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</Add=
itionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> -      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> -      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> -
> <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
> +
> <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPE=
NSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Additional=
IncludeDirectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinition=
s)</UndefinePreprocessorDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32=
.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;winin=
et.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(Additio=
nalDependencies)</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>      <ClCompile>
> -      <Optimization>MaxSpeed</Optimization>
> -      <IntrinsicFunctions>true</IntrinsicFunctions>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SO=
URCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO=
_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</Add=
itionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> -      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> -      <FunctionLevelLinking>true</FunctionLevelLinking>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> -
> <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
> +
> <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPE=
NSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Additional=
IncludeDirectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinition=
s)</UndefinePreprocessorDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32=
.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;winin=
et.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(Additio=
nalDependencies)</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> -      <OptimizeReferences>true</OptimizeReferences>
> -      <EnableCOMDATFolding>true</EnableCOMDATFolding>
> -      <TargetMachine>MachineX86</TargetMachine>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>      <ClCompile>
> -      <Optimization>MaxSpeed</Optimization>
> -      <IntrinsicFunctions>true</IntrinsicFunctions>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SO=
URCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO=
_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</Add=
itionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> -      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> -      <FunctionLevelLinking>true</FunctionLevelLinking>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> -
> <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
> +
> <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPE=
NSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Additional=
IncludeDirectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
> +
> <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinition=
s)</UndefinePreprocessorDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32=
.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;winin=
et.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(Additio=
nalDependencies)</AdditionalDependencies>
>
>  <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS=
11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> -      <OptimizeReferences>true</OptimizeReferences>
> -      <EnableCOMDATFolding>true</EnableCOMDATFolding>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemGroup>
> diff --git a/src/openvpn/openvpn.vcxproj.filters
> b/src/openvpn/openvpn.vcxproj.filters
> index 4152236d..7a9aa631 100644
> --- a/src/openvpn/openvpn.vcxproj.filters
> +++ b/src/openvpn/openvpn.vcxproj.filters
> @@ -228,6 +228,12 @@
>      <ClCompile Include=3D"tls_crypt.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> +    <ClCompile Include=3D"env_set.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"run_command.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
>    </ItemGroup>
>    <ItemGroup>
>      <ClInclude Include=3D"base64.h">
> @@ -476,6 +482,12 @@
>      <ClInclude Include=3D"tls_crypt.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> +    <ClInclude Include=3D"env_set.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"run_command.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
>    </ItemGroup>
>    <ItemGroup>
>      <ResourceCompile Include=3D"openvpn_win32_resources.rc">
> diff --git a/src/openvpnserv/openvpnserv.vcxproj
> b/src/openvpnserv/openvpnserv.vcxproj
> index 4edcf851..74077570 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj
> +++ b/src/openvpnserv/openvpnserv.vcxproj
> @@ -52,124 +52,66 @@
>    </ImportGroup>
>    <ImportGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Release.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|x64'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Release.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Debug.props" />
>    </ImportGroup>
>    <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x=
64'"
> Label=3D"PropertySheets">
>      <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps"
> Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props'=
)"
> Label=3D"LocalAppDataPlatform" />
> -    <Import Project=3D"..\compat\PropertySheet.props" />
> +    <Import Project=3D"..\compat\Debug.props" />
>    </ImportGroup>
>    <PropertyGroup Label=3D"UserMacros" />
>    <PropertyGroup>
>      <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">$(Solutio=
nDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">$(SolutionD=
ir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <IntDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">$(Configu=
ration)\</IntDir>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">true</Lin=
kIncremental>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">true</LinkI=
ncremental>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">$(Solut=
ionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <OutDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">$(Solutio=
nDir)$(Platform)-Output\$(Configuration)\</OutDir>
> -    <IntDir
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">$(Confi=
guration)\</IntDir>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">false</=
LinkIncremental>
> -    <LinkIncremental
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">false</Li=
nkIncremental>
>    </PropertyGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win32'">
>      <ClCompile>
> -      <Optimization>Disabled</Optimization>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\c=
ompat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> -      <MinimalRebuild>true</MinimalRebuild>
> -      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> -      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;=
Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> -      <TargetMachine>MachineX86</TargetMachine>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|x64'">
>      <ClCompile>
> -      <Optimization>Disabled</Optimization>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\c=
ompat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> -      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> -      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpap=
i.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenc=
ies)</AdditionalDependencies>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Win32'">
>      <ClCompile>
> -      <Optimization>MaxSpeed</Optimization>
> -      <IntrinsicFunctions>true</IntrinsicFunctions>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\c=
ompat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> -
> <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(Preprocessor=
Definitions)</PreprocessorDefinitions>
> -      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> -      <FunctionLevelLinking>true</FunctionLevelLinking>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;=
Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> -      <OptimizeReferences>true</OptimizeReferences>
> -      <EnableCOMDATFolding>true</EnableCOMDATFolding>
> -      <TargetMachine>MachineX86</TargetMachine>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemDefinitionGroup
> Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|x64'">
>      <ClCompile>
> -      <Optimization>MaxSpeed</Optimization>
> -      <IntrinsicFunctions>true</IntrinsicFunctions>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);..\..\include;..\openvpn;..\c=
ompat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
> -      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> -      <FunctionLevelLinking>true</FunctionLevelLinking>
> -      <PrecompiledHeader>
> -      </PrecompiledHeader>
> -      <WarningLevel>Level3</WarningLevel>
> -      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +
> <AdditionalIncludeDirectories>..\openvpn;..\compat;%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +
> <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</Preprocesso=
rDefinitions>
>      </ClCompile>
> -    <ResourceCompile>
> -
> <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> -    </ResourceCompile>
> +    <ResourceCompile />
>      <Link>
>
>  <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpap=
i.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependenc=
ies)</AdditionalDependencies>
> -      <GenerateDebugInformation>true</GenerateDebugInformation>
>        <SubSystem>Console</SubSystem>
> -      <OptimizeReferences>true</OptimizeReferences>
> -      <EnableCOMDATFolding>true</EnableCOMDATFolding>
>      </Link>
>    </ItemDefinitionGroup>
>    <ItemGroup>
> diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters
> b/src/openvpnserv/openvpnserv.vcxproj.filters
> index 0c89b4f4..3ce9bb24 100644
> --- a/src/openvpnserv/openvpnserv.vcxproj.filters
> +++ b/src/openvpnserv/openvpnserv.vcxproj.filters
> @@ -15,10 +15,22 @@
>      </Filter>
>    </ItemGroup>
>    <ItemGroup>
> -    <ClCompile Include=3D"openvpnserv.c">
> +    <ClCompile Include=3D"service.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
> -    <ClCompile Include=3D"service.c">
> +    <ClCompile Include=3D"automatic.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"common.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"interactive.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"validate.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"..\openvpn\block_dns.c">
>        <Filter>Source Files</Filter>
>      </ClCompile>
>    </ItemGroup>
> @@ -26,6 +38,12 @@
>      <ClInclude Include=3D"service.h">
>        <Filter>Header Files</Filter>
>      </ClInclude>
> +    <ClInclude Include=3D"validate.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"..\openvpn\block_dns.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
>    </ItemGroup>
>    <ItemGroup>
>      <ResourceCompile Include=3D"openvpnserv_resources.rc">
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


--=20
-Lev

--000000000000eb1adc0577b5dd2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Looks good, removed lots of duplica=
tes. Tested on VS2017.</div><div><br></div><div>Acked-by: Lev Stipakov &lt;=
<a href=3D"mailto:lev@...515...">lev@...515...</a>&gt;</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr">ma 8. lokak. 2018 klo 12.47 Simon Ro=
zman (<a href=3D"mailto:simon@...2293...">simon@...2293...</a>) kirjoitti:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">The Visual Studio 2017 project file=
s were refactored by migrating all<br>
repeating common settings into three property sheets: Debug.props,<br>
Release.props and the existing PropertySheet.props.<br>
This simplifies configuration management while providing uniformity<br>
across projects, configurations and platforms.<br>
---<br>
=C2=A0src/compat/Debug.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 22 +++++<br>
=C2=A0src/compat/PropertySheet.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 19 +++-<br>
=C2=A0src/compat/Release.props=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 25 ++++++<br>
=C2=A0src/compat/compat.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 61 +++----------<br>
=C2=A0src/openvpn/openvpn.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 99 +++++----------------<br>
=C2=A0src/openvpn/openvpn.vcxproj.filters=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 12 +++<br>
=C2=A0src/openvpnserv/openvpnserv.vcxproj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 90 ++++---------------<br>
=C2=A0src/openvpnserv/openvpnserv.vcxproj.filters | 22 ++++-<br>
=C2=A08 files changed, 144 insertions(+), 206 deletions(-)<br>
=C2=A0create mode 100644 src/compat/Debug.props<br>
=C2=A0create mode 100644 src/compat/Release.props<br>
<br>
diff --git a/src/compat/Debug.props b/src/compat/Debug.props<br>
new file mode 100644<br>
index 00000000..e5e9f681<br>
--- /dev/null<br>
+++ b/src/compat/Debug.props<br>
@@ -0,0 +1,22 @@<br>
+&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;<br>
+&lt;Project ToolsVersion=3D&quot;4.0&quot; xmlns=3D&quot;<a href=3D"http:/=
/schemas.microsoft.com/developer/msbuild/2003" rel=3D"noreferrer" target=3D=
"_blank">http://schemas.microsoft.com/developer/msbuild/2003</a>&quot;&gt;<=
br>
+=C2=A0 &lt;ImportGroup Label=3D&quot;PropertySheets&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;PropertySheet.props&quot; /&gt;<b=
r>
+=C2=A0 &lt;/ImportGroup&gt;<br>
+=C2=A0 &lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;<br>
+=C2=A0 &lt;PropertyGroup&gt;<br>
+=C2=A0 =C2=A0 &lt;_PropertySheetDisplayName&gt;compat-Debug&lt;/_PropertyS=
heetDisplayName&gt;<br>
+=C2=A0 =C2=A0 &lt;LinkIncremental&gt;true&lt;/LinkIncremental&gt;<br>
+=C2=A0 &lt;/PropertyGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicR=
untimeChecks&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;Disabled&lt;/Optimization&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_DEBUG;%(PreprocessorD=
efinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/Runti=
meLibrary&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;EditAndContinue&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;MinimalRebuild&gt;true&lt;/MinimalRebuild&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemGroup /&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.prop=
s<br>
index 1e5c2f96..4cad994b 100644<br>
--- a/src/compat/PropertySheet.props<br>
+++ b/src/compat/PropertySheet.props<br>
@@ -9,8 +9,23 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;LZO_HOME&gt;$(OPENVPN_DEPROOT)&lt;/LZO_HOME&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;PKCS11H_HOME&gt;$(OPENVPN_DEPROOT)&lt;/PKCS11H_HOME=
&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
-=C2=A0 &lt;PropertyGroup /&gt;<br>
-=C2=A0 &lt;ItemDefinitionGroup /&gt;<br>
+=C2=A0 &lt;PropertyGroup&gt;<br>
+=C2=A0 =C2=A0 &lt;OutDir&gt;$(SolutionDir)$(Platform)-Output\$(Configurati=
on)\&lt;/OutDir&gt;<br>
+=C2=A0 =C2=A0 &lt;_PropertySheetDisplayName&gt;compat&lt;/_PropertySheetDi=
splayName&gt;<br>
+=C2=A0 &lt;/PropertyGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;$(CPPFLAGS);%(Pr=
eprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDir=
ectories&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;BuildMacro Include=3D&quot;SOURCEBASE&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Value&gt;$(SOURCEBASE)&lt;/Value&gt;<br>
diff --git a/src/compat/Release.props b/src/compat/Release.props<br>
new file mode 100644<br>
index 00000000..63828b79<br>
--- /dev/null<br>
+++ b/src/compat/Release.props<br>
@@ -0,0 +1,25 @@<br>
+&lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;utf-8&quot;?&gt;<br>
+&lt;Project ToolsVersion=3D&quot;4.0&quot; xmlns=3D&quot;<a href=3D"http:/=
/schemas.microsoft.com/developer/msbuild/2003" rel=3D"noreferrer" target=3D=
"_blank">http://schemas.microsoft.com/developer/msbuild/2003</a>&quot;&gt;<=
br>
+=C2=A0 &lt;ImportGroup Label=3D&quot;PropertySheets&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;PropertySheet.props&quot; /&gt;<b=
r>
+=C2=A0 &lt;/ImportGroup&gt;<br>
+=C2=A0 &lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;<br>
+=C2=A0 &lt;PropertyGroup&gt;<br>
+=C2=A0 =C2=A0 &lt;_PropertySheetDisplayName&gt;compat-Release&lt;/_Propert=
ySheetDisplayName&gt;<br>
+=C2=A0 =C2=A0 &lt;LinkIncremental&gt;false&lt;/LinkIncremental&gt;<br>
+=C2=A0 &lt;/PropertyGroup&gt;<br>
+=C2=A0 &lt;ItemDefinitionGroup&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions=
&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;FunctionLevelLinking&gt;true&lt;/FunctionLevelLin=
king&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/RuntimeLib=
rary&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;NDEBUG;%(PreprocessorD=
efinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;Link&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;EnableCOMDATFolding&gt;true&lt;/EnableCOMDATFoldi=
ng&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;OptimizeReferences&gt;true&lt;/OptimizeReferences=
&gt;<br>
+=C2=A0 =C2=A0 &lt;/Link&gt;<br>
+=C2=A0 &lt;/ItemDefinitionGroup&gt;<br>
+=C2=A0 &lt;ItemGroup /&gt;<br>
+&lt;/Project&gt;<br>
\ No newline at end of file<br>
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj<br>
index d6473581..111dacdd 100644<br>
--- a/src/compat/compat.vcxproj<br>
+++ b/src/compat/compat.vcxproj<br>
@@ -52,83 +52,46 @@<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;PropertySheets&=
quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;PropertySheet.props&quot; /&gt;<b=
r>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;Release.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;PropertySheets&qu=
ot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;PropertySheet.props&quot; /&gt;<b=
r>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;Release.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;PropertySheets&qu=
ot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;PropertySheet.props&quot; /&gt;<b=
r>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;Debug.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;PropertySheets&quot=
;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;PropertySheet.props&quot; /&gt;<b=
r>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;Debug.props&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;_ProjectFileVersion&gt;10.0.30319.1&lt;/_ProjectFil=
eVersion&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(SolutionDir)$(Platform)-Outpu=
t\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;$(SolutionDir)$(Platform)-Output\=
$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;IntDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(Configuration)\&lt;/IntDir&gt=
;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(SolutionDir)$(Platform)-Out=
put\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;$(SolutionDir)$(Platform)-Outpu=
t\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;IntDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(Configuration)\&lt;/IntDir&=
gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;Disabled&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HO=
ME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectorie=
s&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;_DEBUG;_LIB;$(CP=
PFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;MinimalRebuild&gt;true&lt;/MinimalRebuild&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicR=
untimeChecks&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/Runti=
meLibrary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;EditAndContinue&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(OPENSSL_HOME)/i=
nclude;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirec=
tories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_LIB;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;Disabled&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HO=
ME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectorie=
s&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;_DEBUG;_LIB;$(CP=
PFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicR=
untimeChecks&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/Runti=
meLibrary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(OPENSSL_HOME)/i=
nclude;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirec=
tories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_LIB;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;MaxSpeed&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HO=
ME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectorie=
s&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;NDEBUG;_LIB;$(CP=
PFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/RuntimeLib=
rary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;FunctionLevelLinking&gt;true&lt;/FunctionLevelLin=
king&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(OPENSSL_HOME)/i=
nclude;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirec=
tories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_LIB;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;MaxSpeed&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HO=
ME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectorie=
s&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;NDEBUG;_LIB;$(CP=
PFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/RuntimeLib=
rary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;FunctionLevelLinking&gt;true&lt;/FunctionLevelLin=
king&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(OPENSSL_HOME)/i=
nclude;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirec=
tories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_LIB;%(PreprocessorDef=
initions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj<br>
index 8fb7bee8..92d7e32e 100644<br>
--- a/src/openvpn/openvpn.vcxproj<br>
+++ b/src/openvpn/openvpn.vcxproj<br>
@@ -52,133 +52,74 @@<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;PropertySheets&=
quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Release.props&quot; /&g=
t;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;PropertySheets&qu=
ot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Release.props&quot; /&g=
t;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;PropertySheets&qu=
ot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Debug.props&quot; /&gt;=
<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;PropertySheets&quot=
;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Debug.props&quot; /&gt;=
<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;_ProjectFileVersion&gt;10.0.30319.1&lt;/_ProjectFil=
eVersion&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(SolutionDir)$(Platform)-Outpu=
t\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;$(SolutionDir)$(Platform)-Output\=
$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;IntDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(Configuration)\&lt;/IntDir&gt=
;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;true&lt;/LinkIncrement=
al&gt;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;true&lt;/LinkIncremental=
&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(SolutionDir)$(Platform)-Out=
put\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;$(SolutionDir)$(Platform)-Outpu=
t\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;IntDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(Configuration)\&lt;/IntDir&=
gt;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;false&lt;/LinkIncrem=
ental&gt;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;false&lt;/LinkIncremen=
tal&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;Disabled&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(O=
PENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Addition=
alIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;_DEBUG;_CONSOLE;=
$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;MinimalRebuild&gt;true&lt;/MinimalRebuild&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicR=
untimeChecks&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/Runti=
meLibrary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;EditAndContinue&lt;/Deb=
ugInformationFormat&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE&lt;/Un=
definePreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\compat;$(TAP_W=
INDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_=
HOME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE;%(Unde=
finePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.=
lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwp=
uclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&g=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;TargetMachine&gt;MachineX86&lt;/TargetMachine&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;Disabled&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(O=
PENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Addition=
alIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;_DEBUG;_CONSOLE;=
$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicR=
untimeChecks&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/Runti=
meLibrary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE&lt;/Un=
definePreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\compat;$(TAP_W=
INDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_=
HOME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE;%(Unde=
finePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.=
lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwp=
uclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&g=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;MaxSpeed&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(O=
PENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Addition=
alIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;NDEBUG;_CONSOLE;=
$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/RuntimeLib=
rary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;FunctionLevelLinking&gt;true&lt;/FunctionLevelLin=
king&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE&lt;/Un=
definePreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\compat;$(TAP_W=
INDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_=
HOME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE;%(Unde=
finePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.=
lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwp=
uclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&g=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;OptimizeReferences&gt;true&lt;/OptimizeReferences=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;EnableCOMDATFolding&gt;true&lt;/EnableCOMDATFoldi=
ng&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;TargetMachine&gt;MachineX86&lt;/TargetMachine&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;MaxSpeed&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);$(S=
OURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(O=
PENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Addition=
alIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;NDEBUG;_CONSOLE;=
$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/RuntimeLib=
rary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;FunctionLevelLinking&gt;true&lt;/FunctionLevelLin=
king&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE&lt;/Un=
definePreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\compat;$(TAP_W=
INDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_=
HOME)/include;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirector=
ies&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;UndefinePreprocessorDefinitions&gt;UNICODE;%(Unde=
finePreprocessorDefinitions)&lt;/UndefinePreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.=
lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwp=
uclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&g=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalLibraryDirectories&gt;$(OPENSSL_HO=
ME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)=
&lt;/AdditionalLibraryDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;OptimizeReferences&gt;true&lt;/OptimizeReferences=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;EnableCOMDATFolding&gt;true&lt;/EnableCOMDATFoldi=
ng&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxp=
roj.filters<br>
index 4152236d..7a9aa631 100644<br>
--- a/src/openvpn/openvpn.vcxproj.filters<br>
+++ b/src/openvpn/openvpn.vcxproj.filters<br>
@@ -228,6 +228,12 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile Include=3D&quot;tls_crypt.c&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;env_set.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;run_command.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;base64.h&quot;&gt;<br>
@@ -476,6 +482,12 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;tls_crypt.h&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;env_set.h&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClInclude&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;run_command.h&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClInclude&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile Include=3D&quot;openvpn_win32_resou=
rces.rc&quot;&gt;<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpns=
erv.vcxproj<br>
index 4edcf851..74077570 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj<br>
@@ -52,124 +52,66 @@<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Release|Win32&#39;&quot; Label=3D&quot;PropertySheets&=
quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Release.props&quot; /&g=
t;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Release|x64&#39;&quot; Label=3D&quot;PropertySheets&qu=
ot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Release.props&quot; /&g=
t;<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|Win32&#39;&quot; Label=3D&quot;PropertySheets&qu=
ot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Debug.props&quot; /&gt;=
<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;ImportGroup Condition=3D&quot;&#39;$(Configuration)|$(Plat=
form)&#39;=3D=3D&#39;Debug|x64&#39;&quot; Label=3D&quot;PropertySheets&quot=
;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Import Project=3D&quot;$(UserRootDir)\Microsoft.Cpp=
.$(Platform).user.props&quot; Condition=3D&quot;exists(&#39;$(UserRootDir)\=
Microsoft.Cpp.$(Platform).user.props&#39;)&quot; Label=3D&quot;LocalAppData=
Platform&quot; /&gt;<br>
-=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\PropertySheet.props&quo=
t; /&gt;<br>
+=C2=A0 =C2=A0 &lt;Import Project=3D&quot;..\compat\Debug.props&quot; /&gt;=
<br>
=C2=A0 =C2=A0&lt;/ImportGroup&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup Label=3D&quot;UserMacros&quot; /&gt;<br>
=C2=A0 =C2=A0&lt;PropertyGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;_ProjectFileVersion&gt;10.0.30319.1&lt;/_ProjectFil=
eVersion&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(SolutionDir)$(Platform)-Outpu=
t\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;$(SolutionDir)$(Platform)-Output\=
$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;IntDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;$(Configuration)\&lt;/IntDir&gt=
;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;true&lt;/LinkIncrement=
al&gt;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;true&lt;/LinkIncremental=
&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(SolutionDir)$(Platform)-Out=
put\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;OutDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;$(SolutionDir)$(Platform)-Outpu=
t\$(Configuration)\&lt;/OutDir&gt;<br>
-=C2=A0 =C2=A0 &lt;IntDir Condition=3D&quot;&#39;$(Configuration)|$(Platfor=
m)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;$(Configuration)\&lt;/IntDir&=
gt;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;false&lt;/LinkIncrem=
ental&gt;<br>
-=C2=A0 =C2=A0 &lt;LinkIncremental Condition=3D&quot;&#39;$(Configuration)|=
$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;false&lt;/LinkIncremen=
tal&gt;<br>
=C2=A0 =C2=A0&lt;/PropertyGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;Disabled&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);..\=
..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)&lt;/Additio=
nalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;_DEBUG;_CONSOLE;=
$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;MinimalRebuild&gt;true&lt;/MinimalRebuild&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicR=
untimeChecks&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/Runti=
meLibrary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;EditAndContinue&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\openvpn;..\com=
pat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Userenv.lib;Iphlpa=
pi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependen=
cies)&lt;/AdditionalDependencies&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;TargetMachine&gt;MachineX86&lt;/TargetMachine&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Debug|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;Disabled&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);..\=
..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)&lt;/Additio=
nalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;_DEBUG;_CONSOLE;=
$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;BasicRuntimeChecks&gt;EnableFastChecks&lt;/BasicR=
untimeChecks&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDebugDLL&lt;/Runti=
meLibrary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\openvpn;..\com=
pat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shl=
wapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|Win32&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;MaxSpeed&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);..\=
..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)&lt;/Additio=
nalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;WIN32;NDEBUG;_CONSOLE;=
$(CPPFLAGS);%(PreprocessorDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/RuntimeLib=
rary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;FunctionLevelLinking&gt;true&lt;/FunctionLevelLin=
king&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\openvpn;..\com=
pat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;Userenv.lib;Iphlpa=
pi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependen=
cies)&lt;/AdditionalDependencies&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;OptimizeReferences&gt;true&lt;/OptimizeReferences=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;EnableCOMDATFolding&gt;true&lt;/EnableCOMDATFoldi=
ng&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;TargetMachine&gt;MachineX86&lt;/TargetMachine&gt;=
<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemDefinitionGroup Condition=3D&quot;&#39;$(Configuration=
)|$(Platform)&#39;=3D=3D&#39;Release|x64&#39;&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;Optimization&gt;MaxSpeed&lt;/Optimization&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;IntrinsicFunctions&gt;true&lt;/IntrinsicFunctions=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);..\=
..\include;..\openvpn;..\compat;%(AdditionalIncludeDirectories)&lt;/Additio=
nalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;RuntimeLibrary&gt;MultiThreadedDLL&lt;/RuntimeLib=
rary&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;FunctionLevelLinking&gt;true&lt;/FunctionLevelLin=
king&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;/PrecompiledHeader&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;WarningLevel&gt;Level3&lt;/WarningLevel&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;DebugInformationFormat&gt;ProgramDatabase&lt;/Deb=
ugInformationFormat&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;..\openvpn;..\com=
pat;%(AdditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;PreprocessorDefinitions&gt;_CONSOLE;%(Preprocesso=
rDefinitions)&lt;/PreprocessorDefinitions&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ResourceCompile&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;AdditionalIncludeDirectories&gt;$(SOURCEBASE);%(A=
dditionalIncludeDirectories)&lt;/AdditionalIncludeDirectories&gt;<br>
-=C2=A0 =C2=A0 &lt;/ResourceCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ResourceCompile /&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;Link&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;AdditionalDependencies&gt;legacy_stdio_defin=
itions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shl=
wapi.lib;%(AdditionalDependencies)&lt;/AdditionalDependencies&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;GenerateDebugInformation&gt;true&lt;/GenerateDebu=
gInformation&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;SubSystem&gt;Console&lt;/SubSystem&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;OptimizeReferences&gt;true&lt;/OptimizeReferences=
&gt;<br>
-=C2=A0 =C2=A0 =C2=A0 &lt;EnableCOMDATFolding&gt;true&lt;/EnableCOMDATFoldi=
ng&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Link&gt;<br>
=C2=A0 =C2=A0&lt;/ItemDefinitionGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/=
openvpnserv.vcxproj.filters<br>
index 0c89b4f4..3ce9bb24 100644<br>
--- a/src/openvpnserv/openvpnserv.vcxproj.filters<br>
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters<br>
@@ -15,10 +15,22 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;/Filter&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
-=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;openvpnserv.c&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;service.c&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
-=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;service.c&quot;&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;automatic.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;common.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;interactive.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;validate.c&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClCompile&gt;<br>
+=C2=A0 =C2=A0 &lt;ClCompile Include=3D&quot;..\openvpn\block_dns.c&quot;&g=
t;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Source Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClCompile&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
@@ -26,6 +38,12 @@<br>
=C2=A0 =C2=A0 =C2=A0&lt;ClInclude Include=3D&quot;service.h&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;/ClInclude&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;validate.h&quot;&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClInclude&gt;<br>
+=C2=A0 =C2=A0 &lt;ClInclude Include=3D&quot;..\openvpn\block_dns.h&quot;&g=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 &lt;Filter&gt;Header Files&lt;/Filter&gt;<br>
+=C2=A0 =C2=A0 &lt;/ClInclude&gt;<br>
=C2=A0 =C2=A0&lt;/ItemGroup&gt;<br>
=C2=A0 =C2=A0&lt;ItemGroup&gt;<br>
=C2=A0 =C2=A0 =C2=A0&lt;ResourceCompile Include=3D&quot;openvpnserv_resourc=
es.rc&quot;&gt;<br>
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

--000000000000eb1adc0577b5dd2b--

