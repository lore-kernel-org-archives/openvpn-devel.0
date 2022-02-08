From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  8 Feb 2022 13:49:05 +0200
Message-Id: <20220208114905.100-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] msvc: cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Remove unused macros for dependency directories,
since dependencies are handled by vcpkg.

Remove unused .bat files.

Reported-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Lev Stipakov <lev@...515...>
---
 Makefile.am                           |  5 +--
 build/msvc/msvc-generate/Makefile.mak | 14 ++++----
 msvc-build.bat                        | 50 ---------------------------
 msvc-dev.bat                          | 28 ---------------
 msvc-env.bat                          | 30 ----------------
 src/compat/PropertySheet.props        | 38 ++++----------------
 src/openvpn/openvpn.vcxproj           | 12 +++----
 src/openvpnmsica/openvpnmsica.props   |  1 -
 8 files changed, 20 insertions(+), 158 deletions(-)
 delete mode 100644 msvc-build.bat
 delete mode 100644 msvc-dev.bat
 delete mode 100644 msvc-env.bat

diff --git a/Makefile.am b/Makefile.am
index 3f0fdd4c..28a7ef76 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -66,10 +66,7 @@ dist_noinst_DATA = \
 	PORTS \
 	README.IPv6 TODO.IPv6 \
 	README.mbedtls \
-	openvpn.sln \
-	msvc-env.bat \
-	msvc-dev.bat \
-	msvc-build.bat
+	openvpn.sln
 
 dist_noinst_HEADERS = \
 	config-msvc.h \
diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-generate/Makefile.mak
index 6da859e3..1cb43102 100644
--- a/build/msvc/msvc-generate/Makefile.mak
+++ b/build/msvc/msvc-generate/Makefile.mak
@@ -1,18 +1,18 @@
 # Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
 
-CONFIG=$(SOURCEBASE)/version.m4
+CONFIG=$(SOLUTIONDIR)/version.m4
 
-INPUT_MSVC_VER=$(SOURCEBASE)/config-msvc-version.h.in
-OUTPUT_MSVC_VER=$(SOURCEBASE)/config-msvc-version.h
+INPUT_MSVC_VER=$(SOLUTIONDIR)/config-msvc-version.h.in
+OUTPUT_MSVC_VER=$(SOLUTIONDIR)/config-msvc-version.h
 
-INPUT_PLUGIN=$(SOURCEBASE)/include/openvpn-plugin.h.in
-OUTPUT_PLUGIN=$(SOURCEBASE)/include/openvpn-plugin.h
+INPUT_PLUGIN=$(SOLUTIONDIR)/include/openvpn-plugin.h.in
+OUTPUT_PLUGIN=$(SOLUTIONDIR)/include/openvpn-plugin.h
 
 INPUT_PLUGIN_CONFIG=version.m4.in
 OUTPUT_PLUGIN_CONFIG=version.m4
 
-INPUT_MAN=$(SOURCEBASE)/doc/openvpn.8.rst
-OUTPUT_MAN=$(SOURCEBASE)/doc/openvpn.8.html
+INPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.rst
+OUTPUT_MAN=$(SOLUTIONDIR)/doc/openvpn.8.html
 
 all:	$(OUTPUT_MSVC_VER) $(OUTPUT_PLUGIN) $(OUTPUT_MAN)
 
diff --git a/msvc-build.bat b/msvc-build.bat
deleted file mode 100644
index 8256c62d..00000000
--- a/msvc-build.bat
+++ /dev/null
@@ -1,50 +0,0 @@
-@...1657... off
-rem Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
-
-@...1738... this stupid command needed for SetEnv.cmd to operate
-setlocal ENABLEDELAYEDEXPANSION
-
-cd /d %0\..
-call msvc-env.bat
-
-set PLATFORMS=x64
-set CONFIGURATIONS=Debug Release
-
-if exist "%VCHOME%\vcvarsall.bat" (
-	call "%VCHOME%\vcvarsall.bat"
-) else if exist "%VCHOME%\bin\vcvars32.bat" (
-	call "%VCHOME%\bin\vcvars32.bat"
-) else if exist "%VCHOME%\Auxiliary\Build\vcvars32.bat" (
-	call "%VCHOME%\Auxiliary\Build\vcvars32.bat"
-) else (
-	echo Cannot detect visual studio
-	goto error
-)
-
-msbuild /help > nul 2>&1
-if errorlevel 1 set DO_VCBUILD=1
-
-for %%p in (%PLATFORMS%) do (
-	for %%c in (%CONFIGURATIONS%) do (
-		rmdir /q /s %SOURCEBASE%\%%p\%%c > nul 2>&1
-
-		if "%DO_VCBUILD%" NEQ "" (
-			vcbuild /errfile:error.log /showenv "%SOLUTION%" /rebuild /platform:%%p "%%c|%%p"
-			for %%f in (error.log) do if %%~zf GTR 0 goto error
-		) else  (
-			msbuild "%SOLUTION%" /p:Configuration="%%c" /p:Platform="%%p"
-			if errorlevel 1 goto error
-		)
-	)
-)
-
-exit /b 0
-goto end
-
-:error
-exit /b 1
-goto end
-
-:end
-
-endlocal
diff --git a/msvc-dev.bat b/msvc-dev.bat
deleted file mode 100644
index 74aee0b0..00000000
--- a/msvc-dev.bat
+++ /dev/null
@@ -1,28 +0,0 @@
-@...1657... off
-
-setlocal
-cd /d %0\..
-call msvc-env.bat
-
-if exist "%VSHOME%\Common7\IDE\VCExpress.exe" (
-	set IDE=%VSHOME%\Common7\IDE\VCExpress.exe
-) else if exist "%VSHOME%\Common7\IDE\devenv.exe" (
-	set IDE=%VSHOME%\Common7\IDE\devenv.exe
-) else if exist "%VCHOME%\Auxiliary\Build\vcvars64.bat" (
-	call "%VCHOME%\Auxiliary\Build\vcvars64.bat"
-) else (
-	echo "Cannot detect visual studio environment"
-	goto error
-)
-start "" "%IDE%" "%SOLUTION%"
-
-exit /b 0
-goto end
-
-:error
-exit /b 1
-goto end
-
-:end
-
-endlocal
diff --git a/msvc-env.bat b/msvc-env.bat
deleted file mode 100644
index cc9663df..00000000
--- a/msvc-env.bat
+++ /dev/null
@@ -1,30 +0,0 @@
-@...1657... off
-
-rem Put your own settings at msvc-env-local.bat
-if exist msvc-env-local.bat call msvc-env-local.bat
-
-if "%ProgramFiles(x86)%"=="" set ProgramFiles(x86)=%ProgramFiles%
-if "%VSCOMNTOOLS%"=="" set VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional\Common7\Tools
-if not exist "%VSCOMNTOOLS%" set VSCOMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\Common7\Tools
-if "%VSHOME%"=="" SET VSHOME=%VSCOMNTOOLS%\..\..
-if "%VCHOME%"=="" SET VCHOME=%VSHOME%\VC
-
-set SOURCEBASE=%cd%
-set SOLUTION=openvpn.sln
-set CPPFLAGS=%CPPFLAGS%;_CRT_SECURE_NO_WARNINGS;WIN32_LEAN_AND_MEAN;_CRT_NONSTDC_NO_WARNINGS;_CRT_SECURE_NO_WARNINGS
-set CPPFLAGS=%CPPFLAGS%;NTDDI_VERSION=NTDDI_VISTA;_WIN32_WINNT=_WIN32_WINNT_VISTA
-set CPPFLAGS=%CPPFLAGS%;
-set CPPFLAGS=%CPPFLAGS%;%EXTRA_CPPFLAGS%
-
-if exist config-msvc-local.h set CPPFLAGS="%CPPFLAGS%;HAVE_CONFIG_MSVC_LOCAL_H"
-
-if "%OPENVPN_DEPROOT%" == "" set OPENVPN_DEPROOT=c:\Temp\openvpn-deps
-if "%OPENSSL_HOME%" == "" set OPENSSL_HOME=%OPENVPN_DEPROOT%
-if "%LZO_HOME%" == "" set LZO_HOME=%OPENVPN_DEPROOT%
-if "%PKCS11H_HOME%" == "" set PKCS11H_HOME=%OPENVPN_DEPROOT%
-if "%TAP_WINDOWS_HOME%" == "" set TAP_WINDOWS_HOME=%OPENVPN_DEPROOT%
-
-if not exist "%OPENSSL_HOME%" echo WARNING: openssl '%OPENSSL_HOME%' does not exist
-if not exist "%LZO_HOME%" echo WARNING: lzo '%LZO_HOME%' does not exist
-if not exist "%PKCS11H_HOME%" echo WARNING: pkcs11-helper '%PKCS11H_HOME%' does not exist
-if not exist "%TAP_WINDOWS_HOME%" echo WARNING: tap-windows '%TAP_WINDOWS_HOME%' does not exist
diff --git a/src/compat/PropertySheet.props b/src/compat/PropertySheet.props
index 4f94b972..57f6995f 100644
--- a/src/compat/PropertySheet.props
+++ b/src/compat/PropertySheet.props
@@ -1,14 +1,7 @@
 <?xml version="1.0" encoding="utf-8"?>
 <Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   <ImportGroup Label="PropertySheets" />
-  <PropertyGroup Label="UserMacros">
-    <SOURCEBASE>$(SolutionDir)</SOURCEBASE>
-    <OPENVPN_DEPROOT>$(SOURCEBASE)\..\openvpn-build\msvc\image$(PlatformArchitecture)</OPENVPN_DEPROOT>
-    <OPENSSL_HOME>$(OPENVPN_DEPROOT)</OPENSSL_HOME>
-    <TAP_WINDOWS_HOME>$(OPENVPN_DEPROOT)</TAP_WINDOWS_HOME>
-    <LZO_HOME>$(OPENVPN_DEPROOT)</LZO_HOME>
-    <PKCS11H_HOME>$(OPENVPN_DEPROOT)</PKCS11H_HOME>
-  </PropertyGroup>
+  <PropertyGroup Label="UserMacros" />
   <PropertyGroup>
     <OutDir>$(SolutionDir)$(Platform)-Output\$(Configuration)\</OutDir>
     <_PropertySheetDisplayName>compat</_PropertySheetDisplayName>
@@ -17,38 +10,19 @@
     <ClCompile>
       <WarningLevel>Level3</WarningLevel>
       <PreprocessorDefinitions>WIN32;$(CPPFLAGS);%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);$(SOURCEBASE)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SolutionDir);$(SolutionDir)include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <Link>
       <GenerateDebugInformation>true</GenerateDebugInformation>
     </Link>
+    <ResourceCompile />
     <ResourceCompile>
-      <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>$(SOLUTIONDIR)</AdditionalIncludeDirectories>
     </ResourceCompile>
   </ItemDefinitionGroup>
   <ItemGroup>
-    <BuildMacro Include="SOURCEBASE">
-      <Value>$(SOURCEBASE)</Value>
-      <EnvironmentVariable>true</EnvironmentVariable>
-    </BuildMacro>
-    <BuildMacro Include="OPENVPN_DEPROOT">
-      <Value>$(OPENVPN_DEPROOT)</Value>
-      <EnvironmentVariable>true</EnvironmentVariable>
-    </BuildMacro>
-    <BuildMacro Include="OPENSSL_HOME">
-      <Value>$(OPENSSL_HOME)</Value>
-      <EnvironmentVariable>true</EnvironmentVariable>
-    </BuildMacro>
-    <BuildMacro Include="TAP_WINDOWS_HOME">
-      <Value>$(TAP_WINDOWS_HOME)</Value>
-      <EnvironmentVariable>true</EnvironmentVariable>
-    </BuildMacro>
-    <BuildMacro Include="LZO_HOME">
-      <Value>$(LZO_HOME)</Value>
-      <EnvironmentVariable>true</EnvironmentVariable>
-    </BuildMacro>
-    <BuildMacro Include="PKCS11H_HOME">
-      <Value>$(PKCS11H_HOME)</Value>
+    <BuildMacro Include="SOLUTIONDIR">
+      <Value>$(SOLUTIONDIR)</Value>
       <EnvironmentVariable>true</EnvironmentVariable>
     </BuildMacro>
   </ItemGroup>
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 33b8f19a..91d5ebbe 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -151,7 +151,7 @@
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -166,7 +166,7 @@
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;$(SolutionDir)include;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -181,7 +181,7 @@
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -196,7 +196,7 @@
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
@@ -212,7 +212,7 @@
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
@@ -228,7 +228,7 @@
       <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
       <WarningLevel>Level2</WarningLevel>
       <TreatWarningAsError>true</TreatWarningAsError>
-      <AdditionalIncludeDirectories>..\compat;$(SolutionDir);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+      <AdditionalIncludeDirectories>..\compat;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
     <ResourceCompile />
diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpnmsica.props
index 074635d0..1091c9f4 100644
--- a/src/openvpnmsica/openvpnmsica.props
+++ b/src/openvpnmsica/openvpnmsica.props
@@ -7,7 +7,6 @@
   </PropertyGroup>
   <ItemDefinitionGroup>
     <ClCompile>
-      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_WIN32_WINNT=_WIN32_WINNT_VISTA;%(PreprocessorDefinitions)</PreprocessorDefinitions>
     </ClCompile>
     <Link>
-- 
2.23.0.windows.1


