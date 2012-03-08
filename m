Message-ID: <4F58BB9C.2020709@...515...>
Date: Thu, 08 Mar 2012 16:01:00 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-53-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-53-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 52/52] build: use tap-windows.h as
 external dependency
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

If I understood this correctly, include/tap-windows.h gets removed, and
will then be included using the same mechanism that's used to include
LZO headers, OpenSSL headers, etc. I think this makes sense now that the
TAP-driver is a separate subproject.

ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> tap-windows.h is provided by the tap project
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac               |   12 ++++++++
>  include/Makefile.am        |    2 -
>  include/tap-windows.h      |   68 --------------------------------------=
------
>  msvc-env.bat               |    2 +
>  src/openvpn/Makefile.am    |    1 +
>  src/openvpn/openvpn.vcproj |    4 +-
>  6 files changed, 17 insertions(+), 72 deletions(-)
>  delete mode 100644 include/tap-windows.h
>
> diff --git a/configure.ac b/configure.ac
> index 2b095a3..c6cabee 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -666,6 +666,18 @@ PKG_CHECK_MODULES(
>         )]
>  )
>
> +AC_ARG_VAR([TAP_WINDOWS_CFLAGS], [C compiler flags for TAP-Windows])
> +if test "${WIN32}" =3D "yes"; then
> +       old_CFLAGS=3D"${CFLAGS}"
> +       CFLAGS=3D"${CFLAGS} ${TAP_WINDOWS_CFLAGS}"
> +       AC_CHECK_HEADERS(
> +               [tap-windows.h],
> +               ,
> +               [AC_MSG_ERROR([tap-windows.h is required but missing])]
> +       )
> +       CFLAGS=3D"${old_CFLAGS}"
> +fi
> +
>  if test "${have_openssl_crypto}" =3D "yes"; then
>         saved_CFLAGS=3D"${CFLAGS}"
>         saved_LIBS=3D"${LIBS}"
> diff --git a/include/Makefile.am b/include/Makefile.am
> index 36eeb6c..13dee61 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -12,6 +12,4 @@
>  MAINTAINERCLEANFILES =3D \
>         $(srcdir)/Makefile.in
>
> -dist_noinst_HEADERS =3D tap-windows.h
> -
>  include_HEADERS =3D openvpn-plugin.h
> diff --git a/include/tap-windows.h b/include/tap-windows.h
> deleted file mode 100644
> index 243a4a2..0000000
> --- a/include/tap-windows.h
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -/*
> - *  TAP-Windows -- A kernel driver to provide virtual tap
> - *                 device functionality on Windows.
> - *
> - *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
> - *
> - *  This source code is Copyright (C) 2002-2010 OpenVPN Technologies, In=
c.,
> - *  and is released under the GPL version 2 (see below).
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
> -#ifndef __TAP_WIN_H
> -#define __TAP_WIN_H
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// TAP IOCTLs
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define TAP_WIN_CONTROL_CODE(request,method) \
> -  CTL_CODE (FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
> -
> -// Present in 8.1
> -
> -#define TAP_WIN_IOCTL_GET_MAC               TAP_WIN_CONTROL_CODE (1, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_GET_VERSION           TAP_WIN_CONTROL_CODE (2, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_GET_MTU               TAP_WIN_CONTROL_CODE (3, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_GET_INFO              TAP_WIN_CONTROL_CODE (4, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT TAP_WIN_CONTROL_CODE (5, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_SET_MEDIA_STATUS      TAP_WIN_CONTROL_CODE (6, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_CONFIG_DHCP_MASQ      TAP_WIN_CONTROL_CODE (7, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_GET_LOG_LINE          TAP_WIN_CONTROL_CODE (8, MET=
HOD_BUFFERED)
> -#define TAP_WIN_IOCTL_CONFIG_DHCP_SET_OPT   TAP_WIN_CONTROL_CODE (9, MET=
HOD_BUFFERED)
> -
> -// Added in 8.2
> -
> -/* obsoletes TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT */
> -#define TAP_WIN_IOCTL_CONFIG_TUN            TAP_WIN_CONTROL_CODE (10, ME=
THOD_BUFFERED)
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Registry keys
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define ADAPTER_KEY "SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E97=
2-E325-11CE-BFC1-08002BE10318}"
> -
> -#define NETWORK_CONNECTIONS_KEY "SYSTEM\\CurrentControlSet\\Control\\Net=
work\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Filesystem prefixes
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define USERMODEDEVICEDIR "\\\\.\\Global\\"
> -#define SYSDEVICEDIR      "\\Device\\"
> -#define USERDEVICEDIR     "\\DosDevices\\Global\\"
> -#define TAP_WIN_SUFFIX    ".tap"
> -
> -#endif
> diff --git a/msvc-env.bat b/msvc-env.bat
> index ef9c7bb..e37757b 100644
> --- a/msvc-env.bat
> +++ b/msvc-env.bat
> @@ -23,7 +23,9 @@ if "%OPENVPN_DEPROOT%" =3D=3D "" set OPENVPN_DEPROOT=3D=
c:\Temp\openvpn-deps
>  if "%OPENSSL_HOME%" =3D=3D "" set OPENSSL_HOME=3D%OPENVPN_DEPROOT%
>  if "%LZO_HOME%" =3D=3D "" set LZO_HOME=3D%OPENVPN_DEPROOT%
>  if "%PKCS11H_HOME%" =3D=3D "" set PKCS11H_HOME=3D%OPENVPN_DEPROOT%
> +if "%TAP_WINDOWS_HOME%" =3D=3D "" set TAP_WINDOWS_HOME=3D%OPENVPN_DEPROO=
T%
>
>  if not exist "%OPENSSL_HOME%" echo WARNING: openssl '%OPENSSL_HOME%' doe=
s not exist
>  if not exist "%LZO_HOME%" echo WARNING: lzo '%LZO_HOME%' does not exist
>  if not exist "%PKCS11H_HOME%" echo WARNING: pkcs11-helper '%PKCS11H_HOME=
%' does not exist
> +if not exist "%TAP_WINDOWS_HOME%" echo WARNING: tap-windows '%TAP_WINDOW=
S_HOME%' does not exist
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 6ba12b8..1410021 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -22,6 +22,7 @@ INCLUDES =3D \
>         -I$(top_srcdir)/src/compat
>
>  AM_CFLAGS =3D \
> +       $(TAP_WINDOWS_CFLAGS) \
>         $(OPTIONAL_CRYPTO_CFLAGS) \
>         $(OPTIONAL_LZO_CFLAGS) \
>         $(OPTIONAL_PKCS11_HELPER_CFLAGS)
> diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
> index 4680e52..c1aa8a0 100644
> --- a/src/openvpn/openvpn.vcproj
> +++ b/src/openvpn/openvpn.vcproj
> @@ -41,7 +41,7 @@
>                         <Tool
>                                 Name=3D"VCCLCompilerTool"
>                                 Optimization=3D"0"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(OPENSSL_HOME)/include=
;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/inc=
lude;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
>                                 PreprocessorDefinitions=3D"WIN32;_DEBUG;_=
CONSOLE;$(CPPFLAGS)"
>                                 MinimalRebuild=3D"true"
>                                 BasicRuntimeChecks=3D"3"
> @@ -118,7 +118,7 @@
>                                 Name=3D"VCCLCompilerTool"
>                                 Optimization=3D"2"
>                                 EnableIntrinsicFunctions=3D"true"
> -                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(OPENSSL_HOME)/include=
;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
> +                               AdditionalIncludeDirectories=3D"$(SOURCEB=
ASE);$(SOURCEBASE)/src/compat;$(SOURCEBASE)/include;$(TAP_WINDOWS_HOME)/inc=
lude;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include"
>                                 PreprocessorDefinitions=3D"WIN32;NDEBUG;_=
CONSOLE;$(CPPFLAGS)"
>                                 RuntimeLibrary=3D"2"
>                                 EnableFunctionLevelLinking=3D"true"
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



