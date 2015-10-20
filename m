From: Steffan Karger <steffan@...1856...>
Date: Wed, 21 Oct 2015 00:37:36 +0200
Message-Id: <1445380656-20654-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] hardening: add insurance to exit on a
	failed ASSERT()
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

The code behind our ASSERT() macro is pretty complex.  Although it seems
to be correct, make it trivially clear we will never return from a failed
assert by adding an _exit(1) call.  As was suggested by Sebastian Krahmer
of the SuSE security team.

A secondary benefit is that tools like clang static analyzer and coverity
can now understand our ASSERT() macros too.  To make sure they do, change
assert_failed() to a static inline function.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/error.c | 6 ------
 src/openvpn/error.h | 7 ++++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 77b6cec..3f6254d 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -393,12 +393,6 @@ dont_mute (unsigned int flags)
   return ret;
 }
 
-void
-assert_failed (const char *filename, int line)
-{
-  msg (M_FATAL, "Assertion failed at %s:%d", filename, line);
-}
-
 /*
  * Fail memory allocation.  Don't use msg() because it tries
  * to allocate memory as part of its operation.
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index d5204f3..6db7b59 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -210,7 +210,12 @@ FILE *msg_fp(const unsigned int flags);
 /* Fatal logic errors */
 #define ASSERT(x) do { if (!(x)) assert_failed(__FILE__, __LINE__); } while (false)
 
-void assert_failed (const char *filename, int line);
+static inline void
+assert_failed (const char *filename, int line)
+{
+  msg (M_FATAL, "Assertion failed at %s:%d", filename, line);
+  _exit(1); /* Just insurance; M_FATAL should trigger a clean exit. */
+}
 
 #ifdef ENABLE_DEBUG
 void crash (void); /* force a segfault (debugging only) */
-- 
2.1.4


