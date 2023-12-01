From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  1 Dec 2023 13:32:11 +0100
Message-Id: <20231201123211.17619-1-frank@...2641...>
In-Reply-To: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
References: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Remove unused/unneeded/add missing
 defines from configure/cmake
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

Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/443
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..4aa9793 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -167,6 +167,7 @@
 check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
 check_symbol_exists(getpwnam pwd.h HAVE_GETPWNAM)
 check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)
+check_symbol_exists(getrlimit "sys/time.h;sys/resource.h" HAVE_GETRLIMIT)
 
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..848c505 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -140,7 +140,7 @@
 #cmakedefine HAVE_GETPWNAM
 
 /* Define to 1 if you have the `getrlimit' function. */
-#undef HAVE_GETRLIMIT
+#cmakedefine HAVE_GETRLIMIT
 
 /* Define to 1 if you have the `getsockname' function. */
 #cmakedefine HAVE_GETSOCKNAME
@@ -235,8 +235,6 @@
 /* Define to 1 if you have the <pwd.h> header file. */
 #cmakedefine HAVE_PWD_H
 
-/* Define to 1 if you have the `readv' function. */
-#undef HAVE_READV
 
 /* Define to 1 if you have the `recvmsg' function. */
 #cmakedefine HAVE_RECVMSG
@@ -383,9 +381,6 @@
 /* Define to 1 if you have the <vfork.h> header file. */
 #undef HAVE_VFORK_H
 
-/* Define to 1 if you have the `vsnprintf' function. */
-#undef HAVE_VSNPRINTF
-
 /* we always assume a recent mbed TLS version */
 #define HAVE_MBEDTLS_PSA_CRYPTO_H 1
 #define HAVE_MBEDTLS_SSL_TLS_PRF 1
diff --git a/configure.ac b/configure.ac
index 84eaad6..141acc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -655,7 +655,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock readv writev time gettimeofday \
+	setgroups flock time gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeereid basename dirname access \
 	epoll_create strsep \

