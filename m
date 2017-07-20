From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 20 Jul 2017 09:56:43 +0200
Message-ID: <1500537403-15079-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <20170720061143.GI70062@...1296...>
References: <20170720061143.GI70062@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Move strerror_ts() to error.h/c
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

Move strerror_ts() to error.c, which is a more suitable location than the
random collection of unrelated stuff called misc.c.

While doing so, simplify the implementation and remove the defines.
strerror() is required by C89 and C99, and we require C99, so no need to
check.

We might want to switch to strerror_r() and get rid of this function all
together (it isn't as thread-safe as it claims), but while strerror() is
part of the C standard, strerror_r() is 'just' posix.  So I'd prefer not
to pull that into this patch.

(I think we should find a better place for everything currently in misc.c,
and get rid of it all together.  This patch is part of that effort.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2 - don't check for strerror presence, it's in C99.

 configure.ac        |  2 +-
 src/openvpn/error.c |  6 ++++++
 src/openvpn/error.h |  3 +++
 src/openvpn/misc.c  | 15 ---------------
 src/openvpn/misc.h  |  6 ------
 5 files changed, 10 insertions(+), 22 deletions(-)

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
index ce50ff9..66685cd 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -815,6 +815,12 @@ msg_flags_string(const unsigned int flags, struct gc_arena *gc)
     return BSTR(&out);
 }
 
+const char *
+strerror_ts(int errnum, struct gc_arena *gc)
+{
+    return string_alloc(openvpn_strerror(errnum, gc), gc);
+}
+
 #ifdef ENABLE_DEBUG
 void
 crash(void)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 14ef7e6..ff68d58 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -398,6 +398,9 @@ nonfatal(const unsigned int err)
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
 
+/** A thread-safe version of strerror */
+const char *strerror_ts(int errnum, struct gc_arena *gc);
+
 #include "errlevel.h"
 
 #endif /* ifndef ERROR_H */
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
 
-- 
2.7.4


