From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 19 Jun 2017 13:47:33 +0200
Message-ID: <1497872853-1464-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Move adjust_power_of_2() to integer.h
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

misc.c it a mess of incoherent functions, and is therefore included by
virtually all our source files.  That makes testing harder than it should
be.  As a first step of cleaning up misc.c, move adjust_power_of_2() to
integer.h, which is a more suitable place for a function like this.

This allows us to remove the duplicate implementation from test_argv.c.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/integer.h                | 17 +++++++++++++++++
 src/openvpn/misc.c                   | 18 ------------------
 src/openvpn/misc.h                   |  2 --
 tests/unit_tests/openvpn/test_argv.c | 19 +------------------
 4 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 240781b..882322a 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -118,6 +118,23 @@ modulo_add(int x, int y, int mod)
     return sum;
 }
 
+/*
+ * Return the next largest power of 2
+ * or u if u is a power of 2.
+ */
+static inline size_t adjust_power_of_2(size_t u)
+{
+    size_t ret = 1;
+
+    while (ret < u)
+    {
+        ret <<= 1;
+        ASSERT(ret > 0);
+    }
+
+    return ret;
+}
+
 static inline int
 index_verify(int index, int size, const char *file, int line)
 {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index df108b0..561f80f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1641,24 +1641,6 @@ openvpn_sleep(const int n)
 }
 
 /*
- * Return the next largest power of 2
- * or u if u is a power of 2.
- */
-size_t
-adjust_power_of_2(size_t u)
-{
-    size_t ret = 1;
-
-    while (ret < u)
-    {
-        ret <<= 1;
-        ASSERT(ret > 0);
-    }
-
-    return ret;
-}
-
-/*
  * Remove security-sensitive strings from control message
  * so that they will not be output to log file.
  */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 94573b2..f55186f 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -325,8 +325,6 @@ extern const char *iproute_path;
 #define SSEC_PW_ENV    3 /* allow calling of built-in programs and user-defined scripts that may receive a password as an environmental variable */
 extern int script_security; /* GLOBAL */
 
-/* return the next largest power of 2 */
-size_t adjust_power_of_2(size_t u);
 
 #define COMPAT_FLAG_QUERY         0       /** compat_flags operator: Query for a flag */
 #define COMPAT_FLAG_SET           (1<<0)  /** compat_flags operator: Set a compat flag */
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 8c90eb9..c5ebc09 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -12,24 +12,7 @@
 
 #include "argv.h"
 #include "buffer.h"
-
-/*
- * This is defined here to prevent #include'ing misc.h
- * which makes things difficult beyond any recognition
- */
-size_t
-adjust_power_of_2(size_t u)
-{
-    size_t ret = 1;
-
-    while (ret < u)
-    {
-        ret <<= 1;
-        assert(ret > 0);
-    }
-
-    return ret;
-}
+#include "integer.h"
 
 /* Defines for use in the tests and the mock parse_line() */
 #define PATH1       "/s p a c e"
-- 
2.7.4


