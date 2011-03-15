From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Tue, 15 Mar 2011 16:37:41 +0200
Message-Id: <1300199861-4776-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Replaced config-win32.h with win/config.h.in
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

The original config-win32.h - a static header file - has been superceded by=
 both
"domake-win" script and the new Python-based buildsystem. Transformed it in=
to a
template file, win/config.h.in, which obtains the most commonly used build
parameters from win/settings.in.

Added support code to win/config.py and win/wb.py to preprocess win/config.=
h.in
and copy it to config.h, from where source and header files can find it.

Removed all references to config-win32.h. Also removed obsolete
PACKAGE_BUGREPORT and USE_PTHREAD variables from the win/config.h.in file.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 config-win32.h              |  308 ---------------------------------------=
--
 openvpn.8                   |    4 +-
 service-win32/openvpnserv.c |    4 -
 syshead.h                   |    4 -
 tap-win32/SOURCES.in        |    3 +-
 win/config.h.in             |  316 +++++++++++++++++++++++++++++++++++++++=
++++
 win/config.py               |   37 +++---
 win/settings.in             |   12 ++-
 win/wb.py                   |   30 +++--
 9 files changed, 366 insertions(+), 352 deletions(-)
 delete mode 100644 config-win32.h
 create mode 100644 win/config.h.in

diff --git a/config-win32.h b/config-win32.h
deleted file mode 100644
index 8f4de3b..0000000
--- a/config-win32.h
+++ /dev/null
@@ -1,308 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * Configuration header for Win32 using the MSVC environment.
- */
-
-#include <windows.h>
-#include <winsock2.h>
-#include "autodefs.h" /* machine generated */
-
-//#define sleep(x) Sleep((x)*1000)
-
-//#define random rand
-//#define srandom srand
-
-typedef unsigned long in_addr_t;
-
-#ifndef _SSIZE_T_
-#define _SSIZE_T_
- typedef unsigned int ssize_t;
-#endif
-
-/* Append a label to program startup title */
-/*#define DEBUG_LABEL "DEBUG1"*/
-
-/* Should we print debug info from driver? */
-#ifdef PRODUCT_TAP_DEBUG
-#define TAP_WIN32_DEBUG
-#endif
-
-/* Enable reading credentials from a file */
-#define ENABLE_PASSWORD_SAVE 1
-
-/* Enable client/server capability */
-#define ENABLE_CLIENT_SERVER 1
-
-/* Enable client capability only */
-#define ENABLE_CLIENT_ONLY
-
-/* Enable management server capability */
-#define ENABLE_MANAGEMENT 1
-
-/* Enable PKCS#11 support */
-/* #define USE_PKCS11 1 */
-
-/* Enable HTTP proxy support */
-#define ENABLE_HTTP_PROXY 1
-
-/* Enable Socks proxy support */
-#define ENABLE_SOCKS 1
-
-/* Enable internal fragmentation support */
-#define ENABLE_FRAGMENT 1
-
-/* Enable smaller executable size */
-/* #undef ENABLE_SMALL */
-
-/* Enable debugging support */
-#define ENABLE_DEBUG 1
-
-/* if defined, will allow usage of the --plugin directive */
-#define USE_LOAD_LIBRARY
-
-/* Dimension size to use for empty array declaration */
-#define EMPTY_ARRAY_SIZE 0
-
-/* Define to 1 if you have the `getsockname' function. */
-#define HAVE_GETSOCKNAME 1
-
-/* Define to 1 if you have the <openssl/engine.h> header file. */
-#define HAVE_OPENSSL_ENGINE_H 1
-
-/* Define to 1 if you have the `ENGINE_load_builtin_engines' function. */
-#define HAVE_ENGINE_LOAD_BUILTIN_ENGINES 1
-
-/* Define to 1 if you have the `ENGINE_register_all_complete' function. */
-#define HAVE_ENGINE_REGISTER_ALL_COMPLETE 1
-
-/* Define to 1 if you have the `ENGINE_cleanup' function. */
-#define HAVE_ENGINE_CLEANUP 1
-
-/* gettimeofday() is implemented in otime.c for Windows */
-#define HAVE_GETTIMEOFDAY 1
-
-/* Define to 1 if you have the 'chsize' function. */
-#define HAVE_CHSIZE 1
-
-/* Define to 1 if you have the `chdir' function. */
-#define HAVE_CHDIR 1
-
-/* Define to 1 if your compiler supports GNU GCC-style variadic macros */
-#ifndef _MSC_VER /* Defines MSFT compiler version. Defined as 1200 for MSV=
C++ 6.0. */
-#define HAVE_CPP_VARARG_MACRO_GCC 1
-#endif
-
-/* Define to 1 if you have the <ctype.h> header file. */
-#define HAVE_CTYPE_H 1
-
-/* Define to 1 if you have the <errno.h> header file. */
-#define HAVE_ERRNO_H 1
-
-/* Define to 1 if you have the `EVP_CIPHER_CTX_set_key_length' function. */
-#define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
-
-/* Define to 1 if you have the <fcntl.h> header file. */
-#define HAVE_FCNTL_H 1
-
-/* Define to 1 if you have the `getsockopt' function. */
-#define HAVE_GETSOCKOPT 1
-
-/* Define to 1 if you have the `inet_ntoa' function. */
-#define HAVE_INET_NTOA 1
-
-/* Define to 1 if your system has a GNU libc compatible `malloc' function,=
 and
-   to 0 otherwise. */
-#define HAVE_MALLOC 1
-
-/* Define to 1 if you have the `memset' function. */
-#define HAVE_MEMSET 1
-
-/* Define to 1 if you have the `setsockopt' function. */
-#define HAVE_SETSOCKOPT 1
-
-/* Define to 1 if you have the `socket' function. */
-#define HAVE_SOCKET 1
-
-/* Define to 1 if you have the <stdarg.h> header file. */
-#define HAVE_STDARG_H 1
-
-/* Define to 1 if you have the <stdint.h> header file. */
-#ifndef _MSC_VER
-#define HAVE_STDINT_H 1
-#endif
-
-/* Define to 1 if you have the <stdio.h> header file. */
-#define HAVE_STDIO_H 1
-
-/* Define to 1 if you have the <stdlib.h> header file. */
-#define HAVE_STDLIB_H 1
-
-/* Define to 1 if you have the `strerror' function. */
-#define HAVE_STRERROR 1
-
-/* Define to 1 if you have the <strings.h> header file. */
-#define HAVE_STRINGS_H 1
-
-/* Define to 1 if you have the <string.h> header file. */
-#define HAVE_STRING_H 1
-
-/* Define to 1 if you have the `system' function. */
-#define HAVE_SYSTEM 1
-
-/* Define to 1 if you have the <sys/file.h> header file. */
-#ifndef _MSC_VER
-#define HAVE_SYS_FILE_H 1
-#endif
-
-/* Define to 1 if you have the <sys/stat.h> header file. */
-#define HAVE_SYS_STAT_H 1
-
-/* Define to 1 if you have the <sys/time.h> header file. */
-#ifndef _MSC_VER
-#define HAVE_SYS_TIME_H 1
-#endif
-
-/* Define to 1 if you have the <sys/types.h> header file. */
-#define HAVE_SYS_TYPES_H 1
-
-/* Define to 1 if you have the `time' function. */
-#define HAVE_TIME 1
-
-/* Define to 1 if you have the <unistd.h> header file. */
-#ifndef _MSC_VER
-#define HAVE_UNISTD_H 1
-#endif
-
-/* Define to 1 if you have the `vsnprintf' function. */
-#define HAVE_VSNPRINTF 1
-
-/* Special Windows version of getpass() defined in io.c */
-#define HAVE_GETPASS 1
-
-/* Define to the address where bug reports for this package should be sent=
. */
-//#define PACKAGE_BUGREPORT "openvpn-users@lists.sourceforge.net"
-
-/* Define to the full name and version of this package. */
-#ifdef DEBUG_LABEL
-#define PACKAGE_STRING PACKAGE_NAME " " PACKAGE_VERSION " " DEBUG_LABEL
-#else
-#define PACKAGE_STRING PACKAGE_NAME " " PACKAGE_VERSION
-#endif
-
-/* Define as the return type of signal handlers (`int' or `void'). */
-#define RETSIGTYPE void
-
-/* The size of a `unsigned int', as computed by sizeof. */
-#define SIZEOF_UNSIGNED_INT 4
-
-/* The size of a `unsigned long', as computed by sizeof. */
-#define SIZEOF_UNSIGNED_LONG 4
-
-/* Define to 1 if you have the ANSI C header files. */
-#define STDC_HEADERS 1
-
-/* A string representing our target */
-#ifdef _MSC_VER
-#define TARGET_ALIAS "Win32-MSVC++"
-#else
-#define TARGET_ALIAS "Win32-MinGW"
-#endif
-
-/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
-#ifndef _MSC_VER
-#define TIME_WITH_SYS_TIME 1
-#endif
-
-/* Use OpenSSL crypto library */
-#define USE_CRYPTO 1
-
-/* Use LZO compression library */
-#define USE_LZO 1
-
-/* LZO version number */
-#define LZO_VERSION_NUM "2"
-
-/* Use lzo/ directory prefix for LZO header files (for LZO 2.0) */
-#define LZO_HEADER_DIR 1
-
-/* Use OpenSSL SSL library */
-#define USE_SSL 1
-
-/* Version number of package */
-#define VERSION PACKAGE_VERSION
-
-/* Define as `__inline' if that's what the C compiler calls it, or to noth=
ing
-   if it is not supported. */
-#define inline __inline
-
-/* type to use in place of socklen_t if not defined */
-#define socklen_t unsigned int
-
-/* 32-bit unsigned type */
-#define uint32_t unsigned int
-
-/* 16-bit unsigned type */
-#define uint16_t unsigned short
-
-/* 8-bit unsigned type */
-#define uint8_t unsigned char
-
-/* Route command */
-#define ROUTE_PATH "route"
-
-/* Windows doesn't support PTHREAD yet */
-#ifdef USE_PTHREAD
-#error The Windows version of OpenVPN does not support PTHREAD yet
-#endif
-
-#ifdef _MSC_VER
-/* MSVC++ hacks */
-#pragma warning(disable:4244) // conversion from 'foo' to 'bar', possible =
loss of data
-#pragma warning(disable:4018) // signed/unsigned mismatch
-#include <io.h>
-#include <direct.h>
-//#define vsnprintf _vsnprintf
-//#define vsnwprintf _vsnwprintf
-#define snwprintf _snwprintf
-#define write _write
-#define open _open
-#define read _read
-#define close _close
-#define lseek _lseek
-#define chdir _chdir
-#define strdup _strdup
-#define strcasecmp _stricmp
-#define chsize _chsize
-#define S_IRUSR 0
-#define S_IWUSR 0
-#define TV_SEC_CAST (long)
-#define TV_USEC_CAST (long)
-typedef int intptr_t;
-/* Visual Studio 2005 supports vararg macros */
-#if _MSC_VER >=3D 1400
-#define HAVE_CPP_VARARG_MACRO_ISO 1
-#endif
-#endif
diff --git a/openvpn.8 b/openvpn.8
index 298c79a..525ddd5 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -3274,7 +3274,7 @@ Authenticate with server using username/password.
 is a file containing username/password on 2 lines (Note: OpenVPN
 will only read passwords from a file if it has been built
 with the \-\-enable-password-save configure option, or on Windows
-by defining ENABLE_PASSWORD_SAVE in config-win32.h).
+by defining ENABLE_PASSWORD_SAVE in win/settings.in).
=20
 If
 .B up
@@ -4227,7 +4227,7 @@ to a certain extent invalidates the extra security pr=
ovided by
 using an encrypted key (Note: OpenVPN
 will only read passwords from a file if it has been built
 with the \-\-enable-password-save configure option, or on Windows
-by defining ENABLE_PASSWORD_SAVE in config-win32.h).
+by defining ENABLE_PASSWORD_SAVE in win/settings.in).
 .\"*********************************************************
 .TP
 .B \-\-auth-nocache
diff --git a/service-win32/openvpnserv.c b/service-win32/openvpnserv.c
index d0cfd9b..b5d8d37 100755
--- a/service-win32/openvpnserv.c
+++ b/service-win32/openvpnserv.c
@@ -33,11 +33,7 @@
  * This code is designed to be built with the mingw compiler.
  */
=20
-#ifdef _MSC_VER
-#include "config-win32.h"
-#else
 #include "config.h"
-#endif
 #include <windows.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/syshead.h b/syshead.h
index d75f881..cef7dbf 100644
--- a/syshead.h
+++ b/syshead.h
@@ -29,12 +29,8 @@
  * Only include if not during configure
  */
 #ifndef PACKAGE_NAME
-#ifdef _MSC_VER
-#include "config-win32.h"
-#else
 #include "config.h"
 #endif
-#endif
=20
 /* branch prediction hints */
 #if defined(__GNUC__)
diff --git a/tap-win32/SOURCES.in b/tap-win32/SOURCES.in
index b7f0e18..cf030f4 100755
--- a/tap-win32/SOURCES.in
+++ b/tap-win32/SOURCES.in
@@ -11,8 +11,7 @@ TARGETLIBS=3D$(DDK_LIB_PATH)\ndis.lib $(DDK_LIB_PATH)\nts=
trsafe.lib
 INCLUDES=3D$(DDK_INCLUDE_PATH) ..
=20
 # The TAP version numbers here must be >=3D
-# TAP_WIN32_MIN_x values defined in
-# config-win32.h
+# PRODUCT_TAP_WIN32_MIN_x values defined in version.m4
 C_DEFINES=3D
 C_DEFINES=3D$(C_DEFINES) -DTAP_DRIVER_MAJOR_VERSION=3D@@PRODUCT_TAP_MAJOR_=
VER@@
 C_DEFINES=3D$(C_DEFINES) -DTAP_DRIVER_MINOR_VERSION=3D@@PRODUCT_TAP_MINOR_=
VER@@
diff --git a/win/config.h.in b/win/config.h.in
new file mode 100644
index 0000000..fb349d0
--- /dev/null
+++ b/win/config.h.in
@@ -0,0 +1,316 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * Configuration header for Win32 using the MSVC environment.
+ */
+
+#include <windows.h>
+#include <winsock2.h>
+#include "autodefs.h" /* machine generated */
+
+//#define sleep(x) Sleep((x)*1000)
+
+//#define random rand
+//#define srandom srand
+
+typedef unsigned long in_addr_t;
+
+#ifndef _SSIZE_T_
+#define _SSIZE_T_
+ typedef unsigned int ssize_t;
+#endif
+
+/* Append a label to program startup title */
+/*#define DEBUG_LABEL "DEBUG1"*/
+
+/* Should we print debug info from driver? */
+#ifdef PRODUCT_TAP_DEBUG
+#define TAP_WIN32_DEBUG
+#endif
+
+/* Enable reading credentials from a file */
+#if @ENABLE_PASSWORD_SAVE@ !=3D 0
+#define ENABLE_PASSWORD_SAVE @ENABLE_PASSWORD_SAVE@
+#endif
+
+/* Enable client/server capability */
+#if @ENABLE_CLIENT_SERVER@ !=3D 0
+#define ENABLE_CLIENT_SERVER @ENABLE_CLIENT_SERVER@
+#endif
+
+/* Enable client capability only */
+#if @ENABLE_CLIENT_ONLY@ !=3D 0
+#define ENABLE_CLIENT_ONLY @ENABLE_CLIENT_ONLY@
+#endif
+
+/* Enable management server capability */
+#if @ENABLE_MANAGEMENT@ !=3D 0
+#define ENABLE_MANAGEMENT @ENABLE_MANAGEMENT@
+#endif
+
+/* Enable PKCS#11 support */
+/* #define USE_PKCS11 1 */
+
+/* Enable HTTP proxy support */
+#if @ENABLE_HTTP_PROXY@ !=3D 0
+#define ENABLE_HTTP_PROXY @ENABLE_HTTP_PROXY@
+#endif
+
+/* Enable Socks proxy support */
+#if @ENABLE_SOCKS@ !=3D 0
+#define ENABLE_SOCKS @ENABLE_SOCKS@
+#endif
+
+/* Enable internal fragmentation support */
+#if @ENABLE_FRAGMENT@ !=3D 0
+#define ENABLE_FRAGMENT @ENABLE_FRAGMENT@
+#endif
+
+/* Enable smaller executable size */
+/* #undef ENABLE_SMALL */
+
+/* Enable debugging support */
+#if @ENABLE_DEBUG@ !=3D 0
+#define ENABLE_DEBUG @ENABLE_DEBUG@
+#endif
+
+/* if defined, will allow usage of the --plugin directive */
+#define USE_LOAD_LIBRARY
+
+/* Dimension size to use for empty array declaration */
+#define EMPTY_ARRAY_SIZE 0
+
+/* Define to 1 if you have the `getsockname' function. */
+#define HAVE_GETSOCKNAME 1
+
+/* Define to 1 if you have the <openssl/engine.h> header file. */
+#define HAVE_OPENSSL_ENGINE_H 1
+
+/* Define to 1 if you have the `ENGINE_load_builtin_engines' function. */
+#define HAVE_ENGINE_LOAD_BUILTIN_ENGINES 1
+
+/* Define to 1 if you have the `ENGINE_register_all_complete' function. */
+#define HAVE_ENGINE_REGISTER_ALL_COMPLETE 1
+
+/* Define to 1 if you have the `ENGINE_cleanup' function. */
+#define HAVE_ENGINE_CLEANUP 1
+
+/* gettimeofday() is implemented in otime.c for Windows */
+#define HAVE_GETTIMEOFDAY 1
+
+/* Define to 1 if you have the 'chsize' function. */
+#define HAVE_CHSIZE 1
+
+/* Define to 1 if you have the `chdir' function. */
+#define HAVE_CHDIR 1
+
+/* Define to 1 if your compiler supports GNU GCC-style variadic macros */
+#ifndef _MSC_VER /* Defines MSFT compiler version. Defined as 1200 for MSV=
C++ 6.0. */
+#define HAVE_CPP_VARARG_MACRO_GCC 1
+#endif
+
+/* Define to 1 if you have the <ctype.h> header file. */
+#define HAVE_CTYPE_H 1
+
+/* Define to 1 if you have the <errno.h> header file. */
+#define HAVE_ERRNO_H 1
+
+/* Define to 1 if you have the `EVP_CIPHER_CTX_set_key_length' function. */
+#define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
+
+/* Define to 1 if you have the <fcntl.h> header file. */
+#define HAVE_FCNTL_H 1
+
+/* Define to 1 if you have the `getsockopt' function. */
+#define HAVE_GETSOCKOPT 1
+
+/* Define to 1 if you have the `inet_ntoa' function. */
+#define HAVE_INET_NTOA 1
+
+/* Define to 1 if your system has a GNU libc compatible `malloc' function,=
 and
+   to 0 otherwise. */
+#define HAVE_MALLOC 1
+
+/* Define to 1 if you have the `memset' function. */
+#define HAVE_MEMSET 1
+
+/* Define to 1 if you have the `setsockopt' function. */
+#define HAVE_SETSOCKOPT 1
+
+/* Define to 1 if you have the `socket' function. */
+#define HAVE_SOCKET 1
+
+/* Define to 1 if you have the <stdarg.h> header file. */
+#define HAVE_STDARG_H 1
+
+/* Define to 1 if you have the <stdint.h> header file. */
+#ifndef _MSC_VER
+#define HAVE_STDINT_H 1
+#endif
+
+/* Define to 1 if you have the <stdio.h> header file. */
+#define HAVE_STDIO_H 1
+
+/* Define to 1 if you have the <stdlib.h> header file. */
+#define HAVE_STDLIB_H 1
+
+/* Define to 1 if you have the `strerror' function. */
+#define HAVE_STRERROR 1
+
+/* Define to 1 if you have the <strings.h> header file. */
+#define HAVE_STRINGS_H 1
+
+/* Define to 1 if you have the <string.h> header file. */
+#define HAVE_STRING_H 1
+
+/* Define to 1 if you have the `system' function. */
+#define HAVE_SYSTEM 1
+
+/* Define to 1 if you have the <sys/file.h> header file. */
+#ifndef _MSC_VER
+#define HAVE_SYS_FILE_H 1
+#endif
+
+/* Define to 1 if you have the <sys/stat.h> header file. */
+#define HAVE_SYS_STAT_H 1
+
+/* Define to 1 if you have the <sys/time.h> header file. */
+#ifndef _MSC_VER
+#define HAVE_SYS_TIME_H 1
+#endif
+
+/* Define to 1 if you have the <sys/types.h> header file. */
+#define HAVE_SYS_TYPES_H 1
+
+/* Define to 1 if you have the `time' function. */
+#define HAVE_TIME 1
+
+/* Define to 1 if you have the <unistd.h> header file. */
+#ifndef _MSC_VER
+#define HAVE_UNISTD_H 1
+#endif
+
+/* Define to 1 if you have the `vsnprintf' function. */
+#define HAVE_VSNPRINTF 1
+
+/* Special Windows version of getpass() defined in io.c */
+#define HAVE_GETPASS 1
+
+/* Define to the full name and version of this package. */
+#ifdef DEBUG_LABEL
+#define PACKAGE_STRING PACKAGE_NAME " " PACKAGE_VERSION " " DEBUG_LABEL
+#else
+#define PACKAGE_STRING PACKAGE_NAME " " PACKAGE_VERSION
+#endif
+
+/* Define as the return type of signal handlers (`int' or `void'). */
+#define RETSIGTYPE void
+
+/* The size of a `unsigned int', as computed by sizeof. */
+#define SIZEOF_UNSIGNED_INT 4
+
+/* The size of a `unsigned long', as computed by sizeof. */
+#define SIZEOF_UNSIGNED_LONG 4
+
+/* Define to 1 if you have the ANSI C header files. */
+#define STDC_HEADERS 1
+
+/* A string representing our target */
+#ifdef _MSC_VER
+#define TARGET_ALIAS "Win32-MSVC++"
+#else
+#define TARGET_ALIAS "Win32-MinGW"
+#endif
+
+/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
+#ifndef _MSC_VER
+#define TIME_WITH_SYS_TIME 1
+#endif
+
+/* Use OpenSSL crypto library */
+#define USE_CRYPTO 1
+
+/* Use LZO compression library */
+#define USE_LZO 1
+
+/* LZO version number */
+#define LZO_VERSION_NUM "2"
+
+/* Use lzo/ directory prefix for LZO header files (for LZO 2.0) */
+#define LZO_HEADER_DIR 1
+
+/* Use OpenSSL SSL library */
+#define USE_SSL 1
+
+/* Version number of package */
+#define VERSION PACKAGE_VERSION
+
+/* Define as `__inline' if that's what the C compiler calls it, or to noth=
ing
+   if it is not supported. */
+#define inline __inline
+
+/* type to use in place of socklen_t if not defined */
+#define socklen_t unsigned int
+
+/* 32-bit unsigned type */
+#define uint32_t unsigned int
+
+/* 16-bit unsigned type */
+#define uint16_t unsigned short
+
+/* 8-bit unsigned type */
+#define uint8_t unsigned char
+
+/* Route command */
+#define ROUTE_PATH "route"
+
+#ifdef _MSC_VER
+/* MSVC++ hacks */
+#pragma warning(disable:4244) // conversion from 'foo' to 'bar', possible =
loss of data
+#pragma warning(disable:4018) // signed/unsigned mismatch
+#include <io.h>
+#include <direct.h>
+//#define vsnprintf _vsnprintf
+//#define vsnwprintf _vsnwprintf
+#define snwprintf _snwprintf
+#define write _write
+#define open _open
+#define read _read
+#define close _close
+#define lseek _lseek
+#define chdir _chdir
+#define strdup _strdup
+#define strcasecmp _stricmp
+#define chsize _chsize
+#define S_IRUSR 0
+#define S_IWUSR 0
+#define TV_SEC_CAST (long)
+#define TV_USEC_CAST (long)
+typedef int intptr_t;
+/* Visual Studio 2005 supports vararg macros */
+#if _MSC_VER >=3D 1400
+#define HAVE_CPP_VARARG_MACRO_ISO 1
+#endif
+#endif
diff --git a/win/config.py b/win/config.py
index 2c57004..b820510 100644
--- a/win/config.py
+++ b/win/config.py
@@ -1,20 +1,21 @@
-from wb import preprocess, autogen, mod_fn, home_fn, build_configure_h, bu=
ild_version_m4_vars, build_autodefs, make_headers_objs, dict_def
-
-def main(config):
+from wb import preprocess, autogen, mod_fn, home_fn, build_config_h, build=
_configure_h, build_version_m4_vars, build_autodefs, make_headers_objs, dic=
t_def
+
+def main(config):
+    build_config_h(config)
     build_configure_h(config, mod_fn(home_fn('configure.h')), head_comment=
=3D'/* %s */\n\n' % autogen)
     build_version_m4_vars(mod_fn(mod_fn('version_m4_vars.tmp')), head_comm=
ent=3D'/* %s */\n\n' % autogen)
-    build_autodefs(config, mod_fn('autodefs.h.in'), home_fn('autodefs.h'))
-    ho =3D make_headers_objs(home_fn('Makefile.am'))
-
-    preprocess(dict_def(config, [('HEADERS_OBJS', ho)]),
-               in_fn=3Dmod_fn('msvc.mak.in'),
-               out_fn=3Dhome_fn('msvc.mak'),
-               quote_begin=3D'@',
-               quote_end=3D'@',
-               if_prefix=3D'!',
-               head_comment=3D'# %s\n\n' % autogen)
-
-# if we are run directly, and not loaded as a module
-if __name__ =3D=3D "__main__":
-    from wb import config
-    main(config)
+    build_autodefs(config, mod_fn('autodefs.h.in'), home_fn('autodefs.h'))
+    ho =3D make_headers_objs(home_fn('Makefile.am'))
+
+    preprocess(dict_def(config, [('HEADERS_OBJS', ho)]),
+               in_fn=3Dmod_fn('msvc.mak.in'),
+               out_fn=3Dhome_fn('msvc.mak'),
+               quote_begin=3D'@',
+               quote_end=3D'@',
+               if_prefix=3D'!',
+               head_comment=3D'# %s\n\n' % autogen)
+
+# if we are run directly, and not loaded as a module
+if __name__ =3D=3D "__main__":
+    from wb import config
+    main(config)
diff --git a/win/settings.in b/win/settings.in
index 6dded79..a194aec 100644
--- a/win/settings.in
+++ b/win/settings.in
@@ -5,10 +5,18 @@
 # stored in this file. This is done to allow using the old and new Windows=
 build=20
 # systems side-by-side
=20
-# Features to include
+# Features to include. DO NOT comment these out, use 1 to enable and 0 to=
=20
+# disable.
 !define ENABLE_PASSWORD_SAVE 1
+
+# ENABLE_CLIENT_SERVER enables the point-to-multipoint support. Normally y=
ou=20
+# want to have this enabled.
 !define ENABLE_CLIENT_SERVER 1
-!define ENABLE_CLIENT_ONLY
+
+# ENABLE_CLIENT_ONLY removes server-side point-to-multipoint features. Thi=
s=20
+# depends on ENABLE_CLIENT_SERVER being set to 1.
+!define ENABLE_CLIENT_ONLY 0
+
 !define ENABLE_MANAGEMENT 1
 !define ENABLE_HTTP_PROXY 1
 !define ENABLE_SOCKS 1
diff --git a/win/wb.py b/win/wb.py
index 33eefbd..30f6a43 100644
--- a/win/wb.py
+++ b/win/wb.py
@@ -101,10 +101,9 @@ def parse_build_params(kv, settings_in):
                 kv[g[0]] =3D g[1] or ''
     f.close()
=20
-
-def dict_def(dict, newdefs):
-    ret =3D dict.copy()
-    ret.update(newdefs)
+def dict_def(dict, newdefs):
+    ret =3D dict.copy()
+    ret.update(newdefs)
     return ret
=20
 def build_autodefs(kv, autodefs_in, autodefs_out):
@@ -112,9 +111,18 @@ def build_autodefs(kv, autodefs_in, autodefs_out):
                in_fn=3Dautodefs_in,
                out_fn=3Dautodefs_out,
                quote_begin=3D'@',
-               quote_end=3D'@',
-               head_comment=3D'/* %s */\n\n' % autogen)
-
+               quote_end=3D'@',
+               head_comment=3D'/* %s */\n\n' % autogen)
+
+def build_config_h(kv):
+    """Generate static win/config.h to config.h to mimic autotools behavio=
r"""
+    preprocess(kv,
+               in_fn=3Dmod_fn('config.h.in'),
+               out_fn=3Dhome_fn('config.h'),
+               quote_begin=3D'@',
+               quote_end=3D'@',
+               head_comment=3D'/* %s */\n\n' % autogen)
+
 def build_configure_h(kv, configure_h_out, head_comment):
     """Generate a configure.h dynamically"""
     fout =3D open(configure_h_out, 'w')
@@ -163,11 +171,9 @@ win/settings.in format. This done to allow importing t=
hem in win/openvpn.nsi"""
=20
     fout.close()
=20
-
-
-def preprocess(kv, in_fn, out_fn, quote_begin=3DNone, quote_end=3DNone, if=
_prefix=3DNone, head_comment=3DNone):
-    def repfn(m):
-        var, =3D m.groups()
+def preprocess(kv, in_fn, out_fn, quote_begin=3DNone, quote_end=3DNone, if=
_prefix=3DNone, head_comment=3DNone):
+    def repfn(m):
+        var, =3D m.groups()
         return kv.get(var, '')
=20
     re_macro =3D re_ifdef =3D None
--=20
1.6.3.3


