From: Gert Doering <gert@...1296...>
Date: Thu, 27 Nov 2025 11:37:05 +0100
Message-ID: <20251127103710.29341-1-gert@...1296...>
In-Reply-To: <gerrit.1764176932000.Ic55e1288b0d3160e68eef07ff4edbb070a03dd31@...2715...>
References: <gerrit.1764176932000.Ic55e1288b0d3160e68eef07ff4edbb070a03dd31@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] configure/CMake: Unify Windows handling
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

From: Frank Lichtenheld <frank@...2641...>

Some things were detected in configure.ac and just
hard-coded in CMake. Move the hard-coding to
syshead.h instead and remove the additional code
in configure.ac. These are really Windows-specific
so I think not dynamically detecting is okay.

Change-Id: Ic55e1288b0d3160e68eef07ff4edbb070a03dd31
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1410
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1410
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index f68ea27..bf1388c 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -411,32 +411,3 @@
 #ifndef _GNU_SOURCE
 # define _GNU_SOURCE 1
 #endif
-
-/* if inttypes.h is included this breaks rc.exe when using the ClangCL
- * Toolchain as it pulls in a inttypes.h variant for clang that rc.exe does
- * not understand (#include_next preprocessor directive) */
-#if defined(_WIN32) && !defined(RC_INVOKED)
-#include <inttypes.h>
-typedef uint32_t in_addr_t;
-typedef uint16_t in_port_t;
-
-#define SIGHUP    1
-#define SIGINT    2
-#define SIGUSR1   10
-#define SIGUSR2   12
-#define SIGTERM   15
-#endif
-
-#if defined(_MSC_VER) && !defined(RC_INVOKED)
-#include <BaseTsd.h>
-typedef SSIZE_T ssize_t;
-#define strncasecmp strnicmp
-#define strcasecmp _stricmp
-
-#define S_IRUSR _S_IREAD
-#define S_IWUSR _S_IWRITE
-#define R_OK 4
-#define W_OK 2
-#define X_OK 1
-#define F_OK 0
-#endif
diff --git a/configure.ac b/configure.ac
index 60799e0..73b388b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -527,18 +527,6 @@
 	[[${SOCKET_INCLUDES}]]
 )
 
-AC_CHECK_TYPES(
-	[in_addr_t],
-	,
-	[AC_DEFINE([in_addr_t], [uint32_t], [Workaround missing in_addr_t])],
-	[[${SOCKET_INCLUDES}]]
-)
-AC_CHECK_TYPES(
-	[in_port_t],
-	,
-	[AC_DEFINE([in_port_t], [uint16_t], [Workaround missing in_port_t])],
-	[[${SOCKET_INCLUDES}]]
-)
 AC_CHECK_TYPE(
 	[struct msghdr],
 	[AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed for extended socket error support])],
@@ -600,48 +588,6 @@
 )
 LDFLAGS="$saved_LDFLAGS"
 
-dnl We emulate signals in Windows
-AC_CHECK_DECLS(
-	[SIGHUP],
-	,
-	[AC_DEFINE([SIGHUP], [1], [SIGHUP replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGINT],
-	,
-	[AC_DEFINE([SIGINT], [2], [SIGINT replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGUSR1],
-	,
-	[AC_DEFINE([SIGUSR1], [10], [SIGUSR1 replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGUSR2],
-	,
-	[AC_DEFINE([SIGUSR2], [12], [SIGUSR2 replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGTERM],
-	,
-	[AC_DEFINE([SIGTERM], [15], [SIGTERM replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-
 AC_FUNC_FORK
 
 AC_CHECK_FUNCS([ \
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index c6f2608..627ba92 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -44,6 +44,35 @@
 #define srandom  srand
 #endif
 
+/* if inttypes.h is included this breaks rc.exe when using the ClangCL
+ * Toolchain as it pulls in a inttypes.h variant for clang that rc.exe does
+ * not understand (#include_next preprocessor directive) */
+#if defined(_WIN32) && !defined(RC_INVOKED)
+#include <inttypes.h>
+typedef uint32_t in_addr_t;
+typedef uint16_t in_port_t;
+
+#define SIGHUP  1
+#define SIGINT  2
+#define SIGUSR1 10
+#define SIGUSR2 12
+#define SIGTERM 15
+#endif
+
+#if defined(_MSC_VER) && !defined(RC_INVOKED)
+#include <BaseTsd.h>
+typedef SSIZE_T ssize_t;
+#define strncasecmp strnicmp
+#define strcasecmp  _stricmp
+
+#define S_IRUSR _S_IREAD
+#define S_IWUSR _S_IWRITE
+#define R_OK    4
+#define W_OK    2
+#define X_OK    1
+#define F_OK    0
+#endif
+
 #if defined(_MSC_VER) && !defined(__clang__) /* Microsoft compiler */
 #define __func__ __FUNCTION__
 #define __attribute__(x)

