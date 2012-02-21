From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:36 +0200
Message-Id: <1329787361-26096-31-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 30/35] build: proper pkcs11-helper detection
	and usage
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
 configure.ac            |   48 ++++++++++++++++------------------------------
 src/openvpn/Makefile.am |    4 +++
 src/openvpn/ssl.c       |    2 +-
 src/openvpn/syshead.h   |    7 ------
 4 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3ffa0ee..db7b6ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -110,9 +110,9 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[pkcs11],
-	[AS_HELP_STRING([--disable-pkcs11], [disable pkcs11 support])],
+	[AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support])],
 	,
-	[enable_pkcs11="yes"]
+	[enable_pkcs11="no"]
 )
 
 AC_ARG_ENABLE(
@@ -253,19 +253,6 @@ AC_ARG_WITH(
 )
 
 AC_ARG_WITH(
-	[pkcs11-helper-headers],
-	[AS_HELP_STRING([--with-pkcs11-helper-headers=DIR], [pkcs11-helper Include files location])],
-	[PKCS11_HELPER_HDR_DIR="$withval"]
-	[CPPFLAGS="$CPPFLAGS -I$withval"] 
-)
-
-AC_ARG_WITH(
-	[pkcs11-helper-lib],
-	[AS_HELP_STRING([--with-pkcs11-helper-lib=DIR], [pkcs11-helper Library location])],
-	[LDFLAGS="$LDFLAGS -L$withval"] 
-)
-
-AC_ARG_WITH(
 	[mem-check],
 	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=dmalloc|valgrind|ssl])],
 	,
@@ -705,22 +692,11 @@ if test "${enable_lzo_stub}" = "yes"; then
 	AC_DEFINE([LZO_STUB], [1], [Enable LZO stub capability])
 fi
 
-dnl
-dnl enable pkcs11 capability
-dnl
-if test "${enable_pkcs11}" = "yes"; then
-   AC_CHECKING([for pkcs11-helper Library and Header files])
-   AC_CHECK_HEADER(pkcs11-helper-1.0/pkcs11h-core.h,
-	[AC_CHECK_LIB(pkcs11-helper, pkcs11h_initialize,
-	    [
-		   AC_DEFINE(USE_PKCS11, 1, [Enable PKCS11 capability])
-		   LIBS="${LIBS} -lpkcs11-helper"
-	    ],
-	    [AC_MSG_RESULT([pkcs11-helper library not found.])]
-	)],
-	[AC_MSG_RESULT([pkcs11-helper headers not found.])]
-   )
-fi
+PKG_CHECK_MODULES(
+	[PKCS11_HELPER],
+	[libpkcs11-helper-1 >= 1.02],
+	[have_pkcs11_helper="yes"]
+)
 
 dnl
 dnl check for SSL-crypto library
@@ -868,6 +844,14 @@ if test "${enable_selinux}" = "yes"; then
 	AC_DEFINE([ENABLE_SELINUX], [1], [SELinux support])
 fi
 
+if test "${enable_pkcs11}" = "yes"; then
+	test "${have_pkcs11_helper}" != "yes" && AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])
+	test "${enable_ssl}" != "yes" && AC_MSG_ERROR([PKCS11 can be enabled only if SSL is enabled])
+	OPTIONAL_PKCS11_HELPER_CFLAGS="${PKCS11_HELPER_CFLAGS}"
+	OPTIONAL_PKCS11_HELPER_LIBS="${PKCS11_HELPER_LIBS}"
+	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])
+fi
+
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -ansi -pedantic"
@@ -895,6 +879,8 @@ AC_SUBST([TAP_WIN_MIN_MINOR])
 
 AC_SUBST([OPTIONAL_DL_LIBS])
 AC_SUBST([OPTIONAL_SELINUX_LIBS])
+AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
+AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 7645e2f..102860e 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -16,6 +16,9 @@ MAINTAINERCLEANFILES = \
 
 INCLUDES = -I$(top_srcdir)/include
 
+AM_CFLAGS = \
+	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
+
 sbin_PROGRAMS = openvpn
 
 openvpn_SOURCES = \
@@ -97,6 +100,7 @@ openvpn_SOURCES = \
 	cryptoapi.h cryptoapi.c
 openvpn_LDADD = \
 	$(SOCKETS_LIBS) \
+	$(OPTIONAL_PKCS11_HELPER_LIBS) \
 	$(OPTIONAL_SELINUX_LIBS) \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c26756e..e260718 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -264,7 +264,7 @@ ssl_purge_auth (const bool auth_user_pass_only)
 {
   if (!auth_user_pass_only)
     {
-#ifdef USE_PKCS11
+#ifdef ENABLE_PKCS11
       pkcs11_logout ();
 #endif
       purge_user_pass (&passbuf, true);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 745f944..089bbfb 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -588,13 +588,6 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Do we have PKCS11 capability?
- */
-#if defined(USE_PKCS11) && defined(USE_CRYPTO) && defined(USE_SSL)
-#define ENABLE_PKCS11
-#endif
-
-/*
  * Do we have CryptoAPI capability?
  */
 #if defined(WIN32) && defined(USE_CRYPTO) && defined(USE_SSL) && defined(USE_OPENSSL)
-- 
1.7.3.4


