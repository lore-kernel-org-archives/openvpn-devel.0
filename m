From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 09:58:36 +0200
Message-Id: <1332575918-3384-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <4F6D06C5.3030408@...1114...>
References: <4F6D06C5.3030408@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH_4/6=5D_build=3A_msvc=3A_upgrad?=
	=?utf-8?q?e_to_Visual_Studio_2010_+_fixups?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore                                     |    2 +
 build/msvc/msvc-generate/Makefile.am           |    2 +-
 build/msvc/msvc-generate/msvc-generate.vcproj  |   74 ---
 build/msvc/msvc-generate/msvc-generate.vcxproj |   69 +++
 msvc-build.bat                                 |   27 +-
 msvc-dev.bat                                   |   19 +-
 msvc-env.bat                                   |    7 +-
 openvpn.sln                                    |   90 ++--
 src/compat/Makefile.am                         |    3 +-
 src/compat/compat.vcproj                       |  197 ------
 src/compat/compat.vcxproj                      |   87 +++
 src/compat/compat.vcxproj.filters              |   42 ++
 src/openvpn/Makefile.am                        |    3 +-
 src/openvpn/openvpn.vcproj                     |  777 ------------------------
 src/openvpn/openvpn.vcxproj                    |  261 ++++++++
 src/openvpn/openvpn.vcxproj.filters            |  458 ++++++++++++++
 src/openvpnserv/Makefile.am                    |    3 +-
 src/openvpnserv/openvpnserv.vcproj             |  209 -------
 src/openvpnserv/openvpnserv.vcxproj            |  112 ++++
 src/openvpnserv/openvpnserv.vcxproj.filters    |   35 ++
 20 files changed, 1153 insertions(+), 1324 deletions(-)
 delete mode 100644 build/msvc/msvc-generate/msvc-generate.vcproj
 create mode 100644 build/msvc/msvc-generate/msvc-generate.vcxproj
 delete mode 100644 src/compat/compat.vcproj
 create mode 100644 src/compat/compat.vcxproj
 create mode 100644 src/compat/compat.vcxproj.filters
 delete mode 100644 src/openvpn/openvpn.vcproj
 create mode 100644 src/openvpn/openvpn.vcxproj
 create mode 100644 src/openvpn/openvpn.vcxproj.filters
 delete mode 100644 src/openvpnserv/openvpnserv.vcproj
 create mode 100644 src/openvpnserv/openvpnserv.vcxproj
 create mode 100644 src/openvpnserv/openvpnserv.vcxproj.filters

diff --git a/.gitignore b/.gitignore
index 2f72ed8..60b9433 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,8 @@
 *.suo
 *.ncb
 *.vcproj.*
+*.vcxproj.user
+*.sln.cache
 *.log
 Release
 Debug
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
index 035ae22..539fb6c 100644
--- a/build/msvc/msvc-generate/Makefile.am
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -13,6 +13,6 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 dist_noinst_DATA = \
-	msvc-generate.vcproj \
+	msvc-generate.vcxproj \
 	Makefile.mak \
 	msvc-generate.js
diff --git a/build/msvc/msvc-generate/msvc-generate.vcproj b/build/msvc/msvc-generate/msvc-generate.vcproj
deleted file mode 100644
index 3b7dc18..0000000
--- a/build/msvc/msvc-generate/msvc-generate.vcproj
+++ /dev/null
@@ -1,74 +0,0 @@
-<?xml version="1.0" encoding="Windows-1252"?>
-<VisualStudioProject
-	ProjectType="Visual C++"
-	Version="9.00"
-	Name="msvc-generate"
-	ProjectGUID="{8598C2C8-34C4-47A1-99B0-7C295A890615}"
-	RootNamespace="msvc-generate"
-	Keyword="MakeFileProj"
-	TargetFrameworkVersion="196613"
-	>
-	<Platforms>
-		<Platform
-			Name="Win32"
-		/>
-	</Platforms>
-	<ToolFiles>
-	</ToolFiles>
-	<Configurations>
-		<Configuration
-			Name="Debug|Win32"
-			OutputDirectory="$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="0"
-			>
-			<Tool
-				Name="VCNMakeTool"
-				BuildCommandLine="nmake -f Makefile.mak all"
-				ReBuildCommandLine="nmake -f Makefile.mak clean all"
-				CleanCommandLine="nmake -f Makefile.mak clean"
-				Output="config-msvc-version.h"
-				PreprocessorDefinitions="WIN32;_DEBUG"
-				IncludeSearchPath=""
-				ForcedIncludes=""
-				AssemblySearchPath=""
-				ForcedUsingAssemblies=""
-				CompileAsManaged=""
-			/>
-		</Configuration>
-		<Configuration
-			Name="Release|Win32"
-			OutputDirectory="$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="0"
-			>
-			<Tool
-				Name="VCNMakeTool"
-				BuildCommandLine="nmake -f Makefile.mak all"
-				ReBuildCommandLine="nmake -f Makefile.mak clean all"
-				CleanCommandLine="nmake -f Makefile.mak clean"
-				Output="config-msvc-version.h"
-				PreprocessorDefinitions="WIN32;NDEBUG"
-				IncludeSearchPath=""
-				ForcedIncludes=""
-				AssemblySearchPath=""
-				ForcedUsingAssemblies=""
-				CompileAsManaged=""
-			/>
-		</Configuration>
-	</Configurations>
-	<References>
-	</References>
-	<Files>
-		<File
-			RelativePath=".\Makefile.mak"
-			>
-		</File>
-		<File
-			RelativePath=".\msc-generate.js"
-			>
-		</File>
-	</Files>
-	<Globals>
-	</Globals>
-</VisualStudioProject>
diff --git a/build/msvc/msvc-generate/msvc-generate.vcxproj b/build/msvc/msvc-generate/msvc-generate.vcxproj
new file mode 100644
index 0000000..e6491ab
--- /dev/null
+++ b/build/msvc/msvc-generate/msvc-generate.vcxproj
@@ -0,0 +1,69 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|Win32">
+      <Configuration>Debug</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|Win32">
+      <Configuration>Release</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+  </ItemGroup>
+  <PropertyGroup Label="Globals">
+    <ProjectGuid>{8598C2C8-34C4-47A1-99B0-7C295A890615}</ProjectGuid>
+    <RootNamespace>msvc-generate</RootNamespace>
+    <Keyword>MakeFileProj</Keyword>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
+    <ConfigurationType>Makefile</ConfigurationType>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
+  <ImportGroup Label="ExtensionSettings">
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
+    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
+    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">config-msvc-version.h</NMakeOutput>
+    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">WIN32;_DEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
+    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
+    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
+    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
+    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
+    <NMakeBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak all</NMakeBuildCommandLine>
+    <NMakeReBuildCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean all</NMakeReBuildCommandLine>
+    <NMakeCleanCommandLine Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">nmake -f Makefile.mak clean</NMakeCleanCommandLine>
+    <NMakeOutput Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">config-msvc-version.h</NMakeOutput>
+    <NMakePreprocessorDefinitions Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">WIN32;NDEBUG;$(NMakePreprocessorDefinitions)</NMakePreprocessorDefinitions>
+    <NMakeIncludeSearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeIncludeSearchPath)</NMakeIncludeSearchPath>
+    <NMakeForcedIncludes Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedIncludes)</NMakeForcedIncludes>
+    <NMakeAssemblySearchPath Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeAssemblySearchPath)</NMakeAssemblySearchPath>
+    <NMakeForcedUsingAssemblies Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(NMakeForcedUsingAssemblies)</NMakeForcedUsingAssemblies>
+  </PropertyGroup>
+  <ItemDefinitionGroup>
+  </ItemDefinitionGroup>
+  <ItemGroup>
+    <None Include="Makefile.mak" />
+    <None Include="msc-generate.js" />
+  </ItemGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
+  <ImportGroup Label="ExtensionTargets">
+  </ImportGroup>
+</Project>
\ No newline at end of file
diff --git a/msvc-build.bat b/msvc-build.bat
index 02a396c..01417d1 100644
--- a/msvc-build.bat
+++ b/msvc-build.bat
@@ -1,23 +1,37 @@
 @echo off
-
 rem Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
 
-call msvc-env.bat
-
 @rem this stupid command needed for SetEnv.cmd to operate
 setlocal ENABLEDELAYEDEXPANSION
 
+call msvc-env.bat
+
 set PLATFORMS=Win32
 set CONFIGURATIONS=Release
 
-call "%VCHOME%\bin\vcvars32.bat"
+if exist "%VCHOME%\vcvarsall.bat" (
+	call "%VCHOME%\vcvarsall.bat"
+) else if exist "%VCHOME%\bin\vcvars32.bat" (
+	call "%VCHOME%\bin\vcvars32.bat"
+) else (
+	echo Cannot detect visual studio
+	goto error
+)
+
+msbuild /help > nul 2>&1
+if errorlevel 1 set DO_VCBUILD=1
 
 for %%p in (%PLATFORMS%) do (
 	for %%c in (%CONFIGURATIONS%) do (
 		rmdir /q /s %SOURCEBASE%\%%p\%%c > nul 2>&1
 
-		vcbuild /errfile:error.log /showenv %SOLUTION% /rebuild /platform:%%p "%%c|%%p"
-		for %%f in (error.log) do if %%~zf GTR 0 goto error
+		if "%DO_VCBUILD%" NEQ "" (
+			vcbuild /errfile:error.log /showenv "%SOLUTION%" /rebuild /platform:%%p "%%c|%%p"
+			for %%f in (error.log) do if %%~zf GTR 0 goto error
+		) else  (
+			msbuild "%SOLUTION%" /p:Configuration="%%c" /p:Platform="%%p"
+			if errorlevel 1 goto error
+		)
 	)
 )
 
@@ -25,7 +39,6 @@ exit /b 0
 goto end
 
 :error
-if "%1" NEQ "batch" pause
 exit /b 1
 goto end
 
diff --git a/msvc-dev.bat b/msvc-dev.bat
index 671a56d..4dac172 100644
--- a/msvc-dev.bat
+++ b/msvc-dev.bat
@@ -4,6 +4,23 @@ setlocal
 cd %0\..
 call msvc-env.bat
 
-start "" "%VSHOME%\Common7\IDE\devenv.exe" %SOLUTION%
+if exist "%VSHOME%\Common7\IDE\VCExpress.exe" (
+	set IDE=%VSHOME%\Common7\IDE\VCExpress.exe
+) else if exist "%VSHOME%\Common7\IDE\devenv.exe" (
+	set IDE=%VSHOME%\Common7\IDE\devenv.exe
+) else (
+	echo "Cannot detect visual studio environment"
+	goto error
+)
+start "" "%IDE%" "%SOLUTION%"
+
+exit /b 0
+goto end
+
+:error
+exit /b 1
+goto end
+
+:end
 
 endlocal
diff --git a/msvc-env.bat b/msvc-env.bat
index e37757b..3c9eb5b 100644
--- a/msvc-env.bat
+++ b/msvc-env.bat
@@ -6,9 +6,10 @@ rem Put your own settings at msvc-env-local.bat
 if exist msvc-env-local.bat call msvc-env-local.bat
 
 if "%ProgramFiles(x86)%"=="" set ProgramFiles(x86)=%ProgramFiles%
-if "%VS90COMNTOOLS%"=="" set VS90COMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio 9.0\Common7\Tools\
-if "%VSHOME%"=="" set VSHOME=%VS90COMNTOOLS%..\..
-if "%VCHOME%"=="" set VCHOME=%VSHOME%\VC
+if "%VSCOMNTOOLS%"=="" SET VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio 10.0\Common7\Tools
+if "%VSCOMNTOOLS%"=="" SET VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio 9.0\Common7\Tools
+if "%VSHOME%"=="" SET VSHOME=%VSCOMNTOOLS%\..\..
+if "%VCHOME%"=="" SET VCHOME=%VSHOME%\VC
 
 set SOURCEBASE=%cd%
 set SOLUTION=openvpn.sln
diff --git a/openvpn.sln b/openvpn.sln
index be35d16..f832e7a 100644
--- a/openvpn.sln
+++ b/openvpn.sln
@@ -1,52 +1,38 @@
-﻿
-Microsoft Visual Studio Solution File, Format Version 10.00
-# Visual Studio 2008
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnserv", "src\openvpnserv\openvpnserv.vcproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
-	ProjectSection(ProjectDependencies) = postProject
-		{8598C2C8-34C4-47A1-99B0-7C295A890615} = {8598C2C8-34C4-47A1-99B0-7C295A890615}
-	EndProjectSection
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpn", "src\openvpn\openvpn.vcproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
-	ProjectSection(ProjectDependencies) = postProject
-		{4B2E2719-E661-45D7-9203-F6F456B22F19} = {4B2E2719-E661-45D7-9203-F6F456B22F19}
-		{8598C2C8-34C4-47A1-99B0-7C295A890615} = {8598C2C8-34C4-47A1-99B0-7C295A890615}
-	EndProjectSection
-EndProject
-Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") = "misc", "misc", "{1AA03DE8-3F08-45B9-B4ED-D7769A445DF3}"
-	ProjectSection(SolutionItems) = preProject
-		config-msvc-version.h.in = config-msvc-version.h.in
-		config-msvc.h = config-msvc.h
-		version.m4 = version.m4
-	EndProjectSection
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "msvc-generate", "build\msvc\msvc-generate\msvc-generate.vcproj", "{8598C2C8-34C4-47A1-99B0-7C295A890615}"
-EndProject
-Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "compat", "src\compat\compat.vcproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
-EndProject
-Global
-	GlobalSection(SolutionConfigurationPlatforms) = preSolution
-		Debug|Win32 = Debug|Win32
-		Release|Win32 = Release|Win32
-	EndGlobalSection
-	GlobalSection(ProjectConfigurationPlatforms) = postSolution
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.ActiveCfg = Debug|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.0 = Debug|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg = Release|Win32
-		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 = Release|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.ActiveCfg = Debug|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.0 = Debug|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg = Release|Win32
-		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 = Release|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.ActiveCfg = Debug|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.0 = Debug|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg = Release|Win32
-		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Build.0 = Release|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.ActiveCfg = Debug|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.0 = Debug|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.ActiveCfg = Release|Win32
-		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 = Release|Win32
-	EndGlobalSection
-	GlobalSection(SolutionProperties) = preSolution
-		HideSolutionNode = FALSE
-	EndGlobalSection
-EndGlobal
+﻿
+Microsoft Visual Studio Solution File, Format Version 11.00
+# Visual C++ Express 2010
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnserv", "src\openvpnserv\openvpnserv.vcxproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
+EndProject
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpn", "src\openvpn\openvpn.vcxproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
+EndProject
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "msvc-generate", "build\msvc\msvc-generate\msvc-generate.vcxproj", "{8598C2C8-34C4-47A1-99B0-7C295A890615}"
+EndProject
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "compat", "src\compat\compat.vcxproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
+EndProject
+Global
+	GlobalSection(SolutionConfigurationPlatforms) = preSolution
+		Debug|Win32 = Debug|Win32
+		Release|Win32 = Release|Win32
+	EndGlobalSection
+	GlobalSection(ProjectConfigurationPlatforms) = postSolution
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.ActiveCfg = Debug|Win32
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Debug|Win32.Build.0 = Debug|Win32
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.ActiveCfg = Release|Win32
+		{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}.Release|Win32.Build.0 = Release|Win32
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.ActiveCfg = Debug|Win32
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Debug|Win32.Build.0 = Debug|Win32
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.ActiveCfg = Release|Win32
+		{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}.Release|Win32.Build.0 = Release|Win32
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.ActiveCfg = Debug|Win32
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.0 = Debug|Win32
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.ActiveCfg = Release|Win32
+		{8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Build.0 = Release|Win32
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.ActiveCfg = Debug|Win32
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.0 = Debug|Win32
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.ActiveCfg = Release|Win32
+		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 = Release|Win32
+	EndGlobalSection
+	GlobalSection(SolutionProperties) = preSolution
+		HideSolutionNode = FALSE
+	EndGlobalSection
+EndGlobal
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 91b7f40..5ee35f7 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -13,7 +13,8 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 EXTRA_DIST = \
-	compat.vcproj
+	compat.vcxproj \
+	compat.vcxproj.filters
 
 noinst_LTLIBRARIES = libcompat.la
 
diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
deleted file mode 100644
index 43fc0c2..0000000
--- a/src/compat/compat.vcproj
+++ /dev/null
@@ -1,197 +0,0 @@
-<?xml version="1.0" encoding="Windows-1252"?>
-<VisualStudioProject
-	ProjectType="Visual C++"
-	Version="9.00"
-	Name="compat"
-	ProjectGUID="{4B2E2719-E661-45D7-9203-F6F456B22F19}"
-	RootNamespace="compat"
-	Keyword="Win32Proj"
-	TargetFrameworkVersion="196613"
-	>
-	<Platforms>
-		<Platform
-			Name="Win32"
-		/>
-	</Platforms>
-	<ToolFiles>
-	</ToolFiles>
-	<Configurations>
-		<Configuration
-			Name="Debug|Win32"
-			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="4"
-			CharacterSet="2"
-			>
-			<Tool
-				Name="VCPreBuildEventTool"
-			/>
-			<Tool
-				Name="VCCustomBuildTool"
-			/>
-			<Tool
-				Name="VCXMLDataGeneratorTool"
-			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
-			<Tool
-				Name="VCMIDLTool"
-			/>
-			<Tool
-				Name="VCCLCompilerTool"
-				Optimization="0"
-				AdditionalIncludeDirectories="$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
-				PreprocessorDefinitions="WIN32;_DEBUG;_LIB;$(CPPFLAGS)"
-				MinimalRebuild="true"
-				BasicRuntimeChecks="3"
-				RuntimeLibrary="3"
-				UsePrecompiledHeader="0"
-				WarningLevel="3"
-				DebugInformationFormat="4"
-			/>
-			<Tool
-				Name="VCManagedResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCPreLinkEventTool"
-			/>
-			<Tool
-				Name="VCLibrarianTool"
-			/>
-			<Tool
-				Name="VCALinkTool"
-			/>
-			<Tool
-				Name="VCXDCMakeTool"
-			/>
-			<Tool
-				Name="VCBscMakeTool"
-			/>
-			<Tool
-				Name="VCFxCopTool"
-			/>
-			<Tool
-				Name="VCPostBuildEventTool"
-			/>
-		</Configuration>
-		<Configuration
-			Name="Release|Win32"
-			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="4"
-			CharacterSet="2"
-			WholeProgramOptimization="1"
-			>
-			<Tool
-				Name="VCPreBuildEventTool"
-			/>
-			<Tool
-				Name="VCCustomBuildTool"
-			/>
-			<Tool
-				Name="VCXMLDataGeneratorTool"
-			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
-			<Tool
-				Name="VCMIDLTool"
-			/>
-			<Tool
-				Name="VCCLCompilerTool"
-				Optimization="2"
-				EnableIntrinsicFunctions="true"
-				AdditionalIncludeDirectories="$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
-				PreprocessorDefinitions="WIN32;NDEBUG;_LIB;$(CPPFLAGS)"
-				RuntimeLibrary="2"
-				EnableFunctionLevelLinking="true"
-				UsePrecompiledHeader="0"
-				WarningLevel="3"
-				DebugInformationFormat="3"
-			/>
-			<Tool
-				Name="VCManagedResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCPreLinkEventTool"
-			/>
-			<Tool
-				Name="VCLibrarianTool"
-			/>
-			<Tool
-				Name="VCALinkTool"
-			/>
-			<Tool
-				Name="VCXDCMakeTool"
-			/>
-			<Tool
-				Name="VCBscMakeTool"
-			/>
-			<Tool
-				Name="VCFxCopTool"
-			/>
-			<Tool
-				Name="VCPostBuildEventTool"
-			/>
-		</Configuration>
-	</Configurations>
-	<References>
-	</References>
-	<Files>
-		<Filter
-			Name="Source Files"
-			Filter="cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx"
-			UniqueIdentifier="{4FC737F1-C7A5-4376-A066-2A32D752A2FF}"
-			>
-			<File
-				RelativePath=".\compat-basename.c"
-				>
-			</File>
-			<File
-				RelativePath=".\compat-dirname.c"
-				>
-			</File>
-			<File
-				RelativePath=".\compat-gettimeofday.c"
-				>
-			</File>
-			<File
-				RelativePath=".\compat-inet_ntop.c"
-				>
-			</File>
-			<File
-				RelativePath=".\compat-inet_pton.c"
-				>
-			</File>
-			<File
-				RelativePath=".\compat-daemon.c"
-				>
-			</File>
-		</Filter>
-		<Filter
-			Name="Header Files"
-			Filter="h;hpp;hxx;hm;inl;inc;xsd"
-			UniqueIdentifier="{93995380-89BD-4b04-88EB-625FBE52EBFB}"
-			>
-			<File
-				RelativePath=".\compat.h"
-				>
-			</File>
-		</Filter>
-		<Filter
-			Name="Resource Files"
-			Filter="rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav"
-			UniqueIdentifier="{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}"
-			>
-		</Filter>
-	</Files>
-	<Globals>
-	</Globals>
-</VisualStudioProject>
diff --git a/src/compat/compat.vcxproj b/src/compat/compat.vcxproj
new file mode 100644
index 0000000..d872fa7
--- /dev/null
+++ b/src/compat/compat.vcxproj
@@ -0,0 +1,87 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|Win32">
+      <Configuration>Debug</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|Win32">
+      <Configuration>Release</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+  </ItemGroup>
+  <PropertyGroup Label="Globals">
+    <ProjectGuid>{4B2E2719-E661-45D7-9203-F6F456B22F19}</ProjectGuid>
+    <RootNamespace>compat</RootNamespace>
+    <Keyword>Win32Proj</Keyword>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
+    <ConfigurationType>StaticLibrary</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
+  <ImportGroup Label="ExtensionSettings">
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
+  </PropertyGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <MinimalRebuild>true</MinimalRebuild>
+      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;NDEBUG;_LIB;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemGroup>
+    <ClCompile Include="compat-basename.c" />
+    <ClCompile Include="compat-dirname.c" />
+    <ClCompile Include="compat-gettimeofday.c" />
+    <ClCompile Include="compat-inet_ntop.c" />
+    <ClCompile Include="compat-inet_pton.c" />
+    <ClCompile Include="compat-daemon.c" />
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="compat.h" />
+  </ItemGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
+  <ImportGroup Label="ExtensionTargets">
+  </ImportGroup>
+</Project>
\ No newline at end of file
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.filters
new file mode 100644
index 0000000..9576c51
--- /dev/null
+++ b/src/compat/compat.vcxproj.filters
@@ -0,0 +1,42 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup>
+    <Filter Include="Source Files">
+      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
+      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
+    </Filter>
+    <Filter Include="Header Files">
+      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
+      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
+    </Filter>
+    <Filter Include="Resource Files">
+      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
+      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav</Extensions>
+    </Filter>
+  </ItemGroup>
+  <ItemGroup>
+    <ClCompile Include="compat-basename.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="compat-dirname.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="compat-gettimeofday.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="compat-inet_ntop.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="compat-inet_pton.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="compat-daemon.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="compat.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+  </ItemGroup>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 1410021..4e485e7 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -15,7 +15,8 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 EXTRA_DIST = \
-	openvpn.vcproj
+	openvpn.vcxproj \
+	openvpn.vcxproj.filters
 
 INCLUDES = \
 	-I$(top_srcdir)/include \
diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
deleted file mode 100644
index c1aa8a0..0000000
--- a/src/openvpn/openvpn.vcproj
+++ /dev/null
@@ -1,777 +0,0 @@
-<?xml version="1.0" encoding="Windows-1252"?>
-<VisualStudioProject
-	ProjectType="Visual C++"
-	Version="9.00"
-	Name="openvpn"
-	ProjectGUID="{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
-	RootNamespace="openvpn"
-	Keyword="Win32Proj"
-	TargetFrameworkVersion="196613"
-	>
-	<Platforms>
-		<Platform
-			Name="Win32"
-		/>
-	</Platforms>
-	<ToolFiles>
-	</ToolFiles>
-	<Configurations>
-		<Configuration
-			Name="Debug|Win32"
-			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="1"
-			CharacterSet="2"
-			>
-			<Tool
-				Name="VCPreBuildEventTool"
-			/>
-			<Tool
-				Name="VCCustomBuildTool"
-			/>
-			<Tool
-				Name="VCXMLDataGeneratorTool"
-			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
-			<Tool
-				Name="VCMIDLTool"
-			/>
-			<Tool
-				Name="VCCLCompilerTool"
-				Optimization="0"
-				AdditionalIncludeDirectories="$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
-				PreprocessorDefinitions="WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS)"
-				MinimalRebuild="true"
-				BasicRuntimeChecks="3"
-				RuntimeLibrary="3"
-				UsePrecompiledHeader="0"
-				WarningLevel="3"
-				DebugInformationFormat="4"
-			/>
-			<Tool
-				Name="VCManagedResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCResourceCompilerTool"
-				AdditionalIncludeDirectories="$(SOURCEBASE)"
-			/>
-			<Tool
-				Name="VCPreLinkEventTool"
-			/>
-			<Tool
-				Name="VCLinkerTool"
-				AdditionalDependencies="libeay32.lib ssleay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
-				LinkIncremental="2"
-				AdditionalLibraryDirectories="$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
-				GenerateDebugInformation="true"
-				SubSystem="1"
-				TargetMachine="1"
-			/>
-			<Tool
-				Name="VCALinkTool"
-			/>
-			<Tool
-				Name="VCManifestTool"
-			/>
-			<Tool
-				Name="VCXDCMakeTool"
-			/>
-			<Tool
-				Name="VCBscMakeTool"
-			/>
-			<Tool
-				Name="VCFxCopTool"
-			/>
-			<Tool
-				Name="VCAppVerifierTool"
-			/>
-			<Tool
-				Name="VCPostBuildEventTool"
-			/>
-		</Configuration>
-		<Configuration
-			Name="Release|Win32"
-			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="1"
-			CharacterSet="2"
-			WholeProgramOptimization="1"
-			>
-			<Tool
-				Name="VCPreBuildEventTool"
-			/>
-			<Tool
-				Name="VCCustomBuildTool"
-			/>
-			<Tool
-				Name="VCXMLDataGeneratorTool"
-			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
-			<Tool
-				Name="VCMIDLTool"
-			/>
-			<Tool
-				Name="VCCLCompilerTool"
-				Optimization="2"
-				EnableIntrinsicFunctions="true"
-				AdditionalIncludeDirectories="$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
-				PreprocessorDefinitions="WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS)"
-				RuntimeLibrary="2"
-				EnableFunctionLevelLinking="true"
-				UsePrecompiledHeader="0"
-				WarningLevel="3"
-				DebugInformationFormat="3"
-			/>
-			<Tool
-				Name="VCManagedResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCResourceCompilerTool"
-				AdditionalIncludeDirectories="$(SOURCEBASE)"
-			/>
-			<Tool
-				Name="VCPreLinkEventTool"
-			/>
-			<Tool
-				Name="VCLinkerTool"
-				AdditionalDependencies="libeay32.lib ssleay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
-				LinkIncremental="1"
-				AdditionalLibraryDirectories="$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
-				GenerateDebugInformation="true"
-				SubSystem="1"
-				OptimizeReferences="2"
-				EnableCOMDATFolding="2"
-				TargetMachine="1"
-			/>
-			<Tool
-				Name="VCALinkTool"
-			/>
-			<Tool
-				Name="VCManifestTool"
-			/>
-			<Tool
-				Name="VCXDCMakeTool"
-			/>
-			<Tool
-				Name="VCBscMakeTool"
-			/>
-			<Tool
-				Name="VCFxCopTool"
-			/>
-			<Tool
-				Name="VCAppVerifierTool"
-			/>
-			<Tool
-				Name="VCPostBuildEventTool"
-			/>
-		</Configuration>
-	</Configurations>
-	<References>
-	</References>
-	<Files>
-		<Filter
-			Name="Source Files"
-			Filter="cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx"
-			UniqueIdentifier="{4FC737F1-C7A5-4376-A066-2A32D752A2FF}"
-			>
-			<File
-				RelativePath=".\base64.c"
-				>
-			</File>
-			<File
-				RelativePath=".\buffer.c"
-				>
-			</File>
-			<File
-				RelativePath=".\clinat.c"
-				>
-			</File>
-			<File
-				RelativePath=".\console.c"
-				>
-			</File>
-			<File
-				RelativePath=".\crypto.c"
-				>
-			</File>
-			<File
-				RelativePath=".\crypto_openssl.c"
-				>
-			</File>
-			<File
-				RelativePath=".\cryptoapi.c"
-				>
-			</File>
-			<File
-				RelativePath=".\dhcp.c"
-				>
-			</File>
-			<File
-				RelativePath=".\error.c"
-				>
-			</File>
-			<File
-				RelativePath=".\event.c"
-				>
-			</File>
-			<File
-				RelativePath=".\fdmisc.c"
-				>
-			</File>
-			<File
-				RelativePath=".\forward.c"
-				>
-			</File>
-			<File
-				RelativePath=".\fragment.c"
-				>
-			</File>
-			<File
-				RelativePath=".\gremlin.c"
-				>
-			</File>
-			<File
-				RelativePath=".\helper.c"
-				>
-			</File>
-			<File
-				RelativePath=".\httpdigest.c"
-				>
-			</File>
-			<File
-				RelativePath=".\init.c"
-				>
-			</File>
-			<File
-				RelativePath=".\interval.c"
-				>
-			</File>
-			<File
-				RelativePath=".\list.c"
-				>
-			</File>
-			<File
-				RelativePath=".\lladdr.c"
-				>
-			</File>
-			<File
-				RelativePath=".\lzo.c"
-				>
-			</File>
-			<File
-				RelativePath=".\manage.c"
-				>
-			</File>
-			<File
-				RelativePath=".\mbuf.c"
-				>
-			</File>
-			<File
-				RelativePath=".\misc.c"
-				>
-			</File>
-			<File
-				RelativePath=".\mroute.c"
-				>
-			</File>
-			<File
-				RelativePath=".\mss.c"
-				>
-			</File>
-			<File
-				RelativePath=".\mstats.c"
-				>
-			</File>
-			<File
-				RelativePath=".\mtcp.c"
-				>
-			</File>
-			<File
-				RelativePath=".\mtu.c"
-				>
-			</File>
-			<File
-				RelativePath=".\mudp.c"
-				>
-			</File>
-			<File
-				RelativePath=".\multi.c"
-				>
-			</File>
-			<File
-				RelativePath=".\ntlm.c"
-				>
-			</File>
-			<File
-				RelativePath=".\occ.c"
-				>
-			</File>
-			<File
-				RelativePath=".\openvpn.c"
-				>
-			</File>
-			<File
-				RelativePath=".\options.c"
-				>
-			</File>
-			<File
-				RelativePath=".\otime.c"
-				>
-			</File>
-			<File
-				RelativePath=".\packet_id.c"
-				>
-			</File>
-			<File
-				RelativePath=".\perf.c"
-				>
-			</File>
-			<File
-				RelativePath=".\pf.c"
-				>
-			</File>
-			<File
-				RelativePath=".\ping.c"
-				>
-			</File>
-			<File
-				RelativePath=".\pkcs11.c"
-				>
-			</File>
-			<File
-				RelativePath=".\pkcs11_openssl.c"
-				>
-			</File>
-			<File
-				RelativePath=".\platform.c"
-				>
-			</File>
-			<File
-				RelativePath=".\plugin.c"
-				>
-			</File>
-			<File
-				RelativePath=".\pool.c"
-				>
-			</File>
-			<File
-				RelativePath=".\proto.c"
-				>
-			</File>
-			<File
-				RelativePath=".\proxy.c"
-				>
-			</File>
-			<File
-				RelativePath=".\ps.c"
-				>
-			</File>
-			<File
-				RelativePath=".\push.c"
-				>
-			</File>
-			<File
-				RelativePath=".\reliable.c"
-				>
-			</File>
-			<File
-				RelativePath=".\route.c"
-				>
-			</File>
-			<File
-				RelativePath=".\schedule.c"
-				>
-			</File>
-			<File
-				RelativePath=".\session_id.c"
-				>
-			</File>
-			<File
-				RelativePath=".\shaper.c"
-				>
-			</File>
-			<File
-				RelativePath=".\sig.c"
-				>
-			</File>
-			<File
-				RelativePath=".\socket.c"
-				>
-			</File>
-			<File
-				RelativePath=".\socks.c"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl.c"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_openssl.c"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_verify.c"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_verify_openssl.c"
-				>
-			</File>
-			<File
-				RelativePath=".\status.c"
-				>
-			</File>
-			<File
-				RelativePath=".\tun.c"
-				>
-			</File>
-			<File
-				RelativePath=".\win32.c"
-				>
-			</File>
-		</Filter>
-		<Filter
-			Name="Header Files"
-			Filter="h;hpp;hxx;hm;inl;inc;xsd"
-			UniqueIdentifier="{93995380-89BD-4b04-88EB-625FBE52EBFB}"
-			>
-			<File
-				RelativePath=".\base64.h"
-				>
-			</File>
-			<File
-				RelativePath=".\basic.h"
-				>
-			</File>
-			<File
-				RelativePath=".\buffer.h"
-				>
-			</File>
-			<File
-				RelativePath=".\circ_list.h"
-				>
-			</File>
-			<File
-				RelativePath=".\clinat.h"
-				>
-			</File>
-			<File
-				RelativePath=".\common.h"
-				>
-			</File>
-			<File
-				RelativePath=".\console.h"
-				>
-			</File>
-			<File
-				RelativePath=".\crypto.h"
-				>
-			</File>
-			<File
-				RelativePath=".\crypto_backend.h"
-				>
-			</File>
-			<File
-				RelativePath=".\crypto_openssl.h"
-				>
-			</File>
-			<File
-				RelativePath=".\cryptoapi.h"
-				>
-			</File>
-			<File
-				RelativePath=".\dhcp.h"
-				>
-			</File>
-			<File
-				RelativePath=".\errlevel.h"
-				>
-			</File>
-			<File
-				RelativePath=".\error.h"
-				>
-			</File>
-			<File
-				RelativePath=".\event.h"
-				>
-			</File>
-			<File
-				RelativePath=".\fdmisc.h"
-				>
-			</File>
-			<File
-				RelativePath=".\forward-inline.h"
-				>
-			</File>
-			<File
-				RelativePath=".\forward.h"
-				>
-			</File>
-			<File
-				RelativePath=".\fragment.h"
-				>
-			</File>
-			<File
-				RelativePath=".\gremlin.h"
-				>
-			</File>
-			<File
-				RelativePath=".\helper.h"
-				>
-			</File>
-			<File
-				RelativePath=".\httpdigest.h"
-				>
-			</File>
-			<File
-				RelativePath=".\init.h"
-				>
-			</File>
-			<File
-				RelativePath=".\integer.h"
-				>
-			</File>
-			<File
-				RelativePath=".\interval.h"
-				>
-			</File>
-			<File
-				RelativePath=".\list.h"
-				>
-			</File>
-			<File
-				RelativePath=".\lladdr.h"
-				>
-			</File>
-			<File
-				RelativePath=".\lzo.h"
-				>
-			</File>
-			<File
-				RelativePath=".\manage.h"
-				>
-			</File>
-			<File
-				RelativePath=".\mbuf.h"
-				>
-			</File>
-			<File
-				RelativePath=".\memdbg.h"
-				>
-			</File>
-			<File
-				RelativePath=".\misc.h"
-				>
-			</File>
-			<File
-				RelativePath=".\mroute.h"
-				>
-			</File>
-			<File
-				RelativePath=".\mss.h"
-				>
-			</File>
-			<File
-				RelativePath=".\mstats.h"
-				>
-			</File>
-			<File
-				RelativePath=".\mtcp.h"
-				>
-			</File>
-			<File
-				RelativePath=".\mtu.h"
-				>
-			</File>
-			<File
-				RelativePath=".\mudp.h"
-				>
-			</File>
-			<File
-				RelativePath=".\multi.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ntlm.h"
-				>
-			</File>
-			<File
-				RelativePath=".\occ-inline.h"
-				>
-			</File>
-			<File
-				RelativePath=".\occ.h"
-				>
-			</File>
-			<File
-				RelativePath=".\openvpn.h"
-				>
-			</File>
-			<File
-				RelativePath=".\options.h"
-				>
-			</File>
-			<File
-				RelativePath=".\otime.h"
-				>
-			</File>
-			<File
-				RelativePath=".\packet_id.h"
-				>
-			</File>
-			<File
-				RelativePath=".\perf.h"
-				>
-			</File>
-			<File
-				RelativePath=".\pf-inline.h"
-				>
-			</File>
-			<File
-				RelativePath=".\pf.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ping-inline.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ping.h"
-				>
-			</File>
-			<File
-				RelativePath=".\pkcs11.h"
-				>
-			</File>
-			<File
-				RelativePath=".\pkcs11_backend.h"
-				>
-			</File>
-			<File
-				RelativePath=".\platform.h"
-				>
-			</File>
-			<File
-				RelativePath=".\plugin.h"
-				>
-			</File>
-			<File
-				RelativePath=".\pool.h"
-				>
-			</File>
-			<File
-				RelativePath=".\proto.h"
-				>
-			</File>
-			<File
-				RelativePath=".\proxy.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ps.h"
-				>
-			</File>
-			<File
-				RelativePath=".\push.h"
-				>
-			</File>
-			<File
-				RelativePath=".\pushlist.h"
-				>
-			</File>
-			<File
-				RelativePath=".\reliable.h"
-				>
-			</File>
-			<File
-				RelativePath=".\route.h"
-				>
-			</File>
-			<File
-				RelativePath=".\schedule.h"
-				>
-			</File>
-			<File
-				RelativePath=".\session_id.h"
-				>
-			</File>
-			<File
-				RelativePath=".\shaper.h"
-				>
-			</File>
-			<File
-				RelativePath=".\sig.h"
-				>
-			</File>
-			<File
-				RelativePath=".\socket.h"
-				>
-			</File>
-			<File
-				RelativePath=".\socks.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_backend.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_common.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_openssl.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_verify.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_verify_backend.h"
-				>
-			</File>
-			<File
-				RelativePath=".\ssl_verify_openssl.h"
-				>
-			</File>
-			<File
-				RelativePath=".\status.h"
-				>
-			</File>
-			<File
-				RelativePath=".\syshead.h"
-				>
-			</File>
-			<File
-				RelativePath=".\tun.h"
-				>
-			</File>
-			<File
-				RelativePath=".\win32.h"
-				>
-			</File>
-		</Filter>
-		<Filter
-			Name="Resource Files"
-			Filter="rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav"
-			UniqueIdentifier="{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}"
-			>
-			<File
-				RelativePath=".\openvpn_win32_resources.rc"
-				>
-			</File>
-		</Filter>
-	</Files>
-	<Globals>
-	</Globals>
-</VisualStudioProject>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
new file mode 100644
index 0000000..51e19af
--- /dev/null
+++ b/src/openvpn/openvpn.vcxproj
@@ -0,0 +1,261 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|Win32">
+      <Configuration>Debug</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|Win32">
+      <Configuration>Release</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+  </ItemGroup>
+  <PropertyGroup Label="Globals">
+    <ProjectGuid>{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}</ProjectGuid>
+    <RootNamespace>openvpn</RootNamespace>
+    <Keyword>Win32Proj</Keyword>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
+  <ImportGroup Label="ExtensionSettings">
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">true</LinkIncremental>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">false</LinkIncremental>
+  </PropertyGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <MinimalRebuild>true</MinimalRebuild>
+      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+      <TargetMachine>MachineX86</TargetMachine>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+      <OptimizeReferences>true</OptimizeReferences>
+      <EnableCOMDATFolding>true</EnableCOMDATFolding>
+      <TargetMachine>MachineX86</TargetMachine>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemGroup>
+    <ClCompile Include="base64.c" />
+    <ClCompile Include="buffer.c" />
+    <ClCompile Include="clinat.c" />
+    <ClCompile Include="console.c" />
+    <ClCompile Include="crypto.c" />
+    <ClCompile Include="crypto_openssl.c" />
+    <ClCompile Include="cryptoapi.c" />
+    <ClCompile Include="dhcp.c" />
+    <ClCompile Include="error.c" />
+    <ClCompile Include="event.c" />
+    <ClCompile Include="fdmisc.c" />
+    <ClCompile Include="forward.c" />
+    <ClCompile Include="fragment.c" />
+    <ClCompile Include="gremlin.c" />
+    <ClCompile Include="helper.c" />
+    <ClCompile Include="httpdigest.c" />
+    <ClCompile Include="init.c" />
+    <ClCompile Include="interval.c" />
+    <ClCompile Include="list.c" />
+    <ClCompile Include="lladdr.c" />
+    <ClCompile Include="lzo.c" />
+    <ClCompile Include="manage.c" />
+    <ClCompile Include="mbuf.c" />
+    <ClCompile Include="misc.c" />
+    <ClCompile Include="mroute.c" />
+    <ClCompile Include="mss.c" />
+    <ClCompile Include="mstats.c" />
+    <ClCompile Include="mtcp.c" />
+    <ClCompile Include="mtu.c" />
+    <ClCompile Include="mudp.c" />
+    <ClCompile Include="multi.c" />
+    <ClCompile Include="ntlm.c" />
+    <ClCompile Include="occ.c" />
+    <ClCompile Include="openvpn.c" />
+    <ClCompile Include="options.c" />
+    <ClCompile Include="otime.c" />
+    <ClCompile Include="packet_id.c" />
+    <ClCompile Include="perf.c" />
+    <ClCompile Include="pf.c" />
+    <ClCompile Include="ping.c" />
+    <ClCompile Include="pkcs11.c" />
+    <ClCompile Include="pkcs11_openssl.c" />
+    <ClCompile Include="platform.c" />
+    <ClCompile Include="plugin.c" />
+    <ClCompile Include="pool.c" />
+    <ClCompile Include="proto.c" />
+    <ClCompile Include="proxy.c" />
+    <ClCompile Include="ps.c" />
+    <ClCompile Include="push.c" />
+    <ClCompile Include="reliable.c" />
+    <ClCompile Include="route.c" />
+    <ClCompile Include="schedule.c" />
+    <ClCompile Include="session_id.c" />
+    <ClCompile Include="shaper.c" />
+    <ClCompile Include="sig.c" />
+    <ClCompile Include="socket.c" />
+    <ClCompile Include="socks.c" />
+    <ClCompile Include="ssl.c" />
+    <ClCompile Include="ssl_openssl.c" />
+    <ClCompile Include="ssl_verify.c" />
+    <ClCompile Include="ssl_verify_openssl.c" />
+    <ClCompile Include="status.c" />
+    <ClCompile Include="tun.c" />
+    <ClCompile Include="win32.c" />
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="base64.h" />
+    <ClInclude Include="basic.h" />
+    <ClInclude Include="buffer.h" />
+    <ClInclude Include="circ_list.h" />
+    <ClInclude Include="clinat.h" />
+    <ClInclude Include="common.h" />
+    <ClInclude Include="console.h" />
+    <ClInclude Include="crypto.h" />
+    <ClInclude Include="crypto_backend.h" />
+    <ClInclude Include="crypto_openssl.h" />
+    <ClInclude Include="cryptoapi.h" />
+    <ClInclude Include="dhcp.h" />
+    <ClInclude Include="errlevel.h" />
+    <ClInclude Include="error.h" />
+    <ClInclude Include="event.h" />
+    <ClInclude Include="fdmisc.h" />
+    <ClInclude Include="forward-inline.h" />
+    <ClInclude Include="forward.h" />
+    <ClInclude Include="fragment.h" />
+    <ClInclude Include="gremlin.h" />
+    <ClInclude Include="helper.h" />
+    <ClInclude Include="httpdigest.h" />
+    <ClInclude Include="init.h" />
+    <ClInclude Include="integer.h" />
+    <ClInclude Include="interval.h" />
+    <ClInclude Include="list.h" />
+    <ClInclude Include="lladdr.h" />
+    <ClInclude Include="lzo.h" />
+    <ClInclude Include="manage.h" />
+    <ClInclude Include="mbuf.h" />
+    <ClInclude Include="memdbg.h" />
+    <ClInclude Include="misc.h" />
+    <ClInclude Include="mroute.h" />
+    <ClInclude Include="mss.h" />
+    <ClInclude Include="mstats.h" />
+    <ClInclude Include="mtcp.h" />
+    <ClInclude Include="mtu.h" />
+    <ClInclude Include="mudp.h" />
+    <ClInclude Include="multi.h" />
+    <ClInclude Include="ntlm.h" />
+    <ClInclude Include="occ-inline.h" />
+    <ClInclude Include="occ.h" />
+    <ClInclude Include="openvpn.h" />
+    <ClInclude Include="options.h" />
+    <ClInclude Include="otime.h" />
+    <ClInclude Include="packet_id.h" />
+    <ClInclude Include="perf.h" />
+    <ClInclude Include="pf-inline.h" />
+    <ClInclude Include="pf.h" />
+    <ClInclude Include="ping-inline.h" />
+    <ClInclude Include="ping.h" />
+    <ClInclude Include="pkcs11.h" />
+    <ClInclude Include="pkcs11_backend.h" />
+    <ClInclude Include="platform.h" />
+    <ClInclude Include="plugin.h" />
+    <ClInclude Include="pool.h" />
+    <ClInclude Include="proto.h" />
+    <ClInclude Include="proxy.h" />
+    <ClInclude Include="ps.h" />
+    <ClInclude Include="push.h" />
+    <ClInclude Include="pushlist.h" />
+    <ClInclude Include="reliable.h" />
+    <ClInclude Include="route.h" />
+    <ClInclude Include="schedule.h" />
+    <ClInclude Include="session_id.h" />
+    <ClInclude Include="shaper.h" />
+    <ClInclude Include="sig.h" />
+    <ClInclude Include="socket.h" />
+    <ClInclude Include="socks.h" />
+    <ClInclude Include="ssl.h" />
+    <ClInclude Include="ssl_backend.h" />
+    <ClInclude Include="ssl_common.h" />
+    <ClInclude Include="ssl_openssl.h" />
+    <ClInclude Include="ssl_verify.h" />
+    <ClInclude Include="ssl_verify_backend.h" />
+    <ClInclude Include="ssl_verify_openssl.h" />
+    <ClInclude Include="status.h" />
+    <ClInclude Include="syshead.h" />
+    <ClInclude Include="tun.h" />
+    <ClInclude Include="win32.h" />
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="openvpn_win32_resources.rc" />
+  </ItemGroup>
+  <ItemGroup>
+    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
+      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+    <ProjectReference Include="..\compat\compat.vcxproj">
+      <Project>{4b2e2719-e661-45d7-9203-f6f456b22f19}</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+  </ItemGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
+  <ImportGroup Label="ExtensionTargets">
+  </ImportGroup>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
new file mode 100644
index 0000000..ec5e676
--- /dev/null
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -0,0 +1,458 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup>
+    <Filter Include="Source Files">
+      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
+      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
+    </Filter>
+    <Filter Include="Header Files">
+      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
+      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
+    </Filter>
+    <Filter Include="Resource Files">
+      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
+      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav</Extensions>
+    </Filter>
+  </ItemGroup>
+  <ItemGroup>
+    <ClCompile Include="base64.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="buffer.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="clinat.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="console.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="crypto.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="crypto_openssl.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="cryptoapi.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="dhcp.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="error.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="event.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="fdmisc.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="forward.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="fragment.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="gremlin.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="helper.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="httpdigest.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="init.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="interval.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="list.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="lladdr.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="lzo.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="manage.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="mbuf.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="misc.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="mroute.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="mss.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="mstats.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="mtcp.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="mtu.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="mudp.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="multi.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="ntlm.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="occ.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="openvpn.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="options.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="otime.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="packet_id.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="perf.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="pf.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="ping.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="pkcs11.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="pkcs11_openssl.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="platform.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="plugin.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="pool.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="proto.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="proxy.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="ps.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="push.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="reliable.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="route.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="schedule.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="session_id.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="shaper.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="sig.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="socket.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="socks.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="ssl.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="ssl_openssl.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="ssl_verify.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="ssl_verify_openssl.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="status.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="tun.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="win32.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="base64.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="basic.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="buffer.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="circ_list.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="clinat.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="common.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="console.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="crypto.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="crypto_backend.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="crypto_openssl.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="cryptoapi.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="dhcp.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="errlevel.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="error.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="event.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="fdmisc.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="forward-inline.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="forward.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="fragment.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="gremlin.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="helper.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="httpdigest.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="init.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="integer.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="interval.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="list.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="lladdr.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="lzo.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="manage.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="mbuf.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="memdbg.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="misc.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="mroute.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="mss.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="mstats.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="mtcp.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="mtu.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="mudp.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="multi.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ntlm.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="occ-inline.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="occ.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="openvpn.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="options.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="otime.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="packet_id.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="perf.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="pf-inline.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="pf.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ping-inline.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ping.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="pkcs11.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="pkcs11_backend.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="platform.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="plugin.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="pool.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="proto.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="proxy.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ps.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="push.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="pushlist.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="reliable.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="route.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="schedule.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="session_id.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="shaper.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="sig.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="socket.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="socks.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ssl.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ssl_backend.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ssl_common.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ssl_openssl.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ssl_verify.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ssl_verify_backend.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="ssl_verify_openssl.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="status.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="syshead.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="tun.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="win32.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="openvpn_win32_resources.rc">
+      <Filter>Resource Files</Filter>
+    </ResourceCompile>
+  </ItemGroup>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 8584b06..a989c25 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -14,7 +14,8 @@ include $(top_srcdir)/build/ltrc.inc
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
 EXTRA_DIST = \
-	openvpnserv.vcproj
+	openvpnserv.vcxproj \
+	openvpnserv.vcxproj.filters
 
 if WIN32
 sbin_PROGRAMS = openvpnserv
diff --git a/src/openvpnserv/openvpnserv.vcproj b/src/openvpnserv/openvpnserv.vcproj
deleted file mode 100644
index 4c55561..0000000
--- a/src/openvpnserv/openvpnserv.vcproj
+++ /dev/null
@@ -1,209 +0,0 @@
-<?xml version="1.0" encoding="Windows-1252"?>
-<VisualStudioProject
-	ProjectType="Visual C++"
-	Version="9.00"
-	Name="openvpnserv"
-	ProjectGUID="{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
-	RootNamespace="openvpnserv"
-	Keyword="Win32Proj"
-	TargetFrameworkVersion="196613"
-	>
-	<Platforms>
-		<Platform
-			Name="Win32"
-		/>
-	</Platforms>
-	<ToolFiles>
-	</ToolFiles>
-	<Configurations>
-		<Configuration
-			Name="Debug|Win32"
-			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="1"
-			CharacterSet="2"
-			>
-			<Tool
-				Name="VCPreBuildEventTool"
-			/>
-			<Tool
-				Name="VCCustomBuildTool"
-			/>
-			<Tool
-				Name="VCXMLDataGeneratorTool"
-			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
-			<Tool
-				Name="VCMIDLTool"
-			/>
-			<Tool
-				Name="VCCLCompilerTool"
-				Optimization="0"
-				AdditionalIncludeDirectories="$(SOURCEBASE)"
-				PreprocessorDefinitions="WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS)"
-				MinimalRebuild="true"
-				BasicRuntimeChecks="3"
-				RuntimeLibrary="3"
-				UsePrecompiledHeader="0"
-				WarningLevel="3"
-				DebugInformationFormat="4"
-			/>
-			<Tool
-				Name="VCManagedResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCResourceCompilerTool"
-				AdditionalIncludeDirectories="$(SOURCEBASE)"
-			/>
-			<Tool
-				Name="VCPreLinkEventTool"
-			/>
-			<Tool
-				Name="VCLinkerTool"
-				LinkIncremental="2"
-				GenerateDebugInformation="true"
-				SubSystem="1"
-				TargetMachine="1"
-			/>
-			<Tool
-				Name="VCALinkTool"
-			/>
-			<Tool
-				Name="VCManifestTool"
-			/>
-			<Tool
-				Name="VCXDCMakeTool"
-			/>
-			<Tool
-				Name="VCBscMakeTool"
-			/>
-			<Tool
-				Name="VCFxCopTool"
-			/>
-			<Tool
-				Name="VCAppVerifierTool"
-			/>
-			<Tool
-				Name="VCPostBuildEventTool"
-			/>
-		</Configuration>
-		<Configuration
-			Name="Release|Win32"
-			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
-			IntermediateDirectory="$(ConfigurationName)"
-			ConfigurationType="1"
-			CharacterSet="2"
-			WholeProgramOptimization="1"
-			>
-			<Tool
-				Name="VCPreBuildEventTool"
-			/>
-			<Tool
-				Name="VCCustomBuildTool"
-			/>
-			<Tool
-				Name="VCXMLDataGeneratorTool"
-			/>
-			<Tool
-				Name="VCWebServiceProxyGeneratorTool"
-			/>
-			<Tool
-				Name="VCMIDLTool"
-			/>
-			<Tool
-				Name="VCCLCompilerTool"
-				Optimization="2"
-				EnableIntrinsicFunctions="true"
-				AdditionalIncludeDirectories="$(SOURCEBASE)"
-				PreprocessorDefinitions="WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS)"
-				RuntimeLibrary="2"
-				EnableFunctionLevelLinking="true"
-				UsePrecompiledHeader="0"
-				WarningLevel="3"
-				DebugInformationFormat="3"
-			/>
-			<Tool
-				Name="VCManagedResourceCompilerTool"
-			/>
-			<Tool
-				Name="VCResourceCompilerTool"
-				AdditionalIncludeDirectories="$(SOURCEBASE)"
-			/>
-			<Tool
-				Name="VCPreLinkEventTool"
-			/>
-			<Tool
-				Name="VCLinkerTool"
-				LinkIncremental="1"
-				GenerateDebugInformation="true"
-				SubSystem="1"
-				OptimizeReferences="2"
-				EnableCOMDATFolding="2"
-				TargetMachine="1"
-			/>
-			<Tool
-				Name="VCALinkTool"
-			/>
-			<Tool
-				Name="VCManifestTool"
-			/>
-			<Tool
-				Name="VCXDCMakeTool"
-			/>
-			<Tool
-				Name="VCBscMakeTool"
-			/>
-			<Tool
-				Name="VCFxCopTool"
-			/>
-			<Tool
-				Name="VCAppVerifierTool"
-			/>
-			<Tool
-				Name="VCPostBuildEventTool"
-			/>
-		</Configuration>
-	</Configurations>
-	<References>
-	</References>
-	<Files>
-		<Filter
-			Name="Source Files"
-			Filter="cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx"
-			UniqueIdentifier="{4FC737F1-C7A5-4376-A066-2A32D752A2FF}"
-			>
-			<File
-				RelativePath=".\openvpnserv.c"
-				>
-			</File>
-			<File
-				RelativePath=".\service.c"
-				>
-			</File>
-		</Filter>
-		<Filter
-			Name="Header Files"
-			Filter="h;hpp;hxx;hm;inl;inc;xsd"
-			UniqueIdentifier="{93995380-89BD-4b04-88EB-625FBE52EBFB}"
-			>
-			<File
-				RelativePath=".\service.h"
-				>
-			</File>
-		</Filter>
-		<Filter
-			Name="Resource Files"
-			Filter="rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav"
-			UniqueIdentifier="{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}"
-			>
-			<File
-				RelativePath=".\openvpnserv_resources.rc"
-				>
-			</File>
-		</Filter>
-	</Files>
-	<Globals>
-	</Globals>
-</VisualStudioProject>
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
new file mode 100644
index 0000000..f2c0071
--- /dev/null
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -0,0 +1,112 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|Win32">
+      <Configuration>Debug</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|Win32">
+      <Configuration>Release</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+  </ItemGroup>
+  <PropertyGroup Label="Globals">
+    <ProjectGuid>{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}</ProjectGuid>
+    <RootNamespace>openvpnserv</RootNamespace>
+    <Keyword>Win32Proj</Keyword>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <CharacterSet>MultiByte</CharacterSet>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
+  <ImportGroup Label="ExtensionSettings">
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <ImportGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="PropertySheets">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <_ProjectFileVersion>10.0.30319.1</_ProjectFileVersion>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">$(Configuration)\</IntDir>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">true</LinkIncremental>
+    <OutDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
+    <IntDir Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">$(Configuration)\</IntDir>
+    <LinkIncremental Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">false</LinkIncremental>
+  </PropertyGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <ClCompile>
+      <Optimization>Disabled</Optimization>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;_DEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <MinimalRebuild>true</MinimalRebuild>
+      <BasicRuntimeChecks>EnableFastChecks</BasicRuntimeChecks>
+      <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+      <TargetMachine>MachineX86</TargetMachine>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <ClCompile>
+      <Optimization>MaxSpeed</Optimization>
+      <IntrinsicFunctions>true</IntrinsicFunctions>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <PreprocessorDefinitions>WIN32;NDEBUG;_CONSOLE;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <RuntimeLibrary>MultiThreadedDLL</RuntimeLibrary>
+      <FunctionLevelLinking>true</FunctionLevelLinking>
+      <PrecompiledHeader>
+      </PrecompiledHeader>
+      <WarningLevel>Level3</WarningLevel>
+      <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+    </ClCompile>
+    <ResourceCompile>
+      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ResourceCompile>
+    <Link>
+      <GenerateDebugInformation>true</GenerateDebugInformation>
+      <SubSystem>Console</SubSystem>
+      <OptimizeReferences>true</OptimizeReferences>
+      <EnableCOMDATFolding>true</EnableCOMDATFolding>
+      <TargetMachine>MachineX86</TargetMachine>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemGroup>
+    <ClCompile Include="openvpnserv.c" />
+    <ClCompile Include="service.c" />
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="service.h" />
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="openvpnserv_resources.rc" />
+  </ItemGroup>
+  <ItemGroup>
+    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
+      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+  </ItemGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
+  <ImportGroup Label="ExtensionTargets">
+  </ImportGroup>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/openvpnserv.vcxproj.filters
new file mode 100644
index 0000000..a6f8ecc
--- /dev/null
+++ b/src/openvpnserv/openvpnserv.vcxproj.filters
@@ -0,0 +1,35 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup>
+    <Filter Include="Source Files">
+      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
+      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
+    </Filter>
+    <Filter Include="Header Files">
+      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
+      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
+    </Filter>
+    <Filter Include="Resource Files">
+      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
+      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav</Extensions>
+    </Filter>
+  </ItemGroup>
+  <ItemGroup>
+    <ClCompile Include="openvpnserv.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="service.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="service.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="openvpnserv_resources.rc">
+      <Filter>Resource Files</Filter>
+    </ResourceCompile>
+  </ItemGroup>
+</Project>
\ No newline at end of file
-- 
1.7.3.4


