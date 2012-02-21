From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:26 +0200
Message-Id: <1329787361-26096-21-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 20/35] build: autotools: first pass of
	trivial autotools changes
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
 Makefile.am  |   12 +-
 configure.ac | 1227 +++++++++++++++++++++++++++-------------------------------
 lladdr.c     |    2 +-
 misc.c       |    2 +-
 misc.h       |    2 +-
 options.c    |   12 +-
 route.c      |   18 +-
 socket.c     |    2 +-
 syshead.h    |   39 +--
 tun.c        |    6 +-
 version.m4   |   11 +-
 win32.h      |   11 -
 12 files changed, 624 insertions(+), 720 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6d7c55f..c198238 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,11 +23,9 @@
 #  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 #
 
-LDADD = @LIBOBJS@
-
 # This option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
-AUTOMAKE_OPTIONS = foreign
+AUTOMAKE_OPTIONS = foreign 1.10
 ACLOCAL_AMFLAGS = -I m4
 
 MAINTAINERCLEANFILES = \
@@ -64,10 +62,13 @@ dist_noinst_SCRIPTS = \
 	configure_h.awk configure_log.awk
 
 dist_noinst_DATA = \
+	.gitignore \
 	openvpn.spec \
 	COPYRIGHT.GPL \
 	PORTS \
-	INSTALL-win32.txt
+	INSTALL-win32.txt \
+	README.IPv6 TODO.IPv6 \
+	README.polarssl \
 
 openvpn_SOURCES = \
         base64.c base64.h \
@@ -155,9 +156,6 @@ configure.h: Makefile
 	awk -f $(srcdir)/configure_h.awk config.h > $@
 	awk -f $(srcdir)/configure_log.awk config.log >> $@
 
-dist-hook:
-	cd $(distdir) && for i in $(EXTRA_DIST) $(SUBDIRS) ; do find $$i -name .svn -type d -prune -exec rm -rf '{}' ';' ; rm -f `find $$i -type f | grep -E '(^|\/)\.?\#|\~$$|\.s?o$$'` ; done
-
 if WIN32
 dist_noinst_DATA += openvpn.8
 nodist_html_DATA = openvpn.8.html
diff --git a/configure.ac b/configure.ac
index 69a3736..3dcc23c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -5,6 +5,7 @@ dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
 dnl  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+dnl  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
 dnl  it under the terms of the GNU General Public License as published by
@@ -23,346 +24,341 @@ dnl  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
 dnl Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.50)
+AC_PREREQ(2.60)
 
 m4_include(version.m4)
-AC_INIT([OpenVPN], [PRODUCT_VERSION], [openvpn-users@lists.sourceforge.net], [openvpn])
-AM_CONFIG_HEADER(config.h)
-AC_CONFIG_SRCDIR(syshead.h)
-
-dnl Guess host type.
-AC_CANONICAL_HOST
+AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRODUCT_TARNAME])
+AC_CONFIG_AUX_DIR([.])
+AM_CONFIG_HEADER([config.h])
+AC_CONFIG_SRCDIR([syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
-AM_INIT_AUTOMAKE(openvpn, [$PACKAGE_VERSION])
-
-AC_ARG_WITH(cygwin-native,
-	[  --with-cygwin-native              Compile native win32],
-	[CYGWIN_NATIVE="${withval}"],
-	[CYGWIN_NATIVE="no"]
-)
-
-WIN32="no"
-CYGWIN="no"
-case "${host}" in
-	*-mingw*)
-		WIN32="yes"
-		cross_compiling="yes"
-	;;
-	*-*-cygwin*)
-		AC_MSG_CHECKING([cygwin mode to use])
-		if test "${CYGWIN_NATIVE}" = "yes"; then
-			AC_MSG_RESULT([Using native win32])
-			CFLAGS="${CFLAGS} -mno-cygwin"
-			CYGWIN="yes"
-			WIN32="yes"
-		else
-			AC_MSG_RESULT([Using cygwin])
-		fi
-	;;
-	*)
-	;;
-esac
-
-AC_ARG_ENABLE(lzo,
-   [  --disable-lzo           Disable LZO compression support],
-   [LZO="$enableval"],
-   [LZO="yes"]
-)
+AM_INIT_AUTOMAKE
+AC_CANONICAL_HOST
+AC_USE_SYSTEM_EXTENSIONS
 
-AC_ARG_ENABLE(lzo-stub,
-   [  --enable-lzo-stub       Don't compile LZO compression support but still allow limited interoperability with LZO-enabled peers],
-   [LZO_STUB="$enableval"],
-   [LZO_STUB="no"]
+AC_ARG_ENABLE(
+	[lzo],
+	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support])],
+	,
+	[enable_lzo="yes"]
 )
 
-AC_ARG_ENABLE(crypto,
-   [  --disable-crypto        Disable crypto support],
-   [CRYPTO="$enableval"],
-   [CRYPTO="yes"]
+AC_ARG_ENABLE(
+	[lzo-stub],
+	[AS_HELP_STRING([--enable-lzo-stub], [don't compile LZO compression support but still allow limited interoperability with LZO-enabled peers])],
+	,
+	[enable_lzo_stub="no"]
 )
 
-AC_ARG_ENABLE(ssl,
-   [  --disable-ssl           Disable SSL support for TLS-based key exchange],
-   [SSL="$enableval"],
-   [SSL="yes"]
+AC_ARG_ENABLE(
+	[crypto],
+	[AS_HELP_STRING([--disable-crypto], [disable crypto support])],
+	,
+	[enable_crypto="yes"]
 )
 
-AC_ARG_ENABLE(x509-alt-username,
-   [  --enable-x509-alt-username    Enable the --x509-username-field feature],
-   [X509ALTUSERNAME="$enableval"],
-   [X509ALTUSERNAME="no"]
+AC_ARG_ENABLE(
+	[ssl],
+	[AS_HELP_STRING([--disable-ssl], [disable SSL support for TLS-based key exchange])],
+	,
+	[enable_ssl="yes"]
 )
 
-AC_ARG_ENABLE(multi,
-   [  --disable-multi         Disable client/server support (--mode server + client mode)],
-   [MULTI="$enableval"],
-   [MULTI="yes"]
+AC_ARG_ENABLE(
+	[x509-alt-username],
+	[AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username-field feature])],
+	,
+	[enable_x509_alt_username="no"]
 )
 
-AC_ARG_ENABLE(server,
-   [  --disable-server        Disable server support only (but retain client support)],
-   [MULTI_SERVER="$enableval"],
-   [MULTI_SERVER="yes"]
+AC_ARG_ENABLE(
+	[multi],
+	[AS_HELP_STRING([--disable-multi], [disable client/server support (--mode server + client mode)])],
+	,
+	[enable_multi="yes"]
 )
 
-AC_ARG_ENABLE(plugins,
-   [  --disable-plugins       Disable plug-in support],
-   [PLUGINS="$enableval"],
-   [PLUGINS="yes"]
+AC_ARG_ENABLE(
+	[server],
+	[AS_HELP_STRING([--disable-server], [disable server support only (but retain client support)])],
+	,
+	[enable_server="yes"]
 )
 
-AC_ARG_ENABLE(eurephia,
-   [  --disable-eurephia      Disable support for the eurephia plug-in],
-   [EUREPHIA="$enableval"],
-   [EUREPHIA="yes"]
+AC_ARG_ENABLE(
+	[plugins],
+	[AS_HELP_STRING([--disable-plugins], [disable plug-in support])],
+	,
+	[enable_plugins="yes"]
 )
 
-AC_ARG_ENABLE(management,
-   [  --disable-management    Disable management server support],
-   [MANAGEMENT="$enableval"],
-   [MANAGEMENT="yes"]
+AC_ARG_ENABLE(
+	[eurephia],
+	[AS_HELP_STRING([--disable-eurephia], [disable support for the eurephia plug-in])],
+	,
+	[enable_eurephia="yes"]
 )
 
-AC_ARG_ENABLE(pkcs11,
-   [  --disable-pkcs11        Disable pkcs11 support],
-   [PKCS11="$enableval"],
-   [PKCS11="yes"]
+AC_ARG_ENABLE(
+	[management],
+	[AS_HELP_STRING([--disable-management], [disable management server support])],
+	,
+	[enable_management="yes"]
 )
 
-AC_ARG_ENABLE(socks,
-   [  --disable-socks         Disable Socks support],
-   [SOCKS="$enableval"],
-   [SOCKS="yes"]
+AC_ARG_ENABLE(
+	[pkcs11],
+	[AS_HELP_STRING([--disable-pkcs11], [disable pkcs11 support])],
+	,
+	[enable_pkcs11="yes"]
 )
 
-AC_ARG_ENABLE(http,
-   [  --disable-http          Disable HTTP proxy support],
-   [HTTP_PROXY="$enableval"],
-   [HTTP_PROXY="yes"]
+AC_ARG_ENABLE(
+	[socks],
+	[AS_HELP_STRING([--disable-socks], [disable Socks support])],
+	,
+	[enable_socks="yes"]
 )
 
-AC_ARG_ENABLE(fragment,
-   [  --disable-fragment      Disable internal fragmentation support (--fragment)],
-   [FRAGMENT="$enableval"],
-   [FRAGMENT="yes"]
+AC_ARG_ENABLE(
+	[http-proxy],
+	[AS_HELP_STRING([--disable-http-proxy], [disable HTTP proxy support])],
+	,
+	[enable_http_proxy="yes"]
 )
 
-AC_ARG_ENABLE(multihome,
-   [  --disable-multihome     Disable multi-homed UDP server support (--multihome)],
-   [MULTIHOME="$enableval"],
-   [MULTIHOME="yes"]
+AC_ARG_ENABLE(
+	[fragment],
+	[AS_HELP_STRING([--disable-fragment], [disable internal fragmentation support (--fragment)])],
+	,
+	[enable_fragment="yes"]
 )
 
-AC_ARG_ENABLE(port-share,
-   [  --disable-port-share    Disable TCP server port-share support (--port-share)],
-   [PORT_SHARE="$enableval"],
-   [PORT_SHARE="yes"]
+AC_ARG_ENABLE(
+	[multihome],
+	[AS_HELP_STRING([--disable-multihome], [disable multi-homed UDP server support (--multihome)])],
+	,
+	[enable_multihome="yes"]
 )
 
-AC_ARG_ENABLE(debug,
-   [  --disable-debug         Disable debugging support (disable gremlin and verb 7+ messages)],
-   [DEBUG="$enableval"],
-   [DEBUG="yes"]
+AC_ARG_ENABLE(
+	[port-share],
+	[AS_HELP_STRING([--disable-port-share], [disable TCP server port-share support (--port-share)])],
+	,
+	[enable_port_share="yes"]
 )
 
-AC_ARG_ENABLE(small,
-   [  --enable-small          Enable smaller executable size (disable OCC, usage message, and verb 4 parm list)],
-   [SMALL="$enableval"],
-   [SMALL="no"]
+AC_ARG_ENABLE(
+	[debug],
+	[AS_HELP_STRING([--disable-debug], [disable debugging support (disable gremlin and verb 7+ messages)])],
+	,
+	[enable_debug="yes"]
 )
 
-AC_ARG_ENABLE(password-save,
-   [  --enable-password-save  Allow --askpass and --auth-user-pass passwords to be read from a file],
-   [PASSWORD_SAVE="$enableval"],
-   [PASSWORD_SAVE="no"]
+AC_ARG_ENABLE(
+	[small],
+	[AS_HELP_STRING([--enable-small], [enable smaller executable size (disable OCC, usage message, and verb 4 parm list)])],
+	,
+	[enable_small="no"]
 )
 
-AC_ARG_ENABLE(iproute2,
-   [  --enable-iproute2       Enable support for iproute2],
-   test $enableval = "yes" && AC_DEFINE(CONFIG_FEATURE_IPROUTE, 1, [enable iproute2 support])   
+AC_ARG_ENABLE(
+	[password-save],
+	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file])],
+	[enable_password_save="no"]
 )
 
-AC_ARG_ENABLE(def-auth,
-   [  --disable-def-auth      Disable deferred authentication],
-   [DEF_AUTH="$enableval"],
-   [DEF_AUTH="yes"]
+AC_ARG_ENABLE(
+	[iproute2],
+	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2])],
+	,
+	[enable_iproute2="no"]
 )
 
-AC_ARG_ENABLE(pf,
-   [  --disable-pf            Disable internal packet filter],
-   [PF="$enableval"],
-   [PF="yes"]
+AC_ARG_ENABLE(
+	[def-auth],
+	[AS_HELP_STRING([--disable-def-auth], [disable deferred authentication])],
+	,
+	[enable_def_auth="yes"]
 )
 
-AC_ARG_ENABLE(strict,
-   [  --enable-strict         Enable strict compiler warnings (debugging option)],
-   [STRICT="$enableval"],
-   [STRICT="no"]
+AC_ARG_ENABLE(
+	[pf],
+	[AS_HELP_STRING([--disable-pf], [disable internal packet filter])],
+	,
+	[enable_pf="yes"]
 )
 
-AC_ARG_ENABLE(pedantic,
-   [  --enable-pedantic       Enable pedantic compiler warnings, will not generate a working executable (debugging option)],
-   [PEDANTIC="$enableval"],
-   [PEDANTIC="no"]
+AC_ARG_ENABLE(
+	[strict],
+	[AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debugging option)])],
+	,
+	[enable_strict="no"]
 )
 
-AC_ARG_ENABLE(profiling,
-   [  --enable-profiling      Enable profiling (debugging option)],
-   [PROFILE="$enableval"],
-   [PROFILE="no"]
+AC_ARG_ENABLE(
+	[pedantic],
+	[AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler warnings, will not generate a working executable (debugging option)])],
+	,
+	[enable_pedantic="no"]
 )
 
-AC_ARG_ENABLE(strict-options,
-   [  --enable-strict-options Enable strict options check between peers (debugging option)],
-   [STRICT_OPTIONS="$enableval"],
-   [STRICT_OPTIONS="no"]
+AC_ARG_ENABLE(
+	[strict-options],
+	[AS_HELP_STRING([--enable-strict-options], [enable strict options check between peers (debugging option)])],
+	,
+	[enable_strict_options="no"]
 )
 
-AC_ARG_ENABLE(selinux,
-   [  --disable-selinux       Disable SELinux support],
-   [SELINUX="$enableval"],
-   [SELINUX="yes"]
+AC_ARG_ENABLE(
+	[selinux],
+	[AS_HELP_STRING([--disable-selinux], [disable SELinux support])],
+	,
+	[enable_selinux="no"]
 )
 
-AC_ARG_ENABLE(systemd,
-   [  --enable-systemd        Enable systemd suppport],
-   [SYSTEMD="$enableval"],
-   [SYSTEMD="no"]
+AC_ARG_ENABLE(
+	[systemd],
+	[AS_HELP_STRING([--enable-systemd], [enable systemd suppport])],
+	,
+	[enable_systemd="no"]
 )
 
-AC_ARG_WITH(ssl-headers,
-   [  --with-ssl-headers=DIR  Crypto/SSL Include files location],
-   [CS_HDR_DIR="$withval"]
-   [CPPFLAGS="$CPPFLAGS -I$withval"] 
+AC_ARG_WITH(
+	[ssl-headers],
+	[AS_HELP_STRING([--with-ssl-headers=DIR], [Crypto/SSL Include files location])],
+	[CS_HDR_DIR="$withval"]
+	[CPPFLAGS="$CPPFLAGS -I$withval"] 
 )
 
-AC_ARG_WITH(ssl-lib,
-   [  --with-ssl-lib=DIR      Crypto/SSL Library location],
-   [LDFLAGS="$LDFLAGS -L$withval"] 
+AC_ARG_WITH(
+	[ssl-lib],
+	[AS_HELP_STRING([--with-ssl-lib=DIR], [Crypto/SSL Library location])],
+	[LDFLAGS="$LDFLAGS -L$withval"] 
 )
 
-AC_ARG_WITH(lzo-headers,
-   [  --with-lzo-headers=DIR  LZO Include files location],
-   [LZO_HDR_DIR="$withval"]
-   [CPPFLAGS="$CPPFLAGS -I$withval"] 
+AC_ARG_WITH(
+	[lzo-headers],
+	[AS_HELP_STRING([--with-lzo-headers=DIR], [LZO Include files location])],
+	[LZO_HDR_DIR="$withval"]
+	[CPPFLAGS="$CPPFLAGS -I$withval"] 
 )
 
-AC_ARG_WITH(lzo-lib,
-   [  --with-lzo-lib=DIR      LZO Library location],
-   [LDFLAGS="$LDFLAGS -L$withval"] 
+AC_ARG_WITH(
+	[lzo-lib],
+	[AS_HELP_STRING([--with-lzo-lib=DIR], [LZO Library location])],
+	[LDFLAGS="$LDFLAGS -L$withval"] 
 )
 
-AC_ARG_WITH(pkcs11-helper-headers,
-   [  --with-pkcs11-helper-headers=DIR pkcs11-helper Include files location],
-   [PKCS11_HELPER_HDR_DIR="$withval"]
-   [CPPFLAGS="$CPPFLAGS -I$withval"] 
+AC_ARG_WITH(
+	[pkcs11-helper-headers],
+	[AS_HELP_STRING([--with-pkcs11-helper-headers=DIR], [pkcs11-helper Include files location])],
+	[PKCS11_HELPER_HDR_DIR="$withval"]
+	[CPPFLAGS="$CPPFLAGS -I$withval"] 
 )
 
-AC_ARG_WITH(pkcs11-helper-lib,
-   [  --with-pkcs11-helper-lib=DIR     pkcs11-helper Library location],
-   [LDFLAGS="$LDFLAGS -L$withval"] 
+AC_ARG_WITH(
+	[pkcs11-helper-lib],
+	[AS_HELP_STRING([--with-pkcs11-helper-lib=DIR], [pkcs11-helper Library location])],
+	[LDFLAGS="$LDFLAGS -L$withval"] 
 )
 
-AC_ARG_WITH(ifconfig-path,
-   [  --with-ifconfig-path=PATH   Path to ifconfig tool],
-   [IFCONFIG="$withval"],
-   [AC_PATH_PROG([IFCONFIG], [ifconfig], [ifconfig], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
+AC_ARG_WITH(
+	[ifconfig-path],
+	[AS_HELP_STRING([--with-ifconfig-path=PATH], [Path to ifconfig tool])],
+	[IFCONFIG="$withval"],
+	[AC_PATH_PROG([IFCONFIG], [ifconfig], [ifconfig], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
 )
-AC_DEFINE_UNQUOTED(IFCONFIG_PATH, "$IFCONFIG", [Path to ifconfig tool])
+AC_DEFINE_UNQUOTED([IFCONFIG_PATH], ["$IFCONFIG"], [Path to ifconfig tool])
 
-AC_ARG_WITH(iproute-path,
-   [  --with-iproute-path=PATH    Path to iproute tool],
-   [IPROUTE="$withval"],
-   [AC_PATH_PROG([IPROUTE], [ip], [ip], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
+AC_ARG_WITH(
+	[iproute-path],
+	[AS_HELP_STRING([--with-iproute-path=PATH], [Path to iproute tool])],
+	[IPROUTE="$withval"],
+	[AC_PATH_PROG([IPROUTE], [ip], [ip], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
 )
-AC_DEFINE_UNQUOTED(IPROUTE_PATH, "$IPROUTE", [Path to iproute tool])
-
+AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
 
-AC_ARG_WITH(route-path,
-   [  --with-route-path=PATH  Path to route tool],
+AC_ARG_WITH([route-path],
+   [AS_HELP_STRING([--with-route-path=PATH], [Path to route tool])],
    [ROUTE="$withval"],
    [AC_PATH_PROG([ROUTE], [route], [route], [$PATH:/usr/local/sbin:/usr/sbin:/sbin])]
 )
-AC_DEFINE_UNQUOTED(ROUTE_PATH, "$ROUTE", [Path to route tool])
+AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
 
-AC_ARG_WITH(netstat-path,
-   [  --with-netstat-path=PATH  Path to netstat tool],
-   [NETSTAT="$withval"],
-   [AC_PATH_PROG([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/usr/sbin:/sbin:/etc])]
+AC_ARG_WITH(
+	[netstat-path],
+	[AS_HELP_STRING([--with-netstat-path=PATH], [Path to netstat tool])],
+	[NETSTAT="$withval"],
+	[AC_PATH_PROG([NETSTAT], [netstat], [netstat], [$PATH:/usr/local/sbin:/usr/sbin:/sbin:/etc])]
 )
-AC_DEFINE_UNQUOTED(NETSTAT_PATH, "$NETSTAT", [Path to netstat tool])
+AC_DEFINE_UNQUOTED([NETSTAT_PATH], ["$NETSTAT"], [Path to netstat tool])
 
-AC_ARG_WITH(mem-check,
-   [  --with-mem-check=TYPE  Build with debug memory checking, TYPE = dmalloc or valgrind],
-   [MEMCHECK="$withval"]
+AC_ARG_WITH(
+	[mem-check],
+	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=dmalloc|valgrind|ssl])],
+	,
+	[with_mem_check="no"]
 )
 
-AC_ARG_WITH([ssl-type],
-   [  --with-ssl-type=TYPE  Build with the given SSL library, TYPE = openssl or polarssl ],
-   [case "${withval}" in 
-        openssl) SSL_LIB=openssl ;;
-        polarssl) SSL_LIB=polarssl ;;
-        *) AC_MSG_ERROR([bad value ${withval} for --with-ssl-type]) ;;
-   esac],
-   [SSL_LIB="openssl"]
+AC_ARG_WITH(
+	[ssl-type],
+	[AS_HELP_STRING([--with-ssl-type=TYPE], [build with the given SSL library, TYPE = openssl or polarssl])],
+	[
+		case "${withval}" in 
+			openssl|polarssl) ;;
+			*) AC_MSG_ERROR([bad value ${withval} for --with-ssl-type]) ;;
+		esac
+	],
+	[with_ssl_type="openssl"]
 )
 
-dnl fix search path, to allow compilers to find syshead.h
-CPPFLAGS="$CPPFLAGS -I${srcdir}"
-
-dnl check host OS
-openvpn_host=$host
-if test $host_alias; then
-  openvpn_host=$host_alias
-fi
-AC_DEFINE_UNQUOTED(TARGET_ALIAS, "$openvpn_host", [A string representing our host])
+AC_DEFINE_UNQUOTED(TARGET_ALIAS, "${host}", [A string representing our host])
 case "$host" in
-*-*-linux*)
-	AC_DEFINE(TARGET_LINUX, 1, [Are we running on Linux?])
-	dnl RH9 SSL headers workaround
-	    if test -z $CS_HDR_DIR && test "$CRYPTO" = "yes"; then
-           CPPFLAGS="$CPPFLAGS $(pkg-config --cflags openssl 2>/dev/null)"
-        fi
-	;;
-*-*-solaris*)
-	AC_DEFINE(TARGET_SOLARIS, 1, [Are we running on Solaris?])
-	;;
-*-*-openbsd*)
-	AC_DEFINE(TARGET_OPENBSD, 1, [Are we running on OpenBSD?])
-	;;
-*-*-freebsd*)
-	AC_DEFINE(TARGET_FREEBSD, 1, [Are we running on FreeBSD?])
-	;;
-*-*-netbsd*)
-	AC_DEFINE(TARGET_NETBSD, 1, [Are we running NetBSD?])
-	;;
-*-*-darwin*)
-	dnl some Mac OS X tendering (we use vararg macros...)
-	AC_DEFINE(TARGET_DARWIN, 1, [Are we running on Mac OS X?])
-	CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
-	;;
-*-mingw*)
-	AC_DEFINE(TARGET_WIN32, 1, [Are we running WIN32?])
-	CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=0x0501"
-	OPENVPN_ADD_LIBS(-lgdi32)
-	OPENVPN_ADD_LIBS(-lws2_32)
-	OPENVPN_ADD_LIBS(-lwininet)
-	OPENVPN_ADD_LIBS(-lcrypt32)
-	OPENVPN_ADD_LIBS(-liphlpapi)
-	OPENVPN_ADD_LIBS(-lwinmm)
-	OPENVPN_ADD_LIBS(-lshell32)
-	;;
-*-*-dragonfly*)
-	AC_DEFINE(TARGET_DRAGONFLY, 1, [Are we running on DragonFlyBSD?])
-	;;
-	
+	*-*-linux*)
+		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
+		;;
+	*-*-solaris*)
+		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
+		;;
+	*-*-openbsd*)
+		AC_DEFINE([TARGET_OPENBSD], [1], [Are we running on OpenBSD?])
+		;;
+	*-*-freebsd*)
+		AC_DEFINE([TARGET_FREEBSD], [1], [Are we running on FreeBSD?])
+		;;
+	*-*-netbsd*)
+		AC_DEFINE([TARGET_NETBSD], [1], [Are we running NetBSD?])
+		;;
+	*-*-darwin*)
+		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
+		dnl some Mac OS X tendering (we use vararg macros...)
+		CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
+		;;
+	*-mingw*)
+		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
+		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -D_POSIX -DWINVER=0x0501"
+		WIN32=yes
+		OPENVPN_ADD_LIBS(-lgdi32)
+		OPENVPN_ADD_LIBS(-lws2_32)
+		OPENVPN_ADD_LIBS(-lwininet)
+		OPENVPN_ADD_LIBS(-lcrypt32)
+		OPENVPN_ADD_LIBS(-liphlpapi)
+		OPENVPN_ADD_LIBS(-lwinmm)
+		OPENVPN_ADD_LIBS(-lshell32)
+		;;
+	*-*-dragonfly*)
+		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
+		;;
 esac
 
-dnl Checks for programs.
-AC_PROG_CC
+PKG_PROG_PKG_CONFIG
+AC_PROG_CPP
 AC_PROG_INSTALL
-AC_PROG_GCC_TRADITIONAL
-AC_GNU_SOURCE
+AC_PROG_LN_S
+AC_PROG_MKDIR_P
+AC_PROG_SED
+AC_PROG_MAKE_SET
 
 if test "${WIN32}" = "yes"; then
 	AC_ARG_VAR([MAN2HTML], [man2html utility])
@@ -370,315 +366,331 @@ if test "${WIN32}" = "yes"; then
 	test -z "${MAN2HTML}" && AC_MSG_ERROR([man2html is required for win32])
 fi
 
-dnl Checks for header files.
-AC_HEADER_STDC
-
-dnl Checks for typedefs, structures, and compiler characteristics.
 AC_C_CONST
 AC_C_INLINE
 AC_C_VOLATILE
 AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
+AC_TYPE_SSIZE_T
 AC_TYPE_UID_T
-AC_HEADER_TIME
+AC_TYPE_INT8_T
+AC_TYPE_INT16_T
+AC_TYPE_INT32_T
+AC_TYPE_INT64_T
+AC_TYPE_UINT8_T
+AC_TYPE_UINT16_T
+AC_TYPE_UINT32_T
+AC_TYPE_UINT64_T
+AC_TYPE_SIGNAL
 AX_CPP_VARARG_MACRO_ISO
 AX_CPP_VARARG_MACRO_GCC
 AX_TYPE_SOCKLEN_T
 AX_EMPTY_ARRAY
+AC_CHECK_SIZEOF([unsigned int])
+AC_CHECK_SIZEOF([unsigned long])
+AC_CHECK_HEADERS([ \
+	stdio.h stdarg.h \
+	time.h errno.h fcntl.h io.h direct.h \
+	ctype.h sys/types.h sys/socket.h \
+	signal.h unistd.h \
+	netinet/in.h netinet/in_systm.h \
+	netinet/tcp.h arpa/inet.h netdb.h \
+	windows.h winsock2.h ws2tcpip.h \
+])
 
-dnl Check for more header files.
-AC_CHECK_HEADERS(fcntl.h stdlib.h dnl
-		 stdarg.h stdio.h string.h dnl
-		 strings.h ctype.h errno.h dnl
-)
+SOCKET_INCLUDES="
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
+#ifdef HAVE_SYS_TYPES_H
+#include <sys/types.h>
+#endif
+#ifdef HAVE_SYS_SOCKET_H
+#include <sys/socket.h>
+#endif
+#ifdef HAVE_NETINET_IN_H
+#include <netinet/in.h>
+#endif
+#ifdef HAVE_WINDOWS_H
+#include <windows.h>
+#endif
+#ifdef HAVE_WINSOCK2_H
+#include <winsock2.h>
+#endif
+#ifdef HAVE_WS2TCPIP_H
+#include <ws2tcpip.h>
+#endif
+"
 
 if test "${WIN32}" != "yes"; then
-   AC_HEADER_SYS_WAIT
-   AC_CHECK_HEADERS(sys/time.h sys/socket.h sys/un.h sys/ioctl.h sys/stat.h dnl
-		 sys/mman.h fcntl.h sys/file.h stdlib.h stdint.h dnl
-		 stdarg.h unistd.h signal.h stdio.h string.h dnl
-		 strings.h ctype.h errno.h syslog.h pwd.h grp.h dnl
-		 net/if_tun.h net/tun/if_tun.h stropts.h sys/sockio.h dnl
-		 netinet/in.h netinet/in_systm.h dnl
-		 netinet/tcp.h arpa/inet.h dnl
-		 netdb.h sys/uio.h linux/if_tun.h linux/sockios.h dnl
-		 linux/types.h sys/poll.h sys/epoll.h err.h dnl
-   )
-   AC_CHECK_HEADERS(net/if.h,,,
-		 [#ifdef HAVE_SYS_TYPES_H
-		  # include <sys/types.h>
-		  #endif
-		  #ifdef HAVE_SYS_SOCKET_H
-		  # include <sys/socket.h>
-		  #endif
-		 ])
-   AC_CHECK_HEADERS(netinet/ip.h,,,
-		 [#ifdef HAVE_SYS_TYPES_H
-		  # include <sys/types.h>
-		  #endif
-		  #ifdef HAVE_NETINET_IN_H
-		  # include <netinet/in.h>
-		  #endif
-		  #ifdef HAVE_NETINET_IN_SYSTM_H
-		  # include <netinet/in_systm.h>
-		  #endif
-		 ])
-   AC_CHECK_HEADERS(netinet/if_ether.h,,,
-		 [#ifdef HAVE_SYS_TYPES_H
-		  # include <sys/types.h>
-		  #endif
-		  #ifdef HAVE_SYS_SOCKET_H
-		  # include <sys/socket.h>
-		  #endif
-		  #ifdef HAVE_NETINET_IN_H
-		  # include <netinet/in.h>
-		  #endif
-		 ])
-   AC_CHECK_HEADERS(resolv.h,,,
-		 [#ifdef HAVE_NETINET_IN_H 
-		  # include <netinet/in.h>
-		  #endif
-		 ])
-   AC_CHECK_HEADERS(linux/errqueue.h,,,
-	[#ifdef HAVE_LINUX_TYPES_H
-	 # include <linux/types.h>
-	 #endif
+	AC_CHECK_HEADERS([ \
+		sys/time.h sys/un.h sys/ioctl.h sys/stat.h \
+		sys/mman.h sys/file.h \
+		syslog.h pwd.h grp.h \
+		net/if_tun.h net/tun/if_tun.h stropts.h \
+		sys/sockio.h \
+		sys/uio.h linux/if_tun.h linux/sockios.h \
+		linux/types.h sys/poll.h sys/epoll.h err.h \
 	])
-
-   dnl Check if SO_MARK is available
-   AC_TRY_COMPILE([#include <sys/socket.h>], [if( SO_MARK > 0) return 1;], [AC_DEFINE(HAVE_SO_MARK,[],[Is SO_MARK available?])])
+	AC_CHECK_HEADERS(
+		[net/if.h netinet/ip.h netinet/if_ether.h resolv.h],
+		,
+		,
+		[[${SOCKET_INCLUDES}]]
+	)
+
+	AC_CHECK_DECLS(
+		[SO_MARK],
+		,
+		,
+		[[${SOCKET_INCLUDES}]]
+	)
+
+	AC_SEARCH_LIBS([socket], [socket])
+	AC_SEARCH_LIBS([inet_ntoa], [nsl])
+	AC_SEARCH_LIBS([gethostbyname], [resolv nsl])
+	AC_FUNC_FORK
 fi
 
-AC_CACHE_SAVE
-
-dnl check that in_addr_t is defined
-AC_CHECK_TYPE(
+dnl We emulate signals in Windows
+AC_CHECK_DECLS(
+	[SIGHUP],
+	,
+	[AC_DEFINE([SIGHUP], [1], [SIGHUP replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+AC_CHECK_DECLS(
+	[SIGINT],
+	,
+	[AC_DEFINE([SIGINT], [2], [SIGINT replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+AC_CHECK_DECLS(
+	[SIGUSR1],
+	,
+	[AC_DEFINE([SIGUSR1], [10], [SIGUSR1 replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+AC_CHECK_DECLS(
+	[SIGUSR2],
+	,
+	[AC_DEFINE([SIGUSR2], [12], [SIGUSR2 replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+AC_CHECK_DECLS(
+	[SIGTERM],
+	,
+	[AC_DEFINE([SIGTERM], [15], [SIGTERM replacement])],
+	[[
+		#ifdef HAVE_SIGNAL_H
+		#include <signal.h>
+		#endif
+	]]
+)
+
+AC_CHECK_TYPES(
 	[in_addr_t],
-	[],
-	[AC_DEFINE(in_addr_t, uint32_t, [Some systems don't define in_addr_t])],
-	[#include "syshead.h"])
-
-dnl check for basic types
-AC_CHECK_TYPE(
-	[uint8_t],
-	[],
-	[AC_DEFINE(uint8_t, unsigned char, [8-bit unsigned type])],
-	[#include "syshead.h"])
-AC_CHECK_TYPE(
-	[uint16_t],
-	[],
-	[AC_DEFINE(uint16_t, unsigned char, [16-bit unsigned type])],
-	[#include "syshead.h"])
-AC_CHECK_TYPE(
-	[uint32_t],
-	[],
-	[AC_DEFINE(uint32_t, unsigned long, [32-bit unsigned type])],
-	[#include "syshead.h"])
+	,
+	[AC_DEFINE([in_addr_t], [uint32_t], [Workaround missing in_addr_t])],
+	[[${SOCKET_INCLUDES}]]
+)
 
 dnl check for IPv6 types
 AC_CHECK_TYPE(
 	[struct tun_pi],
 	[AC_DEFINE(HAVE_TUN_PI, 1, [struct tun_pi needed for IPv6 support])],
-	[],
-	[#include "syshead.h"])
+	,
+	[[${SOCKET_INCLUDES}]]
+)
 AC_CHECK_TYPE(
 	[struct iphdr],
 	[AC_DEFINE(HAVE_IPHDR, 1, [struct iphdr needed for IPv6 support])],
-	[],
-	[#include "syshead.h"])
-AC_CHECK_TYPE(
-	[struct iovec],
-	[AC_DEFINE(HAVE_IOVEC, 1, [struct iovec needed for IPv6 support])],
-	[],
-	[#include "syshead.h"])
-
-dnl check for extended socket error types
+	,
+	[[${SOCKET_INCLUDES}]]
+)
 AC_CHECK_TYPE(
 	[struct sock_extended_err],
 	[AC_DEFINE(HAVE_SOCK_EXTENDED_ERR, 1, [struct sock_extended_err needed for extended socket error support])],
-	[],
-	[#include "syshead.h"])
+	,
+	[[${SOCKET_INCLUDES}]]
+)
 AC_CHECK_TYPE(
 	[struct msghdr],
 	[AC_DEFINE(HAVE_MSGHDR, 1, [struct msghdr needed for extended socket error support])],
-	[],
-	[#include "syshead.h"])
+	,
+	[[${SOCKET_INCLUDES}]]
+)
 AC_CHECK_TYPE(
 	[struct cmsghdr],
 	[AC_DEFINE(HAVE_CMSGHDR, 1, [struct cmsghdr needed for extended socket error support])],
-	[],
-	[#include "syshead.h"])
+	,
+	[[${SOCKET_INCLUDES}]]
+)
 AC_CHECK_TYPE(
 	[struct in_pktinfo],
 	[AC_DEFINE(HAVE_IN_PKTINFO, 1, [struct in_pktinfo needed for IP_PKTINFO support])],
-	[],
-	[#include "syshead.h"])
-
-AC_CHECK_SIZEOF(unsigned int)
-AC_CHECK_SIZEOF(unsigned long)
-
-AC_CACHE_SAVE
-
-AC_CHECK_FUNCS([ctime memset vsnprintf strdup], ,
-               [AC_MSG_ERROR([Required library function not found])])
-AC_CHECK_FUNCS(daemon chroot getpwnam setuid nice system getpid dup dup2 dnl
-	       getpass strerror syslog openlog mlockall getgrnam setgid dnl
-	       setgroups stat flock readv writev time dnl
-	       setsid chdir putenv getpeername unlink dnl
-	       chsize ftruncate execve getpeereid umask basename dirname access)
+	,
+	[[${SOCKET_INCLUDES}]]
+)
+AC_CHECK_TYPE(
+	[struct sockaddr_in6],
+	,
+	[AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6 transport support.])],
+	[[${SOCKET_INCLUDES}]]
+)
+
+AC_CHECK_FUNCS(
+	[ctime memset vsnprintf strdup],
+	,
+	[AC_MSG_ERROR([Required library function not found])]
+)
+AC_CHECK_FUNCS([ \
+	daemon chroot getpwnam setuid nice system getpid dup dup2 \
+	getpass strerror syslog openlog mlockall getgrnam setgid \
+	setgroups stat flock readv writev time gettimeofday \
+	setsid chdir putenv getpeername unlink \
+	chsize ftruncate execve getpeereid umask basename dirname access \
+	epoll_create \
+])
+AC_CHECK_FUNCS([sendmsg recvmsg])
+AC_CHECK_FUNCS(
+	[res_init],
+	,
+	,
+	[[#include <resolv.h>]]
+)
 
 # Windows use stdcall for winsock so we cannot auto detect these
-m4_define([SOCKET_FUNCS], [socket recv recvfrom send sendto listen dnl
-          accept connect bind select gethostbyname inet_ntoa])
-m4_define([SOCKET_OPT_FUNCS], [setsockopt getsockopt getsockname poll])
-
+m4_define(
+	[SOCKET_FUNCS],
+[socket recv recvfrom send sendto listen dnl
+accept connect bind select gethostbyname inet_ntoa]dnl
+)
+m4_define(
+	[SOCKET_OPT_FUNCS],
+	[setsockopt getsockopt getsockname poll]dnl
+)
 if test "${WIN32}" = "yes"; then
-
 	AC_DEFINE([HAVE_GETTIMEOFDAY], [1], [We fake gettimeofday for win32 at otime.c])
-	m4_foreach([F], m4_split(SOCKET_FUNCS SOCKET_OPT_FUNCS),
-		m4_define(UF, [[m4_join([_], [HAVE], m4_toupper(F))]])
-		AC_DEFINE([UF], [1], [Win32 builtin]))
-
+	m4_foreach(
+		[F],
+		m4_split(SOCKET_FUNCS SOCKET_OPT_FUNCS),
+			m4_define([UF], [[m4_join([_], [HAVE], m4_toupper(F))]])
+			AC_DEFINE([UF], [1], [Win32 builtin])
+	)
 else
-
-	dnl check for other types
-	AC_TYPE_SIGNAL
-
-	dnl Check for libsocket
-	AC_SEARCH_LIBS(socket, socket)
-
-	dnl Check for libnsl
-	AC_SEARCH_LIBS(inet_ntoa, nsl)
-
-	dnl Check for libresolv
-	AC_SEARCH_LIBS(gethostbyname, resolv nsl)
-
-	dnl optional library functions
-	AC_FUNC_FORK
-
-	AC_CHECK_FUNCS(gettimeofday)
-
-	AC_CHECK_FUNCS(SOCKET_FUNCS, ,
-	       [AC_MSG_ERROR([Required library function not found])])
-	AC_CHECK_FUNCS(SOCKET_OPT_FUNCS sendmsg recvmsg)
-
-fi
-
-dnl
-dnl Check for res_init
-dnl
-AC_TRY_LINK([
-    #include <resolv.h>
-  ], [
-    res_init ();
-  ], [
-    AC_MSG_RESULT([res_init DEFINED])
-    AC_DEFINE([HAVE_RES_INIT], 1, [Indicates if res_init is available])
-  ], [
-    AC_MSG_RESULT([res_init UNDEFINED])
-  ])
-
-dnl
-dnl check libraries
-dnl
-
-dnl Checking for a working epoll
-AC_CHECKING([for working epoll implementation])
-OLDLDFLAGS="$LDFLAGS"
-LDFLAGS="$LDFLAGS -Wl,--fatal-warnings"
-AC_CHECK_FUNC(epoll_create, AC_DEFINE(HAVE_EPOLL_CREATE, 1, [epoll_create function is defined]))
-LDFLAGS="$OLDLDFLAGS"
-
-dnl ipv6 support
-AC_CHECKING([for struct sockaddr_in6 for IPv6 support])
-AC_CHECK_TYPE(
-      [struct sockaddr_in6],
-      [],
-      [AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6 transport support.])],
-      [#include "syshead.h"])
-
-dnl
-dnl check for valgrind tool
-dnl
-
-if test "$MEMCHECK" = "valgrind"; then
-   AC_CHECKING([for valgrind tool and Header files])
-   AC_CHECK_HEADER(valgrind/memcheck.h, 
-        [
-	    AC_DEFINE(USE_VALGRIND, 1, [Use valgrind memory debugging library])
-	    CFLAGS="-g -fno-inline"
-	],
-        [AC_MSG_ERROR([valgrind headers not found.])]
-   )
-fi
-
-dnl
-dnl check for dmalloc library
-dnl
-
-if test "$MEMCHECK" = "dmalloc"; then
-   AC_CHECKING([for dmalloc Library and Header files])
-   AC_CHECK_HEADER(dmalloc.h, 
-        [AC_CHECK_LIB(dmalloc, malloc,
-	    [
-               OPENVPN_ADD_LIBS(-ldmalloc)
-	       AC_DEFINE(DMALLOC, 1, [Use dmalloc memory debugging library])
-	    ],
-	    [AC_MSG_ERROR([dmalloc library not found.])]
-	)],
-        [AC_MSG_ERROR([dmalloc headers not found.])]
-   )
-fi
+	AC_CHECK_FUNCS(
+		SOCKET_FUNCS,
+		,
+		[AC_MSG_ERROR([Required library function not found])]
+	)
+	AC_CHECK_FUNCS(SOCKET_OPT_FUNCS)
+fi
+
+case "${with_mem_check}" in
+	valgrind)
+		AC_CHECK_HEADER(
+			[valgrind/memcheck.h],
+			[
+				CFLAGS="${CFLAGS} -g -fno-inline"
+				AC_DEFINE(
+					[USE_VALGRIND],
+					[1],
+					[Use valgrind memory debugging library]
+				)
+			],
+			[AC_MSG_ERROR([valgrind headers not found.])]
+		)
+		;;
+	dmalloc)
+		AC_CHECK_HEADER(
+			[dmalloc.h],
+			[AC_CHECK_LIB(
+				[dmalloc],
+				[malloc],
+				[
+					OPENVPN_ADD_LIBS(-ldmalloc)
+					AC_DEFINE(
+						[DMALLOC],
+						[1],
+						[Use dmalloc memory debugging library]
+					)
+				],
+				[AC_MSG_ERROR([dmalloc library not found.])]
+			)],
+			[AC_MSG_ERROR([dmalloc headers not found.])]
+		)
+		;;
+	ssl)
+		AC_CHECK_LIB(
+			[ssl],
+			[CRYPTO_mem_ctrl],
+			[
+				AC_DEFINE(
+					[CRYPTO_MDEBUG],
+					[1],
+					[Use memory debugging function in OpenSSL]
+				)
+				AC_MSG_NOTICE([NOTE: OpenSSL library must be compiled with CRYPTO_MDEBUG])
+			],
+			[AC_MSG_ERROR([Memory Debugging function in OpenSSL library not found.])]
+		)
+		;;
+esac
 
 dnl
 dnl Check for dlopen -- first try libc then libdl.
 dnl
-if test "${WIN32}" != "yes"; then
-   if test "$PLUGINS" = "yes"; then
-      AC_CHECKING([for libdl Library and Header files])
-      AC_CHECK_HEADER(dlfcn.h,
-           [AC_CHECK_FUNC(dlopen,
-               [AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])],
-               [AC_CHECK_LIB(dl, dlopen,
-	           [
-                      OPENVPN_ADD_LIBS(-ldl)
-	              AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])
-	           ],
-	           [AC_MSG_RESULT([libdl library not found.])]
-	       )],
-           )],
-           [AC_MSG_RESULT([libdl headers not found.])]
-      )
-      if test "$EUREPHIA" = "yes"; then
-         AC_DEFINE(ENABLE_EUREPHIA, 1, [Enable support for the eurephia plug-in])
-      fi
-   fi
+if test "${WIN32}" != "yes" -a "${enable_plugins}" = "yes"; then
+	AC_CHECK_HEADER(
+		[dlfcn.h],
+		[AC_CHECK_FUNC(
+			[dlopen],
+			[AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])],
+			[AC_CHECK_LIB(
+				[dl],
+				[dlopen],
+				[
+					OPENVPN_ADD_LIBS(-ldl)
+					AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])
+				],
+				[AC_MSG_RESULT([libdl library not found.])]
+			)],
+		)],
+	)
+	if test "${enable_eurephia}" = "yes"; then
+		AC_DEFINE([ENABLE_EUREPHIA], [1], [Enable support for the eurephia plug-in])
+	fi
 fi
 
 dnl
 dnl Check if LoadLibrary exists on Windows
 dnl
 if test "${WIN32}" = "yes"; then
-   if test "$PLUGINS" = "yes"; then
-	AC_TRY_LINK([
-	    #include <windows.h>
-	  ], [
-	    LoadLibrary (NULL);
-	  ], [
-	    AC_MSG_RESULT([LoadLibrary DEFINED])
-	    AC_DEFINE(USE_LOAD_LIBRARY, 1, [Use LoadLibrary to load DLLs on Windows])
-	  ], [
-	    AC_MSG_RESULT([LoadLibrary UNDEFINED])
-	  ])
-   fi
+	AC_DEFINE(USE_LOAD_LIBRARY, 1, [Use LoadLibrary to load DLLs on Windows])
 fi
 
 dnl
 dnl check for LZO library
 dnl
-
-if test "$LZO" = "yes" && test "$LZO_STUB" = "no"; then
+if test "${enable_lzo}" = "yes" && test "${enable_lzo_stub}" = "no"; then
    LZO_H=""
    AC_CHECKING([for LZO Library and Header files])
    AC_CHECK_HEADER(lzo/lzo1x.h,
@@ -713,15 +725,14 @@ if test "$LZO" = "yes" && test "$LZO_STUB" = "no"; then
 fi
 
 dnl enable multi-client mode
-if test "$LZO_STUB" = "yes"; then
-   AC_DEFINE(LZO_STUB, 1, [Enable LZO stub capability])
+if test "${enable_lzo_stub}" = "yes"; then
+	AC_DEFINE([LZO_STUB], [1], [Enable LZO stub capability])
 fi
 
 dnl
 dnl enable pkcs11 capability
 dnl
-
-if test "$PKCS11" = "yes"; then
+if test "${enable_pkcs11}" = "yes"; then
    AC_CHECKING([for pkcs11-helper Library and Header files])
    AC_CHECK_HEADER(pkcs11-helper-1.0/pkcs11h-core.h,
 	[AC_CHECK_LIB(pkcs11-helper, pkcs11h_initialize,
@@ -738,9 +749,8 @@ fi
 dnl
 dnl check for SSL-crypto library
 dnl
-
-if test "$CRYPTO" = "yes"; then
-   if test "$SSL_LIB" = "openssl"; then  
+if test "${enable_crypto}" = "yes"; then
+   if test "${with_ssl_type}" = "openssl"; then  
        AC_CHECKING([for OpenSSL Crypto Library and Header files])
        AC_CHECK_HEADER(openssl/evp.h,,
 	       [AC_MSG_ERROR([OpenSSL Crypto headers not found.])])
@@ -778,7 +788,7 @@ if test "$CRYPTO" = "yes"; then
          [AC_MSG_ERROR([OpenSSL crypto Library is too old.])]
        )
    fi
-   if test "$SSL_LIB" = "polarssl"; then
+   if test "${with_ssl_type}" = "polarssl"; then
         AC_CHECKING([for PolarSSL Crypto Library and Header files])
         AC_CHECK_HEADER(polarssl/aes.h,
             [AC_CHECK_LIB(polarssl, aes_crypt_cbc,
@@ -796,8 +806,8 @@ if test "$CRYPTO" = "yes"; then
    dnl check for OpenSSL-SSL library
    dnl
 
-   if test "$SSL" = "yes"; then
-      if test "$SSL_LIB" = "openssl"; then  
+   if test "${enable_ssl}" = "yes"; then
+      if test "${with_ssl_type}" = "openssl"; then  
          AC_CHECKING([for OpenSSL SSL Library and Header files])
          AC_CHECK_HEADER(openssl/ssl.h,,
 	      [AC_MSG_ERROR([OpenSSL SSL headers not found.])]
@@ -814,20 +824,9 @@ if test "$CRYPTO" = "yes"; then
 
          test -n "${sslfound}" || AC_MSG_ERROR([OpenSSL SSL library not found.])
 
-         if test "$MEMCHECK" = "ssl"; then
-	        AC_CHECKING([for Memory Debugging Capabilities in OpenSSL Library])
-	        AC_CHECK_LIB(ssl, CRYPTO_mem_ctrl,
-		    [
-		        AC_DEFINE(CRYPTO_MDEBUG, 1, [Use memory debugging function in OpenSSL])
-		        AC_MSG_RESULT([NOTE: OpenSSL library must be compiled with CRYPTO_MDEBUG])
-		    ],
-		    [AC_MSG_ERROR([Memory Debugging function in OpenSSL library not found.])]
-	        )
-         fi
-
          AC_DEFINE(USE_SSL, 1, [Use OpenSSL SSL library])
       fi
-      if test "$SSL_LIB" = "polarssl"; then
+      if test "${with_ssl_type}" = "polarssl"; then
          AC_CHECKING([for PolarSSL SSL Library and Header files])
          AC_CHECK_HEADER(polarssl/ssl.h,
               [AC_CHECK_LIB(polarssl, ssl_init,
@@ -844,120 +843,58 @@ if test "$CRYPTO" = "yes"; then
    fi
 fi
 
-dnl enable --x509-username-field feature if requested
-if test "$X509ALTUSERNAME" = "yes"; then
-   if test "$SSL_LIB" = "polarssl" ; then
-      AC_MSG_ERROR([PolarSSL does not support the --x509-username-field feature])
-   fi
-
-   AC_DEFINE(ENABLE_X509ALTUSERNAME, 1, [Enable --x509-username-field feature])
-fi
-
-dnl enable multi-client mode
-if test "$MULTI" = "yes"; then
-   AC_DEFINE(ENABLE_CLIENT_SERVER, 1, [Enable client/server capability])
-fi
-
-dnl enable client mode only, not server
-if test "$MULTI_SERVER" = "no"; then
-   AC_DEFINE(ENABLE_CLIENT_ONLY, 1, [Enable client capability only])
-fi
-
-dnl enable management server capability
-if test "$MANAGEMENT" = "yes"; then
-   AC_DEFINE(ENABLE_MANAGEMENT, 1, [Enable management server capability])
-fi
-
-dnl enable socks 
-if test "$SOCKS" = "yes"; then
-   AC_DEFINE(ENABLE_SOCKS, 1, [Enable Socks proxy support])
-fi
-
-dnl enable HTTP proxy
-if test "$HTTP_PROXY" = "yes"; then
-   AC_DEFINE(ENABLE_HTTP_PROXY, 1, [Enable HTTP proxy support])
-fi
-
-dnl compile --multihome option
-if test "$MULTIHOME" = "yes"; then
-   AC_DEFINE(ENABLE_MULTIHOME, 1, [Enable multi-homed UDP server capability])
-fi
-
-dnl enable debugging
-if test "$DEBUG" = "yes"; then
-   AC_DEFINE(ENABLE_DEBUG, 1, [Enable debugging support])
-fi
-
-dnl enable small size optimizations
-if test "$SMALL" = "yes"; then
-   AC_DEFINE(ENABLE_SMALL, 1, [Enable smaller executable size])
-fi
-
-dnl enable --fragment
-if test "$FRAGMENT" = "yes"; then
-   AC_DEFINE(ENABLE_FRAGMENT, 1, [Enable internal fragmentation support])
-fi
-
-dnl enable --port-share
-if test "$PORT_SHARE" = "yes"; then
-   AC_DEFINE(ENABLE_PORT_SHARE, 1, [Enable TCP Server port sharing])
-fi
-
-dnl enable deferred auth
-if test "$DEF_AUTH" = "yes"; then
-   AC_DEFINE(CONFIGURE_DEF_AUTH, 1, [Enable deferred authentication])
-fi
-
-dnl enable internal packet filter
-if test "$PF" = "yes"; then
-   AC_DEFINE(CONFIGURE_PF, 1, [Enable internal packet filter])
-fi
-
-dnl enable strict compiler warnings
-if test "$STRICT" = "yes"; then
-   CFLAGS="$CFLAGS -Wall -Wno-unused-parameter -Wno-unused-function"
-fi
-
-dnl enable pedantic compiler warnings
-if test "$PEDANTIC" = "yes"; then
-   CFLAGS="$CFLAGS -ansi -pedantic"
-fi
-
-dnl enable profiling
-if test "$PROFILE" = "yes"; then
-   CFLAGS="$CFLAGS -pg -DENABLE_PROFILING"
-fi
-
-dnl enable strict options check between peers
-if test "$STRICT_OPTIONS" = "yes"; then
-   AC_DEFINE(STRICT_OPTIONS_CHECK, 1, [Enable strict options check between peers])
-fi
-
-dnl enable password save
-if test "$PASSWORD_SAVE" = "yes"; then
-   AC_DEFINE(ENABLE_PASSWORD_SAVE, 1, [Allow --askpass and --auth-user-pass passwords to be read from a file])
-fi
-
-dnl enable systemd support
-if test "$SYSTEMD" = "yes"; then
-   AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd support])
-fi
-
 dnl
 dnl check for SELinux library and headers
 dnl
-if test "$SELINUX" = "yes"; then
-   AC_CHECKING([for libselinux Library and Header files])
-   AC_CHECK_HEADER(selinux/selinux.h,
-      [AC_CHECK_LIB(selinux, setcon,
-         [
-            OPENVPN_ADD_LIBS(-lselinux)
-            AC_DEFINE(HAVE_SETCON, 1, [SELinux support])
-         ],
-            [AC_MSG_RESULT([SELinux library not found.])]
-         )],
-      [AC_MSG_RESULT([SELinux headers not found.])]
-   )
+if test "${enable_selinux}" = "yes"; then
+	AC_CHECK_HEADER(
+		[selinux/selinux.h],
+		[AC_CHECK_LIB(
+			[selinux],
+			[setcon],
+			[
+				OPENVPN_ADD_LIBS(-lselinux)
+				AC_DEFINE(HAVE_SETCON, 1, [SELinux support])
+			],
+			[AC_MSG_RESULT([SELinux library not found.])]
+		)],
+		[AC_MSG_ERROR([SELinux headers not found.])]
+	)
+fi
+
+dnl enable --x509-username-field feature if requested
+if test "${enable_x509_alt_username}" = "yes"; then
+	if test "${with_ssl_type}" = "polarssl" ; then
+		AC_MSG_ERROR([PolarSSL does not support the --x509-username-field feature])
+	fi
+
+	AC_DEFINE([ENABLE_X509ALTUSERNAME], [1], [Enable --x509-username-field feature])
+fi
+
+test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct iovec needed for IPv6 support])
+test "${enable_multi}" = "yes" && AC_DEFINE([ENABLE_CLIENT_SERVER], [1], [Enable client/server capability])
+test "${enable_server}" = "no" && AC_DEFINE([ENABLE_CLIENT_ONLY], [1], [Enable client capability only])
+test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
+test "${enable_socks}" = "yes" && AC_DEFINE([ENABLE_SOCKS], [1], [Enable Socks proxy support])
+test "${enable_http_proxy}" = "yes" && AC_DEFINE([ENABLE_HTTP_PROXY], [1], [Enable HTTP proxy support])
+test "${enable_multihome}" = "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server capability])
+test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])
+test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
+test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
+test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])
+test "${enable_def_auth}" = "yes" && AC_DEFINE([ENABLE_DEF_AUTH], [1], [Enable deferred authentication])
+test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal packet filter])
+test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
+test "${enable_password_save}" = "yes" && AC_DEFINE([ENABLE_PASSWORD_SAVE], [1], [Allow --askpass and --auth-user-pass passwords to be read from a file])
+test "${enable_systemd}" = "yes" && AC_DEFINE([ENABLE_SYSTEMD], [1], [Enable systemd support])
+test "${enable_iproute2}" = "yes" && AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
+
+if test "${enable_pedantic}" = "yes"; then
+	enable_strict="yes"
+	CFLAGS="${CFLAGS} -ansi -pedantic"
+fi
+if test "${enable_strict}" = "yes"; then
+	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
 fi
 
 TAP_WIN_COMPONENT_ID="PRODUCT_TAP_WIN_COMPONENT_ID"
@@ -970,24 +907,12 @@ AC_SUBST([TAP_WIN_COMPONENT_ID])
 AC_SUBST([TAP_WIN_MIN_MAJOR])
 AC_SUBST([TAP_WIN_MIN_MINOR])
 
-win32datadir="\${datadir}/${PACKAGE}-win32"
-AC_SUBST(win32datadir)
-AM_CONDITIONAL(WIN32, test "${WIN32}" = "yes")
-
-# workaround for <autoconf-2.60
-if test -z "${docdir}"; then
-	docdir="\$(datadir)/doc/\$(PACKAGE_NAME)"
-	AC_SUBST([docdir])
-fi
-if test -z "${htmldir}"; then
-	htmldir="\$(docdir)"
-	AC_SUBST([htmldir])
-fi
-# end workaround
+AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
 AC_CONFIG_FILES([t_client.sh], [chmod +x t_client.sh])
-AC_OUTPUT([
+AC_CONFIG_FILES([
 	Makefile
 	openvpn.spec
 	service-win32/Makefile
 ])
+AC_OUTPUT
diff --git a/lladdr.c b/lladdr.c
index 7aefdba..fc01b63 100644
--- a/lladdr.c
+++ b/lladdr.c
@@ -16,7 +16,7 @@ int set_lladdr(const char *ifname, const char *lladdr,
     return -1;
   
 #if defined(TARGET_LINUX)
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
   argv_printf (&argv,
 		    "%s link set addr %s dev %s",
 		    iproute_path, lladdr, ifname);
diff --git a/misc.c b/misc.c
index a07780f..7070c21 100644
--- a/misc.c
+++ b/misc.c
@@ -39,7 +39,7 @@
 
 #include "memdbg.h"
 
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
 const char *iproute_path = IPROUTE_PATH; /* GLOBAL */
 #endif
 
diff --git a/misc.h b/misc.h
index 5df8cec..96f8bf8 100644
--- a/misc.h
+++ b/misc.h
@@ -396,7 +396,7 @@ void get_user_pass_auto_userid (struct user_pass *up, const char *tag);
 /*
  * /sbin/ip path, may be overridden
  */
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
 extern const char *iproute_path;
 #endif
 
diff --git a/options.c b/options.c
index 75aed97..4883c48 100644
--- a/options.c
+++ b/options.c
@@ -181,7 +181,7 @@ static const char usage_message[] =
   "--lladdr hw     : Set the link layer address of the tap device.\n"
   "--topology t    : Set --dev tun topology: 'net30', 'p2p', or 'subnet'.\n"
   "--tun-ipv6      : Build tun link capable of forwarding IPv6 traffic.\n"
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
   "--iproute cmd   : Use this command instead of default " IPROUTE_PATH ".\n"
 #endif
   "--ifconfig l rn : TUN: configure device to use IP address l as a local\n"
@@ -292,7 +292,7 @@ static const char usage_message[] =
   "                  or --fragment max value, whichever is lower.\n"
   "--sndbuf size   : Set the TCP/UDP send buffer size.\n"
   "--rcvbuf size   : Set the TCP/UDP receive buffer size.\n"
-#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
+#if defined(TARGET_LINUX) && defined(HAVE_DECL_SO_MARK)
   "--mark value    : Mark encrypted packets being sent with value. The mark value\n"
   "                  can be matched in policy routing and packetfilter rules.\n"
 #endif
@@ -1506,7 +1506,7 @@ show_settings (const struct options *o)
 #endif
   SHOW_INT (rcvbuf);
   SHOW_INT (sndbuf);
-#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
+#if defined(TARGET_LINUX) && defined(HAVE_DECL_SO_MARK)
   SHOW_INT (mark);
 #endif
   SHOW_INT (sockflags);
@@ -3188,7 +3188,7 @@ options_cmp_equal_safe (char *actual, const char *expected, size_t actual_n)
   if (actual_n > 0)
     {
       actual[actual_n - 1] = 0;
-#ifndef STRICT_OPTIONS_CHECK
+#ifndef ENABLE_STRICT_OPTIONS_CHECK
       if (strncmp (actual, expected, 2))
 	{
 	  msg (D_SHOW_OCC, "NOTE: Options consistency check may be skewed by version differences");
@@ -4307,7 +4307,7 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_UP);
       options->tun_ipv6 = true;
     }
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
   else if (streq (p[0], "iproute") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -4798,7 +4798,7 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "mark") && p[1])
     {
-#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
+#if defined(TARGET_LINUX) && defined(HAVE_DECL_SO_MARK)
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->mark = atoi(p[1]);
 #endif
diff --git a/route.c b/route.c
index cf9a5ea..ca8f1da 100644
--- a/route.c
+++ b/route.c
@@ -1308,8 +1308,8 @@ add_route (struct route *r,
     goto done;
 
 #if defined(TARGET_LINUX)
-#ifdef CONFIG_FEATURE_IPROUTE
-  /* FIXME -- add on-link support for CONFIG_FEATURE_IPROUTE */
+#ifdef ENABLE_IPROUTE
+  /* FIXME -- add on-link support for ENABLE_IPROUTE */
   argv_printf (&argv, "%s route add %s/%d via %s",
   	      iproute_path,
 	      network,
@@ -1330,7 +1330,7 @@ add_route (struct route *r,
   else
     argv_printf_cat (&argv, "gw %s", gateway);
 
-#endif  /*CONFIG_FEATURE_IPROUTE*/
+#endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
@@ -1566,7 +1566,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
    */
 
 #if defined(TARGET_LINUX)
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
   argv_printf (&argv, "%s -6 route add %s/%d dev %s",
   	      iproute_path,
 	      network,
@@ -1583,7 +1583,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 	      device);
   if (r6->metric_defined)
     argv_printf_cat (&argv, " metric %d", r6->metric);
-#endif  /*CONFIG_FEATURE_IPROUTE*/
+#endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
@@ -1717,7 +1717,7 @@ delete_route (struct route *r,
     goto done;
 
 #if defined(TARGET_LINUX)
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
   argv_printf (&argv, "%s route del %s/%d",
   	      iproute_path,
 	      network,
@@ -1727,7 +1727,7 @@ delete_route (struct route *r,
 	       ROUTE_PATH,
 	       network,
 	       netmask);
-#endif /*CONFIG_FEATURE_IPROUTE*/
+#endif /*ENABLE_IPROUTE*/
   if (r->flags & RT_METRIC_DEFINED)
     argv_printf_cat (&argv, "metric %d", r->metric);
   argv_msg (D_ROUTE, &argv);
@@ -1876,7 +1876,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
 
 #if defined(TARGET_LINUX)
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
   argv_printf (&argv, "%s -6 route del %s/%d dev %s",
   	      iproute_path,
 	      network,
@@ -1888,7 +1888,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 	      network,
 	      r6->netbits,
 	      device);
-#endif  /*CONFIG_FEATURE_IPROUTE*/
+#endif  /*ENABLE_IPROUTE*/
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 del command failed");
 
diff --git a/socket.c b/socket.c
index 1a772af..5c9ef99 100644
--- a/socket.c
+++ b/socket.c
@@ -782,7 +782,7 @@ socket_set_tcp_nodelay (int sd, int state)
 static inline void
 socket_set_mark (int sd, int mark)
 {
-#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
+#if defined(TARGET_LINUX) && defined(HAVE_DECL_SO_MARK)
   if (mark && setsockopt (sd, SOL_SOCKET, SO_MARK, &mark, sizeof (mark)) != 0)
     msg (M_WARN, "NOTE: setsockopt SO_MARK=%d failed", mark);
 #endif
diff --git a/syshead.h b/syshead.h
index e8e70d2..d115273 100644
--- a/syshead.h
+++ b/syshead.h
@@ -43,10 +43,6 @@
 # define unlikely(x)    (x)
 #endif
 
-#if defined(_WIN32) && !defined(WIN32)
-#define WIN32
-#endif
-
 #ifdef WIN32
 #include <windows.h>
 #include <winsock2.h>
@@ -78,22 +74,15 @@
 #endif
 #endif
 
-#ifdef TIME_WITH_SYS_TIME
-# include <sys/time.h>
-# include <time.h>
-#else
-# ifdef HAVE_SYS_TIME_H
-#  include <sys/time.h>
-# else
-#  include <time.h>
-# endif
+#ifdef HAVE_SYS_TIME_H
+#include <sys/time.h>
+#endif
+
+#ifdef HAVE_TIME_H
+#include <time.h>
 #endif
 
 #ifdef HAVE_SYS_SOCKET_H
-# if defined(TARGET_LINUX) && !defined(_GNU_SOURCE)
-   /* needed for peercred support on glibc-2.8 */
-#  define _GNU_SOURCE
-# endif
 #include <sys/socket.h>
 #endif
 
@@ -525,14 +514,14 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Enable deferred authentication?
  */
-#if defined(CONFIGURE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_PLUGIN)
+#if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_PLUGIN)
 #define PLUGIN_DEF_AUTH
 #endif
-#if defined(CONFIGURE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_MANAGEMENT)
+#if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_MANAGEMENT)
 #define MANAGEMENT_DEF_AUTH
 #endif
-#if defined(PLUGIN_DEF_AUTH) || defined(MANAGEMENT_DEF_AUTH)
-#define ENABLE_DEF_AUTH
+#if !defined(PLUGIN_DEF_AUTH) && !defined(MANAGEMENT_DEF_AUTH)
+#undef ENABLE_DEF_AUTH
 #endif
 
 /*
@@ -553,14 +542,14 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Enable packet filter?
  */
-#if defined(CONFIGURE_PF) && P2MP_SERVER && defined(ENABLE_PLUGIN) && defined(HAVE_STAT)
+#if defined(ENABLE_PF) && P2MP_SERVER && defined(ENABLE_PLUGIN) && defined(HAVE_STAT)
 #define PLUGIN_PF
 #endif
-#if defined(CONFIGURE_PF) && P2MP_SERVER && defined(MANAGEMENT_DEF_AUTH)
+#if defined(ENABLE_PF) && P2MP_SERVER && defined(MANAGEMENT_DEF_AUTH)
 #define MANAGEMENT_PF
 #endif
-#if defined(PLUGIN_PF) || defined(MANAGEMENT_PF)
-#define ENABLE_PF
+#if !defined(PLUGIN_PF) && !defined(MANAGEMENT_PF)
+#undef ENABLE_PF
 #endif
 
 /*
diff --git a/tun.c b/tun.c
index b3df14e..7b74ebd 100644
--- a/tun.c
+++ b/tun.c
@@ -673,7 +673,7 @@ do_ifconfig (struct tuntap *tt,
 
 
 #if defined(TARGET_LINUX)
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
 	/*
 	 * Set the MTU for the device
 	 */
@@ -761,7 +761,7 @@ do_ifconfig (struct tuntap *tt,
 	}
       tt->did_ifconfig = true;
 
-#endif /*CONFIG_FEATURE_IPROUTE*/
+#endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_SOLARIS)
 
       /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
@@ -1574,7 +1574,7 @@ close_tun (struct tuntap *tt)
 	    struct gc_arena gc = gc_new ();
 	    argv_init (&argv);
 
-#ifdef CONFIG_FEATURE_IPROUTE
+#ifdef ENABLE_IPROUTE
 	    if (is_tun_p2p (tt))
 	      {
 		argv_printf (&argv,
diff --git a/version.m4 b/version.m4
index 52e9c49..42bab30 100644
--- a/version.m4
+++ b/version.m4
@@ -1,6 +1,9 @@
 dnl define the OpenVPN version
-define(PRODUCT_VERSION,[2.x-master])
+define([PRODUCT_NAME], [OpenVPN])
+define([PRODUCT_TARNAME], [openvpn])
+define([PRODUCT_VERSION], [2.x-master])
+define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
 dnl define the TAP version
-define(PRODUCT_TAP_WIN_COMPONENT_ID,[tap0901])
-define(PRODUCT_TAP_WIN_MIN_MAJOR,[9])
-define(PRODUCT_TAP_WIN_MIN_MINOR,[9])
+define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
+define([PRODUCT_TAP_WIN_MIN_MAJOR], [9])
+define([PRODUCT_TAP_WIN_MIN_MINOR], [9])
diff --git a/win32.h b/win32.h
index 2492e35..09f897a 100644
--- a/win32.h
+++ b/win32.h
@@ -51,17 +51,6 @@ void uninit_win32 (void);
 
 void set_pause_exit_win32 (void);
 
-/*
- * Use keyboard input or events
- * to simulate incoming signals
- */
-
-#define SIGUSR1   1
-#define SIGUSR2   2
-#define SIGHUP    3
-#define SIGTERM   4
-#define SIGINT    5
-
 struct security_attributes
 {
   SECURITY_ATTRIBUTES sa;
-- 
1.7.3.4


