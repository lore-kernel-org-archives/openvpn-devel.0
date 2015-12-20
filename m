From: Steffan Karger <steffan@...1856...>
Date: Sun, 20 Dec 2015 10:10:41 +0100
Message-Id: <1450602641-26831-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Make assert_failed() print the failed
	condition
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

Easy change to make logging output more useful.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/error.c | 4 ++--
 src/openvpn/error.h | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 66f37f3..6daf465 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -394,9 +394,9 @@ dont_mute (unsigned int flags)
 }
 
 void
-assert_failed (const char *filename, int line)
+assert_failed (const char *filename, int line, const char *condition)
 {
-  msg (M_FATAL, "Assertion failed at %s:%d", filename, line);
+  msg (M_FATAL, "Assertion failed at %s:%d (%s)", filename, line, condition);
   _exit(1);
 }
 
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1dc0864..5ad75e2 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -211,9 +211,10 @@ const char *msg_flags_string (const unsigned int flags, struct gc_arena *gc);
 FILE *msg_fp(const unsigned int flags);
 
 /* Fatal logic errors */
-#define ASSERT(x) do { if (!(x)) assert_failed(__FILE__, __LINE__); } while (false)
+#define ASSERT(x) do { if (!(x)) assert_failed(__FILE__, __LINE__, #x); } while (false)
 
-void assert_failed (const char *filename, int line) __attribute__((__noreturn__));
+void assert_failed (const char *filename, int line, const char *condition)
+  __attribute__((__noreturn__));
 
 #ifdef ENABLE_DEBUG
 void crash (void); /* force a segfault (debugging only) */
-- 
2.5.0


