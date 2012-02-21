From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:40 +0200
Message-Id: <1329787361-26096-35-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH_34/35=5D_build=3A_win-msvc=3A_?=
	=?utf-8?q?msbuild_format?=
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
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore                                    |   10 +-
 Makefile.am                                   |   10 +-
 build/Makefile.am                             |    2 +
 build/msvc/Makefile.am                        |   15 +
 build/msvc/msvc-generate/Makefile.am          |   18 +
 build/msvc/msvc-generate/Makefile.mak         |   13 +
 build/msvc/msvc-generate/msvc-generate.js     |   59 ++
 build/msvc/msvc-generate/msvc-generate.vcproj |   74 +++
 config-msvc-version.h.in                      |   10 +
 config-msvc.h                                 |  117 ++++
 configure.ac                                  |    2 +
 msvc-build.bat                                |   34 ++
 msvc-dev.bat                                  |    9 +
 msvc-env.bat                                  |   21 +
 openvpn.sln                                   |   45 ++
 src/openvpn/Makefile.am                       |    3 +
 src/openvpn/compat.h                          |    2 -
 src/openvpn/crypto_backend.h                  |    2 -
 src/openvpn/openvpn.vcproj                    |  769 +++++++++++++++++++++++++
 src/openvpn/openvpn_win32_resources.rc        |    2 +-
 src/openvpn/syshead.h                         |   14 +-
 src/openvpn/tun.c                             |    2 +-
 src/openvpn/win32.c                           |    2 +-
 src/openvpnserv/Makefile.am                   |    3 +
 src/openvpnserv/openvpnserv.c                 |   16 +-
 src/openvpnserv/openvpnserv.vcproj            |  209 +++++++
 src/openvpnserv/openvpnserv_resources.rc      |    2 +-
 src/openvpnserv/service.c                     |    5 +
 src/openvpnserv/service.h                     |    2 -
 29 files changed, 1452 insertions(+), 20 deletions(-)
 create mode 100644 build/msvc/Makefile.am
 create mode 100644 build/msvc/msvc-generate/Makefile.am
 create mode 100755 build/msvc/msvc-generate/Makefile.mak
 create mode 100644 build/msvc/msvc-generate/msvc-generate.js
 create mode 100644 build/msvc/msvc-generate/msvc-generate.vcproj
 create mode 100644 config-msvc-version.h.in
 create mode 100644 config-msvc.h
 create mode 100644 msvc-build.bat
 create mode 100644 msvc-dev.bat
 create mode 100644 msvc-env.bat
 create mode 100644 openvpn.sln
 create mode 100644 src/openvpn/openvpn.vcproj
 create mode 100644 src/openvpnserv/openvpnserv.vcproj

diff --git a/.gitignore b/.gitignore
index 156b2c2..7e0a4e9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,12 +2,18 @@
 *.dll
 *.exe
 *.exe.*
-*.mak
 *.obj
 *.pyc
 *.so
 *~
 *.idb
+*.suo
+*.ncb
+*.vcproj.*
+*.log
+Release
+Debug
+Win32-Output
 .deps
 Makefile
 Makefile.in
@@ -33,6 +39,8 @@ m4/ltsugar.m4
 m4/ltversion.m4
 m4/lt~obsolete.m4
 
+msvc-build-local.bat
+config-msvc-version.h
 doc/openvpn.8.html
 distro/rpm/openvpn.spec
 tests/t_client.sh
diff --git a/Makefile.am b/Makefile.am
index 66b0c92..3f5e91d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -49,4 +49,12 @@ dist_noinst_DATA = \
 	PORTS \
 	INSTALL-win32.txt \
 	README.IPv6 TODO.IPv6 \
-	README.polarssl
+	README.polarssl \
+	openvpn.sln \
+	msvc-env.bat \
+	msvc-dev.bat \
+	msvc-build.bat
+
+dist_noinst_HEADERS = \
+	config-msvc.h \
+	config-msvc-version.h.in
diff --git a/build/Makefile.am b/build/Makefile.am
index a993b20..b53ff52 100644
--- a/build/Makefile.am
+++ b/build/Makefile.am
@@ -13,3 +13,5 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = \
 	ltrc.inc
+
+SUBDIRS = msvc
diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
new file mode 100644
index 0000000..6fea1b8
--- /dev/null
+++ b/build/msvc/Makefile.am
@@ -0,0 +1,15 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+SUBDIRS = msvc-generate
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
new file mode 100644
index 0000000..6ad1890
--- /dev/null
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -0,0 +1,18 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+dist_noinst_DATA = \
+	msvc-generate.vcproj \
+	Makefile.mak \
+	msvc-generate.js
diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-generate/Makefile.mak
new file mode 100755
index 0000000..72415f1
--- /dev/null
+++ b/build/msvc/msvc-generate/Makefile.mak
@@ -0,0 +1,13 @@
+# Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+
+CONFIG=$(SOURCEBASE)/version.m4
+INPUT=$(SOURCEBASE)/config-msvc-version.h.in
+OUTPUT=$(SOURCEBASE)/config-msvc-version.h
+
+all:	$(OUTPUT)
+
+$(OUTPUT): $(INPUT) $(CONFIG)
+	cscript //nologo msvc-generate.js --config="$(CONFIG)" --input="$(INPUT)" --output="$(OUTPUT)"
+
+clean:
+	-del "$(OUTPUT)"
diff --git a/build/msvc/msvc-generate/msvc-generate.js b/build/msvc/msvc-generate/msvc-generate.js
new file mode 100644
index 0000000..70b90c1
--- /dev/null
+++ b/build/msvc/msvc-generate/msvc-generate.js
@@ -0,0 +1,59 @@
+// Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+
+var ForReading = 1;
+var vars = new Array();
+var fso = new ActiveXObject("Scripting.FileSystemObject");
+var input = "nul";
+var output = "nul";
+var config = "nul";
+
+function initialize() {
+	for (var i=0;i<WScript.Arguments.length;i++) {
+		var arg = WScript.Arguments(i);
+		if (arg.match(/--input=(.*)/)) {
+			input=RegExp.$1;
+		}
+		if (arg.match(/--output=(.*)/)) {
+			output=RegExp.$1;
+		}
+		if (arg.match(/--config=(.*)/)) {
+			config=RegExp.$1;
+		}
+	}
+}
+
+function process_config(file) {
+	var fin = fso.OpenTextFile(file, ForReading);
+
+	while (!fin.AtEndOfStream) {
+		var content = fin.ReadLine();
+		if (content.match(/define\(\[(.*)\], \[(.*)\]\)/)) {
+			vars[RegExp.$1] = RegExp.$2;
+		}
+	}
+}
+
+function process_file(input, output) {
+	var fin = fso.OpenTextFile(input, ForReading);
+	var fout = fso.CreateTextFile(output);
+	var content = fin.ReadAll();
+
+	for (var i in vars) {
+		content = content.replace(new RegExp("@"+i+"@", "g"), vars[i]);
+	}
+
+	fout.Write(content);
+}
+
+function main() {
+	initialize();
+
+	process_config(config);
+
+	process_file(
+		input,
+		output
+	);
+}
+
+main();
diff --git a/build/msvc/msvc-generate/msvc-generate.vcproj b/build/msvc/msvc-generate/msvc-generate.vcproj
new file mode 100644
index 0000000..3b7dc18
--- /dev/null
+++ b/build/msvc/msvc-generate/msvc-generate.vcproj
@@ -0,0 +1,74 @@
+<?xml version="1.0" encoding="Windows-1252"?>
+<VisualStudioProject
+	ProjectType="Visual C++"
+	Version="9.00"
+	Name="msvc-generate"
+	ProjectGUID="{8598C2C8-34C4-47A1-99B0-7C295A890615}"
+	RootNamespace="msvc-generate"
+	Keyword="MakeFileProj"
+	TargetFrameworkVersion="196613"
+	>
+	<Platforms>
+		<Platform
+			Name="Win32"
+		/>
+	</Platforms>
+	<ToolFiles>
+	</ToolFiles>
+	<Configurations>
+		<Configuration
+			Name="Debug|Win32"
+			OutputDirectory="$(ConfigurationName)"
+			IntermediateDirectory="$(ConfigurationName)"
+			ConfigurationType="0"
+			>
+			<Tool
+				Name="VCNMakeTool"
+				BuildCommandLine="nmake -f Makefile.mak all"
+				ReBuildCommandLine="nmake -f Makefile.mak clean all"
+				CleanCommandLine="nmake -f Makefile.mak clean"
+				Output="config-msvc-version.h"
+				PreprocessorDefinitions="WIN32;_DEBUG"
+				IncludeSearchPath=""
+				ForcedIncludes=""
+				AssemblySearchPath=""
+				ForcedUsingAssemblies=""
+				CompileAsManaged=""
+			/>
+		</Configuration>
+		<Configuration
+			Name="Release|Win32"
+			OutputDirectory="$(ConfigurationName)"
+			IntermediateDirectory="$(ConfigurationName)"
+			ConfigurationType="0"
+			>
+			<Tool
+				Name="VCNMakeTool"
+				BuildCommandLine="nmake -f Makefile.mak all"
+				ReBuildCommandLine="nmake -f Makefile.mak clean all"
+				CleanCommandLine="nmake -f Makefile.mak clean"
+				Output="config-msvc-version.h"
+				PreprocessorDefinitions="WIN32;NDEBUG"
+				IncludeSearchPath=""
+				ForcedIncludes=""
+				AssemblySearchPath=""
+				ForcedUsingAssemblies=""
+				CompileAsManaged=""
+			/>
+		</Configuration>
+	</Configurations>
+	<References>
+	</References>
+	<Files>
+		<File
+			RelativePath=".\Makefile.mak"
+			>
+		</File>
+		<File
+			RelativePath=".\msc-generate.js"
+			>
+		</File>
+	</Files>
+	<Globals>
+	</Globals>
+</VisualStudioProject>
diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
new file mode 100644
index 0000000..4bc89e7
--- /dev/null
+++ b/config-msvc-version.h.in
@@ -0,0 +1,10 @@
+#define PACKAGE_NAME "@PRODUCT_NAME@"
+#define PACKAGE_STRING "@PRODUCT_NAME@ @PRODUCT_VERSION@"
+#define PACKAGE_TARNAME "@PRODUCT_TARNAME@"
+#define PACKAGE "@PRODUCT_TARNAME@"
+#define PACKAGE_VERSION "@PRODUCT_VERSION@"
+#define PRODUCT_BUGREPORT "@PRODUCT_BUGREPORT@"
+#define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@
+#define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
+#define TAP_WIN_MIN_MAJOR @PRODUCT_TAP_WIN_MIN_MAJOR@
+#define TAP_WIN_MIN_MINOR @PRODUCT_TAP_WIN_MIN_MINOR@
diff --git a/config-msvc.h b/config-msvc.h
new file mode 100644
index 0000000..6f9072c
--- /dev/null
+++ b/config-msvc.h
@@ -0,0 +1,117 @@
+#include <config-msvc-version.h>
+
+#define CONFIGURE_DEFINES "N/A"
+
+#define ENABLE_DEF_AUTH 1
+#define ENABLE_PF 1
+#define ENABLE_CLIENT_SERVER 1
+#define ENABLE_CRYPTO 1
+#define ENABLE_CRYPTO_OPENSSL 1
+#define ENABLE_DEBUG 1
+#define ENABLE_EUREPHIA 1
+#define ENABLE_FRAGMENT 1
+#define ENABLE_HTTP_PROXY 1
+#define ENABLE_LZO 1
+#define ENABLE_MANAGEMENT 1
+#define ENABLE_MULTIHOME 1
+#define ENABLE_PKCS11 1
+#define ENABLE_PLUGIN 1
+#define ENABLE_PORT_SHARE 1
+#define ENABLE_SOCKS 1
+#define ENABLE_SSL 1
+
+#define HAVE_ERRNO_H 1
+#define HAVE_FCNTL_H 1
+#define HAVE_CTYPE_H 1
+#define HAVE_STDARG_H 1
+#define HAVE_STDIO_H 1
+#define HAVE_STDLIB_H 1
+#define HAVE_STRDUP 1
+#define HAVE_STRERROR 1
+#define HAVE_STRINGS_H 1
+#define HAVE_STRING_H 1
+#define HAVE_SYSTEM 1
+#define HAVE_TIME 1
+#define HAVE_TIME_H 1
+#define HAVE_UNLINK 1
+#define HAVE_VSNPRINTF 1
+#define HAVE_WINDOWS_H 1
+#define HAVE_WINSOCK2_H 1
+#define HAVE_WS2TCPIP_H 1
+#define HAVE_IO_H 1
+#define HAVE_DIRECT_H 1
+#define HAVE_SYS_TYPES_H 1
+#define HAVE_SYS_STAT_H 1
+#define HAVE_LZO_LZO1X_H 1
+#define HAVE_LZO_LZOUTIL_H 1
+
+#define HAVE_ACCESS 1
+#define HAVE_CHDIR 1
+#define HAVE_CHSIZE 1
+#define HAVE_CPP_VARARG_MACRO_ISO 1
+#define HAVE_CTIME 1
+#define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
+#define HAVE_GETTIMEOFDAY 1
+#define HAVE_IN_PKTINFO 1
+#define HAVE_MEMSET 1
+#define HAVE_PUTENV 1
+#define HAVE_STAT 1
+
+#define HAVE_SOCKET 1
+#define HAVE_RECV 1
+#define HAVE_RECVFROM 1
+#define HAVE_SEND 1
+#define HAVE_SENDTO 1
+#define HAVE_LISTEN 1
+#define HAVE_ACCEPT 1
+#define HAVE_CONNECT 1
+#define HAVE_BIND 1
+#define HAVE_SELECT 1
+#define HAVE_GETHOSTBYNAME 1
+#define HAVE_INET_NTOA 1
+#define HAVE_SETSOCKOPT 1
+#define HAVE_GETSOCKOPT 1
+#define HAVE_GETSOCKNAME 1
+#define HAVE_POLL 1
+
+#define HAVE_OPENSSL_ENGINE 1
+
+#ifndef __cplusplus
+#define inline __inline
+#endif
+
+#define EMPTY_ARRAY_SIZE 0
+#define TARGET_WIN32 1
+#define TARGET_ALIAS "Windows-MSVC"
+
+#define HAVE_DECL_SO_MARK 0
+
+#define strncasecmp strnicmp
+#define strcasecmp _stricmp
+#define snprintf _snprintf
+#define strtoull strtoul
+
+#define in_addr_t uint32_t
+#define ssize_t SSIZE_T
+
+#define S_IRUSR 0
+#define S_IWUSR 0
+#define R_OK 4
+#define W_OK 2
+#define X_OK 1
+#define F_OK 0
+
+#define SIGHUP    1
+#define SIGINT    2
+#define SIGUSR1   10
+#define SIGUSR2   12
+#define SIGTERM   15
+
+typedef unsigned __int64	uint64_t;
+typedef unsigned __int32	uint32_t;
+typedef unsigned __int16	uint16_t;
+typedef unsigned __int8		uint8_t;
+typedef __int64		int64_t;
+typedef __int32		int32_t;
+typedef __int16		int16_t;
+typedef __int8		int8_t;
diff --git a/configure.ac b/configure.ac
index 7c4bd9d..4177001 100644
--- a/configure.ac
+++ b/configure.ac
@@ -880,6 +880,8 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 AC_CONFIG_FILES([
 	Makefile
 	build/Makefile
+	build/msvc/Makefile
+	build/msvc/msvc-generate/Makefile
 	distro/Makefile
 	distro/rpm/Makefile
 	distro/rpm/openvpn.spec
diff --git a/msvc-build.bat b/msvc-build.bat
new file mode 100644
index 0000000..0050080
--- /dev/null
+++ b/msvc-build.bat
@@ -0,0 +1,34 @@
+@echo off
+
+rem Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+
+call msvc-env.bat
+
+@rem this stupid command needed for SetEnv.cmd to operate
+setlocal ENABLEDELAYEDEXPANSION
+
+SET PLATFORMS=Win32
+SET CONFIGURATIONS=Debug,Release
+
+call "%VCHOME%\bin\vcvars32.bat"
+
+for %%p in (%PLATFORMS%) do (
+	for %%c in (%CONFIGURATIONS%) do (
+		rmdir /q /s %SOURCEBASE%\%%p\%%c > nul 2>&1
+
+		vcbuild /errfile:error.log /showenv %SOLUTION% /rebuild /platform:%%p "%%c|%%p"
+		for %%f in (error.log) do if %%~zf GTR 0 goto error
+	)
+)
+
+exit /b 0
+goto end
+
+:error
+if "%1" NEQ "batch" pause
+exit /b 1
+goto end
+
+:end
+
+endlocal
diff --git a/msvc-dev.bat b/msvc-dev.bat
new file mode 100644
index 0000000..671a56d
--- /dev/null
+++ b/msvc-dev.bat
@@ -0,0 +1,9 @@
+@echo off
+
+setlocal
+cd %0\..
+call msvc-env.bat
+
+start "" "%VSHOME%\Common7\IDE\devenv.exe" %SOLUTION%
+
+endlocal
diff --git a/msvc-env.bat b/msvc-env.bat
new file mode 100644
index 0000000..20f54d7
--- /dev/null
+++ b/msvc-env.bat
@@ -0,0 +1,21 @@
+@echo off
+
+cd %0\..
+
+rem Put your own settings at msvc-env-local.bat
+if exist msvc-env-local.bat call msvc-env-local.bat
+
+if "%ProgramFiles(x86)%"=="" SET ProgramFiles(x86)=%ProgramFiles%
+if "%VS90COMNTOOLS%"=="" SET VS90COMNTOOLS=%ProgramFiles(x86)%\Microsoft Visual Studio 9.0\Common7\Tools\
+if "%VSHOME%"=="" SET VSHOME=%VS90COMNTOOLS%..\..
+if "%VCHOME%"=="" SET VCHOME=%VSHOME%\VC
+
+SET SOURCEBASE=%cd%
+SET SOLUTION=openvpn.sln
+SET CFLAGS=_CRT_SECURE_NO_WARNINGS;WIN32_LEAN_AND_MEAN;WINVER=0x0501;_CRT_NONSTDC_NO_WARNINGS;_CRT_SECURE_NO_WARNINGS;_USE_32BIT_TIME_T
+
+IF "%OPENVPN_DEPROOT%" == "" SET OPENVPN_DEPROOT=c:\Temp\openvpn-deps
+IF "%OPENSSL_HOME%" == "" SET OPENSSL_HOME=%OPENVPN_DEPROOT%
+IF "%LZO_HOME%" == "" SET LZO_HOME=%OPENVPN_DEPROOT%
+IF "%PKCS11H_HOME%" == "" SET PKCS11H_HOME=%OPENVPN_DEPROOT%
+
diff --git a/openvpn.sln b/openvpn.sln
new file mode 100644
index 0000000..cbd2093
--- /dev/null
+++ b/openvpn.sln
@@ -0,0 +1,45 @@
+﻿
+Microsoft Visual Studio Solution File, Format Version 10.00
+# Visual Studio 2008
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnserv", "src\openvpnserv\openvpnserv.vcproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
+	ProjectSection(ProjectDependencies) = postProject
+		{8598C2C8-34C4-47A1-99B0-7C295A890615} = {8598C2C8-34C4-47A1-99B0-7C295A890615}
+	EndProjectSection
+EndProject
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpn", "src\openvpn\openvpn.vcproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
+	ProjectSection(ProjectDependencies) = postProject
+		{8598C2C8-34C4-47A1-99B0-7C295A890615} = {8598C2C8-34C4-47A1-99B0-7C295A890615}
+	EndProjectSection
+EndProject
+Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") = "misc", "misc", "{1AA03DE8-3F08-45B9-B4ED-D7769A445DF3}"
+	ProjectSection(SolutionItems) = preProject
+		config-msvc-version.h.in = config-msvc-version.h.in
+		config-msvc.h = config-msvc.h
+		version.m4 = version.m4
+	EndProjectSection
+EndProject
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "msvc-generate", "build\msvc\msvc-generate\msvc-generate.vcproj", "{8598C2C8-34C4-47A1-99B0-7C295A890615}"
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
+	EndGlobalSection
+	GlobalSection(SolutionProperties) = preSolution
+		HideSolutionNode = FALSE
+	EndGlobalSection
+EndGlobal
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ec5bbbf..cc7061d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -14,6 +14,9 @@ include $(top_srcdir)/build/ltrc.inc
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
+EXTRA_DIST = \
+	openvpn.vcproj
+
 INCLUDES = -I$(top_srcdir)/include
 
 AM_CFLAGS = \
diff --git a/src/openvpn/compat.h b/src/openvpn/compat.h
index b380f0b..7af9fe2 100644
--- a/src/openvpn/compat.h
+++ b/src/openvpn/compat.h
@@ -25,8 +25,6 @@
 #ifndef COMPAT_H
 #define COMPAT_H
 
-#include "config.h"
-
 #if defined(HAVE_BASENAME) || defined(HAVE_DIRNAME)
 #include <libgen.h>
 #endif
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 57f2ac4..1eac611 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -30,8 +30,6 @@
 #ifndef CRYPTO_BACKEND_H_
 #define CRYPTO_BACKEND_H_
 
-#include "config.h"
-
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "crypto_openssl.h"
 #endif
diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
new file mode 100644
index 0000000..7627315
--- /dev/null
+++ b/src/openvpn/openvpn.vcproj
@@ -0,0 +1,769 @@
+<?xml version="1.0" encoding="Windows-1252"?>
+<VisualStudioProject
+	ProjectType="Visual C++"
+	Version="9.00"
+	Name="openvpn"
+	ProjectGUID="{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
+	RootNamespace="openvpn"
+	Keyword="Win32Proj"
+	TargetFrameworkVersion="196613"
+	>
+	<Platforms>
+		<Platform
+			Name="Win32"
+		/>
+	</Platforms>
+	<ToolFiles>
+	</ToolFiles>
+	<Configurations>
+		<Configuration
+			Name="Debug|Win32"
+			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
+			IntermediateDirectory="$(ConfigurationName)"
+			ConfigurationType="1"
+			CharacterSet="2"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				Optimization="0"
+				AdditionalIncludeDirectories="$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
+				PreprocessorDefinitions="WIN32;_DEBUG;_CONSOLE;$(CFLAGS)"
+				MinimalRebuild="true"
+				BasicRuntimeChecks="3"
+				RuntimeLibrary="3"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="4"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+				AdditionalIncludeDirectories="$(SOURCEBASE)"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLinkerTool"
+				AdditionalDependencies="libeay32.lib ssleay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
+				LinkIncremental="2"
+				AdditionalLibraryDirectories="$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
+				GenerateDebugInformation="true"
+				SubSystem="1"
+				TargetMachine="1"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCManifestTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCAppVerifierTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+		<Configuration
+			Name="Release|Win32"
+			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
+			IntermediateDirectory="$(ConfigurationName)"
+			ConfigurationType="1"
+			CharacterSet="2"
+			WholeProgramOptimization="1"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				Optimization="2"
+				EnableIntrinsicFunctions="true"
+				AdditionalIncludeDirectories="$(SOURCEBASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
+				PreprocessorDefinitions="WIN32;NDEBUG;_CONSOLE;$(CFLAGS)"
+				RuntimeLibrary="2"
+				EnableFunctionLevelLinking="true"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="3"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+				AdditionalIncludeDirectories="$(SOURCEBASE)"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLinkerTool"
+				AdditionalDependencies="libeay32.lib ssleay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
+				LinkIncremental="1"
+				AdditionalLibraryDirectories="$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
+				GenerateDebugInformation="true"
+				SubSystem="1"
+				OptimizeReferences="2"
+				EnableCOMDATFolding="2"
+				TargetMachine="1"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCManifestTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCAppVerifierTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+	</Configurations>
+	<References>
+	</References>
+	<Files>
+		<Filter
+			Name="Source Files"
+			Filter="cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx"
+			UniqueIdentifier="{4FC737F1-C7A5-4376-A066-2A32D752A2FF}"
+			>
+			<File
+				RelativePath=".\base64.c"
+				>
+			</File>
+			<File
+				RelativePath=".\buffer.c"
+				>
+			</File>
+			<File
+				RelativePath=".\clinat.c"
+				>
+			</File>
+			<File
+				RelativePath=".\compat.c"
+				>
+			</File>
+			<File
+				RelativePath=".\crypto.c"
+				>
+			</File>
+			<File
+				RelativePath=".\crypto_openssl.c"
+				>
+			</File>
+			<File
+				RelativePath=".\cryptoapi.c"
+				>
+			</File>
+			<File
+				RelativePath=".\dhcp.c"
+				>
+			</File>
+			<File
+				RelativePath=".\error.c"
+				>
+			</File>
+			<File
+				RelativePath=".\event.c"
+				>
+			</File>
+			<File
+				RelativePath=".\fdmisc.c"
+				>
+			</File>
+			<File
+				RelativePath=".\forward.c"
+				>
+			</File>
+			<File
+				RelativePath=".\fragment.c"
+				>
+			</File>
+			<File
+				RelativePath=".\gremlin.c"
+				>
+			</File>
+			<File
+				RelativePath=".\helper.c"
+				>
+			</File>
+			<File
+				RelativePath=".\httpdigest.c"
+				>
+			</File>
+			<File
+				RelativePath=".\init.c"
+				>
+			</File>
+			<File
+				RelativePath=".\interval.c"
+				>
+			</File>
+			<File
+				RelativePath=".\list.c"
+				>
+			</File>
+			<File
+				RelativePath=".\lladdr.c"
+				>
+			</File>
+			<File
+				RelativePath=".\lzo.c"
+				>
+			</File>
+			<File
+				RelativePath=".\manage.c"
+				>
+			</File>
+			<File
+				RelativePath=".\mbuf.c"
+				>
+			</File>
+			<File
+				RelativePath=".\misc.c"
+				>
+			</File>
+			<File
+				RelativePath=".\mroute.c"
+				>
+			</File>
+			<File
+				RelativePath=".\mss.c"
+				>
+			</File>
+			<File
+				RelativePath=".\mstats.c"
+				>
+			</File>
+			<File
+				RelativePath=".\mtcp.c"
+				>
+			</File>
+			<File
+				RelativePath=".\mtu.c"
+				>
+			</File>
+			<File
+				RelativePath=".\mudp.c"
+				>
+			</File>
+			<File
+				RelativePath=".\multi.c"
+				>
+			</File>
+			<File
+				RelativePath=".\ntlm.c"
+				>
+			</File>
+			<File
+				RelativePath=".\occ.c"
+				>
+			</File>
+			<File
+				RelativePath=".\openvpn.c"
+				>
+			</File>
+			<File
+				RelativePath=".\options.c"
+				>
+			</File>
+			<File
+				RelativePath=".\otime.c"
+				>
+			</File>
+			<File
+				RelativePath=".\packet_id.c"
+				>
+			</File>
+			<File
+				RelativePath=".\perf.c"
+				>
+			</File>
+			<File
+				RelativePath=".\pf.c"
+				>
+			</File>
+			<File
+				RelativePath=".\ping.c"
+				>
+			</File>
+			<File
+				RelativePath=".\pkcs11.c"
+				>
+			</File>
+			<File
+				RelativePath=".\pkcs11_openssl.c"
+				>
+			</File>
+			<File
+				RelativePath=".\plugin.c"
+				>
+			</File>
+			<File
+				RelativePath=".\pool.c"
+				>
+			</File>
+			<File
+				RelativePath=".\proto.c"
+				>
+			</File>
+			<File
+				RelativePath=".\proxy.c"
+				>
+			</File>
+			<File
+				RelativePath=".\ps.c"
+				>
+			</File>
+			<File
+				RelativePath=".\push.c"
+				>
+			</File>
+			<File
+				RelativePath=".\reliable.c"
+				>
+			</File>
+			<File
+				RelativePath=".\route.c"
+				>
+			</File>
+			<File
+				RelativePath=".\schedule.c"
+				>
+			</File>
+			<File
+				RelativePath=".\session_id.c"
+				>
+			</File>
+			<File
+				RelativePath=".\shaper.c"
+				>
+			</File>
+			<File
+				RelativePath=".\sig.c"
+				>
+			</File>
+			<File
+				RelativePath=".\socket.c"
+				>
+			</File>
+			<File
+				RelativePath=".\socks.c"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl.c"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_openssl.c"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_verify.c"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_verify_openssl.c"
+				>
+			</File>
+			<File
+				RelativePath=".\status.c"
+				>
+			</File>
+			<File
+				RelativePath=".\tun.c"
+				>
+			</File>
+			<File
+				RelativePath=".\win32.c"
+				>
+			</File>
+		</Filter>
+		<Filter
+			Name="Header Files"
+			Filter="h;hpp;hxx;hm;inl;inc;xsd"
+			UniqueIdentifier="{93995380-89BD-4b04-88EB-625FBE52EBFB}"
+			>
+			<File
+				RelativePath=".\base64.h"
+				>
+			</File>
+			<File
+				RelativePath=".\basic.h"
+				>
+			</File>
+			<File
+				RelativePath=".\buffer.h"
+				>
+			</File>
+			<File
+				RelativePath=".\circ_list.h"
+				>
+			</File>
+			<File
+				RelativePath=".\clinat.h"
+				>
+			</File>
+			<File
+				RelativePath=".\common.h"
+				>
+			</File>
+			<File
+				RelativePath=".\compat.h"
+				>
+			</File>
+			<File
+				RelativePath=".\crypto.h"
+				>
+			</File>
+			<File
+				RelativePath=".\crypto_backend.h"
+				>
+			</File>
+			<File
+				RelativePath=".\crypto_openssl.h"
+				>
+			</File>
+			<File
+				RelativePath=".\cryptoapi.h"
+				>
+			</File>
+			<File
+				RelativePath=".\dhcp.h"
+				>
+			</File>
+			<File
+				RelativePath=".\errlevel.h"
+				>
+			</File>
+			<File
+				RelativePath=".\error.h"
+				>
+			</File>
+			<File
+				RelativePath=".\event.h"
+				>
+			</File>
+			<File
+				RelativePath=".\fdmisc.h"
+				>
+			</File>
+			<File
+				RelativePath=".\forward-inline.h"
+				>
+			</File>
+			<File
+				RelativePath=".\forward.h"
+				>
+			</File>
+			<File
+				RelativePath=".\fragment.h"
+				>
+			</File>
+			<File
+				RelativePath=".\gremlin.h"
+				>
+			</File>
+			<File
+				RelativePath=".\helper.h"
+				>
+			</File>
+			<File
+				RelativePath=".\httpdigest.h"
+				>
+			</File>
+			<File
+				RelativePath=".\init.h"
+				>
+			</File>
+			<File
+				RelativePath=".\integer.h"
+				>
+			</File>
+			<File
+				RelativePath=".\interval.h"
+				>
+			</File>
+			<File
+				RelativePath=".\list.h"
+				>
+			</File>
+			<File
+				RelativePath=".\lladdr.h"
+				>
+			</File>
+			<File
+				RelativePath=".\lzo.h"
+				>
+			</File>
+			<File
+				RelativePath=".\manage.h"
+				>
+			</File>
+			<File
+				RelativePath=".\mbuf.h"
+				>
+			</File>
+			<File
+				RelativePath=".\memdbg.h"
+				>
+			</File>
+			<File
+				RelativePath=".\misc.h"
+				>
+			</File>
+			<File
+				RelativePath=".\mroute.h"
+				>
+			</File>
+			<File
+				RelativePath=".\mss.h"
+				>
+			</File>
+			<File
+				RelativePath=".\mstats.h"
+				>
+			</File>
+			<File
+				RelativePath=".\mtcp.h"
+				>
+			</File>
+			<File
+				RelativePath=".\mtu.h"
+				>
+			</File>
+			<File
+				RelativePath=".\mudp.h"
+				>
+			</File>
+			<File
+				RelativePath=".\multi.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ntlm.h"
+				>
+			</File>
+			<File
+				RelativePath=".\occ-inline.h"
+				>
+			</File>
+			<File
+				RelativePath=".\occ.h"
+				>
+			</File>
+			<File
+				RelativePath=".\openvpn.h"
+				>
+			</File>
+			<File
+				RelativePath=".\options.h"
+				>
+			</File>
+			<File
+				RelativePath=".\otime.h"
+				>
+			</File>
+			<File
+				RelativePath=".\packet_id.h"
+				>
+			</File>
+			<File
+				RelativePath=".\perf.h"
+				>
+			</File>
+			<File
+				RelativePath=".\pf-inline.h"
+				>
+			</File>
+			<File
+				RelativePath=".\pf.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ping-inline.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ping.h"
+				>
+			</File>
+			<File
+				RelativePath=".\pkcs11.h"
+				>
+			</File>
+			<File
+				RelativePath=".\pkcs11_backend.h"
+				>
+			</File>
+			<File
+				RelativePath=".\plugin.h"
+				>
+			</File>
+			<File
+				RelativePath=".\pool.h"
+				>
+			</File>
+			<File
+				RelativePath=".\proto.h"
+				>
+			</File>
+			<File
+				RelativePath=".\proxy.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ps.h"
+				>
+			</File>
+			<File
+				RelativePath=".\push.h"
+				>
+			</File>
+			<File
+				RelativePath=".\pushlist.h"
+				>
+			</File>
+			<File
+				RelativePath=".\reliable.h"
+				>
+			</File>
+			<File
+				RelativePath=".\route.h"
+				>
+			</File>
+			<File
+				RelativePath=".\schedule.h"
+				>
+			</File>
+			<File
+				RelativePath=".\session_id.h"
+				>
+			</File>
+			<File
+				RelativePath=".\shaper.h"
+				>
+			</File>
+			<File
+				RelativePath=".\sig.h"
+				>
+			</File>
+			<File
+				RelativePath=".\socket.h"
+				>
+			</File>
+			<File
+				RelativePath=".\socks.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_backend.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_common.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_openssl.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_verify.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_verify_backend.h"
+				>
+			</File>
+			<File
+				RelativePath=".\ssl_verify_openssl.h"
+				>
+			</File>
+			<File
+				RelativePath=".\status.h"
+				>
+			</File>
+			<File
+				RelativePath=".\syshead.h"
+				>
+			</File>
+			<File
+				RelativePath=".\tun.h"
+				>
+			</File>
+			<File
+				RelativePath=".\win32.h"
+				>
+			</File>
+		</Filter>
+		<Filter
+			Name="Resource Files"
+			Filter="rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav"
+			UniqueIdentifier="{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}"
+			>
+			<File
+				RelativePath=".\openvpn_win32_resources.rc"
+				>
+			</File>
+		</Filter>
+	</Files>
+	<Globals>
+	</Globals>
+</VisualStudioProject>
diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn_win32_resources.rc
index e91bfa1..c385baa 100644
--- a/src/openvpn/openvpn_win32_resources.rc
+++ b/src/openvpn/openvpn_win32_resources.rc
@@ -1,7 +1,7 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #else
-#include <config-msc-version.h>
+#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index cdcfbda..eb73504 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -28,11 +28,13 @@
 /*
  * Only include if not during configure
  */
-#ifndef PACKAGE_NAME
+#ifdef HAVE_CONFIG_H
 #include "config.h"
-#include "compat.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
 #endif
 
+#include "compat.h"
 
 /* branch prediction hints */
 #if defined(__GNUC__)
@@ -102,6 +104,14 @@
 #include <fcntl.h>
 #endif
 
+#ifdef HAVE_DIRECT_H
+#include <direct.h>
+#endif
+
+#ifdef HAVE_IO_H
+#include <io.h>
+#endif
+
 #ifdef HAVE_SYS_FILE_H
 #include <sys/file.h>
 #endif
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7b74ebd..9df7126 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3624,7 +3624,7 @@ get_adapter_index_method_1 (const char *guid)
   ULONG index = ~0;
   DWORD status;
   wchar_t wbuf[256];
-  snwprintf (wbuf, SIZE (wbuf), L"\\DEVICE\\TCPIP_%S", guid);
+  _snwprintf (wbuf, SIZE (wbuf), L"\\DEVICE\\TCPIP_%S", guid);
   wbuf [SIZE(wbuf) - 1] = 0;
   if ((status = GetAdapterIndex (wbuf, &index)) != NO_ERROR)
     index = ~0;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 2ba97fc..a2a007f 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -611,7 +611,7 @@ window_title_generate (const char *title)
   struct buffer out = alloc_buf_gc (256, &gc);
   if (!title)
     title = "";
-  buf_printf (&out, "[%s] " PACKAGE_NAME " " VERSION " F4:EXIT F1:USR1 F2:USR2 F3:HUP", title);
+  buf_printf (&out, "[%s] " PACKAGE_NAME " " PACKAGE_VERSION " F4:EXIT F1:USR1 F2:USR2 F3:HUP", title);
   SetConsoleTitle (BSTR (&out));
   gc_free (&gc);
 }
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index f5a59fb..53501f6 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -13,6 +13,9 @@ include $(top_srcdir)/build/ltrc.inc
 
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
+EXTRA_DIST = \
+	openvpnserv.vcproj
+
 if WIN32
 sbin_PROGRAMS = openvpnserv
 endif
diff --git a/src/openvpnserv/openvpnserv.c b/src/openvpnserv/openvpnserv.c
index 0993064..a9a9441 100755
--- a/src/openvpnserv/openvpnserv.c
+++ b/src/openvpnserv/openvpnserv.c
@@ -33,7 +33,11 @@
  * This code is designed to be built with the mingw compiler.
  */
 
+#ifdef HAVE_CONFIG_H
 #include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
 #include <windows.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -196,7 +200,7 @@ match (const WIN32_FIND_DATA *find, const char *ext)
   if (i < 1)
     return false;
 
-  return find->cFileName[i] == '.' && !strcasecmp (find->cFileName + i + 1, ext);
+  return find->cFileName[i] == '.' && !_stricmp (find->cFileName + i + 1, ext);
 }
 
 /*
@@ -331,15 +335,15 @@ VOID ServiceStart (DWORD dwArgc, LPTSTR *lpszArgv)
 
   /* set process priority */
   priority = NORMAL_PRIORITY_CLASS;
-  if (!strcasecmp (priority_string, "IDLE_PRIORITY_CLASS"))
+  if (!_stricmp (priority_string, "IDLE_PRIORITY_CLASS"))
     priority = IDLE_PRIORITY_CLASS;
-  else if (!strcasecmp (priority_string, "BELOW_NORMAL_PRIORITY_CLASS"))
+  else if (!_stricmp (priority_string, "BELOW_NORMAL_PRIORITY_CLASS"))
     priority = BELOW_NORMAL_PRIORITY_CLASS;
-  else if (!strcasecmp (priority_string, "NORMAL_PRIORITY_CLASS"))
+  else if (!_stricmp (priority_string, "NORMAL_PRIORITY_CLASS"))
     priority = NORMAL_PRIORITY_CLASS;
-  else if (!strcasecmp (priority_string, "ABOVE_NORMAL_PRIORITY_CLASS"))
+  else if (!_stricmp (priority_string, "ABOVE_NORMAL_PRIORITY_CLASS"))
     priority = ABOVE_NORMAL_PRIORITY_CLASS;
-  else if (!strcasecmp (priority_string, "HIGH_PRIORITY_CLASS"))
+  else if (!_stricmp (priority_string, "HIGH_PRIORITY_CLASS"))
     priority = HIGH_PRIORITY_CLASS;
   else
     {
diff --git a/src/openvpnserv/openvpnserv.vcproj b/src/openvpnserv/openvpnserv.vcproj
new file mode 100644
index 0000000..35db07a
--- /dev/null
+++ b/src/openvpnserv/openvpnserv.vcproj
@@ -0,0 +1,209 @@
+<?xml version="1.0" encoding="Windows-1252"?>
+<VisualStudioProject
+	ProjectType="Visual C++"
+	Version="9.00"
+	Name="openvpnserv"
+	ProjectGUID="{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
+	RootNamespace="openvpnserv"
+	Keyword="Win32Proj"
+	TargetFrameworkVersion="196613"
+	>
+	<Platforms>
+		<Platform
+			Name="Win32"
+		/>
+	</Platforms>
+	<ToolFiles>
+	</ToolFiles>
+	<Configurations>
+		<Configuration
+			Name="Debug|Win32"
+			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
+			IntermediateDirectory="$(ConfigurationName)"
+			ConfigurationType="1"
+			CharacterSet="2"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				Optimization="0"
+				AdditionalIncludeDirectories="$(SOURCEBASE)"
+				PreprocessorDefinitions="WIN32;_DEBUG;_CONSOLE;$(CFLAGS)"
+				MinimalRebuild="true"
+				BasicRuntimeChecks="3"
+				RuntimeLibrary="3"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="4"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+				AdditionalIncludeDirectories="$(SOURCEBASE)"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLinkerTool"
+				LinkIncremental="2"
+				GenerateDebugInformation="true"
+				SubSystem="1"
+				TargetMachine="1"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCManifestTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCAppVerifierTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+		<Configuration
+			Name="Release|Win32"
+			OutputDirectory="$(SolutionDir)$(PlatformName)-Output\$(ConfigurationName)"
+			IntermediateDirectory="$(ConfigurationName)"
+			ConfigurationType="1"
+			CharacterSet="2"
+			WholeProgramOptimization="1"
+			>
+			<Tool
+				Name="VCPreBuildEventTool"
+			/>
+			<Tool
+				Name="VCCustomBuildTool"
+			/>
+			<Tool
+				Name="VCXMLDataGeneratorTool"
+			/>
+			<Tool
+				Name="VCWebServiceProxyGeneratorTool"
+			/>
+			<Tool
+				Name="VCMIDLTool"
+			/>
+			<Tool
+				Name="VCCLCompilerTool"
+				Optimization="2"
+				EnableIntrinsicFunctions="true"
+				AdditionalIncludeDirectories="$(SOURCEBASE)"
+				PreprocessorDefinitions="WIN32;NDEBUG;_CONSOLE;$(CFLAGS)"
+				RuntimeLibrary="2"
+				EnableFunctionLevelLinking="true"
+				UsePrecompiledHeader="0"
+				WarningLevel="3"
+				DebugInformationFormat="3"
+			/>
+			<Tool
+				Name="VCManagedResourceCompilerTool"
+			/>
+			<Tool
+				Name="VCResourceCompilerTool"
+				AdditionalIncludeDirectories="$(SOURCEBASE)"
+			/>
+			<Tool
+				Name="VCPreLinkEventTool"
+			/>
+			<Tool
+				Name="VCLinkerTool"
+				LinkIncremental="1"
+				GenerateDebugInformation="true"
+				SubSystem="1"
+				OptimizeReferences="2"
+				EnableCOMDATFolding="2"
+				TargetMachine="1"
+			/>
+			<Tool
+				Name="VCALinkTool"
+			/>
+			<Tool
+				Name="VCManifestTool"
+			/>
+			<Tool
+				Name="VCXDCMakeTool"
+			/>
+			<Tool
+				Name="VCBscMakeTool"
+			/>
+			<Tool
+				Name="VCFxCopTool"
+			/>
+			<Tool
+				Name="VCAppVerifierTool"
+			/>
+			<Tool
+				Name="VCPostBuildEventTool"
+			/>
+		</Configuration>
+	</Configurations>
+	<References>
+	</References>
+	<Files>
+		<Filter
+			Name="Source Files"
+			Filter="cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx"
+			UniqueIdentifier="{4FC737F1-C7A5-4376-A066-2A32D752A2FF}"
+			>
+			<File
+				RelativePath=".\openvpnserv.c"
+				>
+			</File>
+			<File
+				RelativePath=".\service.c"
+				>
+			</File>
+		</Filter>
+		<Filter
+			Name="Header Files"
+			Filter="h;hpp;hxx;hm;inl;inc;xsd"
+			UniqueIdentifier="{93995380-89BD-4b04-88EB-625FBE52EBFB}"
+			>
+			<File
+				RelativePath=".\service.h"
+				>
+			</File>
+		</Filter>
+		<Filter
+			Name="Resource Files"
+			Filter="rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav"
+			UniqueIdentifier="{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}"
+			>
+			<File
+				RelativePath=".\openvpnserv_resources.rc"
+				>
+			</File>
+		</Filter>
+	</Files>
+	<Globals>
+	</Globals>
+</VisualStudioProject>
diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/openvpnserv_resources.rc
index b87f4a3..c5a7bf6 100644
--- a/src/openvpnserv/openvpnserv_resources.rc
+++ b/src/openvpnserv/openvpnserv_resources.rc
@@ -1,7 +1,7 @@
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #else
-#include <config-msc-version.h>
+#include <config-msvc-version.h>
 #endif
 #include <winresrc.h>
 
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 91b5821..d7562b3 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -23,6 +23,11 @@ FUNCTIONS:
 
 ---------------------------------------------------------------------------*/
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
 #include <windows.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index cf41ed7..e89a89f 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -57,8 +57,6 @@ Copyright (C) 1993 - 2000.  Microsoft Corporation.  All rights reserved.
 extern "C" {
 #endif
 
-#include "config.h"
-
 //////////////////////////////////////////////////////////////////////////////
 //// todo: change to desired strings
 ////
-- 
1.7.3.4


