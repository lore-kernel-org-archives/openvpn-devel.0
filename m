From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 13:42:47 +0000
Message-Id: <1313588569-18927-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
References: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 1/3] add MinGW WinHTTP compatibility layer
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
performed is to provide wrapper functions and dynamically map the missing
library into the address space, get the function pointer for the actual API
and call it with the arguments provided.

To keep things managable and short in the source code two preprocessor macros
are defined that do most of the work.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 configure.ac |   30 ++++++++++++++++
 win32.c      |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 win32.h      |   61 ++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index a3789d9..42d46cb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -665,6 +665,36 @@ if test "${WIN32}" = "yes"; then
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
+     ], [
+       AC_MSG_RESULT([no.])
+       AC_MSG_NOTICE([Enabling WinHTTP compatibility layer.])
+       AC_DEFINE(USE_WINHTTP_COMPAT, 1, [Use the WinHTTP compatibility layer])
+     ])
+fi
+
+dnl
 dnl check for LZO library
 dnl
 
diff --git a/win32.c b/win32.c
index cf6cc2d..15743a8 100644
--- a/win32.c
+++ b/win32.c
@@ -1128,4 +1128,112 @@ win_get_tempdir()
   }
   return tmpdir;
 }
+
+
+#ifdef USE_WINHTTP_COMPAT
+
+/*
+ * MinGW is missing support for winhttp.dll which is used for automatic
+ * proxy server detection. Until it becomes available the workaround is
+ * to dynamically map the library into the address space and get the
+ * function pointers for the APIs that are used. The two macros below
+ * do just that.
+ *
+ * PROVIDE_WIN32_LIBRARY provides means to access API functions.
+ *     Arguments: LIB - name of the DLL to load
+ *
+ * DEFINE_WIN32_WRAPPER defines a wrapper function around the
+ * original API provoded by the library. The original API can
+ * be accessed within the wrapper as <LIB>_<FUNC> (see Arguments).
+ *     Arguments: LIB   name of the DLL the function is exported in
+ *                ERR   value to return in case something goes wrong
+ *                RET   API function's return value type
+ *                FUNC  exported name of the API function
+ *                ARGS  declaration of the API function arguments
+ *                BODY  the wrapper function's body
+ */
+
+#define PROVIDE_WIN32_LIBRARY(LIB)                                    \
+  static HMODULE get_ ## LIB ## _library ()                           \
+  {                                                                   \
+    static HMODULE lib = NULL;                                        \
+                                                                      \
+    if (lib == NULL)                                                  \
+      {                                                               \
+	char name[MAX_PATH];                                          \
+	UINT len = GetSystemDirectory (name, sizeof (name));          \
+	if (len == 0)                                                 \
+	  return NULL;                                                \
+                                                                      \
+	strncpy (name + len, "\\" #LIB ".dll", sizeof (name) - len);  \
+	name[sizeof (name) - 1] = '\0';                               \
+                                                                      \
+	lib = LoadLibrary (name);                                     \
+      }                                                               \
+                                                                      \
+    return lib;                                                       \
+  }
+
+#define DEFINE_WIN32_WRAPPER(LIB, ERR, RET, FUNC, ARGS, BODY)  \
+  RET FUNC ARGS                                                \
+  {                                                            \
+    typedef RET (WINAPI *(FUNC ## _fn)) ARGS;                  \
+    static FUNC ## _fn  LIB ## _ ## FUNC = NULL;               \
+                                                               \
+    if ((LIB ## _ ## FUNC) == NULL)                            \
+      {                                                        \
+	union {                                                \
+	  FUNC ## _fn *type;                                   \
+	  FARPROC *ptr;                                        \
+	} u = { .type = &(LIB ## _ ## FUNC) };                 \
+                                                               \
+	HMODULE lib = get_ ## LIB ## _library ();              \
+	if (lib == NULL)                                       \
+	  return (ERR);                                        \
+                                                               \
+	*(u.ptr) = GetProcAddress (lib, (#FUNC));              \
+	if ((LIB ## _ ## FUNC) == NULL)                        \
+	  return (ERR);                                        \
+      }                                                        \
+                                                               \
+    BODY                                                       \
+  }
+
+
+PROVIDE_WIN32_LIBRARY (winhttp)
+
+DEFINE_WIN32_WRAPPER (winhttp, NULL, HINTERNET,
+WinHttpOpen, (LPCWSTR user_agent, DWORD access_type, LPCWSTR proxy, LPCWSTR bypass, DWORD flags),
+  return winhttp_WinHttpOpen (user_agent, access_type, proxy, bypass, flags);
+)
+
+DEFINE_WIN32_WRAPPER (winhttp, FALSE, BOOL,
+WinHttpCloseHandle, (HINTERNET session),
+  return winhttp_WinHttpCloseHandle (session);
+)
+
+DEFINE_WIN32_WRAPPER (winhttp, FALSE, BOOL,
+WinHttpGetDefaultProxyConfiguration, (WINHTTP_PROXY_INFO *proxy_info),
+  return winhttp_WinHttpGetDefaultProxyConfiguration (proxy_info);
+)
+
+DEFINE_WIN32_WRAPPER (winhttp, FALSE, BOOL,
+WinHttpGetIEProxyConfigForCurrentUser, (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG *proxy_config),
+  return winhttp_WinHttpGetIEProxyConfigForCurrentUser(proxy_config);
+)
+
+DEFINE_WIN32_WRAPPER (winhttp, FALSE, BOOL,
+WinHttpDetectAutoProxyConfigUrl, (DWORD flags, LPWSTR *url),
+  return winhttp_WinHttpDetectAutoProxyConfigUrl (flags, url);
+)
+
+DEFINE_WIN32_WRAPPER (winhttp, FALSE, BOOL,
+WinHttpGetProxyForUrl, (HINTERNET session, LPCWSTR url,
+			WINHTTP_AUTOPROXY_OPTIONS *options,
+			WINHTTP_PROXY_INFO *proxy_info),
+  return winhttp_WinHttpGetProxyForUrl (session, url, options, proxy_info);
+)
+
+#endif /* USE_WINHTTP_COMPAT */
+
 #endif
diff --git a/win32.h b/win32.h
index 87d8ecc..2ff4b8c 100644
--- a/win32.h
+++ b/win32.h
@@ -288,5 +288,66 @@ int inet_pton(int af, const char *src, void *st);
 /* Find temporary directory */
 const char *win_get_tempdir();
 
+/*
+ * If MinGW does not know about the WinHTTP C API functions and
+ * constants that are used for automatic proxy server detection
+ * they are declared here. For detailed information see:
+ * http://msdn.microsoft.com/en-us/library/aa384252%28v=VS.85%29.aspx
+ */
+#ifdef USE_WINHTTP_COMPAT
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
+HINTERNET WinHttpOpen (LPCWSTR user_agent, DWORD access_type,
+		       LPCWSTR proxy, LPCWSTR bypass, DWORD flags);
+BOOL WinHttpCloseHandle (HINTERNET session);
+BOOL WinHttpGetDefaultProxyConfiguration (WINHTTP_PROXY_INFO *proxy_info);
+BOOL WinHttpGetIEProxyConfigForCurrentUser (WINHTTP_CURRENT_USER_IE_PROXY_CONFIG *proxy_config);
+BOOL WinHttpDetectAutoProxyConfigUrl (DWORD flags, LPWSTR *url);
+BOOL WinHttpGetProxyForUrl (HINTERNET session, LPCWSTR url,
+			    WINHTTP_AUTOPROXY_OPTIONS *options,
+			    WINHTTP_PROXY_INFO *proxy_info);
+
+#endif /* USE_WINHTTP_COMPAT */
+
 #endif
 #endif
-- 
1.7.5.4


