From: David Sommerseth <openvpn.list@...1114...>
Date: Fri,  3 Oct 2014 15:57:41 +0200
Message-Id: <1412344661-26600-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] systemd: Use systemd functions to consider
	systemd availability
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

From: David Sommerseth <davids@...1347...>

This is another systemd implementation clean-up.  It was found that
SELinux will block OpenVPN from checking /sys/fs/cgroups.  As OpenVPN
only checked /sys/fs/cgroups and /sys/fs/cgroups/systemd to see if
systemd was available or not, it was considered better to query
systemd directly to see whether or not to query for usernames and
passwords via systemd.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac            | 37 ++++++++++++++++++++++++++++++++++++-
 src/openvpn/Makefile.am |  1 +
 src/openvpn/console.c   | 10 ++++++----
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6667019..06371c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -997,6 +997,41 @@ if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
 fi
 
 
+dnl
+dnl Check for systemd
+dnl
+
+AC_ARG_VAR([SYSTEMD_LIBS], [linker flags for systemd])
+if test "$enable_systemd" = "yes" ; then
+    AC_CHECKING([for systemd Library and Header files])
+    havesystemdlib=1
+
+    # if SYSTEMD_LIBS is set, we assume it will work, otherwise test
+    saved_LIBS="${CFLAGS}"
+    LIBS="${LIBS} ${SYSTEMD_LIBS}"
+    if test -z "${SYSTEMD_LIBS}"; then
+	AC_CHECK_LIB(systemd-daemon, sd_booted,
+	    [ SYSTEMD_LIBS="-lsystemd-daemon" ],
+	    [
+	        AC_MSG_ERROR([systemd-daemon library not found.])
+	        havesystemdlib=0
+	    ])
+    fi
+
+    AC_CHECK_HEADERS(systemd/sd-daemon.h,
+       ,
+       [
+	   AC_MSG_RESULT([systemd headers not found.])
+	   havesnappylib=0
+       ])
+
+    if test $havesnappylib = 0 ; then
+        AC_MSG_ERROR([systemd headers or library not available])
+    fi
+    OPTIONAL_SYSTEMD_LIBS="${SYSTEMD_LIBS}"
+    AC_DEFINE(ENABLE_SYSTEMD, 1, [Enable systemd integration])
+    LIBS="${saved_LIBS}"
+fi
 
 
 AC_MSG_CHECKING([git checkout])
@@ -1037,7 +1072,6 @@ test "${enable_def_auth}" = "yes" && AC_DEFINE([ENABLE_DEF_AUTH], [1], [Enable d
 test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal packet filter])
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 test "${enable_password_save}" = "yes" && AC_DEFINE([ENABLE_PASSWORD_SAVE], [1], [Allow --askpass and --auth-user-pass passwords to be read from a file])
-test "${enable_systemd}" = "yes" && AC_DEFINE([ENABLE_SYSTEMD], [1], [Enable systemd support])
 
 case "${with_crypto_library}" in
 	openssl)
@@ -1170,6 +1204,7 @@ AC_SUBST([OPTIONAL_SNAPPY_CFLAGS])
 AC_SUBST([OPTIONAL_SNAPPY_LIBS])
 AC_SUBST([OPTIONAL_LZ4_CFLAGS])
 AC_SUBST([OPTIONAL_LZ4_LIBS])
+AC_SUBST([OPTIONAL_SYSTEMD_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index fd593c5..d089f50 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -126,6 +126,7 @@ openvpn_LDADD = \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \
 	$(OPTIONAL_CRYPTO_LIBS) \
 	$(OPTIONAL_SELINUX_LIBS) \
+	$(OPTIONAL_SYSTEMD_LIBS) \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 337b1bb..d66d408 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -34,6 +34,10 @@
 #include "buffer.h"
 #include "misc.h"
 
+#ifdef ENABLE_SYSTEMD
+#include <systemd/sd-daemon.h>
+#endif
+
 #ifdef WIN32
 
 #include "win32.h"
@@ -143,15 +147,13 @@ close_tty (FILE *fp)
 static bool
 check_systemd_running ()
 {
-  struct stat a, b, c;
+  struct stat c;
 
   /* We simply test whether the systemd cgroup hierarchy is
    * mounted, as well as the systemd-ask-password executable
    * being available */
 
-  return (lstat("/sys/fs/cgroup", &a) == 0)
-	  && (lstat("/sys/fs/cgroup/systemd", &b) == 0)
-	  && (a.st_dev != b.st_dev)
+  return (sd_booted() > 0)
 	  && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) == 0);
 
 }
-- 
1.8.3.1


