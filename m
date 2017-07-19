From: Steffan Karger <steffan@...1856...>
Date: Wed, 19 Jul 2017 23:39:23 +0200
Message-Id: <20170719213923.18843-1-steffan@...1856...>
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
random collection of unrelated stuff called misc.c.  While doing so,
simplify the implementation.

(I think we should find a better place for everything currently in misc.c,
and get rid of it all together.  This patch is part of that effort.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/error.c |  8 ++++++++
 src/openvpn/error.h |  5 +++++
 src/openvpn/misc.c  | 15 ---------------
 src/openvpn/misc.h  |  6 ------
 4 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ce50ff9e..a42e5149 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -815,6 +815,14 @@ msg_flags_string(const unsigned int flags, struct gc_arena *gc)
     return BSTR(&out);
 }
 
+#ifdef HAVE_STRERROR
+const char *
+strerror_ts(int errnum, struct gc_arena *gc)
+{
+    return string_alloc(openvpn_strerror(errnum, gc), gc);
+}
+#endif
+
 #ifdef ENABLE_DEBUG
 void
 crash(void)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 14ef7e65..8f6e8ca8 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -398,6 +398,11 @@ nonfatal(const unsigned int err)
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
 
+#ifdef HAVE_STRERROR
+/** A thread-safe version of strerror */
+const char *strerror_ts(int errnum, struct gc_arena *gc);
+#endif
+
 #include "errlevel.h"
 
 #endif /* ifndef ERROR_H */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index ef779ee3..f6d6c6ad 100644
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
index 3116ec42..bc267d73 100644
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
2.11.0


