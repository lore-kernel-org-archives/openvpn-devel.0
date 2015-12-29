From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 29 Dec 2015 18:03:04 +0200
Message-Id: <1451404984-6048-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Detecting Windows version
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

* Use adapter name instead of index on WinXP - sadly XP does not support indexes
* Write Windows version to log
* Send it with peer-info as IV_PLAT_VER

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 config-msvc.h                      |  1 +
 configure.ac                       |  1 +
 src/compat/compat-versionhelpers.h | 81 ++++++++++++++++++++++++++++++++++++++
 src/openvpn/openvpn.c              |  3 ++
 src/openvpn/options.c              | 12 ++++++
 src/openvpn/options.h              |  4 ++
 src/openvpn/route.c                | 19 ++++++---
 src/openvpn/ssl.c                  |  2 +
 src/openvpn/tun.c                  |  2 +-
 src/openvpn/win32.c                | 63 +++++++++++++++++++++++++++++
 src/openvpn/win32.h                | 13 ++++++
 11 files changed, 194 insertions(+), 7 deletions(-)
 create mode 100644 src/compat/compat-versionhelpers.h

diff --git a/config-msvc.h b/config-msvc.h
index fa99384..ae43a5f 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -45,6 +45,7 @@
 #define HAVE_SYS_STAT_H 1
 #define HAVE_LZO_LZO1X_H 1
 #define HAVE_LZO_LZOUTIL_H 1
+#define HAVE_VERSIONHELPERS_H 1
 
 #define HAVE_ACCESS 1
 #define HAVE_CHDIR 1
diff --git a/configure.ac b/configure.ac
index 87d9116..773cded 100644
--- a/configure.ac
+++ b/configure.ac
@@ -423,6 +423,7 @@ AC_CHECK_HEADERS([ \
 	netinet/in.h netinet/in_systm.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
 	windows.h winsock2.h ws2tcpip.h \
+	versionhelpers.h \
 ])
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
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
index 1832bc5..652fdc4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3489,6 +3489,15 @@ usage_small (void)
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
@@ -3514,6 +3523,9 @@ usage_version (void)
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
index 622706a..26b09ea 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -690,6 +690,10 @@ void usage_small (void);
 
 void show_library_versions(const unsigned int flags);
 
+#ifdef WIN32
+void show_windows_version(const unsigned int flags);
+#endif
+
 void init_options (struct options *o, const bool init_gc);
 void uninit_options (struct options *o);
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index cf5a067..a52a803 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -42,6 +42,7 @@
 #include "manage.h"
 #include "win32.h"
 #include "options.h"
+#include "win32.h"
 
 #include "memdbg.h"
 
@@ -1623,9 +1624,12 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
 #elif defined (WIN32)
 
-  struct buffer out = alloc_buf_gc (64, &gc);
-  buf_printf (&out, "interface=%d", tt->adapter_index );
-  device = buf_bptr(&out);
+  if (win32_version_info() != WIN_XP)
+    {
+	struct buffer out = alloc_buf_gc (64, &gc);
+	buf_printf (&out, "interface=%d", tt->adapter_index );
+	device = buf_bptr(&out);
+    }
 
   /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
   argv_printf (&argv, "%s%sc interface ipv6 add route %s/%d %s",
@@ -1958,9 +1962,12 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
 #elif defined (WIN32)
 
-  struct buffer out = alloc_buf_gc (64, &gc);
-  buf_printf (&out, "interface=%d", tt->adapter_index );
-  device = buf_bptr(&out);
+  if (win32_version_info() != WIN_XP)
+    {
+	struct buffer out = alloc_buf_gc (64, &gc);
+	buf_printf (&out, "interface=%d", tt->adapter_index );
+	device = buf_bptr(&out);
+    }
 
   /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
   argv_printf (&argv, "%s%sc interface ipv6 delete route %s/%d %s",
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f728ffb..5a89672 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -43,6 +43,7 @@
 #endif
 
 #include "syshead.h"
+#include "win32.h"
 
 #if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
@@ -1831,6 +1832,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf (&out, "IV_PLAT=freebsd\n");
 #elif defined(WIN32)
       buf_printf (&out, "IV_PLAT=win\n");
+      buf_printf (&out, "IV_PLAT_VER=%s\n", win32_version_string (&gc, false));
 #endif
 
       /* push LZO status */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b08c827..bb019c0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1244,7 +1244,7 @@ do_ifconfig (struct tuntap *tt,
 		     "%s%sc interface ipv6 set address %s %s store=active",
 		     get_win_sys_path(),
 		     NETSH_PATH_SUFFIX,
-		     iface,
+		     win32_version_info() == WIN_XP ? actual : iface,
 		     ifconfig_ipv6_local);
 	netsh_command (&argv, 4);
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e87cb7f..6c6ac4c 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -48,6 +48,12 @@
 
 #include "win32_wfp.h"
 
+#ifdef HAVE_VERSIONHELPERS_H
+#include <versionhelpers.h>
+#else
+#include "compat-versionhelpers.h"
+#endif
+
 /* WFP function pointers. Initialized in win_wfp_init_funcs() */
 func_ConvertInterfaceIndexToLuid ConvertInterfaceIndexToLuid = NULL;
 func_FwpmEngineOpen0 FwpmEngineOpen0 = NULL;
@@ -1289,4 +1295,61 @@ win_wfp_uninit()
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
index 776ef36..0990182 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -275,5 +275,18 @@ bool win_wfp_init_funcs();
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


