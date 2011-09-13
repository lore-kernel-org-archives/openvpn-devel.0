From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 13 Sep 2011 16:44:46 +0000
Message-Id: <1315932286-6992-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313588569-18927-2-git-send-email-heiko.hund@...1489...>
References: <1313588569-18927-2-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] add MinGW WinHTTP compatibility import
	library
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

MinGW is missing support for winhttp.dll which will be used for automatic
proxy server detection in Windows. Until it becomes available the workaround
performed is to define the used constants and function prototypes in openvpn
and build a WINHTTP.dll import library in the build process.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 Makefile.am   |   15 +++++++++++++
 configure.ac  |   53 ++++++++++++++++++++++++++++++++++++++++++++++
 win32.c       |    2 +
 win32.h       |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 winhttp32.def |    8 +++++++
 winhttp64.def |    8 +++++++
 6 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 winhttp32.def
 create mode 100644 winhttp64.def

diff --git a/Makefile.am b/Makefile.am
index 266a5af..b1c0a1b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -74,6 +74,8 @@ dist_noinst_DATA = \
 	openvpn.spec \
 	COPYRIGHT.GPL \
 	PORTS \
+	winhttp32.def \
+	winhttp64.def \
 	INSTALL-win32.txt \
 	service-win32/msvc.mak
 
@@ -163,3 +165,16 @@ openvpn.8.html: $(srcdir)/openvpn.8
 else
 dist_man_MANS = openvpn.8
 endif
+
+if BUILD_WINHTTP_IMPLIB
+openvpn_LDADD = libwinhttp.a
+
+if WIN64
+libwinhttp.a: winhttp64.def
+	$(DLLTOOL) -k -d winhttp64.def -l libwinhttp.a
+else
+libwinhttp.a: winhttp32.def
+	$(DLLTOOL) -k -d winhttp32.def -l libwinhttp.a
+endif
+
+endif
diff --git a/configure.ac b/configure.ac
index a3789d9..7516d68 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,22 @@ case "${host}" in
 	;;
 esac
 
+dnl Check for 64 bit Windows
+WIN64="no"
+if test "${WIN32}" = "yes"; then
+  AC_MSG_CHECKING([if building for 64 bit Windows])
+  case "${host}" in
+    *64-*-*)
+      AC_MSG_RESULT([yes])
+      WIN64="yes"
+      ;;
+    *)
+      AC_MSG_RESULT([no])
+      ;;
+  esac
+fi
+
+
 AC_ARG_ENABLE(lzo,
    [  --disable-lzo           Disable LZO compression support],
    [LZO="$enableval"],
@@ -665,6 +681,42 @@ if test "${WIN32}" = "yes"; then
 fi
 
 dnl
+dnl Check if MinGW knows about WinHTTP API
+dnl
+if test "${WIN32}" = "yes"; then
+   AC_MSG_CHECKING([if MinGW knows about WinHTTP])
+   AC_TRY_LINK([
+       #include <windows.h>
+       #include <winhttp.h>
+     ], [
+       LPWSTR *url;
+       HINTERNET session;
+       WINHTTP_PROXY_INFO proxy_info;
+       WINHTTP_AUTOPROXY_OPTIONS proxy_options;
+       WINHTTP_CURRENT_USER_IE_PROXY_CONFIG ie_proxy_info;
+
+       WinHttpGetDefaultProxyConfiguration (&proxy_info);
+       WinHttpGetIEProxyConfigForCurrentUser (&ie_proxy_info);
+       WinHttpDetectAutoProxyConfigUrl (WINHTTP_AUTO_DETECT_TYPE_DHCP | WINHTTP_AUTO_DETECT_TYPE_DNS_A, url);
+       session = WinHttpOpen (NULL, WINHTTP_ACCESS_TYPE_NO_PROXY, WINHTTP_NO_PROXY_NAME, WINHTTP_NO_PROXY_BYPASS, 0);
+       WinHttpGetProxyForUrl (session, L"http://openvpn.net", &proxy_options, &proxy_info);
+       WinHttpCloseHandle (session);
+     ], [
+       AC_MSG_RESULT([yes])
+       OPENVPN_ADD_LIBS(-lwinhttp)
+       AC_DEFINE([HAVE_WINHTTP], [1], [WinHTTP is available in MinGW])
+     ], [
+       AC_MSG_RESULT([no])
+       AM_CONDITIONAL([BUILD_WINHTTP_IMPLIB], [true])
+       AC_MSG_NOTICE([Compiling own WinHTTP import library.])
+       AC_CHECK_TOOL([DLLTOOL], [dlltool])
+       if test -z "$DLLTOOL"; then
+         AC_MSG_ERROR([Could not find dlltool. Make sure you have binutils for Windows.])
+       fi
+     ])
+fi
+
+dnl
 dnl check for LZO library
 dnl
 
@@ -920,6 +972,7 @@ AC_SUBST(TAP_WIN32_MIN_MINOR)
 win32datadir="\${datadir}/${PACKAGE}-win32"
 AC_SUBST(win32datadir)
 AM_CONDITIONAL(WIN32, test "${WIN32}" = "yes")
+AM_CONDITIONAL(WIN64, test "${WIN64}" = "yes")
 
 # workaround for <autoconf-2.60
 if test -z "${docdir}"; then
diff --git a/win32.c b/win32.c
index cf6cc2d..9f150e9 100644
--- a/win32.c
+++ b/win32.c
@@ -1128,4 +1128,6 @@ win_get_tempdir()
   }
   return tmpdir;
 }
+
+
 #endif
diff --git a/win32.h b/win32.h
index 87d8ecc..f1cc78e 100644
--- a/win32.h
+++ b/win32.h
@@ -288,5 +288,70 @@ int inet_pton(int af, const char *src, void *st);
 /* Find temporary directory */
 const char *win_get_tempdir();
 
+/*
+ * If MinGW does not know about the WinHTTP C API functions and
+ * constants that are used for automatic proxy server detection
+ * they are declared here. For detailed information see:
+ * http://msdn.microsoft.com/en-us/library/aa384252%28v=VS.85%29.aspx
+ */
+#ifdef HAVE_WINHTTP
+
+#include <winhttp.h>
+
+#else /* HAVE_WINHTTP */
+
+#include <windows.h>
+#include <wininet.h>
+
+/* WINHTTP_PROXY_INFO dwAccessType constants */
+/* and WinHttpOpen() access_type             */
+#define WINHTTP_ACCESS_TYPE_NO_PROXY     1
+#define WINHTTP_ACCESS_TYPE_NAMED_PROXY  3
+
+/* WinHttpDetectAutoProxyConfigUrl() flags */
+#define WINHTTP_AUTO_DETECT_TYPE_DHCP   1
+#define WINHTTP_AUTO_DETECT_TYPE_DNS_A  2
+
+/* WINHTTP_AUTOPROXY_OPTIONS dwFlags */
+#define WINHTTP_AUTOPROXY_CONFIG_URL   2
+
+/* WinHttpOpen() proxy and bypass values */
+#define WINHTTP_NO_PROXY_NAME    0
+#define WINHTTP_NO_PROXY_BYPASS  0
+
+typedef struct {
+  DWORD  dwAccessType;
+  LPWSTR lpszProxy;
+  LPWSTR lpszProxyBypass;
+} WINHTTP_PROXY_INFO;
+
+typedef struct {
+  BOOL   fAutoDetect;
+  LPWSTR lpszAutoConfigUrl;
+  LPWSTR lpszProxy;
+  LPWSTR lpszProxyBypass;
+} WINHTTP_CURRENT_USER_IE_PROXY_CONFIG;
+
+typedef struct {
+  DWORD   dwFlags;
+  DWORD   dwAutoDetectFlags;
+  LPCWSTR lpszAutoConfigUrl;
+  LPVOID  lpvReserved;
+  DWORD   dwReserved;
+  BOOL    fAutoLogonIfChallenged;
+} WINHTTP_AUTOPROXY_OPTIONS;
+
+HINTERNET WINAPI WinHttpOpen (LPCWSTR user_agent, DWORD access_type,
+		       LPCWSTR proxy, LPCWSTR bypass, DWORD flags);
+BOOL WINAPI WinHttpCloseHandle (HINTERNET session);
+BOOL WINAPI WinHttpGetDefaultProxyConfiguration (WINHTTP_PROXY_INFO *proxy_info);
+BOOL WINAPI WinHttpGetIEProxyConfigForCurrentUser (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG *proxy_config);
+BOOL WINAPI WinHttpDetectAutoProxyConfigUrl (DWORD flags, LPWSTR *url);
+BOOL WINAPI WinHttpGetProxyForUrl (HINTERNET session, LPCWSTR url,
+			    WINHTTP_AUTOPROXY_OPTIONS *options,
+			    WINHTTP_PROXY_INFO *proxy_info);
+
+#endif /* HAVE_WINHTTP */
+
 #endif
 #endif
diff --git a/winhttp32.def b/winhttp32.def
new file mode 100644
index 0000000..4be9274
--- /dev/null
+++ b/winhttp32.def
@@ -0,0 +1,8 @@
+LIBRARY "WINHTTP.dll"
+EXPORTS
+WinHttpCloseHandle@...1477...
+WinHttpDetectAutoProxyConfigUrl@...1499...
+WinHttpGetDefaultProxyConfiguration@...1477...
+WinHttpGetIEProxyConfigForCurrentUser@...1477...
+WinHttpGetProxyForUrl@...1500...
+WinHttpOpen@...1501...
diff --git a/winhttp64.def b/winhttp64.def
new file mode 100644
index 0000000..dd8cc9b
--- /dev/null
+++ b/winhttp64.def
@@ -0,0 +1,8 @@
+LIBRARY "WINHTTP.dll"
+EXPORTS
+WinHttpCloseHandle
+WinHttpDetectAutoProxyConfigUrl
+WinHttpGetDefaultProxyConfiguration
+WinHttpGetIEProxyConfigForCurrentUser
+WinHttpGetProxyForUrl
+WinHttpOpen
-- 
1.7.5.4


