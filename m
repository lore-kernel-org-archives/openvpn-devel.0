From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 29 Dec 2015 23:02:37 +0200
Message-Id: <1451422957-23951-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20151229200710.GP24952@...1296...>
References: <20151229200710.GP24952@...1296...>
Subject: [Openvpn-devel] [PATCH master] Detecting and logging Windows
	versions
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

Also send it with peer-info as IV_PLAT_VER.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 config-msvc.h                      |  1 +
 configure.ac                       |  1 +
 src/compat/Makefile.am             |  3 +-
 src/compat/compat-versionhelpers.h | 81 ++++++++++++++++++++++++++++++++++++++
 src/openvpn/openvpn.c              |  3 ++
 src/openvpn/options.c              | 12 ++++++
 src/openvpn/options.h              |  4 ++
 src/openvpn/ssl.c                  |  3 ++
 src/openvpn/win32.c                | 63 +++++++++++++++++++++++++++++
 src/openvpn/win32.h                | 13 ++++++
 10 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 src/compat/compat-versionhelpers.h

diff --git a/config-msvc.h b/config-msvc.h
index aa0eeff..0bcf719 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -44,6 +44,7 @@
 #define HAVE_SYS_STAT_H 1
 #define HAVE_LZO_LZO1X_H 1
 #define HAVE_LZO_LZOUTIL_H 1
+#define HAVE_VERSIONHELPERS_H 1
 
 #define HAVE_ACCESS 1
 #define HAVE_CHDIR 1
diff --git a/configure.ac b/configure.ac
index 721395d..4b2eb01 100644
--- a/configure.ac
+++ b/configure.ac
@@ -434,6 +434,7 @@ AC_CHECK_HEADERS([ \
 	netinet/in.h netinet/in_systm.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
 	windows.h winsock2.h ws2tcpip.h \
+	versionhelpers.h \
 ])
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 4591b85..06bab5c 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -27,4 +27,5 @@ libcompat_la_SOURCES = \
 	compat-daemon.c \
 	compat-inet_ntop.c \
 	compat-inet_pton.c \
-	compat-lz4.c compat-lz4.h
+	compat-lz4.c compat-lz4.h \
+	compat-versionhelpers.h
diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
new file mode 100644
index 0000000..f634091
--- /dev/null
+++ b/src/compat/compat-versionhelpers.h
@@ -0,0 +1,81 @@
+/**
+ * This file is part of the mingw-w64 runtime package.
+ * No warranty is given; refer to the file DISCLAIMER within this package.
+ */
+
+#ifndef _INC_VERSIONHELPERS
+#define _INC_VERSIONHELPERS
+
+#include <winapifamily.h>
+
+#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) && !defined(__WIDL__)
+
+#ifdef __cplusplus
+#define VERSIONHELPERAPI inline bool
+#else
+#define VERSIONHELPERAPI FORCEINLINE BOOL
+#endif
+
+#define _WIN32_WINNT_WINBLUE    0x0603
+
+VERSIONHELPERAPI IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
+{
+    OSVERSIONINFOEXW vi = {sizeof(vi),major,minor,0,0,{0},servpack};
+    return VerifyVersionInfoW(&vi, VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACKMAJOR,
+        VerSetConditionMask(VerSetConditionMask(VerSetConditionMask(0,
+            VER_MAJORVERSION,VER_GREATER_EQUAL),
+            VER_MINORVERSION,VER_GREATER_EQUAL),
+            VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL));
+}
+
+VERSIONHELPERAPI IsWindowsXPOrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 0);
+}
+
+VERSIONHELPERAPI IsWindowsXPSP1OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 1);
+}
+
+VERSIONHELPERAPI IsWindowsXPSP2OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 2);
+}
+
+VERSIONHELPERAPI IsWindowsXPSP3OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 3);
+}
+
+VERSIONHELPERAPI IsWindowsVistaOrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 0);
+}
+
+VERSIONHELPERAPI IsWindowsVistaSP1OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 1);
+}
+
+VERSIONHELPERAPI IsWindowsVistaSP2OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 2);
+}
+
+VERSIONHELPERAPI IsWindows7OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 0);
+}
+
+VERSIONHELPERAPI IsWindows7SP1OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 1);
+}
+
+VERSIONHELPERAPI IsWindows8OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8), 0);
+}
+
+VERSIONHELPERAPI IsWindows8Point1OrGreater(void) {
+    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0);
+}
+
+VERSIONHELPERAPI IsWindowsServer(void) {
+    OSVERSIONINFOEXW vi = {sizeof(vi),0,0,0,0,{0},0,0,0,VER_NT_WORKSTATION};
+    return !VerifyVersionInfoW(&vi, VER_PRODUCT_TYPE, VerSetConditionMask(0, VER_PRODUCT_TYPE, VER_EQUAL));
+}
+
+#endif
+#endif
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 32e326e..823c3dd 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -220,6 +220,9 @@ openvpn_main (int argc, char *argv[])
 
 	  /* print version number */
 	  msg (M_INFO, "%s", title_string);
+#ifdef WIN32
+	  show_windows_version(M_INFO);
+#endif
 	  show_library_versions(M_INFO);
 
 	  /* misc stuff */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 46aa824..daa311d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3438,6 +3438,15 @@ usage_small (void)
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
 
+#ifdef WIN32
+void show_windows_version(const unsigned int flags)
+{
+  struct gc_arena gc = gc_new ();
+  msg (flags, "Windows version %s", win32_version_string (&gc, true));
+  gc_free (&gc);
+}
+#endif
+
 void
 show_library_versions(const unsigned int flags)
 {
@@ -3463,6 +3472,9 @@ usage_version (void)
 {
   msg (M_INFO|M_NOPREFIX, "%s", title_string);
   show_library_versions( M_INFO|M_NOPREFIX );
+#ifdef WIN32
+  show_windows_version( M_INFO|M_NOPREFIX );
+#endif  
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
   msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>");
 #ifndef ENABLE_SMALL
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f6c8b4..9e8a6a0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -688,6 +688,10 @@ void usage_small (void);
 
 void show_library_versions(const unsigned int flags);
 
+#ifdef WIN32
+void show_windows_version(const unsigned int flags);
+#endif
+
 void init_options (struct options *o, const bool init_gc);
 void uninit_options (struct options *o);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 665fdd7..443661c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -42,6 +42,7 @@
 #endif
 
 #include "syshead.h"
+#include "win32.h"
 
 #if defined(ENABLE_CRYPTO)
 
@@ -1868,6 +1869,8 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 	  if (rgi.flags & RGI_HWADDR_DEFINED)
 	    buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
 	  buf_printf (&out, "IV_SSL=%s\n", get_ssl_library_version() );
+
+	  buf_printf (&out, "IV_PLAT_VER=%s\n", win32_version_string (&gc, false));
         }
 
       /* push env vars that begin with UV_ and IV_GUI_VER */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 64dc1f7..a01121b 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -46,6 +46,12 @@
 
 #include "memdbg.h"
 
+#ifdef HAVE_VERSIONHELPERS_H
+#include <versionhelpers.h>
+#else
+#include "compat-versionhelpers.h"
+#endif
+
 /*
  * WFP-related defines and GUIDs.
  */
@@ -1288,4 +1294,61 @@ win_wfp_uninit()
     return true;
 }
 
+int
+win32_version_info()
+{
+    if (!IsWindowsXPOrGreater())
+    {
+        msg (M_FATAL, "Error: Windows version must be XP or greater.");
+    }
+
+    if (!IsWindowsVistaOrGreater())
+    {
+        return WIN_XP;
+    }
+
+    if (!IsWindows7OrGreater())
+    {
+        return WIN_VISTA;
+    }
+
+    if (!IsWindows8OrGreater())
+    {
+        return WIN_7;
+    }
+    else
+    {
+        return WIN_8;
+    }
+}
+
+const char *
+win32_version_string(struct gc_arena *gc, bool add_name)
+{
+    int version = win32_version_info();
+    struct buffer out = alloc_buf_gc (256, gc);
+
+    switch (version)
+    {
+        case WIN_XP:
+            buf_printf (&out, "5.1%s", add_name ? " (Windows XP)" : "");
+            break;
+        case WIN_VISTA:
+            buf_printf (&out, "6.0%s", add_name ? " (Windows Vista)" : "");
+            break;
+        case WIN_7:
+            buf_printf (&out, "6.1%s", add_name ? " (Windows 7)" : "");
+            break;
+        case WIN_8:
+            buf_printf (&out, "6.2%s", add_name ? " (Windows 8 or greater)" : "");
+            break;
+        default:
+            msg (M_NONFATAL, "Unknown Windows version: %d", version);
+            buf_printf (&out, "0.0%s", add_name ? " (unknown)" : "");
+            break;
+    }
+
+    return (const char *)out.data;
+}
+
 #endif
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index a5baebd..1e98207 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -274,5 +274,18 @@ WCHAR *wide_string (const char* utf8, struct gc_arena *gc);
 bool win_wfp_block_dns(const NET_IFINDEX index);
 bool win_wfp_uninit();
 
+#define WIN_XP 0
+#define WIN_VISTA 1
+#define WIN_7 2
+#define WIN_8 3
+
+int win32_version_info();
+
+/*
+String representation of Windows version number and name, see
+https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832(v=vs.85).aspx
+*/
+const char * win32_version_string(struct gc_arena *gc, bool add_name);
+
 #endif
 #endif
-- 
1.9.1


