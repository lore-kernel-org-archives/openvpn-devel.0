From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 20 Jul 2017 13:39:00 +0200
Message-ID: <1500550740-24773-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <20170720110005.GK70062@...1296...>
References: <20170720110005.GK70062@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Remove strerror_ts()
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

This function was only called in string format functions, which already
copy the contents, so all this ever did was adding redundant malloc() and
free() calls.

Also, this wasn't as thread-safe as it claims: another thread could still
change the string value between the strerror() and buf_printf() calls. So,
instead of a not needed false sense of thread-safeness, just be honest and
use strerror() directly.

(I think we should find a better place for everything currently in misc.c,
and get rid of it all together.  In this case, the better place is
/dev/null.  This patch is part of that effort.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2 - don't check for strerror presence, it's in C99.
v3 - just remove the function, it serves no real purpose.
v4 - strerror() does not want a gc...

configure.ac         |  2 +-
 src/openvpn/error.c  | 15 +++++----------
 src/openvpn/manage.c |  5 ++---
 src/openvpn/misc.c   | 15 ---------------
 src/openvpn/misc.h   |  6 ------
 src/openvpn/socket.c |  6 ++----
 6 files changed, 10 insertions(+), 39 deletions(-)

diff --git a/configure.ac b/configure.ac
index 60bb465..39d992c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -662,7 +662,7 @@ AC_FUNC_FORK
 
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system getpid dup dup2 \
-	getpass strerror syslog openlog mlockall getgrnam setgid \
+	getpass syslog openlog mlockall getgrnam setgid \
 	setgroups stat flock readv writev time gettimeofday \
 	ctime memset vsnprintf strdup \
 	setsid chdir putenv getpeername unlink \
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ce50ff9..3817666 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -267,7 +267,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
     if ((flags & M_ERRNO) && e)
     {
         openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
-                         m1, strerror_ts(e, &gc), e);
+                         m1, strerror(e), e);
         SWAP;
     }
 
@@ -693,20 +693,15 @@ x_check_status(int status,
         {
             if (extended_msg)
             {
-                msg(x_cs_info_level, "%s %s [%s]: %s (code=%d)",
-                    description,
+                msg(x_cs_info_level, "%s %s [%s]: %s (code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    extended_msg,
-                    strerror_ts(my_errno, &gc),
-                    my_errno);
+                    extended_msg, strerror(my_errno), my_errno);
             }
             else
             {
-                msg(x_cs_info_level, "%s %s: %s (code=%d)",
-                    description,
+                msg(x_cs_info_level, "%s %s: %s (code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    strerror_ts(my_errno, &gc),
-                    my_errno);
+                    strerror(my_errno), my_errno);
             }
 
             if (x_cs_err_delay_ms)
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 39ce8b3..2b85d25 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2006,9 +2006,8 @@ man_io_error(struct management *man, const char *prefix)
     if (!ignore_sys_error(err))
     {
         struct gc_arena gc = gc_new();
-        msg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s",
-            prefix,
-            strerror_ts(err, &gc));
+        msg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s", prefix,
+            strerror(err));
         gc_free(&gc);
         return true;
     }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index ef779ee..f6d6c6a 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -444,21 +444,6 @@ init_random_seed(void)
     }
 }
 
-/* thread-safe strerror */
-
-const char *
-strerror_ts(int errnum, struct gc_arena *gc)
-{
-#ifdef HAVE_STRERROR
-    struct buffer out = alloc_buf_gc(256, gc);
-
-    buf_printf(&out, "%s", openvpn_strerror(errnum, gc));
-    return BSTR(&out);
-#else
-    return "[error string unavailable]";
-#endif
-}
-
 /*
  * Set environmental variable (int or string).
  *
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 3116ec4..bc267d7 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -95,12 +95,6 @@ openvpn_run_script(const struct argv *a, const struct env_set *es, const unsigne
 }
 
 
-#ifdef HAVE_STRERROR
-/* a thread-safe version of strerror */
-const char *strerror_ts(int errnum, struct gc_arena *gc);
-
-#endif
-
 /* Set standard file descriptors to /dev/null */
 void set_std_files_to_null(bool stdin_only);
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a814b95..846df04 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1473,10 +1473,8 @@ socket_connect(socket_descriptor_t *sd,
     if (status)
     {
 
-        msg(D_LINK_ERRORS,
-            "TCP: connect to %s failed: %s",
-            print_sockaddr(dest, &gc),
-            strerror_ts(status, &gc));
+        msg(D_LINK_ERRORS, "TCP: connect to %s failed: %s",
+            print_sockaddr(dest, &gc), strerror(status));
 
         openvpn_close_socket(*sd);
         *sd = SOCKET_UNDEFINED;
-- 
2.7.4


