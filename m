From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Nov 2023 11:39:50 +0100
Message-Id: <20231128103950.62407-1-frank@...2641...>
In-Reply-To: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
References: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Remove compat versionhelpers.h and
 remove cmake/configure check for it
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

From: Arne Schwabe <arne@...1227...>

The cmake file defined that file to be never present in contrast to the
old msvc-config.h that always had it present.
Remove also the compat implementation taken from mingw. All our current
build environments already have that header in place.

Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/445
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

I fixed two typos in commit message relative to Gerrit
submission.
        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..fa6d623 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -308,7 +308,6 @@
     src/compat/compat-dirname.c
     src/compat/compat-gettimeofday.c
     src/compat/compat-strsep.c
-    src/compat/compat-versionhelpers.h
     src/openvpn/argv.c
     src/openvpn/argv.h
     src/openvpn/base64.c
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..8edaff4 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -374,9 +374,6 @@
 /* Define to 1 if you have the <valgrind/memcheck.h> header file. */
 #undef HAVE_VALGRIND_MEMCHECK_H
 
-/* Define to 1 if you have the <versionhelpers.h> header file. */
-#undef HAVE_VERSIONHELPERS_H
-
 /* Define to 1 if you have the `vfork' function. */
 #undef HAVE_VFORK
 
diff --git a/configure.ac b/configure.ac
index 84eaad6..94c6654 100644
--- a/configure.ac
+++ b/configure.ac
@@ -455,7 +455,6 @@
 	unistd.h dlfcn.h \
 	netinet/in.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
-	versionhelpers.h \
 ])
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index f5de451..5298dd8 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -20,5 +20,4 @@
 	compat-basename.c \
 	compat-gettimeofday.c \
 	compat-daemon.c \
-	compat-strsep.c \
-	compat-versionhelpers.h
+	compat-strsep.c
\ No newline at end of file
diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
deleted file mode 100644
index b071602..0000000
--- a/src/compat/compat-versionhelpers.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/**
- * This file is part of the mingw-w64 runtime package.
- * No warranty is given; refer to the file DISCLAIMER within this package.
- */
-
-#ifndef _INC_VERSIONHELPERS
-#define _INC_VERSIONHELPERS
-
-#include <winapifamily.h>
-
-#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) && !defined(__WIDL__)
-
-#ifdef __cplusplus
-#define VERSIONHELPERAPI inline bool
-#else
-#define VERSIONHELPERAPI FORCEINLINE BOOL
-#endif
-
-#define _WIN32_WINNT_WINBLUE    0x0603
-
-#ifndef _WIN32_WINNT_WINTHRESHOLD
-#define _WIN32_WINNT_WINTHRESHOLD    0x0A00 /* Windows 10 */
-#endif
-
-VERSIONHELPERAPI
-IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
-{
-    OSVERSIONINFOEXW vi = {sizeof(vi), major, minor, 0, 0, {0}, servpack};
-    return VerifyVersionInfoW(&vi, VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACKMAJOR,
-                              VerSetConditionMask(VerSetConditionMask(VerSetConditionMask(0,
-                                                                                          VER_MAJORVERSION, VER_GREATER_EQUAL),
-                                                                      VER_MINORVERSION, VER_GREATER_EQUAL),
-                                                  VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL));
-}
-
-VERSIONHELPERAPI
-IsWindowsXPOrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 0);
-}
-
-VERSIONHELPERAPI
-IsWindowsXPSP1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 1);
-}
-
-VERSIONHELPERAPI
-IsWindowsXPSP2OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 2);
-}
-
-VERSIONHELPERAPI
-IsWindowsXPSP3OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 3);
-}
-
-VERSIONHELPERAPI
-IsWindowsVistaOrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 0);
-}
-
-VERSIONHELPERAPI
-IsWindowsVistaSP1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 1);
-}
-
-VERSIONHELPERAPI
-IsWindowsVistaSP2OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 2);
-}
-
-VERSIONHELPERAPI
-IsWindows7OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 0);
-}
-
-VERSIONHELPERAPI
-IsWindows7SP1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 1);
-}
-
-VERSIONHELPERAPI
-IsWindows8OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8), 0);
-}
-
-VERSIONHELPERAPI
-IsWindows8Point1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0);
-}
-
-VERSIONHELPERAPI
-IsWindows10OrGreater()
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), LOBYTE(_WIN32_WINNT_WINTHRESHOLD), 0);
-}
-
-VERSIONHELPERAPI
-IsWindowsServer(void)
-{
-    OSVERSIONINFOEXW vi = {sizeof(vi), 0, 0, 0, 0, {0}, 0, 0, 0, VER_NT_WORKSTATION};
-    return !VerifyVersionInfoW(&vi, VER_PRODUCT_TYPE, VerSetConditionMask(0, VER_PRODUCT_TYPE, VER_EQUAL));
-}
-
-#endif /* if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) && !defined(__WIDL__) */
-#endif /* ifndef _INC_VERSIONHELPERS */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 47eb1fc..e998d90 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -45,11 +45,7 @@
 
 #include "memdbg.h"
 
-#ifdef HAVE_VERSIONHELPERS_H
 #include <versionhelpers.h>
-#else
-#include "compat-versionhelpers.h"
-#endif
 
 #include "block_dns.h"
 
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a47db8a..32c8996 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -34,11 +34,7 @@
 #include <shellapi.h>
 #include <mstcpip.h>
 
-#ifdef HAVE_VERSIONHELPERS_H
 #include <versionhelpers.h>
-#else
-#include "compat-versionhelpers.h"
-#endif
 
 #include "openvpn-msg.h"
 #include "validate.h"

