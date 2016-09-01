From: Steffan Karger <steffan@...1856...>
Date: Thu,  1 Sep 2016 21:13:27 +0200
Message-Id: <1472757207-17900-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] cleanup: remove code duplication in
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

Use check_debug_level() instead of writing out the exact same check in
msg_test().

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/error.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 76515d6..ced2fdf 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -138,12 +138,6 @@ extern int x_msg_line_num;
 /** Check muting filter */
 bool dont_mute (unsigned int flags);
 
-/** Return true if flags represent an enabled, not muted log level */
-static inline bool msg_test (unsigned int flags)
-{
-  return ((flags & M_DEBUG_LEVEL) <= x_debug_level) && dont_mute (flags);
-}
-
 /* Macro to ensure (and teach static analysis tools) we exit on fatal errors */
 #define EXIT_FATAL(flags) do { if ((flags) & M_FATAL) _exit(1); } while (false)
 
@@ -237,6 +231,12 @@ check_debug_level (unsigned int level)
   return (level & M_DEBUG_LEVEL) <= x_debug_level;
 }
 
+/** Return true if flags represent an enabled, not muted log level */
+static inline bool msg_test (unsigned int flags)
+{
+  return check_debug_level (flags) && dont_mute (flags);
+}
+
 /* Call if we forked */
 void msg_forked (void);
 
-- 
2.7.4


