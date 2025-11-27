From: Gert Doering <gert@...1296...>
Date: Thu, 27 Nov 2025 11:53:37 +0100
Message-ID: <20251127105343.30723-1-gert@...1296...>
In-Reply-To: <gerrit.1764176048000.I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20@...2715...>
References: <gerrit.1764176048000.I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] configure/CMake: Remove unused checks
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

Do not run configure checks that we do not
actually need.

But add one missing check in CMake for strsep!

Change-Id: I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1409
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1409
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c4d50e4..f101a1b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -240,6 +240,7 @@
 
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
+check_symbol_exists(strsep string.h HAVE_STRSEP)
 
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
diff --git a/config.h.cmake.in b/config.h.cmake.in
index bf1899c..f68ea27 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -281,9 +281,6 @@
 /* Define to 1 if you have the <syslog.h> header file. */
 #cmakedefine HAVE_SYSLOG_H
 
-/* Define to 1 if you have the `system' function. */
-#undef HAVE_SYSTEM
-
 /* Define to 1 if you have the <systemd/sd-daemon.h> header file. */
 #undef HAVE_SYSTEMD_SD_DAEMON_H
 
@@ -332,12 +329,6 @@
 /* Define to 1 if you have the <tap-windows.h> header file. */
 #undef HAVE_TAP_WINDOWS_H
 
-/* Define to 1 if you have the `time' function. */
-#define HAVE_TIME 1
-
-/* Define to 1 if you have the <time.h> header file. */
-#define HAVE_TIME_H 1
-
 /* Define to 1 if you have the <uapi.h> header file. */
 #undef HAVE_UAPI_H
 
@@ -347,12 +338,6 @@
 /* Define to 1 if you have the <valgrind/memcheck.h> header file. */
 #undef HAVE_VALGRIND_MEMCHECK_H
 
-/* Define to 1 if you have the `vfork' function. */
-#undef HAVE_VFORK
-
-/* Define to 1 if you have the <vfork.h> header file. */
-#undef HAVE_VFORK_H
-
 /* Availability of different mbed TLS features and APIs */
 #cmakedefine HAVE_PSA_CRYPTO_H
 #cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
diff --git a/configure.ac b/configure.ac
index 030f8de..60799e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -475,13 +475,7 @@
 )
 
 AC_C_INLINE
-AC_TYPE_OFF_T
-AC_TYPE_PID_T
-AC_TYPE_SIZE_T
-AC_TYPE_UID_T
 AX_TYPE_SOCKLEN_T
-AC_CHECK_SIZEOF([unsigned int])
-AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
 	fcntl.h io.h \
 	sys/types.h sys/socket.h \
@@ -492,7 +486,7 @@
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
 	sys/mman.h sys/file.h sys/wait.h \
-	unistd.h libgen.h stropts.h \
+	libgen.h stropts.h \
 	syslog.h pwd.h grp.h termios.h \
 	sys/sockio.h sys/uio.h \
 	poll.h sys/epoll.h err.h \
@@ -546,12 +540,6 @@
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
-	[struct iphdr],
-	[AC_DEFINE([HAVE_IPHDR], [1], [struct iphdr needed for IPv6 support])],
-	,
-	[[${SOCKET_INCLUDES}]]
-)
-AC_CHECK_TYPE(
 	[struct msghdr],
 	[AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed for extended socket error support])],
 	,
@@ -657,11 +645,11 @@
 AC_FUNC_FORK
 
 AC_CHECK_FUNCS([ \
-	daemon chroot getpwnam setuid nice system dup dup2 \
+	daemon chroot getpwnam setuid nice dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock time gettimeofday \
+	setgroups flock gettimeofday \
 	setsid chdir \
-	chsize ftruncate execve getpeereid basename dirname access \
+	chsize ftruncate execve getpeereid basename dirname \
 	epoll_create strsep \
 ])
 

