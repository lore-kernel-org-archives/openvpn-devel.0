Message-ID: <4F5891EA.5060900@...515...>
Date: Thu, 08 Mar 2012 13:03:06 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-45-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-45-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 44/52] build: split out compat
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

The commit message makes sense to me, so it's a feature-ACK. Somebody
else might want to look at the code itself.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> compat should not use any of the main project headers or conventions,
> it should be a standalone library that provides missing library
> functions.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac                 |    3 +-
>  openvpn.sln                  |    7 ++
>  src/Makefile.am              |    2 +-
>  src/compat/Makefile.am       |   23 ++++++
>  src/compat/compat-basename.c |   50 ++++++++++++
>  src/compat/compat-dirname.c  |  119 +++++++++++++++++++++++++++
>  src/compat/compat.h          |   36 ++++++++
>  src/compat/compat.vcproj     |  181 ++++++++++++++++++++++++++++++++++++=
++++++
>  src/openvpn/Makefile.am      |    6 +-
>  src/openvpn/compat.c         |  135 -------------------------------
>  src/openvpn/compat.h         |   40 ---------
>  src/openvpn/openvpn.vcproj   |   12 +---
>  src/openvpn/syshead.h        |    4 +
>  13 files changed, 429 insertions(+), 189 deletions(-)
>  create mode 100644 src/compat/Makefile.am
>  create mode 100644 src/compat/compat-basename.c
>  create mode 100644 src/compat/compat-dirname.c
>  create mode 100644 src/compat/compat.h
>  create mode 100644 src/compat/compat.vcproj
>  delete mode 100644 src/openvpn/compat.c
>  delete mode 100644 src/openvpn/compat.h
>
> diff --git a/configure.ac b/configure.ac
> index f5663eb..ff3df28 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -365,7 +365,7 @@ AC_CHECK_HEADERS([ \
>  AC_CHECK_HEADERS([ \
>         sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
>         sys/mman.h sys/file.h \
> -       unistd.h signal.h  \
> +       unistd.h signal.h libgen.h \
>         syslog.h pwd.h grp.h \
>         net/if_tun.h net/tun/if_tun.h stropts.h \
>         sys/sockio.h \
> @@ -914,6 +914,7 @@ AC_CONFIG_FILES([
>         distro/rpm/openvpn.spec
>         include/Makefile
>         src/Makefile
> +       src/compat/Makefile
>         src/openvpn/Makefile
>         src/openvpnserv/Makefile
>         tests/Makefile
> diff --git a/openvpn.sln b/openvpn.sln
> index cbd2093..be35d16 100644
> --- a/openvpn.sln
> +++ b/openvpn.sln
> @@ -8,6 +8,7 @@ Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "op=
envpnserv", "src\openvpns
>  EndProject
>  Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "openvpn", "src\op=
envpn\openvpn.vcproj", "{29DF226E-4D4E-440F-ADAF-5829CFD4CA94}"
>         ProjectSection(ProjectDependencies) =3D postProject
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19} =3D {4B2E2719-E661=
-45D7-9203-F6F456B22F19}
>                 {8598C2C8-34C4-47A1-99B0-7C295A890615} =3D {8598C2C8-34C4=
-47A1-99B0-7C295A890615}
>         EndProjectSection
>  EndProject
> @@ -20,6 +21,8 @@ Project("{2150E333-8FDC-42A3-9474-1A3956D46DE8}") =3D "=
misc", "misc", "{1AA03DE8-3
>  EndProject
>  Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "msvc-generate", "=
build\msvc\msvc-generate\msvc-generate.vcproj", "{8598C2C8-34C4-47A1-99B0-7=
C295A890615}"
>  EndProject
> +Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") =3D "compat", "src\com=
pat\compat.vcproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
> +EndProject
>  Global
>         GlobalSection(SolutionConfigurationPlatforms) =3D preSolution
>                 Debug|Win32 =3D Debug|Win32
> @@ -38,6 +41,10 @@ Global
>                 {8598C2C8-34C4-47A1-99B0-7C295A890615}.Debug|Win32.Build.=
0 =3D Debug|Win32
>                 {8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Acti=
veCfg =3D Release|Win32
>                 {8598C2C8-34C4-47A1-99B0-7C295A890615}.Release|Win32.Buil=
d.0 =3D Release|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Active=
Cfg =3D Debug|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Debug|Win32.Build.=
0 =3D Debug|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Acti=
veCfg =3D Release|Win32
> +               {4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Buil=
d.0 =3D Release|Win32
>         EndGlobalSection
>         GlobalSection(SolutionProperties) =3D preSolution
>                 HideSolutionNode =3D FALSE
> diff --git a/src/Makefile.am b/src/Makefile.am
> index f2481c2..b894977 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -15,4 +15,4 @@ MAINTAINERCLEANFILES =3D \
>  EXTRA_DIST =3D \
>         plugins
>
> -SUBDIRS =3D openvpn openvpnserv
> +SUBDIRS =3D compat openvpn openvpnserv
> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
> new file mode 100644
> index 0000000..e33e5e7
> --- /dev/null
> +++ b/src/compat/Makefile.am
> @@ -0,0 +1,23 @@
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
> +EXTRA_DIST =3D \
> +       compat.vcproj
> +
> +noinst_LTLIBRARIES =3D libcompat.la
> +
> +libcompat_la_SOURCES =3D \
> +       compat.h \
> +       compat-dirname.c \
> +       compat-basename.c
> diff --git a/src/compat/compat-basename.c b/src/compat/compat-basename.c
> new file mode 100644
> index 0000000..a057691
> --- /dev/null
> +++ b/src/compat/compat-basename.c
> @@ -0,0 +1,50 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +#ifndef HAVE_BASENAME
> +
> +#include "compat.h"
> +#include <string.h>
> +
> +/* Modified version based on glibc-2.14.1 by Roland McGrath <roland@...1386...=
269...>
> + * This version is extended to handle both / and \ in path names
> + */
> +char *
> +basename (char *filename)
> +{
> +  char *p =3D strrchr (filename, '/');
> +  if (!p) {
> +    /* If NULL, check for \ instead ... might be Windows a path */
> +    p =3D strrchr (filename, '\\');
> +  }
> +  return p ? p + 1 : (char *) filename;
> +}
> +
> +#endif /* HAVE_BASENAME */
> diff --git a/src/compat/compat-dirname.c b/src/compat/compat-dirname.c
> new file mode 100644
> index 0000000..8878595
> --- /dev/null
> +++ b/src/compat/compat-dirname.c
> @@ -0,0 +1,119 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include "config.h"
> +#elif defined(_MSC_VER)
> +#include "config-msvc.h"
> +#endif
> +
> +
> +#ifndef HAVE_DIRNAME
> +
> +#include "compat.h"
> +#include <string.h>
> +
> +/* Unoptimised version of glibc memrchr().
> + * This is considered fast enough, as only this compat
> + * version of dirname() depends on it.
> + */
> +static const char *
> +__memrchr(const char *str, int c, size_t n)
> +{
> +  const char *end =3D str;
> +
> +  end +=3D n - 1; /* Go to the end of the string */
> +  while (end >=3D str) {
> +    if(c =3D=3D *end)
> +      return end;
> +    else
> +      end--;
> +  }
> +  return NULL;
> +}
> +
> +/* Modified version based on glibc-2.14.1 by Ulrich Drepper <drepper@...493...=
1529...>
> + * This version is extended to handle both / and \ in path names.
> + */
> +char *
> +dirname (char *path)
> +{
> +  static const char dot[] =3D ".";
> +  char *last_slash;
> +  char separator =3D '/';
> +
> +  /* Find last '/'.  */
> +  last_slash =3D path !=3D NULL ? strrchr (path, '/') : NULL;
> +  /* If NULL, check for \ instead ... might be Windows a path */
> +  if (!last_slash) {
> +    last_slash =3D path !=3D NULL ? strrchr (path, '\\') : NULL;
> +    separator =3D last_slash ? '\\' : '/';  /* Change the separator if \=
 was found */
> +  }
> +
> +  if (last_slash !=3D NULL && last_slash !=3D path && last_slash[1] =3D=
=3D '\0') {
> +      /* Determine whether all remaining characters are slashes.  */
> +      char *runp;
> +
> +      for (runp =3D last_slash; runp !=3D path; --runp)
> +       if (runp[-1] !=3D separator)
> +         break;
> +
> +      /* The '/' is the last character, we have to look further.  */
> +      if (runp !=3D path)
> +       last_slash =3D (char *) __memrchr (path, separator, runp - path);
> +    }
> +
> +  if (last_slash !=3D NULL) {
> +      /* Determine whether all remaining characters are slashes.  */
> +      char *runp;
> +
> +      for (runp =3D last_slash; runp !=3D path; --runp)
> +       if (runp[-1] !=3D separator)
> +         break;
> +
> +      /* Terminate the path.  */
> +      if (runp =3D=3D path) {
> +         /* The last slash is the first character in the string.  We hav=
e to
> +            return "/".  As a special case we have to return "//" if the=
re
> +            are exactly two slashes at the beginning of the string.  See
> +            XBD 4.10 Path Name Resolution for more information.  */
> +         if (last_slash =3D=3D path + 1)
> +           ++last_slash;
> +         else
> +           last_slash =3D path + 1;
> +       }
> +      else
> +       last_slash =3D runp;
> +
> +      last_slash[0] =3D '\0';
> +  } else
> +    /* This assignment is ill-designed but the XPG specs require to
> +       return a string containing "." in any case no directory part is
> +       found and so a static and constant string is required.  */
> +    path =3D (char *) dot;
> +
> +  return path;
> +}
> +
> +#endif /* HAVE_DIRNAME */
> diff --git a/src/compat/compat.h b/src/compat/compat.h
> new file mode 100644
> index 0000000..57754da
> --- /dev/null
> +++ b/src/compat/compat.h
> @@ -0,0 +1,36 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2
> + *  as published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program (see the file COPYING included with this
> + *  distribution); if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef COMPAT_H
> +#define COMPAT_H
> +
> +#ifndef HAVE_DIRNAME
> +char * dirname(char *str);
> +#endif /* HAVE_DIRNAME */
> +
> +#ifndef HAVE_BASENAME
> +char * basename(char *str);
> +#endif /* HAVE_BASENAME */
> +
> +#endif /* COMPAT_H */
> diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
> new file mode 100644
> index 0000000..1ece749
> --- /dev/null
> +++ b/src/compat/compat.vcproj
> @@ -0,0 +1,181 @@
> +<?xml version=3D"1.0" encoding=3D"Windows-1252"?>
> +<VisualStudioProject
> +       ProjectType=3D"Visual C++"
> +       Version=3D"9.00"
> +       Name=3D"compat"
> +       ProjectGUID=3D"{4B2E2719-E661-45D7-9203-F6F456B22F19}"
> +       RootNamespace=3D"compat"
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
> +                       ConfigurationType=3D"4"
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
LIB;$(CPPFLAGS)"
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
> +                       />
> +                       <Tool
> +                               Name=3D"VCPreLinkEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCLibrarianTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCALinkTool"
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
> +                               Name=3D"VCPostBuildEventTool"
> +                       />
> +               </Configuration>
> +               <Configuration
> +                       Name=3D"Release|Win32"
> +                       OutputDirectory=3D"$(SolutionDir)$(PlatformName)-=
Output\$(ConfigurationName)"
> +                       IntermediateDirectory=3D"$(ConfigurationName)"
> +                       ConfigurationType=3D"4"
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
LIB;$(CPPFLAGS)"
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
> +                       />
> +                       <Tool
> +                               Name=3D"VCPreLinkEventTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCLibrarianTool"
> +                       />
> +                       <Tool
> +                               Name=3D"VCALinkTool"
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
> +                               RelativePath=3D".\compat-basename.c"
> +                               >
> +                       </File>
> +                       <File
> +                               RelativePath=3D".\compat-dirname.c"
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
> +                               RelativePath=3D".\compat.h"
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
> +               </Filter>
> +       </Files>
> +       <Globals>
> +       </Globals>
> +</VisualStudioProject>
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 3d8c0a9..e170380 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -17,7 +17,9 @@ MAINTAINERCLEANFILES =3D \
>  EXTRA_DIST =3D \
>         openvpn.vcproj
>
> -INCLUDES =3D -I$(top_srcdir)/include
> +INCLUDES =3D \
> +       -I$(top_srcdir)/include \
> +       -I$(top_srcdir)/src/compat
>
>  AM_CFLAGS =3D \
>         $(OPTIONAL_CRYPTO_CFLAGS) \
> @@ -33,7 +35,6 @@ openvpn_SOURCES =3D \
>         circ_list.h \
>         clinat.c clinat.h \
>         common.h \
> -       compat.h compat.c \
>         crypto.c crypto.h crypto_backend.h \
>         crypto_openssl.c crypto_openssl.h \
>         crypto_polarssl.c crypto_polarssl.h \
> @@ -104,6 +105,7 @@ openvpn_SOURCES =3D \
>         win32.h win32.c \
>         cryptoapi.h cryptoapi.c
>  openvpn_LDADD =3D \
> +       $(top_builddir)/src/compat/libcompat.la \
>         $(SOCKETS_LIBS) \
>         $(OPTIONAL_LZO_LIBS) \
>         $(OPTIONAL_PKCS11_HELPER_LIBS) \
> diff --git a/src/openvpn/compat.c b/src/openvpn/compat.c
> deleted file mode 100644
> index f2fa265..0000000
> --- a/src/openvpn/compat.c
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program (see the file COPYING included with this
> - *  distribution); if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#ifdef HAVE_CONFIG_H
> -#include "config.h"
> -#elif defined(_MSC_VER)
> -#include "config-msvc.h"
> -#endif
> -
> -#include "syshead.h"
> -#include "compat.h"
> -#include <string.h>
> -
> -
> -#ifndef HAVE_DIRNAME
> -/* Unoptimised version of glibc memrchr().
> - * This is considered fast enough, as only this compat
> - * version of dirname() depends on it.
> - */
> -static const char *
> -__memrchr(const char *str, int c, size_t n)
> -{
> -  const char *end =3D str;
> -
> -  end +=3D n - 1; /* Go to the end of the string */
> -  while (end >=3D str) {
> -    if(c =3D=3D *end)
> -      return end;
> -    else
> -      end--;
> -  }
> -  return NULL;
> -}
> -
> -/* Modified version based on glibc-2.14.1 by Ulrich Drepper <drepper@...493...=
1529...>
> - * This version is extended to handle both / and \ in path names.
> - */
> -char *
> -dirname (char *path)
> -{
> -  static const char dot[] =3D ".";
> -  char *last_slash;
> -  char separator =3D '/';
> -
> -  /* Find last '/'.  */
> -  last_slash =3D path !=3D NULL ? strrchr (path, '/') : NULL;
> -  /* If NULL, check for \ instead ... might be Windows a path */
> -  if (!last_slash) {
> -    last_slash =3D path !=3D NULL ? strrchr (path, '\\') : NULL;
> -    separator =3D last_slash ? '\\' : '/';  /* Change the separator if \=
 was found */
> -  }
> -
> -  if (last_slash !=3D NULL && last_slash !=3D path && last_slash[1] =3D=
=3D '\0') {
> -      /* Determine whether all remaining characters are slashes.  */
> -      char *runp;
> -
> -      for (runp =3D last_slash; runp !=3D path; --runp)
> -       if (runp[-1] !=3D separator)
> -         break;
> -
> -      /* The '/' is the last character, we have to look further.  */
> -      if (runp !=3D path)
> -       last_slash =3D (char *) __memrchr (path, separator, runp - path);
> -    }
> -
> -  if (last_slash !=3D NULL) {
> -      /* Determine whether all remaining characters are slashes.  */
> -      char *runp;
> -
> -      for (runp =3D last_slash; runp !=3D path; --runp)
> -       if (runp[-1] !=3D separator)
> -         break;
> -
> -      /* Terminate the path.  */
> -      if (runp =3D=3D path) {
> -         /* The last slash is the first character in the string.  We hav=
e to
> -            return "/".  As a special case we have to return "//" if the=
re
> -            are exactly two slashes at the beginning of the string.  See
> -            XBD 4.10 Path Name Resolution for more information.  */
> -         if (last_slash =3D=3D path + 1)
> -           ++last_slash;
> -         else
> -           last_slash =3D path + 1;
> -       }
> -      else
> -       last_slash =3D runp;
> -
> -      last_slash[0] =3D '\0';
> -  } else
> -    /* This assignment is ill-designed but the XPG specs require to
> -       return a string containing "." in any case no directory part is
> -       found and so a static and constant string is required.  */
> -    path =3D (char *) dot;
> -
> -  return path;
> -}
> -#endif /* HAVE_DIRNAME */
> -
> -
> -#ifndef HAVE_BASENAME
> -/* Modified version based on glibc-2.14.1 by Roland McGrath <roland@...1386...=
269...>
> - * This version is extended to handle both / and \ in path names
> - */
> -char *
> -basename (char *filename)
> -{
> -  char *p =3D strrchr (filename, '/');
> -  if (!p) {
> -    /* If NULL, check for \ instead ... might be Windows a path */
> -    p =3D strrchr (filename, '\\');
> -  }
> -  return p ? p + 1 : (char *) filename;
> -}
> -#endif /* HAVE_BASENAME */
> diff --git a/src/openvpn/compat.h b/src/openvpn/compat.h
> deleted file mode 100644
> index 7af9fe2..0000000
> --- a/src/openvpn/compat.h
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -/*
> - *  OpenVPN -- An application to securely tunnel IP networks
> - *             over a single UDP port, with support for SSL/TLS-based
> - *             session authentication and key exchange,
> - *             packet encryption, packet authentication, and
> - *             packet compression.
> - *
> - *  Copyright (C) 2011 - David Sommerseth <davids@...1347...>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License version 2
> - *  as published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program (see the file COPYING included with this
> - *  distribution); if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#ifndef COMPAT_H
> -#define COMPAT_H
> -
> -#if defined(HAVE_BASENAME) || defined(HAVE_DIRNAME)
> -#include <libgen.h>
> -#endif
> -
> -#ifndef HAVE_DIRNAME
> -char * dirname(char *str);
> -#endif /* HAVE_DIRNAME */
> -
> -#ifndef HAVE_BASENAME
> -char * basename(char *str);
> -#endif /* HAVE_BASENAME */
> -
> -#endif /* COMPAT_H */
> diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
> index 8a3f4b0..45c0a77 100644
> --- a/src/openvpn/openvpn.vcproj
> +++ b/src/openvpn/openvpn.vcproj
> @@ -41,7 +41,7 @@
>                         <Tool
>                                 Name=3D"VCCLCompilerTool"
>                                 Optimization=3D"0"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PK=
CS11H_HOME)/include"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(OPENSSL_HOME)/include=
;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
>                                 PreprocessorDefinitions=3D"WIN32;_DEBUG;_=
CONSOLE;$(CPPFLAGS)"
>                                 MinimalRebuild=3D"true"
>                                 BasicRuntimeChecks=3D"3"
> @@ -118,7 +118,7 @@
>                                 Name=3D"VCCLCompilerTool"
>                                 Optimization=3D"2"
>                                 EnableIntrinsicFunctions=3D"true"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PK=
CS11H_HOME)/include"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(OPENSSL_HOME)/include=
;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
>                                 PreprocessorDefinitions=3D"WIN32;NDEBUG;_=
CONSOLE;$(CPPFLAGS)"
>                                 RuntimeLibrary=3D"2"
>                                 EnableFunctionLevelLinking=3D"true"
> @@ -191,10 +191,6 @@
>                                 >
>                         </File>
>                         <File
> -                               RelativePath=3D".\compat.c"
> -                               >
> -                       </File>
> -                       <File
>                                 RelativePath=3D".\crypto.c"
>                                 >
>                         </File>
> @@ -461,10 +457,6 @@
>                                 >
>                         </File>
>                         <File
> -                               RelativePath=3D".\compat.h"
> -                               >
> -                       </File>
> -                       <File
>                                 RelativePath=3D".\crypto.h"
>                                 >
>                         </File>
> diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
> index f9636f7..e8da88c 100644
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -181,6 +181,10 @@
>  #include <selinux/selinux.h>
>  #endif
>
> +#if defined(HAVE_LIBGEN_H)
> +#include <libgen.h>
> +#endif
> +
>  #ifdef TARGET_SOLARIS
>  #ifdef HAVE_STRINGS_H
>  #include <strings.h>
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



