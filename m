Message-ID: <4F589140.3060405@...515...>
Date: Thu, 08 Mar 2012 13:00:16 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-43-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-43-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 42/52] build: win-msvc: msbuild format
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

A huge patch :). So, this basically adds the new MSVC build system,
which we want, at least for now. All the changes to existing files are
fairly trivial.

I didn't go through all of this, but I suggest we give this one an ACK
and fix any issues later on. I've tested this buildsystem and it worked
fine on Windows 2008r2.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  .gitignore                                    |   11 +-
>  Makefile.am                                   |   10 +-
>  build/Makefile.am                             |    2 +
>  build/msvc/Makefile.am                        |   15 +
>  build/msvc/msvc-generate/Makefile.am          |   18 +
>  build/msvc/msvc-generate/Makefile.mak         |   13 +
>  build/msvc/msvc-generate/msvc-generate.js     |  118 ++++
>  build/msvc/msvc-generate/msvc-generate.vcproj |   74 +++
>  config-msvc-version.h.in                      |   10 +
>  config-msvc.h                                 |  122 ++++
>  configure.ac                                  |    5 +-
>  msvc-build.bat                                |   34 ++
>  msvc-dev.bat                                  |    9 +
>  msvc-env.bat                                  |   29 +
>  openvpn.sln                                   |   45 ++
>  src/openvpn/Makefile.am                       |    3 +
>  src/openvpn/compat.h                          |    2 -
>  src/openvpn/crypto_backend.h                  |    2 -
>  src/openvpn/openvpn.vcproj                    |  769 +++++++++++++++++++=
++++++
>  src/openvpn/openvpn_win32_resources.rc        |    2 +-
>  src/openvpn/syshead.h                         |   14 +-
>  src/openvpn/tun.c                             |    2 +-
>  src/openvpn/win32.c                           |    2 +-
>  src/openvpnserv/Makefile.am                   |    3 +
>  src/openvpnserv/openvpnserv.c                 |   16 +-
>  src/openvpnserv/openvpnserv.vcproj            |  209 +++++++
>  src/openvpnserv/openvpnserv_resources.rc      |    2 +-
>  src/openvpnserv/service.c                     |    5 +
>  src/openvpnserv/service.h                     |    2 -
>  29 files changed, 1527 insertions(+), 21 deletions(-)
>  create mode 100644 build/msvc/Makefile.am
>  create mode 100644 build/msvc/msvc-generate/Makefile.am
>  create mode 100755 build/msvc/msvc-generate/Makefile.mak
>  create mode 100644 build/msvc/msvc-generate/msvc-generate.js
>  create mode 100644 build/msvc/msvc-generate/msvc-generate.vcproj
>  create mode 100644 config-msvc-version.h.in
>  create mode 100644 config-msvc.h
>  create mode 100644 msvc-build.bat
>  create mode 100644 msvc-dev.bat
>  create mode 100644 msvc-env.bat
>  create mode 100644 openvpn.sln
>  create mode 100644 src/openvpn/openvpn.vcproj
>  create mode 100644 src/openvpnserv/openvpnserv.vcproj
>
> diff --git a/.gitignore b/.gitignore
> index 156b2c2..e7232cf 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,12 +2,18 @@
>  *.dll
>  *.exe
>  *.exe.*
> -*.mak
>  *.obj
>  *.pyc
>  *.so
>  *~
>  *.idb
> +*.suo
> +*.ncb
> +*.vcproj.*
> +*.log
> +Release
> +Debug
> +Win32-Output
>  .deps
>  Makefile
>  Makefile.in
> @@ -33,6 +39,9 @@ m4/ltsugar.m4
>  m4/ltversion.m4
>  m4/lt~obsolete.m4
>
> +msvc-env-local.bat
> +config-msvc-local.h
> +config-msvc-version.h
>  doc/openvpn.8.html
>  distro/rpm/openvpn.spec
>  tests/t_client.sh
> diff --git a/Makefile.am b/Makefile.am
> index ebc2252..5293518 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -54,10 +54,18 @@ dist_noinst_DATA =3D \
>         .gitignore \
>         PORTS \
>         README.IPv6 TODO.IPv6 \
> -       README.polarssl
> +       README.polarssl \
> +       openvpn.sln \
> +       msvc-env.bat \
> +       msvc-dev.bat \
> +       msvc-build.bat
>
>  if WIN32
>  dist_doc_DATA +=3D INSTALL-win32.txt
>  else
>  dist_noinst_DATA +=3D INSTALL-win32.txt
>  endif
> +
> +dist_noinst_HEADERS =3D \
> +       config-msvc.h \
> +       config-msvc-version.h.in
> diff --git a/build/Makefile.am b/build/Makefile.am
> index a993b20..b53ff52 100644
> --- a/build/Makefile.am
> +++ b/build/Makefile.am
> @@ -13,3 +13,5 @@ MAINTAINERCLEANFILES =3D \
>
>  EXTRA_DIST =3D \
>         ltrc.inc
> +
> +SUBDIRS =3D msvc
> diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
> new file mode 100644
> index 0000000..7dc3def
> --- /dev/null
> +++ b/build/msvc/Makefile.am
> @@ -0,0 +1,15 @@
> +#
> +#  OpenVPN -- An application to securely tunnel IP networks
> +#             over a single UDP port, with support for SSL/TLS-based
> +#             session authentication and key exchange,
> +#             packet encryption, packet authentication, and
> +#             packet compression.
> +#
> +#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
> +#
> +
> +MAINTAINERCLEANFILES =3D \
> +       $(srcdir)/Makefile.in
> +
> +SUBDIRS =3D msvc-generate
> diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-gener=
ate/Makefile.am
> new file mode 100644
> index 0000000..035ae22
> --- /dev/null
> +++ b/build/msvc/msvc-generate/Makefile.am
> @@ -0,0 +1,18 @@
> +#
> +#  OpenVPN -- An application to securely tunnel IP networks
> +#             over a single UDP port, with support for SSL/TLS-based
> +#             session authentication and key exchange,
> +#             packet encryption, packet authentication, and
> +#             packet compression.
> +#
> +#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
> +#  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
> +#
> +
> +MAINTAINERCLEANFILES =3D \
> +       $(srcdir)/Makefile.in
> +
> +dist_noinst_DATA =3D \
> +       msvc-generate.vcproj \
> +       Makefile.mak \
> +       msvc-generate.js
> diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-gene=
rate/Makefile.mak
> new file mode 100755
> index 0000000..72415f1
> --- /dev/null
> +++ b/build/msvc/msvc-generate/Makefile.mak
> @@ -0,0 +1,13 @@
> +# Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
> +
> +CONFIG=3D$(SOURCEBASE)/version.m4
> +INPUT=3D$(SOURCEBASE)/config-msvc-version.h.in
> +OUTPUT=3D$(SOURCEBASE)/config-msvc-version.h
> +
> +all:   $(OUTPUT)
> +
> +$(OUTPUT): $(INPUT) $(CONFIG)
> +       cscript //nologo msvc-generate.js --config=3D"$(CONFIG)" --input=
=3D"$(INPUT)" --output=3D"$(OUTPUT)"
> +
> +clean:
> +       -del "$(OUTPUT)"
> diff --git a/build/msvc/msvc-generate/msvc-generate.js b/build/msvc/msvc-=
generate/msvc-generate.js
> new file mode 100644
> index 0000000..d9564cf
> --- /dev/null
> +++ b/build/msvc/msvc-generate/msvc-generate.js
> @@ -0,0 +1,118 @@
> +/*
> + * msvc-generate.js  - string transformation
> + *
> + * Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
> + *
> + * BSD License
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions ar=
e met:
> + *
> + *     o Redistributions of source code must retain the above copyright =
notice,
> + *       this list of conditions and the following disclaimer.
> + *     o Redistributions in binary form must reproduce the above copyrig=
ht
> + *       notice, this list of conditions and the following disclaimer in=
 the
> + *       documentation and/or other materials provided with the distribu=
tion.
> + *     o Neither the name of the Alon Bar-Lev nor the names of its
> + *       contributors may be used to endorse or promote products derived=
 from
> + *       this software without specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,=
 THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS=
 BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSIN=
ESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER =
IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWIS=
E)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED O=
F THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +var ForReading =3D 1;
> +var fso =3D new ActiveXObject("Scripting.FileSystemObject");
> +var input =3D "nul";
> +var output =3D "nul";
> +var files =3D new Array();
> +var env =3D new Array();
> +
> +function initialize() {
> +       for (var i=3D0;i<WScript.Arguments.length;i++) {
> +               var arg =3D WScript.Arguments(i);
> +               if (arg.match(/^--input=3D(.*)$/)) {
> +                       input=3DRegExp.$1;
> +               }
> +               else if (arg.match(/^--output=3D(.*)$/)) {
> +                       output=3DRegExp.$1;
> +               }
> +               else if (arg.match(/^--config=3D(.*)$/)) {
> +                       files.push(RegExp.$1);
> +               }
> +               else if (arg.match(/^--var=3D([^=3D]*)=3D(.*)$/)) {
> +                       env[RegExp.$1] =3D RegExp.$2;
> +               }
> +       }
> +}
> +
> +function process_config(vars, file) {
> +       try {
> +               var fin =3D fso.OpenTextFile(file, ForReading);
> +
> +               while (!fin.AtEndOfStream) {
> +                       var content =3D fin.ReadLine();
> +                       if (content.match(/^[ \t]*define\(\[(.*)\],[ \t]*=
\[(.*)\]\)[ \t]*/)) {
> +                               vars[RegExp.$1] =3D RegExp.$2;
> +                       }
> +               }
> +       }
> +       catch(e) {
> +               throw new Error(1, "Cannot process '" + file + "'.");
> +       }
> +}
> +
> +function process_file(vars, input, output) {
> +       var fin =3D fso.OpenTextFile(input, ForReading);
> +       var fout =3D fso.CreateTextFile(output);
> +       var content =3D fin.ReadAll();
> +
> +       for (var i in vars) {
> +               content =3D content.replace(new RegExp("@"+i+"@", "g"), v=
ars[i]);
> +       }
> +
> +       fout.Write(content);
> +}
> +
> +function build_vars() {
> +       var vars =3D new Array();
> +       for (var f in files) {
> +               process_config(vars, files[f]);
> +       }
> +       for (var e in env) {
> +               vars[e] =3D env[e];
> +       }
> +       return vars;
> +}
> +
> +function main() {
> +       try {
> +               initialize();
> +
> +               var vars =3D build_vars();
> +
> +               process_file(
> +                       vars,
> +                       input,
> +                       output
> +               );
> +
> +               WScript.Quit(0);
> +       }
> +       catch(e) {
> +               WScript.Echo("ERROR: when procssing " + output + ": " + e=
.description);
> +               WScript.Quit(1);
> +       }
> +}
> +
> +main();
> diff --git a/build/msvc/msvc-generate/msvc-generate.vcproj b/build/msvc/m=
svc-generate/msvc-generate.vcproj
> new file mode 100644
> index 0000000..3b7dc18
> --- /dev/null
> +++ b/build/msvc/msvc-generate/msvc-generate.vcproj
> @@ -0,0 +1,74 @@
> +<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> +<VisualStudioProject
> +       ProjectType=3D"Visual C++"
> +       Version=3D"9.00"
> +       Name=3D"msvc-generate"
> +       ProjectGUID=3D"{8598C2C8-34C4-47A1-99B0-7C295A890615}"
> +       RootNamespace=3D"msvc-generate"
> +       Keyword=3D"MakeFileProj"
> +       TargetFrameworkVersion=3D"196613"
> +       >
> +       <Platforms>
> +               <Platform
> +                       Name=3D"Win32"
> +               />
> +       </Platforms>
> +       <ToolFiles>
> +       </ToolFiles>
> +       <Configurations>
> +               <Configuration
> +                       Name=3D"Debug|Win32"
> +                       OutputDirectory=3D"$(ConfigurationName)"
> +                       IntermediateDirectory=3D"$(ConfigurationName)"
> +                       ConfigurationType=3D"0"
> +                       >
> +                       <Tool
> +                               Name=3D"VCNMakeTool"
> +                               BuildCommandLine=3D"nmake -f Makefile.mak=
 all"
> +                               ReBuildCommandLine=3D"nmake -f Makefile.m=
ak clean all"
> +                               CleanCommandLine=3D"nmake -f Makefile.mak=
 clean"
> +                               Output=3D"config-msvc-version.h"
> +                               PreprocessorDefinitions=3D"WIN32;_DEBUG"
> +                               IncludeSearchPath=3D""
> +                               ForcedIncludes=3D""
> +                               AssemblySearchPath=3D""
> +                               ForcedUsingAssemblies=3D""
> +                               CompileAsManaged=3D""
> +                       />
> +               </Configuration>
> +               <Configuration
> +                       Name=3D"Release|Win32"
> +                       OutputDirectory=3D"$(ConfigurationName)"
> +                       IntermediateDirectory=3D"$(ConfigurationName)"
> +                       ConfigurationType=3D"0"
> +                       >
> +                       <Tool
> +                               Name=3D"VCNMakeTool"
> +                               BuildCommandLine=3D"nmake -f Makefile.mak=
 all"
> +                               ReBuildCommandLine=3D"nmake -f Makefile.m=
ak clean all"
> +                               CleanCommandLine=3D"nmake -f Makefile.mak=
 clean"
> +                               Output=3D"config-msvc-version.h"
> +                               PreprocessorDefinitions=3D"WIN32;NDEBUG"
> +                               IncludeSearchPath=3D""
> +                               ForcedIncludes=3D""
> +                               AssemblySearchPath=3D""
> +                               ForcedUsingAssemblies=3D""
> +                               CompileAsManaged=3D""
> +                       />
> +               </Configuration>
> +       </Configurations>
> +       <References>
> +       </References>
> +       <Files>
> +               <File
> +                       RelativePath=3D".\Makefile.mak"
> +                       >
> +               </File>
> +               <File
> +                       RelativePath=3D".\msc-generate.js"
> +                       >
> +               </File>
> +       </Files>
> +       <Globals>
> +       </Globals>
> +</VisualStudioProject>
> diff --git a/config-msvc-version.h.in b/config-msvc-version.h.in
> new file mode 100644
> index 0000000..4bc89e7
> --- /dev/null
> +++ b/config-msvc-version.h.in
> @@ -0,0 +1,10 @@
> +#define PACKAGE_NAME "@PRODUCT_NAME@"
> +#define PACKAGE_STRING "@PRODUCT_NAME@ @PRODUCT_VERSION@"
> +#define PACKAGE_TARNAME "@PRODUCT_TARNAME@"
> +#define PACKAGE "@PRODUCT_TARNAME@"
> +#define PACKAGE_VERSION "@PRODUCT_VERSION@"
> +#define PRODUCT_BUGREPORT "@PRODUCT_BUGREPORT@"
> +#define OPENVPN_VERSION_RESOURCE @PRODUCT_VERSION_RESOURCE@
> +#define TAP_WIN_COMPONENT_ID "@PRODUCT_TAP_WIN_COMPONENT_ID@"
> +#define TAP_WIN_MIN_MAJOR @PRODUCT_TAP_WIN_MIN_MAJOR@
> +#define TAP_WIN_MIN_MINOR @PRODUCT_TAP_WIN_MIN_MINOR@
> diff --git a/config-msvc.h b/config-msvc.h
> new file mode 100644
> index 0000000..577371f
> --- /dev/null
> +++ b/config-msvc.h
> @@ -0,0 +1,122 @@
> +#include <config-msvc-version.h>
> +
> +#define CONFIGURE_DEFINES "N/A"
> +
> +#define ENABLE_DEF_AUTH 1
> +#define ENABLE_PF 1
> +#define ENABLE_CLIENT_SERVER 1
> +#define ENABLE_CRYPTO 1
> +#define ENABLE_CRYPTO_OPENSSL 1
> +#define ENABLE_DEBUG 1
> +#define ENABLE_EUREPHIA 1
> +#define ENABLE_FRAGMENT 1
> +#define ENABLE_HTTP_PROXY 1
> +#define ENABLE_LZO 1
> +#define ENABLE_MANAGEMENT 1
> +#define ENABLE_MULTIHOME 1
> +#define ENABLE_PKCS11 1
> +#define ENABLE_PLUGIN 1
> +#define ENABLE_PORT_SHARE 1
> +#define ENABLE_SOCKS 1
> +#define ENABLE_SSL 1
> +
> +#define HAVE_ERRNO_H 1
> +#define HAVE_FCNTL_H 1
> +#define HAVE_CTYPE_H 1
> +#define HAVE_STDARG_H 1
> +#define HAVE_STDIO_H 1
> +#define HAVE_STDLIB_H 1
> +#define HAVE_STRDUP 1
> +#define HAVE_STRERROR 1
> +#define HAVE_STRINGS_H 1
> +#define HAVE_STRING_H 1
> +#define HAVE_SYSTEM 1
> +#define HAVE_TIME 1
> +#define HAVE_TIME_H 1
> +#define HAVE_UNLINK 1
> +#define HAVE_VSNPRINTF 1
> +#define HAVE_WINDOWS_H 1
> +#define HAVE_WINSOCK2_H 1
> +#define HAVE_WS2TCPIP_H 1
> +#define HAVE_IO_H 1
> +#define HAVE_DIRECT_H 1
> +#define HAVE_SYS_TYPES_H 1
> +#define HAVE_SYS_STAT_H 1
> +#define HAVE_LZO_LZO1X_H 1
> +#define HAVE_LZO_LZOUTIL_H 1
> +
> +#define HAVE_ACCESS 1
> +#define HAVE_CHDIR 1
> +#define HAVE_CHSIZE 1
> +#define HAVE_CPP_VARARG_MACRO_ISO 1
> +#define HAVE_CTIME 1
> +#define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
> +#define HAVE_GETTIMEOFDAY 1
> +#define HAVE_IN_PKTINFO 1
> +#define HAVE_MEMSET 1
> +#define HAVE_PUTENV 1
> +#define HAVE_STAT 1
> +
> +#define HAVE_SOCKET 1
> +#define HAVE_RECV 1
> +#define HAVE_RECVFROM 1
> +#define HAVE_SEND 1
> +#define HAVE_SENDTO 1
> +#define HAVE_LISTEN 1
> +#define HAVE_ACCEPT 1
> +#define HAVE_CONNECT 1
> +#define HAVE_BIND 1
> +#define HAVE_SELECT 1
> +#define HAVE_GETHOSTBYNAME 1
> +#define HAVE_INET_NTOA 1
> +#define HAVE_SETSOCKOPT 1
> +#define HAVE_GETSOCKOPT 1
> +#define HAVE_GETSOCKNAME 1
> +#define HAVE_POLL 1
> +
> +#define HAVE_OPENSSL_ENGINE 1
> +
> +#ifndef __cplusplus
> +#define inline __inline
> +#endif
> +
> +#define EMPTY_ARRAY_SIZE 0
> +#define TARGET_WIN32 1
> +#define TARGET_ALIAS "Windows-MSVC"
> +
> +#define HAVE_DECL_SO_MARK 0
> +
> +#define strncasecmp strnicmp
> +#define strcasecmp _stricmp
> +#define snprintf _snprintf
> +#define strtoull strtoul
> +
> +#define in_addr_t uint32_t
> +#define ssize_t SSIZE_T
> +
> +#define S_IRUSR 0
> +#define S_IWUSR 0
> +#define R_OK 4
> +#define W_OK 2
> +#define X_OK 1
> +#define F_OK 0
> +
> +#define SIGHUP    1
> +#define SIGINT    2
> +#define SIGUSR1   10
> +#define SIGUSR2   12
> +#define SIGTERM   15
> +
> +typedef unsigned __int64       uint64_t;
> +typedef unsigned __int32       uint32_t;
> +typedef unsigned __int16       uint16_t;
> +typedef unsigned __int8                uint8_t;
> +typedef __int64                int64_t;
> +typedef __int32                int32_t;
> +typedef __int16                int16_t;
> +typedef __int8         int8_t;
> +
> +#ifdef HAVE_CONFIG_MSVC_LOCAL_H
> +#include <config-msvc-local.h>
> +#endif
> +
> diff --git a/configure.ac b/configure.ac
> index 9ffcc68..f5663eb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -282,7 +282,8 @@ case "$host" in
>         *-mingw*)
>                 AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
>                 AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix=
])
> -               CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=3D=
0x0501"
> +               CPPFLAGS=3D"${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
> +               CPPFLAGS=3D"${CPPFLAGS} -DNTDDI_VERSION=3DNTDDI_WINXP -D_=
WIN32_WINNT=3D_WIN32_WINNT_WINXP"
>                 WIN32=3Dyes
>                 ;;
>         *-*-dragonfly*)
> @@ -906,6 +907,8 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
>  AC_CONFIG_FILES([
>         Makefile
>         build/Makefile
> +       build/msvc/Makefile
> +       build/msvc/msvc-generate/Makefile
>         distro/Makefile
>         distro/rpm/Makefile
>         distro/rpm/openvpn.spec
> diff --git a/msvc-build.bat b/msvc-build.bat
> new file mode 100644
> index 0000000..02a396c
> --- /dev/null
> +++ b/msvc-build.bat
> @@ -0,0 +1,34 @@
> +@echo off
> +
> +rem Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
> +
> +call msvc-env.bat
> +
> +@rem this stupid command needed for SetEnv.cmd to operate
> +setlocal ENABLEDELAYEDEXPANSION
> +
> +set PLATFORMS=3DWin32
> +set CONFIGURATIONS=3DRelease
> +
> +call "%VCHOME%\bin\vcvars32.bat"
> +
> +for %%p in (%PLATFORMS%) do (
> +       for %%c in (%CONFIGURATIONS%) do (
> +               rmdir /q /s %SOURCEBASE%\%%p\%%c > nul 2>&1
> +
> +               vcbuild /errfile:error.log /showenv %SOLUTION% /rebuild /=
platform:%%p "%%c|%%p"
> +               for %%f in (error.log) do if %%~zf GTR 0 goto error
> +       )
> +)
> +
> +exit /b 0
> +goto end
> +
> +:error
> +if "%1" NEQ "batch" pause
> +exit /b 1
> +goto end
> +
> +:end
> +
> +endlocal
> diff --git a/msvc-dev.bat b/msvc-dev.bat
> new file mode 100644
> index 0000000..671a56d
> --- /dev/null
> +++ b/msvc-dev.bat
> @@ -0,0 +1,9 @@
> +@echo off
> +
> +setlocal
> +cd %0\..
> +call msvc-env.bat
> +
> +start "" "%VSHOME%\Common7\IDE\devenv.exe" %SOLUTION%
> +
> +endlocal
> diff --git a/msvc-env.bat b/msvc-env.bat
> new file mode 100644
> index 0000000..ef9c7bb
> --- /dev/null
> +++ b/msvc-env.bat
> @@ -0,0 +1,29 @@
> +@echo off
> +
> +cd %0\..
> +
> +rem Put your own settings at msvc-env-local.bat
> +if exist msvc-env-local.bat call msvc-env-local.bat
> +
> +if "%ProgramFiles(x86)%"=3D=3D"" set ProgramFiles(x86)=3D%ProgramFiles%
> +if "%VS90COMNTOOLS%"=3D=3D"" set VS90COMNTOOLS=3D%ProgramFiles(x86)%\Mic=
rosoft Visual Studio 9.0\Common7\Tools\
> +if "%VSHOME%"=3D=3D"" set VSHOME=3D%VS90COMNTOOLS%..\..
> +if "%VCHOME%"=3D=3D"" set VCHOME=3D%VSHOME%\VC
> +
> +set SOURCEBASE=3D%cd%
> +set SOLUTION=3Dopenvpn.sln
> +set CPPFLAGS=3D%CPPFLAGS%;_CRT_SECURE_NO_WARNINGS;WIN32_LEAN_AND_MEAN;_C=
RT_NONSTDC_NO_WARNINGS;_CRT_SECURE_NO_WARNINGS
> +set CPPFLAGS=3D%CPPFLAGS%;NTDDI_VERSION=3DNTDDI_WINXP;_WIN32_WINNT=3D_WI=
N32_WINNT_WINXP
> +set CPPFLAGS=3D%CPPFLAGS%;_USE_32BIT_TIME_T
> +set CPPFLAGS=3D%CPPFLAGS%;%EXTRA_CPPFLAGS%
> +
> +if exist config-msvc-local.h set CPPFLAGS=3D"%CPPFLAGS%;HAVE_CONFIG_MSVC=
_LOCAL_H"
> +
> +if "%OPENVPN_DEPROOT%" =3D=3D "" set OPENVPN_DEPROOT=3Dc:\Temp\openvpn-d=
eps
> +if "%OPENSSL_HOME%" =3D=3D "" set OPENSSL_HOME=3D%OPENVPN_DEPROOT%
> +if "%LZO_HOME%" =3D=3D "" set LZO_HOME=3D%OPENVPN_DEPROOT%
> +if "%PKCS11H_HOME%" =3D=3D "" set PKCS11H_HOME=3D%OPENVPN_DEPROOT%
> +
> +if not exist "%OPENSSL_HOME%" echo WARNING: openssl '%OPENSSL_HOME%' doe=
s not exist
> +if not exist "%LZO_HOME%" echo WARNING: lzo '%LZO_HOME%' does not exist
> +if not exist "%PKCS11H_HOME%" echo WARNING: pkcs11-helper '%PKCS11H_HOME=
%' does not exist
> diff --git a/openvpn.sln b/openvpn.sln
> new file mode 100644
> index 0000000..cbd2093
> --- /dev/null
> +++ b/openvpn.sln
> @@ -0,0 +1,45 @@
> +=EF=BB=BF
> +Microsoft Visual Studio Solution File, Format Version 10.00
> +# Visual Studio 2008
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpnserv", "sr=
c\openvpnserv\openvpnserv.vcproj", "{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
> +       ProjectSection(ProjectDependencies) =3D postProject
> +               {8598C2C8-34C4-47A1-99B0-7C295A890615} =3D {8598C2C8-34C4=
-47A1-99B0-7C295A890615}
> +       EndProjectSection
> +EndProject
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpn", "src\op=
envpn\openvpn.vcproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
> +       ProjectSection(ProjectDependencies) =3D postProject
> +               {8598C2C8-34C4-47A1-99B0-7C295A890615} =3D {8598C2C8-34C4=
-47A1-99B0-7C295A890615}
> +       EndProjectSection
> +EndProject
> +Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") =3D "misc", "misc", "{=
1AA03DE8-3F08-45B9-B4ED-D7769A445DF3}"
> +       ProjectSection(SolutionItems) =3D preProject
> +               config-msvc-version.h.in =3D config-msvc-version.h.in
> +               config-msvc.h =3D config-msvc.h
> +               version.m4 =3D version.m4
> +       EndProjectSection
> +EndProject
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "msvc-generate", "=
build\msvc\msvc-generate\msvc-generate.vcproj", "{8598C2C8-34C4-47A1-99B0-7=
C295A890615}"
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
> +       EndGlobalSection
> +       GlobalSection(SolutionProperties) =3D preSolution
> +               HideSolutionNode =3D FALSE
> +       EndGlobalSection
> +EndGlobal
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index e9b3b07..3d8c0a9 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -14,6 +14,9 @@ include $(top_srcdir)/build/ltrc.inc
>  MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in
>
> +EXTRA_DIST =3D \
> +       openvpn.vcproj
> +
>  INCLUDES =3D -I$(top_srcdir)/include
>
>  AM_CFLAGS =3D \
> diff --git a/src/openvpn/compat.h b/src/openvpn/compat.h
> index b380f0b..7af9fe2 100644
> --- a/src/openvpn/compat.h
> +++ b/src/openvpn/compat.h
> @@ -25,8 +25,6 @@
>  #ifndef COMPAT_H
>  #define COMPAT_H
>
> -#include "config.h"
> -
>  #if defined(HAVE_BASENAME) || defined(HAVE_DIRNAME)
>  #include <libgen.h>
>  #endif
> diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
> index 57f2ac4..1eac611 100644
> --- a/src/openvpn/crypto_backend.h
> +++ b/src/openvpn/crypto_backend.h
> @@ -30,8 +30,6 @@
>  #ifndef CRYPTO_BACKEND_H_
>  #define CRYPTO_BACKEND_H_
>
> -#include "config.h"
> -
>  #ifdef ENABLE_CRYPTO_OPENSSL
>  #include "crypto_openssl.h"
>  #endif
> diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
> new file mode 100644
> index 0000000..8a3f4b0
> --- /dev/null
> +++ b/src/openvpn/openvpn.vcproj
> @@ -0,0 +1,769 @@
> +<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> +<VisualStudioProject
> +       ProjectType=3D"Visual C++"
> +       Version=3D"9.00"
> +       Name=3D"openvpn"
> +       ProjectGUID=3D"{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
> +       RootNamespace=3D"openvpn"
> +       Keyword=3D"Win32Proj"
> +       TargetFrameworkVersion=3D"196613"
> +       >
> +       <Platforms>
> +               <Platform
> +                       Name=3D"Win32"
> +               />
> +       </Platforms>
> +       <ToolFiles>
> +       </ToolFiles>
> +       <Configurations>
> +               <Configuration
> +                       Name=3D"Debug|Win32"
> +                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> +                       IntermediateDirectory=3D"$(ConfigurationName)"
> +                       ConfigurationType=3D"1"
> +                       CharacterSet=3D"2"
> +                       >
> +                       <Tool
> +                               Name=3D"VCPreBuildEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCustomBuildTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXMLDataGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCWebServiceProxyGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCMIDLTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCLCompilerTool"
> +                               Optimization=3D"0"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PK=
CS11H_HOME)/include"
> +                               PreprocessorDefinitions=3D"WIN32;_DEBUG;_=
CONSOLE;$(CPPFLAGS)"
> +                               MinimalRebuild=3D"true"
> +                               BasicRuntimeChecks=3D"3"
> +                               RuntimeLibrary=3D"3"
> +                               UsePrecompiledHeader=3D"0"
> +                               WarningLevel=3D"3"
> +                               DebugInformationFormat=3D"4"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManagedResourceCompilerTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCResourceCompilerTool"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPreLinkEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCLinkerTool"
> +                               AdditionalDependencies=3D"libeay32.lib ss=
leay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib =
crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
> +                               LinkIncremental=3D"2"
> +                               AdditionalLibraryDirectories=3D"$(OPENSSL=
_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
> +                               GenerateDebugInformation=3D"true"
> +                               SubSystem=3D"1"
> +                               TargetMachine=3D"1"
> +                       />
> +                       <Tool
> +                               Name=3D"VCALinkTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManifestTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXDCMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCBscMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCFxCopTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCAppVerifierTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPostBuildEventTool"
> +                       />
> +               </Configuration>
> +               <Configuration
> +                       Name=3D"Release|Win32"
> +                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> +                       IntermediateDirectory=3D"$(ConfigurationName)"
> +                       ConfigurationType=3D"1"
> +                       CharacterSet=3D"2"
> +                       WholeProgramOptimization=3D"1"
> +                       >
> +                       <Tool
> +                               Name=3D"VCPreBuildEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCustomBuildTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXMLDataGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCWebServiceProxyGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCMIDLTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCLCompilerTool"
> +                               Optimization=3D"2"
> +                               EnableIntrinsicFunctions=3D"true"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PK=
CS11H_HOME)/include"
> +                               PreprocessorDefinitions=3D"WIN32;NDEBUG;_=
CONSOLE;$(CPPFLAGS)"
> +                               RuntimeLibrary=3D"2"
> +                               EnableFunctionLevelLinking=3D"true"
> +                               UsePrecompiledHeader=3D"0"
> +                               WarningLevel=3D"3"
> +                               DebugInformationFormat=3D"3"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManagedResourceCompilerTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCResourceCompilerTool"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPreLinkEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCLinkerTool"
> +                               AdditionalDependencies=3D"libeay32.lib ss=
leay32.lib lzo2.lib pkcs11-helper.dll.lib gdi32.lib ws2_32.lib wininet.lib =
crypt32.lib iphlpapi.lib winmm.lib shell32.lib"
> +                               LinkIncremental=3D"1"
> +                               AdditionalLibraryDirectories=3D"$(OPENSSL=
_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib"
> +                               GenerateDebugInformation=3D"true"
> +                               SubSystem=3D"1"
> +                               OptimizeReferences=3D"2"
> +                               EnableCOMDATFolding=3D"2"
> +                               TargetMachine=3D"1"
> +                       />
> +                       <Tool
> +                               Name=3D"VCALinkTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManifestTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXDCMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCBscMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCFxCopTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCAppVerifierTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPostBuildEventTool"
> +                       />
> +               </Configuration>
> +       </Configurations>
> +       <References>
> +       </References>
> +       <Files>
> +               <Filter
> +                       Name=3D"Source Files"
> +                       Filter=3D"cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;as=
mx"
> +                       UniqueIdentifier=3D"{4FC737F1-C7A5-4376-A066-2A32=
D752A2FF}"
> +                       >
> +                       <File
> +                               RelativePath=3D".\base64.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\buffer.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\clinat.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\compat.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\crypto.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\crypto_openssl.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\cryptoapi.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\dhcp.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\error.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\event.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\fdmisc.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\forward.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\fragment.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\gremlin.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\helper.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\httpdigest.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\init.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\interval.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\list.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\lladdr.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\lzo.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\manage.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mbuf.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\misc.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mroute.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mss.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mstats.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mtcp.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mtu.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mudp.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\multi.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ntlm.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\occ.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\openvpn.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\options.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\otime.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\packet_id.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\perf.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pf.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ping.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pkcs11.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pkcs11_openssl.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\plugin.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pool.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\proto.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\proxy.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ps.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\push.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\reliable.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\route.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\schedule.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\session_id.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\shaper.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\sig.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\socket.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\socks.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_openssl.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_verify.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_verify_openssl.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\status.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\tun.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\win32.c"
> +                               >
> +                       </File>
> +               </Filter>
> +               <Filter
> +                       Name=3D"Header Files"
> +                       Filter=3D"h;hpp;hxx;hm;inl;inc;xsd"
> +                       UniqueIdentifier=3D"{93995380-89BD-4b04-88EB-625F=
BE52EBFB}"
> +                       >
> +                       <File
> +                               RelativePath=3D".\base64.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\basic.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\buffer.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\circ_list.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\clinat.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\common.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\compat.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\crypto.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\crypto_backend.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\crypto_openssl.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\cryptoapi.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\dhcp.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\errlevel.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\error.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\event.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\fdmisc.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\forward-inline.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\forward.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\fragment.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\gremlin.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\helper.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\httpdigest.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\init.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\integer.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\interval.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\list.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\lladdr.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\lzo.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\manage.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mbuf.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\memdbg.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\misc.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mroute.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mss.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mstats.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mtcp.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mtu.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\mudp.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\multi.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ntlm.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\occ-inline.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\occ.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\openvpn.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\options.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\otime.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\packet_id.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\perf.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pf-inline.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pf.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ping-inline.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ping.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pkcs11.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pkcs11_backend.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\plugin.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pool.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\proto.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\proxy.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ps.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\push.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\pushlist.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\reliable.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\route.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\schedule.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\session_id.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\shaper.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\sig.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\socket.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\socks.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_backend.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_common.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_openssl.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_verify.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_verify_backend.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\ssl_verify_openssl.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\status.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\syshead.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\tun.h"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\win32.h"
> +                               >
> +                       </File>
> +               </Filter>
> +               <Filter
> +                       Name=3D"Resource Files"
> +                       Filter=3D"rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;=
jpg;jpeg;jpe;resx;tiff;tif;png;wav"
> +                       UniqueIdentifier=3D"{67DA6AB6-F800-4c08-8B7A-83BB=
121AAD01}"
> +                       >
> +                       <File
> +                               RelativePath=3D".\openvpn_win32_resources=
.rc"
> +                               >
> +                       </File>
> +               </Filter>
> +       </Files>
> +       <Globals>
> +       </Globals>
> +</VisualStudioProject>
> diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn=
_win32_resources.rc
> index e91bfa1..c385baa 100644
> --- a/src/openvpn/openvpn_win32_resources.rc
> +++ b/src/openvpn/openvpn_win32_resources.rc
> @@ -1,7 +1,7 @@
>  #ifdef HAVE_CONFIG_H
>  #include <config.h>
>  #else
> -#include <config-msc-version.h>
> +#include <config-msvc-version.h>
>  #endif
>  #include <winresrc.h>
>
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index b82f9e4..bca842c 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -28,11 +28,13 @@
>  /*
>   * Only include if not during configure
>   */
> -#ifndef PACKAGE_NAME
> +#ifdef HAVE_CONFIG_H
>  #include "config.h"
> -#include "compat.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
>  #endif
>
> +#include "compat.h"
>
>  /* branch prediction hints */
>  #if defined(__GNUC__)
> @@ -102,6 +104,14 @@
>  #include <fcntl.h>
>  #endif
>
> +#ifdef HAVE_DIRECT_H
> +#include <direct.h>
> +#endif
> +
> +#ifdef HAVE_IO_H
> +#include <io.h>
> +#endif
> +
>  #ifdef HAVE_SYS_FILE_H
>  #include <sys/file.h>
>  #endif
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 7b74ebd..9df7126 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -3624,7 +3624,7 @@ get_adapter_index_method_1 (const char *guid)
>    ULONG index =3D ~0;
>    DWORD status;
>    wchar_t wbuf[256];
> -  snwprintf (wbuf, SIZE (wbuf), L"\\DEVICE\\TCPIP_%S", guid);
> +  _snwprintf (wbuf, SIZE (wbuf), L"\\DEVICE\\TCPIP_%S", guid);
>    wbuf [SIZE(wbuf) - 1] =3D 0;
>    if ((status =3D GetAdapterIndex (wbuf, &index)) !=3D NO_ERROR)
>      index =3D ~0;
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index acf5ebc..7639bad 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -611,7 +611,7 @@ window_title_generate (const char *title)
>    struct buffer out =3D alloc_buf_gc (256, &gc);
>    if (!title)
>      title =3D "";
> -  buf_printf (&out, "[%s] " PACKAGE_NAME " " VERSION " F4:EXIT F1:USR1 F=
2:USR2 F3:HUP", title);
> +  buf_printf (&out, "[%s] " PACKAGE_NAME " " PACKAGE_VERSION " F4:EXIT F=
1:USR1 F2:USR2 F3:HUP", title);
>    SetConsoleTitle (BSTR (&out));
>    gc_free (&gc);
>  }
> diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
> index 58005c0..8584b06 100644
> --- a/src/openvpnserv/Makefile.am
> +++ b/src/openvpnserv/Makefile.am
> @@ -13,6 +13,9 @@ include $(top_srcdir)/build/ltrc.inc
>
>  MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in
>
> +EXTRA_DIST =3D \
> +       openvpnserv.vcproj
> +
>  if WIN32
>  sbin_PROGRAMS =3D openvpnserv
>  endif
> diff --git a/src/openvpnserv/openvpnserv.c b/src/openvpnserv/openvpnserv.c
> index 0993064..a9a9441 100755
> --- a/src/openvpnserv/openvpnserv.c
> +++ b/src/openvpnserv/openvpnserv.c
> @@ -33,7 +33,11 @@
>   * This code is designed to be built with the mingw compiler.
>   */
>
> +#ifdef HAVE_CONFIG_H
>  #include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
>  #include <windows.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> @@ -196,7 +200,7 @@ match (const WIN32_FIND_DATA *find, const char *ext)
>    if (i < 1)
>      return false;
>
> -  return find->cFileName[i] =3D=3D '.' && !strcasecmp (find->cFileName +=
 i + 1, ext);
> +  return find->cFileName[i] =3D=3D '.' && !_stricmp (find->cFileName + i=
 + 1, ext);
>  }
>
>  /*
> @@ -331,15 +335,15 @@ VOID ServiceStart (DWORD dwArgc, LPTSTR *lpszArgv)
>
>    /* set process priority */
>    priority =3D NORMAL_PRIORITY_CLASS;
> -  if (!strcasecmp (priority_string, "IDLE_PRIORITY_CLASS"))
> +  if (!_stricmp (priority_string, "IDLE_PRIORITY_CLASS"))
>      priority =3D IDLE_PRIORITY_CLASS;
> -  else if (!strcasecmp (priority_string, "BELOW_NORMAL_PRIORITY_CLASS"))
> +  else if (!_stricmp (priority_string, "BELOW_NORMAL_PRIORITY_CLASS"))
>      priority =3D BELOW_NORMAL_PRIORITY_CLASS;
> -  else if (!strcasecmp (priority_string, "NORMAL_PRIORITY_CLASS"))
> +  else if (!_stricmp (priority_string, "NORMAL_PRIORITY_CLASS"))
>      priority =3D NORMAL_PRIORITY_CLASS;
> -  else if (!strcasecmp (priority_string, "ABOVE_NORMAL_PRIORITY_CLASS"))
> +  else if (!_stricmp (priority_string, "ABOVE_NORMAL_PRIORITY_CLASS"))
>      priority =3D ABOVE_NORMAL_PRIORITY_CLASS;
> -  else if (!strcasecmp (priority_string, "HIGH_PRIORITY_CLASS"))
> +  else if (!_stricmp (priority_string, "HIGH_PRIORITY_CLASS"))
>      priority =3D HIGH_PRIORITY_CLASS;
>    else
>      {
> diff --git a/src/openvpnserv/openvpnserv.vcproj b/src/openvpnserv/openvpn=
serv.vcproj
> new file mode 100644
> index 0000000..4c55561
> --- /dev/null
> +++ b/src/openvpnserv/openvpnserv.vcproj
> @@ -0,0 +1,209 @@
> +<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> +<VisualStudioProject
> +       ProjectType=3D"Visual C++"
> +       Version=3D"9.00"
> +       Name=3D"openvpnserv"
> +       ProjectGUID=3D"{9C91EE0B-817D-420A-A1E6-15A5A9D98BAD}"
> +       RootNamespace=3D"openvpnserv"
> +       Keyword=3D"Win32Proj"
> +       TargetFrameworkVersion=3D"196613"
> +       >
> +       <Platforms>
> +               <Platform
> +                       Name=3D"Win32"
> +               />
> +       </Platforms>
> +       <ToolFiles>
> +       </ToolFiles>
> +       <Configurations>
> +               <Configuration
> +                       Name=3D"Debug|Win32"
> +                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> +                       IntermediateDirectory=3D"$(ConfigurationName)"
> +                       ConfigurationType=3D"1"
> +                       CharacterSet=3D"2"
> +                       >
> +                       <Tool
> +                               Name=3D"VCPreBuildEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCustomBuildTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXMLDataGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCWebServiceProxyGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCMIDLTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCLCompilerTool"
> +                               Optimization=3D"0"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> +                               PreprocessorDefinitions=3D"WIN32;_DEBUG;_=
CONSOLE;$(CPPFLAGS)"
> +                               MinimalRebuild=3D"true"
> +                               BasicRuntimeChecks=3D"3"
> +                               RuntimeLibrary=3D"3"
> +                               UsePrecompiledHeader=3D"0"
> +                               WarningLevel=3D"3"
> +                               DebugInformationFormat=3D"4"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManagedResourceCompilerTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCResourceCompilerTool"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPreLinkEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCLinkerTool"
> +                               LinkIncremental=3D"2"
> +                               GenerateDebugInformation=3D"true"
> +                               SubSystem=3D"1"
> +                               TargetMachine=3D"1"
> +                       />
> +                       <Tool
> +                               Name=3D"VCALinkTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManifestTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXDCMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCBscMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCFxCopTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCAppVerifierTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPostBuildEventTool"
> +                       />
> +               </Configuration>
> +               <Configuration
> +                       Name=3D"Release|Win32"
> +                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> +                       IntermediateDirectory=3D"$(ConfigurationName)"
> +                       ConfigurationType=3D"1"
> +                       CharacterSet=3D"2"
> +                       WholeProgramOptimization=3D"1"
> +                       >
> +                       <Tool
> +                               Name=3D"VCPreBuildEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCustomBuildTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXMLDataGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCWebServiceProxyGeneratorTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCMIDLTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCCLCompilerTool"
> +                               Optimization=3D"2"
> +                               EnableIntrinsicFunctions=3D"true"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> +                               PreprocessorDefinitions=3D"WIN32;NDEBUG;_=
CONSOLE;$(CPPFLAGS)"
> +                               RuntimeLibrary=3D"2"
> +                               EnableFunctionLevelLinking=3D"true"
> +                               UsePrecompiledHeader=3D"0"
> +                               WarningLevel=3D"3"
> +                               DebugInformationFormat=3D"3"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManagedResourceCompilerTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCResourceCompilerTool"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE)"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPreLinkEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCLinkerTool"
> +                               LinkIncremental=3D"1"
> +                               GenerateDebugInformation=3D"true"
> +                               SubSystem=3D"1"
> +                               OptimizeReferences=3D"2"
> +                               EnableCOMDATFolding=3D"2"
> +                               TargetMachine=3D"1"
> +                       />
> +                       <Tool
> +                               Name=3D"VCALinkTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCManifestTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCXDCMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCBscMakeTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCFxCopTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCAppVerifierTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCPostBuildEventTool"
> +                       />
> +               </Configuration>
> +       </Configurations>
> +       <References>
> +       </References>
> +       <Files>
> +               <Filter
> +                       Name=3D"Source Files"
> +                       Filter=3D"cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;as=
mx"
> +                       UniqueIdentifier=3D"{4FC737F1-C7A5-4376-A066-2A32=
D752A2FF}"
> +                       >
> +                       <File
> +                               RelativePath=3D".\openvpnserv.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\service.c"
> +                               >
> +                       </File>
> +               </Filter>
> +               <Filter
> +                       Name=3D"Header Files"
> +                       Filter=3D"h;hpp;hxx;hm;inl;inc;xsd"
> +                       UniqueIdentifier=3D"{93995380-89BD-4b04-88EB-625F=
BE52EBFB}"
> +                       >
> +                       <File
> +                               RelativePath=3D".\service.h"
> +                               >
> +                       </File>
> +               </Filter>
> +               <Filter
> +                       Name=3D"Resource Files"
> +                       Filter=3D"rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;=
jpg;jpeg;jpe;resx;tiff;tif;png;wav"
> +                       UniqueIdentifier=3D"{67DA6AB6-F800-4c08-8B7A-83BB=
121AAD01}"
> +                       >
> +                       <File
> +                               RelativePath=3D".\openvpnserv_resources.r=
c"
> +                               >
> +                       </File>
> +               </Filter>
> +       </Files>
> +       <Globals>
> +       </Globals>
> +</VisualStudioProject>
> diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/o=
penvpnserv_resources.rc
> index b87f4a3..c5a7bf6 100644
> --- a/src/openvpnserv/openvpnserv_resources.rc
> +++ b/src/openvpnserv/openvpnserv_resources.rc
> @@ -1,7 +1,7 @@
>  #ifdef HAVE_CONFIG_H
>  #include <config.h>
>  #else
> -#include <config-msc-version.h>
> +#include <config-msvc-version.h>
>  #endif
>  #include <winresrc.h>
>
> diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
> index 91b5821..d7562b3 100644
> --- a/src/openvpnserv/service.c
> +++ b/src/openvpnserv/service.c
> @@ -23,6 +23,11 @@ FUNCTIONS:
>
>  ------------------------------------------------------------------------=
---*/
>
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
>  #include <windows.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
> index cf41ed7..e89a89f 100644
> --- a/src/openvpnserv/service.h
> +++ b/src/openvpnserv/service.h
> @@ -57,8 +57,6 @@ Copyright (C) 1993 - 2000.  Microsoft Corporation.  All=
 rights reserved.
>  extern "C" {
>  #endif
>
> -#include "config.h"
> -
>  ////////////////////////////////////////////////////////////////////////=
//////
>  //// todo: change to desired strings
>  ////
> --
> 1.7.3.4
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


