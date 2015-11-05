From: Steffan Karger <steffan@...1856...>
Date: Thu,  5 Nov 2015 22:03:01 +0100
Message-Id: <1446757381-27863-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add macro to ensure we exit on fatal errors
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

Also prevents false positives in static analysis tools.

(Note that the current x_msg() code does properly exit, this is just a way
to make it trivial to see we will not return from msg() on fatal errors,
even for static analysis tools.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/error.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index e9564ac..d0d528a 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -144,19 +144,22 @@ bool dont_mute (unsigned int flags); /* check muting filter */
 
 #define MSG_TEST(flags) (unlikely((((unsigned int)flags) & M_DEBUG_LEVEL) <= x_debug_level) && dont_mute (flags))
 
+/* Macro to ensure (and teach static analysis tools) we exit on fatal errors */
+#define EXIT_FATAL(flags) do { if ((flags) & M_FATAL) _exit(1); } while (false)
+
 #if defined(HAVE_CPP_VARARG_MACRO_ISO) && !defined(__LCLINT__)
 # define HAVE_VARARG_MACROS
-# define msg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); } while (false)
+# define msg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); EXIT_FATAL(flags); } while (false)
 # ifdef ENABLE_DEBUG
-#  define dmsg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); } while (false)
+#  define dmsg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); EXIT_FATAL(flags); } while (false)
 # else
 #  define dmsg(flags, ...)
 # endif
 #elif defined(HAVE_CPP_VARARG_MACRO_GCC) && !defined(__LCLINT__)
 # define HAVE_VARARG_MACROS
-# define msg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); } while (false)
+# define msg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); EXIT_FATAL(flags); } while (false)
 # ifdef ENABLE_DEBUG
-#  define dmsg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); } while (false)
+#  define dmsg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); EXIT_FATAL(flags); } while (false)
 # else
 #  define dmsg(flags, args...)
 # endif
-- 
2.5.0


