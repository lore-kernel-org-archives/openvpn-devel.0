Message-ID: <4F55EECD.70107@...515...>
Date: Tue, 06 Mar 2012 13:02:37 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-20-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-20-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 19/52] Remove tap-win32
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

As tap-win32 is being moved to a separate subproject, this makes sense.

ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


> Introduce tap-windows.h which is modified tap-win32/common.h.
> Except of function rename, it is the same without the tap_id.
> This file should be provided as part of tap-win32 MSI.
> For now we hold a copy.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  Makefile.am                    |    3 +-
>  configure.ac                   |   14 +-
>  tap-win32/MAKEFILE             |    6 -
>  tap-win32/SOURCES.in           |   64 -
>  tap-win32/common.h             |   82 --
>  tap-win32/constants.h          |   52 -
>  tap-win32/dhcp.c               |  599 --------
>  tap-win32/dhcp.h               |  164 ---
>  tap-win32/endian.h             |   35 -
>  tap-win32/error.c              |  378 -----
>  tap-win32/error.h              |   88 --
>  tap-win32/hexdump.c            |   69 -
>  tap-win32/hexdump.h            |   63 -
>  tap-win32/i386/OemWin2k.inf.in |  195 ---
>  tap-win32/instance.c           |  241 ---
>  tap-win32/lock.h               |   75 -
>  tap-win32/macinfo.c            |  154 --
>  tap-win32/macinfo.h            |   38 -
>  tap-win32/mem.c                |  186 ---
>  tap-win32/proto.h              |  224 ---
>  tap-win32/prototypes.h         |  260 ----
>  tap-win32/resource.rc          |   58 -
>  tap-win32/tapdrvr.c            | 3146 ----------------------------------=
------
>  tap-win32/types.h              |  178 ---
>  tap-windows.h                  |   68 +
>  tun.h                          |    2 +-
>  win/autodefs.h.in              |    2 +-
>  27 files changed, 78 insertions(+), 6366 deletions(-)
>  delete mode 100755 tap-win32/MAKEFILE
>  delete mode 100755 tap-win32/SOURCES.in
>  delete mode 100755 tap-win32/common.h
>  delete mode 100755 tap-win32/constants.h
>  delete mode 100755 tap-win32/dhcp.c
>  delete mode 100755 tap-win32/dhcp.h
>  delete mode 100755 tap-win32/endian.h
>  delete mode 100755 tap-win32/error.c
>  delete mode 100755 tap-win32/error.h
>  delete mode 100755 tap-win32/hexdump.c
>  delete mode 100755 tap-win32/hexdump.h
>  delete mode 100755 tap-win32/i386/OemWin2k.inf.in
>  delete mode 100755 tap-win32/instance.c
>  delete mode 100755 tap-win32/lock.h
>  delete mode 100755 tap-win32/macinfo.c
>  delete mode 100755 tap-win32/macinfo.h
>  delete mode 100755 tap-win32/mem.c
>  delete mode 100755 tap-win32/proto.h
>  delete mode 100755 tap-win32/prototypes.h
>  delete mode 100755 tap-win32/resource.rc
>  delete mode 100755 tap-win32/tapdrvr.c
>  delete mode 100755 tap-win32/types.h
>  create mode 100644 tap-windows.h
>
> diff --git a/Makefile.am b/Makefile.am
> index b6fcfbb..74f388a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -44,7 +44,6 @@ EXTRA_DIST =3D \
>         sample-keys \
>         sample-scripts \
>         suse \
> -       tap-win32 \
>         contrib \
>         debug \
>         plugins \
> @@ -147,7 +146,7 @@ openvpn_SOURCES =3D \
>         ssl_verify_polarssl.c ssl_verify_polarssl.h \
>         status.c status.h \
>         syshead.h \
> -       tun.c tun.h \
> +       tun.c tun.h tap-windows.h \
>         win32.h win32.c \
>         cryptoapi.h cryptoapi.c
>
> diff --git a/configure.ac b/configure.ac
> index 747c7b4..937ce1f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -959,15 +959,15 @@ if test "$SELINUX" =3D "yes"; then
>     )
>  fi
>
> -TAP_ID=3D"PRODUCT_TAP_ID"
> +TAP_COMPONENT_ID=3D"PRODUCT_TAP_ID"
>  TAP_WIN32_MIN_MAJOR=3D"PRODUCT_TAP_WIN32_MIN_MAJOR"
>  TAP_WIN32_MIN_MINOR=3D"PRODUCT_TAP_WIN32_MIN_MINOR"
> -AC_DEFINE_UNQUOTED(TAP_ID, "${TAP_ID}", [The TAP-Win32 id defined in tap=
-win32/SOURCES])
> -AC_DEFINE_UNQUOTED(TAP_WIN32_MIN_MAJOR, ${TAP_WIN32_MIN_MAJOR}, [The TAP=
-Win32 version number is defined in tap-win32/SOURCES])
> -AC_DEFINE_UNQUOTED(TAP_WIN32_MIN_MINOR, ${TAP_WIN32_MIN_MINOR}, [The TAP=
-Win32 version number is defined in tap-win32/SOURCES])
> -AC_SUBST(TAP_ID)
> -AC_SUBST(TAP_WIN32_MIN_MAJOR)
> -AC_SUBST(TAP_WIN32_MIN_MINOR)
> +AC_DEFINE_UNQUOTED([TAP_ID], ["${TAP_ID}"], [The TAP-Win32 id])
> +AC_DEFINE_UNQUOTED([TAP_WIN32_MIN_MAJOR], [${TAP_WIN32_MIN_MAJOR}], [The=
 TAP-Win32 version number is defined in tap-win32/SOURCES])
> +AC_DEFINE_UNQUOTED([TAP_WIN32_MIN_MINOR], [${TAP_WIN32_MIN_MINOR}], [The=
 TAP-Win32 version number is defined in tap-win32/SOURCES])
> +AC_SUBST([TAP_COMPONENT_ID])
> +AC_SUBST([TAP_WIN32_MIN_MAJOR])
> +AC_SUBST([TAP_WIN32_MIN_MINOR])
>
>  win32datadir=3D"\${datadir}/${PACKAGE}-win32"
>  AC_SUBST(win32datadir)
> diff --git a/tap-win32/MAKEFILE b/tap-win32/MAKEFILE
> deleted file mode 100755
> index 6ee4f43..0000000
> --- a/tap-win32/MAKEFILE
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#
> -# DO NOT EDIT THIS FILE!!!  Edit .\sources. if you want to add a new sou=
rce
> -# file to this component.  This file merely indirects to the real make f=
ile
> -# that is shared by all the components of NT OS/2
> -#
> -!INCLUDE $(NTMAKEENV)\makefile.def
> diff --git a/tap-win32/SOURCES.in b/tap-win32/SOURCES.in
> deleted file mode 100755
> index cf030f4..0000000
> --- a/tap-win32/SOURCES.in
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -# Build TAP-Win32 driver.
> -# Build Command: build -cef
> -
> -MAJORCOMP=3Dntos
> -MINORCOMP=3Dndis
> -
> -TARGETNAME=3D@@PRODUCT_TAP_ID@@
> -TARGETTYPE=3DDRIVER
> -TARGETPATH=3D.
> -TARGETLIBS=3D$(DDK_LIB_PATH)\ndis.lib $(DDK_LIB_PATH)\ntstrsafe.lib
> -INCLUDES=3D$(DDK_INCLUDE_PATH) ..
> -
> -# The TAP version numbers here must be >=3D
> -# PRODUCT_TAP_WIN32_MIN_x values defined in version.m4
> -C_DEFINES=3D
> -C_DEFINES=3D$(C_DEFINES) -DTAP_DRIVER_MAJOR_VERSION=3D@@PRODUCT_TAP_MAJO=
R_VER@@
> -C_DEFINES=3D$(C_DEFINES) -DTAP_DRIVER_MINOR_VERSION=3D@@PRODUCT_TAP_MINO=
R_VER@@
> -
> -# Produce the same symbolic information for both free & checked builds.
> -# This will allow us to perform full source-level debugging on both
> -# builds without affecting the free build's performance.
> -!IF "$(DDKBUILDENV)" !=3D "chk"
> -NTDEBUGTYPE=3Dboth
> -USE_PDB=3D1
> -!ELSE
> -NTDEBUGTYPE=3Dboth
> -USE_PDB=3D1
> -!ENDIF
> -
> -# Set compiler optimizations:
> -# /Ox - Full optimization enabled
> -# /Os - favor speed over size when optimizing
> -# /Od - Disable all optimizations
> -# /Oi - Enable optimization for intrinsic functions
> -# /Fc - Generate mixed assembler/source code files
> -#
> -# For both checked and free builds, make sure that any intrinsic
> -# functions are compiled correctly. To do this, ensure that /Oi
> -# is selected for both free and checked builds. There is a bug in
> -# VC++ 6.0 (at least through SP4) where, if you specify any
> -# intrinsic functions in your code with "#pragma intrinsic" but
> -# you don't have the /Oi optimization enabled, neither a call
> -# to the function, nor the intrinsic inline version of the function
> -# will end up in your object code. This bug only applies to free
> -# builds, but just to be safe we'll make sure that the flag is
> -# enabled for all builds.
> -
> -!IF "$(DDKBUILDENV)" !=3D "chk"
> -MSC_OPTIMIZATION=3D/Ox /Oi /Fc
> -!ELSE
> -MSC_OPTIMIZATION=3D/Od /Oi /Fc
> -!ENDIF
> -
> -# Generate a linker map file just in case we need one for debugging
> -LINKER_FLAGS=3D$(LINKER_FLAGS) /INCREMENTAL:NO /MAP /MAPINFO:EXPORTS
> -
> -# Generate a browser information file for use in IDE development
> -#BROWSER_INFO=3D1
> -#BROWSERFILE=3D$(TARGETNAME).BSC -n
> -
> -# Abort compilation on warnings by adding /WX
> -MSC_WARNING_LEVEL=3D/W3
> -
> -SOURCES=3Dtapdrvr.c resource.rc
> diff --git a/tap-win32/common.h b/tap-win32/common.h
> deleted file mode 100755
> index bb8ab90..0000000
> --- a/tap-win32/common.h
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// This file is included both by OpenVPN and
> -// the TAP-Win32 driver and contains definitions
> -// common to both.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#ifndef HAVE_CONFIG_H
> -#include "autodefs.h"
> -#endif
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// TAP IOCTLs
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define TAP_CONTROL_CODE(request,method) \
> -  CTL_CODE (FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
> -
> -// Present in 8.1
> -
> -#define TAP_IOCTL_GET_MAC               TAP_CONTROL_CODE (1, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_GET_VERSION           TAP_CONTROL_CODE (2, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_GET_MTU               TAP_CONTROL_CODE (3, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_GET_INFO              TAP_CONTROL_CODE (4, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE (5, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_SET_MEDIA_STATUS      TAP_CONTROL_CODE (6, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_CONFIG_DHCP_MASQ      TAP_CONTROL_CODE (7, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_GET_LOG_LINE          TAP_CONTROL_CODE (8, METHOD_BUFF=
ERED)
> -#define TAP_IOCTL_CONFIG_DHCP_SET_OPT   TAP_CONTROL_CODE (9, METHOD_BUFF=
ERED)
> -
> -// Added in 8.2
> -
> -/* obsoletes TAP_IOCTL_CONFIG_POINT_TO_POINT */
> -#define TAP_IOCTL_CONFIG_TUN            TAP_CONTROL_CODE (10, METHOD_BUF=
FERED)
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
> -#define TAPSUFFIX         ".tap"
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// TAP_COMPONENT_ID -- This string defines the TAP driver
> -// type -- different component IDs can reside in the system
> -// simultaneously.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define TAP_COMPONENT_ID TAP_ID
> diff --git a/tap-win32/constants.h b/tap-win32/constants.h
> deleted file mode 100755
> index 9bbd7ee..0000000
> --- a/tap-win32/constants.h
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                        Product and Version public settings
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define PRODUCT_STRING PRODUCT_TAP_DEVICE_DESCRIPTION
> -
> -#define TAP_NDIS_MAJOR_VERSION 5
> -#define TAP_NDIS_MINOR_VERSION 0
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Driver constants
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define ETHERNET_HEADER_SIZE     (sizeof (ETH_HEADER))
> -#define ETHERNET_MTU             1500
> -#define ETHERNET_PACKET_SIZE     (ETHERNET_MTU + ETHERNET_HEADER_SIZE)
> -#define DEFAULT_PACKET_LOOKAHEAD (ETHERNET_PACKET_SIZE)
> -
> -#define NIC_MAX_MCAST_LIST 32  // Max length of multicast address list
> -
> -#define MINIMUM_MTU 576        // USE TCP Minimum MTU
> -#define MAXIMUM_MTU 65536      // IP maximum MTU
> -
> -#define PACKET_QUEUE_SIZE   64 // tap -> userspace queue size
> -#define IRP_QUEUE_SIZE      16 // max number of simultaneous i/o operati=
ons from userspace
> -#define INJECT_QUEUE_SIZE   16 // DHCP/ARP -> tap injection queue
> -
> -#define TAP_LITTLE_ENDIAN      // affects ntohs, htonl, etc. functions
> diff --git a/tap-win32/dhcp.c b/tap-win32/dhcp.c
> deleted file mode 100755
> index 3891d42..0000000
> --- a/tap-win32/dhcp.c
> +++ /dev/null
> @@ -1,599 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -// Code to set DHCP options
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -
> -VOID
> -SetDHCPOpt (DHCPMsg *m, void *data, unsigned int len)
> -{
> -  if (!m->overflow)
> -    {
> -      if (m->optlen + len <=3D DHCP_OPTIONS_BUFFER_SIZE)
> -       {
> -         if (len)
> -           {
> -             NdisMoveMemory (m->msg.options + m->optlen, data, len);
> -             m->optlen +=3D len;
> -           }
> -       }
> -      else
> -       {
> -         m->overflow =3D TRUE;
> -       }
> -    }
> -}
> -
> -VOID
> -SetDHCPOpt0 (DHCPMsg *msg, int type)
> -{
> -  DHCPOPT0 opt;
> -  opt.type =3D (UCHAR) type;
> -  SetDHCPOpt (msg, &opt, sizeof (opt));
> -}
> -
> -VOID
> -SetDHCPOpt8 (DHCPMsg *msg, int type, ULONG data)
> -{
> -  DHCPOPT8 opt;
> -  opt.type =3D (UCHAR) type;
> -  opt.len =3D sizeof (opt.data);
> -  opt.data =3D (UCHAR) data;
> -  SetDHCPOpt (msg, &opt, sizeof (opt));
> -}
> -
> -VOID
> -SetDHCPOpt32 (DHCPMsg *msg, int type, ULONG data)
> -{
> -  DHCPOPT32 opt;
> -  opt.type =3D (UCHAR) type;
> -  opt.len =3D sizeof (opt.data);
> -  opt.data =3D data;
> -  SetDHCPOpt (msg, &opt, sizeof (opt));
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Checksum code
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -USHORT
> -ip_checksum (const UCHAR *buf, const int len_ip_header)
> -{
> -  USHORT word16;
> -  ULONG sum =3D 0;
> -  int i;
> -
> -  // make 16 bit words out of every two adjacent 8 bit words in the pack=
et
> -  // and add them up
> -  for (i =3D 0; i < len_ip_header - 1; i +=3D 2) {
> -    word16 =3D ((buf[i] << 8) & 0xFF00) + (buf[i+1] & 0xFF);
> -    sum +=3D (ULONG) word16;
> -  }
> -
> -  // take only 16 bits out of the 32 bit sum and add up the carries
> -  while (sum >> 16)
> -    sum =3D (sum & 0xFFFF) + (sum >> 16);
> -
> -  // one's complement the result
> -  return ((USHORT) ~sum);
> -}
> -
> -USHORT
> -udp_checksum (const UCHAR *buf,
> -             const int len_udp,
> -             const UCHAR *src_addr,
> -             const UCHAR *dest_addr)
> -{
> -  USHORT word16;
> -  ULONG sum =3D 0;
> -  int i;
> -
> -  // make 16 bit words out of every two adjacent 8 bit words and
> -  // calculate the sum of all 16 bit words
> -  for (i =3D 0; i < len_udp; i +=3D 2){
> -    word16 =3D ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_udp) ? (buf[i+1]=
 & 0xFF) : 0);
> -    sum +=3D word16;
> -  }
> -
> -  // add the UDP pseudo header which contains the IP source and destinat=
ion addresses
> -  for (i =3D 0; i < 4; i +=3D 2){
> -    word16 =3D((src_addr[i] << 8) & 0xFF00) + (src_addr[i+1] & 0xFF);
> -    sum +=3D word16;
> -  }
> -  for (i =3D 0; i < 4; i +=3D 2){
> -    word16 =3D((dest_addr[i] << 8) & 0xFF00) + (dest_addr[i+1] & 0xFF);
> -    sum +=3D word16;
> -  }
> -
> -  // the protocol number and the length of the UDP packet
> -  sum +=3D (USHORT) IPPROTO_UDP + (USHORT) len_udp;
> -
> -  // keep only the last 16 bits of the 32 bit calculated sum and add the=
 carries
> -  while (sum >> 16)
> -    sum =3D (sum & 0xFFFF) + (sum >> 16);
> -
> -  // Take the one's complement of sum
> -  return ((USHORT) ~sum);
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Set IP and UDP packet checksums
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -VOID
> -SetChecksumDHCPMsg (DHCPMsg *m)
> -{
> -  // Set IP checksum
> -  m->msg.pre.ip.check =3D htons (ip_checksum ((UCHAR *) &m->msg.pre.ip, =
sizeof (IPHDR)));
> -
> -  // Set UDP Checksum
> -  m->msg.pre.udp.check =3D htons (udp_checksum ((UCHAR *) &m->msg.pre.ud=
p,
> -                                             sizeof (UDPHDR) + sizeof (D=
HCP) + m->optlen,
> -                                             (UCHAR *)&m->msg.pre.ip.sad=
dr,
> -                                             (UCHAR *)&m->msg.pre.ip.dad=
dr));
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// DHCP message tests
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -int
> -GetDHCPMessageType (const DHCP *dhcp, const int optlen)
> -{
> -  const UCHAR *p =3D (UCHAR *) (dhcp + 1);
> -  int i;
> -
> -  for (i =3D 0; i < optlen; ++i)
> -    {
> -      const UCHAR type =3D p[i];
> -      const int room =3D optlen - i - 1;
> -      if (type =3D=3D DHCP_END)           // didn't find what we were lo=
oking for
> -       return -1;
> -      else if (type =3D=3D DHCP_PAD)      // no-operation
> -       ;
> -      else if (type =3D=3D DHCP_MSG_TYPE) // what we are looking for
> -       {
> -         if (room >=3D 2)
> -           {
> -             if (p[i+1] =3D=3D 1)        // message length should be 1
> -               return p[i+2];        // return message type
> -           }
> -         return -1;
> -       }
> -      else                            // some other message
> -       {
> -         if (room >=3D 1)
> -           {
> -             const int len =3D p[i+1]; // get message length
> -             i +=3D (len + 1);         // advance to next message
> -           }
> -       }
> -    }
> -  return -1;
> -}
> -
> -BOOLEAN
> -DHCPMessageOurs (const TapAdapterPointer p_Adapter,
> -                const ETH_HEADER *eth,
> -                const IPHDR *ip,
> -                const UDPHDR *udp,
> -                const DHCP *dhcp)
> -{
> -  // Must be UDPv4 protocol
> -  if (!(eth->proto =3D=3D htons (ETH_P_IP) && ip->protocol =3D=3D IPPROT=
O_UDP))
> -    return FALSE;
> -
> -  // Source MAC must be our adapter
> -  if (!MAC_EQUAL (eth->src, p_Adapter->m_MAC))
> -    return FALSE;
> -
> -  // Dest MAC must be either broadcast or our virtual DHCP server
> -  if (!(MAC_EQUAL (eth->dest, p_Adapter->m_MAC_Broadcast)
> -       || MAC_EQUAL (eth->dest, p_Adapter->m_dhcp_server_mac)))
> -    return FALSE;
> -
> -  // Port numbers must be correct
> -  if (!(udp->dest =3D=3D htons (BOOTPS_PORT)
> -       && udp->source =3D=3D htons (BOOTPC_PORT)))
> -    return FALSE;
> -
> -  // Hardware address must be MAC addr sized
> -  if (!(dhcp->hlen =3D=3D sizeof (MACADDR)))
> -    return FALSE;
> -
> -  // Hardware address must match our adapter
> -  if (!MAC_EQUAL (eth->src, dhcp->chaddr))
> -    return FALSE;
> -
> -  return TRUE;
> -}
> -
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -// Build all of DHCP packet except for DHCP options.
> -// Assume that *p has been zeroed before we are called.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -
> -VOID
> -BuildDHCPPre (const TapAdapterPointer a,
> -             DHCPPre *p,
> -             const ETH_HEADER *eth,
> -             const IPHDR *ip,
> -             const UDPHDR *udp,
> -             const DHCP *dhcp,
> -             const int optlen,
> -             const int type)
> -{
> -  // Should we broadcast or direct to a specific MAC / IP address?
> -  const BOOLEAN broadcast =3D (type =3D=3D DHCPNAK
> -                            || MAC_EQUAL (eth->dest, a->m_MAC_Broadcast)=
);
> -  // Build ethernet header
> -
> -  COPY_MAC (p->eth.src, a->m_dhcp_server_mac);
> -
> -  if (broadcast)
> -    COPY_MAC (p->eth.dest, a->m_MAC_Broadcast);
> -  else
> -    COPY_MAC (p->eth.dest, eth->src);
> -
> -  p->eth.proto =3D htons (ETH_P_IP);
> -
> -  // Build IP header
> -
> -  p->ip.version_len =3D (4 << 4) | (sizeof (IPHDR) >> 2);
> -  p->ip.tos =3D 0;
> -  p->ip.tot_len =3D htons (sizeof (IPHDR) + sizeof (UDPHDR) + sizeof (DH=
CP) + optlen);
> -  p->ip.id =3D 0;
> -  p->ip.frag_off =3D 0;
> -  p->ip.ttl =3D 16;
> -  p->ip.protocol =3D IPPROTO_UDP;
> -  p->ip.check =3D 0;
> -  p->ip.saddr =3D a->m_dhcp_server_ip;
> -
> -  if (broadcast)
> -    p->ip.daddr =3D ~0;
> -  else
> -    p->ip.daddr =3D a->m_dhcp_addr;
> -
> -  // Build UDP header
> -
> -  p->udp.source =3D htons (BOOTPS_PORT);
> -  p->udp.dest =3D htons (BOOTPC_PORT);
> -  p->udp.len =3D htons (sizeof (UDPHDR) + sizeof (DHCP) + optlen);
> -  p->udp.check =3D 0;
> -
> -  // Build DHCP response
> -
> -  p->dhcp.op =3D BOOTREPLY;
> -  p->dhcp.htype =3D 1;
> -  p->dhcp.hlen =3D sizeof (MACADDR);
> -  p->dhcp.hops =3D 0;
> -  p->dhcp.xid =3D dhcp->xid;
> -  p->dhcp.secs =3D 0;
> -  p->dhcp.flags =3D 0;
> -  p->dhcp.ciaddr =3D 0;
> -
> -  if (type =3D=3D DHCPNAK)
> -    p->dhcp.yiaddr =3D 0;
> -  else
> -    p->dhcp.yiaddr =3D a->m_dhcp_addr;
> -
> -  p->dhcp.siaddr =3D a->m_dhcp_server_ip;
> -  p->dhcp.giaddr =3D 0;
> -  COPY_MAC (p->dhcp.chaddr, eth->src);
> -  p->dhcp.magic =3D htonl (0x63825363);
> -}
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -// Build specific DHCP messages
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -
> -VOID
> -SendDHCPMsg (const TapAdapterPointer a,
> -            const int type,
> -            const ETH_HEADER *eth,
> -            const IPHDR *ip,
> -            const UDPHDR *udp,
> -            const DHCP *dhcp)
> -{
> -  DHCPMsg *pkt;
> -
> -  if (!(type =3D=3D DHCPOFFER || type =3D=3D DHCPACK || type =3D=3D DHCP=
NAK))
> -    {
> -      DEBUGP (("[TAP] SendDHCPMsg: Bad DHCP type: %d\n", type));
> -      return;
> -    }
> -
> -  pkt =3D (DHCPMsg *) MemAlloc (sizeof (DHCPMsg), TRUE);
> -
> -  if (pkt)
> -    {
> -      //-----------------------
> -      // Build DHCP options
> -      //-----------------------
> -
> -      // Message Type
> -      SetDHCPOpt8 (pkt, DHCP_MSG_TYPE, type);
> -
> -      // Server ID
> -      SetDHCPOpt32 (pkt, DHCP_SERVER_ID, a->m_dhcp_server_ip);
> -
> -      if (type =3D=3D DHCPOFFER || type =3D=3D DHCPACK)
> -       {
> -         // Lease Time
> -         SetDHCPOpt32 (pkt, DHCP_LEASE_TIME, htonl (a->m_dhcp_lease_time=
));
> -
> -         // Netmask
> -         SetDHCPOpt32 (pkt, DHCP_NETMASK, a->m_dhcp_netmask);
> -
> -         // Other user-defined options
> -         SetDHCPOpt (pkt,
> -                     a->m_dhcp_user_supplied_options_buffer,
> -                     a->m_dhcp_user_supplied_options_buffer_len);
> -       }
> -
> -      // End
> -      SetDHCPOpt0 (pkt, DHCP_END);
> -
> -      if (!DHCPMSG_OVERFLOW (pkt))
> -       {
> -         // The initial part of the DHCP message (not including options)=
 gets built here
> -         BuildDHCPPre (a,
> -                       &pkt->msg.pre,
> -                       eth,
> -                       ip,
> -                       udp,
> -                       dhcp,
> -                       DHCPMSG_LEN_OPT (pkt),
> -                       type);
> -
> -         SetChecksumDHCPMsg (pkt);
> -
> -         DUMP_PACKET ("DHCPMsg",
> -                      DHCPMSG_BUF (pkt),
> -                      DHCPMSG_LEN_FULL (pkt));
> -
> -         // Return DHCP response to kernel
> -         InjectPacketDeferred (a,
> -                               DHCPMSG_BUF (pkt),
> -                               DHCPMSG_LEN_FULL (pkt));
> -       }
> -      else
> -       {
> -         DEBUGP (("[TAP] SendDHCPMsg: DHCP buffer overflow\n"));
> -       }
> -
> -      MemFree (pkt, sizeof (DHCPMsg));
> -    }
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Handle a BOOTPS packet produced by the local system to
> -// resolve the address/netmask of this adapter.
> -// If we are in TAP_IOCTL_CONFIG_DHCP_MASQ mode, reply
> -// to the message.  Return TRUE if we processed the passed
> -// message, so that downstream stages can ignore it.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -BOOLEAN
> -ProcessDHCP (TapAdapterPointer p_Adapter,
> -            const ETH_HEADER *eth,
> -            const IPHDR *ip,
> -            const UDPHDR *udp,
> -            const DHCP *dhcp,
> -            int optlen)
> -{
> -  int msg_type;
> -
> -  // Sanity check IP header
> -  if (!(ntohs (ip->tot_len) =3D=3D sizeof (IPHDR) + sizeof (UDPHDR) + si=
zeof (DHCP) + optlen
> -       && (ntohs (ip->frag_off) & IP_OFFMASK) =3D=3D 0))
> -    return TRUE;
> -
> -  // Does this message belong to us?
> -  if (!DHCPMessageOurs (p_Adapter, eth, ip, udp, dhcp))
> -    return FALSE;
> -
> -  msg_type =3D GetDHCPMessageType (dhcp, optlen);
> -
> -  // Drop non-BOOTREQUEST messages
> -  if (dhcp->op !=3D BOOTREQUEST)
> -    return TRUE;
> -
> -  // Drop any messages except DHCPDISCOVER or DHCPREQUEST
> -  if (!(msg_type =3D=3D DHCPDISCOVER || msg_type =3D=3D DHCPREQUEST))
> -    return TRUE;
> -
> -  // Should we reply with DHCPOFFER, DHCPACK, or DHCPNAK?
> -  if (msg_type =3D=3D DHCPREQUEST
> -      && ((dhcp->ciaddr && dhcp->ciaddr !=3D p_Adapter->m_dhcp_addr)
> -         || !p_Adapter->m_dhcp_received_discover
> -         || p_Adapter->m_dhcp_bad_requests >=3D BAD_DHCPREQUEST_NAK_THRE=
SHOLD))
> -    SendDHCPMsg (p_Adapter,
> -                DHCPNAK,
> -                eth, ip, udp, dhcp);
> -  else
> -    SendDHCPMsg (p_Adapter,
> -                (msg_type =3D=3D DHCPDISCOVER ? DHCPOFFER : DHCPACK),
> -                eth, ip, udp, dhcp);
> -
> -  // Remember if we received a DHCPDISCOVER
> -  if (msg_type =3D=3D DHCPDISCOVER)
> -    p_Adapter->m_dhcp_received_discover =3D TRUE;
> -
> -  // Is this a bad DHCPREQUEST?
> -  if (msg_type =3D=3D DHCPREQUEST && dhcp->ciaddr !=3D p_Adapter->m_dhcp=
_addr)
> -    ++p_Adapter->m_dhcp_bad_requests;
> -
> -  return TRUE;
> -}
> -
> -#if DBG
> -
> -const char *
> -message_op_text (int op)
> -{
> -  switch (op)
> -    {
> -    case BOOTREQUEST:
> -      return "BOOTREQUEST";
> -    case BOOTREPLY:
> -      return "BOOTREPLY";
> -    default:
> -      return "???";
> -    }
> -}
> -
> -const char *
> -message_type_text (int type)
> -{
> -  switch (type)
> -    {
> -    case DHCPDISCOVER:
> -      return "DHCPDISCOVER";
> -    case DHCPOFFER:
> -      return "DHCPOFFER";
> -    case DHCPREQUEST:
> -      return "DHCPREQUEST";
> -    case DHCPDECLINE:
> -      return "DHCPDECLINE";
> -    case DHCPACK:
> -      return "DHCPACK";
> -    case DHCPNAK:
> -      return "DHCPNAK";
> -    case DHCPRELEASE:
> -      return "DHCPRELEASE";
> -    case DHCPINFORM:
> -      return "DHCPINFORM";
> -    default:
> -      return "???";
> -    }
> -}
> -
> -const char *
> -port_name (int port)
> -{
> -  switch (port)
> -    {
> -    case BOOTPS_PORT:
> -      return "BOOTPS";
> -    case BOOTPC_PORT:
> -      return "BOOTPC";
> -    default:
> -      return "unknown";
> -    }
> -}
> -
> -VOID
> -DumpDHCP (const ETH_HEADER *eth,
> -         const IPHDR *ip,
> -         const UDPHDR *udp,
> -         const DHCP *dhcp,
> -         const int optlen)
> -{
> -  DEBUGP ((" %s", message_op_text (dhcp->op)));
> -  DEBUGP ((" %s ", message_type_text (GetDHCPMessageType (dhcp, optlen))=
));
> -  PrIP (ip->saddr);
> -  DEBUGP ((":%s[", port_name (ntohs (udp->source))));
> -  PrMac (eth->src);
> -  DEBUGP (("] -> "));
> -  PrIP (ip->daddr);
> -  DEBUGP ((":%s[", port_name (ntohs (udp->dest))));
> -  PrMac (eth->dest);
> -  DEBUGP (("]"));
> -  if (dhcp->ciaddr)
> -    {
> -      DEBUGP ((" ci=3D"));
> -      PrIP (dhcp->ciaddr);
> -    }
> -  if (dhcp->yiaddr)
> -    {
> -      DEBUGP ((" yi=3D"));
> -      PrIP (dhcp->yiaddr);
> -    }
> -  if (dhcp->siaddr)
> -    {
> -      DEBUGP ((" si=3D"));
> -      PrIP (dhcp->siaddr);
> -    }
> -  if (dhcp->hlen =3D=3D sizeof (MACADDR))
> -    {
> -      DEBUGP ((" ch=3D"));
> -      PrMac (dhcp->chaddr);
> -    }
> -
> -  DEBUGP ((" xid=3D0x%08x", ntohl (dhcp->xid)));
> -
> -  if (ntohl (dhcp->magic) !=3D 0x63825363)
> -    DEBUGP ((" ma=3D0x%08x", ntohl (dhcp->magic)));
> -  if (dhcp->htype !=3D 1)
> -    DEBUGP ((" htype=3D%d", dhcp->htype));
> -  if (dhcp->hops)
> -    DEBUGP ((" hops=3D%d", dhcp->hops));
> -  if (ntohs (dhcp->secs))
> -    DEBUGP ((" secs=3D%d", ntohs (dhcp->secs)));
> -  if (ntohs (dhcp->flags))
> -    DEBUGP ((" flags=3D0x%04x", ntohs (dhcp->flags)));
> -
> -  // extra stuff
> -
> -  if (ip->version_len !=3D 0x45)
> -    DEBUGP ((" vl=3D0x%02x", ip->version_len));
> -  if (ntohs (ip->tot_len) !=3D sizeof (IPHDR) + sizeof (UDPHDR) + sizeof=
 (DHCP) + optlen)
> -    DEBUGP ((" tl=3D%d", ntohs (ip->tot_len)));
> -  if (ntohs (udp->len) !=3D sizeof (UDPHDR) + sizeof (DHCP) + optlen)
> -    DEBUGP ((" ul=3D%d", ntohs (udp->len)));
> -
> -  if (ip->tos)
> -    DEBUGP ((" tos=3D0x%02x", ip->tos));
> -  if (ntohs (ip->id))
> -    DEBUGP ((" id=3D0x%04x", ntohs (ip->id)));
> -  if (ntohs (ip->frag_off))
> -    DEBUGP ((" frag_off=3D0x%04x", ntohs (ip->frag_off)));
> -
> -  DEBUGP ((" ttl=3D%d", ip->ttl));
> -  DEBUGP ((" ic=3D0x%04x [0x%04x]", ntohs (ip->check),
> -           ip_checksum ((UCHAR*)ip, sizeof (IPHDR))));
> -  DEBUGP ((" uc=3D0x%04x [0x%04x/%d]", ntohs (udp->check),
> -           udp_checksum ((UCHAR *) udp,
> -                         sizeof (UDPHDR) + sizeof (DHCP) + optlen,
> -                         (UCHAR *) &ip->saddr,
> -                         (UCHAR *) &ip->daddr),
> -           optlen));
> -
> -  // Options
> -  {
> -    const UCHAR *opt =3D (UCHAR *) (dhcp + 1);
> -    int i;
> -
> -    DEBUGP ((" OPT"));
> -    for (i =3D 0; i < optlen; ++i)
> -      {
> -       const UCHAR data =3D opt[i];
> -       DEBUGP ((".%d", data));
> -      }
> -  }
> -}
> -
> -#endif /* DBG */
> diff --git a/tap-win32/dhcp.h b/tap-win32/dhcp.h
> deleted file mode 100755
> index 4215f81..0000000
> --- a/tap-win32/dhcp.h
> +++ /dev/null
> @@ -1,164 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#pragma pack(1)
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -// How many bad DHCPREQUESTs do we receive before we
> -// return a NAK?
> -//
> -// A bad DHCPREQUEST is defined to be one where the
> -// requestor doesn't know its IP address.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -
> -#define BAD_DHCPREQUEST_NAK_THRESHOLD 3
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Maximum number of DHCP options bytes supplied
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define DHCP_USER_SUPPLIED_OPTIONS_BUFFER_SIZE 256
> -#define DHCP_OPTIONS_BUFFER_SIZE               256
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// UDP port numbers of DHCP messages.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define BOOTPS_PORT 67
> -#define BOOTPC_PORT 68
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -// The DHCP message structure
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> -
> -typedef struct {
> -# define BOOTREQUEST 1
> -# define BOOTREPLY   2
> -  UCHAR op;          /* message op */
> -
> -  UCHAR  htype;      /* hardware address type (e.g. '1' =3D 10Mb Etherne=
t) */
> -  UCHAR  hlen;       /* hardware address length (e.g. '6' for 10Mb Ether=
net) */
> -  UCHAR  hops;       /* client sets to 0, may be used by relay agents */
> -  ULONG  xid;        /* transaction ID, chosen by client */
> -  USHORT secs;       /* seconds since request process began, set by clie=
nt */
> -  USHORT flags;
> -  ULONG  ciaddr;     /* client IP address, client sets if known */
> -  ULONG  yiaddr;     /* 'your' IP address -- server's response to client=
 */
> -  ULONG  siaddr;     /* server IP address */
> -  ULONG  giaddr;     /* relay agent IP address */
> -  UCHAR  chaddr[16]; /* client hardware address */
> -  UCHAR  sname[64];  /* optional server host name */
> -  UCHAR  file[128];  /* boot file name */
> -  ULONG  magic;      /* must be 0x63825363 (network order) */
> -} DHCP;
> -
> -typedef struct {
> -  ETH_HEADER eth;
> -  IPHDR ip;
> -  UDPHDR udp;
> -  DHCP dhcp;
> -} DHCPPre;
> -
> -typedef struct {
> -  DHCPPre pre;
> -  UCHAR options[DHCP_OPTIONS_BUFFER_SIZE];
> -} DHCPFull;
> -
> -typedef struct {
> -  unsigned int optlen;
> -  BOOLEAN overflow;
> -  DHCPFull msg;
> -} DHCPMsg;
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Macros for DHCPMSG
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define DHCPMSG_LEN_BASE(p) (sizeof (DHCPPre))
> -#define DHCPMSG_LEN_OPT(p)  ((p)->optlen)
> -#define DHCPMSG_LEN_FULL(p) (DHCPMSG_LEN_BASE(p) + DHCPMSG_LEN_OPT(p))
> -#define DHCPMSG_BUF(p)      ((UCHAR*) &(p)->msg)
> -#define DHCPMSG_OVERFLOW(p) ((p)->overflow)
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// structs to hold individual DHCP options
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -typedef struct {
> -  UCHAR type;
> -} DHCPOPT0;
> -
> -typedef struct {
> -  UCHAR type;
> -  UCHAR len;
> -  UCHAR data;
> -} DHCPOPT8;
> -
> -typedef struct {
> -  UCHAR type;
> -  UCHAR len;
> -  ULONG data;
> -} DHCPOPT32;
> -
> -#pragma pack()
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// DHCP Option types
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define DHCP_MSG_TYPE    53  /* message type (u8) */
> -#define DHCP_PARM_REQ    55  /* parameter request list: c1 (u8), ... */
> -#define DHCP_CLIENT_ID   61  /* client ID: type (u8), i1 (u8), ... */
> -#define DHCP_IP          50  /* requested IP addr (u32) */
> -#define DHCP_NETMASK      1  /* subnet mask (u32) */
> -#define DHCP_LEASE_TIME  51  /* lease time sec (u32) */
> -#define DHCP_RENEW_TIME  58  /* renewal time sec (u32) */
> -#define DHCP_REBIND_TIME 59  /* rebind time sec (u32) */
> -#define DHCP_SERVER_ID   54  /* server ID: IP addr (u32) */
> -#define DHCP_PAD          0
> -#define DHCP_END        255
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// DHCP Messages types
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#define DHCPDISCOVER 1
> -#define DHCPOFFER    2
> -#define DHCPREQUEST  3
> -#define DHCPDECLINE  4
> -#define DHCPACK      5
> -#define DHCPNAK      6
> -#define DHCPRELEASE  7
> -#define DHCPINFORM   8
> -
> -#if DBG
> -
> -VOID
> -DumpDHCP (const ETH_HEADER *eth,
> -         const IPHDR *ip,
> -         const UDPHDR *udp,
> -         const DHCP *dhcp,
> -         const int optlen);
> -
> -#endif
> diff --git a/tap-win32/endian.h b/tap-win32/endian.h
> deleted file mode 100755
> index 128029a..0000000
> --- a/tap-win32/endian.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#ifdef TAP_LITTLE_ENDIAN
> -#define ntohs(x) RtlUshortByteSwap(x)
> -#define htons(x) RtlUshortByteSwap(x)
> -#define ntohl(x) RtlUlongByteSwap(x)
> -#define htonl(x) RtlUlongByteSwap(x)
> -#else
> -#define ntohs(x) ((USHORT)(x))
> -#define htons(x) ((USHORT)(x))
> -#define ntohl(x) ((ULONG)(x))
> -#define htonl(x) ((ULONG)(x))
> -#endif
> diff --git a/tap-win32/error.c b/tap-win32/error.c
> deleted file mode 100755
> index 5b25f48..0000000
> --- a/tap-win32/error.c
> +++ /dev/null
> @@ -1,378 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//-----------------
> -// DEBUGGING OUTPUT
> -//-----------------
> -
> -const char *g_LastErrorFilename;
> -int g_LastErrorLineNumber;
> -
> -#if DBG
> -
> -DebugOutput g_Debug;
> -
> -BOOLEAN
> -NewlineExists (const char *str, int len)
> -{
> -  while (len-- > 0)
> -    {
> -      const char c =3D *str++;
> -      if (c =3D=3D '\n')
> -       return TRUE;
> -      else if (c =3D=3D '\0')
> -       break;
> -    }
> -  return FALSE;
> -}
> -
> -VOID
> -MyDebugInit (unsigned int bufsiz)
> -{
> -  NdisZeroMemory (&g_Debug, sizeof (g_Debug));
> -  g_Debug.text =3D (char *) MemAlloc (bufsiz, FALSE);
> -  if (g_Debug.text)
> -    g_Debug.capacity =3D bufsiz;
> -}
> -
> -VOID
> -MyDebugFree ()
> -{
> -  if (g_Debug.text)
> -    MemFree (g_Debug.text, g_Debug.capacity);
> -  NdisZeroMemory (&g_Debug, sizeof (g_Debug));
> -}
> -
> -VOID
> -MyDebugPrint (const unsigned char* format, ...)
> -{
> -  if (g_Debug.text && g_Debug.capacity > 0 && CAN_WE_PRINT)
> -    {
> -      BOOLEAN owned;
> -      ACQUIRE_MUTEX_ADAPTIVE (&g_Debug.lock, owned);
> -      if (owned)
> -       {
> -         const int remaining =3D (int)g_Debug.capacity - (int)g_Debug.ou=
t;
> -
> -         if (remaining > 0)
> -           {
> -             va_list args;
> -             NTSTATUS status;
> -             char *end;
> -
> -             va_start (args, format);
> -             status =3D RtlStringCchVPrintfExA (g_Debug.text + g_Debug.o=
ut,
> -                                              remaining,
> -                                              &end,
> -                                              NULL,
> -                                              STRSAFE_NO_TRUNCATION | ST=
RSAFE_IGNORE_NULLS,
> -                                              format,
> -                                              args);
> -             va_end (args);
> -
> -             if (status =3D=3D STATUS_SUCCESS)
> -               g_Debug.out =3D (unsigned int) (end - g_Debug.text);
> -             else
> -               g_Debug.error =3D TRUE;
> -           }
> -         else
> -           g_Debug.error =3D TRUE;
> -
> -         RELEASE_MUTEX (&g_Debug.lock);
> -       }
> -      else
> -       g_Debug.error =3D TRUE;
> -    }
> -}
> -
> -BOOLEAN
> -GetDebugLine (char *buf, const int len)
> -{
> -  static const char *truncated =3D "[OUTPUT TRUNCATED]\n";
> -  BOOLEAN ret =3D FALSE;
> -
> -  NdisZeroMemory (buf, len);
> -
> -  if (g_Debug.text && g_Debug.capacity > 0)
> -    {
> -      BOOLEAN owned;
> -      ACQUIRE_MUTEX_ADAPTIVE (&g_Debug.lock, owned);
> -      if (owned)
> -       {
> -         int i =3D 0;
> -
> -         if (g_Debug.error || NewlineExists (g_Debug.text + g_Debug.in, =
(int)g_Debug.out - (int)g_Debug.in))
> -           {
> -             while (i < (len - 1) && g_Debug.in < g_Debug.out)
> -               {
> -                 const char c =3D g_Debug.text[g_Debug.in++];
> -                 if (c =3D=3D '\n')
> -                   break;
> -                 buf[i++] =3D c;
> -               }
> -             if (i < len)
> -               buf[i] =3D '\0';
> -           }
> -
> -         if (!i)
> -           {
> -             if (g_Debug.in =3D=3D g_Debug.out)
> -               {
> -                 g_Debug.in =3D g_Debug.out =3D 0;
> -                 if (g_Debug.error)
> -                   {
> -                     const unsigned int tlen =3D strlen (truncated);
> -                     if (tlen < g_Debug.capacity)
> -                       {
> -                         NdisMoveMemory (g_Debug.text, truncated, tlen+1=
);
> -                         g_Debug.out =3D tlen;
> -                       }
> -                     g_Debug.error =3D FALSE;
> -                   }
> -               }
> -           }
> -         else
> -           ret =3D TRUE;
> -
> -         RELEASE_MUTEX (&g_Debug.lock);
> -       }
> -    }
> -  return ret;
> -}
> -
> -VOID
> -MyAssert (const unsigned char *file, int line)
> -{
> -      DEBUGP (("MYASSERT failed %s/%d\n", file, line));
> -      KeBugCheckEx (0x0F00BABA,
> -                   (ULONG_PTR) line,
> -                   (ULONG_PTR) 0,
> -                   (ULONG_PTR) 0,
> -                   (ULONG_PTR) 0);
> -}
> -
> -VOID
> -PrMac (const MACADDR mac)
> -{
> -  DEBUGP (("%x:%x:%x:%x:%x:%x",
> -           mac[0], mac[1], mac[2],
> -           mac[3], mac[4], mac[5]));
> -}
> -
> -VOID
> -PrIP (IPADDR ip_addr)
> -{
> -  const unsigned char *ip =3D (const unsigned char *) &ip_addr;
> -
> -  DEBUGP (("%d.%d.%d.%d",
> -           ip[0], ip[1], ip[2], ip[3]));
> -}
> -
> -const char *
> -PrIPProto (int proto)
> -{
> -  switch (proto)
> -    {
> -    case IPPROTO_UDP:
> -      return "UDP";
> -    case IPPROTO_TCP:
> -      return "TCP";
> -    case IPPROTO_ICMP:
> -      return "ICMP";
> -    case IPPROTO_IGMP:
> -      return "IGMP";
> -    default:
> -      return "???";
> -    }
> -}
> -
> -VOID
> -DumpARP (const char *prefix, const ARP_PACKET *arp)
> -{
> -  DEBUGP (("%s ARP src=3D", prefix));
> -  PrMac (arp->m_MAC_Source);
> -  DEBUGP ((" dest=3D"));
> -  PrMac (arp->m_MAC_Destination);
> -  DEBUGP ((" OP=3D0x%04x",
> -           (int)ntohs(arp->m_ARP_Operation)));
> -  DEBUGP ((" M=3D0x%04x(%d)",
> -           (int)ntohs(arp->m_MAC_AddressType),
> -           (int)arp->m_MAC_AddressSize));
> -  DEBUGP ((" P=3D0x%04x(%d)",
> -           (int)ntohs(arp->m_PROTO_AddressType),
> -           (int)arp->m_PROTO_AddressSize));
> -
> -  DEBUGP ((" MacSrc=3D"));
> -  PrMac (arp->m_ARP_MAC_Source);
> -  DEBUGP ((" MacDest=3D"));
> -  PrMac (arp->m_ARP_MAC_Destination);
> -
> -  DEBUGP ((" IPSrc=3D"));
> -  PrIP (arp->m_ARP_IP_Source);
> -  DEBUGP ((" IPDest=3D"));
> -  PrIP (arp->m_ARP_IP_Destination);
> -
> -  DEBUGP (("\n"));
> -}
> -
> -struct ethpayload {
> -  ETH_HEADER eth;
> -  UCHAR payload[DEFAULT_PACKET_LOOKAHEAD];
> -};
> -
> -VOID
> -DumpPacket2 (const char *prefix,
> -            const ETH_HEADER *eth,
> -            const unsigned char *data,
> -            unsigned int len)
> -{
> -  struct ethpayload *ep =3D (struct ethpayload *) MemAlloc (sizeof (stru=
ct ethpayload), TRUE);
> -  if (ep)
> -    {
> -      if (len > DEFAULT_PACKET_LOOKAHEAD)
> -       len =3D DEFAULT_PACKET_LOOKAHEAD;
> -      ep->eth =3D *eth;
> -      NdisMoveMemory (ep->payload, data, len);
> -      DumpPacket (prefix, (unsigned char *) ep, sizeof (ETH_HEADER) + le=
n);
> -      MemFree (ep, sizeof (struct ethpayload));
> -    }
> -}
> -
> -VOID
> -DumpPacket (const char *prefix,
> -           const unsigned char *data,
> -           unsigned int len)
> -{
> -  const ETH_HEADER *eth =3D (const ETH_HEADER *) data;
> -  const IPHDR *ip =3D (const IPHDR *) (data + sizeof (ETH_HEADER));
> -
> -  if (len < sizeof (ETH_HEADER))
> -    {
> -      DEBUGP (("%s TRUNCATED PACKET LEN=3D%d\n", prefix, len));
> -      return;
> -    }
> -
> -  // ARP Packet?
> -  if (len >=3D sizeof (ARP_PACKET) && eth->proto =3D=3D htons (ETH_P_ARP=
))
> -    {
> -      DumpARP (prefix, (const ARP_PACKET *) data);
> -      return;
> -    }
> -
> -  // IPv4 packet?
> -  if (len >=3D (sizeof (IPHDR) + sizeof (ETH_HEADER))
> -      && eth->proto =3D=3D htons (ETH_P_IP)
> -      && IPH_GET_VER (ip->version_len) =3D=3D 4)
> -    {
> -      const int hlen =3D IPH_GET_LEN (ip->version_len);
> -      const int blen =3D len - sizeof (ETH_HEADER);
> -      BOOLEAN did =3D FALSE;
> -
> -      DEBUGP (("%s IPv4 %s[%d]", prefix, PrIPProto (ip->protocol), len));
> -
> -      if (!(ntohs (ip->tot_len) =3D=3D blen && hlen <=3D blen))
> -       {
> -         DEBUGP ((" XXX"));
> -         return;
> -       }
> -
> -      // TCP packet?
> -      if (ip->protocol =3D=3D IPPROTO_TCP
> -         && blen - hlen >=3D (sizeof (TCPHDR)))
> -       {
> -         const TCPHDR *tcp =3D (TCPHDR *) (data + sizeof (ETH_HEADER) + =
hlen);
> -         DEBUGP ((" "));
> -         PrIP (ip->saddr);
> -         DEBUGP ((":%d", ntohs (tcp->source)));
> -         DEBUGP ((" -> "));
> -         PrIP (ip->daddr);
> -         DEBUGP ((":%d", ntohs (tcp->dest)));
> -         did =3D TRUE;
> -       }
> -
> -      // UDP packet?
> -      else if ((ntohs (ip->frag_off) & IP_OFFMASK) =3D=3D 0
> -              && ip->protocol =3D=3D IPPROTO_UDP
> -              && blen - hlen >=3D (sizeof (UDPHDR)))
> -       {
> -         const UDPHDR *udp =3D (UDPHDR *) (data + sizeof (ETH_HEADER) + =
hlen);
> -
> -         // DHCP packet?
> -         if ((udp->dest =3D=3D htons (BOOTPC_PORT) || udp->dest =3D=3D h=
tons (BOOTPS_PORT))
> -             && blen - hlen >=3D (sizeof (UDPHDR) + sizeof (DHCP)))
> -           {
> -             const DHCP *dhcp =3D (DHCP *) (data
> -                                          + hlen
> -                                          + sizeof (ETH_HEADER)
> -                                          + sizeof (UDPHDR));
> -
> -             int optlen =3D len
> -               - sizeof (ETH_HEADER)
> -               - hlen
> -               - sizeof (UDPHDR)
> -               - sizeof (DHCP);
> -
> -             if (optlen < 0)
> -               optlen =3D 0;
> -
> -             DumpDHCP (eth, ip, udp, dhcp, optlen);
> -             did =3D TRUE;
> -           }
> -
> -         if (!did)
> -           {
> -             DEBUGP ((" "));
> -             PrIP (ip->saddr);
> -             DEBUGP ((":%d", ntohs (udp->source)));
> -             DEBUGP ((" -> "));
> -             PrIP (ip->daddr);
> -             DEBUGP ((":%d", ntohs (udp->dest)));
> -             did =3D TRUE;
> -           }
> -       }
> -
> -      if (!did)
> -       {
> -         DEBUGP ((" ipproto=3D%d ", ip->protocol));
> -         PrIP (ip->saddr);
> -         DEBUGP ((" -> "));
> -         PrIP (ip->daddr);
> -       }
> -
> -      DEBUGP (("\n"));
> -      return;
> -    }
> -
> -  {
> -    DEBUGP (("%s ??? src=3D", prefix));
> -    PrMac (eth->src);
> -    DEBUGP ((" dest=3D"));
> -    PrMac (eth->dest);
> -    DEBUGP ((" proto=3D0x%04x len=3D%d\n",
> -             (int) ntohs(eth->proto),
> -             len));
> -  }
> -}
> -
> -#endif
> diff --git a/tap-win32/error.h b/tap-win32/error.h
> deleted file mode 100755
> index d8436dc..0000000
> --- a/tap-win32/error.h
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//-----------------
> -// DEBUGGING OUTPUT
> -//-----------------
> -
> -#define NOTE_ERROR() \
> -{ \
> -  g_LastErrorFilename =3D __FILE__; \
> -  g_LastErrorLineNumber =3D __LINE__; \
> -}
> -
> -#if DBG
> -
> -typedef struct {
> -  unsigned int in;
> -  unsigned int out;
> -  unsigned int capacity;
> -  char *text;
> -  BOOLEAN error;
> -  MUTEX lock;
> -} DebugOutput;
> -
> -VOID MyDebugPrint (const unsigned char* format, ...);
> -
> -VOID MyAssert (const unsigned char *file, int line);
> -
> -VOID DumpPacket (const char *prefix,
> -                const unsigned char *data,
> -                unsigned int len);
> -
> -VOID DumpPacket2 (const char *prefix,
> -                 const ETH_HEADER *eth,
> -                 const unsigned char *data,
> -                 unsigned int len);
> -
> -#define CAN_WE_PRINT (DEBUGP_AT_DISPATCH || KeGetCurrentIrql () < DISPAT=
CH_LEVEL)
> -
> -#if ALSO_DBGPRINT
> -#define DEBUGP(fmt) { MyDebugPrint fmt; if (CAN_WE_PRINT) DbgPrint fmt; }
> -#else
> -#define DEBUGP(fmt) { MyDebugPrint fmt; }
> -#endif
> -
> -#define MYASSERT(exp) \
> -{ \
> -  if (!(exp)) \
> -    { \
> -      MyAssert(__FILE__, __LINE__); \
> -    } \
> -}
> -
> -#define DUMP_PACKET(prefix, data, len) \
> -  DumpPacket (prefix, data, len)
> -
> -#define DUMP_PACKET2(prefix, eth, data, len) \
> -  DumpPacket2 (prefix, eth, data, len)
> -
> -#else
> -
> -#define DEBUGP(fmt)
> -#define MYASSERT(exp)
> -#define DUMP_PACKET(prefix, data, len)
> -#define DUMP_PACKET2(prefix, eth, data, len)
> -
> -#endif
> diff --git a/tap-win32/hexdump.c b/tap-win32/hexdump.c
> deleted file mode 100755
> index 49bc38c..0000000
> --- a/tap-win32/hexdump.c
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -#include "hexdump.h"
> -
> -#ifndef NDIS_MINIPORT_DRIVER
> -
> -VOID (*DbgMessage)(char *p_Format, ...) =3D DisplayDebugString;
> -
> -VOID DisplayDebugString (char *p_Format, ...)
> -   {
> -    static char l_Buffer [4096];
> -
> -    va_list l_ArgumentList;
> -    va_start (l_ArgumentList, p_Format);
> -    vsprintf (l_Buffer, p_Format, l_ArgumentList);
> -    va_end (l_ArgumentList);
> -
> -    OutputDebugStringA (l_Buffer);
> -   }
> -
> -#endif
> -
> -VOID HexDump (unsigned char *p_Buffer, unsigned long p_Size)
> -   {
> -    unsigned long l_Index, l_Idx;
> -    unsigned char l_Row [17];
> -
> -    for (l_Index =3D l_Row [16] =3D 0; l_Index < p_Size || l_Index % 16;=
 ++l_Index)
> -       {
> -        if (l_Index % 16 =3D=3D 0)
> -         DEBUGP (("%05x   ", l_Index));
> -        DEBUGP (("%02x ", l_Row [l_Index % 16] =3D (l_Index < p_Size ? p=
_Buffer [l_Index] : 0)));
> -        l_Row [l_Index % 16] =3D IfPrint (l_Row [l_Index % 16]);
> -        if ((l_Index + 1) % 16 =3D=3D 0)
> -         DEBUGP (("   %s\n", l_Row));
> -       }
> -
> -    DEBUGP (("\n"));
> -   }
> -
> -#ifdef __cplusplus
> -}
> -#endif
> diff --git a/tap-win32/hexdump.h b/tap-win32/hexdump.h
> deleted file mode 100755
> index c1af705..0000000
> --- a/tap-win32/hexdump.h
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#ifndef HEXDUMP_DEFINED
> -#define HEXDUMP_DEFINED
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                                   Debug Routines
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#ifndef NDIS_MINIPORT_DRIVER
> -#   include <stdio.h>
> -#   include <ctype.h>
> -#   include <windows.h>
> -#   include <winnt.h>
> -#   include <memory.h>
> -
> -#   ifndef DEBUGP
> -#      define DEBUGP(fmt) { DbgMessage fmt; }
> -#   endif
> -
> -    extern VOID (*DbgMessage)(char *p_Format, ...);
> -
> -    VOID DisplayDebugString (char *p_Format, ...);
> -#endif
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                              Reporting / Debugging
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -#define IfPrint(c) (c >=3D 32 && c < 127 ? c : '.')
> -
> -VOID HexDump (unsigned char *p_Buffer, unsigned long p_Size);
> -
> -#ifdef __cplusplus
> -}
> -#endif
> -
> -#endif
> diff --git a/tap-win32/i386/OemWin2k.inf.in b/tap-win32/i386/OemWin2k.inf=
.in
> deleted file mode 100755
> index 031b06c..0000000
> --- a/tap-win32/i386/OemWin2k.inf.in
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -; **********************************************************************=
******
> -; * Copyright (C) 2002-2010 OpenVPN Technologies, Inc.                  =
          *
> -; *  This program is free software; you can redistribute it and/or modif=
y    *
> -; *  it under the terms of the GNU General Public License version 2     =
     *
> -; *  as published by the Free Software Foundation.                      =
     *
> -; **********************************************************************=
******
> -
> -; SYNTAX CHECKER
> -; cd \WINDDK\3790\tools\chkinf
> -; chkinf c:\src\openvpn\tap-win32\i386\oemwin2k.inf
> -; OUTPUT -> file:///c:/WINDDK/3790/tools/chkinf/htm/c%23+src+openvpn+tap=
-win32+i386+__OemWin2k.htm
> -
> -; INSTALL/REMOVE DRIVER
> -;   tapinstall install OemWin2k.inf TAP0901
> -;   tapinstall update OemWin2k.inf TAP0901
> -;   tapinstall remove TAP0901
> -
> -;*********************************************************
> -; Note to Developers:
> -;
> -; If you are bundling the TAP-Win32 driver with your app,
> -; you should try to rename it in such a way that it will
> -; not collide with other instances of TAP-Win32 defined
> -; by other apps.  Multiple versions of the TAP-Win32
> -; driver, each installed by different apps, can coexist
> -; on the same machine if you follow these guidelines.
> -; NOTE: these instructions assume you are editing the
> -; generated OemWin2k.inf file, not the source
> -; OemWin2k.inf.in file which is preprocessed by winconfig
> -; and uses macro definitions from settings.in.
> -;
> -; (1) Rename all tapXXXX instances in this file to
> -;     something different (use at least 5 characters
> -;     for this name!)
> -; (2) Change the "!define TAP" definition in openvpn.nsi
> -;     to match what you changed tapXXXX to.
> -; (3) Change TARGETNAME in SOURCES to match what you
> -;     changed tapXXXX to.
> -; (4) Change TAP_COMPONENT_ID in common.h to match what
> -;     you changed tapXXXX to.
> -; (5) Change SZDEPENDENCIES in service.h to match what
> -;     you changed tapXXXX to.
> -; (6) Change DeviceDescription and Provider strings.
> -; (7) Change PRODUCT_STRING in constants.h to what you
> -;     set DeviceDescription to.
> -;
> -;*********************************************************
> -
> -[Version]
> -   Signature =3D "$Windows NT$"
> -   CatalogFile =3D @@PRODUCT_TAP_ID@@.cat
> -   ClassGUID =3D {4d36e972-e325-11ce-bfc1-08002be10318}
> -   Provider =3D %Provider%
> -   Class =3D Net
> -
> -; This version number should match the version
> -; number given in SOURCES.
> -   DriverVer=3D@@PRODUCT_TAP_RELDATE@@,@@PRODUCT_TAP_MAJOR_VER@@.00.00.@=
@PRODUCT_TAP_MINOR_VER@@
> -
> -[Strings]
> -   DeviceDescription =3D "@@PRODUCT_TAP_DEVICE_DESCRIPTION@@"
> -   Provider =3D "@@PRODUCT_TAP_PROVIDER@@"
> -
> -;----------------------------------------------------------------
> -;                      Manufacturer + Product Section (Done)
> -;----------------------------------------------------------------
> -[Manufacturer]
> -!ifdef AMD64
> -   %Provider% =3D @@PRODUCT_TAP_ID@@, NTamd64
> -!else
> -   %Provider% =3D @@PRODUCT_TAP_ID@@
> -!endif
> -
> -!ifdef AMD64
> -[@@PRODUCT_TAP_ID@@.NTamd64]
> -!else
> -[@@PRODUCT_TAP_ID@@]
> -!endif
> -   %DeviceDescription% =3D @@PRODUCT_TAP_ID@@.ndi, @@PRODUCT_TAP_ID@@
> -
> -;---------------------------------------------------------------
> -;                             Driver Section (Done)
> -;---------------------------------------------------------------
> -
> -;----------------- Characteristics ------------
> -;    NCF_PHYSICAL =3D 0x04
> -;    NCF_VIRTUAL =3D 0x01
> -;    NCF_SOFTWARE_ENUMERATED =3D 0x02
> -;    NCF_HIDDEN =3D 0x08
> -;    NCF_NO_SERVICE =3D 0x10
> -;    NCF_HAS_UI =3D 0x80
> -;----------------- Characteristics ------------
> -
> -[@@PRODUCT_TAP_ID@@.ndi]
> -   CopyFiles       =3D @@PRODUCT_TAP_ID@@.driver, @@PRODUCT_TAP_ID@@.fil=
es
> -   AddReg          =3D @@PRODUCT_TAP_ID@@.reg
> -   AddReg          =3D @@PRODUCT_TAP_ID@@.params.reg
> -   Characteristics =3D @@PRODUCT_TAP_CHARACTERISTICS@@
> -
> -[@@PRODUCT_TAP_ID@@.ndi.Services]
> -   AddService =3D @@PRODUCT_TAP_ID@@,        2, @@PRODUCT_TAP_ID@@.servi=
ce
> -
> -[@@PRODUCT_TAP_ID@@.reg]
> -   HKR, Ndi,            Service,      0, "@@PRODUCT_TAP_ID@@"
> -   HKR, Ndi\Interfaces, UpperRange,   0, "ndis5"
> -   HKR, Ndi\Interfaces, LowerRange,   0, "ethernet"
> -   HKR, ,               Manufacturer, 0, "%Provider%"
> -   HKR, ,               ProductName,  0, "%DeviceDescription%"
> -
> -[@@PRODUCT_TAP_ID@@.params.reg]
> -   HKR, Ndi\params\MTU,                  ParamDesc, 0, "MTU"
> -   HKR, Ndi\params\MTU,                  Type,      0, "int"
> -   HKR, Ndi\params\MTU,                  Default,   0, "1500"
> -   HKR, Ndi\params\MTU,                  Optional,  0, "0"
> -   HKR, Ndi\params\MTU,                  Min,       0, "100"
> -   HKR, Ndi\params\MTU,                  Max,       0, "1500"
> -   HKR, Ndi\params\MTU,                  Step,      0, "1"
> -   HKR, Ndi\params\MediaStatus,          ParamDesc, 0, "Media Status"
> -   HKR, Ndi\params\MediaStatus,          Type,      0, "enum"
> -   HKR, Ndi\params\MediaStatus,          Default,   0, "0"
> -   HKR, Ndi\params\MediaStatus,          Optional,  0, "0"
> -   HKR, Ndi\params\MediaStatus\enum,     "0",       0, "Application Cont=
rolled"
> -   HKR, Ndi\params\MediaStatus\enum,     "1",       0, "Always Connected"
> -   HKR, Ndi\params\MAC,                  ParamDesc, 0, "MAC Address"
> -   HKR, Ndi\params\MAC,                  Type,      0, "edit"
> -   HKR, Ndi\params\MAC,                  Optional,  0, "1"
> -   HKR, Ndi\params\AllowNonAdmin,        ParamDesc, 0, "Non-Admin Access"
> -   HKR, Ndi\params\AllowNonAdmin,        Type,      0, "enum"
> -   HKR, Ndi\params\AllowNonAdmin,        Default,   0, "1"
> -   HKR, Ndi\params\AllowNonAdmin,        Optional,  0, "0"
> -   HKR, Ndi\params\AllowNonAdmin\enum,   "0",       0, "Not Allowed"
> -   HKR, Ndi\params\AllowNonAdmin\enum,   "1",       0, "Allowed"
> -
> -;----------------------------------------------------------------
> -;                             Service Section
> -;----------------------------------------------------------------
> -
> -;---------- Service Type -------------
> -;    SERVICE_KERNEL_DRIVER     =3D 0x01
> -;    SERVICE_WIN32_OWN_PROCESS =3D 0x10
> -;---------- Service Type -------------
> -
> -;---------- Start Mode ---------------
> -;    SERVICE_BOOT_START   =3D 0x0
> -;    SERVICE_SYSTEM_START =3D 0x1
> -;    SERVICE_AUTO_START   =3D 0x2
> -;    SERVICE_DEMAND_START =3D 0x3
> -;    SERVICE_DISABLED     =3D 0x4
> -;---------- Start Mode ---------------
> -
> -[@@PRODUCT_TAP_ID@@.service]
> -   DisplayName =3D %DeviceDescription%
> -   ServiceType =3D 1
> -   StartType =3D 3
> -   ErrorControl =3D 1
> -   LoadOrderGroup =3D NDIS
> -   ServiceBinary =3D %12%\@@PRODUCT_TAP_ID@@.sys
> -
> -;-----------------------------------------------------------------
> -;                                File Installation
> -;-----------------------------------------------------------------
> -
> -;----------------- Copy Flags ------------
> -;    COPYFLG_NOSKIP =3D 0x02
> -;    COPYFLG_NOVERSIONCHECK =3D 0x04
> -;----------------- Copy Flags ------------
> -
> -; SourceDisksNames
> -; diskid =3D description[, [tagfile] [, <unused>, subdir]]
> -; 1 =3D "Intel Driver Disk 1",e100bex.sys,,
> -
> -[SourceDisksNames]
> -   1 =3D %DeviceDescription%, @@PRODUCT_TAP_ID@@.sys
> -
> -; SourceDisksFiles
> -; filename_on_source =3D diskID[, [subdir][, size]]
> -; e100bex.sys =3D 1,, ; on distribution disk 1
> -
> -[SourceDisksFiles]
> -@@PRODUCT_TAP_ID@@.sys =3D 1
> -
> -[DestinationDirs]
> -   @@PRODUCT_TAP_ID@@.files  =3D 11
> -   @@PRODUCT_TAP_ID@@.driver =3D 12
> -
> -[@@PRODUCT_TAP_ID@@.files]
> -;   TapPanel.cpl,,,6   ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
> -;   cipsrvr.exe,,,6     ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCHECK
> -
> -[@@PRODUCT_TAP_ID@@.driver]
> -   @@PRODUCT_TAP_ID@@.sys,,,6     ; COPYFLG_NOSKIP | COPYFLG_NOVERSIONCH=
ECK
> -
> -;---------------------------------------------------------------
> -;                                      End
> -;---------------------------------------------------------------
> diff --git a/tap-win32/instance.c b/tap-win32/instance.c
> deleted file mode 100755
> index 182cee8..0000000
> --- a/tap-win32/instance.c
> +++ /dev/null
> @@ -1,241 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#define INSTANCE_KEY(a) ((PVOID)((a)->m_Extension.m_TapDevice))
> -
> -#define N_INSTANCE_BUCKETS 256
> -
> -typedef struct _INSTANCE {
> -  struct _INSTANCE *next;
> -  TapAdapterPointer m_Adapter;
> -} INSTANCE;
> -
> -typedef struct {
> -  INSTANCE *list;
> -  MUTEX lock;
> -} INSTANCE_BUCKET;
> -
> -typedef struct {
> -  INSTANCE_BUCKET buckets[N_INSTANCE_BUCKETS];
> -} INSTANCE_HASH;
> -
> -INSTANCE_HASH *g_InstanceHash =3D NULL;
> -
> -// must return a hash >=3D 0 and < N_INSTANCE_BUCKETS
> -int
> -InstanceHashValue (PVOID addr)
> -{
> -  UCHAR *p =3D (UCHAR *) &addr;
> -
> -  if (sizeof (addr) =3D=3D 4)
> -    return p[0] ^ p[1] ^ p[2] ^ p[3];
> -  else if (sizeof (addr) =3D=3D 8)
> -    return p[0] ^ p[1] ^ p[2] ^ p[3] ^ p[4] ^ p[5] ^ p[6] ^ p[7];
> -  else
> -    {
> -      MYASSERT (0);
> -    }
> -}
> -
> -BOOLEAN
> -InitInstanceList (VOID)
> -{
> -  MYASSERT (g_InstanceHash =3D=3D NULL);
> -  g_InstanceHash =3D MemAlloc (sizeof (INSTANCE_HASH), TRUE);
> -  if (g_InstanceHash)
> -    {
> -      int i;
> -      for (i =3D 0; i < N_INSTANCE_BUCKETS; ++i)
> -       INIT_MUTEX (&g_InstanceHash->buckets[i].lock);
> -      return TRUE;
> -    }
> -  else
> -    return FALSE;
> -}
> -
> -int
> -NInstances (VOID)
> -{
> -  int i, n =3D 0;
> -
> -  if (g_InstanceHash)
> -    {
> -      for (i =3D 0; i < N_INSTANCE_BUCKETS; ++i)
> -       {
> -         BOOLEAN got_lock;
> -         INSTANCE_BUCKET *ib =3D &g_InstanceHash->buckets[i];
> -         ACQUIRE_MUTEX_ADAPTIVE (&ib->lock, got_lock);
> -
> -         if (got_lock)
> -           {
> -             INSTANCE *current;
> -             for (current =3D ib->list; current !=3D NULL; current =3D c=
urrent->next)
> -               ++n;
> -             RELEASE_MUTEX (&ib->lock);
> -           }
> -         else
> -           return -1;
> -       }
> -    }
> -
> -  return n;
> -}
> -
> -int
> -InstanceMaxBucketSize (VOID)
> -{
> -  int i, n =3D 0;
> -
> -  if (g_InstanceHash)
> -    {
> -      for (i =3D 0; i < N_INSTANCE_BUCKETS; ++i)
> -       {
> -         BOOLEAN got_lock;
> -         int bucket_size =3D 0;
> -         INSTANCE_BUCKET *ib =3D &g_InstanceHash->buckets[i];
> -         ACQUIRE_MUTEX_ADAPTIVE (&ib->lock, got_lock);
> -
> -         if (got_lock)
> -           {
> -             INSTANCE *current;
> -             for (current =3D ib->list; current !=3D NULL; current =3D c=
urrent->next)
> -                 ++bucket_size;
> -             if (bucket_size > n)
> -               n =3D bucket_size;
> -             RELEASE_MUTEX (&ib->lock);
> -           }
> -         else
> -           return -1;
> -       }
> -    }
> -
> -  return n;
> -}
> -
> -VOID
> -FreeInstanceList (VOID)
> -{
> -  if (g_InstanceHash)
> -    {
> -      MYASSERT (NInstances() =3D=3D 0);
> -      MemFree (g_InstanceHash, sizeof (INSTANCE_HASH));
> -      g_InstanceHash =3D NULL;
> -    }
> -}
> -
> -BOOLEAN
> -AddAdapterToInstanceList (TapAdapterPointer p_Adapter)
> -{
> -  BOOLEAN got_lock;
> -  BOOLEAN ret =3D FALSE;
> -  const int hash =3D InstanceHashValue(INSTANCE_KEY(p_Adapter));
> -  INSTANCE_BUCKET *ib =3D &g_InstanceHash->buckets[hash];
> -
> -  DEBUGP (("[TAP] AddAdapterToInstanceList hash=3D%d\n", hash));
> -
> -  ACQUIRE_MUTEX_ADAPTIVE (&ib->lock, got_lock);
> -
> -  if (got_lock)
> -    {
> -      INSTANCE *i =3D MemAlloc (sizeof (INSTANCE), FALSE);
> -      if (i)
> -       {
> -         MYASSERT (p_Adapter);
> -         i->m_Adapter =3D p_Adapter;
> -         i->next =3D ib->list;
> -         ib->list =3D i;
> -         ret =3D TRUE;
> -       }
> -      RELEASE_MUTEX (&ib->lock);
> -    }
> -
> -  return ret;
> -}
> -
> -BOOLEAN
> -RemoveAdapterFromInstanceList (TapAdapterPointer p_Adapter)
> -{
> -  BOOLEAN got_lock;
> -  BOOLEAN ret =3D FALSE;
> -  INSTANCE_BUCKET *ib =3D &g_InstanceHash->buckets[InstanceHashValue(INS=
TANCE_KEY(p_Adapter))];
> -
> -  ACQUIRE_MUTEX_ADAPTIVE (&ib->lock, got_lock);
> -
> -  if (got_lock)
> -    {
> -      INSTANCE *current, *prev=3DNULL;
> -      for (current =3D ib->list; current !=3D NULL; current =3D current-=
>next)
> -       {
> -         if (current->m_Adapter =3D=3D p_Adapter) // found match
> -           {
> -             if (prev)
> -               prev->next =3D current->next;
> -             else
> -               ib->list =3D current->next;
> -             MemFree (current->m_Adapter, sizeof (TapAdapter));
> -             MemFree (current, sizeof (INSTANCE));
> -             ret =3D TRUE;
> -             break;
> -           }
> -         prev =3D current;
> -       }
> -      RELEASE_MUTEX (&ib->lock);
> -    }
> -
> -  return ret;
> -}
> -
> -TapAdapterPointer
> -LookupAdapterInInstanceList (PDEVICE_OBJECT p_DeviceObject)
> -{
> -  BOOLEAN got_lock;
> -  TapAdapterPointer ret =3D NULL;
> -  INSTANCE_BUCKET *ib =3D &g_InstanceHash->buckets[InstanceHashValue((PV=
OID)p_DeviceObject)];
> -
> -  ACQUIRE_MUTEX_ADAPTIVE (&ib->lock, got_lock);
> -
> -  if (got_lock)
> -    {
> -      INSTANCE *current, *prev=3DNULL;
> -      for (current =3D ib->list; current !=3D NULL; current =3D current-=
>next)
> -       {
> -         if (p_DeviceObject =3D=3D INSTANCE_KEY (current->m_Adapter)) //=
 found match
> -           {
> -             // move it to head of list
> -             if (prev)
> -               {
> -                 prev->next =3D current->next;
> -                 current->next =3D ib->list;
> -                 ib->list =3D current;
> -               }
> -             ret =3D ib->list->m_Adapter;
> -             break;
> -           }
> -         prev =3D current;
> -       }
> -      RELEASE_MUTEX (&ib->lock);
> -    }
> -
> -  return ret;
> -}
> diff --git a/tap-win32/lock.h b/tap-win32/lock.h
> deleted file mode 100755
> index ea75414..0000000
> --- a/tap-win32/lock.h
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -typedef struct
> -{
> -  volatile long count;
> -} MUTEX;
> -
> -#define MUTEX_SLEEP_TIME  10000 // microseconds
> -
> -#define INIT_MUTEX(m) { (m)->count =3D 0; }
> -
> -#define ACQUIRE_MUTEX_BLOCKING(m)                         \
> -{                                                         \
> -    while (NdisInterlockedIncrement (&((m)->count)) !=3D 1) \
> -    {                                                     \
> -        NdisInterlockedDecrement(&((m)->count));          \
> -        NdisMSleep(MUTEX_SLEEP_TIME);                     \
> -    }                                                     \
> -}
> -
> -#define RELEASE_MUTEX(m)                                  \
> -{                                                         \
> -        NdisInterlockedDecrement(&((m)->count));          \
> -}
> -
> -#define ACQUIRE_MUTEX_NONBLOCKING(m, result)              \
> -{                                                         \
> -    if (NdisInterlockedIncrement (&((m)->count)) !=3D 1)    \
> -    {                                                     \
> -        NdisInterlockedDecrement(&((m)->count));          \
> -        result =3D FALSE;                                   \
> -    }                                                     \
> -    else                                                  \
> -    {                                                     \
> -       result =3D TRUE;                                    \
> -    }                                                     \
> -}
> -
> -#define ACQUIRE_MUTEX_ADAPTIVE(m, result)                 \
> -{                                                         \
> -    result =3D TRUE;                                        \
> -    while (NdisInterlockedIncrement (&((m)->count)) !=3D 1) \
> -    {                                                     \
> -        NdisInterlockedDecrement(&((m)->count));          \
> -        if (KeGetCurrentIrql () < DISPATCH_LEVEL)         \
> -            NdisMSleep(MUTEX_SLEEP_TIME);                 \
> -        else                                              \
> -        {                                                 \
> -           result =3D FALSE;                               \
> -           break;                                        \
> -        }                                                 \
> -    }                                                     \
> -}
> diff --git a/tap-win32/macinfo.c b/tap-win32/macinfo.c
> deleted file mode 100755
> index 8d512ec..0000000
> --- a/tap-win32/macinfo.c
> +++ /dev/null
> @@ -1,154 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#include "macinfo.h"
> -
> -int
> -HexStringToDecimalInt (const int p_Character)
> -{
> -  int l_Value =3D 0;
> -
> -  if (p_Character >=3D 'A' && p_Character <=3D 'F')
> -    l_Value =3D (p_Character - 'A') + 10;
> -  else if (p_Character >=3D 'a' && p_Character <=3D 'f')
> -    l_Value =3D (p_Character - 'a') + 10;
> -  else if (p_Character >=3D '0' && p_Character <=3D '9')
> -    l_Value =3D p_Character - '0';
> -
> -  return l_Value;
> -}
> -
> -BOOLEAN
> -ParseMAC (MACADDR dest, const char *src)
> -{
> -  int c;
> -  int mac_index =3D 0;
> -  BOOLEAN high_digit =3D FALSE;
> -  int delim_action =3D 1;
> -
> -  MYASSERT (src);
> -  MYASSERT (dest);
> -
> -  CLEAR_MAC (dest);
> -
> -  while (c =3D *src++)
> -    {
> -      if (IsMacDelimiter (c))
> -       {
> -         mac_index +=3D delim_action;
> -         high_digit =3D FALSE;
> -         delim_action =3D 1;
> -       }
> -      else if (IsHexDigit (c))
> -       {
> -         const int digit =3D HexStringToDecimalInt (c);
> -         if (mac_index < sizeof (MACADDR))
> -           {
> -             if (!high_digit)
> -               {
> -                 dest[mac_index] =3D (char)(digit);
> -                 high_digit =3D TRUE;
> -                 delim_action =3D 1;
> -               }
> -             else
> -               {
> -                 dest[mac_index] =3D (char)(dest[mac_index] * 16 + digit=
);
> -                 ++mac_index;
> -                 high_digit =3D FALSE;
> -                 delim_action =3D 0;
> -               }
> -           }
> -         else
> -           return FALSE;
> -       }
> -      else
> -       return FALSE;
> -    }
> -
> -  return (mac_index + delim_action) >=3D sizeof (MACADDR);
> -}
> -
> -/*
> - * Generate a MAC using the GUID in the adapter name.
> - *
> - * The mac is constructed as 00:FF:xx:xx:xx:xx where
> - * the Xs are taken from the first 32 bits of the GUID in the
> - * adapter name.  This is similar to the Linux 2.4 tap MAC
> - * generator, except linux uses 32 random bits for the Xs.
> - *
> - * In general, this solution is reasonable for most
> - * applications except for very large bridged TAP networks,
> - * where the probability of address collisions becomes more
> - * than infintesimal.
> - *
> - * Using the well-known "birthday paradox", on a 1000 node
> - * network the probability of collision would be
> - * 0.000116292153.  On a 10,000 node network, the probability
> - * of collision would be 0.01157288998621678766.
> - */
> -
> -VOID GenerateRandomMac (MACADDR mac, const unsigned char *adapter_name)
> -{
> -  unsigned const char *cp =3D adapter_name;
> -  unsigned char c;
> -  unsigned int i =3D 2;
> -  unsigned int byte =3D 0;
> -  int brace =3D 0;
> -  int state =3D 0;
> -
> -  CLEAR_MAC (mac);
> -
> -  mac[0] =3D 0x00;
> -  mac[1] =3D 0xFF;
> -
> -  while (c =3D *cp++)
> -    {
> -      if (i >=3D sizeof (MACADDR))
> -       break;
> -      if (c =3D=3D '{')
> -       brace =3D 1;
> -      if (IsHexDigit (c) && brace)
> -       {
> -         const unsigned int digit =3D HexStringToDecimalInt (c);
> -         if (state)
> -           {
> -             byte <<=3D 4;
> -             byte |=3D digit;
> -             mac[i++] =3D (unsigned char) byte;
> -             state =3D 0;
> -           }
> -         else
> -           {
> -             byte =3D digit;
> -             state =3D 1;
> -           }
> -       }
> -    }
> -}
> -
> -VOID GenerateRelatedMAC (MACADDR dest, const MACADDR src, const int delt=
a)
> -{
> -  COPY_MAC (dest, src);
> -  dest[2] +=3D (UCHAR) delta;
> -}
> diff --git a/tap-win32/macinfo.h b/tap-win32/macinfo.h
> deleted file mode 100755
> index 51e930d..0000000
> --- a/tap-win32/macinfo.h
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#ifndef MacInfoDefined
> -#define MacInfoDefined
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                                      Macros
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -#define IsMacDelimiter(a) (a =3D=3D ':' || a =3D=3D '-' || a =3D=3D '.')
> -#define IsHexDigit(c) ((c >=3D '0' && c <=3D '9') || (c >=3D 'A' && c <=
=3D 'F') || (c >=3D 'a' && c <=3D 'f'))
> -
> -#define COPY_MAC(dest, src) NdisMoveMemory ((dest), (src), sizeof (MACAD=
DR))
> -#define CLEAR_MAC(dest)     NdisZeroMemory ((dest), sizeof (MACADDR))
> -#define MAC_EQUAL(a,b)      (memcmp ((a), (b), sizeof (MACADDR)) =3D=3D =
0)
> -
> -#endif
> diff --git a/tap-win32/mem.c b/tap-win32/mem.c
> deleted file mode 100755
> index 6fbbed5..0000000
> --- a/tap-win32/mem.c
> +++ /dev/null
> @@ -1,186 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//------------------
> -// Memory Management
> -//------------------
> -
> -PVOID
> -MemAlloc (ULONG p_Size, BOOLEAN zero)
> -{
> -  PVOID l_Return =3D NULL;
> -
> -  if (p_Size)
> -    {
> -      __try
> -      {
> -       if (NdisAllocateMemoryWithTag (&l_Return, p_Size, 'APAT')
> -           =3D=3D NDIS_STATUS_SUCCESS)
> -         {
> -           if (zero)
> -             NdisZeroMemory (l_Return, p_Size);
> -         }
> -       else
> -         l_Return =3D NULL;
> -      }
> -      __except (EXCEPTION_EXECUTE_HANDLER)
> -      {
> -       l_Return =3D NULL;
> -      }
> -    }
> -
> -  return l_Return;
> -}
> -
> -VOID
> -MemFree (PVOID p_Addr, ULONG p_Size)
> -{
> -  if (p_Addr && p_Size)
> -    {
> -      __try
> -      {
> -#if DBG
> -       NdisZeroMemory (p_Addr, p_Size);
> -#endif
> -       NdisFreeMemory (p_Addr, p_Size, 0);
> -      }
> -      __except (EXCEPTION_EXECUTE_HANDLER)
> -      {
> -      }
> -    }
> -}
> -
> -/*
> - * Circular queue management routines.
> - */
> -
> -#define QUEUE_BYTE_ALLOCATION(size) \
> -  (sizeof (Queue) + (size * sizeof (PVOID)))
> -
> -#define QUEUE_ADD_INDEX(var, inc) \
> -{ \
> -  var +=3D inc; \
> -  if (var >=3D q->capacity) \
> -    var -=3D q->capacity; \
> -  MYASSERT (var < q->capacity); \
> -}
> -
> -#define QUEUE_SANITY_CHECK() \
> -  MYASSERT (q !=3D NULL && q->base < q->capacity && q->size <=3D q->capa=
city)
> -
> -#define QueueCount(q) (q->size)
> -
> -#define UPDATE_MAX_SIZE() \
> -{ \
> -  if (q->size > q->max_size) \
> -    q->max_size =3D q->size; \
> -}
> -
> -Queue *
> -QueueInit (ULONG capacity)
> -{
> -  Queue *q;
> -
> -  MYASSERT (capacity > 0);
> -  q =3D (Queue *) MemAlloc (QUEUE_BYTE_ALLOCATION (capacity), TRUE);
> -  if (!q)
> -    return NULL;
> -
> -  q->base =3D q->size =3D 0;
> -  q->capacity =3D capacity;
> -  q->max_size =3D 0;
> -  return q;
> -}
> -
> -VOID
> -QueueFree (Queue *q)
> -{
> -  if (q)
> -    {
> -      QUEUE_SANITY_CHECK ();
> -      MemFree (q, QUEUE_BYTE_ALLOCATION (q->capacity));
> -    }
> -}
> -
> -PVOID
> -QueuePush (Queue *q, PVOID item)
> -{
> -  ULONG dest;
> -  QUEUE_SANITY_CHECK ();
> -  if (q->size =3D=3D q->capacity)
> -    return NULL;
> -  dest =3D q->base;
> -  QUEUE_ADD_INDEX (dest, q->size);
> -  q->data[dest] =3D item;
> -  ++q->size;
> -  UPDATE_MAX_SIZE();
> -  return item;
> -}
> -
> -PVOID
> -QueuePop (Queue *q)
> -{
> -  ULONG oldbase;
> -  QUEUE_SANITY_CHECK ();
> -  if (!q->size)
> -    return NULL;
> -  oldbase =3D q->base;
> -  QUEUE_ADD_INDEX (q->base, 1);
> -  --q->size;
> -  UPDATE_MAX_SIZE();
> -  return q->data[oldbase];
> -}
> -
> -PVOID
> -QueueExtract (Queue *q, PVOID item)
> -{
> -  ULONG src, dest, count, n;
> -  QUEUE_SANITY_CHECK ();
> -  n =3D 0;
> -  src =3D dest =3D q->base;
> -  count =3D q->size;
> -  while (count--)
> -    {
> -      if (item =3D=3D q->data[src])
> -       {
> -         ++n;
> -         --q->size;
> -       }
> -      else
> -       {
> -         q->data[dest] =3D q->data[src];
> -         QUEUE_ADD_INDEX (dest, 1);
> -       }
> -      QUEUE_ADD_INDEX (src, 1);
> -    }
> -  if (n)
> -    return item;
> -  else
> -    return NULL;
> -}
> -
> -#undef QUEUE_BYTE_ALLOCATION
> -#undef QUEUE_ADD_INDEX
> -#undef QUEUE_SANITY_CHECK
> -#undef UPDATE_MAX_SIZE
> diff --git a/tap-win32/proto.h b/tap-win32/proto.h
> deleted file mode 100755
> index 894a37f..0000000
> --- a/tap-win32/proto.h
> +++ /dev/null
> @@ -1,224 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// MAC address, Ethernet header, and ARP
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#pragma pack(1)
> -
> -#define IP_HEADER_SIZE 20
> -#define IPV6_HEADER_SIZE 40
> -
> -typedef unsigned char MACADDR [6];
> -typedef unsigned long IPADDR;
> -typedef unsigned char IPV6ADDR [16];
> -
> -//-----------------
> -// Ethernet address
> -//-----------------
> -
> -typedef struct {
> -  MACADDR addr;
> -} ETH_ADDR;
> -
> -typedef struct {
> -  ETH_ADDR list[NIC_MAX_MCAST_LIST];
> -} MC_LIST;
> -
> -//----------------
> -// Ethernet header
> -//----------------
> -
> -typedef struct
> -{
> -  MACADDR dest;               /* destination eth addr  */
> -  MACADDR src;                /* source ether addr     */
> -
> -# define ETH_P_IP   0x0800    /* IPv4 protocol */
> -# define ETH_P_IPV6 0x86DD    /* IPv6 protocol */
> -# define ETH_P_ARP  0x0806    /* ARP protocol */
> -  USHORT proto;               /* packet type ID field  */
> -} ETH_HEADER, *PETH_HEADER;
> -
> -//----------------
> -// ARP packet
> -//----------------
> -
> -typedef struct
> -   {
> -    MACADDR        m_MAC_Destination;        // Reverse these two
> -    MACADDR        m_MAC_Source;             // to answer ARP requests
> -    USHORT         m_Proto;                  // 0x0806
> -
> -#   define MAC_ADDR_TYPE 0x0001
> -    USHORT         m_MAC_AddressType;        // 0x0001
> -
> -    USHORT         m_PROTO_AddressType;      // 0x0800
> -    UCHAR          m_MAC_AddressSize;        // 0x06
> -    UCHAR          m_PROTO_AddressSize;      // 0x04
> -
> -#   define ARP_REQUEST 0x0001
> -#   define ARP_REPLY   0x0002
> -    USHORT         m_ARP_Operation;          // 0x0001 for ARP request, =
0x0002 for ARP reply
> -
> -    MACADDR        m_ARP_MAC_Source;
> -    IPADDR         m_ARP_IP_Source;
> -    MACADDR        m_ARP_MAC_Destination;
> -    IPADDR         m_ARP_IP_Destination;
> -   }
> -ARP_PACKET, *PARP_PACKET;
> -
> -//----------
> -// IP Header
> -//----------
> -
> -typedef struct {
> -# define IPH_GET_VER(v) (((v) >> 4) & 0x0F)
> -# define IPH_GET_LEN(v) (((v) & 0x0F) << 2)
> -  UCHAR    version_len;
> -
> -  UCHAR    tos;
> -  USHORT   tot_len;
> -  USHORT   id;
> -
> -# define IP_OFFMASK 0x1fff
> -  USHORT   frag_off;
> -
> -  UCHAR    ttl;
> -
> -# define IPPROTO_UDP  17  /* UDP protocol */
> -# define IPPROTO_TCP   6  /* TCP protocol */
> -# define IPPROTO_ICMP  1  /* ICMP protocol */
> -# define IPPROTO_IGMP  2  /* IGMP protocol */
> -  UCHAR    protocol;
> -
> -  USHORT   check;
> -  ULONG    saddr;
> -  ULONG    daddr;
> -  /* The options start here. */
> -} IPHDR;
> -
> -//-----------
> -// UDP header
> -//-----------
> -
> -typedef struct {
> -  USHORT   source;
> -  USHORT   dest;
> -  USHORT   len;
> -  USHORT   check;
> -} UDPHDR;
> -
> -//--------------------------
> -// TCP header, per RFC 793.
> -//--------------------------
> -
> -typedef struct {
> -  USHORT      source;    /* source port */
> -  USHORT      dest;      /* destination port */
> -  ULONG       seq;       /* sequence number */
> -  ULONG       ack_seq;   /* acknowledgement number */
> -
> -# define TCPH_GET_DOFF(d) (((d) & 0xF0) >> 2)
> -  UCHAR       doff_res;
> -
> -# define TCPH_FIN_MASK (1<<0)
> -# define TCPH_SYN_MASK (1<<1)
> -# define TCPH_RST_MASK (1<<2)
> -# define TCPH_PSH_MASK (1<<3)
> -# define TCPH_ACK_MASK (1<<4)
> -# define TCPH_URG_MASK (1<<5)
> -# define TCPH_ECE_MASK (1<<6)
> -# define TCPH_CWR_MASK (1<<7)
> -  UCHAR       flags;
> -
> -  USHORT      window;
> -  USHORT      check;
> -  USHORT      urg_ptr;
> -} TCPHDR;
> -
> -#define        TCPOPT_EOL     0
> -#define        TCPOPT_NOP     1
> -#define        TCPOPT_MAXSEG  2
> -#define TCPOLEN_MAXSEG 4
> -
> -//------------
> -// IPv6 Header
> -//------------
> -
> -typedef struct {
> -  UCHAR    version_prio;
> -  UCHAR    flow_lbl[3];
> -  USHORT   payload_len;
> -# define IPPROTO_ICMPV6  0x3a  /* ICMP protocol v6 */
> -  UCHAR    nexthdr;
> -  UCHAR    hop_limit;
> -  IPV6ADDR saddr;
> -  IPV6ADDR daddr;
> -} IPV6HDR;
> -
> -//--------------------------------------------
> -// IPCMPv6 NS/NA Packets (RFC4443 and RFC4861)
> -//--------------------------------------------
> -
> -// Neighbor Solictiation - RFC 4861, 4.3
> -// (this is just the ICMPv6 part of the packet)
> -typedef struct {
> -  UCHAR    type;
> -# define ICMPV6_TYPE_NS        135             // neighbour solicitation
> -  UCHAR    code;
> -# define ICMPV6_CODE_0 0               // no specific sub-code for NS/NA
> -  USHORT   checksum;
> -  ULONG    reserved;
> -  IPV6ADDR target_addr;
> -} ICMPV6_NS;
> -
> -// Neighbor Advertisement - RFC 4861, 4.4 + 4.6/4.6.1
> -// (this is just the ICMPv6 payload)
> -typedef struct {
> -  UCHAR    type;
> -# define ICMPV6_TYPE_NA        136             // neighbour advertisement
> -  UCHAR    code;
> -# define ICMPV6_CODE_0 0               // no specific sub-code for NS/NA
> -  USHORT   checksum;
> -  UCHAR    rso_bits;                   // Router(0), Solicited(2), Ovrrd=
(4)
> -  UCHAR           reserved[3];
> -  IPV6ADDR target_addr;
> -// always include "Target Link-layer Address" option (RFC 4861 4.6.1)
> -  UCHAR    opt_type;
> -#define ICMPV6_OPTION_TLLA 2
> -  UCHAR    opt_length;
> -#define ICMPV6_LENGTH_TLLA 1           // multiplied by 8 -> 1 =3D 8 byt=
es
> -  MACADDR  target_macaddr;
> -} ICMPV6_NA;
> -
> -// this is the complete packet with Ethernet and IPv6 headers
> -typedef struct {
> -  ETH_HEADER eth;
> -  IPV6HDR    ipv6;
> -  ICMPV6_NA  icmpv6;
> -} ICMPV6_NA_PKT;
> -
> -#pragma pack()
> diff --git a/tap-win32/prototypes.h b/tap-win32/prototypes.h
> deleted file mode 100755
> index 55454d5..0000000
> --- a/tap-win32/prototypes.h
> +++ /dev/null
> @@ -1,260 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#ifndef TAP_PROTOTYPES_DEFINED
> -#define TAP_PROTOTYPES_DEFINED
> -
> -NTSTATUS DriverEntry
> -   (
> -    IN PDRIVER_OBJECT p_DriverObject,
> -    IN PUNICODE_STRING p_RegistryPath
> -   );
> -
> -VOID TapDriverUnload
> -   (
> -    IN PDRIVER_OBJECT p_DriverObject
> -   );
> -
> -NDIS_STATUS AdapterCreate
> -   (
> -    OUT PNDIS_STATUS p_ErrorStatus,
> -    OUT PUINT p_MediaIndex,
> -    IN PNDIS_MEDIUM p_Media,
> -    IN UINT p_MediaCount,
> -    IN NDIS_HANDLE p_AdapterHandle,
> -    IN NDIS_HANDLE p_ConfigurationHandle
> -   );
> -
> -VOID AdapterHalt
> -   (
> -    IN NDIS_HANDLE p_AdapterContext
> -   );
> -
> -VOID AdapterFreeResources
> -   (
> -    TapAdapterPointer p_Adapter
> -   );
> -
> -NDIS_STATUS AdapterReset
> -   (
> -    OUT PBOOLEAN p_AddressingReset,
> -    IN NDIS_HANDLE p_AdapterContext
> -   );
> -
> -NDIS_STATUS AdapterQuery
> -   (
> -    IN NDIS_HANDLE p_AdapterContext,
> -    IN NDIS_OID p_OID,
> -    IN PVOID p_Buffer,
> -    IN ULONG p_BufferLength,
> -    OUT PULONG p_BytesWritten,
> -    OUT PULONG p_BytesNeeded
> -   );
> -
> -NDIS_STATUS AdapterModify
> -   (
> -    IN NDIS_HANDLE p_AdapterContext,
> -    IN NDIS_OID p_OID,
> -    IN PVOID p_Buffer,
> -    IN ULONG p_BufferLength,
> -    OUT PULONG p_BytesRead,
> -    OUT PULONG p_BytesNeeded
> -   );
> -
> -NDIS_STATUS AdapterTransmit
> -   (
> -    IN NDIS_HANDLE p_AdapterContext,
> -    IN PNDIS_PACKET p_Packet,
> -    IN UINT p_Flags
> -   );
> -
> -NDIS_STATUS AdapterReceive
> -   (
> -    OUT PNDIS_PACKET p_Packet,
> -    OUT PUINT p_Transferred,
> -    IN NDIS_HANDLE p_AdapterContext,
> -    IN NDIS_HANDLE p_ReceiveContext,
> -    IN UINT p_Offset,
> -    IN UINT p_ToTransfer
> -   );
> -
> -NTSTATUS TapDeviceHook
> -   (
> -    IN PDEVICE_OBJECT p_DeviceObject,
> -    IN PIRP p_IRP
> -   );
> -
> -NDIS_STATUS CreateTapDevice
> -   (
> -    TapExtensionPointer p_Extension,
> -    const char *p_Name
> -   );
> -
> -VOID DestroyTapDevice
> -   (
> -    TapExtensionPointer p_Extension
> -   );
> -
> -VOID TapDeviceFreeResources
> -   (
> -    TapExtensionPointer p_Extension
> -    );
> -
> -NTSTATUS CompleteIRP
> -   (
> -    IN PIRP p_IRP,
> -    IN TapPacketPointer p_PacketBuffer,
> -    IN CCHAR PriorityBoost
> -   );
> -
> -VOID CancelIRPCallback
> -   (
> -    IN PDEVICE_OBJECT p_DeviceObject,
> -    IN PIRP p_IRP
> -   );
> -
> -VOID CancelIRP
> -   (
> -    TapExtensionPointer p_Extension,
> -    IN PIRP p_IRP,
> -    BOOLEAN callback
> -   );
> -
> -VOID FlushQueues
> -   (
> -    TapExtensionPointer p_Extension
> -   );
> -
> -VOID ResetTapAdapterState
> -   (
> -    TapAdapterPointer p_Adapter
> -   );
> -
> -BOOLEAN ProcessARP
> -   (
> -    TapAdapterPointer p_Adapter,
> -    const PARP_PACKET src,
> -    const IPADDR adapter_ip,
> -    const IPADDR ip_network,
> -    const IPADDR ip_netmask,
> -    const MACADDR mac
> -   );
> -
> -VOID SetMediaStatus
> -   (
> -    TapAdapterPointer p_Adapter,
> -    BOOLEAN state
> -   );
> -
> -VOID InjectPacketDeferred
> -   (
> -    TapAdapterPointer p_Adapter,
> -    UCHAR *packet,
> -    const unsigned int len
> -   );
> -
> -VOID InjectPacketNow
> -   (
> -    TapAdapterPointer p_Adapter,
> -    UCHAR *packet,
> -    const unsigned int len
> -   );
> -
> -// for KDEFERRED_ROUTINE and Static Driver Verifier
> -//#include <wdm.h>
> -//KDEFERRED_ROUTINE InjectPacketDpc;
> -
> -VOID InjectPacketDpc
> -   (
> -    KDPC *Dpc,
> -    PVOID DeferredContext,
> -    PVOID SystemArgument1,
> -    PVOID SystemArgument2
> -    );
> -
> -VOID CheckIfDhcpAndTunMode
> -   (
> -    TapAdapterPointer p_Adapter
> -   );
> -
> -VOID HookDispatchFunctions();
> -
> -#if ENABLE_NONADMIN
> -
> -#if DDKVER_MAJOR < 5600
> -/*
> - * Better solution for use on Vista DDK, but possibly not compatible with
> - * earlier DDKs:
> - *
> - * Eliminate the definition of SECURITY_DESCRIPTOR (and even ZwSetSecuri=
tyObject),
> - * and at the top of tapdrv.c change:
> - *
> - * #include <ndis.h>
> - * #include <ntstrsafe.h>
> - * #include <ntddk.h>
> - *
> - * To
> - *
> - * #include <ntifs.h>
> - * #include <ndis.h>
> - * #include <ntstrsafe.h>
> - */
> -typedef struct _SECURITY_DESCRIPTOR {
> -  unsigned char opaque[64];
> -} SECURITY_DESCRIPTOR;
> -
> -NTSYSAPI
> -NTSTATUS
> -NTAPI
> -ZwSetSecurityObject (
> -  IN HANDLE  Handle,
> -  IN SECURITY_INFORMATION  SecurityInformation,
> -  IN PSECURITY_DESCRIPTOR  SecurityDescriptor);
> -
> -#endif
> -
> -VOID AllowNonAdmin (TapExtensionPointer p_Extension);
> -
> -#endif
> -
> -struct WIN2K_NDIS_MINIPORT_BLOCK
> -{
> -  unsigned char  opaque[16];
> -  UNICODE_STRING MiniportName;       // how mini-port refers to us
> -};
> -
> -#if PACKET_TRUNCATION_CHECK
> -
> -VOID IPv4PacketSizeVerify
> -   (
> -    const UCHAR *data,
> -    ULONG length,
> -    BOOLEAN tun,
> -    const char *prefix,
> -    LONG *counter
> -   );
> -
> -#endif
> -
> -#endif
> diff --git a/tap-win32/resource.rc b/tap-win32/resource.rc
> deleted file mode 100755
> index 84884cf..0000000
> --- a/tap-win32/resource.rc
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -#include <windows.h>
> -#include <ntverp.h>
> -
> -/* get VERSION */
> -#include "common.h"
> -
> -/* VER_FILETYPE, VER_FILESUBTYPE, VER_FILEDESCRIPTION_STR
> - * and VER_INTERNALNAME_STR must be defined before including COMMON.VER
> - * The strings don't need a '\0', since common.ver has them.
> - */
> -
> -#define        VER_FILETYPE    VFT_DRV
> -/* possible values:            VFT_UNKNOWN
> -                               VFT_APP
> -                               VFT_DLL
> -                               VFT_DRV
> -                               VFT_FONT
> -                               VFT_VXD
> -                               VFT_STATIC_LIB
> -*/
> -#define        VER_FILESUBTYPE VFT2_DRV_NETWORK
> -/* possible values             VFT2_UNKNOWN
> -                               VFT2_DRV_PRINTER
> -                               VFT2_DRV_KEYBOARD
> -                               VFT2_DRV_LANGUAGE
> -                               VFT2_DRV_DISPLAY
> -                               VFT2_DRV_MOUSE
> -                               VFT2_DRV_NETWORK
> -                               VFT2_DRV_SYSTEM
> -                               VFT2_DRV_INSTALLABLE
> -                               VFT2_DRV_SOUND
> -                               VFT2_DRV_COMM
> -*/
> -
> -#define VER_COMPANYNAME_STR         "The OpenVPN Project"
> -#define VER_FILEDESCRIPTION_STR     "TAP-Win32 Virtual Network Driver"
> -#define VER_ORIGINALFILENAME_STR    TAP_COMPONENT_ID ".sys"
> -#define VER_LEGALCOPYRIGHT_YEARS    "2003-2010"
> -#define VER_LEGALCOPYRIGHT_STR      "OpenVPN Technologies, Inc."
> -
> -
> -#define VER_PRODUCTNAME_STR         VER_FILEDESCRIPTION_STR
> -#define VER_PRODUCTVERSION         TAP_DRIVER_MAJOR_VERSION,00,00,TAP_DR=
IVER_MINOR_VERSION
> -
> -#define XSTR(s) STR(s)
> -#define STR(s) #s
> -
> -#define VSTRING PACKAGE_VERSION " " XSTR(TAP_DRIVER_MAJOR_VERSION) "/" X=
STR(TAP_DRIVER_MINOR_VERSION)
> -
> -#ifdef DBG
> -#define VER_PRODUCTVERSION_STR      VSTRING " (DEBUG)"
> -#else
> -#define VER_PRODUCTVERSION_STR      VSTRING
> -#endif
> -
> -#define VER_INTERNALNAME_STR        VER_ORIGINALFILENAME_STR
> -
> -#include "common.ver"
> diff --git a/tap-win32/tapdrvr.c b/tap-win32/tapdrvr.c
> deleted file mode 100755
> index e5760dc..0000000
> --- a/tap-win32/tapdrvr.c
> +++ /dev/null
> @@ -1,3146 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -// This driver is designed to work on Win 2000 or higher
> -// versions of Windows.
> -//
> -// It is SMP-safe and handles NDIS 5 power management.
> -//
> -// By default we operate as a "tap" virtual ethernet
> -// 802.3 interface, but we can emulate a "tun"
> -// interface (point-to-point IPv4) through the
> -// TAP_IOCTL_CONFIG_POINT_TO_POINT or
> -// TAP_IOCTL_CONFIG_TUN ioctl.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -
> -#include "common.h"
> -#ifndef DDKVER_MAJOR
> -#error DDKVER_MAJOR must be defined as the major number of the DDK Versi=
on
> -#endif
> -
> -#define NDIS_MINIPORT_DRIVER
> -#define BINARY_COMPATIBLE 0
> -#define NDIS50_MINIPORT 1
> -#define NDIS_WDM 0
> -#define NDIS50 1
> -#define NTSTRSAFE_LIB
> -
> -// Debug info output
> -#define ALSO_DBGPRINT           1
> -#define DEBUGP_AT_DISPATCH      0
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -// Check for truncated IPv4 packets, log errors if found.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -#define PACKET_TRUNCATION_CHECK 0
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -// EXPERIMENTAL -- Configure TAP device object to be
> -// accessible from non-administrative accounts, based
> -// on an advanced properties setting.
> -//
> -// Duplicates the functionality of OpenVPN's
> -// --allow-nonadmin directive.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -#define ENABLE_NONADMIN 1
> -
> -#if DDKVER_MAJOR < 5600
> -#include <ndis.h>
> -#include <ntstrsafe.h>
> -#include <ntddk.h>
> -#else
> -#include <ntifs.h>
> -#include <ndis.h>
> -#include <ntstrsafe.h>
> -#endif
> -
> -#include "lock.h"
> -#include "constants.h"
> -#include "proto.h"
> -#include "error.h"
> -#include "endian.h"
> -#include "dhcp.h"
> -#include "types.h"
> -#include "prototypes.h"
> -
> -#include "mem.c"
> -#include "macinfo.c"
> -#include "error.c"
> -#include "dhcp.c"
> -#include "instance.c"
> -
> -#define IS_UP(ta) \
> -  ((ta)->m_InterfaceIsRunning && (ta)->m_Extension.m_TapIsRunning)
> -
> -#define INCREMENT_STAT(s) ++(s)
> -
> -#define NAME_BUFFER_SIZE 80
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -//                            Globals
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -NDIS_HANDLE g_NdisWrapperHandle;
> -
> -const UINT g_SupportedOIDList[] =3D {
> -  OID_GEN_HARDWARE_STATUS,
> -  OID_GEN_MEDIA_SUPPORTED,
> -  OID_GEN_MEDIA_IN_USE,
> -  OID_GEN_MAXIMUM_LOOKAHEAD,
> -  OID_GEN_MAC_OPTIONS,
> -  OID_GEN_LINK_SPEED,
> -  OID_GEN_TRANSMIT_BLOCK_SIZE,
> -  OID_GEN_RECEIVE_BLOCK_SIZE,
> -  OID_GEN_VENDOR_DESCRIPTION,
> -  OID_GEN_DRIVER_VERSION,
> -  OID_GEN_XMIT_OK,
> -  OID_GEN_RCV_OK,
> -  OID_GEN_XMIT_ERROR,
> -  OID_GEN_RCV_ERROR,
> -  OID_802_3_PERMANENT_ADDRESS,
> -  OID_802_3_CURRENT_ADDRESS,
> -  OID_GEN_RCV_NO_BUFFER,
> -  OID_802_3_RCV_ERROR_ALIGNMENT,
> -  OID_802_3_XMIT_ONE_COLLISION,
> -  OID_802_3_XMIT_MORE_COLLISIONS,
> -  OID_802_3_MULTICAST_LIST,
> -  OID_802_3_MAXIMUM_LIST_SIZE,
> -  OID_GEN_VENDOR_ID,
> -  OID_GEN_CURRENT_LOOKAHEAD,
> -  OID_GEN_CURRENT_PACKET_FILTER,
> -  OID_GEN_PROTOCOL_OPTIONS,
> -  OID_GEN_MAXIMUM_TOTAL_SIZE,
> -  OID_GEN_TRANSMIT_BUFFER_SPACE,
> -  OID_GEN_RECEIVE_BUFFER_SPACE,
> -  OID_GEN_MAXIMUM_FRAME_SIZE,
> -  OID_GEN_VENDOR_DRIVER_VERSION,
> -  OID_GEN_MAXIMUM_SEND_PACKETS,
> -  OID_GEN_MEDIA_CONNECT_STATUS,
> -  OID_GEN_SUPPORTED_LIST
> -};
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                         Driver Entry
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -#pragma NDIS_INIT_FUNCTION (DriverEntry)
> -
> -NTSTATUS
> -DriverEntry (IN PDRIVER_OBJECT p_DriverObject,
> -            IN PUNICODE_STRING p_RegistryPath)
> -{
> -  NDIS_STATUS l_Status =3D NDIS_STATUS_FAILURE;
> -  NDIS_MINIPORT_CHARACTERISTICS *l_Properties =3D NULL;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Notify NDIS that a new miniport driver is initializing.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  NdisMInitializeWrapper (&g_NdisWrapperHandle,
> -                         p_DriverObject,
> -                         p_RegistryPath, NULL);
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Global initialization
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -#if DBG
> -  MyDebugInit (10000); // Allocate debugging text space
> -#endif
> -
> -  if (!InitInstanceList ())
> -    {
> -      DEBUGP (("[TAP] Allocation failed for adapter instance list\n"));
> -      goto cleanup;
> -    }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Set and register miniport entry points
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  l_Properties =3D MemAlloc (sizeof (NDIS_MINIPORT_CHARACTERISTICS), TRU=
E);
> -
> -  if (l_Properties =3D=3D NULL)
> -    {
> -      DEBUGP (("[TAP] Allocation failed for miniport entry points\n"));
> -      goto cleanup;
> -    }
> -
> -  l_Properties->MajorNdisVersion =3D TAP_NDIS_MAJOR_VERSION;
> -  l_Properties->MinorNdisVersion =3D TAP_NDIS_MINOR_VERSION;
> -  l_Properties->InitializeHandler =3D AdapterCreate;
> -  l_Properties->HaltHandler =3D AdapterHalt;
> -  l_Properties->ResetHandler =3D AdapterReset;               /* DISPATCH=
_LEVEL */
> -  l_Properties->TransferDataHandler =3D AdapterReceive;      /* DISPATCH=
_LEVEL */
> -  l_Properties->SendHandler =3D AdapterTransmit;             /* DISPATCH=
_LEVEL */
> -  l_Properties->QueryInformationHandler =3D AdapterQuery;    /* DISPATCH=
_LEVEL */
> -  l_Properties->SetInformationHandler =3D AdapterModify;     /* DISPATCH=
_LEVEL */
> -
> -  switch (l_Status =3D
> -         NdisMRegisterMiniport (g_NdisWrapperHandle, l_Properties,
> -                                sizeof (NDIS_MINIPORT_CHARACTERISTICS)))
> -    {
> -    case NDIS_STATUS_SUCCESS:
> -      {
> -       DEBUGP (("[TAP] version [%d.%d] %s %s registered miniport success=
fully\n",
> -                TAP_DRIVER_MAJOR_VERSION,
> -                TAP_DRIVER_MINOR_VERSION,
> -                __DATE__,
> -                __TIME__));
> -       DEBUGP (("Registry Path: '%.*S'\n", p_RegistryPath->Length/2, p_R=
egistryPath->Buffer));
> -       break;
> -      }
> -
> -    case NDIS_STATUS_BAD_CHARACTERISTICS:
> -      {
> -       DEBUGP (("[TAP] Miniport characteristics were badly defined\n"));
> -       NdisTerminateWrapper (g_NdisWrapperHandle, NULL);
> -       break;
> -      }
> -
> -    case NDIS_STATUS_BAD_VERSION:
> -      {
> -       DEBUGP
> -         (("[TAP] NDIS Version is wrong for the given characteristics\n"=
));
> -       NdisTerminateWrapper (g_NdisWrapperHandle, NULL);
> -       break;
> -      }
> -
> -    case NDIS_STATUS_RESOURCES:
> -      {
> -       DEBUGP (("[TAP] Insufficient resources\n"));
> -       NdisTerminateWrapper (g_NdisWrapperHandle, NULL);
> -       break;
> -      }
> -
> -    default:
> -    case NDIS_STATUS_FAILURE:
> -      {
> -       DEBUGP (("[TAP] Unknown fatal registration error\n"));
> -       NdisTerminateWrapper (g_NdisWrapperHandle, NULL);
> -       break;
> -      }
> -    }
> -
> - cleanup:
> -  if (l_Properties)
> -    MemFree (l_Properties, sizeof (NDIS_MINIPORT_CHARACTERISTICS));
> -
> -  if (l_Status =3D=3D NDIS_STATUS_SUCCESS)
> -    NdisMRegisterUnloadHandler (g_NdisWrapperHandle, TapDriverUnload);
> -  else
> -    TapDriverUnload (p_DriverObject);
> -
> -  return l_Status;
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                         Driver Unload
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -VOID
> -TapDriverUnload (IN PDRIVER_OBJECT p_DriverObject)
> -{
> -  DEBUGP (("[TAP] version [%d.%d] %s %s unloaded, instances=3D%d, imbs=
=3D%d\n",
> -          TAP_DRIVER_MAJOR_VERSION,
> -          TAP_DRIVER_MINOR_VERSION,
> -          __DATE__,
> -          __TIME__,
> -          NInstances(),
> -          InstanceMaxBucketSize()));
> -
> -  FreeInstanceList ();
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Free debugging text space
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -#if DBG
> -  MyDebugFree ();
> -#endif
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                            Adapter Initialization
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -NDIS_STATUS AdapterCreate
> -(OUT PNDIS_STATUS p_ErrorStatus,
> - OUT PUINT p_MediaIndex,
> - IN PNDIS_MEDIUM p_Media,
> - IN UINT p_MediaCount,
> - IN NDIS_HANDLE p_AdapterHandle,
> - IN NDIS_HANDLE p_ConfigurationHandle)
> -{
> -  TapAdapterPointer l_Adapter =3D NULL;
> -
> -  NDIS_MEDIUM l_PreferredMedium =3D NdisMedium802_3; // Ethernet
> -  BOOLEAN l_MacFromRegistry =3D FALSE;
> -  UINT l_Index;
> -  NDIS_STATUS status;
> -
> -#if ENABLE_NONADMIN
> -  BOOLEAN enable_non_admin =3D FALSE;
> -#endif
> -
> -  DEBUGP (("[TAP] AdapterCreate called\n"));
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Make sure adapter type is supported
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  for (l_Index =3D 0;
> -       l_Index < p_MediaCount && p_Media[l_Index] !=3D l_PreferredMedium;
> -       ++l_Index);
> -
> -  if (l_Index =3D=3D p_MediaCount)
> -    {
> -      DEBUGP (("[TAP] Unsupported adapter type [wanted: %d]\n",
> -              l_PreferredMedium));
> -      return NDIS_STATUS_UNSUPPORTED_MEDIA;
> -    }
> -
> -  *p_MediaIndex =3D l_Index;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Allocate memory for TapAdapter structure
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  l_Adapter =3D MemAlloc (sizeof (TapAdapter), TRUE);
> -
> -  if (l_Adapter =3D=3D NULL)
> -    {
> -      DEBUGP (("[TAP] Couldn't allocate adapter memory\n"));
> -      return NDIS_STATUS_RESOURCES;
> -    }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Inform the NDIS library about significant
> -  // features of our virtual NIC.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  NdisMSetAttributesEx
> -    (p_AdapterHandle,
> -     (NDIS_HANDLE) l_Adapter,
> -     16,
> -     NDIS_ATTRIBUTE_DESERIALIZE
> -     | NDIS_ATTRIBUTE_IGNORE_PACKET_TIMEOUT
> -     | NDIS_ATTRIBUTE_IGNORE_REQUEST_TIMEOUT
> -     | NDIS_ATTRIBUTE_NO_HALT_ON_SUSPEND,
> -     NdisInterfaceInternal);
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Initialize simple Adapter parameters
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  l_Adapter->m_Lookahead =3D DEFAULT_PACKET_LOOKAHEAD;
> -  l_Adapter->m_Medium =3D l_PreferredMedium;
> -  l_Adapter->m_DeviceState =3D '?';
> -  l_Adapter->m_MiniportAdapterHandle =3D p_AdapterHandle;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Allocate spinlock for controlling
> -  // access to multicast address list.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  NdisAllocateSpinLock (&l_Adapter->m_MCLock);
> -  l_Adapter->m_MCLockAllocated =3D TRUE;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -  // Register a shutdown handler which will be called
> -  // on system restart/shutdown to halt our virtual NIC.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -
> -  NdisMRegisterAdapterShutdownHandler (p_AdapterHandle, l_Adapter,
> -                                      AdapterHalt);
> -  l_Adapter->m_RegisteredAdapterShutdownHandler =3D TRUE;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Get parameters from registry which were set
> -  // in the adapter advanced properties dialog.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  {
> -    NDIS_STATUS status;
> -    NDIS_HANDLE configHandle;
> -    NDIS_CONFIGURATION_PARAMETER *parm;
> -
> -    // set defaults in case our registry query fails
> -    l_Adapter->m_MTU =3D ETHERNET_MTU;
> -    l_Adapter->m_MediaStateAlwaysConnected =3D FALSE;
> -    l_Adapter->m_MediaState =3D FALSE;
> -
> -    NdisOpenConfiguration (&status, &configHandle, p_ConfigurationHandle=
);
> -    if (status !=3D NDIS_STATUS_SUCCESS)
> -      {
> -       DEBUGP (("[TAP] Couldn't open adapter registry\n"));
> -       AdapterFreeResources (l_Adapter);
> -       return status;
> -      }
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    // Allocate and construct adapter name
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    {
> -
> -      NDIS_STRING mkey =3D NDIS_STRING_CONST("MiniportName");
> -      NDIS_STRING vkey =3D NDIS_STRING_CONST("NdisVersion");
> -      NDIS_STATUS vstatus;
> -      NDIS_CONFIGURATION_PARAMETER *vparm;
> -
> -      NdisReadConfiguration (&vstatus, &vparm, configHandle, &vkey, Ndis=
ParameterInteger);
> -      if (vstatus =3D=3D NDIS_STATUS_SUCCESS)
> -       DEBUGP (("[TAP] NdisReadConfiguration NdisVersion=3D%X\n", vparm-=
>ParameterData.IntegerData));
> -
> -      NdisReadConfiguration (&status, &parm, configHandle, &mkey, NdisPa=
rameterString);
> -      if (status =3D=3D NDIS_STATUS_SUCCESS)
> -       {
> -         if (parm->ParameterType =3D=3D NdisParameterString)
> -           {
> -             DEBUGP (("[TAP] NdisReadConfiguration (MiniportName=3D%.*S)=
\n",
> -                      parm->ParameterData.StringData.Length/2,
> -                      parm->ParameterData.StringData.Buffer));
> -
> -             if (RtlUnicodeStringToAnsiString (
> -                                               &l_Adapter->m_NameAnsi,
> -                                               &parm->ParameterData.Stri=
ngData,
> -                                               TRUE) !=3D STATUS_SUCCESS)
> -               {
> -                 DEBUGP (("[TAP] MiniportName failed\n"));
> -                 status =3D NDIS_STATUS_RESOURCES;
> -               }
> -           }
> -       }
> -      else
> -       {
> -         /* "MiniportName" is available only XP and above.  Not on Windo=
ws 2000. */
> -         if (vstatus =3D=3D NDIS_STATUS_SUCCESS && vparm->ParameterData.=
IntegerData =3D=3D 0x50000)
> -           {
> -             /* Fallback for Windows 2000 with NDIS version 5.00.00
> -                Don't use this on Vista, 'NDIS_MINIPORT_BLOCK' was chang=
ed! */
> -             if (RtlUnicodeStringToAnsiString (&l_Adapter->m_NameAnsi,
> -                                               &((struct WIN2K_NDIS_MINI=
PORT_BLOCK *) p_AdapterHandle)->MiniportName,
> -                                               TRUE) !=3D STATUS_SUCCESS)
> -               {
> -                 DEBUGP (("[TAP] MiniportName (W2K) failed\n"));
> -                 status =3D NDIS_STATUS_RESOURCES;
> -               }
> -             else
> -               {
> -                 DEBUGP (("[TAP] MiniportName (W2K) succeeded: %s\n", l_=
Adapter->m_NameAnsi.Buffer));
> -                 status =3D NDIS_STATUS_SUCCESS;
> -               }
> -           }
> -       }
> -    }
> -
> -    /* Can't continue without name (see macro 'NAME') */
> -    if (status !=3D NDIS_STATUS_SUCCESS || !l_Adapter->m_NameAnsi.Buffer)
> -      {
> -       NdisCloseConfiguration (configHandle);
> -       AdapterFreeResources (l_Adapter);
> -       DEBUGP (("[TAP] failed to get miniport name\n"));
> -       return NDIS_STATUS_RESOURCES;
> -      }
> -
> -    /* Read MTU setting from registry */
> -    {
> -      NDIS_STRING key =3D NDIS_STRING_CONST("MTU");
> -      NdisReadConfiguration (&status, &parm, configHandle,
> -                            &key, NdisParameterInteger);
> -      if (status =3D=3D NDIS_STATUS_SUCCESS)
> -       {
> -         if (parm->ParameterType =3D=3D NdisParameterInteger)
> -           {
> -             int mtu =3D parm->ParameterData.IntegerData;
> -             if (mtu < MINIMUM_MTU)
> -               mtu =3D MINIMUM_MTU;
> -             if (mtu > MAXIMUM_MTU)
> -               mtu =3D MAXIMUM_MTU;
> -             l_Adapter->m_MTU =3D mtu;
> -           }
> -       }
> -    }
> -
> -    /* Read Media Status setting from registry */
> -    {
> -      NDIS_STRING key =3D NDIS_STRING_CONST("MediaStatus");
> -      NdisReadConfiguration (&status, &parm, configHandle,
> -                            &key, NdisParameterInteger);
> -      if (status =3D=3D NDIS_STATUS_SUCCESS)
> -       {
> -         if (parm->ParameterType =3D=3D NdisParameterInteger)
> -           {
> -             if (parm->ParameterData.IntegerData)
> -               {
> -                 l_Adapter->m_MediaStateAlwaysConnected =3D TRUE;
> -                 l_Adapter->m_MediaState =3D TRUE;
> -               }
> -           }
> -       }
> -    }
> -
> -#if ENABLE_NONADMIN
> -    /* Read AllowNonAdmin setting from registry */
> -    {
> -      NDIS_STRING key =3D NDIS_STRING_CONST("AllowNonAdmin");
> -      NdisReadConfiguration (&status, &parm, configHandle,
> -                            &key, NdisParameterInteger);
> -      if (status =3D=3D NDIS_STATUS_SUCCESS)
> -       {
> -         if (parm->ParameterType =3D=3D NdisParameterInteger)
> -           {
> -             if (parm->ParameterData.IntegerData)
> -               {
> -                 enable_non_admin =3D TRUE;
> -               }
> -           }
> -       }
> -    }
> -#endif
> -
> -    /* Read optional MAC setting from registry */
> -    {
> -      NDIS_STRING key =3D NDIS_STRING_CONST("MAC");
> -      ANSI_STRING mac_string;
> -      NdisReadConfiguration (&status, &parm, configHandle,
> -                            &key, NdisParameterString);
> -      if (status =3D=3D NDIS_STATUS_SUCCESS)
> -       {
> -         if (parm->ParameterType =3D=3D NdisParameterString)
> -           {
> -             if (RtlUnicodeStringToAnsiString (&mac_string, &parm->Param=
eterData.StringData, TRUE) =3D=3D STATUS_SUCCESS)
> -               {
> -                 l_MacFromRegistry =3D ParseMAC (l_Adapter->m_MAC, mac_s=
tring.Buffer);
> -                 RtlFreeAnsiString (&mac_string);
> -               }
> -           }
> -       }
> -    }
> -
> -    NdisCloseConfiguration (configHandle);
> -
> -    DEBUGP (("[%s] MTU=3D%d\n", NAME (l_Adapter), l_Adapter->m_MTU));
> -  }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Store and update MAC address info
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  if (!l_MacFromRegistry)
> -    GenerateRandomMac (l_Adapter->m_MAC, NAME (l_Adapter));
> -
> -  DEBUGP (("[%s] Using MAC %x:%x:%x:%x:%x:%x\n",
> -          NAME (l_Adapter),
> -          l_Adapter->m_MAC[0], l_Adapter->m_MAC[1], l_Adapter->m_MAC[2],
> -          l_Adapter->m_MAC[3], l_Adapter->m_MAC[4], l_Adapter->m_MAC[5])=
);
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Set broadcast MAC
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  {
> -    int i;
> -    for (i =3D 0; i < sizeof (MACADDR); ++i)
> -      l_Adapter->m_MAC_Broadcast[i] =3D 0xFF;
> -  }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Initialize TAP device
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  {
> -    NDIS_STATUS tap_status;
> -    tap_status =3D CreateTapDevice (&l_Adapter->m_Extension, NAME (l_Ada=
pter));
> -    if (tap_status !=3D NDIS_STATUS_SUCCESS)
> -      {
> -       AdapterFreeResources (l_Adapter);
> -       DEBUGP (("[TAP] CreateTapDevice failed\n"));
> -       return tap_status;
> -      }
> -  }
> -
> -  if (!AddAdapterToInstanceList (l_Adapter))
> -    {
> -      NOTE_ERROR ();
> -      TapDeviceFreeResources (&l_Adapter->m_Extension);
> -      AdapterFreeResources (l_Adapter);
> -      DEBUGP (("[TAP] AddAdapterToInstanceList failed\n"));
> -      return NDIS_STATUS_RESOURCES;
> -    }
> -
> -  l_Adapter->m_InterfaceIsRunning =3D TRUE;
> -
> -#if ENABLE_NONADMIN
> -  if (enable_non_admin)
> -    AllowNonAdmin (&l_Adapter->m_Extension);
> -#endif
> -
> -  return NDIS_STATUS_SUCCESS;
> -}
> -
> -VOID
> -AdapterHalt (IN NDIS_HANDLE p_AdapterContext)
> -{
> -  BOOLEAN status;
> -
> -  TapAdapterPointer l_Adapter =3D (TapAdapterPointer) p_AdapterContext;
> -
> -  NOTE_ERROR ();
> -
> -  l_Adapter->m_InterfaceIsRunning =3D FALSE;
> -
> -  DEBUGP (("[%s] is being halted\n", NAME (l_Adapter)));
> -
> -  DestroyTapDevice (&l_Adapter->m_Extension);
> -
> -  // Free resources
> -  DEBUGP (("[%s] Freeing Resources\n", NAME (l_Adapter)));
> -  AdapterFreeResources (l_Adapter);
> -
> -  status =3D RemoveAdapterFromInstanceList (l_Adapter);
> -  DEBUGP (("[TAP] RemoveAdapterFromInstanceList returned %d\n", (int) st=
atus));
> -
> -  DEBUGP (("[TAP] version [%d.%d] %s %s AdapterHalt returning\n",
> -          TAP_DRIVER_MAJOR_VERSION,
> -          TAP_DRIVER_MINOR_VERSION,
> -          __DATE__,
> -          __TIME__));
> -}
> -
> -VOID
> -AdapterFreeResources (TapAdapterPointer p_Adapter)
> -{
> -  MYASSERT (!p_Adapter->m_CalledAdapterFreeResources);
> -  p_Adapter->m_CalledAdapterFreeResources =3D TRUE;
> -
> -  if (p_Adapter->m_NameAnsi.Buffer)
> -    RtlFreeAnsiString (&p_Adapter->m_NameAnsi);
> -
> -  if (p_Adapter->m_RegisteredAdapterShutdownHandler)
> -    NdisMDeregisterAdapterShutdownHandler (p_Adapter->m_MiniportAdapterH=
andle);
> -
> -  if (p_Adapter->m_MCLockAllocated)
> -    NdisFreeSpinLock (&p_Adapter->m_MCLock);
> -}
> -
> -VOID
> -DestroyTapDevice (TapExtensionPointer p_Extension)
> -{
> -  DEBUGP (("[%s] Destroying tap device\n", p_Extension->m_TapName));
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Let clients know we are shutting down
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  p_Extension->m_TapIsRunning =3D FALSE;
> -  p_Extension->m_TapOpens =3D 0;
> -  p_Extension->m_Halt =3D TRUE;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // If we are concurrently executing in
> -  // TapDeviceHook or AdapterTransmit,
> -  // give those calls time to finish.
> -  // Note that we must be running at IRQL
> -  // < DISPATCH_LEVEL in order to call
> -  // NdisMSleep.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  NdisMSleep (500000);
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Exhaust IRP and packet queues.  Any pending IRPs will
> -  // be cancelled, causing user-space to get this error
> -  // on overlapped reads:
> -  //   The I/O operation has been aborted because of either a
> -  //   thread exit or an application request.   (code=3D995)
> -  // It's important that user-space close the device handle
> -  // when this code is returned, so that when we finally
> -  // do a NdisMDeregisterDevice, the device reference count
> -  // is 0.  Otherwise the driver will not unload even if the
> -  // the last adapter has been halted.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  FlushQueues (p_Extension);
> -  NdisMSleep (500000); // give user space time to respond to IRP cancel
> -
> -  TapDeviceFreeResources (p_Extension);
> -}
> -
> -VOID
> -TapDeviceFreeResources (TapExtensionPointer p_Extension)
> -{
> -  MYASSERT (p_Extension);
> -  MYASSERT (!p_Extension->m_CalledTapDeviceFreeResources);
> -  p_Extension->m_CalledTapDeviceFreeResources =3D TRUE;
> -
> -  if (p_Extension->m_PacketQueue)
> -    QueueFree (p_Extension->m_PacketQueue);
> -  if (p_Extension->m_IrpQueue)
> -    QueueFree (p_Extension->m_IrpQueue);
> -  if (p_Extension->m_InjectQueue)
> -    QueueFree (p_Extension->m_InjectQueue);
> -
> -  if (p_Extension->m_CreatedUnicodeLinkName)
> -    RtlFreeUnicodeString (&p_Extension->m_UnicodeLinkName);
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // According to DDK docs, the device is not actually deleted
> -  // until its reference count falls to zero.  That means we
> -  // still need to gracefully fail TapDeviceHook requests
> -  // after this point, otherwise ugly things would happen if
> -  // the device was disabled (e.g. in the network connections
> -  // control panel) while a userspace app still held an open
> -  // file handle to it.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  if (p_Extension->m_TapDevice)
> -    {
> -      BOOLEAN status;
> -      status =3D (NdisMDeregisterDevice (p_Extension->m_TapDeviceHandle)
> -               =3D=3D NDIS_STATUS_SUCCESS);
> -      DEBUGP (("[TAP] Deregistering TAP device, status=3D%d\n", (int)sta=
tus));
> -    }
> -
> -  if (p_Extension->m_TapName)
> -    MemFree (p_Extension->m_TapName, NAME_BUFFER_SIZE);
> -
> -  if (p_Extension->m_InjectDpcInitialized)
> -    KeRemoveQueueDpc (&p_Extension->m_InjectDpc);
> -
> -  if (p_Extension->m_AllocatedSpinlocks)
> -    {
> -      NdisFreeSpinLock (&p_Extension->m_QueueLock);
> -      NdisFreeSpinLock (&p_Extension->m_InjectLock);
> -    }
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                             Tap Device Initialization
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -NDIS_STATUS
> -CreateTapDevice (TapExtensionPointer p_Extension, const char *p_Name)
> -{
> -# define SIZEOF_DISPATCH (sizeof(PDRIVER_DISPATCH) * (IRP_MJ_MAXIMUM_FUN=
CTION + 1))
> -  PDRIVER_DISPATCH *l_Dispatch =3D NULL;
> -  ANSI_STRING l_TapString, l_LinkString;
> -  UNICODE_STRING l_TapUnicode;
> -  BOOLEAN l_FreeTapUnicode =3D FALSE;
> -  NTSTATUS l_Status, l_Return =3D NDIS_STATUS_SUCCESS;
> -  const char *l_UsableName;
> -
> -  DEBUGP (("[TAP] version [%d.%d] creating tap device: %s\n",
> -          TAP_DRIVER_MAJOR_VERSION,
> -          TAP_DRIVER_MINOR_VERSION,
> -          p_Name));
> -
> -  NdisZeroMemory (p_Extension, sizeof (TapExtension));
> -
> -  INIT_MUTEX (&p_Extension->m_OpenCloseMutex);
> -
> -  l_LinkString.Buffer =3D NULL;
> -  l_TapString.Buffer =3D NULL;
> -
> -  l_TapString.MaximumLength =3D l_LinkString.MaximumLength =3D NAME_BUFF=
ER_SIZE;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Set TAP device entry points
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  if ((l_Dispatch =3D MemAlloc (SIZEOF_DISPATCH, TRUE)) =3D=3D NULL)
> -    {
> -      DEBUGP (("[%s] couldn't alloc TAP dispatch table\n", p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -
> -  l_Dispatch[IRP_MJ_DEVICE_CONTROL] =3D TapDeviceHook;
> -  l_Dispatch[IRP_MJ_READ] =3D TapDeviceHook;
> -  l_Dispatch[IRP_MJ_WRITE] =3D TapDeviceHook;
> -  l_Dispatch[IRP_MJ_CREATE] =3D TapDeviceHook;
> -  l_Dispatch[IRP_MJ_CLOSE] =3D TapDeviceHook;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Find the beginning of the GUID
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  l_UsableName =3D p_Name;
> -  while (*l_UsableName !=3D '{')
> -    {
> -      if (*l_UsableName =3D=3D '\0')
> -       {
> -         DEBUGP (("[%s] couldn't find leading '{' in name\n", p_Name));
> -         l_Return =3D NDIS_STATUS_RESOURCES;
> -         goto cleanup;
> -       }
> -      ++l_UsableName;
> -    }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Allocate pool for TAP device name
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  if ((p_Extension->m_TapName =3D l_TapString.Buffer =3D
> -       MemAlloc (NAME_BUFFER_SIZE, TRUE)) =3D=3D NULL)
> -    {
> -      DEBUGP (("[%s] couldn't alloc TAP name buffer\n", p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -  // Allocate pool for TAP symbolic link name buffer
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -
> -  if ((l_LinkString.Buffer =3D
> -       MemAlloc (NAME_BUFFER_SIZE, TRUE)) =3D=3D NULL)
> -    {
> -      DEBUGP (("[%s] couldn't alloc TAP symbolic link name buffer\n",
> -              p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Set TAP device name
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  l_Status =3D RtlStringCchPrintfExA
> -    (l_TapString.Buffer,
> -     l_TapString.MaximumLength,
> -     NULL,
> -     NULL,
> -     STRSAFE_FILL_BEHIND_NULL | STRSAFE_IGNORE_NULLS,
> -     "%s%s%s",
> -     SYSDEVICEDIR,
> -     l_UsableName,
> -     TAPSUFFIX);
> -
> -  if (l_Status !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[%s] couldn't format TAP device name\n",
> -              p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -  l_TapString.Length =3D (USHORT) strlen (l_TapString.Buffer);
> -
> -  DEBUGP (("TAP DEV NAME: '%s'\n", l_TapString.Buffer));
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Set TAP link name
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  l_Status =3D RtlStringCchPrintfExA
> -    (l_LinkString.Buffer,
> -     l_LinkString.MaximumLength,
> -     NULL,
> -     NULL,
> -     STRSAFE_FILL_BEHIND_NULL | STRSAFE_IGNORE_NULLS,
> -     "%s%s%s",
> -     USERDEVICEDIR,
> -     l_UsableName,
> -     TAPSUFFIX);
> -
> -  if (l_Status !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[%s] couldn't format TAP device symbolic link\n",
> -              p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -  l_LinkString.Length =3D (USHORT) strlen (l_LinkString.Buffer);
> -
> -  DEBUGP (("TAP LINK NAME: '%s'\n", l_LinkString.Buffer));
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -  // Convert strings to unicode
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -  if (RtlAnsiStringToUnicodeString (&l_TapUnicode, &l_TapString, TRUE) !=
=3D
> -      STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[%s] couldn't alloc TAP unicode name buffer\n",
> -               p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -  l_FreeTapUnicode =3D TRUE;
> -
> -  if (RtlAnsiStringToUnicodeString
> -      (&p_Extension->m_UnicodeLinkName, &l_LinkString, TRUE)
> -      !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP
> -       (("[%s] Couldn't allocate unicode string for symbolic link name\n=
",
> -        p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -  p_Extension->m_CreatedUnicodeLinkName =3D TRUE;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -  // Create new TAP device with symbolic
> -  // link and associate with adapter.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -
> -  l_Status =3D NdisMRegisterDevice
> -    (g_NdisWrapperHandle,
> -     &l_TapUnicode,
> -     &p_Extension->m_UnicodeLinkName,
> -     l_Dispatch,
> -     &p_Extension->m_TapDevice,
> -     &p_Extension->m_TapDeviceHandle
> -     );
> -
> -  if (l_Status !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[%s] couldn't be created\n", p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -
> -  /* Set TAP device flags */
> -  p_Extension->m_TapDevice->Flags |=3D DO_DIRECT_IO;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Initialize Packet and IRP queues.
> -  //
> -  // The packet queue is used to buffer data which has been
> -  // "transmitted" by the virtual NIC, before user space
> -  // has had a chance to read it.
> -  //
> -  // The IRP queue is used to buffer pending I/O requests
> -  // from userspace, i.e. read requests on the TAP device
> -  // waiting for the system to "transmit" something through
> -  // the virtual NIC.
> -  //
> -  // Basically, packets in the packet queue are used
> -  // to satisfy IRP requests in the IRP queue.
> -  //
> -  // QueueLock is used to lock the packet queue used
> -  // for the TAP-Win32 NIC -> User Space packet flow direction.
> -  //
> -  // All accesses to packet or IRP queues should be
> -  // bracketed by the QueueLock spinlock,
> -  // in order to be SMP-safe.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  NdisAllocateSpinLock (&p_Extension->m_QueueLock);
> -  NdisAllocateSpinLock (&p_Extension->m_InjectLock);
> -  p_Extension->m_AllocatedSpinlocks =3D TRUE;
> -
> -  p_Extension->m_PacketQueue =3D QueueInit (PACKET_QUEUE_SIZE);
> -  p_Extension->m_IrpQueue =3D QueueInit (IRP_QUEUE_SIZE);
> -  p_Extension->m_InjectQueue =3D QueueInit (INJECT_QUEUE_SIZE);
> -  if (!p_Extension->m_PacketQueue
> -      || !p_Extension->m_IrpQueue
> -      || !p_Extension->m_InjectQueue)
> -    {
> -      DEBUGP (("[%s] couldn't alloc TAP queues\n", p_Name));
> -      l_Return =3D NDIS_STATUS_RESOURCES;
> -      goto cleanup;
> -    }
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  // Initialize deferred procedure call for DHCP/ARP packet injection
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -  KeInitializeDpc (&p_Extension->m_InjectDpc, InjectPacketDpc, NULL);
> -  p_Extension->m_InjectDpcInitialized =3D TRUE;
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -  // Finalize initialization
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -
> -  p_Extension->m_TapIsRunning =3D TRUE;
> -
> -  DEBUGP (("[%s] successfully created TAP device [%s]\n", p_Name,
> -           p_Extension->m_TapName));
> -
> - cleanup:
> -  if (l_FreeTapUnicode)
> -    RtlFreeUnicodeString (&l_TapUnicode);
> -  if (l_LinkString.Buffer)
> -    MemFree (l_LinkString.Buffer, NAME_BUFFER_SIZE);
> -  if (l_Dispatch)
> -    MemFree (l_Dispatch, SIZEOF_DISPATCH);
> -
> -  if (l_Return !=3D NDIS_STATUS_SUCCESS)
> -    TapDeviceFreeResources (p_Extension);
> -
> -  return l_Return;
> -}
> -#undef SIZEOF_DISPATCH
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -//                      Adapter Control
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -NDIS_STATUS
> -AdapterReset (OUT PBOOLEAN p_AddressingReset, IN NDIS_HANDLE p_AdapterCo=
ntext)
> -{
> -  TapAdapterPointer l_Adapter =3D (TapAdapterPointer) p_AdapterContext;
> -  DEBUGP (("[%s] is resetting\n", NAME (l_Adapter)));
> -  return NDIS_STATUS_SUCCESS;
> -}
> -
> -NDIS_STATUS AdapterReceive
> -  (OUT PNDIS_PACKET p_Packet,
> -   OUT PUINT p_Transferred,
> -   IN NDIS_HANDLE p_AdapterContext,
> -   IN NDIS_HANDLE p_ReceiveContext,
> -   IN UINT p_Offset,
> -   IN UINT p_ToTransfer)
> -{
> -  return NDIS_STATUS_SUCCESS;
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                  Adapter Option Query/Modification
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -NDIS_STATUS AdapterQuery
> -(IN NDIS_HANDLE p_AdapterContext,
> - IN NDIS_OID p_OID,
> - IN PVOID p_Buffer,
> - IN ULONG p_BufferLength,
> - OUT PULONG p_BytesWritten, OUT PULONG p_BytesNeeded)
> -{
> -  TapAdapterPointer l_Adapter =3D (TapAdapterPointer) p_AdapterContext;
> -  TapAdapterQuery l_Query, *l_QueryPtr =3D &l_Query;
> -  NDIS_STATUS l_Status =3D NDIS_STATUS_SUCCESS;
> -  UINT l_QueryLength =3D 4;
> -  BOOLEAN lock_succeeded;
> -
> -  NdisZeroMemory (&l_Query, sizeof (l_Query));
> -
> -  switch (p_OID)
> -    {
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                       Vendor & Driver version Info
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case OID_GEN_VENDOR_DESCRIPTION:
> -      l_QueryPtr =3D (TapAdapterQueryPointer) PRODUCT_STRING;
> -      l_QueryLength =3D strlen (PRODUCT_STRING) + 1;
> -      break;
> -
> -    case OID_GEN_VENDOR_ID:
> -      l_Query.m_Long =3D 0xffffff;
> -      break;
> -
> -    case OID_GEN_DRIVER_VERSION:
> -      l_Query.m_Short =3D
> -       (((USHORT) TAP_NDIS_MAJOR_VERSION) << 8 | (USHORT)
> -        TAP_NDIS_MINOR_VERSION);
> -      l_QueryLength =3D sizeof (unsigned short);
> -      break;
> -
> -    case OID_GEN_VENDOR_DRIVER_VERSION:
> -      l_Query.m_Long =3D
> -       (((USHORT) TAP_DRIVER_MAJOR_VERSION) << 8 | (USHORT)
> -        TAP_DRIVER_MINOR_VERSION);
> -      break;
> -
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                             Statistics
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case OID_GEN_RCV_NO_BUFFER:
> -      l_Query.m_Long =3D 0;
> -      break;
> -
> -    case OID_802_3_RCV_ERROR_ALIGNMENT:
> -      l_Query.m_Long =3D 0;
> -      break;
> -
> -    case OID_802_3_XMIT_ONE_COLLISION:
> -      l_Query.m_Long =3D 0;
> -      break;
> -
> -    case OID_802_3_XMIT_MORE_COLLISIONS:
> -      l_Query.m_Long =3D 0;
> -      break;
> -
> -    case OID_GEN_XMIT_OK:
> -      l_Query.m_Long =3D l_Adapter->m_Tx;
> -      break;
> -
> -    case OID_GEN_RCV_OK:
> -      l_Query.m_Long =3D l_Adapter->m_Rx;
> -      break;
> -
> -    case OID_GEN_XMIT_ERROR:
> -      l_Query.m_Long =3D l_Adapter->m_TxErr;
> -      break;
> -
> -    case OID_GEN_RCV_ERROR:
> -      l_Query.m_Long =3D l_Adapter->m_RxErr;
> -      break;
> -
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                       Device & Protocol Options
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case OID_GEN_SUPPORTED_LIST:
> -      l_QueryPtr =3D (TapAdapterQueryPointer) g_SupportedOIDList;
> -      l_QueryLength =3D sizeof (g_SupportedOIDList);
> -      break;
> -
> -    case OID_GEN_MAC_OPTIONS:
> -      // This MUST be here !!!
> -      l_Query.m_Long =3D (NDIS_MAC_OPTION_RECEIVE_SERIALIZED
> -                       | NDIS_MAC_OPTION_COPY_LOOKAHEAD_DATA
> -                       | NDIS_MAC_OPTION_NO_LOOPBACK
> -                       | NDIS_MAC_OPTION_TRANSFERS_NOT_PEND);
> -
> -      break;
> -
> -    case OID_GEN_CURRENT_PACKET_FILTER:
> -      l_Query.m_Long =3D
> -       (NDIS_PACKET_TYPE_ALL_LOCAL |
> -        NDIS_PACKET_TYPE_BROADCAST |
> -        NDIS_PACKET_TYPE_DIRECTED | NDIS_PACKET_TYPE_ALL_FUNCTIONAL);
> -
> -      break;
> -
> -    case OID_GEN_PROTOCOL_OPTIONS:
> -      l_Query.m_Long =3D 0;
> -      break;
> -
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                            Device Info
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case OID_GEN_MEDIA_CONNECT_STATUS:
> -      l_Query.m_Long =3D l_Adapter->m_MediaState
> -       ? NdisMediaStateConnected : NdisMediaStateDisconnected;
> -      break;
> -
> -    case OID_GEN_HARDWARE_STATUS:
> -      l_Query.m_HardwareStatus =3D NdisHardwareStatusReady;
> -      l_QueryLength =3D sizeof (NDIS_HARDWARE_STATUS);
> -      break;
> -
> -    case OID_GEN_MEDIA_SUPPORTED:
> -    case OID_GEN_MEDIA_IN_USE:
> -      l_Query.m_Medium =3D l_Adapter->m_Medium;
> -      l_QueryLength =3D sizeof (NDIS_MEDIUM);
> -      break;
> -
> -    case OID_GEN_PHYSICAL_MEDIUM:
> -      l_Query.m_PhysicalMedium =3D NdisPhysicalMediumUnspecified;
> -      l_QueryLength =3D sizeof (NDIS_PHYSICAL_MEDIUM);
> -      break;
> -
> -    case OID_GEN_LINK_SPEED:
> -      l_Query.m_Long =3D 100000; // rate / 100 bps
> -      break;
> -
> -    case OID_802_3_PERMANENT_ADDRESS:
> -    case OID_802_3_CURRENT_ADDRESS:
> -      COPY_MAC (l_Query.m_MacAddress, l_Adapter->m_MAC);
> -      l_QueryLength =3D sizeof (MACADDR);
> -      break;
> -
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                             Limits
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -    case OID_GEN_MAXIMUM_SEND_PACKETS:
> -      l_Query.m_Long =3D 1;
> -      break;
> -
> -    case OID_802_3_MAXIMUM_LIST_SIZE:
> -      l_Query.m_Long =3D NIC_MAX_MCAST_LIST;
> -      break;
> -
> -    case OID_GEN_CURRENT_LOOKAHEAD:
> -      l_Query.m_Long =3D l_Adapter->m_Lookahead;
> -      break;
> -
> -    case OID_GEN_MAXIMUM_LOOKAHEAD:
> -    case OID_GEN_MAXIMUM_TOTAL_SIZE:
> -    case OID_GEN_RECEIVE_BUFFER_SPACE:
> -    case OID_GEN_RECEIVE_BLOCK_SIZE:
> -      l_Query.m_Long =3D DEFAULT_PACKET_LOOKAHEAD;
> -      break;
> -
> -    case OID_GEN_MAXIMUM_FRAME_SIZE:
> -    case OID_GEN_TRANSMIT_BLOCK_SIZE:
> -    case OID_GEN_TRANSMIT_BUFFER_SPACE:
> -      l_Query.m_Long =3D l_Adapter->m_MTU;
> -      break;
> -
> -    case OID_PNP_CAPABILITIES:
> -      do
> -       {
> -         PNDIS_PNP_CAPABILITIES pPNPCapabilities;
> -         PNDIS_PM_WAKE_UP_CAPABILITIES pPMstruct;
> -
> -         if (p_BufferLength >=3D sizeof (NDIS_PNP_CAPABILITIES))
> -           {
> -             pPNPCapabilities =3D (PNDIS_PNP_CAPABILITIES) (p_Buffer);
> -
> -             //
> -             // Setting up the buffer to be returned
> -             // to the Protocol above the Passthru miniport
> -             //
> -             pPMstruct =3D &pPNPCapabilities->WakeUpCapabilities;
> -             pPMstruct->MinMagicPacketWakeUp =3D NdisDeviceStateUnspecif=
ied;
> -             pPMstruct->MinPatternWakeUp =3D NdisDeviceStateUnspecified;
> -             pPMstruct->MinLinkChangeWakeUp =3D NdisDeviceStateUnspecifi=
ed;
> -           }
> -         l_QueryLength =3D sizeof (NDIS_PNP_CAPABILITIES);
> -       }
> -      while (FALSE);
> -      break;
> -    case OID_PNP_QUERY_POWER:
> -      break;
> -
> -      // Required OIDs that we don't support
> -
> -    case OID_GEN_SUPPORTED_GUIDS:
> -    case OID_GEN_MEDIA_CAPABILITIES:
> -    case OID_TCP_TASK_OFFLOAD:
> -    case OID_FFP_SUPPORT:
> -      l_Status =3D NDIS_STATUS_INVALID_OID;
> -      break;
> -
> -      // Optional stats OIDs
> -
> -    case OID_GEN_DIRECTED_BYTES_XMIT:
> -    case OID_GEN_DIRECTED_FRAMES_XMIT:
> -    case OID_GEN_MULTICAST_BYTES_XMIT:
> -    case OID_GEN_MULTICAST_FRAMES_XMIT:
> -    case OID_GEN_BROADCAST_BYTES_XMIT:
> -    case OID_GEN_BROADCAST_FRAMES_XMIT:
> -    case OID_GEN_DIRECTED_BYTES_RCV:
> -    case OID_GEN_DIRECTED_FRAMES_RCV:
> -    case OID_GEN_MULTICAST_BYTES_RCV:
> -    case OID_GEN_MULTICAST_FRAMES_RCV:
> -    case OID_GEN_BROADCAST_BYTES_RCV:
> -    case OID_GEN_BROADCAST_FRAMES_RCV:
> -      l_Status =3D NDIS_STATUS_INVALID_OID;
> -      break;
> -
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                          Not Handled
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    default:
> -      DEBUGP (("[%s] Unhandled OID %lx\n", NAME (l_Adapter), p_OID));
> -      l_Status =3D NDIS_STATUS_INVALID_OID;
> -      break;
> -    }
> -
> -  if (l_Status !=3D NDIS_STATUS_SUCCESS)
> -    ;
> -  else if (l_QueryLength > p_BufferLength)
> -    {
> -      l_Status =3D NDIS_STATUS_INVALID_LENGTH;
> -      *p_BytesNeeded =3D l_QueryLength;
> -    }
> -  else
> -    NdisMoveMemory (p_Buffer, (PVOID) l_QueryPtr,
> -                   (*p_BytesWritten =3D l_QueryLength));
> -
> -  return l_Status;
> -}
> -
> -NDIS_STATUS AdapterModify
> -(IN NDIS_HANDLE p_AdapterContext,
> - IN NDIS_OID p_OID,
> - IN PVOID p_Buffer,
> - IN ULONG p_BufferLength,
> - OUT PULONG p_BytesRead,
> - OUT PULONG p_BytesNeeded)
> -{
> -  TapAdapterQueryPointer l_Query =3D (TapAdapterQueryPointer) p_Buffer;
> -  TapAdapterPointer l_Adapter =3D (TapAdapterPointer) p_AdapterContext;
> -  NDIS_STATUS l_Status =3D NDIS_STATUS_INVALID_OID;
> -  ULONG l_Long;
> -
> -  switch (p_OID)
> -    {
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                            Device Info
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case OID_802_3_MULTICAST_LIST:
> -      DEBUGP (("[%s] Setting [OID_802_3_MULTICAST_LIST]\n",
> -              NAME (l_Adapter)));
> -
> -      *p_BytesNeeded =3D sizeof (ETH_ADDR);
> -      *p_BytesRead =3D p_BufferLength;
> -
> -      if (p_BufferLength % sizeof (ETH_ADDR))
> -       l_Status =3D NDIS_STATUS_INVALID_LENGTH;
> -      else if (p_BufferLength > sizeof (MC_LIST))
> -       {
> -         l_Status =3D NDIS_STATUS_MULTICAST_FULL;
> -         *p_BytesNeeded =3D sizeof (MC_LIST);
> -       }
> -      else
> -       {
> -         NdisAcquireSpinLock (&l_Adapter->m_MCLock);
> -
> -         NdisZeroMemory(&l_Adapter->m_MCList, sizeof (MC_LIST));
> -
> -         NdisMoveMemory(&l_Adapter->m_MCList,
> -                        p_Buffer,
> -                        p_BufferLength);
> -
> -         l_Adapter->m_MCListSize =3D p_BufferLength / sizeof (ETH_ADDR);
> -
> -         NdisReleaseSpinLock (&l_Adapter->m_MCLock);
> -
> -         l_Status =3D NDIS_STATUS_SUCCESS;
> -       }
> -      break;
> -
> -    case OID_GEN_CURRENT_PACKET_FILTER:
> -      l_Status =3D NDIS_STATUS_INVALID_LENGTH;
> -      *p_BytesNeeded =3D 4;
> -
> -      if (p_BufferLength >=3D sizeof (ULONG))
> -       {
> -         DEBUGP
> -           (("[%s] Setting [OID_GEN_CURRENT_PACKET_FILTER] to [0x%02lx]\=
n",
> -             NAME (l_Adapter), l_Query->m_Long));
> -         l_Status =3D NDIS_STATUS_SUCCESS;
> -         *p_BytesRead =3D sizeof (ULONG);
> -       }
> -      break;
> -
> -    case OID_GEN_CURRENT_LOOKAHEAD:
> -      if (p_BufferLength < sizeof (ULONG))
> -       {
> -         l_Status =3D NDIS_STATUS_INVALID_LENGTH;
> -         *p_BytesNeeded =3D 4;
> -       }
> -      else if (l_Query->m_Long > DEFAULT_PACKET_LOOKAHEAD
> -              || l_Query->m_Long <=3D 0)
> -       {
> -         l_Status =3D NDIS_STATUS_INVALID_DATA;
> -       }
> -      else
> -       {
> -         DEBUGP (("[%s] Setting [OID_GEN_CURRENT_LOOKAHEAD] to [%d]\n",
> -                  NAME (l_Adapter), l_Query->m_Long));
> -         l_Adapter->m_Lookahead =3D l_Query->m_Long;
> -         l_Status =3D NDIS_STATUS_SUCCESS;
> -         *p_BytesRead =3D sizeof (ULONG);
> -       }
> -      break;
> -
> -    case OID_GEN_NETWORK_LAYER_ADDRESSES:
> -      l_Status =3D NDIS_STATUS_SUCCESS;
> -      *p_BytesRead =3D *p_BytesNeeded =3D 0;
> -      break;
> -
> -    case OID_GEN_TRANSPORT_HEADER_OFFSET:
> -      l_Status =3D NDIS_STATUS_SUCCESS;
> -      *p_BytesRead =3D *p_BytesNeeded =3D 0;
> -      break;
> -
> -    case OID_PNP_SET_POWER:
> -      do
> -       {
> -         NDIS_DEVICE_POWER_STATE NewDeviceState;
> -
> -         NewDeviceState =3D (*(PNDIS_DEVICE_POWER_STATE) p_Buffer);
> -
> -         switch (NewDeviceState)
> -           {
> -           case NdisDeviceStateD0:
> -             l_Adapter->m_DeviceState =3D '0';
> -             break;
> -           case NdisDeviceStateD1:
> -             l_Adapter->m_DeviceState =3D '1';
> -             break;
> -           case NdisDeviceStateD2:
> -             l_Adapter->m_DeviceState =3D '2';
> -             break;
> -           case NdisDeviceStateD3:
> -             l_Adapter->m_DeviceState =3D '3';
> -             break;
> -           default:
> -             l_Adapter->m_DeviceState =3D '?';
> -             break;
> -           }
> -
> -         l_Status =3D NDIS_STATUS_FAILURE;
> -
> -         //
> -         // Check for invalid length
> -         //
> -         if (p_BufferLength < sizeof (NDIS_DEVICE_POWER_STATE))
> -           {
> -             l_Status =3D NDIS_STATUS_INVALID_LENGTH;
> -             break;
> -           }
> -
> -         if (NewDeviceState > NdisDeviceStateD0)
> -           {
> -             l_Adapter->m_InterfaceIsRunning =3D FALSE;
> -             DEBUGP (("[%s] Power management device state OFF\n",
> -                      NAME (l_Adapter)));
> -           }
> -         else
> -           {
> -             l_Adapter->m_InterfaceIsRunning =3D TRUE;
> -             DEBUGP (("[%s] Power management device state ON\n",
> -                      NAME (l_Adapter)));
> -           }
> -
> -         l_Status =3D NDIS_STATUS_SUCCESS;
> -       }
> -      while (FALSE);
> -
> -      if (l_Status =3D=3D NDIS_STATUS_SUCCESS)
> -       {
> -         *p_BytesRead =3D sizeof (NDIS_DEVICE_POWER_STATE);
> -         *p_BytesNeeded =3D 0;
> -       }
> -      else
> -       {
> -         *p_BytesRead =3D 0;
> -         *p_BytesNeeded =3D sizeof (NDIS_DEVICE_POWER_STATE);
> -       }
> -      break;
> -
> -    case OID_PNP_REMOVE_WAKE_UP_PATTERN:
> -    case OID_PNP_ADD_WAKE_UP_PATTERN:
> -      l_Status =3D NDIS_STATUS_SUCCESS;
> -      *p_BytesRead =3D *p_BytesNeeded =3D 0;
> -      break;
> -
> -    default:
> -      DEBUGP (("[%s] Can't set value for OID %lx\n", NAME (l_Adapter),
> -              p_OID));
> -      l_Status =3D NDIS_STATUS_INVALID_OID;
> -      *p_BytesRead =3D *p_BytesNeeded =3D 0;
> -      break;
> -    }
> -
> -  return l_Status;
> -}
> -
> -// checksum code for ICMPv6 packet, taken from dhcp.c / udp_checksum
> -// see RFC 4443, 2.3, and RFC 2460, 8.1
> -USHORT
> -icmpv6_checksum (const UCHAR *buf,
> -                const int len_icmpv6,
> -                const UCHAR *saddr6,
> -                const UCHAR *daddr6)
> -{
> -  USHORT word16;
> -  ULONG sum =3D 0;
> -  int i;
> -
> -  // make 16 bit words out of every two adjacent 8 bit words and
> -  // calculate the sum of all 16 bit words
> -  for (i =3D 0; i < len_icmpv6; i +=3D 2){
> -    word16 =3D ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_icmpv6) ? (buf[i=
+1] & 0xFF) : 0);
> -    sum +=3D word16;
> -  }
> -
> -  // add the IPv6 pseudo header which contains the IP source and destina=
tion addresses
> -  for (i =3D 0; i < 16; i +=3D 2){
> -    word16 =3D((saddr6[i] << 8) & 0xFF00) + (saddr6[i+1] & 0xFF);
> -    sum +=3D word16;
> -  }
> -  for (i =3D 0; i < 16; i +=3D 2){
> -    word16 =3D((daddr6[i] << 8) & 0xFF00) + (daddr6[i+1] & 0xFF);
> -    sum +=3D word16;
> -  }
> -
> -  // the next-header number and the length of the ICMPv6 packet
> -  sum +=3D (USHORT) IPPROTO_ICMPV6 + (USHORT) len_icmpv6;
> -
> -  // keep only the last 16 bits of the 32 bit calculated sum and add the=
 carries
> -  while (sum >> 16)
> -    sum =3D (sum & 0xFFFF) + (sum >> 16);
> -
> -  // Take the one's complement of sum
> -  return ((USHORT) ~sum);
> -}
> -
> -// check IPv6 packet for "is this an IPv6 Neighbor Solicitation that
> -// the tap driver needs to answer?"
> -// see RFC 4861 4.3 for the different cases
> -static IPV6ADDR IPV6_NS_TARGET_MCAST =3D
> -       { 0xff, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -          0x00, 0x00, 0x00, 0x01, 0xff, 0x00, 0x00, 0x08 };
> -static IPV6ADDR IPV6_NS_TARGET_UNICAST =3D
> -       { 0xfe, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08 };
> -
> -BOOLEAN
> -HandleIPv6NeighborDiscovery( TapAdapterPointer p_Adapter, UCHAR * m_Data=
 )
> -{
> -    const ETH_HEADER * e =3D (ETH_HEADER *) m_Data;
> -    const IPV6HDR *ipv6 =3D (IPV6HDR *) (m_Data + sizeof (ETH_HEADER));
> -    const ICMPV6_NS * icmpv6_ns =3D (ICMPV6_NS *) (m_Data + sizeof (ETH_=
HEADER) + sizeof (IPV6HDR));
> -    ICMPV6_NA_PKT *na;
> -    USHORT icmpv6_len, icmpv6_csum;
> -
> -    // we don't really care about the destination MAC address here
> -    // - it's either a multicast MAC, or the userland destination MAC
> -    // but since the TAP driver is point-to-point, all packets are "for =
us"
> -
> -    // IPv6 target address must be ff02::1::ff00:8 (multicast for
> -    // initial NS) or fe80::1 (unicast for recurrent NUD)
> -    if ( memcmp( ipv6->daddr, IPV6_NS_TARGET_MCAST,
> -                sizeof(IPV6ADDR) ) !=3D 0 &&
> -         memcmp( ipv6->daddr, IPV6_NS_TARGET_UNICAST,
> -                sizeof(IPV6ADDR) ) !=3D 0 )
> -    {
> -       return FALSE;                           // wrong target address
> -    }
> -
> -    // IPv6 Next-Header must be ICMPv6
> -    if ( ipv6->nexthdr !=3D IPPROTO_ICMPV6 )
> -    {
> -       return FALSE;                           // wrong next-header
> -    }
> -
> -    // ICMPv6 type+code must be 135/0 for NS
> -    if ( icmpv6_ns->type !=3D ICMPV6_TYPE_NS ||
> -        icmpv6_ns->code !=3D ICMPV6_CODE_0 )
> -    {
> -       return FALSE;                           // wrong ICMPv6 type
> -    }
> -
> -    // ICMPv6 target address must be fe80::8 (magic)
> -    if ( memcmp( icmpv6_ns->target_addr, IPV6_NS_TARGET_UNICAST,
> -                sizeof(IPV6ADDR) ) !=3D 0 )
> -    {
> -       return FALSE;                           // not for us
> -    }
> -
> -    // packet identified, build magic response packet
> -
> -    na =3D (ICMPV6_NA_PKT *) MemAlloc (sizeof (ICMPV6_NA_PKT), TRUE);
> -    if ( !na ) return FALSE;
> -
> -    //------------------------------------------------
> -    // Initialize Neighbour Advertisement reply packet
> -    //------------------------------------------------
> -
> -    // ethernet header
> -    na->eth.proto =3D htons(ETH_P_IPV6);
> -    COPY_MAC(na->eth.dest, p_Adapter->m_MAC);
> -    COPY_MAC(na->eth.src, p_Adapter->m_TapToUser.dest);
> -
> -    // IPv6 header
> -    na->ipv6.version_prio =3D ipv6->version_prio;
> -    NdisMoveMemory( na->ipv6.flow_lbl, ipv6->flow_lbl,
> -                   sizeof(na->ipv6.flow_lbl) );
> -    icmpv6_len =3D sizeof(ICMPV6_NA_PKT) - sizeof(ETH_HEADER) - sizeof(I=
PV6HDR);
> -    na->ipv6.payload_len =3D htons(icmpv6_len);
> -    na->ipv6.nexthdr =3D IPPROTO_ICMPV6;
> -    na->ipv6.hop_limit =3D 255;
> -    NdisMoveMemory( na->ipv6.saddr, IPV6_NS_TARGET_UNICAST,
> -                   sizeof(IPV6ADDR) );
> -    NdisMoveMemory( na->ipv6.daddr, ipv6->saddr,
> -                   sizeof(IPV6ADDR) );
> -
> -    // ICMPv6
> -    na->icmpv6.type =3D ICMPV6_TYPE_NA;
> -    na->icmpv6.code =3D ICMPV6_CODE_0;
> -    na->icmpv6.checksum =3D 0;
> -    na->icmpv6.rso_bits =3D 0x60;                // Solicited + Override
> -    NdisZeroMemory( na->icmpv6.reserved, sizeof(na->icmpv6.reserved) );
> -    NdisMoveMemory( na->icmpv6.target_addr, IPV6_NS_TARGET_UNICAST,
> -                   sizeof(IPV6ADDR) );
> -
> -    // ICMPv6 option "Target Link Layer Address"
> -    na->icmpv6.opt_type =3D ICMPV6_OPTION_TLLA;
> -    na->icmpv6.opt_length =3D ICMPV6_LENGTH_TLLA;
> -    COPY_MAC( na->icmpv6.target_macaddr, p_Adapter->m_TapToUser.dest );
> -
> -    // calculate and set checksum
> -    icmpv6_csum =3D icmpv6_checksum ( (UCHAR*) &(na->icmpv6),
> -                                   icmpv6_len,
> -                                   na->ipv6.saddr,
> -                                   na->ipv6.daddr );
> -    na->icmpv6.checksum =3D htons( icmpv6_csum );
> -
> -    DUMP_PACKET ("HandleIPv6NeighborDiscovery",
> -                (unsigned char *) na,
> -                sizeof (ICMPV6_NA_PKT));
> -
> -    InjectPacketDeferred (p_Adapter, (UCHAR *) na, sizeof (ICMPV6_NA_PKT=
));
> -
> -    MemFree (na, sizeof (ICMPV6_NA_PKT));
> -
> -    return TRUE;                               // all fine
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                               Adapter Transmission
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -NDIS_STATUS
> -AdapterTransmit (IN NDIS_HANDLE p_AdapterContext,
> -                IN PNDIS_PACKET p_Packet,
> -                IN UINT p_Flags)
> -{
> -  TapAdapterPointer l_Adapter =3D (TapAdapterPointer) p_AdapterContext;
> -  ULONG l_Index =3D 0, l_PacketLength =3D 0;
> -  UINT l_BufferLength =3D 0;
> -  PIRP l_IRP;
> -  TapPacketPointer l_PacketBuffer;
> -  PNDIS_BUFFER l_NDIS_Buffer;
> -  PUCHAR l_Buffer;
> -  PVOID result;
> -
> -  NdisQueryPacket (p_Packet, NULL, NULL, &l_NDIS_Buffer, &l_PacketLength=
);
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -  // Here we abandon the transmission attempt if any of
> -  // the parameters is wrong or memory allocation fails
> -  // but we do not indicate failure. The packet is
> -  // silently dropped.
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -
> -  if (l_PacketLength < ETHERNET_HEADER_SIZE || l_PacketLength > 65535)
> -    goto exit_fail;
> -  else if (!l_Adapter->m_Extension.m_TapOpens || !l_Adapter->m_MediaStat=
e)
> -    goto exit_success;              // Nothing is bound to the TAP device
> -
> -  if (NdisAllocateMemoryWithTag (&l_PacketBuffer,
> -                                TAP_PACKET_SIZE (l_PacketLength),
> -                                '5PAT') !=3D NDIS_STATUS_SUCCESS)
> -    goto exit_no_resources;
> -
> -  if (l_PacketBuffer =3D=3D NULL)
> -    goto exit_no_resources;
> -
> -  l_PacketBuffer->m_SizeFlags =3D (l_PacketLength & TP_SIZE_MASK);
> -
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -  // Reassemble packet contents
> -  //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -
> -  __try
> -  {
> -    l_Index =3D 0;
> -    while (l_NDIS_Buffer && l_Index < l_PacketLength)
> -      {
> -       ULONG newlen;
> -       NdisQueryBuffer (l_NDIS_Buffer, (PVOID *) & l_Buffer,
> -                        &l_BufferLength);
> -       newlen =3D l_Index + l_BufferLength;
> -       if (newlen > l_PacketLength)
> -         {
> -           NOTE_ERROR ();
> -           goto no_queue; /* overflow */
> -         }
> -       NdisMoveMemory (l_PacketBuffer->m_Data + l_Index, l_Buffer,
> -                       l_BufferLength);
> -       l_Index =3D newlen;
> -       NdisGetNextBuffer (l_NDIS_Buffer, &l_NDIS_Buffer);
> -      }
> -    if (l_Index !=3D l_PacketLength)
> -      {
> -       NOTE_ERROR ();
> -       goto no_queue; /* underflow */
> -      }
> -
> -    DUMP_PACKET ("AdapterTransmit", l_PacketBuffer->m_Data, l_PacketLeng=
th);
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -    // If IPv4 packet, check whether or not packet
> -    // was truncated.
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -#if PACKET_TRUNCATION_CHECK
> -    IPv4PacketSizeVerify (l_PacketBuffer->m_Data, l_PacketLength, FALSE,=
 "TX", &l_Adapter->m_TxTrunc);
> -#endif
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -    // Are we running in DHCP server masquerade mode?
> -    //
> -    // If so, catch both DHCP requests and ARP queries
> -    // to resolve the address of our virtual DHCP server.
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -    if (l_Adapter->m_dhcp_enabled)
> -      {
> -       const ETH_HEADER *eth =3D (ETH_HEADER *) l_PacketBuffer->m_Data;
> -       const IPHDR *ip =3D (IPHDR *) (l_PacketBuffer->m_Data + sizeof (E=
TH_HEADER));
> -       const UDPHDR *udp =3D (UDPHDR *) (l_PacketBuffer->m_Data + sizeof=
 (ETH_HEADER) + sizeof (IPHDR));
> -
> -       // ARP packet?
> -       if (l_PacketLength =3D=3D sizeof (ARP_PACKET)
> -           && eth->proto =3D=3D htons (ETH_P_ARP)
> -           && l_Adapter->m_dhcp_server_arp)
> -         {
> -           if (ProcessARP (l_Adapter,
> -                           (PARP_PACKET) l_PacketBuffer->m_Data,
> -                           l_Adapter->m_dhcp_addr,
> -                           l_Adapter->m_dhcp_server_ip,
> -                           ~0,
> -                           l_Adapter->m_dhcp_server_mac))
> -             goto no_queue;
> -         }
> -
> -       // DHCP packet?
> -       else if (l_PacketLength >=3D sizeof (ETH_HEADER) + sizeof (IPHDR)=
 + sizeof (UDPHDR) + sizeof (DHCP)
> -                && eth->proto =3D=3D htons (ETH_P_IP)
> -                && ip->version_len =3D=3D 0x45 // IPv4, 20 byte header
> -                && ip->protocol =3D=3D IPPROTO_UDP
> -                && udp->dest =3D=3D htons (BOOTPS_PORT))
> -         {
> -           const DHCP *dhcp =3D (DHCP *) (l_PacketBuffer->m_Data
> -                                        + sizeof (ETH_HEADER)
> -                                        + sizeof (IPHDR)
> -                                        + sizeof (UDPHDR));
> -
> -           const int optlen =3D l_PacketLength
> -             - sizeof (ETH_HEADER)
> -             - sizeof (IPHDR)
> -             - sizeof (UDPHDR)
> -             - sizeof (DHCP);
> -
> -           if (optlen > 0) // we must have at least one DHCP option
> -             {
> -               if (ProcessDHCP (l_Adapter, eth, ip, udp, dhcp, optlen))
> -                 goto no_queue;
> -             }
> -           else
> -             goto no_queue;
> -         }
> -      }
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    // In Point-To-Point mode, check to see whether
> -    // packet is ARP (handled) or IPv4 (sent to app).
> -    // IPv6 packets are inspected for neighbour discovery
> -    // (to be handled locally), and the rest is forwarded
> -    // all other protocols are dropped
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    if (l_Adapter->m_tun)
> -      {
> -       ETH_HEADER *e;
> -
> -       if (l_PacketLength < ETHERNET_HEADER_SIZE)
> -         goto no_queue;
> -
> -       e =3D (ETH_HEADER *) l_PacketBuffer->m_Data;
> -
> -       switch (ntohs (e->proto))
> -         {
> -         case ETH_P_ARP:
> -
> -           // Make sure that packet is the
> -           // right size for ARP.
> -           if (l_PacketLength !=3D sizeof (ARP_PACKET))
> -             goto no_queue;
> -
> -           ProcessARP (l_Adapter,
> -                       (PARP_PACKET) l_PacketBuffer->m_Data,
> -                       l_Adapter->m_localIP,
> -                       l_Adapter->m_remoteNetwork,
> -                       l_Adapter->m_remoteNetmask,
> -                       l_Adapter->m_TapToUser.dest);
> -
> -         default:
> -           goto no_queue;
> -
> -         case ETH_P_IP:
> -
> -           // Make sure that packet is large
> -           // enough to be IPv4.
> -           if (l_PacketLength
> -               < ETHERNET_HEADER_SIZE + IP_HEADER_SIZE)
> -             goto no_queue;
> -
> -           // Only accept directed packets,
> -           // not broadcasts.
> -           if (memcmp (e, &l_Adapter->m_TapToUser, ETHERNET_HEADER_SIZE))
> -             goto no_queue;
> -
> -           // Packet looks like IPv4, queue it.
> -           l_PacketBuffer->m_SizeFlags |=3D TP_TUN;
> -           break;
> -
> -         case ETH_P_IPV6:
> -           // make sure that packet is large
> -           // enough to be IPv6
> -           if (l_PacketLength
> -               < ETHERNET_HEADER_SIZE + IPV6_HEADER_SIZE)
> -             goto no_queue;
> -
> -           // broadcasts and multicasts are handled specially
> -           // (to be implemented)
> -
> -           // neighbor discovery packets to fe80::8 are special
> -           // OpenVPN sets this next-hop to signal "handled by tapdrv"
> -           if ( HandleIPv6NeighborDiscovery( l_Adapter,
> -                                             l_PacketBuffer->m_Data ))
> -             {
> -               goto no_queue;
> -             }
> -
> -           // Packet looks like IPv6, queue it :-)
> -           l_PacketBuffer->m_SizeFlags |=3D TP_TUN;
> -         }
> -      }
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    // Push packet onto queue to wait for read from
> -    // userspace.
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -    NdisAcquireSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -    result =3D NULL;
> -    if (IS_UP (l_Adapter))
> -      result =3D QueuePush (l_Adapter->m_Extension.m_PacketQueue, l_Pack=
etBuffer);
> -
> -    NdisReleaseSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -    if ((TapPacketPointer) result !=3D l_PacketBuffer)
> -      {
> -       // adapter receive overrun
> -       INCREMENT_STAT (l_Adapter->m_TxErr);
> -       goto no_queue;
> -      }
> -    else
> -      {
> -       INCREMENT_STAT (l_Adapter->m_Tx);
> -      }
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    // Cycle through IRPs and packets, try to satisfy each pending
> -    // IRP with a queued packet.
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    while (TRUE)
> -      {
> -       l_IRP =3D NULL;
> -       l_PacketBuffer =3D NULL;
> -
> -       NdisAcquireSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -       if (IS_UP (l_Adapter)
> -           && QueueCount (l_Adapter->m_Extension.m_PacketQueue)
> -           && QueueCount (l_Adapter->m_Extension.m_IrpQueue))
> -         {
> -           l_IRP =3D (PIRP) QueuePop (l_Adapter->m_Extension.m_IrpQueue);
> -           l_PacketBuffer =3D (TapPacketPointer)
> -             QueuePop (l_Adapter->m_Extension.m_PacketQueue);
> -         }
> -
> -       NdisReleaseSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -       MYASSERT ((l_IRP !=3D NULL) + (l_PacketBuffer !=3D NULL) !=3D 1);
> -
> -       if (l_IRP && l_PacketBuffer)
> -         {
> -           CompleteIRP (l_IRP,
> -                        l_PacketBuffer,
> -                        IO_NETWORK_INCREMENT);
> -         }
> -       else
> -         break;
> -      }
> -  }
> -  __except (EXCEPTION_EXECUTE_HANDLER)
> -    {
> -    }
> -
> -  return NDIS_STATUS_SUCCESS;
> -
> - no_queue:
> -  NdisFreeMemory (l_PacketBuffer,
> -                 TAP_PACKET_SIZE (l_PacketLength),
> -                 0);
> -
> - exit_success:
> -  return NDIS_STATUS_SUCCESS;
> -
> - exit_fail:
> -  return NDIS_STATUS_FAILURE;
> -
> - exit_no_resources:
> -  return NDIS_STATUS_RESOURCES;
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Hooks for catching TAP device IRP's.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -NTSTATUS
> -TapDeviceHook (IN PDEVICE_OBJECT p_DeviceObject, IN PIRP p_IRP)
> -{
> -  TapAdapterPointer l_Adapter =3D LookupAdapterInInstanceList (p_DeviceO=
bject);
> -  PIO_STACK_LOCATION l_IrpSp;
> -  NTSTATUS l_Status =3D STATUS_SUCCESS;
> -  BOOLEAN accessible;
> -
> -  l_IrpSp =3D IoGetCurrentIrpStackLocation (p_IRP);
> -
> -  p_IRP->IoStatus.Status =3D STATUS_SUCCESS;
> -  p_IRP->IoStatus.Information =3D 0;
> -
> -  if (!l_Adapter || l_Adapter->m_Extension.m_Halt)
> -    {
> -      DEBUGP (("TapDeviceHook called when TAP device is halted, MajorFun=
ction=3D%d\n",
> -              (int)l_IrpSp->MajorFunction));
> -
> -      if (l_IrpSp->MajorFunction =3D=3D IRP_MJ_CLOSE)
> -       {
> -         IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -         return STATUS_SUCCESS;
> -       }
> -      else
> -       {
> -         p_IRP->IoStatus.Status =3D STATUS_NO_SUCH_DEVICE;
> -         IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -         return STATUS_NO_SUCH_DEVICE;
> -       }
> -    }
> -
> -  switch (l_IrpSp->MajorFunction)
> -    {
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      //                 Ioctl call handlers
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case IRP_MJ_DEVICE_CONTROL:
> -      {
> -       switch (l_IrpSp->Parameters.DeviceIoControl.IoControlCode)
> -         {
> -         case TAP_IOCTL_GET_MAC:
> -           {
> -             if (l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength
> -                 >=3D sizeof (MACADDR))
> -               {
> -                 COPY_MAC (p_IRP->AssociatedIrp.SystemBuffer,
> -                           l_Adapter->m_MAC);
> -                 p_IRP->IoStatus.Information =3D sizeof (MACADDR);
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_BUFFER_T=
OO_SMALL;
> -               }
> -             break;
> -           }
> -         case TAP_IOCTL_GET_VERSION:
> -           {
> -             const ULONG size =3D sizeof (ULONG) * 3;
> -             if (l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength
> -                 >=3D size)
> -               {
> -                 ((PULONG) (p_IRP->AssociatedIrp.SystemBuffer))[0]
> -                   =3D TAP_DRIVER_MAJOR_VERSION;
> -                 ((PULONG) (p_IRP->AssociatedIrp.SystemBuffer))[1]
> -                   =3D TAP_DRIVER_MINOR_VERSION;
> -                 ((PULONG) (p_IRP->AssociatedIrp.SystemBuffer))[2]
> -#if DBG
> -                   =3D 1;
> -#else
> -                 =3D 0;
> -#endif
> -                 p_IRP->IoStatus.Information =3D size;
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_BUFFER_T=
OO_SMALL;
> -               }
> -
> -             break;
> -           }
> -         case TAP_IOCTL_GET_MTU:
> -           {
> -             const ULONG size =3D sizeof (ULONG) * 1;
> -             if (l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength
> -                 >=3D size)
> -               {
> -                 ((PULONG) (p_IRP->AssociatedIrp.SystemBuffer))[0]
> -                   =3D l_Adapter->m_MTU;
> -                 p_IRP->IoStatus.Information =3D size;
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_BUFFER_T=
OO_SMALL;
> -               }
> -
> -             break;
> -           }
> -         case TAP_IOCTL_GET_INFO:
> -           {
> -             char state[16];
> -             if (l_Adapter->m_InterfaceIsRunning)
> -               state[0] =3D 'A';
> -             else
> -               state[0] =3D 'a';
> -             if (l_Adapter->m_Extension.m_TapIsRunning)
> -               state[1] =3D 'T';
> -             else
> -               state[1] =3D 't';
> -             state[2] =3D l_Adapter->m_DeviceState;
> -             if (l_Adapter->m_MediaStateAlwaysConnected)
> -               state[3] =3D 'C';
> -             else
> -               state[3] =3D 'c';
> -             state[4] =3D '\0';
> -
> -             p_IRP->IoStatus.Status =3D l_Status =3D RtlStringCchPrintfE=
xA (
> -               ((LPTSTR) (p_IRP->AssociatedIrp.SystemBuffer)),
> -               l_IrpSp->Parameters.DeviceIoControl.OutputBufferLength,
> -               NULL,
> -               NULL,
> -               STRSAFE_FILL_BEHIND_NULL | STRSAFE_IGNORE_NULLS,
> -#if PACKET_TRUNCATION_CHECK
> -               "State=3D%s Err=3D[%s/%d] #O=3D%d Tx=3D[%d,%d,%d] Rx=3D[%=
d,%d,%d] IrpQ=3D[%d,%d,%d] PktQ=3D[%d,%d,%d] InjQ=3D[%d,%d,%d]",
> -#else
> -               "State=3D%s Err=3D[%s/%d] #O=3D%d Tx=3D[%d,%d] Rx=3D[%d,%=
d] IrpQ=3D[%d,%d,%d] PktQ=3D[%d,%d,%d] InjQ=3D[%d,%d,%d]",
> -#endif
> -               state,
> -               g_LastErrorFilename,
> -               g_LastErrorLineNumber,
> -               (int)l_Adapter->m_Extension.m_NumTapOpens,
> -               (int)l_Adapter->m_Tx,
> -               (int)l_Adapter->m_TxErr,
> -#if PACKET_TRUNCATION_CHECK
> -               (int)l_Adapter->m_TxTrunc,
> -#endif
> -               (int)l_Adapter->m_Rx,
> -               (int)l_Adapter->m_RxErr,
> -#if PACKET_TRUNCATION_CHECK
> -               (int)l_Adapter->m_RxTrunc,
> -#endif
> -               (int)l_Adapter->m_Extension.m_IrpQueue->size,
> -               (int)l_Adapter->m_Extension.m_IrpQueue->max_size,
> -               (int)IRP_QUEUE_SIZE,
> -               (int)l_Adapter->m_Extension.m_PacketQueue->size,
> -               (int)l_Adapter->m_Extension.m_PacketQueue->max_size,
> -               (int)PACKET_QUEUE_SIZE,
> -               (int)l_Adapter->m_Extension.m_InjectQueue->size,
> -               (int)l_Adapter->m_Extension.m_InjectQueue->max_size,
> -               (int)INJECT_QUEUE_SIZE
> -               );
> -
> -             p_IRP->IoStatus.Information
> -               =3D l_IrpSp->Parameters.DeviceIoControl.OutputBufferLengt=
h;
> -
> -             break;
> -           }
> -
> -#if DBG
> -         case TAP_IOCTL_GET_LOG_LINE:
> -           {
> -             if (GetDebugLine ((LPTSTR)p_IRP->AssociatedIrp.SystemBuffer,
> -                               l_IrpSp->Parameters.DeviceIoControl.Outpu=
tBufferLength))
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_SUCCESS;
> -             else
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSF=
UL;
> -
> -             p_IRP->IoStatus.Information
> -               =3D l_IrpSp->Parameters.DeviceIoControl.OutputBufferLengt=
h;
> -
> -             break;
> -           }
> -#endif
> -
> -         case TAP_IOCTL_CONFIG_TUN:
> -           {
> -             if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
=3D
> -                 (sizeof (IPADDR) * 3))
> -               {
> -                 MACADDR dest;
> -
> -                 l_Adapter->m_tun =3D FALSE;
> -
> -                 GenerateRelatedMAC (dest, l_Adapter->m_MAC, 1);
> -
> -                 l_Adapter->m_localIP =3D       ((IPADDR*) (p_IRP->Assoc=
iatedIrp.SystemBuffer))[0];
> -                 l_Adapter->m_remoteNetwork =3D ((IPADDR*) (p_IRP->Assoc=
iatedIrp.SystemBuffer))[1];
> -                 l_Adapter->m_remoteNetmask =3D ((IPADDR*) (p_IRP->Assoc=
iatedIrp.SystemBuffer))[2];
> -
> -                 // sanity check on network/netmask
> -                 if ((l_Adapter->m_remoteNetwork & l_Adapter->m_remoteNe=
tmask) !=3D l_Adapter->m_remoteNetwork)
> -                   {
> -                     NOTE_ERROR ();
> -                     p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVA=
LID_PARAMETER;
> -                     break;
> -                   }
> -
> -                 COPY_MAC (l_Adapter->m_TapToUser.src, l_Adapter->m_MAC);
> -                 COPY_MAC (l_Adapter->m_TapToUser.dest, dest);
> -                 COPY_MAC (l_Adapter->m_UserToTap.src, dest);
> -                 COPY_MAC (l_Adapter->m_UserToTap.dest, l_Adapter->m_MAC=
);
> -
> -                 l_Adapter->m_TapToUser.proto =3D l_Adapter->m_UserToTap=
.proto =3D htons (ETH_P_IP);
> -                 l_Adapter->m_UserToTap_IPv6 =3D l_Adapter->m_UserToTap;
> -                 l_Adapter->m_UserToTap_IPv6.proto =3D htons(ETH_P_IPV6);
> -
> -                 l_Adapter->m_tun =3D TRUE;
> -
> -                 CheckIfDhcpAndTunMode (l_Adapter);
> -
> -                 p_IRP->IoStatus.Information =3D 1; // Simple boolean va=
lue
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_=
PARAMETER;
> -               }
> -
> -             break;
> -           }
> -
> -         case TAP_IOCTL_CONFIG_POINT_TO_POINT: // Obsoleted by TAP_IOCTL=
_CONFIG_TUN
> -           {
> -             if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
=3D
> -                 (sizeof (IPADDR) * 2))
> -               {
> -                 MACADDR dest;
> -
> -                 l_Adapter->m_tun =3D FALSE;
> -
> -                 GenerateRelatedMAC (dest, l_Adapter->m_MAC, 1);
> -
> -                 l_Adapter->m_localIP =3D       ((IPADDR*) (p_IRP->Assoc=
iatedIrp.SystemBuffer))[0];
> -                 l_Adapter->m_remoteNetwork =3D ((IPADDR*) (p_IRP->Assoc=
iatedIrp.SystemBuffer))[1];
> -                 l_Adapter->m_remoteNetmask =3D ~0;
> -
> -                 COPY_MAC (l_Adapter->m_TapToUser.src, l_Adapter->m_MAC);
> -                 COPY_MAC (l_Adapter->m_TapToUser.dest, dest);
> -                 COPY_MAC (l_Adapter->m_UserToTap.src, dest);
> -                 COPY_MAC (l_Adapter->m_UserToTap.dest, l_Adapter->m_MAC=
);
> -
> -                 l_Adapter->m_TapToUser.proto =3D l_Adapter->m_UserToTap=
.proto =3D htons (ETH_P_IP);
> -                 l_Adapter->m_UserToTap_IPv6 =3D l_Adapter->m_UserToTap;
> -                 l_Adapter->m_UserToTap_IPv6.proto =3D htons(ETH_P_IPV6);
> -
> -                 l_Adapter->m_tun =3D TRUE;
> -
> -                 CheckIfDhcpAndTunMode (l_Adapter);
> -
> -                 p_IRP->IoStatus.Information =3D 1; // Simple boolean va=
lue
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_=
PARAMETER;
> -               }
> -
> -             break;
> -           }
> -
> -         case TAP_IOCTL_SET_MEDIA_STATUS:
> -           {
> -             if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
=3D
> -                 (sizeof (ULONG) * 1))
> -               {
> -                 ULONG parm =3D ((PULONG) (p_IRP->AssociatedIrp.SystemBu=
ffer))[0];
> -                 SetMediaStatus (l_Adapter, (BOOLEAN) parm);
> -                 p_IRP->IoStatus.Information =3D 1;
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_=
PARAMETER;
> -               }
> -             break;
> -           }
> -
> -         case TAP_IOCTL_CONFIG_DHCP_MASQ:
> -           {
> -             if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength >=
=3D
> -                 (sizeof (IPADDR) * 4))
> -               {
> -                 l_Adapter->m_dhcp_enabled =3D FALSE;
> -                 l_Adapter->m_dhcp_server_arp =3D FALSE;
> -                 l_Adapter->m_dhcp_user_supplied_options_buffer_len =3D =
0;
> -
> -                 // Adapter IP addr / netmask
> -                 l_Adapter->m_dhcp_addr =3D
> -                   ((IPADDR*) (p_IRP->AssociatedIrp.SystemBuffer))[0];
> -                 l_Adapter->m_dhcp_netmask =3D
> -                   ((IPADDR*) (p_IRP->AssociatedIrp.SystemBuffer))[1];
> -
> -                 // IP addr of DHCP masq server
> -                 l_Adapter->m_dhcp_server_ip =3D
> -                   ((IPADDR*) (p_IRP->AssociatedIrp.SystemBuffer))[2];
> -
> -                 // Lease time in seconds
> -                 l_Adapter->m_dhcp_lease_time =3D
> -                   ((IPADDR*) (p_IRP->AssociatedIrp.SystemBuffer))[3];
> -
> -                 GenerateRelatedMAC (l_Adapter->m_dhcp_server_mac, l_Ada=
pter->m_MAC, 2);
> -
> -                 l_Adapter->m_dhcp_enabled =3D TRUE;
> -                 l_Adapter->m_dhcp_server_arp =3D TRUE;
> -
> -                 CheckIfDhcpAndTunMode (l_Adapter);
> -
> -                 p_IRP->IoStatus.Information =3D 1; // Simple boolean va=
lue
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_=
PARAMETER;
> -               }
> -
> -             break;
> -           }
> -
> -         case TAP_IOCTL_CONFIG_DHCP_SET_OPT:
> -           {
> -             if (l_IrpSp->Parameters.DeviceIoControl.InputBufferLength <=
=3D
> -                 DHCP_USER_SUPPLIED_OPTIONS_BUFFER_SIZE
> -                 && l_Adapter->m_dhcp_enabled)
> -               {
> -                 l_Adapter->m_dhcp_user_supplied_options_buffer_len =3D =
0;
> -
> -                 NdisMoveMemory (l_Adapter->m_dhcp_user_supplied_options=
_buffer,
> -                                 p_IRP->AssociatedIrp.SystemBuffer,
> -                                 l_IrpSp->Parameters.DeviceIoControl.Inp=
utBufferLength);
> -
> -                 l_Adapter->m_dhcp_user_supplied_options_buffer_len =3D
> -                   l_IrpSp->Parameters.DeviceIoControl.InputBufferLength;
> -
> -                 p_IRP->IoStatus.Information =3D 1; // Simple boolean va=
lue
> -               }
> -             else
> -               {
> -                 NOTE_ERROR ();
> -                 p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_=
PARAMETER;
> -               }
> -
> -             break;
> -           }
> -
> -         default:
> -           {
> -             NOTE_ERROR ();
> -             p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_PARA=
METER;
> -             break;
> -           }
> -         }
> -
> -       IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -       break;
> -      }
> -
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      // User mode thread issued a read request on the tap device
> -      // If there are packets waiting to be read, then the request
> -      // will be satisfied here. If not, then the request will be
> -      // queued and satisfied by any packet that is not used to
> -      // satisfy requests ahead of it.
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case IRP_MJ_READ:
> -      {
> -       TapPacketPointer l_PacketBuffer;
> -       BOOLEAN pending =3D FALSE;
> -
> -       // Save IRP-accessible copy of buffer length
> -       p_IRP->IoStatus.Information =3D l_IrpSp->Parameters.Read.Length;
> -
> -       if (p_IRP->MdlAddress =3D=3D NULL)
> -         {
> -           DEBUGP (("[%s] MdlAddress is NULL for IRP_MJ_READ\n",
> -                    NAME (l_Adapter)));
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_PARAME=
TER;
> -           p_IRP->IoStatus.Information =3D 0;
> -           IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -           break;
> -         }
> -       else if ((p_IRP->AssociatedIrp.SystemBuffer =3D
> -                 MmGetSystemAddressForMdlSafe
> -                 (p_IRP->MdlAddress, NormalPagePriority)) =3D=3D NULL)
> -         {
> -           DEBUGP (("[%s] Could not map address in IRP_MJ_READ\n",
> -                    NAME (l_Adapter)));
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INSUFFICIENT_R=
ESOURCES;
> -           p_IRP->IoStatus.Information =3D 0;
> -           IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -           break;
> -         }
> -       else if (!l_Adapter->m_InterfaceIsRunning)
> -         {
> -           DEBUGP (("[%s] Interface is down in IRP_MJ_READ\n",
> -                    NAME (l_Adapter)));
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSFUL;
> -           p_IRP->IoStatus.Information =3D 0;
> -           IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -           break;
> -         }
> -
> -       //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -       // Can we provide immediate service?
> -       //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -       l_PacketBuffer =3D NULL;
> -
> -       NdisAcquireSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -       if (IS_UP (l_Adapter)
> -           && QueueCount (l_Adapter->m_Extension.m_PacketQueue)
> -           && QueueCount (l_Adapter->m_Extension.m_IrpQueue) =3D=3D 0)
> -         {
> -           l_PacketBuffer =3D (TapPacketPointer)
> -             QueuePop (l_Adapter->m_Extension.m_PacketQueue);
> -         }
> -
> -       NdisReleaseSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -       if (l_PacketBuffer)
> -         {
> -           l_Status =3D CompleteIRP (p_IRP,
> -                                   l_PacketBuffer,
> -                                   IO_NO_INCREMENT);
> -           break;
> -         }
> -
> -       //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -       // Attempt to pend read request
> -       //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -       NdisAcquireSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -       if (IS_UP (l_Adapter)
> -           && QueuePush (l_Adapter->m_Extension.m_IrpQueue, p_IRP) =3D=
=3D (PIRP) p_IRP)
> -         {
> -           IoSetCancelRoutine (p_IRP, CancelIRPCallback);
> -           l_Status =3D STATUS_PENDING;
> -           IoMarkIrpPending (p_IRP);
> -           pending =3D TRUE;
> -         }
> -
> -       NdisReleaseSpinLock (&l_Adapter->m_Extension.m_QueueLock);
> -
> -       if (pending)
> -         break;
> -
> -       // Can't queue anymore IRP's
> -       DEBUGP (("[%s] TAP [%s] read IRP overrun\n",
> -                NAME (l_Adapter), l_Adapter->m_Extension.m_TapName));
> -       NOTE_ERROR ();
> -       p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSFUL;
> -       p_IRP->IoStatus.Information =3D 0;
> -       IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -       break;
> -      }
> -
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -      // User mode issued a WriteFile request on the TAP file handle.
> -      // The request will always get satisfied here.  The call may
> -      // fail if there are too many pending packets (queue full).
> -      //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -    case IRP_MJ_WRITE:
> -      {
> -       if (p_IRP->MdlAddress =3D=3D NULL)
> -         {
> -           DEBUGP (("[%s] MdlAddress is NULL for IRP_MJ_WRITE\n",
> -                    NAME (l_Adapter)));
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INVALID_PARAME=
TER;
> -           p_IRP->IoStatus.Information =3D 0;
> -         }
> -       else if ((p_IRP->AssociatedIrp.SystemBuffer =3D
> -                 MmGetSystemAddressForMdlSafe
> -                 (p_IRP->MdlAddress, NormalPagePriority)) =3D=3D NULL)
> -         {
> -           DEBUGP (("[%s] Could not map address in IRP_MJ_WRITE\n",
> -                    NAME (l_Adapter)));
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_INSUFFICIENT_R=
ESOURCES;
> -           p_IRP->IoStatus.Information =3D 0;
> -         }
> -       else if (!l_Adapter->m_InterfaceIsRunning)
> -         {
> -           DEBUGP (("[%s] Interface is down in IRP_MJ_WRITE\n",
> -                    NAME (l_Adapter)));
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSFUL;
> -           p_IRP->IoStatus.Information =3D 0;
> -         }
> -       else if (!l_Adapter->m_tun && ((l_IrpSp->Parameters.Write.Length)=
 >=3D ETHERNET_HEADER_SIZE))
> -         {
> -           __try
> -             {
> -               p_IRP->IoStatus.Information =3D l_IrpSp->Parameters.Write=
.Length;
> -
> -               DUMP_PACKET ("IRP_MJ_WRITE ETH",
> -                            (unsigned char *) p_IRP->AssociatedIrp.Syste=
mBuffer,
> -                            l_IrpSp->Parameters.Write.Length);
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -    // If IPv4 packet, check whether or not packet
> -    // was truncated.
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -#if PACKET_TRUNCATION_CHECK
> -               IPv4PacketSizeVerify ((unsigned char *) p_IRP->Associated=
Irp.SystemBuffer,
> -                                     l_IrpSp->Parameters.Write.Length,
> -                                     FALSE,
> -                                     "RX",
> -                                     &l_Adapter->m_RxTrunc);
> -#endif
> -
> -               NdisMEthIndicateReceive
> -                 (l_Adapter->m_MiniportAdapterHandle,
> -                  (NDIS_HANDLE) l_Adapter,
> -                  (unsigned char *) p_IRP->AssociatedIrp.SystemBuffer,
> -                  ETHERNET_HEADER_SIZE,
> -                  (unsigned char *) p_IRP->AssociatedIrp.SystemBuffer + =
ETHERNET_HEADER_SIZE,
> -                  l_IrpSp->Parameters.Write.Length - ETHERNET_HEADER_SIZ=
E,
> -                  l_IrpSp->Parameters.Write.Length - ETHERNET_HEADER_SIZ=
E);
> -
> -               NdisMEthIndicateReceiveComplete (l_Adapter->m_MiniportAda=
pterHandle);
> -
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_SUCCESS;
> -             }
> -           __except (EXCEPTION_EXECUTE_HANDLER)
> -             {
> -               DEBUGP (("[%s] NdisMEthIndicateReceive failed in IRP_MJ_W=
RITE\n",
> -                        NAME (l_Adapter)));
> -               NOTE_ERROR ();
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSF=
UL;
> -               p_IRP->IoStatus.Information =3D 0;
> -             }
> -         }
> -       else if (l_Adapter->m_tun && ((l_IrpSp->Parameters.Write.Length) =
>=3D IP_HEADER_SIZE))
> -         {
> -           __try
> -             {
> -               ETH_HEADER * p_UserToTap =3D &l_Adapter->m_UserToTap;
> -
> -               // for IPv6, need to use ethernet header with IPv6 proto
> -               if ( IPH_GET_VER( ((IPHDR*) p_IRP->AssociatedIrp.SystemBu=
ffer)->version_len) =3D=3D 6 )
> -                 {
> -                   p_UserToTap =3D &l_Adapter->m_UserToTap_IPv6;
> -                 }
> -
> -               p_IRP->IoStatus.Information =3D l_IrpSp->Parameters.Write=
.Length;
> -
> -               DUMP_PACKET2 ("IRP_MJ_WRITE P2P",
> -                             p_UserToTap,
> -                             (unsigned char *) p_IRP->AssociatedIrp.Syst=
emBuffer,
> -                             l_IrpSp->Parameters.Write.Length);
> -
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -    // If IPv4 packet, check whether or not packet
> -    // was truncated.
> -    //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -#if PACKET_TRUNCATION_CHECK
> -               IPv4PacketSizeVerify ((unsigned char *) p_IRP->Associated=
Irp.SystemBuffer,
> -                                     l_IrpSp->Parameters.Write.Length,
> -                                     TRUE,
> -                                     "RX",
> -                                     &l_Adapter->m_RxTrunc);
> -#endif
> -
> -               NdisMEthIndicateReceive
> -                 (l_Adapter->m_MiniportAdapterHandle,
> -                  (NDIS_HANDLE) l_Adapter,
> -                  (unsigned char *) p_UserToTap,
> -                  sizeof (ETH_HEADER),
> -                  (unsigned char *) p_IRP->AssociatedIrp.SystemBuffer,
> -                  l_IrpSp->Parameters.Write.Length,
> -                  l_IrpSp->Parameters.Write.Length);
> -
> -               NdisMEthIndicateReceiveComplete (l_Adapter->m_MiniportAda=
pterHandle);
> -
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_SUCCESS;
> -             }
> -           __except (EXCEPTION_EXECUTE_HANDLER)
> -             {
> -               DEBUGP (("[%s] NdisMEthIndicateReceive failed in IRP_MJ_W=
RITE (P2P)\n",
> -                        NAME (l_Adapter)));
> -               NOTE_ERROR ();
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSF=
UL;
> -               p_IRP->IoStatus.Information =3D 0;
> -             }
> -         }
> -       else
> -         {
> -           DEBUGP (("[%s] Bad buffer size in IRP_MJ_WRITE, len=3D%d\n",
> -                    NAME (l_Adapter),
> -                    l_IrpSp->Parameters.Write.Length));
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Information =3D 0;    // ETHERNET_HEADER_SIZE;
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_BUFFER_TOO_SMA=
LL;
> -         }
> -
> -       if (l_Status =3D=3D STATUS_SUCCESS)
> -         INCREMENT_STAT (l_Adapter->m_Rx);
> -       else
> -         INCREMENT_STAT (l_Adapter->m_RxErr);
> -
> -       IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -       break;
> -      }
> -
> -      //--------------------------------------------------------------
> -      //   User mode thread has called CreateFile() on the tap device
> -      //--------------------------------------------------------------
> -    case IRP_MJ_CREATE:
> -      {
> -       BOOLEAN succeeded =3D FALSE;
> -       BOOLEAN mutex_succeeded;
> -
> -       DEBUGP
> -         (("[%s] [TAP] release [%d.%d] open request (m_TapOpens=3D%d)\n",
> -           NAME (l_Adapter), TAP_DRIVER_MAJOR_VERSION,
> -           TAP_DRIVER_MINOR_VERSION, l_Adapter->m_Extension.m_TapOpens));
> -
> -       ACQUIRE_MUTEX_ADAPTIVE (&l_Adapter->m_Extension.m_OpenCloseMutex,=
 mutex_succeeded);
> -       if (mutex_succeeded)
> -         {
> -           if (l_Adapter->m_Extension.m_TapIsRunning && !l_Adapter->m_Ex=
tension.m_TapOpens)
> -             {
> -               ResetTapAdapterState (l_Adapter);
> -               l_Adapter->m_Extension.m_TapOpens =3D 1;
> -               succeeded =3D TRUE;
> -             }
> -
> -           if (succeeded)
> -             {
> -               INCREMENT_STAT (l_Adapter->m_Extension.m_NumTapOpens);
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_SUCCESS;
> -               p_IRP->IoStatus.Information =3D 0;
> -             }
> -           else
> -             {
> -               DEBUGP (("[%s] TAP is presently unavailable (m_TapOpens=
=3D%d)\n",
> -                        NAME (l_Adapter), l_Adapter->m_Extension.m_TapOp=
ens));
> -               NOTE_ERROR ();
> -               p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSF=
UL;
> -               p_IRP->IoStatus.Information =3D 0;
> -             }
> -
> -           RELEASE_MUTEX (&l_Adapter->m_Extension.m_OpenCloseMutex);
> -         }
> -       else
> -         {
> -           DEBUGP (("[%s] TAP is presently locked (m_TapOpens=3D%d)\n",
> -                    NAME (l_Adapter), l_Adapter->m_Extension.m_TapOpens)=
);
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSFUL;
> -           p_IRP->IoStatus.Information =3D 0;
> -         }
> -
> -       IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -       break;
> -      }
> -
> -      //-----------------------------------------------------------
> -      //  User mode thread called CloseHandle() on the tap device
> -      //-----------------------------------------------------------
> -    case IRP_MJ_CLOSE:
> -      {
> -       BOOLEAN mutex_succeeded;
> -
> -       DEBUGP (("[%s] [TAP] release [%d.%d] close/cleanup request\n",
> -                NAME (l_Adapter), TAP_DRIVER_MAJOR_VERSION,
> -                TAP_DRIVER_MINOR_VERSION));
> -
> -       ACQUIRE_MUTEX_ADAPTIVE (&l_Adapter->m_Extension.m_OpenCloseMutex,=
 mutex_succeeded);
> -       if (mutex_succeeded)
> -         {
> -           l_Adapter->m_Extension.m_TapOpens =3D 0;
> -           ResetTapAdapterState (l_Adapter);
> -           FlushQueues (&l_Adapter->m_Extension);
> -           SetMediaStatus (l_Adapter, FALSE);
> -           RELEASE_MUTEX (&l_Adapter->m_Extension.m_OpenCloseMutex);
> -         }
> -       else
> -         {
> -           DEBUGP (("[%s] TAP is presently locked (m_TapOpens=3D%d)\n",
> -                    NAME (l_Adapter), l_Adapter->m_Extension.m_TapOpens)=
);
> -           NOTE_ERROR ();
> -           p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSFUL;
> -           p_IRP->IoStatus.Information =3D 0;
> -         }
> -
> -       IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -       break;
> -      }
> -
> -      //------------------
> -      // Strange Request
> -      //------------------
> -    default:
> -      {
> -       //NOTE_ERROR ();
> -       p_IRP->IoStatus.Status =3D l_Status =3D STATUS_UNSUCCESSFUL;
> -       IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -       break;
> -      }
> -    }
> -
> -  return l_Status;
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// CompleteIRP is normally called with an adapter -> userspace
> -// network packet and an IRP (Pending I/O request) from userspace.
> -//
> -// The IRP will normally represent a queued overlapped read
> -// operation from userspace that is in a wait state.
> -//
> -// Use the ethernet packet to satisfy the IRP.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -NTSTATUS
> -CompleteIRP (IN PIRP p_IRP,
> -            IN TapPacketPointer p_PacketBuffer,
> -            IN CCHAR PriorityBoost)
> -{
> -  NTSTATUS l_Status =3D STATUS_UNSUCCESSFUL;
> -
> -  int offset;
> -  int len;
> -
> -  MYASSERT (p_IRP);
> -  MYASSERT (p_PacketBuffer);
> -
> -  IoSetCancelRoutine (p_IRP, NULL);  // Disable cancel routine
> -
> -  //-------------------------------------------
> -  // While p_PacketBuffer always contains a
> -  // full ethernet packet, including the
> -  // ethernet header, in point-to-point mode,
> -  // we only want to return the IPv4
> -  // component.
> -  //-------------------------------------------
> -
> -  if (p_PacketBuffer->m_SizeFlags & TP_TUN)
> -    {
> -      offset =3D ETHERNET_HEADER_SIZE;
> -      len =3D (int) (p_PacketBuffer->m_SizeFlags & TP_SIZE_MASK) - ETHER=
NET_HEADER_SIZE;
> -    }
> -  else
> -    {
> -      offset =3D 0;
> -      len =3D (p_PacketBuffer->m_SizeFlags & TP_SIZE_MASK);
> -    }
> -
> -  if (len < 0 || (int) p_IRP->IoStatus.Information < len)
> -    {
> -      p_IRP->IoStatus.Information =3D 0;
> -      p_IRP->IoStatus.Status =3D STATUS_BUFFER_OVERFLOW;
> -      NOTE_ERROR ();
> -    }
> -  else
> -    {
> -      p_IRP->IoStatus.Information =3D len;
> -      p_IRP->IoStatus.Status =3D l_Status =3D STATUS_SUCCESS;
> -
> -      __try
> -       {
> -         NdisMoveMemory (p_IRP->AssociatedIrp.SystemBuffer,
> -                         p_PacketBuffer->m_Data + offset,
> -                         len);
> -       }
> -      __except (EXCEPTION_EXECUTE_HANDLER)
> -       {
> -         NOTE_ERROR ();
> -         p_IRP->IoStatus.Status =3D STATUS_UNSUCCESSFUL;
> -         p_IRP->IoStatus.Information =3D 0;
> -       }
> -    }
> -
> -  __try
> -    {
> -      NdisFreeMemory (p_PacketBuffer,
> -                     TAP_PACKET_SIZE (p_PacketBuffer->m_SizeFlags & TP_S=
IZE_MASK),
> -                     0);
> -    }
> -  __except (EXCEPTION_EXECUTE_HANDLER)
> -    {
> -    }
> -
> -  if (l_Status =3D=3D STATUS_SUCCESS)
> -    {
> -      IoCompleteRequest (p_IRP, PriorityBoost);
> -    }
> -  else
> -    IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -
> -  return l_Status;
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// IRPs get cancelled for a number of reasons.
> -//
> -// The TAP device could be closed by userspace
> -// when there are still pending read operations.
> -//
> -// The user could disable the TAP adapter in the
> -// network connections control panel, while the
> -// device is still open by a process.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -VOID
> -CancelIRPCallback (IN PDEVICE_OBJECT p_DeviceObject,
> -                  IN PIRP p_IRP)
> -{
> -  TapAdapterPointer l_Adapter =3D LookupAdapterInInstanceList (p_DeviceO=
bject);
> -  CancelIRP (l_Adapter ? &l_Adapter->m_Extension : NULL, p_IRP, TRUE);
> -}
> -
> -VOID
> -CancelIRP (TapExtensionPointer p_Extension,
> -          IN PIRP p_IRP,
> -          BOOLEAN callback)
> -{
> -  BOOLEAN exists =3D FALSE;
> -
> -  MYASSERT (p_IRP);
> -
> -  if (p_Extension)
> -    {
> -      NdisAcquireSpinLock (&p_Extension->m_QueueLock);
> -      exists =3D (QueueExtract (p_Extension->m_IrpQueue, p_IRP) =3D=3D p=
_IRP);
> -      NdisReleaseSpinLock (&p_Extension->m_QueueLock);
> -    }
> -  else
> -    exists =3D TRUE;
> -
> -  if (exists)
> -    {
> -      IoSetCancelRoutine (p_IRP, NULL);
> -      p_IRP->IoStatus.Status =3D STATUS_CANCELLED;
> -      p_IRP->IoStatus.Information =3D 0;
> -    }
> -
> -  if (callback)
> -    IoReleaseCancelSpinLock (p_IRP->CancelIrql);
> -
> -  if (exists)
> -    IoCompleteRequest (p_IRP, IO_NO_INCREMENT);
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Exhaust packet, IRP, and injection queues.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -VOID
> -FlushQueues (TapExtensionPointer p_Extension)
> -{
> -  PIRP l_IRP;
> -  TapPacketPointer l_PacketBuffer;
> -  InjectPacketPointer l_InjectBuffer;
> -  int n_IRP=3D0, n_Packet=3D0, n_Inject=3D0;
> -
> -  MYASSERT (p_Extension);
> -  MYASSERT (p_Extension->m_TapDevice);
> -
> -  while (TRUE)
> -    {
> -      NdisAcquireSpinLock (&p_Extension->m_QueueLock);
> -      l_IRP =3D QueuePop (p_Extension->m_IrpQueue);
> -      NdisReleaseSpinLock (&p_Extension->m_QueueLock);
> -      if (l_IRP)
> -       {
> -         ++n_IRP;
> -         CancelIRP (NULL, l_IRP, FALSE);
> -       }
> -      else
> -       break;
> -    }
> -
> -  while (TRUE)
> -    {
> -      NdisAcquireSpinLock (&p_Extension->m_QueueLock);
> -      l_PacketBuffer =3D QueuePop (p_Extension->m_PacketQueue);
> -      NdisReleaseSpinLock (&p_Extension->m_QueueLock);
> -      if (l_PacketBuffer)
> -       {
> -         ++n_Packet;
> -         MemFree (l_PacketBuffer, TAP_PACKET_SIZE (l_PacketBuffer->m_Siz=
eFlags & TP_SIZE_MASK));
> -       }
> -      else
> -       break;
> -    }
> -
> -  while (TRUE)
> -    {
> -      NdisAcquireSpinLock (&p_Extension->m_InjectLock);
> -      l_InjectBuffer =3D QueuePop (p_Extension->m_InjectQueue);
> -      NdisReleaseSpinLock (&p_Extension->m_InjectLock);
> -      if (l_InjectBuffer)
> -       {
> -         ++n_Inject;
> -         INJECT_PACKET_FREE(l_InjectBuffer);
> -       }
> -      else
> -       break;
> -    }
> -
> -  DEBUGP ((
> -          "[%s] [TAP] FlushQueues n_IRP=3D[%d,%d,%d] n_Packet=3D[%d,%d,%=
d] n_Inject=3D[%d,%d,%d]\n",
> -          p_Extension->m_TapName,
> -          n_IRP,
> -          p_Extension->m_IrpQueue->max_size,
> -          IRP_QUEUE_SIZE,
> -          n_Packet,
> -          p_Extension->m_PacketQueue->max_size,
> -          PACKET_QUEUE_SIZE,
> -          n_Inject,
> -          p_Extension->m_InjectQueue->max_size,
> -          INJECT_QUEUE_SIZE
> -          ));
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -// Tell Windows whether the TAP device should be
> -// considered "connected" or "disconnected".
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -VOID
> -SetMediaStatus (TapAdapterPointer p_Adapter, BOOLEAN state)
> -{
> -  if (p_Adapter->m_MediaState !=3D state && !p_Adapter->m_MediaStateAlwa=
ysConnected)
> -    {
> -      if (state)
> -       NdisMIndicateStatus (p_Adapter->m_MiniportAdapterHandle,
> -                            NDIS_STATUS_MEDIA_CONNECT, NULL, 0);
> -      else
> -       NdisMIndicateStatus (p_Adapter->m_MiniportAdapterHandle,
> -                            NDIS_STATUS_MEDIA_DISCONNECT, NULL, 0);
> -
> -      NdisMIndicateStatusComplete (p_Adapter->m_MiniportAdapterHandle);
> -      p_Adapter->m_MediaState =3D state;
> -    }
> -}
> -
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -// If DHCP mode is used together with tun
> -// mode, consider the fact that the P2P remote subnet
> -// might enclose the DHCP masq server address.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> -VOID
> -CheckIfDhcpAndTunMode (TapAdapterPointer p_Adapter)
> -{
> -  if (p_Adapter->m_tun && p_Adapter->m_dhcp_enabled)
> -    {
> -      if ((p_Adapter->m_dhcp_server_ip & p_Adapter->m_remoteNetmask) =3D=
=3D p_Adapter->m_remoteNetwork)
> -       {
> -         COPY_MAC (p_Adapter->m_dhcp_server_mac, p_Adapter->m_TapToUser.=
dest);
> -         p_Adapter->m_dhcp_server_arp =3D FALSE;
> -       }
> -    }
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -// Generate an ARP reply message for specific kinds
> -// ARP queries.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -BOOLEAN
> -ProcessARP (TapAdapterPointer p_Adapter,
> -           const PARP_PACKET src,
> -           const IPADDR adapter_ip,
> -           const IPADDR ip_network,
> -           const IPADDR ip_netmask,
> -           const MACADDR mac)
> -{
> -  //-----------------------------------------------
> -  // Is this the kind of packet we are looking for?
> -  //-----------------------------------------------
> -  if (src->m_Proto =3D=3D htons (ETH_P_ARP)
> -      && MAC_EQUAL (src->m_MAC_Source, p_Adapter->m_MAC)
> -      && MAC_EQUAL (src->m_ARP_MAC_Source, p_Adapter->m_MAC)
> -      && MAC_EQUAL (src->m_MAC_Destination, p_Adapter->m_MAC_Broadcast)
> -      && src->m_ARP_Operation =3D=3D htons (ARP_REQUEST)
> -      && src->m_MAC_AddressType =3D=3D htons (MAC_ADDR_TYPE)
> -      && src->m_MAC_AddressSize =3D=3D sizeof (MACADDR)
> -      && src->m_PROTO_AddressType =3D=3D htons (ETH_P_IP)
> -      && src->m_PROTO_AddressSize =3D=3D sizeof (IPADDR)
> -      && src->m_ARP_IP_Source =3D=3D adapter_ip
> -      && (src->m_ARP_IP_Destination & ip_netmask) =3D=3D ip_network
> -      && src->m_ARP_IP_Destination !=3D adapter_ip)
> -    {
> -      ARP_PACKET *arp =3D (ARP_PACKET *) MemAlloc (sizeof (ARP_PACKET), =
TRUE);
> -      if (arp)
> -       {
> -         //----------------------------------------------
> -         // Initialize ARP reply fields
> -         //----------------------------------------------
> -         arp->m_Proto =3D htons (ETH_P_ARP);
> -         arp->m_MAC_AddressType =3D htons (MAC_ADDR_TYPE);
> -         arp->m_PROTO_AddressType =3D htons (ETH_P_IP);
> -         arp->m_MAC_AddressSize =3D sizeof (MACADDR);
> -         arp->m_PROTO_AddressSize =3D sizeof (IPADDR);
> -         arp->m_ARP_Operation =3D htons (ARP_REPLY);
> -
> -         //----------------------------------------------
> -         // ARP addresses
> -         //----------------------------------------------
> -         COPY_MAC (arp->m_MAC_Source, mac);
> -         COPY_MAC (arp->m_MAC_Destination, p_Adapter->m_MAC);
> -         COPY_MAC (arp->m_ARP_MAC_Source, mac);
> -         COPY_MAC (arp->m_ARP_MAC_Destination, p_Adapter->m_MAC);
> -         arp->m_ARP_IP_Source =3D src->m_ARP_IP_Destination;
> -         arp->m_ARP_IP_Destination =3D adapter_ip;
> -
> -         DUMP_PACKET ("ProcessARP",
> -                      (unsigned char *) arp,
> -                      sizeof (ARP_PACKET));
> -
> -         InjectPacketDeferred (p_Adapter, (UCHAR *) arp, sizeof (ARP_PAC=
KET));
> -
> -         MemFree (arp, sizeof (ARP_PACKET));
> -       }
> -
> -      return TRUE;
> -    }
> -  else
> -    return FALSE;
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Used in cases where internally generated packets such as
> -// ARP or DHCP replies must be returned to the kernel, to be
> -// seen as an incoming packet "arriving" on the interface.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -// Defer packet injection till IRQL < DISPATCH_LEVEL
> -VOID
> -InjectPacketDeferred (TapAdapterPointer p_Adapter,
> -                     UCHAR *packet,
> -                     const unsigned int len)
> -{
> -  InjectPacketPointer l_InjectBuffer;
> -  PVOID result;
> -
> -  if (NdisAllocateMemoryWithTag (&l_InjectBuffer,
> -                                INJECT_PACKET_SIZE (len),
> -                                'IPAT') =3D=3D NDIS_STATUS_SUCCESS)
> -    {
> -      l_InjectBuffer->m_Size =3D len;
> -      NdisMoveMemory (l_InjectBuffer->m_Data, packet, len);
> -      NdisAcquireSpinLock (&p_Adapter->m_Extension.m_InjectLock);
> -      result =3D QueuePush (p_Adapter->m_Extension.m_InjectQueue, l_Inje=
ctBuffer);
> -      NdisReleaseSpinLock (&p_Adapter->m_Extension.m_InjectLock);
> -      if (result)
> -       KeInsertQueueDpc (&p_Adapter->m_Extension.m_InjectDpc, p_Adapter,=
 NULL);
> -      else
> -       INJECT_PACKET_FREE(l_InjectBuffer);
> -    }
> -}
> -
> -// Handle the injection of previously deferred packets
> -VOID
> -InjectPacketDpc(KDPC *Dpc,
> -               PVOID DeferredContext,
> -               PVOID SystemArgument1,
> -               PVOID SystemArgument2)
> -{
> -  InjectPacketPointer l_InjectBuffer;
> -  TapAdapterPointer l_Adapter =3D (TapAdapterPointer)SystemArgument1;
> -  while (TRUE)
> -    {
> -      NdisAcquireSpinLock (&l_Adapter->m_Extension.m_InjectLock);
> -      l_InjectBuffer =3D QueuePop (l_Adapter->m_Extension.m_InjectQueue);
> -      NdisReleaseSpinLock (&l_Adapter->m_Extension.m_InjectLock);
> -      if (l_InjectBuffer)
> -       {
> -         InjectPacketNow(l_Adapter, l_InjectBuffer->m_Data, l_InjectBuff=
er->m_Size);
> -         INJECT_PACKET_FREE(l_InjectBuffer);
> -       }
> -      else
> -       break;
> -    }
> -}
> -
> -// Do packet injection now
> -VOID
> -InjectPacketNow (TapAdapterPointer p_Adapter,
> -                UCHAR *packet,
> -                const unsigned int len)
> -{
> -  MYASSERT (len >=3D ETHERNET_HEADER_SIZE);
> -
> -  __try
> -    {
> -      //------------------------------------------------------------
> -      // NdisMEthIndicateReceive and NdisMEthIndicateReceiveComplete
> -      // could potentially be called reentrantly both here and in
> -      // TapDeviceHook/IRP_MJ_WRITE.
> -      //
> -      // The DDK docs imply that this is okay.
> -      //
> -      // Note that reentrant behavior could only occur if the
> -      // non-deferred version of InjectPacket is used.
> -      //------------------------------------------------------------
> -      NdisMEthIndicateReceive
> -       (p_Adapter->m_MiniportAdapterHandle,
> -        (NDIS_HANDLE) p_Adapter,
> -        packet,
> -        ETHERNET_HEADER_SIZE,
> -        packet + ETHERNET_HEADER_SIZE,
> -        len - ETHERNET_HEADER_SIZE,
> -        len - ETHERNET_HEADER_SIZE);
> -
> -      NdisMEthIndicateReceiveComplete (p_Adapter->m_MiniportAdapterHandl=
e);
> -    }
> -  __except (EXCEPTION_EXECUTE_HANDLER)
> -    {
> -      DEBUGP (("[%s] NdisMEthIndicateReceive failed in InjectPacketNow\n=
",
> -              NAME (p_Adapter)));
> -      NOTE_ERROR ();
> -    }
> -}
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Go back to default TAP mode from Point-To-Point mode.
> -// Also reset (i.e. disable) DHCP Masq mode.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -VOID ResetTapAdapterState (TapAdapterPointer p_Adapter)
> -{
> -  // Point-To-Point
> -  p_Adapter->m_tun =3D FALSE;
> -  p_Adapter->m_localIP =3D 0;
> -  p_Adapter->m_remoteNetwork =3D 0;
> -  p_Adapter->m_remoteNetmask =3D 0;
> -  NdisZeroMemory (&p_Adapter->m_TapToUser, sizeof (p_Adapter->m_TapToUse=
r));
> -  NdisZeroMemory (&p_Adapter->m_UserToTap, sizeof (p_Adapter->m_UserToTa=
p));
> -  NdisZeroMemory (&p_Adapter->m_UserToTap_IPv6, sizeof (p_Adapter->m_Use=
rToTap_IPv6));
> -
> -  // DHCP Masq
> -  p_Adapter->m_dhcp_enabled =3D FALSE;
> -  p_Adapter->m_dhcp_server_arp =3D FALSE;
> -  p_Adapter->m_dhcp_user_supplied_options_buffer_len =3D 0;
> -  p_Adapter->m_dhcp_addr =3D 0;
> -  p_Adapter->m_dhcp_netmask =3D 0;
> -  p_Adapter->m_dhcp_server_ip =3D 0;
> -  p_Adapter->m_dhcp_lease_time =3D 0;
> -  p_Adapter->m_dhcp_received_discover =3D FALSE;
> -  p_Adapter->m_dhcp_bad_requests =3D 0;
> -  NdisZeroMemory (p_Adapter->m_dhcp_server_mac, sizeof (MACADDR));
> -}
> -
> -#if ENABLE_NONADMIN
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -// Set TAP device handle to be accessible without admin privileges.
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -VOID AllowNonAdmin (TapExtensionPointer p_Extension)
> -{
> -  NTSTATUS stat;
> -  SECURITY_DESCRIPTOR sd;
> -  OBJECT_ATTRIBUTES oa;
> -  IO_STATUS_BLOCK isb;
> -  HANDLE hand =3D NULL;
> -
> -  NdisZeroMemory (&sd, sizeof (sd));
> -  NdisZeroMemory (&oa, sizeof (oa));
> -  NdisZeroMemory (&isb, sizeof (isb));
> -
> -  if (!p_Extension->m_CreatedUnicodeLinkName)
> -    {
> -      DEBUGP (("[TAP] AllowNonAdmin: UnicodeLinkName is uninitialized\n"=
));
> -      NOTE_ERROR ();
> -      return;
> -    }
> -
> -  stat =3D RtlCreateSecurityDescriptor (&sd, SECURITY_DESCRIPTOR_REVISIO=
N);
> -  if (stat !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[TAP] AllowNonAdmin: RtlCreateSecurityDescriptor failed\=
n"));
> -      NOTE_ERROR ();
> -      return;
> -    }
> -
> -  InitializeObjectAttributes (
> -    &oa,
> -    &p_Extension->m_UnicodeLinkName,
> -    OBJ_KERNEL_HANDLE,
> -    NULL,
> -    NULL
> -    );
> -
> -  stat =3D ZwOpenFile (
> -    &hand,
> -    WRITE_DAC,
> -    &oa,
> -    &isb,
> -    0,
> -    0
> -    );
> -  if (stat !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[TAP] AllowNonAdmin: ZwOpenFile failed, status=3D0x%08x\=
n", (unsigned int)stat));
> -      NOTE_ERROR ();
> -      return;
> -    }
> -
> -  stat =3D ZwSetSecurityObject (hand, DACL_SECURITY_INFORMATION, &sd);
> -  if (stat !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[TAP] AllowNonAdmin: ZwSetSecurityObject failed\n"));
> -      NOTE_ERROR ();
> -      return;
> -    }
> -
> -  stat =3D ZwClose (hand);
> -  if (stat !=3D STATUS_SUCCESS)
> -    {
> -      DEBUGP (("[TAP] AllowNonAdmin: ZwClose failed\n"));
> -      NOTE_ERROR ();
> -      return;
> -    }
> -
> -  DEBUGP (("[TAP] AllowNonAdmin: SUCCEEDED\n"));
> -}
> -
> -#endif
> -
> -#if PACKET_TRUNCATION_CHECK
> -
> -VOID
> -IPv4PacketSizeVerify (const UCHAR *data, ULONG length, BOOLEAN tun, cons=
t char *prefix, LONG *counter)
> -{
> -  const IPHDR *ip;
> -  int len =3D length;
> -
> -  if (tun)
> -    {
> -      ip =3D (IPHDR *) data;
> -    }
> -  else
> -    {
> -      if (length >=3D sizeof (ETH_HEADER))
> -       {
> -         const ETH_HEADER *eth =3D (ETH_HEADER *) data;
> -
> -         if (eth->proto !=3D htons (ETH_P_IP))
> -           return;
> -
> -         ip =3D (IPHDR *) (data + sizeof (ETH_HEADER));
> -         len -=3D sizeof (ETH_HEADER);
> -       }
> -      else
> -       return;
> -    }
> -
> -  if (len >=3D sizeof (IPHDR))
> -    {
> -      const int totlen =3D ntohs (ip->tot_len);
> -
> -      DEBUGP (("[TAP] IPv4PacketSizeVerify %s len=3D%d totlen=3D%d\n", p=
refix, len, totlen));
> -
> -      if (len !=3D totlen)
> -       ++(*counter);
> -    }
> -}
> -
> -#endif
> -
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -//                                    End of Source
> -//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/tap-win32/types.h b/tap-win32/types.h
> deleted file mode 100755
> index bdc08e7..0000000
> --- a/tap-win32/types.h
> +++ /dev/null
> @@ -1,178 +0,0 @@
> -/*
> - *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> - *                         device functionality on Windows.
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
> -
> -#ifndef TAP_TYPES_DEFINED
> -#define TAP_TYPES_DEFINED
> -
> -typedef struct _Queue
> -{
> -  ULONG base;
> -  ULONG size;
> -  ULONG capacity;
> -  ULONG max_size;
> -  PVOID data[];
> -} Queue;
> -
> -typedef struct _TapAdapter;
> -typedef struct _TapPacket;
> -
> -typedef union _TapAdapterQuery
> -{
> -  NDIS_HARDWARE_STATUS m_HardwareStatus;
> -  NDIS_MEDIUM m_Medium;
> -  NDIS_PHYSICAL_MEDIUM m_PhysicalMedium;
> -  UCHAR m_MacAddress [6];
> -  UCHAR m_Buffer [256];
> -  ULONG m_Long;
> -  USHORT m_Short;
> -  UCHAR m_Byte;
> -}
> -TapAdapterQuery, *TapAdapterQueryPointer;
> -
> -typedef struct _TapExtension
> -{
> -  // TAP device object and packet queues
> -  Queue *m_PacketQueue, *m_IrpQueue;
> -  PDEVICE_OBJECT m_TapDevice;
> -  NDIS_HANDLE m_TapDeviceHandle;
> -  ULONG m_TapOpens;
> -
> -  // Used to lock packet queues
> -  NDIS_SPIN_LOCK m_QueueLock;
> -  BOOLEAN m_AllocatedSpinlocks;
> -
> -  // Used to bracket open/close
> -  // state changes.
> -  MUTEX m_OpenCloseMutex;
> -
> -  // True if device has been permanently halted
> -  BOOLEAN m_Halt;
> -
> -  // TAP device name
> -  unsigned char *m_TapName;
> -  UNICODE_STRING m_UnicodeLinkName;
> -  BOOLEAN m_CreatedUnicodeLinkName;
> -
> -  // Used for device status ioctl only
> -  const char *m_LastErrorFilename;
> -  int m_LastErrorLineNumber;
> -  LONG m_NumTapOpens;
> -
> -  // Flags
> -  BOOLEAN m_TapIsRunning;
> -  BOOLEAN m_CalledTapDeviceFreeResources;
> -
> -  // DPC queue for deferred packet injection
> -  BOOLEAN m_InjectDpcInitialized;
> -  KDPC m_InjectDpc;
> -  NDIS_SPIN_LOCK m_InjectLock;
> -  Queue *m_InjectQueue;
> -}
> -TapExtension, *TapExtensionPointer;
> -
> -typedef struct _TapPacket
> -   {
> -#   define TAP_PACKET_SIZE(data_size) (sizeof (TapPacket) + (data_size))
> -#   define TP_TUN 0x80000000
> -#   define TP_SIZE_MASK      (~TP_TUN)
> -    ULONG m_SizeFlags;
> -    UCHAR m_Data []; // m_Data must be the last struct member
> -   }
> -TapPacket, *TapPacketPointer;
> -
> -typedef struct _InjectPacket
> -   {
> -#   define INJECT_PACKET_SIZE(data_size) (sizeof (InjectPacket) + (data_=
size))
> -#   define INJECT_PACKET_FREE(ib)  NdisFreeMemory ((ib), INJECT_PACKET_S=
IZE ((ib)->m_Size), 0)
> -    ULONG m_Size;
> -    UCHAR m_Data []; // m_Data must be the last struct member
> -   }
> -InjectPacket, *InjectPacketPointer;
> -
> -typedef struct _TapAdapter
> -{
> -# define NAME(a) ((a)->m_NameAnsi.Buffer)
> -  ANSI_STRING m_NameAnsi;
> -  MACADDR m_MAC;
> -  BOOLEAN m_InterfaceIsRunning;
> -  NDIS_HANDLE m_MiniportAdapterHandle;
> -  LONG m_Rx, m_Tx, m_RxErr, m_TxErr;
> -#if PACKET_TRUNCATION_CHECK
> -  LONG m_RxTrunc, m_TxTrunc;
> -#endif
> -  NDIS_MEDIUM m_Medium;
> -  ULONG m_Lookahead;
> -  ULONG m_MTU;
> -
> -  // TRUE if adapter should always be
> -  // "connected" even when device node
> -  // is not open by a userspace process.
> -  BOOLEAN m_MediaStateAlwaysConnected;
> -
> -  // TRUE if device is "connected"
> -  BOOLEAN m_MediaState;
> -
> -  // Adapter power state
> -  char m_DeviceState;
> -
> -  // Info for point-to-point mode
> -  BOOLEAN m_tun;
> -  IPADDR m_localIP;
> -  IPADDR m_remoteNetwork;
> -  IPADDR m_remoteNetmask;
> -  ETH_HEADER m_TapToUser;
> -  ETH_HEADER m_UserToTap;
> -  ETH_HEADER m_UserToTap_IPv6;         // same as UserToTap but proto=3D=
ipv6
> -  MACADDR m_MAC_Broadcast;
> -
> -  // Used for DHCP server masquerade
> -  BOOLEAN m_dhcp_enabled;
> -  IPADDR m_dhcp_addr;
> -  ULONG m_dhcp_netmask;
> -  IPADDR m_dhcp_server_ip;
> -  BOOLEAN m_dhcp_server_arp;
> -  MACADDR m_dhcp_server_mac;
> -  ULONG m_dhcp_lease_time;
> -  UCHAR m_dhcp_user_supplied_options_buffer[DHCP_USER_SUPPLIED_OPTIONS_B=
UFFER_SIZE];
> -  ULONG m_dhcp_user_supplied_options_buffer_len;
> -  BOOLEAN m_dhcp_received_discover;
> -  ULONG m_dhcp_bad_requests;
> -
> -  // Help to tear down the adapter by keeping
> -  // some state information on allocated
> -  // resources.
> -  BOOLEAN m_CalledAdapterFreeResources;
> -  BOOLEAN m_RegisteredAdapterShutdownHandler;
> -
> -  // Multicast list info
> -  NDIS_SPIN_LOCK m_MCLock;
> -  BOOLEAN m_MCLockAllocated;
> -  ULONG m_MCListSize;
> -  MC_LIST m_MCList;
> -
> -  // Information on the TAP device
> -  TapExtension m_Extension;
> -} TapAdapter, *TapAdapterPointer;
> -
> -#endif
> diff --git a/tap-windows.h b/tap-windows.h
> new file mode 100644
> index 0000000..0655672
> --- /dev/null
> +++ b/tap-windows.h
> @@ -0,0 +1,68 @@
> +/*
> + *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
> + *                         device functionality on Windows.
> + *
> + *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
> + *
> + *  This source code is Copyright (C) 2002-2010 OpenVPN Technologies, In=
c.,
> + *  and is released under the GPL version 2 (see below).
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
> +#ifndef __TAP_H
> +#define __TAP_H
> +
> +//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +// TAP IOCTLs
> +//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +#define TAP_CONTROL_CODE(request,method) \
> +  CTL_CODE (FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
> +
> +// Present in 8.1
> +
> +#define TAP_IOCTL_GET_MAC               TAP_CONTROL_CODE (1, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_GET_VERSION           TAP_CONTROL_CODE (2, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_GET_MTU               TAP_CONTROL_CODE (3, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_GET_INFO              TAP_CONTROL_CODE (4, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE (5, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_SET_MEDIA_STATUS      TAP_CONTROL_CODE (6, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_CONFIG_DHCP_MASQ      TAP_CONTROL_CODE (7, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_GET_LOG_LINE          TAP_CONTROL_CODE (8, METHOD_BUFF=
ERED)
> +#define TAP_IOCTL_CONFIG_DHCP_SET_OPT   TAP_CONTROL_CODE (9, METHOD_BUFF=
ERED)
> +
> +// Added in 8.2
> +
> +/* obsoletes TAP_IOCTL_CONFIG_POINT_TO_POINT */
> +#define TAP_IOCTL_CONFIG_TUN            TAP_CONTROL_CODE (10, METHOD_BUF=
FERED)
> +
> +//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +// Registry keys
> +//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +#define ADAPTER_KEY "SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E97=
2-E325-11CE-BFC1-08002BE10318}"
> +
> +#define NETWORK_CONNECTIONS_KEY "SYSTEM\\CurrentControlSet\\Control\\Net=
work\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
> +
> +//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +// Filesystem prefixes
> +//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +#define USERMODEDEVICEDIR "\\\\.\\Global\\"
> +#define SYSDEVICEDIR      "\\Device\\"
> +#define USERDEVICEDIR     "\\DosDevices\\Global\\"
> +#define TAPSUFFIX         ".tap"
> +
> +#endif
> diff --git a/tun.h b/tun.h
> index 513257f..ad7b2b1 100644
> --- a/tun.h
> +++ b/tun.h
> @@ -27,7 +27,7 @@
>
>  #ifdef WIN32
>  #include <winioctl.h>
> -#include "tap-win32/common.h"
> +#include <tap-windows.h>
>  #endif
>
>  #include "buffer.h"
> diff --git a/win/autodefs.h.in b/win/autodefs.h.in
> index ad0af19..372eb81 100644
> --- a/win/autodefs.h.in
> +++ b/win/autodefs.h.in
> @@ -6,7 +6,7 @@
>   *
>   * The TAP-Win32 version number is defined in tap-win32/SOURCES
>   */
> -#define TAP_ID "@PRODUCT_TAP_ID@"
> +#define TAP_COMPONENT_ID "@PRODUCT_TAP_ID@"
>  #define TAP_WIN32_MIN_MAJOR @PRODUCT_TAP_WIN32_MIN_MAJOR@
>  #define TAP_WIN32_MIN_MINOR @PRODUCT_TAP_WIN32_MIN_MINOR@
>
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



