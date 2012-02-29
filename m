From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:02 +0200
Message-Id: <1330546342-17794-33-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 32/52] build: libdl usage
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>

1. properly detect.
2. Link only required components.
3. No way we don't have LoadLibrary on Windows.
4. ENABLE_PLUGIN should be controlled in autoconf.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac            |   50 ++++++++++++++++-------------------------------
 src/openvpn/Makefile.am |    4 ++-
 src/openvpn/plugin.c    |   16 +++++++++-----
 src/openvpn/plugin.h    |    4 +-
 src/openvpn/syshead.h   |   11 ----------
 5 files changed, 32 insertions(+), 53 deletions(-)

diff --git a/configure.ac b/configure.ac
index ed98464..a0dc462 100644
--- a/configure.ac
+++ b/configure.ac
@@ -395,7 +395,7 @@ AC_CHECK_HEADERS([ \
 	stdio.h stdarg.h \
 	time.h errno.h fcntl.h io.h direct.h \
 	ctype.h sys/types.h sys/socket.h \
-	signal.h unistd.h \
+	signal.h unistd.h dlfcn.h \
 	netinet/in.h netinet/in_systm.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
 	windows.h winsock2.h ws2tcpip.h \
@@ -606,6 +606,13 @@ else
 	AC_CHECK_FUNCS(SOCKET_OPT_FUNCS)
 fi
 
+AC_CHECK_LIB(
+	[dl],
+	[dlopen],
+	[DL_LIBS="-ldl"]
+)
+AC_SUBST([DL_LIBS])
+
 case "${with_mem_check}" in
 	valgrind)
 		AC_CHECK_HEADER(
@@ -658,38 +665,6 @@ case "${with_mem_check}" in
 esac
 
 dnl
-dnl Check for dlopen -- first try libc then libdl.
-dnl
-if test "${WIN32}" != "yes" -a "${enable_plugins}" = "yes"; then
-	AC_CHECK_HEADER(
-		[dlfcn.h],
-		[AC_CHECK_FUNC(
-			[dlopen],
-			[AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])],
-			[AC_CHECK_LIB(
-				[dl],
-				[dlopen],
-				[
-					LIBS="${LIBS} -ldl"
-					AC_DEFINE(USE_LIBDL, 1, [Use libdl for dynamic library loading])
-				],
-				[AC_MSG_RESULT([libdl library not found.])]
-			)],
-		)],
-	)
-	if test "${enable_eurephia}" = "yes"; then
-		AC_DEFINE([ENABLE_EUREPHIA], [1], [Enable support for the eurephia plug-in])
-	fi
-fi
-
-dnl
-dnl Check if LoadLibrary exists on Windows
-dnl
-if test "${WIN32}" = "yes"; then
-	AC_DEFINE(USE_LOAD_LIBRARY, 1, [Use LoadLibrary to load DLLs on Windows])
-fi
-
-dnl
 dnl check for LZO library
 dnl
 if test "${enable_lzo}" = "yes" && test "${enable_lzo_stub}" = "no"; then
@@ -898,6 +873,13 @@ test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHEC
 test "${enable_password_save}" = "yes" && AC_DEFINE([ENABLE_PASSWORD_SAVE], [1], [Allow --askpass and --auth-user-pass passwords to be read from a file])
 test "${enable_systemd}" = "yes" && AC_DEFINE([ENABLE_SYSTEMD], [1], [Enable systemd support])
 
+if test "${enable_plugins}" = "yes"; then
+	test "${WIN32}" != "yes" -a -z "${DL_LIBS}" && AC_MSG_ERROR([libdl is required for plugins])
+	OPTIONAL_DL_LIBS="${DL_LIBS}"
+	AC_DEFINE([ENABLE_PLUGIN], [1], [Enable systemd support])
+	test "${enable_eurephia}" = "yes" && AC_DEFINE([ENABLE_EUREPHIA], [1], [Enable support for the eurephia plug-in])
+fi
+
 if test "${enable_iproute2}" = "yes"; then
 	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missing])
 	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
@@ -933,6 +915,8 @@ AC_SUBST([TAP_WIN_COMPONENT_ID])
 AC_SUBST([TAP_WIN_MIN_MAJOR])
 AC_SUBST([TAP_WIN_MIN_MINOR])
 
+AC_SUBST([OPTIONAL_DL_LIBS])
+
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
 AC_CONFIG_FILES([
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a509bba..c7626c8 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -95,7 +95,9 @@ openvpn_SOURCES = \
 	tun.c tun.h \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
+openvpn_LDADD = \
+	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
-openvpn_LDADD = -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32
 endif
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 4cc9c36..3f379dd 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -26,6 +26,10 @@
 
 #ifdef ENABLE_PLUGIN
 
+#ifdef HAVE_DLFCN_H
+#include <dlfcn.h>
+#endif
+
 #include "buffer.h"
 #include "error.h"
 #include "misc.h"
@@ -160,7 +164,7 @@ plugin_option_list_print (const struct plugin_option_list *list, int msglevel)
 }
 #endif
 
-#if defined(USE_LIBDL)
+#ifndef WIN32
 
 static void
 libdl_resolve_symbol (void *handle, void **dest, const char *symbol, const char *plugin_name, const unsigned int flags)
@@ -170,7 +174,7 @@ libdl_resolve_symbol (void *handle, void **dest, const char *symbol, const char
     msg (M_FATAL, "PLUGIN: could not find required symbol '%s' in plugin shared object %s: %s", symbol, plugin_name, dlerror());
 }
 
-#elif defined(USE_LOAD_LIBRARY)
+#else
 
 static void
 dll_resolve_symbol (HMODULE module, void **dest, const char *symbol, const char *plugin_name, const unsigned int flags)
@@ -191,7 +195,7 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   p->so_pathname = o->so_pathname;
   p->plugin_type_mask = plugin_supported_types ();
 
-#if defined(USE_LIBDL)
+#ifndef WIN32
 
   p->handle = NULL;
 #if defined(PLUGIN_LIBDIR)
@@ -220,7 +224,7 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
 
 # define PLUGIN_SYM(var, name, flags) libdl_resolve_symbol (p->handle, (void*)&p->var, name, p->so_pathname, flags)
 
-#elif defined(USE_LOAD_LIBRARY)
+#else
 
   rel = !absolute_pathname (p->so_pathname);
   p->module = LoadLibraryW (wide_string (p->so_pathname, &gc));
@@ -427,10 +431,10 @@ plugin_close_item (struct plugin *p)
       if (p->plugin_handle)
 	(*p->close)(p->plugin_handle);
 
-#if defined(USE_LIBDL)
+#ifndef WIN32
       if (dlclose (p->handle))
 	msg (M_WARN, "PLUGIN_CLOSE: dlclose() failed on plugin: %s", p->so_pathname);
-#elif defined(USE_LOAD_LIBRARY)
+#elif defined(WIN32)
       if (!FreeLibrary (p->module))
 	msg (M_WARN, "PLUGIN_CLOSE: FreeLibrary() failed on plugin: %s", p->so_pathname);
 #endif
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 6f75e27..4c0a1fd 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -59,9 +59,9 @@ struct plugin {
   unsigned int plugin_type_mask;
   int requested_initialization_point;
 
-#if defined(USE_LIBDL)
+#ifndef WIN32
   void *handle;
-#elif defined(USE_LOAD_LIBRARY)
+#else
   HMODULE module;
 #endif
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index b305660..1ad81d8 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -156,10 +156,6 @@
 #include <grp.h>
 #endif
 
-#ifdef USE_LIBDL
-#include <dlfcn.h>
-#endif
-
 #ifdef HAVE_NETDB_H
 #include <netdb.h>
 #endif
@@ -507,13 +503,6 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Do we have a plug-in capability?
- */
-#if defined(USE_LIBDL) || defined(USE_LOAD_LIBRARY)
-#define ENABLE_PLUGIN
-#endif
-
-/*
  * Enable deferred authentication?
  */
 #if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_PLUGIN)
-- 
1.7.3.4


