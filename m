Message-ID: <4F740B02.7080503@...515...>
Date: Thu, 29 Mar 2012 10:10:58 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332575918-3384-5-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] build: msvc: upgrade to Visual
 Studio 2010 + fixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi,

This looks ok, provided we don't need Visual Studio for official
releases anymore (signing the installer, openvpn.exe and tap-driver).
The version I had to use for 2.3-alpha1 and earlier was VS2008. I doubt
James minds either, as he's still using his old Python build system.
When he's ready to move on, the upgrade license costs around $500[1] -
provided that he even wants/needs to build with Visual Studio at that point.

ACK.

Samuli

[1]
<http://searchwindevelopment.techtarget.com/news/1347126/Microsoft-cuts-Vis=
ual-Studio-2008-upgrade-prices-as-VS-2010-looms>


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  .gitignore                                     |    2 +
>  build/msvc/msvc-generate/Makefile.am           |    2 +-
>  build/msvc/msvc-generate/msvc-generate.vcproj  |   74 ---
>  build/msvc/msvc-generate/msvc-generate.vcxproj |   69 +++
>  msvc-build.bat                                 |   27 +-
>  msvc-dev.bat                                   |   19 +-
>  msvc-env.bat                                   |    7 +-
>  openvpn.sln                                    |   90 ++--
>  src/compat/Makefile.am                         |    3 +-
>  src/compat/compat.vcproj                       |  197 ------
>  src/compat/compat.vcxproj                      |   87 +++
>  src/compat/compat.vcxproj.filters              |   42 ++
>  src/openvpn/Makefile.am                        |    3 +-
>  src/openvpn/openvpn.vcproj                     |  777 ------------------=
------
>  src/openvpn/openvpn.vcxproj                    |  261 ++++++++
>  src/openvpn/openvpn.vcxproj.filters            |  458 ++++++++++++++
>  src/openvpnserv/Makefile.am                    |    3 +-
>  src/openvpnserv/openvpnserv.vcproj             |  209 -------
>  src/openvpnserv/openvpnserv.vcxproj            |  112 ++++
>  src/openvpnserv/openvpnserv.vcxproj.filters    |   35 ++
>  20 files changed, 1153 insertions(+), 1324 deletions(-)
>  delete mode 100644 build/msvc/msvc-generate/msvc-generate.vcproj
>  create mode 100644 build/msvc/msvc-generate/msvc-generate.vcxproj
>  delete mode 100644 src/compat/compat.vcproj
>  create mode 100644 src/compat/compat.vcxproj
>  create mode 100644 src/compat/compat.vcxproj.filters
>  delete mode 100644 src/openvpn/openvpn.vcproj
>  create mode 100644 src/openvpn/openvpn.vcxproj
>  create mode 100644 src/openvpn/openvpn.vcxproj.filters
>  delete mode 100644 src/openvpnserv/openvpnserv.vcproj
>  create mode 100644 src/openvpnserv/openvpnserv.vcxproj
>  create mode 100644 src/openvpnserv/openvpnserv.vcxproj.filters
>
> diff --git a/.gitignore b/.gitignore
> index 2f72ed8..60b9433 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -10,6 +10,8 @@
>  *.suo
>  *.ncb
>  *.vcproj.*
> +*.vcxproj.user
> +*.sln.cache
>  *.log
>  Release
>  Debug
> diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-gener=
ate/Makefile.am
> index 035ae22..539fb6c 100644
> --- a/build/msvc/msvc-generate/Makefile.am
> +++ b/build/msvc/msvc-generate/Makefile.am
> @@ -13,6 +13,6 @@ MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in
>
>  dist_noinst_DATA =3D \
> -       msvc-generate.vcproj \
> +       msvc-generate.vcxproj \
>         Makefile.mak \
>         msvc-generate.js
> diff --git a/build/msvc/msvc-generate/msvc-generate.vcproj b/build/msvc/m=
svc-generate/msvc-generate.vcproj
> deleted file mode 100644
> index 3b7dc18..0000000
> --- a/build/msvc/msvc-generate/msvc-generate.vcproj
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> -<VisualStudioProject
> -       ProjectType=3D"Visual C++"
> -       Version=3D"9.00"
> -       Name=3D"msvc-generate"
> -       ProjectGUID=3D"{8598C2C8-34C4-47A1-99B0-7C295A890615}"
> -       RootNamespace=3D"msvc-generate"
> -       Keyword=3D"MakeFileProj"
> -       TargetFrameworkVersion=3D"196613"
> -       >
> -       <Platforms>
> -               <Platform
> -                       Name=3D"Win32"
> -               />
> -       </Platforms>
> -       <ToolFiles>
> -       </ToolFiles>
> -       <Configurations>
> -               <Configuration
> -                       Name=3D"Debug|Win32"
> -                       OutputDirectory=3D"$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"0"
> -                       >
> -                       <Tool
> -                               Name=3D"VCNMakeTool"
> -                               BuildCommandLine=3D"nmake -f Makefile.mak=
 all"
> -                               ReBuildCommandLine=3D"nmake -f Makefile.m=
ak clean all"
> -                               CleanCommandLine=3D"nmake -f Makefile.mak=
 clean"
> -                               Output=3D"config-msvc-version.h"
> -                               PreprocessorDefinitions=3D"WIN32;_DEBUG"
> -                               IncludeSearchPath=3D""
> -                               ForcedIncludes=3D""
> -                               AssemblySearchPath=3D""
> -                               ForcedUsingAssemblies=3D""
> -                               CompileAsManaged=3D""
> -                       />
> -               </Configuration>
> -               <Configuration
> -                       Name=3D"Release|Win32"
> -                       OutputDirectory=3D"$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"0"
> -                       >
> -                       <Tool
> -                               Name=3D"VCNMakeTool"
> -                               BuildCommandLine=3D"nmake -f Makefile.mak=
 all"
> -                               ReBuildCommandLine=3D"nmake -f Makefile.m=
ak clean all"
> -                               CleanCommandLine=3D"nmake -f Makefile.mak=
 clean"
> -                               Output=3D"config-msvc-version.h"
> -                               PreprocessorDefinitions=3D"WIN32;NDEBUG"
> -                               IncludeSearchPath=3D""
> -                               ForcedIncludes=3D""
> -                               AssemblySearchPath=3D""
> -                               ForcedUsingAssemblies=3D""
> -                               CompileAsManaged=3D""
> -                       />
> -               </Configuration>
> -       </Configurations>
> -       <References>
> -       </References>
> -       <Files>
> -               <File
> -                       RelativePath=3D".\Makefile.mak"
> -                       >
> -               </File>
> -               <File
> -                       RelativePath=3D".\msc-generate.js"
> -                       >
> -               </File>
> -       </Files>
> -       <Globals>
> -       </Globals>
> -</VisualStudioProject>
> diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/=
msvc-generate/msvc-generate.vcxproj
> new file mode 100644
> index 0000000..e6491ab
> --- /dev/null
> +++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
> @@ -0,0 +1,69 @@
> +=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project DefaultTargets=3D"Build" ToolsVersion=3D"4.0" xmlns=3D"http://s=
chemas.microsoft.com/developer/msbuild/2003">
> +  <ItemGroup Label=3D"ProjectConfigurations">
> +    <ProjectConfiguration Include=3D"Debug|Win32">
> +      <Configuration>Debug</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +    <ProjectConfiguration Include=3D"Release|Win32">
> +      <Configuration>Release</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +  </ItemGroup>
> +  <PropertyGroup Label=3D"Globals">
> +    <ProjectGuid>{8598C2C8-34C4-47A1-99B0-7C295A890615}</ProjectGuid>
> +    <RootNamespace>msvc-generate</RootNamespace>
> +    <Keyword>MakeFileProj</Keyword>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Relea=
se|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>Makefile</ConfigurationType>
> +  </PropertyGroup>
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>Makefile</ConfigurationType>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> +  <ImportGroup Label=3D"ExtensionSettings">
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <PropertyGroup Label=3D"UserMacros" />
> +  <PropertyGroup>
> +    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(Configuration)\</IntDir>
> +    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
> +    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLi=
ne>
> +    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
> +    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|Win32'">config-msvc-version.h</NMakeOutput>
> +    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platf=
orm)'=3D=3D'Debug|Win32'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMa=
kePreprocessorDefinitions>
> +    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
> +    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Debug|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
> +    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Debug|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
> +    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Debug|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAsse=
mblies>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(Configuration)\</IntDir>
> +    <NMakeBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
> +    <NMakeReBuildCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommand=
Line>
> +    <NMakeCleanCommandLine Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
> +    <NMakeOutput Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Relea=
se|Win32'">config-msvc-version.h</NMakeOutput>
> +    <NMakePreprocessorDefinitions Condition=3D"'$(Configuration)|$(Platf=
orm)'=3D=3D'Release|Win32'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</N=
MakePreprocessorDefinitions>
> +    <NMakeIncludeSearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
> +    <NMakeForcedIncludes Condition=3D"'$(Configuration)|$(Platform)'=3D=
=3D'Release|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
> +    <NMakeAssemblySearchPath Condition=3D"'$(Configuration)|$(Platform)'=
=3D=3D'Release|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
> +    <NMakeForcedUsingAssemblies Condition=3D"'$(Configuration)|$(Platfor=
m)'=3D=3D'Release|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAs=
semblies>
> +  </PropertyGroup>
> +  <ItemDefinitionGroup>
> +  </ItemDefinitionGroup>
> +  <ItemGroup>
> +    <None Include=3D"Makefile.mak" />
> +    <None Include=3D"msc-generate.js" />
> +  </ItemGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
> +  <ImportGroup Label=3D"ExtensionTargets">
> +  </ImportGroup>
> +</Project>
> \ No newline at end of file
> diff --git a/msvc-build.bat b/msvc-build.bat
> index 02a396c..01417d1 100644
> --- a/msvc-build.bat
> +++ b/msvc-build.bat
> @@ -1,23 +1,37 @@
>  @echo off
> -
>  rem Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
>
> -call msvc-env.bat
> -
>  @rem this stupid command needed for SetEnv.cmd to operate
>  setlocal ENABLEDELAYEDEXPANSION
>
> +call msvc-env.bat
> +
>  set PLATFORMS=3DWin32
>  set CONFIGURATIONS=3DRelease
>
> -call "%VCHOME%\bin\vcvars32.bat"
> +if exist "%VCHOME%\vcvarsall.bat" (
> +       call "%VCHOME%\vcvarsall.bat"
> +) else if exist "%VCHOME%\bin\vcvars32.bat" (
> +       call "%VCHOME%\bin\vcvars32.bat"
> +) else (
> +       echo Cannot detect visual studio
> +       goto error
> +)
> +
> +msbuild /help > nul 2>&1
> +if errorlevel 1 set DO_VCBUILD=3D1
>
>  for %%p in (%PLATFORMS%) do (
>         for %%c in (%CONFIGURATIONS%) do (
>                 rmdir /q /s %SOURCEBASE%\%%p\%%c > nul 2>&1
>
> -               vcbuild /errfile:error.log /showenv %SOLUTION% /rebuild /=
platform:%%p "%%c|%%p"
> -               for %%f in (error.log) do if %%~zf GTR 0 goto error
> +               if "%DO_VCBUILD%" NEQ "" (
> +                       vcbuild /errfile:error.log /showenv "%SOLUTION%" =
/rebuild /platform:%%p "%%c|%%p"
> +                       for %%f in (error.log) do if %%~zf GTR 0 goto err=
or
> +               ) else  (
> +                       msbuild "%SOLUTION%" /p:Configuration=3D"%%c" /p:=
Platform=3D"%%p"
> +                       if errorlevel 1 goto error
> +               )
>         )
>  )
>
> @@ -25,7 +39,6 @@ exit /b 0
>  goto end
>
>  :error
> -if "%1" NEQ "batch" pause
>  exit /b 1
>  goto end
>
> diff --git a/msvc-dev.bat b/msvc-dev.bat
> index 671a56d..4dac172 100644
> --- a/msvc-dev.bat
> +++ b/msvc-dev.bat
> @@ -4,6 +4,23 @@ setlocal
>  cd %0\..
>  call msvc-env.bat
>
> -start "" "%VSHOME%\Common7\IDE\devenv.exe" %SOLUTION%
> +if exist "%VSHOME%\Common7\IDE\VCExpress.exe" (
> +       set IDE=3D%VSHOME%\Common7\IDE\VCExpress.exe
> +) else if exist "%VSHOME%\Common7\IDE\devenv.exe" (
> +       set IDE=3D%VSHOME%\Common7\IDE\devenv.exe
> +) else (
> +       echo "Cannot detect visual studio environment"
> +       goto error
> +)
> +start "" "%IDE%" "%SOLUTION%"
> +
> +exit /b 0
> +goto end
> +
> +:error
> +exit /b 1
> +goto end
> +
> +:end
>
>  endlocal
> diff --git a/msvc-env.bat b/msvc-env.bat
> index e37757b..3c9eb5b 100644
> --- a/msvc-env.bat
> +++ b/msvc-env.bat
> @@ -6,9 +6,10 @@ rem Put your own settings at msvc-env-local.bat
>  if exist msvc-env-local.bat call msvc-env-local.bat
>
>  if "%ProgramFiles(x86)%"=3D=3D"" set ProgramFiles(x86)=3D%ProgramFiles%
> -if "%VS90COMNTOOLS%"=3D=3D"" set VS90COMNTOOLS=3D%ProgramFiles(x86)%\Mic=
rosoft Visual Studio 9.0\Common7\Tools\
> -if "%VSHOME%"=3D=3D"" set VSHOME=3D%VS90COMNTOOLS%..\..
> -if "%VCHOME%"=3D=3D"" set VCHOME=3D%VSHOME%\VC
> +if "%VSCOMNTOOLS%"=3D=3D"" SET VSCOMNTOOLS=3D%ProgramFiles(x86)%\Microso=
ft Visual Studio 10.0\Common7\Tools
> +if "%VSCOMNTOOLS%"=3D=3D"" SET VSCOMNTOOLS=3D%ProgramFiles(x86)%\Microso=
ft Visual Studio 9.0\Common7\Tools
> +if "%VSHOME%"=3D=3D"" SET VSHOME=3D%VSCOMNTOOLS%\..\..
> +if "%VCHOME%"=3D=3D"" SET VCHOME=3D%VSHOME%\VC
>
>  set SOURCEBASE=3D%cd%
>  set SOLUTION=3Dopenvpn.sln
> diff --git a/openvpn.sln b/openvpn.sln
> index be35d16..f832e7a 100644
> --- a/openvpn.sln
> +++ b/openvpn.sln
> @@ -1,52 +1,38 @@
> -=EF=BB=BF
> -Microsoft Visual Studio Solution File, Format Version 10.00
> -# Visual Studio 2008
> -Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpnserv", "sr=
c\openvpnserv\openvpnserv.vcproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
> -       ProjectSection(ProjectDependencies) =3D postProject
> -               {8598C2C8-34C4-47A1-99B0-7C295A890615} =3D {8598C2C8-34C4=
-47A1-99B0-7C295A890615}
> -       EndProjectSection
> -EndProject
> -Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpn", "src\op=
envpn\openvpn.vcproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
> -       ProjectSection(ProjectDependencies) =3D postProject
> -               {4B2E2719-E661-45D7-9203-F6F456B22F19} =3D {4B2E2719-E661=
-45D7-9203-F6F456B22F19}
> -               {8598C2C8-34C4-47A1-99B0-7C295A890615} =3D {8598C2C8-34C4=
-47A1-99B0-7C295A890615}
> -       EndProjectSection
> -EndProject
> -Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") =3D "misc", "misc", "{=
1AA03DE8-3F08-45B9-B4ED-D7769A445DF3}"
> -       ProjectSection(SolutionItems) =3D preProject
> -               config-msvc-version.h.in =3D config-msvc-version.h.in
> -               config-msvc.h =3D config-msvc.h
> -               version.m4 =3D version.m4
> -       EndProjectSection
> -EndProject
> -Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "msvc-generate", "=
build\msvc\msvc-generate\msvc-generate.vcproj", "{8598C2C8-34C4-47A1-99B0-7=
C295A890615}"
> -EndProject
> -Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "compat", "src\com=
pat\compat.vcproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
> -EndProject
> -Global
> -       GlobalSection(SolutionConfigurationPlatforms) =3D preSolution
> -               Debug|Win32 =3D Debug|Win32
> -               Release|Win32 =3D Release|Win32
> -       EndGlobalSection
> -       GlobalSection(ProjectConfigurationPlatforms) =3D postSolution
> -               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> -               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.=
0 =3D Debug|Win32
> -               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Acti=
veCfg =3D Release|Win32
> -               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Buil=
d.0 =3D Release|Win32
> -               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> -               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.=
0 =3D Debug|Win32
> -               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Acti=
veCfg =3D Release|Win32
> -               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Buil=
d.0 =3D Release|Win32
> -               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> -               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.=
0 =3D Debug|Win32
> -               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Acti=
veCfg =3D Release|Win32
> -               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Buil=
d.0 =3D Release|Win32
> -               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> -               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.=
0 =3D Debug|Win32
> -               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Acti=
veCfg =3D Release|Win32
> -               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Buil=
d.0 =3D Release|Win32
> -       EndGlobalSection
> -       GlobalSection(SolutionProperties) =3D preSolution
> -               HideSolutionNode =3D FALSE
> -       EndGlobalSection
> -EndGlobal
> +=EF=BB=BF
> +Microsoft Visual Studio Solution File, Format Version 11.00
> +# Visual C++ Express 2010
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpnserv", "sr=
c\openvpnserv\openvpnserv.vcxproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
> +EndProject
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpn", "src\op=
envpn\openvpn.vcxproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
> +EndProject
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "msvc-generate", "=
build\msvc\msvc-generate\msvc-generate.vcxproj", "{8598C2C8-34C4-47A1-99B0-=
7C295A890615}"
> +EndProject
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "compat", "src\com=
pat\compat.vcxproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
> +EndProject
> +Global
> +       GlobalSection(SolutionConfigurationPlatforms) =3D preSolution
> +               Debug|Win32 =3D Debug|Win32
> +               Release|Win32 =3D Release|Win32
> +       EndGlobalSection
> +       GlobalSection(ProjectConfigurationPlatforms) =3D postSolution
> +               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> +               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.=
0 =3D Debug|Win32
> +               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Acti=
veCfg =3D Release|Win32
> +               {9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Buil=
d.0 =3D Release|Win32
> +               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> +               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.=
0 =3D Debug|Win32
> +               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Acti=
veCfg =3D Release|Win32
> +               {29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Buil=
d.0 =3D Release|Win32
> +               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> +               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.=
0 =3D Debug|Win32
> +               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Acti=
veCfg =3D Release|Win32
> +               {8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Buil=
d.0 =3D Release|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.=
0 =3D Debug|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Acti=
veCfg =3D Release|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Buil=
d.0 =3D Release|Win32
> +       EndGlobalSection
> +       GlobalSection(SolutionProperties) =3D preSolution
> +               HideSolutionNode =3D FALSE
> +       EndGlobalSection
> +EndGlobal
> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
> index 91b7f40..5ee35f7 100644
> --- a/src/compat/Makefile.am
> +++ b/src/compat/Makefile.am
> @@ -13,7 +13,8 @@ MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in
>
>  EXTRA_DIST =3D \
> -       compat.vcproj
> +       compat.vcxproj \
> +       compat.vcxproj.filters
>
>  noinst_LTLIBRARIES =3D libcompat.la
>
> diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
> deleted file mode 100644
> index 43fc0c2..0000000
> --- a/src/compat/compat.vcproj
> +++ /dev/null
> @@ -1,197 +0,0 @@
> -<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> -<VisualStudioProject
> -       ProjectType=3D"Visual C++"
> -       Version=3D"9.00"
> -       Name=3D"compat"
> -       ProjectGUID=3D"{4B2E2719-E661-45D7-9203-F6F456B22F19}"
> -       RootNamespace=3D"compat"
> -       Keyword=3D"Win32Proj"
> -       TargetFrameworkVersion=3D"196613"
> -       >
> -       <Platforms>
> -               <Platform
> -                       Name=3D"Win32"
> -               />
> -       </Platforms>
> -       <ToolFiles>
> -       </ToolFiles>
> -       <Configurations>
> -               <Configuration
> -                       Name=3D"Debug|Win32"
> -                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"4"
> -                       CharacterSet=3D"2"
> -                       >
> -                       <Tool
> -                               Name=3D"VCPreBuildEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCustomBuildTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXMLDataGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCWebServiceProxyGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCMIDLTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCLCompilerTool"
> -                               Optimization=3D"0"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PK=
CS11H_HOME)/include"
> -                               PreprocessorDefinitions=3D"WIN32;_DEBUG;_=
LIB;$(CPPFLAGS)"
> -                               MinimalRebuild=3D"true"
> -                               BasicRuntimeChecks=3D"3"
> -                               RuntimeLibrary=3D"3"
> -                               UsePrecompiledHeader=3D"0"
> -                               WarningLevel=3D"3"
> -                               DebugInformationFormat=3D"4"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManagedResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPreLinkEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCLibrarianTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCALinkTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXDCMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCBscMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCFxCopTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPostBuildEventTool"
> -                       />
> -               </Configuration>
> -               <Configuration
> -                       Name=3D"Release|Win32"
> -                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"4"
> -                       CharacterSet=3D"2"
> -                       WholeProgramOptimization=3D"1"
> -                       >
> -                       <Tool
> -                               Name=3D"VCPreBuildEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCustomBuildTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXMLDataGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCWebServiceProxyGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCMIDLTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCLCompilerTool"
> -                               Optimization=3D"2"
> -                               EnableIntrinsicFunctions=3D"true"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PK=
CS11H_HOME)/include"
> -                               PreprocessorDefinitions=3D"WIN32;NDEBUG;_=
LIB;$(CPPFLAGS)"
> -                               RuntimeLibrary=3D"2"
> -                               EnableFunctionLevelLinking=3D"true"
> -                               UsePrecompiledHeader=3D"0"
> -                               WarningLevel=3D"3"
> -                               DebugInformationFormat=3D"3"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManagedResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPreLinkEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCLibrarianTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCALinkTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXDCMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCBscMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCFxCopTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPostBuildEventTool"
> -                       />
> -               </Configuration>
> -       </Configurations>
> -       <References>
> -       </References>
> -       <Files>
> -               <Filter
> -                       Name=3D"Source Files"
> -                       Filter=3D"cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;as=
mx"
> -                       UniqueIdentifier=3D"{4FC737F1-C7A5-4376-A066-2A32=
D752A2FF}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\compat-basename.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\compat-dirname.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\compat-gettimeofday.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\compat-inet_ntop.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\compat-inet_pton.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\compat-daemon.c"
> -                               >
> -                       </File>
> -               </Filter>
> -               <Filter
> -                       Name=3D"Header Files"
> -                       Filter=3D"h;hpp;hxx;hm;inl;inc;xsd"
> -                       UniqueIdentifier=3D"{93995380-89BD-4b04-88EB-625F=
BE52EBFB}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\compat.h"
> -                               >
> -                       </File>
> -               </Filter>
> -               <Filter
> -                       Name=3D"Resource Files"
> -                       Filter=3D"rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;=
jpg;jpeg;jpe;resx;tiff;tif;png;wav"
> -                       UniqueIdentifier=3D"{67DA6AB6-F800-4c08-8B7A-83BB=
121AAD01}"
> -                       >
> -               </Filter>
> -       </Files>
> -       <Globals>
> -       </Globals>
> -</VisualStudioProject>
> diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
> new file mode 100644
> index 0000000..d872fa7
> --- /dev/null
> +++ b/src/compat/compat.vcxproj
> @@ -0,0 +1,87 @@
> +=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project DefaultTargets=3D"Build" ToolsVersion=3D"4.0" xmlns=3D"http://s=
chemas.microsoft.com/developer/msbuild/2003">
> +  <ItemGroup Label=3D"ProjectConfigurations">
> +    <ProjectConfiguration Include=3D"Debug|Win32">
> +      <Configuration>Debug</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +    <ProjectConfiguration Include=3D"Release|Win32">
> +      <Configuration>Release</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +  </ItemGroup>
> +  <PropertyGroup Label=3D"Globals">
> +    <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
> +    <RootNamespace>compat</RootNamespace>
> +    <Keyword>Win32Proj</Keyword>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Relea=
se|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>StaticLibrary</ConfigurationType>
> +    <CharacterSet>MultiByte</CharacterSet>
> +    <WholeProgramOptimization>true</WholeProgramOptimization>
> +  </PropertyGroup>
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>StaticLibrary</ConfigurationType>
> +    <CharacterSet>MultiByte</CharacterSet>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> +  <ImportGroup Label=3D"ExtensionSettings">
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <PropertyGroup Label=3D"UserMacros" />
> +  <PropertyGroup>
> +    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(Configuration)\</IntDir>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(Configuration)\</IntDir>
> +  </PropertyGroup>
> +  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Debug|Win32'">
> +    <ClCompile>
> +      <Optimization>Disabled</Optimization>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;=
$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Addit=
ionalIncludeDirectories)</AdditionalIncludeDirectories>
> +      <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(Preproces=
sorDefinitions)</PreprocessorDefinitions>
> +      <MinimalRebuild>true</MinimalRebuild>
> +      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> +      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> +      <PrecompiledHeader>
> +      </PrecompiledHeader>
> +      <WarningLevel>Level3</WarningLevel>
> +      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Release|Win32'">
> +    <ClCompile>
> +      <Optimization>MaxSpeed</Optimization>
> +      <IntrinsicFunctions>true</IntrinsicFunctions>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;=
$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(Addit=
ionalIncludeDirectories)</AdditionalIncludeDirectories>
> +      <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(Preproces=
sorDefinitions)</PreprocessorDefinitions>
> +      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> +      <FunctionLevelLinking>true</FunctionLevelLinking>
> +      <PrecompiledHeader>
> +      </PrecompiledHeader>
> +      <WarningLevel>Level3</WarningLevel>
> +      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +    </ClCompile>
> +  </ItemDefinitionGroup>
> +  <ItemGroup>
> +    <ClCompile Include=3D"compat-basename.c" />
> +    <ClCompile Include=3D"compat-dirname.c" />
> +    <ClCompile Include=3D"compat-gettimeofday.c" />
> +    <ClCompile Include=3D"compat-inet_ntop.c" />
> +    <ClCompile Include=3D"compat-inet_pton.c" />
> +    <ClCompile Include=3D"compat-daemon.c" />
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClInclude Include=3D"compat.h" />
> +  </ItemGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
> +  <ImportGroup Label=3D"ExtensionTargets">
> +  </ImportGroup>
> +</Project>
> \ No newline at end of file
> diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxpro=
j.filters
> new file mode 100644
> index 0000000..9576c51
> --- /dev/null
> +++ b/src/compat/compat.vcxproj.filters
> @@ -0,0 +1,42 @@
> +=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/deve=
loper/msbuild/2003">
> +  <ItemGroup>
> +    <Filter Include=3D"Source Files">
> +      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueId=
entifier>
> +      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
> +    </Filter>
> +    <Filter Include=3D"Header Files">
> +      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueId=
entifier>
> +      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
> +    </Filter>
> +    <Filter Include=3D"Resource Files">
> +      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueId=
entifier>
> +      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;re=
sx;tiff;tif;png;wav</Extensions>
> +    </Filter>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClCompile Include=3D"compat-basename.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"compat-dirname.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"compat-gettimeofday.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"compat-inet_ntop.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"compat-inet_pton.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"compat-daemon.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClInclude Include=3D"compat.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +  </ItemGroup>
> +</Project>
> \ No newline at end of file
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 1410021..4e485e7 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -15,7 +15,8 @@ MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in
>
>  EXTRA_DIST =3D \
> -       openvpn.vcproj
> +       openvpn.vcxproj \
> +       openvpn.vcxproj.filters
>
>  INCLUDES =3D \
>         -I$(top_srcdir)/include \
> diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
> deleted file mode 100644
> index c1aa8a0..0000000
> --- a/src/openvpn/openvpn.vcproj
> +++ /dev/null
> @@ -1,777 +0,0 @@
> -<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> -<VisualStudioProject
> -       ProjectType=3D"Visual C++"
> -       Version=3D"9.00"
> -       Name=3D"openvpn"
> -       ProjectGUID=3D"{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
> -       RootNamespace=3D"openvpn"
> -       Keyword=3D"Win32Proj"
> -       TargetFrameworkVersion=3D"196613"
> -       >
> -       <Platforms>
> -               <Platform
> -                       Name=3D"Win32"
> -               />
> -       </Platforms>
> -       <ToolFiles>
> -       </ToolFiles>
> -       <Configurations>
> -               <Configuration
> -                       Name=3D"Debug|Win32"
> -                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"1"
> -                       CharacterSet=3D"2"
> -                       >
> -                       <Tool
> -                               Name=3D"VCPreBuildEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCustomBuildTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXMLDataGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCWebServiceProxyGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCMIDLTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCLCompilerTool"
> -                               Optimization=3D"0"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/inc=
lude;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
> -                               PreprocessorDefinitions=3D"WIN32;_DEBUG;_=
CONSOLE;$(CPPFLAGS)"
> -                               MinimalRebuild=3D"true"
> -                               BasicRuntimeChecks=3D"3"
> -                               RuntimeLibrary=3D"3"
> -                               UsePrecompiledHeader=3D"0"
> -                               WarningLevel=3D"3"
> -                               DebugInformationFormat=3D"4"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManagedResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCResourceCompilerTool"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPreLinkEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCLinkerTool"
> -                               AdditionalDependencies=3D"libeay32.lib ss=
leay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib =
crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
> -                               LinkIncremental=3D"2"
> -                               AdditionalLibraryDirectories=3D"$(OPENSSL=
_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
> -                               GenerateDebugInformation=3D"true"
> -                               SubSystem=3D"1"
> -                               TargetMachine=3D"1"
> -                       />
> -                       <Tool
> -                               Name=3D"VCALinkTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManifestTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXDCMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCBscMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCFxCopTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCAppVerifierTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPostBuildEventTool"
> -                       />
> -               </Configuration>
> -               <Configuration
> -                       Name=3D"Release|Win32"
> -                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"1"
> -                       CharacterSet=3D"2"
> -                       WholeProgramOptimization=3D"1"
> -                       >
> -                       <Tool
> -                               Name=3D"VCPreBuildEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCustomBuildTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXMLDataGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCWebServiceProxyGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCMIDLTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCLCompilerTool"
> -                               Optimization=3D"2"
> -                               EnableIntrinsicFunctions=3D"true"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/inc=
lude;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
> -                               PreprocessorDefinitions=3D"WIN32;NDEBUG;_=
CONSOLE;$(CPPFLAGS)"
> -                               RuntimeLibrary=3D"2"
> -                               EnableFunctionLevelLinking=3D"true"
> -                               UsePrecompiledHeader=3D"0"
> -                               WarningLevel=3D"3"
> -                               DebugInformationFormat=3D"3"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManagedResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCResourceCompilerTool"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPreLinkEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCLinkerTool"
> -                               AdditionalDependencies=3D"libeay32.lib ss=
leay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib =
crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
> -                               LinkIncremental=3D"1"
> -                               AdditionalLibraryDirectories=3D"$(OPENSSL=
_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
> -                               GenerateDebugInformation=3D"true"
> -                               SubSystem=3D"1"
> -                               OptimizeReferences=3D"2"
> -                               EnableCOMDATFolding=3D"2"
> -                               TargetMachine=3D"1"
> -                       />
> -                       <Tool
> -                               Name=3D"VCALinkTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManifestTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXDCMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCBscMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCFxCopTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCAppVerifierTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPostBuildEventTool"
> -                       />
> -               </Configuration>
> -       </Configurations>
> -       <References>
> -       </References>
> -       <Files>
> -               <Filter
> -                       Name=3D"Source Files"
> -                       Filter=3D"cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;as=
mx"
> -                       UniqueIdentifier=3D"{4FC737F1-C7A5-4376-A066-2A32=
D752A2FF}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\base64.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\buffer.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\clinat.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\console.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\crypto.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\crypto_openssl.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\cryptoapi.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\dhcp.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\error.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\event.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\fdmisc.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\forward.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\fragment.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\gremlin.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\helper.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\httpdigest.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\init.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\interval.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\list.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\lladdr.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\lzo.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\manage.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mbuf.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\misc.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mroute.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mss.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mstats.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mtcp.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mtu.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mudp.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\multi.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ntlm.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\occ.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\openvpn.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\options.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\otime.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\packet_id.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\perf.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pf.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ping.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pkcs11.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pkcs11_openssl.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\platform.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\plugin.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pool.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\proto.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\proxy.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ps.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\push.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\reliable.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\route.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\schedule.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\session_id.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\shaper.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\sig.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\socket.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\socks.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_openssl.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_verify.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_verify_openssl.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\status.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\tun.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\win32.c"
> -                               >
> -                       </File>
> -               </Filter>
> -               <Filter
> -                       Name=3D"Header Files"
> -                       Filter=3D"h;hpp;hxx;hm;inl;inc;xsd"
> -                       UniqueIdentifier=3D"{93995380-89BD-4b04-88EB-625F=
BE52EBFB}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\base64.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\basic.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\buffer.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\circ_list.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\clinat.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\common.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\console.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\crypto.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\crypto_backend.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\crypto_openssl.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\cryptoapi.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\dhcp.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\errlevel.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\error.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\event.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\fdmisc.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\forward-inline.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\forward.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\fragment.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\gremlin.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\helper.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\httpdigest.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\init.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\integer.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\interval.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\list.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\lladdr.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\lzo.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\manage.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mbuf.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\memdbg.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\misc.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mroute.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mss.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mstats.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mtcp.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mtu.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\mudp.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\multi.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ntlm.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\occ-inline.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\occ.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\openvpn.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\options.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\otime.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\packet_id.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\perf.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pf-inline.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pf.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ping-inline.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ping.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pkcs11.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pkcs11_backend.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\platform.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\plugin.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pool.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\proto.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\proxy.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ps.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\push.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\pushlist.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\reliable.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\route.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\schedule.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\session_id.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\shaper.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\sig.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\socket.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\socks.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_backend.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_common.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_openssl.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_verify.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_verify_backend.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\ssl_verify_openssl.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\status.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\syshead.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\tun.h"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\win32.h"
> -                               >
> -                       </File>
> -               </Filter>
> -               <Filter
> -                       Name=3D"Resource Files"
> -                       Filter=3D"rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;=
jpg;jpeg;jpe;resx;tiff;tif;png;wav"
> -                       UniqueIdentifier=3D"{67DA6AB6-F800-4c08-8B7A-83BB=
121AAD01}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\openvpn_win32_resources=
.rc"
> -                               >
> -                       </File>
> -               </Filter>
> -       </Files>
> -       <Globals>
> -       </Globals>
> -</VisualStudioProject>
> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
> new file mode 100644
> index 0000000..51e19af
> --- /dev/null
> +++ b/src/openvpn/openvpn.vcxproj
> @@ -0,0 +1,261 @@
> +=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project DefaultTargets=3D"Build" ToolsVersion=3D"4.0" xmlns=3D"http://s=
chemas.microsoft.com/developer/msbuild/2003">
> +  <ItemGroup Label=3D"ProjectConfigurations">
> +    <ProjectConfiguration Include=3D"Debug|Win32">
> +      <Configuration>Debug</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +    <ProjectConfiguration Include=3D"Release|Win32">
> +      <Configuration>Release</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +  </ItemGroup>
> +  <PropertyGroup Label=3D"Globals">
> +    <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
> +    <RootNamespace>openvpn</RootNamespace>
> +    <Keyword>Win32Proj</Keyword>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Relea=
se|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>Application</ConfigurationType>
> +    <CharacterSet>MultiByte</CharacterSet>
> +    <WholeProgramOptimization>true</WholeProgramOptimization>
> +  </PropertyGroup>
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>Application</ConfigurationType>
> +    <CharacterSet>MultiByte</CharacterSet>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> +  <ImportGroup Label=3D"ExtensionSettings">
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <PropertyGroup Label=3D"UserMacros" />
> +  <PropertyGroup>
> +    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(Configuration)\</IntDir>
> +    <LinkIncremental Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">true</LinkIncremental>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(Configuration)\</IntDir>
> +    <LinkIncremental Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">false</LinkIncremental>
> +  </PropertyGroup>
> +  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Debug|Win32'">
> +    <ClCompile>
> +      <Optimization>Disabled</Optimization>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/comp=
at;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/includ=
e;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> +      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(Prepr=
ocessorDefinitions)</PreprocessorDefinitions>
> +      <MinimalRebuild>true</MinimalRebuild>
> +      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> +      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> +      <PrecompiledHeader>
> +      </PrecompiledHeader>
> +      <WarningLevel>Level3</WarningLevel>
> +      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> +    </ClCompile>
> +    <ResourceCompile>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +    </ResourceCompile>
> +    <Link>
> +      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
> +      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirec=
tories>
> +      <GenerateDebugInformation>true</GenerateDebugInformation>
> +      <SubSystem>Console</SubSystem>
> +      <TargetMachine>MachineX86</TargetMachine>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Release|Win32'">
> +    <ClCompile>
> +      <Optimization>MaxSpeed</Optimization>
> +      <IntrinsicFunctions>true</IntrinsicFunctions>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/comp=
at;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/includ=
e;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectorie=
s)</AdditionalIncludeDirectories>
> +      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(Prepr=
ocessorDefinitions)</PreprocessorDefinitions>
> +      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> +      <FunctionLevelLinking>true</FunctionLevelLinking>
> +      <PrecompiledHeader>
> +      </PrecompiledHeader>
> +      <WarningLevel>Level3</WarningLevel>
> +      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +    </ClCompile>
> +    <ResourceCompile>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +    </ResourceCompile>
> +    <Link>
> +      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-=
helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;wi=
nmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
> +      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;=
$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirec=
tories>
> +      <GenerateDebugInformation>true</GenerateDebugInformation>
> +      <SubSystem>Console</SubSystem>
> +      <OptimizeReferences>true</OptimizeReferences>
> +      <EnableCOMDATFolding>true</EnableCOMDATFolding>
> +      <TargetMachine>MachineX86</TargetMachine>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemGroup>
> +    <ClCompile Include=3D"base64.c" />
> +    <ClCompile Include=3D"buffer.c" />
> +    <ClCompile Include=3D"clinat.c" />
> +    <ClCompile Include=3D"console.c" />
> +    <ClCompile Include=3D"crypto.c" />
> +    <ClCompile Include=3D"crypto_openssl.c" />
> +    <ClCompile Include=3D"cryptoapi.c" />
> +    <ClCompile Include=3D"dhcp.c" />
> +    <ClCompile Include=3D"error.c" />
> +    <ClCompile Include=3D"event.c" />
> +    <ClCompile Include=3D"fdmisc.c" />
> +    <ClCompile Include=3D"forward.c" />
> +    <ClCompile Include=3D"fragment.c" />
> +    <ClCompile Include=3D"gremlin.c" />
> +    <ClCompile Include=3D"helper.c" />
> +    <ClCompile Include=3D"httpdigest.c" />
> +    <ClCompile Include=3D"init.c" />
> +    <ClCompile Include=3D"interval.c" />
> +    <ClCompile Include=3D"list.c" />
> +    <ClCompile Include=3D"lladdr.c" />
> +    <ClCompile Include=3D"lzo.c" />
> +    <ClCompile Include=3D"manage.c" />
> +    <ClCompile Include=3D"mbuf.c" />
> +    <ClCompile Include=3D"misc.c" />
> +    <ClCompile Include=3D"mroute.c" />
> +    <ClCompile Include=3D"mss.c" />
> +    <ClCompile Include=3D"mstats.c" />
> +    <ClCompile Include=3D"mtcp.c" />
> +    <ClCompile Include=3D"mtu.c" />
> +    <ClCompile Include=3D"mudp.c" />
> +    <ClCompile Include=3D"multi.c" />
> +    <ClCompile Include=3D"ntlm.c" />
> +    <ClCompile Include=3D"occ.c" />
> +    <ClCompile Include=3D"openvpn.c" />
> +    <ClCompile Include=3D"options.c" />
> +    <ClCompile Include=3D"otime.c" />
> +    <ClCompile Include=3D"packet_id.c" />
> +    <ClCompile Include=3D"perf.c" />
> +    <ClCompile Include=3D"pf.c" />
> +    <ClCompile Include=3D"ping.c" />
> +    <ClCompile Include=3D"pkcs11.c" />
> +    <ClCompile Include=3D"pkcs11_openssl.c" />
> +    <ClCompile Include=3D"platform.c" />
> +    <ClCompile Include=3D"plugin.c" />
> +    <ClCompile Include=3D"pool.c" />
> +    <ClCompile Include=3D"proto.c" />
> +    <ClCompile Include=3D"proxy.c" />
> +    <ClCompile Include=3D"ps.c" />
> +    <ClCompile Include=3D"push.c" />
> +    <ClCompile Include=3D"reliable.c" />
> +    <ClCompile Include=3D"route.c" />
> +    <ClCompile Include=3D"schedule.c" />
> +    <ClCompile Include=3D"session_id.c" />
> +    <ClCompile Include=3D"shaper.c" />
> +    <ClCompile Include=3D"sig.c" />
> +    <ClCompile Include=3D"socket.c" />
> +    <ClCompile Include=3D"socks.c" />
> +    <ClCompile Include=3D"ssl.c" />
> +    <ClCompile Include=3D"ssl_openssl.c" />
> +    <ClCompile Include=3D"ssl_verify.c" />
> +    <ClCompile Include=3D"ssl_verify_openssl.c" />
> +    <ClCompile Include=3D"status.c" />
> +    <ClCompile Include=3D"tun.c" />
> +    <ClCompile Include=3D"win32.c" />
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClInclude Include=3D"base64.h" />
> +    <ClInclude Include=3D"basic.h" />
> +    <ClInclude Include=3D"buffer.h" />
> +    <ClInclude Include=3D"circ_list.h" />
> +    <ClInclude Include=3D"clinat.h" />
> +    <ClInclude Include=3D"common.h" />
> +    <ClInclude Include=3D"console.h" />
> +    <ClInclude Include=3D"crypto.h" />
> +    <ClInclude Include=3D"crypto_backend.h" />
> +    <ClInclude Include=3D"crypto_openssl.h" />
> +    <ClInclude Include=3D"cryptoapi.h" />
> +    <ClInclude Include=3D"dhcp.h" />
> +    <ClInclude Include=3D"errlevel.h" />
> +    <ClInclude Include=3D"error.h" />
> +    <ClInclude Include=3D"event.h" />
> +    <ClInclude Include=3D"fdmisc.h" />
> +    <ClInclude Include=3D"forward-inline.h" />
> +    <ClInclude Include=3D"forward.h" />
> +    <ClInclude Include=3D"fragment.h" />
> +    <ClInclude Include=3D"gremlin.h" />
> +    <ClInclude Include=3D"helper.h" />
> +    <ClInclude Include=3D"httpdigest.h" />
> +    <ClInclude Include=3D"init.h" />
> +    <ClInclude Include=3D"integer.h" />
> +    <ClInclude Include=3D"interval.h" />
> +    <ClInclude Include=3D"list.h" />
> +    <ClInclude Include=3D"lladdr.h" />
> +    <ClInclude Include=3D"lzo.h" />
> +    <ClInclude Include=3D"manage.h" />
> +    <ClInclude Include=3D"mbuf.h" />
> +    <ClInclude Include=3D"memdbg.h" />
> +    <ClInclude Include=3D"misc.h" />
> +    <ClInclude Include=3D"mroute.h" />
> +    <ClInclude Include=3D"mss.h" />
> +    <ClInclude Include=3D"mstats.h" />
> +    <ClInclude Include=3D"mtcp.h" />
> +    <ClInclude Include=3D"mtu.h" />
> +    <ClInclude Include=3D"mudp.h" />
> +    <ClInclude Include=3D"multi.h" />
> +    <ClInclude Include=3D"ntlm.h" />
> +    <ClInclude Include=3D"occ-inline.h" />
> +    <ClInclude Include=3D"occ.h" />
> +    <ClInclude Include=3D"openvpn.h" />
> +    <ClInclude Include=3D"options.h" />
> +    <ClInclude Include=3D"otime.h" />
> +    <ClInclude Include=3D"packet_id.h" />
> +    <ClInclude Include=3D"perf.h" />
> +    <ClInclude Include=3D"pf-inline.h" />
> +    <ClInclude Include=3D"pf.h" />
> +    <ClInclude Include=3D"ping-inline.h" />
> +    <ClInclude Include=3D"ping.h" />
> +    <ClInclude Include=3D"pkcs11.h" />
> +    <ClInclude Include=3D"pkcs11_backend.h" />
> +    <ClInclude Include=3D"platform.h" />
> +    <ClInclude Include=3D"plugin.h" />
> +    <ClInclude Include=3D"pool.h" />
> +    <ClInclude Include=3D"proto.h" />
> +    <ClInclude Include=3D"proxy.h" />
> +    <ClInclude Include=3D"ps.h" />
> +    <ClInclude Include=3D"push.h" />
> +    <ClInclude Include=3D"pushlist.h" />
> +    <ClInclude Include=3D"reliable.h" />
> +    <ClInclude Include=3D"route.h" />
> +    <ClInclude Include=3D"schedule.h" />
> +    <ClInclude Include=3D"session_id.h" />
> +    <ClInclude Include=3D"shaper.h" />
> +    <ClInclude Include=3D"sig.h" />
> +    <ClInclude Include=3D"socket.h" />
> +    <ClInclude Include=3D"socks.h" />
> +    <ClInclude Include=3D"ssl.h" />
> +    <ClInclude Include=3D"ssl_backend.h" />
> +    <ClInclude Include=3D"ssl_common.h" />
> +    <ClInclude Include=3D"ssl_openssl.h" />
> +    <ClInclude Include=3D"ssl_verify.h" />
> +    <ClInclude Include=3D"ssl_verify_backend.h" />
> +    <ClInclude Include=3D"ssl_verify_openssl.h" />
> +    <ClInclude Include=3D"status.h" />
> +    <ClInclude Include=3D"syshead.h" />
> +    <ClInclude Include=3D"tun.h" />
> +    <ClInclude Include=3D"win32.h" />
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ResourceCompile Include=3D"openvpn_win32_resources.rc" />
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ProjectReference Include=3D"..\..\build\msvc\msvc-generate\msvc-gen=
erate.vcxproj">
> +      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
> +      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
> +    </ProjectReference>
> +    <ProjectReference Include=3D"..\compat\compat.vcxproj">
> +      <Project>{4b2e2719-e661-45d7-9203-f6f456b22f19}</Project>
> +      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
> +    </ProjectReference>
> +  </ItemGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
> +  <ImportGroup Label=3D"ExtensionTargets">
> +  </ImportGroup>
> +</Project>
> \ No newline at end of file
> diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vc=
xproj.filters
> new file mode 100644
> index 0000000..ec5e676
> --- /dev/null
> +++ b/src/openvpn/openvpn.vcxproj.filters
> @@ -0,0 +1,458 @@
> +=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/deve=
loper/msbuild/2003">
> +  <ItemGroup>
> +    <Filter Include=3D"Source Files">
> +      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueId=
entifier>
> +      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
> +    </Filter>
> +    <Filter Include=3D"Header Files">
> +      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueId=
entifier>
> +      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
> +    </Filter>
> +    <Filter Include=3D"Resource Files">
> +      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueId=
entifier>
> +      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;re=
sx;tiff;tif;png;wav</Extensions>
> +    </Filter>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClCompile Include=3D"base64.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"buffer.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"clinat.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"console.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"crypto.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"crypto_openssl.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"cryptoapi.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"dhcp.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"error.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"event.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"fdmisc.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"forward.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"fragment.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"gremlin.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"helper.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"httpdigest.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"init.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"interval.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"list.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"lladdr.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"lzo.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"manage.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"mbuf.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"misc.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"mroute.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"mss.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"mstats.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"mtcp.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"mtu.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"mudp.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"multi.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"ntlm.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"occ.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"openvpn.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"options.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"otime.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"packet_id.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"perf.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"pf.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"ping.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"pkcs11.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"pkcs11_openssl.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"platform.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"plugin.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"pool.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"proto.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"proxy.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"ps.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"push.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"reliable.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"route.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"schedule.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"session_id.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"shaper.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"sig.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"socket.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"socks.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"ssl.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"ssl_openssl.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"ssl_verify.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"ssl_verify_openssl.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"status.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"tun.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"win32.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClInclude Include=3D"base64.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"basic.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"buffer.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"circ_list.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"clinat.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"common.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"console.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"crypto.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"crypto_backend.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"crypto_openssl.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"cryptoapi.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"dhcp.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"errlevel.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"error.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"event.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"fdmisc.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"forward-inline.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"forward.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"fragment.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"gremlin.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"helper.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"httpdigest.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"init.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"integer.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"interval.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"list.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"lladdr.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"lzo.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"manage.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"mbuf.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"memdbg.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"misc.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"mroute.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"mss.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"mstats.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"mtcp.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"mtu.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"mudp.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"multi.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ntlm.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"occ-inline.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"occ.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"openvpn.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"options.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"otime.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"packet_id.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"perf.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"pf-inline.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"pf.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ping-inline.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ping.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"pkcs11.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"pkcs11_backend.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"platform.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"plugin.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"pool.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"proto.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"proxy.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ps.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"push.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"pushlist.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"reliable.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"route.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"schedule.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"session_id.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"shaper.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"sig.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"socket.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"socks.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ssl.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ssl_backend.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ssl_common.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ssl_openssl.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ssl_verify.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ssl_verify_backend.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"ssl_verify_openssl.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"status.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"syshead.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"tun.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +    <ClInclude Include=3D"win32.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ResourceCompile Include=3D"openvpn_win32_resources.rc">
> +      <Filter>Resource Files</Filter>
> +    </ResourceCompile>
> +  </ItemGroup>
> +</Project>
> \ No newline at end of file
> diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
> index 8584b06..a989c25 100644
> --- a/src/openvpnserv/Makefile.am
> +++ b/src/openvpnserv/Makefile.am
> @@ -14,7 +14,8 @@ include $(top_srcdir)/build/ltrc.inc
>  MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in
>
>  EXTRA_DIST =3D \
> -       openvpnserv.vcproj
> +       openvpnserv.vcxproj \
> +       openvpnserv.vcxproj.filters
>
>  if WIN32
>  sbin_PROGRAMS =3D openvpnserv
> diff --git a/src/openvpnserv/openvpnserv.vcproj b/src/openvpnserv/openvpn=
serv.vcproj
> deleted file mode 100644
> index 4c55561..0000000
> --- a/src/openvpnserv/openvpnserv.vcproj
> +++ /dev/null
> @@ -1,209 +0,0 @@
> -<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> -<VisualStudioProject
> -       ProjectType=3D"Visual C++"
> -       Version=3D"9.00"
> -       Name=3D"openvpnserv"
> -       ProjectGUID=3D"{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
> -       RootNamespace=3D"openvpnserv"
> -       Keyword=3D"Win32Proj"
> -       TargetFrameworkVersion=3D"196613"
> -       >
> -       <Platforms>
> -               <Platform
> -                       Name=3D"Win32"
> -               />
> -       </Platforms>
> -       <ToolFiles>
> -       </ToolFiles>
> -       <Configurations>
> -               <Configuration
> -                       Name=3D"Debug|Win32"
> -                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"1"
> -                       CharacterSet=3D"2"
> -                       >
> -                       <Tool
> -                               Name=3D"VCPreBuildEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCustomBuildTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXMLDataGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCWebServiceProxyGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCMIDLTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCLCompilerTool"
> -                               Optimization=3D"0"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> -                               PreprocessorDefinitions=3D"WIN32;_DEBUG;_=
CONSOLE;$(CPPFLAGS)"
> -                               MinimalRebuild=3D"true"
> -                               BasicRuntimeChecks=3D"3"
> -                               RuntimeLibrary=3D"3"
> -                               UsePrecompiledHeader=3D"0"
> -                               WarningLevel=3D"3"
> -                               DebugInformationFormat=3D"4"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManagedResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCResourceCompilerTool"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPreLinkEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCLinkerTool"
> -                               LinkIncremental=3D"2"
> -                               GenerateDebugInformation=3D"true"
> -                               SubSystem=3D"1"
> -                               TargetMachine=3D"1"
> -                       />
> -                       <Tool
> -                               Name=3D"VCALinkTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManifestTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXDCMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCBscMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCFxCopTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCAppVerifierTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPostBuildEventTool"
> -                       />
> -               </Configuration>
> -               <Configuration
> -                       Name=3D"Release|Win32"
> -                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> -                       IntermediateDirectory=3D"$(ConfigurationName)"
> -                       ConfigurationType=3D"1"
> -                       CharacterSet=3D"2"
> -                       WholeProgramOptimization=3D"1"
> -                       >
> -                       <Tool
> -                               Name=3D"VCPreBuildEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCustomBuildTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXMLDataGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCWebServiceProxyGeneratorTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCMIDLTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCCLCompilerTool"
> -                               Optimization=3D"2"
> -                               EnableIntrinsicFunctions=3D"true"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> -                               PreprocessorDefinitions=3D"WIN32;NDEBUG;_=
CONSOLE;$(CPPFLAGS)"
> -                               RuntimeLibrary=3D"2"
> -                               EnableFunctionLevelLinking=3D"true"
> -                               UsePrecompiledHeader=3D"0"
> -                               WarningLevel=3D"3"
> -                               DebugInformationFormat=3D"3"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManagedResourceCompilerTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCResourceCompilerTool"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPreLinkEventTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCLinkerTool"
> -                               LinkIncremental=3D"1"
> -                               GenerateDebugInformation=3D"true"
> -                               SubSystem=3D"1"
> -                               OptimizeReferences=3D"2"
> -                               EnableCOMDATFolding=3D"2"
> -                               TargetMachine=3D"1"
> -                       />
> -                       <Tool
> -                               Name=3D"VCALinkTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCManifestTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCXDCMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCBscMakeTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCFxCopTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCAppVerifierTool"
> -                       />
> -                       <Tool
> -                               Name=3D"VCPostBuildEventTool"
> -                       />
> -               </Configuration>
> -       </Configurations>
> -       <References>
> -       </References>
> -       <Files>
> -               <Filter
> -                       Name=3D"Source Files"
> -                       Filter=3D"cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;as=
mx"
> -                       UniqueIdentifier=3D"{4FC737F1-C7A5-4376-A066-2A32=
D752A2FF}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\openvpnserv.c"
> -                               >
> -                       </File>
> -                       <File
> -                               RelativePath=3D".\service.c"
> -                               >
> -                       </File>
> -               </Filter>
> -               <Filter
> -                       Name=3D"Header Files"
> -                       Filter=3D"h;hpp;hxx;hm;inl;inc;xsd"
> -                       UniqueIdentifier=3D"{93995380-89BD-4b04-88EB-625F=
BE52EBFB}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\service.h"
> -                               >
> -                       </File>
> -               </Filter>
> -               <Filter
> -                       Name=3D"Resource Files"
> -                       Filter=3D"rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;=
jpg;jpeg;jpe;resx;tiff;tif;png;wav"
> -                       UniqueIdentifier=3D"{67DA6AB6-F800-4c08-8B7A-83BB=
121AAD01}"
> -                       >
> -                       <File
> -                               RelativePath=3D".\openvpnserv_resources.r=
c"
> -                               >
> -                       </File>
> -               </Filter>
> -       </Files>
> -       <Globals>
> -       </Globals>
> -</VisualStudioProject>
> diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvp=
nserv.vcxproj
> new file mode 100644
> index 0000000..f2c0071
> --- /dev/null
> +++ b/src/openvpnserv/openvpnserv.vcxproj
> @@ -0,0 +1,112 @@
> +=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project DefaultTargets=3D"Build" ToolsVersion=3D"4.0" xmlns=3D"http://s=
chemas.microsoft.com/developer/msbuild/2003">
> +  <ItemGroup Label=3D"ProjectConfigurations">
> +    <ProjectConfiguration Include=3D"Debug|Win32">
> +      <Configuration>Debug</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +    <ProjectConfiguration Include=3D"Release|Win32">
> +      <Configuration>Release</Configuration>
> +      <Platform>Win32</Platform>
> +    </ProjectConfiguration>
> +  </ItemGroup>
> +  <PropertyGroup Label=3D"Globals">
> +    <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
> +    <RootNamespace>openvpnserv</RootNamespace>
> +    <Keyword>Win32Proj</Keyword>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Relea=
se|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>Application</ConfigurationType>
> +    <CharacterSet>MultiByte</CharacterSet>
> +    <WholeProgramOptimization>true</WholeProgramOptimization>
> +  </PropertyGroup>
> +  <PropertyGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug=
|Win32'" Label=3D"Configuration">
> +    <ConfigurationType>Application</ConfigurationType>
> +    <CharacterSet>MultiByte</CharacterSet>
> +  </PropertyGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.props" />
> +  <ImportGroup Label=3D"ExtensionSettings">
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release=
|Win32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <ImportGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|W=
in32'" Label=3D"PropertySheets">
> +    <Import Project=3D"$(UserRootDir)\Microsoft.Cpp.$(Platform).user.pro=
ps" Condition=3D"exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.prop=
s')" Label=3D"LocalAppDataPlatform" />
> +  </ImportGroup>
> +  <PropertyGroup Label=3D"UserMacros" />
> +  <PropertyGroup>
> +    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Debug|Win3=
2'">$(Configuration)\</IntDir>
> +    <LinkIncremental Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'D=
ebug|Win32'">true</LinkIncremental>
> +    <OutDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
> +    <IntDir Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'Release|Wi=
n32'">$(Configuration)\</IntDir>
> +    <LinkIncremental Condition=3D"'$(Configuration)|$(Platform)'=3D=3D'R=
elease|Win32'">false</LinkIncremental>
> +  </PropertyGroup>
> +  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Debug|Win32'">
> +    <ClCompile>
> +      <Optimization>Disabled</Optimization>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(Prepr=
ocessorDefinitions)</PreprocessorDefinitions>
> +      <MinimalRebuild>true</MinimalRebuild>
> +      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
> +      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
> +      <PrecompiledHeader>
> +      </PrecompiledHeader>
> +      <WarningLevel>Level3</WarningLevel>
> +      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
> +    </ClCompile>
> +    <ResourceCompile>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +    </ResourceCompile>
> +    <Link>
> +      <GenerateDebugInformation>true</GenerateDebugInformation>
> +      <SubSystem>Console</SubSystem>
> +      <TargetMachine>MachineX86</TargetMachine>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemDefinitionGroup Condition=3D"'$(Configuration)|$(Platform)'=3D=3D=
'Release|Win32'">
> +    <ClCompile>
> +      <Optimization>MaxSpeed</Optimization>
> +      <IntrinsicFunctions>true</IntrinsicFunctions>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(Prepr=
ocessorDefinitions)</PreprocessorDefinitions>
> +      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
> +      <FunctionLevelLinking>true</FunctionLevelLinking>
> +      <PrecompiledHeader>
> +      </PrecompiledHeader>
> +      <WarningLevel>Level3</WarningLevel>
> +      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
> +    </ClCompile>
> +    <ResourceCompile>
> +      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDir=
ectories)</AdditionalIncludeDirectories>
> +    </ResourceCompile>
> +    <Link>
> +      <GenerateDebugInformation>true</GenerateDebugInformation>
> +      <SubSystem>Console</SubSystem>
> +      <OptimizeReferences>true</OptimizeReferences>
> +      <EnableCOMDATFolding>true</EnableCOMDATFolding>
> +      <TargetMachine>MachineX86</TargetMachine>
> +    </Link>
> +  </ItemDefinitionGroup>
> +  <ItemGroup>
> +    <ClCompile Include=3D"openvpnserv.c" />
> +    <ClCompile Include=3D"service.c" />
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClInclude Include=3D"service.h" />
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ResourceCompile Include=3D"openvpnserv_resources.rc" />
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ProjectReference Include=3D"..\..\build\msvc\msvc-generate\msvc-gen=
erate.vcxproj">
> +      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
> +      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
> +    </ProjectReference>
> +  </ItemGroup>
> +  <Import Project=3D"$(VCTargetsPath)\Microsoft.Cpp.targets" />
> +  <ImportGroup Label=3D"ExtensionTargets">
> +  </ImportGroup>
> +</Project>
> \ No newline at end of file
> diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnser=
v/openvpnserv.vcxproj.filters
> new file mode 100644
> index 0000000..a6f8ecc
> --- /dev/null
> +++ b/src/openvpnserv/openvpnserv.vcxproj.filters
> @@ -0,0 +1,35 @@
> +=EF=BB=BF<?xml version=3D"1.0" encoding=3D"utf-8"?>
> +<Project ToolsVersion=3D"4.0" xmlns=3D"http://schemas.microsoft.com/deve=
loper/msbuild/2003">
> +  <ItemGroup>
> +    <Filter Include=3D"Source Files">
> +      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueId=
entifier>
> +      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
> +    </Filter>
> +    <Filter Include=3D"Header Files">
> +      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueId=
entifier>
> +      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
> +    </Filter>
> +    <Filter Include=3D"Resource Files">
> +      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueId=
entifier>
> +      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;re=
sx;tiff;tif;png;wav</Extensions>
> +    </Filter>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClCompile Include=3D"openvpnserv.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +    <ClCompile Include=3D"service.c">
> +      <Filter>Source Files</Filter>
> +    </ClCompile>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ClInclude Include=3D"service.h">
> +      <Filter>Header Files</Filter>
> +    </ClInclude>
> +  </ItemGroup>
> +  <ItemGroup>
> +    <ResourceCompile Include=3D"openvpnserv_resources.rc">
> +      <Filter>Resource Files</Filter>
> +    </ResourceCompile>
> +  </ItemGroup>
> +</Project>
> \ No newline at end of file
> --
> 1.7.3.4
>
>
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



