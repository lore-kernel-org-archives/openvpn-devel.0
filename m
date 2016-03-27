From: Steffan Karger <steffan@...1856...>
Date: Sun, 27 Mar 2016 16:18:16 +0200
Message-Id: <1459088296-5046-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Replace MSG_TEST() macro for static inline
	msg_test()
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

Using a static inline function instead of a macro has the advantages that
(1) 'flags' is not evaluated twice and (2) coverity will stop complaining
that 'Macro compares unsigned to 0 (NO_EFFECT)' each time we use flags
with loglevel 0 (e.g. M_FATAL or M_WARN).

This has a performance impact when compiler optimizations are fully
disabled ('-O0'), but should otherwise be as fast as using a macro.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/error.c  |  2 +-
 src/openvpn/error.h  | 17 +++++++++++------
 src/openvpn/plugin.c |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index cfd5a41..bb0ab5b 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -228,7 +228,7 @@ void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
 
 #ifndef HAVE_VARARG_MACROS
   /* the macro has checked this otherwise */
-  if (!MSG_TEST (flags))
+  if (!msg_test (flags))
     return;
 #endif
 
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index dd5ccf7..76515d6 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -135,26 +135,31 @@ extern int x_msg_line_num;
  * msg() as a macro for optimization win.
  */
 
-bool dont_mute (unsigned int flags); /* check muting filter */
+/** Check muting filter */
+bool dont_mute (unsigned int flags);
 
-#define MSG_TEST(flags) (unlikely((((unsigned int)flags) & M_DEBUG_LEVEL) <= x_debug_level) && dont_mute (flags))
+/** Return true if flags represent an enabled, not muted log level */
+static inline bool msg_test (unsigned int flags)
+{
+  return ((flags & M_DEBUG_LEVEL) <= x_debug_level) && dont_mute (flags);
+}
 
 /* Macro to ensure (and teach static analysis tools) we exit on fatal errors */
 #define EXIT_FATAL(flags) do { if ((flags) & M_FATAL) _exit(1); } while (false)
 
 #if defined(HAVE_CPP_VARARG_MACRO_ISO) && !defined(__LCLINT__)
 # define HAVE_VARARG_MACROS
-# define msg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); EXIT_FATAL(flags); } while (false)
+# define msg(flags, ...) do { if (msg_test(flags)) x_msg((flags), __VA_ARGS__); EXIT_FATAL(flags); } while (false)
 # ifdef ENABLE_DEBUG
-#  define dmsg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); EXIT_FATAL(flags); } while (false)
+#  define dmsg(flags, ...) do { if (msg_test(flags)) x_msg((flags), __VA_ARGS__); EXIT_FATAL(flags); } while (false)
 # else
 #  define dmsg(flags, ...)
 # endif
 #elif defined(HAVE_CPP_VARARG_MACRO_GCC) && !defined(__LCLINT__)
 # define HAVE_VARARG_MACROS
-# define msg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); EXIT_FATAL(flags); } while (false)
+# define msg(flags, args...) do { if (msg_test(flags)) x_msg((flags), args); EXIT_FATAL(flags); } while (false)
 # ifdef ENABLE_DEBUG
-#  define dmsg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); EXIT_FATAL(flags); } while (false)
+#  define dmsg(flags, args...) do { if (msg_test(flags)) x_msg((flags), args); EXIT_FATAL(flags); } while (false)
 # else
 #  define dmsg(flags, args...)
 # endif
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 9be0b0c..542e5b1 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -319,7 +319,7 @@ plugin_vlog (openvpn_plugin_log_flags_t flags, const char *name, const char *for
   if (flags & PLOG_NOMUTE)
     msg_flags |= M_NOMUTE;
 
-  if (MSG_TEST (msg_flags))
+  if (msg_test (msg_flags))
     {
       struct gc_arena gc;
       char* msg_fmt;
-- 
2.5.0


